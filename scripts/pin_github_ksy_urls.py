#!/usr/bin/env python3
r"""Pin ``https://github.com/<owner>/<repo>/(blob|tree)/(master|main)/...`` in ``\*.ksy`` files
to a single 40-char commit SHA per ``(owner, repo)`` (keyed case-insensitively).

**Branch selection (per \`\`owner/repo\`\` resolved via GitHub API):** If both ``master`` and ``main``
branch tips exist, the SHA used for **all** URLs to that repository is the tip of whichever branch
has the **newer** commit (by ``committer`` / ``author`` date). If only one branch exists, that
branch's tip is used. This can desynchronize line anchors if ``master`` and ``main`` have
diverged.

**Branch strategy (``--branch-strategy``):** **``master``** (default) — if both ``master`` and ``main``
exist, use **``master``**'s tip so historic ``#L`` ranges stay closer to the old ``/blob/master/`` tree.
**``newer``** — use the **newer** of the two tips by commit date (as in the original plan; may require
fixing ``#L`` in ``.ksy`` afterward).

**Failure handling:** If resolution fails for ``owner/repo``, retry with ``th3w1zard1/<repo>`` (same
``repo`` spelling as the first in-file URL, except owner becomes ``th3w1zard1``). If that still
fails, the default is to **leave the original URL** and exit **non-zero**; use ``--soft-fail`` to
warn only and continue.

**Auth (recommended):** Set ``GITHUB_TOKEN`` or ``GH_TOKEN`` for 5000 API requests/hour (vs ~60
unauthenticated).

Run from the repository root::

  export GITHUB_TOKEN=…
  python scripts/pin_github_ksy_urls.py
  python scripts/pin_github_ksy_urls.py --dry-run
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.error
import urllib.request
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterator

# ``blob|tree`` + ``master|main`` + path (optional) + ``#L`` line fragment (optional, GitHub form).
_GH_FLOATING_REF = re.compile(
    r"https://github\.com/([^/\s#\"'<>()]+)/([^/\s#\"'<>()]+)"
    r"/(blob|tree)/(master|main)(/[^\s#\"'<>()]*)?((?:#L\d+(?:-L?\d+)?)?)",
    flags=re.IGNORECASE,
)


@dataclass(frozen=True)
class PinResult:
    out_owner: str
    out_repo: str
    sha: str
    source: str
    error: str | None = None


def repo_key(owner: str, repo: str) -> tuple[str, str]:
    r = re.sub(r"\.git$", "", repo, flags=re.IGNORECASE)
    return (owner.lower(), r.lower())


def _parse_iso_date(s: str | None) -> datetime | None:
    if not s:
        return None
    s = s.replace("Z", "+00:00")
    try:
        d = datetime.fromisoformat(s)
    except ValueError:
        return None
    if d.tzinfo is None:
        d = d.replace(tzinfo=timezone.utc)
    return d


def _commit_date_from_branch(obj: dict[str, Any] | None) -> tuple[datetime | None, str | None]:
    if not obj:
        return None, None
    c = obj.get("commit")
    if not isinstance(c, dict):
        return None, None
    sha = c.get("sha")
    if isinstance(sha, str) and len(sha) > 40:
        sha = sha[:40]
    inner = c.get("commit")
    if not isinstance(inner, dict):
        return None, sha if isinstance(sha, str) else None
    cmt = inner.get("committer") or {}
    aut = inner.get("author") or {}
    d1 = _parse_iso_date(cmt.get("date") if isinstance(cmt, dict) else None)
    d2 = _parse_iso_date(aut.get("date") if isinstance(aut, dict) else None)
    if d1 and d2:
        return (max(d1, d2), sha if isinstance(sha, str) else None)
    if d1:
        return (d1, sha if isinstance(sha, str) else None)
    if d2:
        return (d2, sha if isinstance(sha, str) else None)
    return (None, sha if isinstance(sha, str) else None)


def pick_branch_tips(
    master_json: dict[str, Any] | None,
    main_json: dict[str, Any] | None,
    strategy: str,
) -> tuple[str, str, str] | None:
    """``strategy`` is ``master`` (default: if both exist, use ``master`` tip) or ``newer`` (commit-date)."""
    m_date, m_sha = _commit_date_from_branch(master_json)
    n_date, n_sha = _commit_date_from_branch(main_json)
    if m_sha and n_sha and strategy == "master":
        return "master", m_sha, "master (prefer over main)"
    if m_sha and n_sha and strategy == "newer":
        if m_date and n_date:
            if m_date >= n_date:
                return "master", m_sha, "master (newer tip)"
            return "main", n_sha, "main (newer tip)"
        return "master", m_sha, "master (tie, dates partial)"
    if m_sha:
        return "master", m_sha, "master"
    if n_sha:
        return "main", n_sha, "main"
    return None


class GitHubApi:
    def __init__(self, token: str | None) -> None:
        self._token = token
        self._min_interval = 0.0
        self._last_call = 0.0

    def _req(
        self, path: str, max_retries: int = 5
    ) -> tuple[int, dict[str, Any] | list[Any] | None, str | None]:
        if not path.startswith("/"):
            path = "/" + path
        url = f"https://api.github.com{path}"
        headers: dict[str, str] = {
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
        }
        if self._token:
            headers["Authorization"] = f"Bearer {self._token}"
        for attempt in range(max_retries + 1):
            now = time.monotonic()
            wait = self._last_call + self._min_interval - now
            if wait > 0:
                time.sleep(wait)
            req = urllib.request.Request(url, headers=headers, method="GET")
            try:
                with urllib.request.urlopen(req, timeout=60) as resp:  # noqa: S310
                    self._last_call = time.monotonic()
                    self._min_interval = 0.0
                    body = resp.read().decode("utf-8")
                    remaining = resp.headers.get("X-RateLimit-Remaining", "")
                    if remaining.isdigit() and int(remaining) < 5:
                        self._min_interval = 2.0
                    if body:
                        return resp.status, json.loads(body), None
                    return resp.status, None, None
            except urllib.error.HTTPError as e:
                self._last_call = time.monotonic()
                err_bytes = e.read() if e.fp is not None else b""
                err_text = err_bytes.decode("utf-8", "replace")
                if e.code == 403 and "rate limit" in err_text.lower():
                    time.sleep(60)
                    continue
                if e.code in (403, 429):
                    ra = e.headers.get("Retry-After") if e.headers else None
                    if ra and ra.isdigit():
                        time.sleep(int(ra) + 1)
                        continue
                if e.code == 404:
                    return 404, None, "not found"
                if attempt < max_retries and e.code >= 500:
                    time.sleep(1.0 * (2**attempt))
                    continue
                return e.code, None, str(e) or err_text
            except OSError as e:
                if attempt < max_retries:
                    time.sleep(0.5 * (2**attempt))
                    continue
                return 0, None, str(e)
        return 0, None, "exhausted retries"

    def branch(self, owner: str, repo: str, name: str) -> dict[str, Any] | None:
        # GitHub is case-insensitive; urllib quote path segments for special chars? Rare in our owners.
        code, j, _ = self._req(f"/repos/{owner}/{repo}/branches/{name}")
        if code == 200 and isinstance(j, dict):
            return j
        return None


def resolve_one_repo(
    api: GitHubApi,
    key: tuple[str, str],
    first_display: dict[tuple[str, str], tuple[str, str]],
    branch_strategy: str = "master",
    fork_user: str = "th3w1zard1",
) -> PinResult:
    o_low, r_low = key
    d_o, d_r = first_display.get(key, (o_low, r_low))
    m_api = api.branch(d_o, d_r, "master")
    n_api = api.branch(d_o, d_r, "main")
    picked = pick_branch_tips(m_api, n_api, branch_strategy)
    if picked:
        _ref, sha, label = picked
        return PinResult(
            d_o,
            d_r,
            (sha or "").lower(),
            f"api:{d_o}/{d_r}:{label}",
            None,
        )
    m_fork = api.branch(fork_user, d_r, "master")
    n_fork = api.branch(fork_user, d_r, "main")
    picked2 = pick_branch_tips(m_fork, n_fork, branch_strategy)
    if picked2:
        _ref, sha, label = picked2
        return PinResult(
            fork_user,
            d_r,
            (sha or "").lower(),
            f"fork:{fork_user}/{d_r}:{label}",
            None,
        )
    return PinResult(
        d_o,
        d_r,
        "",
        f"unresolved:{d_o}/{d_r}",
        f"API: no master/main for {d_o}/{d_r} or {fork_user}/{d_r}",
    )


def build_pin_map(
    keys: set[tuple[str, str]],
    first_display: dict[tuple[str, str], tuple[str, str]],
    api: GitHubApi,
    branch_strategy: str = "master",
    fork_user: str = "th3w1zard1",
) -> dict[tuple[str, str], PinResult]:
    out: dict[tuple[str, str], PinResult] = {}
    for k in sorted(keys, key=lambda t: (t[0], t[1])):
        out[k] = resolve_one_repo(
            api, k, first_display, branch_strategy=branch_strategy, fork_user=fork_user
        )
    return out


def apply_pin_map_to_text(
    text: str,
    pin_by_key: dict[tuple[str, str], PinResult],
) -> tuple[str, list[str]]:
    warnings: list[str] = []

    def sub(m: re.Match[str]) -> str:
        knd = m.group(3)
        path = m.group(5) or ""
        frag = m.group(6) or ""
        key = repo_key(m.group(1), m.group(2))
        if key not in pin_by_key:
            warnings.append(f"internal: missing key {key!r} for {m.group(0)[:100]}")
            return m.group(0)
        pr = pin_by_key[key]
        if not pr.sha or pr.error:
            return m.group(0)
        return f"https://github.com/{pr.out_owner}/{pr.out_repo}/{knd}/{pr.sha}{path}{frag}"

    return _GH_FLOATING_REF.sub(sub, text), warnings


def collect_keys_and_displays(
    text: str,
) -> tuple[set[tuple[str, str]], dict[tuple[str, str], tuple[str, str]]]:
    keys: set[tuple[str, str]] = set()
    first: dict[tuple[str, str], tuple[str, str]] = {}
    for m in _GH_FLOATING_REF.finditer(text):
        key = repo_key(m.group(1), m.group(2))
        keys.add(key)
        if key not in first:
            first[key] = (m.group(1), m.group(2))
    return keys, first


def verify_raw_blobs(
    text: str,
    timeout: float = 45.0,
) -> list[str]:
    issues: list[str] = []
    pat = re.compile(
        r"https://github\.com/([^/]+)/([^/]+)/blob/([0-9a-f]{40})/([^#]+)#L(\d+)(?:-L(\d+))?",
        re.I,
    )
    for m in pat.finditer(text):
        o, r, sha, fpath, a, b = m.group(1), m.group(2), m.group(3), m.group(4), m.group(5), m.group(6)
        u = f"https://raw.githubusercontent.com/{o}/{r}/{sha}/{fpath}"
        try:
            ur = urllib.request.Request(  # noqa: S310
                u, method="HEAD", headers={"User-Agent": "bioware-kaitai-pin/1.0"}
            )
            with urllib.request.urlopen(ur, timeout=timeout) as resp:  # noqa: S310
                if b and int(b) < int(a):
                    continue
                if resp.status not in (200, 404):
                    issues.append(f"raw HEAD {resp.status}: {u}")
        except OSError as e:
            issues.append(f"raw HEAD {u!r} … {e!r}")
    return issues


def iter_ksy_files(root: Path) -> Iterator[Path]:
    for p in sorted(root.rglob("*.ksy")):
        if p.is_file():
            yield p


def _token_from_env() -> str | None:
    import os

    return os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("Run from the repository", 1)[0].strip())
    ap.add_argument(
        "--root",
        type=Path,
        default=Path("formats"),
        help="Root directory to scan (default: formats/ under --repo-root)",
    )
    ap.add_argument(
        "--repo-root",
        type=Path,
        default=Path("."),
        help="Path to repository root (default: .)",
    )
    ap.add_argument("--dry-run", action="store_true", help="Do not write files; list files that would change")
    ap.add_argument(
        "--github-token",
        default="",
        help="GitHub API token (default: GITHUB_TOKEN or GH_TOKEN from environment)",
    )
    ap.add_argument(
        "--soft-fail",
        action="store_true",
        help="On unresolved owner/repo, leave URL unchanged; exit 0 (still print FAILED lines)",
    )
    ap.add_argument(
        "--json-report",
        type=Path,
        default=None,
        help="Write JSON report of per-(lowercase)key resolution",
    )
    ap.add_argument(
        "--verify-raw",
        action="store_true",
        help="After write, HEAD raw.githubusercontent.com for each pinned blob #L link (slow)",
    )
    ap.add_argument(
        "--fork-user",
        default="th3w1zard1",
        help="User/org to try if upstream has no resolvable master/main (default: th3w1zard1)",
    )
    ap.add_argument(
        "--branch-strategy",
        choices=("master", "newer"),
        default="master",
        help="When both master and main exist: ``master`` = always pin master (stable with historic "
        "``blob/master`` #L links); ``newer`` = tip of whichever branch is newer (plan mode; can break #L).",
    )
    args = ap.parse_args()
    repo_root: Path = args.repo_root.resolve()
    if args.root.is_absolute():
        scan_root = args.root.resolve()
    else:
        scan_root = (repo_root / args.root).resolve()
    if not scan_root.is_dir():
        print(f"error: not a directory: {scan_root}", file=sys.stderr)
        return 2

    files = list(iter_ksy_files(scan_root))
    all_keys: set[tuple[str, str]] = set()
    merged_display: dict[tuple[str, str], tuple[str, str]] = {}
    file_texts: dict[Path, str] = {}
    for p in files:
        t = p.read_text(encoding="utf-8", errors="replace")
        kset, fdis = collect_keys_and_displays(t)
        all_keys |= kset
        for k, disp in fdis.items():
            if k not in merged_display:
                merged_display[k] = disp
        file_texts[p] = t

    token = args.github_token or _token_from_env()
    api = GitHubApi(token)
    pin_by_key = build_pin_map(
        all_keys,
        merged_display,
        api,
        branch_strategy=args.branch_strategy,
        fork_user=args.fork_user,
    )
    failed = [k for k, v in pin_by_key.items() if not v.sha]
    for k in failed:
        v = pin_by_key[k]
        print(f"FAILED {k[0]}/{k[1]}: {v.error or 'no sha'}", file=sys.stderr)

    if failed and not args.soft_fail:
        print(
            "error: unresolved repository pins (set GITHUB_TOKEN, use --soft-fail, or fix network)",
            file=sys.stderr,
        )
        if args.json_report is not None:
            _write_json_report(args.json_report, pin_by_key)
        return 1

    changed = 0
    for p, t in file_texts.items():
        new_t, _ = apply_pin_map_to_text(t, pin_by_key)
        if new_t != t:
            changed += 1
            if not args.dry_run:
                p.write_text(new_t, encoding="utf-8", newline="\n")
            else:
                try:
                    rel = p.relative_to(repo_root)
                except ValueError:
                    rel = p
                print(f"would change: {rel}")

    if args.verify_raw and not args.dry_run:
        for p in file_texts:
            to_check = p.read_text(encoding="utf-8", errors="replace")
            for issue in verify_raw_blobs(to_check):
                print(issue, file=sys.stderr)
    elif args.verify_raw and args.dry_run:
        print("note: --verify-raw skipped in --dry-run (nothing written to disk)", file=sys.stderr)

    print(
        f"{'Would change' if args.dry_run else 'Changed'} {changed} of {len(files)} file(s); "
        f"{len(all_keys)} unique owner/repo key(s)"
    )

    if args.json_report is not None:
        _write_json_report(args.json_report, pin_by_key)
    return 0


def _write_json_report(
    path: Path, pin_by_key: dict[tuple[str, str], PinResult]
) -> None:
    report: dict[str, Any] = {}
    for (a, b), v in sorted(pin_by_key.items(), key=lambda i: (i[0][0], i[0][1])):
        report[f"{a}/{b}"] = {**asdict(v), "key": [a, b]}
    path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")


# --- Tests import these: ---
__all__ = [
    "PinResult",
    "repo_key",
    "pick_branch_tips",
    "apply_pin_map_to_text",
    "collect_keys_and_displays",
    "_commit_date_from_branch",
]


if __name__ == "__main__":
    raise SystemExit(main())

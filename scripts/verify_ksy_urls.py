#!/usr/bin/env python3
"""Extract https:// URLs from text sources under path(s) and optionally verify via HTTP HEAD.

Default: all ``*.ksy`` under ``--root`` (default: ``formats``).

Optional: ``--include-markdown`` adds ``**/*.md`` under the same roots; use ``--also`` to add
``docs``, ``README.md``, etc.

Optional: ``--check-github-blob-line-ranges`` fetches ``raw.githubusercontent.com`` at the
pinned commit for every ``https://github.com/<org>/<repo>/blob/<40-hex-sha>/…#L…`` anchor and
checks that each ``#L`` / ``#Lx-Ly`` band lies within the file's line count.

Optional: ``--check-xoreos-github-line-ranges`` fetches ``raw.githubusercontent.com`` for
``https://github.com/xoreos/(xoreos|xoreos-tools)/blob/master/…#L…`` anchors only (upstream
``master`` drift guard for engine/tooling sources).

Optional: ``--fail-on-master-blob`` fails if any ``https://github.com/…/blob/master/`` or
``/tree/master/`` URL appears under the scanned roots (floating branch pins).

GitHub wiki caveat: HEAD/GET may return 200 for a missing wiki page (UI falls back to Home
or an empty editor). Do not treat HTTP status alone as proof that a /wiki/... slug exists;
compare the rendered page title/anchors to the intended article (see OpenKotOR PyKotor wiki
hub pages such as Container-Formats, Audio-and-Localization-Formats, Texture-Formats).
"""
from __future__ import annotations

import argparse
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path


# Require a hostname (avoids matching bare `` `https://` `` in prose).
URL_RE = re.compile(r"https://[^\s/\)>\]'\"]+(?:/[^\s\)>\]'\"]*)?")

# GitHub web UI uses `#L10-L20`, not `:10-20` in the path segment (the latter returns 404 on /blob/).
_GITHUB_BLOB_LINE = re.compile(
    r"(https://github\.com/[^/]+/[^/]+/blob/[^/]+/.+):(\d+)-(\d+)(?=[^0-9#]|$)"
)
_GITHUB_BLOB_LINE_SINGLE = re.compile(
    r"(https://github\.com/[^/]+/[^/]+/blob/[^/]+/.+):(\d+)(?=[^0-9#-]|$)"
)

_FLOATING_XOREOS_MASTER = re.compile(
    r"https://github\.com/xoreos/(?:xoreos|xoreos-tools|xoreos-docs)/blob/master/",
)

# Pinned commit on ``/blob/<sha>/…`` — only full 40-char lowercase hex SHAs (avoid matching branch names).
_GITHUB_PINNED_BLOB_LINE_ANCHOR = re.compile(
    r"https://github\.com/([^/]+)/([^/]+)/blob/([0-9a-f]{40})/([^#\s\)\"]+)#L(\d+)(?:-L(\d+))?"
)

# Upstream xoreos ``master`` line anchors (``blob/master/…#L…``).
_XOREOS_MASTER_LINE_ANCHOR = re.compile(
    r"https://github\.com/(xoreos/(?:xoreos|xoreos-tools))/blob/master/([^#\s\)\"]+)#L(\d+)(?:-L(\d+))?"
)

_FLOATING_GITHUB_MASTER_BLOB = re.compile(
    r"https://github\.com/[^/\s]+/[^/\s]+/blob/master/",
)
_FLOATING_GITHUB_MASTER_TREE = re.compile(
    r"https://github\.com/[^/\s]+/[^/\s]+/tree/master/",
)


def normalize_url(url: str) -> str:
    u = url.rstrip(".,;")
    u = u.removesuffix("`")
    m = _GITHUB_BLOB_LINE.match(u)
    if m:
        u = f"{m.group(1)}#L{m.group(2)}-L{m.group(3)}"
    else:
        m2 = _GITHUB_BLOB_LINE_SINGLE.match(u)
        if m2:
            n = m2.group(2)
            u = f"{m2.group(1)}#L{n}"
    return u


def _suffixes(include_markdown: bool) -> tuple[str, ...]:
    exts: list[str] = [".ksy"]
    if include_markdown:
        exts.append(".md")
    return tuple(exts)


def iter_source_files(roots: list[Path], include_markdown: bool) -> list[Path]:
    allowed = _suffixes(include_markdown)
    out: list[Path] = []
    for base in roots:
        if not base.exists():
            continue
        if base.is_file():
            if base.suffix.lower() in allowed:
                out.append(base)
            continue
        for ext in allowed:
            out.extend(sorted(base.rglob(f"*{ext}")))
    return out


def collect_urls(roots: list[Path], include_markdown: bool) -> list[str]:
    urls: set[str] = set()
    for path in iter_source_files(roots, include_markdown):
        text = path.read_text(encoding="utf-8", errors="replace")
        for m in URL_RE.finditer(text):
            urls.add(normalize_url(m.group(0)))
    return sorted(urls)


def check_github_blob_line_ranges(
    roots: list[Path],
    include_markdown: bool,
    timeout: float,
) -> int:
    """Return 0 if all pinned ``#L`` ranges are in-bounds for raw.githubusercontent.com at <sha>."""
    cache: dict[tuple[str, str, str, str], list[str]] = {}

    def fetch_lines(org: str, repo: str, sha: str, file_path: str) -> list[str]:
        key = (org, repo, sha, file_path)
        if key not in cache:
            url = f"https://raw.githubusercontent.com/{org}/{repo}/{sha}/{file_path}"
            with urllib.request.urlopen(url, timeout=timeout) as resp:  # noqa: S310
                cache[key] = resp.read().decode("utf-8", errors="replace").splitlines()
        return cache[key]

    issues: list[str] = []
    checked = 0
    for path in iter_source_files(roots, include_markdown):
        text = path.read_text(encoding="utf-8", errors="replace")
        for m in _GITHUB_PINNED_BLOB_LINE_ANCHOR.finditer(text):
            org, repo, sha, file_path, a, b = (
                m.group(1),
                m.group(2),
                m.group(3),
                m.group(4),
                m.group(5),
                m.group(6),
            )
            start = int(a)
            end = int(b) if b else start
            try:
                lines = fetch_lines(org, repo, sha, file_path)
            except OSError as e:
                issues.append(f"{path}: {m.group(0)[:120]!r} … fetch failed: {e!r}")
                continue
            n = len(lines)
            checked += 1
            if start < 1 or end > n or start > end:
                issues.append(
                    f"{path}: {m.group(0)[:120]!r} … range {start}-{end} vs nlines={n}"
                )
    print(
        f"GitHub pinned ``#L`` range check: {checked} URL(s), {len(issues)} issue(s) "
        f"under [{', '.join(str(r.resolve()) for r in roots)}]"
    )
    for msg in issues[:200]:
        print(msg)
    if len(issues) > 200:
        print(f"… {len(issues) - 200} more")
    return 1 if issues else 0


def check_xoreos_master_blob_line_ranges(
    roots: list[Path],
    include_markdown: bool,
    timeout: float,
) -> int:
    """Return 0 if all ``#L`` ranges are in-bounds for ``xoreos/xoreos`` and ``xoreos-tools`` on ``master``."""
    cache: dict[tuple[str, str], list[str]] = {}

    def fetch_lines(org_repo: str, file_path: str) -> list[str]:
        key = (org_repo, file_path)
        if key not in cache:
            url = f"https://raw.githubusercontent.com/{org_repo}/master/{file_path}"
            with urllib.request.urlopen(url, timeout=timeout) as resp:  # noqa: S310
                cache[key] = resp.read().decode("utf-8", errors="replace").splitlines()
        return cache[key]

    issues: list[str] = []
    checked = 0
    for path in iter_source_files(roots, include_markdown):
        text = path.read_text(encoding="utf-8", errors="replace")
        for m in _XOREOS_MASTER_LINE_ANCHOR.finditer(text):
            org_repo, file_path, a, b = m.group(1), m.group(2), m.group(3), m.group(4)
            start = int(a)
            end = int(b) if b else start
            try:
                lines = fetch_lines(org_repo, file_path)
            except OSError as e:
                issues.append(f"{path}: {m.group(0)[:120]!r} … fetch failed: {e!r}")
                continue
            n = len(lines)
            checked += 1
            if start < 1 or end > n or start > end:
                issues.append(
                    f"{path}: {m.group(0)[:120]!r} … range {start}-{end} vs nlines={n}"
                )
    print(
        f"xoreos GitHub ``master`` ``#L`` range check: {checked} URL(s), {len(issues)} issue(s) "
        f"under [{', '.join(str(r.resolve()) for r in roots)}]"
    )
    for msg in issues[:200]:
        print(msg)
    if len(issues) > 200:
        print(f"… {len(issues) - 200} more")
    return 1 if issues else 0


def check_fail_on_master_blob(roots: list[Path], include_markdown: bool) -> int:
    issues: list[str] = []
    for path in iter_source_files(roots, include_markdown):
        text = path.read_text(encoding="utf-8", errors="replace")
        for rx, label in (
            (_FLOATING_GITHUB_MASTER_BLOB, "blob/master"),
            (_FLOATING_GITHUB_MASTER_TREE, "tree/master"),
        ):
            for m in rx.finditer(text):
                issues.append(f"{path}: floating {label} URL: {m.group(0)[:120]!r}")
    print(
        f"Floating GitHub master URL check: {len(issues)} issue(s) under "
        f"[{', '.join(str(r.resolve()) for r in roots)}]"
    )
    for msg in issues[:200]:
        print(msg)
    if len(issues) > 200:
        print(f"… {len(issues) - 200} more")
    return 1 if issues else 0


def head_ok(url: str, timeout: float, user_agent: str) -> tuple[bool, str]:
    req = urllib.request.Request(
        url,
        method="HEAD",
        headers={"User-Agent": user_agent},
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:  # noqa: S310
            code = resp.getcode()
            if 200 <= code < 400:
                return True, str(code)
            return False, f"HTTP {code}"
    except urllib.error.HTTPError as e:
        if e.code in (405, 501):  # Method Not Allowed — try GET (small)
            try:
                greq = urllib.request.Request(
                    url,
                    method="GET",
                    headers={"User-Agent": user_agent, "Range": "bytes=0-0"},
                )
                with urllib.request.urlopen(greq, timeout=timeout) as resp:  # noqa: S310
                    return True, f"GET fallback {resp.getcode()}"
            except OSError as e2:
                return False, repr(e2)
        return False, repr(e)
    except OSError as e:
        return False, repr(e)


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--root",
        type=Path,
        default=Path("formats"),
        help="Primary directory to scan (default: formats)",
    )
    p.add_argument(
        "--also",
        type=Path,
        action="append",
        default=[],
        metavar="PATH",
        help="Additional file or directory to scan (repeatable). Example: --also docs --also README.md",
    )
    p.add_argument(
        "--include-markdown",
        action="store_true",
        help="Also scan **/*.md under each scanned directory (and .md files passed via --also)",
    )
    p.add_argument(
        "--verify",
        action="store_true",
        help="Perform HTTP HEAD checks (slow; some hosts block HEAD)",
    )
    p.add_argument("--timeout", type=float, default=12.0, help="Per-URL timeout seconds")
    p.add_argument(
        "--user-agent",
        default="bioware-kaitai-formats-url-check/1.4 (+https://github.com/)",
    )
    p.add_argument(
        "--allow-fail-host",
        action="append",
        default=[],
        metavar="HOST",
        help="Hostname substring to treat as non-fatal on HEAD failure (e.g. deadlystream.com). Repeatable.",
    )
    p.add_argument(
        "--warn-floating-xoreos-master",
        action="store_true",
        help=(
            "Print warnings for `https://github.com/xoreos/*/blob/master/` URLs inside scanned "
            "sources when env var `XOREOS_PIN_SHA` is set (reminder to prefer commit-pinned anchors)."
        ),
    )
    p.add_argument(
        "--check-github-blob-line-ranges",
        action="store_true",
        help=(
            "Fetch `raw.githubusercontent.com` for every `github.com/.../blob/<40-hex-sha>/...#L...` "
            "anchor; fail if any line range exceeds file length."
        ),
    )
    p.add_argument(
        "--check-xoreos-github-line-ranges",
        action="store_true",
        help=(
            "Fetch `raw.githubusercontent.com` for `github.com/xoreos/(xoreos|xoreos-tools)/blob/master/…#L…` "
            "anchors; fail if any line range exceeds file length."
        ),
    )
    p.add_argument(
        "--fail-on-master-blob",
        action="store_true",
        help="Fail if any `github.com/.../blob/master/` or `/tree/master/` URL appears in scanned sources.",
    )
    args = p.parse_args()

    roots = [args.root, *args.also]
    pinned_range_rc = 0
    if args.check_github_blob_line_ranges:
        pinned_range_rc = check_github_blob_line_ranges(
            roots, args.include_markdown, max(args.timeout, 30.0)
        )

    xoreos_master_rc = 0
    if args.check_xoreos_github_line_ranges:
        xoreos_master_rc = check_xoreos_master_blob_line_ranges(
            roots, args.include_markdown, max(args.timeout, 30.0)
        )

    master_rc = 0
    if args.fail_on_master_blob:
        master_rc = check_fail_on_master_blob(roots, args.include_markdown)

    urls = collect_urls(roots, args.include_markdown)
    label = ", ".join(str(r.resolve()) for r in roots)
    print(f"Found {len(urls)} unique https URLs under [{label}]")

    pin_sha = os.environ.get("XOREOS_PIN_SHA", "").strip()
    if args.warn_floating_xoreos_master and pin_sha:
        warned = 0
        for path in iter_source_files(roots, args.include_markdown):
            text = path.read_text(encoding="utf-8", errors="replace")
            for m in _FLOATING_XOREOS_MASTER.finditer(text):
                print(f"WARN floating xoreos master URL in {path}: {m.group(0)}…")
                warned += 1
        if warned:
            print(
                f"({warned} occurrence(s); set `XOREOS_PIN_SHA` is {pin_sha!r} — "
                "prefer /blob/<sha>/… anchors for proof links.)"
            )

    if not args.verify:
        for u in urls:
            print(u)
        return max(pinned_range_rc, xoreos_master_rc, master_rc)

    ok = fail = skipped = 0
    allow = tuple(h.lower() for h in args.allow_fail_host)
    for u in urls:
        good, detail = head_ok(u, args.timeout, args.user_agent)
        if good:
            ok += 1
        elif allow and any(h in u.lower() for h in allow):
            skipped += 1
            print(f"SKIP (allowed host) {u}\n      {detail}")
        else:
            fail += 1
            print(f"FAIL {u}\n      {detail}")
    print(f"OK={ok} FAIL={fail} SKIP={skipped} TOTAL={len(urls)}")
    verify_rc = 1 if fail else 0
    return max(verify_rc, pinned_range_rc, xoreos_master_rc, master_rc)


if __name__ == "__main__":
    sys.exit(main())

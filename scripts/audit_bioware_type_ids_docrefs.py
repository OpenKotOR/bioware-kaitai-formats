"""Flag `doc-ref` repo-relative `#L` bands that do not contain the cited enum row in `bioware_type_ids.ksy`.

Citations use ``formats/Common/bioware_type_ids.ksy#Llo-Lhi`` (no self-referential ``github.com/.../bioware-kaitai-formats`` URL).

1. **`xoreos_file_type_id`**: lines with ``(`xoreos_file_type_id` excerpt)`` (plus TwoDA `wok`/`two_da`).
2. **`xoreos_game_id`**: lines mentioning ``xoreos_game_id`` and (``excerpt`` or `` `xoreos_game_id` enum``) with
   ``**`stem` (id)**`` / `` `stem` (**id**) ``.
3. **`xoreos_archive_type`**: lines mentioning ``xoreos_archive_type`` and ``excerpt`` (or backticked enum name) with the same bold id patterns.
4. **`xoreos_resource_category`**: same pattern (``xoreos_resource_category`` + excerpt / backticks).
5. **`xoreos_platform_id`**: same pattern (``xoreos_platform_id`` + excerpt / backticks).

Does **not** validate PCC `meta.doc-ref` hub bands or prose-only anchors (no id tuple).

**Fragility:** inserting new lines in `formats/Common/bioware_type_ids.ksy` *above* `enums:` (in `meta.doc` / `doc-ref`)
reindexes every enum row and breaks existing `#L` anchors across the repo; extend `bioware_common.ksy` hub `doc-ref` instead.

Run: ``python scripts/audit_bioware_type_ids_docrefs.py`` (exit 0 if no issues, 1 otherwise).

Widen out-of-date ``#L`` bands: ``python scripts/audit_bioware_type_ids_docrefs.py --fix`` (recomputes
each band from the cited id rows; re-run the audit after fixing).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TID = ROOT / "formats" / "Common" / "bioware_type_ids.ksy"
ENTRY_RE = re.compile(r"^\s+(-?\d+):\s+(\w+)\s*$")
# Repo-relative anchor (no self-referential github.com/.../bioware-kaitai-formats URL).
TID_ANCHOR_RE = re.compile(r'formats/Common/bioware_type_ids\.ksy#L(\d+)-L(\d+)')
# Primary highlighted id in generic / most specs: **`stem` (id)**  or  `stem` (**id**)
STARSTEM_RE = re.compile(r"\*\*`(\w+)` \((-?\d+)\)\*\*")
ALTSTEM_RE = re.compile(r"`(\w+)` \(\*\*(-?\d+)\*\*\)")


def _enum_first_key_lines(lines: list[str], start_key: str, end_key: str) -> dict[int, int]:
    start = end = None
    for i, line in enumerate(lines):
        if line == start_key:
            start = i + 1
        elif line == end_key and start is not None:
            end = i
            break
    if start is None or end is None:
        raise SystemExit(f"enum bounds not found: {start_key!r} .. {end_key!r}")
    out: dict[int, int] = {}
    for i in range(start, end):
        m = ENTRY_RE.match(lines[i])
        if not m:
            continue
        k = int(m.group(1))
        if k not in out:
            out[k] = i + 1
    return out


def load_xoreos_file_type_lines() -> dict[int, int]:
    lines = TID.read_text(encoding="utf-8").splitlines()
    return _enum_first_key_lines(
        lines,
        "  xoreos_file_type_id:",
        "  bioware_resource_type_id:",
    )


def load_xoreos_game_id_lines() -> dict[int, int]:
    lines = TID.read_text(encoding="utf-8").splitlines()
    return _enum_first_key_lines(
        lines,
        "  xoreos_game_id:",
        "  xoreos_archive_type:",
    )


def load_xoreos_archive_type_lines() -> dict[int, int]:
    lines = TID.read_text(encoding="utf-8").splitlines()
    return _enum_first_key_lines(
        lines,
        "  xoreos_archive_type:",
        "  xoreos_resource_category:",
    )


def load_xoreos_resource_category_lines() -> dict[int, int]:
    lines = TID.read_text(encoding="utf-8").splitlines()
    return _enum_first_key_lines(
        lines,
        "  xoreos_resource_category:",
        "  xoreos_platform_id:",
    )


def load_xoreos_platform_id_lines() -> dict[int, int]:
    lines = TID.read_text(encoding="utf-8").splitlines()
    start = None
    for i, line in enumerate(lines):
        if line == "  xoreos_platform_id:":
            start = i + 1
            break
    if start is None:
        raise SystemExit("enum bounds not found: '  xoreos_platform_id:' .. EOF")
    out: dict[int, int] = {}
    for i in range(start, len(lines)):
        m = ENTRY_RE.match(lines[i])
        if not m:
            continue
        k = int(m.group(1))
        if k not in out:
            out[k] = i + 1
    return out


def primary_ids_from_docref(rest: str) -> list[tuple[str, int]]:
    """Return (stem, id) for bold backtick id patterns (may be multiple on one line)."""
    out = [(m.group(1), int(m.group(2))) for m in STARSTEM_RE.finditer(rest)]
    out.extend((m.group(1), int(m.group(2))) for m in ALTSTEM_RE.finditer(rest))
    return out


def _select_id_line(
    line: str,
    id_line_ft: dict[int, int],
    id_line_game: dict[int, int],
    id_line_arch: dict[int, int],
    id_line_rescat: dict[int, int],
    id_line_plat: dict[int, int],
) -> dict[int, int] | None:
    if "xoreos_game_id" in line and (
        "excerpt" in line or "`xoreos_game_id` enum" in line or "(`xoreos_game_id`" in line
    ):
        return id_line_game
    if "xoreos_archive_type" in line and (
        "excerpt" in line or "`xoreos_archive_type`" in line or "(`xoreos_archive_type`" in line
    ):
        return id_line_arch
    if "xoreos_resource_category" in line and (
        "excerpt" in line
        or "`xoreos_resource_category`" in line
        or "(`xoreos_resource_category`" in line
    ):
        return id_line_rescat
    if "xoreos_platform_id" in line and (
        "excerpt" in line or "`xoreos_platform_id`" in line or "(`xoreos_platform_id`" in line
    ):
        return id_line_plat
    if "xoreos_file_type_id" in line or "xoreos_file_type_id` **" in line:
        return id_line_ft
    if "`wok`" in line and "`two_da`" in line:
        return id_line_ft
    return None


def _recalc_band(
    line: str,
    id_line: dict[int, int],
) -> tuple[int, int] | None:
    hits = primary_ids_from_docref(line)
    if not hits:
        return None
    lns: list[int] = []
    for _stem, nid in hits:
        ln = id_line.get(nid)
        if ln is not None:
            lns.append(ln)
    if not lns:
        return None
    return (min(lns), max(lns))


def _check_band(
    path: Path,
    line: str,
    lo: int,
    hi: int,
    hits: list[tuple[str, int]],
    id_line: dict[int, int],
    enum_label: str,
    issues: list[str],
) -> None:
    for stem, nid in hits:
        ln = id_line.get(nid)
        if ln is None:
            issues.append(f"{path.relative_to(ROOT)}: id {nid} ({stem}) not in {enum_label}")
            continue
        if not (lo <= ln <= hi):
            issues.append(
                f"{path.relative_to(ROOT)}: **{stem}** ({nid}) on bioware_type_ids.ksy line {ln}, "
                f"not in cited L{lo}-L{hi} ({enum_label})\n  {line.strip()}"
            )


def main() -> int:
    id_line_ft = load_xoreos_file_type_lines()
    id_line_game = load_xoreos_game_id_lines()
    id_line_arch = load_xoreos_archive_type_lines()
    id_line_rescat = load_xoreos_resource_category_lines()
    id_line_plat = load_xoreos_platform_id_lines()
    issues: list[str] = []
    n_ft = n_game = n_arch = n_rescat = n_plat = 0
    for path in sorted(ROOT.glob("formats/**/*.ksy")):
        text = path.read_text(encoding="utf-8")
        for line in text.splitlines():
            if "formats/Common/bioware_type_ids.ksy#L" not in line:
                continue
            um = TID_ANCHOR_RE.search(line)
            if not um:
                continue
            lo, hi = int(um.group(1)), int(um.group(2))
            hits = primary_ids_from_docref(line)
            if not hits:
                continue
            if "xoreos_game_id" in line and (
                "excerpt" in line or "`xoreos_game_id` enum" in line or "(`xoreos_game_id`" in line
            ):
                n_game += 1
                _check_band(path, line, lo, hi, hits, id_line_game, "xoreos_game_id", issues)
                continue
            if "xoreos_archive_type" in line and (
                "excerpt" in line or "`xoreos_archive_type`" in line or "(`xoreos_archive_type`" in line
            ):
                n_arch += 1
                _check_band(path, line, lo, hi, hits, id_line_arch, "xoreos_archive_type", issues)
                continue
            if "xoreos_resource_category" in line and (
                "excerpt" in line
                or "`xoreos_resource_category`" in line
                or "(`xoreos_resource_category`" in line
            ):
                n_rescat += 1
                _check_band(path, line, lo, hi, hits, id_line_rescat, "xoreos_resource_category", issues)
                continue
            if "xoreos_platform_id" in line and (
                "excerpt" in line or "`xoreos_platform_id`" in line or "(`xoreos_platform_id`" in line
            ):
                n_plat += 1
                _check_band(path, line, lo, hi, hits, id_line_plat, "xoreos_platform_id", issues)
                continue
            if "xoreos_file_type_id" not in line and "xoreos_file_type_id` **" not in line:
                # TwoDA uses: **`wok` (2016)** without the standard suffix
                if "`wok`" in line and "`two_da`" in line:
                    pass
                else:
                    continue
            n_ft += 1
            _check_band(path, line, lo, hi, hits, id_line_ft, "xoreos_file_type_id", issues)
    if issues:
        print("\n".join(issues))
        return 1
    ksy_n = len(list(ROOT.glob("formats/**/*.ksy")))
    print(
        "ok",
        "bioware_type_ids",
        "doc-ref",
        "bands",
        f"file_type={n_ft}",
        f"game_id={n_game}",
        f"archive_type={n_arch}",
        f"resource_category={n_rescat}",
        f"platform_id={n_plat}",
        "ksy_files",
        ksy_n,
    )
    return 0


def fix_bands() -> int:
    """Widen in-tree ``doc-ref`` #L ranges so they cover all cited id rows in ``bioware_type_ids.ksy``."""
    id_line_ft = load_xoreos_file_type_lines()
    id_line_game = load_xoreos_game_id_lines()
    id_line_arch = load_xoreos_archive_type_lines()
    id_line_rescat = load_xoreos_resource_category_lines()
    id_line_plat = load_xoreos_platform_id_lines()
    n_files = 0
    n_lines = 0
    for path in sorted(ROOT.glob("formats/**/*.ksy")):
        text = path.read_text(encoding="utf-8")
        new_lines: list[str] = []
        changed = False
        for line in text.splitlines(keepends=True):
            if line.endswith("\r\n"):
                body, eol = line[:-2], "\r\n"
            elif line.endswith("\n"):
                body, eol = line[:-1], "\n"
            else:
                body, eol = line, ""

            if "formats/Common/bioware_type_ids.ksy#L" not in body:
                new_lines.append(line)
                continue
            um = TID_ANCHOR_RE.search(body)
            if not um:
                new_lines.append(line)
                continue
            id_line = _select_id_line(
                body,
                id_line_ft,
                id_line_game,
                id_line_arch,
                id_line_rescat,
                id_line_plat,
            )
            if id_line is None:
                new_lines.append(line)
                continue
            band = _recalc_band(body, id_line)
            if band is None:
                new_lines.append(line)
                continue
            nlo, nhi = band
            lo, hi = int(um.group(1)), int(um.group(2))
            if nlo == lo and nhi == hi:
                new_lines.append(line)
                continue
            new_body = TID_ANCHOR_RE.sub(
                f"formats/Common/bioware_type_ids.ksy#L{nlo}-L{nhi}",
                body,
                count=1,
            )
            new_lines.append(new_body + eol)
            changed = True
            n_lines += 1
        if changed:
            path.write_text("".join(new_lines), encoding="utf-8", newline="\n")
            n_files += 1
    print("fix_bands: updated", n_lines, "line(s) in", n_files, "file(s)")
    return 0


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--fix":
        sys.exit(fix_bands())
    sys.exit(main())

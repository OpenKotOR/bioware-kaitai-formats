"""Re-point GFF generic `bioware_type_ids` doc-ref #L bands to the first `xoreos_file_type_id` enum only.

Run after bulk-editing `formats/Common/bioware_type_ids.ksy` or generic capsules so repo-relative ``formats/Common/bioware_type_ids.ksy#L…`` anchors
stay on the engine `xoreos_file_type_id` table (duplicate numeric keys exist under `bioware_resource_type_id`).

Validate with: `python scripts/audit_bioware_type_ids_docrefs.py` (broader in-tree `#L` checks; CI: `.github/workflows/ksy-verify.yml`).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FORMATS = ROOT / "formats"
TID = FORMATS / "Common" / "bioware_type_ids.ksy"
STEM_ID_RE = re.compile(r"\*\*`(\w+)` \((\d+)\)\*\*")


def parse_typeid_docref_line(line: str) -> tuple[str, int] | None:
    if not line.startswith('  - "formats/Common/bioware_type_ids.ksy#L'):
        return None
    if "(`xoreos_file_type_id` excerpt)\"" not in line:
        return None
    m = STEM_ID_RE.search(line)
    if not m:
        return None
    return m.group(1), int(m.group(2))


def main() -> int:
    all_lines = TID.read_text(encoding="utf-8").splitlines()
    start = None
    end = None
    for i, line in enumerate(all_lines):
        if line == "  xoreos_file_type_id:":
            start = i + 1
        elif line == "  bioware_resource_type_id:" and start is not None:
            end = i
            break
    if start is None or end is None:
        print("ENUM_BOUNDS_NOT_FOUND")
        return 1

    id_to_line: dict[int, int] = {}
    for i in range(start, end):
        line = all_lines[i]
        m = re.match(r"\s+(\d+):\s+(\w+)\s*$", line)
        if m:
            k = int(m.group(1))
            if k not in id_to_line:
                id_to_line[k] = i + 1

    fixed = 0
    for p in sorted((FORMATS / "GFF" / "Generics").glob("*/*.ksy")):
        lines = p.read_text(encoding="utf-8").splitlines()
        out: list[str] = []
        changed = False
        for line in lines:
            parsed = parse_typeid_docref_line(line)
            if not parsed:
                out.append(line)
                continue
            stem, nid = parsed
            ln = id_to_line.get(nid)
            if ln is None:
                print("MISSING", p.relative_to(ROOT), nid)
                return 1
            lo, hi = max(1, ln - 1), min(len(all_lines), ln + 1)
            new_line = (
                f'  - "formats/Common/bioware_type_ids.ksy#L{lo}-L{hi} In-tree — **`{stem}` ({nid})** '
                f'(`xoreos_file_type_id` excerpt)"'
            )
            if new_line != line:
                changed = True
            out.append(new_line)
        if changed:
            p.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
            fixed += 1
    print("files_updated", fixed)
    return 0


if __name__ == "__main__":
    sys.exit(main())

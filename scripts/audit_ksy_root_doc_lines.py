#!/usr/bin/env python3
"""Print root-level `doc: |` line counts for `formats/**/*.ksy` (dedupe by resolved path).

Use after doc-hygiene passes to find oversized `meta.doc` blocks that blow up generated parser docstrings.
"""
from __future__ import annotations

import re
from pathlib import Path


def root_doc_line_count(lines: list[str]) -> tuple[int, int | None, int | None]:
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith("doc:") and "|" in stripped and not line.startswith(" "):
            n = 0
            j = i + 1
            while j < len(lines):
                l = lines[j]
                if not l.strip():
                    n += 1
                    j += 1
                    continue
                if l.lstrip().startswith("#") and not l.startswith(" "):
                    n += 1
                    j += 1
                    continue
                if re.match(r"^[^\s]", l):
                    break
                n += 1
                j += 1
            return n, i + 1, j + 1
        if stripped.startswith("doc:") and not line.startswith(" ") and "|" not in stripped:
            return 1, i + 1, i + 2
    return 0, None, None


def main() -> int:
    root = Path("formats")
    seen: set[str] = set()
    rows: list[tuple[int, str]] = []
    for p in sorted(root.rglob("*.ksy")):
        key = str(p.resolve()).lower()
        if key in seen:
            continue
        seen.add(key)
        lines = p.read_text(encoding="utf-8").splitlines()
        n, _, _ = root_doc_line_count(lines)
        rows.append((n, p.as_posix()))
    rows.sort(reverse=True)
    for n, p in rows:
        flag = " **" if n > 50 else (" *" if n > 35 else "")
        print(f"{n:4d}{flag} {p}")
    print("---")
    print("total unique:", len(rows))
    print(">35 lines:", sum(1 for n, _ in rows if n > 35))
    print(">50 lines:", sum(1 for n, _ in rows if n > 50))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

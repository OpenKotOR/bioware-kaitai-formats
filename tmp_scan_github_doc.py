import pathlib
import re

root = pathlib.Path("formats")
url_re = re.compile(r"https://github\.com/[^\s]+/blob/master/[^\s#]+")
xref_re = re.compile(r"^    [A-Za-z0-9_]+:\s+https://github\.com/")


def line_in_doc_ref_block(lines: list[str], idx0: int) -> bool:
    """True if idx0 is strictly after a root-level `doc-ref:` line and before the next root `seq|types|instances|enums`."""
    dr: int | None = None
    for j, s in enumerate(lines):
        if s.startswith("doc-ref:"):
            dr = j
            continue
        if dr is None:
            continue
        if re.match(r"^(seq|types|instances|enums):", s):
            return dr < idx0 < j
    if dr is not None:
        return idx0 > dr
    return False


out: list[tuple[str, int, str]] = []
for p in sorted(root.rglob("*.ksy")):
    try:
        lines = p.read_text(encoding="utf-8").splitlines()
    except OSError:
        continue
    for i, line in enumerate(lines):
        if "blob/master/" not in line or "#L" in line:
            continue
        if not url_re.search(line):
            continue
        if xref_re.search(line):
            continue
        if line_in_doc_ref_block(lines, i):
            continue
        out.append((p.as_posix(), i + 1, line.rstrip()[:220]))
for rel, ln, s in out[:40]:
    print(f"{rel}:{ln}: {s}")
print("--- total", len(out))

import pathlib
import re

root = pathlib.Path("formats")
url_re = re.compile(r"https://github\.com/[^\s]+/blob/master/[^\s#]+")
xref_re = re.compile(r"^    [A-Za-z0-9_]+:\s+https://github\.com/")


def in_doc_ref_section(lines: list[str], idx0: int) -> bool:
    """True if lines[idx0] is at or after a top-level `doc-ref:` key until `seq:`/`types:`/`instances:`/`enums:` at indent 0."""
    for j in range(idx0, -1, -1):
        s = lines[j]
        if s.startswith("doc-ref:"):
            return True
        if re.match(r"^(meta|seq|types|instances|enums):", s):
            return j != idx0 and s.startswith("doc-ref:") is False and j < idx0
        if j == 0:
            break
    return False


out: list[tuple[str, int, str]] = []
for p in sorted(root.rglob("*.ksy")):
    try:
        lines = p.read_text(encoding="utf-8").splitlines()
    except OSError:
        continue
    for i, line in enumerate(lines, 1):
        if "blob/master/" not in line or "#L" in line:
            continue
        if not url_re.search(line):
            continue
        if xref_re.search(line):
            continue
        if in_doc_ref_section(lines, i - 1):
            continue
        out.append((p.as_posix(), i, line.rstrip()[:220]))
for rel, ln, s in out[:30]:
    print(f"{rel}:{ln}: {s}")
print("--- total", len(out))

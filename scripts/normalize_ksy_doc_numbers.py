#!/usr/bin/env python3
# ruff: noqa: PLR0911, PLR0912, PLR0915
"""Normalize ``*.ksy`` doc prose: byte sizes/offsets as ``N (0xN)`` (e.g. ``12 (0xC) bytes``)."""

from __future__ import annotations

import re
import sys
from pathlib import Path

FORMATS = Path(__file__).resolve().parents[1] / "formats"
FOLD = re.compile(r"^(\s*)\S.*:\s\|\s*(#.*)?$")
# After ``li <= base`` at same indent, sibling YAML key
SIB = re.compile(r"^(\s*[-a-zA-Z0-9_.$]+|\"[^\"]+\"?):\s*")


def hx(n: int) -> str:
    return f"0x{n:x}"


def foldable(line: str) -> bool:
    s = line.rstrip("\n\r")
    s = s.split("#", 1)[0].rstrip()
    if "http" in s:
        return False
    if s.rstrip().endswith("|-") or s.endswith(" |-"):
        return False
    if not s.endswith("|"):
        return False
    return re.search(r":\s\|\s*$", s) is not None and bool(s.lstrip() and not s.lstrip().startswith("#"))


def xform(s: str) -> str:
    t = s
    t = re.sub(
        r"\b0x([0-9a-fA-F]{1,8})[\u2013-]0x([0-9a-fA-F]{1,8})\b",
        lambda m: f"{(a := int(m.group(1), 16))} ({hx(a)})"
        f"–{(b := int(m.group(2), 16))} ({hx(b)})",
        t,
    )

    def n_bytes(m: re.Match[str]) -> str:
        n = int(m.group(1))
        a, full, left = m.start(1), m.string, m.string[: m.start(1)]
        if a >= 2 and full[a - 2 : a] == "0x":
            return m.group(0)
        if re.search(r"\(0x[0-9a-fA-F]+\)\s+$", left.rstrip()):
            return m.group(0)
        if re.search(r" \(0x[0-9a-fA-F]+\)\s$", left.replace("\t", " ")[-32:]):
            return m.group(0)
        return f"{n} ({hx(n)}) bytes"

    t = re.sub(r"(?<![0-9.])\b(\d{1,9})\s+bytes\b", n_bytes, t)
    t = re.sub(
        r"(?<![0-9*])\b0x([0-9a-fA-F]+)-byte\b",
        lambda m: f"{int(m.group(1), 16)} ({hx(int(m.group(1), 16))})-byte",
        t,
    )
    t = re.sub(
        r"\*\*(\d{1,9})\*\*-byte",
        lambda m: f"{m.group(1)} ({hx(int(m.group(1)))})-byte",
        t,
    )
    t = re.sub(
        r"(?<![0-9.*])\b(\d{1,9})-byte\b",
        lambda m: f"{m.group(1)} ({hx(int(m.group(1)))})-byte",
        t,
    )
    t = re.sub(
        r"(?<![0-9.])\b(\d{1,9})\s+byte\b(?!s)",
        lambda m: f"{m.group(1)} ({hx(int(m.group(1)))}) byte",
        t,
    )
    t = re.sub(
        r"(?<![0-9.])\b(\d{1,9})\s+B(?=[\b,.)])",
        lambda m: f"{m.group(1)} ({hx(int(m.group(1)))}) B",
        t,
    )
    t = re.sub(
        r"×\s*(\d{1,9})\s+(bytes|B)\b",
        lambda m: f"× {m.group(1)} ({hx(int(m.group(1)))}) {m.group(2)}",
        t,
    )
    t = re.sub(
        r"(?<![0-9(])\bmax (\d{1,9}) bytes",
        lambda m: f"max {m.group(1)} ({hx(int(m.group(1)))}) bytes",
        t,
    )
    t = re.sub(
        r"\boffset 0x([0-9a-fA-F]{1,6})\b(?!,|\)|])",
        lambda m: f"offset {int(m.group(1), 16)} ({hx(int(m.group(1), 16))})",
        t,
    )
    t = re.sub(
        r"(?<![0-9(])\boffset (\d{1,9})(?![0-9—\-])(?!\s*\(0x)",
        lambda m: f"offset {m.group(1)} ({hx(int(m.group(1)))})",
        t,
    )
    t = re.sub(
        r"\((\d{1,9}) bytes\)",
        lambda m: f"({m.group(1)} ({hx(int(m.group(1)))}) bytes)",
        t,
    )
    return t


def is_kaitai_struct(s: str) -> bool:
    t = s.rstrip("\n\r")
    st = t.strip()
    if not st:
        return True
    if t.lstrip().startswith("#"):
        return False
    if re.match(r"^(\s*-\s*)0x[0-9a-fA-F]+:\s+\S", t):
        return True
    if re.match(
        r"^(\s*)-?\s+id:\s|^\s+id:\s|^\s+type:\s|^\s+size:\s|^\s+if:\s|"
        r"^\s+pos:\s|^\s+value:\s|^\s+valid:\s|"
        r"^\s+default:|\bterminator:|\bencoding:|\benum-id:|\btype-id:|\brepeat:",
        t,
    ):
        return True
    if re.match(
        r"^(\s*)(- )?repeat-expr:|\brepeat-until:|\bpad-right:|\bconsume:|\bbit-endian:|\bimport:|\bio:",
        t,
    ):
        return True
    if re.match(r"^(\s*)-?\s*0x[0-9a-fA-F]+:\s+\S", t) and "doc:" not in t and " doc " not in t:
        return True
    return False


def ends_fold(li: int, base: int, t: str) -> bool:
    s = t.rstrip("\n\r")
    st = s.strip()
    if not st:
        return False
    if s.lstrip().startswith(("#",)):
        return False
    if li > base:
        return False
    if SIB.match(s):
        return True
    return bool(re.match(r"^(\s*-\s+id:\s|^\s+id:\s|^\s+type:\s|^\s+seq:)", t))


def maybe_line(line: str) -> str:
    t = line.rstrip("\n\r")
    eol = line[len(t) :]
    m = re.match(
        r"^((\s*|-\s+)?doc:\s+)(.+)$",
        t,
    )
    if m and " |" not in m.group(0):
        pre, rest = m.group(1, 3)
        r2 = xform(rest)
        return (pre + r2 + eol) if r2 != rest else line
    m2 = re.match(
        r"^((\s*|-\s+)?title:\s+)(.+)$",
        t,
        re.I,
    )
    if m2:
        pre, rest = m2.group(1, 3)
        r2 = xform(rest)
        return (pre + r2 + eol) if r2 != rest else line
    r2 = xform(t)
    return (r2 + eol) if r2 != t else line


def process_ksy(path: Path) -> bool:
    old = path.read_text(encoding="utf-8")
    lines = old.splitlines(keepends=True)
    if not lines:
        return False
    n = len(lines)
    out: list[str] = []
    in_fold = False
    base = 0
    i = 0
    while i < n:
        line = lines[i]
        t = line.rstrip("\n\r")
        m = FOLD.match(t) if foldable(t) else None
        if in_fold:
            li = len(line) - len(line.lstrip(" "))
            if t == "" or (t and t.lstrip().startswith(("#",))):
                out.append(maybe_line(line) if t else line)
                i += 1
                continue
            if li <= base and t and not t.lstrip().startswith(("#",)) and ends_fold(
                li,
                base,
                t,
            ):
                in_fold = False
            else:
                if not is_kaitai_struct(t):
                    out.append(maybe_line(line))
                else:
                    out.append(line)
                i += 1
                continue
        if m:
            in_fold = True
            base = len(m.group(1) or "")
            out.append(line)
            i += 1
            continue
        out.append(maybe_line(line))
        i += 1
    new = "".join(out)
    if new == old:
        return False
    path.write_text(new, encoding="utf-8")
    return True


def main() -> int:
    paths = (
        [Path(p) for p in sys.argv[1:]]
        if len(sys.argv) > 1
        else sorted(FORMATS.rglob("*.ksy"))
    )
    n = 0
    for p in paths:
        if process_ksy(p):
            n += 1
            print(p)  # noqa: T201
    print("updated", n)  # noqa: T201
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
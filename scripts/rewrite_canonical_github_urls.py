#!/usr/bin/env python3
"""Rewrite known fork/pin GitHub URL prefixes in formats/**/*.ksy to canonical upstreams.

Matches URLs with or without a ``/`` immediately after the commit SHA (e.g. ``…/blob/<sha>`` alone
or ``…/blob/<sha>/src/…``).

Run from repo root; then::

  python scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges --also docs/XOREOS_FORMAT_COVERAGE.md
"""
from __future__ import annotations

import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

# (old_prefix, new_prefix) — old must be unique to the fork pin; replace every occurrence.
REPLACEMENTS: list[tuple[str, str]] = [
    (
        "https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800",
        "https://github.com/xoreos/xoreos-tools/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2",
        "https://github.com/xoreos/xoreos/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163",
        "https://github.com/xoreos/xoreos-docs/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/xoreos-docs/tree/c7f12b09788a331499ce15b1283b630b4feb5163",
        "https://github.com/xoreos/xoreos-docs/tree/master",
    ),
    (
        "https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33",
        "https://github.com/OpenKotOR/PyKotor/tree/master",
    ),
    (
        "https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33",
        "https://github.com/OpenKotOR/PyKotor/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2",
        "https://github.com/modawan/reone/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264",
        "https://github.com/KobaltBlu/KotOR.js/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2",
        "https://github.com/NickHugi/Kotor.NET/blob/master",
    ),
    (
        "https://github.com/th3w1zard1/Kotor.NET/tree/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2",
        "https://github.com/NickHugi/Kotor.NET/tree/master",
    ),
]


def main() -> int:
    base = REPO_ROOT / "formats"
    changed = 0
    for path in sorted(base.rglob("*.ksy")):
        text = path.read_text(encoding="utf-8")
        orig = text
        for old, new in REPLACEMENTS:
            text = text.replace(old, new)
        if text != orig:
            path.write_text(text, encoding="utf-8", newline="\n")
            print(path.relative_to(REPO_ROOT))
            changed += 1
    print(f"updated {changed} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())

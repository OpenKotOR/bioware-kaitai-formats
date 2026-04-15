#!/usr/bin/env python3
"""Rewrite GitHub ``/blob/master/`` and ``/tree/master/`` URLs in ``formats/**/*.ksy`` using
``scripts/data/upstream_github_pins.json`` (commit-pinned ``th3w1zard1/*`` forks where configured).

**Inverse of canonical URLs:** this tool replaces upstream ``OpenKotOR/PyKotor`` / ``xoreos/xoreos``
``master`` links with **fork SHAs** for regression snapshots. Do **not** run it after
``scripts/rewrite_canonical_github_urls.py`` unless you intentionally want fork pins back.

Run from repo root::

    python scripts/apply_github_pins.py
    python scripts/apply_github_pins.py --dry-run
    python scripts/apply_github_pins.py --emit-inventory  # print unique github.com owners/repos seen
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


def load_pins(repo_root: Path) -> dict[str, dict]:
    p = repo_root / "scripts" / "data" / "upstream_github_pins.json"
    data = json.loads(p.read_text(encoding="utf-8"))
    return data["repos"]


def build_rules(repos: dict[str, dict]) -> list[tuple[str, str]]:
    rules: list[tuple[str, str]] = []
    for fork, info in repos.items():
        sha = info["sha"]
        fo, fr = fork.split("/", 1)
        for upstream in info["replaces"]:
            uo, ur = upstream.split("/", 1)
            rules.append(
                (
                    f"https://github.com/{uo}/{ur}/blob/master/",
                    f"https://github.com/{fo}/{fr}/blob/{sha}/",
                )
            )
            rules.append(
                (
                    f"https://github.com/{uo}/{ur}/tree/master/",
                    f"https://github.com/{fo}/{fr}/tree/{sha}/",
                )
            )
    # TSLPatcher uses ``main`` as default branch on the fork.
    rules.append(
        (
            "https://github.com/th3w1zard1/TSLPatcher/blob/main/",
            "https://github.com/th3w1zard1/TSLPatcher/blob/ad04700a47086c25e1c6ef4b4961f76dfa8cc6a5/",
        )
    )
    rules.append(
        (
            "https://github.com/th3w1zard1/TSLPatcher/tree/main/",
            "https://github.com/th3w1zard1/TSLPatcher/tree/ad04700a47086c25e1c6ef4b4961f76dfa8cc6a5/",
        )
    )
    # Already-forked repos that still used ``/blob/master/`` in-tree.
    rules.append(
        (
            "https://github.com/th3w1zard1/mdlops/blob/master/",
            "https://github.com/th3w1zard1/mdlops/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/",
        )
    )
    rules.append(
        (
            "https://github.com/th3w1zard1/mdlops/tree/master/",
            "https://github.com/th3w1zard1/mdlops/tree/7e40846d36acb5118e2e9feb2fd53620c29be540/",
        )
    )
    return rules


_GITHUB_REPO = re.compile(r"https://github\.com/([^/]+)/([^/]+)/")


def emit_inventory(files: list[Path]) -> None:
    seen: set[tuple[str, str]] = set()
    for path in files:
        text = path.read_text(encoding="utf-8", errors="replace")
        for m in _GITHUB_REPO.finditer(text):
            seen.add((m.group(1), m.group(2)))
    for o, r in sorted(seen):
        print(f"{o}/{r}")


def apply_to_files(files: list[Path], rules: list[tuple[str, str]], dry: bool) -> int:
    changed_files = 0
    for path in files:
        text = path.read_text(encoding="utf-8")
        new = text
        for old, repl in rules:
            new = new.replace(old, repl)
        if new != text:
            changed_files += 1
            if not dry:
                path.write_text(new, encoding="utf-8", newline="\n")
    print(f"{'Would change' if dry else 'Changed'} {changed_files} file(s)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--root", type=Path, default=Path("."), help="Repository root")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument(
        "--emit-inventory",
        action="store_true",
        help="List unique github.com owner/repo pairs under formats/**/*.ksy and exit",
    )
    args = ap.parse_args()
    repo_root: Path = args.root.resolve()
    formats = repo_root / "formats"
    files = sorted(formats.rglob("*.ksy"))
    if args.emit_inventory:
        emit_inventory(files)
        return 0
    repos = load_pins(repo_root)
    rules = build_rules(repos)
    return apply_to_files(files, rules, args.dry_run)


if __name__ == "__main__":
    sys.exit(main())

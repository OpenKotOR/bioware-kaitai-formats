#!/usr/bin/env python3
"""Report xoreos `FileType` coverage vs `formats/coverage/filetype_coverage.yaml`.

Reads `xoreos_file_type_id` from `formats/Common/bioware_type_ids.ksy` (line-oriented parse).
Prints MISSING (enum value absent from YAML) and optional DRIFT (vendor `types.h` constants
not present in the mirrored enum).

The coverage YAML uses a **restricted subset** (no PyYAML required): each entry under ``coverage:``
must look like::

  2012:
    tier: B
    spec: formats/GFF/Generics/ARE/ARE.ksy

Run from repo root::

    python scripts/report_filetype_ksy_coverage.py
    python scripts/report_filetype_ksy_coverage.py --vendor-types-h vendor/xoreos/src/aurora/types.h
    python scripts/report_filetype_ksy_coverage.py --write-default-coverage
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_KSY = REPO_ROOT / "formats" / "Common" / "bioware_type_ids.ksy"
DEFAULT_YAML = REPO_ROOT / "formats" / "coverage" / "filetype_coverage.yaml"


def parse_xoreos_file_type_enum(ksy_path: Path) -> dict[int, str]:
    text = ksy_path.read_text(encoding="utf-8")
    lines = text.splitlines()
    in_enum = False
    out: dict[int, str] = {}
    entry_re = re.compile(r"^\s+(-?\d+):\s+(\S+)\s*$")
    for line in lines:
        if line.rstrip() == "  xoreos_file_type_id:":
            in_enum = True
            continue
        if in_enum:
            if line.startswith("  ") and not line.startswith("    "):
                break
            m = entry_re.match(line)
            if m:
                out[int(m.group(1))] = m.group(2)
    if not out:
        raise SystemExit(f"no xoreos_file_type_id entries parsed from {ksy_path}")
    return out


def parse_vendor_filetype_constants(types_h: Path) -> dict[int, list[str]]:
    """Map numeric -> list of C++ enum identifiers (kFileTypeFoo)."""
    text = types_h.read_text(encoding="utf-8", errors="replace")
    pat = re.compile(
        r"\b(kFileType\w+)\s*=\s*(-?\d+)\s*(?:,|(?:,\s*///<))",
        re.MULTILINE,
    )
    by_val: dict[int, list[str]] = {}
    for m in pat.finditer(text):
        name, val_s = m.group(1), int(m.group(2))
        by_val.setdefault(val_s, []).append(name)
    return by_val


def load_coverage_yaml(path: Path) -> dict[int, dict[str, str]]:
    """Parse minimal YAML: top-level ``coverage:`` then ``  <int>:\\n    tier: ...\\n    spec: ...``."""
    if not path.is_file():
        return {}
    lines = path.read_text(encoding="utf-8").splitlines()
    cov: dict[int, dict[str, str]] = {}
    in_cov = False
    current: int | None = None
    key_re = re.compile(r"^  (-?\d+):\s*$")
    field_re = re.compile(r"^    (tier|spec|notes):(?:\s+(.*))?$")
    for raw in lines:
        line = raw.rstrip("\n")
        if line.strip().startswith("#"):
            continue
        if line.rstrip() == "coverage:":
            in_cov = True
            current = None
            continue
        if not in_cov:
            continue
        mkey = key_re.match(line)
        if mkey:
            current = int(mkey.group(1))
            cov[current] = {"tier": "", "spec": "", "notes": ""}
            continue
        if current is None:
            continue
        mf = field_re.match(line)
        if mf:
            k, v = mf.group(1), (mf.group(2) or "").strip()
            if k == "notes" and v.startswith('"') and v.endswith('"'):
                v = v[1:-1]
            if k == "spec" and v.startswith('"') and v.endswith('"'):
                v = v[1:-1]
            cov[current][k] = v
    return cov


def _stem_upper(name: str) -> str:
    return name.upper().replace(".", "_")


def default_coverage_row(val: int, name: str) -> dict[str, str]:
    """Heuristic tier + spec for bootstrap / gap triage (tiers A–E per maintainer plan)."""
    # Tier C — archive containers
    c_arch = {
        9997: "formats/ERF/ERF.ksy",
        9998: "formats/BIF/BIF.ksy",
        9999: "formats/BIF/KEY.ksy",
        3002: "formats/RIM/RIM.ksy",
        26000: "formats/BIF/BZF.ksy",
    }
    if val in c_arch:
        return {"tier": "C", "spec": c_arch[val], "notes": "Archive / index wire"}

    # Tier A — dedicated binary specs in-repo
    a_map: dict[int, tuple[str, str]] = {
        -1: ("A", "formats/Common/bioware_type_ids.ksy"),
        1: ("E", ""),
        2: ("E", ""),
        3: ("A", "formats/TPC/TGA.ksy"),
        4: ("A", "formats/WAV/WAV.ksy"),
        6: ("A", "formats/PLT/PLT.ksy"),
        2002: ("A", "formats/MDL/MDL.ksy"),
        2009: ("D", "formats/NSS/NSS.ksy"),
        2010: ("A", "formats/NSS/NCS.ksy"),
        2011: ("C", "formats/ERF/ERF.ksy"),
        2017: ("A", "formats/TwoDA/TwoDA.ksy"),
        2018: ("A", "formats/TLK/TLK.ksy"),
        2022: ("D", "formats/TPC/TXI.ksy"),
        2033: ("A", "formats/TPC/DDS.ksy"),
        2036: ("A", "formats/LTR/LTR.ksy"),
        2037: ("A", "formats/GFF/GFF.ksy"),
        2052: ("A", "formats/BWM/BWM.ksy"),
        2053: ("A", "formats/BWM/BWM.ksy"),
        2016: ("A", "formats/BWM/BWM.ksy"),
        2060: ("A", "formats/SSF/SSF.ksy"),
        2061: ("C", "formats/ERF/ERF.ksy"),
        2062: ("C", "formats/ERF/ERF.ksy"),
        3004: ("A", "formats/LIP/LIP.ksy"),
        3005: ("A", "formats/BWM/BWM.ksy"),
        3006: ("A", "formats/TPC/TXB.ksy"),
        3007: ("A", "formats/TPC/TPC.ksy"),
        3008: ("A", "formats/MDL/MDX.ksy"),
        3017: ("A", "formats/TPC/TXB2.ksy"),
        3028: ("A", "formats/LIP/BIP.ksy"),
        9996: ("A", "formats/TwoDA/TwoDA.ksy"),
        22008: ("A", "formats/GDA/GDA.ksy"),
        2098: ("A", "formats/DAS/DAS.ksy"),
        27000: ("A", "formats/DA2S/DA2S.ksy"),
    }
    if val in a_map:
        tier, spec = a_map[val]
        note = "Dedicated wire or standard-media placeholder (tier E may omit spec)"
        return {"tier": tier, "spec": spec, "notes": note}

    # Tier B — GFF3 template capsules (Generics/<STEM>/<STEM>.ksy)
    gff_templates = {
        "res",
        "are",
        "set",
        "ifo",
        "bic",
        "git",
        "bti",
        "uti",
        "btc",
        "utc",
        "dlg",
        "itp",
        "btt",
        "utt",
        "bts",
        "uts",
        "fac",
        "bte",
        "ute",
        "btd",
        "utd",
        "btp",
        "utp",
        "btm",
        "utm",
        "btg",
        "utg",
        "jrl",
        "sav",
        "utw",
        "pth",
        "gic",
        "gui",
        "cut",
        "qdb",
        "qst",
        "ptm",
        "ptt",
        "cam",
    }
    if name in gff_templates:
        stem = _stem_upper(name)
        return {
            "tier": "B",
            "spec": f"formats/GFF/Generics/{stem}/{stem}.ksy",
            "notes": "GFF3 on-disk wire via GFF.ksy capsule",
        }

    # Tier D — plaintext / tooling (policy: may exist as .ksy for interchange docs)
    d_plain = {
        7,
        10,
        3000,
        3001,
        20003,
        28000,
        28001,
        28002,
        28003,
    }
    if val in d_plain or name in {"ini", "txt", "lyt", "vis", "xml", "json", "nss"}:
        return {
            "tier": "D",
            "spec": "",
            "notes": "Plaintext / tooling — see AGENTS.md scope",
        }

    # Tier E — common foreign binary (no dedicated BioWare wire spec here)
    e_media = {
        8,
        9,
        11,
        12,
        13,
        2076,
        2077,
        2078,
        2110,
        25014,
        41000,
    }
    if val in e_media or name in {
        "bmp",
        "mve",
        "mpg",
        "wma",
        "wmv",
        "xmv",
        "jpg",
        "ico",
        "ogg",
        "png",
        "mp3",
        "wbm",
    }:
        return {
            "tier": "E",
            "spec": "",
            "notes": "Standard or codec container — normative spec outside repo",
        }

    # Default: unclassified (still listed so MISSING count stays meaningful when hand-trimming)
    return {
        "tier": "U",
        "spec": "",
        "notes": "TODO classify (A–E) and add owning spec or policy row",
    }


def write_default_coverage(path: Path, enum_map: dict[int, str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Machine-maintained: regenerate with `python scripts/report_filetype_ksy_coverage.py --write-default-coverage`",
        "# Tiers: A=dedicated binary wire, B=GFF template capsule, C=archive container, D=plaintext/tooling, E=foreign standard, U=unclassified",
        "coverage:",
    ]
    for val in sorted(enum_map):
        name = enum_map[val]
        row = default_coverage_row(val, name)
        lines.append(f"  {val}:")
        lines.append(f"    tier: {row['tier']}")
        spec = row["spec"].replace('"', '\\"')
        if spec:
            lines.append(f'    spec: "{spec}"')
        else:
            lines.append('    spec: ""')
        if row.get("notes"):
            lines.append(f'    notes: "{row["notes"]}"')
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--ksy",
        type=Path,
        default=DEFAULT_KSY,
        help="Path to bioware_type_ids.ksy",
    )
    ap.add_argument(
        "--coverage-yaml",
        type=Path,
        default=DEFAULT_YAML,
        help="Path to filetype_coverage.yaml",
    )
    ap.add_argument(
        "--vendor-types-h",
        type=Path,
        default=None,
        help="Optional vendor xoreos types.h for DRIFT detection vs mirrored enum",
    )
    ap.add_argument(
        "--write-default-coverage",
        action="store_true",
        help="Write heuristic coverage YAML for every enum id (overwrites target file)",
    )
    ap.add_argument(
        "--fail-on-missing",
        action="store_true",
        help="Exit non-zero if any MISSING rows (default: print only)",
    )
    args = ap.parse_args()

    enum_map = parse_xoreos_file_type_enum(args.ksy)
    if args.write_default_coverage:
        write_default_coverage(args.coverage_yaml, enum_map)
        print(f"Wrote {args.coverage_yaml} ({len(enum_map)} rows)")
        return 0

    cov = load_coverage_yaml(args.coverage_yaml)
    if not cov:
        raise SystemExit(
            f"{args.coverage_yaml} missing or empty — run with --write-default-coverage first"
        )

    missing: list[tuple[int, str]] = []
    for val, name in sorted(enum_map.items(), key=lambda x: x[0]):
        if val not in cov:
            missing.append((val, name))

    print(f"Parsed {len(enum_map)} xoreos_file_type_id values from {args.ksy}")
    print(f"Coverage rows: {len(cov)} in {args.coverage_yaml}")
    print(f"MISSING: {len(missing)}")
    for val, name in missing:
        print(f"  MISSING  {val:6d}  {name}")

    drift: list[tuple[int, str]] = []
    if args.vendor_types_h and args.vendor_types_h.is_file():
        vendor = parse_vendor_filetype_constants(args.vendor_types_h)
        for val, names in sorted(vendor.items(), key=lambda x: x[0]):
            if val not in enum_map:
                drift.append((val, ", ".join(sorted(names))))
        print(
            f"DRIFT (vendor const not in mirrored bioware_type_ids enum): {len(drift)}"
        )
        for val, names in drift:
            print(f"  DRIFT    {val:6d}  {names}")
    elif args.vendor_types_h:
        print(
            f"Note: vendor types.h not found at {args.vendor_types_h} — skipping DRIFT",
            file=sys.stderr,
        )

    if args.fail_on_missing and missing:
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

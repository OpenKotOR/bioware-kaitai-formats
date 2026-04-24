---
name: FileType KSY coverage
overview: "Clarify xoreos `ResourceType` vs `FileType`, explain the `uv run` Win32 error, then drive exhaustive `FileType` coverage: per-template GFF `.ksy` under `formats/GFF/Generics/`, dedicated `.ksy` for every other binary wire family, inventory automation against [`formats/Common/bioware_type_ids.ksy`](formats/Common/bioware_type_ids.ksy), and verification via xoreos/xoreos-tools plus **observed behavior** in shipped executables when it anchors a layout or enum."
todos:
  - id: clarify-enums-doc
    content: Document ResourceType vs FileType in bioware_type_ids.ksy / XOREOS_FORMAT_COVERAGE.md and sync upstream drift (e.g. WBM 41000 if confirmed on master).
    status: completed
  - id: coverage-inventory-script
    content: Add scripts/report_filetype_ksy_coverage.py + formats/coverage/filetype_coverage.yaml to enumerate xoreos_file_type_id rows and print MISSING/DRIFT vs owning .ksy paths.
    status: completed
  - id: gff-generics-wave1-kotor
    content: Scaffold formats/GFF/Generics/<Template>/*.ksy for KotOR-critical GFF templates (ARE/GIT/IFO/UTC/UT*/DLG/JRL/PTH/…) importing shared GFF modules.
    status: completed
  - id: binary-gaps-wave1-kotor
    content: Prioritize remaining KotOR binary FileType families (TXB/TXB2/BIP/etc.) with xoreos reader parity and `meta.xref` notes for **observed behavior** / upstream parsers where applicable.
    status: completed
  - id: uv-run-doc
    content: Document correct `uv run pwsh -File ...` invocation for compile scripts (README or script header).
    status: completed
  - id: verify-ci-batch
    content: "After each batch: verify_ksy_urls.py (+ optional vendor xref), pytest smoke, regenerate kaitai outputs."
    status: completed
isProject: false
---

# Exhaustive xoreos-aligned `.ksy` coverage (FileType + GFF templates)

## 0) Terminology: what xoreos calls `ResourceType`

In upstream [xoreos `src/aurora/types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h), **`enum ResourceType` is not the archive “restype” table**. It is only five media categories plus a sentinel:

- `kResourceImage`, `kResourceVideo`, `kResourceSound`, `kResourceMusic`, `kResourceCursor`, `kResourceMAX`

This repo already mirrors that as **`xoreos_resource_category`** in [`formats/Common/bioware_type_ids.ksy`](formats/Common/bioware_type_ids.ksy) (values `0..5`). **There is nothing “missing” for that enum** beyond keeping it in sync if upstream ever changes.

What you mean by “Eclipse / Aurora / Odyssey resource types” (and why **36** `.ksy` files is plausible) is almost certainly **`enum FileType`** in the same header: the large numeric ID map used in KEY/BIF/ERF/RIM entries. That set is already mirrored as **`xoreos_file_type_id`** in the same `.ksy` file (see `meta.xref.xoreos_types_file_type_enum`).

**Plan implication:** all gap analysis, “zero omissions,” and new `.ksy` work should be framed against **`FileType` / `xoreos_file_type_id`**, not the tiny `ResourceType` enum.

## 1) `uv run` error 193 on Windows

`uv run .\scripts\compile_all_languages.ps1` fails because **`uv run` tries to execute the `.ps1` as a native executable**; Windows returns **“%1 is not a valid Win32 application (193)”**.

**Correct invocation pattern (document in README or script header comment, no policy change required unless you want):**

- `uv run pwsh -NoProfile -File .\scripts\compile_all_languages.ps1`, or
- run `.\scripts\compile_all_languages.ps1` directly under PowerShell (what you already did successfully).

## 2) “Which ones are missing?” — definition + deliverable

Because “missing” depends on **coverage rules**, use this **explicit matrix** (and automate it):

| Tier | Meaning | Example |
|------|---------|--------|
| A | **Dedicated binary wire `.ksy`** | `MDL.ksy`, `TPC.ksy`, `TLK.ksy` |
| B | **Per-template GFF `.ksy` (your choice)** | `formats/GFF/Generics/ARE/ARE.ksy` wrapping / documenting GFF3 instance rules for ARE |
| C | **Archive / container only** | Types `9997` ERF, `9998` BIF, `9999` KEY, `3002` RIM — already covered by archive specs |
| D | **Plaintext / interchange** (repo policy today) | `NSS`, `TXI`, `LYT`, `VIS`, XML/JSON rows — `.ksy` may still exist (as today for some) but must be labeled **non-wire** per [`AGENTS.md`](AGENTS.md) |
| E | **Standard foreign formats** (BMP/JPEG/PNG/OGG/WebM/…) | Prefer normative external spec references in `meta.xref` / `doc`; optional thin `.ksy` if you truly want in-tree parsing |

**Deliverable:** add a small maintainer script (e.g. [`scripts/report_filetype_ksy_coverage.py`](scripts/report_filetype_ksy_coverage.py)) that:

1. Parses `xoreos_file_type_id` from [`formats/Common/bioware_type_ids.ksy`](formats/Common/bioware_type_ids.ksy) (or reads `vendor/xoreos/src/aurora/types.h` when present).
2. Reads a **machine-edited mapping table** (e.g. `formats/coverage/filetype_coverage.yaml`) mapping each numeric ID → tier A/B/C/D/E + owning `.ksy` path(s).
3. Prints **`MISSING`** rows (no mapping) and **`DRIFT`** rows (upstream `types.h` adds IDs not present in the YAML mirror — e.g. upstream recently adds `kFileTypeWBM = 41000` after `kFileTypeXEOSITEX`; your mirrored enum currently ends at `40000: xeositex` and **does not yet list `41000`**).

**Initial “missing” statement (high-signal, not exhaustive without running the inventory):**

- **Hundreds** of `FileType` values are **not** represented as dedicated top-level wire specs today; most fall into: **GFF-backed templates** (should become tier B per your choice), **plaintext** (tier D), **standard media** (tier E), or **game-specific binary families** not yet modeled (true tier A gaps: e.g. many Dragon Age / NWN2 / Jade / DS nitro rows, texture variants like TXB/TXB2, codec containers like BIK/MVE, etc.).
- The repo’s maintainer index already acknowledges this shape in [`docs/XOREOS_FORMAT_COVERAGE.md`](docs/XOREOS_FORMAT_COVERAGE.md) section **2** (“without a dedicated first-class `.ksy`”).

The script + YAML table is how we make “zero omissions” **measurable** and keep it from regressing.

## 3) Implementation strategy (exhaustive, but phased)

### Phase A — Inventory + policy lock

- Build `filetype_coverage.yaml` starting from `xoreos_file_type_id` keys.
- Mark each ID with tier + authoritative upstream pointer (prefer `xoreos/xoreos` `master` `blob/...#L` per [`AGENTS.md`](AGENTS.md)).
- For KotOR PC **consumption proofs**, add `meta.xref` blocks (per-field `seq`/`types` in `.ksy`) that cite **observed behavior** or canonical upstreams when they anchor structs/enums — not boilerplate that names external tooling.

### Phase B — GFF templates (your selection: per-template `.ksy`)

For every `FileType` whose upstream comment indicates **GFF** (and any additional templates discovered via xoreos `*file.cpp` / PyKotor loaders), add:

- `formats/GFF/Generics/<STEM>/<STEM>.ksy` (uppercase dir optional; follow [.cursorrules](.cursorrules) examples)
- Each file should: `imports` shared field/layout types from [`formats/Common/bioware_gff_common.ksy`](formats/Common/bioware_gff_common.ksy) + [`formats/GFF/GFF.ksy`](formats/GFF/GFF.ksy) patterns, and focus **`doc` / `meta.xref` / struct id** on template-specific labels, root structs, and game variance — avoid duplicating entire GFF3 grammar if a single import composition is enough.

**Practical sequencing:** KotOR-first templates (ARE/GIT/IFO/UTC/UT*/DLG/JRL/PTH/…), then NWN/NWN2 expansions, then Dragon Age/Jade/Sonic families.

### Phase C — Non-GFF binary `FileType` families

For each remaining tier A target, create or extend `.ksy` under `formats/<Family>/` mirroring the **actual reader** in xoreos (runtime) and, where separate, xoreos-tools.

Priority order (matches your note):

1. **KotOR — observed behavior** in shipped builds for structs that differ from docs-only guesses.
2. **xoreos / xoreos-tools** parsers as primary wire truth.
3. **PyKotor / reone** as secondary cross-checks where they agree on bytes.

### Phase D — Plaintext + tooling types

Where `AGENTS.md` excludes interchange: still allowed to exist (as today) but must be explicitly labeled and excluded from “binary completeness” metrics unless you expand maintainer scope.

### Phase E — Repo hygiene

- Extend [`docs/XOREOS_FORMAT_COVERAGE.md`](docs/XOREOS_FORMAT_COVERAGE.md) section 1 rows for each new `.ksy`.
- Run the verification block from [`AGENTS.md`](AGENTS.md) after batches (`verify_ksy_urls.py`, optional vendor line checker, `pytest`).
- Regenerate multi-language outputs via [`scripts/compile_all_languages.ps1`](scripts/compile_all_languages.ps1) / CI equivalents.

## 4) Expectations / risk notes

- This is **large surface area** (hundreds of IDs × multiple games × parser variance). The inventory script + YAML coverage map is the difference between “claim completeness” and **proving** completeness.
- Some `FileType` values are **aliases / collisions** (already documented for `FXR`/`FXT`, `DFT`/`DTF`); the coverage map must record canonical naming consistent with [`formats/Common/bioware_type_ids.ksy`](formats/Common/bioware_type_ids.ksy) constraints.

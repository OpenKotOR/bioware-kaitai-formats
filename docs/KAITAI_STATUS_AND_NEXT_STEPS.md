# Kaitai Struct — repository status and next steps

_Last aligned with the working tree in 2026; treat [`docs/XOREOS_FORMAT_COVERAGE.md`](XOREOS_FORMAT_COVERAGE.md) as the live matrix for xoreos ↔ `.ksy` mapping._

## Current snapshot

### What this repo ships

- **`formats/**/*.ksy`** — **34** Kaitai specs (binary on-disk layouts only). Shared enums and structs live under [`formats/Common/`](../formats/Common/) (`bioware_common`, `bioware_gff_common`, `bioware_type_ids`, `bioware_mdl_common`, `bioware_ncs_common`, `tga_common`). Per-format folders (BIF, ERF, GFF, TPC, …) import those modules using **`meta.imports`** paths whose final segment is **`lower_snake_case`** (matches `include/ksy_schema.json` and KSC resolution on case-insensitive filesystems).
- **`src/<language>/kaitai_generated/`** — parsers emitted by **Kaitai Struct Compiler 0.11** (see [`.cursorrules`](../.cursorrules) §3). Regenerate after substantive `.ksy` edits via [`scripts/generate_code.ps1`](../scripts/generate_code.ps1) or targeted `kaitai-struct-compiler` invocations.
- **Documentation** — Cross-vendor coverage and proof links: [`docs/XOREOS_FORMAT_COVERAGE.md`](XOREOS_FORMAT_COVERAGE.md). Architecture overview: [`docs/kaitai_architecture.md`](kaitai_architecture.md).

### Compilation and CI-style checks

| Check | Command / location |
|--------|---------------------|
| **KSC smoke (Python target)** | `python -m pytest src/python/tests/test_kaitai_compile_smoke.py` — expects **every** `formats/**/*.ksy` to compile. |
| **xoreos `#L` anchors vs `master` file length** | `python scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges --also docs/XOREOS_FORMAT_COVERAGE.md` |
| **Optional URL HEAD probe** | `python scripts/verify_ksy_urls.py --verify …` (slow; some hosts block HEAD) |

### Policy (from project conventions)

- **Binary wire in `.ksy` only** — Do not model plaintext interchange (TXI, VIS, NSS, MDL ASCII, arbitrary XML/JSON/CSV payloads) in Kaitai unless the team explicitly expands scope. The tree retains **`formats/GFF/XML/GFF_XML.ksy`** where XML is still tracked; other plaintext siblings were removed per that policy.
- **Upstream citations** — Prefer `meta.xref` / `doc` URLs to **xoreos `master`** (and PyKotor / tooling) at stable line anchors; see §9 in [`XOREOS_FORMAT_COVERAGE.md`](XOREOS_FORMAT_COVERAGE.md).
- **Kaitai `meta.doc` hygiene** — Root `meta.doc` is embedded verbatim in generated parser docstrings. Keep it short and wire-focused; put pinned proof in `meta.xref`, optional “Further reading” in `doc-ref`, and long narrative in Markdown (not numbered bibliographies in `doc`). Full convention: [`AGENTS.md`](../AGENTS.md) (“Kaitai `meta.doc`, `doc-ref`, and `meta.xref`”). Concise example: [`formats/MDL/MDL.ksy`](../formats/MDL/MDL.ksy).

### Major structural facts

1. **GFF3 + GFF4 in one spec** — Standalone `GFF4.ksy` was **merged into** [`formats/GFF/GFF.ksy`](../formats/GFF/GFF.ksy) (`gff4_after_aurora` / `gff4_file`). [`formats/GDA/GDA.ksy`](../formats/GDA/GDA.ksy) imports the unified `gff` types.
2. **Kaitai generates readers, not writers** — Serializers and rich object models remain application concerns (e.g. PyKotor).

## Historical note

Older snapshots in git history described “57 `.ksy` files”, “31 failing XML generics”, and Windows import-path issues. **That era is closed for this branch:** the inventory is the **34** files under `formats/`, and the smoke test above is the source of truth for “compiles today”.

## Suggested next steps (engineering)

1. **GFF4 depth** — Field-declaration blocks, `data_offset` struct payloads, and V4.1 shared string heap (see gap notes in [`XOREOS_FORMAT_COVERAGE.md`](XOREOS_FORMAT_COVERAGE.md) §3 / appendix).
2. **Golden fixtures** — Add small binary samples under a dedicated `tests/fixtures/` (or documented external corpus) and parse them in language-specific tests beyond compile-only smoke.
3. **Multi-language regen** — After `.ksy` changes, run the repo’s batch generator so `src/{csharp,java,go,rust,…}/kaitai_generated` stays in sync; avoid hand-editing generated files except for emergencies (then re-run KSC).

## References

- [`AGENTS.md`](../AGENTS.md) — learned preferences (xref placement, common modules, Ghidra context).
- [Kaitai Struct user guide](https://doc.kaitai.io/user_guide.html) — expression language, enums (`to_i`), compiler version expectations.

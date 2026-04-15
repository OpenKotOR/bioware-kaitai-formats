# Xoreos format coverage vs this repository

This document maps **canonical upstream** [xoreos](https://github.com/xoreos/xoreos), [xoreos-tools](https://github.com/xoreos/xoreos-tools), and [xoreos-docs](https://github.com/xoreos/xoreos-docs) to the `.ksy` specs under [`formats/`](../formats/). It is written for **completion tracking** across BioWare engines that xoreos implements (Aurora / Odyssey / Eclipse branches inside xoreos, plus Neverwinter “Infinity-era” data where xoreos shares Aurora loaders).

> **Vendor vs upstream:** [`.gitmodules`](../.gitmodules) points `vendor/xoreos*` at forks (`th3w1zard1/xoreos*`). After `git submodule update --init --recursive`, line numbers in a fork may **diverge** from upstream `master`. For **audit work**, maintainers often keep optional shallow clones under [`_upstream/`](../_upstream/) (gitignored) tracking `github.com/xoreos/xoreos` at a known SHA. **GitHub URLs in this doc and in `meta.xref` fields default to upstream `xoreos/xoreos` on `master`**; pin URLs to a commit (for example `…/blob/89c99d2/…`) when you need citations that survive upstream edits.

## 0. Checkout status (`vendor/` vs `_upstream/`)

`vendor/xoreos`, `vendor/xoreos-tools`, and `vendor/xoreos-docs` are registered in [`.gitmodules`](../.gitmodules) but may be **missing** or **checked out with zero files** until `git submodule update --init --recursive` completes successfully (this workspace currently has **0 files** under each `vendor/xoreos*` path). Do line-anchor research against a populated tree: either a finished submodule checkout or a local mirror such as **`_upstream/xoreos`**. For CI or long-lived citations, prefer URLs pinned to a **commit SHA** on `github.com/xoreos/xoreos` (see §Pin at the end).

### 0.1 Terminology: Aurora, Odyssey, Eclipse, and “Infinity”

| Term | Meaning here (xoreos + this repo) |
|------|-----------------------------------|
| **Aurora** | Neverwinter Nights 1/2 lineage in xoreos: `GameID` **0** (`kGameIDNWN`), **1** (`kGameIDNWN2`). Shared containers (`KEY`/`BIF`/`ERF`), GFF3 templates, NWScript (`NCS`), PLT, etc. |
| **Odyssey** | KotOR / TSL: `GameID` **2** / **3**. Reuses many Aurora `FileType` values (same integers in archives) plus KotOR-specific types in the **`3000`…** block (`LYT`, `VIS`, `LIP`, `BWM`, `TPC`, `MDX`, …) and **`26000`** (`BZF`). |
| **Eclipse** | Dragon Age: Origins / DA2: `GameID` **7** / **8**. Adds **`22000`…** and **`25000`…** `FileType` ranges (`GDA`, `GFX`, `CIF`/GFF4, …). |
| **“Infinity”** | **Not** a target game line in xoreos: the project does **not** implement classic **Infinity Engine** titles (BG/IWD) as first-class engines. Upstream still names some *generic* `FileType` entries after legacy BioWare usage (e.g. **`kFileTypeMVE` = 2** “Infinity Engine” video in [`types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L59-L60)) — that is **enum heritage / shared ID space**, not a promise of IE archive compatibility. |

### 0.2 When `git submodule update` cannot see `vendor/xoreos*`

[`.gitmodules`](../.gitmodules) lists `vendor/xoreos`, `vendor/xoreos-docs`, and `vendor/xoreos-tools`, but some clones have **no submodule gitlinks in the git index** (`git ls-files vendor` is empty). In that state, `git submodule update --init vendor/xoreos` fails with **“pathspec did not match any file(s) known to git”** — Git literally has no submodule object at that path yet.

**Fix (maintainers):** register each path once (for example `git submodule add <url> vendor/xoreos` per upstream policy) **or** rely on a manual mirror under `_upstream/` for audits. Until then, treat **`vendor/xoreos*` as optional** and use **`docs/XOREOS_FORMAT_COVERAGE.md`** + GitHub `blob` URLs for citations.

### 0.3 Scoped “completion”: Aurora / Odyssey / Eclipse vs full upstream

Upstream xoreos also targets **Jade Empire**, **The Witcher**, **Sonic Chronicles (NDS)**, and other `GameID` values. If your goal is **BioWare Aurora + KotOR-line + Dragon Age** parity, treat these `GameID` integers (authoritative enum: [`types.h` L396–L408](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408)) as the **primary** `.ksy` backlog:

| Priority | `GameID` (int) | Engine label | Typical missing `.ksy` vs xoreos (see §3 / §5) |
|----------|----------------|----------------|--------------------------------------------------|
| P0 | **0**, **1** | NWN, NWN2 | `ZIP` (**20000**), `GR2` (**4003**), long tail `20001`…`20028` FaceFx / XML / walkmesh sidecars |
| P0 | **2**, **3** | KotOR, TSL | `TXB` / `TXB2` (**3006**, **3017**); optional audit `BWM` vs [`walkmeshloader.cpp`](https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp) |
| P0 | **7**, **8** | DA:O, DA2 | **`GFF.ksy`** (GFF4 branch + `gff4_file`), **`GDA.ksy`**, `GFX` (**22009**), `25000`… DA2 bucket (many entries are toolchain or opaque blobs in practice) |
| P1 | **4**, **5**, **6** | Jade, Witcher, Sonic | `thewitchersavefile`, full **21000**… NDS / HERF / Nitro stack — only if you explicitly widen scope |

**“Infinity”:** still means **shared `FileType` ID heritage** (see §0.1), not “ship every IE1 resource.”

### 0.4 Tracked `formats/**/*.ksy` ↔ xoreos (quick inventory)

Every row should have **`meta.xref`** entries pointing at **both** [`types.h` `FileType`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394) (when a primary wire ID exists) **and** the matching **reader** `*.cpp` line range. This table is the **at-a-glance** map; deep gaps stay in §3 / §5.

### 0.4a CI compile smoke vs this inventory

[`src/python/tests/test_kaitai_compile_smoke.py`](../src/python/tests/test_kaitai_compile_smoke.py) maintains a **curated** `EXPECTED_PASSES` list: it checks that `kaitai-struct-compiler` can emit Python for a **known-good** subset of `.ksy` files (fast regression guard). **Inclusion in §0.4 does not imply inclusion in smoke**, and vice versa — for example Eclipse saves (`DAS.ksy` / `DA2S.ksy`) are tracked here for coverage narrative but may be omitted from smoke until someone opts them into the harness. After substantive `.ksy` edits, extend smoke when the spec is meant to stay compiler-clean.

| `.ksy` | Primary games (`GameID`) | Main `FileType` int(s) | Primary xoreos implementation |
|--------|--------------------------|------------------------|------------------------------|
| [`bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy) | all | entire enum | [`types.h` L56–L394](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394), [`resman.cpp` L610–L612](https://github.com/xoreos/xoreos/blob/master/src/aurora/resman.cpp#L610-L612) |
| [`bioware_common.ksy`](../formats/Common/bioware_common.ksy) | all | N/A (structs) | [`aurorafile.cpp` L53–L75](https://github.com/xoreos/xoreos/blob/master/src/aurora/aurorafile.cpp#L53-L75) (`readHeader` overloads), [`locstring.cpp` L164–L176](https://github.com/xoreos/xoreos/blob/master/src/aurora/locstring.cpp#L164-L176) (`readLocString` — matches [`bioware_common.ksy`](../formats/Common/bioware_common.ksy) `meta.xref`) |
| [`bioware_gff_common.ksy`](../formats/Common/bioware_gff_common.ksy) | 0–3 (+ shared) | N/A (GFF field tags) | Shared with [`gff3file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp) / [`GFF.ksy`](../formats/GFF/GFF.ksy) |
| [`bioware_ncs_common.ksy`](../formats/Common/bioware_ncs_common.ksy) | 0–3 | N/A (NCS opcode tables) | [`nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp) with [`NCS.ksy`](../formats/NSS/NCS.ksy) |
| [`bioware_mdl_common.ksy`](../formats/Common/bioware_mdl_common.ksy) | 2–3 | N/A (MDL/MDX shared) | [`model_kotor.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp) with [`MDL.ksy`](../formats/MDL/MDL.ksy) / [`MDX.ksy`](../formats/MDL/MDX.ksy) |
| [`tga_common.ksy`](../formats/Common/tga_common.ksy) | 0–3 | N/A (pixel headers) | [`tga.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp) with [`TGA.ksy`](../formats/TPC/TGA.ksy) |
| [`KEY.ksy`](../formats/BIF/KEY.ksy) | 0–3, 7–8 (archives) | **9999** (+ neighbors in L206–L209) | [`keyfile.cpp` L50–L139](https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L139) |
| [`BIF.ksy`](../formats/BIF/BIF.ksy) | 0–3, 7–8 | **9998** | [`biffile.cpp` L54–L97](https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97) |
| [`BZF.ksy`](../formats/BIF/BZF.ksy) | 2–3 (iOS KotOR) | **26000** | [`bzffile.cpp` L55–L83](https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L55-L83) |
| [`ERF.ksy`](../formats/ERF/ERF.ksy) | 0–3, 7–8 | **9997** | [`erffile.cpp` `ERFFile::load` L281–L306](https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L281-L306), [`readERFHeader` L440–L503](https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L440-L503), [`readResources` L519–L560](https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L519-L560) (see `.ksy` `xref` for description / locstring) |
| [`RIM.ksy`](../formats/RIM/RIM.ksy) | 0–3 | **3002** | [`rimfile.cpp` L49–L91](https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L49-L91) |
| [`GFF.ksy`](../formats/GFF/GFF.ksy) | 0–3 GFF3; 6–8 GFF4 (+ templates) | **2037** + many `20xx` GFF templates; **22034** (`CIF`) + related `22xxx` / `25xxx` | **GFF3:** [`gff3file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp) — [`Header::read` L50–L63](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63), [`load` L97–L108](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L97-L108), [`loadHeader` L110–L181](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181), [`loadStructs` L183–L189](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L183-L189), [`loadLists` L191–L249](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L191-L249). **GFF4:** [`gff4file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp) — [`Header::read` L48–L72](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72), [`load` L151–L164](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164), [`loadHeader` L166–L187](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L166-L187), [`loadStructs` L189–L250](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L189-L250), [`loadStrings` L252–L267](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L252-L267) (see [`GFF.ksy`](../formats/GFF/GFF.ksy) `meta.xref`; full-stream helper `gff4_file` for GDA / other GFF4-only containers). |
| [`GDA.ksy`](../formats/GDA/GDA.ksy) | 7–8 | **22008** (`GDA`) | [`gdafile.cpp` L275–L305](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305) (GFF4 type `G2DA`); wire = [`gff::gff4_file` in `GFF.ksy`](../formats/GFF/GFF.ksy) |
| [`HERF.ksy`](../formats/HERF/HERF.ksy) | 6 (Sonic) | **21001** | [`herffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp) — [`load` L48–L67](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp#L48-L67), [`readDictionary` L88–L111](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp#L88-L111), [`readResList` L113–L142](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp#L113-L142) (matches [`HERF.ksy`](../formats/HERF/HERF.ksy) `meta.xref`) |
| [`TXB.ksy`](../formats/TPC/TXB.ksy) | 2–3 | **3006**, **3017** | [`txb.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp) — [`TXB::load` L48–L65](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L48-L65), [`readHeader` L81–L165](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L81-L165), [`readData` L178–L219](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L178-L219), [`readTXI` L221–L232](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L221-L232) (matches [`TXB.ksy`](../formats/TPC/TXB.ksy) `meta.xref`) |
| [`TLK.ksy`](../formats/TLK/TLK.ksy) | 0–3 binary; 7–8 also GFF4 | **2018** (binary vs [`talktable_gff.cpp` L78–L99](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_gff.cpp#L78-L99)) | [`talktable_tlk.cpp` L57–L92](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92) |
| [`TwoDA.ksy`](../formats/TwoDA/TwoDA.ksy) | 0–3 classic; 7–8 GDA | **2017**, **9996** (`1DA`); **22008** (`GDA`) | [`2dafile.cpp` L145–L196](https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L196), [`gdafile.cpp` L275–L305](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305) (matches [`GDA.ksy`](../formats/GDA/GDA.ksy) / [`GFF.ksy`](../formats/GFF/GFF.ksy) `gff4_file`) |
| [`SSF.ksy`](../formats/SSF/SSF.ksy) | 0–3 | **2060** | [`ssffile.cpp` `SSFFile::load` L72–L85](https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L72-L85), [`readSSFHeader` L87–L120](https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L87-L120) (matches [`SSF.ksy`](../formats/SSF/SSF.ksy) `meta.xref`) |
| [`LTR.ksy`](../formats/LTR/LTR.ksy) | 0–3 | **2036** | [`ltrfile.cpp` L135–L168](https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168) |
| [`WAV.ksy`](../formats/WAV/WAV.ksy) | 0–3 | **4** | [`wave.cpp` L38–L106](https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106), [`sound.cpp` `SoundManager::makeAudioStream` L256–L340](https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340) (RIFF/`data` + KotOR “modified WAVE” dispatch → `makeWAVStream`; matches [`WAV.ksy`](../formats/WAV/WAV.ksy) `meta.xref`) |
| [`NCS.ksy`](../formats/NSS/NCS.ksy) / [`NCS_minimal.ksy`](../formats/NSS/NCS_minimal.ksy) | 0–3 | **2010** | [`nwscript/ncsfile.cpp` L333–L355](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355) |
| [`TPC.ksy`](../formats/TPC/TPC.ksy) | 2–3, 0–1 | **3007** | [`tpc.cpp` L52–L66](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66) (`TPC::load`), [`L68–L252`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L68-L252) (`readHeader`; matches [`TPC.ksy`](../formats/TPC/TPC.ksy) `meta.xref`) |
| [`DDS.ksy`](../formats/TPC/DDS.ksy) | 0–3 | **2033** | [`dds.cpp` L55–L67](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67) (`DDS::load`), [`L141–L210`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210) (`readBioWareHeader`; matches [`DDS.ksy`](../formats/TPC/DDS.ksy) `meta.xref`) |
| [`TGA.ksy`](../formats/TPC/TGA.ksy) | 0–3 | **3** | [`tga.cpp` L75–L87](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L75-L87) (`TGA::load`), [`L89–L177`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177) (`readHeader`; matches [`TGA.ksy`](../formats/TPC/TGA.ksy) `meta.xref`) |
| [`MDL.ksy`](../formats/MDL/MDL.ksy) | 2–3 | **2002** | [`model_kotor.cpp` L184–L267](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267) (`Model_KotOR::load`; matches [`MDL.ksy`](../formats/MDL/MDL.ksy) / [`bioware_mdl_common.ksy`](../formats/Common/bioware_mdl_common.ksy) `meta.xref`) |
| [`MDX.ksy`](../formats/MDL/MDX.ksy) | 2–3 | **3008** | [`model_kotor.cpp` L885–L917](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L885-L917) (interleaved `ctx.mdx` vertex read loop; matches [`MDX.ksy`](../formats/MDL/MDX.ksy) `meta.xref`) |
| [`PLT.ksy`](../formats/PLT/PLT.ksy) | 0–1 (NWN) | **6** | [`pltfile.cpp` L102–L145](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145) (`PLTFile::load`; matches [`PLT.ksy`](../formats/PLT/PLT.ksy) `meta.xref`) |
| [`BWM.ksy`](../formats/BWM/BWM.ksy) | 2–3 | **3005** | [`walkmeshloader.cpp` L42–L113](https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113) |
| [`LIP.ksy`](../formats/LIP/LIP.ksy) | 2–3 | **3004** | *No `lipfile.cpp` in xoreos* — cite [`types.h` L180–L181](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180-L181); wire from PyKotor/reone |
| [`DAS.ksy`](../formats/DAS/DAS.ksy) / [`DA2S.ksy`](../formats/DA2S/DA2S.ksy) | **7** / **8** | N/A (not Aurora `FileType`) | *No upstream DAS/DA2S reader* — Eclipse saves; see `.ksy` `xref` + [`types.h` `GameID` L396–L408](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408) |
| [`PCC.ksy`](../formats/PCC/PCC.ksy) | Mass Effect | N/A in xoreos `FileType` | *No xoreos PCC reader* — Legendary Explorer ecosystem |

---

## 1. Authoritative enumerations (wire IDs)

### 1.1 `Aurora::FileType` (archive numeric type IDs)

**Source:** [`xoreos/xoreos` `src/aurora/types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h) — enum `FileType` runs **lines 56–394** on upstream `master` (closing `};` at 394; spot-check against pin `89c99d2` when auditing). The sentinel `kFileTypeMAXArchive` sits at **line 212** immediately after the `9996`–`9999` container pseudo-types.

**Mirrored in this repo:** [`formats/Common/bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy) enum `xoreos_file_type_id`, with `xref` keys `xoreos_types_file_type_enum`, `xoreos_types_file_type_comment`, etc., pointing at the same line ranges.

**How to read the numeric blocks in `types.h`:**

| Range (approx.) | Meaning |
|------------------|---------|
| `-1` … `13` | Generic / Infinity-adjacent base types (`RES`, `BMP`, `MVE`, `TGA`, `WAV`, …) |
| `2000` … `2078` | Core Aurora on-disk resource types (`MDL`, `TLK`, `GFF`, template `UTC`/`UTI`/…, `DDS`, …) |
| `3000` … `3028` | KotOR / Jade / Dragon Age–era **layout and model companion** types (`LYT`, `VIS`, `LIP`, `BWM`, `TPC`, `MDX`, …) — **still numeric `FileType` values** even when the payload is not a “classic” GFF |
| `4000` … `4008` | NWN2-era extensions (`GR2`, …) |
| `9996` … `9999` | Pseudo-types for **containers** (`1DA`, `ERF`, `BIF`, `KEY`) |
| `19000` … | Files **not** normally stored with numeric IDs in archives; game-specific overlays and toolchains |
| `21000` … | **Sonic Chronicles / Nintendo DS** family |
| `22000` … | **Dragon Age: Origins** (Eclipse) family |
| `23000` … | **KotOR Mac** port extras |
| `24000` … | **Jade Empire** |
| `25000` … | **Dragon Age II** |
| `26000` … | **KotOR** `BZF` compressed BIF |
| `27000` … | **The Witcher** |
| `28000` … | **Jade Empire Android** JSON / text TLK variants |
| `29000` … | **Jade Empire Xbox** audio containers |
| `30000` … | **Dragon Age: Origins Xbox** texture |

When a game **reuses** a type ID for a different physical layout, xoreos resolves conflicts with `ResourceManager::addTypeAlias()` (described in the `FileType` block comment in `types.h` lines **34–55**).

### 1.2 `Aurora::GameID`

**Source:** same file, **lines 396–408** — `enum GameID` (integer values **-1** through **8** for `kGameIDUnknown` … `kGameIDDragonAge2`, plus `kGameIDMAX`).

| `GameID` constant | Integer | Typical games / engines in xoreos |
|---------------------|--------:|-----------------------------------|
| `kGameIDUnknown` | -1 | — |
| `kGameIDNWN` | 0 | Neverwinter Nights (Aurora) |
| `kGameIDNWN2` | 1 | Neverwinter Nights 2 |
| `kGameIDKotOR` | 2 | KotOR (Odyssey) |
| `kGameIDKotOR2` | 3 | TSL |
| `kGameIDJade` | 4 | Jade Empire |
| `kGameIDWitcher` | 5 | The Witcher |
| `kGameIDSonic` | 6 | Sonic Chronicles (NDS / hashed archives) |
| `kGameIDDragonAge` | 7 | Dragon Age: Origins (Eclipse) |
| `kGameIDDragonAge2` | 8 | Dragon Age II |

Use this when documentation asks **which engine build** owns a parser path under `src/engines/*`.

### 1.3 `Aurora::ArchiveType`

**Source:** same file, **lines 419–430** — `enum ArchiveType` (`KEY` = 0, then `BIF`, `ERF`, `RIM`, `ZIP`, `EXE`, `NDS`, `HERF`, `NSBTX`, `kArchiveMAX`).

This lines up with container `.ksy` files here (`KEY`, `BIF`, `BZF`, `ERF`, `RIM`, …).

### 1.4 `Aurora::ResourceType` (high-level engine classification)

**Source:** same file, **lines 410–417** — `enum ResourceType` (`kResourceImage` … `kResourceMAX`). This is **not** the same as numeric `FileType` IDs in KEY/BIF/ERF tables; it classifies resources for the engine’s resource manager at a coarser level.

### 1.5 `ResourceManager::addTypeAlias` (runtime ID overlays)

When two games assign different layouts to the same numeric `FileType`, xoreos registers an overlay at startup: [`ResourceManager::addTypeAlias`](https://github.com/xoreos/xoreos/blob/master/src/aurora/resman.cpp#L610-L612) (`resman.cpp` **L610–L612**). Game-specific registration lives under `src/engines/*/…` (search `addTypeAlias` there). **`.ksy` wire specs** should document the **on-disk** layout for the title you care about; use this hook to explain why the same integer can mean different parsers at runtime.

---

## 2. Where xoreos parses each format (runtime vs tools)

| Layer | Repository path | Role |
|-------|-----------------|------|
| **Runtime readers** | [`xoreos/src/aurora/*.cpp`](https://github.com/xoreos/xoreos/tree/master/src/aurora) | In-game loading (`*file.cpp` pattern) |
| **Graphics** | [`xoreos/src/graphics/images/*.cpp`](https://github.com/xoreos/xoreos/tree/master/src/graphics/images) | `tpc.cpp`, `tga.cpp`, `dds.cpp`, `txi.cpp`, … |
| **Per-game engines** | [`xoreos/src/engines/*`](https://github.com/xoreos/xoreos/tree/master/src/engines) | `kotor`, `odyssey`, `nwn`, `dragonage`, `eclipse`, … |
| **CLI / converters** | [`xoreos-tools/src/aurora/*.cpp`](https://github.com/xoreos/xoreos-tools/tree/master/src/aurora) | Same format names plus `*writer.cpp` |

`xoreos-tools` adds writers (`bifwriter`, `erfwriter`, `gff3writer`, …) that **do not** always have a matching `.ksy` in this repo (we generally model **on-disk wire** layouts, not every tool emission path).

### 2.1 Wire reuse cheat-sheet (same `FileType` integer, different games)

| `FileType` (examples) | Integer | Reuse pattern |
|------------------------|--------:|---------------|
| `RES`, `BMP`, `TGA`, `WAV`, … | `0`–`13` | **Aurora-wide** primitives; all listed games may reference them from archives or loose files. |
| `MDL`, `TLK`, `GFF`, `UTC`, `UTI`, `DLG`, `2DA`, … | `2000`–`2078` (see `types.h`) | **Shared Aurora core**; Odyssey and NWN both use GFF3-shaped templates for many extensions. Eclipse may still use **some** IDs while payload becomes **GFF4** or **GDA** — treat DA rows in the matrix as **parser path**, not “same bytes as NWN”. |
| `LYT`, `VIS`, `RIM`, `LIP`, `BWM`, `TXB`, `TPC`, `MDX`, … | `3000`–`3028` | **Primarily Odyssey / Jade-era** extensions; not central to DA/Eclipse the same way. |
| `ERF`, `BIF`, `KEY`, `1DA` | `9997`–`9999`, `9996` | **Container pseudo-types** in `types.h`; actual archives are modeled by [`KEY.ksy`](../formats/BIF/KEY.ksy) / [`BIF.ksy`](../formats/BIF/BIF.ksy) / [`ERF.ksy`](../formats/ERF/ERF.ksy) / [`RIM.ksy`](../formats/RIM/RIM.ksy). |
| `BZF` | `26000` | **KotOR iOS** compressed BIF (`bzffile.cpp`); not used on desktop NWN. |
| `GDA`, `GFX`, `CIF`, … | `22000`+ / `25000`+ blocks | **Eclipse / DA2** extensions; see comments in [`types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L282-L365). |
| `ZIP`, `FXM`, `FXS`, `XML`, `WLK`, … | `20000`–`20028` (see [`types.h` L222–L251](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L222-L251)) | **NWN2-era** “non-archive numeric ID” bucket: often **FaceFX + ZIP** packaging and effect/walkmesh sidecars — xoreos loads **`ZIP`** via [`common/zipfile.cpp#L46-L119`](https://github.com/xoreos/xoreos/blob/master/src/common/zipfile.cpp#L46-L119); most siblings still lack dedicated `.ksy` specs here. |
| `FXR`, `FXT` | both **22033** in [`types.h#L316-L317`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L316-L317) | **DA / Eclipse** FaceFX metadata — upstream assigns the **same integer** to two enum names; treat as **one wire bucket** unless a title proves two layouts. |

### 2.2 `xoreos-tools` beyond `src/aurora/` (parity with runtime)

The game engine lives in `xoreos`, but **authoritative read/write order** for several formats is duplicated or extended under [xoreos-tools](https://github.com/xoreos/xoreos-tools). When adding `.ksy` specs, diff **both** trees (many parsers are intentionally mirrored).

| Path | Role | Typical `GameID` / game | Our `.ksy` |
|------|------|-------------------------|------------|
| [`src/aurora/*.cpp`](https://github.com/xoreos/xoreos-tools/tree/master/src/aurora) | Same names as runtime plus **writers** (`*writer.cpp`) | all | Same rows as §3 |
| [`src/xml/gffdumper.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp) ([`L36–L176`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176); cited from [`GFF.ksy`](../formats/GFF/GFF.ksy)) / [`gff3dumper.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gff3dumper.cpp) / [`gff4dumper.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gff4dumper.cpp) | GFF3/GFF4 XML dump (field iteration order) | NWN + DA | Informs **GFF** vs **GFF4** field trees |
| [`src/xml/gff3creator.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gff3creator.cpp) | GFF3 XML → binary | tools | N/A on-disk consumer |
| [`src/nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp) | NCS structural reads / disasm | NWN / KotOR | [`NCS.ksy`](../formats/NSS/NCS.ksy) — align with runtime [`nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp) |
| [`src/images/txb.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/txb.cpp) | TXB / TXB2 | Odyssey (`3006`, `3017`) | [`TXB.ksy`](../formats/TPC/TXB.ksy) (runtime [`txb.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp) — same line anchors as [`TXB.ksy`](../formats/TPC/TXB.ksy) `meta.xref` on `master`) |
| [`src/images/cdpth.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/cdpth.cpp) | CDPTH export | Sonic | *missing* |
| [`src/images/nbfs.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/nbfs.cpp) / [`ncgr.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/ncgr.cpp) / [`nclr.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/images/nclr.cpp) | Nitro image helpers | Sonic | *missing* — runtime [`nbfs.cpp#L46-L66`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/nbfs.cpp#L46-L66) (`NBFS::load`), [`ncgr.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/ncgr.cpp), [`nclr.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/nclr.cpp) |
| [`src/archives/files_sonic.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/archives/files_sonic.cpp) | Sonic hashed file glue | Sonic | *missing* — pairs with `HERF` / `NDS` |
| [`src/unnds.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/unnds.cpp) / [`unnsbtx.cpp`](https://github.com/xoreos/xoreos-tools/blob/master/src/unnsbtx.cpp) | CLI unpackers | Sonic | N/A |

---

## 3. Coverage matrix (xoreos `src/aurora` ↔ this repo)

**Legend:** ✅ has `.ksy` · ⚠ partial / needs alignment audit · ❌ missing · N/A non-target (non-BioWare or text-first)

| xoreos reader (`src/aurora`) | Typical `FileType` / notes | Odyssey / KotOR | NWN / Infinity | DA / Eclipse | Other xoreos engines | Our `.ksy` |
|-----------------------------|-----------------------------|-----------------|----------------|--------------|------------------------|-----------|
| `2dafile` | `kFileType2DA` (2017), `kFileType1DA` (9996) | ✅ shared | ✅ | ✅ GDA variant uses `gdafile` | — | [`TwoDA.ksy`](../formats/TwoDA/TwoDA.ksy) |
| `gdafile` / `gdaheaders` | `kFileTypeGDA` (22008) | ❌ | ❌ | ✅ | — | ✅ [`GDA.ksy`](../formats/GDA/GDA.ksy) — GFF4 `G2DA` shell ([`gdafile.cpp` L275–L305](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305)) |
| `gff3file` | `kFileTypeGFF` + template types | ✅ | ✅ | ⚠ DA uses GFF4 for some payloads | Witcher | [`GFF.ksy`](../formats/GFF/GFF.ksy) — `Header::read` [`gff3file.cpp#L50-L63`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63), orchestration [`L97-L108`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L97-L108), `loadHeader` [`L110-L181`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181) |
| `gff4file` | `kFileTypeCIF` (22034) etc. | ❌ | ❌ | ✅ | — | ⚠ [`GFF.ksy`](../formats/GFF/GFF.ksy) (`gff4_after_aurora` / `gff4_file`) — `Header::read` through `loadStrings` on [`gff4file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp) (see [`GFF.ksy`](../formats/GFF/GFF.ksy) `meta.xref`); field graphs / generics still engine-driven |
| `talktable` + `talktable_tlk` + `talktable_gff` | `kFileTypeTLK` (**2018**) | ✅ | ✅ | ✅ (GFF4 path) | — | **Binary** TLK: [`TLK.ksy`](../formats/TLK/TLK.ksy) + [`talktable_tlk.cpp#L57-L92`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92). **GFF4-wrapped** TLK: [`talktable_gff.cpp#L78-L99`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_gff.cpp#L78-L99) — use [`GFF.ksy`](../formats/GFF/GFF.ksy) `gff4_file` for wire prefix; full string graph still partial |
| `biffile` / `bzffile` | `kFileTypeBIF` / `BZF` | ✅ | ✅ | ⚠ | — | [`BIF.ksy`](../formats/BIF/BIF.ksy), [`BZF.ksy`](../formats/BIF/BZF.ksy) |
| `keyfile` | `kFileTypeKEY` | ✅ | ✅ | ⚠ | — | [`KEY.ksy`](../formats/BIF/KEY.ksy) |
| `aurorafile` | 4-byte ID + 4-byte version (+ UTF-16 heuristic) | ✅ | ✅ | ✅ | ✅ | **Shared prefix** for TLK/SSF/GFF/… — [`aurorafile.cpp#L53-L70`](https://github.com/xoreos/xoreos/blob/master/src/aurora/aurorafile.cpp#L53-L70) (`AuroraFile::readHeader`) |
| `locstring` | CExoLocString / `LocString` blob | ✅ | ✅ | ✅ | ✅ | Embedded in **ERF** localized strings and **GFF** fields — wire layout in [`bioware_common.ksy`](../formats/Common/bioware_common.ksy); xoreos reader [`locstring.cpp#L164-L176`](https://github.com/xoreos/xoreos/blob/master/src/aurora/locstring.cpp#L164-L176) (`readLocString` overloads) |
| `erffile` | `kFileTypeERF` / `MOD` / … | ✅ | ✅ | ✅ | — | [`ERF.ksy`](../formats/ERF/ERF.ksy) |
| `rimfile` | `kFileTypeRIM` | ✅ | ✅ | — | — | [`RIM.ksy`](../formats/RIM/RIM.ksy) |
| `herffile` | `kFileTypeHERF` (**21001**); pairs with **`DICT` (21002)** + **`SMALL` (21003)** | ❌ | ❌ | ❌ | Sonic / hashed ERF | ⚠ [`HERF.ksy`](../formats/HERF/HERF.ksy) — `load` + `readDictionary` + `readResList` ([`herffile.cpp` L48–L142](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp#L48-L142)); **`DICT` / `SMALL`** payloads still separate |
| `ssffile` | `kFileTypeSSF` | ✅ | ✅ | — | — | [`SSF.ksy`](../formats/SSF/SSF.ksy) |
| `ltrfile` | `kFileTypeLTR` | ✅ | ✅ | — | — | [`LTR.ksy`](../formats/LTR/LTR.ksy) |
| `dlgfile` | `kFileTypeDLG` (**2029**) | ✅ GFF payload | ✅ | — | — | Covered by [`GFF.ksy`](../formats/GFF/GFF.ksy); xoreos semantic load [`dlgfile.cpp#L169-L202`](https://github.com/xoreos/xoreos/blob/master/src/aurora/dlgfile.cpp#L169-L202) |
| `ifofile` / `nfofile` | `IFO` / `NFO` | ✅ | ✅ | — | — | GFF3-backed: [`ifofile.cpp#L101-L227`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ifofile.cpp#L101-L227), [`nfofile.cpp#L72-L83`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nfofile.cpp#L72-L83) |
| `lytfile` / `visfile` | `LYT` (3000), `VIS` (3001) | ✅ **text** | ✅ **text** | — | — | **Removed** `.ksy` (plaintext); xoreos text parsers: [`lytfile.cpp#L56-L200`](https://github.com/xoreos/xoreos/blob/master/src/aurora/lytfile.cpp#L56-L200) (`LYTFile::load`), [`visfile.cpp#L45-L115`](https://github.com/xoreos/xoreos/blob/master/src/aurora/visfile.cpp#L45-L115) (`VISFile::load`) |
| `rim` / `erf` writers | — | tools | tools | tools | — | N/A `.ksy` |
| `zipfile` | `kFileTypeZIP` (**20000**) | ❌ | ✅ NWN2 | — | — | *optional `ZIP.ksy`* — Aurora indexes parsed files ([`src/aurora/zipfile.cpp#L58-L69`](https://github.com/xoreos/xoreos/blob/master/src/aurora/zipfile.cpp#L58-L69)); PKZIP central-directory walk is [`src/common/zipfile.cpp#L46-L119`](https://github.com/xoreos/xoreos/blob/master/src/common/zipfile.cpp#L46-L119) (`ZipFile::load`) |
| `pefile` | `kFileTypeEXE` (**19000**) | ❌ | ✅ | — | — | optional PE-as-archive — resource enumeration [`pefile.cpp#L134-L173`](https://github.com/xoreos/xoreos/blob/master/src/aurora/pefile.cpp#L134-L173) |
| `ndsrom` | `kFileTypeNDS` (**21000**) | ❌ | ❌ | ❌ | Sonic / NDS | ❌ *no `.ksy`* — [`ndsrom.cpp#L56-L77`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ndsrom.cpp#L56-L77) (`NDSFile::load`) |
| `nitrofile` | Nitro BOM wrapper | ❌ | ❌ | ❌ | Sonic / NDS | ❌ *no `.ksy`* — [`nitrofile.cpp#L53-L71`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nitrofile.cpp#L53-L71) (`NitroFile::open`) |
| `nsbtxfile` | `kFileTypeNSBTX` (**21019**) + `kArchiveNSBTX` | ❌ | ❌ | ❌ | Sonic / NDS | ❌ *no `.ksy`* — [`nsbtxfile.cpp#L343-L356`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nsbtxfile.cpp#L343-L356) (`NSBTXFile::load`) |
| `smallfile` | `kFileTypeSMALL` (**21003**) | ❌ | ❌ | ❌ | Sonic / NDS | ❌ *no `.ksy`* — [`smallfile.cpp#L258-L269`](https://github.com/xoreos/xoreos/blob/master/src/aurora/smallfile.cpp#L258-L269) (`Small::decompress` Read/Write) |
| `cdpth` | `kFileTypeCDPTH` (**21005**) | ❌ | ❌ | ❌ | Sonic | ❌ *no `.ksy`* — public entry [`cdpth.cpp#L81-L86`](https://github.com/xoreos/xoreos/blob/master/src/aurora/cdpth.cpp#L81-L86) (`CDPTH::load`); cell table + LZSS via `Small::decompress` [`L94-L132`](https://github.com/xoreos/xoreos/blob/master/src/aurora/cdpth.cpp#L94-L132) (`readCells`) |
| `gfxfile` + `actionscript/*` | `kFileTypeGFX` (**22009**) | ❌ | ❌ | ✅ DA Scaleform | — | ❌ *no `.ksy`* — [`gfxfile.cpp#L224-L322`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gfxfile.cpp#L224-L322) (`GFXFile::load`: magic + zlib payload + tag dispatch); VM under [`src/aurora/actionscript/`](https://github.com/xoreos/xoreos/tree/master/src/aurora/actionscript) |
| `lua/*` | script runtime | ⚠ | ⚠ | ⚠ | Witcher / others | N/A wire `.ksy` (embedded LUA / bytecode paths are engine-specific) |
| `xmlfixer` | XML repair utilities | tools | tools | tools | — | N/A on-disk game resource |
| `thewitchersavefile` | `kFileTypeTheWitcherSave` | ❌ | ❌ | ❌ | Witcher | *game-specific save* — separate from DAS/DA2S here |
| `gr2file` | `kFileTypeGR2` (**4003**) | ❌ | ✅ NWN2 | — | — | *add `GR2.ksy` or document “external Granny”* — [`gr2file.cpp#L75-L231`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gr2file.cpp#L75-L231) (`GR2File::load`) |
| `textureatlasfile` | engine-specific | ⚠ | ⚠ | ⚠ | — | investigate vs `TPC`/`DDS` |
| `sacfile` | unknown SAC | ❓ | ❓ | ❓ | — | low priority; read header in `sacfile.cpp` before `.ksy` |
| `obbfile` | Android OBB | ❌ | ❌ | ❌ | Android ports | N/A core Odyssey |

### 3a. Other `src/aurora/*.cpp` top-level units (quick index)

| Unit | Role | `.ksy` / action |
|------|------|------------------|
| `archive.cpp` | Abstract archive / resource list plumbing | N/A standalone; informs KEY/BIF/ERF/RIM |
| `2dareg.cpp` | TwoDA registry / lookup helpers | N/A wire format |
| `resman.cpp` | Resource index + **`addTypeAlias`** [`L610-L612`](https://github.com/xoreos/xoreos/blob/master/src/aurora/resman.cpp#L610-L612) | Cited from [`bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy) |
| `talkman.cpp` | Talk table manager (dispatches TLK/GFF) | Overlaps [`talktable.cpp#L46-L67`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L46-L67) |
| `language.cpp` / `util.cpp` | Language codes / helpers | N/A resource file |
| `oodle.cpp` | Oodle compression hooks | Port-specific; no `.ksy` |
| `textureatlasfile.cpp` | Texture atlas container | ⚠ compare to [`TPC.ksy`](../formats/TPC/TPC.ksy) / DDS paths |
| `thewitchersavefile.cpp` | Witcher save container | ❌ no `.ksy` (different stack from DAS/DA2S) |
| `sacfile.cpp` | SAC archive probe | ❓ low priority |
| `xmlfixer.cpp` | XML repair for tools | N/A in-game binary |

### 3b. `formats/**/*.ksy` ↔ primary xoreos implementation (quick map)

Use this when deciding **which `*.cpp` to diff** after changing a `.ksy`. Line-level `meta.xref` keys live on each file where we have started anchors; expand any row that still only lists a tree URL.

| Our spec | Primary xoreos reader(s) | Notes |
|----------|----------------------------|--------|
| [`GFF.ksy`](../formats/GFF/GFF.ksy) | [`gff3file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp), [`gff4file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp) | **GFF3** arenas + resolved views; **GFF4** `gff_union_file` / `gff4_after_aurora` / full-stream `gff4_file`. Template semantics also: [`dlgfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/dlgfile.cpp), [`ifofile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ifofile.cpp), [`talktable_gff.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_gff.cpp) (GFF4 TLK) |
| [`GDA.ksy`](../formats/GDA/GDA.ksy) | [`gdafile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp) | Imports `gff::gff4_file`; enforces `G2DA` + `V0.1`/`V0.2` at runtime in xoreos |
| [`HERF.ksy`](../formats/HERF/HERF.ksy) | [`herffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp) | Sonic hashed ERF index + dictionary discovery |
| [`TXB.ksy`](../formats/TPC/TXB.ksy) | [`txb.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp) | KotOR-family TXB / TXB2 header strip |
| [`bioware_gff_common.ksy`](../formats/Common/bioware_gff_common.ksy) | (shared with `gff3file.cpp`) | Canonical GFF3 field-type tags consumed by [`GFF.ksy`](../formats/GFF/GFF.ksy) |
| [`bioware_ncs_common.ksy`](../formats/Common/bioware_ncs_common.ksy) | [`nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp) | Opcode / type tables for [`NCS.ksy`](../formats/NSS/NCS.ksy) |
| [`bioware_mdl_common.ksy`](../formats/Common/bioware_mdl_common.ksy) | [`model_kotor.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp) | Shared MDL/MDX enums and chunks |
| [`tga_common.ksy`](../formats/Common/tga_common.ksy) | [`tga.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp) | Shared TGA header pieces for [`TGA.ksy`](../formats/TPC/TGA.ksy) |
| [`TLK.ksy`](../formats/TLK/TLK.ksy) | [`talktable_tlk.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp), [`talktable.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp) | Binary TLK only; Eclipse GFF4 TLK → **`GFF.ksy`** (`gff4_file`) |
| [`TwoDA.ksy`](../formats/TwoDA/TwoDA.ksy) | [`2dafile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp) | Dragon Age tables → [`gdafile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp) (`kFileTypeGDA` **22008**) |
| [`KEY.ksy`](../formats/BIF/KEY.ksy) / [`BIF.ksy`](../formats/BIF/BIF.ksy) / [`BZF.ksy`](../formats/BIF/BZF.ksy) | [`keyfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp), [`biffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp), [`bzffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp) | `BZF` = **`26000`** |
| [`ERF.ksy`](../formats/ERF/ERF.ksy) / [`RIM.ksy`](../formats/RIM/RIM.ksy) | [`erffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp), [`rimfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp) | `LocString` description: [`locstring.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/locstring.cpp) |
| [`SSF.ksy`](../formats/SSF/SSF.ksy) / [`LTR.ksy`](../formats/LTR/LTR.ksy) | [`ssffile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp), [`ltrfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp) | `kFileTypeSSF` **2060**, `kFileTypeLTR` **2036** |
| [`WAV.ksy`](../formats/WAV/WAV.ksy) | [`sound/sound.cpp`](https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp), [`sound/decoders/wave.cpp`](https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp) | `kFileTypeWAV` **4** |
| [`NCS.ksy`](../formats/NSS/NCS.ksy) / [`NCS_minimal.ksy`](../formats/NSS/NCS_minimal.ksy) | [`aurora/nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp) | `kFileTypeNCS` **2010** |
| [`TPC.ksy`](../formats/TPC/TPC.ksy) / [`DDS.ksy`](../formats/TPC/DDS.ksy) / [`TGA.ksy`](../formats/TPC/TGA.ksy) | [`graphics/images/tpc.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp), [`dds.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp), [`tga.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp) | `TPC` **3007**, `DDS` **2033**, `TGA` **3** |
| [`MDL.ksy`](../formats/MDL/MDL.ksy) / [`MDX.ksy`](../formats/MDL/MDX.ksy) | [`graphics/aurora/model_kotor.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp) | `kFileTypeMDL` **2002**, `kFileTypeMDX` **3008** |
| [`BWM.ksy`](../formats/BWM/BWM.ksy) | [`engines/kotorbase/path/walkmeshloader.cpp`](https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp) | `kFileTypeBWM` **3005** |
| [`PLT.ksy`](../formats/PLT/PLT.ksy) | [`graphics/aurora/pltfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp) | `kFileTypePLT` **6** (NWN-centric) |
| [`LIP.ksy`](../formats/LIP/LIP.ksy) | *(no `lipfile.cpp`)* | `kFileTypeLIP` **3004** — cite [`types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180-L181); wire from PyKotor/reone |
| [`PCC.ksy`](../formats/PCC/PCC.ksy) | *(none in xoreos)* | Mass Effect / Unreal package — **outside** upstream `FileType` table |
| [`DAS.ksy`](../formats/DAS/DAS.ksy) / [`DA2S.ksy`](../formats/DA2S/DA2S.ksy) | *(no upstream DAS reader)* | Eclipse saves — `GameID` **7** / **8** only (see `.ksy` `xref`) |
| [`bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy) / [`bioware_common.ksy`](../formats/Common/bioware_common.ksy) | [`types.h`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h), [`aurorafile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/aurorafile.cpp), [`locstring.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/locstring.cpp) | Shared enums / locstring wire |

**URL hygiene:** run `python scripts/verify_ksy_urls.py` on [`formats/`](../formats/) (see [`scripts/verify_ksy_urls.py`](../scripts/verify_ksy_urls.py)); use `--verify` sparingly (GitHub rate limits / HEAD quirks).

**Graphics** ([`src/graphics/images`](https://github.com/xoreos/xoreos/tree/master/src/graphics/images)):

| Reader | `FileType` | Our `.ksy` |
|--------|------------|------------|
| `tpc.cpp` | `TPC` (3007), related | [`TPC.ksy`](../formats/TPC/TPC.ksy) |
| `dds.cpp` | `DDS` (2033) | [`DDS.ksy`](../formats/TPC/DDS.ksy) |
| `tga.cpp` | `TGA` (3) | [`TGA.ksy`](../formats/TPC/TGA.ksy) |
| `txi.cpp` | `TXI` (2022) | **text** — no `.ksy` (removed); wire reference: [`txi.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txi.cpp) |
| `txb.cpp` | `TXB` / `TXB2` (`3006`, `3017`) | ⚠ [`TXB.ksy`](../formats/TPC/TXB.ksy) — [`readHeader` L81–L165](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L81-L165) + mip/TXI tail [`readData` L178–L219](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L178-L219), [`readTXI` L221–L232](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L221-L232) (matches [`TXB.ksy`](../formats/TPC/TXB.ksy) `meta.xref`) |
| `nbfs` / `ncgr` / `nclr` … | Nitro | N/A |

---

## 4. `xoreos-docs` (human specs)

Tree (top level): [`xoreos-docs/specs`](https://github.com/xoreos/xoreos-docs/tree/master/specs)

| Path | Contents | Use for |
|------|----------|---------|
| [`specs/bioware/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware) | Collected BioWare text specs | Cross-check GFF / field semantics |
| [`specs/torlack/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/torlack) | Torlack HTML (ITP, …) | Already referenced from [`GFF.ksy`](../formats/GFF/GFF.ksy) |
| [`specs/kotor_mdl.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html) | KotOR MDL notes | [`MDL.ksy`](../formats/MDL/MDL.ksy) / [`MDX.ksy`](../formats/MDL/MDX.ksy) doc sections |
| [`specs/nds/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/nds) | Nintendo DS | Sonic only |
| [`specs/trn/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/trn) | TRN terrain | NWN2 |
| [`specs/foxpro/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/foxpro) | FoxPro / xBase notes | NWN `DBF`/`CDX`/`FPT` (`kFileTypeDBF` **19001**, …) — see [`pefile.cpp` / `types.h` non-archive block](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L216-L220) |

### 4.1 `specs/` file inventory (this `_upstream` snapshot)

Use these as **human** cross-checks; wire order remains **`*.cpp` in xoreos**.

| Document | Games / scope | Relates to our `.ksy` |
|----------|---------------|------------------------|
| [`specs/bioware/GFF_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf) | Aurora GFF3 | [`GFF.ksy`](../formats/GFF/GFF.ksy) |
| [`specs/bioware/CommonGFFStructs.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf) | shared structs | `GFF.ksy` |
| [`specs/bioware/ERF_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf) / [`KeyBIF_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf) | NWN family | [`ERF.ksy`](../formats/ERF/ERF.ksy), [`KEY.ksy`](../formats/BIF/KEY.ksy), [`BIF.ksy`](../formats/BIF/BIF.ksy) |
| [`specs/bioware/2DA_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf) | classic `.2da` | [`TwoDA.ksy`](../formats/TwoDA/TwoDA.ksy) |
| [`specs/bioware/TalkTable_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf) | binary TLK | [`TLK.ksy`](../formats/TLK/TLK.ksy) |
| [`specs/bioware/SSF_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/SSF_Format.pdf) | SSF | [`SSF.ksy`](../formats/SSF/SSF.ksy) |
| [`specs/bioware/Conversation_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/Conversation_Format.pdf) / [`IFO_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/IFO_Format.pdf) | DLG / IFO semantics | `GFF.ksy` + [`dlgfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/dlgfile.cpp) / [`ifofile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ifofile.cpp) |
| [`specs/torlack/itp.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html) / [`plt.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html) | palette / ITP | [`PLT.ksy`](../formats/PLT/PLT.ksy), Torlack ITP (text / removed `.ksy`) |
| [`specs/torlack/ncs.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html) | NWScript bytecode | [`NCS.ksy`](../formats/NSS/NCS.ksy) |
| [`specs/kotor_mdl.html`](https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html) | KotOR MDL | [`MDL.ksy`](../formats/MDL/MDL.ksy), [`MDX.ksy`](../formats/MDL/MDX.ksy) |
| [`specs/trn/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/trn) | NWN2 terrain / ASWM | NWN2 only — no dedicated `.ksy` here yet |
| [`specs/nds/`](https://github.com/xoreos/xoreos-docs/tree/master/specs/nds) | Nintendo DS | `kGameIDSonic` (**6**) — pairs with §3 `ndsrom` / Nitro rows |

---

## 5. Recommended new `.ksy` files (priority order)

High value for **“xoreos parity”** on modern BioWare stacks:

1. **`GFF.ksy` (GFF4 branch)** — **Merged** (standalone `GFF4.ksy` removed): Aurora 8-byte prefix + GFF4 `Header::read` + contiguous struct-template strip live in [`GFF.ksy`](../formats/GFF/GFF.ksy) as `gff4_after_aurora` / `gff4_file` (see [`gff4file.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp) + `meta.xref` on [`GFF.ksy`](../formats/GFF/GFF.ksy)). **Remaining gap:** field-declaration blocks (non-sequential seeks), `GFF4Struct` payload at `data_offset`, V4.1 shared string heap — extend or keep engine-deferred.
2. **`GDA.ksy`** — **Added** ([`formats/GDA/GDA.ksy`](../formats/GDA/GDA.ksy)): documents GFF4 shell with type `G2DA` + [`gdafile.cpp` L275–L305](https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305); body reuses `gff::gff4_file` from [`GFF.ksy`](../formats/GFF/GFF.ksy).
3. **`HERF.ksy`** — **Added** ([`formats/HERF/HERF.ksy`](../formats/HERF/HERF.ksy)): magic + `(hash,size,offset)` table ([`herffile.cpp` L48–L142](https://github.com/xoreos/xoreos/blob/master/src/aurora/herffile.cpp#L48-L142) spans `load` + `readDictionary` + `readResList`). **Remaining gap:** embedded `erf.dict` / `DICT` / `SMALL` decompression.
4. **`TXB.ksy`** — **Added** ([`formats/TPC/TXB.ksy`](../formats/TPC/TXB.ksy)): `readHeader` 128-byte block + mip/TXI tail ([`readHeader` L81–L165](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L81-L165), [`readData` L178–L219](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L178-L219), [`readTXI` L221–L232](https://github.com/xoreos/xoreos/blob/master/src/graphics/images/txb.cpp#L221-L232); matches [`TXB.ksy`](../formats/TPC/TXB.ksy) `meta.xref`). **Remaining gap:** per-mip byte sizing / swizzle (decode in app code).
5. **`BWM.ksy` (audit)** — **Done (doc pass):** [`BWM.ksy`](../formats/BWM/BWM.ksy) `data_table_offsets` doc now notes `walkmeshloader.cpp` vs PyKotor-style perimeter split (**TODO: VERIFY** on real meshes).

**Sonic / NDS completeness (only if you expand scope beyond KotOR):** `NDS` ROM shell ([`ndsrom.cpp#L56-L77`](https://github.com/xoreos/xoreos/blob/master/src/aurora/ndsrom.cpp#L56-L77)), `HERF` / `DICT` (**21002**) / `SMALL` chain, `NSBTX`, Nitro wrappers ([`nitrofile.cpp#L53-L71`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nitrofile.cpp#L53-L71) — both `NitroFile::open` overloads), `CDPTH` ([`cdpth.cpp#L81-L86`](https://github.com/xoreos/xoreos/blob/master/src/aurora/cdpth.cpp#L81-L86) `CDPTH::load` + [`L94-L132`](https://github.com/xoreos/xoreos/blob/master/src/aurora/cdpth.cpp#L94-L132) `readCells`), plus the **21004–21026** Nitro / map / audio types in [`types.h#L258-L280`](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L258-L280) — each needs its own `.ksy` or an explicit “out of repo scope” callout.

**NWN2 / Eclipse long tail:** `GR2`, `GFX`, ZIP-faced FaceFX (`FXM`/`FXS`/`ZIP` block in `types.h` starting ~`20000`), `WLK`, many `25000` DA2 types — each needs a **game column** before committing to `.ksy` scope.

---

## 6. Cleanup / alignment (existing `.ksy`)

- **Cross-engine `PCC.ksy` / `DAS.ksy` / `DA2S.ksy`:** Eclipse saves are **not** Aurora `ERF`; keep `xref` scoped to `src/engines/dragonage*` and `types.h` `22000` / `25000` blocks.
- **`WAV.ksy`:** xoreos treats `WAV` as a standard RIFF parser; `meta.xref` should cite **both** [`types.h` `kFileTypeWAV` = **4**](https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62) (`xoreos_types_kfiletype_wav`) **and** [`wave.cpp` `makeWAVStream`](https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106) plus [`sound.cpp` `SoundManager::makeAudioStream`](https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340) (container sniff + KotOR “modified WAVE” → `makeWAVStream`).
- **GFF generics:** If `formats/GFF/Generics/**` returns in-tree, prefer **binary** `ARE.ksy` etc. aligned to `gff3file.cpp` struct/label sections — not XML/JSON (removed as plaintext).
- **GFF XML / JSON interchange:** `formats/GFF/XML/GFF_XML.ksy` and `formats/GFF/JSON/GFF_JSON.ksy` are **intentionally absent** (repo `AGENTS.md` — Kaitai models **binary on-disk** wire only). PyKotor / xoreos-tools still implement XML/JSON pipelines; cite those repos in prose or `GFF.ksy` `meta.xref`, not as `.ksy` parsers.

---

## 7. Citation convention for `.ksy` `meta.xref`

1. Prefer **GitHub line anchors** on upstream `master` (template uses angle brackets only inside backticks so URL scrapers do not treat the scheme plus “colon slash slash” as a link):  
   `github.com/xoreos/xoreos/blob/master/src/aurora/<file>.cpp#L<start>-L<end>` → prepend the usual `https` URL scheme when substituting a real path (example: [`gff3file.cpp` `Header::read`](https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63)).
2. When `master` line numbers shift, update anchors (or pin to a **commit SHA** in the URL for stable CI citations).
3. Pair **reader** (`xoreos`) with **tooling** (`xoreos-tools`) when write paths matter.
4. When a spec maps to one primary **`kFileType*`** wire ID, add a matching **`types.h`** anchor (`…/types.h#L<start>-L<end>`) next to the `*file.cpp` link — this repo uses keys like `xoreos_types_kfiletype_*` on [`GFF.ksy`](../formats/GFF/GFF.ksy), [`SSF.ksy`](../formats/SSF/SSF.ksy), [`ERF.ksy`](../formats/ERF/ERF.ksy), [`WAV.ksy`](../formats/WAV/WAV.ksy), etc.
5. Keep **PyKotor wiki** links for *human* semantics; use **xoreos** links for *parser truth*.

**Examples already applied:** [`bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy), [`GFF.ksy`](../formats/GFF/GFF.ksy) (GFF3 + GFF4), plus `meta.xref` line anchors on TLK/TwoDA/KEY/BIF/BZF/ERF/RIM/SSF/LTR/WAV/NCS/TPC/DDS/TGA/MDL/MDX/PLT/BWM, GDA/HERF/TXB, and upstream-gap notes on PCC/DAS/DA2S.

---

## 8. Engine → xoreos directory quick map

| Your term | xoreos `GameID` | Typical `src/engines/*` dirs |
|-----------|-----------------|-------------------------------|
| Odyssey (KotOR era) | `kGameIDKotOR`, `kGameIDKotOR2` | `odyssey`, `kotor`, `kotor2`, `kotorbase` |
| Aurora (NWN era) | `kGameIDNWN`, `kGameIDNWN2` | `nwn`, `nwn2`, `aurora` helpers |
| Eclipse (Dragon Age) | `kGameIDDragonAge`, `kGameIDDragonAge2` | `dragonage`, `dragonage2`, `eclipse` |
| Jade / Witcher / Sonic | `kGameIDJade`, … | matching `src/engines/*` |

---

## 9. Next steps (workflow)

1. `git submodule update --init vendor/xoreos vendor/xoreos-tools vendor/xoreos-docs` (optional forks), **or** clone upstream into `_upstream/` for stable line audits. When `vendor/xoreos*` is empty, use GitHub **`/blob/<sha>/…`** links at the same SHA as this doc’s pin table (appendix “Pin used for this revision”) so line anchors stay reproducible.
2. For each **missing** row in §5, open the cited `*file.cpp`, sketch `seq:`/`types:` to match `read*()` order.
3. Add `meta.xref` anchors (see §7).
4. Extend [`bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy) only when new **numeric** `FileType` values appear in `types.h` that are not yet mirrored.
5. Optional drift hygiene: set `XOREOS_PIN_SHA` to the same short SHA as the doc pin, then run  
   `python scripts/verify_ksy_urls.py --root formats --also docs/XOREOS_FORMAT_COVERAGE.md --warn-floating-xoreos-master`  
   to list floating `…/xoreos/*/blob/master/…` URLs inside scanned files (warnings only; pair with `--verify` when you want HTTP checks). Add `--check-xoreos-github-line-ranges` to fail fast when any `xoreos/xoreos` or `xoreos/xoreos-tools` `master` `#L` band is out of range versus upstream raw file length.

---

## 10. Appendix — `xoreos` `src/aurora/*.cpp` inventory (runtime readers / writers)

These are the Aurora-layer translation units in upstream `master` (names only; see each file for `GameID` / `FileType` branches). Last bulk filename inventory snapshot: `89c99d2`.

`2dafile.cpp`, `2dareg.cpp`, `archive.cpp`, `aurorafile.cpp`, `biffile.cpp`, `bzffile.cpp`, `cdpth.cpp`, `dlgfile.cpp`, `erffile.cpp`, `erfwriter.cpp`, `gdafile.cpp`, `gdaheaders.cpp`, `gff3file.cpp`, `gff3writer.cpp`, `gff4file.cpp`, `gfxfile.cpp`, `gr2file.cpp`, `herffile.cpp`, `ifofile.cpp`, `keyfile.cpp`, `language.cpp`, `locstring.cpp`, `ltrfile.cpp`, `lytfile.cpp`, `ndsrom.cpp`, `nfofile.cpp`, `nitrofile.cpp`, `nsbtxfile.cpp`, `obbfile.cpp`, `oodle.cpp`, `pefile.cpp`, `resman.cpp`, `rimfile.cpp`, `sacfile.cpp`, `smallfile.cpp`, `ssffile.cpp`, `talkman.cpp`, `talktable_gff.cpp`, `talktable_tlk.cpp`, `talktable.cpp`, `textureatlasfile.cpp`, `thewitchersavefile.cpp`, `thewitchersavewriter.cpp`, `util.cpp`, `visfile.cpp`, `xmlfixer.cpp`, `zipfile.cpp`.

**Subdirectories under `src/aurora/`** (not listed file-by-file above): [`actionscript/`](https://github.com/xoreos/xoreos/tree/master/src/aurora/actionscript) (Scaleform / `GFXFile` VM), [`lua/`](https://github.com/xoreos/xoreos/tree/master/src/aurora/lua) (embedded Lua host), [`nwscript/`](https://github.com/xoreos/xoreos/tree/master/src/aurora/nwscript) (NWScript VM + `NCSFile`).

NWScript bytecode: [`src/aurora/nwscript/ncsfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp) (`NCSFile::load` **L333–L355** on current `master`).

## 11. Appendix — `xoreos` `src/graphics/images/*.cpp`

`cbgt.cpp`, `cubemapcombiner.cpp`, `dds.cpp`, `decoder.cpp`, `dumptga.cpp`, `nbfs.cpp`, `ncgr.cpp`, `nclr.cpp`, `s3tc.cpp`, `sbm.cpp`, `screenshot.cpp`, `surface.cpp`, `tga.cpp`, `tpc.cpp`, `txb.cpp`, `txi.cpp`, `txitypes.cpp`, `winiconimage.cpp`, `xoreositex.cpp`.

PLT lives under [`src/graphics/aurora/pltfile.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp).

KotOR MDL/MDX consumption (not a standalone `mdlfile.cpp` in Aurora): [`src/graphics/aurora/model_kotor.cpp`](https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp) — `Model_KotOR::load` starts **L184**; MDX vertex interleave reads around **L885–L917** on current `master`.

KotOR walkmeshes (BWM / WOK / DWK / PWK): [`src/engines/kotorbase/path/walkmeshloader.cpp`](https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp) — `WalkmeshLoader::load` **L42–L113**.

## 12. Appendix — `xoreos-tools` `src/aurora/*.cpp`

`2dafile.cpp`, `archive.cpp`, `aurorafile.cpp`, `biffile.cpp`, `bifwriter.cpp`, `bzffile.cpp`, `bzfwriter.cpp`, `erffile.cpp`, `erfwriter.cpp`, `gdafile.cpp`, `gdaheaders.cpp`, `gff3file.cpp`, `gff3writer.cpp`, `gff4file.cpp`, `herffile.cpp`, `keyfile.cpp`, `keywriter.cpp`, `language.cpp`, `locstring.cpp`, `ndsrom.cpp`, `nitrofile.cpp`, `nsbtxfile.cpp`, `obbfile.cpp`, `rimfile.cpp`, `rimwriter.cpp`, `sacfile.cpp`, `smallfile.cpp`, `ssffile.cpp`, `talktable_gff.cpp`, `talktable_tlk.cpp`, `talktable.cpp`, `thewitchersavefile.cpp`, `thewitchersavewriter.cpp`, `util.cpp`, `xmlfixer.cpp`, `zipfile.cpp`.

---

### Pin used for this revision

| Repository | Short SHA | Notes |
|------------|-----------|--------|
| [xoreos/xoreos](https://github.com/xoreos/xoreos) | `89c99d2` | Optional regression snapshot; `formats/**/*.ksy` `meta.xref` URLs default to `master` |
| [xoreos/xoreos-tools](https://github.com/xoreos/xoreos-tools) | `b2ebf4f` | tools `src/aurora` inventory |
| [xoreos/xoreos-docs](https://github.com/xoreos/xoreos-docs) | `4e1c197` | `specs/` tree snapshot |

*GitHub `…/blob/master/…` anchors drift when upstream edits land — refresh `_upstream/` clones and update `meta.xref` / this doc. Pin SHAs above are optional reproducibility checkpoints (for example when diffing `vendor/xoreos*` forks).*

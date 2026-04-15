meta:
  id: txi
  title: BioWare TXI (Texture Info) Format
  license: MIT
  endian: le
  file-extension: txi
  encoding: ASCII
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: TXI ASCII sidecars parsed with TPC textures (PyKotor wiki)."
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/
    pykotor_wiki_txi: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi
    github_openkotor_pykotor_txi_io: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py`:
      **`TXIReaderMode`** **20–26**; **`TXIBinaryReader`** **28–335** (`load` from **48**); **`TXIBinaryWriter`** **337–375** (`write` **343–375**).
    github_openkotor_pykotor_txi_data: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py`:
      **`TXI`** resource model **52+**; command dispatch / **`TXICommand`** enum members **117+** (full enum block **619–684** on current `master` — re-verify if upstream moves).
    github_modawan_reone_txi: |
      https://github.com/modawan/reone — `src/libs/graphics/format/txireader.cpp`:       **`TxiReader::load`** **28–38**,
      **`parseProcedureType`** **41–53**, **`processLine`** **55–125** (ASCII line parser for TPC-attached TXI bytes; includes coord sub-states).
    github_kobaltblu_kotor_js_txi: |
      https://github.com/KobaltBlu/KotOR.js — `src/resource/TXI.ts`: class **`TXI`** **16–96**; **`ParseInfo`** switch **98–120** (continues for per-command branches).
    xoreos_upstream_note_txi: |
      Upstream **xoreos** does not ship a dedicated `txifile.cpp`; TXI is an **ASCII sidecar** paired with **`kFileTypeTPC`** / TPC loaders (`src/graphics/images/tpc.cpp`). Treat **`types.h`** `kFileTypeTXI` / **`2022`** as the numeric ID only (`formats/Common/bioware_type_ids.ksy`).
    xoreos_tpc_read_txi: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L362-L373
    xoreos_types_kfiletype_txi: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L88
    xoreos_tools_tpc_cpp_read_header: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
doc: |
  **Policy:** TXI is **plaintext** (line-oriented ASCII). This `.ksy` models only an opaque string span for tooling;
  authoritative command semantics live in PyKotor / reone parsers (`meta.xref`). xoreos consumes embedded TXI via **`TPC::readTXI`**
  (`meta.xref.xoreos_tpc_read_txi`), not a standalone `txifile.cpp`.

  TXI (Texture Info) files are compact ASCII descriptors that attach metadata to TPC textures.
  They control mipmap usage, filtering, flipbook animation, environment mapping, font atlases,
  and platform-specific downsampling. Every TXI file is parsed at runtime to configure how
  a TPC image is rendered.

  Format Structure:
  - Line-based ASCII text file (UTF-8 or Windows-1252)
  - Commands are case-insensitive but conventionally lowercase
  - Empty TXI files (0 bytes) are valid and use default settings
  - A TXI can be embedded at the end of a .tpc file or exist as a separate .txi file

  Command Formats (from PyKotor implementation):
  1. Simple commands: "command value" (e.g., "mipmap 0", "blending additive")
  2. Multi-value commands: "command v1 v2 v3" (e.g., "channelscale 1.0 0.5 0.5")
  3. Coordinate commands: "command count" followed by count coordinate lines
     Coordinate format: "x y z" (normalized floats + int, typically z=0)

  Parsing Behavior (matches PyKotor TXIReaderMode):
  - Lines parsed sequentially, whitespace stripped
  - Empty lines ignored
  - Commands recognized by uppercase comparison against TXICommand enum
  - Invalid commands logged but don't stop parsing
  - Coordinate commands switch parser to coordinate mode until count reached
  - Commands can interrupt coordinate parsing

  All Supported Commands (from TXICommand enum in txi_data.py):
  - alphamean, arturoheight, arturowidth, baselineheight, blending, bumpmapscaling, bumpmaptexture
  - bumpyshinytexture, candownsample, caretindent, channelscale, channeltranslate, clamp, codepage
  - cols, compresstexture, controllerscript, cube, decal, defaultbpp, defaultheight, defaultwidth
  - distort, distortangle, distortionamplitude, downsamplefactor, downsamplemax, downsamplemin
  - envmaptexture, filerange, filter, fontheight, fontwidth, fps, isbumpmap, isdiffusebumpmap
  - islightmap, isspecularbumpmap, lowerrightcoords, maxsizehq, maxsizelq, minsizehq, minsizelq
  - mipmap, numchars, numcharspersheet, numx, numy, ondemand, priority, proceduretype, rows
  - spacingb, spacingr, speed, temporary, texturewidth, unique, upperleftcoords, wateralpha
  - waterheight, waterwidth, xbox_downsample

  Index: `meta.xref` and `doc-ref`.

doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_type_ids.ksy In-tree — `xoreos_file_type_id` / restype **2022** (`txi`)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#txi PyKotor wiki — TXI"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/io_txi.py#L20-L50 PyKotor — TXI reader (`TXIReaderMode`, `TXIBinaryReader.load` start)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/txi/txi_data.py#L619-L684 PyKotor — `TXICommand` enum block"
  - "https://github.com/modawan/reone/blob/master/src/libs/graphics/format/txireader.cpp#L28-L125 reone — `TxiReader` ASCII parse (`load` + `processLine`)"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L362-L373 xoreos — `TPC::readTXI` (embedded TXI tail)"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader` (texture tool stack; TXI pairs with TPC)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L88 xoreos — `kFileTypeTXI`"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (TPC-attached TXI context)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TXI.ts#L16-L120 KotOR.js — `TXI` + `ParseInfo` (ASCII command switch)"

seq:
  - id: content
    type: str
    size-eos: true
    encoding: ASCII
    doc: |
      Complete TXI file content as raw ASCII text.
      The PyKotor parser processes this line-by-line with special handling for:
      - Coordinate commands (upperleftcoords, lowerrightcoords) followed by coordinate data
      - Multi-value commands (channelscale, channeltranslate, filerange)
      - Boolean/numeric/string single-value commands
      - Empty files (valid, indicates default settings)

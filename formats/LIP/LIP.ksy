meta:
  id: lip
  title: BioWare LIP (LIP Synchronization) File
  license: MIT
  endian: le
  file-extension: lip
  imports:
    - ../Common/bioware_common
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Odyssey MCP `user-agdec-http` on `/K1/k1_win_gog_swkotor.exe` (classes+structures search for **`CResLIP`**): **no**
      `CResLIP` symbol returned (contrast **`CResMDL`**, **`CResLTR`**, …). Lip-sync **wire** in this repo is therefore pinned to
      **PyKotor `io_lip` / `lip_data`**, **reone `LipReader`**, and **KotOR.js** (`meta.xref`) until a Ghidra class/vtable name is recovered.
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/
    github_openkotor_pykotor_io_lip: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py`:
      **`_load_lip_from_kaitai`** **24–36**; **`_load_lip_legacy`** **39–59**; **`LIPBinaryReader`** **63–92** (`load` **86–92**); **`LIPBinaryWriter`** **95–116** (`write` **108–116**).
    github_openkotor_pykotor_lip_data_lipshape: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py`:
      **`LIPShape`** viseme **`IntEnum`** **47–127** (wire **`u8`** 0–15; mirrors `bioware_lip_viseme_id` in `bioware_common.ksy`).
    kotor_js_lipobject_read_binary: https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118
    kotor_net_lip: https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs#L9-L39
    xoreos_types_kfiletype_lip: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180
    xoreos_upstream_note: |
      Upstream xoreos has no `lipfile.cpp`; LIP payloads are consumed via game render/audio paths.
      Use `kFileTypeLIP` in types.h for the numeric ID (3004) and community parsers (PyKotor/reone) for wire layout.
    pykotor_wiki_lip: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
    reone_lipreader_load: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware

doc: |
  **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
  `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.

  xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).

doc-ref:
  - "https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no LIP-specific tool)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116 PyKotor — `io_lip` (Kaitai + legacy read/write)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip_data.py#L47-L127 PyKotor — `LIPShape` enum"
  - "https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41 reone — `LipReader::load`"
  - "https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LIPObject.ts#L99-L118 KotOR.js — `LIPObject.readBinary`"
  - "https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorLIP/LIP.cs#L9-L39 NickHugi/Kotor.NET — `LIP` / `MouthShape` (wire-oriented types)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L180 xoreos — `kFileTypeLIP` (numeric id; no standalone `lipfile.cpp`)"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no dedicated LIP Torlack/PDF; wire from PyKotor/reone)"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "LIP " (space-padded) for LIP files.
  
  - id: file_version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Must be "V1.0" for LIP files.
  
  - id: length
    type: f4
    doc: |
      Duration in seconds. Must equal the paired WAV file playback time for
      glitch-free animation. This is the total length of the lip sync animation.
  
  - id: num_keyframes
    type: u4
    doc: |
      Number of keyframes immediately following. Each keyframe contains a timestamp
      and a viseme shape index. Keyframes should be sorted ascending by timestamp.
  
  - id: keyframes
    type: keyframe_entry
    repeat: expr
    repeat-expr: num_keyframes
    doc: |
      Array of keyframe entries. Each entry maps a timestamp to a mouth shape.
      Entries must be stored in chronological order (ascending by timestamp).

types:
  keyframe_entry:
    doc: |
      A single keyframe entry mapping a timestamp to a viseme (mouth shape).
      Keyframes are used by the engine to interpolate between mouth shapes during
      audio playback to create lip sync animation.
    seq:
      - id: timestamp
        type: f4
        doc: |
          Seconds from animation start. Must be >= 0 and <= length.
          Keyframes should be sorted ascending by timestamp.
      
      - id: shape
        type: u1
        enum: bioware_common::bioware_lip_viseme_id
        doc: |
          Viseme index (0–15). Canonical names: `formats/Common/bioware_common.ksy` →
          `bioware_lip_viseme_id` (PyKotor `LIPShape` / Preston Blair set).


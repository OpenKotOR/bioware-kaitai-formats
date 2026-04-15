meta:
  id: lip
  title: BioWare LIP (LIP Synchronization) File
  license: MIT
  endian: le
  file-extension: lip
  imports:
    - ../Common/bioware_common
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: LIP resources parsed for lip-sync; binary layout per PyKotor/reone.
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/lip/
    reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/lipreader.cpp
    kotor_js: https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/resource/LIPObject.ts#L99-L125
    kotor_net: https://github.com/th3w1zard1/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorLIP/LIP.cs
    xoreos_types_kfiletype_lip: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L180
    xoreos_upstream_note: |
      Upstream xoreos has no `lipfile.cpp`; LIP payloads are consumed via game render/audio paths.
      Use `kFileTypeLIP` in types.h for the numeric ID (3004) and community parsers (PyKotor/reone) for wire layout.
    pykotor_wiki_lip: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
    reone_lipreader_keyframes: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/lipreader.cpp#L27-L42
doc: |
  **LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
  `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.

  xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP"
  - "https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/lipreader.cpp#L27-L42 reone — LIPReader"

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


meta:
  id: tpc
  title: BioWare TPC (Texture Pack Container) File Format
  license: MIT
  endian: le
  file-extension:
    - tpc
  imports:
    - ../Common/bioware_common
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: TPC textures loaded via Aurora stack; 128-byte header + payload per PyKotor.
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/tpc/
    reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/tpcreader.cpp
    kotor_js_tpcloader: https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/loaders/TPCLoader.ts#L153-L173
    kotor_js_tpcobject: https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/resource/TPCObject.ts#L36-L72
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tpc.cpp
    xoreos_types_kfiletype_tpc: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L183
    xoreos_tpc_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tpc.cpp#L52-L66
    xoreos_tpc_read_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tpc.cpp#L68-L252
    pykotor_wiki_tpc: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    reone_tpcreader: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/tpcreader.cpp
doc: |
  **TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
  (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
  (`meta.xref`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — TPC"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tpc.cpp#L68-L252 xoreos — TPC::readHeader"

seq:
  - id: header
    type: tpc_header
    doc: TPC file header (128 bytes total)

  - id: body
    size-eos: true
    doc: |
      Remaining file bytes after the header (texture data for all layers/mipmaps, then optional TXI).

types:
  tpc_header:
    seq:
      - id: data_size
        type: u4
        doc: |
          Total compressed payload size. If non-zero, texture is compressed (DXT).
          If zero, texture is uncompressed and size is derived from format/width/height.

      - id: alpha_test
        type: f4
        doc: |
          Float threshold used by punch-through rendering.
          Commonly 0.0 or 0.5.

      - id: width
        type: u2
        doc: |
          Texture width in pixels (uint16).
          Must be power-of-two for compressed formats.

      - id: height
        type: u2
        doc: |
          Texture height in pixels (uint16).
          For cube maps, this is 6x the face width.
          Must be power-of-two for compressed formats.

      - id: pixel_encoding
        type: u1
        enum: bioware_common::bioware_tpc_pixel_format_id
        doc: |
          Pixel encoding byte (`u1`). Canonical values: `formats/Common/bioware_common.ksy` →
          `bioware_tpc_pixel_format_id` (PyKotor wiki TPC header; xoreos `tpc.cpp` `readHeader`).

      - id: mipmap_count
        type: u1
        doc: |
          Number of mip levels per layer (minimum 1).
          Each mip level is half the size of the previous level.

      - id: reserved
        type: u1
        repeat: expr
        repeat-expr: 114
        doc: |
          Reserved/padding bytes (0x72 = 114 bytes).
          KotOR stores platform hints here but all implementations skip them.

    instances:
      is_compressed:
        value: data_size != 0
        doc: True if texture data is compressed (DXT format)

      is_uncompressed:
        value: data_size == 0
        doc: True if texture data is uncompressed (raw pixels)

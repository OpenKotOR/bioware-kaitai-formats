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
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/
    github_openkotor_pykotor_io_tpc: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py`:
      **`TPCBinaryReader`** **93+**; **`TPCBinaryReader.load`** **121–303**; **`TPCBinaryWriter.write`** **391+** (long writer).
    github_openkotor_pykotor_tpc_data: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py`:
      **`TPCTextureFormat`** **74+**; **`TPCMipmap`** **218+**; **`TPCLayer`** **414+**; **`class TPC`** **499+** (resource model + mip/layer helpers).
    github_openkotor_pykotor_resource_type_tpc: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/type.py`:       **`ResourceType.TPC`** tuple **1040–1045** (`type_id` **3007**).
    github_modawan_reone_tpcreader: |
      https://github.com/modawan/reone — `src/libs/graphics/format/tpcreader.cpp`: **`TpcReader::load`** **29–62**;
      **`loadLayers`** **64–81**; **`loadFeatures`** (**TXI** tail via **`TxiReader`**) **83–96**; **`loadTexture`** **98–105**;
      **`getMipMapDataSize`** **112+**; **`getPixelFormat`** **136+**.
    kotor_js_tpcloader: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/loaders/TPCLoader.ts#L26-L96
    github_kobaltblu_kotor_js_tpcobject: |
      https://github.com/KobaltBlu/KotOR.js — `src/resource/TPCObject.ts`: **`TPCObject`** **25+**; **`readHeader`** **290–380** (wire layout; pairs with this `.ksy` header).
    xoreos_tpc_cpp: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L66
    xoreos_types_kfiletype_tpc: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L183
    xoreos_tpc_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L66
    xoreos_tpc_read_header: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L68-L252
    xoreos_tpc_read_data: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L326
    xoreos_tpc_read_txi: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L362
    xoreos_tools_tpc_cpp_load: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68
    xoreos_tools_tpc_cpp_read_header: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224
    pykotor_wiki_tpc: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
doc: |
  **TPC** (KotOR native texture): 128 (0x80)-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
  (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
  (`meta.xref`).

doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/TPC/DDS.ksy In-tree — `CResTPC::OnResourceServiced` (128 (0x80)-byte header; K1 + TSL **observed behavior** in `DDS.ksy` `meta.xref`)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — TPC"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303 PyKotor — `TPCBinaryReader` + `load`"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120 PyKotor — `TPCTextureFormat` (opening)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520 PyKotor — `class TPC` (opening)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/tpcreader.cpp#L29-L105 reone — `TpcReader` (body + TXI features)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L183 xoreos — `kFileTypeTPC`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L362 xoreos — `TPC::load` through `readTXI` entrypoints"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/TPCObject.ts#L290-L380 KotOR.js — `TPCObject.readHeader`"

seq:
  - id: header
    type: tpc_header
    doc: TPC file header (128 (0x80) bytes total)

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
          Reserved/padding bytes (0x72 = 114 (0x72) bytes).
          KotOR stores platform hints here but all implementations skip them.

    instances:
      is_compressed:
        value: data_size != 0
        doc: True if texture data is compressed (DXT format)

      is_uncompressed:
        value: data_size == 0
        doc: True if texture data is uncompressed (raw pixels)

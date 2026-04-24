meta:
  id: txb
  title: BioWare TXB Texture (TPC-shaped wire)
  license: MIT
  endian: le
  file-extension: txb
  imports:
    - ../Common/bioware_type_ids
    - tpc
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools ↔ this spec; submodule section 0).
    xoreos_types_kfiletype_txb: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L182
    xoreos_tpc_cpp: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L66
    xoreos_tools_tpc_cpp_load: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68
    xoreos_tools_tpc_cpp_read_header: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224
    pykotor_tpc_tree: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc
    reone_tpcreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/tpcreader.cpp#L29-L105
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
doc: |
  **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
  (PyKotor / reone) route many TXB payloads through the same **128 (0x80)-byte TPC header** + tail layout as native **TPC**.

  This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
  variant diverges, split a dedicated header type and cite engine/binary evidence (`TODO: VERIFY`).

doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/TPC/DDS.ksy In-tree — `CResTPC::OnResourceServiced` / 128 (0x80)-byte header (**observed behavior** for K1 + TSL in `meta.xref` on `DDS.ksy`)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L182 xoreos — `kFileTypeTXB`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family (cross-check TXB)"

seq:
  - id: header
    type: tpc::tpc_header
    doc: Shared 128 (0x80)-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
  - id: body
    size-eos: true
    doc: Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.

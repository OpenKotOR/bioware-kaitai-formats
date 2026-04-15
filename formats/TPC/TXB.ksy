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
    xoreos_types_kfiletype_txb: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182
    xoreos_tpc_cpp: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66
    xoreos_tools_tpc_cpp_load: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68
    xoreos_tools_tpc_cpp_read_header: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224
    pykotor_tpc_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc
    reone_tpcreader: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    ghidra_odyssey_k1: |
      Odyssey MCP `user-agdec-http` on `/K1/k1_win_gog_swkotor.exe` (structures+classes search): **`CResTGA`** / **`CResDDS`** present;
      **no** `CResTXB` symbol in that inventory. **`CResTPC::OnResourceServiced`** (128-byte header) is documented for KotOR PC in **`formats/TPC/DDS.ksy`** — use that xref when arguing TXB ≈ TPC-shaped wire. **TXB** remains a **type-id** bucket in `types.h`; treat tail layout like **TPC** until a divergent ship is proven (`doc`).
doc: |
  **TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
  (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.

  This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
  variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).

doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/TPC/DDS.ksy In-tree — Ghidra `CResTPC::OnResourceServiced` / 128-byte header evidence (K1 + TSL blocks)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182 xoreos — `kFileTypeTXB`"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family (cross-check TXB)"

seq:
  - id: header
    type: tpc::tpc_header
    doc: Shared 128-byte TPC-class header (see `TPC.ksy` / PyKotor `TPCBinaryReader`).
  - id: body
    size-eos: true
    doc: Remaining bytes (mip chain / faces / optional TXI tail) — same consumption model as `TPC.ksy`.

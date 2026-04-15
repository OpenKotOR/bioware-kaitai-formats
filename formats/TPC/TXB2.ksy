meta:
  id: txb2
  title: BioWare TXB2 Texture (TPC-shaped wire)
  license: MIT
  endian: le
  file-extension: txb2
  imports:
    - ../Common/bioware_type_ids
    - tpc
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools ↔ this spec; submodule section 0).
    xoreos_types_kfiletype_txb2: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192
    xoreos_tpc_cpp: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66
    xoreos_tools_tpc_cpp_load: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68
    xoreos_tools_tpc_cpp_read_header: https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224
    pykotor_tpc_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc
    reone_tpcreader: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    ghidra_odyssey_k1: |
      Same notes as `formats/TPC/TXB.ksy`: **`CResTGA`** / **`CResDDS`** in a K1 structures+classes inventory; **no** `CResTXB2` / `CResTXB` symbol there;
      **`CResTPC::OnResourceServiced`** evidence lives under **`formats/TPC/DDS.ksy`**. Treat **TXB2** like **TXB** until on-disk divergence is proven.
doc: |
  **TXB2** (`kFileTypeTXB2` **3017**): second-generation TXB id in `types.h`; treated like **TXB** / **TPC** by engine
  texture stacks. This capsule mirrors `TXB.ksy` (TPC header + opaque tail) until a divergent wire is proven.

doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/TPC/DDS.ksy In-tree — Ghidra `CResTPC::OnResourceServiced` (shared with TXB / TPC family)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192 xoreos — `kFileTypeTXB2`"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66 xoreos — `TPC::load` (texture family)"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68 xoreos-tools — `TPC::load`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224 xoreos-tools — `TPC::readHeader`"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — texture family"

seq:
  - id: header
    type: tpc::tpc_header
  - id: body
    size-eos: true

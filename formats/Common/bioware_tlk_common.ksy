meta:
  id: bioware_tlk_common
  title: BioWare TLK (talk table) shared wire tags
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ TLK; submodule section 0).
    xoreos_talktable_tlk_constants: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L42
    pykotor_io_tlk: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196
    reone_tlkreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/tlkreader.cpp#L27-L67
    xoreos_docs_talktable_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/TalkTable_Format.pdf
doc: |
  LE ``u32`` tags matching xoreos ``MKTAG`` constants for TLK containers (same four bytes as ASCII
  ``"TLK "`` / ``"V3.0"`` / ``"V4.0"`` on disk).

  **Lowest-scope documentation:** enum members carry the upstream line anchors; `formats/TLK/TLK.ksy`
  imports this module and documents header layout / string table only.

doc-ref:
  - "formats/TLK/TLK.ksy In-tree — TLK root (`tlk_header` consumes these enums)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L42 xoreos — `kTLKID`, `kVersion3`, `kVersion4`"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196 PyKotor — `io_tlk` (ASCII header tags + V3/V4 paths)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/tlkreader.cpp#L27-L67 reone — `TlkReader` (`StringFlags`, load)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/TalkTable_Format.pdf xoreos-docs — TalkTable_Format.pdf"

enums:
  # xoreos: static const uint32_t kTLKID = MKTAG('T', 'L', 'K', ' ');
  tlk_file_magic_le:
    0x204b4c54:
      id: tlk_space
      doc: |
        ASCII ``TLK `` as LE ``u32`` (``0x54 0x4c 0x4b 0x20``). xoreos ``kTLKID``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L42

  # xoreos: kVersion3 / kVersion4 — Jade uses V4 per talktable_tlk.cpp dispatch.
  tlk_format_version_le:
    0x302e3356:
      id: v3_0
      doc: |
        ASCII ``V3.0`` (KotOR / NWN-era talk tables). xoreos ``kVersion3``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L65
    0x302e3456:
      id: v4_0
      doc: |
        ASCII ``V4.0`` (Jade Empire). xoreos ``kVersion4``; entry table layout differs from V3.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L86

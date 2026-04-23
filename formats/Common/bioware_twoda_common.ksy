meta:
  id: bioware_twoda_common
  title: BioWare TwoDA (2D array) shared wire tags
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ TwoDA; submodule section 0).
    xoreos_2dafile_constants: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51
    pykotor_io_twoda: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238
    reone_2dareader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/2dareader.cpp#L29-L66
    xoreos_docs_2da_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/2DA_Format.pdf
doc: |
  LE ``u32`` tags for Aurora **binary** TwoDA headers (ASCII fourcc + version token), matching xoreos ``MKTAG`` ids
  in ``2dafile.cpp`` and PyKotor ``io_twoda`` / reone ``TwoDAReader``.

  **Lowest-scope documentation:** enum members carry upstream anchors; ``formats/TwoDA/TwoDA.ksy`` models the full
  ``V2.b`` blob (column headers, offsets, …) only.

doc-ref:
  - "formats/TwoDA/TwoDA.ksy In-tree — binary TwoDA root (`twoda_header` consumes these enums)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51 xoreos — `k2DAID` / `k2DAIDTab` / `kVersion2a` / `kVersion2b`"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238 PyKotor — `io_twoda`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/2dareader.cpp#L29-L66 reone — `TwoDAReader`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf"

enums:
  two_da_file_magic_le:
    0x20414432:
      id: two_da_space
      doc: |
        ASCII ``2DA `` (KotOR / NWN binary tables). xoreos ``k2DAID``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51
    0x32414409:
      id: two_da_tab
      doc: |
        ASCII ``2DA\t`` (tab-terminated magic variant). xoreos ``k2DAIDTab`` (ASCII / tab-separated paths).
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51

  two_da_binary_version_le:
    0x302e3256:
      id: v2_0
      doc: |
        ASCII ``V2.0`` binary tag. xoreos ``kVersion2a``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L50-L51
    0x622e3256:
      id: v2_b
      doc: |
        ASCII ``V2.b`` KotOR/TSL on-disk binary TwoDA. xoreos ``kVersion2b``; PyKotor reader **25–26**.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L50-L51

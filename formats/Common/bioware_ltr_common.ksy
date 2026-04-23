meta:
  id: bioware_ltr_common
  title: BioWare LTR (letter / Markov) shared wire tags
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-docs ↔ LTR; submodule section 0).
    xoreos_ltrfile_constants: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ltrfile.cpp#L31-L32
    pykotor_io_ltr: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155
    reone_ltrreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/ltrreader.cpp#L27-L74
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  LE ``u32`` tags for binary **LTR** headers (``LTR `` + ``V1.0``), matching xoreos ``LTRFile`` / PyKotor ``io_ltr``.

  Alphabet sizes (**26** vs **28**) stay on ``bioware_common::bioware_ltr_alphabet_length``; this module is tags only.

doc-ref:
  - "formats/LTR/LTR.ksy In-tree — LTR root (imports this module + `bioware_common` for alphabet enum)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ltrfile.cpp#L31-L32 xoreos — `kLTRID` / `kVersion10`"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155 PyKotor — `io_ltr`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/ltrreader.cpp#L27-L74 reone — `LtrReader`"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree"

enums:
  ltr_file_magic_le:
    0x2052544c:
      id: ltr_space
      doc: |
        ASCII ``LTR ``. xoreos ``kLTRID``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ltrfile.cpp#L31-L32

  ltr_file_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0``. xoreos ``kVersion10``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ltrfile.cpp#L31-L32

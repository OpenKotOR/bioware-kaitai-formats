meta:
  id: bioware_bif_common
  title: BioWare BIF / BZF container magic (little-endian u32)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ BIF/BZF; submodule section 0).
    pykotor_bif_type_enum: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py`:
      **`BIFType`** **`BIFF`** / **`BZF `** **59–71** (ASCII fourcc prefixes; `BZF ` is the **outer** LZMA capsule tag).
    xoreos_biffile_magic: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/biffile.cpp#L54-L60
    xoreos_bzffile_outer_note: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L41-L55
    reone_bifreader_signature: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/bifreader.cpp#L26-L29
    xoreos_docs_keybif_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  First **four bytes** of classic Aurora **BIF** rows are the inner tag **`BIFF`** (`u4` LE `0x46464942`), followed by a **version**
  tag (`bif_file_version_le`: ``V1  `` or ``V1.1`` per PyKotor / xoreos). **BZF** mobile / compressed capsules use an **outer** tag **`BZF `**
  (`u4` LE `0x20465a42`) then **``V1.0``** (`bzf_outer_file_version_le`) + LZMA payload (`formats/BIF/BZF.ksy`).

doc-ref:
  - "formats/BIF/BIF.ksy In-tree — uncompressed BIF (`bif_inner_container_magic_le` + `bif_file_version_le`)"
  - "formats/BIF/BZF.ksy In-tree — BZF outer capsule (`bzf_outer_container_magic_le` + `bzf_outer_file_version_le`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71 PyKotor — `BIFType`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/biffile.cpp#L54-L60 xoreos — `BIFFile::load` (BIFF header)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L41-L55 xoreos — `BZFFile::load` (outer vs inner tag notes)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/bifreader.cpp#L26-L29 reone — `BifReader::load` (`BIFFV1  ` check)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"

enums:
  bif_inner_container_magic_le:
    0x46464942: biff

  bzf_outer_container_magic_le:
    0x20465a42: bzf

  bif_file_version_le:
    0x20203156:
      id: v1_two_spaces
      doc: |
        ASCII ``V1  `` (``V`` + ``1`` + two spaces). PyKotor / xoreos BIFF header after inner ``BIFF`` tag.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L94-L166
    0x312e3156:
      id: v1_1
      doc: |
        ASCII ``V1.1`` BIF header variant.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L94-L166

  bzf_outer_file_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0`` after outer ``BZF `` tag (LZMA capsule header per PyKotor wiki / `io_bif`).
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L102-L166

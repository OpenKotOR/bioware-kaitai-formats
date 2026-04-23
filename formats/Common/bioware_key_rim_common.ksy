meta:
  id: bioware_key_rim_common
  title: BioWare KEY / RIM container magic (little-endian u32)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ KEY/RIM; submodule section 0).
    xoreos_keyfile_magic: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/keyfile.cpp#L50-L55
    xoreos_rimfile_magic: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L36
    pykotor_key_rim_io: |
      https://github.com/OpenKotOR/PyKotor — `io_key.py` / `io_rim.py`: **`KEY `** / **`RIM `** ASCII signatures in binary readers (see `formats/BIF/KEY.ksy`, `formats/RIM/RIM.ksy`).
    reone_keyreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/keyreader.cpp#L26-L35
    reone_rimreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/rimreader.cpp#L26-L34
    xoreos_docs_keybif_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  Aurora **KEY** master tables start with **`KEY `** (`u4` LE `0x2045594b`) plus a **version** tag (`key_file_version_le`:
  ``V1  `` or ``V1.1`` per PyKotor / Torlack). KotOR **RIM** module templates start with **`RIM `** (`u4` LE `0x204d4952`)
  and **``V1.0``** (`rim_format_version_le`, xoreos ``kVersion1``). Wire layouts: `formats/BIF/KEY.ksy`, `formats/RIM/RIM.ksy`.

doc-ref:
  - "formats/BIF/KEY.ksy In-tree — KEY wire (`key_container_magic_le` on `file_type`)"
  - "formats/RIM/RIM.ksy In-tree — RIM wire (`rim_container_magic_le` on `file_type`)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/keyfile.cpp#L50-L55 xoreos — `KEYFile::load` (signature)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L36 xoreos — `kRIMID` / `RIMFile::load`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/keyreader.cpp#L26-L35 reone — `KeyReader::load`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/rimreader.cpp#L26-L34 reone — `RimReader::load`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"

enums:
  key_container_magic_le:
    0x2045594b: key

  rim_container_magic_le:
    0x204d4952: rim

  # PyKotor `io_key` legacy checks; Torlack KEY header — two shipped forms.
  key_file_version_le:
    0x20203156:
      id: v1_two_spaces
      doc: |
        ASCII ``V1  `` (``V`` + ``1`` + two spaces). PyKotor KEY reader accepts this form.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L57-L66
    0x312e3156:
      id: v1_1
      doc: |
        ASCII ``V1.1`` KEY table variant.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L57-L66

  rim_format_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0`` RIM stream tag. xoreos ``kVersion1``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L36

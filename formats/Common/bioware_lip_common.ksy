meta:
  id: bioware_lip_common
  title: BioWare LIP (lip sync) shared wire tags
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools ↔ LIP; submodule section 0).
    pykotor_io_lip: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116
    reone_lipreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41
    kotor_js_lipobject: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/LIPObject.ts#L99-L118
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  LE ``u32`` tags for the standard **LIP** header (ASCII ``LIP `` + ``V1.0``), matching PyKotor / reone /
  KotOR.js readers.

  **Lowest-scope documentation:** enum members carry vendor anchors; viseme ids stay on
  ``bioware_common::bioware_lip_viseme_id``; ``formats/LIP/LIP.ksy`` documents keyframe layout only.

doc-ref:
  - "formats/LIP/LIP.ksy In-tree — LIP root (imports this module for header tags)"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116 PyKotor — `io_lip`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41 reone — `LipReader::load`"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/LIPObject.ts#L99-L118 KotOR.js — `LIPObject.readBinary`"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree (no dedicated LIP PDF)"

enums:
  lip_file_magic_le:
    0x2050494c:
      id: lip_space
      doc: |
        ASCII ``LIP `` as LE ``u32``. PyKotor / KotOR.js / reone expect this signature.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L86-L92

  lip_format_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0`` wire tag used by KotOR-family LIP files.
        https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L86-L92

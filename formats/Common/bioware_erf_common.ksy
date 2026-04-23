meta:
  id: bioware_erf_common
  title: BioWare ERF family container magic (little-endian u32)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ ERF; submodule section 0).
    pykotor_erf_type_enum: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py`:
      **`ERFType`** (`ERF` / `MOD` / `SAV` / `HAK`) **91–107** (ASCII fourcc labels matching these LE u32 values).
    xoreos_erffile_type_tags: |
      https://github.com/xoreos/xoreos — `src/aurora/erffile.cpp`: **`kERFID` / `kMODID` / `kHAKID` / `kSAVID`** **50–59**
      (`MKTAG` fourccs equivalent to the first four bytes of each signature).
    reone_erfreader_signature: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/erfreader.cpp#L41-L51
    xoreos_docs_erf_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/ERF_Format.pdf
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  First **four bytes** of Aurora **ERF** / **MOD** / **SAV** / **HAK** containers are ASCII space-padded tags read as **`u4` LE**
  on little-endian hosts (`ERF ` → `0x20465245`, etc.). KotOR-era archives use **``V1.0``** as the next **four** bytes
  (`erf_format_version_le`, xoreos ``kVersion10``). `formats/ERF/ERF.ksy` binds `erf_header.file_type` to
  `erf_container_magic_le` and `erf_header.file_version` to `erf_format_version_le`.

doc-ref:
  - "formats/ERF/ERF.ksy In-tree — full ERF wire (`erf_container_magic_le` + `erf_format_version_le`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L107 PyKotor — `ERFType`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/erffile.cpp#L50-L59 xoreos — `kERFID` / `kMODID` / `kHAKID` / `kSAVID`"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/erfreader.cpp#L41-L51 reone — `ErfReader::checkSignature`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/ERF_Format.pdf xoreos-docs — ERF_Format.pdf"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"

enums:
  # LE u32 of first four on-disk ASCII bytes (space = 0x20).
  erf_container_magic_le:
    0x20465245: erf
    0x20444f4d: mod
    0x20564153: sav
    0x204b4148: hak

  erf_format_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0`` as LE ``u32`` (bytes ``V`` ``1`` ``.`` ``0``). xoreos ``kVersion10``; KotOR ERF/MOD/HAK/SAV wire per PyKotor / reone.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/erffile.cpp#L50-L59

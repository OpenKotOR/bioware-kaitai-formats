meta:
  id: ssf
  title: BioWare SSF (Sound Set File) Format
  license: MIT
  endian: le
  file-extension: ssf
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/ssf/
    pykotor_wiki_ssf: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
    github_openkotor_pykotor_io_ssf: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py`:
      **`_load_ssf_from_kaitai`** **102–109**; **`SSFBinaryReader`** **112–143** (`load` **137–143**); **`SSFBinaryWriter`** **146–165** (`write` **156–165**, 12× `0xFFFFFFFF` trailer).
    github_xoreos_ssffile: |
      https://github.com/xoreos/xoreos — `src/aurora/ssffile.cpp`:
      **`SSFFile::load`** **72–85**; **`readSSFHeader`** **87–120** (KotOR `V1.1` path returns **`kVersion11_KotOR`** **118–119**);
      **`readEntries`** **122–141**; **`readEntriesKotOR`** **165–170**; **`writeKotOR`** **371–378**.
    github_xoreos_types_kfiletype_ssf: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L126
    xoreos_ssffile_read_chain: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L72-L141
    xoreos_ssffile_read_entries_kotor: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L165-L170
    xoreos_tools_ssf2xml_main: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/ssf2xml.cpp#L51-L70
    xoreos_tools_xml2ssf_main: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml2ssf.cpp#L54-L75
    xoreos_tools_ssfdumper_dump: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfdumper.cpp#L133-L167
    xoreos_tools_ssfcreator_create: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfcreator.cpp#L38-L74
    reone_ssfreader_load: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/ssfreader.cpp#L26-L32
    xoreos_docs_ssf_format_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/SSF_Format.pdf
doc: |
  SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
  Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.

  Binary Format:
  - Header (12 (0xc) bytes): File type signature, version, and offset to sounds array (usually 12)
  - Sounds Array (112 (0x70) bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)

  Vanilla KotOR SSFs are typically 136 (0x88) bytes total: after the 28 StrRefs, many files append 12 (0xc) bytes
  of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.

  Sound Slots (in order):
  0-5: Battle Cry 1-6
  6-8: Select 1-3
  9-11: Attack Grunt 1-3
  12-13: Pain Grunt 1-2
  14: Low Health
  15: Dead
  16: Critical Hit
  17: Target Immune
  18: Lay Mine
  19: Disarm Mine
  20: Begin Stealth
  21: Begin Search
  22: Begin Unlock
  23: Unlock Failed
  24: Unlock Success
  25: Separated From Party
  26: Rejoined Party
  27: Poisoned

  Authoritative implementations: `meta.xref` and `doc-ref` (PyKotor `io_ssf`, xoreos `ssffile.cpp`, xoreos-tools `ssf2xml` / `xml2ssf`, xoreos-docs `SSF_Format.pdf`, reone `SsfReader`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf PyKotor wiki — SSF"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L102-L165 PyKotor — `io_ssf` (Kaitai bridge + binary read/write)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L126 xoreos — `kFileTypeSSF`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L72-L141 xoreos — `SSFFile::load` + `readSSFHeader` + `readEntries`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L165-L170 xoreos — `readEntriesKotOR`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/ssf2xml.cpp#L51-L70 xoreos-tools — `ssf2xml` CLI"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml2ssf.cpp#L54-L75 xoreos-tools — `xml2ssf` CLI (`main`)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfdumper.cpp#L133-L167 xoreos-tools — `SSFDumper::dump` (XML mapping for `ssf2xml`)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfcreator.cpp#L38-L74 xoreos-tools — `SSFCreator::create` (XML mapping for `xml2ssf`)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/SSF_Format.pdf xoreos-docs — SSF_Format.pdf"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/ssfreader.cpp#L26-L32 reone — `SsfReader::load`"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File type signature. Must be "SSF " (space-padded).
      Bytes: 0x53 0x53 0x46 0x20
    valid: "'SSF '"

  - id: file_version
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File format version. Always "V1.1" for KotOR SSF files.
      Bytes: 0x56 0x31 0x2E 0x31
    valid: "'V1.1'"

  - id: sounds_offset
    type: u4
    doc: |
      Byte offset to the sounds array from the beginning of the file.
      KotOR files almost always use 12 (0x0C) so the table follows the header immediately, but the
      field is a real offset; readers must seek here instead of assuming 12.

instances:
  sounds:
    type: sound_array
    pos: sounds_offset
    doc: Array of 28 sound string references (StrRefs)

types:
  sound_array:
    seq:
      - id: entries
        type: sound_entry
        repeat: expr
        repeat-expr: 28
        doc: |
          Array of exactly 28 sound entries, one for each SSFSound enum value.
          Each entry is a uint32 representing a StrRef (string reference).
          Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).

          Entry indices map to SSFSound enum:
          - 0-5: Battle Cry 1-6
          - 6-8: Select 1-3
          - 9-11: Attack Grunt 1-3
          - 12-13: Pain Grunt 1-2
          - 14: Low Health
          - 15: Dead
          - 16: Critical Hit
          - 17: Target Immune
          - 18: Lay Mine
          - 19: Disarm Mine
          - 20: Begin Stealth
          - 21: Begin Search
          - 22: Begin Unlock
          - 23: Unlock Failed
          - 24: Unlock Success
          - 25: Separated From Party
          - 26: Rejoined Party
          - 27: Poisoned

  sound_entry:
    seq:
      - id: strref_raw
        type: u4
        doc: |
          Raw uint32 value representing the StrRef.
          Value 0xFFFFFFFF (4294967295) represents -1 (no sound assigned).
          All other values are valid StrRefs (typically 0-999999).
          The conversion from 0xFFFFFFFF to -1 is handled by SSFBinaryReader.ReadInt32MaxNeg1().

    instances:
      is_no_sound:
        value: strref_raw == 0xFFFFFFFF
        doc: |
          True if this entry represents "no sound" (0xFFFFFFFF).
          False if this entry contains a valid StrRef value.

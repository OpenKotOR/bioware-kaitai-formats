meta:
  id: bzf
  title: BioWare BZF (BioWare Zipped File) Format
  license: MIT
  endian: le
  file-extension: bzf
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: compressed BZF archives pair with BIF/KEY loading paths (same family as BIF)."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/
    pykotor_wiki_bif_file_format: https://github.com/OldRepublicDevs/PyKotor/wiki/BIF-File-Format.md
    pykotor_wiki_bif_bzf: https://github.com/OldRepublicDevs/PyKotor/wiki/BIF-BZF.md
doc: |
  BZF (BioWare Zipped File) files are LZMA-compressed BIF files used primarily in iOS
  (and maybe Android) ports of KotOR. The BZF header contains "BZF " + "V1.0", followed
  by LZMA-compressed BIF data. Decompression reveals a standard BIF structure.

  Format Structure:
  - Header (8 bytes): File type signature "BZF " and version "V1.0"
  - Compressed Data: LZMA-compressed BIF file data

  After decompression, the data follows the standard BIF format structure.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/BIF-File-Format.md - BZF compression section
  - BIF.ksy - Standard BIF format (decompressed BZF data matches this)

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "BZF " for compressed BIF files.
    valid: "'BZF '"

  - id: version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Always "V1.0" for BZF files.
    valid: "'V1.0'"

  - id: compressed_data
    type: u1
    repeat: eos
    doc: |
      LZMA-compressed BIF file data.
      This data must be decompressed using LZMA algorithm to obtain the standard BIF structure.
      After decompression, the data can be parsed using the BIF format definition.

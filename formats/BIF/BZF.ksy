meta:
  id: bzf
  title: BioWare BZF (BioWare Zipped File) Format
  license: MIT
  endian: le
  file-extension: bzf
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: compressed BZF archives pair with BIF/KEY loading paths (same family as BIF).
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/bif/
    pykotor_wiki_bif_file_format: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif
    pykotor_wiki_bif_bzf: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/bzffile.cpp
    xoreos_types_kfiletype_bzf: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L368
    xoreos_bzf_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/bzffile.cpp#L55-L83
doc: |
  **BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
  mobile KotOR ports.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression PyKotor wiki — BZF (LZMA BIF)"

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
    size-eos: true
    doc: |
      LZMA-compressed BIF file data (single blob to EOF).
      Decompress with LZMA to obtain the standard BIF structure (see BIF.ksy).

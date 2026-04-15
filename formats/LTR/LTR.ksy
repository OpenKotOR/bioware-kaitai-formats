meta:
  id: ltr
  title: BioWare LTR (Letter) File
  license: MIT
  endian: le
  file-extension: ltr
  imports:
    - ../Common/bioware_common
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: CResLTR present; binary LTR wire format per PyKotor wiki.
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/ltr/
    reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/ltrreader.cpp
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/ltrfile.cpp
    xoreos_types_kfiletype_ltr: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L101
    xoreos_ltr_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/ltrfile.cpp#L135-L168
    kotor_js: https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/resource/LTRObject.ts#L52-L121
    kaitai_user_guide_enums: https://doc.kaitai.io/user_guide.html
    pykotor_wiki_ltr: https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format
    reone_ltrreader: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/ltrreader.cpp#L27-L74
doc: |
  **LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
  `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
  `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format PyKotor wiki — LTR"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/ltrfile.cpp#L135-L168 xoreos — LTR::load"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "LTR " (space-padded) for LTR files.
  
  - id: file_version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Must be "V1.0" for LTR files.
  
  - id: letter_count
    type: u1
    enum: bioware_common::bioware_ltr_alphabet_length
    doc: |
      Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
      (26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide §6.4.5).
  
  - id: single_letter_block
    type: letter_block
    doc: |
      Single-letter probability block (no context).
      Used for generating the first character of names.
      Contains start/middle/end probability arrays, each with letter_count floats.
      Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).
  
  - id: double_letter_blocks
    type: double_letter_blocks_array
    doc: |
      Double-letter probability blocks (1-character context).
      Array of letter_count blocks, each indexed by the previous character.
      Used for generating the second character based on the first character.
      Each block contains start/middle/end probability arrays.
      Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.
  
  - id: triple_letter_blocks
    type: triple_letter_blocks_array
    doc: |
      Triple-letter probability blocks (2-character context).
      Two-dimensional array of letter_count × letter_count blocks.
      Each block is indexed by the previous two characters.
      Used for generating third and subsequent characters.
      Each block contains start/middle/end probability arrays.
      Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.

types:
  letter_block:
    doc: |
      A probability block containing three arrays of probabilities (start, middle, end).
      Each array has letter_count floats representing cumulative probabilities for each character
      in the alphabet appearing at that position (start, middle, or end of name).
      
      Blocks store cumulative probabilities (monotonically increasing floats) that are compared
      against random roll values during name generation.
    seq:
      - id: start_probabilities
        type: f4
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of start probabilities. One float per character in alphabet.
          Probability of each letter starting a name (no context for singles,
          after previous character for doubles, after previous two for triples).
      
      - id: middle_probabilities
        type: f4
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of middle probabilities. One float per character in alphabet.
          Probability of each letter appearing in the middle of a name.
      
      - id: end_probabilities
        type: f4
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of end probabilities. One float per character in alphabet.
          Probability of each letter ending a name.

  double_letter_blocks_array:
    doc: |
      Array of double-letter blocks. One block per character in the alphabet.
      Each block is indexed by the previous character (context length 1).
    seq:
      - id: blocks
        type: letter_block
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of letter_count blocks, each containing start/middle/end probability arrays.
          Block index corresponds to the previous character in the alphabet.

  triple_letter_blocks_array:
    doc: |
      Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
      Each block is indexed by the previous two characters (context length 2).
    seq:
      - id: rows
        type: triple_letter_row
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of letter_count rows, each containing letter_count blocks.
          First index corresponds to the second-to-last character.
          Second index corresponds to the last character.

  triple_letter_row:
    doc: |
      A row in the triple-letter blocks array. Contains letter_count blocks,
      each indexed by the last character in the two-character context.
    seq:
      - id: blocks
        type: letter_block
        repeat: expr
        repeat-expr: _root.letter_count.to_i
        doc: |
          Array of letter_count blocks, each containing start/middle/end probability arrays.
          Block index corresponds to the last character in the two-character context.



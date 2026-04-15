meta:
  id: key
  title: BioWare KEY (Key Table) File
  license: MIT
  endian: le
  file-extension: key
  imports:
    - ../Common/bioware_type_ids
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: runtime indexing uses CExoKeyTable / CKeyTableEntry (28B, ResRef + pointers + ResourceType);
      on-disk .key layout here remains the Aurora KEY V1 wire format (see PyKotor wiki).
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/key/
    reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/keyreader.cpp
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp
    xoreos_types_kfiletype_key: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L209
    xoreos_key_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp#L50-L88
    xoreos_key_read_bif_list: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp#L90-L117
    xoreos_key_read_res_list: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp#L119-L139
    pykotor_wiki_key: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key
    xoreos_docs_torlack_key: https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163/specs/torlack/key.html
doc: |
  **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
  Resource types use `bioware_type_ids`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key PyKotor wiki — KEY"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp#L50-L88 xoreos — KEY::load"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "KEY " (space-padded).
    valid: "'KEY '"
  
  - id: file_version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Typically "V1  " or "V1.1".
    valid:
      any-of:
        - "'V1  '"
        - "'V1.1'"
  
  - id: bif_count
    type: u4
    doc: Number of BIF files referenced by this KEY file.
  
  - id: key_count
    type: u4
    doc: Number of resource entries in the KEY table.
  
  - id: file_table_offset
    type: u4
    doc: Byte offset to the file table from the beginning of the file.
  
  - id: key_table_offset
    type: u4
    doc: Byte offset to the KEY table from the beginning of the file.
  
  - id: build_year
    type: u4
    doc: Build year (years since 1900).
  
  - id: build_day
    type: u4
    doc: Build day (days since January 1).
  
  - id: reserved
    size: 32
    doc: Reserved padding (usually zeros).

instances:
  file_table:
    pos: file_table_offset
    type: file_table
    if: bif_count > 0
    doc: File table containing BIF file entries.

  key_table:
    pos: key_table_offset
    type: key_table
    if: key_count > 0
    doc: KEY table containing resource entries.

types:
  file_table:
    seq:
      - id: entries
        type: file_entry
        repeat: expr
        repeat-expr: _root.bif_count
        doc: Array of BIF file entries.
  
  file_entry:
    seq:
      - id: file_size
        type: u4
        doc: Size of the BIF file on disk in bytes.
      
      - id: filename_offset
        type: u4
        doc: |
          Absolute byte offset from the start of the KEY file where this BIF's filename is stored
          (seek(filename_offset), then read filename_size bytes).
          This is not relative to the file table or to the end of the BIF entry array.
      
      - id: filename_size
        type: u2
        doc: Length of the filename in bytes (including null terminator).
      
      - id: drives
        type: u2
        doc: |
          Drive flags indicating which media contains the BIF file.
          Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
          Modern distributions typically use 0x0001 (HD) for all files.

    instances:
      filename:
        pos: filename_offset
        type: str
        encoding: ASCII
        size: filename_size
        doc: BIF filename string at the absolute filename_offset in the KEY file.
  
  filename_table:
    seq:
      - id: filenames
        type: str
        encoding: ASCII
        size-eos: true
        doc: |
          Null-terminated BIF filenames concatenated together.
          Each filename is read using the filename_offset and filename_size
          from the corresponding file_entry.
  
  key_table:
    seq:
      - id: entries
        type: key_entry
        repeat: expr
        repeat-expr: _root.key_count
        doc: Array of resource entries.
  
  key_entry:
    seq:
      - id: resref
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Resource filename (ResRef) without extension.
          Null-padded, maximum 16 characters.
          The game uses this name to access the resource.
      
      - id: resource_type
        type: u2
        enum: bioware_type_ids::xoreos_file_type_id
        doc: |
          Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
          `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
      
      - id: resource_id
        type: u4
        doc: |
          Encoded resource location.
          Bits 31-20: BIF index (top 12 bits) - index into file table
          Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
          
          Formula: resource_id = (bif_index << 20) | resource_index
          
          Decoding:
          - bif_index = (resource_id >> 20) & 0xFFF
          - resource_index = resource_id & 0xFFFFF

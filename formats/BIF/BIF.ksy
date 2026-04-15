meta:
  id: bif
  title: BioWare BIF (Binary Index Format) File
  license: MIT
  endian: le
  file-extension: bif
  imports:
    - ../Common/bioware_type_ids
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe loads BIF archives alongside KEY; BIFF V1 on-disk layout matches Aurora tooling (PyKotor/reone/xoreos).
    pykotor: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/bif/
    reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/bifreader.cpp
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/biffile.cpp
    xoreos_types_kfiletype_bif: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L208
    xoreos_bif_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/biffile.cpp#L54-L82
    xoreos_bif_read_var_res_table: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/biffile.cpp#L84-L97
    pykotor_wiki_bif: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif
    xoreos_docs_torlack_bif: https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163/specs/torlack/bif.html
doc: |
  **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
  the paired **KEY** (`KEY.ksy`), not in the BIF.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif PyKotor wiki — BIF"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/biffile.cpp#L54-L82 xoreos — BIFF::load"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "BIFF" for BIF files.
    valid: "'BIFF'"
  
  - id: version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Typically "V1  " or "V1.1".
    valid:
      any-of:
        - "'V1  '"
        - "'V1.1'"
  
  - id: var_res_count
    type: u4
    doc: Number of variable-size resources in this file.
  
  - id: fixed_res_count
    type: u4
    doc: Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
    valid: 0
  
  - id: var_table_offset
    type: u4
    doc: Byte offset to the variable resource table from the beginning of the file.

instances:
  var_resource_table:
    pos: var_table_offset
    type: var_resource_table
    if: var_res_count > 0
    doc: Variable resource table containing entries for each resource.

types:
  var_resource_table:
    seq:
      - id: entries
        type: var_resource_entry
        repeat: expr
        repeat-expr: _root.var_res_count
        doc: Array of variable resource entries.
  
  var_resource_entry:
    seq:
      - id: resource_id
        type: u4
        doc: |
          Resource ID (matches KEY file entry).
          Encodes BIF index (bits 31-20) and resource index (bits 19-0).
          Formula: resource_id = (bif_index << 20) | resource_index
      
      - id: offset
        type: u4
        doc: Byte offset to resource data in file (absolute file offset).
      
      - id: file_size
        type: u4
        doc: Uncompressed size of resource data in bytes.
      
      - id: resource_type
        type: u4
        enum: bioware_type_ids::xoreos_file_type_id
        doc: |
          Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
          read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
          `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.


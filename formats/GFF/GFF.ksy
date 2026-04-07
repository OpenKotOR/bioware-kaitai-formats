meta:
  id: gff
  title: BioWare GFF (Generic File Format) File
  license: MIT
  endian: le
  file-extension: gff
  imports:
    # Path must match formats/Common/BioWare_Common.ksy (case-sensitive on Linux)
    - ../Common/BioWare_Common
  xref:
    kotor_js: https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts
    kotor_net: https://github.com/KotOR-Community-Patches/Kotor.NET/tree/master/Kotor.NET/Formats/KotorGFF/
    kotor_net2: https://github.com/NickHugi/Kotor.NET/tree/master/Kotor.NET/Formats/KotorGFF/  # - .NET GFF reader/writer
    kotor_unity: https://github.com/KotOR-Community-Patches/KotOR-Unity/blob/master/Assets/Scripts/FileObjects/GFFObject.cs
    kotor_unity2: https://github.com/th3w1zard1/KotOR-Unity/blob/master/Assets/Scripts/FileObjects/GFFObject.cs  # - C# Unity GFF loader
    pykotor_gff_data: https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py  # - GFF data model
    pykotor_io_gff: https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py  # - PyKotor binary reader/writer
    pykotor_wiki_gff_aurora: https://github.com/OldRepublicDevs/PyKotor/wiki/Bioware-Aurora-GFF.md
    pykotor_wiki_gff_format: https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md
    pykotor_wiki_tslpatcher: https://github.com/OldRepublicDevs/PyKotor/wiki/TSLPatcher-GFFList-Syntax.md
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/
    reone: https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/gffreader.cpp
    xoreos_docs: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html
    xoreos_gff3file: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp  #  - Generic Aurora GFF implementation (shared format)
    xoreos: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp
doc: |
  GFF (Generic File Format) is BioWare's universal container format for structured game data.
  It is used by many KotOR file types including UTC (creature), UTI (item), DLG (dialogue),
  ARE (area), GIT (game instance template), IFO (module info), and many others.

  GFF uses a hierarchical structure with structs containing fields, which can be simple values,
  nested structs, or lists of structs. The format supports version V3.2 (KotOR) and later
  versions (V3.3, V4.0, V4.1) used in other BioWare games.

  Binary Format Structure:
  - File Header (56 bytes): File type signature (FourCC), version, counts, and offsets to all
    data tables (structs, fields, labels, field_data, field_indices, list_indices)
  - Label Array: Array of 16-byte null-padded field name labels
  - Struct Array: Array of struct entries (12 bytes each) - struct_id, data_or_offset, field_count
  - Field Array: Array of field entries (12 bytes each) - field_type, label_index, data_or_offset
  - Field Data: Storage area for complex field types (strings, binary, vectors, etc.)
  - Field Indices Array: Array of field index arrays (used when structs have multiple fields)
  - List Indices Array: Array of list entry structures (count + struct indices)

  Field Types:
  - Simple types (0-5, 8): Stored inline in data_or_offset (uint8, int8, uint16, int16, uint32,
    int32, float)
  - Complex types (6-7, 9-13, 16-17): Offset to field_data section (uint64, int64, double, string,
    resref, localized_string, binary, vector4, vector3)
  - Struct (14): Struct index stored inline (nested struct)
  - List (15): Offset to list_indices_array (list of structs)

  Struct Access Pattern:
  1. Root struct is always at struct_array index 0
  2. If struct.field_count == 1: data_or_offset contains direct field index
  3. If struct.field_count > 1: data_or_offset contains offset into field_indices_array
  4. Use field_index to access field_array entry
  5. Use field.label_index to get field name from label_array
  6. Use field.data_or_offset based on field_type (inline, offset, struct index, list offset)

  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/GFF-File-Format.md - Complete GFF format documentation
  - https://github.com/OldRepublicDevs/PyKotor/wiki/Bioware-Aurora-GFF.md - Official BioWare Aurora GFF specification
  - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html - Tim Smith/Torlack's GFF/ITP documentation
  - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/gffreader.cpp - Complete C++ GFF reader implementation
  - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp - Generic Aurora GFF implementation (shared format)
  - https://github.com/KotOR-Community-Patches/KotOR.js/blob/master/src/resource/GFFObject.ts - TypeScript GFF parser
  - https://github.com/KotOR-Community-Patches/KotOR-Unity/blob/master/Assets/Scripts/FileObjects/GFFObject.cs - C# Unity GFF loader
  - https://github.com/KotOR-Community-Patches/Kotor.NET/tree/master/Kotor.NET/Formats/KotorGFF/ - .NET GFF reader/writer
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py - PyKotor binary reader/writer
  - https://github.com/OldRepublicDevs/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py - GFF data model

seq:
  - id: header
    type: gff_header
    doc: GFF file header (56 bytes total)

instances:
  label_array:
    type: label_array
    if: header.label_count > 0
    pos: header.label_offset
    doc: Array of 16-byte null-padded field name labels

  struct_array:
    type: struct_array
    if: header.struct_count > 0
    pos: header.struct_offset
    doc: Array of struct entries (12 bytes each)

  field_array:
    type: field_array
    if: header.field_count > 0
    pos: header.field_offset
    doc: Array of field entries (12 bytes each)

  field_data:
    type: field_data
    if: header.field_data_count > 0
    pos: header.field_data_offset
    doc: Storage area for complex field types (strings, binary, vectors, etc.)

  field_indices_array:
    type: field_indices_array
    if: header.field_indices_count > 0
    pos: header.field_indices_offset
    doc: Array of field index arrays (used when structs have multiple fields)

  list_indices_array:
    type: list_indices_array
    if: header.list_indices_count > 0
    pos: header.list_indices_offset
    doc: Array of list entry structures (count + struct indices)

  root_struct_resolved:
    type: resolved_struct(0)
    doc: |
      Convenience "decoded" view of the root struct (struct_array[0]).
      This resolves field indices to field entries, resolves labels to strings,
      and decodes field values (including nested structs and lists) into typed instances.

types:
  gff_header:
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature (FourCC). Examples: "GFF ", "UTC ", "UTI ", "DLG ", "ARE ", etc.
          Must match a valid GFFContent enum value.

      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Must be "V3.2" for KotOR games.
          Later BioWare games use "V3.3", "V4.0", or "V4.1".
          Valid values: "V3.2" (KotOR), "V3.3", "V4.0", "V4.1" (other BioWare games)

      - id: struct_offset
        type: u4
        doc: Byte offset to struct array from beginning of file

      - id: struct_count
        type: u4
        doc: Number of struct entries in struct array

      - id: field_offset
        type: u4
        doc: Byte offset to field array from beginning of file

      - id: field_count
        type: u4
        doc: Number of field entries in field array

      - id: label_offset
        type: u4
        doc: Byte offset to label array from beginning of file

      - id: label_count
        type: u4
        doc: Number of labels in label array

      - id: field_data_offset
        type: u4
        doc: Byte offset to field data section from beginning of file

      - id: field_data_count
        type: u4
        doc: Size of field data section in bytes

      - id: field_indices_offset
        type: u4
        doc: Byte offset to field indices array from beginning of file

      - id: field_indices_count
        type: u4
        doc: Number of field indices (total count across all structs with multiple fields)

      - id: list_indices_offset
        type: u4
        doc: Byte offset to list indices array from beginning of file

      - id: list_indices_count
        type: u4
        doc: Number of list indices entries

  label_array:
    seq:
      - id: labels
        type: label_entry
        repeat: expr
        repeat-expr: _root.header.label_count
        doc: Array of label entries (16 bytes each)

  label_entry:
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Field name label (null-padded to 16 bytes, null-terminated).
          The actual label length is determined by the first null byte.
          Application code should trim trailing null bytes when using this field.

  struct_array:
    seq:
      - id: entries
        type: struct_entry
        repeat: expr
        repeat-expr: _root.header.struct_count
        doc: Array of struct entries (12 bytes each)

  struct_entry:
    seq:
      - id: struct_id
        type: s4
        doc: |
          Structure type identifier. Often 0xFFFFFFFF (-1) for generic structs.
          Used to identify struct types in schema-aware parsers.

      - id: data_or_offset
        type: u4
        doc: |
          Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
          If field_count == 0, this value is unused.

      - id: field_count
        type: u4
        doc: |
          Number of fields in this struct:
          - 0: No fields
          - 1: Single field, data_or_offset contains the field index directly
          - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
    instances:
      has_single_field:
        value: field_count == 1
        doc: True if struct has exactly one field (direct field index in data_or_offset)
      has_multiple_fields:
        value: field_count > 1
        doc: True if struct has multiple fields (offset to field indices in data_or_offset)
      single_field_index:
        value: data_or_offset
        if: has_single_field
        doc: Direct field index when struct has exactly one field
      field_indices_offset:
        value: data_or_offset
        if: has_multiple_fields
        doc: Byte offset into field_indices_array when struct has multiple fields

  field_array:
    seq:
      - id: entries
        type: field_entry
        repeat: expr
        repeat-expr: _root.header.field_count
        doc: Array of field entries (12 bytes each)

  field_entry:
    seq:
      - id: field_type
        type: u4
        enum: gff_field_type
        doc: |
          Field data type (see gff_field_type enum):
          - 0-5, 8: Simple types (stored inline in data_or_offset)
          - 6-7, 9-13, 16-17: Complex types (offset to field_data in data_or_offset)
          - 14: Struct (struct index in data_or_offset)
          - 15: List (offset to list_indices_array in data_or_offset)

      - id: label_index
        type: u4
        doc: Index into label_array for field name

      - id: data_or_offset
        type: u4
        doc: |
          Inline data (simple types) or offset/index (complex types):
          - Simple types (0-5, 8): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
          - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
          - Struct (14): Struct index (index into struct_array)
          - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
    instances:
      is_simple_type:
        value: |
          field_type == gff_field_type::uint8 or
          field_type == gff_field_type::int8 or
          field_type == gff_field_type::uint16 or
          field_type == gff_field_type::int16 or
          field_type == gff_field_type::uint32 or
          field_type == gff_field_type::int32 or
          field_type == gff_field_type::single
        doc: True if field stores data inline (simple types)
      is_complex_type:
        value: |
          field_type == gff_field_type::uint64 or
          field_type == gff_field_type::int64 or
          field_type == gff_field_type::double or
          field_type == gff_field_type::string or
          field_type == gff_field_type::resref or
          field_type == gff_field_type::localized_string or
          field_type == gff_field_type::binary or
          field_type == gff_field_type::vector4 or
          field_type == gff_field_type::vector3
        doc: True if field stores data in field_data section
      is_struct_type:
        value: field_type == gff_field_type::struct
        doc: True if field is a nested struct
      is_list_type:
        value: field_type == gff_field_type::list
        doc: True if field is a list of structs
      field_data_offset_value:
        value: _root.header.field_data_offset + data_or_offset
        if: is_complex_type
        doc: Absolute file offset to field data for complex types
      struct_index_value:
        value: data_or_offset
        if: is_struct_type
        doc: Struct index for struct type fields
      list_indices_offset_value:
        value: _root.header.list_indices_offset + data_or_offset
        if: is_list_type
        doc: Absolute file offset to list indices for list type fields

  field_data:
    seq:
      - id: raw_data
        size: _root.header.field_data_count
        doc: |
          Raw field data storage. Individual field data entries are accessed via
          field_entry.field_data_offset_value offsets. The structure of each entry
          depends on the field_type:
          - UInt64/Int64/Double: 8 bytes
          - String: 4-byte length + string bytes
          - ResRef: 1-byte length + string bytes (max 16)
          - LocalizedString: variable (see bioware_common::bioware_locstring type)
          - Binary: 4-byte length + binary bytes
          - Vector3: 12 bytes (3×float)
          - Vector4: 16 bytes (4×float)

  field_indices_array:
    seq:
      - id: indices
        type: u4
        repeat: expr
        repeat-expr: _root.header.field_indices_count
        doc: |
          Array of field indices. When a struct has multiple fields, it stores an offset
          into this array, and the next N consecutive u4 values (where N = struct.field_count)
          are the field indices for that struct.

  list_indices_array:
    seq:
      - id: raw_data
        size: _root.header.list_indices_count
        doc: |
          Raw list indices data. List entries are accessed via offsets stored in
          list-type field entries (field_entry.list_indices_offset_value).
          Each entry starts with a count (u4), followed by that many struct indices (u4 each).

          Note: This is a raw data block. In practice, list entries are accessed via
          offsets stored in list-type field entries, not as a sequential array.
          Use list_entry type to parse individual entries at specific offsets.


  list_entry:
    seq:
      - id: num_struct_indices
        type: u4
        doc: Number of struct indices in this list
      - id: struct_indices
        type: u4
        repeat: expr
        repeat-expr: num_struct_indices
        doc: Array of struct indices (indices into struct_array)

  # NOTE: For field data parsing, use bioware_common types directly:
  # - bioware_common::bioware_resref for ResRef fields
  # - bioware_common::bioware_cexo_string for String fields
  # - bioware_common::bioware_locstring for LocalizedString fields
  # - bioware_common::bioware_vector3 for Vector3 fields
  # - bioware_common::bioware_vector4 for Vector4 fields
  # - bioware_common::bioware_binary_data for Binary fields

  # ----------------------------
  # Higher-level resolved views
  # ----------------------------

  label_entry_terminated:
    doc: |
      Label entry as a null-terminated ASCII string within a fixed 16-byte field.
      This avoids leaking trailing `\0` bytes into generated-code consumers.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        terminator: 0
        include: false

  resolved_struct:
    doc: |
      A decoded struct node: resolves field indices -> field entries -> typed values,
      and recursively resolves nested structs and lists.
    params:
      - id: struct_index
        type: u4
        doc: Index into struct_array
    instances:
      entry:
        type: struct_entry
        pos: _root.header.struct_offset + struct_index * 12
        doc: Raw struct entry at struct_index

      field_indices:
        type: u4
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        pos: _root.header.field_indices_offset + entry.data_or_offset
        doc: |
          Field indices for this struct (only present when field_count > 1).
          When field_count == 1, the single field index is stored directly in entry.data_or_offset.

      fields:
        type: resolved_field(field_indices[_index])
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        doc: Resolved fields (multi-field struct)

      single_field:
        type: resolved_field(entry.data_or_offset)
        if: entry.field_count == 1
        doc: Resolved field (single-field struct)

  resolved_field:
    doc: |
      A decoded field: includes resolved label string and decoded typed value.
      Exactly one `value_*` instance (or one of `value_struct` / `list_*`) will be non-null.
    params:
      - id: field_index
        type: u4
        doc: Index into field_array
    instances:
      entry:
        type: field_entry
        pos: _root.header.field_offset + field_index * 12
        doc: Raw field entry at field_index

      label:
        type: label_entry_terminated
        pos: _root.header.label_offset + entry.label_index * 16
        doc: Resolved field label string

      field_entry_pos:
        value: _root.header.field_offset + field_index * 12
        doc: Absolute file offset of this field entry (start of 12-byte record)

      # Inline/simple field types (stored directly in the 4-byte data_or_offset slot)
      value_uint8:
        type: u1
        if: entry.field_type == gff_field_type::uint8
        pos: field_entry_pos + 8
      value_int8:
        type: s1
        if: entry.field_type == gff_field_type::int8
        pos: field_entry_pos + 8
      value_uint16:
        type: u2
        if: entry.field_type == gff_field_type::uint16
        pos: field_entry_pos + 8
      value_int16:
        type: s2
        if: entry.field_type == gff_field_type::int16
        pos: field_entry_pos + 8
      value_uint32:
        type: u4
        if: entry.field_type == gff_field_type::uint32
        pos: field_entry_pos + 8
      value_int32:
        type: s4
        if: entry.field_type == gff_field_type::int32
        pos: field_entry_pos + 8
      value_single:
        type: f4
        if: entry.field_type == gff_field_type::single
        pos: field_entry_pos + 8

      # Complex field types (stored in field_data section, offset is entry.data_or_offset)
      value_uint64:
        type: u8
        if: entry.field_type == gff_field_type::uint64
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_int64:
        type: s8
        if: entry.field_type == gff_field_type::int64
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_double:
        type: f8
        if: entry.field_type == gff_field_type::double
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_string:
        type: bioware_common::bioware_cexo_string
        if: entry.field_type == gff_field_type::string
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_resref:
        type: bioware_common::bioware_resref
        if: entry.field_type == gff_field_type::resref
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_localized_string:
        type: bioware_common::bioware_locstring
        if: entry.field_type == gff_field_type::localized_string
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_binary:
        type: bioware_common::bioware_binary_data
        if: entry.field_type == gff_field_type::binary
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_vector4:
        type: bioware_common::bioware_vector4
        if: entry.field_type == gff_field_type::vector4
        pos: _root.header.field_data_offset + entry.data_or_offset
      value_vector3:
        type: bioware_common::bioware_vector3
        if: entry.field_type == gff_field_type::vector3
        pos: _root.header.field_data_offset + entry.data_or_offset

      # Nested struct and list types (stored as indices/offsets in entry.data_or_offset)
      value_struct:
        type: resolved_struct(entry.data_or_offset)
        if: entry.field_type == gff_field_type::struct
        doc: Nested struct (struct index = entry.data_or_offset)

      list_entry:
        type: list_entry
        if: entry.field_type == gff_field_type::list
        pos: _root.header.list_indices_offset + entry.data_or_offset
        doc: Parsed list entry at offset (list indices)

      list_structs:
        type: resolved_struct(list_entry.struct_indices[_index])
        repeat: expr
        repeat-expr: list_entry.num_struct_indices
        if: entry.field_type == gff_field_type::list
        doc: Resolved structs referenced by this list

enums:
  gff_field_type:
    0: uint8
    1: int8
    2: uint16
    3: int16
    4: uint32
    5: int32
    6: uint64
    7: int64
    8: single
    9: double
    10: string
    11: resref
    12: localized_string
    13: binary
    14: struct
    15: list
    16: vector4
    17: vector3


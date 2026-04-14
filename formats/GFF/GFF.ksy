meta:
  id: gff
  title: BioWare GFF (Generic File Format) File
  license: MIT
  endian: le
  file-extension: gff
  imports:
    - ../common/bioware_common
  xref:
    # Canonical format write-up (sections: File Header, Label Array, Struct Array, Field Array, Field Data,
    # Field Indices, List Indices, GFF Data Types). Per-field citations below use these URLs + anchors.
    wiki:
      gff: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
      aurora_gff: https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff
      tslpatcher_gfflist: https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFF-Syntax#gfflist-syntax
    pykotor:
      package: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff
      io_gff: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py
      gff_data: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py
doc: |
  GFF (Generic File Format) is BioWare’s hierarchical binary container for structured game data (KotOR/TSL
  and other Aurora-family titles). **Normative community documentation:** OpenKotOR PyKotor wiki
  [GFF File Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format) (binary layout, field types,
  struct/field/list access). Related: [Bioware Aurora GFF](https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff),
  [TSLPatcher GFFList](https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFF-Syntax#gfflist-syntax).

  **PyKotor reference implementation:** [resource/formats/gff/](https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff)
  ([io_gff.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py),
  [gff_data.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py)).

  **EXE/Ghidra (KotOR1):** On-disk record names and image addresses are **not** repeated here — they are cited
  on the specific `types` / `seq` / `enums` nodes they justify (e.g. `GFFHeaderInfo` field offsets under
  `gff_header`, `CResGFF::GetField` @ `0x00410990` next to `field_entry`, `GFFFieldTypes` values under
  `gff_field_type`). This file describes wire bytes; the game builds in-memory `CResGFF` views from them.

  Summary (see wiki [Binary Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#binary-format)):
  - 56-byte header → offsets/counts for label, struct, field, field-data, field-indices, and list-indices arenas
  - 12-byte struct rows and 12-byte field rows; field types and inline vs field-data storage per [GFF Data Types](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
  - Root struct index 0; single-field vs multi-field indexing: [Field Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap), [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices)

seq:
  - id: header
    type: gff_header
    doc: |
      Wire header (56 B). Ghidra: `GFFHeaderInfo` on `/K1/k1_win_gog_swkotor.exe`.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header — full offset/size table.

instances:
  label_array:
    type: label_array
    if: header.label_count > 0
    pos: header.label_offset
    doc: |
      Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
      Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

  struct_array:
    type: struct_array
    if: header.struct_count > 0
    pos: header.struct_offset
    doc: |
      Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array

  field_array:
    type: field_array
    if: header.field_count > 0
    pos: header.field_offset
    doc: |
      Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
      `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array

  field_data:
    type: field_data
    if: header.field_data_count > 0
    pos: header.field_data_offset
    doc: |
      Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

  field_indices_array:
    type: field_indices_array
    if: header.field_indices_count > 0
    pos: header.field_indices_offset
    doc: |
      Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
      Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap

  list_indices_array:
    type: list_indices_array
    if: header.list_indices_count > 0
    pos: header.list_indices_offset
    doc: |
      Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
      Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
      Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices

  root_struct_resolved:
    type: resolved_struct(0)
    doc: |
      Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
      Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
      Implements the access pattern described in meta.doc (single-field vs multi-field structs).

types:
  gff_header:
    doc: |
      56-byte header: wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) table.
      Ghidra `/K1/k1_win_gog_swkotor.exe`: datatype `GFFHeaderInfo` — each `seq` field below names the matching column + offset.
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature (FourCC), e.g. `"UTC "`, `"DLG "`, `"ARE "`. Wiki `File Header` row “File Type”, offset 0x00.
          Source: Ghidra `GFFHeaderInfo.file_type` @ +0x0 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.

      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          Format version; KotOR uses `"V3.2"`. Wiki `File Header` row “File Version”, offset 0x04.
          Source: Ghidra `GFFHeaderInfo.file_version` @ +0x4 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.

      - id: struct_offset
        type: u4
        doc: |
          Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
          Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).

      - id: struct_count
        type: u4
        doc: |
          Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
          Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).

      - id: field_offset
        type: u4
        doc: |
          Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
          Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).

      - id: field_count
        type: u4
        doc: |
          Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
          Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).

      - id: label_offset
        type: u4
        doc: |
          Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
          Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).

      - id: label_count
        type: u4
        doc: |
          Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
          Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).

      - id: field_data_offset
        type: u4
        doc: |
          Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
          Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).

      - id: field_data_count
        type: u4
        doc: |
          Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
          Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).

      - id: field_indices_offset
        type: u4
        doc: |
          Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
          Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).

      - id: field_indices_count
        type: u4
        doc: |
          Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
          Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).

      - id: list_indices_offset
        type: u4
        doc: |
          Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
          Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).

      - id: list_indices_count
        type: u4
        doc: |
          List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
          Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
          Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).

  label_array:
    doc: |
      Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
      Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
    seq:
      - id: labels
        type: label_entry
        repeat: expr
        repeat-expr: _root.header.label_count
        doc: |
          Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
          Index `i` is at file offset `label_offset + i*16`.

  label_entry:
    doc: |
      One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
          Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
          Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

  struct_array:
    doc: |
      Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
    seq:
      - id: entries
        type: struct_entry
        repeat: expr
        repeat-expr: _root.header.struct_count
        doc: |
          Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
          Stride 12 bytes per struct (matches Ghidra component sizes).

  struct_entry:
    doc: |
      One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
    seq:
      - id: struct_id
        type: u4
        doc: |
          Structure type identifier.
          Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
          0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.

      - id: data_or_offset
        type: u4
        doc: |
          Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
          If field_count == 0, this value is unused.
          Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).

      - id: field_count
        type: u4
        doc: |
          Number of fields in this struct:
          - 0: No fields
          - 1: Single field, data_or_offset contains the field index directly
          - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
          Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
    instances:
      has_single_field:
        value: field_count == 1
        doc: |
          Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
          Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
      has_multiple_fields:
        value: field_count > 1
        doc: |
          Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
      single_field_index:
        value: data_or_offset
        if: has_single_field
        doc: |
          Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
      field_indices_offset:
        value: data_or_offset
        if: has_multiple_fields
        doc: |
          Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.

  field_array:
    doc: |
      Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
    seq:
      - id: entries
        type: field_entry
        repeat: expr
        repeat-expr: _root.header.field_count
        doc: |
          Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
          Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).

  field_entry:
    doc: |
      One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
      `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
    seq:
      - id: field_type
        type: u4
        enum: gff_field_type
        doc: |
          Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
          (ID → storage: inline vs `field_data` vs struct/list indirection).
          Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
          Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
          Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.

      - id: label_index
        type: u4
        doc: |
          Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
          Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).

      - id: data_or_offset
        type: u4
        doc: |
          Inline data (simple types) or offset/index (complex types):
          - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
          - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
          - Struct (14): Struct index (index into struct_array)
          - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
          Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
          `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    instances:
      is_simple_type:
        value: |
          field_type == gff_field_type::uint8 or
          field_type == gff_field_type::int8 or
          field_type == gff_field_type::uint16 or
          field_type == gff_field_type::int16 or
          field_type == gff_field_type::uint32 or
          field_type == gff_field_type::int32 or
          field_type == gff_field_type::single or
          field_type == gff_field_type::str_ref
        doc: |
          Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
          Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
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
        doc: |
          Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
      is_struct_type:
        value: field_type == gff_field_type::struct
        doc: |
          Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
      is_list_type:
        value: field_type == gff_field_type::list
        doc: |
          Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
      field_data_offset_value:
        value: _root.header.field_data_offset + data_or_offset
        if: is_complex_type
        doc: |
          Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
      struct_index_value:
        value: data_or_offset
        if: is_struct_type
        doc: |
          Struct index (same numeric interpretation as `GFFStructData` row index).
      list_indices_offset_value:
        value: _root.header.list_indices_offset + data_or_offset
        if: is_list_type
        doc: |
          Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.

  field_data:
    doc: |
      Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
    seq:
      - id: raw_data
        size: _root.header.field_data_count
        doc: |
          Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
          Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
          Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

  field_indices_array:
    doc: |
      Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
    seq:
      - id: indices
        type: u4
        repeat: expr
        repeat-expr: _root.header.field_indices_count
        doc: |
          `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
          `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
          Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.

  list_indices_array:
    doc: |
      Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
    seq:
      - id: raw_data
        size: _root.header.list_indices_count
        doc: |
          Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
          Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
          This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.

  list_entry:
    doc: |
      One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
    seq:
      - id: num_struct_indices
        type: u4
        doc: |
          Little-endian count of following struct indices (list cardinality).
          Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
      - id: struct_indices
        type: u4
        repeat: expr
        repeat-expr: num_struct_indices
        doc: |
          Each value indexes `struct_array.entries[index]` (`GFFStructData` row).

  # Complex payloads: formats/Common/BioWare_Common.ksy (bioware_cexo_string, bioware_resref,
  # bioware_locstring, bioware_vector3/4, bioware_binary_data). Cross-audit those .ksy files against
  # the same /K1/k1_win_gog_swkotor.exe when verifying full engine parity.

  # ----------------------------
  # Higher-level resolved views
  # ----------------------------

  label_entry_terminated:
    doc: |
      Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
      Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        terminator: 0
        include: false
        doc: |
          Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.

  resolved_struct:
    doc: |
      Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
      On-disk row remains at `struct_offset + struct_index * 12`.
    params:
      - id: struct_index
        type: u4
        doc: |
          Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
    instances:
      entry:
        type: struct_entry
        pos: _root.header.struct_offset + struct_index * 12
        doc: |
          Raw `GFFStructData` (Ghidra 12-byte layout).

      field_indices:
        type: u4
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        pos: _root.header.field_indices_offset + entry.data_or_offset
        doc: |
          Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
          Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).

      fields:
        type: resolved_field(field_indices[_index])
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        doc: |
          One `resolved_field` per entry in `field_indices`.

      single_field:
        type: resolved_field(entry.data_or_offset)
        if: entry.field_count == 1
        doc: |
          `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).

  resolved_field:
    doc: |
      Kaitai composition: one `GFFFieldData` row + label + payload.
      Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
      Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
      For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
    params:
      - id: field_index
        type: u4
        doc: |
          Index into `field_array.entries`; require `field_index < field_count`.
    instances:
      entry:
        type: field_entry
        pos: _root.header.field_offset + field_index * 12
        doc: |
          Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).

      label:
        type: label_entry_terminated
        pos: _root.header.label_offset + entry.label_index * 16
        doc: |
          Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.

      field_entry_pos:
        value: _root.header.field_offset + field_index * 12
        doc: |
          Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).

      # Inline/simple types — payload in the DWORD at file offset field_entry_pos+8
      value_uint8:
        type: u1
        if: entry.field_type == gff_field_type::uint8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
      value_int8:
        type: s1
        if: entry.field_type == gff_field_type::int8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 1 (INT8 in low byte of slot).
      value_uint16:
        type: u2
        if: entry.field_type == gff_field_type::uint16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 2 (UINT16 LE at +8).
      value_int16:
        type: s2
        if: entry.field_type == gff_field_type::int16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 3 (INT16 LE at +8).
      value_uint32:
        type: u4
        if: entry.field_type == gff_field_type::uint32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 4 (full inline DWORD).
      value_int32:
        type: s4
        if: entry.field_type == gff_field_type::int32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
      value_single:
        type: f4
        if: entry.field_type == gff_field_type::single
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 8 (32-bit float).
      value_str_ref:
        type: u4
        if: entry.field_type == gff_field_type::str_ref
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
          `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref

      # Complex — payload in field_data blob
      value_uint64:
        type: u8
        if: entry.field_type == gff_field_type::uint64
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
      value_int64:
        type: s8
        if: entry.field_type == gff_field_type::int64
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 7 (INT64).
      value_double:
        type: f8
        if: entry.field_type == gff_field_type::double
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 9 (double).
      value_string:
        type: bioware_common::bioware_cexo_string
        if: entry.field_type == gff_field_type::string
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
      value_resref:
        type: bioware_common::bioware_resref
        if: entry.field_type == gff_field_type::resref
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
      value_localized_string:
        type: bioware_common::bioware_locstring
        if: entry.field_type == gff_field_type::localized_string
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
      value_binary:
        type: bioware_common::bioware_binary_data
        if: entry.field_type == gff_field_type::binary
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
      value_vector4:
        type: bioware_common::bioware_vector4
        if: entry.field_type == gff_field_type::vector4
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
      value_vector3:
        type: bioware_common::bioware_vector3
        if: entry.field_type == gff_field_type::vector3
        pos: _root.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 17 — three floats (`bioware_vector3`).

      # Struct / list — index or offset in data_or_offset (+8)
      value_struct:
        type: resolved_struct(entry.data_or_offset)
        if: entry.field_type == gff_field_type::struct
        doc: |
          `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.

      list_entry:
        type: list_entry
        if: entry.field_type == gff_field_type::list
        pos: _root.header.list_indices_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.

      list_structs:
        type: resolved_struct(list_entry.struct_indices[_index])
        repeat: expr
        repeat-expr: list_entry.num_struct_indices
        if: entry.field_type == gff_field_type::list
        doc: |
          Child structs for this list; indices from `list_entry.struct_indices`.

enums:
  gff_field_type:
    0:
      id: uint8
      doc: |
        Numeric 0 — UINT8; value in `GFFFieldData.data_or_data_offset` (+8). Ghidra `/K1/k1_win_gog_swkotor.exe`:
        `GFFFieldTypes` on `GFFFieldData.field_type` @ +0. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    1:
      id: int8
      doc: |
        Numeric 1 — INT8 in low byte of the 4-byte inline slot (+8).
    2:
      id: uint16
      doc: |
        Numeric 2 — UINT16 LE at +8.
    3:
      id: int16
      doc: |
        Numeric 3 — INT16 LE at +8.
    4:
      id: uint32
      doc: |
        Numeric 4 — UINT32; full inline DWORD at +8.
    5:
      id: int32
      doc: |
        Numeric 5 — INT32 inline. Engine: `CResGFF::ReadFieldINT` @ `0x00411c90` (uses `GetField` @ `0x00410990`).
    6:
      id: uint64
      doc: |
        Numeric 6 — UINT64 payload in `field_data` at `field_data_offset` + relative offset from +8.
    7:
      id: int64
      doc: |
        Numeric 7 — INT64 in `field_data`.
    8:
      id: single
      doc: |
        Numeric 8 — 32-bit IEEE float inline at +8.
    9:
      id: double
      doc: |
        Numeric 9 — 64-bit IEEE float in `field_data`.
    10:
      id: string
      doc: |
        Numeric 10 — CExoString in `field_data` (`bioware_cexo_string` in this repo).
    11:
      id: resref
      doc: |
        Numeric 11 — ResRef in `field_data` (`bioware_resref`).
    12:
      id: localized_string
      doc: |
        Numeric 12 — CExoLocString in `field_data` (`bioware_locstring`).
    13:
      id: binary
      doc: |
        Numeric 13 — length-prefixed octets in `field_data` (`bioware_binary_data`).
    14:
      id: struct
      doc: |
        Numeric 14 — nested struct; +8 word is index into `GFFStructData` table (`struct_offset` + index×12).
    15:
      id: list
      doc: |
        Numeric 15 — list; +8 word is byte offset into list-indices arena (`list_indices_offset` + offset).
    16:
      id: vector4
      doc: |
        Numeric 16 — four floats in `field_data` (`bioware_vector4`).
    17:
      id: vector3
      doc: |
        Numeric 17 — three floats in `field_data` (`bioware_vector3`).
    18:
      id: str_ref
      doc: |
        Numeric 18 — TLK StrRef (inline DWORD at +8). KotOR extension; same width as type 5, distinct field kind in data.
        Ghidra: `GFFFieldTypes` on `/K1/k1_win_gog_swkotor.exe`.
        Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types — row “StrRef”; StrRef semantics: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref


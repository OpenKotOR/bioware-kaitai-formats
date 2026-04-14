#ifndef GFF_H_
#define GFF_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class gff_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_common.h"
#include <set>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * GFF (Generic File Format) is BioWare’s hierarchical binary container for structured game data (KotOR/TSL
 * and other Aurora-family titles). **Normative community documentation:** OpenKotOR PyKotor wiki
 * [GFF File Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format) (binary layout, field types,
 * struct/field/list access). Related: [Bioware Aurora GFF](https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff),
 * [TSLPatcher GFFList](https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFF-Syntax#gfflist-syntax).
 * 
 * **PyKotor reference implementation:** [resource/formats/gff/](https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/gff)
 * ([io_gff.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py),
 * [gff_data.py](https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py)).
 * 
 * **EXE/Ghidra (KotOR1):** On-disk record names and image addresses are **not** repeated here — they are cited
 * on the specific `types` / `seq` / `enums` nodes they justify (e.g. `GFFHeaderInfo` field offsets under
 * `gff_header`, `CResGFF::GetField` @ `0x00410990` next to `field_entry`, `GFFFieldTypes` values under
 * `gff_field_type`). This file describes wire bytes; the game builds in-memory `CResGFF` views from them.
 * 
 * Summary (see wiki [Binary Format](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#binary-format)):
 * - 56-byte header → offsets/counts for label, struct, field, field-data, field-indices, and list-indices arenas
 * - 12-byte struct rows and 12-byte field rows; field types and inline vs field-data storage per [GFF Data Types](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types)
 * - Root struct index 0; single-field vs multi-field indexing: [Field Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap), [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices)
 */

class gff_t : public kaitai::kstruct {

public:
    class field_array_t;
    class field_data_t;
    class field_entry_t;
    class field_indices_array_t;
    class gff_header_t;
    class label_array_t;
    class label_entry_t;
    class label_entry_terminated_t;
    class list_entry_t;
    class list_indices_array_t;
    class resolved_field_t;
    class resolved_struct_t;
    class struct_array_t;
    class struct_entry_t;

    enum gff_field_type_t {
        GFF_FIELD_TYPE_UINT8 = 0,
        GFF_FIELD_TYPE_INT8 = 1,
        GFF_FIELD_TYPE_UINT16 = 2,
        GFF_FIELD_TYPE_INT16 = 3,
        GFF_FIELD_TYPE_UINT32 = 4,
        GFF_FIELD_TYPE_INT32 = 5,
        GFF_FIELD_TYPE_UINT64 = 6,
        GFF_FIELD_TYPE_INT64 = 7,
        GFF_FIELD_TYPE_SINGLE = 8,
        GFF_FIELD_TYPE_DOUBLE = 9,
        GFF_FIELD_TYPE_STRING = 10,
        GFF_FIELD_TYPE_RESREF = 11,
        GFF_FIELD_TYPE_LOCALIZED_STRING = 12,
        GFF_FIELD_TYPE_BINARY = 13,
        GFF_FIELD_TYPE_STRUCT = 14,
        GFF_FIELD_TYPE_LIST = 15,
        GFF_FIELD_TYPE_VECTOR4 = 16,
        GFF_FIELD_TYPE_VECTOR3 = 17,
        GFF_FIELD_TYPE_STR_REF = 18
    };
    static bool _is_defined_gff_field_type_t(gff_field_type_t v);

private:
    static const std::set<gff_field_type_t> _values_gff_field_type_t;
    static std::set<gff_field_type_t> _build_values_gff_field_type_t();

public:

    gff_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~gff_t();

    /**
     * Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
     */

    class field_array_t : public kaitai::kstruct {

    public:

        field_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_array_t();

    private:
        std::vector<field_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
         * Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).
         */
        std::vector<field_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
     */

    class field_data_t : public kaitai::kstruct {

    public:

        field_data_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_data_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
         * Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
         * Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
     * `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
     */

    class field_entry_t : public kaitai::kstruct {

    public:

        field_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_entry_t();

    private:
        bool f_field_data_offset_value;
        int32_t m_field_data_offset_value;
        bool n_field_data_offset_value;

    public:
        bool _is_null_field_data_offset_value() { field_data_offset_value(); return n_field_data_offset_value; };

    private:

    public:

        /**
         * Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
         */
        int32_t field_data_offset_value();

    private:
        bool f_is_complex_type;
        bool m_is_complex_type;

    public:

        /**
         * Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
         */
        bool is_complex_type();

    private:
        bool f_is_list_type;
        bool m_is_list_type;

    public:

        /**
         * Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
         */
        bool is_list_type();

    private:
        bool f_is_simple_type;
        bool m_is_simple_type;

    public:

        /**
         * Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
         * Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
         */
        bool is_simple_type();

    private:
        bool f_is_struct_type;
        bool m_is_struct_type;

    public:

        /**
         * Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
         */
        bool is_struct_type();

    private:
        bool f_list_indices_offset_value;
        int32_t m_list_indices_offset_value;
        bool n_list_indices_offset_value;

    public:
        bool _is_null_list_indices_offset_value() { list_indices_offset_value(); return n_list_indices_offset_value; };

    private:

    public:

        /**
         * Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.
         */
        int32_t list_indices_offset_value();

    private:
        bool f_struct_index_value;
        uint32_t m_struct_index_value;
        bool n_struct_index_value;

    public:
        bool _is_null_struct_index_value() { struct_index_value(); return n_struct_index_value; };

    private:

    public:

        /**
         * Struct index (same numeric interpretation as `GFFStructData` row index).
         */
        uint32_t struct_index_value();

    private:
        gff_field_type_t m_field_type;
        uint32_t m_label_index;
        uint32_t m_data_or_offset;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         * (ID → storage: inline vs `field_data` vs struct/list indirection).
         * Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
         * Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
         * Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
         */
        gff_field_type_t field_type() const { return m_field_type; }

        /**
         * Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
         * Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).
         */
        uint32_t label_index() const { return m_label_index; }

        /**
         * Inline data (simple types) or offset/index (complex types):
         * - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
         * - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
         * - Struct (14): Struct index (index into struct_array)
         * - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
         * Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
         * `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
     */

    class field_indices_array_t : public kaitai::kstruct {

    public:

        field_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~field_indices_array_t();

    private:
        std::vector<uint32_t>* m_indices;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
         * `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
         * Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.
         */
        std::vector<uint32_t>* indices() const { return m_indices; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * 56-byte header: wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) table.
     * Ghidra `/K1/k1_win_gog_swkotor.exe`: datatype `GFFHeaderInfo` — each `seq` field below names the matching column + offset.
     */

    class gff_header_t : public kaitai::kstruct {

    public:

        gff_header_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~gff_header_t();

    private:
        std::string m_file_type;
        std::string m_file_version;
        uint32_t m_struct_offset;
        uint32_t m_struct_count;
        uint32_t m_field_offset;
        uint32_t m_field_count;
        uint32_t m_label_offset;
        uint32_t m_label_count;
        uint32_t m_field_data_offset;
        uint32_t m_field_data_count;
        uint32_t m_field_indices_offset;
        uint32_t m_field_indices_count;
        uint32_t m_list_indices_offset;
        uint32_t m_list_indices_count;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * File type signature (FourCC), e.g. `"UTC "`, `"DLG "`, `"ARE "`. Wiki `File Header` row “File Type”, offset 0x00.
         * Source: Ghidra `GFFHeaderInfo.file_type` @ +0x0 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.
         */
        std::string file_type() const { return m_file_type; }

        /**
         * Format version; KotOR uses `"V3.2"`. Wiki `File Header` row “File Version”, offset 0x04.
         * Source: Ghidra `GFFHeaderInfo.file_version` @ +0x4 (char[4]) on `/K1/k1_win_gog_swkotor.exe`.
         */
        std::string file_version() const { return m_file_version; }

        /**
         * Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
         * Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
         */
        uint32_t struct_offset() const { return m_struct_offset; }

        /**
         * Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
         * Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
         */
        uint32_t struct_count() const { return m_struct_count; }

        /**
         * Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
         * Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
         */
        uint32_t field_offset() const { return m_field_offset; }

        /**
         * Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
         * Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
         */
        uint32_t field_count() const { return m_field_count; }

        /**
         * Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
         * Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
         */
        uint32_t label_offset() const { return m_label_offset; }

        /**
         * Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
         * Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
         */
        uint32_t label_count() const { return m_label_count; }

        /**
         * Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
         * Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
         */
        uint32_t field_data_offset() const { return m_field_data_offset; }

        /**
         * Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
         * Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
         */
        uint32_t field_data_count() const { return m_field_data_count; }

        /**
         * Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
         * Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
         */
        uint32_t field_indices_offset() const { return m_field_indices_offset; }

        /**
         * Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
         * Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
         */
        uint32_t field_indices_count() const { return m_field_indices_count; }

        /**
         * Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
         * Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
         */
        uint32_t list_indices_offset() const { return m_list_indices_offset; }

        /**
         * List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
         * Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
         * Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
         */
        uint32_t list_indices_count() const { return m_list_indices_count; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
     * Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
     */

    class label_array_t : public kaitai::kstruct {

    public:

        label_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_array_t();

    private:
        std::vector<label_entry_t*>* m_labels;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
         * Index `i` is at file offset `label_offset + i*16`.
         */
        std::vector<label_entry_t*>* labels() const { return m_labels; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
     */

    class label_entry_t : public kaitai::kstruct {

    public:

        label_entry_t(kaitai::kstream* p__io, gff_t::label_array_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_entry_t();

    private:
        std::string m_name;
        gff_t* m__root;
        gff_t::label_array_t* m__parent;

    public:

        /**
         * Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
         * Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
         * Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
         * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
         */
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::label_array_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
     * Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
     */

    class label_entry_terminated_t : public kaitai::kstruct {

    public:

        label_entry_terminated_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~label_entry_terminated_t();

    private:
        std::string m_name;
        gff_t* m__root;
        gff_t::resolved_field_t* m__parent;

    public:

        /**
         * Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.
         */
        std::string name() const { return m_name; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

    /**
     * One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
     */

    class list_entry_t : public kaitai::kstruct {

    public:

        list_entry_t(kaitai::kstream* p__io, gff_t::resolved_field_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~list_entry_t();

    private:
        uint32_t m_num_struct_indices;
        std::vector<uint32_t>* m_struct_indices;
        gff_t* m__root;
        gff_t::resolved_field_t* m__parent;

    public:

        /**
         * Little-endian count of following struct indices (list cardinality).
         * Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
         */
        uint32_t num_struct_indices() const { return m_num_struct_indices; }

        /**
         * Each value indexes `struct_array.entries[index]` (`GFFStructData` row).
         */
        std::vector<uint32_t>* struct_indices() const { return m_struct_indices; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_field_t* _parent() const { return m__parent; }
    };

    /**
     * Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
     */

    class list_indices_array_t : public kaitai::kstruct {

    public:

        list_indices_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~list_indices_array_t();

    private:
        std::string m_raw_data;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
         * Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
         * This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.
         */
        std::string raw_data() const { return m_raw_data; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai composition: one `GFFFieldData` row + label + payload.
     * Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
     * Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
     * For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
     */

    class resolved_field_t : public kaitai::kstruct {

    public:

        resolved_field_t(uint32_t p_field_index, kaitai::kstream* p__io, gff_t::resolved_struct_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resolved_field_t();

    private:
        bool f_entry;
        field_entry_t* m_entry;

    public:

        /**
         * Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).
         */
        field_entry_t* entry();

    private:
        bool f_field_entry_pos;
        int32_t m_field_entry_pos;

    public:

        /**
         * Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).
         */
        int32_t field_entry_pos();

    private:
        bool f_label;
        label_entry_terminated_t* m_label;

    public:

        /**
         * Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.
         */
        label_entry_terminated_t* label();

    private:
        bool f_list_entry;
        list_entry_t* m_list_entry;
        bool n_list_entry;

    public:
        bool _is_null_list_entry() { list_entry(); return n_list_entry; };

    private:

    public:

        /**
         * `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.
         */
        list_entry_t* list_entry();

    private:
        bool f_list_structs;
        std::vector<resolved_struct_t*>* m_list_structs;
        bool n_list_structs;

    public:
        bool _is_null_list_structs() { list_structs(); return n_list_structs; };

    private:

    public:

        /**
         * Child structs for this list; indices from `list_entry.struct_indices`.
         */
        std::vector<resolved_struct_t*>* list_structs();

    private:
        bool f_value_binary;
        bioware_common_t::bioware_binary_data_t* m_value_binary;
        bool n_value_binary;

    public:
        bool _is_null_value_binary() { value_binary(); return n_value_binary; };

    private:

    public:

        /**
         * `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
         */
        bioware_common_t::bioware_binary_data_t* value_binary();

    private:
        bool f_value_double;
        double m_value_double;
        bool n_value_double;

    public:
        bool _is_null_value_double() { value_double(); return n_value_double; };

    private:

    public:

        /**
         * `GFFFieldTypes` 9 (double).
         */
        double value_double();

    private:
        bool f_value_int16;
        int16_t m_value_int16;
        bool n_value_int16;

    public:
        bool _is_null_value_int16() { value_int16(); return n_value_int16; };

    private:

    public:

        /**
         * `GFFFieldTypes` 3 (INT16 LE at +8).
         */
        int16_t value_int16();

    private:
        bool f_value_int32;
        int32_t m_value_int32;
        bool n_value_int32;

    public:
        bool _is_null_value_int32() { value_int32(); return n_value_int32; };

    private:

    public:

        /**
         * `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
         */
        int32_t value_int32();

    private:
        bool f_value_int64;
        int64_t m_value_int64;
        bool n_value_int64;

    public:
        bool _is_null_value_int64() { value_int64(); return n_value_int64; };

    private:

    public:

        /**
         * `GFFFieldTypes` 7 (INT64).
         */
        int64_t value_int64();

    private:
        bool f_value_int8;
        int8_t m_value_int8;
        bool n_value_int8;

    public:
        bool _is_null_value_int8() { value_int8(); return n_value_int8; };

    private:

    public:

        /**
         * `GFFFieldTypes` 1 (INT8 in low byte of slot).
         */
        int8_t value_int8();

    private:
        bool f_value_localized_string;
        bioware_common_t::bioware_locstring_t* m_value_localized_string;
        bool n_value_localized_string;

    public:
        bool _is_null_value_localized_string() { value_localized_string(); return n_value_localized_string; };

    private:

    public:

        /**
         * `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
         */
        bioware_common_t::bioware_locstring_t* value_localized_string();

    private:
        bool f_value_resref;
        bioware_common_t::bioware_resref_t* m_value_resref;
        bool n_value_resref;

    public:
        bool _is_null_value_resref() { value_resref(); return n_value_resref; };

    private:

    public:

        /**
         * `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
         */
        bioware_common_t::bioware_resref_t* value_resref();

    private:
        bool f_value_single;
        float m_value_single;
        bool n_value_single;

    public:
        bool _is_null_value_single() { value_single(); return n_value_single; };

    private:

    public:

        /**
         * `GFFFieldTypes` 8 (32-bit float).
         */
        float value_single();

    private:
        bool f_value_str_ref;
        uint32_t m_value_str_ref;
        bool n_value_str_ref;

    public:
        bool _is_null_value_str_ref() { value_str_ref(); return n_value_str_ref; };

    private:

    public:

        /**
         * `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
         * `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
         */
        uint32_t value_str_ref();

    private:
        bool f_value_string;
        bioware_common_t::bioware_cexo_string_t* m_value_string;
        bool n_value_string;

    public:
        bool _is_null_value_string() { value_string(); return n_value_string; };

    private:

    public:

        /**
         * `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
         */
        bioware_common_t::bioware_cexo_string_t* value_string();

    private:
        bool f_value_struct;
        resolved_struct_t* m_value_struct;
        bool n_value_struct;

    public:
        bool _is_null_value_struct() { value_struct(); return n_value_struct; };

    private:

    public:

        /**
         * `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.
         */
        resolved_struct_t* value_struct();

    private:
        bool f_value_uint16;
        uint16_t m_value_uint16;
        bool n_value_uint16;

    public:
        bool _is_null_value_uint16() { value_uint16(); return n_value_uint16; };

    private:

    public:

        /**
         * `GFFFieldTypes` 2 (UINT16 LE at +8).
         */
        uint16_t value_uint16();

    private:
        bool f_value_uint32;
        uint32_t m_value_uint32;
        bool n_value_uint32;

    public:
        bool _is_null_value_uint32() { value_uint32(); return n_value_uint32; };

    private:

    public:

        /**
         * `GFFFieldTypes` 4 (full inline DWORD).
         */
        uint32_t value_uint32();

    private:
        bool f_value_uint64;
        uint64_t m_value_uint64;
        bool n_value_uint64;

    public:
        bool _is_null_value_uint64() { value_uint64(); return n_value_uint64; };

    private:

    public:

        /**
         * `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
         */
        uint64_t value_uint64();

    private:
        bool f_value_uint8;
        uint8_t m_value_uint8;
        bool n_value_uint8;

    public:
        bool _is_null_value_uint8() { value_uint8(); return n_value_uint8; };

    private:

    public:

        /**
         * `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
         */
        uint8_t value_uint8();

    private:
        bool f_value_vector3;
        bioware_common_t::bioware_vector3_t* m_value_vector3;
        bool n_value_vector3;

    public:
        bool _is_null_value_vector3() { value_vector3(); return n_value_vector3; };

    private:

    public:

        /**
         * `GFFFieldTypes` 17 — three floats (`bioware_vector3`).
         */
        bioware_common_t::bioware_vector3_t* value_vector3();

    private:
        bool f_value_vector4;
        bioware_common_t::bioware_vector4_t* m_value_vector4;
        bool n_value_vector4;

    public:
        bool _is_null_value_vector4() { value_vector4(); return n_value_vector4; };

    private:

    public:

        /**
         * `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
         */
        bioware_common_t::bioware_vector4_t* value_vector4();

    private:
        uint32_t m_field_index;
        gff_t* m__root;
        gff_t::resolved_struct_t* m__parent;

    public:

        /**
         * Index into `field_array.entries`; require `field_index < field_count`.
         */
        uint32_t field_index() const { return m_field_index; }
        gff_t* _root() const { return m__root; }
        gff_t::resolved_struct_t* _parent() const { return m__parent; }
    };

    /**
     * Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
     * On-disk row remains at `struct_offset + struct_index * 12`.
     */

    class resolved_struct_t : public kaitai::kstruct {

    public:

        resolved_struct_t(uint32_t p_struct_index, kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~resolved_struct_t();

    private:
        bool f_entry;
        struct_entry_t* m_entry;

    public:

        /**
         * Raw `GFFStructData` (Ghidra 12-byte layout).
         */
        struct_entry_t* entry();

    private:
        bool f_field_indices;
        std::vector<uint32_t>* m_field_indices;
        bool n_field_indices;

    public:
        bool _is_null_field_indices() { field_indices(); return n_field_indices; };

    private:

    public:

        /**
         * Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
         * Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
         */
        std::vector<uint32_t>* field_indices();

    private:
        bool f_fields;
        std::vector<resolved_field_t*>* m_fields;
        bool n_fields;

    public:
        bool _is_null_fields() { fields(); return n_fields; };

    private:

    public:

        /**
         * One `resolved_field` per entry in `field_indices`.
         */
        std::vector<resolved_field_t*>* fields();

    private:
        bool f_single_field;
        resolved_field_t* m_single_field;
        bool n_single_field;

    public:
        bool _is_null_single_field() { single_field(); return n_single_field; };

    private:

    public:

        /**
         * `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).
         */
        resolved_field_t* single_field();

    private:
        uint32_t m_struct_index;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
         */
        uint32_t struct_index() const { return m_struct_index; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
     */

    class struct_array_t : public kaitai::kstruct {

    public:

        struct_array_t(kaitai::kstream* p__io, gff_t* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~struct_array_t();

    private:
        std::vector<struct_entry_t*>* m_entries;
        gff_t* m__root;
        gff_t* m__parent;

    public:

        /**
         * Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
         * Stride 12 bytes per struct (matches Ghidra component sizes).
         */
        std::vector<struct_entry_t*>* entries() const { return m_entries; }
        gff_t* _root() const { return m__root; }
        gff_t* _parent() const { return m__parent; }
    };

    /**
     * One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
     */

    class struct_entry_t : public kaitai::kstruct {

    public:

        struct_entry_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, gff_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~struct_entry_t();

    private:
        bool f_field_indices_offset;
        uint32_t m_field_indices_offset;
        bool n_field_indices_offset;

    public:
        bool _is_null_field_indices_offset() { field_indices_offset(); return n_field_indices_offset; };

    private:

    public:

        /**
         * Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.
         */
        uint32_t field_indices_offset();

    private:
        bool f_has_multiple_fields;
        bool m_has_multiple_fields;

    public:

        /**
         * Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
         */
        bool has_multiple_fields();

    private:
        bool f_has_single_field;
        bool m_has_single_field;

    public:

        /**
         * Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
         * Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
         */
        bool has_single_field();

    private:
        bool f_single_field_index;
        uint32_t m_single_field_index;
        bool n_single_field_index;

    public:
        bool _is_null_single_field_index() { single_field_index(); return n_single_field_index; };

    private:

    public:

        /**
         * Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
         */
        uint32_t single_field_index();

    private:
        uint32_t m_struct_id;
        uint32_t m_data_or_offset;
        uint32_t m_field_count;
        gff_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Structure type identifier.
         * Source: Odyssey Ghidra `/K1/k1_win_gog_swkotor.exe` `GFFStructData.id` @ +0x0 (ulong).
         * 0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.
         */
        uint32_t struct_id() const { return m_struct_id; }

        /**
         * Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
         * If field_count == 0, this value is unused.
         * Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).
         */
        uint32_t data_or_offset() const { return m_data_or_offset; }

        /**
         * Number of fields in this struct:
         * - 0: No fields
         * - 1: Single field, data_or_offset contains the field index directly
         * - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
         * Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
         */
        uint32_t field_count() const { return m_field_count; }
        gff_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    bool f_field_array;
    field_array_t* m_field_array;
    bool n_field_array;

public:
    bool _is_null_field_array() { field_array(); return n_field_array; };

private:

public:

    /**
     * Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
     * `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
     */
    field_array_t* field_array();

private:
    bool f_field_data;
    field_data_t* m_field_data;
    bool n_field_data;

public:
    bool _is_null_field_data() { field_data(); return n_field_data; };

private:

public:

    /**
     * Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
     */
    field_data_t* field_data();

private:
    bool f_field_indices_array;
    field_indices_array_t* m_field_indices_array;
    bool n_field_indices_array;

public:
    bool _is_null_field_indices_array() { field_indices_array(); return n_field_indices_array; };

private:

public:

    /**
     * Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
     * Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
     */
    field_indices_array_t* field_indices_array();

private:
    bool f_label_array;
    label_array_t* m_label_array;
    bool n_label_array;

public:
    bool _is_null_label_array() { label_array(); return n_label_array; };

private:

public:

    /**
     * Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
     * Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
     */
    label_array_t* label_array();

private:
    bool f_list_indices_array;
    list_indices_array_t* m_list_indices_array;
    bool n_list_indices_array;

public:
    bool _is_null_list_indices_array() { list_indices_array(); return n_list_indices_array; };

private:

public:

    /**
     * Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
     * Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
     */
    list_indices_array_t* list_indices_array();

private:
    bool f_root_struct_resolved;
    resolved_struct_t* m_root_struct_resolved;

public:

    /**
     * Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
     * Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
     * Implements the access pattern described in meta.doc (single-field vs multi-field structs).
     */
    resolved_struct_t* root_struct_resolved();

private:
    bool f_struct_array;
    struct_array_t* m_struct_array;
    bool n_struct_array;

public:
    bool _is_null_struct_array() { struct_array(); return n_struct_array; };

private:

public:

    /**
     * Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
     */
    struct_array_t* struct_array();

private:
    gff_header_t* m_header;
    gff_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Wire header (56 B). Ghidra: `GFFHeaderInfo` on `/K1/k1_win_gog_swkotor.exe`.
     * Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header — full offset/size table.
     */
    gff_header_t* header() const { return m_header; }
    gff_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // GFF_H_

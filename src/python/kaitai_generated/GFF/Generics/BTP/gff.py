# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import bioware_common
import bioware_gff_common


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Gff(KaitaiStruct):
    """BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
    DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
    reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.

    **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
    `xoreos_aurorafile_read_header`).
    **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
    `instances`.
    **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
    (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).

    **GFF3 wire summary:**
    - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
    - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
      vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.

    **Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.

    **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.

    .. seealso::
       PyKotor wiki — GFF binary format - https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format


    .. seealso::
       xoreos — GFF3File::Header::read - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63


    .. seealso::
       xoreos — GFF3File load (post-header struct/field arena wiring) - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L110-L181


    .. seealso::
       xoreos — GFF4File::Header::read - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L48-L72


    .. seealso::
       xoreos — GFF4File::load entry - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L151-L164


    .. seealso::
       PyKotor — GFFBinaryReader.load - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114


    .. seealso::
       reone — GffReader - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225


    .. seealso::
       KotOR.js — GFFObject.parse - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/GFFObject.ts#L152-L221


    .. seealso::
       xoreos-tools — GFF3 load pipeline (shared with CLIs) - https://github.com/xoreos/xoreos-tools/blob/master/src/aurora/gff3file.cpp#L86-L238


    .. seealso::
       xoreos-tools — `gffdumper` - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176


    .. seealso::
       xoreos-tools — `gffcreator` - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60


    .. seealso::
       xoreos-docs — GFF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Gff, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file = Gff.GffUnionFile(self._io, self, self._root)

    def _fetch_instances(self):
        pass
        self.file._fetch_instances()

    class FieldArray(KaitaiStruct):
        """Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
        Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L68-L72
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.FieldArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.file.gff3.header.field_count):
                self.entries.append(Gff.FieldEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class FieldData(KaitaiStruct):
        """Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.FieldData, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.raw_data = self._io.read_bytes(
                self._root.file.gff3.header.field_data_count
            )

        def _fetch_instances(self):
            pass

    class FieldEntry(KaitaiStruct):
        """One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
        `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
        Dispatch table (inline vs `field_data` vs struct/list): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L78-L146
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.FieldEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.field_type = KaitaiStream.resolve_enum(
                bioware_gff_common.BiowareGffCommon.GffFieldType, self._io.read_u4le()
            )
            self.label_index = self._io.read_u4le()
            self.data_or_offset = self._io.read_u4le()

        def _fetch_instances(self):
            pass

        @property
        def field_data_offset_value(self):
            """Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`."""
            if hasattr(self, "_m_field_data_offset_value"):
                return self._m_field_data_offset_value

            if self.is_complex_type:
                pass
                self._m_field_data_offset_value = (
                    self._root.file.gff3.header.field_data_offset + self.data_or_offset
                )

            return getattr(self, "_m_field_data_offset_value", None)

        @property
        def is_complex_type(self):
            """Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`)."""
            if hasattr(self, "_m_is_complex_type"):
                return self._m_is_complex_type

            self._m_is_complex_type = (
                (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.uint64
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.int64
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.double
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.string
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.resref
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.localized_string
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.binary
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.vector4
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.vector3
                )
            )
            return getattr(self, "_m_is_complex_type", None)

        @property
        def is_list_type(self):
            """Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`)."""
            if hasattr(self, "_m_is_list_type"):
                return self._m_is_list_type

            self._m_is_list_type = (
                self.field_type == bioware_gff_common.BiowareGffCommon.GffFieldType.list
            )
            return getattr(self, "_m_is_list_type", None)

        @property
        def is_simple_type(self):
            """Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
            Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
            **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
            """
            if hasattr(self, "_m_is_simple_type"):
                return self._m_is_simple_type

            self._m_is_simple_type = (
                (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.uint8
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.int8
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.uint16
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.int16
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.uint32
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.int32
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.single
                )
                or (
                    self.field_type
                    == bioware_gff_common.BiowareGffCommon.GffFieldType.str_ref
                )
            )
            return getattr(self, "_m_is_simple_type", None)

        @property
        def is_struct_type(self):
            """Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row)."""
            if hasattr(self, "_m_is_struct_type"):
                return self._m_is_struct_type

            self._m_is_struct_type = (
                self.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.struct
            )
            return getattr(self, "_m_is_struct_type", None)

        @property
        def list_indices_offset_value(self):
            """Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`."""
            if hasattr(self, "_m_list_indices_offset_value"):
                return self._m_list_indices_offset_value

            if self.is_list_type:
                pass
                self._m_list_indices_offset_value = (
                    self._root.file.gff3.header.list_indices_offset
                    + self.data_or_offset
                )

            return getattr(self, "_m_list_indices_offset_value", None)

        @property
        def struct_index_value(self):
            """Struct index (same numeric interpretation as `GFFStructData` row index)."""
            if hasattr(self, "_m_struct_index_value"):
                return self._m_struct_index_value

            if self.is_struct_type:
                pass
                self._m_struct_index_value = self.data_or_offset

            return getattr(self, "_m_struct_index_value", None)

    class FieldIndicesArray(KaitaiStruct):
        """Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
        “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.FieldIndicesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.indices = []
            for i in range(self._root.file.gff3.header.field_indices_count):
                self.indices.append(self._io.read_u4le())

        def _fetch_instances(self):
            pass
            for i in range(len(self.indices)):
                pass

    class Gff3AfterAurora(KaitaiStruct):
        """GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances."""

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.Gff3AfterAurora, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.header = Gff.GffHeaderTail(self._io, self, self._root)

        def _fetch_instances(self):
            pass
            self.header._fetch_instances()
            _ = self.field_array
            if hasattr(self, "_m_field_array"):
                pass
                self._m_field_array._fetch_instances()

            _ = self.field_data
            if hasattr(self, "_m_field_data"):
                pass
                self._m_field_data._fetch_instances()

            _ = self.field_indices_array
            if hasattr(self, "_m_field_indices_array"):
                pass
                self._m_field_indices_array._fetch_instances()

            _ = self.label_array
            if hasattr(self, "_m_label_array"):
                pass
                self._m_label_array._fetch_instances()

            _ = self.list_indices_array
            if hasattr(self, "_m_list_indices_array"):
                pass
                self._m_list_indices_array._fetch_instances()

            _ = self.root_struct_resolved
            if hasattr(self, "_m_root_struct_resolved"):
                pass
                self._m_root_struct_resolved._fetch_instances()

            _ = self.struct_array
            if hasattr(self, "_m_struct_array"):
                pass
                self._m_struct_array._fetch_instances()

        @property
        def field_array(self):
            """Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
            `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
                PyKotor `_load_fields_batch` / `_load_field`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L67-L149
            """
            if hasattr(self, "_m_field_array"):
                return self._m_field_array

            if self.header.field_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.field_offset)
                self._m_field_array = Gff.FieldArray(self._io, self, self._root)
                self._io.seek(_pos)

            return getattr(self, "_m_field_array", None)

        @property
        def field_data(self):
            """Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
                PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L160-L216
            """
            if hasattr(self, "_m_field_data"):
                return self._m_field_data

            if self.header.field_data_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.field_data_offset)
                self._m_field_data = Gff.FieldData(self._io, self, self._root)
                self._io.seek(_pos)

            return getattr(self, "_m_field_data", None)

        @property
        def field_indices_array(self):
            """Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
            Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
                PyKotor batch read: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49
            """
            if hasattr(self, "_m_field_indices_array"):
                return self._m_field_indices_array

            if self.header.field_indices_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.field_indices_offset)
                self._m_field_indices_array = Gff.FieldIndicesArray(
                    self._io, self, self._root
                )
                self._io.seek(_pos)

            return getattr(self, "_m_field_indices_array", None)

        @property
        def label_array(self):
            """Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
            Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
                PyKotor load: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L151-L154
            """
            if hasattr(self, "_m_label_array"):
                return self._m_label_array

            if self.header.label_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.label_offset)
                self._m_label_array = Gff.LabelArray(self._io, self, self._root)
                self._io.seek(_pos)

            return getattr(self, "_m_label_array", None)

        @property
        def list_indices_array(self):
            """Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
            Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
                PyKotor `_load_list`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
            """
            if hasattr(self, "_m_list_indices_array"):
                return self._m_list_indices_array

            if self.header.list_indices_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.list_indices_offset)
                self._m_list_indices_array = Gff.ListIndicesArray(
                    self._io, self, self._root
                )
                self._io.seek(_pos)

            return getattr(self, "_m_list_indices_array", None)

        @property
        def root_struct_resolved(self):
            """Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
            Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
            Implements the access pattern described in meta.doc (single-field vs multi-field structs).
            """
            if hasattr(self, "_m_root_struct_resolved"):
                return self._m_root_struct_resolved

            self._m_root_struct_resolved = Gff.ResolvedStruct(
                0, self._io, self, self._root
            )
            return getattr(self, "_m_root_struct_resolved", None)

        @property
        def struct_array(self):
            """Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
            Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
                PyKotor `_load_struct`: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L46-L65
            """
            if hasattr(self, "_m_struct_array"):
                return self._m_struct_array

            if self.header.struct_count > 0:
                pass
                _pos = self._io.pos()
                self._io.seek(self.header.struct_offset)
                self._m_struct_array = Gff.StructArray(self._io, self, self._root)
                self._io.seek(_pos)

            return getattr(self, "_m_struct_array", None)

    class Gff4AfterAurora(KaitaiStruct):
        """GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
        PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
        """

        def __init__(self, aurora_version, _io, _parent=None, _root=None):
            super(Gff.Gff4AfterAurora, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self.aurora_version = aurora_version
            self._read()

        def _read(self):
            self.platform_id = self._io.read_u4be()
            self.file_type = self._io.read_u4be()
            self.type_version = self._io.read_u4be()
            self.num_struct_templates = self._io.read_u4le()
            if self.aurora_version == 1446260273:
                pass
                self.string_count = self._io.read_u4le()

            if self.aurora_version == 1446260273:
                pass
                self.string_offset = self._io.read_u4le()

            self.data_offset = self._io.read_u4le()
            self.struct_templates = []
            for i in range(self.num_struct_templates):
                self.struct_templates.append(
                    Gff.Gff4StructTemplateHeader(self._io, self, self._root)
                )

            self.tail = self._io.read_bytes_full()

        def _fetch_instances(self):
            pass
            if self.aurora_version == 1446260273:
                pass

            if self.aurora_version == 1446260273:
                pass

            for i in range(len(self.struct_templates)):
                pass
                self.struct_templates[i]._fetch_instances()

    class Gff4File(KaitaiStruct):
        """Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
        that expect a single user-type over the whole file.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.Gff4File, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.aurora_magic = self._io.read_u4be()
            self.aurora_version = self._io.read_u4be()
            self.gff4 = Gff.Gff4AfterAurora(
                self.aurora_version, self._io, self, self._root
            )

        def _fetch_instances(self):
            pass
            self.gff4._fetch_instances()

    class Gff4StructTemplateHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.Gff4StructTemplateHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.struct_label = self._io.read_u4be()
            self.field_count = self._io.read_u4le()
            self.field_offset = self._io.read_u4le()
            self.struct_size = self._io.read_u4le()

        def _fetch_instances(self):
            pass

    class GffHeaderTail(KaitaiStruct):
        """**GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
        after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
        wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
        Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.

        Sources (same DWORD order on disk after the 8-byte signature):
        - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
        - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
        - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
        - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.GffHeaderTail, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.struct_offset = self._io.read_u4le()
            self.struct_count = self._io.read_u4le()
            self.field_offset = self._io.read_u4le()
            self.field_count = self._io.read_u4le()
            self.label_offset = self._io.read_u4le()
            self.label_count = self._io.read_u4le()
            self.field_data_offset = self._io.read_u4le()
            self.field_data_count = self._io.read_u4le()
            self.field_indices_offset = self._io.read_u4le()
            self.field_indices_count = self._io.read_u4le()
            self.list_indices_offset = self._io.read_u4le()
            self.list_indices_count = self._io.read_u4le()

        def _fetch_instances(self):
            pass

    class GffUnionFile(KaitaiStruct):
        """Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
        (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.GffUnionFile, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.aurora_magic = self._io.read_u4be()
            self.aurora_version = self._io.read_u4be()
            if (self.aurora_version != 1446260272) and (
                self.aurora_version != 1446260273
            ):
                pass
                self.gff3 = Gff.Gff3AfterAurora(self._io, self, self._root)

            if (self.aurora_version == 1446260272) or (
                self.aurora_version == 1446260273
            ):
                pass
                self.gff4 = Gff.Gff4AfterAurora(
                    self.aurora_version, self._io, self, self._root
                )

        def _fetch_instances(self):
            pass
            if (self.aurora_version != 1446260272) and (
                self.aurora_version != 1446260273
            ):
                pass
                self.gff3._fetch_instances()

            if (self.aurora_version == 1446260272) or (
                self.aurora_version == 1446260273
            ):
                pass
                self.gff4._fetch_instances()

    class LabelArray(KaitaiStruct):
        """Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
        Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
        Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.LabelArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.labels = []
            for i in range(self._root.file.gff3.header.label_count):
                self.labels.append(Gff.LabelEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.labels)):
                pass
                self.labels[i]._fetch_instances()

    class LabelEntry(KaitaiStruct):
        """One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim."""

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.LabelEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.name = (self._io.read_bytes(16)).decode("ASCII")

        def _fetch_instances(self):
            pass

    class LabelEntryTerminated(KaitaiStruct):
        """Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
        Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.LabelEntryTerminated, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.name = (
                KaitaiStream.bytes_terminate(self._io.read_bytes(16), 0, False)
            ).decode("ASCII")

        def _fetch_instances(self):
            pass

    class ListEntry(KaitaiStruct):
        """One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
        Mirrors: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L218-L223
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.ListEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.num_struct_indices = self._io.read_u4le()
            self.struct_indices = []
            for i in range(self.num_struct_indices):
                self.struct_indices.append(self._io.read_u4le())

        def _fetch_instances(self):
            pass
            for i in range(len(self.struct_indices)):
                pass

    class ListIndicesArray(KaitaiStruct):
        """Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.ListIndicesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.raw_data = self._io.read_bytes(
                self._root.file.gff3.header.list_indices_count
            )

        def _fetch_instances(self):
            pass

    class ResolvedField(KaitaiStruct):
        """Kaitai composition: one `GFFFieldData` row + label + payload.
        Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
        Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
        For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
        """

        def __init__(self, field_index, _io, _parent=None, _root=None):
            super(Gff.ResolvedField, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self.field_index = field_index
            self._read()

        def _read(self):
            pass

        def _fetch_instances(self):
            pass
            _ = self.entry
            if hasattr(self, "_m_entry"):
                pass
                self._m_entry._fetch_instances()

            _ = self.label
            if hasattr(self, "_m_label"):
                pass
                self._m_label._fetch_instances()

            _ = self.list_entry
            if hasattr(self, "_m_list_entry"):
                pass
                self._m_list_entry._fetch_instances()

            _ = self.list_structs
            if hasattr(self, "_m_list_structs"):
                pass
                for i in range(len(self._m_list_structs)):
                    pass
                    self._m_list_structs[i]._fetch_instances()

            _ = self.value_binary
            if hasattr(self, "_m_value_binary"):
                pass
                self._m_value_binary._fetch_instances()

            _ = self.value_double
            if hasattr(self, "_m_value_double"):
                pass

            _ = self.value_int16
            if hasattr(self, "_m_value_int16"):
                pass

            _ = self.value_int32
            if hasattr(self, "_m_value_int32"):
                pass

            _ = self.value_int64
            if hasattr(self, "_m_value_int64"):
                pass

            _ = self.value_int8
            if hasattr(self, "_m_value_int8"):
                pass

            _ = self.value_localized_string
            if hasattr(self, "_m_value_localized_string"):
                pass
                self._m_value_localized_string._fetch_instances()

            _ = self.value_resref
            if hasattr(self, "_m_value_resref"):
                pass
                self._m_value_resref._fetch_instances()

            _ = self.value_single
            if hasattr(self, "_m_value_single"):
                pass

            _ = self.value_str_ref
            if hasattr(self, "_m_value_str_ref"):
                pass

            _ = self.value_string
            if hasattr(self, "_m_value_string"):
                pass
                self._m_value_string._fetch_instances()

            _ = self.value_struct
            if hasattr(self, "_m_value_struct"):
                pass
                self._m_value_struct._fetch_instances()

            _ = self.value_uint16
            if hasattr(self, "_m_value_uint16"):
                pass

            _ = self.value_uint32
            if hasattr(self, "_m_value_uint32"):
                pass

            _ = self.value_uint64
            if hasattr(self, "_m_value_uint64"):
                pass

            _ = self.value_uint8
            if hasattr(self, "_m_value_uint8"):
                pass

            _ = self.value_vector3
            if hasattr(self, "_m_value_vector3"):
                pass
                self._m_value_vector3._fetch_instances()

            _ = self.value_vector4
            if hasattr(self, "_m_value_vector4"):
                pass
                self._m_value_vector4._fetch_instances()

        @property
        def entry(self):
            """Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`)."""
            if hasattr(self, "_m_entry"):
                return self._m_entry

            _pos = self._io.pos()
            self._io.seek(
                self._root.file.gff3.header.field_offset + self.field_index * 12
            )
            self._m_entry = Gff.FieldEntry(self._io, self, self._root)
            self._io.seek(_pos)
            return getattr(self, "_m_entry", None)

        @property
        def field_entry_pos(self):
            """Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8)."""
            if hasattr(self, "_m_field_entry_pos"):
                return self._m_field_entry_pos

            self._m_field_entry_pos = (
                self._root.file.gff3.header.field_offset + self.field_index * 12
            )
            return getattr(self, "_m_field_entry_pos", None)

        @property
        def label(self):
            """Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters."""
            if hasattr(self, "_m_label"):
                return self._m_label

            _pos = self._io.pos()
            self._io.seek(
                self._root.file.gff3.header.label_offset + self.entry.label_index * 16
            )
            self._m_label = Gff.LabelEntryTerminated(self._io, self, self._root)
            self._io.seek(_pos)
            return getattr(self, "_m_label", None)

        @property
        def list_entry(self):
            """`GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset."""
            if hasattr(self, "_m_list_entry"):
                return self._m_list_entry

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.list
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.list_indices_offset
                    + self.entry.data_or_offset
                )
                self._m_list_entry = Gff.ListEntry(self._io, self, self._root)
                self._io.seek(_pos)

            return getattr(self, "_m_list_entry", None)

        @property
        def list_structs(self):
            """Child structs for this list; indices from `list_entry.struct_indices`."""
            if hasattr(self, "_m_list_structs"):
                return self._m_list_structs

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.list
            ):
                pass
                self._m_list_structs = []
                for i in range(self.list_entry.num_struct_indices):
                    self._m_list_structs.append(
                        Gff.ResolvedStruct(
                            self.list_entry.struct_indices[i],
                            self._io,
                            self,
                            self._root,
                        )
                    )

            return getattr(self, "_m_list_structs", None)

        @property
        def value_binary(self):
            """`GFFFieldTypes` 13 — binary (`bioware_binary_data`)."""
            if hasattr(self, "_m_value_binary"):
                return self._m_value_binary

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.binary
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_binary = bioware_common.BiowareCommon.BiowareBinaryData(
                    self._io
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_binary", None)

        @property
        def value_double(self):
            """`GFFFieldTypes` 9 (double)."""
            if hasattr(self, "_m_value_double"):
                return self._m_value_double

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.double
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_double = self._io.read_f8le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_double", None)

        @property
        def value_int16(self):
            """`GFFFieldTypes` 3 (INT16 LE at +8)."""
            if hasattr(self, "_m_value_int16"):
                return self._m_value_int16

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.int16
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_int16 = self._io.read_s2le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_int16", None)

        @property
        def value_int32(self):
            """`GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup."""
            if hasattr(self, "_m_value_int32"):
                return self._m_value_int32

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.int32
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_int32 = self._io.read_s4le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_int32", None)

        @property
        def value_int64(self):
            """`GFFFieldTypes` 7 (INT64)."""
            if hasattr(self, "_m_value_int64"):
                return self._m_value_int64

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.int64
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_int64 = self._io.read_s8le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_int64", None)

        @property
        def value_int8(self):
            """`GFFFieldTypes` 1 (INT8 in low byte of slot)."""
            if hasattr(self, "_m_value_int8"):
                return self._m_value_int8

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.int8
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_int8 = self._io.read_s1()
                self._io.seek(_pos)

            return getattr(self, "_m_value_int8", None)

        @property
        def value_localized_string(self):
            """`GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`)."""
            if hasattr(self, "_m_value_localized_string"):
                return self._m_value_localized_string

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.localized_string
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_localized_string = (
                    bioware_common.BiowareCommon.BiowareLocstring(self._io)
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_localized_string", None)

        @property
        def value_resref(self):
            """`GFFFieldTypes` 11 — ResRef (`bioware_resref`)."""
            if hasattr(self, "_m_value_resref"):
                return self._m_value_resref

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.resref
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_resref = bioware_common.BiowareCommon.BiowareResref(
                    self._io
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_resref", None)

        @property
        def value_single(self):
            """`GFFFieldTypes` 8 (32-bit float)."""
            if hasattr(self, "_m_value_single"):
                return self._m_value_single

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.single
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_single = self._io.read_f4le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_single", None)

        @property
        def value_str_ref(self):
            """`GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
            `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
            **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
            Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
            PyKotor reader gap (no `elif` for 18): https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273
            """
            if hasattr(self, "_m_value_str_ref"):
                return self._m_value_str_ref

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.str_ref
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_str_ref = self._io.read_u4le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_str_ref", None)

        @property
        def value_string(self):
            """`GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`)."""
            if hasattr(self, "_m_value_string"):
                return self._m_value_string

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.string
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_string = bioware_common.BiowareCommon.BiowareCexoString(
                    self._io
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_string", None)

        @property
        def value_struct(self):
            """`GFFFieldTypes` 14 — `data_or_data_offset` is struct row index."""
            if hasattr(self, "_m_value_struct"):
                return self._m_value_struct

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.struct
            ):
                pass
                self._m_value_struct = Gff.ResolvedStruct(
                    self.entry.data_or_offset, self._io, self, self._root
                )

            return getattr(self, "_m_value_struct", None)

        @property
        def value_uint16(self):
            """`GFFFieldTypes` 2 (UINT16 LE at +8)."""
            if hasattr(self, "_m_value_uint16"):
                return self._m_value_uint16

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.uint16
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_uint16 = self._io.read_u2le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_uint16", None)

        @property
        def value_uint32(self):
            """`GFFFieldTypes` 4 (full inline DWORD)."""
            if hasattr(self, "_m_value_uint32"):
                return self._m_value_uint32

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.uint32
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_uint32 = self._io.read_u4le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_uint32", None)

        @property
        def value_uint64(self):
            """`GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset)."""
            if hasattr(self, "_m_value_uint64"):
                return self._m_value_uint64

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.uint64
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_uint64 = self._io.read_u8le()
                self._io.seek(_pos)

            return getattr(self, "_m_value_uint64", None)

        @property
        def value_uint8(self):
            """`GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup."""
            if hasattr(self, "_m_value_uint8"):
                return self._m_value_uint8

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.uint8
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(self.field_entry_pos + 8)
                self._m_value_uint8 = self._io.read_u1()
                self._io.seek(_pos)

            return getattr(self, "_m_value_uint8", None)

        @property
        def value_vector3(self):
            """`GFFFieldTypes` 17 — three floats (`bioware_vector3`)."""
            if hasattr(self, "_m_value_vector3"):
                return self._m_value_vector3

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.vector3
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_vector3 = bioware_common.BiowareCommon.BiowareVector3(
                    self._io
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_vector3", None)

        @property
        def value_vector4(self):
            """`GFFFieldTypes` 16 — four floats (`bioware_vector4`)."""
            if hasattr(self, "_m_value_vector4"):
                return self._m_value_vector4

            if (
                self.entry.field_type
                == bioware_gff_common.BiowareGffCommon.GffFieldType.vector4
            ):
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_data_offset
                    + self.entry.data_or_offset
                )
                self._m_value_vector4 = bioware_common.BiowareCommon.BiowareVector4(
                    self._io
                )
                self._io.seek(_pos)

            return getattr(self, "_m_value_vector4", None)

    class ResolvedStruct(KaitaiStruct):
        """Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
        On-disk row remains at `struct_offset + struct_index * 12`.
        """

        def __init__(self, struct_index, _io, _parent=None, _root=None):
            super(Gff.ResolvedStruct, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self.struct_index = struct_index
            self._read()

        def _read(self):
            pass

        def _fetch_instances(self):
            pass
            _ = self.entry
            if hasattr(self, "_m_entry"):
                pass
                self._m_entry._fetch_instances()

            _ = self.field_indices
            if hasattr(self, "_m_field_indices"):
                pass
                for i in range(len(self._m_field_indices)):
                    pass

            _ = self.fields
            if hasattr(self, "_m_fields"):
                pass
                for i in range(len(self._m_fields)):
                    pass
                    self._m_fields[i]._fetch_instances()

            _ = self.single_field
            if hasattr(self, "_m_single_field"):
                pass
                self._m_single_field._fetch_instances()

        @property
        def entry(self):
            """Raw `GFFStructData` (Ghidra 12-byte layout)."""
            if hasattr(self, "_m_entry"):
                return self._m_entry

            _pos = self._io.pos()
            self._io.seek(
                self._root.file.gff3.header.struct_offset + self.struct_index * 12
            )
            self._m_entry = Gff.StructEntry(self._io, self, self._root)
            self._io.seek(_pos)
            return getattr(self, "_m_entry", None)

        @property
        def field_indices(self):
            """Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
            Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).
            """
            if hasattr(self, "_m_field_indices"):
                return self._m_field_indices

            if self.entry.field_count > 1:
                pass
                _pos = self._io.pos()
                self._io.seek(
                    self._root.file.gff3.header.field_indices_offset
                    + self.entry.data_or_offset
                )
                self._m_field_indices = []
                for i in range(self.entry.field_count):
                    self._m_field_indices.append(self._io.read_u4le())

                self._io.seek(_pos)

            return getattr(self, "_m_field_indices", None)

        @property
        def fields(self):
            """One `resolved_field` per entry in `field_indices`."""
            if hasattr(self, "_m_fields"):
                return self._m_fields

            if self.entry.field_count > 1:
                pass
                self._m_fields = []
                for i in range(self.entry.field_count):
                    self._m_fields.append(
                        Gff.ResolvedField(
                            self.field_indices[i], self._io, self, self._root
                        )
                    )

            return getattr(self, "_m_fields", None)

        @property
        def single_field(self):
            """`field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`)."""
            if hasattr(self, "_m_single_field"):
                return self._m_single_field

            if self.entry.field_count == 1:
                pass
                self._m_single_field = Gff.ResolvedField(
                    self.entry.data_or_offset, self._io, self, self._root
                )

            return getattr(self, "_m_single_field", None)

    class StructArray(KaitaiStruct):
        """Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
        Cross-check: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L47-L51
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.StructArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.file.gff3.header.struct_count):
                self.entries.append(Gff.StructEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class StructEntry(KaitaiStruct):
        """One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing."""

        def __init__(self, _io, _parent=None, _root=None):
            super(Gff.StructEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.struct_id = self._io.read_u4le()
            self.data_or_offset = self._io.read_u4le()
            self.field_count = self._io.read_u4le()

        def _fetch_instances(self):
            pass

        @property
        def field_indices_offset(self):
            """Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos."""
            if hasattr(self, "_m_field_indices_offset"):
                return self._m_field_indices_offset

            if self.has_multiple_fields:
                pass
                self._m_field_indices_offset = self.data_or_offset

            return getattr(self, "_m_field_indices_offset", None)

        @property
        def has_multiple_fields(self):
            """Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream."""
            if hasattr(self, "_m_has_multiple_fields"):
                return self._m_has_multiple_fields

            self._m_has_multiple_fields = self.field_count > 1
            return getattr(self, "_m_has_multiple_fields", None)

        @property
        def has_single_field(self):
            """Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
            Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
            """
            if hasattr(self, "_m_has_single_field"):
                return self._m_has_single_field

            self._m_has_single_field = self.field_count == 1
            return getattr(self, "_m_has_single_field", None)

        @property
        def single_field_index(self):
            """Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`."""
            if hasattr(self, "_m_single_field_index"):
                return self._m_single_field_index

            if self.has_single_field:
                pass
                self._m_single_field_index = self.data_or_offset

            return getattr(self, "_m_single_field_index", None)

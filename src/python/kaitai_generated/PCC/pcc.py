# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import bioware_common


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Pcc(KaitaiStruct):
    """**PCC** (Mass Effect–era Unreal package): BioWare variant of UE packages — `file_header`, name/import/export
    tables, then export blobs. May be zlib/LZO chunked (`bioware_pcc_compression_codec` in `bioware_common`).

    **Not KotOR:** no `k1_win_gog_swkotor.exe` grounding — follow LegendaryExplorer wiki + `meta.xref`.

    .. seealso::
       xoreos — `FileType` enum start (Aurora/BioWare family IDs; **PCC/Unreal packages are not in this table** — included only as canonical upstream anchor for “what this repo’s xoreos stack is”) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60


    .. seealso::
       ME3Tweaks — PCC file format - https://github.com/ME3Tweaks/LegendaryExplorer/wiki/PCC-File-Format


    .. seealso::
       ME3Tweaks — Package handling (export/import tables, UE3-era BioWare packages) - https://github.com/ME3Tweaks/LegendaryExplorer/wiki/Package-Handling


    .. seealso::
       In-tree — coverage matrix (PCC is out-of-xoreos Aurora scope; see table) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/docs/XOREOS_FORMAT_COVERAGE.md


    .. seealso::
       xoreos-docs — BioWare specs tree (KotOR-era PDFs; PCC is Mass Effect / UE3 — use LegendaryExplorer wiki as wire authority) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Pcc, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Pcc.FileHeader(self._io, self, self._root)

    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        _ = self.export_table
        if hasattr(self, "_m_export_table"):
            pass
            self._m_export_table._fetch_instances()

        _ = self.import_table
        if hasattr(self, "_m_import_table"):
            pass
            self._m_import_table._fetch_instances()

        _ = self.name_table
        if hasattr(self, "_m_name_table"):
            pass
            self._m_name_table._fetch_instances()

    class ExportEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.ExportEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.class_index = self._io.read_s4le()
            self.super_class_index = self._io.read_s4le()
            self.link = self._io.read_s4le()
            self.object_name_index = self._io.read_s4le()
            self.object_name_number = self._io.read_s4le()
            self.archetype_index = self._io.read_s4le()
            self.object_flags = self._io.read_u8le()
            self.data_size = self._io.read_u4le()
            self.data_offset = self._io.read_u4le()
            self.unknown1 = self._io.read_u4le()
            self.num_components = self._io.read_s4le()
            self.unknown2 = self._io.read_u4le()
            self.guid = Pcc.Guid(self._io, self, self._root)
            if self.num_components > 0:
                pass
                self.components = []
                for i in range(self.num_components):
                    self.components.append(self._io.read_s4le())

        def _fetch_instances(self):
            pass
            self.guid._fetch_instances()
            if self.num_components > 0:
                pass
                for i in range(len(self.components)):
                    pass

    class ExportTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.ExportTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.export_count):
                self.entries.append(Pcc.ExportEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class FileHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.FileHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.magic = self._io.read_u4le()
            if not self.magic == 2653586369:
                raise kaitaistruct.ValidationNotEqualError(
                    2653586369, self.magic, self._io, "/types/file_header/seq/0"
                )
            self.version = self._io.read_u4le()
            self.licensee_version = self._io.read_u4le()
            self.header_size = self._io.read_s4le()
            self.package_name = (self._io.read_bytes(10)).decode("UTF-16LE")
            self.package_flags = self._io.read_u4le()
            self.package_type = KaitaiStream.resolve_enum(
                bioware_common.BiowareCommon.BiowarePccPackageKind, self._io.read_u4le()
            )
            self.name_count = self._io.read_u4le()
            self.name_table_offset = self._io.read_u4le()
            self.export_count = self._io.read_u4le()
            self.export_table_offset = self._io.read_u4le()
            self.import_count = self._io.read_u4le()
            self.import_table_offset = self._io.read_u4le()
            self.depend_offset = self._io.read_u4le()
            self.depend_count = self._io.read_u4le()
            self.guid_part1 = self._io.read_u4le()
            self.guid_part2 = self._io.read_u4le()
            self.guid_part3 = self._io.read_u4le()
            self.guid_part4 = self._io.read_u4le()
            self.generations = self._io.read_u4le()
            self.export_count_dup = self._io.read_u4le()
            self.name_count_dup = self._io.read_u4le()
            self.unknown1 = self._io.read_u4le()
            self.engine_version = self._io.read_u4le()
            self.cooker_version = self._io.read_u4le()
            self.compression_flags = self._io.read_u4le()
            self.package_source = self._io.read_u4le()
            self.compression_type = KaitaiStream.resolve_enum(
                bioware_common.BiowareCommon.BiowarePccCompressionCodec,
                self._io.read_u4le(),
            )
            self.chunk_count = self._io.read_u4le()

        def _fetch_instances(self):
            pass

    class Guid(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.Guid, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.part1 = self._io.read_u4le()
            self.part2 = self._io.read_u4le()
            self.part3 = self._io.read_u4le()
            self.part4 = self._io.read_u4le()

        def _fetch_instances(self):
            pass

    class ImportEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.ImportEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.package_name_index = self._io.read_s8le()
            self.class_name_index = self._io.read_s4le()
            self.link = self._io.read_s8le()
            self.import_name_index = self._io.read_s8le()

        def _fetch_instances(self):
            pass

    class ImportTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.ImportTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.import_count):
                self.entries.append(Pcc.ImportEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class NameEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.NameEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.length = self._io.read_s4le()
            self.name = (
                self._io.read_bytes(
                    (-(self.length) if self.length < 0 else self.length) * 2
                )
            ).decode("UTF-16LE")

        def _fetch_instances(self):
            pass

        @property
        def abs_length(self):
            """Absolute value of length for size calculation."""
            if hasattr(self, "_m_abs_length"):
                return self._m_abs_length

            self._m_abs_length = -(self.length) if self.length < 0 else self.length
            return getattr(self, "_m_abs_length", None)

        @property
        def name_size(self):
            """Size of name string in bytes (absolute length * 2 bytes per WCHAR)."""
            if hasattr(self, "_m_name_size"):
                return self._m_name_size

            self._m_name_size = self.abs_length * 2
            return getattr(self, "_m_name_size", None)

    class NameTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Pcc.NameTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.name_count):
                self.entries.append(Pcc.NameEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    @property
    def compression_type(self):
        """Compression algorithm used (0=None, 1=Zlib, 2=LZO)."""
        if hasattr(self, "_m_compression_type"):
            return self._m_compression_type

        self._m_compression_type = self.header.compression_type
        return getattr(self, "_m_compression_type", None)

    @property
    def export_table(self):
        """Table containing all objects exported from this package."""
        if hasattr(self, "_m_export_table"):
            return self._m_export_table

        if self.header.export_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.header.export_table_offset)
            self._m_export_table = Pcc.ExportTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, "_m_export_table", None)

    @property
    def import_table(self):
        """Table containing references to external packages and classes."""
        if hasattr(self, "_m_import_table"):
            return self._m_import_table

        if self.header.import_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.header.import_table_offset)
            self._m_import_table = Pcc.ImportTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, "_m_import_table", None)

    @property
    def is_compressed(self):
        """True if package uses compressed chunks (bit 25 of package_flags)."""
        if hasattr(self, "_m_is_compressed"):
            return self._m_is_compressed

        self._m_is_compressed = self.header.package_flags & 33554432 != 0
        return getattr(self, "_m_is_compressed", None)

    @property
    def name_table(self):
        """Table containing all string names used in the package."""
        if hasattr(self, "_m_name_table"):
            return self._m_name_table

        if self.header.name_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.header.name_table_offset)
            self._m_name_table = Pcc.NameTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, "_m_name_table", None)

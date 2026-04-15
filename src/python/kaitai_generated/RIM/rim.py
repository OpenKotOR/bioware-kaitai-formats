# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_type_ids


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Rim(KaitaiStruct):
    """RIM (Resource Information Manager) files are self-contained archives used for module templates.
    RIM files are similar to ERF files but are read-only from the game's perspective. The game
    loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
    RIM files store all resources inline with metadata, making them self-contained archives.
    
    Format Variants:
    - Standard RIM: Basic module template files
    - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
    
    Binary Format (KotOR / PyKotor):
    - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
    - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
    - Key / resource entry table (32 bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
    - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
    
    Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.
    
    .. seealso::
       PyKotor wiki — RIM - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
    
    
    .. seealso::
       PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128
    
    
    .. seealso::
       xoreos — `RIMFile::load` + `readResList` - https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp#L35-L91
    
    
    .. seealso::
       xoreos-tools — `unrim` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/unrim.cpp#L55-L85
    
    
    .. seealso::
       xoreos-tools — `rim` packer CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/rim.cpp#L43-L84
    
    
    .. seealso::
       xoreos-docs — Torlack mod.html (MOD/RIM family) - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html
    
    
    .. seealso::
       KotOR.js — `RIMObject` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/RIMObject.ts#L69-L93
    
    
    .. seealso::
       NickHugi/Kotor.NET — `RIMBinaryStructure` - https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs
    
    
    .. seealso::
       reone — `RimReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/rimreader.cpp#L26-L58
    
    
    .. seealso::
       xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394
    
    
    .. seealso::
       PyKotor — `ResourceType` (tooling superset) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Rim, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Rim.RimHeader(self._io, self, self._root)
        if self.header.offset_to_resource_table == 0:
            pass
            self.gap_before_key_table_implicit = self._io.read_bytes(96)

        if self.header.offset_to_resource_table != 0:
            pass
            self.gap_before_key_table_explicit = self._io.read_bytes(self.header.offset_to_resource_table - 24)

        if self.header.resource_count > 0:
            pass
            self.resource_entry_table = Rim.ResourceEntryTable(self._io, self, self._root)



    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        if self.header.offset_to_resource_table == 0:
            pass

        if self.header.offset_to_resource_table != 0:
            pass

        if self.header.resource_count > 0:
            pass
            self.resource_entry_table._fetch_instances()


    class ResourceEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Rim.ResourceEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.resref = (self._io.read_bytes(16)).decode(u"ASCII")
            self.resource_type = KaitaiStream.resolve_enum(bioware_type_ids.BiowareTypeIds.XoreosFileTypeId, self._io.read_u4le())
            self.resource_id = self._io.read_u4le()
            self.offset_to_data = self._io.read_u4le()
            self.num_data = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            _ = self.data
            if hasattr(self, '_m_data'):
                pass
                for i in range(len(self._m_data)):
                    pass



        @property
        def data(self):
            """Raw binary data for this resource (read at specified offset)."""
            if hasattr(self, '_m_data'):
                return self._m_data

            _pos = self._io.pos()
            self._io.seek(self.offset_to_data)
            self._m_data = []
            for i in range(self.num_data):
                self._m_data.append(self._io.read_u1())

            self._io.seek(_pos)
            return getattr(self, '_m_data', None)


    class ResourceEntryTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Rim.ResourceEntryTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.resource_count):
                self.entries.append(Rim.ResourceEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class RimHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Rim.RimHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.file_type == u"RIM ":
                raise kaitaistruct.ValidationNotEqualError(u"RIM ", self.file_type, self._io, u"/types/rim_header/seq/0")
            self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.file_version == u"V1.0":
                raise kaitaistruct.ValidationNotEqualError(u"V1.0", self.file_version, self._io, u"/types/rim_header/seq/1")
            self.reserved = self._io.read_u4le()
            self.resource_count = self._io.read_u4le()
            self.offset_to_resource_table = self._io.read_u4le()
            self.offset_to_resources = self._io.read_u4le()


        def _fetch_instances(self):
            pass

        @property
        def has_resources(self):
            """Whether the RIM file contains any resources."""
            if hasattr(self, '_m_has_resources'):
                return self._m_has_resources

            self._m_has_resources = self.resource_count > 0
            return getattr(self, '_m_has_resources', None)




# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_type_ids


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Rim(KaitaiStruct):
    """**RIM** (Resource Information Manager): KotOR module **template** archive (read-only to the engine; runtime copy is
    ERF-shaped). 24-byte header, then **96-byte implicit gap** when offsets are zero (120-byte prelude before keys),
    32-byte key rows (ResRef, `resource_type` from `bioware_type_ids`, id, offset, size), then payload bytes.
    
    `*x.rim` “extension” rims chain additional resources — same wire.
    
    Pinned readers: `meta.xref`.
    
    .. seealso::
       PyKotor wiki — RIM - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
    
    
    .. seealso::
       xoreos — RIMFile::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/rimfile.cpp#L49-L75
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




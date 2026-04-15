# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_type_ids


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Key(KaitaiStruct):
    """**KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
    Resource types use `bioware_type_ids`.
    
    .. seealso::
       PyKotor wiki — KEY - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key
    
    
    .. seealso::
       xoreos — KEY::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/keyfile.cpp#L50-L88
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Key, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_type == u"KEY ":
            raise kaitaistruct.ValidationNotEqualError(u"KEY ", self.file_type, self._io, u"/seq/0")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        if not  ((self.file_version == u"V1  ") or (self.file_version == u"V1.1")) :
            raise kaitaistruct.ValidationNotAnyOfError(self.file_version, self._io, u"/seq/1")
        self.bif_count = self._io.read_u4le()
        self.key_count = self._io.read_u4le()
        self.file_table_offset = self._io.read_u4le()
        self.key_table_offset = self._io.read_u4le()
        self.build_year = self._io.read_u4le()
        self.build_day = self._io.read_u4le()
        self.reserved = self._io.read_bytes(32)


    def _fetch_instances(self):
        pass
        _ = self.file_table
        if hasattr(self, '_m_file_table'):
            pass
            self._m_file_table._fetch_instances()

        _ = self.key_table
        if hasattr(self, '_m_key_table'):
            pass
            self._m_key_table._fetch_instances()


    class FileEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Key.FileEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.file_size = self._io.read_u4le()
            self.filename_offset = self._io.read_u4le()
            self.filename_size = self._io.read_u2le()
            self.drives = self._io.read_u2le()


        def _fetch_instances(self):
            pass
            _ = self.filename
            if hasattr(self, '_m_filename'):
                pass


        @property
        def filename(self):
            """BIF filename string at the absolute filename_offset in the KEY file."""
            if hasattr(self, '_m_filename'):
                return self._m_filename

            _pos = self._io.pos()
            self._io.seek(self.filename_offset)
            self._m_filename = (self._io.read_bytes(self.filename_size)).decode(u"ASCII")
            self._io.seek(_pos)
            return getattr(self, '_m_filename', None)


    class FileTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Key.FileTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.bif_count):
                self.entries.append(Key.FileEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class FilenameTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Key.FilenameTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.filenames = (self._io.read_bytes_full()).decode(u"ASCII")


        def _fetch_instances(self):
            pass


    class KeyEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Key.KeyEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.resref = (self._io.read_bytes(16)).decode(u"ASCII")
            self.resource_type = KaitaiStream.resolve_enum(bioware_type_ids.BiowareTypeIds.XoreosFileTypeId, self._io.read_u2le())
            self.resource_id = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class KeyTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Key.KeyTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.key_count):
                self.entries.append(Key.KeyEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    @property
    def file_table(self):
        """File table containing BIF file entries."""
        if hasattr(self, '_m_file_table'):
            return self._m_file_table

        if self.bif_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.file_table_offset)
            self._m_file_table = Key.FileTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_file_table', None)

    @property
    def key_table(self):
        """KEY table containing resource entries."""
        if hasattr(self, '_m_key_table'):
            return self._m_key_table

        if self.key_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.key_table_offset)
            self._m_key_table = Key.KeyTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_key_table', None)



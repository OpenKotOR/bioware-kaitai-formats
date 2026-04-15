# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Erf(KaitaiStruct):
    """BioWare **ERF** (Encapsulated Resource File): self-contained ResRef + payload archive (`ERF ` / `HAK ` / `MOD ` /
    `SAV ` share one wire layout; FourCC picks role). Unlike KEY+BIF, names live beside data; optional localized
    description rows when `language_count` / offsets are set.
    
    **Wire:** 160-byte `erf_header` → optional localized strings → 24-byte key rows (ResRef → `resource_id`, raw
    `u2` `resource_type` per `bioware_type_ids`) → 8-byte `(offset, size)` table → raw blobs. Implicit `offset_to_*`
    bases when fields are zero: see `instances` below (PyKotor / xoreos parity).
    
    **Lookup:** read header → key_list by `effective_offset_to_key_list` → `resource_list` → seek each
    `offset_to_data` for `resource_size` bytes.
    
    Pinned code + wikis: `meta.xref`.
    
    .. seealso::
       PyKotor wiki — ERF / containers - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf
    
    
    .. seealso::
       PyKotor wiki — Aurora ERF - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf
    
    
    .. seealso::
       xoreos — ERF::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/erffile.cpp#L281-L306
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Erf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Erf.ErfHeader(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        _ = self.key_list
        if hasattr(self, '_m_key_list'):
            pass
            self._m_key_list._fetch_instances()

        _ = self.localized_string_list
        if hasattr(self, '_m_localized_string_list'):
            pass
            self._m_localized_string_list._fetch_instances()

        _ = self.resource_list
        if hasattr(self, '_m_resource_list'):
            pass
            self._m_resource_list._fetch_instances()


    class ErfHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ErfHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
            if not  ((self.file_type == u"ERF ") or (self.file_type == u"MOD ") or (self.file_type == u"SAV ") or (self.file_type == u"HAK ")) :
                raise kaitaistruct.ValidationNotAnyOfError(self.file_type, self._io, u"/types/erf_header/seq/0")
            self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.file_version == u"V1.0":
                raise kaitaistruct.ValidationNotEqualError(u"V1.0", self.file_version, self._io, u"/types/erf_header/seq/1")
            self.language_count = self._io.read_u4le()
            self.localized_string_size = self._io.read_u4le()
            self.entry_count = self._io.read_u4le()
            self.offset_to_localized_string_list = self._io.read_u4le()
            self.offset_to_key_list = self._io.read_u4le()
            self.offset_to_resource_list = self._io.read_u4le()
            self.build_year = self._io.read_u4le()
            self.build_day = self._io.read_u4le()
            self.description_strref = self._io.read_s4le()
            self.reserved = self._io.read_bytes(116)


        def _fetch_instances(self):
            pass

        @property
        def is_save_file(self):
            """Heuristic to detect save game files.
            Save games use MOD signature but typically have description_strref = 0.
            """
            if hasattr(self, '_m_is_save_file'):
                return self._m_is_save_file

            self._m_is_save_file =  ((self.file_type == u"MOD ") and (self.description_strref == 0)) 
            return getattr(self, '_m_is_save_file', None)


    class KeyEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.KeyEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.resref = (self._io.read_bytes(16)).decode(u"ASCII")
            self.resource_id = self._io.read_u4le()
            self.resource_type = self._io.read_u2le()
            self.unused = self._io.read_u2le()


        def _fetch_instances(self):
            pass


    class KeyList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.KeyList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.entry_count):
                self.entries.append(Erf.KeyEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class LocalizedStringEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.LocalizedStringEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.language_id = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareLanguageId, self._io.read_u4le())
            self.string_size = self._io.read_u4le()
            self.string_data = (self._io.read_bytes(self.string_size)).decode(u"windows-1252")


        def _fetch_instances(self):
            pass


    class LocalizedStringList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.LocalizedStringList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.language_count):
                self.entries.append(Erf.LocalizedStringEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class ResourceEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ResourceEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.offset_to_data = self._io.read_u4le()
            self.resource_size = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class ResourceList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ResourceList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.entry_count):
                self.entries.append(Erf.ResourceEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    @property
    def effective_offset_to_key_list(self):
        """KotOR and PyKotor treat offset_to_key_list == 0 as implicit 160 (end of fixed header)
        when resources are present.
        """
        if hasattr(self, '_m_effective_offset_to_key_list'):
            return self._m_effective_offset_to_key_list

        self._m_effective_offset_to_key_list = (self.header.offset_to_key_list if self.header.offset_to_key_list != 0 else 160)
        return getattr(self, '_m_effective_offset_to_key_list', None)

    @property
    def effective_offset_to_resource_list(self):
        """When offset_to_resource_list is 0, keys immediately follow the key list (24 bytes per entry).
        """
        if hasattr(self, '_m_effective_offset_to_resource_list'):
            return self._m_effective_offset_to_resource_list

        self._m_effective_offset_to_resource_list = (self.header.offset_to_resource_list if self.header.offset_to_resource_list != 0 else self.effective_offset_to_key_list + self.header.entry_count * 24)
        return getattr(self, '_m_effective_offset_to_resource_list', None)

    @property
    def key_list(self):
        """Array of key entries mapping ResRefs to resource indices."""
        if hasattr(self, '_m_key_list'):
            return self._m_key_list

        if self.header.entry_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.effective_offset_to_key_list)
            self._m_key_list = Erf.KeyList(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_key_list', None)

    @property
    def localized_string_list(self):
        """Optional localized string entries for multi-language descriptions."""
        if hasattr(self, '_m_localized_string_list'):
            return self._m_localized_string_list

        if  ((self.header.language_count > 0) and (self.header.offset_to_localized_string_list > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self.header.offset_to_localized_string_list)
            self._m_localized_string_list = Erf.LocalizedStringList(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_localized_string_list', None)

    @property
    def resource_list(self):
        """Array of resource entries containing offset and size information."""
        if hasattr(self, '_m_resource_list'):
            return self._m_resource_list

        if self.header.entry_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.effective_offset_to_resource_list)
            self._m_resource_list = Erf.ResourceList(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_resource_list', None)



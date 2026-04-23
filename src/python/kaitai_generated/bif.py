# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_type_ids


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Bif(KaitaiStruct):
    """**BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
    the paired **KEY** (`KEY.ksy`), not in the BIF.
    
    .. seealso::
       PyKotor wiki — BIF - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif
    
    
    .. seealso::
       PyKotor — `io_bif` (Kaitai + legacy + reader) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215
    
    
    .. seealso::
       PyKotor — `BIFType` - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71
    
    
    .. seealso::
       xoreos — `BIFFile::load` + `readVarResTable` - https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97
    
    
    .. seealso::
       xoreos — `kFileTypeBIF` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208
    
    
    .. seealso::
       xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`) - https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209
    
    
    .. seealso::
       reone — `BifReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63
    
    
    .. seealso::
       KotOR.js — `BIFObject.readFromDisk` (header + variable resource table) - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts#L87-L123
    
    
    .. seealso::
       xoreos-docs — Torlack bif.html - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html
    
    
    .. seealso::
       xoreos-docs — KeyBIF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Bif, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_type == u"BIFF":
            raise kaitaistruct.ValidationNotEqualError(u"BIFF", self.file_type, self._io, u"/seq/0")
        self.version = (self._io.read_bytes(4)).decode(u"ASCII")
        if not  ((self.version == u"V1  ") or (self.version == u"V1.1")) :
            raise kaitaistruct.ValidationNotAnyOfError(self.version, self._io, u"/seq/1")
        self.var_res_count = self._io.read_u4le()
        self.fixed_res_count = self._io.read_u4le()
        if not self.fixed_res_count == 0:
            raise kaitaistruct.ValidationNotEqualError(0, self.fixed_res_count, self._io, u"/seq/3")
        self.var_table_offset = self._io.read_u4le()


    def _fetch_instances(self):
        pass
        _ = self.var_resource_table
        if hasattr(self, '_m_var_resource_table'):
            pass
            self._m_var_resource_table._fetch_instances()


    class VarResourceEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bif.VarResourceEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.resource_id = self._io.read_u4le()
            self.offset = self._io.read_u4le()
            self.file_size = self._io.read_u4le()
            self.resource_type = KaitaiStream.resolve_enum(bioware_type_ids.BiowareTypeIds.XoreosFileTypeId, self._io.read_u4le())


        def _fetch_instances(self):
            pass


    class VarResourceTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bif.VarResourceTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.var_res_count):
                self.entries.append(Bif.VarResourceEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    @property
    def var_resource_table(self):
        """Variable resource table containing entries for each resource."""
        if hasattr(self, '_m_var_resource_table'):
            return self._m_var_resource_table

        if self.var_res_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.var_table_offset)
            self._m_var_resource_table = Bif.VarResourceTable(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_var_resource_table', None)



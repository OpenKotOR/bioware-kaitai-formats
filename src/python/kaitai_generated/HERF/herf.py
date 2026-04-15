# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Herf(KaitaiStruct):
    """**HERF** (hashed ERF) stores resources keyed by DJB2 name hashes; an embedded **`erf.dict`**
    resource maps hashes back to stems (`HERFFile::readDictionary`). The dictionary payload itself
    is another HERF magic block (`readDictionary` re-validates `0x00F1A5C0`).
    
    **DICT / SMALL:** `readResList` marks the resource whose offset/size match the discovered
    dictionary slice as `kFileTypeDICT`; compressed payloads may involve `Small::decompress`
    (`smallfile.cpp`) — not expanded in this skeleton.
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Herf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.magic = self._io.read_u4le()
        if not self.magic == 15836608:
            raise kaitaistruct.ValidationNotEqualError(15836608, self.magic, self._io, u"/seq/0")
        self.num_resources = self._io.read_u4le()
        self.resources = []
        for i in range(self.num_resources):
            self.resources.append(Herf.HerfResourceEntry(self._io, self, self._root))



    def _fetch_instances(self):
        pass
        for i in range(len(self.resources)):
            pass
            self.resources[i]._fetch_instances()


    class HerfResourceEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Herf.HerfResourceEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.name_hash = self._io.read_u4le()
            self.size = self._io.read_u4le()
            self.offset = self._io.read_u4le()


        def _fetch_instances(self):
            pass




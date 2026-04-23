# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Bzf(KaitaiStruct):
    """**BZF**: `BZF ` + `V1.0` header, then **LZMA** payload that expands to a normal **BIF** (`BIF.ksy`). Common on
    mobile KotOR ports.
    
    .. seealso::
       PyKotor wiki — BZF (LZMA BIF) - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bzf-compression
    
    
    .. seealso::
       PyKotor — `_decompress_bzf_payload` - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L26-L54
    
    
    .. seealso::
       xoreos — `kBZFID` quirk + `BZFFile::load` - https://github.com/xoreos/xoreos/blob/master/src/aurora/bzffile.cpp#L41-L83
    
    
    .. seealso::
       xoreos-tools — `.bzf` → `BZFFile` - https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L207
    
    
    .. seealso::
       xoreos-docs — KeyBIF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Bzf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_type == u"BZF ":
            raise kaitaistruct.ValidationNotEqualError(u"BZF ", self.file_type, self._io, u"/seq/0")
        self.version = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.version == u"V1.0":
            raise kaitaistruct.ValidationNotEqualError(u"V1.0", self.version, self._io, u"/seq/1")
        self.compressed_data = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Tpc(KaitaiStruct):
    """**TPC** (KotOR native texture): 128-byte header (`pixel_encoding` etc. via `bioware_common`) + opaque tail
    (mips / cube faces / optional **TXI** suffix). Per-mip byte sizes are format-specific — see PyKotor `io_tpc.py`
    (`meta.xref`).
    
    .. seealso::
       PyKotor wiki — TPC - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    
    
    .. seealso::
       PyKotor — `TPCBinaryReader` + `load` - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tpc.py#L93-L303
    
    
    .. seealso::
       PyKotor — `TPCTextureFormat` (opening) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L74-L120
    
    
    .. seealso::
       PyKotor — `class TPC` (opening) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tpc_data.py#L499-L520
    
    
    .. seealso::
       reone — `TpcReader` (body + TXI features) - https://github.com/modawan/reone/blob/master/src/libs/graphics/format/tpcreader.cpp#L29-L105
    
    
    .. seealso::
       xoreos — `kFileTypeTPC` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L183
    
    
    .. seealso::
       xoreos — `TPC::load` through `readTXI` entrypoints - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L362
    
    
    .. seealso::
       xoreos-tools — `TPC::load` - https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68
    
    
    .. seealso::
       xoreos-tools — `TPC::readHeader` - https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    
    
    .. seealso::
       xoreos-docs — KotOR MDL overview (texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    
    
    .. seealso::
       KotOR.js — `TPCObject.readHeader` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TPCObject.ts#L290-L380
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Tpc, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Tpc.TpcHeader(self._io, self, self._root)
        self.body = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()

    class TpcHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tpc.TpcHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.data_size = self._io.read_u4le()
            self.alpha_test = self._io.read_f4le()
            self.width = self._io.read_u2le()
            self.height = self._io.read_u2le()
            self.pixel_encoding = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareTpcPixelFormatId, self._io.read_u1())
            self.mipmap_count = self._io.read_u1()
            self.reserved = []
            for i in range(114):
                self.reserved.append(self._io.read_u1())



        def _fetch_instances(self):
            pass
            for i in range(len(self.reserved)):
                pass


        @property
        def is_compressed(self):
            """True if texture data is compressed (DXT format)."""
            if hasattr(self, '_m_is_compressed'):
                return self._m_is_compressed

            self._m_is_compressed = self.data_size != 0
            return getattr(self, '_m_is_compressed', None)

        @property
        def is_uncompressed(self):
            """True if texture data is uncompressed (raw pixels)."""
            if hasattr(self, '_m_is_uncompressed'):
                return self._m_is_uncompressed

            self._m_is_uncompressed = self.data_size == 0
            return getattr(self, '_m_is_uncompressed', None)




# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Dds(KaitaiStruct):
    """**DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
    (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.
    
    BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.
    
    .. seealso::
       PyKotor wiki — DDS - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds
    
    
    .. seealso::
       PyKotor — TPCDDSReader - https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Dds, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.magic = (self._io.read_bytes(4)).decode(u"ASCII")
        if not  ((self.magic == u"DDS ") or (self.magic == u"    ")) :
            raise kaitaistruct.ValidationNotAnyOfError(self.magic, self._io, u"/seq/0")
        if self.magic == u"DDS ":
            pass
            self.header = Dds.DdsHeader(self._io, self, self._root)

        if self.magic != u"DDS ":
            pass
            self.bioware_header = Dds.BiowareDdsHeader(self._io, self, self._root)

        self.pixel_data = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass
        if self.magic == u"DDS ":
            pass
            self.header._fetch_instances()

        if self.magic != u"DDS ":
            pass
            self.bioware_header._fetch_instances()


    class BiowareDdsHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Dds.BiowareDdsHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.width = self._io.read_u4le()
            self.height = self._io.read_u4le()
            self.bytes_per_pixel = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareDdsVariantBytesPerPixel, self._io.read_u4le())
            self.data_size = self._io.read_u4le()
            self.unused_float = self._io.read_f4le()


        def _fetch_instances(self):
            pass


    class Ddpixelformat(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Dds.Ddpixelformat, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.size = self._io.read_u4le()
            if not self.size == 32:
                raise kaitaistruct.ValidationNotEqualError(32, self.size, self._io, u"/types/ddpixelformat/seq/0")
            self.flags = self._io.read_u4le()
            self.fourcc = (self._io.read_bytes(4)).decode(u"ASCII")
            self.rgb_bit_count = self._io.read_u4le()
            self.r_bit_mask = self._io.read_u4le()
            self.g_bit_mask = self._io.read_u4le()
            self.b_bit_mask = self._io.read_u4le()
            self.a_bit_mask = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class DdsHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Dds.DdsHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.size = self._io.read_u4le()
            if not self.size == 124:
                raise kaitaistruct.ValidationNotEqualError(124, self.size, self._io, u"/types/dds_header/seq/0")
            self.flags = self._io.read_u4le()
            self.height = self._io.read_u4le()
            self.width = self._io.read_u4le()
            self.pitch_or_linear_size = self._io.read_u4le()
            self.depth = self._io.read_u4le()
            self.mipmap_count = self._io.read_u4le()
            self.reserved1 = []
            for i in range(11):
                self.reserved1.append(self._io.read_u4le())

            self.pixel_format = Dds.Ddpixelformat(self._io, self, self._root)
            self.caps = self._io.read_u4le()
            self.caps2 = self._io.read_u4le()
            self.caps3 = self._io.read_u4le()
            self.caps4 = self._io.read_u4le()
            self.reserved2 = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            for i in range(len(self.reserved1)):
                pass

            self.pixel_format._fetch_instances()




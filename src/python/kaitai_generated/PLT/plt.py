# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Plt(KaitaiStruct):
    """**PLT** (palette texture, NWN lineage): each pixel is `(palette_group_index, color_index)` into external
    `.pal` tables — header (24 B) then `width × height` × 2-byte entries.
    
    **KotOR:** type id `0x0006` exists in Aurora tables, but KotOR does not ship or decode PLT bodies; use TPC/TGA/DDS
    for in-engine textures. This spec is for NWN-era assets and tooling.
    
    Palette groups 0–9: `formats/Common/bioware_common.ksy` → `bioware_nwn_plt_palette_group_id`. Proof: `meta.xref`.
    
    .. seealso::
       PyKotor wiki — PLT (NWN) - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    
    
    .. seealso::
       xoreos — pltfile load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/aurora/pltfile.cpp#L102-L145
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Plt, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Plt.PltHeader(self._io, self, self._root)
        self.pixel_data = Plt.PixelDataSection(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        self.pixel_data._fetch_instances()

    class PixelDataSection(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Plt.PixelDataSection, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.pixels = []
            for i in range(self._root.header.width * self._root.header.height):
                self.pixels.append(Plt.PltPixel(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.pixels)):
                pass
                self.pixels[i]._fetch_instances()



    class PltHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Plt.PltHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.signature = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.signature == u"PLT ":
                raise kaitaistruct.ValidationNotEqualError(u"PLT ", self.signature, self._io, u"/types/plt_header/seq/0")
            self.version = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.version == u"V1  ":
                raise kaitaistruct.ValidationNotEqualError(u"V1  ", self.version, self._io, u"/types/plt_header/seq/1")
            self.unknown1 = self._io.read_u4le()
            self.unknown2 = self._io.read_u4le()
            self.width = self._io.read_u4le()
            self.height = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class PltPixel(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Plt.PltPixel, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.color_index = self._io.read_u1()
            self.palette_group_index = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareNwnPltPaletteGroupId, self._io.read_u1())


        def _fetch_instances(self):
            pass




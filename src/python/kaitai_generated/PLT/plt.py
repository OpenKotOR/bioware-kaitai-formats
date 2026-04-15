# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Plt(KaitaiStruct):
    """PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
    palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
    that reference external palette files, enabling dynamic color customization for character models
    (skin, hair, armor colors, etc.).

    **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
    resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
    does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
    including character models. This documentation is provided for reference only.

    **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.

    Binary Format Structure:
    - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
    - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)

    Palette System:
    PLT files work in conjunction with external palette files (.pal files) that contain the actual
    color values. The PLT file itself stores:
    1. Palette Group index (0-9): Which palette group to use for each pixel
    2. Color index (0-255): Which color within the selected palette to use

    At runtime, the game:
    1. Loads the appropriate palette file for the selected palette group
    2. Uses the palette index (supplied by the content creator) to select a row in the palette file
    3. Uses the color index from the PLT file to retrieve the final color value

    Palette Groups (10 total):
    0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
    6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2

    References:
    - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT`
    - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
    - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`

    .. seealso::
       PyKotor wiki — PLT (NWN legacy) - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy


    .. seealso::
       xoreos-docs — Torlack plt.html - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html


    .. seealso::
       xoreos — `PLTFile::load` - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145


    .. seealso::
       xoreos — `kFileTypePLT` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63


    .. seealso::
       reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch) - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35
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
            self.signature = (self._io.read_bytes(4)).decode("ASCII")
            if not self.signature == "PLT ":
                raise kaitaistruct.ValidationNotEqualError(
                    "PLT ", self.signature, self._io, "/types/plt_header/seq/0"
                )
            self.version = (self._io.read_bytes(4)).decode("ASCII")
            if not self.version == "V1  ":
                raise kaitaistruct.ValidationNotEqualError(
                    "V1  ", self.version, self._io, "/types/plt_header/seq/1"
                )
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
            self.palette_group_index = self._io.read_u1()

        def _fetch_instances(self):
            pass

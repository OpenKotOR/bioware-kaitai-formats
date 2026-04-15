# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class TgaCommon(KaitaiStruct):
    """Canonical enumerations for the TGA file header fields `color_map_type` and `image_type` (`u1` each),
    per the Truevision TGA specification (also mirrored in xoreos `tga.cpp`).
    
    Import from `formats/TPC/TGA.ksy` as `../Common/tga_common` (must match `meta.id`). Lowest-scope anchors: `meta.xref`.
    """

    class TgaColorMapType(IntEnum):
        none = 0
        present = 1

    class TgaImageType(IntEnum):
        no_image_data = 0
        uncompressed_color_mapped = 1
        uncompressed_rgb = 2
        uncompressed_greyscale = 3
        rle_color_mapped = 9
        rle_rgb = 10
        rle_greyscale = 11
    def __init__(self, _io, _parent=None, _root=None):
        super(TgaCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import tga_common


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Tga(KaitaiStruct):
    """**TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
    converts authoring TGAs to **TPC** for shipping.

    Shared header enums: `formats/Common/tga_common.ksy`.

    .. seealso::
       PyKotor wiki — textures (TPC/TGA pipeline) - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc


    .. seealso::
       PyKotor — compact TGA reader (`tga.py`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40


    .. seealso::
       PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120


    .. seealso::
       xoreos — `TGA::readHeader` - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tga.cpp#L89-L177


    .. seealso::
       xoreos-tools — `TGA::load` through `readRLE` (tooling reader) - https://github.com/xoreos/xoreos-tools/blob/master/src/images/tga.cpp#L68-L241


    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware


    .. seealso::
       xoreos-docs — KotOR MDL overview (texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html


    .. seealso::
       lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`) - https://github.com/lachjames/NorthernLights
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Tga, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.id_length = self._io.read_u1()
        self.color_map_type = KaitaiStream.resolve_enum(
            tga_common.TgaCommon.TgaColorMapType, self._io.read_u1()
        )
        self.image_type = KaitaiStream.resolve_enum(
            tga_common.TgaCommon.TgaImageType, self._io.read_u1()
        )
        if self.color_map_type == tga_common.TgaCommon.TgaColorMapType.present:
            pass
            self.color_map_spec = Tga.ColorMapSpecification(self._io, self, self._root)

        self.image_spec = Tga.ImageSpecification(self._io, self, self._root)
        if self.id_length > 0:
            pass
            self.image_id = (self._io.read_bytes(self.id_length)).decode("ASCII")

        if self.color_map_type == tga_common.TgaCommon.TgaColorMapType.present:
            pass
            self.color_map_data = []
            for i in range(self.color_map_spec.length):
                self.color_map_data.append(self._io.read_u1())

        self.image_data = []
        i = 0
        while not self._io.is_eof():
            self.image_data.append(self._io.read_u1())
            i += 1

    def _fetch_instances(self):
        pass
        if self.color_map_type == tga_common.TgaCommon.TgaColorMapType.present:
            pass
            self.color_map_spec._fetch_instances()

        self.image_spec._fetch_instances()
        if self.id_length > 0:
            pass

        if self.color_map_type == tga_common.TgaCommon.TgaColorMapType.present:
            pass
            for i in range(len(self.color_map_data)):
                pass

        for i in range(len(self.image_data)):
            pass

    class ColorMapSpecification(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tga.ColorMapSpecification, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.first_entry_index = self._io.read_u2le()
            self.length = self._io.read_u2le()
            self.entry_size = self._io.read_u1()

        def _fetch_instances(self):
            pass

    class ImageSpecification(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tga.ImageSpecification, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.x_origin = self._io.read_u2le()
            self.y_origin = self._io.read_u2le()
            self.width = self._io.read_u2le()
            self.height = self._io.read_u2le()
            self.pixel_depth = self._io.read_u1()
            self.image_descriptor = self._io.read_u1()

        def _fetch_instances(self):
            pass

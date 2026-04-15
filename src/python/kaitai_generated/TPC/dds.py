# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import bioware_common


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Dds(KaitaiStruct):
    """**DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
    (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.

    BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.

    .. seealso::
       PyKotor wiki — DDS - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds


    .. seealso::
       PyKotor — `TPCDDSReader` / `io_dds` - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130


    .. seealso::
       xoreos — `kFileTypeDDS` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98


    .. seealso::
       xoreos — `dds.cpp` load entry - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67


    .. seealso::
       xoreos — BioWare headerless / Microsoft DDS branches - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210


    .. seealso::
       xoreos-tools — `dds.cpp` (image tooling) - https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158


    .. seealso::
       xoreos-docs — BioWare specs PDF tree (texture-adjacent PDFs) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware


    .. seealso::
       xoreos-docs — KotOR MDL overview (engine texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html


    .. seealso::
       lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`) - https://github.com/lachjames/NorthernLights


    .. seealso::
       reone — `ResourceType::Dds` (type id; TPC path in `tpcreader.cpp`) - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L57
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Dds, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.magic = (self._io.read_bytes(4)).decode("ASCII")
        if not ((self.magic == "DDS ") or (self.magic == "    ")):
            raise kaitaistruct.ValidationNotAnyOfError(self.magic, self._io, "/seq/0")
        if self.magic == "DDS ":
            pass
            self.header = Dds.DdsHeader(self._io, self, self._root)

        if self.magic != "DDS ":
            pass
            self.bioware_header = Dds.BiowareDdsHeader(self._io, self, self._root)

        self.pixel_data = self._io.read_bytes_full()

    def _fetch_instances(self):
        pass
        if self.magic == "DDS ":
            pass
            self.header._fetch_instances()

        if self.magic != "DDS ":
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
            self.bytes_per_pixel = KaitaiStream.resolve_enum(
                bioware_common.BiowareCommon.BiowareDdsVariantBytesPerPixel,
                self._io.read_u4le(),
            )
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
                raise kaitaistruct.ValidationNotEqualError(
                    32, self.size, self._io, "/types/ddpixelformat/seq/0"
                )
            self.flags = self._io.read_u4le()
            self.fourcc = (self._io.read_bytes(4)).decode("ASCII")
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
                raise kaitaistruct.ValidationNotEqualError(
                    124, self.size, self._io, "/types/dds_header/seq/0"
                )
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

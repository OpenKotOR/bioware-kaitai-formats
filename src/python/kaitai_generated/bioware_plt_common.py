# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowarePltCommon(KaitaiStruct):
    """**PLT** wire: **file tag** LE ``u32`` pair (`plt_file_magic_le` / `plt_file_version_le` for ASCII ``PLT `` + ``V1  ``),
    plus per-pixel **`u8`** palette **group** ids (`0..9`) in `plt_palette_group_id` alongside an 8-bit color index into palette rows.
    
    **Lowest scope:** header tags + palette-group semantics live here; `formats/PLT/PLT.ksy` keeps dimensions + pixel grid layout.
    
    .. seealso::
       formats/PLT/PLT.ksy#L137-L152 In-tree — `plt_pixel` + `palette_group_index` (`plt_palette_group_id`)
    
    
    .. seealso::
       PyKotor wiki — PLT (NWN legacy) - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    
    
    .. seealso::
       xoreos-docs — Torlack plt.html - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/plt.html
    
    
    .. seealso::
       xoreos — `PLTFile::load` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/pltfile.cpp#L102-L145
    
    
    .. seealso::
       xoreos — `kFileTypePLT` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L63
    """

    class PltFileMagicLe(IntEnum):
        plt_space = 542395472

    class PltFileVersionLe(IntEnum):
        v1_two_spaces = 538980694

    class PltPaletteGroupId(IntEnum):
        skin = 0
        hair = 1
        metal_1 = 2
        metal_2 = 3
        cloth_1 = 4
        cloth_2 = 5
        leather_1 = 6
        leather_2 = 7
        tattoo_1 = 8
        tattoo_2 = 9
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowarePltCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



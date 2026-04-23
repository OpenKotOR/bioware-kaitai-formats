# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareLipCommon(KaitaiStruct):
    """LE ``u32`` tags for the standard **LIP** header (ASCII ``LIP `` + ``V1.0``), matching PyKotor / reone /
    KotOR.js readers.
    
    **Lowest-scope documentation:** enum members carry vendor anchors; viseme ids stay on
    ``bioware_common::bioware_lip_viseme_id``; ``formats/LIP/LIP.ksy`` documents keyframe layout only.
    
    .. seealso::
       formats/LIP/LIP.ksy In-tree — LIP root (imports this module for header tags)
    
    
    .. seealso::
       PyKotor — `io_lip` - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip.py#L24-L116
    
    
    .. seealso::
       reone — `LipReader::load` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41
    
    
    .. seealso::
       KotOR.js — `LIPObject.readBinary` - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/LIPObject.ts#L99-L118
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (no dedicated LIP PDF) - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class LipFileMagicLe(IntEnum):
        lip_space = 542132556

    class LipFormatVersionLe(IntEnum):
        v1_0 = 808333654
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareLipCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareLtrCommon(KaitaiStruct):
    """LE ``u32`` tags for binary **LTR** headers (``LTR `` + ``V1.0``), matching xoreos ``LTRFile`` / PyKotor ``io_ltr``.
    
    Alphabet sizes (**26** vs **28**) stay on ``bioware_common::bioware_ltr_alphabet_length``; this module is tags only.
    
    .. seealso::
       formats/LTR/LTR.ksy In-tree — LTR root (imports this module + `bioware_common` for alphabet enum)
    
    
    .. seealso::
       xoreos — `kLTRID` / `kVersion10` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ltrfile.cpp#L31-L32
    
    
    .. seealso::
       PyKotor — `io_ltr` - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155
    
    
    .. seealso::
       reone — `LtrReader` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/ltrreader.cpp#L27-L74
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class LtrFileMagicLe(IntEnum):
        ltr_space = 542266444

    class LtrFileVersionLe(IntEnum):
        v1_0 = 808333654
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareLtrCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareTlkCommon(KaitaiStruct):
    """LE ``u32`` tags matching xoreos ``MKTAG`` constants for TLK containers (same four bytes as ASCII
    ``"TLK "`` / ``"V3.0"`` / ``"V4.0"`` on disk).
    
    **Lowest-scope documentation:** enum members carry the upstream line anchors; `formats/TLK/TLK.ksy`
    imports this module and documents header layout / string table only.
    
    .. seealso::
       formats/TLK/TLK.ksy In-tree — TLK root (`tlk_header` consumes these enums)
    
    
    .. seealso::
       xoreos — `kTLKID`, `kVersion3`, `kVersion4` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L40-L42
    
    
    .. seealso::
       PyKotor — `io_tlk` (ASCII header tags + V3/V4 paths) - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196
    
    
    .. seealso::
       reone — `TlkReader` (`StringFlags`, load) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/tlkreader.cpp#L27-L67
    
    
    .. seealso::
       xoreos-docs — TalkTable_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/TalkTable_Format.pdf
    """

    class TlkFileMagicLe(IntEnum):
        tlk_space = 541805652

    class TlkFormatVersionLe(IntEnum):
        v3_0 = 808334166
        v4_0 = 808334422
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareTlkCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



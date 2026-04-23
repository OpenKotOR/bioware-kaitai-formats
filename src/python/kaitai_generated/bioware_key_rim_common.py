# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareKeyRimCommon(KaitaiStruct):
    """Aurora **KEY** master tables start with **`KEY `** (`u4` LE `0x2045594b`) plus a **version** tag (`key_file_version_le`:
    ``V1  `` or ``V1.1`` per PyKotor / Torlack). KotOR **RIM** module templates start with **`RIM `** (`u4` LE `0x204d4952`)
    and **``V1.0``** (`rim_format_version_le`, xoreos ``kVersion1``). Wire layouts: `formats/BIF/KEY.ksy`, `formats/RIM/RIM.ksy`.
    
    .. seealso::
       formats/BIF/KEY.ksy In-tree — KEY wire (`key_container_magic_le` on `file_type`)
    
    
    .. seealso::
       formats/RIM/RIM.ksy In-tree — RIM wire (`rim_container_magic_le` on `file_type`)
    
    
    .. seealso::
       xoreos — `KEYFile::load` (signature) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/keyfile.cpp#L50-L55
    
    
    .. seealso::
       xoreos — `kRIMID` / `RIMFile::load` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L36
    
    
    .. seealso::
       reone — `KeyReader::load` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/keyreader.cpp#L26-L35
    
    
    .. seealso::
       reone — `RimReader::load` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/rimreader.cpp#L26-L34
    
    
    .. seealso::
       xoreos-docs — KeyBIF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class KeyContainerMagicLe(IntEnum):
        key = 541415755

    class KeyFileVersionLe(IntEnum):
        v1_two_spaces = 538980694
        v1_1 = 825110870

    class RimContainerMagicLe(IntEnum):
        rim = 541935954

    class RimFormatVersionLe(IntEnum):
        v1_0 = 808333654
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareKeyRimCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareEclipseSaveCommon(KaitaiStruct):
    """Shared **user-type** definitions for **Eclipse-engine** binary saves (**Dragon Age: Origins** `DAS `, **Dragon Age 2** `DA2S`).
    
    File **signatures** as LE ``u32``: ``das_save_file_magic_le`` / ``da2s_save_file_magic_le`` (Andastra ``SaveSignature``).
    
    Import this file from `formats/DAS/DAS.ksy` and `formats/DA2S/DA2S.ksy` instead of duplicating `length_prefixed_string`.
    
    .. seealso::
       formats/Common/bioware_type_ids.ksy#L558-L559 In-tree — `xoreos_game_id` excerpt (**`dragon_age` (7)** / **`dragon_age2` (8)**; full `-1`..`max` table; mirrors `types.h` `GameID`)
    
    
    .. seealso::
       formats/DAS/DAS.ksy In-tree — DAO save (`das_save_file_magic_le` on `signature`)
    
    
    .. seealso::
       formats/DA2S/DA2S.ksy In-tree — DA2 save (`da2s_save_file_magic_le` on `signature`)
    
    
    .. seealso::
       Andastra — UTF-8 length-prefixed string read/write - https://github.com/OldRepublicDevs/Andastra/blob/9f49a4d88fc144f819488a0cc37de471eaa0f01b/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L61
    
    
    .. seealso::
       xoreos — `GameID` (Dragon Age entries) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L396-L408
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class Da2sSaveFileMagicLe(IntEnum):
        da2s = 1144144211

    class DasSaveFileMagicLe(IntEnum):
        das_space = 542327108
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareEclipseSaveCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass

    class LengthPrefixedString(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareEclipseSaveCommon.LengthPrefixedString, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.length = self._io.read_s4le()
            self.value = (KaitaiStream.bytes_terminate(self._io.read_bytes(self.length), 0, False)).decode(u"UTF-8")


        def _fetch_instances(self):
            pass

        @property
        def value_trimmed(self):
            """String value.
            Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
            """
            if hasattr(self, '_m_value_trimmed'):
                return self._m_value_trimmed

            self._m_value_trimmed = self.value
            return getattr(self, '_m_value_trimmed', None)




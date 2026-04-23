# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareSsfCommon(KaitaiStruct):
    """Shared SSF wire: **header tags** (`ssf_file_magic_le`, `ssf_file_version_le`, xoreos ``kSSFID`` / ``kVersion*``)
    plus the fixed **28-column** StrRef table for KotOR **V1.1** (`ssf_sound_slot`: index `0..27` maps to gameplay
    slots). The per-slot layout is **not** tagged on disk — column order follows PyKotor / xoreos ``readEntriesKotOR`` /
    xoreos-tools XML mapping.
    
    **Lowest-scope documentation:** vendor line anchors sit on each enum member; `formats/SSF/SSF.ksy` imports this
    module and documents offset / `0xFFFFFFFF` trailer only.
    
    .. seealso::
       formats/SSF/SSF.ksy#L94-L121 In-tree — SSF wire (`sound_array` / `sound_entry`) consuming this slot order
    
    
    .. seealso::
       PyKotor wiki — SSF hub - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
    
    
    .. seealso::
       PyKotor — `io_ssf` binary reader/writer (28 StrRefs) - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L112-L165
    
    
    .. seealso::
       xoreos — `SSFFile::readEntriesKotOR` (28× uint32) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L165-L170
    
    
    .. seealso::
       xoreos-tools — `SSFDumper::dump` (XML tag ↔ column) - https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfdumper.cpp#L133-L167
    
    
    .. seealso::
       xoreos-docs — SSF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/SSF_Format.pdf
    """

    class SsfFileMagicLe(IntEnum):
        ssf_space = 541476435

    class SsfFileVersionLe(IntEnum):
        v1_0_nwn = 808333654
        v1_1_kotor_or_nwn2 = 825110870

    class SsfSoundSlot(IntEnum):
        battle_cry_1 = 0
        battle_cry_2 = 1
        battle_cry_3 = 2
        battle_cry_4 = 3
        battle_cry_5 = 4
        battle_cry_6 = 5
        select_1 = 6
        select_2 = 7
        select_3 = 8
        attack_grunt_1 = 9
        attack_grunt_2 = 10
        attack_grunt_3 = 11
        pain_grunt_1 = 12
        pain_grunt_2 = 13
        low_health = 14
        dead = 15
        critical_hit = 16
        target_immune = 17
        lay_mine = 18
        disarm_mine = 19
        begin_stealth = 20
        begin_search = 21
        begin_unlock = 22
        unlock_failed = 23
        unlock_success = 24
        separated_from_party = 25
        rejoined_party = 26
        poisoned = 27
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareSsfCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



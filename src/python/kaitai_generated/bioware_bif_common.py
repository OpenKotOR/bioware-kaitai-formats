# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareBifCommon(KaitaiStruct):
    """First **four bytes** of classic Aurora **BIF** rows are the inner tag **`BIFF`** (`u4` LE `0x46464942`), followed by a **version**
    tag (`bif_file_version_le`: ``V1  `` or ``V1.1`` per PyKotor / xoreos). **BZF** mobile / compressed capsules use an **outer** tag **`BZF `**
    (`u4` LE `0x20465a42`) then **``V1.0``** (`bzf_outer_file_version_le`) + LZMA payload (`formats/BIF/BZF.ksy`).
    
    .. seealso::
       formats/BIF/BIF.ksy In-tree — uncompressed BIF (`bif_inner_container_magic_le` + `bif_file_version_le`)
    
    
    .. seealso::
       formats/BIF/BZF.ksy In-tree — BZF outer capsule (`bzf_outer_container_magic_le` + `bzf_outer_file_version_le`)
    
    
    .. seealso::
       PyKotor — `BIFType` - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71
    
    
    .. seealso::
       xoreos — `BIFFile::load` (BIFF header) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/biffile.cpp#L54-L60
    
    
    .. seealso::
       xoreos — `BZFFile::load` (outer vs inner tag notes) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/bzffile.cpp#L41-L55
    
    
    .. seealso::
       reone — `BifReader::load` (`BIFFV1  ` check) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/bifreader.cpp#L26-L29
    
    
    .. seealso::
       xoreos-docs — KeyBIF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/KeyBIF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class BifFileVersionLe(IntEnum):
        v1_two_spaces = 538980694
        v1_1 = 825110870

    class BifInnerContainerMagicLe(IntEnum):
        biff = 1179011394

    class BzfOuterContainerMagicLe(IntEnum):
        bzf = 541481538

    class BzfOuterFileVersionLe(IntEnum):
        v1_0 = 808333654
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareBifCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



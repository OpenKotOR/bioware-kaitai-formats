# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareErfCommon(KaitaiStruct):
    """First **four bytes** of Aurora **ERF** / **MOD** / **SAV** / **HAK** containers are ASCII space-padded tags read as **`u4` LE**
    on little-endian hosts (`ERF ` → `0x20465245`, etc.). KotOR-era archives use **``V1.0``** as the next **four** bytes
    (`erf_format_version_le`, xoreos ``kVersion10``). `formats/ERF/ERF.ksy` binds `erf_header.file_type` to
    `erf_container_magic_le` and `erf_header.file_version` to `erf_format_version_le`.
    
    .. seealso::
       formats/ERF/ERF.ksy In-tree — full ERF wire (`erf_container_magic_le` + `erf_format_version_le`)
    
    
    .. seealso::
       PyKotor — `ERFType` - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L107
    
    
    .. seealso::
       xoreos — `kERFID` / `kMODID` / `kHAKID` / `kSAVID` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/erffile.cpp#L50-L59
    
    
    .. seealso::
       reone — `ErfReader::checkSignature` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/erfreader.cpp#L41-L51
    
    
    .. seealso::
       xoreos-docs — ERF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/ERF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class ErfContainerMagicLe(IntEnum):
        mod = 541347661
        erf = 541479493
        hak = 541802824
        sav = 542523731

    class ErfFormatVersionLe(IntEnum):
        v1_0 = 808333654
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareErfCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



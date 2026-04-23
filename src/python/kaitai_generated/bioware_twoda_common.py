# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareTwodaCommon(KaitaiStruct):
    """LE ``u32`` tags for Aurora **binary** TwoDA headers (ASCII fourcc + version token), matching xoreos ``MKTAG`` ids
    in ``2dafile.cpp`` and PyKotor ``io_twoda`` / reone ``TwoDAReader``.
    
    **Lowest-scope documentation:** enum members carry upstream anchors; ``formats/TwoDA/TwoDA.ksy`` models the full
    ``V2.b`` blob (column headers, offsets, …) only.
    
    .. seealso::
       formats/TwoDA/TwoDA.ksy In-tree — binary TwoDA root (`twoda_header` consumes these enums)
    
    
    .. seealso::
       xoreos — `k2DAID` / `k2DAIDTab` / `kVersion2a` / `kVersion2b` - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51
    
    
    .. seealso::
       PyKotor — `io_twoda` - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238
    
    
    .. seealso::
       reone — `TwoDAReader` - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/2dareader.cpp#L29-L66
    
    
    .. seealso::
       xoreos-docs — 2DA_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/2DA_Format.pdf
    """

    class TwoDaBinaryVersionLe(IntEnum):
        v2_0 = 808333910
        v2_b = 1647194710

    class TwoDaFileMagicLe(IntEnum):
        two_da_space = 541148210
        two_da_tab = 843138057
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareTwodaCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



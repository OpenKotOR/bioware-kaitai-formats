# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct
import tpc


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Txb(KaitaiStruct):
    """**TXB** (`kFileTypeTXB` **3006**): xoreos classifies this as a texture alongside **TPC** / **TXB2**. Community loaders
    (PyKotor / reone) route many TXB payloads through the same **128-byte TPC header** + tail layout as native **TPC**.

    This capsule **reuses** `tpc::tpc_header` + opaque tail so emitters share one header struct. If a shipped TXB
    variant diverges, split a dedicated header type and cite Ghidra / binary evidence (`TODO: VERIFY`).

    .. seealso::
       xoreos — `kFileTypeTXB` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L182


    .. seealso::
       xoreos — `TPC::load` (texture family) - https://github.com/xoreos/xoreos/blob/master/src/graphics/images/tpc.cpp#L52-L66


    .. seealso::
       xoreos-tools — `TPC::load` - https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L51-L68


    .. seealso::
       xoreos-tools — `TPC::readHeader` - https://github.com/xoreos/xoreos-tools/blob/master/src/images/tpc.cpp#L77-L224


    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware


    .. seealso::
       xoreos-docs — KotOR MDL overview (texture pipeline context) - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html


    .. seealso::
       PyKotor wiki — texture family (cross-check TXB) - https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Txb, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = tpc.Tpc.TpcHeader(self._io)
        self.body = self._io.read_bytes_full()

    def _fetch_instances(self):
        pass
        self.header._fetch_instances()

# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Bip(KaitaiStruct):
    """**BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
    framed wire lives in `LIP.ksy`.

    **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
    exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.

    .. seealso::
       xoreos — `kFileTypeBIP` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198


    .. seealso::
       PyKotor wiki — LIP family - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip


    .. seealso::
       xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Bip, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.payload = self._io.read_bytes_full()

    def _fetch_instances(self):
        pass

# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Lip(KaitaiStruct):
    """**LIP** (lip sync): sorted `(timestamp_f32, viseme_u8)` keyframes (`LIP ` / `V1.0`). Viseme ids 0–15 map through
    `bioware_lip_viseme_id` in `bioware_common.ksy`. Pair with a **WAV** of matching duration.
    
    xoreos does not ship a standalone `lipfile.cpp` reader — use PyKotor / reone / KotOR.js (`meta.xref`).
    
    .. seealso::
       PyKotor wiki — LIP - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip
    
    
    .. seealso::
       reone — LIPReader - https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/graphics/format/lipreader.cpp#L27-L42
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Lip, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        self.length = self._io.read_f4le()
        self.num_keyframes = self._io.read_u4le()
        self.keyframes = []
        for i in range(self.num_keyframes):
            self.keyframes.append(Lip.KeyframeEntry(self._io, self, self._root))



    def _fetch_instances(self):
        pass
        for i in range(len(self.keyframes)):
            pass
            self.keyframes[i]._fetch_instances()


    class KeyframeEntry(KaitaiStruct):
        """A single keyframe entry mapping a timestamp to a viseme (mouth shape).
        Keyframes are used by the engine to interpolate between mouth shapes during
        audio playback to create lip sync animation.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Lip.KeyframeEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.timestamp = self._io.read_f4le()
            self.shape = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareLipVisemeId, self._io.read_u1())


        def _fetch_instances(self):
            pass




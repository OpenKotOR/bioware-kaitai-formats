# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Ssf(KaitaiStruct):
    """**SSF** (sound set): 28 StrRef slots for a voice set. **Wire:** `SSF ` + `V1.1` header (12 B) → `sounds_offset`
    (usually 12) → 28×`u4` (`0xFFFFFFFF` = empty). Many vanilla files append a 12-byte `0xFF` trailer — not modeled.
    
    Row indices map through `bioware_ssf_sound_slot` in `formats/Common/bioware_common.ksy` (Kaitai cannot attach imported
    enums to `repeat` indices here).
    
    .. seealso::
       PyKotor wiki — SSF - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
    
    
    .. seealso::
       xoreos — SSF::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/ssffile.cpp#L72-L85
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Ssf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_type == u"SSF ":
            raise kaitaistruct.ValidationNotEqualError(u"SSF ", self.file_type, self._io, u"/seq/0")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        if not self.file_version == u"V1.1":
            raise kaitaistruct.ValidationNotEqualError(u"V1.1", self.file_version, self._io, u"/seq/1")
        self.sounds_offset = self._io.read_u4le()


    def _fetch_instances(self):
        pass
        _ = self.sounds
        if hasattr(self, '_m_sounds'):
            pass
            self._m_sounds._fetch_instances()


    class SoundArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Ssf.SoundArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(28):
                self.entries.append(Ssf.SoundEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class SoundEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Ssf.SoundEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.strref_raw = self._io.read_u4le()


        def _fetch_instances(self):
            pass

        @property
        def is_no_sound(self):
            """True if this entry represents "no sound" (0xFFFFFFFF).
            False if this entry contains a valid StrRef value.
            """
            if hasattr(self, '_m_is_no_sound'):
                return self._m_is_no_sound

            self._m_is_no_sound = self.strref_raw == 4294967295
            return getattr(self, '_m_is_no_sound', None)


    @property
    def sounds(self):
        """Array of 28 sound string references (StrRefs)."""
        if hasattr(self, '_m_sounds'):
            return self._m_sounds

        _pos = self._io.pos()
        self._io.seek(self.sounds_offset)
        self._m_sounds = Ssf.SoundArray(self._io, self, self._root)
        self._io.seek(_pos)
        return getattr(self, '_m_sounds', None)



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Ssf(KaitaiStruct):
    """SSF (Sound Set File) files store sound string references (StrRefs) for character voice sets.
    Each SSF file contains exactly 28 sound slots, mapping to different game events and actions.

    Binary Format:
    - Header (12 bytes): File type signature, version, and offset to sounds array (usually 12)
    - Sounds Array (112 bytes at sounds_offset): 28 uint32 values representing StrRefs (0xFFFFFFFF = -1 = no sound)

    Vanilla KotOR SSFs are typically 136 bytes total: after the 28 StrRefs, many files append 12 bytes
    of 0xFFFFFFFF padding; that trailer is not part of the header and is not modeled here.

    Sound Slots (in order):
    0-5: Battle Cry 1-6
    6-8: Select 1-3
    9-11: Attack Grunt 1-3
    12-13: Pain Grunt 1-2
    14: Low Health
    15: Dead
    16: Critical Hit
    17: Target Immune
    18: Lay Mine
    19: Disarm Mine
    20: Begin Stealth
    21: Begin Search
    22: Begin Unlock
    23: Unlock Failed
    24: Unlock Success
    25: Separated From Party
    26: Rejoined Party
    27: Poisoned

    Authoritative implementations: `meta.xref` and `doc-ref` (PyKotor `io_ssf`, xoreos `ssffile.cpp`, xoreos-tools `ssf2xml` / `xml2ssf`, xoreos-docs `SSF_Format.pdf`, reone `SsfReader`).

    .. seealso::
       PyKotor wiki — SSF - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf


    .. seealso::
       PyKotor — `io_ssf` (Kaitai bridge + binary read/write) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L102-L166


    .. seealso::
       xoreos — `kFileTypeSSF` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L126


    .. seealso::
       xoreos — `SSFFile::load` + `readSSFHeader` + `readEntries` - https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L72-L141


    .. seealso::
       xoreos — `readEntriesKotOR` - https://github.com/xoreos/xoreos/blob/master/src/aurora/ssffile.cpp#L165-L170


    .. seealso::
       xoreos-tools — `ssf2xml` CLI - https://github.com/xoreos/xoreos-tools/blob/master/src/ssf2xml.cpp#L51-L70


    .. seealso::
       xoreos-tools — `xml2ssf` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml2ssf.cpp#L54-L75


    .. seealso::
       xoreos-tools — `SSFDumper::dump` (XML mapping for `ssf2xml`) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfdumper.cpp#L133-L167


    .. seealso::
       xoreos-tools — `SSFCreator::create` (XML mapping for `xml2ssf`) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/ssfcreator.cpp#L38-L74


    .. seealso::
       xoreos-docs — SSF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/SSF_Format.pdf


    .. seealso::
       reone — `SsfReader::load` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/ssfreader.cpp#L26-L32
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Ssf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode("ASCII")
        if not self.file_type == "SSF ":
            raise kaitaistruct.ValidationNotEqualError(
                "SSF ", self.file_type, self._io, "/seq/0"
            )
        self.file_version = (self._io.read_bytes(4)).decode("ASCII")
        if not self.file_version == "V1.1":
            raise kaitaistruct.ValidationNotEqualError(
                "V1.1", self.file_version, self._io, "/seq/1"
            )
        self.sounds_offset = self._io.read_u4le()

    def _fetch_instances(self):
        pass
        _ = self.sounds
        if hasattr(self, "_m_sounds"):
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
            if hasattr(self, "_m_is_no_sound"):
                return self._m_is_no_sound

            self._m_is_no_sound = self.strref_raw == 4294967295
            return getattr(self, "_m_is_no_sound", None)

    @property
    def sounds(self):
        """Array of 28 sound string references (StrRefs)."""
        if hasattr(self, "_m_sounds"):
            return self._m_sounds

        _pos = self._io.pos()
        self._io.seek(self.sounds_offset)
        self._m_sounds = Ssf.SoundArray(self._io, self, self._root)
        self._io.seek(_pos)
        return getattr(self, "_m_sounds", None)

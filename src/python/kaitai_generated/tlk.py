# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Tlk(KaitaiStruct):
    """TLK (Talk Table) files contain all text strings used in the game, both written and spoken.
    They enable easy localization by providing a lookup table from string reference numbers (StrRef)
    to localized text and associated voice-over audio files.
    
    Binary Format Structure:
    - File Header (20 bytes): File type signature, version, language ID, string count, entries offset
    - String Data Table (40 bytes per entry): Metadata for each string entry (flags, sound ResRef, offsets, lengths)
    - String Entries (variable size): Sequential null-terminated text strings starting at entries_offset
    
    The format uses a two-level structure:
    1. String Data Table: Contains metadata (flags, sound filename, text offset/length) for each entry
    2. String Entries: Actual text data stored sequentially, referenced by offsets in the data table
    
    String references (StrRef) are 0-based indices into the string_data_table array. StrRef 0 refers to
    the first entry, StrRef 1 to the second, etc. StrRef -1 indicates no string reference.
    
    Authoritative index: `meta.xref` and `doc-ref` (PyKotor, xoreos `talktable*` + `talktable_tlk`, xoreos-tools CLIs, reone, KotOR.js, NickHugi/Kotor.NET). Legacy Perl / archived community URLs are omitted when they no longer resolve on GitHub.
    
    .. seealso::
       PyKotor wiki — TLK - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
    
    
    .. seealso::
       PyKotor — `io_tlk` (sizes, Kaitai + legacy + write) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk.py#L23-L196
    
    
    .. seealso::
       xoreos — `TalkTable::load` (factory dispatch) - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable.cpp#L35-L69
    
    
    .. seealso::
       xoreos — TLK id/version + `TalkTable_TLK::load` + V3/V4 entry tables - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L40-L114
    
    
    .. seealso::
       xoreos — `kFileTypeTLK` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L87
    
    
    .. seealso::
       xoreos — `Language` / `LanguageGender` (TLK `language_id` / substring packing) - https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73
    
    
    .. seealso::
       xoreos-tools — `tlk2xml` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/tlk2xml.cpp#L56-L80
    
    
    .. seealso::
       xoreos-tools — `xml2tlk` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml2tlk.cpp#L58-L85
    
    
    .. seealso::
       reone — `TlkReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/tlkreader.cpp#L27-L67
    
    
    .. seealso::
       KotOR.js — `TLKObject` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TLKObject.ts#L16-L77
    
    
    .. seealso::
       NickHugi/Kotor.NET — `TLKBinaryReader` (`Read` + constructors) - https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorTLK/TLKBinaryReader.cs#L16-L52
    
    
    .. seealso::
       xoreos-docs — TalkTable_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/TalkTable_Format.pdf
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Tlk, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Tlk.TlkHeader(self._io, self, self._root)
        self.string_data_table = Tlk.StringDataTable(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        self.string_data_table._fetch_instances()

    class StringDataEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tlk.StringDataEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.flags = self._io.read_u4le()
            self.sound_resref = (self._io.read_bytes(16)).decode(u"ASCII")
            self.volume_variance = self._io.read_u4le()
            self.pitch_variance = self._io.read_u4le()
            self.text_offset = self._io.read_u4le()
            self.text_length = self._io.read_u4le()
            self.sound_length = self._io.read_f4le()


        def _fetch_instances(self):
            pass
            _ = self.text_data
            if hasattr(self, '_m_text_data'):
                pass


        @property
        def entry_size(self):
            """Size of each string_data_entry in bytes.
            Breakdown: flags (4) + sound_resref (16) + volume_variance (4) + pitch_variance (4) + 
            text_offset (4) + text_length (4) + sound_length (4) = 40 bytes total.
            """
            if hasattr(self, '_m_entry_size'):
                return self._m_entry_size

            self._m_entry_size = 40
            return getattr(self, '_m_entry_size', None)

        @property
        def sound_length_present(self):
            """Whether sound length is valid (bit 2 of flags)."""
            if hasattr(self, '_m_sound_length_present'):
                return self._m_sound_length_present

            self._m_sound_length_present = self.flags & 4 != 0
            return getattr(self, '_m_sound_length_present', None)

        @property
        def sound_present(self):
            """Whether voice-over audio exists (bit 1 of flags)."""
            if hasattr(self, '_m_sound_present'):
                return self._m_sound_present

            self._m_sound_present = self.flags & 2 != 0
            return getattr(self, '_m_sound_present', None)

        @property
        def text_data(self):
            """Text string data as raw bytes (read as ASCII for byte-level access).
            The actual encoding depends on the language_id in the header.
            Common encodings:
            - English/French/German/Italian/Spanish: Windows-1252 (cp1252)
            - Polish: Windows-1250 (cp1250)
            - Korean: EUC-KR (cp949)
            - Chinese Traditional: Big5 (cp950)
            - Chinese Simplified: GB2312 (cp936)
            - Japanese: Shift-JIS (cp932)
            
            Note: This field reads the raw bytes as ASCII string for byte-level access.
            The application layer should decode based on the language_id field in the header.
            To get raw bytes, access the underlying byte representation of this string.
            
            In practice, strings are stored sequentially starting at entries_offset,
            so text_offset values are relative to entries_offset (0, len1, len1+len2, etc.).
            
            Strings may be null-terminated, but text_length includes the null terminator.
            Application code should trim null bytes when decoding.
            
            If text_present flag (bit 0) is not set, this field may contain garbage data
            or be empty. Always check text_present before using this data.
            """
            if hasattr(self, '_m_text_data'):
                return self._m_text_data

            _pos = self._io.pos()
            self._io.seek(self.text_file_offset)
            self._m_text_data = (self._io.read_bytes(self.text_length)).decode(u"ASCII")
            self._io.seek(_pos)
            return getattr(self, '_m_text_data', None)

        @property
        def text_file_offset(self):
            """Absolute file offset to the text string.
            Calculated as entries_offset (from header) + text_offset (from entry).
            """
            if hasattr(self, '_m_text_file_offset'):
                return self._m_text_file_offset

            self._m_text_file_offset = self._root.header.entries_offset + self.text_offset
            return getattr(self, '_m_text_file_offset', None)

        @property
        def text_present(self):
            """Whether text content exists (bit 0 of flags)."""
            if hasattr(self, '_m_text_present'):
                return self._m_text_present

            self._m_text_present = self.flags & 1 != 0
            return getattr(self, '_m_text_present', None)


    class StringDataTable(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tlk.StringDataTable, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.string_count):
                self.entries.append(Tlk.StringDataEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()



    class TlkHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Tlk.TlkHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
            self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
            self.language_id = self._io.read_u4le()
            self.string_count = self._io.read_u4le()
            self.entries_offset = self._io.read_u4le()


        def _fetch_instances(self):
            pass

        @property
        def expected_entries_offset(self):
            """Expected offset to string entries (header + string data table).
            Used for validation.
            """
            if hasattr(self, '_m_expected_entries_offset'):
                return self._m_expected_entries_offset

            self._m_expected_entries_offset = 20 + self.string_count * 40
            return getattr(self, '_m_expected_entries_offset', None)

        @property
        def header_size(self):
            """Size of the TLK header in bytes."""
            if hasattr(self, '_m_header_size'):
                return self._m_header_size

            self._m_header_size = 20
            return getattr(self, '_m_header_size', None)




# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Wav(KaitaiStruct):
    """**KotOR WAV:** standard **RIFF/WAVE** (`fmt ` + `data`) plus engine-specific cases (VO vs SFX obfuscation wrappers,
    MP3-in-WAV quirks) described on the PyKotor wiki — this `.ksy` models the **core RIFF chunk tree**; 470-byte SFX /
    20-byte VO prefixes are application-level.
    
    `wFormatTag` / PCM layout notes: `bioware_common.ksy` → `riff_wave_format_tag`.
    
    The `xoreos-tools` tree does not ship a RIFF/WAVE wire parser on `master` (see `meta.xref.xoreos_tools_wav_note`); use xoreos `wave.cpp` / `sound.cpp` and PyKotor `io_wav.py` for chunk behavior.
    
    .. seealso::
       PyKotor wiki — WAV - https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#wav
    
    
    .. seealso::
       PyKotor — `io_wav` (Kaitai RIFF parse + `WAVBinaryReader.load` + legacy) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/io_wav.py#L43-L187
    
    
    .. seealso::
       reone — `WavReader` (fake header + chunk loop) - https://github.com/modawan/reone/blob/master/src/libs/audio/format/wavreader.cpp#L30-L72
    
    
    .. seealso::
       xoreos — `makeWAVStream` / chunk scan - https://github.com/xoreos/xoreos/blob/master/src/sound/decoders/wave.cpp#L38-L106
    
    
    .. seealso::
       xoreos — `SoundManager::makeAudioStream` KotOR WAVE quirks - https://github.com/xoreos/xoreos/blob/master/src/sound/sound.cpp#L256-L340
    
    
    .. seealso::
       xoreos — `kFileTypeWAV` (numeric id) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L62
    
    
    .. seealso::
       KotOR.js — `AudioFile` (prefix + MP3-in-WAV) - https://github.com/KobaltBlu/KotOR.js/blob/master/src/audio/AudioFile.ts#L10-L145
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree (no dedicated WAV PDF; discoverability anchor) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Wav, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.riff_header = Wav.RiffHeader(self._io, self, self._root)
        self.chunks = []
        i = 0
        while True:
            _ = Wav.Chunk(self._io, self, self._root)
            self.chunks.append(_)
            if self._io.is_eof():
                break
            i += 1


    def _fetch_instances(self):
        pass
        self.riff_header._fetch_instances()
        for i in range(len(self.chunks)):
            pass
            self.chunks[i]._fetch_instances()


    class Chunk(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.Chunk, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.id = (self._io.read_bytes(4)).decode(u"ASCII")
            self.size = self._io.read_u4le()
            _on = self.id
            if _on == u"data":
                pass
                self.body = Wav.DataChunkBody(self._io, self, self._root)
            elif _on == u"fact":
                pass
                self.body = Wav.FactChunkBody(self._io, self, self._root)
            elif _on == u"fmt ":
                pass
                self.body = Wav.FormatChunkBody(self._io, self, self._root)
            else:
                pass
                self.body = Wav.UnknownChunkBody(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            _on = self.id
            if _on == u"data":
                pass
                self.body._fetch_instances()
            elif _on == u"fact":
                pass
                self.body._fetch_instances()
            elif _on == u"fmt ":
                pass
                self.body._fetch_instances()
            else:
                pass
                self.body._fetch_instances()


    class DataChunkBody(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.DataChunkBody, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.data = self._io.read_bytes(self._parent.size)


        def _fetch_instances(self):
            pass


    class FactChunkBody(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.FactChunkBody, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.sample_count = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class FormatChunkBody(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.FormatChunkBody, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.audio_format = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.RiffWaveFormatTag, self._io.read_u2le())
            self.channels = self._io.read_u2le()
            self.sample_rate = self._io.read_u4le()
            self.bytes_per_sec = self._io.read_u4le()
            self.block_align = self._io.read_u2le()
            self.bits_per_sample = self._io.read_u2le()
            if self._parent.size > 16:
                pass
                self.extra_format_bytes = self._io.read_bytes(self._parent.size - 16)



        def _fetch_instances(self):
            pass
            if self._parent.size > 16:
                pass


        @property
        def is_ima_adpcm(self):
            """True if audio format is IMA ADPCM (compressed)."""
            if hasattr(self, '_m_is_ima_adpcm'):
                return self._m_is_ima_adpcm

            self._m_is_ima_adpcm = self.audio_format == bioware_common.BiowareCommon.RiffWaveFormatTag.dvi_ima_adpcm
            return getattr(self, '_m_is_ima_adpcm', None)

        @property
        def is_mp3(self):
            """True if audio format is MP3."""
            if hasattr(self, '_m_is_mp3'):
                return self._m_is_mp3

            self._m_is_mp3 = self.audio_format == bioware_common.BiowareCommon.RiffWaveFormatTag.mpeg_layer3
            return getattr(self, '_m_is_mp3', None)

        @property
        def is_pcm(self):
            """True if audio format is PCM (uncompressed)."""
            if hasattr(self, '_m_is_pcm'):
                return self._m_is_pcm

            self._m_is_pcm = self.audio_format == bioware_common.BiowareCommon.RiffWaveFormatTag.pcm
            return getattr(self, '_m_is_pcm', None)


    class RiffHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.RiffHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.riff_id = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.riff_id == u"RIFF":
                raise kaitaistruct.ValidationNotEqualError(u"RIFF", self.riff_id, self._io, u"/types/riff_header/seq/0")
            self.riff_size = self._io.read_u4le()
            self.wave_id = (self._io.read_bytes(4)).decode(u"ASCII")
            if not self.wave_id == u"WAVE":
                raise kaitaistruct.ValidationNotEqualError(u"WAVE", self.wave_id, self._io, u"/types/riff_header/seq/2")


        def _fetch_instances(self):
            pass

        @property
        def is_mp3_in_wav(self):
            """MP3-in-WAV format detected when RIFF size = 50
            Reference: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/wav/wav_obfuscation.py#L98-L103 (`riff_size` read + `MP3_IN_WAV_RIFF_SIZE` check)
            """
            if hasattr(self, '_m_is_mp3_in_wav'):
                return self._m_is_mp3_in_wav

            self._m_is_mp3_in_wav = self.riff_size == 50
            return getattr(self, '_m_is_mp3_in_wav', None)


    class UnknownChunkBody(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Wav.UnknownChunkBody, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.data = self._io.read_bytes(self._parent.size)
            if self._parent.size % 2 == 1:
                pass
                self.padding = self._io.read_u1()



        def _fetch_instances(self):
            pass
            if self._parent.size % 2 == 1:
                pass





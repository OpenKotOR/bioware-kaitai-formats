# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
from enum import IntEnum


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class BiowareCommon(KaitaiStruct):
    """Shared enums and "common objects" used across the BioWare ecosystem that also appear
    in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).

    This file is intended to be imported by other `.ksy` files to avoid repeating:
    - Language IDs (used in TLK headers and GFF LocalizedString substrings)
    - Gender IDs (used in GFF LocalizedString substrings)
    - The CExoLocString / LocalizedString binary layout

    References:
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
    - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
    - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h

    .. seealso::
       PyKotor — Language (substring language IDs) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py


    .. seealso::
       PyKotor — Gender / Game / EquipmentSlot - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py


    .. seealso::
       PyKotor — ObjectType - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py


    .. seealso::
       PyKotor — GFF field read path (LocalizedString via reader) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235


    .. seealso::
       xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing) - https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73


    .. seealso::
       xoreos — `TalkTable_TLK::load` (TLK header + language id field) - https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92


    .. seealso::
       xoreos-tools — `byte` / `uint` typedefs - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33


    .. seealso::
       reone — resource type / engine constants - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h


    .. seealso::
       xoreos-docs — BioWare specs PDF tree (discoverability) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    class BiowareDdsVariantBytesPerPixel(IntEnum):
        dxt1 = 3
        dxt5 = 4

    class BiowareEquipmentSlotFlag(IntEnum):
        invalid = 0
        head = 1
        armor = 2
        gauntlet = 8
        right_hand = 16
        left_hand = 32
        right_arm = 128
        left_arm = 256
        implant = 512
        belt = 1024
        claw1 = 16384
        claw2 = 32768
        claw3 = 65536
        hide = 131072
        right_hand_2 = 262144
        left_hand_2 = 524288

    class BiowareGameId(IntEnum):
        k1 = 1
        k2 = 2
        k1_xbox = 3
        k2_xbox = 4
        k1_ios = 5
        k2_ios = 6
        k1_android = 7
        k2_android = 8

    class BiowareGenderId(IntEnum):
        male = 0
        female = 1

    class BiowareLanguageId(IntEnum):
        english = 0
        french = 1
        german = 2
        italian = 3
        spanish = 4
        polish = 5
        afrikaans = 6
        basque = 7
        breton = 9
        catalan = 10
        chamorro = 11
        chichewa = 12
        corsican = 13
        danish = 14
        dutch = 15
        faroese = 16
        filipino = 18
        finnish = 19
        flemish = 20
        frisian = 21
        galician = 22
        ganda = 23
        haitian_creole = 24
        hausa_latin = 25
        hawaiian = 26
        icelandic = 27
        ido = 28
        indonesian = 29
        igbo = 30
        irish = 31
        interlingua = 32
        javanese_latin = 33
        latin = 34
        luxembourgish = 35
        maltese = 36
        norwegian = 37
        occitan = 38
        portuguese = 39
        scots = 40
        scottish_gaelic = 41
        shona = 42
        soto = 43
        sundanese_latin = 44
        swahili = 45
        swedish = 46
        tagalog = 47
        tahitian = 48
        tongan = 49
        uzbek_latin = 50
        walloon = 51
        xhosa = 52
        yoruba = 53
        welsh = 54
        zulu = 55
        bulgarian = 58
        belarisian = 59
        macedonian = 60
        russian = 61
        serbian_cyrillic = 62
        tajik = 63
        tatar_cyrillic = 64
        ukrainian = 66
        uzbek = 67
        albanian = 68
        bosnian_latin = 69
        czech = 70
        slovak = 71
        slovene = 72
        croatian = 73
        hungarian = 75
        romanian = 76
        greek = 77
        esperanto = 78
        azerbaijani_latin = 79
        turkish = 81
        turkmen_latin = 82
        hebrew = 83
        arabic = 84
        estonian = 85
        latvian = 86
        lithuanian = 87
        vietnamese = 88
        thai = 89
        aymara = 90
        kinyarwanda = 91
        kurdish_latin = 92
        malagasy = 93
        malay_latin = 94
        maori = 95
        moldovan_latin = 96
        samoan = 97
        somali = 98
        korean = 128
        chinese_traditional = 129
        chinese_simplified = 130
        japanese = 131
        unknown = 2147483646

    class BiowareLipVisemeId(IntEnum):
        neutral = 0
        ee = 1
        eh = 2
        ah = 3
        oh = 4
        ooh = 5
        y = 6
        sts = 7
        fv = 8
        ng = 9
        th = 10
        mpb = 11
        td = 12
        sh = 13
        l = 14
        kg = 15

    class BiowareLtrAlphabetLength(IntEnum):
        neverwinter_nights = 26
        kotor = 28

    class BiowareObjectTypeId(IntEnum):
        invalid = 0
        creature = 1
        door = 2
        item = 3
        trigger = 4
        placeable = 5
        waypoint = 6
        encounter = 7
        store = 8
        area = 9
        sound = 10
        camera = 11

    class BiowarePccCompressionCodec(IntEnum):
        none = 0
        zlib = 1
        lzo = 2

    class BiowarePccPackageKind(IntEnum):
        normal_package = 0
        patch_package = 1

    class BiowareTpcPixelFormatId(IntEnum):
        greyscale = 1
        rgb_or_dxt1 = 2
        rgba_or_dxt5 = 4
        bgra_xbox_swizzle = 12

    class RiffWaveFormatTag(IntEnum):
        pcm = 1
        adpcm_ms = 2
        ieee_float = 3
        alaw = 6
        mulaw = 7
        dvi_ima_adpcm = 17
        mpeg_layer3 = 85
        wave_format_extensible = 65534

    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass

    def _fetch_instances(self):
        pass

    class BiowareBinaryData(KaitaiStruct):
        """Variable-length binary data with 4-byte length prefix.
        Used for Void/Binary fields in GFF files.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareBinaryData, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.len_value = self._io.read_u4le()
            self.value = self._io.read_bytes(self.len_value)

        def _fetch_instances(self):
            pass

    class BiowareCexoString(KaitaiStruct):
        """BioWare CExoString - variable-length string with 4-byte length prefix.
        Used for string fields in GFF files.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareCexoString, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.len_string = self._io.read_u4le()
            self.value = (self._io.read_bytes(self.len_string)).decode("UTF-8")

        def _fetch_instances(self):
            pass

    class BiowareLocstring(KaitaiStruct):
        """BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
        section for field type "LocalizedString".
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareLocstring, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.total_size = self._io.read_u4le()
            self.string_ref = self._io.read_u4le()
            self.num_substrings = self._io.read_u4le()
            self.substrings = []
            for i in range(self.num_substrings):
                self.substrings.append(
                    BiowareCommon.Substring(self._io, self, self._root)
                )

        def _fetch_instances(self):
            pass
            for i in range(len(self.substrings)):
                pass
                self.substrings[i]._fetch_instances()

        @property
        def has_strref(self):
            """True if this locstring references dialog.tlk."""
            if hasattr(self, "_m_has_strref"):
                return self._m_has_strref

            self._m_has_strref = self.string_ref != 4294967295
            return getattr(self, "_m_has_strref", None)

    class BiowareResref(KaitaiStruct):
        """BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
        Used throughout GFF files to reference game resources by name.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareResref, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.len_resref = self._io.read_u1()
            if not self.len_resref <= 16:
                raise kaitaistruct.ValidationGreaterThanError(
                    16, self.len_resref, self._io, "/types/bioware_resref/seq/0"
                )
            self.value = (self._io.read_bytes(self.len_resref)).decode("ASCII")

        def _fetch_instances(self):
            pass

    class BiowareVector3(KaitaiStruct):
        """3D vector (X, Y, Z coordinates).
        Used for positions, directions, etc. in game files.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareVector3, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.x = self._io.read_f4le()
            self.y = self._io.read_f4le()
            self.z = self._io.read_f4le()

        def _fetch_instances(self):
            pass

    class BiowareVector4(KaitaiStruct):
        """4D vector / Quaternion (X, Y, Z, W components).
        Used for orientations/rotations in game files.
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.BiowareVector4, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.x = self._io.read_f4le()
            self.y = self._io.read_f4le()
            self.z = self._io.read_f4le()
            self.w = self._io.read_f4le()

        def _fetch_instances(self):
            pass

    class Substring(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareCommon.Substring, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.substring_id = self._io.read_u4le()
            self.len_text = self._io.read_u4le()
            self.text = (self._io.read_bytes(self.len_text)).decode("UTF-8")

        def _fetch_instances(self):
            pass

        @property
        def gender(self):
            """Gender as enum value."""
            if hasattr(self, "_m_gender"):
                return self._m_gender

            self._m_gender = KaitaiStream.resolve_enum(
                BiowareCommon.BiowareGenderId, self.gender_raw
            )
            return getattr(self, "_m_gender", None)

        @property
        def gender_raw(self):
            """Raw gender ID (0..255)."""
            if hasattr(self, "_m_gender_raw"):
                return self._m_gender_raw

            self._m_gender_raw = self.substring_id & 255
            return getattr(self, "_m_gender_raw", None)

        @property
        def language(self):
            """Language as enum value."""
            if hasattr(self, "_m_language"):
                return self._m_language

            self._m_language = KaitaiStream.resolve_enum(
                BiowareCommon.BiowareLanguageId, self.language_raw
            )
            return getattr(self, "_m_language", None)

        @property
        def language_raw(self):
            """Raw language ID (0..255)."""
            if hasattr(self, "_m_language_raw"):
                return self._m_language_raw

            self._m_language_raw = self.substring_id >> 8 & 255
            return getattr(self, "_m_language_raw", None)

# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Shared enums and "common objects" used across the BioWare ecosystem that also appear
# in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).
# 
# This file is intended to be imported by other `.ksy` files to avoid repeating:
# - Language IDs (used in TLK headers and GFF LocalizedString substrings)
# - Gender IDs (used in GFF LocalizedString substrings)
# - The CExoLocString / LocalizedString binary layout
# 
# References:
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py
# - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py
# - https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33
# - https://github.com/modawan/reone/blob/master/include/reone/resource/types.h
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/language.py PyKotor — Language (substring language IDs)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/misc.py PyKotor — Gender / Game / EquipmentSlot
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/common/game_object.py PyKotor — ObjectType
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235 PyKotor — GFF field read path (LocalizedString via reader)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/language.h#L46-L73 xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/talktable_tlk.cpp#L57-L92 xoreos — `TalkTable_TLK::load` (TLK header + language id field)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/common/types.h#L28-L33 xoreos-tools — `byte` / `uint` typedefs
# @see https://github.com/modawan/reone/blob/master/include/reone/resource/types.h reone — resource type / engine constants
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree (discoverability)
class BiowareCommon < Kaitai::Struct::Struct

  BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL = {
    3 => :bioware_dds_variant_bytes_per_pixel_dxt1,
    4 => :bioware_dds_variant_bytes_per_pixel_dxt5,
  }
  I__BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL = BIOWARE_DDS_VARIANT_BYTES_PER_PIXEL.invert

  BIOWARE_EQUIPMENT_SLOT_FLAG = {
    0 => :bioware_equipment_slot_flag_invalid,
    1 => :bioware_equipment_slot_flag_head,
    2 => :bioware_equipment_slot_flag_armor,
    8 => :bioware_equipment_slot_flag_gauntlet,
    16 => :bioware_equipment_slot_flag_right_hand,
    32 => :bioware_equipment_slot_flag_left_hand,
    128 => :bioware_equipment_slot_flag_right_arm,
    256 => :bioware_equipment_slot_flag_left_arm,
    512 => :bioware_equipment_slot_flag_implant,
    1024 => :bioware_equipment_slot_flag_belt,
    16384 => :bioware_equipment_slot_flag_claw1,
    32768 => :bioware_equipment_slot_flag_claw2,
    65536 => :bioware_equipment_slot_flag_claw3,
    131072 => :bioware_equipment_slot_flag_hide,
    262144 => :bioware_equipment_slot_flag_right_hand_2,
    524288 => :bioware_equipment_slot_flag_left_hand_2,
  }
  I__BIOWARE_EQUIPMENT_SLOT_FLAG = BIOWARE_EQUIPMENT_SLOT_FLAG.invert

  BIOWARE_GAME_ID = {
    1 => :bioware_game_id_k1,
    2 => :bioware_game_id_k2,
    3 => :bioware_game_id_k1_xbox,
    4 => :bioware_game_id_k2_xbox,
    5 => :bioware_game_id_k1_ios,
    6 => :bioware_game_id_k2_ios,
    7 => :bioware_game_id_k1_android,
    8 => :bioware_game_id_k2_android,
  }
  I__BIOWARE_GAME_ID = BIOWARE_GAME_ID.invert

  BIOWARE_GENDER_ID = {
    0 => :bioware_gender_id_male,
    1 => :bioware_gender_id_female,
  }
  I__BIOWARE_GENDER_ID = BIOWARE_GENDER_ID.invert

  BIOWARE_LANGUAGE_ID = {
    0 => :bioware_language_id_english,
    1 => :bioware_language_id_french,
    2 => :bioware_language_id_german,
    3 => :bioware_language_id_italian,
    4 => :bioware_language_id_spanish,
    5 => :bioware_language_id_polish,
    6 => :bioware_language_id_afrikaans,
    7 => :bioware_language_id_basque,
    9 => :bioware_language_id_breton,
    10 => :bioware_language_id_catalan,
    11 => :bioware_language_id_chamorro,
    12 => :bioware_language_id_chichewa,
    13 => :bioware_language_id_corsican,
    14 => :bioware_language_id_danish,
    15 => :bioware_language_id_dutch,
    16 => :bioware_language_id_faroese,
    18 => :bioware_language_id_filipino,
    19 => :bioware_language_id_finnish,
    20 => :bioware_language_id_flemish,
    21 => :bioware_language_id_frisian,
    22 => :bioware_language_id_galician,
    23 => :bioware_language_id_ganda,
    24 => :bioware_language_id_haitian_creole,
    25 => :bioware_language_id_hausa_latin,
    26 => :bioware_language_id_hawaiian,
    27 => :bioware_language_id_icelandic,
    28 => :bioware_language_id_ido,
    29 => :bioware_language_id_indonesian,
    30 => :bioware_language_id_igbo,
    31 => :bioware_language_id_irish,
    32 => :bioware_language_id_interlingua,
    33 => :bioware_language_id_javanese_latin,
    34 => :bioware_language_id_latin,
    35 => :bioware_language_id_luxembourgish,
    36 => :bioware_language_id_maltese,
    37 => :bioware_language_id_norwegian,
    38 => :bioware_language_id_occitan,
    39 => :bioware_language_id_portuguese,
    40 => :bioware_language_id_scots,
    41 => :bioware_language_id_scottish_gaelic,
    42 => :bioware_language_id_shona,
    43 => :bioware_language_id_soto,
    44 => :bioware_language_id_sundanese_latin,
    45 => :bioware_language_id_swahili,
    46 => :bioware_language_id_swedish,
    47 => :bioware_language_id_tagalog,
    48 => :bioware_language_id_tahitian,
    49 => :bioware_language_id_tongan,
    50 => :bioware_language_id_uzbek_latin,
    51 => :bioware_language_id_walloon,
    52 => :bioware_language_id_xhosa,
    53 => :bioware_language_id_yoruba,
    54 => :bioware_language_id_welsh,
    55 => :bioware_language_id_zulu,
    58 => :bioware_language_id_bulgarian,
    59 => :bioware_language_id_belarisian,
    60 => :bioware_language_id_macedonian,
    61 => :bioware_language_id_russian,
    62 => :bioware_language_id_serbian_cyrillic,
    63 => :bioware_language_id_tajik,
    64 => :bioware_language_id_tatar_cyrillic,
    66 => :bioware_language_id_ukrainian,
    67 => :bioware_language_id_uzbek,
    68 => :bioware_language_id_albanian,
    69 => :bioware_language_id_bosnian_latin,
    70 => :bioware_language_id_czech,
    71 => :bioware_language_id_slovak,
    72 => :bioware_language_id_slovene,
    73 => :bioware_language_id_croatian,
    75 => :bioware_language_id_hungarian,
    76 => :bioware_language_id_romanian,
    77 => :bioware_language_id_greek,
    78 => :bioware_language_id_esperanto,
    79 => :bioware_language_id_azerbaijani_latin,
    81 => :bioware_language_id_turkish,
    82 => :bioware_language_id_turkmen_latin,
    83 => :bioware_language_id_hebrew,
    84 => :bioware_language_id_arabic,
    85 => :bioware_language_id_estonian,
    86 => :bioware_language_id_latvian,
    87 => :bioware_language_id_lithuanian,
    88 => :bioware_language_id_vietnamese,
    89 => :bioware_language_id_thai,
    90 => :bioware_language_id_aymara,
    91 => :bioware_language_id_kinyarwanda,
    92 => :bioware_language_id_kurdish_latin,
    93 => :bioware_language_id_malagasy,
    94 => :bioware_language_id_malay_latin,
    95 => :bioware_language_id_maori,
    96 => :bioware_language_id_moldovan_latin,
    97 => :bioware_language_id_samoan,
    98 => :bioware_language_id_somali,
    128 => :bioware_language_id_korean,
    129 => :bioware_language_id_chinese_traditional,
    130 => :bioware_language_id_chinese_simplified,
    131 => :bioware_language_id_japanese,
    2147483646 => :bioware_language_id_unknown,
  }
  I__BIOWARE_LANGUAGE_ID = BIOWARE_LANGUAGE_ID.invert

  BIOWARE_LIP_VISEME_ID = {
    0 => :bioware_lip_viseme_id_neutral,
    1 => :bioware_lip_viseme_id_ee,
    2 => :bioware_lip_viseme_id_eh,
    3 => :bioware_lip_viseme_id_ah,
    4 => :bioware_lip_viseme_id_oh,
    5 => :bioware_lip_viseme_id_ooh,
    6 => :bioware_lip_viseme_id_y,
    7 => :bioware_lip_viseme_id_sts,
    8 => :bioware_lip_viseme_id_fv,
    9 => :bioware_lip_viseme_id_ng,
    10 => :bioware_lip_viseme_id_th,
    11 => :bioware_lip_viseme_id_mpb,
    12 => :bioware_lip_viseme_id_td,
    13 => :bioware_lip_viseme_id_sh,
    14 => :bioware_lip_viseme_id_l,
    15 => :bioware_lip_viseme_id_kg,
  }
  I__BIOWARE_LIP_VISEME_ID = BIOWARE_LIP_VISEME_ID.invert

  BIOWARE_LTR_ALPHABET_LENGTH = {
    26 => :bioware_ltr_alphabet_length_neverwinter_nights,
    28 => :bioware_ltr_alphabet_length_kotor,
  }
  I__BIOWARE_LTR_ALPHABET_LENGTH = BIOWARE_LTR_ALPHABET_LENGTH.invert

  BIOWARE_OBJECT_TYPE_ID = {
    0 => :bioware_object_type_id_invalid,
    1 => :bioware_object_type_id_creature,
    2 => :bioware_object_type_id_door,
    3 => :bioware_object_type_id_item,
    4 => :bioware_object_type_id_trigger,
    5 => :bioware_object_type_id_placeable,
    6 => :bioware_object_type_id_waypoint,
    7 => :bioware_object_type_id_encounter,
    8 => :bioware_object_type_id_store,
    9 => :bioware_object_type_id_area,
    10 => :bioware_object_type_id_sound,
    11 => :bioware_object_type_id_camera,
  }
  I__BIOWARE_OBJECT_TYPE_ID = BIOWARE_OBJECT_TYPE_ID.invert

  BIOWARE_PCC_COMPRESSION_CODEC = {
    0 => :bioware_pcc_compression_codec_none,
    1 => :bioware_pcc_compression_codec_zlib,
    2 => :bioware_pcc_compression_codec_lzo,
  }
  I__BIOWARE_PCC_COMPRESSION_CODEC = BIOWARE_PCC_COMPRESSION_CODEC.invert

  BIOWARE_PCC_PACKAGE_KIND = {
    0 => :bioware_pcc_package_kind_normal_package,
    1 => :bioware_pcc_package_kind_patch_package,
  }
  I__BIOWARE_PCC_PACKAGE_KIND = BIOWARE_PCC_PACKAGE_KIND.invert

  BIOWARE_TPC_PIXEL_FORMAT_ID = {
    1 => :bioware_tpc_pixel_format_id_greyscale,
    2 => :bioware_tpc_pixel_format_id_rgb_or_dxt1,
    4 => :bioware_tpc_pixel_format_id_rgba_or_dxt5,
    12 => :bioware_tpc_pixel_format_id_bgra_xbox_swizzle,
  }
  I__BIOWARE_TPC_PIXEL_FORMAT_ID = BIOWARE_TPC_PIXEL_FORMAT_ID.invert

  RIFF_WAVE_FORMAT_TAG = {
    1 => :riff_wave_format_tag_pcm,
    2 => :riff_wave_format_tag_adpcm_ms,
    3 => :riff_wave_format_tag_ieee_float,
    6 => :riff_wave_format_tag_alaw,
    7 => :riff_wave_format_tag_mulaw,
    17 => :riff_wave_format_tag_dvi_ima_adpcm,
    85 => :riff_wave_format_tag_mpeg_layer3,
    65534 => :riff_wave_format_tag_wave_format_extensible,
  }
  I__RIFF_WAVE_FORMAT_TAG = RIFF_WAVE_FORMAT_TAG.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end

  ##
  # Variable-length binary data with 4-byte length prefix.
  # Used for Void/Binary fields in GFF files.
  class BiowareBinaryData < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @len_value = @_io.read_u4le
      @value = @_io.read_bytes(len_value)
      self
    end

    ##
    # Length of binary data in bytes
    attr_reader :len_value

    ##
    # Binary data
    attr_reader :value
  end

  ##
  # BioWare CExoString - variable-length string with 4-byte length prefix.
  # Used for string fields in GFF files.
  class BiowareCexoString < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @len_string = @_io.read_u4le
      @value = (@_io.read_bytes(len_string)).force_encoding("UTF-8")
      self
    end

    ##
    # Length of string in bytes
    attr_reader :len_string

    ##
    # String data (UTF-8)
    attr_reader :value
  end

  ##
  # BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
  # section for field type "LocalizedString".
  class BiowareLocstring < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @total_size = @_io.read_u4le
      @string_ref = @_io.read_u4le
      @num_substrings = @_io.read_u4le
      @substrings = []
      (num_substrings).times { |i|
        @substrings << Substring.new(@_io, self, @_root)
      }
      self
    end

    ##
    # True if this locstring references dialog.tlk
    def has_strref
      return @has_strref unless @has_strref.nil?
      @has_strref = string_ref != 4294967295
      @has_strref
    end

    ##
    # Total size of the structure in bytes (excluding this field).
    attr_reader :total_size

    ##
    # StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).
    attr_reader :string_ref

    ##
    # Number of substring entries that follow.
    attr_reader :num_substrings

    ##
    # Language/gender-specific substring entries.
    attr_reader :substrings
  end

  ##
  # BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
  # Used throughout GFF files to reference game resources by name.
  class BiowareResref < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @len_resref = @_io.read_u1
      raise Kaitai::Struct::ValidationGreaterThanError.new(16, @len_resref, @_io, "/types/bioware_resref/seq/0") if not @len_resref <= 16
      @value = (@_io.read_bytes(len_resref)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Length of ResRef string (0-16 characters)
    attr_reader :len_resref

    ##
    # ResRef string data (ASCII, lowercase recommended)
    attr_reader :value
  end

  ##
  # 3D vector (X, Y, Z coordinates).
  # Used for positions, directions, etc. in game files.
  class BiowareVector3 < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @x = @_io.read_f4le
      @y = @_io.read_f4le
      @z = @_io.read_f4le
      self
    end

    ##
    # X coordinate
    attr_reader :x

    ##
    # Y coordinate
    attr_reader :y

    ##
    # Z coordinate
    attr_reader :z
  end

  ##
  # 4D vector / Quaternion (X, Y, Z, W components).
  # Used for orientations/rotations in game files.
  class BiowareVector4 < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @x = @_io.read_f4le
      @y = @_io.read_f4le
      @z = @_io.read_f4le
      @w = @_io.read_f4le
      self
    end

    ##
    # X component
    attr_reader :x

    ##
    # Y component
    attr_reader :y

    ##
    # Z component
    attr_reader :z

    ##
    # W component
    attr_reader :w
  end
  class Substring < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @substring_id = @_io.read_u4le
      @len_text = @_io.read_u4le
      @text = (@_io.read_bytes(len_text)).force_encoding("UTF-8")
      self
    end

    ##
    # Gender as enum value
    def gender
      return @gender unless @gender.nil?
      @gender = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_GENDER_ID, gender_raw)
      @gender
    end

    ##
    # Raw gender ID (0..255).
    def gender_raw
      return @gender_raw unless @gender_raw.nil?
      @gender_raw = substring_id & 255
      @gender_raw
    end

    ##
    # Language as enum value
    def language
      return @language unless @language.nil?
      @language = Kaitai::Struct::Stream::resolve_enum(BiowareCommon::BIOWARE_LANGUAGE_ID, language_raw)
      @language
    end

    ##
    # Raw language ID (0..255).
    def language_raw
      return @language_raw unless @language_raw.nil?
      @language_raw = substring_id >> 8 & 255
      @language_raw
    end

    ##
    # Packed language+gender identifier:
    # - bits 0..7: gender
    # - bits 8..15: language
    attr_reader :substring_id

    ##
    # Length of text in bytes.
    attr_reader :len_text

    ##
    # Substring text.
    attr_reader :text
  end
end

meta:
  id: bioware_common
  title: BioWare Common Types (enums + shared structs)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor_ref: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/common
    xoreos_tools: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/common/types.h#L28-L33
    xoreos_language_enum: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/language.h#L46-L73
    xoreos_talktable_tlk_language_field: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L57-L92
    reone_resource_types_h: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/include/reone/resource/types.h#L30-L99
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  Shared enums and "common objects" used across the BioWare ecosystem that also appear
  in BioWare/Odyssey binary formats (notably TLK and GFF LocalizedStrings).

  This file is intended to be imported by other `.ksy` files to avoid repeating:
  - Language IDs (used in TLK headers and GFF LocalizedString substrings)
  - Gender IDs (used in GFF LocalizedString substrings)
  - The CExoLocString / LocalizedString binary layout

  Canonical upstream links: `meta.doc-ref` and `meta.xref` (line-anchored where applicable).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/common/language.py#L13-L428 PyKotor — `Language` + `Gender` (substring language / gender ids)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/common/misc.py#L255-L265 PyKotor — `Game` (engine id)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/common/misc.py#L611-L625 PyKotor — `EquipmentSlot`"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/common/game_object.py#L28-L45 PyKotor — `ObjectType`"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L220-L235 PyKotor — GFF field read path (LocalizedString via reader)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/language.h#L46-L73 xoreos — `Language` / `LanguageGender` (Aurora runtime; compare TLK / substring packing)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/talktable_tlk.cpp#L57-L92 xoreos — `TalkTable_TLK::load` (TLK header + language id field)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/common/types.h#L28-L33 xoreos-tools — `byte` / `uint` typedefs"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/include/reone/resource/types.h#L30-L99 reone — `ResType` + `GameID` (numeric resource ids)"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree (discoverability)"

types:
  # LocalizedString (CExoLocString) - Used in GFF field data section
  bioware_locstring:
    doc: |
      BioWare "CExoLocString" (LocalizedString) binary layout, as embedded inside the GFF field-data
      section for field type "LocalizedString".
    seq:
      - id: total_size
        type: u4
        doc: Total size of the structure in bytes (excluding this field).

      - id: string_ref
        type: u4
        doc: |
          StrRef into `dialog.tlk` (0xFFFFFFFF means no strref / use substrings).

      - id: num_substrings
        type: u4
        doc: Number of substring entries that follow.

      - id: substrings
        type: substring
        repeat: expr
        repeat-expr: num_substrings
        doc: Language/gender-specific substring entries.
    instances:
      has_strref:
        value: string_ref != 0xFFFFFFFF
        doc: True if this locstring references dialog.tlk

  substring:
    seq:
      - id: substring_id
        type: u4
        doc: |
          Packed language+gender identifier:
          - bits 0..7: gender
          - bits 8..15: language

      - id: len_text
        type: u4
        doc: Length of text in bytes.

      - id: text
        type: str
        encoding: UTF-8
        size: len_text
        doc: Substring text.
    instances:
      gender_raw:
        value: substring_id & 0xff
        doc: Raw gender ID (0..255).
      language_raw:
        value: (substring_id >> 8) & 0xff
        doc: Raw language ID (0..255).
      gender:
        value: gender_raw
        enum: bioware_gender_id
        doc: Gender as enum value
      language:
        value: language_raw
        enum: bioware_language_id
        doc: Language as enum value

  # ResRef - Used in GFF field data section
  bioware_resref:
    doc: |
      BioWare Resource Reference (ResRef) - max 16 character ASCII identifier.
      Used throughout GFF files to reference game resources by name.
    seq:
      - id: len_resref
        type: u1
        doc: Length of ResRef string (0-16 characters)
        valid:
          max: 16
      - id: value
        type: str
        encoding: ASCII
        size: len_resref
        doc: ResRef string data (ASCII, lowercase recommended)

  # CExoString - Used in GFF field data section  
  bioware_cexo_string:
    doc: |
      BioWare CExoString - variable-length string with 4 (0x4)-byte length prefix.
      Used for string fields in GFF files.
    seq:
      - id: len_string
        type: u4
        doc: Length of string in bytes
      - id: value
        type: str
        encoding: UTF-8
        size: len_string
        doc: String data (UTF-8)

  # Vector3 - Used in GFF field data section
  bioware_vector3:
    doc: |
      3D vector (X, Y, Z coordinates).
      Used for positions, directions, etc. in game files.
    seq:
      - id: x
        type: f4
        doc: X coordinate
      - id: y
        type: f4
        doc: Y coordinate
      - id: z
        type: f4
        doc: Z coordinate

  # Vector4 - Used in GFF field data section
  bioware_vector4:
    doc: |
      4D vector / Quaternion (X, Y, Z, W components).
      Used for orientations/rotations in game files.
    seq:
      - id: x
        type: f4
        doc: X component
      - id: y
        type: f4
        doc: Y component
      - id: z
        type: f4
        doc: Z component
      - id: w
        type: f4
        doc: W component

  # Binary data - Used in GFF field data section
  bioware_binary_data:
    doc: |
      Variable-length binary data with 4 (0x4)-byte length prefix.
      Used for Void/Binary fields in GFF files.
    seq:
      - id: len_value
        type: u4
        doc: Length of binary data in bytes
      - id: value
        size: len_value
        doc: Binary data

enums:
  # Extracted from `pykotor.common.language.Language` (IntEnum)
  bioware_language_id:
    0: english
    1: french
    2: german
    3: italian
    4: spanish
    5: polish
    6: afrikaans
    7: basque
    9: breton
    10: catalan
    11: chamorro
    12: chichewa
    13: corsican
    14: danish
    15: dutch
    16: faroese
    18: filipino
    19: finnish
    20: flemish
    21: frisian
    22: galician
    23: ganda
    24: haitian_creole
    25: hausa_latin
    26: hawaiian
    27: icelandic
    28: ido
    29: indonesian
    30: igbo
    31: irish
    32: interlingua
    33: javanese_latin
    34: latin
    35: luxembourgish
    36: maltese
    37: norwegian
    38: occitan
    39: portuguese
    40: scots
    41: scottish_gaelic
    42: shona
    43: soto
    44: sundanese_latin
    45: swahili
    46: swedish
    47: tagalog
    48: tahitian
    49: tongan
    50: uzbek_latin
    51: walloon
    52: xhosa
    53: yoruba
    54: welsh
    55: zulu
    58: bulgarian
    59: belarisian
    60: macedonian
    61: russian
    62: serbian_cyrillic
    63: tajik
    64: tatar_cyrillic
    66: ukrainian
    67: uzbek
    68: albanian
    69: bosnian_latin
    70: czech
    71: slovak
    72: slovene
    73: croatian
    75: hungarian
    76: romanian
    77: greek
    78: esperanto
    79: azerbaijani_latin
    81: turkish
    82: turkmen_latin
    83: hebrew
    84: arabic
    85: estonian
    86: latvian
    87: lithuanian
    88: vietnamese
    89: thai
    90: aymara
    91: kinyarwanda
    92: kurdish_latin
    93: malagasy
    94: malay_latin
    95: maori
    96: moldovan_latin
    97: samoan
    98: somali
    128: korean
    129: chinese_traditional
    130: chinese_simplified
    131: japanese
    2147483646: unknown

  # Extracted from `pykotor.common.language.Gender` (IntEnum)
  bioware_gender_id:
    0: male
    1: female

  # Extracted from `pykotor.common.misc.Game` (IntEnum)
  bioware_game_id:
    1: k1
    2: k2
    3: k1_xbox
    4: k2_xbox
    5: k1_ios
    6: k2_ios
    7: k1_android
    8: k2_android

  # Extracted from `pykotor.common.game_object.ObjectType` (IntEnum)
  bioware_object_type_id:
    0: invalid
    1: creature
    2: door
    3: item
    4: trigger
    5: placeable
    6: waypoint
    7: encounter
    8: store
    9: area
    10: sound
    11: camera

  # Extracted from `pykotor.common.misc.EquipmentSlot` (Enum used as bit-flags)
  # NOTE: This is a flag set; consumers typically treat these as bitmasks.
  bioware_equipment_slot_flag:
    0: invalid
    1: head
    2: armor
    8: gauntlet
    16: right_hand
    32: left_hand
    128: right_arm
    256: left_arm
    512: implant
    1024: belt
    16384: claw1
    32768: claw2
    65536: claw3
    131072: hide
    262144: right_hand_2
    524288: left_hand_2

  # PyKotor `LIPShape` / Preston Blair viseme indices (0–15) — `formats/LIP/LIP.ksy`
  bioware_lip_viseme_id:
    0: neutral
    1: ee
    2: eh
    3: ah
    4: oh
    5: ooh
    6: y
    7: sts
    8: fv
    9: ng
    10: th
    11: mpb
    12: td
    13: sh
    14: l
    15: kg

  # LTR header `letter_count`: NWN 26-letter vs KotOR 28 (`a-z` + `'` + `-`) — `formats/LTR/LTR.ksy`
  bioware_ltr_alphabet_length:
    26: neverwinter_nights
    28: kotor

  # LegendaryExplorer PCC wiki — `formats/PCC/PCC.ksy` (`package_type`, `compression_type`)
  bioware_pcc_package_kind:
    0: normal_package
    1: patch_package

  bioware_pcc_compression_codec:
    0: none
    1: zlib
    2: lzo

  # BioWare headerless DDS prefix (`bioware_dds_header.bytes_per_pixel`) — `formats/TPC/DDS.ksy`, PyKotor `io_dds.py`
  bioware_dds_variant_bytes_per_pixel:
    3: dxt1
    4: dxt5

  # TPC header byte — PyKotor wiki / xoreos `tpc.cpp` — `formats/TPC/TPC.ksy`
  bioware_tpc_pixel_format_id:
    1: greyscale
    2: rgb_or_dxt1
    4: rgba_or_dxt5
    12: bgra_xbox_swizzle

  # RIFF `WAVEFORMATEX.wFormatTag` — `formats/WAV/WAV.ksy`, Microsoft + KotOR usage
  riff_wave_format_tag:
    1: pcm
    2: adpcm_ms
    3: ieee_float
    6: alaw
    7: mulaw
    17: dvi_ima_adpcm
    85: mpeg_layer3
    65534: wave_format_extensible

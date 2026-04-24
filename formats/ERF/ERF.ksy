meta:
  id: erf
  title: BioWare ERF (Encapsulated Resource File) Format
  license: MIT
  endian: le
  file-extension:
    - erf
    - hak
    - mod
    - sav
  imports:
    - ../Common/bioware_type_ids
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    k1_erf_header_alignment: |
      **CERFHeader** in the K1 build is 160 B with the same field order as `erf_header` here
      (file type, version, language count, localized string size, entry count, three offsets, build year/day, description strref, 116 (0x74)-byte reserved tail).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/erf/
    github_openkotor_pykotor_io_erf: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py`:
      **`_load_erf_from_kaitai`** **22–83**; legacy **`V1.0`** **86–119**; **`ERFBinaryReader.load`** **206–215**; **`ERFBinaryWriter.write`** **247+** (160 (0xa0)-byte header block **247–294**, then localized strings, key table, resource table, and payload writes — long method); header size constants **234–236**.
    github_openkotor_pykotor_erf_data: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py`:
      **`ERFType`** (`ERF` / `MOD` / `SAV` / `HAK`) **91–107**; header field overview **14–22**; **`class ERF`** **123+**.
    github_modawan_reone_erfreader: |
      https://github.com/modawan/reone — `src/libs/resource/format/erfreader.cpp`: **`ErfReader::load`** **26–39**; **`checkSignature`** (`ERF V1.0` / `MOD V1.0`) **41–51**; **`readKeyEntry`** **62–72**; **`readResourceEntry`** **83–92**.
    xoreos_erffile: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/erffile.cpp#L50-L335
    github_xoreos_types_kfiletype_erf: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L207
    github_xoreos_erffile: |
      https://github.com/xoreos/xoreos — `src/aurora/erffile.cpp`: type tags **`kERFID` / `kMODID` / `kHAKID` / `kSAVID`** + **`kVersion10`** **50–59**; **`ERFFile::load`** **281–306**; **`readV10Header`** **318–333**; **`readV11Header`** from **335**.
    github_xoreos_types_erf_family: |
      https://github.com/xoreos/xoreos — `src/aurora/types.h`: **`kFileTypeERF`** **207**; **`kFileTypeMOD`** (and related Aurora ids nearby — see full enum).
    github_xoreos_tools_unerf: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unerf.cpp#L69-L106
    github_xoreos_tools_erf_pack: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/erf.cpp#L49-L96
    github_xoreos_docs_erf_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/ERF_Format.pdf
    github_xoreos_docs_torlack_mod: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/mod.html
    github_kobaltblu_kotor_js_erf: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/ERFObject.ts#L70-L115
    kotor_net_erf_tree: https://github.com/NickHugi/Kotor.NET/tree/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorERF
    pykotor_wiki: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf
    bioware_aurora: https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf
doc: |
  ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
  texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
  ERF files store both resource names (ResRefs) and data in the same file. They also support
  localized strings for descriptions in multiple languages.

  Format Variants:
  - ERF: Generic encapsulated resource file (texture packs, etc.)
  - HAK: Hak pak file (contains override resources). Used for mod content distribution
  - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
  - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`

  All variants use the same binary format structure, differing only in the file type signature.

  Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.

  Binary Format Structure:
  - Header (160 (0xa0) bytes): File type, version, entry counts, offsets, build date, description
  - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
    include localized module names for the load screen. Each entry contains language_id (u4),
    string_size (u4), and string_data (UTF-8 encoded text)
  - Key List (24 (0x18) bytes per entry): ResRef to resource index mapping. Each entry contains:
    - resref (16 (0x10) bytes, ASCII, null-padded): Resource filename
    - resource_id (u4): Index into resource_list
    - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
    - unused (u2): Padding/unused field (typically 0)
  - Resource List (8 (0x8) bytes per entry): Resource offset and size. Each entry contains:
    - offset_to_data (u4): Byte offset to resource data from beginning of file
    - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
  - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
    in resource_list

  File Access Pattern:
  1. Read header to get entry_count and offsets
  2. Read key_list to map ResRefs to resource_ids
  3. Use resource_id to index into resource_list
  4. Read resource data from offset_to_data with byte length len_data

  Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf PyKotor wiki — ERF"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf PyKotor wiki — Aurora ERF notes"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316 PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130 PyKotor — `ERFType` + `ERF` model (opening)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/erffile.cpp#L50-L335 xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unerf.cpp#L69-L106 xoreos-tools — `unerf` CLI (`main`)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/erf.cpp#L49-L96 xoreos-tools — `erf` packer CLI (`main`)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/mod.html xoreos-docs — Torlack mod.html"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/erfreader.cpp#L26-L92 reone — `ErfReader`"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/ERFObject.ts#L70-L115 KotOR.js — `ERFObject`"
  - "https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs#L25-L66 NickHugi/Kotor.NET — `ERFBinaryStructure.FileRoot` read/write"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/ERF_Format.pdf xoreos-docs — ERF_Format.pdf"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/type.py#L123-L322 PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows)"

seq:
  - id: header
    type: erf_header
    doc: ERF file header (160 (0xa0) bytes)

instances:
  localized_string_list:
    type: localized_string_list
    if: header.language_count > 0
    pos: header.offset_to_localized_string_list
    doc: Optional localized string entries for multi-language descriptions

  key_list:
    type: key_list
    pos: header.offset_to_key_list
    doc: Array of key entries mapping ResRefs to resource indices

  resource_list:
    type: resource_list
    pos: header.offset_to_resource_list
    doc: Array of resource entries containing offset and size information

types:
  erf_header:
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be one of:
          - "ERF " (0x45 0x52 0x46 0x20) - Generic ERF archive
          - "MOD " (0x4D 0x4F 0x44 0x20) - Module file
          - "SAV " (0x53 0x41 0x56 0x20) - Save game file
          - "HAK " (0x48 0x41 0x4B 0x20) - Hak pak file
        valid:
          any-of:
            - "'ERF '"
            - "'MOD '"
            - "'SAV '"
            - "'HAK '"

      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V1.0" for KotOR ERF files.
          Other versions may exist in Neverwinter Nights but are not supported in KotOR.
        valid: "'V1.0'"

      - id: language_count
        type: u4
        doc: |
          Number of localized string entries. Typically 0 for most ERF files.
          MOD files may include localized module names for the load screen.

      - id: localized_string_size
        type: u4
        doc: |
          Total size of localized string data in bytes.
          Includes all language entries (language_id + string_size + string_data for each).

      - id: entry_count
        type: u4
        doc: |
          Number of resources in the archive. This determines:
          - Number of entries in key_list
          - Number of entries in resource_list
          - Number of resource data blocks stored at various offsets

      - id: offset_to_localized_string_list
        type: u4
        doc: |
          Byte offset to the localized string list from the beginning of the file.
          Typically 160 (right after header) if present, or 0 if not present.

      - id: offset_to_key_list
        type: u4
        doc: |
          Byte offset to the key list from the beginning of the file.
          Typically 160 (right after header) if no localized strings, or after localized strings.

      - id: offset_to_resource_list
        type: u4
        doc: |
          Byte offset to the resource list from the beginning of the file.
          Located after the key list.

      - id: build_year
        type: u4
        doc: |
          Build year (years since 1900).
          Example: 103 = year 2003
          Primarily informational, used by development tools to track module versions.

      - id: build_day
        type: u4
        doc: |
          Build day (days since January 1, with January 1 = day 1).
          Example: 247 = September 4th (the 247th day of the year)
          Primarily informational, used by development tools to track module versions.

      - id: description_strref
        type: s4
        doc: |
          Description StrRef (TLK string reference) for the archive description.
          Values vary by file type:
          - MOD files: -1 (0xFFFFFFFF, uses localized strings instead)
          - SAV files: 0 (typically no description)
          - ERF/HAK files: Unpredictable (may contain valid StrRef or -1)

      - id: reserved
        size: 116
        doc: |
          Reserved padding (usually zeros).
          Total header size is 160 (0xa0) bytes:
          file_type (4) + file_version (4) + language_count (4) + localized_string_size (4) +
          entry_count (4) + offset_to_localized_string_list (4) + offset_to_key_list (4) +
          offset_to_resource_list (4) + build_year (4) + build_day (4) + description_strref (4) +
          reserved (116) = 160 (0xa0) bytes

    instances:
      is_save_file:
        value: file_type == "MOD " and description_strref == 0
        doc: |
          Heuristic to detect save game files.
          Save games use MOD signature but typically have description_strref = 0.

  localized_string_list:
    seq:
      - id: entries
        type: localized_string_entry
        repeat: expr
        repeat-expr: _root.header.language_count
        doc: Array of localized string entries, one per language

  localized_string_entry:
    seq:
      - id: language_id
        type: u4
        doc: |
          Language identifier:
          - 0 = English
          - 1 = French
          - 2 = German
          - 3 = Italian
          - 4 = Spanish
          - 5 = Polish
          - Additional languages for Asian releases

      - id: string_size
        type: u4
        doc: Length of string data in bytes

      - id: string_data
        type: str
        size: string_size
        encoding: UTF-8
        doc: UTF-8 encoded text string

  key_list:
    seq:
      - id: entries
        type: key_entry
        repeat: expr
        repeat-expr: _root.header.entry_count
        doc: Array of key entries mapping ResRefs to resource indices

  key_entry:
    seq:
      - id: resref
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Resource filename (ResRef), null-padded to 16 (0x10) bytes.
          Maximum 16 characters. If exactly 16 characters, no null terminator exists.
          Resource names can be mixed case, though most are lowercase in practice.

      - id: resource_id
        type: u4
        doc: |
          Resource ID (index into resource_list).
          Maps this key entry to the corresponding resource entry.

      - id: resource_type
        type: u2
        enum: bioware_type_ids::xoreos_file_type_id
        doc: |
          Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
          Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)

      - id: unused
        type: u2
        doc: Padding/unused field (typically 0)

    # NOTE: Avoid string trimming helpers here — Kaitai 0.11 does not support Python-style
    # `.rstrip()` on parsed strings in all backends. Consumers can trim `\0` externally if needed.

  resource_list:
    seq:
      - id: entries
        type: resource_entry
        repeat: expr
        repeat-expr: _root.header.entry_count
        doc: Array of resource entries containing offset and size information

  resource_entry:
    seq:
      - id: offset_to_data
        type: u4
        doc: |
          Byte offset to resource data from the beginning of the file.
          Points to the actual binary data for this resource.

      - id: len_data
        type: u4
        doc: |
          Size of resource data in bytes.
          Uncompressed size of the resource.

    instances:
      data:
        pos: offset_to_data
        size: len_data
        doc: Raw binary data for this resource

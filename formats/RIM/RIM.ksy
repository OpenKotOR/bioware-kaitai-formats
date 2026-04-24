meta:
  id: rim
  title: BioWare RIM (Resource Information Manager) Format
  license: MIT
  endian: le
  file-extension: rim
  imports:
    - ../Common/bioware_type_ids
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/rim/
    github_openkotor_pykotor_io_rim: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py`:
      **`_load_rim_legacy`** **`RIM `** / **`V1.0`** + implicit 120 (0x78)-byte key offset **39–62**; **`RIMBinaryReader.load`** **123–128**; **`RIMBinaryWriter.write`** **145+** (header + 96 (0x60)-byte pad to **120**, then keyed resource layout — long method).
    github_modawan_reone_rimreader: |
      https://github.com/modawan/reone — `src/libs/resource/format/rimreader.cpp`: **`RimReader::load`** **26–34**; **`readResource`** **46–58**.
    xoreos_rimfile_cpp: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L91
    github_xoreos_rimfile: |
      https://github.com/xoreos/xoreos — `src/aurora/rimfile.cpp`: **`kRIMID`** / **`kVersion1`** **35–36**; **`RIMFile::load`** **49–75**; **`readResList`** **77–91** (`FileType` read at **85**).
    github_xoreos_tools_unrim: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unrim.cpp#L55-L85
    github_xoreos_tools_rim_pack: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/rim.cpp#L43-L84
    github_xoreos_docs_mod_torlack: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/mod.html
    github_kobaltblu_kotor_js_rim: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/RIMObject.ts#L69-L93
    pykotor_wiki_rim: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim
doc: |
  RIM (Resource Information Manager) files are self-contained archives used for module templates.
  RIM files are similar to ERF files but are read-only from the game's perspective. The game
  loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
  RIM files store all resources inline with metadata, making them self-contained archives.
  
  Format Variants:
  - Standard RIM: Basic module template files
  - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
  
  Binary Format (KotOR / PyKotor):
  - Fixed header (24 (0x18) bytes): File type, version, reserved, resource count, offset to key table, offset to resources
  - Padding to key table (96 (0x60) bytes when offsets are implicit): total 120 (0x78) bytes before the key table
  - Key / resource entry table (32 (0x20) bytes per entry): ResRef, `resource_type` (`bioware_type_ids::xoreos_file_type_id`), ID, offset, size
  - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
  
  Authoritative index: `meta.xref` and `doc-ref`. Archived Community-Patches GitHub URLs for .NET RIM samples were removed after link rot; use **NickHugi/Kotor.NET** `Kotor.NET/Formats/KotorRIM/` on current `master`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#rim PyKotor wiki — RIM"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/rim/io_rim.py#L39-L128 PyKotor — `io_rim` (legacy + `RIMBinaryReader.load`)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/rimfile.cpp#L35-L91 xoreos — `RIMFile::load` + `readResList`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/unrim.cpp#L55-L85 xoreos-tools — `unrim` CLI (`main`)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/rim.cpp#L43-L84 xoreos-tools — `rim` packer CLI (`main`)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/mod.html xoreos-docs — Torlack mod.html (MOD/RIM family)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/RIMObject.ts#L69-L93 KotOR.js — `RIMObject`"
  - "https://github.com/NickHugi/Kotor.NET/blob/6dca4a6a1af2fee6e36befb9a6f127c8ba04d3e2/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs#L23-L54 NickHugi/Kotor.NET — `RIMBinaryStructure.FileRoot` read/write"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/rimreader.cpp#L26-L58 reone — `RimReader`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L56-L394 xoreos — `enum FileType` (numeric IDs in RIM/ERF/KEY tables)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/type.py#L123-L322 PyKotor — `ResourceType` (tooling superset)"

seq:
  - id: header
    type: rim_header
    doc: RIM file header (24 (0x18) bytes) plus padding to the key table (PyKotor total 120 (0x78) bytes when implicit)
  
  - id: gap_before_key_table_implicit
    size: 96
    if: header.offset_to_resource_table == 0
    doc: |
      When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
      After the 24 (0x18)-byte header, skip 96 (0x60) bytes of padding (24 + 96 = 120).
  
  - id: gap_before_key_table_explicit
    size: header.offset_to_resource_table - 24
    if: header.offset_to_resource_table != 0
    doc: |
      When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
      Vanilla files often store 120 here, which yields the same 96 (0x60) bytes of padding as the implicit case.
  
  - id: resource_entry_table
    type: resource_entry_table
    if: header.resource_count > 0
    doc: Array of resource entries mapping ResRefs to resource data

types:
  rim_header:
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
          This identifies the file as a RIM archive.
        valid: "'RIM '"
      
      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V1.0" for KotOR RIM files.
          Other versions may exist in Neverwinter Nights but are not supported in KotOR.
        valid: "'V1.0'"
      
      - id: reserved
        type: u4
        doc: |
          Reserved field (typically 0x00000000).
          Unknown purpose, but always set to 0 in practice.
      
      - id: resource_count
        type: u4
        doc: |
          Number of resources in the archive. This determines:
          - Number of entries in resource_entry_table
          - Number of resources in resource_data_section
      
      - id: offset_to_resource_table
        type: u4
        doc: |
          Byte offset to the key / resource entry table from the beginning of the file.
          0 means implicit offset 120 (0x78) (24 (0x18)-byte header + 96 (0x60)-byte padding), matching PyKotor and vanilla KotOR.
          When non-zero, this offset is used directly (commonly 120).
      
      - id: offset_to_resources
        type: u4
        doc: |
          Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
          taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
    
    instances:
      has_resources:
        value: resource_count > 0
        doc: Whether the RIM file contains any resources
  
  resource_entry_table:
    seq:
      - id: entries
        type: resource_entry
        repeat: expr
        repeat-expr: _root.header.resource_count
        doc: Array of resource entries, one per resource in the archive
  
  resource_entry:
    seq:
      - id: resref
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Resource filename (ResRef), null-padded to 16 (0x10) bytes.
          Maximum 16 characters. If exactly 16 characters, no null terminator exists.
          Resource names can be mixed case, though most are lowercase in practice.
          The game engine typically lowercases ResRefs when loading.
      
      - id: resource_type
        type: u4
        enum: bioware_type_ids::xoreos_file_type_id
        doc: |
          Resource type identifier (xoreos `FileType` numeric space; canonical enum in `formats/Common/bioware_type_ids.ksy`).
          Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
      
      - id: resource_id
        type: u4
        doc: |
          Resource ID (index, usually sequential).
          Typically matches the index of this entry in the resource_entry_table.
          Used for internal reference, but not critical for parsing.
      
      - id: offset_to_data
        type: u4
        doc: |
          Byte offset to resource data from the beginning of the file.
          Points to the actual binary data for this resource in resource_data_section.
      
      - id: num_data
        type: u4
        doc: |
          Size of resource data in bytes (repeat count for raw `data` bytes).
          Uncompressed size of the resource.
    
    instances:
      data:
        type: u1
        pos: offset_to_data
        repeat: expr
        repeat-expr: num_data
        doc: Raw binary data for this resource (read at specified offset)


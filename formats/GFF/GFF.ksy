meta:
  id: gff
  title: BioWare GFF (Generic File Format) File
  license: MIT
  endian: le
  file-extension: gff
  imports:
    - ../Common/bioware_common
    - ../Common/bioware_gff_common
  xref:
    # Flat scalar map (ksy schema): line-anchored authorities. Long reading lists live here (+ optional `doc-ref`), not in `meta.doc`.
    wiki_gff: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    wiki_gff_file_header: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header
    wiki_gff_label_array: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
    wiki_gff_struct_array: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
    wiki_gff_field_array: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
    wiki_gff_field_data: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
    wiki_gff_field_indices: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
    wiki_gff_list_indices: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
    wiki_gff_binary_format: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#binary-format
    wiki_gff_data_types: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    wiki_aurora_gff: https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#gff
    wiki_tslpatcher_gfflist: https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFFList-Syntax
    wiki_strref_tlk: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
    wiki_audio_tlk: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#tlk
    wiki_resource_resolution: https://github.com/OpenKotOR/PyKotor/wiki/Concepts#resource-resolution-order
    wiki_resource_formats_index: https://github.com/OpenKotOR/PyKotor/wiki/Resource-Formats-and-Resolution
    wiki_tslpatcher_gff_syntax: https://github.com/OpenKotOR/PyKotor/wiki/TSLPatcher-GFF-Syntax#gfflist-syntax
    wiki_holopatcher_mod_developers: https://github.com/OpenKotOR/PyKotor/wiki/HoloPatcher#mod-developers
    wiki_reverse_engineering_findings: https://github.com/OpenKotOR/PyKotor/wiki/reverse_engineering_findings
    wiki_holocron_module_resources: https://github.com/OpenKotOR/PyKotor/wiki/Holocron-Toolset-Module-Resources
    nwn_docs_repo: https://github.com/kucik/nwn-docs
    xoreos_docs_repo: https://github.com/xoreos/xoreos-docs
    legacy_k_gff_deadly_stream_reviews: https://deadlystream.com/files/file/719-k-gff/?tab=reviews
    pykotor_gff_package: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff
    pykotor_io_gff_reader_load: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114
    pykotor_io_gff_writer_write: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L331-L369
    # Writer recursion: mirrors `_load_struct` / `_load_list` / `_load_field_value_by_id` (reader §4).
    pykotor_io_gff_writer_build_struct_list_field: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L371-L478
    pykotor_gff_auto_read_json: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_auto.py#L341-L346
    pykotor_gff_data_from_json: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L654-L667
    pykotor_gff_data_parse_json_struct: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L709-L721
    pykotor_gff_auto_write_json: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_auto.py#L376-L380
    pykotor_io_gff_xml_reader_load: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L61-L75
    pykotor_io_gff_xml_writer_root: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L179-L188
    pykotor_gff_data_fieldtype_enum: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367
    # Torlack ITP HTML: MultiMap / list terminology (GFF-family); line range = `<ol>` section bullets.
    xoreos_docs_torlack_itp_html: https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163/specs/torlack/itp.html#L44-L49
    xoreos_docs_bioware_specs_tree: https://github.com/th3w1zard1/xoreos-docs/tree/c7f12b09788a331499ce15b1283b630b4feb5163/specs/bioware
    # `@file` banner + pointer to BioWare NWN-era dumps (see `xoreos_gff3file_file_banner`).
    xoreos_gff3file_file_banner: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L21-L27
    xoreos_gff3file_load_lists: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L191-L249
    # Header field order matches `GFF3File::Header::read()` (uint32 LE × 12).
    xoreos_gff3_header_read: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L50-L63
    xoreos_gff3_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L97-L108
    xoreos_gff3_load_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L110-L181
    xoreos_gff3_load_structs: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L183-L189
    xoreos_gff4_header_read: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L48-L72
    xoreos_gff4_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L151-L164
    xoreos_gff4_load_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L166-L187
    xoreos_gff4_load_structs: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L189-L250
    xoreos_gff4_load_strings: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L252-L267
    xoreos_gff4file_h_overview: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.h#L52-L91
    xoreos_aurorafile_read_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/aurorafile.cpp#L53-L75
    xoreos_types_gff4_family: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L282-L320
    xoreos_types_kfiletype_gff: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L102
    xoreos_tools_gff3file_load_pipeline: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/aurora/gff3file.cpp#L86-L238
    xoreos_tools_gffdumper_identify: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffdumper.cpp#L36-L176
    xoreos_tools_gffcreator_create: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffcreator.cpp#L43-L60
    xoreos_dlgfile_load_from_gff: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/dlgfile.cpp#L169-L202
    xoreos_ifofile_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/ifofile.cpp#L101-L227
    xoreos_nfofile_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/nfofile.cpp#L72-L83
    # xoreos TLK path here is **GFF4** (`GFF4File`), not KotOR on-disk GFF3 — lineage / engine-variance reference only.
    xoreos_talktable_gff_gff4_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/talktable_gff.cpp#L78-L99
    reone_gffreader_cpp: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L27-L225
    kotor_js_gffobject_parse: https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/resource/GFFObject.ts#L152-L221
    bioware_gff_common_field_types: |
      Canonical `gff_field_type` wire tags + per-ID documentation: `formats/Common/bioware_gff_common.ksy`.
    legacy_k_gff_deadly_stream_listing: https://deadlystream.com/files/file/719-k-gff/
    legacy_k_gff_deadly_stream_changelog: https://deadlystream.com/files/file/719-k-gff/?changelog=0
    # IPS changelog id for Oct 2015 capture (distinct from default `?changelog=0` = v1.3.0 bullets on site).
    legacy_k_gff_deadly_stream_changelog_1858: https://deadlystream.com/files/file/719-k-gff/?changelog=1858
    legacy_k_gff_deadly_stream_comments: https://deadlystream.com/files/file/719-k-gff/?tab=comments
    legacy_k_gff_lucasforums_archive_thread: https://www.lucasforumsarchive.com/thread/149407
    lucasforumsarchive_kotor_modding_forum: https://www.lucasforumsarchive.com/forum/521
    lucasforumsarchive_t3m4_droid_center_forum: https://www.lucasforumsarchive.com/forum/646
doc: |
  BioWare **GFF** (Generic File Format): hierarchical binary game data (KotOR/TSL and Aurora lineage; GFF4 for
  DA / Eclipse-class payloads in this `.ksy`). Human-readable tables and tutorials: PyKotor wiki (**Further
  reading**). Wire `gff_field_type` enum: `formats/Common/bioware_gff_common.ksy`.

  **Aurora prefix (8 bytes):** `u4be` FourCC + `u4be` version (`AuroraFile::readHeader` — `meta.xref`
  `xoreos_aurorafile_read_header`).
  **GFF3:** Twelve LE `u32` counts/offsets as `gff_header_tail` under `gff3_after_aurora`, then lazy arena
  `instances`.
  **GFF4:** When version is `V4.0` / `V4.1`, the next field is `platform_id` (`u4be`), not GFF3 `struct_offset`
  (`gff4_after_aurora`; partial GFF4 graph — `tail` blob still opaque).

  **GFF3 wire summary:**
  - Root `file` → `gff_union_file`; arenas addressed via `gff3.header` offsets.
  - 12-byte struct rows (`struct_entry`), 12-byte field rows (`field_entry`); root struct index **0**; single-field
    vs multi-field vs lists per wiki *Struct array* / *Field indices* / *List indices*.

  **Ghidra / VMA:** engine record names and addresses live on the `seq` / `types` nodes they justify, not in this blurb.

  **Pinned URLs and tool history:** `meta.xref` (alphabetical keys). Coverage matrix: `docs/XOREOS_FORMAT_COVERAGE.md`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF binary format"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L50-L63 xoreos — GFF3File::Header::read"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L48-L72 xoreos — GFF4File::Header::read"
  - "https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 PyKotor — GFFBinaryReader.load"
  - "https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L27-L225 reone — GffReader"
  - "https://github.com/th3w1zard1/KotOR.js/blob/a9fc837cede88fc50bea7b675cda4f1f8e891264/src/resource/GFFObject.ts#L152-L221 KotOR.js — GFFObject.parse"

seq:
  - id: file
    type: gff_union_file
    doc: |
      Aurora container: shared **8-byte** prefix (`u4be` magic + `u4be` version tag), then either **GFF3**
      (`gff3_after_aurora`: 48-byte `gff_header_tail` + arena `instances`) or **GFF4** (`gff4_after_aurora`).
      Discrimination matches xoreos `loadHeader` order (`gff3file.cpp` vs `gff4file.cpp`); Kaitai uses
      mutually exclusive `if` on `seq` fields (V4.* vs non-V4) so `gff3` / `gff4` have stable types for
      downstream `pos:` / `_root.file.gff3.header` paths.

types:
  gff_union_file:
    doc: |
      Shared Aurora wire prefix + GFF3/GFF4 branch. First 8 bytes align with `AuroraFile::readHeader`
      (`aurorafile.cpp`) and with the opening of `GFF3File::Header::read` / `GFF4File::Header::read`.
    seq:
      - id: aurora_magic
        type: u4be
        doc: |
          File type signature as **big-endian u32** (e.g. `0x47464620` for ASCII `GFF `). Same four bytes as
          legacy `gff_header.file_type` / PyKotor `read(4)` at offset 0.

      - id: aurora_version
        type: u4be
        doc: |
          Format version tag as **big-endian u32** (e.g. KotOR `V3.2` → `0x56332e32`; GFF4 `V4.0`/`V4.1` →
          `0x56342e30` / `0x56342e31`). Same four bytes as legacy `gff_header.file_version`.

      - id: gff3
        type: gff3_after_aurora
        if: aurora_version != 0x56342e30 and aurora_version != 0x56342e31
        doc: |
          **GFF3** (KotOR and other Aurora titles using V3.x tags). Twelve LE `u32` arena fields follow the prefix.

      - id: gff4
        type: gff4_after_aurora(aurora_version)
        if: aurora_version == 0x56342e30 or aurora_version == 0x56342e31
        doc: |
          **GFF4** (DA / DA2 / Sonic Chronicles / …). `platform_id` and following header fields per `gff4file.cpp`.

  gff3_after_aurora:
    doc: |
      GFF3 payload after the shared 8-byte Aurora prefix: `gff_header_tail` (48 B) then lazy arena instances.
    seq:
      - id: header
        type: gff_header_tail
        doc: |
          Bytes 8–55: same twelve `u32` LE fields as wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header)
          rows from Struct Array Offset through List Indices Count. Ghidra: `GFFHeaderInfo` @ +0x8 … +0x34.

    instances:
      label_array:
        type: label_array
        if: header.label_count > 0
        pos: header.label_offset
        doc: |
          Label table: `header.label_count` entries ×16 bytes at `header.label_offset`.
          Ghidra: slots indexed by `GFFFieldData.label_index` (+0x4); header fields `label_offset` / `label_count` @ +0x18 / +0x1C.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array
          PyKotor load: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L108-L111 — reone `readLabel`: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L151-L154

      struct_array:
        type: struct_array
        if: header.struct_count > 0
        pos: header.struct_offset
        doc: |
          Struct table: `header.struct_count` × 12 B at `header.struct_offset`. Ghidra: `GFFStructData` rows.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
          PyKotor `_load_struct`: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L116-L143 — reone `readStruct`: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L46-L65

      field_array:
        type: field_array
        if: header.field_count > 0
        pos: header.field_offset
        doc: |
          Field dictionary: `header.field_count` × 12 B at `header.field_offset`. Ghidra: `GFFFieldData`.
          `CResGFF::GetField` @ `0x00410990` uses 12-byte stride on this table.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
          PyKotor `_load_fields_batch` / `_load_field`: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L145-L180 — https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L182-L195 — reone `readField`: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L67-L149

      field_data:
        type: field_data
        if: header.field_data_count > 0
        pos: header.field_data_offset
        doc: |
          Complex-type payload heap. Ghidra: `field_data_offset` @ +0x20, size `field_data_count` @ +0x24.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data
          PyKotor seeks `field_data_offset + offset` for “complex” IDs: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L211-L213 — reone helpers from `_fieldDataOffset`: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L160-L216

      field_indices_array:
        type: field_indices_array
        if: header.field_indices_count > 0
        pos: header.field_indices_offset
        doc: |
          Flat `u4` stream (`field_indices_count` elements). Multi-field structs slice via `GFFStructData.data_or_data_offset`.
          Ghidra: `field_indices_offset` @ +0x28, `field_indices_count` @ +0x2C.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-indices-multiple-element-map--multimap
          PyKotor batch read: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L135-L139 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L156-L158 — Torlack MultiMap context: https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163/specs/torlack/itp.html#L44-L49

      list_indices_array:
        type: list_indices_array
        if: header.list_indices_count > 0
        pos: header.list_indices_offset
        doc: |
          Packed list nodes (`u4` count + `u4` struct indices). List fields store byte offsets from this arena base.
          Ghidra: `list_indices_offset` @ +0x30; `list_indices_count` @ +0x34 = span length in bytes (this `.ksy` `raw_data` size).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
          PyKotor `_load_list`: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 — reone `readList`: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L218-L223

      root_struct_resolved:
        type: resolved_struct(0)
        doc: |
          Kaitai-only convenience: decoded view of struct index 0 (`struct_array.entries[0]`).
          Not a distinct on-disk record; uses same `GFFStructData` + tables as above.
          Implements the access pattern described in meta.doc (single-field vs multi-field structs).

  gff4_after_aurora:
    doc: |
      GFF4 payload after the shared 8-byte Aurora prefix (through struct-template strip + remainder `tail`).
      PC-first LE numeric tail; `string_*` fields only when `aurora_version` (param) is V4.1.
    params:
      - id: aurora_version
        type: u4
        doc: |
          Aurora version tag from the enclosing stream’s first 8 bytes (read on disk as `u4be`;
          passed as `u4` for Kaitai param typing). Same value as `gff_union_file.aurora_version` / `gff4_file.aurora_version`.

    seq:
      - id: platform_id
        type: u4be
        doc: |
          Platform fourCC (`Header::read` first field). PC = `PC  ` (little-endian payload);
          `PS3 ` / `X360` use big-endian numeric tail (not modeled byte-for-byte here).

      - id: file_type
        type: u4be
        doc: |
          GFF4 logical type fourCC (e.g. `G2DA` for GDA tables). `Header::read` uses
          `readUint32BE` on the endian-aware substream (`gff4file.cpp`).

      - id: type_version
        type: u4be
        doc: Version of the logical `file_type` (GDA uses `V0.1` / `V0.2` per `gdafile.cpp`).

      - id: num_struct_templates
        type: u4le
        doc: |
          Struct template count (`readUint32` without BE — follows platform endianness; **PC LE**
          in typical DA assets). xoreos: `_header.structCount`.

      - id: string_count
        type: u4le
        if: aurora_version == 0x56342e31
        doc: V4.1 only — entry count for global shared string table (`gff4file.cpp` `Header::read`).

      - id: string_offset
        type: u4le
        if: aurora_version == 0x56342e31
        doc: V4.1 only — byte offset to UTF-8 shared strings (`loadStrings`).

      - id: data_offset
        type: u4le
        doc: |
          Byte offset to instantiated struct data (`GFF4Struct` root @ `_header.dataOffset`).
          `readUint32` on the endian substream (`gff4file.cpp`).

      - id: struct_templates
        type: gff4_struct_template_header
        repeat: expr
        repeat-expr: num_struct_templates
        doc: Contiguous template header array (`structTemplateStart + i * 16` in `loadStructs`).

      - id: tail
        size-eos: true
        doc: |
          Remaining bytes after the template strip (field-declaration tables at arbitrary offsets,
          optional V4.1 string heap, struct payload at `data_offset`, etc.). Parse with a full
          GFF4 graph walker or defer to engine code.

  gff4_file:
    doc: |
      Full GFF4 stream (8-byte Aurora prefix + `gff4_after_aurora`). Use from importers such as `GDA.ksy`
      that expect a single user-type over the whole file.
    seq:
      - id: aurora_magic
        type: u4be
        doc: Aurora container magic (`GFF ` as `u4be`).

      - id: aurora_version
        type: u4be
        doc: GFF4 `V4.0` / `V4.1` on-disk tags.

      - id: gff4
        type: gff4_after_aurora(aurora_version)
        doc: GFF4 header tail + struct templates + opaque remainder.

  gff4_struct_template_header:
    seq:
      - id: struct_label
        type: u4be
        doc: Template label (fourCC style, read `readUint32BE` in `loadStructs`).

      - id: field_count
        type: u4le
        doc: Number of field declaration records for this template (may be 0).

      - id: field_offset
        type: u4le
        doc: |
          Absolute stream offset to field declaration array, or `0xFFFFFFFF` when `field_count == 0`
          (xoreos `continue`s without reading declarations).

      - id: struct_size
        type: u4le
        doc: Declared on-disk struct size for instances of this template (`strct.size`).

  gff_header_tail:
    doc: |
      **GFF3** header continuation: **48 bytes** (twelve LE `u32` dwords) at file offsets **0x08–0x37**, immediately
      after the shared Aurora 8-byte prefix (`aurora_magic` / `aurora_version` on `gff_union_file`). Same layout as
      wiki [File Header](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#file-header) rows from “Struct Array
      Offset” through “List Indices Count”. Ghidra `/K1/k1_win_gog_swkotor.exe`: `GFFHeaderInfo` @ +0x8 … +0x34.

      Sources (same DWORD order on disk after the 8-byte signature):
      - https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L70-L114 (`file_type`/`file_version` L79–L80 then twelve header `u32`s L93–L106)
      - https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L27-L44 (`GffReader::load` — skips 8-byte signature, reads twelve header `u32`s L30–L41)
      - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff3file.cpp#L50-L63 (`GFF3File::Header::read` — Aurora GFF3 header DWORD layout)
      - https://github.com/th3w1zard1/xoreos-docs/blob/c7f12b09788a331499ce15b1283b630b4feb5163/specs/torlack/itp.html#L44-L49 (Aurora/GFF-family background; MultiMap wording)
    seq:
      - id: struct_offset
        type: u4
        doc: |
          Byte offset to struct array. Wiki `File Header` row “Struct Array Offset”, offset 0x08.
          Source: Ghidra `GFFHeaderInfo.struct_offset` @ +0x8 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L93 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L30

      - id: struct_count
        type: u4
        doc: |
          Struct row count. Wiki `File Header` row “Struct Count”, offset 0x0C.
          Source: Ghidra `GFFHeaderInfo.struct_count` @ +0xC (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L94 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L31

      - id: field_offset
        type: u4
        doc: |
          Byte offset to field array. Wiki `File Header` row “Field Array Offset”, offset 0x10.
          Source: Ghidra `GFFHeaderInfo.field_offset` @ +0x10 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L95 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L32

      - id: field_count
        type: u4
        doc: |
          Field row count. Wiki `File Header` row “Field Count”, offset 0x14.
          Source: Ghidra `GFFHeaderInfo.field_count` @ +0x14 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L96 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L33

      - id: label_offset
        type: u4
        doc: |
          Byte offset to label array. Wiki `File Header` row “Label Array Offset”, offset 0x18.
          Source: Ghidra `GFFHeaderInfo.label_offset` @ +0x18 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L98 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L34

      - id: label_count
        type: u4
        doc: |
          Label slot count. Wiki `File Header` row “Label Count”, offset 0x1C.
          Source: Ghidra `GFFHeaderInfo.label_count` @ +0x1C (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L99 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L35

      - id: field_data_offset
        type: u4
        doc: |
          Byte offset to field-data section. Wiki `File Header` row “Field Data Offset”, offset 0x20.
          Source: Ghidra `GFFHeaderInfo.field_data_offset` @ +0x20 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L101 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L36

      - id: field_data_count
        type: u4
        doc: |
          Field-data section size in bytes. Wiki `File Header` row “Field Data Count”, offset 0x24.
          Source: Ghidra `GFFHeaderInfo.field_data_count` @ +0x24 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L102 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L37

      - id: field_indices_offset
        type: u4
        doc: |
          Byte offset to field-indices stream. Wiki `File Header` row “Field Indices Offset”, offset 0x28.
          Source: Ghidra `GFFHeaderInfo.field_indices_offset` @ +0x28 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L103 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L38

      - id: field_indices_count
        type: u4
        doc: |
          Count of `u32` entries in the field-indices stream (MultiMap). Wiki `File Header` row “Field Indices Count”, offset 0x2C.
          Source: Ghidra `GFFHeaderInfo.field_indices_count` @ +0x2C (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L104 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L39 (member typo `fieldIncidesCount` in upstream)

      - id: list_indices_offset
        type: u4
        doc: |
          Byte offset to list-indices arena. Wiki `File Header` row “List Indices Offset”, offset 0x30.
          Source: Ghidra `GFFHeaderInfo.list_indices_offset` @ +0x30 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L105 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L40

      - id: list_indices_count
        type: u4
        doc: |
          List-indices arena size in bytes (this `.ksy` uses it as `list_indices_array.raw_data` byte length).
          Wiki `File Header` row “List Indices Count”, offset 0x34 — note wiki table header wording; access pattern is under [List Indices](https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices).
          Source: Ghidra `GFFHeaderInfo.list_indices_count` @ +0x34 (ulong).
          PyKotor: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L106 — reone: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L41; list decode https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L275-L294 vs reone https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L218-L223

  label_array:
    doc: |
      Contiguous table of `label_count` fixed 16-byte ASCII name slots at `label_offset`.
      Indexed by `GFFFieldData.label_index` (×16). Not a separate Ghidra struct — rows are `char[16]` in bulk.
      Community tooling (16-byte label convention, KotOR-focused): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
    seq:
      - id: labels
        type: label_entry
        repeat: expr
        repeat-expr: _root.file.gff3.header.label_count
        doc: |
          Repeated `label_entry`; count from `GFFHeaderInfo.label_count`. Stride 16 bytes per label.
          Index `i` is at file offset `label_offset + i*16`.

  label_entry:
    doc: |
      One on-disk label: 16 bytes ASCII, NUL-padded (GFF label convention). Same bytes as `label_entry_terminated` without terminator trim.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Field name label (null-padded to 16 bytes, ASCII, first NUL terminates logical name).
          Referenced by `GFFFieldData.label_index` ×16 from `label_offset`.
          Engine resolves names when matching `ReadField*` label parameters (e.g. string pointers pushed to `ReadFieldBYTE` @ `0x00411a60`).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#label-array

  struct_array:
    doc: |
      Table of `GFFStructData` rows (`struct_count` × 12 bytes at `struct_offset`). Ghidra name `GFFStructData`.
      Cross-check: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L122-L127 (seek row base L122; three `u32` L123–L127) — https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L47-L51
    seq:
      - id: entries
        type: struct_entry
        repeat: expr
        repeat-expr: _root.file.gff3.header.struct_count
        doc: |
          Repeated `struct_entry` (`GFFStructData`); count from `struct_count`, base `struct_offset`.
          Stride 12 bytes per struct (matches Ghidra component sizes).

  struct_entry:
    doc: |
      One `GFFStructData` row: `id` (+0), `data_or_data_offset` (+4), `field_count` (+8). Drives single-field vs multi-field indexing.
    seq:
      - id: struct_id
        type: u4
        doc: |
          Structure type identifier.
          Source: Ghidra `GFFStructData.id` @ +0x0 on `/K1/k1_win_gog_swkotor.exe`.
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
          0xFFFFFFFF is the conventional "generic" / unset id in KotOR data; other values are schema-specific.

      - id: data_or_offset
        type: u4
        doc: |
          Field index (if field_count == 1) or byte offset to field indices array (if field_count > 1).
          If field_count == 0, this value is unused.
          Source: Ghidra `GFFStructData.data_or_data_offset` @ +0x4 (matches engine naming; same 4-byte slot as here).

      - id: field_count
        type: u4
        doc: |
          Number of fields in this struct:
          - 0: No fields
          - 1: Single field, data_or_offset contains the field index directly
          - >1: Multiple fields, data_or_offset contains byte offset into field_indices_array
          Source: Ghidra `GFFStructData.field_count` @ +0x8 (ulong).
    instances:
      has_single_field:
        value: field_count == 1
        doc: |
          Derived: `GFFStructData.field_count == 1` ⇒ `data_or_data_offset` holds a direct index into the field dictionary.
          Same access pattern: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#struct-array
      has_multiple_fields:
        value: field_count > 1
        doc: |
          Derived: `field_count > 1` ⇒ `data_or_data_offset` is byte offset into the flat `field_indices_array` stream.
      single_field_index:
        value: data_or_offset
        if: has_single_field
        doc: |
          Alias of `data_or_offset` when `field_count == 1`; indexes `field_array.entries[index]`.
      field_indices_offset:
        value: data_or_offset
        if: has_multiple_fields
        doc: |
          Alias of `data_or_offset` when `field_count > 1`; added to `field_indices_offset` header field for absolute file pos.

  field_array:
    doc: |
      Table of `GFFFieldData` rows (`field_count` × 12 bytes at `field_offset`). Indexed by struct metadata and `field_indices_array`.
      Cross-check: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L163-L180 (`_load_fields_batch` reads 12-byte headers via `struct.unpack_from` L176–L178); single-field path `_load_field` L188–L191 — https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L68-L72
    seq:
      - id: entries
        type: field_entry
        repeat: expr
        repeat-expr: _root.file.gff3.header.field_count
        doc: |
          Repeated `field_entry` (`GFFFieldData`); count `field_count`, base `field_offset`.
          Stride 12 bytes; consistent with `CResGFF::GetField` indexing (`0x00410990`).

  field_entry:
    doc: |
      One `GFFFieldData` row: `field_type` (+0, `GFFFieldTypes`), `label_index` (+4), `data_or_data_offset` (+8).
      `CResGFF::GetField` @ `0x00410990` walks these with 12-byte stride.
      Dispatch table (inline vs `field_data` vs struct/list): https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L208-L273 — https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L78-L146
    seq:
      - id: field_type
        type: u4
        enum: bioware_gff_common::gff_field_type
        doc: |
          Field data type tag. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
          (ID → storage: inline vs `field_data` vs struct/list indirection).
          Inline: types 0–5, 8, 18; `field_data`: 6–7, 9–13, 16–17; struct index 14; list offset 15.
          Source: Ghidra `/K1/k1_win_gog_swkotor.exe` — `GFFFieldData.field_type` @ +0 (`GFFFieldTypes`).
          Runtime: `CResGFF::GetField` @ `0x00410990` (12-byte stride); `ReadFieldBYTE` @ `0x00411a60`, `ReadFieldINT` @ `0x00411c90`.
          PyKotor `GFFFieldType` enum ends at `Vector3 = 17` (no `StrRef`): https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 — binary reader comment on type 18: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

      - id: label_index
        type: u4
        doc: |
          Index into the label table (×16 bytes from `label_offset`). Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-array
          Source: Ghidra `GFFFieldData.label_index` @ +0x4 (ulong).

      - id: data_or_offset
        type: u4
        doc: |
          Inline data (simple types) or offset/index (complex types):
          - Simple types (0-5, 8, 18): Value stored directly (1-4 bytes, sign/zero extended to 4 bytes)
          - Complex types (6-7, 9-13, 16-17): Byte offset into field_data section (relative to field_data_offset)
          - Struct (14): Struct index (index into struct_array)
          - List (15): Byte offset into list_indices_array (relative to list_indices_offset)
          Source: Ghidra `GFFFieldData.data_or_data_offset` @ +0x8.
          `resolved_field` reads narrow values at `field_offset + index*12 + 8` for inline types; wiki storage rules: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types
    instances:
      is_simple_type:
        value: |
          field_type == bioware_gff_common::gff_field_type::uint8 or
          field_type == bioware_gff_common::gff_field_type::int8 or
          field_type == bioware_gff_common::gff_field_type::uint16 or
          field_type == bioware_gff_common::gff_field_type::int16 or
          field_type == bioware_gff_common::gff_field_type::uint32 or
          field_type == bioware_gff_common::gff_field_type::int32 or
          field_type == bioware_gff_common::gff_field_type::single or
          field_type == bioware_gff_common::gff_field_type::str_ref
        doc: |
          Derived: inline scalars — payload lives in the 4-byte `GFFFieldData.data_or_data_offset` word (`+0x8` in the 12-byte record).
          Matches readers that widen to 32-bit in-memory (see `ReadField*` callers).
          **PyKotor `GFFBinaryReader`:** type **18 is not handled** after the float branch — see https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L268-L273 (wire layout for 18 is still per wiki + this `.ksy`).
      is_complex_type:
        value: |
          field_type == bioware_gff_common::gff_field_type::uint64 or
          field_type == bioware_gff_common::gff_field_type::int64 or
          field_type == bioware_gff_common::gff_field_type::double or
          field_type == bioware_gff_common::gff_field_type::string or
          field_type == bioware_gff_common::gff_field_type::resref or
          field_type == bioware_gff_common::gff_field_type::localized_string or
          field_type == bioware_gff_common::gff_field_type::binary or
          field_type == bioware_gff_common::gff_field_type::vector4 or
          field_type == bioware_gff_common::gff_field_type::vector3
        doc: |
          Derived: `data_or_data_offset` is byte offset into `field_data` blob (base `field_data_offset`).
      is_struct_type:
        value: field_type == bioware_gff_common::gff_field_type::struct
        doc: |
          Derived: `data_or_data_offset` is struct index into `struct_array` (`GFFStructData` row).
      is_list_type:
        value: field_type == bioware_gff_common::gff_field_type::list
        doc: |
          Derived: `data_or_data_offset` is byte offset into `list_indices_array` (base `list_indices_offset`).
      field_data_offset_value:
        value: _root.file.gff3.header.field_data_offset + data_or_offset
        if: is_complex_type
        doc: |
          Absolute file offset: `GFFHeaderInfo.field_data_offset` + relative payload offset in `GFFFieldData`.
      struct_index_value:
        value: data_or_offset
        if: is_struct_type
        doc: |
          Struct index (same numeric interpretation as `GFFStructData` row index).
      list_indices_offset_value:
        value: _root.file.gff3.header.list_indices_offset + data_or_offset
        if: is_list_type
        doc: |
          Absolute file offset to a `list_entry` (count + indices) inside `list_indices_array`.

  field_data:
    doc: |
      Byte arena for complex field payloads; span = `field_data_count` from `field_data_offset` (`GFFHeaderInfo` +0x20 / +0x24).
    seq:
      - id: raw_data
        size: _root.file.gff3.header.field_data_count
        doc: |
          Opaque span sized by `GFFHeaderInfo.field_data_count` @ +0x24; base @ +0x20.
          Entries are addressed only through `GFFFieldData` complex-type offsets (not sequential).
          Per-type layouts: see `resolved_field` value_* instances and `bioware_common` types (CExoString, ResRef, LocString, vectors, binary).
          Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#field-data

  field_indices_array:
    doc: |
      Flat `u4` stream (`field_indices_count` elements from `field_indices_offset`). Multi-field structs slice this stream via `GFFStructData.data_or_data_offset`.
      “MultiMap” naming: PyKotor wiki (`wiki_gff_field_indices`) + Torlack ITP HTML (`xoreos_docs_torlack_itp_html`).
    seq:
      - id: indices
        type: u4
        repeat: expr
        repeat-expr: _root.file.gff3.header.field_indices_count
        doc: |
          `field_indices_count` × `u4` from `field_indices_offset`. No per-row header on disk —
          `GFFStructData` for a multi-field struct points at the first `u4` of its slice; length = `field_count`.
          Ghidra: counts/offset from `GFFHeaderInfo` @ +0x28 / +0x2C.

  list_indices_array:
    doc: |
      Packed list nodes (`u4` count + `u4` struct indices); arena size `list_indices_count` bytes from `list_indices_offset` (+0x30 / +0x34).
    seq:
      - id: raw_data
        size: _root.file.gff3.header.list_indices_count
        doc: |
          Byte span `list_indices_count` @ +0x34 from base `list_indices_offset` @ +0x30.
          Contains packed `list_entry` blobs at offsets referenced by list-typed `GFFFieldData`.
          This `raw_data` instance exposes the whole arena; use `list_entry` at `list_indices_offset + field_offset`.

  list_entry:
    doc: |
      One list node on disk: leading cardinality then struct row indices. Used when `GFFFieldTypes` = list (15).
      Mirrors: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L278-L285 — https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L218-L223
    seq:
      - id: num_struct_indices
        type: u4
        doc: |
          Little-endian count of following struct indices (list cardinality).
          Wiki list packing: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#list-indices
      - id: struct_indices
        type: u4
        repeat: expr
        repeat-expr: num_struct_indices
        doc: |
          Each value indexes `struct_array.entries[index]` (`GFFStructData` row).

  # Complex payloads: formats/Common/bioware_common.ksy (bioware_cexo_string, bioware_resref,
  # bioware_locstring, bioware_vector3/4, bioware_binary_data). Cross-audit those .ksy files against
  # the same /K1/k1_win_gog_swkotor.exe when verifying full engine parity.

  # ----------------------------
  # Higher-level resolved views
  # ----------------------------

  label_entry_terminated:
    doc: |
      Kaitai helper: same 16-byte on-disk label as `label_entry`, but `str` ends at first NUL (`terminator: 0`).
      Not a separate Ghidra datatype. Wire cite: `label_entry.name`.
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
        terminator: 0
        include: false
        doc: |
          Logical ASCII name; bytes match the fixed 16-byte `label_entry` slot up to the first `0x00`.

  resolved_struct:
    doc: |
      Kaitai composition: expands one `GFFStructData` row into child `resolved_field`s (recursive).
      On-disk row remains at `struct_offset + struct_index * 12`.
    params:
      - id: struct_index
        type: u4
        doc: |
          Row index into `struct_array.entries`; `0` = root. Require `struct_index < struct_count`.
    instances:
      entry:
        type: struct_entry
        pos: _root.file.gff3.header.struct_offset + struct_index * 12
        doc: |
          Raw `GFFStructData` (Ghidra 12-byte layout).

      field_indices:
        type: u4
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        pos: _root.file.gff3.header.field_indices_offset + entry.data_or_offset
        doc: |
          Contiguous `u4` slice when `field_count > 1`; absolute pos = `field_indices_offset` + `data_or_offset`.
          Length = `field_count`. If `field_count == 1`, the sole index is `data_or_offset` (see `single_field`).

      fields:
        type: resolved_field(field_indices[_index])
        repeat: expr
        repeat-expr: entry.field_count
        if: entry.field_count > 1
        doc: |
          One `resolved_field` per entry in `field_indices`.

      single_field:
        type: resolved_field(entry.data_or_offset)
        if: entry.field_count == 1
        doc: |
          `field_count == 1`: `data_or_offset` is the field dictionary index (not an offset into `field_indices`).

  resolved_field:
    doc: |
      Kaitai composition: one `GFFFieldData` row + label + payload.
      Inline scalars: read at `field_entry_pos + 8` (same file offset as `data_or_data_offset` in the 12-byte record).
      Complex: `field_data_offset + data_or_offset`. List head: `list_indices_offset + data_or_offset`.
      For well-formed data, exactly one `value_*` / `value_struct` / `list_*` branch applies.
    params:
      - id: field_index
        type: u4
        doc: |
          Index into `field_array.entries`; require `field_index < field_count`.
    instances:
      entry:
        type: field_entry
        pos: _root.file.gff3.header.field_offset + field_index * 12
        doc: |
          Raw `GFFFieldData`; 12-byte stride (see `CResGFF::GetField` @ `0x00410990`).

      label:
        type: label_entry_terminated
        pos: _root.file.gff3.header.label_offset + entry.label_index * 16
        doc: |
          Resolved name: `label_index` × 16 from `label_offset`; matches `ReadField*` label parameters.

      field_entry_pos:
        value: _root.file.gff3.header.field_offset + field_index * 12
        doc: |
          Byte offset of `field_type` (+0), `label_index` (+4), `data_or_data_offset` (+8).

      # Inline/simple types — payload in the DWORD at file offset field_entry_pos+8
      value_uint8:
        type: u1
        if: entry.field_type == bioware_gff_common::gff_field_type::uint8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 0 (UINT8). Engine: `ReadFieldBYTE` @ `0x00411a60` after lookup.
      value_int8:
        type: s1
        if: entry.field_type == bioware_gff_common::gff_field_type::int8
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 1 (INT8 in low byte of slot).
      value_uint16:
        type: u2
        if: entry.field_type == bioware_gff_common::gff_field_type::uint16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 2 (UINT16 LE at +8).
      value_int16:
        type: s2
        if: entry.field_type == bioware_gff_common::gff_field_type::int16
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 3 (INT16 LE at +8).
      value_uint32:
        type: u4
        if: entry.field_type == bioware_gff_common::gff_field_type::uint32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 4 (full inline DWORD).
      value_int32:
        type: s4
        if: entry.field_type == bioware_gff_common::gff_field_type::int32
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 5. `ReadFieldINT` @ `0x00411c90` after lookup.
      value_single:
        type: f4
        if: entry.field_type == bioware_gff_common::gff_field_type::single
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 8 (32-bit float).
      value_str_ref:
        type: u4
        if: entry.field_type == bioware_gff_common::gff_field_type::str_ref
        pos: field_entry_pos + 8
        doc: |
          `GFFFieldTypes` 18 — TLK StrRef inline (same 4-byte width as type 5; distinct meaning).
          `0xFFFFFFFF` often unset. Wiki: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types and https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#string-references-strref
          **reone** implements `StrRef` as **`field_data`-relative** (`readStrRefFieldData`), not as an inline dword at +8: https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L141-L143 — https://github.com/th3w1zard1/reone/blob/72e7f615a5790adfa2a12105d2570211e1c233b2/src/libs/resource/format/gffreader.cpp#L199-L204 (treat as cross-engine / cross-tool variance when porting assets).
          Historical KotOR editor discussion (type list / StrRef): https://www.lucasforumsarchive.com/thread/149407 — https://deadlystream.com/files/file/719-k-gff/
          PyKotor reader gap (no `elif` for 18): https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L273

      # Complex — payload in field_data blob
      value_uint64:
        type: u8
        if: entry.field_type == bioware_gff_common::gff_field_type::uint64
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 6 (UINT64 at `field_data` + relative offset).
      value_int64:
        type: s8
        if: entry.field_type == bioware_gff_common::gff_field_type::int64
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 7 (INT64).
      value_double:
        type: f8
        if: entry.field_type == bioware_gff_common::gff_field_type::double
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 9 (double).
      value_string:
        type: bioware_common::bioware_cexo_string
        if: entry.field_type == bioware_gff_common::gff_field_type::string
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 10 — CExoString (`bioware_cexo_string`).
      value_resref:
        type: bioware_common::bioware_resref
        if: entry.field_type == bioware_gff_common::gff_field_type::resref
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 11 — ResRef (`bioware_resref`).
      value_localized_string:
        type: bioware_common::bioware_locstring
        if: entry.field_type == bioware_gff_common::gff_field_type::localized_string
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 12 — CExoLocString (`bioware_locstring`).
      value_binary:
        type: bioware_common::bioware_binary_data
        if: entry.field_type == bioware_gff_common::gff_field_type::binary
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 13 — binary (`bioware_binary_data`).
      value_vector4:
        type: bioware_common::bioware_vector4
        if: entry.field_type == bioware_gff_common::gff_field_type::vector4
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 16 — four floats (`bioware_vector4`).
      value_vector3:
        type: bioware_common::bioware_vector3
        if: entry.field_type == bioware_gff_common::gff_field_type::vector3
        pos: _root.file.gff3.header.field_data_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 17 — three floats (`bioware_vector3`).

      # Struct / list — index or offset in data_or_offset (+8)
      value_struct:
        type: resolved_struct(entry.data_or_offset)
        if: entry.field_type == bioware_gff_common::gff_field_type::struct
        doc: |
          `GFFFieldTypes` 14 — `data_or_data_offset` is struct row index.

      list_entry:
        type: list_entry
        if: entry.field_type == bioware_gff_common::gff_field_type::list
        pos: _root.file.gff3.header.list_indices_offset + entry.data_or_offset
        doc: |
          `GFFFieldTypes` 15 — list node at `list_indices_offset` + relative byte offset.

      list_structs:
        type: resolved_struct(list_entry.struct_indices[_index])
        repeat: expr
        repeat-expr: list_entry.num_struct_indices
        if: entry.field_type == bioware_gff_common::gff_field_type::list
        doc: |
          Child structs for this list; indices from `list_entry.struct_indices`.

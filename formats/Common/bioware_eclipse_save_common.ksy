meta:
  id: bioware_eclipse_save_common
  title: BioWare Eclipse save wire helpers (Dragon Age family)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (shared Eclipse save primitives; submodule section 0).
      KotOR PC binary evidence: not applicable — Dragon Age saves (`DA2S`, `DAS`) use Eclipse binaries checked out separately in Odyssey (`user-agdec-http` per `AGENTS.md`).
    github_oldrepublicdevs_andastra_eclipse_save_base: |
      https://github.com/OldRepublicDevs/Andastra — `src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs`:
      UTF-8 length-prefixed strings **`WriteString` / `ReadString`** **35–61** (same wire as `length_prefixed_string` here).
    github_xoreos_types_game_id_block: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L396-L408
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  Shared **user-type** definitions for **Eclipse-engine** binary saves (**Dragon Age: Origins** `DAS `, **Dragon Age 2** `DA2S`).

  File **signatures** as LE ``u32``: ``das_save_file_magic_le`` / ``da2s_save_file_magic_le`` (Andastra ``SaveSignature``).

  Import this file from `formats/DAS/DAS.ksy` and `formats/DA2S/DA2S.ksy` instead of duplicating `length_prefixed_string`.

doc-ref:
  - "formats/Common/bioware_type_ids.ksy#L555-L556 In-tree — `xoreos_game_id` excerpt (**`dragon_age` (7)** / **`dragon_age2` (8)**; full `-1`..`max` table; mirrors `types.h` `GameID`)"
  - "formats/DAS/DAS.ksy In-tree — DAO save (`das_save_file_magic_le` on `signature`)"
  - "formats/DA2S/DA2S.ksy In-tree — DA2 save (`da2s_save_file_magic_le` on `signature`)"
  - "https://github.com/OldRepublicDevs/Andastra/blob/9f49a4d88fc144f819488a0cc37de471eaa0f01b/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L61 Andastra — UTF-8 length-prefixed string read/write"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L396-L408 xoreos — `GameID` (Dragon Age entries)"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree"

enums:
  das_save_file_magic_le:
    0x20534144:
      id: das_space
      doc: |
        ASCII ``DAS `` (space-terminated fourcc). Andastra ``DragonAgeOriginsSaveSerializer.SaveSignature``.
        https://github.com/OldRepublicDevs/Andastra/blob/9f49a4d88fc144f819488a0cc37de471eaa0f01b/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23

  da2s_save_file_magic_le:
    0x44324153:
      id: da2s
      doc: |
        ASCII ``DA2S`` (four letters, no trailing space). Andastra ``DragonAge2SaveSerializer.SaveSignature``.
        https://github.com/OldRepublicDevs/Andastra/blob/9f49a4d88fc144f819488a0cc37de471eaa0f01b/src/Andastra/Game/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs#L24

types:
  length_prefixed_string:
    seq:
      - id: length
        type: s4
        doc: |
          String length in bytes (UTF-8 encoding).
          Must be >= 0 and <= 65536 (sanity check).

      - id: value
        type: str
        encoding: UTF-8
        size: length
        terminator: 0
        include: false
        doc: String value (UTF-8 encoded)
    instances:
      value_trimmed:
        value: value
        doc: |
          String value.
          Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.

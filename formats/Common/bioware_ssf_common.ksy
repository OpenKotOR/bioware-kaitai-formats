meta:
  id: bioware_ssf_common
  title: BioWare SSF shared wire (sound-slot index table)
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ SSF; submodule section 0).
    ghidra_odyssey_k1: |
      Same KotOR PC **`CResSSF`** inventory as `formats/SSF/SSF.ksy` (Odyssey MCP `user-agdec-http` — see `AGENTS.md`): **no**
      dedicated `CResSSF`; this file documents only the **28×** `ssf_sound_slot` column semantics aligned with PyKotor / xoreos
      `readEntriesKotOR` / xoreos-tools XML mapping (`doc-ref`).
    pykotor_wiki_ssf_hub: https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf
    github_openkotor_pykotor_io_ssf: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py`:
      **`SSFBinaryReader.load`** **137–143** (28 StrRefs); **`SSFBinaryWriter.write`** **156–165** (28 writes + trailer).
    github_xoreos_ssffile_read_entries_kotor: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L165-L170
    xoreos_tools_ssfdumper_dump: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfdumper.cpp#L133-L167
    xoreos_docs_ssf_format_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/SSF_Format.pdf
doc: |
  Shared SSF wire: **header tags** (`ssf_file_magic_le`, `ssf_file_version_le`, xoreos ``kSSFID`` / ``kVersion*``)
  plus the fixed **28-column** StrRef table for KotOR **V1.1** (`ssf_sound_slot`: index `0..27` maps to gameplay
  slots). The per-slot layout is **not** tagged on disk — column order follows PyKotor / xoreos ``readEntriesKotOR`` /
  xoreos-tools XML mapping.

  **Lowest-scope documentation:** vendor line anchors sit on each enum member; `formats/SSF/SSF.ksy` imports this
  module and documents offset / `0xFFFFFFFF` trailer only.

doc-ref:
  - "formats/SSF/SSF.ksy#L94-L121 In-tree — SSF wire (`sound_array` / `sound_entry`) consuming this slot order"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#ssf PyKotor wiki — SSF hub"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/ssf/io_ssf.py#L112-L165 PyKotor — `io_ssf` binary reader/writer (28 StrRefs)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L165-L170 xoreos — `SSFFile::readEntriesKotOR` (28× uint32)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/xml/ssfdumper.cpp#L133-L167 xoreos-tools — `SSFDumper::dump` (XML tag ↔ column)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/SSF_Format.pdf xoreos-docs — SSF_Format.pdf"

enums:
  # Column order for the 28× uint32 StrRef table (KotOR / Aurora SSF v1.1).
  ssf_sound_slot:
    0: battle_cry_1
    1: battle_cry_2
    2: battle_cry_3
    3: battle_cry_4
    4: battle_cry_5
    5: battle_cry_6
    6: select_1
    7: select_2
    8: select_3
    9: attack_grunt_1
    10: attack_grunt_2
    11: attack_grunt_3
    12: pain_grunt_1
    13: pain_grunt_2
    14: low_health
    15: dead
    16: critical_hit
    17: target_immune
    18: lay_mine
    19: disarm_mine
    20: begin_stealth
    21: begin_search
    22: begin_unlock
    23: unlock_failed
    24: unlock_success
    25: separated_from_party
    26: rejoined_party
    27: poisoned

  # xoreos ssffile.cpp: kSSFID, kVersion10, kVersion11 (MKTAG LE u32 == ASCII fourcc).
  ssf_file_magic_le:
    0x20464653:
      id: ssf_space
      doc: |
        ASCII ``SSF `` as LE ``u32``. xoreos ``kSSFID``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L44-L46

  ssf_file_version_le:
    0x302e3156:
      id: v1_0_nwn
      doc: |
        ASCII ``V1.0`` (NWN 16-entry table). xoreos ``kVersion10``.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L44-L46
    0x312e3156:
      id: v1_1_kotor_or_nwn2
      doc: |
        ASCII ``V1.1`` (KotOR 28× StrRef column order in ``ssf_sound_slot``; NWN2 variant resolved by header heuristics in xoreos).
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/ssffile.cpp#L44-L119

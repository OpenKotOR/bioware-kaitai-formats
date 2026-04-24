meta:
  id: bioware_bwm_common
  title: BioWare BWM (binary walkmesh) shared enumerations
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / PyKotor ↔ BWM; submodule section 0).
    pykotor_bwm_type: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bwm/bwm_data.py#L96-L124
    pykotor_surface_material: https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/utility/common/geometry.py#L1118-L1152
    xoreos_walkmeshloader_header_comment: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L65-L71
    reone_bwmreader_type: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L35
    kotor_js_walkmesh_type: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/enums/odyssey/OdysseyWalkMeshType.ts#L11-L14
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  Shared **wire** for KotOR-lineage **BWM** (`.wok` / `.pwk` / `.dwk`): **file tag** LE ``u32`` pair
  (`bwm_file_magic_le` / `bwm_file_version_le`, same bytes as ASCII ``BWM `` + ``V1.0``), walkmesh class
  (`bwm_walkmesh_kind`: placeable-or-door vs area),   and per-face **surface material** ids (`bwm_surface_material`;
  same numeric space as `surfacemat.2da` / PyKotor `SurfaceMaterial`).

  WOK **AABB tree** nodes: **split plane / branch tag** in `bwm_aabb_split_plane_u4` (`BWM.ksy` `aabb_node.most_significant_plane`).

  **Lowest scope:** vendor anchors for these tables live here; `formats/BWM/BWM.ksy` imports this module
  and documents offsets, AABB layout, and adjacency only.

doc-ref:
  - "formats/BWM/BWM.ksy#L175-L182 In-tree — `walkmesh_type` (`bwm_walkmesh_kind`)"
  - "formats/BWM/BWM.ksy In-tree — `aabb_node.most_significant_plane` → `bwm_aabb_split_plane_u4`"
  - "formats/BWM/BWM.ksy#L369-L378 In-tree — `materials_array` (`bwm_surface_material` per face)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395 KotOR.js — AABB BVH read (split encoding mirrors `most_significant_plane`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bwm/bwm_data.py#L96-L124 PyKotor — `BWMType` (walkmesh kind 0/1)"
  - "https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/utility/common/geometry.py#L1118-L1152 PyKotor — `SurfaceMaterial` (face material ids)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L65-L71 xoreos — BWM header comment (`uint32_t` walkmesh type after magic)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L35 reone — `BwmReader::load` (type + version)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/enums/odyssey/OdysseyWalkMeshType.ts#L11-L14 KotOR.js — walkmesh type enum"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree (no dedicated BWM PDF in-tree; shared anchor)"

enums:
  bwm_file_magic_le:
    0x204d5742:
      id: bwm_space
      doc: |
        ASCII ``BWM `` as LE ``u32``. reone reads 8 (0x8)-byte ``BWM V1.0`` prefix; xoreos ``WalkmeshLoader`` documents magic + version.
        https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L30
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L65-L71

  bwm_file_version_le:
    0x302e3156:
      id: v1_0
      doc: |
        ASCII ``V1.0`` (only BWM stream version in KotOR data).
        https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L30

  # WOK-only AABB BVH: `formats/BWM/BWM.ksy` `aabb_node.most_significant_plane` (LE u32; negative half-spaces
  # use large unsigned values equal to -2..-4 as s32). KotOR.js `OdysseyWalkMesh` AABB read — `meta.xref` on `BWM.ksy`.
  bwm_aabb_split_plane_u4:
    0:
      id: no_children
      doc: |
        ``0x00000000`` — no child splits in this tag interpretation (see `BWM.ksy` `aabb_node` leaf vs internal narrative).
    1:
      id: pos_x
      doc: Positive X-axis split (internal node).
    2:
      id: pos_y
      doc: Positive Y-axis split (internal node).
    3:
      id: pos_z
      doc: Positive Z-axis split (internal node).
    0xfffffffe:
      id: neg_x
      doc: |
        ``0xFFFFFFFE`` (``-2`` as ``s4``) — negative X half-space. https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395
    0xfffffffd:
      id: neg_y
      doc: |
        ``0xFFFFFFFD`` (``-3`` as ``s4``) — negative Y half-space. https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395
    0xfffffffc:
      id: neg_z
      doc: |
        ``0xFFFFFFFC`` (``-4`` as ``s4``) — negative Z half-space. https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395

  # PyKotor `BWMType` / reone `WalkmeshType` / KotOR.js `OdysseyWalkMeshType` — on-disk u32 after 8 (0x8)-byte BWM header.
  bwm_walkmesh_kind:
    0: placeable_or_door
    1: area

  # PyKotor `SurfaceMaterial` (`surfacemat.2da`); stored once per face as u32 on disk.
  bwm_surface_material:
    0: undefined
    1: dirt
    2: obscuring
    3: grass
    4: stone
    5: wood
    6: water
    7: non_walk
    8: transparent
    9: carpet
    10: metal
    11: puddles
    12: swamp
    13: mud
    14: leaves
    15: lava
    16: bottomless_pit
    17: deep_water
    18: door
    19: non_walk_grass
    20: surface_material_20
    21: surface_material_21
    22: surface_material_22
    23: surface_material_23
    24: surface_material_24
    25: surface_material_25
    26: surface_material_26
    27: surface_material_27
    28: surface_material_28
    29: surface_material_29
    30: trigger

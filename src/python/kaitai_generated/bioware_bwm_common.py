# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareBwmCommon(KaitaiStruct):
    """Shared **wire** for KotOR-lineage **BWM** (`.wok` / `.pwk` / `.dwk`): **file tag** LE ``u32`` pair
    (`bwm_file_magic_le` / `bwm_file_version_le`, same bytes as ASCII ``BWM `` + ``V1.0``), walkmesh class
    (`bwm_walkmesh_kind`: placeable-or-door vs area),   and per-face **surface material** ids (`bwm_surface_material`;
    same numeric space as `surfacemat.2da` / PyKotor `SurfaceMaterial`).
    
    WOK **AABB tree** nodes: **split plane / branch tag** in `bwm_aabb_split_plane_u4` (`BWM.ksy` `aabb_node.most_significant_plane`).
    
    **Lowest scope:** vendor anchors for these tables live here; `formats/BWM/BWM.ksy` imports this module
    and documents offsets, AABB layout, and adjacency only.
    
    .. seealso::
       formats/BWM/BWM.ksy#L175-L182 In-tree — `walkmesh_type` (`bwm_walkmesh_kind`)
    
    
    .. seealso::
       formats/BWM/BWM.ksy In-tree — `aabb_node.most_significant_plane` → `bwm_aabb_split_plane_u4`
    
    
    .. seealso::
       formats/BWM/BWM.ksy#L369-L378 In-tree — `materials_array` (`bwm_surface_material` per face)
    
    
    .. seealso::
       KotOR.js — AABB BVH read (split encoding mirrors `most_significant_plane`) - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395
    
    
    .. seealso::
       PyKotor — `BWMType` (walkmesh kind 0/1) - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/pykotor/resource/formats/bwm/bwm_data.py#L96-L124
    
    
    .. seealso::
       PyKotor — `SurfaceMaterial` (face material ids) - https://github.com/OpenKotOR/PyKotor/blob/628a69df1b71a4537ce8a410b1c2e3c3604bd7f8/Libraries/PyKotor/src/utility/common/geometry.py#L1118-L1152
    
    
    .. seealso::
       xoreos — BWM header comment (`uint32_t` walkmesh type after magic) - https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L65-L71
    
    
    .. seealso::
       reone — `BwmReader::load` (type + version) - https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L35
    
    
    .. seealso::
       KotOR.js — walkmesh type enum - https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/enums/odyssey/OdysseyWalkMeshType.ts#L11-L14
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (no dedicated BWM PDF in-tree; shared anchor) - https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    """

    class BwmAabbSplitPlaneU4(IntEnum):
        no_children = 0
        pos_x = 1
        pos_y = 2
        pos_z = 3
        neg_z = 4294967292
        neg_y = 4294967293
        neg_x = 4294967294

    class BwmFileMagicLe(IntEnum):
        bwm_space = 541939522

    class BwmFileVersionLe(IntEnum):
        v1_0 = 808333654

    class BwmSurfaceMaterial(IntEnum):
        undefined = 0
        dirt = 1
        obscuring = 2
        grass = 3
        stone = 4
        wood = 5
        water = 6
        non_walk = 7
        transparent = 8
        carpet = 9
        metal = 10
        puddles = 11
        swamp = 12
        mud = 13
        leaves = 14
        lava = 15
        bottomless_pit = 16
        deep_water = 17
        door = 18
        non_walk_grass = 19
        surface_material_20 = 20
        surface_material_21 = 21
        surface_material_22 = 22
        surface_material_23 = 23
        surface_material_24 = 24
        surface_material_25 = 25
        surface_material_26 = 26
        surface_material_27 = 27
        surface_material_28 = 28
        surface_material_29 = 29
        trigger = 30

    class BwmWalkmeshKind(IntEnum):
        placeable_or_door = 0
        area = 1
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareBwmCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



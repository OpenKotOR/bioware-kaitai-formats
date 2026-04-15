# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Bwm(KaitaiStruct):
    """**BWM** (binary walkmesh): KotOR pathfinding / collision for `.wok` (area, `walkmesh_type=1`) vs `.pwk`/`.dwk`
    (placeable/door, `walkmesh_type=0`). Magic `BWM ` + `V1.0`, 52-byte properties, 84-byte offset/count table, then
    vertices, faces, materials; WOK adds normals, planes, AABB tree, adjacency, edges, perimeters.
    
    Decode `walkmesh_type` / face materials via `formats/Common/bioware_common.ksy`. Pinned readers: `meta.xref`.
    
    .. seealso::
       PyKotor wiki — BWM - https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm
    
    
    .. seealso::
       xoreos — WalkmeshLoader::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Bwm, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Bwm.BwmHeader(self._io, self, self._root)
        self.walkmesh_properties = Bwm.WalkmeshProperties(self._io, self, self._root)
        self.data_table_offsets = Bwm.DataTableOffsets(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        self.walkmesh_properties._fetch_instances()
        self.data_table_offsets._fetch_instances()
        _ = self.aabb_nodes
        if hasattr(self, '_m_aabb_nodes'):
            pass
            self._m_aabb_nodes._fetch_instances()

        _ = self.adjacencies
        if hasattr(self, '_m_adjacencies'):
            pass
            self._m_adjacencies._fetch_instances()

        _ = self.edges
        if hasattr(self, '_m_edges'):
            pass
            self._m_edges._fetch_instances()

        _ = self.face_indices
        if hasattr(self, '_m_face_indices'):
            pass
            self._m_face_indices._fetch_instances()

        _ = self.materials
        if hasattr(self, '_m_materials'):
            pass
            self._m_materials._fetch_instances()

        _ = self.normals
        if hasattr(self, '_m_normals'):
            pass
            self._m_normals._fetch_instances()

        _ = self.perimeters
        if hasattr(self, '_m_perimeters'):
            pass
            self._m_perimeters._fetch_instances()

        _ = self.planar_distances
        if hasattr(self, '_m_planar_distances'):
            pass
            self._m_planar_distances._fetch_instances()

        _ = self.vertices
        if hasattr(self, '_m_vertices'):
            pass
            self._m_vertices._fetch_instances()


    class AabbNode(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.AabbNode, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.bounds_min = Bwm.Vec3f(self._io, self, self._root)
            self.bounds_max = Bwm.Vec3f(self._io, self, self._root)
            self.face_index = self._io.read_s4le()
            self.unknown = self._io.read_u4le()
            self.most_significant_plane = self._io.read_u4le()
            self.left_child_index = self._io.read_u4le()
            self.right_child_index = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.bounds_min._fetch_instances()
            self.bounds_max._fetch_instances()

        @property
        def has_left_child(self):
            """True if this node has a left child."""
            if hasattr(self, '_m_has_left_child'):
                return self._m_has_left_child

            self._m_has_left_child = self.left_child_index != 4294967295
            return getattr(self, '_m_has_left_child', None)

        @property
        def has_right_child(self):
            """True if this node has a right child."""
            if hasattr(self, '_m_has_right_child'):
                return self._m_has_right_child

            self._m_has_right_child = self.right_child_index != 4294967295
            return getattr(self, '_m_has_right_child', None)

        @property
        def is_internal_node(self):
            """True if this is an internal node (has children), false if leaf node."""
            if hasattr(self, '_m_is_internal_node'):
                return self._m_is_internal_node

            self._m_is_internal_node = self.face_index == -1
            return getattr(self, '_m_is_internal_node', None)

        @property
        def is_leaf_node(self):
            """True if this is a leaf node (contains a face), false if internal node."""
            if hasattr(self, '_m_is_leaf_node'):
                return self._m_is_leaf_node

            self._m_is_leaf_node = self.face_index != -1
            return getattr(self, '_m_is_leaf_node', None)


    class AabbNodesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.AabbNodesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.nodes = []
            for i in range(self._root.data_table_offsets.aabb_count):
                self.nodes.append(Bwm.AabbNode(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.nodes)):
                pass
                self.nodes[i]._fetch_instances()



    class AdjacenciesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.AdjacenciesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.adjacencies = []
            for i in range(self._root.data_table_offsets.adjacency_count):
                self.adjacencies.append(Bwm.AdjacencyTriplet(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.adjacencies)):
                pass
                self.adjacencies[i]._fetch_instances()



    class AdjacencyTriplet(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.AdjacencyTriplet, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.edge_0_adjacency = self._io.read_s4le()
            self.edge_1_adjacency = self._io.read_s4le()
            self.edge_2_adjacency = self._io.read_s4le()


        def _fetch_instances(self):
            pass

        @property
        def edge_0_face_index(self):
            """Face index of adjacent face for edge 0 (decoded from adjacency index)."""
            if hasattr(self, '_m_edge_0_face_index'):
                return self._m_edge_0_face_index

            self._m_edge_0_face_index = (self.edge_0_adjacency // 3 if self.edge_0_adjacency != -1 else -1)
            return getattr(self, '_m_edge_0_face_index', None)

        @property
        def edge_0_has_neighbor(self):
            """True if edge 0 has an adjacent walkable face."""
            if hasattr(self, '_m_edge_0_has_neighbor'):
                return self._m_edge_0_has_neighbor

            self._m_edge_0_has_neighbor = self.edge_0_adjacency != -1
            return getattr(self, '_m_edge_0_has_neighbor', None)

        @property
        def edge_0_local_edge(self):
            """Local edge index (0, 1, or 2) of adjacent face for edge 0."""
            if hasattr(self, '_m_edge_0_local_edge'):
                return self._m_edge_0_local_edge

            self._m_edge_0_local_edge = (self.edge_0_adjacency % 3 if self.edge_0_adjacency != -1 else -1)
            return getattr(self, '_m_edge_0_local_edge', None)

        @property
        def edge_1_face_index(self):
            """Face index of adjacent face for edge 1 (decoded from adjacency index)."""
            if hasattr(self, '_m_edge_1_face_index'):
                return self._m_edge_1_face_index

            self._m_edge_1_face_index = (self.edge_1_adjacency // 3 if self.edge_1_adjacency != -1 else -1)
            return getattr(self, '_m_edge_1_face_index', None)

        @property
        def edge_1_has_neighbor(self):
            """True if edge 1 has an adjacent walkable face."""
            if hasattr(self, '_m_edge_1_has_neighbor'):
                return self._m_edge_1_has_neighbor

            self._m_edge_1_has_neighbor = self.edge_1_adjacency != -1
            return getattr(self, '_m_edge_1_has_neighbor', None)

        @property
        def edge_1_local_edge(self):
            """Local edge index (0, 1, or 2) of adjacent face for edge 1."""
            if hasattr(self, '_m_edge_1_local_edge'):
                return self._m_edge_1_local_edge

            self._m_edge_1_local_edge = (self.edge_1_adjacency % 3 if self.edge_1_adjacency != -1 else -1)
            return getattr(self, '_m_edge_1_local_edge', None)

        @property
        def edge_2_face_index(self):
            """Face index of adjacent face for edge 2 (decoded from adjacency index)."""
            if hasattr(self, '_m_edge_2_face_index'):
                return self._m_edge_2_face_index

            self._m_edge_2_face_index = (self.edge_2_adjacency // 3 if self.edge_2_adjacency != -1 else -1)
            return getattr(self, '_m_edge_2_face_index', None)

        @property
        def edge_2_has_neighbor(self):
            """True if edge 2 has an adjacent walkable face."""
            if hasattr(self, '_m_edge_2_has_neighbor'):
                return self._m_edge_2_has_neighbor

            self._m_edge_2_has_neighbor = self.edge_2_adjacency != -1
            return getattr(self, '_m_edge_2_has_neighbor', None)

        @property
        def edge_2_local_edge(self):
            """Local edge index (0, 1, or 2) of adjacent face for edge 2."""
            if hasattr(self, '_m_edge_2_local_edge'):
                return self._m_edge_2_local_edge

            self._m_edge_2_local_edge = (self.edge_2_adjacency % 3 if self.edge_2_adjacency != -1 else -1)
            return getattr(self, '_m_edge_2_local_edge', None)


    class BwmHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.BwmHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.magic = (self._io.read_bytes(4)).decode(u"ASCII")
            self.version = (self._io.read_bytes(4)).decode(u"ASCII")


        def _fetch_instances(self):
            pass

        @property
        def is_valid_bwm(self):
            """Validation check that the file is a valid BWM file.
            Both magic and version must match expected values.
            """
            if hasattr(self, '_m_is_valid_bwm'):
                return self._m_is_valid_bwm

            self._m_is_valid_bwm =  ((self.magic == u"BWM ") and (self.version == u"V1.0")) 
            return getattr(self, '_m_is_valid_bwm', None)


    class DataTableOffsets(KaitaiStruct):
        """**xoreos alignment:** `walkmeshloader.cpp` skips the same 64 bytes after `BWM ` / `V1.0`
        then reads this 16×`u4` table in order: vertex count/offset, face count/offset, face-type
        offset, **8-byte gap** (maps to `materials_offset` + `normals_offset` here), AABB count/offset,
        **4-byte unknown** (`unknown`), adjacency count/offset, perimeter edge count/offset.
        Perimeter handling differs: xoreos reads `(u32, u32)` pairs at `perimEdgesOffset` into a map
        (`appendPerimEdges`); this `.ksy` models separate **edges** + **perimeters** arrays per
        PyKotor-style BWM docs. **TODO: VERIFY** perimeter vs edge tables on representative `.wok` /
        `.dwk` assets if you need bit-identical parity with `WalkmeshLoader` only.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.DataTableOffsets, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.vertex_count = self._io.read_u4le()
            self.vertex_offset = self._io.read_u4le()
            self.face_count = self._io.read_u4le()
            self.face_indices_offset = self._io.read_u4le()
            self.materials_offset = self._io.read_u4le()
            self.normals_offset = self._io.read_u4le()
            self.distances_offset = self._io.read_u4le()
            self.aabb_count = self._io.read_u4le()
            self.aabb_offset = self._io.read_u4le()
            self.unknown = self._io.read_u4le()
            self.adjacency_count = self._io.read_u4le()
            self.adjacency_offset = self._io.read_u4le()
            self.edge_count = self._io.read_u4le()
            self.edge_offset = self._io.read_u4le()
            self.perimeter_count = self._io.read_u4le()
            self.perimeter_offset = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class EdgeEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.EdgeEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.edge_index = self._io.read_u4le()
            self.transition = self._io.read_s4le()


        def _fetch_instances(self):
            pass

        @property
        def face_index(self):
            """Face index that this edge belongs to (decoded from edge_index)."""
            if hasattr(self, '_m_face_index'):
                return self._m_face_index

            self._m_face_index = self.edge_index // 3
            return getattr(self, '_m_face_index', None)

        @property
        def has_transition(self):
            """True if this edge has a transition ID (links to door/area connection)."""
            if hasattr(self, '_m_has_transition'):
                return self._m_has_transition

            self._m_has_transition = self.transition != -1
            return getattr(self, '_m_has_transition', None)

        @property
        def local_edge_index(self):
            """Local edge index (0, 1, or 2) within the face (decoded from edge_index)."""
            if hasattr(self, '_m_local_edge_index'):
                return self._m_local_edge_index

            self._m_local_edge_index = self.edge_index % 3
            return getattr(self, '_m_local_edge_index', None)


    class EdgesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.EdgesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.edges = []
            for i in range(self._root.data_table_offsets.edge_count):
                self.edges.append(Bwm.EdgeEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.edges)):
                pass
                self.edges[i]._fetch_instances()



    class FaceIndices(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.FaceIndices, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.v1_index = self._io.read_u4le()
            self.v2_index = self._io.read_u4le()
            self.v3_index = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class FaceIndicesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.FaceIndicesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.faces = []
            for i in range(self._root.data_table_offsets.face_count):
                self.faces.append(Bwm.FaceIndices(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.faces)):
                pass
                self.faces[i]._fetch_instances()



    class MaterialsArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.MaterialsArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.materials = []
            for i in range(self._root.data_table_offsets.face_count):
                self.materials.append(KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareBwmFaceMaterialId, self._io.read_u4le()))



        def _fetch_instances(self):
            pass
            for i in range(len(self.materials)):
                pass



    class NormalsArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.NormalsArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.normals = []
            for i in range(self._root.data_table_offsets.face_count):
                self.normals.append(Bwm.Vec3f(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.normals)):
                pass
                self.normals[i]._fetch_instances()



    class PerimetersArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.PerimetersArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.perimeters = []
            for i in range(self._root.data_table_offsets.perimeter_count):
                self.perimeters.append(self._io.read_u4le())



        def _fetch_instances(self):
            pass
            for i in range(len(self.perimeters)):
                pass



    class PlanarDistancesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.PlanarDistancesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.distances = []
            for i in range(self._root.data_table_offsets.face_count):
                self.distances.append(self._io.read_f4le())



        def _fetch_instances(self):
            pass
            for i in range(len(self.distances)):
                pass



    class Vec3f(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.Vec3f, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.x = self._io.read_f4le()
            self.y = self._io.read_f4le()
            self.z = self._io.read_f4le()


        def _fetch_instances(self):
            pass


    class VerticesArray(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.VerticesArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.vertices = []
            for i in range(self._root.data_table_offsets.vertex_count):
                self.vertices.append(Bwm.Vec3f(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.vertices)):
                pass
                self.vertices[i]._fetch_instances()



    class WalkmeshProperties(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Bwm.WalkmeshProperties, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.walkmesh_type = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareBwmWalkmeshKind, self._io.read_u4le())
            self.relative_use_position_1 = Bwm.Vec3f(self._io, self, self._root)
            self.relative_use_position_2 = Bwm.Vec3f(self._io, self, self._root)
            self.absolute_use_position_1 = Bwm.Vec3f(self._io, self, self._root)
            self.absolute_use_position_2 = Bwm.Vec3f(self._io, self, self._root)
            self.position = Bwm.Vec3f(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.relative_use_position_1._fetch_instances()
            self.relative_use_position_2._fetch_instances()
            self.absolute_use_position_1._fetch_instances()
            self.absolute_use_position_2._fetch_instances()
            self.position._fetch_instances()

        @property
        def is_area_walkmesh(self):
            """True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)."""
            if hasattr(self, '_m_is_area_walkmesh'):
                return self._m_is_area_walkmesh

            self._m_is_area_walkmesh = self.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok
            return getattr(self, '_m_is_area_walkmesh', None)

        @property
        def is_placeable_or_door(self):
            """True if this is a placeable or door walkmesh (PWK/DWK)."""
            if hasattr(self, '_m_is_placeable_or_door'):
                return self._m_is_placeable_or_door

            self._m_is_placeable_or_door = self.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.placeable_or_door
            return getattr(self, '_m_is_placeable_or_door', None)


    @property
    def aabb_nodes(self):
        """Array of AABB tree nodes for spatial acceleration - WOK only."""
        if hasattr(self, '_m_aabb_nodes'):
            return self._m_aabb_nodes

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.aabb_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.aabb_offset)
            self._m_aabb_nodes = Bwm.AabbNodesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_aabb_nodes', None)

    @property
    def adjacencies(self):
        """Array of adjacency indices (int32 triplets per walkable face) - WOK only."""
        if hasattr(self, '_m_adjacencies'):
            return self._m_adjacencies

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.adjacency_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.adjacency_offset)
            self._m_adjacencies = Bwm.AdjacenciesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_adjacencies', None)

    @property
    def edges(self):
        """Array of perimeter edges (edge_index, transition pairs) - WOK only."""
        if hasattr(self, '_m_edges'):
            return self._m_edges

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.edge_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.edge_offset)
            self._m_edges = Bwm.EdgesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_edges', None)

    @property
    def face_indices(self):
        """Array of face vertex indices (uint32 triplets)."""
        if hasattr(self, '_m_face_indices'):
            return self._m_face_indices

        if self._root.data_table_offsets.face_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.face_indices_offset)
            self._m_face_indices = Bwm.FaceIndicesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_face_indices', None)

    @property
    def materials(self):
        """Array of surface material IDs per face."""
        if hasattr(self, '_m_materials'):
            return self._m_materials

        if self._root.data_table_offsets.face_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.materials_offset)
            self._m_materials = Bwm.MaterialsArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_materials', None)

    @property
    def normals(self):
        """Array of face normal vectors (float3 triplets) - WOK only."""
        if hasattr(self, '_m_normals'):
            return self._m_normals

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.face_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.normals_offset)
            self._m_normals = Bwm.NormalsArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_normals', None)

    @property
    def perimeters(self):
        """Array of perimeter markers (edge indices marking end of loops) - WOK only."""
        if hasattr(self, '_m_perimeters'):
            return self._m_perimeters

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.perimeter_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.perimeter_offset)
            self._m_perimeters = Bwm.PerimetersArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_perimeters', None)

    @property
    def planar_distances(self):
        """Array of planar distances (float32 per face) - WOK only."""
        if hasattr(self, '_m_planar_distances'):
            return self._m_planar_distances

        if  ((self._root.walkmesh_properties.walkmesh_type == bioware_common.BiowareCommon.BiowareBwmWalkmeshKind.area_wok) and (self._root.data_table_offsets.face_count > 0)) :
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.distances_offset)
            self._m_planar_distances = Bwm.PlanarDistancesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_planar_distances', None)

    @property
    def vertices(self):
        """Array of vertex positions (float3 triplets)."""
        if hasattr(self, '_m_vertices'):
            return self._m_vertices

        if self._root.data_table_offsets.vertex_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self._root.data_table_offsets.vertex_offset)
            self._m_vertices = Bwm.VerticesArray(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_vertices', None)



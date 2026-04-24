meta:
  id: bwm
  title: BioWare BWM (Binary WalkMesh) File Format
  license: MIT
  endian: le
  file-extension:
    - dwk
    - pwk
    - wok
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor_bwm_tree: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/
    pykotor_io_bwm_kaitai: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110
    pykotor_io_bwm_reader: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253
    pykotor_bwm_data: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/bwm_data.py#L96-L120
    github_modawan_reone_bwmreader: |
      https://github.com/modawan/reone — `src/libs/graphics/format/bwmreader.cpp`:
      **`BwmReader::load`** **27–92**; **vertex / adjacency / AABB table reads** **94–171**.
    xoreos_walkmeshloader_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113
    xoreos_walkmeshloader_append_tables: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216
    xoreos_walkmeshloader_getaabb_stream: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249
    kotor_js_odyssey_walkmesh_binary: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395
    kotor_js_odyssey_walkmesh_header: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L490-L516
    wiki: https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43
    xoreos_tools_no_walkmesh_cli: |
      `xoreos-tools` ships no dedicated BWM/`.wok` decode CLI (see `README.md` tool list); walkmesh bytes are consumed in-engine
      (`walkmeshloader.cpp`) and in PyKotor/reone/KotOR.js (`meta.xref` above).
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc-ref:
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no BWM-specific tool)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm PyKotor wiki — BWM"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110 PyKotor — Kaitai-backed BWM struct load"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253 PyKotor — BWMBinaryReader.load"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113 xoreos — WalkmeshLoader::load"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216 xoreos — WalkmeshLoader (append tables / WOK-only paths)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249 xoreos — WalkmeshLoader::getAABB"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L27-L92 reone — BwmReader::load"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/bwmreader.cpp#L94-L171 reone — BwmReader (AABB / adjacency tables)"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L301-L395 KotOR.js — readBinary"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyWalkMesh.ts#L490-L516 KotOR.js — header / version constants"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)"

doc: |
  BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
  in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
  extensions depending on their type:

  - WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
  - PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
  - DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states

  The format uses a header-based structure where offsets point to various data tables, allowing
  efficient random access to vertices, faces, materials, and acceleration structures.

  Binary Format Structure:
  - File Header (8 (0x8) bytes): Magic "BWM " and version "V1.0"
  - Walkmesh Properties (52 (0x34) bytes): Type, hook vectors, position
  - Data Table Offsets (84 (0x54) bytes): Counts and offsets for all data tables
  - Vertices Array: Array of float3 (x, y, z) per vertex
  - Face Indices Array: Array of uint32 triplets (vertex indices per face)
  - Materials Array: Array of uint32 (SurfaceMaterial ID per face)
  - Normals Array: Array of float3 (face normal per face) - WOK only
  - Planar Distances Array: Array of float32 (per face) - WOK only
  - AABB Nodes Array: Array of AABB structures (WOK only)
  - Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
  - Edges Array: Array of (edge_index, transition) pairs (WOK only)
  - Perimeters Array: Array of edge indices (WOK only)

  Authoritative cross-implementations (pinned paths and line bands): see `meta.xref` and `doc-ref`.

seq:
  - id: header
    type: bwm_header
    doc: BWM file header (8 (0x8) bytes) - magic and version signature

  - id: walkmesh_properties
    type: walkmesh_properties
    doc: Walkmesh properties section (52 (0x34) bytes) - type, hooks, position

  - id: data_table_offsets
    type: data_table_offsets
    doc: Data table offsets section (84 (0x54) bytes) - counts and offsets for all data tables

instances:
  vertices:
    pos: _root.data_table_offsets.vertex_offset
    type: vertices_array
    if: _root.data_table_offsets.vertex_count > 0
    doc: Array of vertex positions (float3 triplets)

  face_indices:
    pos: _root.data_table_offsets.face_indices_offset
    type: face_indices_array
    if: _root.data_table_offsets.face_count > 0
    doc: Array of face vertex indices (uint32 triplets)

  materials:
    pos: _root.data_table_offsets.materials_offset
    type: materials_array
    if: _root.data_table_offsets.face_count > 0
    doc: Array of surface material IDs per face

  normals:
    pos: _root.data_table_offsets.normals_offset
    type: normals_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.face_count > 0
    doc: Array of face normal vectors (float3 triplets) - WOK only

  planar_distances:
    pos: _root.data_table_offsets.distances_offset
    type: planar_distances_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.face_count > 0
    doc: Array of planar distances (float32 per face) - WOK only

  aabb_nodes:
    pos: _root.data_table_offsets.aabb_offset
    type: aabb_nodes_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.aabb_count > 0
    doc: Array of AABB tree nodes for spatial acceleration - WOK only

  adjacencies:
    pos: _root.data_table_offsets.adjacency_offset
    type: adjacencies_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.adjacency_count > 0
    doc: Array of adjacency indices (int32 triplets per walkable face) - WOK only

  edges:
    pos: _root.data_table_offsets.edge_offset
    type: edges_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.edge_count > 0
    doc: Array of perimeter edges (edge_index, transition pairs) - WOK only

  perimeters:
    pos: _root.data_table_offsets.perimeter_offset
    type: perimeters_array
    if: _root.walkmesh_properties.walkmesh_type == 1 and _root.data_table_offsets.perimeter_count > 0
    doc: Array of perimeter markers (edge indices marking end of loops) - WOK only

types:
  bwm_header:
    seq:
      - id: magic
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be "BWM " (space-padded).
          The space after "BWM" is significant and must be present.

      - id: version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V1.0" for KotOR BWM files.
          This is the first and only version of the BWM format used in KotOR games.

    instances:
      is_valid_bwm:
        value: magic == "BWM " and version == "V1.0"
        doc: |
          Validation check that the file is a valid BWM file.
          Both magic and version must match expected values.

  walkmesh_properties:
    seq:
      - id: walkmesh_type
        type: u4
        doc: |
          Walkmesh type identifier:
          - 0 = PWK/DWK (Placeable/Door walkmesh)
          - 1 = WOK (Area walkmesh)

      - id: relative_use_position_1
        type: vec3f
        doc: |
          Relative use hook position 1 (x, y, z).
          Position relative to the walkmesh origin, used when the walkmesh may be transformed.
          For doors: Defines where the player must stand to interact (relative to door model).
          For placeables: Defines interaction points relative to the object's local coordinate system.

      - id: relative_use_position_2
        type: vec3f
        doc: |
          Relative use hook position 2 (x, y, z).
          Second interaction point relative to the walkmesh origin.

      - id: absolute_use_position_1
        type: vec3f
        doc: |
          Absolute use hook position 1 (x, y, z).
          Position in world space, used when the walkmesh position is known.
          For doors: Precomputed world-space interaction points (position + relative hook).
          For placeables: World-space interaction points accounting for object placement.

      - id: absolute_use_position_2
        type: vec3f
        doc: |
          Absolute use hook position 2 (x, y, z).
          Second absolute interaction point in world space.

      - id: position
        type: vec3f
        doc: |
          Walkmesh position offset (x, y, z) in world space.
          For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
          For placeable/door walkmeshes: The position where the object is placed in the area.
          Used to transform vertices from local to world coordinates.

    instances:
      is_area_walkmesh:
        value: walkmesh_type == 1
        doc: True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)

      is_placeable_or_door:
        value: walkmesh_type == 0
        doc: True if this is a placeable or door walkmesh (PWK/DWK)

  data_table_offsets:
    seq:
      - id: vertex_count
        type: u4
        doc: Number of vertices in the walkmesh

      - id: vertex_offset
        type: u4
        doc: Byte offset to vertex array from the beginning of the file

      - id: face_count
        type: u4
        doc: Number of faces (triangles) in the walkmesh

      - id: face_indices_offset
        type: u4
        doc: Byte offset to face indices array from the beginning of the file

      - id: materials_offset
        type: u4
        doc: Byte offset to materials array from the beginning of the file

      - id: normals_offset
        type: u4
        doc: |
          Byte offset to face normals array from the beginning of the file.
          Only used for WOK files (area walkmeshes).

      - id: distances_offset
        type: u4
        doc: |
          Byte offset to planar distances array from the beginning of the file.
          Only used for WOK files (area walkmeshes).

      - id: aabb_count
        type: u4
        doc: |
          Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
          AABB trees provide spatial acceleration for raycasting and point queries.

      - id: aabb_offset
        type: u4
        doc: |
          Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
          Only present if aabb_count > 0.

      - id: unknown
        type: u4
        doc: |
          Unknown field (typically 0 or 4).
          Purpose is undocumented but appears in all BWM files.

      - id: adjacency_count
        type: u4
        doc: |
          Number of walkable faces for adjacency data (WOK only).
          This equals the number of walkable faces, not the total face count.
          Adjacencies are stored only for walkable faces.

      - id: adjacency_offset
        type: u4
        doc: |
          Byte offset to adjacency array from the beginning of the file (WOK only).
          Only present if adjacency_count > 0.

      - id: edge_count
        type: u4
        doc: |
          Number of perimeter edges (WOK only).
          Perimeter edges are boundary edges with no walkable neighbor.

      - id: edge_offset
        type: u4
        doc: |
          Byte offset to edges array from the beginning of the file (WOK only).
          Only present if edge_count > 0.

      - id: perimeter_count
        type: u4
        doc: |
          Number of perimeter markers (WOK only).
          Perimeter markers indicate the end of closed loops of perimeter edges.

      - id: perimeter_offset
        type: u4
        doc: |
          Byte offset to perimeters array from the beginning of the file (WOK only).
          Only present if perimeter_count > 0.

  vec3f:
    seq:
      - id: x
        type: f4
        doc: X coordinate (float32)

      - id: y
        type: f4
        doc: Y coordinate (float32)

      - id: z
        type: f4
        doc: Z coordinate (float32)

  vertices_array:
    seq:
      - id: vertices
        type: vec3f
        repeat: expr
        repeat-expr: _root.data_table_offsets.vertex_count
        doc: Array of vertex positions, each vertex is a float3 (x, y, z)

  face_indices_array:
    seq:
      - id: faces
        type: face_indices
        repeat: expr
        repeat-expr: _root.data_table_offsets.face_count
        doc: Array of face vertex index triplets

  face_indices:
    seq:
      - id: v1_index
        type: u4
        doc: |
          Vertex index for first vertex of triangle (0-based index into vertices array).
          Vertex indices define the triangle's vertices in counter-clockwise order
          when viewed from the front (the side the normal points toward).

      - id: v2_index
        type: u4
        doc: |
          Vertex index for second vertex of triangle (0-based index into vertices array).

      - id: v3_index
        type: u4
        doc: |
          Vertex index for third vertex of triangle (0-based index into vertices array).

  materials_array:
    seq:
      - id: materials
        type: u4
        repeat: expr
        repeat-expr: _root.data_table_offsets.face_count
        doc: |
          Array of surface material IDs, one per face.
          Material IDs determine walkability and physical properties:
          - 0 = NotDefined/UNDEFINED (non-walkable)
          - 1 = Dirt (walkable)
          - 2 = Obscuring (non-walkable, blocks line of sight)
          - 3 = Grass (walkable)
          - 4 = Stone (walkable)
          - 5 = Wood (walkable)
          - 6 = Water (walkable)
          - 7 = Nonwalk/NON_WALK (non-walkable)
          - 8 = Transparent (non-walkable)
          - 9 = Carpet (walkable)
          - 10 = Metal (walkable)
          - 11 = Puddles (walkable)
          - 12 = Swamp (walkable)
          - 13 = Mud (walkable)
          - 14 = Leaves (walkable)
          - 15 = Lava (non-walkable, damage-dealing)
          - 16 = BottomlessPit (walkable but dangerous)
          - 17 = DeepWater (non-walkable)
          - 18 = Door (walkable, special handling)
          - 19 = Snow/NON_WALK_GRASS (non-walkable)
          - 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)

  normals_array:
    seq:
      - id: normals
        type: vec3f
        repeat: expr
        repeat-expr: _root.data_table_offsets.face_count
        doc: |
          Array of face normal vectors, one per face (WOK only).
          Normals are precomputed unit vectors perpendicular to each face.
          Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
          Normal direction follows right-hand rule based on vertex winding order.

  planar_distances_array:
    seq:
      - id: distances
        type: f4
        repeat: expr
        repeat-expr: _root.data_table_offsets.face_count
        doc: |
          Array of planar distances, one per face (WOK only).
          The D component of the plane equation ax + by + cz + d = 0.
          Calculated as d = -normal · vertex1 for each face.
          Precomputed to allow quick point-plane relationship tests.

  aabb_nodes_array:
    seq:
      - id: nodes
        type: aabb_node
        repeat: expr
        repeat-expr: _root.data_table_offsets.aabb_count
        doc: |
          Array of AABB tree nodes for spatial acceleration (WOK only).
          AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).

  aabb_node:
    seq:
      - id: bounds_min
        type: vec3f
        doc: |
          Minimum bounding box coordinates (x, y, z).
          Defines the lower corner of the axis-aligned bounding box.

      - id: bounds_max
        type: vec3f
        doc: |
          Maximum bounding box coordinates (x, y, z).
          Defines the upper corner of the axis-aligned bounding box.

      - id: face_index
        type: s4
        doc: |
          Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
          Leaf nodes contain a single face, internal nodes contain child nodes.

      - id: unknown
        type: u4
        doc: |
          Unknown field (typically 4).
          Purpose is undocumented but appears in all AABB nodes.

      - id: most_significant_plane
        type: u4
        doc: |
          Split axis/plane identifier:
          - 0x00 = No children (leaf node)
          - 0x01 = Positive X axis split
          - 0x02 = Positive Y axis split
          - 0x03 = Positive Z axis split
          - 0xFFFFFFFE (-2) = Negative X axis split
          - 0xFFFFFFFD (-3) = Negative Y axis split
          - 0xFFFFFFFC (-4) = Negative Z axis split

      - id: left_child_index
        type: u4
        doc: |
          Index to left child node (0-based array index).
          0xFFFFFFFF indicates no left child.
          Child indices are 0-based indices into the AABB nodes array.

      - id: right_child_index
        type: u4
        doc: |
          Index to right child node (0-based array index).
          0xFFFFFFFF indicates no right child.
          Child indices are 0-based indices into the AABB nodes array.

    instances:
      is_leaf_node:
        value: face_index != -1
        doc: True if this is a leaf node (contains a face), false if internal node

      is_internal_node:
        value: face_index == -1
        doc: True if this is an internal node (has children), false if leaf node

      has_left_child:
        value: left_child_index != 0xFFFFFFFF
        doc: True if this node has a left child

      has_right_child:
        value: right_child_index != 0xFFFFFFFF
        doc: True if this node has a right child

  adjacencies_array:
    seq:
      - id: adjacencies
        type: adjacency_triplet
        repeat: expr
        repeat-expr: _root.data_table_offsets.adjacency_count
        doc: |
          Array of adjacency triplets, one per walkable face (WOK only).
          Each walkable face has exactly three adjacency entries, one for each edge.
          Adjacency count equals the number of walkable faces, not the total face count.

  adjacency_triplet:
    seq:
      - id: edge_0_adjacency
        type: s4
        doc: |
          Adjacency index for edge 0 (between v1 and v2).
          Encoding: face_index * 3 + edge_index
          -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

      - id: edge_1_adjacency
        type: s4
        doc: |
          Adjacency index for edge 1 (between v2 and v3).
          Encoding: face_index * 3 + edge_index
          -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

      - id: edge_2_adjacency
        type: s4
        doc: |
          Adjacency index for edge 2 (between v3 and v1).
          Encoding: face_index * 3 + edge_index
          -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).

    instances:
      edge_0_has_neighbor:
        value: edge_0_adjacency != -1
        doc: True if edge 0 has an adjacent walkable face

      edge_1_has_neighbor:
        value: edge_1_adjacency != -1
        doc: True if edge 1 has an adjacent walkable face

      edge_2_has_neighbor:
        value: edge_2_adjacency != -1
        doc: True if edge 2 has an adjacent walkable face

      edge_0_face_index:
        value: 'edge_0_adjacency != -1 ? (edge_0_adjacency / 3) : -1'
        doc: Face index of adjacent face for edge 0 (decoded from adjacency index)

      edge_0_local_edge:
        value: 'edge_0_adjacency != -1 ? (edge_0_adjacency % 3) : -1'
        doc: Local edge index (0, 1, or 2) of adjacent face for edge 0

      edge_1_face_index:
        value: 'edge_1_adjacency != -1 ? (edge_1_adjacency / 3) : -1'
        doc: Face index of adjacent face for edge 1 (decoded from adjacency index)

      edge_1_local_edge:
        value: 'edge_1_adjacency != -1 ? (edge_1_adjacency % 3) : -1'
        doc: Local edge index (0, 1, or 2) of adjacent face for edge 1

      edge_2_face_index:
        value: 'edge_2_adjacency != -1 ? (edge_2_adjacency / 3) : -1'
        doc: Face index of adjacent face for edge 2 (decoded from adjacency index)

      edge_2_local_edge:
        value: 'edge_2_adjacency != -1 ? (edge_2_adjacency % 3) : -1'
        doc: Local edge index (0, 1, or 2) of adjacent face for edge 2

  edges_array:
    seq:
      - id: edges
        type: edge_entry
        repeat: expr
        repeat-expr: _root.data_table_offsets.edge_count
        doc: |
          Array of perimeter edges (WOK only).
          Perimeter edges are boundary edges with no walkable neighbor.
          Each edge entry contains an edge index and optional transition ID.

  edge_entry:
    seq:
      - id: edge_index
        type: u4
        doc: |
          Encoded edge index: face_index * 3 + local_edge_index
          Identifies which face and which edge (0, 1, or 2) of that face.
          Edge 0: between v1 and v2
          Edge 1: between v2 and v3
          Edge 2: between v3 and v1

      - id: transition
        type: s4
        doc: |
          Transition ID for room/area connections, -1 if no transition.
          Non-negative values reference door connections or area boundaries.
          -1 indicates this is just a boundary edge with no transition.

    instances:
      face_index:
        value: edge_index / 3
        doc: Face index that this edge belongs to (decoded from edge_index)

      local_edge_index:
        value: edge_index % 3
        doc: Local edge index (0, 1, or 2) within the face (decoded from edge_index)

      has_transition:
        value: transition != -1
        doc: True if this edge has a transition ID (links to door/area connection)

  perimeters_array:
    seq:
      - id: perimeters
        type: u4
        repeat: expr
        repeat-expr: _root.data_table_offsets.perimeter_count
        doc: |
          Array of perimeter markers (WOK only).
          Each value is an index into the edges array, marking the end of a perimeter loop.
          Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
          Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.



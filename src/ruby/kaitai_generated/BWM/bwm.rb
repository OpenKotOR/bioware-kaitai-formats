# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# BWM (Binary WalkMesh) files define walkable surfaces for pathfinding and collision detection
# in Knights of the Old Republic (KotOR) games. BWM files are stored on disk with different
# extensions depending on their type:
# 
# - WOK: Area walkmesh files (walkmesh_type = 1) - defines walkable regions in game areas
# - PWK: Placeable walkmesh files (walkmesh_type = 0) - collision geometry for containers, furniture
# - DWK: Door walkmesh files (walkmesh_type = 0) - collision geometry for doors in various states
# 
# The format uses a header-based structure where offsets point to various data tables, allowing
# efficient random access to vertices, faces, materials, and acceleration structures.
# 
# Binary Format Structure:
# - File Header (8 bytes): Magic "BWM " and version "V1.0"
# - Walkmesh Properties (52 bytes): Type, hook vectors, position
# - Data Table Offsets (84 bytes): Counts and offsets for all data tables
# - Vertices Array: Array of float3 (x, y, z) per vertex
# - Face Indices Array: Array of uint32 triplets (vertex indices per face)
# - Materials Array: Array of uint32 (SurfaceMaterial ID per face)
# - Normals Array: Array of float3 (face normal per face) - WOK only
# - Planar Distances Array: Array of float32 (per face) - WOK only
# - AABB Nodes Array: Array of AABB structures (WOK only)
# - Adjacencies Array: Array of int32 triplets (WOK only, -1 for no neighbor)
# - Edges Array: Array of (edge_index, transition) pairs (WOK only)
# - Perimeters Array: Array of edge indices (WOK only)
# 
# Authoritative cross-implementations (pinned paths and line bands): see `meta.xref` and `doc-ref`.
# @see https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no BWM-specific tool)
# @see https://github.com/OpenKotOR/PyKotor/wiki/Level-Layout-Formats#bwm PyKotor wiki — BWM
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L56-L110 PyKotor — Kaitai-backed BWM struct load
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bwm/io_bwm.py#L187-L253 PyKotor — BWMBinaryReader.load
# @see https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L42-L113 xoreos — WalkmeshLoader::load
# @see https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L119-L216 xoreos — WalkmeshLoader (append tables / WOK-only paths)
# @see https://github.com/xoreos/xoreos/blob/master/src/engines/kotorbase/path/walkmeshloader.cpp#L218-L249 xoreos — WalkmeshLoader::getAABB
# @see https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L27-L92 reone — BwmReader::load
# @see https://github.com/modawan/reone/blob/master/src/libs/graphics/format/bwmreader.cpp#L94-L171 reone — BwmReader (AABB / adjacency tables)
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L301-L395 KotOR.js — readBinary
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyWalkMesh.ts#L490-L516 KotOR.js — header / version constants
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no dedicated BWM / walkmesh Torlack page; use engine + PyKotor xrefs above)
class Bwm < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @header = BwmHeader.new(@_io, self, @_root)
    @walkmesh_properties = WalkmeshProperties.new(@_io, self, @_root)
    @data_table_offsets = DataTableOffsets.new(@_io, self, @_root)
    self
  end
  class AabbNode < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @bounds_min = Vec3f.new(@_io, self, @_root)
      @bounds_max = Vec3f.new(@_io, self, @_root)
      @face_index = @_io.read_s4le
      @unknown = @_io.read_u4le
      @most_significant_plane = @_io.read_u4le
      @left_child_index = @_io.read_u4le
      @right_child_index = @_io.read_u4le
      self
    end

    ##
    # True if this node has a left child
    def has_left_child
      return @has_left_child unless @has_left_child.nil?
      @has_left_child = left_child_index != 4294967295
      @has_left_child
    end

    ##
    # True if this node has a right child
    def has_right_child
      return @has_right_child unless @has_right_child.nil?
      @has_right_child = right_child_index != 4294967295
      @has_right_child
    end

    ##
    # True if this is an internal node (has children), false if leaf node
    def is_internal_node
      return @is_internal_node unless @is_internal_node.nil?
      @is_internal_node = face_index == -1
      @is_internal_node
    end

    ##
    # True if this is a leaf node (contains a face), false if internal node
    def is_leaf_node
      return @is_leaf_node unless @is_leaf_node.nil?
      @is_leaf_node = face_index != -1
      @is_leaf_node
    end

    ##
    # Minimum bounding box coordinates (x, y, z).
    # Defines the lower corner of the axis-aligned bounding box.
    attr_reader :bounds_min

    ##
    # Maximum bounding box coordinates (x, y, z).
    # Defines the upper corner of the axis-aligned bounding box.
    attr_reader :bounds_max

    ##
    # Face index for leaf nodes, -1 (0xFFFFFFFF) for internal nodes.
    # Leaf nodes contain a single face, internal nodes contain child nodes.
    attr_reader :face_index

    ##
    # Unknown field (typically 4).
    # Purpose is undocumented but appears in all AABB nodes.
    attr_reader :unknown

    ##
    # Split axis/plane identifier:
    # - 0x00 = No children (leaf node)
    # - 0x01 = Positive X axis split
    # - 0x02 = Positive Y axis split
    # - 0x03 = Positive Z axis split
    # - 0xFFFFFFFE (-2) = Negative X axis split
    # - 0xFFFFFFFD (-3) = Negative Y axis split
    # - 0xFFFFFFFC (-4) = Negative Z axis split
    attr_reader :most_significant_plane

    ##
    # Index to left child node (0-based array index).
    # 0xFFFFFFFF indicates no left child.
    # Child indices are 0-based indices into the AABB nodes array.
    attr_reader :left_child_index

    ##
    # Index to right child node (0-based array index).
    # 0xFFFFFFFF indicates no right child.
    # Child indices are 0-based indices into the AABB nodes array.
    attr_reader :right_child_index
  end
  class AabbNodesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @nodes = []
      (_root.data_table_offsets.aabb_count).times { |i|
        @nodes << AabbNode.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of AABB tree nodes for spatial acceleration (WOK only).
    # AABB trees enable efficient raycasting and point queries (O(log N) vs O(N)).
    attr_reader :nodes
  end
  class AdjacenciesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @adjacencies = []
      (_root.data_table_offsets.adjacency_count).times { |i|
        @adjacencies << AdjacencyTriplet.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of adjacency triplets, one per walkable face (WOK only).
    # Each walkable face has exactly three adjacency entries, one for each edge.
    # Adjacency count equals the number of walkable faces, not the total face count.
    attr_reader :adjacencies
  end
  class AdjacencyTriplet < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @edge_0_adjacency = @_io.read_s4le
      @edge_1_adjacency = @_io.read_s4le
      @edge_2_adjacency = @_io.read_s4le
      self
    end

    ##
    # Face index of adjacent face for edge 0 (decoded from adjacency index)
    def edge_0_face_index
      return @edge_0_face_index unless @edge_0_face_index.nil?
      @edge_0_face_index = (edge_0_adjacency != -1 ? edge_0_adjacency / 3 : -1)
      @edge_0_face_index
    end

    ##
    # True if edge 0 has an adjacent walkable face
    def edge_0_has_neighbor
      return @edge_0_has_neighbor unless @edge_0_has_neighbor.nil?
      @edge_0_has_neighbor = edge_0_adjacency != -1
      @edge_0_has_neighbor
    end

    ##
    # Local edge index (0, 1, or 2) of adjacent face for edge 0
    def edge_0_local_edge
      return @edge_0_local_edge unless @edge_0_local_edge.nil?
      @edge_0_local_edge = (edge_0_adjacency != -1 ? edge_0_adjacency % 3 : -1)
      @edge_0_local_edge
    end

    ##
    # Face index of adjacent face for edge 1 (decoded from adjacency index)
    def edge_1_face_index
      return @edge_1_face_index unless @edge_1_face_index.nil?
      @edge_1_face_index = (edge_1_adjacency != -1 ? edge_1_adjacency / 3 : -1)
      @edge_1_face_index
    end

    ##
    # True if edge 1 has an adjacent walkable face
    def edge_1_has_neighbor
      return @edge_1_has_neighbor unless @edge_1_has_neighbor.nil?
      @edge_1_has_neighbor = edge_1_adjacency != -1
      @edge_1_has_neighbor
    end

    ##
    # Local edge index (0, 1, or 2) of adjacent face for edge 1
    def edge_1_local_edge
      return @edge_1_local_edge unless @edge_1_local_edge.nil?
      @edge_1_local_edge = (edge_1_adjacency != -1 ? edge_1_adjacency % 3 : -1)
      @edge_1_local_edge
    end

    ##
    # Face index of adjacent face for edge 2 (decoded from adjacency index)
    def edge_2_face_index
      return @edge_2_face_index unless @edge_2_face_index.nil?
      @edge_2_face_index = (edge_2_adjacency != -1 ? edge_2_adjacency / 3 : -1)
      @edge_2_face_index
    end

    ##
    # True if edge 2 has an adjacent walkable face
    def edge_2_has_neighbor
      return @edge_2_has_neighbor unless @edge_2_has_neighbor.nil?
      @edge_2_has_neighbor = edge_2_adjacency != -1
      @edge_2_has_neighbor
    end

    ##
    # Local edge index (0, 1, or 2) of adjacent face for edge 2
    def edge_2_local_edge
      return @edge_2_local_edge unless @edge_2_local_edge.nil?
      @edge_2_local_edge = (edge_2_adjacency != -1 ? edge_2_adjacency % 3 : -1)
      @edge_2_local_edge
    end

    ##
    # Adjacency index for edge 0 (between v1 and v2).
    # Encoding: face_index * 3 + edge_index
    # -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
    attr_reader :edge_0_adjacency

    ##
    # Adjacency index for edge 1 (between v2 and v3).
    # Encoding: face_index * 3 + edge_index
    # -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
    attr_reader :edge_1_adjacency

    ##
    # Adjacency index for edge 2 (between v3 and v1).
    # Encoding: face_index * 3 + edge_index
    # -1 (0xFFFFFFFF) indicates no adjacent walkable face (boundary edge).
    attr_reader :edge_2_adjacency
  end
  class BwmHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @magic = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      @version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Validation check that the file is a valid BWM file.
    # Both magic and version must match expected values.
    def is_valid_bwm
      return @is_valid_bwm unless @is_valid_bwm.nil?
      @is_valid_bwm =  ((magic == "BWM ") && (version == "V1.0")) 
      @is_valid_bwm
    end

    ##
    # File type signature. Must be "BWM " (space-padded).
    # The space after "BWM" is significant and must be present.
    attr_reader :magic

    ##
    # File format version. Always "V1.0" for KotOR BWM files.
    # This is the first and only version of the BWM format used in KotOR games.
    attr_reader :version
  end
  class DataTableOffsets < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @vertex_count = @_io.read_u4le
      @vertex_offset = @_io.read_u4le
      @face_count = @_io.read_u4le
      @face_indices_offset = @_io.read_u4le
      @materials_offset = @_io.read_u4le
      @normals_offset = @_io.read_u4le
      @distances_offset = @_io.read_u4le
      @aabb_count = @_io.read_u4le
      @aabb_offset = @_io.read_u4le
      @unknown = @_io.read_u4le
      @adjacency_count = @_io.read_u4le
      @adjacency_offset = @_io.read_u4le
      @edge_count = @_io.read_u4le
      @edge_offset = @_io.read_u4le
      @perimeter_count = @_io.read_u4le
      @perimeter_offset = @_io.read_u4le
      self
    end

    ##
    # Number of vertices in the walkmesh
    attr_reader :vertex_count

    ##
    # Byte offset to vertex array from the beginning of the file
    attr_reader :vertex_offset

    ##
    # Number of faces (triangles) in the walkmesh
    attr_reader :face_count

    ##
    # Byte offset to face indices array from the beginning of the file
    attr_reader :face_indices_offset

    ##
    # Byte offset to materials array from the beginning of the file
    attr_reader :materials_offset

    ##
    # Byte offset to face normals array from the beginning of the file.
    # Only used for WOK files (area walkmeshes).
    attr_reader :normals_offset

    ##
    # Byte offset to planar distances array from the beginning of the file.
    # Only used for WOK files (area walkmeshes).
    attr_reader :distances_offset

    ##
    # Number of AABB tree nodes (WOK only, 0 for PWK/DWK).
    # AABB trees provide spatial acceleration for raycasting and point queries.
    attr_reader :aabb_count

    ##
    # Byte offset to AABB tree nodes array from the beginning of the file (WOK only).
    # Only present if aabb_count > 0.
    attr_reader :aabb_offset

    ##
    # Unknown field (typically 0 or 4).
    # Purpose is undocumented but appears in all BWM files.
    attr_reader :unknown

    ##
    # Number of walkable faces for adjacency data (WOK only).
    # This equals the number of walkable faces, not the total face count.
    # Adjacencies are stored only for walkable faces.
    attr_reader :adjacency_count

    ##
    # Byte offset to adjacency array from the beginning of the file (WOK only).
    # Only present if adjacency_count > 0.
    attr_reader :adjacency_offset

    ##
    # Number of perimeter edges (WOK only).
    # Perimeter edges are boundary edges with no walkable neighbor.
    attr_reader :edge_count

    ##
    # Byte offset to edges array from the beginning of the file (WOK only).
    # Only present if edge_count > 0.
    attr_reader :edge_offset

    ##
    # Number of perimeter markers (WOK only).
    # Perimeter markers indicate the end of closed loops of perimeter edges.
    attr_reader :perimeter_count

    ##
    # Byte offset to perimeters array from the beginning of the file (WOK only).
    # Only present if perimeter_count > 0.
    attr_reader :perimeter_offset
  end
  class EdgeEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @edge_index = @_io.read_u4le
      @transition = @_io.read_s4le
      self
    end

    ##
    # Face index that this edge belongs to (decoded from edge_index)
    def face_index
      return @face_index unless @face_index.nil?
      @face_index = edge_index / 3
      @face_index
    end

    ##
    # True if this edge has a transition ID (links to door/area connection)
    def has_transition
      return @has_transition unless @has_transition.nil?
      @has_transition = transition != -1
      @has_transition
    end

    ##
    # Local edge index (0, 1, or 2) within the face (decoded from edge_index)
    def local_edge_index
      return @local_edge_index unless @local_edge_index.nil?
      @local_edge_index = edge_index % 3
      @local_edge_index
    end

    ##
    # Encoded edge index: face_index * 3 + local_edge_index
    # Identifies which face and which edge (0, 1, or 2) of that face.
    # Edge 0: between v1 and v2
    # Edge 1: between v2 and v3
    # Edge 2: between v3 and v1
    attr_reader :edge_index

    ##
    # Transition ID for room/area connections, -1 if no transition.
    # Non-negative values reference door connections or area boundaries.
    # -1 indicates this is just a boundary edge with no transition.
    attr_reader :transition
  end
  class EdgesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @edges = []
      (_root.data_table_offsets.edge_count).times { |i|
        @edges << EdgeEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of perimeter edges (WOK only).
    # Perimeter edges are boundary edges with no walkable neighbor.
    # Each edge entry contains an edge index and optional transition ID.
    attr_reader :edges
  end
  class FaceIndices < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @v1_index = @_io.read_u4le
      @v2_index = @_io.read_u4le
      @v3_index = @_io.read_u4le
      self
    end

    ##
    # Vertex index for first vertex of triangle (0-based index into vertices array).
    # Vertex indices define the triangle's vertices in counter-clockwise order
    # when viewed from the front (the side the normal points toward).
    attr_reader :v1_index

    ##
    # Vertex index for second vertex of triangle (0-based index into vertices array).
    attr_reader :v2_index

    ##
    # Vertex index for third vertex of triangle (0-based index into vertices array).
    attr_reader :v3_index
  end
  class FaceIndicesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @faces = []
      (_root.data_table_offsets.face_count).times { |i|
        @faces << FaceIndices.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of face vertex index triplets
    attr_reader :faces
  end
  class MaterialsArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @materials = []
      (_root.data_table_offsets.face_count).times { |i|
        @materials << @_io.read_u4le
      }
      self
    end

    ##
    # Array of surface material IDs, one per face.
    # Material IDs determine walkability and physical properties:
    # - 0 = NotDefined/UNDEFINED (non-walkable)
    # - 1 = Dirt (walkable)
    # - 2 = Obscuring (non-walkable, blocks line of sight)
    # - 3 = Grass (walkable)
    # - 4 = Stone (walkable)
    # - 5 = Wood (walkable)
    # - 6 = Water (walkable)
    # - 7 = Nonwalk/NON_WALK (non-walkable)
    # - 8 = Transparent (non-walkable)
    # - 9 = Carpet (walkable)
    # - 10 = Metal (walkable)
    # - 11 = Puddles (walkable)
    # - 12 = Swamp (walkable)
    # - 13 = Mud (walkable)
    # - 14 = Leaves (walkable)
    # - 15 = Lava (non-walkable, damage-dealing)
    # - 16 = BottomlessPit (walkable but dangerous)
    # - 17 = DeepWater (non-walkable)
    # - 18 = Door (walkable, special handling)
    # - 19 = Snow/NON_WALK_GRASS (non-walkable)
    # - 20+ = Additional materials (Sand, BareBones, StoneBridge, etc.)
    attr_reader :materials
  end
  class NormalsArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @normals = []
      (_root.data_table_offsets.face_count).times { |i|
        @normals << Vec3f.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of face normal vectors, one per face (WOK only).
    # Normals are precomputed unit vectors perpendicular to each face.
    # Calculated using cross product: normal = normalize((v2 - v1) × (v3 - v1)).
    # Normal direction follows right-hand rule based on vertex winding order.
    attr_reader :normals
  end
  class PerimetersArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @perimeters = []
      (_root.data_table_offsets.perimeter_count).times { |i|
        @perimeters << @_io.read_u4le
      }
      self
    end

    ##
    # Array of perimeter markers (WOK only).
    # Each value is an index into the edges array, marking the end of a perimeter loop.
    # Perimeter loops are closed chains of perimeter edges forming walkable boundaries.
    # Values are typically 1-based (marking end of loop), but may be 0-based depending on implementation.
    attr_reader :perimeters
  end
  class PlanarDistancesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @distances = []
      (_root.data_table_offsets.face_count).times { |i|
        @distances << @_io.read_f4le
      }
      self
    end

    ##
    # Array of planar distances, one per face (WOK only).
    # The D component of the plane equation ax + by + cz + d = 0.
    # Calculated as d = -normal · vertex1 for each face.
    # Precomputed to allow quick point-plane relationship tests.
    attr_reader :distances
  end
  class Vec3f < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @x = @_io.read_f4le
      @y = @_io.read_f4le
      @z = @_io.read_f4le
      self
    end

    ##
    # X coordinate (float32)
    attr_reader :x

    ##
    # Y coordinate (float32)
    attr_reader :y

    ##
    # Z coordinate (float32)
    attr_reader :z
  end
  class VerticesArray < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @vertices = []
      (_root.data_table_offsets.vertex_count).times { |i|
        @vertices << Vec3f.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of vertex positions, each vertex is a float3 (x, y, z)
    attr_reader :vertices
  end
  class WalkmeshProperties < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @walkmesh_type = @_io.read_u4le
      @relative_use_position_1 = Vec3f.new(@_io, self, @_root)
      @relative_use_position_2 = Vec3f.new(@_io, self, @_root)
      @absolute_use_position_1 = Vec3f.new(@_io, self, @_root)
      @absolute_use_position_2 = Vec3f.new(@_io, self, @_root)
      @position = Vec3f.new(@_io, self, @_root)
      self
    end

    ##
    # True if this is an area walkmesh (WOK), false if placeable/door (PWK/DWK)
    def is_area_walkmesh
      return @is_area_walkmesh unless @is_area_walkmesh.nil?
      @is_area_walkmesh = walkmesh_type == 1
      @is_area_walkmesh
    end

    ##
    # True if this is a placeable or door walkmesh (PWK/DWK)
    def is_placeable_or_door
      return @is_placeable_or_door unless @is_placeable_or_door.nil?
      @is_placeable_or_door = walkmesh_type == 0
      @is_placeable_or_door
    end

    ##
    # Walkmesh type identifier:
    # - 0 = PWK/DWK (Placeable/Door walkmesh)
    # - 1 = WOK (Area walkmesh)
    attr_reader :walkmesh_type

    ##
    # Relative use hook position 1 (x, y, z).
    # Position relative to the walkmesh origin, used when the walkmesh may be transformed.
    # For doors: Defines where the player must stand to interact (relative to door model).
    # For placeables: Defines interaction points relative to the object's local coordinate system.
    attr_reader :relative_use_position_1

    ##
    # Relative use hook position 2 (x, y, z).
    # Second interaction point relative to the walkmesh origin.
    attr_reader :relative_use_position_2

    ##
    # Absolute use hook position 1 (x, y, z).
    # Position in world space, used when the walkmesh position is known.
    # For doors: Precomputed world-space interaction points (position + relative hook).
    # For placeables: World-space interaction points accounting for object placement.
    attr_reader :absolute_use_position_1

    ##
    # Absolute use hook position 2 (x, y, z).
    # Second absolute interaction point in world space.
    attr_reader :absolute_use_position_2

    ##
    # Walkmesh position offset (x, y, z) in world space.
    # For area walkmeshes (WOK): Typically (0, 0, 0) as areas define their own coordinate system.
    # For placeable/door walkmeshes: The position where the object is placed in the area.
    # Used to transform vertices from local to world coordinates.
    attr_reader :position
  end

  ##
  # Array of AABB tree nodes for spatial acceleration - WOK only
  def aabb_nodes
    return @aabb_nodes unless @aabb_nodes.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.aabb_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.aabb_offset)
      @aabb_nodes = AabbNodesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @aabb_nodes
  end

  ##
  # Array of adjacency indices (int32 triplets per walkable face) - WOK only
  def adjacencies
    return @adjacencies unless @adjacencies.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.adjacency_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.adjacency_offset)
      @adjacencies = AdjacenciesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @adjacencies
  end

  ##
  # Array of perimeter edges (edge_index, transition pairs) - WOK only
  def edges
    return @edges unless @edges.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.edge_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.edge_offset)
      @edges = EdgesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @edges
  end

  ##
  # Array of face vertex indices (uint32 triplets)
  def face_indices
    return @face_indices unless @face_indices.nil?
    if _root.data_table_offsets.face_count > 0
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.face_indices_offset)
      @face_indices = FaceIndicesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @face_indices
  end

  ##
  # Array of surface material IDs per face
  def materials
    return @materials unless @materials.nil?
    if _root.data_table_offsets.face_count > 0
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.materials_offset)
      @materials = MaterialsArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @materials
  end

  ##
  # Array of face normal vectors (float3 triplets) - WOK only
  def normals
    return @normals unless @normals.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.face_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.normals_offset)
      @normals = NormalsArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @normals
  end

  ##
  # Array of perimeter markers (edge indices marking end of loops) - WOK only
  def perimeters
    return @perimeters unless @perimeters.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.perimeter_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.perimeter_offset)
      @perimeters = PerimetersArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @perimeters
  end

  ##
  # Array of planar distances (float32 per face) - WOK only
  def planar_distances
    return @planar_distances unless @planar_distances.nil?
    if  ((_root.walkmesh_properties.walkmesh_type == 1) && (_root.data_table_offsets.face_count > 0)) 
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.distances_offset)
      @planar_distances = PlanarDistancesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @planar_distances
  end

  ##
  # Array of vertex positions (float3 triplets)
  def vertices
    return @vertices unless @vertices.nil?
    if _root.data_table_offsets.vertex_count > 0
      _pos = @_io.pos
      @_io.seek(_root.data_table_offsets.vertex_offset)
      @vertices = VerticesArray.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @vertices
  end

  ##
  # BWM file header (8 bytes) - magic and version signature
  attr_reader :header

  ##
  # Walkmesh properties section (52 bytes) - type, hooks, position
  attr_reader :walkmesh_properties

  ##
  # Data table offsets section (84 bytes) - counts and offsets for all data tables
  attr_reader :data_table_offsets
end

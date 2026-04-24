# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_mdl_common'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# BioWare MDL Model Format
# 
# The MDL file contains:
# - File header (12 bytes)
# - Model header (196 bytes) which begins with a Geometry header (80 bytes)
# - Name offset array + name strings
# - Animation offset array + animation headers + animation nodes
# - Node hierarchy with geometry data
# 
# Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.
# 
# Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.
# 
# Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
# are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
# compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
# @see https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)
# @see https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — MDLBinaryReader (binary MDL/MDX)
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — Model_KotOR::load
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)
# @see https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller / Aurora background)
# @see https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118 reone — MdlMdxReader::load
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170 KotOR.js — OdysseyModel binary constructor
# @see https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — controller name table
# @see https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — `readasciimdl` (ASCII MDL ingest)
class Mdl < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_header = FileHeader.new(@_io, self, @_root)
    @model_header = ModelHeader.new(@_io, self, @_root)
    self
  end

  ##
  # AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
  class AabbHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @trimesh_base = TrimeshHeader.new(@_io, self, @_root)
      @unknown = @_io.read_u4le
      self
    end

    ##
    # Standard trimesh header
    attr_reader :trimesh_base

    ##
    # Purpose unknown
    attr_reader :unknown
  end

  ##
  # Animation event (36 bytes)
  class AnimationEvent < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @activation_time = @_io.read_f4le
      @event_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Time in seconds when event triggers during animation playback
    attr_reader :activation_time

    ##
    # Name of event (null-terminated string, e.g., "detonate")
    attr_reader :event_name
  end

  ##
  # Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
  class AnimationHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @geo_header = GeometryHeader.new(@_io, self, @_root)
      @animation_length = @_io.read_f4le
      @transition_time = @_io.read_f4le
      @animation_root = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @event_array_offset = @_io.read_u4le
      @event_count = @_io.read_u4le
      @event_count_duplicate = @_io.read_u4le
      @unknown = @_io.read_u4le
      self
    end

    ##
    # Standard 80-byte geometry header (geometry_type = 0x01 for animation)
    attr_reader :geo_header

    ##
    # Duration of animation in seconds
    attr_reader :animation_length

    ##
    # Transition/blend time to this animation in seconds
    attr_reader :transition_time

    ##
    # Root node name for animation (null-terminated string)
    attr_reader :animation_root

    ##
    # Offset to animation events array
    attr_reader :event_array_offset

    ##
    # Number of animation events
    attr_reader :event_count

    ##
    # Duplicate value of event count
    attr_reader :event_count_duplicate

    ##
    # Purpose unknown
    attr_reader :unknown
  end

  ##
  # Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
  class AnimmeshHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @trimesh_base = TrimeshHeader.new(@_io, self, @_root)
      @unknown = @_io.read_f4le
      @unknown_array = ArrayDefinition.new(@_io, self, @_root)
      @unknown_floats = []
      (9).times { |i|
        @unknown_floats << @_io.read_f4le
      }
      self
    end

    ##
    # Standard trimesh header
    attr_reader :trimesh_base

    ##
    # Purpose unknown
    attr_reader :unknown

    ##
    # Unknown array definition
    attr_reader :unknown_array

    ##
    # Unknown float values
    attr_reader :unknown_floats
  end

  ##
  # Array definition structure (offset, count, count duplicate)
  class ArrayDefinition < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @offset = @_io.read_s4le
      @count = @_io.read_u4le
      @count_duplicate = @_io.read_u4le
      self
    end

    ##
    # Offset to array (relative to MDL data start, offset 12)
    attr_reader :offset

    ##
    # Number of used entries
    attr_reader :count

    ##
    # Duplicate of count (allocated entries)
    attr_reader :count_duplicate
  end

  ##
  # Controller structure (16 bytes) - defines animation data for a node property over time
  class Controller < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @type = Kaitai::Struct::Stream::resolve_enum(BiowareMdlCommon::CONTROLLER_TYPE, @_io.read_u4le)
      @unknown = @_io.read_u2le
      @row_count = @_io.read_u2le
      @time_index = @_io.read_u2le
      @data_index = @_io.read_u2le
      @column_count = @_io.read_u1
      @padding = []
      (3).times { |i|
        @padding << @_io.read_u1
      }
      self
    end

    ##
    # True if controller uses Bezier interpolation
    def uses_bezier
      return @uses_bezier unless @uses_bezier.nil?
      @uses_bezier = column_count & 16 != 0
      @uses_bezier
    end

    ##
    # Controller type identifier. Controllers define animation data for node properties over time.
    # 
    # Common Node Controllers (used by all node types):
    # - 8: Position (3 floats: X, Y, Z translation)
    # - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
    # - 36: Scale (3 floats: X, Y, Z scale factors)
    # 
    # Light Controllers (specific to light nodes):
    # - 76: Color (light color, 3 floats: R, G, B)
    # - 88: Radius (light radius, 1 float)
    # - 96: Shadow Radius (shadow casting radius, 1 float)
    # - 100: Vertical Displacement (vertical offset, 1 float)
    # - 140: Multiplier (light intensity multiplier, 1 float)
    # 
    # Emitter Controllers (specific to emitter nodes):
    # - 80: Alpha End (final alpha value, 1 float)
    # - 84: Alpha Start (initial alpha value, 1 float)
    # - 88: Birth Rate (particle spawn rate, 1 float)
    # - 92: Bounce Coefficient (particle bounce factor, 1 float)
    # - 96: Combine Time (particle combination timing, 1 float)
    # - 100: Drag (particle drag/resistance, 1 float)
    # - 104: FPS (frames per second, 1 float)
    # - 108: Frame End (ending frame number, 1 float)
    # - 112: Frame Start (starting frame number, 1 float)
    # - 116: Gravity (gravity force, 1 float)
    # - 120: Life Expectancy (particle lifetime, 1 float)
    # - 124: Mass (particle mass, 1 float)
    # - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
    # - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
    # - 136: Particle Rotation (particle rotation speed/angle, 1 float)
    # - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
    # - 144: Size Start (initial particle size, 1 float)
    # - 148: Size End (final particle size, 1 float)
    # - 152: Size Start Y (initial particle size Y component, 1 float)
    # - 156: Size End Y (final particle size Y component, 1 float)
    # - 160: Spread (particle spread angle, 1 float)
    # - 164: Threshold (threshold value, 1 float)
    # - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
    # - 172: X Size (particle X dimension size, 1 float)
    # - 176: Y Size (particle Y dimension size, 1 float)
    # - 180: Blur Length (motion blur length, 1 float)
    # - 184: Lightning Delay (lightning effect delay, 1 float)
    # - 188: Lightning Radius (lightning effect radius, 1 float)
    # - 192: Lightning Scale (lightning effect scale factor, 1 float)
    # - 196: Lightning Subdivide (lightning subdivision count, 1 float)
    # - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
    # - 216: Alpha Mid (mid-point alpha value, 1 float)
    # - 220: Percent Start (starting percentage, 1 float)
    # - 224: Percent Mid (mid-point percentage, 1 float)
    # - 228: Percent End (ending percentage, 1 float)
    # - 232: Size Mid (mid-point particle size, 1 float)
    # - 236: Size Mid Y (mid-point particle size Y component, 1 float)
    # - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
    # - 252: Target Size (target particle size, 1 float)
    # - 256: Number of Control Points (control point count, 1 float)
    # - 260: Control Point Radius (control point radius, 1 float)
    # - 264: Control Point Delay (control point delay timing, 1 float)
    # - 268: Tangent Spread (tangent spread angle, 1 float)
    # - 272: Tangent Length (tangent vector length, 1 float)
    # - 284: Color Mid (mid-point color, 3 floats: R, G, B)
    # - 380: Color End (final color, 3 floats: R, G, B)
    # - 392: Color Start (initial color, 3 floats: R, G, B)
    # - 502: Emitter Detonate (detonation trigger, 1 float)
    # 
    # Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
    # - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
    # - 128: Alpha (transparency/opacity, 1 float)
    # 
    # Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
    # Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
    # Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list
    attr_reader :type

    ##
    # Purpose unknown, typically 0xFFFF
    attr_reader :unknown

    ##
    # Number of keyframe rows (timepoints) for this controller
    attr_reader :row_count

    ##
    # Index into controller data array where time values begin
    attr_reader :time_index

    ##
    # Index into controller data array where property values begin
    attr_reader :data_index

    ##
    # Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
    # If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
    attr_reader :column_count

    ##
    # Padding bytes for 16-byte alignment
    attr_reader :padding
  end

  ##
  # Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
  class DanglymeshHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @trimesh_base = TrimeshHeader.new(@_io, self, @_root)
      @constraints_offset = @_io.read_u4le
      @constraints_count = @_io.read_u4le
      @constraints_count_duplicate = @_io.read_u4le
      @displacement = @_io.read_f4le
      @tightness = @_io.read_f4le
      @period = @_io.read_f4le
      @unknown = @_io.read_u4le
      self
    end

    ##
    # Standard trimesh header
    attr_reader :trimesh_base

    ##
    # Offset to vertex constraint values array
    attr_reader :constraints_offset

    ##
    # Number of vertex constraints (matches vertex count)
    attr_reader :constraints_count

    ##
    # Duplicate of constraints count
    attr_reader :constraints_count_duplicate

    ##
    # Maximum displacement distance for physics simulation
    attr_reader :displacement

    ##
    # Tightness/stiffness of spring simulation (0.0-1.0)
    attr_reader :tightness

    ##
    # Oscillation period in seconds
    attr_reader :period

    ##
    # Purpose unknown
    attr_reader :unknown
  end

  ##
  # Emitter header (224 bytes)
  class EmitterHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @dead_space = @_io.read_f4le
      @blast_radius = @_io.read_f4le
      @blast_length = @_io.read_f4le
      @branch_count = @_io.read_u4le
      @control_point_smoothing = @_io.read_f4le
      @x_grid = @_io.read_u4le
      @y_grid = @_io.read_u4le
      @padding_unknown = @_io.read_u4le
      @update_script = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @render_script = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @blend_script = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @texture_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @chunk_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @two_sided_texture = @_io.read_u4le
      @loop = @_io.read_u4le
      @render_order = @_io.read_u2le
      @frame_blending = @_io.read_u1
      @depth_texture_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @padding = @_io.read_u1
      @flags = @_io.read_u4le
      self
    end

    ##
    # Minimum distance from emitter before particles become visible
    attr_reader :dead_space

    ##
    # Radius of explosive/blast particle effects
    attr_reader :blast_radius

    ##
    # Length/duration of blast effects
    attr_reader :blast_length

    ##
    # Number of branching paths for particle trails
    attr_reader :branch_count

    ##
    # Smoothing factor for particle path control points
    attr_reader :control_point_smoothing

    ##
    # Grid subdivisions along X axis for particle spawning
    attr_reader :x_grid

    ##
    # Grid subdivisions along Y axis for particle spawning
    attr_reader :y_grid

    ##
    # Purpose unknown or padding
    attr_reader :padding_unknown

    ##
    # Update behavior script name (e.g., "single", "fountain")
    attr_reader :update_script

    ##
    # Render mode script name (e.g., "normal", "billboard_to_local_z")
    attr_reader :render_script

    ##
    # Blend mode script name (e.g., "normal", "lighten")
    attr_reader :blend_script

    ##
    # Particle texture name (null-terminated string)
    attr_reader :texture_name

    ##
    # Associated model chunk name (null-terminated string)
    attr_reader :chunk_name

    ##
    # 1 if texture should render two-sided, 0 for single-sided
    attr_reader :two_sided_texture

    ##
    # 1 if particle system loops, 0 for single playback
    attr_reader :loop

    ##
    # Rendering priority/order for particle sorting
    attr_reader :render_order

    ##
    # 1 if frame blending enabled, 0 otherwise
    attr_reader :frame_blending

    ##
    # Depth/softparticle texture name (null-terminated string)
    attr_reader :depth_texture_name

    ##
    # Padding byte for alignment
    attr_reader :padding

    ##
    # Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
    attr_reader :flags
  end

  ##
  # MDL file header (12 bytes)
  class FileHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @unused = @_io.read_u4le
      @mdl_size = @_io.read_u4le
      @mdx_size = @_io.read_u4le
      self
    end

    ##
    # Always 0
    attr_reader :unused

    ##
    # Size of MDL file in bytes
    attr_reader :mdl_size

    ##
    # Size of MDX file in bytes
    attr_reader :mdx_size
  end

  ##
  # Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
  class GeometryHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @function_pointer_0 = @_io.read_u4le
      @function_pointer_1 = @_io.read_u4le
      @model_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @root_node_offset = @_io.read_u4le
      @node_count = @_io.read_u4le
      @unknown_array_1 = ArrayDefinition.new(@_io, self, @_root)
      @unknown_array_2 = ArrayDefinition.new(@_io, self, @_root)
      @reference_count = @_io.read_u4le
      @geometry_type = @_io.read_u1
      @padding = []
      (3).times { |i|
        @padding << @_io.read_u1
      }
      self
    end

    ##
    # True if this is a KOTOR 2 model
    def is_kotor2
      return @is_kotor2 unless @is_kotor2.nil?
      @is_kotor2 =  ((function_pointer_0 == 4285200) || (function_pointer_0 == 4285872)) 
      @is_kotor2
    end

    ##
    # Game engine version identifier:
    # - KOTOR 1 PC: 4273776 (0x413670)
    # - KOTOR 2 PC: 4285200 (0x416310)
    # - KOTOR 1 Xbox: 4254992 (0x40ED10)
    # - KOTOR 2 Xbox: 4285872 (0x4165B0)
    attr_reader :function_pointer_0

    ##
    # Function pointer to ASCII model parser
    attr_reader :function_pointer_1

    ##
    # Model name, null-terminated string, max 32 (0x20) bytes
    attr_reader :model_name

    ##
    # Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
    attr_reader :root_node_offset

    ##
    # Total number of nodes in model hierarchy, unsigned 32-bit integer
    attr_reader :node_count

    ##
    # Unknown array definition (offset, count, count duplicate)
    attr_reader :unknown_array_1

    ##
    # Unknown array definition (offset, count, count duplicate)
    attr_reader :unknown_array_2

    ##
    # Reference count (initialized to 0, incremented when model is referenced)
    attr_reader :reference_count

    ##
    # Geometry type:
    # - 0x01: Basic geometry header (not in models)
    # - 0x02: Model geometry header
    # - 0x05: Animation geometry header
    # If bit 7 (0x80) is set, model is compiled binary with absolute addresses
    attr_reader :geometry_type

    ##
    # Padding bytes for alignment
    attr_reader :padding
  end

  ##
  # Light header (92 bytes)
  class LightHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @unknown = []
      (4).times { |i|
        @unknown << @_io.read_f4le
      }
      @flare_sizes_offset = @_io.read_u4le
      @flare_sizes_count = @_io.read_u4le
      @flare_sizes_count_duplicate = @_io.read_u4le
      @flare_positions_offset = @_io.read_u4le
      @flare_positions_count = @_io.read_u4le
      @flare_positions_count_duplicate = @_io.read_u4le
      @flare_color_shifts_offset = @_io.read_u4le
      @flare_color_shifts_count = @_io.read_u4le
      @flare_color_shifts_count_duplicate = @_io.read_u4le
      @flare_texture_names_offset = @_io.read_u4le
      @flare_texture_names_count = @_io.read_u4le
      @flare_texture_names_count_duplicate = @_io.read_u4le
      @flare_radius = @_io.read_f4le
      @light_priority = @_io.read_u4le
      @ambient_only = @_io.read_u4le
      @dynamic_type = @_io.read_u4le
      @affect_dynamic = @_io.read_u4le
      @shadow = @_io.read_u4le
      @flare = @_io.read_u4le
      @fading_light = @_io.read_u4le
      self
    end

    ##
    # Purpose unknown, possibly padding or reserved values
    attr_reader :unknown

    ##
    # Offset to flare sizes array (floats)
    attr_reader :flare_sizes_offset

    ##
    # Number of flare size entries
    attr_reader :flare_sizes_count

    ##
    # Duplicate of flare sizes count
    attr_reader :flare_sizes_count_duplicate

    ##
    # Offset to flare positions array (floats, 0.0-1.0 along light ray)
    attr_reader :flare_positions_offset

    ##
    # Number of flare position entries
    attr_reader :flare_positions_count

    ##
    # Duplicate of flare positions count
    attr_reader :flare_positions_count_duplicate

    ##
    # Offset to flare color shift array (RGB floats)
    attr_reader :flare_color_shifts_offset

    ##
    # Number of flare color shift entries
    attr_reader :flare_color_shifts_count

    ##
    # Duplicate of flare color shifts count
    attr_reader :flare_color_shifts_count_duplicate

    ##
    # Offset to flare texture name string offsets array
    attr_reader :flare_texture_names_offset

    ##
    # Number of flare texture names
    attr_reader :flare_texture_names_count

    ##
    # Duplicate of flare texture names count
    attr_reader :flare_texture_names_count_duplicate

    ##
    # Radius of flare effect
    attr_reader :flare_radius

    ##
    # Rendering priority for light culling/sorting
    attr_reader :light_priority

    ##
    # 1 if light only affects ambient, 0 for full lighting
    attr_reader :ambient_only

    ##
    # Type of dynamic lighting behavior
    attr_reader :dynamic_type

    ##
    # 1 if light affects dynamic objects, 0 otherwise
    attr_reader :affect_dynamic

    ##
    # 1 if light casts shadows, 0 otherwise
    attr_reader :shadow

    ##
    # 1 if lens flare effect enabled, 0 otherwise
    attr_reader :flare

    ##
    # 1 if light intensity fades with distance, 0 otherwise
    attr_reader :fading_light
  end

  ##
  # Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
  class LightsaberHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @trimesh_base = TrimeshHeader.new(@_io, self, @_root)
      @vertices_offset = @_io.read_u4le
      @texcoords_offset = @_io.read_u4le
      @normals_offset = @_io.read_u4le
      @unknown1 = @_io.read_u4le
      @unknown2 = @_io.read_u4le
      self
    end

    ##
    # Standard trimesh header
    attr_reader :trimesh_base

    ##
    # Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
    attr_reader :vertices_offset

    ##
    # Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
    attr_reader :texcoords_offset

    ##
    # Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
    attr_reader :normals_offset

    ##
    # Purpose unknown
    attr_reader :unknown1

    ##
    # Purpose unknown
    attr_reader :unknown2
  end

  ##
  # One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
  # Wraps the header so repeated root instances can use parametric types (user guide).
  class MdlAnimationEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil, anim_index)
      super(_io, _parent, _root)
      @anim_index = anim_index
      _read
    end

    def _read
      self
    end
    def header
      return @header unless @header.nil?
      _pos = @_io.pos
      @_io.seek(_root.data_start + _root.animation_offsets[anim_index])
      @header = AnimationHeader.new(@_io, self, @_root)
      @_io.seek(_pos)
      @header
    end
    attr_reader :anim_index
  end

  ##
  # Model header (196 bytes) starting at offset 12 (data_start).
  # This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
  # model-wide metadata, offsets, and counts.
  class ModelHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @geometry = GeometryHeader.new(@_io, self, @_root)
      @model_type = Kaitai::Struct::Stream::resolve_enum(BiowareMdlCommon::MODEL_CLASSIFICATION, @_io.read_u1)
      @unknown0 = @_io.read_u1
      @padding0 = @_io.read_u1
      @fog = @_io.read_u1
      @unknown1 = @_io.read_u4le
      @offset_to_animations = @_io.read_u4le
      @animation_count = @_io.read_u4le
      @animation_count2 = @_io.read_u4le
      @unknown2 = @_io.read_u4le
      @bounding_box_min = Vec3f.new(@_io, self, @_root)
      @bounding_box_max = Vec3f.new(@_io, self, @_root)
      @radius = @_io.read_f4le
      @animation_scale = @_io.read_f4le
      @supermodel_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @offset_to_super_root = @_io.read_u4le
      @unknown3 = @_io.read_u4le
      @mdx_data_size = @_io.read_u4le
      @mdx_data_offset = @_io.read_u4le
      @offset_to_name_offsets = @_io.read_u4le
      @name_offsets_count = @_io.read_u4le
      @name_offsets_count2 = @_io.read_u4le
      self
    end

    ##
    # Geometry header (80 bytes)
    attr_reader :geometry

    ##
    # Model classification byte
    attr_reader :model_type

    ##
    # TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
    attr_reader :unknown0

    ##
    # Padding byte
    attr_reader :padding0

    ##
    # Fog interaction (1 = affected, 0 = ignore fog)
    attr_reader :fog

    ##
    # TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
    attr_reader :unknown1

    ##
    # Offset to animation offset array (relative to data_start)
    attr_reader :offset_to_animations

    ##
    # Number of animations
    attr_reader :animation_count

    ##
    # Duplicate animation count / allocated count
    attr_reader :animation_count2

    ##
    # TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
    attr_reader :unknown2

    ##
    # Minimum coordinates of bounding box (X, Y, Z)
    attr_reader :bounding_box_min

    ##
    # Maximum coordinates of bounding box (X, Y, Z)
    attr_reader :bounding_box_max

    ##
    # Radius of model's bounding sphere
    attr_reader :radius

    ##
    # Scale factor for animations (typically 1.0)
    attr_reader :animation_scale

    ##
    # Name of supermodel (null-terminated string, "null" if empty)
    attr_reader :supermodel_name

    ##
    # TODO: VERIFY - offset to super-root node (relative to data_start)
    attr_reader :offset_to_super_root

    ##
    # TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
    attr_reader :unknown3

    ##
    # Size of MDX file data in bytes
    attr_reader :mdx_data_size

    ##
    # Offset to MDX data (typically 0)
    attr_reader :mdx_data_offset

    ##
    # Offset to name offset array (relative to data_start)
    attr_reader :offset_to_name_offsets

    ##
    # Count of name offsets / partnames
    attr_reader :name_offsets_count

    ##
    # Duplicate name offsets count / allocated count
    attr_reader :name_offsets_count2
  end

  ##
  # Array of null-terminated name strings
  class NameStrings < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @strings = []
      i = 0
      while not @_io.eof?
        @strings << (@_io.read_bytes_term(0, false, true, true)).force_encoding("ASCII").encode('UTF-8')
        i += 1
      end
      self
    end
    attr_reader :strings
  end

  ##
  # Node structure - starts with 80-byte header, followed by type-specific sub-header
  class Node < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @header = NodeHeader.new(@_io, self, @_root)
      if header.node_type == 3
        @light_sub_header = LightHeader.new(@_io, self, @_root)
      end
      if header.node_type == 5
        @emitter_sub_header = EmitterHeader.new(@_io, self, @_root)
      end
      if header.node_type == 17
        @reference_sub_header = ReferenceHeader.new(@_io, self, @_root)
      end
      if header.node_type == 33
        @trimesh_sub_header = TrimeshHeader.new(@_io, self, @_root)
      end
      if header.node_type == 97
        @skinmesh_sub_header = SkinmeshHeader.new(@_io, self, @_root)
      end
      if header.node_type == 161
        @animmesh_sub_header = AnimmeshHeader.new(@_io, self, @_root)
      end
      if header.node_type == 289
        @danglymesh_sub_header = DanglymeshHeader.new(@_io, self, @_root)
      end
      if header.node_type == 545
        @aabb_sub_header = AabbHeader.new(@_io, self, @_root)
      end
      if header.node_type == 2081
        @lightsaber_sub_header = LightsaberHeader.new(@_io, self, @_root)
      end
      self
    end
    attr_reader :header
    attr_reader :light_sub_header
    attr_reader :emitter_sub_header
    attr_reader :reference_sub_header
    attr_reader :trimesh_sub_header
    attr_reader :skinmesh_sub_header
    attr_reader :animmesh_sub_header
    attr_reader :danglymesh_sub_header
    attr_reader :aabb_sub_header
    attr_reader :lightsaber_sub_header
  end

  ##
  # Node header (80 bytes) - present in all node types
  class NodeHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @node_type = @_io.read_u2le
      @node_index = @_io.read_u2le
      @node_name_index = @_io.read_u2le
      @padding = @_io.read_u2le
      @root_node_offset = @_io.read_u4le
      @parent_node_offset = @_io.read_u4le
      @position = Vec3f.new(@_io, self, @_root)
      @orientation = Quaternion.new(@_io, self, @_root)
      @child_array_offset = @_io.read_u4le
      @child_count = @_io.read_u4le
      @child_count_duplicate = @_io.read_u4le
      @controller_array_offset = @_io.read_u4le
      @controller_count = @_io.read_u4le
      @controller_count_duplicate = @_io.read_u4le
      @controller_data_offset = @_io.read_u4le
      @controller_data_count = @_io.read_u4le
      @controller_data_count_duplicate = @_io.read_u4le
      self
    end
    def has_aabb
      return @has_aabb unless @has_aabb.nil?
      @has_aabb = node_type & 512 != 0
      @has_aabb
    end
    def has_anim
      return @has_anim unless @has_anim.nil?
      @has_anim = node_type & 128 != 0
      @has_anim
    end
    def has_dangly
      return @has_dangly unless @has_dangly.nil?
      @has_dangly = node_type & 256 != 0
      @has_dangly
    end
    def has_emitter
      return @has_emitter unless @has_emitter.nil?
      @has_emitter = node_type & 4 != 0
      @has_emitter
    end
    def has_light
      return @has_light unless @has_light.nil?
      @has_light = node_type & 2 != 0
      @has_light
    end
    def has_mesh
      return @has_mesh unless @has_mesh.nil?
      @has_mesh = node_type & 32 != 0
      @has_mesh
    end
    def has_reference
      return @has_reference unless @has_reference.nil?
      @has_reference = node_type & 16 != 0
      @has_reference
    end
    def has_saber
      return @has_saber unless @has_saber.nil?
      @has_saber = node_type & 2048 != 0
      @has_saber
    end
    def has_skin
      return @has_skin unless @has_skin.nil?
      @has_skin = node_type & 64 != 0
      @has_skin
    end

    ##
    # Bitmask indicating node features (also carries the primary node kind in the composite values listed in
    # `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
    # - 0x0001: NODE_HAS_HEADER
    # - 0x0002: NODE_HAS_LIGHT
    # - 0x0004: NODE_HAS_EMITTER
    # - 0x0008: NODE_HAS_CAMERA
    # - 0x0010: NODE_HAS_REFERENCE
    # - 0x0020: NODE_HAS_MESH
    # - 0x0040: NODE_HAS_SKIN
    # - 0x0080: NODE_HAS_ANIM
    # - 0x0100: NODE_HAS_DANGLY
    # - 0x0200: NODE_HAS_AABB
    # - 0x0800: NODE_HAS_SABER
    attr_reader :node_type

    ##
    # Sequential index of this node in the model
    attr_reader :node_index

    ##
    # Index into names array for this node's name
    attr_reader :node_name_index

    ##
    # Padding for alignment
    attr_reader :padding

    ##
    # Offset to model's root node
    attr_reader :root_node_offset

    ##
    # Offset to this node's parent node (0 if root)
    attr_reader :parent_node_offset

    ##
    # Node position in local space (X, Y, Z)
    attr_reader :position

    ##
    # Node orientation as quaternion (W, X, Y, Z)
    attr_reader :orientation

    ##
    # Offset to array of child node offsets
    attr_reader :child_array_offset

    ##
    # Number of child nodes
    attr_reader :child_count

    ##
    # Duplicate value of child count
    attr_reader :child_count_duplicate

    ##
    # Offset to array of controller structures
    attr_reader :controller_array_offset

    ##
    # Number of controllers attached to this node
    attr_reader :controller_count

    ##
    # Duplicate value of controller count
    attr_reader :controller_count_duplicate

    ##
    # Offset to controller keyframe/data array
    attr_reader :controller_data_offset

    ##
    # Number of floats in controller data array
    attr_reader :controller_data_count

    ##
    # Duplicate value of controller data count
    attr_reader :controller_data_count_duplicate
  end

  ##
  # Quaternion rotation (4 floats W, X, Y, Z)
  class Quaternion < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @w = @_io.read_f4le
      @x = @_io.read_f4le
      @y = @_io.read_f4le
      @z = @_io.read_f4le
      self
    end
    attr_reader :w
    attr_reader :x
    attr_reader :y
    attr_reader :z
  end

  ##
  # Reference header (36 bytes)
  class ReferenceHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @model_resref = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @reattachable = @_io.read_u4le
      self
    end

    ##
    # Referenced model resource name without extension (null-terminated string)
    attr_reader :model_resref

    ##
    # 1 if model can be detached and reattached dynamically, 0 if permanent
    attr_reader :reattachable
  end

  ##
  # Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
  class SkinmeshHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @trimesh_base = TrimeshHeader.new(@_io, self, @_root)
      @unknown_weights = @_io.read_s4le
      @padding1 = []
      (8).times { |i|
        @padding1 << @_io.read_u1
      }
      @mdx_bone_weights_offset = @_io.read_u4le
      @mdx_bone_indices_offset = @_io.read_u4le
      @bone_map_offset = @_io.read_u4le
      @bone_map_count = @_io.read_u4le
      @qbones_offset = @_io.read_u4le
      @qbones_count = @_io.read_u4le
      @qbones_count_duplicate = @_io.read_u4le
      @tbones_offset = @_io.read_u4le
      @tbones_count = @_io.read_u4le
      @tbones_count_duplicate = @_io.read_u4le
      @unknown_array = @_io.read_u4le
      @bone_node_serial_numbers = []
      (16).times { |i|
        @bone_node_serial_numbers << @_io.read_u2le
      }
      @padding2 = @_io.read_u2le
      self
    end

    ##
    # Standard trimesh header
    attr_reader :trimesh_base

    ##
    # Purpose unknown (possibly compilation weights)
    attr_reader :unknown_weights

    ##
    # Padding
    attr_reader :padding1

    ##
    # Offset to bone weight data in MDX file (4 floats per vertex)
    attr_reader :mdx_bone_weights_offset

    ##
    # Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
    attr_reader :mdx_bone_indices_offset

    ##
    # Offset to bone map array (maps local bone indices to skeleton bone numbers)
    attr_reader :bone_map_offset

    ##
    # Number of bones referenced by this mesh (max 16)
    attr_reader :bone_map_count

    ##
    # Offset to quaternion bind pose array (4 floats per bone)
    attr_reader :qbones_offset

    ##
    # Number of quaternion bind poses
    attr_reader :qbones_count

    ##
    # Duplicate of QBones count
    attr_reader :qbones_count_duplicate

    ##
    # Offset to translation bind pose array (3 floats per bone)
    attr_reader :tbones_offset

    ##
    # Number of translation bind poses
    attr_reader :tbones_count

    ##
    # Duplicate of TBones count
    attr_reader :tbones_count_duplicate

    ##
    # Purpose unknown
    attr_reader :unknown_array

    ##
    # Serial indices of bone nodes (0xFFFF for unused slots)
    attr_reader :bone_node_serial_numbers

    ##
    # Padding for alignment
    attr_reader :padding2
  end

  ##
  # Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
  class TrimeshHeader < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @function_pointer_0 = @_io.read_u4le
      @function_pointer_1 = @_io.read_u4le
      @faces_array_offset = @_io.read_u4le
      @faces_count = @_io.read_u4le
      @faces_count_duplicate = @_io.read_u4le
      @bounding_box_min = Vec3f.new(@_io, self, @_root)
      @bounding_box_max = Vec3f.new(@_io, self, @_root)
      @radius = @_io.read_f4le
      @average_point = Vec3f.new(@_io, self, @_root)
      @diffuse_color = Vec3f.new(@_io, self, @_root)
      @ambient_color = Vec3f.new(@_io, self, @_root)
      @transparency_hint = @_io.read_u4le
      @texture_0_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @texture_1_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(32), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @texture_2_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(12), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @texture_3_name = (Kaitai::Struct::Stream::bytes_terminate(@_io.read_bytes(12), 0, false)).force_encoding("ASCII").encode('UTF-8')
      @indices_count_array_offset = @_io.read_u4le
      @indices_count_array_count = @_io.read_u4le
      @indices_count_array_count_duplicate = @_io.read_u4le
      @indices_offset_array_offset = @_io.read_u4le
      @indices_offset_array_count = @_io.read_u4le
      @indices_offset_array_count_duplicate = @_io.read_u4le
      @inverted_counter_array_offset = @_io.read_u4le
      @inverted_counter_array_count = @_io.read_u4le
      @inverted_counter_array_count_duplicate = @_io.read_u4le
      @unknown_values = []
      (3).times { |i|
        @unknown_values << @_io.read_s4le
      }
      @saber_unknown_data = []
      (8).times { |i|
        @saber_unknown_data << @_io.read_u1
      }
      @unknown = @_io.read_u4le
      @uv_direction = Vec3f.new(@_io, self, @_root)
      @uv_jitter = @_io.read_f4le
      @uv_jitter_speed = @_io.read_f4le
      @mdx_vertex_size = @_io.read_u4le
      @mdx_data_flags = @_io.read_u4le
      @mdx_vertices_offset = @_io.read_s4le
      @mdx_normals_offset = @_io.read_s4le
      @mdx_vertex_colors_offset = @_io.read_s4le
      @mdx_tex0_uvs_offset = @_io.read_s4le
      @mdx_tex1_uvs_offset = @_io.read_s4le
      @mdx_tex2_uvs_offset = @_io.read_s4le
      @mdx_tex3_uvs_offset = @_io.read_s4le
      @mdx_tangent_space_offset = @_io.read_s4le
      @mdx_unknown_offset_1 = @_io.read_s4le
      @mdx_unknown_offset_2 = @_io.read_s4le
      @mdx_unknown_offset_3 = @_io.read_s4le
      @vertex_count = @_io.read_u2le
      @texture_count = @_io.read_u2le
      @lightmapped = @_io.read_u1
      @rotate_texture = @_io.read_u1
      @background_geometry = @_io.read_u1
      @shadow = @_io.read_u1
      @beaming = @_io.read_u1
      @render = @_io.read_u1
      @unknown_flag = @_io.read_u1
      @padding = @_io.read_u1
      @total_area = @_io.read_f4le
      @unknown2 = @_io.read_u4le
      if _root.model_header.geometry.is_kotor2
        @k2_unknown_1 = @_io.read_u4le
      end
      if _root.model_header.geometry.is_kotor2
        @k2_unknown_2 = @_io.read_u4le
      end
      @mdx_data_offset = @_io.read_u4le
      @mdl_vertices_offset = @_io.read_u4le
      self
    end

    ##
    # Game engine function pointer (version-specific)
    attr_reader :function_pointer_0

    ##
    # Secondary game engine function pointer
    attr_reader :function_pointer_1

    ##
    # Offset to face definitions array
    attr_reader :faces_array_offset

    ##
    # Number of triangular faces in mesh
    attr_reader :faces_count

    ##
    # Duplicate of faces count
    attr_reader :faces_count_duplicate

    ##
    # Minimum bounding box coordinates (X, Y, Z)
    attr_reader :bounding_box_min

    ##
    # Maximum bounding box coordinates (X, Y, Z)
    attr_reader :bounding_box_max

    ##
    # Bounding sphere radius
    attr_reader :radius

    ##
    # Average vertex position (centroid) X, Y, Z
    attr_reader :average_point

    ##
    # Material diffuse color (R, G, B, range 0.0-1.0)
    attr_reader :diffuse_color

    ##
    # Material ambient color (R, G, B, range 0.0-1.0)
    attr_reader :ambient_color

    ##
    # Transparency rendering mode
    attr_reader :transparency_hint

    ##
    # Primary diffuse texture name (null-terminated string)
    attr_reader :texture_0_name

    ##
    # Secondary texture name, often lightmap (null-terminated string)
    attr_reader :texture_1_name

    ##
    # Tertiary texture name (null-terminated string)
    attr_reader :texture_2_name

    ##
    # Quaternary texture name (null-terminated string)
    attr_reader :texture_3_name

    ##
    # Offset to vertex indices count array
    attr_reader :indices_count_array_offset

    ##
    # Number of entries in indices count array
    attr_reader :indices_count_array_count

    ##
    # Duplicate of indices count array count
    attr_reader :indices_count_array_count_duplicate

    ##
    # Offset to vertex indices offset array
    attr_reader :indices_offset_array_offset

    ##
    # Number of entries in indices offset array
    attr_reader :indices_offset_array_count

    ##
    # Duplicate of indices offset array count
    attr_reader :indices_offset_array_count_duplicate

    ##
    # Offset to inverted counter array
    attr_reader :inverted_counter_array_offset

    ##
    # Number of entries in inverted counter array
    attr_reader :inverted_counter_array_count

    ##
    # Duplicate of inverted counter array count
    attr_reader :inverted_counter_array_count_duplicate

    ##
    # Typically {-1, -1, 0}, purpose unknown
    attr_reader :unknown_values

    ##
    # Data specific to lightsaber meshes
    attr_reader :saber_unknown_data

    ##
    # Purpose unknown
    attr_reader :unknown

    ##
    # UV animation direction X, Y components (Z = jitter speed)
    attr_reader :uv_direction

    ##
    # UV animation jitter amount
    attr_reader :uv_jitter

    ##
    # UV animation jitter speed
    attr_reader :uv_jitter_speed

    ##
    # Size in bytes of each vertex in MDX data
    attr_reader :mdx_vertex_size

    ##
    # Bitmask of present vertex attributes:
    # - 0x00000001: MDX_VERTICES (vertex positions)
    # - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
    # - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
    # - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
    # - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
    # - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
    # - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
    # - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
    attr_reader :mdx_data_flags

    ##
    # Relative offset to vertex positions in MDX (or -1 if none)
    attr_reader :mdx_vertices_offset

    ##
    # Relative offset to vertex normals in MDX (or -1 if none)
    attr_reader :mdx_normals_offset

    ##
    # Relative offset to vertex colors in MDX (or -1 if none)
    attr_reader :mdx_vertex_colors_offset

    ##
    # Relative offset to primary texture UVs in MDX (or -1 if none)
    attr_reader :mdx_tex0_uvs_offset

    ##
    # Relative offset to secondary texture UVs in MDX (or -1 if none)
    attr_reader :mdx_tex1_uvs_offset

    ##
    # Relative offset to tertiary texture UVs in MDX (or -1 if none)
    attr_reader :mdx_tex2_uvs_offset

    ##
    # Relative offset to quaternary texture UVs in MDX (or -1 if none)
    attr_reader :mdx_tex3_uvs_offset

    ##
    # Relative offset to tangent space data in MDX (or -1 if none)
    attr_reader :mdx_tangent_space_offset

    ##
    # Relative offset to unknown MDX data (or -1 if none)
    attr_reader :mdx_unknown_offset_1

    ##
    # Relative offset to unknown MDX data (or -1 if none)
    attr_reader :mdx_unknown_offset_2

    ##
    # Relative offset to unknown MDX data (or -1 if none)
    attr_reader :mdx_unknown_offset_3

    ##
    # Number of vertices in mesh
    attr_reader :vertex_count

    ##
    # Number of textures used by mesh
    attr_reader :texture_count

    ##
    # 1 if mesh uses lightmap, 0 otherwise
    attr_reader :lightmapped

    ##
    # 1 if texture should rotate, 0 otherwise
    attr_reader :rotate_texture

    ##
    # 1 if background geometry, 0 otherwise
    attr_reader :background_geometry

    ##
    # 1 if mesh casts shadows, 0 otherwise
    attr_reader :shadow

    ##
    # 1 if beaming effect enabled, 0 otherwise
    attr_reader :beaming

    ##
    # 1 if mesh is renderable, 0 if hidden
    attr_reader :render

    ##
    # Purpose unknown (possibly UV animation enable)
    attr_reader :unknown_flag

    ##
    # Padding byte
    attr_reader :padding

    ##
    # Total surface area of all faces
    attr_reader :total_area

    ##
    # Purpose unknown
    attr_reader :unknown2

    ##
    # KOTOR 2 only: Additional unknown field
    attr_reader :k2_unknown_1

    ##
    # KOTOR 2 only: Additional unknown field
    attr_reader :k2_unknown_2

    ##
    # Absolute offset to this mesh's vertex data in MDX file
    attr_reader :mdx_data_offset

    ##
    # Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
    attr_reader :mdl_vertices_offset
  end

  ##
  # 3D vector (3 floats)
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
    attr_reader :x
    attr_reader :y
    attr_reader :z
  end

  ##
  # Animation header offsets (relative to data_start)
  def animation_offsets
    return @animation_offsets unless @animation_offsets.nil?
    if model_header.animation_count > 0
      _pos = @_io.pos
      @_io.seek(data_start + model_header.offset_to_animations)
      @animation_offsets = []
      (model_header.animation_count).times { |i|
        @animation_offsets << @_io.read_u4le
      }
      @_io.seek(_pos)
    end
    @animation_offsets
  end

  ##
  # Animation headers (via offset table). Each list element is `mdl_animation_entry`;
  # the parsed header is `element.header` (same wire layout as `animation_header`).
  def animations
    return @animations unless @animations.nil?
    if model_header.animation_count > 0
      @animations = []
      (model_header.animation_count).times { |i|
        @animations << MdlAnimationEntry.new(@_io, self, @_root, i)
      }
    end
    @animations
  end

  ##
  # MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
  # section, which begins immediately after the 12-byte file header.
  def data_start
    return @data_start unless @data_start.nil?
    @data_start = 12
    @data_start
  end

  ##
  # Name string offsets (relative to data_start)
  def name_offsets
    return @name_offsets unless @name_offsets.nil?
    if model_header.name_offsets_count > 0
      _pos = @_io.pos
      @_io.seek(data_start + model_header.offset_to_name_offsets)
      @name_offsets = []
      (model_header.name_offsets_count).times { |i|
        @name_offsets << @_io.read_u4le
      }
      @_io.seek(_pos)
    end
    @name_offsets
  end

  ##
  # Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
  # Parsed as null-terminated ASCII strings in `name_strings`.
  def names_data
    return @names_data unless @names_data.nil?
    if model_header.name_offsets_count > 0
      _pos = @_io.pos
      @_io.seek((data_start + model_header.offset_to_name_offsets) + 4 * model_header.name_offsets_count)
      _io_names_data = @_io.substream((data_start + model_header.offset_to_animations) - ((data_start + model_header.offset_to_name_offsets) + 4 * model_header.name_offsets_count))
      @names_data = NameStrings.new(_io_names_data, self, @_root)
      @_io.seek(_pos)
    end
    @names_data
  end
  def root_node
    return @root_node unless @root_node.nil?
    if model_header.geometry.root_node_offset > 0
      _pos = @_io.pos
      @_io.seek(data_start + model_header.geometry.root_node_offset)
      @root_node = Node.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @root_node
  end
  attr_reader :file_header
  attr_reader :model_header
  attr_reader :_raw_names_data
end

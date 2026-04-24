# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
# Used by modding tools for easier editing than binary MDL format.
# 
# The ASCII format represents the model structure using plain text with keyword-based syntax.
# Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
# 
# Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
# documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
# full binary-vs-text scope rule.
# 
# Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
# Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
# Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
# and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88 xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)
# @see https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format PyKotor wiki — ASCII MDL
# @see https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format PyKotor wiki — binary MDL (wire vs ASCII)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl
# @see https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)
# @see https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — readasciimdl
class MdlAscii < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @lines = []
    i = 0
    while not @_io.eof?
      @lines << AsciiLine.new(@_io, self, @_root)
      i += 1
    end
    self
  end

  ##
  # Animation section keywords
  class AnimationSection < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @newanim = LineText.new(@_io, self, @_root)
      @doneanim = LineText.new(@_io, self, @_root)
      @length = LineText.new(@_io, self, @_root)
      @transtime = LineText.new(@_io, self, @_root)
      @animroot = LineText.new(@_io, self, @_root)
      @event = LineText.new(@_io, self, @_root)
      @eventlist = LineText.new(@_io, self, @_root)
      @endlist = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # newanim <animation_name> <model_name> - Start of animation definition
    attr_reader :newanim

    ##
    # doneanim <animation_name> <model_name> - End of animation definition
    attr_reader :doneanim

    ##
    # length <duration> - Animation duration in seconds
    attr_reader :length

    ##
    # transtime <transition_time> - Transition/blend time to this animation in seconds
    attr_reader :transtime

    ##
    # animroot <root_node_name> - Root node name for animation
    attr_reader :animroot

    ##
    # event <time> <event_name> - Animation event (triggers at specified time)
    attr_reader :event

    ##
    # eventlist - Start of animation events list
    attr_reader :eventlist

    ##
    # endlist - End of list (controllers, events, etc.)
    attr_reader :endlist
  end

  ##
  # Single line in ASCII MDL file
  class AsciiLine < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @content = (@_io.read_bytes_term(10, false, true, false)).force_encoding("UTF-8")
      self
    end
    attr_reader :content
  end

  ##
  # Bezier (smooth animated) controller format
  class ControllerBezier < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @controller_name = LineText.new(@_io, self, @_root)
      @keyframes = []
      i = 0
      while not @_io.eof?
        @keyframes << ControllerBezierKeyframe.new(@_io, self, @_root)
        i += 1
      end
      self
    end

    ##
    # Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
    attr_reader :controller_name

    ##
    # Keyframe entries until endlist keyword
    attr_reader :keyframes
  end

  ##
  # Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
  class ControllerBezierKeyframe < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @time = (@_io.read_bytes_full).force_encoding("UTF-8")
      @value_data = (@_io.read_bytes_full).force_encoding("UTF-8")
      self
    end

    ##
    # Time value (float)
    attr_reader :time

    ##
    # Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
    attr_reader :value_data
  end

  ##
  # Keyed (animated) controller format
  class ControllerKeyed < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @controller_name = LineText.new(@_io, self, @_root)
      @keyframes = []
      i = 0
      while not @_io.eof?
        @keyframes << ControllerKeyframe.new(@_io, self, @_root)
        i += 1
      end
      self
    end

    ##
    # Controller name followed by 'key' (e.g., positionkey, orientationkey)
    attr_reader :controller_name

    ##
    # Keyframe entries until endlist keyword
    attr_reader :keyframes
  end

  ##
  # Single keyframe in keyed controller
  class ControllerKeyframe < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @time = (@_io.read_bytes_full).force_encoding("UTF-8")
      @values = (@_io.read_bytes_full).force_encoding("UTF-8")
      self
    end

    ##
    # Time value (float)
    attr_reader :time

    ##
    # Space-separated property values (number depends on controller type and column count)
    attr_reader :values
  end

  ##
  # Single (constant) controller format
  class ControllerSingle < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @controller_name = LineText.new(@_io, self, @_root)
      @values = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # Controller name (position, orientation, scale, color, radius, etc.)
    attr_reader :controller_name

    ##
    # Space-separated controller values (number depends on controller type)
    attr_reader :values
  end

  ##
  # Danglymesh node properties
  class DanglymeshProperties < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @displacement = LineText.new(@_io, self, @_root)
      @tightness = LineText.new(@_io, self, @_root)
      @period = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # displacement <value> - Maximum displacement distance for physics simulation
    attr_reader :displacement

    ##
    # tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
    attr_reader :tightness

    ##
    # period <value> - Oscillation period in seconds
    attr_reader :period
  end

  ##
  # Data array keywords
  class DataArrays < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @verts = LineText.new(@_io, self, @_root)
      @faces = LineText.new(@_io, self, @_root)
      @tverts = LineText.new(@_io, self, @_root)
      @tverts1 = LineText.new(@_io, self, @_root)
      @lightmaptverts = LineText.new(@_io, self, @_root)
      @tverts2 = LineText.new(@_io, self, @_root)
      @tverts3 = LineText.new(@_io, self, @_root)
      @texindices1 = LineText.new(@_io, self, @_root)
      @texindices2 = LineText.new(@_io, self, @_root)
      @texindices3 = LineText.new(@_io, self, @_root)
      @colors = LineText.new(@_io, self, @_root)
      @colorindices = LineText.new(@_io, self, @_root)
      @weights = LineText.new(@_io, self, @_root)
      @constraints = LineText.new(@_io, self, @_root)
      @aabb = LineText.new(@_io, self, @_root)
      @saber_verts = LineText.new(@_io, self, @_root)
      @saber_norms = LineText.new(@_io, self, @_root)
      @name = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
    attr_reader :verts

    ##
    # faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
    attr_reader :faces

    ##
    # tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
    attr_reader :tverts

    ##
    # tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
    attr_reader :tverts1

    ##
    # lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
    attr_reader :lightmaptverts

    ##
    # tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
    attr_reader :tverts2

    ##
    # tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
    attr_reader :tverts3

    ##
    # texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
    attr_reader :texindices1

    ##
    # texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
    attr_reader :texindices2

    ##
    # texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
    attr_reader :texindices3

    ##
    # colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
    attr_reader :colors

    ##
    # colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
    attr_reader :colorindices

    ##
    # weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
    attr_reader :weights

    ##
    # constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
    attr_reader :constraints

    ##
    # aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
    attr_reader :aabb

    ##
    # saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
    attr_reader :saber_verts

    ##
    # saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
    attr_reader :saber_norms

    ##
    # name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
    attr_reader :name
  end

  ##
  # Emitter behavior flags
  class EmitterFlags < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @p2p = LineText.new(@_io, self, @_root)
      @p2p_sel = LineText.new(@_io, self, @_root)
      @affected_by_wind = LineText.new(@_io, self, @_root)
      @m_is_tinted = LineText.new(@_io, self, @_root)
      @bounce = LineText.new(@_io, self, @_root)
      @random = LineText.new(@_io, self, @_root)
      @inherit = LineText.new(@_io, self, @_root)
      @inheritvel = LineText.new(@_io, self, @_root)
      @inherit_local = LineText.new(@_io, self, @_root)
      @splat = LineText.new(@_io, self, @_root)
      @inherit_part = LineText.new(@_io, self, @_root)
      @depth_texture = LineText.new(@_io, self, @_root)
      @emitterflag13 = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # p2p <0_or_1> - Point-to-point flag (bit 0x0001)
    attr_reader :p2p

    ##
    # p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
    attr_reader :p2p_sel

    ##
    # affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
    attr_reader :affected_by_wind

    ##
    # m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
    attr_reader :m_is_tinted

    ##
    # bounce <0_or_1> - Bounce flag (bit 0x0010)
    attr_reader :bounce

    ##
    # random <0_or_1> - Random flag (bit 0x0020)
    attr_reader :random

    ##
    # inherit <0_or_1> - Inherit flag (bit 0x0040)
    attr_reader :inherit

    ##
    # inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
    attr_reader :inheritvel

    ##
    # inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
    attr_reader :inherit_local

    ##
    # splat <0_or_1> - Splat flag (bit 0x0200)
    attr_reader :splat

    ##
    # inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
    attr_reader :inherit_part

    ##
    # depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
    attr_reader :depth_texture

    ##
    # emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
    attr_reader :emitterflag13
  end

  ##
  # Emitter node properties
  class EmitterProperties < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @deadspace = LineText.new(@_io, self, @_root)
      @blast_radius = LineText.new(@_io, self, @_root)
      @blast_length = LineText.new(@_io, self, @_root)
      @num_branches = LineText.new(@_io, self, @_root)
      @controlptsmoothing = LineText.new(@_io, self, @_root)
      @xgrid = LineText.new(@_io, self, @_root)
      @ygrid = LineText.new(@_io, self, @_root)
      @spawntype = LineText.new(@_io, self, @_root)
      @update = LineText.new(@_io, self, @_root)
      @render = LineText.new(@_io, self, @_root)
      @blend = LineText.new(@_io, self, @_root)
      @texture = LineText.new(@_io, self, @_root)
      @chunkname = LineText.new(@_io, self, @_root)
      @twosidedtex = LineText.new(@_io, self, @_root)
      @loop = LineText.new(@_io, self, @_root)
      @renderorder = LineText.new(@_io, self, @_root)
      @m_b_frame_blending = LineText.new(@_io, self, @_root)
      @m_s_depth_texture_name = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # deadspace <value> - Minimum distance from emitter before particles become visible
    attr_reader :deadspace

    ##
    # blastRadius <value> - Radius of explosive/blast particle effects
    attr_reader :blast_radius

    ##
    # blastLength <value> - Length/duration of blast effects
    attr_reader :blast_length

    ##
    # numBranches <value> - Number of branching paths for particle trails
    attr_reader :num_branches

    ##
    # controlptsmoothing <value> - Smoothing factor for particle path control points
    attr_reader :controlptsmoothing

    ##
    # xgrid <value> - Grid subdivisions along X axis for particle spawning
    attr_reader :xgrid

    ##
    # ygrid <value> - Grid subdivisions along Y axis for particle spawning
    attr_reader :ygrid

    ##
    # spawntype <value> - Particle spawn type
    attr_reader :spawntype

    ##
    # update <script_name> - Update behavior script name (e.g., single, fountain)
    attr_reader :update

    ##
    # render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
    attr_reader :render

    ##
    # blend <script_name> - Blend mode script name (e.g., normal, lighten)
    attr_reader :blend

    ##
    # texture <texture_name> - Particle texture name
    attr_reader :texture

    ##
    # chunkname <chunk_name> - Associated model chunk name
    attr_reader :chunkname

    ##
    # twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
    attr_reader :twosidedtex

    ##
    # loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
    attr_reader :loop

    ##
    # renderorder <value> - Rendering priority/order for particle sorting
    attr_reader :renderorder

    ##
    # m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
    attr_reader :m_b_frame_blending

    ##
    # m_sDepthTextureName <texture_name> - Depth/softparticle texture name
    attr_reader :m_s_depth_texture_name
  end

  ##
  # Light node properties
  class LightProperties < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @flareradius = LineText.new(@_io, self, @_root)
      @flarepositions = LineText.new(@_io, self, @_root)
      @flaresizes = LineText.new(@_io, self, @_root)
      @flarecolorshifts = LineText.new(@_io, self, @_root)
      @texturenames = LineText.new(@_io, self, @_root)
      @ambientonly = LineText.new(@_io, self, @_root)
      @ndynamictype = LineText.new(@_io, self, @_root)
      @affectdynamic = LineText.new(@_io, self, @_root)
      @flare = LineText.new(@_io, self, @_root)
      @lightpriority = LineText.new(@_io, self, @_root)
      @fadinglight = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # flareradius <value> - Radius of lens flare effect
    attr_reader :flareradius

    ##
    # flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
    attr_reader :flarepositions

    ##
    # flaresizes <count> - Start flare sizes array (count floats)
    attr_reader :flaresizes

    ##
    # flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
    attr_reader :flarecolorshifts

    ##
    # texturenames <count> - Start flare texture names array (count strings)
    attr_reader :texturenames

    ##
    # ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
    attr_reader :ambientonly

    ##
    # ndynamictype <value> - Type of dynamic lighting behavior
    attr_reader :ndynamictype

    ##
    # affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
    attr_reader :affectdynamic

    ##
    # flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
    attr_reader :flare

    ##
    # lightpriority <value> - Rendering priority for light culling/sorting
    attr_reader :lightpriority

    ##
    # fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
    attr_reader :fadinglight
  end

  ##
  # A single UTF-8 text line (without the trailing newline).
  # Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
  class LineText < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @value = (@_io.read_bytes_term(10, false, true, false)).force_encoding("UTF-8")
      self
    end
    attr_reader :value
  end

  ##
  # Reference node properties
  class ReferenceProperties < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @refmodel = LineText.new(@_io, self, @_root)
      @reattachable = LineText.new(@_io, self, @_root)
      self
    end

    ##
    # refmodel <model_resref> - Referenced model resource name without extension
    attr_reader :refmodel

    ##
    # reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
    attr_reader :reattachable
  end
  attr_reader :lines
end

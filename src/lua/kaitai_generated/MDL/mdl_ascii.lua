-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
local str_decode = require("string_decode")

-- 
-- MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
-- Used by modding tools for easier editing than binary MDL format.
-- 
-- The ASCII format represents the model structure using plain text with keyword-based syntax.
-- Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
-- 
-- Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
-- documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
-- full binary-vs-text scope rule.
-- 
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
-- Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
-- Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
-- and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).
-- See also: xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire) (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79)
-- See also: xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs) (https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88)
-- See also: PyKotor wiki — ASCII MDL (https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format)
-- See also: PyKotor wiki — binary MDL (wire vs ASCII) (https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format)
-- See also: xoreos-docs — Torlack binmdl (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html)
-- See also: In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords) (https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy)
-- See also: Community MDLOps — readasciimdl (https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698)
MdlAscii = class.class(KaitaiStruct)

function MdlAscii:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function MdlAscii:_read()
  self.lines = {}
  local i = 0
  while not self._io:is_eof() do
    self.lines[i + 1] = MdlAscii.AsciiLine(self._io, self, self._root)
    i = i + 1
  end
end


-- 
-- Animation section keywords.
MdlAscii.AnimationSection = class.class(KaitaiStruct)

function MdlAscii.AnimationSection:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.AnimationSection:_read()
  self.newanim = MdlAscii.LineText(self._io, self, self._root)
  self.doneanim = MdlAscii.LineText(self._io, self, self._root)
  self.length = MdlAscii.LineText(self._io, self, self._root)
  self.transtime = MdlAscii.LineText(self._io, self, self._root)
  self.animroot = MdlAscii.LineText(self._io, self, self._root)
  self.event = MdlAscii.LineText(self._io, self, self._root)
  self.eventlist = MdlAscii.LineText(self._io, self, self._root)
  self.endlist = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- newanim <animation_name> <model_name> - Start of animation definition.
-- 
-- doneanim <animation_name> <model_name> - End of animation definition.
-- 
-- length <duration> - Animation duration in seconds.
-- 
-- transtime <transition_time> - Transition/blend time to this animation in seconds.
-- 
-- animroot <root_node_name> - Root node name for animation.
-- 
-- event <time> <event_name> - Animation event (triggers at specified time).
-- 
-- eventlist - Start of animation events list.
-- 
-- endlist - End of list (controllers, events, etc.).

-- 
-- Single line in ASCII MDL file.
MdlAscii.AsciiLine = class.class(KaitaiStruct)

function MdlAscii.AsciiLine:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.AsciiLine:_read()
  self.content = str_decode.decode(self._io:read_bytes_term(10, false, true, false), "UTF-8")
end


-- 
-- Bezier (smooth animated) controller format.
MdlAscii.ControllerBezier = class.class(KaitaiStruct)

function MdlAscii.ControllerBezier:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ControllerBezier:_read()
  self.controller_name = MdlAscii.LineText(self._io, self, self._root)
  self.keyframes = {}
  local i = 0
  while not self._io:is_eof() do
    self.keyframes[i + 1] = MdlAscii.ControllerBezierKeyframe(self._io, self, self._root)
    i = i + 1
  end
end

-- 
-- Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey).
-- 
-- Keyframe entries until endlist keyword.

-- 
-- Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column).
MdlAscii.ControllerBezierKeyframe = class.class(KaitaiStruct)

function MdlAscii.ControllerBezierKeyframe:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ControllerBezierKeyframe:_read()
  self.time = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
  self.value_data = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
end

-- 
-- Time value (float).
-- 
-- Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column).

-- 
-- Keyed (animated) controller format.
MdlAscii.ControllerKeyed = class.class(KaitaiStruct)

function MdlAscii.ControllerKeyed:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ControllerKeyed:_read()
  self.controller_name = MdlAscii.LineText(self._io, self, self._root)
  self.keyframes = {}
  local i = 0
  while not self._io:is_eof() do
    self.keyframes[i + 1] = MdlAscii.ControllerKeyframe(self._io, self, self._root)
    i = i + 1
  end
end

-- 
-- Controller name followed by 'key' (e.g., positionkey, orientationkey).
-- 
-- Keyframe entries until endlist keyword.

-- 
-- Single keyframe in keyed controller.
MdlAscii.ControllerKeyframe = class.class(KaitaiStruct)

function MdlAscii.ControllerKeyframe:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ControllerKeyframe:_read()
  self.time = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
  self.values = str_decode.decode(self._io:read_bytes_full(), "UTF-8")
end

-- 
-- Time value (float).
-- 
-- Space-separated property values (number depends on controller type and column count).

-- 
-- Single (constant) controller format.
MdlAscii.ControllerSingle = class.class(KaitaiStruct)

function MdlAscii.ControllerSingle:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ControllerSingle:_read()
  self.controller_name = MdlAscii.LineText(self._io, self, self._root)
  self.values = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- Controller name (position, orientation, scale, color, radius, etc.).
-- 
-- Space-separated controller values (number depends on controller type).

-- 
-- Danglymesh node properties.
MdlAscii.DanglymeshProperties = class.class(KaitaiStruct)

function MdlAscii.DanglymeshProperties:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.DanglymeshProperties:_read()
  self.displacement = MdlAscii.LineText(self._io, self, self._root)
  self.tightness = MdlAscii.LineText(self._io, self, self._root)
  self.period = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- displacement <value> - Maximum displacement distance for physics simulation.
-- 
-- tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0).
-- 
-- period <value> - Oscillation period in seconds.

-- 
-- Data array keywords.
MdlAscii.DataArrays = class.class(KaitaiStruct)

function MdlAscii.DataArrays:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.DataArrays:_read()
  self.verts = MdlAscii.LineText(self._io, self, self._root)
  self.faces = MdlAscii.LineText(self._io, self, self._root)
  self.tverts = MdlAscii.LineText(self._io, self, self._root)
  self.tverts1 = MdlAscii.LineText(self._io, self, self._root)
  self.lightmaptverts = MdlAscii.LineText(self._io, self, self._root)
  self.tverts2 = MdlAscii.LineText(self._io, self, self._root)
  self.tverts3 = MdlAscii.LineText(self._io, self, self._root)
  self.texindices1 = MdlAscii.LineText(self._io, self, self._root)
  self.texindices2 = MdlAscii.LineText(self._io, self, self._root)
  self.texindices3 = MdlAscii.LineText(self._io, self, self._root)
  self.colors = MdlAscii.LineText(self._io, self, self._root)
  self.colorindices = MdlAscii.LineText(self._io, self, self._root)
  self.weights = MdlAscii.LineText(self._io, self, self._root)
  self.constraints = MdlAscii.LineText(self._io, self, self._root)
  self.aabb = MdlAscii.LineText(self._io, self, self._root)
  self.saber_verts = MdlAscii.LineText(self._io, self, self._root)
  self.saber_norms = MdlAscii.LineText(self._io, self, self._root)
  self.name = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z).
-- 
-- faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3]).
-- 
-- tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V).
-- 
-- tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V).
-- 
-- lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1).
-- 
-- tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V).
-- 
-- tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V).
-- 
-- texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face).
-- 
-- texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face).
-- 
-- texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face).
-- 
-- colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B).
-- 
-- colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face).
-- 
-- weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]]).
-- 
-- constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex).
-- 
-- aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line).
-- 
-- saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z).
-- 
-- saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z).
-- 
-- name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes).

-- 
-- Emitter behavior flags.
MdlAscii.EmitterFlags = class.class(KaitaiStruct)

function MdlAscii.EmitterFlags:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.EmitterFlags:_read()
  self.p2p = MdlAscii.LineText(self._io, self, self._root)
  self.p2p_sel = MdlAscii.LineText(self._io, self, self._root)
  self.affected_by_wind = MdlAscii.LineText(self._io, self, self._root)
  self.m_is_tinted = MdlAscii.LineText(self._io, self, self._root)
  self.bounce = MdlAscii.LineText(self._io, self, self._root)
  self.random = MdlAscii.LineText(self._io, self, self._root)
  self.inherit = MdlAscii.LineText(self._io, self, self._root)
  self.inheritvel = MdlAscii.LineText(self._io, self, self._root)
  self.inherit_local = MdlAscii.LineText(self._io, self, self._root)
  self.splat = MdlAscii.LineText(self._io, self, self._root)
  self.inherit_part = MdlAscii.LineText(self._io, self, self._root)
  self.depth_texture = MdlAscii.LineText(self._io, self, self._root)
  self.emitterflag13 = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- p2p <0_or_1> - Point-to-point flag (bit 0x0001).
-- 
-- p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002).
-- 
-- affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004).
-- 
-- m_isTinted <0_or_1> - Is tinted flag (bit 0x0008).
-- 
-- bounce <0_or_1> - Bounce flag (bit 0x0010).
-- 
-- random <0_or_1> - Random flag (bit 0x0020).
-- 
-- inherit <0_or_1> - Inherit flag (bit 0x0040).
-- 
-- inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080).
-- 
-- inherit_local <0_or_1> - Inherit local flag (bit 0x0100).
-- 
-- splat <0_or_1> - Splat flag (bit 0x0200).
-- 
-- inherit_part <0_or_1> - Inherit part flag (bit 0x0400).
-- 
-- depth_texture <0_or_1> - Depth texture flag (bit 0x0800).
-- 
-- emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000).

-- 
-- Emitter node properties.
MdlAscii.EmitterProperties = class.class(KaitaiStruct)

function MdlAscii.EmitterProperties:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.EmitterProperties:_read()
  self.deadspace = MdlAscii.LineText(self._io, self, self._root)
  self.blast_radius = MdlAscii.LineText(self._io, self, self._root)
  self.blast_length = MdlAscii.LineText(self._io, self, self._root)
  self.num_branches = MdlAscii.LineText(self._io, self, self._root)
  self.controlptsmoothing = MdlAscii.LineText(self._io, self, self._root)
  self.xgrid = MdlAscii.LineText(self._io, self, self._root)
  self.ygrid = MdlAscii.LineText(self._io, self, self._root)
  self.spawntype = MdlAscii.LineText(self._io, self, self._root)
  self.update = MdlAscii.LineText(self._io, self, self._root)
  self.render = MdlAscii.LineText(self._io, self, self._root)
  self.blend = MdlAscii.LineText(self._io, self, self._root)
  self.texture = MdlAscii.LineText(self._io, self, self._root)
  self.chunkname = MdlAscii.LineText(self._io, self, self._root)
  self.twosidedtex = MdlAscii.LineText(self._io, self, self._root)
  self.loop = MdlAscii.LineText(self._io, self, self._root)
  self.renderorder = MdlAscii.LineText(self._io, self, self._root)
  self.m_b_frame_blending = MdlAscii.LineText(self._io, self, self._root)
  self.m_s_depth_texture_name = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- deadspace <value> - Minimum distance from emitter before particles become visible.
-- 
-- blastRadius <value> - Radius of explosive/blast particle effects.
-- 
-- blastLength <value> - Length/duration of blast effects.
-- 
-- numBranches <value> - Number of branching paths for particle trails.
-- 
-- controlptsmoothing <value> - Smoothing factor for particle path control points.
-- 
-- xgrid <value> - Grid subdivisions along X axis for particle spawning.
-- 
-- ygrid <value> - Grid subdivisions along Y axis for particle spawning.
-- 
-- spawntype <value> - Particle spawn type.
-- 
-- update <script_name> - Update behavior script name (e.g., single, fountain).
-- 
-- render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z).
-- 
-- blend <script_name> - Blend mode script name (e.g., normal, lighten).
-- 
-- texture <texture_name> - Particle texture name.
-- 
-- chunkname <chunk_name> - Associated model chunk name.
-- 
-- twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided).
-- 
-- loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback).
-- 
-- renderorder <value> - Rendering priority/order for particle sorting.
-- 
-- m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled).
-- 
-- m_sDepthTextureName <texture_name> - Depth/softparticle texture name.

-- 
-- Light node properties.
MdlAscii.LightProperties = class.class(KaitaiStruct)

function MdlAscii.LightProperties:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.LightProperties:_read()
  self.flareradius = MdlAscii.LineText(self._io, self, self._root)
  self.flarepositions = MdlAscii.LineText(self._io, self, self._root)
  self.flaresizes = MdlAscii.LineText(self._io, self, self._root)
  self.flarecolorshifts = MdlAscii.LineText(self._io, self, self._root)
  self.texturenames = MdlAscii.LineText(self._io, self, self._root)
  self.ambientonly = MdlAscii.LineText(self._io, self, self._root)
  self.ndynamictype = MdlAscii.LineText(self._io, self, self._root)
  self.affectdynamic = MdlAscii.LineText(self._io, self, self._root)
  self.flare = MdlAscii.LineText(self._io, self, self._root)
  self.lightpriority = MdlAscii.LineText(self._io, self, self._root)
  self.fadinglight = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- flareradius <value> - Radius of lens flare effect.
-- 
-- flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray).
-- 
-- flaresizes <count> - Start flare sizes array (count floats).
-- 
-- flarecolorshifts <count> - Start flare color shifts array (count RGB floats).
-- 
-- texturenames <count> - Start flare texture names array (count strings).
-- 
-- ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting).
-- 
-- ndynamictype <value> - Type of dynamic lighting behavior.
-- 
-- affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only).
-- 
-- flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled).
-- 
-- lightpriority <value> - Rendering priority for light culling/sorting.
-- 
-- fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant).

-- 
-- A single UTF-8 text line (without the trailing newline).
-- Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
MdlAscii.LineText = class.class(KaitaiStruct)

function MdlAscii.LineText:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.LineText:_read()
  self.value = str_decode.decode(self._io:read_bytes_term(10, false, true, false), "UTF-8")
end


-- 
-- Reference node properties.
MdlAscii.ReferenceProperties = class.class(KaitaiStruct)

function MdlAscii.ReferenceProperties:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function MdlAscii.ReferenceProperties:_read()
  self.refmodel = MdlAscii.LineText(self._io, self, self._root)
  self.reattachable = MdlAscii.LineText(self._io, self, self._root)
end

-- 
-- refmodel <model_resref> - Referenced model resource name without extension.
-- 
-- reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent).


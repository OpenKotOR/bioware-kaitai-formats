-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
require("kaitaistruct")
require("bioware_mdl_common")
local stringstream = require("string_stream")
local str_decode = require("string_decode")

-- 
-- BioWare MDL Model Format
-- 
-- The MDL file contains:
-- - File header (12 bytes)
-- - Model header (196 bytes) which begins with a Geometry header (80 bytes)
-- - Name offset array + name strings
-- - Animation offset array + animation headers + animation nodes
-- - Node hierarchy with geometry data
-- 
-- Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.
-- 
-- Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.
-- 
-- Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
-- are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
-- compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
-- See also: In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`) (https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy)
-- See also: PyKotor wiki — MDL/MDX (https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format)
-- See also: PyKotor — MDLBinaryReader (binary MDL/MDX) (https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408)
-- See also: xoreos — Model_KotOR::load (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267)
-- See also: xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load) (https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79)
-- See also: xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool) (https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43)
-- See also: xoreos-docs — KotOR MDL overview (https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html)
-- See also: xoreos-docs — Torlack binmdl (controller / Aurora background) (https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html)
-- See also: reone — MdlMdxReader::load (https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118)
-- See also: KotOR.js — OdysseyModel binary constructor (https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170)
-- See also: Community MDLOps — controller name table (https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407)
-- See also: Community MDLOps — `readasciimdl` (ASCII MDL ingest) (https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698)
Mdl = class.class(KaitaiStruct)

function Mdl:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Mdl:_read()
  self.file_header = Mdl.FileHeader(self._io, self, self._root)
  self.model_header = Mdl.ModelHeader(self._io, self, self._root)
end

-- 
-- Animation header offsets (relative to data_start).
Mdl.property.animation_offsets = {}
function Mdl.property.animation_offsets:get()
  if self._m_animation_offsets ~= nil then
    return self._m_animation_offsets
  end

  if self.model_header.animation_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.data_start + self.model_header.offset_to_animations)
    self._m_animation_offsets = {}
    for i = 0, self.model_header.animation_count - 1 do
      self._m_animation_offsets[i + 1] = self._io:read_u4le()
    end
    self._io:seek(_pos)
  end
  return self._m_animation_offsets
end

-- 
-- Animation headers (via offset table). Each list element is `mdl_animation_entry`;
-- the parsed header is `element.header` (same wire layout as `animation_header`).
Mdl.property.animations = {}
function Mdl.property.animations:get()
  if self._m_animations ~= nil then
    return self._m_animations
  end

  if self.model_header.animation_count > 0 then
    self._m_animations = {}
    for i = 0, self.model_header.animation_count - 1 do
      self._m_animations[i + 1] = Mdl.MdlAnimationEntry(i, self._io, self, self._root)
    end
  end
  return self._m_animations
end

-- 
-- MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
-- section, which begins immediately after the 12-byte file header.
Mdl.property.data_start = {}
function Mdl.property.data_start:get()
  if self._m_data_start ~= nil then
    return self._m_data_start
  end

  self._m_data_start = 12
  return self._m_data_start
end

-- 
-- Name string offsets (relative to data_start).
Mdl.property.name_offsets = {}
function Mdl.property.name_offsets:get()
  if self._m_name_offsets ~= nil then
    return self._m_name_offsets
  end

  if self.model_header.name_offsets_count > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.data_start + self.model_header.offset_to_name_offsets)
    self._m_name_offsets = {}
    for i = 0, self.model_header.name_offsets_count - 1 do
      self._m_name_offsets[i + 1] = self._io:read_u4le()
    end
    self._io:seek(_pos)
  end
  return self._m_name_offsets
end

-- 
-- Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
-- Parsed as null-terminated ASCII strings in `name_strings`.
Mdl.property.names_data = {}
function Mdl.property.names_data:get()
  if self._m_names_data ~= nil then
    return self._m_names_data
  end

  if self.model_header.name_offsets_count > 0 then
    local _pos = self._io:pos()
    self._io:seek((self.data_start + self.model_header.offset_to_name_offsets) + 4 * self.model_header.name_offsets_count)
    self._raw__m_names_data = self._io:read_bytes((self.data_start + self.model_header.offset_to_animations) - ((self.data_start + self.model_header.offset_to_name_offsets) + 4 * self.model_header.name_offsets_count))
    local _io = KaitaiStream(stringstream(self._raw__m_names_data))
    self._m_names_data = Mdl.NameStrings(_io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_names_data
end

Mdl.property.root_node = {}
function Mdl.property.root_node:get()
  if self._m_root_node ~= nil then
    return self._m_root_node
  end

  if self.model_header.geometry.root_node_offset > 0 then
    local _pos = self._io:pos()
    self._io:seek(self.data_start + self.model_header.geometry.root_node_offset)
    self._m_root_node = Mdl.Node(self._io, self, self._root)
    self._io:seek(_pos)
  end
  return self._m_root_node
end


-- 
-- AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header.
Mdl.AabbHeader = class.class(KaitaiStruct)

function Mdl.AabbHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.AabbHeader:_read()
  self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
  self.unknown = self._io:read_u4le()
end

-- 
-- Standard trimesh header.
-- 
-- Purpose unknown.

-- 
-- Animation event (36 bytes).
Mdl.AnimationEvent = class.class(KaitaiStruct)

function Mdl.AnimationEvent:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.AnimationEvent:_read()
  self.activation_time = self._io:read_f4le()
  self.event_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
end

-- 
-- Time in seconds when event triggers during animation playback.
-- 
-- Name of event (null-terminated string, e.g., "detonate").

-- 
-- Animation header (136 bytes = 80 byte geometry header + 56 byte animation header).
Mdl.AnimationHeader = class.class(KaitaiStruct)

function Mdl.AnimationHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.AnimationHeader:_read()
  self.geo_header = Mdl.GeometryHeader(self._io, self, self._root)
  self.animation_length = self._io:read_f4le()
  self.transition_time = self._io:read_f4le()
  self.animation_root = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.event_array_offset = self._io:read_u4le()
  self.event_count = self._io:read_u4le()
  self.event_count_duplicate = self._io:read_u4le()
  self.unknown = self._io:read_u4le()
end

-- 
-- Standard 80-byte geometry header (geometry_type = 0x01 for animation).
-- 
-- Duration of animation in seconds.
-- 
-- Transition/blend time to this animation in seconds.
-- 
-- Root node name for animation (null-terminated string).
-- 
-- Offset to animation events array.
-- 
-- Number of animation events.
-- 
-- Duplicate value of event count.
-- 
-- Purpose unknown.

-- 
-- Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header.
Mdl.AnimmeshHeader = class.class(KaitaiStruct)

function Mdl.AnimmeshHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.AnimmeshHeader:_read()
  self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
  self.unknown = self._io:read_f4le()
  self.unknown_array = Mdl.ArrayDefinition(self._io, self, self._root)
  self.unknown_floats = {}
  for i = 0, 9 - 1 do
    self.unknown_floats[i + 1] = self._io:read_f4le()
  end
end

-- 
-- Standard trimesh header.
-- 
-- Purpose unknown.
-- 
-- Unknown array definition.
-- 
-- Unknown float values.

-- 
-- Array definition structure (offset, count, count duplicate).
Mdl.ArrayDefinition = class.class(KaitaiStruct)

function Mdl.ArrayDefinition:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.ArrayDefinition:_read()
  self.offset = self._io:read_s4le()
  self.count = self._io:read_u4le()
  self.count_duplicate = self._io:read_u4le()
end

-- 
-- Offset to array (relative to MDL data start, offset 12).
-- 
-- Number of used entries.
-- 
-- Duplicate of count (allocated entries).

-- 
-- Controller structure (16 bytes) - defines animation data for a node property over time.
Mdl.Controller = class.class(KaitaiStruct)

function Mdl.Controller:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.Controller:_read()
  self.type = BiowareMdlCommon.ControllerType(self._io:read_u4le())
  self.unknown = self._io:read_u2le()
  self.row_count = self._io:read_u2le()
  self.time_index = self._io:read_u2le()
  self.data_index = self._io:read_u2le()
  self.column_count = self._io:read_u1()
  self.padding = {}
  for i = 0, 3 - 1 do
    self.padding[i + 1] = self._io:read_u1()
  end
end

-- 
-- True if controller uses Bezier interpolation.
Mdl.Controller.property.uses_bezier = {}
function Mdl.Controller.property.uses_bezier:get()
  if self._m_uses_bezier ~= nil then
    return self._m_uses_bezier
  end

  self._m_uses_bezier = self.column_count & 16 ~= 0
  return self._m_uses_bezier
end

-- 
-- Controller type identifier. Controllers define animation data for node properties over time.
-- 
-- Common Node Controllers (used by all node types):
-- - 8: Position (3 floats: X, Y, Z translation)
-- - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
-- - 36: Scale (3 floats: X, Y, Z scale factors)
-- 
-- Light Controllers (specific to light nodes):
-- - 76: Color (light color, 3 floats: R, G, B)
-- - 88: Radius (light radius, 1 float)
-- - 96: Shadow Radius (shadow casting radius, 1 float)
-- - 100: Vertical Displacement (vertical offset, 1 float)
-- - 140: Multiplier (light intensity multiplier, 1 float)
-- 
-- Emitter Controllers (specific to emitter nodes):
-- - 80: Alpha End (final alpha value, 1 float)
-- - 84: Alpha Start (initial alpha value, 1 float)
-- - 88: Birth Rate (particle spawn rate, 1 float)
-- - 92: Bounce Coefficient (particle bounce factor, 1 float)
-- - 96: Combine Time (particle combination timing, 1 float)
-- - 100: Drag (particle drag/resistance, 1 float)
-- - 104: FPS (frames per second, 1 float)
-- - 108: Frame End (ending frame number, 1 float)
-- - 112: Frame Start (starting frame number, 1 float)
-- - 116: Gravity (gravity force, 1 float)
-- - 120: Life Expectancy (particle lifetime, 1 float)
-- - 124: Mass (particle mass, 1 float)
-- - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
-- - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
-- - 136: Particle Rotation (particle rotation speed/angle, 1 float)
-- - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
-- - 144: Size Start (initial particle size, 1 float)
-- - 148: Size End (final particle size, 1 float)
-- - 152: Size Start Y (initial particle size Y component, 1 float)
-- - 156: Size End Y (final particle size Y component, 1 float)
-- - 160: Spread (particle spread angle, 1 float)
-- - 164: Threshold (threshold value, 1 float)
-- - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
-- - 172: X Size (particle X dimension size, 1 float)
-- - 176: Y Size (particle Y dimension size, 1 float)
-- - 180: Blur Length (motion blur length, 1 float)
-- - 184: Lightning Delay (lightning effect delay, 1 float)
-- - 188: Lightning Radius (lightning effect radius, 1 float)
-- - 192: Lightning Scale (lightning effect scale factor, 1 float)
-- - 196: Lightning Subdivide (lightning subdivision count, 1 float)
-- - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
-- - 216: Alpha Mid (mid-point alpha value, 1 float)
-- - 220: Percent Start (starting percentage, 1 float)
-- - 224: Percent Mid (mid-point percentage, 1 float)
-- - 228: Percent End (ending percentage, 1 float)
-- - 232: Size Mid (mid-point particle size, 1 float)
-- - 236: Size Mid Y (mid-point particle size Y component, 1 float)
-- - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
-- - 252: Target Size (target particle size, 1 float)
-- - 256: Number of Control Points (control point count, 1 float)
-- - 260: Control Point Radius (control point radius, 1 float)
-- - 264: Control Point Delay (control point delay timing, 1 float)
-- - 268: Tangent Spread (tangent spread angle, 1 float)
-- - 272: Tangent Length (tangent vector length, 1 float)
-- - 284: Color Mid (mid-point color, 3 floats: R, G, B)
-- - 380: Color End (final color, 3 floats: R, G, B)
-- - 392: Color Start (initial color, 3 floats: R, G, B)
-- - 502: Emitter Detonate (detonation trigger, 1 float)
-- 
-- Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
-- - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
-- - 128: Alpha (transparency/opacity, 1 float)
-- 
-- Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
-- Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
-- Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list
-- 
-- Purpose unknown, typically 0xFFFF.
-- 
-- Number of keyframe rows (timepoints) for this controller.
-- 
-- Index into controller data array where time values begin.
-- 
-- Index into controller data array where property values begin.
-- 
-- Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
-- If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
-- 
-- Padding bytes for 16-byte alignment.

-- 
-- Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header.
Mdl.DanglymeshHeader = class.class(KaitaiStruct)

function Mdl.DanglymeshHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.DanglymeshHeader:_read()
  self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
  self.constraints_offset = self._io:read_u4le()
  self.constraints_count = self._io:read_u4le()
  self.constraints_count_duplicate = self._io:read_u4le()
  self.displacement = self._io:read_f4le()
  self.tightness = self._io:read_f4le()
  self.period = self._io:read_f4le()
  self.unknown = self._io:read_u4le()
end

-- 
-- Standard trimesh header.
-- 
-- Offset to vertex constraint values array.
-- 
-- Number of vertex constraints (matches vertex count).
-- 
-- Duplicate of constraints count.
-- 
-- Maximum displacement distance for physics simulation.
-- 
-- Tightness/stiffness of spring simulation (0.0-1.0).
-- 
-- Oscillation period in seconds.
-- 
-- Purpose unknown.

-- 
-- Emitter header (224 bytes).
Mdl.EmitterHeader = class.class(KaitaiStruct)

function Mdl.EmitterHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.EmitterHeader:_read()
  self.dead_space = self._io:read_f4le()
  self.blast_radius = self._io:read_f4le()
  self.blast_length = self._io:read_f4le()
  self.branch_count = self._io:read_u4le()
  self.control_point_smoothing = self._io:read_f4le()
  self.x_grid = self._io:read_u4le()
  self.y_grid = self._io:read_u4le()
  self.padding_unknown = self._io:read_u4le()
  self.update_script = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.render_script = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.blend_script = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.texture_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.chunk_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.two_sided_texture = self._io:read_u4le()
  self.loop = self._io:read_u4le()
  self.render_order = self._io:read_u2le()
  self.frame_blending = self._io:read_u1()
  self.depth_texture_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.padding = self._io:read_u1()
  self.flags = self._io:read_u4le()
end

-- 
-- Minimum distance from emitter before particles become visible.
-- 
-- Radius of explosive/blast particle effects.
-- 
-- Length/duration of blast effects.
-- 
-- Number of branching paths for particle trails.
-- 
-- Smoothing factor for particle path control points.
-- 
-- Grid subdivisions along X axis for particle spawning.
-- 
-- Grid subdivisions along Y axis for particle spawning.
-- 
-- Purpose unknown or padding.
-- 
-- Update behavior script name (e.g., "single", "fountain").
-- 
-- Render mode script name (e.g., "normal", "billboard_to_local_z").
-- 
-- Blend mode script name (e.g., "normal", "lighten").
-- 
-- Particle texture name (null-terminated string).
-- 
-- Associated model chunk name (null-terminated string).
-- 
-- 1 if texture should render two-sided, 0 for single-sided.
-- 
-- 1 if particle system loops, 0 for single playback.
-- 
-- Rendering priority/order for particle sorting.
-- 
-- 1 if frame blending enabled, 0 otherwise.
-- 
-- Depth/softparticle texture name (null-terminated string).
-- 
-- Padding byte for alignment.
-- 
-- Emitter behavior flags bitmask (P2P, bounce, inherit, etc.).

-- 
-- MDL file header (12 bytes).
Mdl.FileHeader = class.class(KaitaiStruct)

function Mdl.FileHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.FileHeader:_read()
  self.unused = self._io:read_u4le()
  self.mdl_size = self._io:read_u4le()
  self.mdx_size = self._io:read_u4le()
end

-- 
-- Always 0.
-- 
-- Size of MDL file in bytes.
-- 
-- Size of MDX file in bytes.

-- 
-- Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC).
Mdl.GeometryHeader = class.class(KaitaiStruct)

function Mdl.GeometryHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.GeometryHeader:_read()
  self.function_pointer_0 = self._io:read_u4le()
  self.function_pointer_1 = self._io:read_u4le()
  self.model_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.root_node_offset = self._io:read_u4le()
  self.node_count = self._io:read_u4le()
  self.unknown_array_1 = Mdl.ArrayDefinition(self._io, self, self._root)
  self.unknown_array_2 = Mdl.ArrayDefinition(self._io, self, self._root)
  self.reference_count = self._io:read_u4le()
  self.geometry_type = self._io:read_u1()
  self.padding = {}
  for i = 0, 3 - 1 do
    self.padding[i + 1] = self._io:read_u1()
  end
end

-- 
-- True if this is a KOTOR 2 model.
Mdl.GeometryHeader.property.is_kotor2 = {}
function Mdl.GeometryHeader.property.is_kotor2:get()
  if self._m_is_kotor2 ~= nil then
    return self._m_is_kotor2
  end

  self._m_is_kotor2 =  ((self.function_pointer_0 == 4285200) or (self.function_pointer_0 == 4285872)) 
  return self._m_is_kotor2
end

-- 
-- Game engine version identifier:
-- - KOTOR 1 PC: 4273776 (0x413670)
-- - KOTOR 2 PC: 4285200 (0x416310)
-- - KOTOR 1 Xbox: 4254992 (0x40ED10)
-- - KOTOR 2 Xbox: 4285872 (0x4165B0)
-- 
-- Function pointer to ASCII model parser.
-- 
-- Model name, null-terminated string, max 32 (0x20) bytes.
-- 
-- Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes.
-- 
-- Total number of nodes in model hierarchy, unsigned 32-bit integer.
-- 
-- Unknown array definition (offset, count, count duplicate).
-- 
-- Unknown array definition (offset, count, count duplicate).
-- 
-- Reference count (initialized to 0, incremented when model is referenced).
-- 
-- Geometry type:
-- - 0x01: Basic geometry header (not in models)
-- - 0x02: Model geometry header
-- - 0x05: Animation geometry header
-- If bit 7 (0x80) is set, model is compiled binary with absolute addresses
-- 
-- Padding bytes for alignment.

-- 
-- Light header (92 bytes).
Mdl.LightHeader = class.class(KaitaiStruct)

function Mdl.LightHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.LightHeader:_read()
  self.unknown = {}
  for i = 0, 4 - 1 do
    self.unknown[i + 1] = self._io:read_f4le()
  end
  self.flare_sizes_offset = self._io:read_u4le()
  self.flare_sizes_count = self._io:read_u4le()
  self.flare_sizes_count_duplicate = self._io:read_u4le()
  self.flare_positions_offset = self._io:read_u4le()
  self.flare_positions_count = self._io:read_u4le()
  self.flare_positions_count_duplicate = self._io:read_u4le()
  self.flare_color_shifts_offset = self._io:read_u4le()
  self.flare_color_shifts_count = self._io:read_u4le()
  self.flare_color_shifts_count_duplicate = self._io:read_u4le()
  self.flare_texture_names_offset = self._io:read_u4le()
  self.flare_texture_names_count = self._io:read_u4le()
  self.flare_texture_names_count_duplicate = self._io:read_u4le()
  self.flare_radius = self._io:read_f4le()
  self.light_priority = self._io:read_u4le()
  self.ambient_only = self._io:read_u4le()
  self.dynamic_type = self._io:read_u4le()
  self.affect_dynamic = self._io:read_u4le()
  self.shadow = self._io:read_u4le()
  self.flare = self._io:read_u4le()
  self.fading_light = self._io:read_u4le()
end

-- 
-- Purpose unknown, possibly padding or reserved values.
-- 
-- Offset to flare sizes array (floats).
-- 
-- Number of flare size entries.
-- 
-- Duplicate of flare sizes count.
-- 
-- Offset to flare positions array (floats, 0.0-1.0 along light ray).
-- 
-- Number of flare position entries.
-- 
-- Duplicate of flare positions count.
-- 
-- Offset to flare color shift array (RGB floats).
-- 
-- Number of flare color shift entries.
-- 
-- Duplicate of flare color shifts count.
-- 
-- Offset to flare texture name string offsets array.
-- 
-- Number of flare texture names.
-- 
-- Duplicate of flare texture names count.
-- 
-- Radius of flare effect.
-- 
-- Rendering priority for light culling/sorting.
-- 
-- 1 if light only affects ambient, 0 for full lighting.
-- 
-- Type of dynamic lighting behavior.
-- 
-- 1 if light affects dynamic objects, 0 otherwise.
-- 
-- 1 if light casts shadows, 0 otherwise.
-- 
-- 1 if lens flare effect enabled, 0 otherwise.
-- 
-- 1 if light intensity fades with distance, 0 otherwise.

-- 
-- Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header.
Mdl.LightsaberHeader = class.class(KaitaiStruct)

function Mdl.LightsaberHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.LightsaberHeader:_read()
  self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
  self.vertices_offset = self._io:read_u4le()
  self.texcoords_offset = self._io:read_u4le()
  self.normals_offset = self._io:read_u4le()
  self.unknown1 = self._io:read_u4le()
  self.unknown2 = self._io:read_u4le()
end

-- 
-- Standard trimesh header.
-- 
-- Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces).
-- 
-- Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20).
-- 
-- Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20).
-- 
-- Purpose unknown.
-- 
-- Purpose unknown.

-- 
-- One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
-- Wraps the header so repeated root instances can use parametric types (user guide).
Mdl.MdlAnimationEntry = class.class(KaitaiStruct)

function Mdl.MdlAnimationEntry:_init(anim_index, io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self.anim_index = anim_index
  self:_read()
end

function Mdl.MdlAnimationEntry:_read()
end

Mdl.MdlAnimationEntry.property.header = {}
function Mdl.MdlAnimationEntry.property.header:get()
  if self._m_header ~= nil then
    return self._m_header
  end

  local _pos = self._io:pos()
  self._io:seek(self._root.data_start + self._root.animation_offsets[self.anim_index + 1])
  self._m_header = Mdl.AnimationHeader(self._io, self, self._root)
  self._io:seek(_pos)
  return self._m_header
end


-- 
-- Model header (196 bytes) starting at offset 12 (data_start).
-- This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
-- model-wide metadata, offsets, and counts.
Mdl.ModelHeader = class.class(KaitaiStruct)

function Mdl.ModelHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.ModelHeader:_read()
  self.geometry = Mdl.GeometryHeader(self._io, self, self._root)
  self.model_type = BiowareMdlCommon.ModelClassification(self._io:read_u1())
  self.unknown0 = self._io:read_u1()
  self.padding0 = self._io:read_u1()
  self.fog = self._io:read_u1()
  self.unknown1 = self._io:read_u4le()
  self.offset_to_animations = self._io:read_u4le()
  self.animation_count = self._io:read_u4le()
  self.animation_count2 = self._io:read_u4le()
  self.unknown2 = self._io:read_u4le()
  self.bounding_box_min = Mdl.Vec3f(self._io, self, self._root)
  self.bounding_box_max = Mdl.Vec3f(self._io, self, self._root)
  self.radius = self._io:read_f4le()
  self.animation_scale = self._io:read_f4le()
  self.supermodel_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.offset_to_super_root = self._io:read_u4le()
  self.unknown3 = self._io:read_u4le()
  self.mdx_data_size = self._io:read_u4le()
  self.mdx_data_offset = self._io:read_u4le()
  self.offset_to_name_offsets = self._io:read_u4le()
  self.name_offsets_count = self._io:read_u4le()
  self.name_offsets_count2 = self._io:read_u4le()
end

-- 
-- Geometry header (80 bytes).
-- 
-- Model classification byte.
-- 
-- TODO: VERIFY - unknown field (MDLOps / PyKotor preserve).
-- 
-- Padding byte.
-- 
-- Fog interaction (1 = affected, 0 = ignore fog).
-- 
-- TODO: VERIFY - unknown field (MDLOps / PyKotor preserve).
-- 
-- Offset to animation offset array (relative to data_start).
-- 
-- Number of animations.
-- 
-- Duplicate animation count / allocated count.
-- 
-- TODO: VERIFY - unknown field (MDLOps / PyKotor preserve).
-- 
-- Minimum coordinates of bounding box (X, Y, Z).
-- 
-- Maximum coordinates of bounding box (X, Y, Z).
-- 
-- Radius of model's bounding sphere.
-- 
-- Scale factor for animations (typically 1.0).
-- 
-- Name of supermodel (null-terminated string, "null" if empty).
-- 
-- TODO: VERIFY - offset to super-root node (relative to data_start).
-- 
-- TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve).
-- 
-- Size of MDX file data in bytes.
-- 
-- Offset to MDX data (typically 0).
-- 
-- Offset to name offset array (relative to data_start).
-- 
-- Count of name offsets / partnames.
-- 
-- Duplicate name offsets count / allocated count.

-- 
-- Array of null-terminated name strings.
Mdl.NameStrings = class.class(KaitaiStruct)

function Mdl.NameStrings:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.NameStrings:_read()
  self.strings = {}
  local i = 0
  while not self._io:is_eof() do
    self.strings[i + 1] = str_decode.decode(self._io:read_bytes_term(0, false, true, true), "ASCII")
    i = i + 1
  end
end


-- 
-- Node structure - starts with 80-byte header, followed by type-specific sub-header.
Mdl.Node = class.class(KaitaiStruct)

function Mdl.Node:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.Node:_read()
  self.header = Mdl.NodeHeader(self._io, self, self._root)
  if self.header.node_type == 3 then
    self.light_sub_header = Mdl.LightHeader(self._io, self, self._root)
  end
  if self.header.node_type == 5 then
    self.emitter_sub_header = Mdl.EmitterHeader(self._io, self, self._root)
  end
  if self.header.node_type == 17 then
    self.reference_sub_header = Mdl.ReferenceHeader(self._io, self, self._root)
  end
  if self.header.node_type == 33 then
    self.trimesh_sub_header = Mdl.TrimeshHeader(self._io, self, self._root)
  end
  if self.header.node_type == 97 then
    self.skinmesh_sub_header = Mdl.SkinmeshHeader(self._io, self, self._root)
  end
  if self.header.node_type == 161 then
    self.animmesh_sub_header = Mdl.AnimmeshHeader(self._io, self, self._root)
  end
  if self.header.node_type == 289 then
    self.danglymesh_sub_header = Mdl.DanglymeshHeader(self._io, self, self._root)
  end
  if self.header.node_type == 545 then
    self.aabb_sub_header = Mdl.AabbHeader(self._io, self, self._root)
  end
  if self.header.node_type == 2081 then
    self.lightsaber_sub_header = Mdl.LightsaberHeader(self._io, self, self._root)
  end
end


-- 
-- Node header (80 bytes) - present in all node types.
Mdl.NodeHeader = class.class(KaitaiStruct)

function Mdl.NodeHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.NodeHeader:_read()
  self.node_type = self._io:read_u2le()
  self.node_index = self._io:read_u2le()
  self.node_name_index = self._io:read_u2le()
  self.padding = self._io:read_u2le()
  self.root_node_offset = self._io:read_u4le()
  self.parent_node_offset = self._io:read_u4le()
  self.position = Mdl.Vec3f(self._io, self, self._root)
  self.orientation = Mdl.Quaternion(self._io, self, self._root)
  self.child_array_offset = self._io:read_u4le()
  self.child_count = self._io:read_u4le()
  self.child_count_duplicate = self._io:read_u4le()
  self.controller_array_offset = self._io:read_u4le()
  self.controller_count = self._io:read_u4le()
  self.controller_count_duplicate = self._io:read_u4le()
  self.controller_data_offset = self._io:read_u4le()
  self.controller_data_count = self._io:read_u4le()
  self.controller_data_count_duplicate = self._io:read_u4le()
end

Mdl.NodeHeader.property.has_aabb = {}
function Mdl.NodeHeader.property.has_aabb:get()
  if self._m_has_aabb ~= nil then
    return self._m_has_aabb
  end

  self._m_has_aabb = self.node_type & 512 ~= 0
  return self._m_has_aabb
end

Mdl.NodeHeader.property.has_anim = {}
function Mdl.NodeHeader.property.has_anim:get()
  if self._m_has_anim ~= nil then
    return self._m_has_anim
  end

  self._m_has_anim = self.node_type & 128 ~= 0
  return self._m_has_anim
end

Mdl.NodeHeader.property.has_dangly = {}
function Mdl.NodeHeader.property.has_dangly:get()
  if self._m_has_dangly ~= nil then
    return self._m_has_dangly
  end

  self._m_has_dangly = self.node_type & 256 ~= 0
  return self._m_has_dangly
end

Mdl.NodeHeader.property.has_emitter = {}
function Mdl.NodeHeader.property.has_emitter:get()
  if self._m_has_emitter ~= nil then
    return self._m_has_emitter
  end

  self._m_has_emitter = self.node_type & 4 ~= 0
  return self._m_has_emitter
end

Mdl.NodeHeader.property.has_light = {}
function Mdl.NodeHeader.property.has_light:get()
  if self._m_has_light ~= nil then
    return self._m_has_light
  end

  self._m_has_light = self.node_type & 2 ~= 0
  return self._m_has_light
end

Mdl.NodeHeader.property.has_mesh = {}
function Mdl.NodeHeader.property.has_mesh:get()
  if self._m_has_mesh ~= nil then
    return self._m_has_mesh
  end

  self._m_has_mesh = self.node_type & 32 ~= 0
  return self._m_has_mesh
end

Mdl.NodeHeader.property.has_reference = {}
function Mdl.NodeHeader.property.has_reference:get()
  if self._m_has_reference ~= nil then
    return self._m_has_reference
  end

  self._m_has_reference = self.node_type & 16 ~= 0
  return self._m_has_reference
end

Mdl.NodeHeader.property.has_saber = {}
function Mdl.NodeHeader.property.has_saber:get()
  if self._m_has_saber ~= nil then
    return self._m_has_saber
  end

  self._m_has_saber = self.node_type & 2048 ~= 0
  return self._m_has_saber
end

Mdl.NodeHeader.property.has_skin = {}
function Mdl.NodeHeader.property.has_skin:get()
  if self._m_has_skin ~= nil then
    return self._m_has_skin
  end

  self._m_has_skin = self.node_type & 64 ~= 0
  return self._m_has_skin
end

-- 
-- Bitmask indicating node features (also carries the primary node kind in the composite values listed in
-- `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
-- - 0x0001: NODE_HAS_HEADER
-- - 0x0002: NODE_HAS_LIGHT
-- - 0x0004: NODE_HAS_EMITTER
-- - 0x0008: NODE_HAS_CAMERA
-- - 0x0010: NODE_HAS_REFERENCE
-- - 0x0020: NODE_HAS_MESH
-- - 0x0040: NODE_HAS_SKIN
-- - 0x0080: NODE_HAS_ANIM
-- - 0x0100: NODE_HAS_DANGLY
-- - 0x0200: NODE_HAS_AABB
-- - 0x0800: NODE_HAS_SABER
-- 
-- Sequential index of this node in the model.
-- 
-- Index into names array for this node's name.
-- 
-- Padding for alignment.
-- 
-- Offset to model's root node.
-- 
-- Offset to this node's parent node (0 if root).
-- 
-- Node position in local space (X, Y, Z).
-- 
-- Node orientation as quaternion (W, X, Y, Z).
-- 
-- Offset to array of child node offsets.
-- 
-- Number of child nodes.
-- 
-- Duplicate value of child count.
-- 
-- Offset to array of controller structures.
-- 
-- Number of controllers attached to this node.
-- 
-- Duplicate value of controller count.
-- 
-- Offset to controller keyframe/data array.
-- 
-- Number of floats in controller data array.
-- 
-- Duplicate value of controller data count.

-- 
-- Quaternion rotation (4 floats W, X, Y, Z).
Mdl.Quaternion = class.class(KaitaiStruct)

function Mdl.Quaternion:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.Quaternion:_read()
  self.w = self._io:read_f4le()
  self.x = self._io:read_f4le()
  self.y = self._io:read_f4le()
  self.z = self._io:read_f4le()
end


-- 
-- Reference header (36 bytes).
Mdl.ReferenceHeader = class.class(KaitaiStruct)

function Mdl.ReferenceHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.ReferenceHeader:_read()
  self.model_resref = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.reattachable = self._io:read_u4le()
end

-- 
-- Referenced model resource name without extension (null-terminated string).
-- 
-- 1 if model can be detached and reattached dynamically, 0 if permanent.

-- 
-- Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header.
Mdl.SkinmeshHeader = class.class(KaitaiStruct)

function Mdl.SkinmeshHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.SkinmeshHeader:_read()
  self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
  self.unknown_weights = self._io:read_s4le()
  self.padding1 = {}
  for i = 0, 8 - 1 do
    self.padding1[i + 1] = self._io:read_u1()
  end
  self.mdx_bone_weights_offset = self._io:read_u4le()
  self.mdx_bone_indices_offset = self._io:read_u4le()
  self.bone_map_offset = self._io:read_u4le()
  self.bone_map_count = self._io:read_u4le()
  self.qbones_offset = self._io:read_u4le()
  self.qbones_count = self._io:read_u4le()
  self.qbones_count_duplicate = self._io:read_u4le()
  self.tbones_offset = self._io:read_u4le()
  self.tbones_count = self._io:read_u4le()
  self.tbones_count_duplicate = self._io:read_u4le()
  self.unknown_array = self._io:read_u4le()
  self.bone_node_serial_numbers = {}
  for i = 0, 16 - 1 do
    self.bone_node_serial_numbers[i + 1] = self._io:read_u2le()
  end
  self.padding2 = self._io:read_u2le()
end

-- 
-- Standard trimesh header.
-- 
-- Purpose unknown (possibly compilation weights).
-- 
-- Padding.
-- 
-- Offset to bone weight data in MDX file (4 floats per vertex).
-- 
-- Offset to bone index data in MDX file (4 floats per vertex, cast to uint16).
-- 
-- Offset to bone map array (maps local bone indices to skeleton bone numbers).
-- 
-- Number of bones referenced by this mesh (max 16).
-- 
-- Offset to quaternion bind pose array (4 floats per bone).
-- 
-- Number of quaternion bind poses.
-- 
-- Duplicate of QBones count.
-- 
-- Offset to translation bind pose array (3 floats per bone).
-- 
-- Number of translation bind poses.
-- 
-- Duplicate of TBones count.
-- 
-- Purpose unknown.
-- 
-- Serial indices of bone nodes (0xFFFF for unused slots).
-- 
-- Padding for alignment.

-- 
-- Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2).
Mdl.TrimeshHeader = class.class(KaitaiStruct)

function Mdl.TrimeshHeader:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.TrimeshHeader:_read()
  self.function_pointer_0 = self._io:read_u4le()
  self.function_pointer_1 = self._io:read_u4le()
  self.faces_array_offset = self._io:read_u4le()
  self.faces_count = self._io:read_u4le()
  self.faces_count_duplicate = self._io:read_u4le()
  self.bounding_box_min = Mdl.Vec3f(self._io, self, self._root)
  self.bounding_box_max = Mdl.Vec3f(self._io, self, self._root)
  self.radius = self._io:read_f4le()
  self.average_point = Mdl.Vec3f(self._io, self, self._root)
  self.diffuse_color = Mdl.Vec3f(self._io, self, self._root)
  self.ambient_color = Mdl.Vec3f(self._io, self, self._root)
  self.transparency_hint = self._io:read_u4le()
  self.texture_0_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.texture_1_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(32), 0, false), "ASCII")
  self.texture_2_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(12), 0, false), "ASCII")
  self.texture_3_name = str_decode.decode(KaitaiStream.bytes_terminate(self._io:read_bytes(12), 0, false), "ASCII")
  self.indices_count_array_offset = self._io:read_u4le()
  self.indices_count_array_count = self._io:read_u4le()
  self.indices_count_array_count_duplicate = self._io:read_u4le()
  self.indices_offset_array_offset = self._io:read_u4le()
  self.indices_offset_array_count = self._io:read_u4le()
  self.indices_offset_array_count_duplicate = self._io:read_u4le()
  self.inverted_counter_array_offset = self._io:read_u4le()
  self.inverted_counter_array_count = self._io:read_u4le()
  self.inverted_counter_array_count_duplicate = self._io:read_u4le()
  self.unknown_values = {}
  for i = 0, 3 - 1 do
    self.unknown_values[i + 1] = self._io:read_s4le()
  end
  self.saber_unknown_data = {}
  for i = 0, 8 - 1 do
    self.saber_unknown_data[i + 1] = self._io:read_u1()
  end
  self.unknown = self._io:read_u4le()
  self.uv_direction = Mdl.Vec3f(self._io, self, self._root)
  self.uv_jitter = self._io:read_f4le()
  self.uv_jitter_speed = self._io:read_f4le()
  self.mdx_vertex_size = self._io:read_u4le()
  self.mdx_data_flags = self._io:read_u4le()
  self.mdx_vertices_offset = self._io:read_s4le()
  self.mdx_normals_offset = self._io:read_s4le()
  self.mdx_vertex_colors_offset = self._io:read_s4le()
  self.mdx_tex0_uvs_offset = self._io:read_s4le()
  self.mdx_tex1_uvs_offset = self._io:read_s4le()
  self.mdx_tex2_uvs_offset = self._io:read_s4le()
  self.mdx_tex3_uvs_offset = self._io:read_s4le()
  self.mdx_tangent_space_offset = self._io:read_s4le()
  self.mdx_unknown_offset_1 = self._io:read_s4le()
  self.mdx_unknown_offset_2 = self._io:read_s4le()
  self.mdx_unknown_offset_3 = self._io:read_s4le()
  self.vertex_count = self._io:read_u2le()
  self.texture_count = self._io:read_u2le()
  self.lightmapped = self._io:read_u1()
  self.rotate_texture = self._io:read_u1()
  self.background_geometry = self._io:read_u1()
  self.shadow = self._io:read_u1()
  self.beaming = self._io:read_u1()
  self.render = self._io:read_u1()
  self.unknown_flag = self._io:read_u1()
  self.padding = self._io:read_u1()
  self.total_area = self._io:read_f4le()
  self.unknown2 = self._io:read_u4le()
  if self._root.model_header.geometry.is_kotor2 then
    self.k2_unknown_1 = self._io:read_u4le()
  end
  if self._root.model_header.geometry.is_kotor2 then
    self.k2_unknown_2 = self._io:read_u4le()
  end
  self.mdx_data_offset = self._io:read_u4le()
  self.mdl_vertices_offset = self._io:read_u4le()
end

-- 
-- Game engine function pointer (version-specific).
-- 
-- Secondary game engine function pointer.
-- 
-- Offset to face definitions array.
-- 
-- Number of triangular faces in mesh.
-- 
-- Duplicate of faces count.
-- 
-- Minimum bounding box coordinates (X, Y, Z).
-- 
-- Maximum bounding box coordinates (X, Y, Z).
-- 
-- Bounding sphere radius.
-- 
-- Average vertex position (centroid) X, Y, Z.
-- 
-- Material diffuse color (R, G, B, range 0.0-1.0).
-- 
-- Material ambient color (R, G, B, range 0.0-1.0).
-- 
-- Transparency rendering mode.
-- 
-- Primary diffuse texture name (null-terminated string).
-- 
-- Secondary texture name, often lightmap (null-terminated string).
-- 
-- Tertiary texture name (null-terminated string).
-- 
-- Quaternary texture name (null-terminated string).
-- 
-- Offset to vertex indices count array.
-- 
-- Number of entries in indices count array.
-- 
-- Duplicate of indices count array count.
-- 
-- Offset to vertex indices offset array.
-- 
-- Number of entries in indices offset array.
-- 
-- Duplicate of indices offset array count.
-- 
-- Offset to inverted counter array.
-- 
-- Number of entries in inverted counter array.
-- 
-- Duplicate of inverted counter array count.
-- 
-- Typically {-1, -1, 0}, purpose unknown.
-- 
-- Data specific to lightsaber meshes.
-- 
-- Purpose unknown.
-- 
-- UV animation direction X, Y components (Z = jitter speed).
-- 
-- UV animation jitter amount.
-- 
-- UV animation jitter speed.
-- 
-- Size in bytes of each vertex in MDX data.
-- 
-- Bitmask of present vertex attributes:
-- - 0x00000001: MDX_VERTICES (vertex positions)
-- - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
-- - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
-- - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
-- - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
-- - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
-- - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
-- - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
-- 
-- Relative offset to vertex positions in MDX (or -1 if none).
-- 
-- Relative offset to vertex normals in MDX (or -1 if none).
-- 
-- Relative offset to vertex colors in MDX (or -1 if none).
-- 
-- Relative offset to primary texture UVs in MDX (or -1 if none).
-- 
-- Relative offset to secondary texture UVs in MDX (or -1 if none).
-- 
-- Relative offset to tertiary texture UVs in MDX (or -1 if none).
-- 
-- Relative offset to quaternary texture UVs in MDX (or -1 if none).
-- 
-- Relative offset to tangent space data in MDX (or -1 if none).
-- 
-- Relative offset to unknown MDX data (or -1 if none).
-- 
-- Relative offset to unknown MDX data (or -1 if none).
-- 
-- Relative offset to unknown MDX data (or -1 if none).
-- 
-- Number of vertices in mesh.
-- 
-- Number of textures used by mesh.
-- 
-- 1 if mesh uses lightmap, 0 otherwise.
-- 
-- 1 if texture should rotate, 0 otherwise.
-- 
-- 1 if background geometry, 0 otherwise.
-- 
-- 1 if mesh casts shadows, 0 otherwise.
-- 
-- 1 if beaming effect enabled, 0 otherwise.
-- 
-- 1 if mesh is renderable, 0 if hidden.
-- 
-- Purpose unknown (possibly UV animation enable).
-- 
-- Padding byte.
-- 
-- Total surface area of all faces.
-- 
-- Purpose unknown.
-- 
-- KOTOR 2 only: Additional unknown field.
-- 
-- KOTOR 2 only: Additional unknown field.
-- 
-- Absolute offset to this mesh's vertex data in MDX file.
-- 
-- Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes).

-- 
-- 3D vector (3 floats).
Mdl.Vec3f = class.class(KaitaiStruct)

function Mdl.Vec3f:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Mdl.Vec3f:_read()
  self.x = self._io:read_f4le()
  self.y = self._io:read_f4le()
  self.z = self._io:read_f4le()
end



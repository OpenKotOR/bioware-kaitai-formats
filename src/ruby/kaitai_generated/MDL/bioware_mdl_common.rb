# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
# `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
# Tooling alignment: PyKotor / MDLOps / xoreos.
# 
# - `model_classification` — `model_header.model_type` (`u1`).
# - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
# - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
# @see https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
# @see https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/ PyKotor — MDL package
# @see https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — `Model_KotOR::load`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81 xoreos — `kFileTypeMDL`
# @see https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller IDs)
# @see https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)
class BiowareMdlCommon < Kaitai::Struct::Struct

  CONTROLLER_TYPE = {
    8 => :controller_type_position,
    20 => :controller_type_orientation,
    36 => :controller_type_scale,
    76 => :controller_type_color,
    80 => :controller_type_emitter_alpha_end,
    84 => :controller_type_emitter_alpha_start,
    88 => :controller_type_radius,
    92 => :controller_type_emitter_bounce_coefficient,
    96 => :controller_type_shadow_radius,
    100 => :controller_type_vertical_displacement_or_drag_or_selfillumcolor,
    104 => :controller_type_emitter_fps,
    108 => :controller_type_emitter_frame_end,
    112 => :controller_type_emitter_frame_start,
    116 => :controller_type_emitter_gravity,
    120 => :controller_type_emitter_life_expectancy,
    124 => :controller_type_emitter_mass,
    132 => :controller_type_alpha,
    136 => :controller_type_emitter_particle_rotation,
    140 => :controller_type_multiplier_or_randvel,
    144 => :controller_type_emitter_size_start,
    148 => :controller_type_emitter_size_end,
    152 => :controller_type_emitter_size_start_y,
    156 => :controller_type_emitter_size_end_y,
    160 => :controller_type_emitter_spread,
    164 => :controller_type_emitter_threshold,
    168 => :controller_type_emitter_velocity,
    172 => :controller_type_emitter_x_size,
    176 => :controller_type_emitter_y_size,
    180 => :controller_type_emitter_blur_length,
    184 => :controller_type_emitter_lightning_delay,
    188 => :controller_type_emitter_lightning_radius,
    192 => :controller_type_emitter_lightning_scale,
    196 => :controller_type_emitter_lightning_subdivide,
    200 => :controller_type_emitter_lightning_zig_zag,
    216 => :controller_type_emitter_alpha_mid,
    220 => :controller_type_emitter_percent_start,
    224 => :controller_type_emitter_percent_mid,
    228 => :controller_type_emitter_percent_end,
    232 => :controller_type_emitter_size_mid,
    236 => :controller_type_emitter_size_mid_y,
    240 => :controller_type_emitter_random_birth_rate,
    252 => :controller_type_emitter_target_size,
    256 => :controller_type_emitter_num_control_points,
    260 => :controller_type_emitter_control_point_radius,
    264 => :controller_type_emitter_control_point_delay,
    268 => :controller_type_emitter_tangent_spread,
    272 => :controller_type_emitter_tangent_length,
    284 => :controller_type_emitter_color_mid,
    380 => :controller_type_emitter_color_end,
    392 => :controller_type_emitter_color_start,
    502 => :controller_type_emitter_detonate,
  }
  I__CONTROLLER_TYPE = CONTROLLER_TYPE.invert

  MODEL_CLASSIFICATION = {
    0 => :model_classification_other,
    1 => :model_classification_effect,
    2 => :model_classification_tile,
    4 => :model_classification_character,
    8 => :model_classification_door,
    16 => :model_classification_lightsaber,
    32 => :model_classification_placeable,
    64 => :model_classification_flyer,
  }
  I__MODEL_CLASSIFICATION = MODEL_CLASSIFICATION.invert

  NODE_TYPE_VALUE = {
    1 => :node_type_value_dummy,
    3 => :node_type_value_light,
    5 => :node_type_value_emitter,
    17 => :node_type_value_reference,
    33 => :node_type_value_trimesh,
    97 => :node_type_value_skinmesh,
    161 => :node_type_value_animmesh,
    289 => :node_type_value_danglymesh,
    545 => :node_type_value_aabb,
    2081 => :node_type_value_lightsaber,
  }
  I__NODE_TYPE_VALUE = NODE_TYPE_VALUE.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end
end

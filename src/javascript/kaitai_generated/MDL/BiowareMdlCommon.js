// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.BiowareMdlCommon || (root.BiowareMdlCommon = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (BiowareMdlCommon_, KaitaiStream) {
/**
 * Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
 * `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
 * Tooling alignment: PyKotor / MDLOps / xoreos.
 * 
 * - `model_classification` — `model_header.model_type` (`u1`).
 * - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
 * - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format|PyKotor wiki — MDL/MDX}
 * @see {@link https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/|PyKotor — MDL package}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267|xoreos — `Model_KotOR::load`}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81|xoreos — `kFileTypeMDL`}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43|xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html|xoreos-docs — Torlack binmdl (controller IDs)}
 * @see {@link https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407|Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)}
 */

var BiowareMdlCommon = (function() {
  BiowareMdlCommon.ControllerType = Object.freeze({
    POSITION: 8,
    ORIENTATION: 20,
    SCALE: 36,
    COLOR: 76,
    EMITTER_ALPHA_END: 80,
    EMITTER_ALPHA_START: 84,
    RADIUS: 88,
    EMITTER_BOUNCE_COEFFICIENT: 92,
    SHADOW_RADIUS: 96,
    VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR: 100,
    EMITTER_FPS: 104,
    EMITTER_FRAME_END: 108,
    EMITTER_FRAME_START: 112,
    EMITTER_GRAVITY: 116,
    EMITTER_LIFE_EXPECTANCY: 120,
    EMITTER_MASS: 124,
    ALPHA: 132,
    EMITTER_PARTICLE_ROTATION: 136,
    MULTIPLIER_OR_RANDVEL: 140,
    EMITTER_SIZE_START: 144,
    EMITTER_SIZE_END: 148,
    EMITTER_SIZE_START_Y: 152,
    EMITTER_SIZE_END_Y: 156,
    EMITTER_SPREAD: 160,
    EMITTER_THRESHOLD: 164,
    EMITTER_VELOCITY: 168,
    EMITTER_X_SIZE: 172,
    EMITTER_Y_SIZE: 176,
    EMITTER_BLUR_LENGTH: 180,
    EMITTER_LIGHTNING_DELAY: 184,
    EMITTER_LIGHTNING_RADIUS: 188,
    EMITTER_LIGHTNING_SCALE: 192,
    EMITTER_LIGHTNING_SUBDIVIDE: 196,
    EMITTER_LIGHTNING_ZIG_ZAG: 200,
    EMITTER_ALPHA_MID: 216,
    EMITTER_PERCENT_START: 220,
    EMITTER_PERCENT_MID: 224,
    EMITTER_PERCENT_END: 228,
    EMITTER_SIZE_MID: 232,
    EMITTER_SIZE_MID_Y: 236,
    EMITTER_RANDOM_BIRTH_RATE: 240,
    EMITTER_TARGET_SIZE: 252,
    EMITTER_NUM_CONTROL_POINTS: 256,
    EMITTER_CONTROL_POINT_RADIUS: 260,
    EMITTER_CONTROL_POINT_DELAY: 264,
    EMITTER_TANGENT_SPREAD: 268,
    EMITTER_TANGENT_LENGTH: 272,
    EMITTER_COLOR_MID: 284,
    EMITTER_COLOR_END: 380,
    EMITTER_COLOR_START: 392,
    EMITTER_DETONATE: 502,

    8: "POSITION",
    20: "ORIENTATION",
    36: "SCALE",
    76: "COLOR",
    80: "EMITTER_ALPHA_END",
    84: "EMITTER_ALPHA_START",
    88: "RADIUS",
    92: "EMITTER_BOUNCE_COEFFICIENT",
    96: "SHADOW_RADIUS",
    100: "VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR",
    104: "EMITTER_FPS",
    108: "EMITTER_FRAME_END",
    112: "EMITTER_FRAME_START",
    116: "EMITTER_GRAVITY",
    120: "EMITTER_LIFE_EXPECTANCY",
    124: "EMITTER_MASS",
    132: "ALPHA",
    136: "EMITTER_PARTICLE_ROTATION",
    140: "MULTIPLIER_OR_RANDVEL",
    144: "EMITTER_SIZE_START",
    148: "EMITTER_SIZE_END",
    152: "EMITTER_SIZE_START_Y",
    156: "EMITTER_SIZE_END_Y",
    160: "EMITTER_SPREAD",
    164: "EMITTER_THRESHOLD",
    168: "EMITTER_VELOCITY",
    172: "EMITTER_X_SIZE",
    176: "EMITTER_Y_SIZE",
    180: "EMITTER_BLUR_LENGTH",
    184: "EMITTER_LIGHTNING_DELAY",
    188: "EMITTER_LIGHTNING_RADIUS",
    192: "EMITTER_LIGHTNING_SCALE",
    196: "EMITTER_LIGHTNING_SUBDIVIDE",
    200: "EMITTER_LIGHTNING_ZIG_ZAG",
    216: "EMITTER_ALPHA_MID",
    220: "EMITTER_PERCENT_START",
    224: "EMITTER_PERCENT_MID",
    228: "EMITTER_PERCENT_END",
    232: "EMITTER_SIZE_MID",
    236: "EMITTER_SIZE_MID_Y",
    240: "EMITTER_RANDOM_BIRTH_RATE",
    252: "EMITTER_TARGET_SIZE",
    256: "EMITTER_NUM_CONTROL_POINTS",
    260: "EMITTER_CONTROL_POINT_RADIUS",
    264: "EMITTER_CONTROL_POINT_DELAY",
    268: "EMITTER_TANGENT_SPREAD",
    272: "EMITTER_TANGENT_LENGTH",
    284: "EMITTER_COLOR_MID",
    380: "EMITTER_COLOR_END",
    392: "EMITTER_COLOR_START",
    502: "EMITTER_DETONATE",
  });

  BiowareMdlCommon.ModelClassification = Object.freeze({
    OTHER: 0,
    EFFECT: 1,
    TILE: 2,
    CHARACTER: 4,
    DOOR: 8,
    LIGHTSABER: 16,
    PLACEABLE: 32,
    FLYER: 64,

    0: "OTHER",
    1: "EFFECT",
    2: "TILE",
    4: "CHARACTER",
    8: "DOOR",
    16: "LIGHTSABER",
    32: "PLACEABLE",
    64: "FLYER",
  });

  BiowareMdlCommon.NodeTypeValue = Object.freeze({
    DUMMY: 1,
    LIGHT: 3,
    EMITTER: 5,
    REFERENCE: 17,
    TRIMESH: 33,
    SKINMESH: 97,
    ANIMMESH: 161,
    DANGLYMESH: 289,
    AABB: 545,
    LIGHTSABER: 2081,

    1: "DUMMY",
    3: "LIGHT",
    5: "EMITTER",
    17: "REFERENCE",
    33: "TRIMESH",
    97: "SKINMESH",
    161: "ANIMMESH",
    289: "DANGLYMESH",
    545: "AABB",
    2081: "LIGHTSABER",
  });

  function BiowareMdlCommon(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  BiowareMdlCommon.prototype._read = function() {
  }

  return BiowareMdlCommon;
})();
BiowareMdlCommon_.BiowareMdlCommon = BiowareMdlCommon;
});

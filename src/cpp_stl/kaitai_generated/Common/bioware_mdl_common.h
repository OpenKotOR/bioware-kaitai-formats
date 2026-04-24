#ifndef BIOWARE_MDL_COMMON_H_
#define BIOWARE_MDL_COMMON_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bioware_mdl_common_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <set>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
 * `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
 * Tooling alignment: PyKotor / MDLOps / xoreos.
 * 
 * - `model_classification` — `model_header.model_type` (`u1`).
 * - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
 * - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/ PyKotor — MDL package
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — `Model_KotOR::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81 xoreos — `kFileTypeMDL`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller IDs)
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)
 */

class bioware_mdl_common_t : public kaitai::kstruct {

public:

    enum controller_type_t {
        CONTROLLER_TYPE_POSITION = 8,
        CONTROLLER_TYPE_ORIENTATION = 20,
        CONTROLLER_TYPE_SCALE = 36,
        CONTROLLER_TYPE_COLOR = 76,
        CONTROLLER_TYPE_EMITTER_ALPHA_END = 80,
        CONTROLLER_TYPE_EMITTER_ALPHA_START = 84,
        CONTROLLER_TYPE_RADIUS = 88,
        CONTROLLER_TYPE_EMITTER_BOUNCE_COEFFICIENT = 92,
        CONTROLLER_TYPE_SHADOW_RADIUS = 96,
        CONTROLLER_TYPE_VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR = 100,
        CONTROLLER_TYPE_EMITTER_FPS = 104,
        CONTROLLER_TYPE_EMITTER_FRAME_END = 108,
        CONTROLLER_TYPE_EMITTER_FRAME_START = 112,
        CONTROLLER_TYPE_EMITTER_GRAVITY = 116,
        CONTROLLER_TYPE_EMITTER_LIFE_EXPECTANCY = 120,
        CONTROLLER_TYPE_EMITTER_MASS = 124,
        CONTROLLER_TYPE_ALPHA = 132,
        CONTROLLER_TYPE_EMITTER_PARTICLE_ROTATION = 136,
        CONTROLLER_TYPE_MULTIPLIER_OR_RANDVEL = 140,
        CONTROLLER_TYPE_EMITTER_SIZE_START = 144,
        CONTROLLER_TYPE_EMITTER_SIZE_END = 148,
        CONTROLLER_TYPE_EMITTER_SIZE_START_Y = 152,
        CONTROLLER_TYPE_EMITTER_SIZE_END_Y = 156,
        CONTROLLER_TYPE_EMITTER_SPREAD = 160,
        CONTROLLER_TYPE_EMITTER_THRESHOLD = 164,
        CONTROLLER_TYPE_EMITTER_VELOCITY = 168,
        CONTROLLER_TYPE_EMITTER_X_SIZE = 172,
        CONTROLLER_TYPE_EMITTER_Y_SIZE = 176,
        CONTROLLER_TYPE_EMITTER_BLUR_LENGTH = 180,
        CONTROLLER_TYPE_EMITTER_LIGHTNING_DELAY = 184,
        CONTROLLER_TYPE_EMITTER_LIGHTNING_RADIUS = 188,
        CONTROLLER_TYPE_EMITTER_LIGHTNING_SCALE = 192,
        CONTROLLER_TYPE_EMITTER_LIGHTNING_SUBDIVIDE = 196,
        CONTROLLER_TYPE_EMITTER_LIGHTNING_ZIG_ZAG = 200,
        CONTROLLER_TYPE_EMITTER_ALPHA_MID = 216,
        CONTROLLER_TYPE_EMITTER_PERCENT_START = 220,
        CONTROLLER_TYPE_EMITTER_PERCENT_MID = 224,
        CONTROLLER_TYPE_EMITTER_PERCENT_END = 228,
        CONTROLLER_TYPE_EMITTER_SIZE_MID = 232,
        CONTROLLER_TYPE_EMITTER_SIZE_MID_Y = 236,
        CONTROLLER_TYPE_EMITTER_RANDOM_BIRTH_RATE = 240,
        CONTROLLER_TYPE_EMITTER_TARGET_SIZE = 252,
        CONTROLLER_TYPE_EMITTER_NUM_CONTROL_POINTS = 256,
        CONTROLLER_TYPE_EMITTER_CONTROL_POINT_RADIUS = 260,
        CONTROLLER_TYPE_EMITTER_CONTROL_POINT_DELAY = 264,
        CONTROLLER_TYPE_EMITTER_TANGENT_SPREAD = 268,
        CONTROLLER_TYPE_EMITTER_TANGENT_LENGTH = 272,
        CONTROLLER_TYPE_EMITTER_COLOR_MID = 284,
        CONTROLLER_TYPE_EMITTER_COLOR_END = 380,
        CONTROLLER_TYPE_EMITTER_COLOR_START = 392,
        CONTROLLER_TYPE_EMITTER_DETONATE = 502
    };
    static bool _is_defined_controller_type_t(controller_type_t v);

private:
    static const std::set<controller_type_t> _values_controller_type_t;
    static std::set<controller_type_t> _build_values_controller_type_t();

public:

    enum model_classification_t {
        MODEL_CLASSIFICATION_OTHER = 0,
        MODEL_CLASSIFICATION_EFFECT = 1,
        MODEL_CLASSIFICATION_TILE = 2,
        MODEL_CLASSIFICATION_CHARACTER = 4,
        MODEL_CLASSIFICATION_DOOR = 8,
        MODEL_CLASSIFICATION_LIGHTSABER = 16,
        MODEL_CLASSIFICATION_PLACEABLE = 32,
        MODEL_CLASSIFICATION_FLYER = 64
    };
    static bool _is_defined_model_classification_t(model_classification_t v);

private:
    static const std::set<model_classification_t> _values_model_classification_t;
    static std::set<model_classification_t> _build_values_model_classification_t();

public:

    enum node_type_value_t {
        NODE_TYPE_VALUE_DUMMY = 1,
        NODE_TYPE_VALUE_LIGHT = 3,
        NODE_TYPE_VALUE_EMITTER = 5,
        NODE_TYPE_VALUE_REFERENCE = 17,
        NODE_TYPE_VALUE_TRIMESH = 33,
        NODE_TYPE_VALUE_SKINMESH = 97,
        NODE_TYPE_VALUE_ANIMMESH = 161,
        NODE_TYPE_VALUE_DANGLYMESH = 289,
        NODE_TYPE_VALUE_AABB = 545,
        NODE_TYPE_VALUE_LIGHTSABER = 2081
    };
    static bool _is_defined_node_type_value_t(node_type_value_t v);

private:
    static const std::set<node_type_value_t> _values_node_type_value_t;
    static std::set<node_type_value_t> _build_values_node_type_value_t();

public:

    bioware_mdl_common_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bioware_mdl_common_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bioware_mdl_common_t();

private:
    bioware_mdl_common_t* m__root;
    kaitai::kstruct* m__parent;

public:
    bioware_mdl_common_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIOWARE_MDL_COMMON_H_

#ifndef MDL_H_
#define MDL_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class mdl_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include "bioware_mdl_common.h"
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * BioWare MDL Model Format
 * 
 * The MDL file contains:
 * - File header (12 bytes)
 * - Model header (196 bytes) which begins with a Geometry header (80 bytes)
 * - Name offset array + name strings
 * - Animation offset array + animation headers + animation nodes
 * - Node hierarchy with geometry data
 * 
 * Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.
 * 
 * Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.
 * 
 * Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
 * are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
 * compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — MDLBinaryReader (binary MDL/MDX)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — Model_KotOR::load
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller / Aurora background)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118 reone — MdlMdxReader::load
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170 KotOR.js — OdysseyModel binary constructor
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — controller name table
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — `readasciimdl` (ASCII MDL ingest)
 */

class mdl_t : public kaitai::kstruct {

public:
    class aabb_header_t;
    class animation_event_t;
    class animation_header_t;
    class animmesh_header_t;
    class array_definition_t;
    class controller_t;
    class danglymesh_header_t;
    class emitter_header_t;
    class file_header_t;
    class geometry_header_t;
    class light_header_t;
    class lightsaber_header_t;
    class mdl_animation_entry_t;
    class model_header_t;
    class name_strings_t;
    class node_t;
    class node_header_t;
    class quaternion_t;
    class reference_header_t;
    class skinmesh_header_t;
    class trimesh_header_t;
    class vec3f_t;

    mdl_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~mdl_t();

    /**
     * AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
     */

    class aabb_header_t : public kaitai::kstruct {

    public:

        aabb_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~aabb_header_t();

    private:
        trimesh_header_t* m_trimesh_base;
        uint32_t m_unknown;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Standard trimesh header
         */
        trimesh_header_t* trimesh_base() const { return m_trimesh_base; }

        /**
         * Purpose unknown
         */
        uint32_t unknown() const { return m_unknown; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Animation event (36 bytes)
     */

    class animation_event_t : public kaitai::kstruct {

    public:

        animation_event_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~animation_event_t();

    private:
        float m_activation_time;
        std::string m_event_name;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Time in seconds when event triggers during animation playback
         */
        float activation_time() const { return m_activation_time; }

        /**
         * Name of event (null-terminated string, e.g., "detonate")
         */
        std::string event_name() const { return m_event_name; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
     */

    class animation_header_t : public kaitai::kstruct {

    public:

        animation_header_t(kaitai::kstream* p__io, mdl_t::mdl_animation_entry_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~animation_header_t();

    private:
        geometry_header_t* m_geo_header;
        float m_animation_length;
        float m_transition_time;
        std::string m_animation_root;
        uint32_t m_event_array_offset;
        uint32_t m_event_count;
        uint32_t m_event_count_duplicate;
        uint32_t m_unknown;
        mdl_t* m__root;
        mdl_t::mdl_animation_entry_t* m__parent;

    public:

        /**
         * Standard 80-byte geometry header (geometry_type = 0x01 for animation)
         */
        geometry_header_t* geo_header() const { return m_geo_header; }

        /**
         * Duration of animation in seconds
         */
        float animation_length() const { return m_animation_length; }

        /**
         * Transition/blend time to this animation in seconds
         */
        float transition_time() const { return m_transition_time; }

        /**
         * Root node name for animation (null-terminated string)
         */
        std::string animation_root() const { return m_animation_root; }

        /**
         * Offset to animation events array
         */
        uint32_t event_array_offset() const { return m_event_array_offset; }

        /**
         * Number of animation events
         */
        uint32_t event_count() const { return m_event_count; }

        /**
         * Duplicate value of event count
         */
        uint32_t event_count_duplicate() const { return m_event_count_duplicate; }

        /**
         * Purpose unknown
         */
        uint32_t unknown() const { return m_unknown; }
        mdl_t* _root() const { return m__root; }
        mdl_t::mdl_animation_entry_t* _parent() const { return m__parent; }
    };

    /**
     * Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
     */

    class animmesh_header_t : public kaitai::kstruct {

    public:

        animmesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~animmesh_header_t();

    private:
        trimesh_header_t* m_trimesh_base;
        float m_unknown;
        array_definition_t* m_unknown_array;
        std::vector<float>* m_unknown_floats;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Standard trimesh header
         */
        trimesh_header_t* trimesh_base() const { return m_trimesh_base; }

        /**
         * Purpose unknown
         */
        float unknown() const { return m_unknown; }

        /**
         * Unknown array definition
         */
        array_definition_t* unknown_array() const { return m_unknown_array; }

        /**
         * Unknown float values
         */
        std::vector<float>* unknown_floats() const { return m_unknown_floats; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Array definition structure (offset, count, count duplicate)
     */

    class array_definition_t : public kaitai::kstruct {

    public:

        array_definition_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~array_definition_t();

    private:
        int32_t m_offset;
        uint32_t m_count;
        uint32_t m_count_duplicate;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Offset to array (relative to MDL data start, offset 12)
         */
        int32_t offset() const { return m_offset; }

        /**
         * Number of used entries
         */
        uint32_t count() const { return m_count; }

        /**
         * Duplicate of count (allocated entries)
         */
        uint32_t count_duplicate() const { return m_count_duplicate; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Controller structure (16 bytes) - defines animation data for a node property over time
     */

    class controller_t : public kaitai::kstruct {

    public:

        controller_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_t();

    private:
        bool f_uses_bezier;
        bool m_uses_bezier;

    public:

        /**
         * True if controller uses Bezier interpolation
         */
        bool uses_bezier();

    private:
        bioware_mdl_common_t::controller_type_t m_type;
        uint16_t m_unknown;
        uint16_t m_row_count;
        uint16_t m_time_index;
        uint16_t m_data_index;
        uint8_t m_column_count;
        std::vector<uint8_t>* m_padding;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Controller type identifier. Controllers define animation data for node properties over time.
         * 
         * Common Node Controllers (used by all node types):
         * - 8: Position (3 floats: X, Y, Z translation)
         * - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
         * - 36: Scale (3 floats: X, Y, Z scale factors)
         * 
         * Light Controllers (specific to light nodes):
         * - 76: Color (light color, 3 floats: R, G, B)
         * - 88: Radius (light radius, 1 float)
         * - 96: Shadow Radius (shadow casting radius, 1 float)
         * - 100: Vertical Displacement (vertical offset, 1 float)
         * - 140: Multiplier (light intensity multiplier, 1 float)
         * 
         * Emitter Controllers (specific to emitter nodes):
         * - 80: Alpha End (final alpha value, 1 float)
         * - 84: Alpha Start (initial alpha value, 1 float)
         * - 88: Birth Rate (particle spawn rate, 1 float)
         * - 92: Bounce Coefficient (particle bounce factor, 1 float)
         * - 96: Combine Time (particle combination timing, 1 float)
         * - 100: Drag (particle drag/resistance, 1 float)
         * - 104: FPS (frames per second, 1 float)
         * - 108: Frame End (ending frame number, 1 float)
         * - 112: Frame Start (starting frame number, 1 float)
         * - 116: Gravity (gravity force, 1 float)
         * - 120: Life Expectancy (particle lifetime, 1 float)
         * - 124: Mass (particle mass, 1 float)
         * - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
         * - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
         * - 136: Particle Rotation (particle rotation speed/angle, 1 float)
         * - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
         * - 144: Size Start (initial particle size, 1 float)
         * - 148: Size End (final particle size, 1 float)
         * - 152: Size Start Y (initial particle size Y component, 1 float)
         * - 156: Size End Y (final particle size Y component, 1 float)
         * - 160: Spread (particle spread angle, 1 float)
         * - 164: Threshold (threshold value, 1 float)
         * - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
         * - 172: X Size (particle X dimension size, 1 float)
         * - 176: Y Size (particle Y dimension size, 1 float)
         * - 180: Blur Length (motion blur length, 1 float)
         * - 184: Lightning Delay (lightning effect delay, 1 float)
         * - 188: Lightning Radius (lightning effect radius, 1 float)
         * - 192: Lightning Scale (lightning effect scale factor, 1 float)
         * - 196: Lightning Subdivide (lightning subdivision count, 1 float)
         * - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
         * - 216: Alpha Mid (mid-point alpha value, 1 float)
         * - 220: Percent Start (starting percentage, 1 float)
         * - 224: Percent Mid (mid-point percentage, 1 float)
         * - 228: Percent End (ending percentage, 1 float)
         * - 232: Size Mid (mid-point particle size, 1 float)
         * - 236: Size Mid Y (mid-point particle size Y component, 1 float)
         * - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
         * - 252: Target Size (target particle size, 1 float)
         * - 256: Number of Control Points (control point count, 1 float)
         * - 260: Control Point Radius (control point radius, 1 float)
         * - 264: Control Point Delay (control point delay timing, 1 float)
         * - 268: Tangent Spread (tangent spread angle, 1 float)
         * - 272: Tangent Length (tangent vector length, 1 float)
         * - 284: Color Mid (mid-point color, 3 floats: R, G, B)
         * - 380: Color End (final color, 3 floats: R, G, B)
         * - 392: Color Start (initial color, 3 floats: R, G, B)
         * - 502: Emitter Detonate (detonation trigger, 1 float)
         * 
         * Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
         * - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
         * - 128: Alpha (transparency/opacity, 1 float)
         * 
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
         * Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
         * Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list
         */
        bioware_mdl_common_t::controller_type_t type() const { return m_type; }

        /**
         * Purpose unknown, typically 0xFFFF
         */
        uint16_t unknown() const { return m_unknown; }

        /**
         * Number of keyframe rows (timepoints) for this controller
         */
        uint16_t row_count() const { return m_row_count; }

        /**
         * Index into controller data array where time values begin
         */
        uint16_t time_index() const { return m_time_index; }

        /**
         * Index into controller data array where property values begin
         */
        uint16_t data_index() const { return m_data_index; }

        /**
         * Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
         * If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
         */
        uint8_t column_count() const { return m_column_count; }

        /**
         * Padding bytes for 16-byte alignment
         */
        std::vector<uint8_t>* padding() const { return m_padding; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
     */

    class danglymesh_header_t : public kaitai::kstruct {

    public:

        danglymesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~danglymesh_header_t();

    private:
        trimesh_header_t* m_trimesh_base;
        uint32_t m_constraints_offset;
        uint32_t m_constraints_count;
        uint32_t m_constraints_count_duplicate;
        float m_displacement;
        float m_tightness;
        float m_period;
        uint32_t m_unknown;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Standard trimesh header
         */
        trimesh_header_t* trimesh_base() const { return m_trimesh_base; }

        /**
         * Offset to vertex constraint values array
         */
        uint32_t constraints_offset() const { return m_constraints_offset; }

        /**
         * Number of vertex constraints (matches vertex count)
         */
        uint32_t constraints_count() const { return m_constraints_count; }

        /**
         * Duplicate of constraints count
         */
        uint32_t constraints_count_duplicate() const { return m_constraints_count_duplicate; }

        /**
         * Maximum displacement distance for physics simulation
         */
        float displacement() const { return m_displacement; }

        /**
         * Tightness/stiffness of spring simulation (0.0-1.0)
         */
        float tightness() const { return m_tightness; }

        /**
         * Oscillation period in seconds
         */
        float period() const { return m_period; }

        /**
         * Purpose unknown
         */
        uint32_t unknown() const { return m_unknown; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Emitter header (224 bytes)
     */

    class emitter_header_t : public kaitai::kstruct {

    public:

        emitter_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~emitter_header_t();

    private:
        float m_dead_space;
        float m_blast_radius;
        float m_blast_length;
        uint32_t m_branch_count;
        float m_control_point_smoothing;
        uint32_t m_x_grid;
        uint32_t m_y_grid;
        uint32_t m_padding_unknown;
        std::string m_update_script;
        std::string m_render_script;
        std::string m_blend_script;
        std::string m_texture_name;
        std::string m_chunk_name;
        uint32_t m_two_sided_texture;
        uint32_t m_loop;
        uint16_t m_render_order;
        uint8_t m_frame_blending;
        std::string m_depth_texture_name;
        uint8_t m_padding;
        uint32_t m_flags;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Minimum distance from emitter before particles become visible
         */
        float dead_space() const { return m_dead_space; }

        /**
         * Radius of explosive/blast particle effects
         */
        float blast_radius() const { return m_blast_radius; }

        /**
         * Length/duration of blast effects
         */
        float blast_length() const { return m_blast_length; }

        /**
         * Number of branching paths for particle trails
         */
        uint32_t branch_count() const { return m_branch_count; }

        /**
         * Smoothing factor for particle path control points
         */
        float control_point_smoothing() const { return m_control_point_smoothing; }

        /**
         * Grid subdivisions along X axis for particle spawning
         */
        uint32_t x_grid() const { return m_x_grid; }

        /**
         * Grid subdivisions along Y axis for particle spawning
         */
        uint32_t y_grid() const { return m_y_grid; }

        /**
         * Purpose unknown or padding
         */
        uint32_t padding_unknown() const { return m_padding_unknown; }

        /**
         * Update behavior script name (e.g., "single", "fountain")
         */
        std::string update_script() const { return m_update_script; }

        /**
         * Render mode script name (e.g., "normal", "billboard_to_local_z")
         */
        std::string render_script() const { return m_render_script; }

        /**
         * Blend mode script name (e.g., "normal", "lighten")
         */
        std::string blend_script() const { return m_blend_script; }

        /**
         * Particle texture name (null-terminated string)
         */
        std::string texture_name() const { return m_texture_name; }

        /**
         * Associated model chunk name (null-terminated string)
         */
        std::string chunk_name() const { return m_chunk_name; }

        /**
         * 1 if texture should render two-sided, 0 for single-sided
         */
        uint32_t two_sided_texture() const { return m_two_sided_texture; }

        /**
         * 1 if particle system loops, 0 for single playback
         */
        uint32_t loop() const { return m_loop; }

        /**
         * Rendering priority/order for particle sorting
         */
        uint16_t render_order() const { return m_render_order; }

        /**
         * 1 if frame blending enabled, 0 otherwise
         */
        uint8_t frame_blending() const { return m_frame_blending; }

        /**
         * Depth/softparticle texture name (null-terminated string)
         */
        std::string depth_texture_name() const { return m_depth_texture_name; }

        /**
         * Padding byte for alignment
         */
        uint8_t padding() const { return m_padding; }

        /**
         * Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
         */
        uint32_t flags() const { return m_flags; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * MDL file header (12 bytes)
     */

    class file_header_t : public kaitai::kstruct {

    public:

        file_header_t(kaitai::kstream* p__io, mdl_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~file_header_t();

    private:
        uint32_t m_unused;
        uint32_t m_mdl_size;
        uint32_t m_mdx_size;
        mdl_t* m__root;
        mdl_t* m__parent;

    public:

        /**
         * Always 0
         */
        uint32_t unused() const { return m_unused; }

        /**
         * Size of MDL file in bytes
         */
        uint32_t mdl_size() const { return m_mdl_size; }

        /**
         * Size of MDX file in bytes
         */
        uint32_t mdx_size() const { return m_mdx_size; }
        mdl_t* _root() const { return m__root; }
        mdl_t* _parent() const { return m__parent; }
    };

    /**
     * Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
     */

    class geometry_header_t : public kaitai::kstruct {

    public:

        geometry_header_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~geometry_header_t();

    private:
        bool f_is_kotor2;
        bool m_is_kotor2;

    public:

        /**
         * True if this is a KOTOR 2 model
         */
        bool is_kotor2();

    private:
        uint32_t m_function_pointer_0;
        uint32_t m_function_pointer_1;
        std::string m_model_name;
        uint32_t m_root_node_offset;
        uint32_t m_node_count;
        array_definition_t* m_unknown_array_1;
        array_definition_t* m_unknown_array_2;
        uint32_t m_reference_count;
        uint8_t m_geometry_type;
        std::vector<uint8_t>* m_padding;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Game engine version identifier:
         * - KOTOR 1 PC: 4273776 (0x413670)
         * - KOTOR 2 PC: 4285200 (0x416310)
         * - KOTOR 1 Xbox: 4254992 (0x40ED10)
         * - KOTOR 2 Xbox: 4285872 (0x4165B0)
         */
        uint32_t function_pointer_0() const { return m_function_pointer_0; }

        /**
         * Function pointer to ASCII model parser
         */
        uint32_t function_pointer_1() const { return m_function_pointer_1; }

        /**
         * Model name, null-terminated string, max 32 (0x20) bytes
         */
        std::string model_name() const { return m_model_name; }

        /**
         * Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
         */
        uint32_t root_node_offset() const { return m_root_node_offset; }

        /**
         * Total number of nodes in model hierarchy, unsigned 32-bit integer
         */
        uint32_t node_count() const { return m_node_count; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        array_definition_t* unknown_array_1() const { return m_unknown_array_1; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        array_definition_t* unknown_array_2() const { return m_unknown_array_2; }

        /**
         * Reference count (initialized to 0, incremented when model is referenced)
         */
        uint32_t reference_count() const { return m_reference_count; }

        /**
         * Geometry type:
         * - 0x01: Basic geometry header (not in models)
         * - 0x02: Model geometry header
         * - 0x05: Animation geometry header
         * If bit 7 (0x80) is set, model is compiled binary with absolute addresses
         */
        uint8_t geometry_type() const { return m_geometry_type; }

        /**
         * Padding bytes for alignment
         */
        std::vector<uint8_t>* padding() const { return m_padding; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Light header (92 bytes)
     */

    class light_header_t : public kaitai::kstruct {

    public:

        light_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~light_header_t();

    private:
        std::vector<float>* m_unknown;
        uint32_t m_flare_sizes_offset;
        uint32_t m_flare_sizes_count;
        uint32_t m_flare_sizes_count_duplicate;
        uint32_t m_flare_positions_offset;
        uint32_t m_flare_positions_count;
        uint32_t m_flare_positions_count_duplicate;
        uint32_t m_flare_color_shifts_offset;
        uint32_t m_flare_color_shifts_count;
        uint32_t m_flare_color_shifts_count_duplicate;
        uint32_t m_flare_texture_names_offset;
        uint32_t m_flare_texture_names_count;
        uint32_t m_flare_texture_names_count_duplicate;
        float m_flare_radius;
        uint32_t m_light_priority;
        uint32_t m_ambient_only;
        uint32_t m_dynamic_type;
        uint32_t m_affect_dynamic;
        uint32_t m_shadow;
        uint32_t m_flare;
        uint32_t m_fading_light;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Purpose unknown, possibly padding or reserved values
         */
        std::vector<float>* unknown() const { return m_unknown; }

        /**
         * Offset to flare sizes array (floats)
         */
        uint32_t flare_sizes_offset() const { return m_flare_sizes_offset; }

        /**
         * Number of flare size entries
         */
        uint32_t flare_sizes_count() const { return m_flare_sizes_count; }

        /**
         * Duplicate of flare sizes count
         */
        uint32_t flare_sizes_count_duplicate() const { return m_flare_sizes_count_duplicate; }

        /**
         * Offset to flare positions array (floats, 0.0-1.0 along light ray)
         */
        uint32_t flare_positions_offset() const { return m_flare_positions_offset; }

        /**
         * Number of flare position entries
         */
        uint32_t flare_positions_count() const { return m_flare_positions_count; }

        /**
         * Duplicate of flare positions count
         */
        uint32_t flare_positions_count_duplicate() const { return m_flare_positions_count_duplicate; }

        /**
         * Offset to flare color shift array (RGB floats)
         */
        uint32_t flare_color_shifts_offset() const { return m_flare_color_shifts_offset; }

        /**
         * Number of flare color shift entries
         */
        uint32_t flare_color_shifts_count() const { return m_flare_color_shifts_count; }

        /**
         * Duplicate of flare color shifts count
         */
        uint32_t flare_color_shifts_count_duplicate() const { return m_flare_color_shifts_count_duplicate; }

        /**
         * Offset to flare texture name string offsets array
         */
        uint32_t flare_texture_names_offset() const { return m_flare_texture_names_offset; }

        /**
         * Number of flare texture names
         */
        uint32_t flare_texture_names_count() const { return m_flare_texture_names_count; }

        /**
         * Duplicate of flare texture names count
         */
        uint32_t flare_texture_names_count_duplicate() const { return m_flare_texture_names_count_duplicate; }

        /**
         * Radius of flare effect
         */
        float flare_radius() const { return m_flare_radius; }

        /**
         * Rendering priority for light culling/sorting
         */
        uint32_t light_priority() const { return m_light_priority; }

        /**
         * 1 if light only affects ambient, 0 for full lighting
         */
        uint32_t ambient_only() const { return m_ambient_only; }

        /**
         * Type of dynamic lighting behavior
         */
        uint32_t dynamic_type() const { return m_dynamic_type; }

        /**
         * 1 if light affects dynamic objects, 0 otherwise
         */
        uint32_t affect_dynamic() const { return m_affect_dynamic; }

        /**
         * 1 if light casts shadows, 0 otherwise
         */
        uint32_t shadow() const { return m_shadow; }

        /**
         * 1 if lens flare effect enabled, 0 otherwise
         */
        uint32_t flare() const { return m_flare; }

        /**
         * 1 if light intensity fades with distance, 0 otherwise
         */
        uint32_t fading_light() const { return m_fading_light; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
     */

    class lightsaber_header_t : public kaitai::kstruct {

    public:

        lightsaber_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~lightsaber_header_t();

    private:
        trimesh_header_t* m_trimesh_base;
        uint32_t m_vertices_offset;
        uint32_t m_texcoords_offset;
        uint32_t m_normals_offset;
        uint32_t m_unknown1;
        uint32_t m_unknown2;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Standard trimesh header
         */
        trimesh_header_t* trimesh_base() const { return m_trimesh_base; }

        /**
         * Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
         */
        uint32_t vertices_offset() const { return m_vertices_offset; }

        /**
         * Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
         */
        uint32_t texcoords_offset() const { return m_texcoords_offset; }

        /**
         * Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
         */
        uint32_t normals_offset() const { return m_normals_offset; }

        /**
         * Purpose unknown
         */
        uint32_t unknown1() const { return m_unknown1; }

        /**
         * Purpose unknown
         */
        uint32_t unknown2() const { return m_unknown2; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
     * Wraps the header so repeated root instances can use parametric types (user guide).
     */

    class mdl_animation_entry_t : public kaitai::kstruct {

    public:

        mdl_animation_entry_t(uint32_t p_anim_index, kaitai::kstream* p__io, mdl_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~mdl_animation_entry_t();

    private:
        bool f_header;
        animation_header_t* m_header;

    public:
        animation_header_t* header();

    private:
        uint32_t m_anim_index;
        mdl_t* m__root;
        mdl_t* m__parent;

    public:
        uint32_t anim_index() const { return m_anim_index; }
        mdl_t* _root() const { return m__root; }
        mdl_t* _parent() const { return m__parent; }
    };

    /**
     * Model header (196 bytes) starting at offset 12 (data_start).
     * This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
     * model-wide metadata, offsets, and counts.
     */

    class model_header_t : public kaitai::kstruct {

    public:

        model_header_t(kaitai::kstream* p__io, mdl_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~model_header_t();

    private:
        geometry_header_t* m_geometry;
        bioware_mdl_common_t::model_classification_t m_model_type;
        uint8_t m_unknown0;
        uint8_t m_padding0;
        uint8_t m_fog;
        uint32_t m_unknown1;
        uint32_t m_offset_to_animations;
        uint32_t m_animation_count;
        uint32_t m_animation_count2;
        uint32_t m_unknown2;
        vec3f_t* m_bounding_box_min;
        vec3f_t* m_bounding_box_max;
        float m_radius;
        float m_animation_scale;
        std::string m_supermodel_name;
        uint32_t m_offset_to_super_root;
        uint32_t m_unknown3;
        uint32_t m_mdx_data_size;
        uint32_t m_mdx_data_offset;
        uint32_t m_offset_to_name_offsets;
        uint32_t m_name_offsets_count;
        uint32_t m_name_offsets_count2;
        mdl_t* m__root;
        mdl_t* m__parent;

    public:

        /**
         * Geometry header (80 bytes)
         */
        geometry_header_t* geometry() const { return m_geometry; }

        /**
         * Model classification byte
         */
        bioware_mdl_common_t::model_classification_t model_type() const { return m_model_type; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        uint8_t unknown0() const { return m_unknown0; }

        /**
         * Padding byte
         */
        uint8_t padding0() const { return m_padding0; }

        /**
         * Fog interaction (1 = affected, 0 = ignore fog)
         */
        uint8_t fog() const { return m_fog; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        uint32_t unknown1() const { return m_unknown1; }

        /**
         * Offset to animation offset array (relative to data_start)
         */
        uint32_t offset_to_animations() const { return m_offset_to_animations; }

        /**
         * Number of animations
         */
        uint32_t animation_count() const { return m_animation_count; }

        /**
         * Duplicate animation count / allocated count
         */
        uint32_t animation_count2() const { return m_animation_count2; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        uint32_t unknown2() const { return m_unknown2; }

        /**
         * Minimum coordinates of bounding box (X, Y, Z)
         */
        vec3f_t* bounding_box_min() const { return m_bounding_box_min; }

        /**
         * Maximum coordinates of bounding box (X, Y, Z)
         */
        vec3f_t* bounding_box_max() const { return m_bounding_box_max; }

        /**
         * Radius of model's bounding sphere
         */
        float radius() const { return m_radius; }

        /**
         * Scale factor for animations (typically 1.0)
         */
        float animation_scale() const { return m_animation_scale; }

        /**
         * Name of supermodel (null-terminated string, "null" if empty)
         */
        std::string supermodel_name() const { return m_supermodel_name; }

        /**
         * TODO: VERIFY - offset to super-root node (relative to data_start)
         */
        uint32_t offset_to_super_root() const { return m_offset_to_super_root; }

        /**
         * TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
         */
        uint32_t unknown3() const { return m_unknown3; }

        /**
         * Size of MDX file data in bytes
         */
        uint32_t mdx_data_size() const { return m_mdx_data_size; }

        /**
         * Offset to MDX data (typically 0)
         */
        uint32_t mdx_data_offset() const { return m_mdx_data_offset; }

        /**
         * Offset to name offset array (relative to data_start)
         */
        uint32_t offset_to_name_offsets() const { return m_offset_to_name_offsets; }

        /**
         * Count of name offsets / partnames
         */
        uint32_t name_offsets_count() const { return m_name_offsets_count; }

        /**
         * Duplicate name offsets count / allocated count
         */
        uint32_t name_offsets_count2() const { return m_name_offsets_count2; }
        mdl_t* _root() const { return m__root; }
        mdl_t* _parent() const { return m__parent; }
    };

    /**
     * Array of null-terminated name strings
     */

    class name_strings_t : public kaitai::kstruct {

    public:

        name_strings_t(kaitai::kstream* p__io, mdl_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~name_strings_t();

    private:
        std::vector<std::string>* m_strings;
        mdl_t* m__root;
        mdl_t* m__parent;

    public:
        std::vector<std::string>* strings() const { return m_strings; }
        mdl_t* _root() const { return m__root; }
        mdl_t* _parent() const { return m__parent; }
    };

    /**
     * Node structure - starts with 80-byte header, followed by type-specific sub-header
     */

    class node_t : public kaitai::kstruct {

    public:

        node_t(kaitai::kstream* p__io, mdl_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~node_t();

    private:
        node_header_t* m_header;
        light_header_t* m_light_sub_header;
        bool n_light_sub_header;

    public:
        bool _is_null_light_sub_header() { light_sub_header(); return n_light_sub_header; };

    private:
        emitter_header_t* m_emitter_sub_header;
        bool n_emitter_sub_header;

    public:
        bool _is_null_emitter_sub_header() { emitter_sub_header(); return n_emitter_sub_header; };

    private:
        reference_header_t* m_reference_sub_header;
        bool n_reference_sub_header;

    public:
        bool _is_null_reference_sub_header() { reference_sub_header(); return n_reference_sub_header; };

    private:
        trimesh_header_t* m_trimesh_sub_header;
        bool n_trimesh_sub_header;

    public:
        bool _is_null_trimesh_sub_header() { trimesh_sub_header(); return n_trimesh_sub_header; };

    private:
        skinmesh_header_t* m_skinmesh_sub_header;
        bool n_skinmesh_sub_header;

    public:
        bool _is_null_skinmesh_sub_header() { skinmesh_sub_header(); return n_skinmesh_sub_header; };

    private:
        animmesh_header_t* m_animmesh_sub_header;
        bool n_animmesh_sub_header;

    public:
        bool _is_null_animmesh_sub_header() { animmesh_sub_header(); return n_animmesh_sub_header; };

    private:
        danglymesh_header_t* m_danglymesh_sub_header;
        bool n_danglymesh_sub_header;

    public:
        bool _is_null_danglymesh_sub_header() { danglymesh_sub_header(); return n_danglymesh_sub_header; };

    private:
        aabb_header_t* m_aabb_sub_header;
        bool n_aabb_sub_header;

    public:
        bool _is_null_aabb_sub_header() { aabb_sub_header(); return n_aabb_sub_header; };

    private:
        lightsaber_header_t* m_lightsaber_sub_header;
        bool n_lightsaber_sub_header;

    public:
        bool _is_null_lightsaber_sub_header() { lightsaber_sub_header(); return n_lightsaber_sub_header; };

    private:
        mdl_t* m__root;
        mdl_t* m__parent;

    public:
        node_header_t* header() const { return m_header; }
        light_header_t* light_sub_header() const { return m_light_sub_header; }
        emitter_header_t* emitter_sub_header() const { return m_emitter_sub_header; }
        reference_header_t* reference_sub_header() const { return m_reference_sub_header; }
        trimesh_header_t* trimesh_sub_header() const { return m_trimesh_sub_header; }
        skinmesh_header_t* skinmesh_sub_header() const { return m_skinmesh_sub_header; }
        animmesh_header_t* animmesh_sub_header() const { return m_animmesh_sub_header; }
        danglymesh_header_t* danglymesh_sub_header() const { return m_danglymesh_sub_header; }
        aabb_header_t* aabb_sub_header() const { return m_aabb_sub_header; }
        lightsaber_header_t* lightsaber_sub_header() const { return m_lightsaber_sub_header; }
        mdl_t* _root() const { return m__root; }
        mdl_t* _parent() const { return m__parent; }
    };

    /**
     * Node header (80 bytes) - present in all node types
     */

    class node_header_t : public kaitai::kstruct {

    public:

        node_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~node_header_t();

    private:
        bool f_has_aabb;
        bool m_has_aabb;

    public:
        bool has_aabb();

    private:
        bool f_has_anim;
        bool m_has_anim;

    public:
        bool has_anim();

    private:
        bool f_has_dangly;
        bool m_has_dangly;

    public:
        bool has_dangly();

    private:
        bool f_has_emitter;
        bool m_has_emitter;

    public:
        bool has_emitter();

    private:
        bool f_has_light;
        bool m_has_light;

    public:
        bool has_light();

    private:
        bool f_has_mesh;
        bool m_has_mesh;

    public:
        bool has_mesh();

    private:
        bool f_has_reference;
        bool m_has_reference;

    public:
        bool has_reference();

    private:
        bool f_has_saber;
        bool m_has_saber;

    public:
        bool has_saber();

    private:
        bool f_has_skin;
        bool m_has_skin;

    public:
        bool has_skin();

    private:
        uint16_t m_node_type;
        uint16_t m_node_index;
        uint16_t m_node_name_index;
        uint16_t m_padding;
        uint32_t m_root_node_offset;
        uint32_t m_parent_node_offset;
        vec3f_t* m_position;
        quaternion_t* m_orientation;
        uint32_t m_child_array_offset;
        uint32_t m_child_count;
        uint32_t m_child_count_duplicate;
        uint32_t m_controller_array_offset;
        uint32_t m_controller_count;
        uint32_t m_controller_count_duplicate;
        uint32_t m_controller_data_offset;
        uint32_t m_controller_data_count;
        uint32_t m_controller_data_count_duplicate;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Bitmask indicating node features (also carries the primary node kind in the composite values listed in
         * `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
         * - 0x0001: NODE_HAS_HEADER
         * - 0x0002: NODE_HAS_LIGHT
         * - 0x0004: NODE_HAS_EMITTER
         * - 0x0008: NODE_HAS_CAMERA
         * - 0x0010: NODE_HAS_REFERENCE
         * - 0x0020: NODE_HAS_MESH
         * - 0x0040: NODE_HAS_SKIN
         * - 0x0080: NODE_HAS_ANIM
         * - 0x0100: NODE_HAS_DANGLY
         * - 0x0200: NODE_HAS_AABB
         * - 0x0800: NODE_HAS_SABER
         */
        uint16_t node_type() const { return m_node_type; }

        /**
         * Sequential index of this node in the model
         */
        uint16_t node_index() const { return m_node_index; }

        /**
         * Index into names array for this node's name
         */
        uint16_t node_name_index() const { return m_node_name_index; }

        /**
         * Padding for alignment
         */
        uint16_t padding() const { return m_padding; }

        /**
         * Offset to model's root node
         */
        uint32_t root_node_offset() const { return m_root_node_offset; }

        /**
         * Offset to this node's parent node (0 if root)
         */
        uint32_t parent_node_offset() const { return m_parent_node_offset; }

        /**
         * Node position in local space (X, Y, Z)
         */
        vec3f_t* position() const { return m_position; }

        /**
         * Node orientation as quaternion (W, X, Y, Z)
         */
        quaternion_t* orientation() const { return m_orientation; }

        /**
         * Offset to array of child node offsets
         */
        uint32_t child_array_offset() const { return m_child_array_offset; }

        /**
         * Number of child nodes
         */
        uint32_t child_count() const { return m_child_count; }

        /**
         * Duplicate value of child count
         */
        uint32_t child_count_duplicate() const { return m_child_count_duplicate; }

        /**
         * Offset to array of controller structures
         */
        uint32_t controller_array_offset() const { return m_controller_array_offset; }

        /**
         * Number of controllers attached to this node
         */
        uint32_t controller_count() const { return m_controller_count; }

        /**
         * Duplicate value of controller count
         */
        uint32_t controller_count_duplicate() const { return m_controller_count_duplicate; }

        /**
         * Offset to controller keyframe/data array
         */
        uint32_t controller_data_offset() const { return m_controller_data_offset; }

        /**
         * Number of floats in controller data array
         */
        uint32_t controller_data_count() const { return m_controller_data_count; }

        /**
         * Duplicate value of controller data count
         */
        uint32_t controller_data_count_duplicate() const { return m_controller_data_count_duplicate; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Quaternion rotation (4 floats W, X, Y, Z)
     */

    class quaternion_t : public kaitai::kstruct {

    public:

        quaternion_t(kaitai::kstream* p__io, mdl_t::node_header_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~quaternion_t();

    private:
        float m_w;
        float m_x;
        float m_y;
        float m_z;
        mdl_t* m__root;
        mdl_t::node_header_t* m__parent;

    public:
        float w() const { return m_w; }
        float x() const { return m_x; }
        float y() const { return m_y; }
        float z() const { return m_z; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_header_t* _parent() const { return m__parent; }
    };

    /**
     * Reference header (36 bytes)
     */

    class reference_header_t : public kaitai::kstruct {

    public:

        reference_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~reference_header_t();

    private:
        std::string m_model_resref;
        uint32_t m_reattachable;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Referenced model resource name without extension (null-terminated string)
         */
        std::string model_resref() const { return m_model_resref; }

        /**
         * 1 if model can be detached and reattached dynamically, 0 if permanent
         */
        uint32_t reattachable() const { return m_reattachable; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
     */

    class skinmesh_header_t : public kaitai::kstruct {

    public:

        skinmesh_header_t(kaitai::kstream* p__io, mdl_t::node_t* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~skinmesh_header_t();

    private:
        trimesh_header_t* m_trimesh_base;
        int32_t m_unknown_weights;
        std::vector<uint8_t>* m_padding1;
        uint32_t m_mdx_bone_weights_offset;
        uint32_t m_mdx_bone_indices_offset;
        uint32_t m_bone_map_offset;
        uint32_t m_bone_map_count;
        uint32_t m_qbones_offset;
        uint32_t m_qbones_count;
        uint32_t m_qbones_count_duplicate;
        uint32_t m_tbones_offset;
        uint32_t m_tbones_count;
        uint32_t m_tbones_count_duplicate;
        uint32_t m_unknown_array;
        std::vector<uint16_t>* m_bone_node_serial_numbers;
        uint16_t m_padding2;
        mdl_t* m__root;
        mdl_t::node_t* m__parent;

    public:

        /**
         * Standard trimesh header
         */
        trimesh_header_t* trimesh_base() const { return m_trimesh_base; }

        /**
         * Purpose unknown (possibly compilation weights)
         */
        int32_t unknown_weights() const { return m_unknown_weights; }

        /**
         * Padding
         */
        std::vector<uint8_t>* padding1() const { return m_padding1; }

        /**
         * Offset to bone weight data in MDX file (4 floats per vertex)
         */
        uint32_t mdx_bone_weights_offset() const { return m_mdx_bone_weights_offset; }

        /**
         * Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
         */
        uint32_t mdx_bone_indices_offset() const { return m_mdx_bone_indices_offset; }

        /**
         * Offset to bone map array (maps local bone indices to skeleton bone numbers)
         */
        uint32_t bone_map_offset() const { return m_bone_map_offset; }

        /**
         * Number of bones referenced by this mesh (max 16)
         */
        uint32_t bone_map_count() const { return m_bone_map_count; }

        /**
         * Offset to quaternion bind pose array (4 floats per bone)
         */
        uint32_t qbones_offset() const { return m_qbones_offset; }

        /**
         * Number of quaternion bind poses
         */
        uint32_t qbones_count() const { return m_qbones_count; }

        /**
         * Duplicate of QBones count
         */
        uint32_t qbones_count_duplicate() const { return m_qbones_count_duplicate; }

        /**
         * Offset to translation bind pose array (3 floats per bone)
         */
        uint32_t tbones_offset() const { return m_tbones_offset; }

        /**
         * Number of translation bind poses
         */
        uint32_t tbones_count() const { return m_tbones_count; }

        /**
         * Duplicate of TBones count
         */
        uint32_t tbones_count_duplicate() const { return m_tbones_count_duplicate; }

        /**
         * Purpose unknown
         */
        uint32_t unknown_array() const { return m_unknown_array; }

        /**
         * Serial indices of bone nodes (0xFFFF for unused slots)
         */
        std::vector<uint16_t>* bone_node_serial_numbers() const { return m_bone_node_serial_numbers; }

        /**
         * Padding for alignment
         */
        uint16_t padding2() const { return m_padding2; }
        mdl_t* _root() const { return m__root; }
        mdl_t::node_t* _parent() const { return m__parent; }
    };

    /**
     * Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
     */

    class trimesh_header_t : public kaitai::kstruct {

    public:

        trimesh_header_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~trimesh_header_t();

    private:
        uint32_t m_function_pointer_0;
        uint32_t m_function_pointer_1;
        uint32_t m_faces_array_offset;
        uint32_t m_faces_count;
        uint32_t m_faces_count_duplicate;
        vec3f_t* m_bounding_box_min;
        vec3f_t* m_bounding_box_max;
        float m_radius;
        vec3f_t* m_average_point;
        vec3f_t* m_diffuse_color;
        vec3f_t* m_ambient_color;
        uint32_t m_transparency_hint;
        std::string m_texture_0_name;
        std::string m_texture_1_name;
        std::string m_texture_2_name;
        std::string m_texture_3_name;
        uint32_t m_indices_count_array_offset;
        uint32_t m_indices_count_array_count;
        uint32_t m_indices_count_array_count_duplicate;
        uint32_t m_indices_offset_array_offset;
        uint32_t m_indices_offset_array_count;
        uint32_t m_indices_offset_array_count_duplicate;
        uint32_t m_inverted_counter_array_offset;
        uint32_t m_inverted_counter_array_count;
        uint32_t m_inverted_counter_array_count_duplicate;
        std::vector<int32_t>* m_unknown_values;
        std::vector<uint8_t>* m_saber_unknown_data;
        uint32_t m_unknown;
        vec3f_t* m_uv_direction;
        float m_uv_jitter;
        float m_uv_jitter_speed;
        uint32_t m_mdx_vertex_size;
        uint32_t m_mdx_data_flags;
        int32_t m_mdx_vertices_offset;
        int32_t m_mdx_normals_offset;
        int32_t m_mdx_vertex_colors_offset;
        int32_t m_mdx_tex0_uvs_offset;
        int32_t m_mdx_tex1_uvs_offset;
        int32_t m_mdx_tex2_uvs_offset;
        int32_t m_mdx_tex3_uvs_offset;
        int32_t m_mdx_tangent_space_offset;
        int32_t m_mdx_unknown_offset_1;
        int32_t m_mdx_unknown_offset_2;
        int32_t m_mdx_unknown_offset_3;
        uint16_t m_vertex_count;
        uint16_t m_texture_count;
        uint8_t m_lightmapped;
        uint8_t m_rotate_texture;
        uint8_t m_background_geometry;
        uint8_t m_shadow;
        uint8_t m_beaming;
        uint8_t m_render;
        uint8_t m_unknown_flag;
        uint8_t m_padding;
        float m_total_area;
        uint32_t m_unknown2;
        uint32_t m_k2_unknown_1;
        bool n_k2_unknown_1;

    public:
        bool _is_null_k2_unknown_1() { k2_unknown_1(); return n_k2_unknown_1; };

    private:
        uint32_t m_k2_unknown_2;
        bool n_k2_unknown_2;

    public:
        bool _is_null_k2_unknown_2() { k2_unknown_2(); return n_k2_unknown_2; };

    private:
        uint32_t m_mdx_data_offset;
        uint32_t m_mdl_vertices_offset;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Game engine function pointer (version-specific)
         */
        uint32_t function_pointer_0() const { return m_function_pointer_0; }

        /**
         * Secondary game engine function pointer
         */
        uint32_t function_pointer_1() const { return m_function_pointer_1; }

        /**
         * Offset to face definitions array
         */
        uint32_t faces_array_offset() const { return m_faces_array_offset; }

        /**
         * Number of triangular faces in mesh
         */
        uint32_t faces_count() const { return m_faces_count; }

        /**
         * Duplicate of faces count
         */
        uint32_t faces_count_duplicate() const { return m_faces_count_duplicate; }

        /**
         * Minimum bounding box coordinates (X, Y, Z)
         */
        vec3f_t* bounding_box_min() const { return m_bounding_box_min; }

        /**
         * Maximum bounding box coordinates (X, Y, Z)
         */
        vec3f_t* bounding_box_max() const { return m_bounding_box_max; }

        /**
         * Bounding sphere radius
         */
        float radius() const { return m_radius; }

        /**
         * Average vertex position (centroid) X, Y, Z
         */
        vec3f_t* average_point() const { return m_average_point; }

        /**
         * Material diffuse color (R, G, B, range 0.0-1.0)
         */
        vec3f_t* diffuse_color() const { return m_diffuse_color; }

        /**
         * Material ambient color (R, G, B, range 0.0-1.0)
         */
        vec3f_t* ambient_color() const { return m_ambient_color; }

        /**
         * Transparency rendering mode
         */
        uint32_t transparency_hint() const { return m_transparency_hint; }

        /**
         * Primary diffuse texture name (null-terminated string)
         */
        std::string texture_0_name() const { return m_texture_0_name; }

        /**
         * Secondary texture name, often lightmap (null-terminated string)
         */
        std::string texture_1_name() const { return m_texture_1_name; }

        /**
         * Tertiary texture name (null-terminated string)
         */
        std::string texture_2_name() const { return m_texture_2_name; }

        /**
         * Quaternary texture name (null-terminated string)
         */
        std::string texture_3_name() const { return m_texture_3_name; }

        /**
         * Offset to vertex indices count array
         */
        uint32_t indices_count_array_offset() const { return m_indices_count_array_offset; }

        /**
         * Number of entries in indices count array
         */
        uint32_t indices_count_array_count() const { return m_indices_count_array_count; }

        /**
         * Duplicate of indices count array count
         */
        uint32_t indices_count_array_count_duplicate() const { return m_indices_count_array_count_duplicate; }

        /**
         * Offset to vertex indices offset array
         */
        uint32_t indices_offset_array_offset() const { return m_indices_offset_array_offset; }

        /**
         * Number of entries in indices offset array
         */
        uint32_t indices_offset_array_count() const { return m_indices_offset_array_count; }

        /**
         * Duplicate of indices offset array count
         */
        uint32_t indices_offset_array_count_duplicate() const { return m_indices_offset_array_count_duplicate; }

        /**
         * Offset to inverted counter array
         */
        uint32_t inverted_counter_array_offset() const { return m_inverted_counter_array_offset; }

        /**
         * Number of entries in inverted counter array
         */
        uint32_t inverted_counter_array_count() const { return m_inverted_counter_array_count; }

        /**
         * Duplicate of inverted counter array count
         */
        uint32_t inverted_counter_array_count_duplicate() const { return m_inverted_counter_array_count_duplicate; }

        /**
         * Typically {-1, -1, 0}, purpose unknown
         */
        std::vector<int32_t>* unknown_values() const { return m_unknown_values; }

        /**
         * Data specific to lightsaber meshes
         */
        std::vector<uint8_t>* saber_unknown_data() const { return m_saber_unknown_data; }

        /**
         * Purpose unknown
         */
        uint32_t unknown() const { return m_unknown; }

        /**
         * UV animation direction X, Y components (Z = jitter speed)
         */
        vec3f_t* uv_direction() const { return m_uv_direction; }

        /**
         * UV animation jitter amount
         */
        float uv_jitter() const { return m_uv_jitter; }

        /**
         * UV animation jitter speed
         */
        float uv_jitter_speed() const { return m_uv_jitter_speed; }

        /**
         * Size in bytes of each vertex in MDX data
         */
        uint32_t mdx_vertex_size() const { return m_mdx_vertex_size; }

        /**
         * Bitmask of present vertex attributes:
         * - 0x00000001: MDX_VERTICES (vertex positions)
         * - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
         * - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
         * - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
         * - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
         * - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
         * - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
         * - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
         */
        uint32_t mdx_data_flags() const { return m_mdx_data_flags; }

        /**
         * Relative offset to vertex positions in MDX (or -1 if none)
         */
        int32_t mdx_vertices_offset() const { return m_mdx_vertices_offset; }

        /**
         * Relative offset to vertex normals in MDX (or -1 if none)
         */
        int32_t mdx_normals_offset() const { return m_mdx_normals_offset; }

        /**
         * Relative offset to vertex colors in MDX (or -1 if none)
         */
        int32_t mdx_vertex_colors_offset() const { return m_mdx_vertex_colors_offset; }

        /**
         * Relative offset to primary texture UVs in MDX (or -1 if none)
         */
        int32_t mdx_tex0_uvs_offset() const { return m_mdx_tex0_uvs_offset; }

        /**
         * Relative offset to secondary texture UVs in MDX (or -1 if none)
         */
        int32_t mdx_tex1_uvs_offset() const { return m_mdx_tex1_uvs_offset; }

        /**
         * Relative offset to tertiary texture UVs in MDX (or -1 if none)
         */
        int32_t mdx_tex2_uvs_offset() const { return m_mdx_tex2_uvs_offset; }

        /**
         * Relative offset to quaternary texture UVs in MDX (or -1 if none)
         */
        int32_t mdx_tex3_uvs_offset() const { return m_mdx_tex3_uvs_offset; }

        /**
         * Relative offset to tangent space data in MDX (or -1 if none)
         */
        int32_t mdx_tangent_space_offset() const { return m_mdx_tangent_space_offset; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        int32_t mdx_unknown_offset_1() const { return m_mdx_unknown_offset_1; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        int32_t mdx_unknown_offset_2() const { return m_mdx_unknown_offset_2; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        int32_t mdx_unknown_offset_3() const { return m_mdx_unknown_offset_3; }

        /**
         * Number of vertices in mesh
         */
        uint16_t vertex_count() const { return m_vertex_count; }

        /**
         * Number of textures used by mesh
         */
        uint16_t texture_count() const { return m_texture_count; }

        /**
         * 1 if mesh uses lightmap, 0 otherwise
         */
        uint8_t lightmapped() const { return m_lightmapped; }

        /**
         * 1 if texture should rotate, 0 otherwise
         */
        uint8_t rotate_texture() const { return m_rotate_texture; }

        /**
         * 1 if background geometry, 0 otherwise
         */
        uint8_t background_geometry() const { return m_background_geometry; }

        /**
         * 1 if mesh casts shadows, 0 otherwise
         */
        uint8_t shadow() const { return m_shadow; }

        /**
         * 1 if beaming effect enabled, 0 otherwise
         */
        uint8_t beaming() const { return m_beaming; }

        /**
         * 1 if mesh is renderable, 0 if hidden
         */
        uint8_t render() const { return m_render; }

        /**
         * Purpose unknown (possibly UV animation enable)
         */
        uint8_t unknown_flag() const { return m_unknown_flag; }

        /**
         * Padding byte
         */
        uint8_t padding() const { return m_padding; }

        /**
         * Total surface area of all faces
         */
        float total_area() const { return m_total_area; }

        /**
         * Purpose unknown
         */
        uint32_t unknown2() const { return m_unknown2; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        uint32_t k2_unknown_1() const { return m_k2_unknown_1; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        uint32_t k2_unknown_2() const { return m_k2_unknown_2; }

        /**
         * Absolute offset to this mesh's vertex data in MDX file
         */
        uint32_t mdx_data_offset() const { return m_mdx_data_offset; }

        /**
         * Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
         */
        uint32_t mdl_vertices_offset() const { return m_mdl_vertices_offset; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * 3D vector (3 floats)
     */

    class vec3f_t : public kaitai::kstruct {

    public:

        vec3f_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~vec3f_t();

    private:
        float m_x;
        float m_y;
        float m_z;
        mdl_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        float x() const { return m_x; }
        float y() const { return m_y; }
        float z() const { return m_z; }
        mdl_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    bool f_animation_offsets;
    std::vector<uint32_t>* m_animation_offsets;
    bool n_animation_offsets;

public:
    bool _is_null_animation_offsets() { animation_offsets(); return n_animation_offsets; };

private:

public:

    /**
     * Animation header offsets (relative to data_start)
     */
    std::vector<uint32_t>* animation_offsets();

private:
    bool f_animations;
    std::vector<mdl_animation_entry_t*>* m_animations;
    bool n_animations;

public:
    bool _is_null_animations() { animations(); return n_animations; };

private:

public:

    /**
     * Animation headers (via offset table). Each list element is `mdl_animation_entry`;
     * the parsed header is `element.header` (same wire layout as `animation_header`).
     */
    std::vector<mdl_animation_entry_t*>* animations();

private:
    bool f_data_start;
    int8_t m_data_start;

public:

    /**
     * MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
     * section, which begins immediately after the 12-byte file header.
     */
    int8_t data_start();

private:
    bool f_name_offsets;
    std::vector<uint32_t>* m_name_offsets;
    bool n_name_offsets;

public:
    bool _is_null_name_offsets() { name_offsets(); return n_name_offsets; };

private:

public:

    /**
     * Name string offsets (relative to data_start)
     */
    std::vector<uint32_t>* name_offsets();

private:
    bool f_names_data;
    name_strings_t* m_names_data;
    bool n_names_data;

public:
    bool _is_null_names_data() { names_data(); return n_names_data; };

private:

public:

    /**
     * Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
     * Parsed as null-terminated ASCII strings in `name_strings`.
     */
    name_strings_t* names_data();

private:
    bool f_root_node;
    node_t* m_root_node;
    bool n_root_node;

public:
    bool _is_null_root_node() { root_node(); return n_root_node; };

private:

public:
    node_t* root_node();

private:
    file_header_t* m_file_header;
    model_header_t* m_model_header;
    mdl_t* m__root;
    kaitai::kstruct* m__parent;
    std::string m__raw_names_data;
    bool n__raw_names_data;

public:
    bool _is_null__raw_names_data() { _raw_names_data(); return n__raw_names_data; };

private:
    kaitai::kstream* m__io__raw_names_data;

public:
    file_header_t* file_header() const { return m_file_header; }
    model_header_t* model_header() const { return m_model_header; }
    mdl_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
    std::string _raw_names_data() const { return m__raw_names_data; }
    kaitai::kstream* _io__raw_names_data() const { return m__io__raw_names_data; }
};

#endif  // MDL_H_

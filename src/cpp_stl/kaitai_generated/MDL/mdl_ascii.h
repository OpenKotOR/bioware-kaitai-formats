#ifndef MDL_ASCII_H_
#define MDL_ASCII_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class mdl_ascii_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
 * Used by modding tools for easier editing than binary MDL format.
 * 
 * The ASCII format represents the model structure using plain text with keyword-based syntax.
 * Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
 * 
 * Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
 * documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
 * full binary-vs-text scope rule.
 * 
 * Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
 * Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
 * Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
 * and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88 xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format PyKotor wiki — ASCII MDL
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format PyKotor wiki — binary MDL (wire vs ASCII)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — readasciimdl
 */

class mdl_ascii_t : public kaitai::kstruct {

public:
    class animation_section_t;
    class ascii_line_t;
    class controller_bezier_t;
    class controller_bezier_keyframe_t;
    class controller_keyed_t;
    class controller_keyframe_t;
    class controller_single_t;
    class danglymesh_properties_t;
    class data_arrays_t;
    class emitter_flags_t;
    class emitter_properties_t;
    class light_properties_t;
    class line_text_t;
    class reference_properties_t;

    mdl_ascii_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~mdl_ascii_t();

    /**
     * Animation section keywords
     */

    class animation_section_t : public kaitai::kstruct {

    public:

        animation_section_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~animation_section_t();

    private:
        line_text_t* m_newanim;
        line_text_t* m_doneanim;
        line_text_t* m_length;
        line_text_t* m_transtime;
        line_text_t* m_animroot;
        line_text_t* m_event;
        line_text_t* m_eventlist;
        line_text_t* m_endlist;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * newanim <animation_name> <model_name> - Start of animation definition
         */
        line_text_t* newanim() const { return m_newanim; }

        /**
         * doneanim <animation_name> <model_name> - End of animation definition
         */
        line_text_t* doneanim() const { return m_doneanim; }

        /**
         * length <duration> - Animation duration in seconds
         */
        line_text_t* length() const { return m_length; }

        /**
         * transtime <transition_time> - Transition/blend time to this animation in seconds
         */
        line_text_t* transtime() const { return m_transtime; }

        /**
         * animroot <root_node_name> - Root node name for animation
         */
        line_text_t* animroot() const { return m_animroot; }

        /**
         * event <time> <event_name> - Animation event (triggers at specified time)
         */
        line_text_t* event() const { return m_event; }

        /**
         * eventlist - Start of animation events list
         */
        line_text_t* eventlist() const { return m_eventlist; }

        /**
         * endlist - End of list (controllers, events, etc.)
         */
        line_text_t* endlist() const { return m_endlist; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Single line in ASCII MDL file
     */

    class ascii_line_t : public kaitai::kstruct {

    public:

        ascii_line_t(kaitai::kstream* p__io, mdl_ascii_t* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~ascii_line_t();

    private:
        std::string m_content;
        mdl_ascii_t* m__root;
        mdl_ascii_t* m__parent;

    public:
        std::string content() const { return m_content; }
        mdl_ascii_t* _root() const { return m__root; }
        mdl_ascii_t* _parent() const { return m__parent; }
    };

    /**
     * Bezier (smooth animated) controller format
     */

    class controller_bezier_t : public kaitai::kstruct {

    public:

        controller_bezier_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_bezier_t();

    private:
        line_text_t* m_controller_name;
        std::vector<controller_bezier_keyframe_t*>* m_keyframes;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
         */
        line_text_t* controller_name() const { return m_controller_name; }

        /**
         * Keyframe entries until endlist keyword
         */
        std::vector<controller_bezier_keyframe_t*>* keyframes() const { return m_keyframes; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
     */

    class controller_bezier_keyframe_t : public kaitai::kstruct {

    public:

        controller_bezier_keyframe_t(kaitai::kstream* p__io, mdl_ascii_t::controller_bezier_t* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_bezier_keyframe_t();

    private:
        std::string m_time;
        std::string m_value_data;
        mdl_ascii_t* m__root;
        mdl_ascii_t::controller_bezier_t* m__parent;

    public:

        /**
         * Time value (float)
         */
        std::string time() const { return m_time; }

        /**
         * Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
         */
        std::string value_data() const { return m_value_data; }
        mdl_ascii_t* _root() const { return m__root; }
        mdl_ascii_t::controller_bezier_t* _parent() const { return m__parent; }
    };

    /**
     * Keyed (animated) controller format
     */

    class controller_keyed_t : public kaitai::kstruct {

    public:

        controller_keyed_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_keyed_t();

    private:
        line_text_t* m_controller_name;
        std::vector<controller_keyframe_t*>* m_keyframes;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Controller name followed by 'key' (e.g., positionkey, orientationkey)
         */
        line_text_t* controller_name() const { return m_controller_name; }

        /**
         * Keyframe entries until endlist keyword
         */
        std::vector<controller_keyframe_t*>* keyframes() const { return m_keyframes; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Single keyframe in keyed controller
     */

    class controller_keyframe_t : public kaitai::kstruct {

    public:

        controller_keyframe_t(kaitai::kstream* p__io, mdl_ascii_t::controller_keyed_t* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_keyframe_t();

    private:
        std::string m_time;
        std::string m_values;
        mdl_ascii_t* m__root;
        mdl_ascii_t::controller_keyed_t* m__parent;

    public:

        /**
         * Time value (float)
         */
        std::string time() const { return m_time; }

        /**
         * Space-separated property values (number depends on controller type and column count)
         */
        std::string values() const { return m_values; }
        mdl_ascii_t* _root() const { return m__root; }
        mdl_ascii_t::controller_keyed_t* _parent() const { return m__parent; }
    };

    /**
     * Single (constant) controller format
     */

    class controller_single_t : public kaitai::kstruct {

    public:

        controller_single_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~controller_single_t();

    private:
        line_text_t* m_controller_name;
        line_text_t* m_values;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * Controller name (position, orientation, scale, color, radius, etc.)
         */
        line_text_t* controller_name() const { return m_controller_name; }

        /**
         * Space-separated controller values (number depends on controller type)
         */
        line_text_t* values() const { return m_values; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Danglymesh node properties
     */

    class danglymesh_properties_t : public kaitai::kstruct {

    public:

        danglymesh_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~danglymesh_properties_t();

    private:
        line_text_t* m_displacement;
        line_text_t* m_tightness;
        line_text_t* m_period;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * displacement <value> - Maximum displacement distance for physics simulation
         */
        line_text_t* displacement() const { return m_displacement; }

        /**
         * tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
         */
        line_text_t* tightness() const { return m_tightness; }

        /**
         * period <value> - Oscillation period in seconds
         */
        line_text_t* period() const { return m_period; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Data array keywords
     */

    class data_arrays_t : public kaitai::kstruct {

    public:

        data_arrays_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~data_arrays_t();

    private:
        line_text_t* m_verts;
        line_text_t* m_faces;
        line_text_t* m_tverts;
        line_text_t* m_tverts1;
        line_text_t* m_lightmaptverts;
        line_text_t* m_tverts2;
        line_text_t* m_tverts3;
        line_text_t* m_texindices1;
        line_text_t* m_texindices2;
        line_text_t* m_texindices3;
        line_text_t* m_colors;
        line_text_t* m_colorindices;
        line_text_t* m_weights;
        line_text_t* m_constraints;
        line_text_t* m_aabb;
        line_text_t* m_saber_verts;
        line_text_t* m_saber_norms;
        line_text_t* m_name;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        line_text_t* verts() const { return m_verts; }

        /**
         * faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
         */
        line_text_t* faces() const { return m_faces; }

        /**
         * tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        line_text_t* tverts() const { return m_tverts; }

        /**
         * tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        line_text_t* tverts1() const { return m_tverts1; }

        /**
         * lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
         */
        line_text_t* lightmaptverts() const { return m_lightmaptverts; }

        /**
         * tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        line_text_t* tverts2() const { return m_tverts2; }

        /**
         * tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
         */
        line_text_t* tverts3() const { return m_tverts3; }

        /**
         * texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
         */
        line_text_t* texindices1() const { return m_texindices1; }

        /**
         * texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
         */
        line_text_t* texindices2() const { return m_texindices2; }

        /**
         * texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
         */
        line_text_t* texindices3() const { return m_texindices3; }

        /**
         * colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
         */
        line_text_t* colors() const { return m_colors; }

        /**
         * colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
         */
        line_text_t* colorindices() const { return m_colorindices; }

        /**
         * weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
         */
        line_text_t* weights() const { return m_weights; }

        /**
         * constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
         */
        line_text_t* constraints() const { return m_constraints; }

        /**
         * aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
         */
        line_text_t* aabb() const { return m_aabb; }

        /**
         * saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
         */
        line_text_t* saber_verts() const { return m_saber_verts; }

        /**
         * saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
         */
        line_text_t* saber_norms() const { return m_saber_norms; }

        /**
         * name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
         */
        line_text_t* name() const { return m_name; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Emitter behavior flags
     */

    class emitter_flags_t : public kaitai::kstruct {

    public:

        emitter_flags_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~emitter_flags_t();

    private:
        line_text_t* m_p2p;
        line_text_t* m_p2p_sel;
        line_text_t* m_affected_by_wind;
        line_text_t* m_m_is_tinted;
        line_text_t* m_bounce;
        line_text_t* m_random;
        line_text_t* m_inherit;
        line_text_t* m_inheritvel;
        line_text_t* m_inherit_local;
        line_text_t* m_splat;
        line_text_t* m_inherit_part;
        line_text_t* m_depth_texture;
        line_text_t* m_emitterflag13;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * p2p <0_or_1> - Point-to-point flag (bit 0x0001)
         */
        line_text_t* p2p() const { return m_p2p; }

        /**
         * p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
         */
        line_text_t* p2p_sel() const { return m_p2p_sel; }

        /**
         * affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
         */
        line_text_t* affected_by_wind() const { return m_affected_by_wind; }

        /**
         * m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
         */
        line_text_t* m_is_tinted() const { return m_m_is_tinted; }

        /**
         * bounce <0_or_1> - Bounce flag (bit 0x0010)
         */
        line_text_t* bounce() const { return m_bounce; }

        /**
         * random <0_or_1> - Random flag (bit 0x0020)
         */
        line_text_t* random() const { return m_random; }

        /**
         * inherit <0_or_1> - Inherit flag (bit 0x0040)
         */
        line_text_t* inherit() const { return m_inherit; }

        /**
         * inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
         */
        line_text_t* inheritvel() const { return m_inheritvel; }

        /**
         * inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
         */
        line_text_t* inherit_local() const { return m_inherit_local; }

        /**
         * splat <0_or_1> - Splat flag (bit 0x0200)
         */
        line_text_t* splat() const { return m_splat; }

        /**
         * inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
         */
        line_text_t* inherit_part() const { return m_inherit_part; }

        /**
         * depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
         */
        line_text_t* depth_texture() const { return m_depth_texture; }

        /**
         * emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
         */
        line_text_t* emitterflag13() const { return m_emitterflag13; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Emitter node properties
     */

    class emitter_properties_t : public kaitai::kstruct {

    public:

        emitter_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~emitter_properties_t();

    private:
        line_text_t* m_deadspace;
        line_text_t* m_blast_radius;
        line_text_t* m_blast_length;
        line_text_t* m_num_branches;
        line_text_t* m_controlptsmoothing;
        line_text_t* m_xgrid;
        line_text_t* m_ygrid;
        line_text_t* m_spawntype;
        line_text_t* m_update;
        line_text_t* m_render;
        line_text_t* m_blend;
        line_text_t* m_texture;
        line_text_t* m_chunkname;
        line_text_t* m_twosidedtex;
        line_text_t* m_loop;
        line_text_t* m_renderorder;
        line_text_t* m_m_b_frame_blending;
        line_text_t* m_m_s_depth_texture_name;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * deadspace <value> - Minimum distance from emitter before particles become visible
         */
        line_text_t* deadspace() const { return m_deadspace; }

        /**
         * blastRadius <value> - Radius of explosive/blast particle effects
         */
        line_text_t* blast_radius() const { return m_blast_radius; }

        /**
         * blastLength <value> - Length/duration of blast effects
         */
        line_text_t* blast_length() const { return m_blast_length; }

        /**
         * numBranches <value> - Number of branching paths for particle trails
         */
        line_text_t* num_branches() const { return m_num_branches; }

        /**
         * controlptsmoothing <value> - Smoothing factor for particle path control points
         */
        line_text_t* controlptsmoothing() const { return m_controlptsmoothing; }

        /**
         * xgrid <value> - Grid subdivisions along X axis for particle spawning
         */
        line_text_t* xgrid() const { return m_xgrid; }

        /**
         * ygrid <value> - Grid subdivisions along Y axis for particle spawning
         */
        line_text_t* ygrid() const { return m_ygrid; }

        /**
         * spawntype <value> - Particle spawn type
         */
        line_text_t* spawntype() const { return m_spawntype; }

        /**
         * update <script_name> - Update behavior script name (e.g., single, fountain)
         */
        line_text_t* update() const { return m_update; }

        /**
         * render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
         */
        line_text_t* render() const { return m_render; }

        /**
         * blend <script_name> - Blend mode script name (e.g., normal, lighten)
         */
        line_text_t* blend() const { return m_blend; }

        /**
         * texture <texture_name> - Particle texture name
         */
        line_text_t* texture() const { return m_texture; }

        /**
         * chunkname <chunk_name> - Associated model chunk name
         */
        line_text_t* chunkname() const { return m_chunkname; }

        /**
         * twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
         */
        line_text_t* twosidedtex() const { return m_twosidedtex; }

        /**
         * loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
         */
        line_text_t* loop() const { return m_loop; }

        /**
         * renderorder <value> - Rendering priority/order for particle sorting
         */
        line_text_t* renderorder() const { return m_renderorder; }

        /**
         * m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
         */
        line_text_t* m_b_frame_blending() const { return m_m_b_frame_blending; }

        /**
         * m_sDepthTextureName <texture_name> - Depth/softparticle texture name
         */
        line_text_t* m_s_depth_texture_name() const { return m_m_s_depth_texture_name; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Light node properties
     */

    class light_properties_t : public kaitai::kstruct {

    public:

        light_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~light_properties_t();

    private:
        line_text_t* m_flareradius;
        line_text_t* m_flarepositions;
        line_text_t* m_flaresizes;
        line_text_t* m_flarecolorshifts;
        line_text_t* m_texturenames;
        line_text_t* m_ambientonly;
        line_text_t* m_ndynamictype;
        line_text_t* m_affectdynamic;
        line_text_t* m_flare;
        line_text_t* m_lightpriority;
        line_text_t* m_fadinglight;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * flareradius <value> - Radius of lens flare effect
         */
        line_text_t* flareradius() const { return m_flareradius; }

        /**
         * flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
         */
        line_text_t* flarepositions() const { return m_flarepositions; }

        /**
         * flaresizes <count> - Start flare sizes array (count floats)
         */
        line_text_t* flaresizes() const { return m_flaresizes; }

        /**
         * flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
         */
        line_text_t* flarecolorshifts() const { return m_flarecolorshifts; }

        /**
         * texturenames <count> - Start flare texture names array (count strings)
         */
        line_text_t* texturenames() const { return m_texturenames; }

        /**
         * ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
         */
        line_text_t* ambientonly() const { return m_ambientonly; }

        /**
         * ndynamictype <value> - Type of dynamic lighting behavior
         */
        line_text_t* ndynamictype() const { return m_ndynamictype; }

        /**
         * affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
         */
        line_text_t* affectdynamic() const { return m_affectdynamic; }

        /**
         * flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
         */
        line_text_t* flare() const { return m_flare; }

        /**
         * lightpriority <value> - Rendering priority for light culling/sorting
         */
        line_text_t* lightpriority() const { return m_lightpriority; }

        /**
         * fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
         */
        line_text_t* fadinglight() const { return m_fadinglight; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * A single UTF-8 text line (without the trailing newline).
     * Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
     */

    class line_text_t : public kaitai::kstruct {

    public:

        line_text_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~line_text_t();

    private:
        std::string m_value;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        std::string value() const { return m_value; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    /**
     * Reference node properties
     */

    class reference_properties_t : public kaitai::kstruct {

    public:

        reference_properties_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mdl_ascii_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~reference_properties_t();

    private:
        line_text_t* m_refmodel;
        line_text_t* m_reattachable;
        mdl_ascii_t* m__root;
        kaitai::kstruct* m__parent;

    public:

        /**
         * refmodel <model_resref> - Referenced model resource name without extension
         */
        line_text_t* refmodel() const { return m_refmodel; }

        /**
         * reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
         */
        line_text_t* reattachable() const { return m_reattachable; }
        mdl_ascii_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

private:
    std::vector<ascii_line_t*>* m_lines;
    mdl_ascii_t* m__root;
    kaitai::kstruct* m__parent;

public:
    std::vector<ascii_line_t*>* lines() const { return m_lines; }
    mdl_ascii_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // MDL_ASCII_H_

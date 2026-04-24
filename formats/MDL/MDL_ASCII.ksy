meta:
  id: mdl_ascii
  title: BioWare MDL ASCII Format
  license: MIT
  endian: le
  file-extension: mdl.ascii
  encoding: UTF-8
  ks-version: 0.11
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor_mdlops: https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L3916-L4698
    pykotor_wiki_mdl: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    xoreos_docs_torlack_binmdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/binmdl.html
    bioware_mdl_common_wire_enums: |
      Binary MDL/MDX wire enums: `formats/Common/bioware_mdl_common.ksy` (`model_classification`, `node_type_value`, `controller_type`).
      ASCII keyword integers in MDLOps are a **tooling** namespace; compare wiki binary section + Torlack binmdl for semantics.
    xoreos_model_kotor_h_parser_context: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.h#L45-L79
    xoreos_types_kfiletype_mdl_mdx: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L81-L88
doc: |
  MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
  Used by modding tools for easier editing than binary MDL format.

  The ASCII format represents the model structure using plain text with keyword-based syntax.
  Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.

  Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
  documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
  full binary-vs-text scope rule.

  Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
  Reference: https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
  Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
  and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L81-L88 xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format PyKotor wiki — ASCII MDL"
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format PyKotor wiki — binary MDL (wire vs ASCII)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl"
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)"
  - "https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L3916-L4698 Community MDLOps — readasciimdl"

seq:
  - id: lines
    type: ascii_line
    repeat: eos

types:
  line_text:
    doc: |
      A single UTF-8 text line (without the trailing newline).
      Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
    seq:
      - id: value
        type: str
        encoding: UTF-8
        terminator: 10
        include: false
        consume: true
        eos-error: false

  ascii_line:
    doc: Single line in ASCII MDL file
    seq:
      - id: content
        type: str
        encoding: UTF-8
        terminator: 10
        include: false
        consume: true
        eos-error: false
  # NOTE:
  # ASCII MDL is not a regular binary format: it is a keyword-driven text grammar.
  # This `.ksy` intentionally exposes the file as a sequence of lines (`ascii_line`).
  # Higher-level semantic parsing (keywords -> nodes/meshes/controllers) is performed by application code.

  light_properties:
    doc: Light node properties
    seq:
      - id: flareradius
        type: line_text
        doc: "flareradius <value> - Radius of lens flare effect"
      - id: flarepositions
        type: line_text
        doc: "flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)"
      - id: flaresizes
        type: line_text
        doc: "flaresizes <count> - Start flare sizes array (count floats)"
      - id: flarecolorshifts
        type: line_text
        doc: "flarecolorshifts <count> - Start flare color shifts array (count RGB floats)"
      - id: texturenames
        type: line_text
        doc: "texturenames <count> - Start flare texture names array (count strings)"
      - id: ambientonly
        type: line_text
        doc: "ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)"
      - id: ndynamictype
        type: line_text
        doc: "ndynamictype <value> - Type of dynamic lighting behavior"
      - id: affectdynamic
        type: line_text
        doc: "affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)"
      - id: flare
        type: line_text
        doc: "flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)"
      - id: lightpriority
        type: line_text
        doc: "lightpriority <value> - Rendering priority for light culling/sorting"
      - id: fadinglight
        type: line_text
        doc: "fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)"

  emitter_properties:
    doc: Emitter node properties
    seq:
      - id: deadspace
        type: line_text
        doc: "deadspace <value> - Minimum distance from emitter before particles become visible"
      - id: blast_radius
        type: line_text
        doc: "blastRadius <value> - Radius of explosive/blast particle effects"
      - id: blast_length
        type: line_text
        doc: "blastLength <value> - Length/duration of blast effects"
      - id: num_branches
        type: line_text
        doc: "numBranches <value> - Number of branching paths for particle trails"
      - id: controlptsmoothing
        type: line_text
        doc: "controlptsmoothing <value> - Smoothing factor for particle path control points"
      - id: xgrid
        type: line_text
        doc: "xgrid <value> - Grid subdivisions along X axis for particle spawning"
      - id: ygrid
        type: line_text
        doc: "ygrid <value> - Grid subdivisions along Y axis for particle spawning"
      - id: spawntype
        type: line_text
        doc: "spawntype <value> - Particle spawn type"
      - id: update
        type: line_text
        doc: "update <script_name> - Update behavior script name (e.g., single, fountain)"
      - id: render
        type: line_text
        doc: "render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)"
      - id: blend
        type: line_text
        doc: "blend <script_name> - Blend mode script name (e.g., normal, lighten)"
      - id: texture
        type: line_text
        doc: "texture <texture_name> - Particle texture name"
      - id: chunkname
        type: line_text
        doc: "chunkname <chunk_name> - Associated model chunk name"
      - id: twosidedtex
        type: line_text
        doc: "twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)"
      - id: loop
        type: line_text
        doc: "loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)"
      - id: renderorder
        type: line_text
        doc: "renderorder <value> - Rendering priority/order for particle sorting"
      - id: m_b_frame_blending
        type: line_text
        doc: "m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)"
      - id: m_s_depth_texture_name
        type: line_text
        doc: "m_sDepthTextureName <texture_name> - Depth/softparticle texture name"

  emitter_flags:
    doc: Emitter behavior flags
    seq:
      - id: p2p
        type: line_text
        doc: "p2p <0_or_1> - Point-to-point flag (bit 0x0001)"
      - id: p2p_sel
        type: line_text
        doc: "p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)"
      - id: affected_by_wind
        type: line_text
        doc: "affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)"
      - id: m_is_tinted
        type: line_text
        doc: "m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)"
      - id: bounce
        type: line_text
        doc: "bounce <0_or_1> - Bounce flag (bit 0x0010)"
      - id: random
        type: line_text
        doc: "random <0_or_1> - Random flag (bit 0x0020)"
      - id: inherit
        type: line_text
        doc: "inherit <0_or_1> - Inherit flag (bit 0x0040)"
      - id: inheritvel
        type: line_text
        doc: "inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)"
      - id: inherit_local
        type: line_text
        doc: "inherit_local <0_or_1> - Inherit local flag (bit 0x0100)"
      - id: splat
        type: line_text
        doc: "splat <0_or_1> - Splat flag (bit 0x0200)"
      - id: inherit_part
        type: line_text
        doc: "inherit_part <0_or_1> - Inherit part flag (bit 0x0400)"
      - id: depth_texture
        type: line_text
        doc: "depth_texture <0_or_1> - Depth texture flag (bit 0x0800)"
      - id: emitterflag13
        type: line_text
        doc: "emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)"

  reference_properties:
    doc: Reference node properties
    seq:
      - id: refmodel
        type: line_text
        doc: "refmodel <model_resref> - Referenced model resource name without extension"
      - id: reattachable
        type: line_text
        doc: "reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)"

  danglymesh_properties:
    doc: Danglymesh node properties
    seq:
      - id: displacement
        type: line_text
        doc: "displacement <value> - Maximum displacement distance for physics simulation"
      - id: tightness
        type: line_text
        doc: "tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)"
      - id: period
        type: line_text
        doc: "period <value> - Oscillation period in seconds"

  data_arrays:
    doc: Data array keywords
    seq:
      - id: verts
        type: line_text
        doc: "verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)"
      - id: faces
        type: line_text
        doc: "faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])"
      - id: tverts
        type: line_text
        doc: "tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)"
      - id: tverts1
        type: line_text
        doc: "tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)"
      - id: lightmaptverts
        type: line_text
        doc: "lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)"
      - id: tverts2
        type: line_text
        doc: "tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)"
      - id: tverts3
        type: line_text
        doc: "tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)"
      - id: texindices1
        type: line_text
        doc: "texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)"
      - id: texindices2
        type: line_text
        doc: "texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)"
      - id: texindices3
        type: line_text
        doc: "texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)"
      - id: colors
        type: line_text
        doc: "colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)"
      - id: colorindices
        type: line_text
        doc: "colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)"
      - id: weights
        type: line_text
        doc: "weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])"
      - id: constraints
        type: line_text
        doc: "constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)"
      - id: aabb
        type: line_text
        doc: "aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)"
      - id: saber_verts
        type: line_text
        doc: "saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)"
      - id: saber_norms
        type: line_text
        doc: "saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)"
      - id: name
        type: line_text
        doc: "name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)"

  animation_section:
    doc: Animation section keywords
    seq:
      - id: newanim
        type: line_text
        doc: "newanim <animation_name> <model_name> - Start of animation definition"
      - id: doneanim
        type: line_text
        doc: "doneanim <animation_name> <model_name> - End of animation definition"
      - id: length
        type: line_text
        doc: "length <duration> - Animation duration in seconds"
      - id: transtime
        type: line_text
        doc: "transtime <transition_time> - Transition/blend time to this animation in seconds"
      - id: animroot
        type: line_text
        doc: "animroot <root_node_name> - Root node name for animation"
      - id: event
        type: line_text
        doc: "event <time> <event_name> - Animation event (triggers at specified time)"
      - id: eventlist
        type: line_text
        doc: "eventlist - Start of animation events list"
      - id: endlist
        type: line_text
        doc: "endlist - End of list (controllers, events, etc.)"

  controller_single:
    doc: Single (constant) controller format
    seq:
      - id: controller_name
        type: line_text
        doc: Controller name (position, orientation, scale, color, radius, etc.)
      - id: values
        type: line_text
        doc: Space-separated controller values (number depends on controller type)

  controller_keyed:
    doc: Keyed (animated) controller format
    seq:
      - id: controller_name
        type: line_text
        doc: Controller name followed by 'key' (e.g., positionkey, orientationkey)
      - id: keyframes
        type: controller_keyframe
        repeat: eos
        doc: Keyframe entries until endlist keyword

  controller_bezier:
    doc: Bezier (smooth animated) controller format
    seq:
      - id: controller_name
        type: line_text
        doc: Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
      - id: keyframes
        type: controller_bezier_keyframe
        repeat: eos
        doc: Keyframe entries until endlist keyword

  controller_keyframe:
    doc: Single keyframe in keyed controller
    seq:
      - id: time
        type: str
        size-eos: true
        encoding: UTF-8
        doc: Time value (float)
      - id: values
        type: str
        size-eos: true
        encoding: UTF-8
        doc: Space-separated property values (number depends on controller type and column count)

  controller_bezier_keyframe:
    doc: Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
    seq:
      - id: time
        type: str
        size-eos: true
        encoding: UTF-8
        doc: Time value (float)
      - id: value_data
        type: str
        size-eos: true
        encoding: UTF-8
        doc: "Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)"

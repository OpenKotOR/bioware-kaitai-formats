meta:
  id: mdl
  file-extension: mdl
  endian: le
  encoding: ASCII
  ks-version: 0.11
  license: MIT
  title: BioWare MDL (Model) Binary Format
  imports:
    - ../Common/bioware_mdl_common
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    mdl_model_header_unknown_fields_policy: |
      Several `model_header` u1/u4 slots and `offset_to_super_root` semantics still carry `TODO: VERIFY` in field `doc:` text.
      They are retained for **PyKotor / MDLOps round-trip** compatibility until **observed behavior** in the game executables
      or upstream parsers pins them. Treat unknowns as **opaque preserved fields**, not gameplay-authoritative layout.
    pykotor_wiki_mdl: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    pykotor_io_mdl_tree: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/mdl/
    pykotor_io_mdl_binary_reader: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408
    pykotor_io_mdl_kaitai_probe: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2332-L2338
    pykotor_mdl_data: https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/mdl/mdl_data.py#L1283-L1322
    mdlops: https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L342-L407
    mdlops_upstream_mirror: https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L342-L4698
    xoreos_model_kotor_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.cpp#L184-L267
    xoreos_model_kotor_parser_context: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.cpp#L123-L140
    xoreos_model_kotor_h_parser_context: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.h#L45-L79
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
    xoreos_docs_torlack_binmdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/binmdl.html
    reone_mdlmdxreader_load: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118
    kotor_js_mdl_loader: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/loaders/MDLLoader.ts#L66-L150
    kotor_js_odyssey_model_constructor: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyModel.ts#L56-L170
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43
doc: |
  BioWare MDL Model Format

  The MDL file contains:
  - File header (12 (0xc) bytes)
  - Model header (196 (0xc4) bytes) which begins with a Geometry header (80 (0x50) bytes)
  - Name offset array + name strings
  - Animation offset array + animation headers + animation nodes
  - Node hierarchy with geometry data

  Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.

  Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.

  Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
  are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
  compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
doc-ref:
  - "https://github.com/OpenKotOR/bioware-kaitai-formats/blob/f4700f43f20337e01b8ef751a7c7d42e0acfb00a/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — MDLBinaryReader (binary MDL/MDX)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — Model_KotOR::load"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller / Aurora background)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118 reone — MdlMdxReader::load"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/odyssey/OdysseyModel.ts#L56-L170 KotOR.js — OdysseyModel binary constructor"
  - "https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L342-L407 Community MDLOps — controller name table"
  - "https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L3916-L4698 Community MDLOps — `readasciimdl` (ASCII MDL ingest)"

seq:
  - id: file_header
    type: file_header
  - id: model_header
    type: model_header

instances:
  data_start:
    value: 12
    doc: |
      MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
      section, which begins immediately after the 12 (0xc)-byte file header.

  name_offsets:
    type: u4
    repeat: expr
    repeat-expr: model_header.name_offsets_count
    if: model_header.name_offsets_count > 0
    pos: data_start + model_header.offset_to_name_offsets
    doc: Name string offsets (relative to data_start)

  names_data:
    type: name_strings
    if: model_header.name_offsets_count > 0
    pos: data_start + model_header.offset_to_name_offsets + (4 * model_header.name_offsets_count)
    size: (data_start + model_header.offset_to_animations) - (data_start + model_header.offset_to_name_offsets + (4 * model_header.name_offsets_count))
    doc: |
      Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
      Parsed as null-terminated ASCII strings in `name_strings`.

  animation_offsets:
    type: u4
    repeat: expr
    repeat-expr: model_header.animation_count
    if: model_header.animation_count > 0
    pos: data_start + model_header.offset_to_animations
    doc: Animation header offsets (relative to data_start)

  # Per Kaitai Struct user guide § sparse offset tables: `pos` on a repeated *instance*
  # is not applied per element the way we need here; the Python backend hoists a single
  # seek using `_index` / `i` *before* the repeat loop (broken). Use a parametric wrapper
  # that receives `_index` and reads `animation_header` at `animation_offsets[anim_index]`.
  animations:
    type: mdl_animation_entry(_index)
    repeat: expr
    repeat-expr: model_header.animation_count
    if: model_header.animation_count > 0
    doc: |
      Animation headers (via offset table). Each list element is `mdl_animation_entry`;
      the parsed header is `element.header` (same wire layout as `animation_header`).

  root_node:
    type: node
    if: model_header.geometry.root_node_offset > 0
    pos: data_start + model_header.geometry.root_node_offset

types:
  file_header:
    doc: MDL file header (12 (0xc) bytes)
    seq:
      - id: unused
        type: u4
        doc: Always 0
      - id: mdl_size
        type: u4
        doc: Size of MDL file in bytes
      - id: mdx_size
        type: u4
        doc: Size of MDX file in bytes

  geometry_header:
    doc: Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
    seq:
      - id: function_pointer_0
        type: u4
        doc: |
          Game engine version identifier:
          - KOTOR 1 PC: 4273776 (0x413670)
          - KOTOR 2 PC: 4285200 (0x416310)
          - KOTOR 1 Xbox: 4254992 (0x40ED10)
          - KOTOR 2 Xbox: 4285872 (0x4165B0)
      - id: function_pointer_1
        type: u4
        doc: Function pointer to ASCII model parser
      - id: model_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Model name, null-terminated string, max 32 (0x20) bytes
      - id: root_node_offset
        type: u4
        doc: Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
      - id: node_count
        type: u4
        doc: Total number of nodes in model hierarchy, unsigned 32-bit integer
      - id: unknown_array_1
        type: array_definition
        doc: Unknown array definition (offset, count, count duplicate)
      - id: unknown_array_2
        type: array_definition
        doc: Unknown array definition (offset, count, count duplicate)
      - id: reference_count
        type: u4
        doc: Reference count (initialized to 0, incremented when model is referenced)
      - id: geometry_type
        type: u1
        doc: |
          Geometry type:
          - 0x01: Basic geometry header (not in models)
          - 0x02: Model geometry header
          - 0x05: Animation geometry header
          If bit 7 (0x80) is set, model is compiled binary with absolute addresses
      - id: padding
        type: u1
        repeat: expr
        repeat-expr: 3
        doc: Padding bytes for alignment
    instances:
      is_kotor2:
        value: function_pointer_0 == 4285200 or function_pointer_0 == 4285872
        doc: True if this is a KOTOR 2 model

  array_definition:
    doc: Array definition structure (offset, count, count duplicate)
    seq:
      - id: offset
        type: s4
        doc: Offset to array (relative to MDL data start, offset 12 (0xc))
      - id: count
        type: u4
        doc: Number of used entries
      - id: count_duplicate
        type: u4
        doc: Duplicate of count (allocated entries)

  model_header:
    doc: |
      Model header (196 (0xc4) bytes) starting at offset 12 (0xc) (data_start).
      This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
      model-wide metadata, offsets, and counts.
    seq:
      - id: geometry
        type: geometry_header
        doc: Geometry header (80 (0x50) bytes)
      - id: model_type
        type: u1
        enum: bioware_mdl_common::model_classification
        doc: Model classification byte
      - id: unknown0
        type: u1
        doc: 'TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)'
      - id: padding0
        type: u1
        doc: Padding byte
      - id: fog
        type: u1
        doc: Fog interaction (1 = affected, 0 = ignore fog)
      - id: unknown1
        type: u4
        doc: 'TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)'
      - id: offset_to_animations
        type: u4
        doc: Offset to animation offset array (relative to data_start)
      - id: animation_count
        type: u4
        doc: Number of animations
      - id: animation_count2
        type: u4
        doc: Duplicate animation count / allocated count
      - id: unknown2
        type: u4
        doc: 'TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)'
      - id: bounding_box_min
        type: vec3f
        doc: Minimum coordinates of bounding box (X, Y, Z)
      - id: bounding_box_max
        type: vec3f
        doc: Maximum coordinates of bounding box (X, Y, Z)
      - id: radius
        type: f4
        doc: Radius of model's bounding sphere
      - id: animation_scale
        type: f4
        doc: Scale factor for animations (typically 1.0)
      - id: supermodel_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Name of supermodel (null-terminated string, "null" if empty)
      - id: offset_to_super_root
        type: u4
        doc: 'TODO: VERIFY - offset to super-root node (relative to data_start)'
      - id: unknown3
        type: u4
        doc: 'TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)'
      - id: mdx_data_size
        type: u4
        doc: Size of MDX file data in bytes
      - id: mdx_data_offset
        type: u4
        doc: Offset to MDX data (typically 0)
      - id: offset_to_name_offsets
        type: u4
        doc: Offset to name offset array (relative to data_start)
      - id: name_offsets_count
        type: u4
        doc: Count of name offsets / partnames
      - id: name_offsets_count2
        type: u4
        doc: Duplicate name offsets count / allocated count

  vec3f:
    doc: 3D vector (3 floats)
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  quaternion:
    doc: Quaternion rotation (4 floats W, X, Y, Z)
    seq:
      - id: w
        type: f4
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  # NOTE: Older revisions modeled a separate 'names_header' + contiguous names blob.
  # Real-world MDL uses the model_header tail fields (offset_to_name_offsets + counts) and
  # name offsets point to null-terminated strings scattered in the name block.

  name_strings:
    doc: Array of null-terminated name strings
    seq:
      - id: strings
        type: str
        repeat: eos
        encoding: ASCII
        terminator: 0

  mdl_animation_entry:
    doc: |
      One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
      Wraps the header so repeated root instances can use parametric types (user guide).
    params:
      - id: anim_index
        type: u4
    instances:
      header:
        type: animation_header
        pos: _root.data_start + _root.animation_offsets[anim_index]

  animation_header:
    doc: Animation header (136 (0x88) bytes = 80 (0x50) byte geometry header + 56 (0x38) byte animation header)
    seq:
      - id: geo_header
        type: geometry_header
        doc: Standard 80 (0x50)-byte geometry header (geometry_type = 0x01 for animation)
      - id: animation_length
        type: f4
        doc: Duration of animation in seconds
      - id: transition_time
        type: f4
        doc: Transition/blend time to this animation in seconds
      - id: animation_root
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Root node name for animation (null-terminated string)
      - id: event_array_offset
        type: u4
        doc: Offset to animation events array
      - id: event_count
        type: u4
        doc: Number of animation events
      - id: event_count_duplicate
        type: u4
        doc: Duplicate value of event count
      - id: unknown
        type: u4
        doc: Purpose unknown

  animation_event:
    doc: Animation event (36 (0x24) bytes)
    seq:
      - id: activation_time
        type: f4
        doc: Time in seconds when event triggers during animation playback
      - id: event_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Name of event (null-terminated string, e.g., "detonate")

  node:
    doc: Node structure - starts with 80 (0x50)-byte header, followed by type-specific sub-header
    seq:
      - id: header
        type: node_header
      - id: light_sub_header
        type: light_header
        if: header.node_type == 3
      - id: emitter_sub_header
        type: emitter_header
        if: header.node_type == 5
      - id: reference_sub_header
        type: reference_header
        if: header.node_type == 17
      - id: trimesh_sub_header
        type: trimesh_header
        if: header.node_type == 33
      - id: skinmesh_sub_header
        type: skinmesh_header
        if: header.node_type == 97
      - id: animmesh_sub_header
        type: animmesh_header
        if: header.node_type == 161
      - id: danglymesh_sub_header
        type: danglymesh_header
        if: header.node_type == 289
      - id: aabb_sub_header
        type: aabb_header
        if: header.node_type == 545
      - id: lightsaber_sub_header
        type: lightsaber_header
        if: header.node_type == 2081

  node_header:
    doc: Node header (80 (0x50) bytes) - present in all node types
    seq:
      - id: node_type
        type: u2
        doc: |
          Bitmask indicating node features (also carries the primary node kind in the composite values listed in
          `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
          - 0x0001: NODE_HAS_HEADER
          - 0x0002: NODE_HAS_LIGHT
          - 0x0004: NODE_HAS_EMITTER
          - 0x0008: NODE_HAS_CAMERA
          - 0x0010: NODE_HAS_REFERENCE
          - 0x0020: NODE_HAS_MESH
          - 0x0040: NODE_HAS_SKIN
          - 0x0080: NODE_HAS_ANIM
          - 0x0100: NODE_HAS_DANGLY
          - 0x0200: NODE_HAS_AABB
          - 0x0800: NODE_HAS_SABER
      - id: node_index
        type: u2
        doc: Sequential index of this node in the model
      - id: node_name_index
        type: u2
        doc: Index into names array for this node's name
      - id: padding
        type: u2
        doc: Padding for alignment
      - id: root_node_offset
        type: u4
        doc: Offset to model's root node
      - id: parent_node_offset
        type: u4
        doc: Offset to this node's parent node (0 if root)
      - id: position
        type: vec3f
        doc: Node position in local space (X, Y, Z)
      - id: orientation
        type: quaternion
        doc: Node orientation as quaternion (W, X, Y, Z)
      - id: child_array_offset
        type: u4
        doc: Offset to array of child node offsets
      - id: child_count
        type: u4
        doc: Number of child nodes
      - id: child_count_duplicate
        type: u4
        doc: Duplicate value of child count
      - id: controller_array_offset
        type: u4
        doc: Offset to array of controller structures
      - id: controller_count
        type: u4
        doc: Number of controllers attached to this node
      - id: controller_count_duplicate
        type: u4
        doc: Duplicate value of controller count
      - id: controller_data_offset
        type: u4
        doc: Offset to controller keyframe/data array
      - id: controller_data_count
        type: u4
        doc: Number of floats in controller data array
      - id: controller_data_count_duplicate
        type: u4
        doc: Duplicate value of controller data count
    instances:
      has_light:
        value: (node_type & 0x0002) != 0
      has_emitter:
        value: (node_type & 0x0004) != 0
      has_reference:
        value: (node_type & 0x0010) != 0
      has_mesh:
        value: (node_type & 0x0020) != 0
      has_skin:
        value: (node_type & 0x0040) != 0
      has_anim:
        value: (node_type & 0x0080) != 0
      has_dangly:
        value: (node_type & 0x0100) != 0
      has_aabb:
        value: (node_type & 0x0200) != 0
      has_saber:
        value: (node_type & 0x0800) != 0


  light_header:
    doc: Light header (92 (0x5c) bytes)
    seq:
      - id: unknown
        type: f4
        repeat: expr
        repeat-expr: 4
        doc: Purpose unknown, possibly padding or reserved values
      - id: flare_sizes_offset
        type: u4
        doc: Offset to flare sizes array (floats)
      - id: flare_sizes_count
        type: u4
        doc: Number of flare size entries
      - id: flare_sizes_count_duplicate
        type: u4
        doc: Duplicate of flare sizes count
      - id: flare_positions_offset
        type: u4
        doc: Offset to flare positions array (floats, 0.0-1.0 along light ray)
      - id: flare_positions_count
        type: u4
        doc: Number of flare position entries
      - id: flare_positions_count_duplicate
        type: u4
        doc: Duplicate of flare positions count
      - id: flare_color_shifts_offset
        type: u4
        doc: Offset to flare color shift array (RGB floats)
      - id: flare_color_shifts_count
        type: u4
        doc: Number of flare color shift entries
      - id: flare_color_shifts_count_duplicate
        type: u4
        doc: Duplicate of flare color shifts count
      - id: flare_texture_names_offset
        type: u4
        doc: Offset to flare texture name string offsets array
      - id: flare_texture_names_count
        type: u4
        doc: Number of flare texture names
      - id: flare_texture_names_count_duplicate
        type: u4
        doc: Duplicate of flare texture names count
      - id: flare_radius
        type: f4
        doc: Radius of flare effect
      - id: light_priority
        type: u4
        doc: Rendering priority for light culling/sorting
      - id: ambient_only
        type: u4
        doc: 1 if light only affects ambient, 0 for full lighting
      - id: dynamic_type
        type: u4
        doc: Type of dynamic lighting behavior
      - id: affect_dynamic
        type: u4
        doc: 1 if light affects dynamic objects, 0 otherwise
      - id: shadow
        type: u4
        doc: 1 if light casts shadows, 0 otherwise
      - id: flare
        type: u4
        doc: 1 if lens flare effect enabled, 0 otherwise
      - id: fading_light
        type: u4
        doc: 1 if light intensity fades with distance, 0 otherwise

  emitter_header:
    doc: Emitter header (224 (0xe0) bytes)
    seq:
      - id: dead_space
        type: f4
        doc: Minimum distance from emitter before particles become visible
      - id: blast_radius
        type: f4
        doc: Radius of explosive/blast particle effects
      - id: blast_length
        type: f4
        doc: Length/duration of blast effects
      - id: branch_count
        type: u4
        doc: Number of branching paths for particle trails
      - id: control_point_smoothing
        type: f4
        doc: Smoothing factor for particle path control points
      - id: x_grid
        type: u4
        doc: Grid subdivisions along X axis for particle spawning
      - id: y_grid
        type: u4
        doc: Grid subdivisions along Y axis for particle spawning
      - id: padding_unknown
        type: u4
        doc: Purpose unknown or padding
      - id: update_script
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Update behavior script name (e.g., "single", "fountain")
      - id: render_script
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Render mode script name (e.g., "normal", "billboard_to_local_z")
      - id: blend_script
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Blend mode script name (e.g., "normal", "lighten")
      - id: texture_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Particle texture name (null-terminated string)
      - id: chunk_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Associated model chunk name (null-terminated string)
      - id: two_sided_texture
        type: u4
        doc: 1 if texture should render two-sided, 0 for single-sided
      - id: loop
        type: u4
        doc: 1 if particle system loops, 0 for single playback
      - id: render_order
        type: u2
        doc: Rendering priority/order for particle sorting
      - id: frame_blending
        type: u1
        doc: 1 if frame blending enabled, 0 otherwise
      - id: depth_texture_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Depth/softparticle texture name (null-terminated string)
      - id: padding
        type: u1
        doc: Padding byte for alignment
      - id: flags
        type: u4
        doc: Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)

  reference_header:
    doc: Reference header (36 (0x24) bytes)
    seq:
      - id: model_resref
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Referenced model resource name without extension (null-terminated string)
      - id: reattachable
        type: u4
        doc: 1 if model can be detached and reattached dynamically, 0 if permanent

  trimesh_header:
    doc: Trimesh header (332 (0x14c) bytes KOTOR 1, 340 (0x154) bytes KOTOR 2)
    seq:
      - id: function_pointer_0
        type: u4
        doc: Game engine function pointer (version-specific)
      - id: function_pointer_1
        type: u4
        doc: Secondary game engine function pointer
      - id: faces_array_offset
        type: u4
        doc: Offset to face definitions array
      - id: faces_count
        type: u4
        doc: Number of triangular faces in mesh
      - id: faces_count_duplicate
        type: u4
        doc: Duplicate of faces count
      - id: bounding_box_min
        type: vec3f
        doc: Minimum bounding box coordinates (X, Y, Z)
      - id: bounding_box_max
        type: vec3f
        doc: Maximum bounding box coordinates (X, Y, Z)
      - id: radius
        type: f4
        doc: Bounding sphere radius
      - id: average_point
        type: vec3f
        doc: Average vertex position (centroid) X, Y, Z
      - id: diffuse_color
        type: vec3f
        doc: Material diffuse color (R, G, B, range 0.0-1.0)
      - id: ambient_color
        type: vec3f
        doc: Material ambient color (R, G, B, range 0.0-1.0)
      - id: transparency_hint
        type: u4
        doc: Transparency rendering mode
      - id: texture_0_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Primary diffuse texture name (null-terminated string)
      - id: texture_1_name
        type: str
        size: 32
        encoding: ASCII
        terminator: 0
        doc: Secondary texture name, often lightmap (null-terminated string)
      - id: texture_2_name
        type: str
        size: 12
        encoding: ASCII
        terminator: 0
        doc: Tertiary texture name (null-terminated string)
      - id: texture_3_name
        type: str
        size: 12
        encoding: ASCII
        terminator: 0
        doc: Quaternary texture name (null-terminated string)
      - id: indices_count_array_offset
        type: u4
        doc: Offset to vertex indices count array
      - id: indices_count_array_count
        type: u4
        doc: Number of entries in indices count array
      - id: indices_count_array_count_duplicate
        type: u4
        doc: Duplicate of indices count array count
      - id: indices_offset_array_offset
        type: u4
        doc: Offset to vertex indices offset array
      - id: indices_offset_array_count
        type: u4
        doc: Number of entries in indices offset array
      - id: indices_offset_array_count_duplicate
        type: u4
        doc: Duplicate of indices offset array count
      - id: inverted_counter_array_offset
        type: u4
        doc: Offset to inverted counter array
      - id: inverted_counter_array_count
        type: u4
        doc: Number of entries in inverted counter array
      - id: inverted_counter_array_count_duplicate
        type: u4
        doc: Duplicate of inverted counter array count
      - id: unknown_values
        type: s4
        repeat: expr
        repeat-expr: 3
        doc: Typically {-1, -1, 0}, purpose unknown
      - id: saber_unknown_data
        type: u1
        repeat: expr
        repeat-expr: 8
        doc: Data specific to lightsaber meshes
      - id: unknown
        type: u4
        doc: Purpose unknown
      - id: uv_direction
        type: vec3f
        doc: UV animation direction X, Y components (Z = jitter speed)
      - id: uv_jitter
        type: f4
        doc: UV animation jitter amount
      - id: uv_jitter_speed
        type: f4
        doc: UV animation jitter speed
      - id: mdx_vertex_size
        type: u4
        doc: Size in bytes of each vertex in MDX data
      - id: mdx_data_flags
        type: u4
        doc: |
          Bitmask of present vertex attributes:
          - 0x00000001: MDX_VERTICES (vertex positions)
          - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
          - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
          - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
          - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
          - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
          - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
          - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
      - id: mdx_vertices_offset
        type: s4
        doc: Relative offset to vertex positions in MDX (or -1 if none)
      - id: mdx_normals_offset
        type: s4
        doc: Relative offset to vertex normals in MDX (or -1 if none)
      - id: mdx_vertex_colors_offset
        type: s4
        doc: Relative offset to vertex colors in MDX (or -1 if none)
      - id: mdx_tex0_uvs_offset
        type: s4
        doc: Relative offset to primary texture UVs in MDX (or -1 if none)
      - id: mdx_tex1_uvs_offset
        type: s4
        doc: Relative offset to secondary texture UVs in MDX (or -1 if none)
      - id: mdx_tex2_uvs_offset
        type: s4
        doc: Relative offset to tertiary texture UVs in MDX (or -1 if none)
      - id: mdx_tex3_uvs_offset
        type: s4
        doc: Relative offset to quaternary texture UVs in MDX (or -1 if none)
      - id: mdx_tangent_space_offset
        type: s4
        doc: Relative offset to tangent space data in MDX (or -1 if none)
      - id: mdx_unknown_offset_1
        type: s4
        doc: Relative offset to unknown MDX data (or -1 if none)
      - id: mdx_unknown_offset_2
        type: s4
        doc: Relative offset to unknown MDX data (or -1 if none)
      - id: mdx_unknown_offset_3
        type: s4
        doc: Relative offset to unknown MDX data (or -1 if none)
      - id: vertex_count
        type: u2
        doc: Number of vertices in mesh
      - id: texture_count
        type: u2
        doc: Number of textures used by mesh
      - id: lightmapped
        type: u1
        doc: 1 if mesh uses lightmap, 0 otherwise
      - id: rotate_texture
        type: u1
        doc: 1 if texture should rotate, 0 otherwise
      - id: background_geometry
        type: u1
        doc: 1 if background geometry, 0 otherwise
      - id: shadow
        type: u1
        doc: 1 if mesh casts shadows, 0 otherwise
      - id: beaming
        type: u1
        doc: 1 if beaming effect enabled, 0 otherwise
      - id: render
        type: u1
        doc: 1 if mesh is renderable, 0 if hidden
      - id: unknown_flag
        type: u1
        doc: Purpose unknown (possibly UV animation enable)
      - id: padding
        type: u1
        doc: Padding byte
      - id: total_area
        type: f4
        doc: Total surface area of all faces
      - id: unknown2
        type: u4
        doc: Purpose unknown
      - id: k2_unknown_1
        type: u4
        doc: "KOTOR 2 only: Additional unknown field"
        if: _root.model_header.geometry.is_kotor2
      - id: k2_unknown_2
        type: u4
        doc: "KOTOR 2 only: Additional unknown field"
        if: _root.model_header.geometry.is_kotor2
      - id: mdx_data_offset
        type: u4
        doc: Absolute offset to this mesh's vertex data in MDX file
      - id: mdl_vertices_offset
        type: u4
        doc: Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)

  skinmesh_header:
    doc: Skinmesh header (432 (0x1b0) bytes KOTOR 1, 440 (0x1b8) bytes KOTOR 2) - extends trimesh_header
    seq:
      - id: trimesh_base
        type: trimesh_header
        doc: Standard trimesh header
      - id: unknown_weights
        type: s4
        doc: Purpose unknown (possibly compilation weights)
      - id: padding1
        type: u1
        repeat: expr
        repeat-expr: 8
        doc: Padding
      - id: mdx_bone_weights_offset
        type: u4
        doc: Offset to bone weight data in MDX file (4 floats per vertex)
      - id: mdx_bone_indices_offset
        type: u4
        doc: Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
      - id: bone_map_offset
        type: u4
        doc: Offset to bone map array (maps local bone indices to skeleton bone numbers)
      - id: bone_map_count
        type: u4
        doc: Number of bones referenced by this mesh (max 16)
      - id: qbones_offset
        type: u4
        doc: Offset to quaternion bind pose array (4 floats per bone)
      - id: qbones_count
        type: u4
        doc: Number of quaternion bind poses
      - id: qbones_count_duplicate
        type: u4
        doc: Duplicate of QBones count
      - id: tbones_offset
        type: u4
        doc: Offset to translation bind pose array (3 floats per bone)
      - id: tbones_count
        type: u4
        doc: Number of translation bind poses
      - id: tbones_count_duplicate
        type: u4
        doc: Duplicate of TBones count
      - id: unknown_array
        type: u4
        doc: Purpose unknown
      - id: bone_node_serial_numbers
        type: u2
        repeat: expr
        repeat-expr: 16
        doc: Serial indices of bone nodes (0xFFFF for unused slots)
      - id: padding2
        type: u2
        doc: Padding for alignment

  animmesh_header:
    doc: Animmesh header (388 (0x184) bytes KOTOR 1, 396 (0x18c) bytes KOTOR 2) - extends trimesh_header
    seq:
      - id: trimesh_base
        type: trimesh_header
        doc: Standard trimesh header
      - id: unknown
        type: f4
        doc: Purpose unknown
      - id: unknown_array
        type: array_definition
        doc: Unknown array definition
      - id: unknown_floats
        type: f4
        repeat: expr
        repeat-expr: 9
        doc: Unknown float values

  danglymesh_header:
    doc: Danglymesh header (360 (0x168) bytes KOTOR 1, 368 (0x170) bytes KOTOR 2) - extends trimesh_header
    seq:
      - id: trimesh_base
        type: trimesh_header
        doc: Standard trimesh header
      - id: constraints_offset
        type: u4
        doc: Offset to vertex constraint values array
      - id: constraints_count
        type: u4
        doc: Number of vertex constraints (matches vertex count)
      - id: constraints_count_duplicate
        type: u4
        doc: Duplicate of constraints count
      - id: displacement
        type: f4
        doc: Maximum displacement distance for physics simulation
      - id: tightness
        type: f4
        doc: Tightness/stiffness of spring simulation (0.0-1.0)
      - id: period
        type: f4
        doc: Oscillation period in seconds
      - id: unknown
        type: u4
        doc: Purpose unknown

  aabb_header:
    doc: AABB (Axis-Aligned Bounding Box) header (336 (0x150) bytes KOTOR 1, 344 (0x158) bytes KOTOR 2) - extends trimesh_header
    seq:
      - id: trimesh_base
        type: trimesh_header
        doc: Standard trimesh header
      - id: unknown
        type: u4
        doc: Purpose unknown

  lightsaber_header:
    doc: Lightsaber header (352 (0x160) bytes KOTOR 1, 360 (0x168) bytes KOTOR 2) - extends trimesh_header
    seq:
      - id: trimesh_base
        type: trimesh_header
        doc: Standard trimesh header
      - id: vertices_offset
        type: u4
        doc: Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
      - id: texcoords_offset
        type: u4
        doc: Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
      - id: normals_offset
        type: u4
        doc: Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
      - id: unknown1
        type: u4
        doc: Purpose unknown
      - id: unknown2
        type: u4
        doc: Purpose unknown

  controller:
    doc: Controller structure (16 (0x10) bytes) - defines animation data for a node property over time
    seq:
      - id: type
        type: u4
        enum: bioware_mdl_common::controller_type
        doc: |
          Controller type identifier. Controllers define animation data for node properties over time.

          Common Node Controllers (used by all node types):
          - 8: Position (3 floats: X, Y, Z translation)
          - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
          - 36: Scale (3 floats: X, Y, Z scale factors)

          Light Controllers (specific to light nodes):
          - 76: Color (light color, 3 floats: R, G, B)
          - 88: Radius (light radius, 1 float)
          - 96: Shadow Radius (shadow casting radius, 1 float)
          - 100: Vertical Displacement (vertical offset, 1 float)
          - 140: Multiplier (light intensity multiplier, 1 float)

          Emitter Controllers (specific to emitter nodes):
          - 80: Alpha End (final alpha value, 1 float)
          - 84: Alpha Start (initial alpha value, 1 float)
          - 88: Birth Rate (particle spawn rate, 1 float)
          - 92: Bounce Coefficient (particle bounce factor, 1 float)
          - 96: Combine Time (particle combination timing, 1 float)
          - 100: Drag (particle drag/resistance, 1 float)
          - 104: FPS (frames per second, 1 float)
          - 108: Frame End (ending frame number, 1 float)
          - 112: Frame Start (starting frame number, 1 float)
          - 116: Gravity (gravity force, 1 float)
          - 120: Life Expectancy (particle lifetime, 1 float)
          - 124: Mass (particle mass, 1 float)
          - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
          - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
          - 136: Particle Rotation (particle rotation speed/angle, 1 float)
          - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
          - 144: Size Start (initial particle size, 1 float)
          - 148: Size End (final particle size, 1 float)
          - 152: Size Start Y (initial particle size Y component, 1 float)
          - 156: Size End Y (final particle size Y component, 1 float)
          - 160: Spread (particle spread angle, 1 float)
          - 164: Threshold (threshold value, 1 float)
          - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
          - 172: X Size (particle X dimension size, 1 float)
          - 176: Y Size (particle Y dimension size, 1 float)
          - 180: Blur Length (motion blur length, 1 float)
          - 184: Lightning Delay (lightning effect delay, 1 float)
          - 188: Lightning Radius (lightning effect radius, 1 float)
          - 192: Lightning Scale (lightning effect scale factor, 1 float)
          - 196: Lightning Subdivide (lightning subdivision count, 1 float)
          - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
          - 216: Alpha Mid (mid-point alpha value, 1 float)
          - 220: Percent Start (starting percentage, 1 float)
          - 224: Percent Mid (mid-point percentage, 1 float)
          - 228: Percent End (ending percentage, 1 float)
          - 232: Size Mid (mid-point particle size, 1 float)
          - 236: Size Mid Y (mid-point particle size Y component, 1 float)
          - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
          - 252: Target Size (target particle size, 1 float)
          - 256: Number of Control Points (control point count, 1 float)
          - 260: Control Point Radius (control point radius, 1 float)
          - 264: Control Point Delay (control point delay timing, 1 float)
          - 268: Tangent Spread (tangent spread angle, 1 float)
          - 272: Tangent Length (tangent vector length, 1 float)
          - 284: Color Mid (mid-point color, 3 floats: R, G, B)
          - 380: Color End (final color, 3 floats: R, G, B)
          - 392: Color Start (initial color, 3 floats: R, G, B)
          - 502: Emitter Detonate (detonation trigger, 1 float)

          Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
          - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
          - 128: Alpha (transparency/opacity, 1 float)

          Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
          Reference: https://github.com/OpenKotOR/MDLOps/blob/7e40846d36acb5118e2e9feb2fd53620c29be540/MDLOpsM.pm#L342-L407 — Controller type definitions
          Reference: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/binmdl.html - Comprehensive controller list
      - id: unknown
        type: u2
        doc: Purpose unknown, typically 0xFFFF
      - id: row_count
        type: u2
        doc: Number of keyframe rows (timepoints) for this controller
      - id: time_index
        type: u2
        doc: Index into controller data array where time values begin
      - id: data_index
        type: u2
        doc: Index into controller data array where property values begin
      - id: column_count
        type: u1
        doc: |
          Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
          If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
      - id: padding
        type: u1
        repeat: expr
        repeat-expr: 3
        doc: Padding bytes for 16 (0x10)-byte alignment
    instances:
      uses_bezier:
        value: (column_count & 0x10) != 0
        doc: True if controller uses Bezier interpolation

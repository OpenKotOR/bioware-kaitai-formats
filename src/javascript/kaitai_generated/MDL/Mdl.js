// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream', './BiowareMdlCommon'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'), require('./BiowareMdlCommon'));
  } else {
    factory(root.Mdl || (root.Mdl = {}), root.KaitaiStream, root.BiowareMdlCommon || (root.BiowareMdlCommon = {}));
  }
})(typeof self !== 'undefined' ? self : this, function (Mdl_, KaitaiStream, BiowareMdlCommon_) {
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
 * @see {@link https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy|In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format|PyKotor wiki — MDL/MDX}
 * @see {@link https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408|PyKotor — MDLBinaryReader (binary MDL/MDX)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267|xoreos — Model_KotOR::load}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79|xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)}
 * @see {@link https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43|xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html|xoreos-docs — KotOR MDL overview}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html|xoreos-docs — Torlack binmdl (controller / Aurora background)}
 * @see {@link https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118|reone — MdlMdxReader::load}
 * @see {@link https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170|KotOR.js — OdysseyModel binary constructor}
 * @see {@link https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407|Community MDLOps — controller name table}
 * @see {@link https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698|Community MDLOps — `readasciimdl` (ASCII MDL ingest)}
 */

var Mdl = (function() {
  function Mdl(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  Mdl.prototype._read = function() {
    this.fileHeader = new FileHeader(this._io, this, this._root);
    this.modelHeader = new ModelHeader(this._io, this, this._root);
  }

  /**
   * AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
   */

  var AabbHeader = Mdl.AabbHeader = (function() {
    function AabbHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AabbHeader.prototype._read = function() {
      this.trimeshBase = new TrimeshHeader(this._io, this, this._root);
      this.unknown = this._io.readU4le();
    }

    /**
     * Standard trimesh header
     */

    /**
     * Purpose unknown
     */

    return AabbHeader;
  })();

  /**
   * Animation event (36 bytes)
   */

  var AnimationEvent = Mdl.AnimationEvent = (function() {
    function AnimationEvent(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AnimationEvent.prototype._read = function() {
      this.activationTime = this._io.readF4le();
      this.eventName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
    }

    /**
     * Time in seconds when event triggers during animation playback
     */

    /**
     * Name of event (null-terminated string, e.g., "detonate")
     */

    return AnimationEvent;
  })();

  /**
   * Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
   */

  var AnimationHeader = Mdl.AnimationHeader = (function() {
    function AnimationHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AnimationHeader.prototype._read = function() {
      this.geoHeader = new GeometryHeader(this._io, this, this._root);
      this.animationLength = this._io.readF4le();
      this.transitionTime = this._io.readF4le();
      this.animationRoot = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.eventArrayOffset = this._io.readU4le();
      this.eventCount = this._io.readU4le();
      this.eventCountDuplicate = this._io.readU4le();
      this.unknown = this._io.readU4le();
    }

    /**
     * Standard 80-byte geometry header (geometry_type = 0x01 for animation)
     */

    /**
     * Duration of animation in seconds
     */

    /**
     * Transition/blend time to this animation in seconds
     */

    /**
     * Root node name for animation (null-terminated string)
     */

    /**
     * Offset to animation events array
     */

    /**
     * Number of animation events
     */

    /**
     * Duplicate value of event count
     */

    /**
     * Purpose unknown
     */

    return AnimationHeader;
  })();

  /**
   * Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
   */

  var AnimmeshHeader = Mdl.AnimmeshHeader = (function() {
    function AnimmeshHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AnimmeshHeader.prototype._read = function() {
      this.trimeshBase = new TrimeshHeader(this._io, this, this._root);
      this.unknown = this._io.readF4le();
      this.unknownArray = new ArrayDefinition(this._io, this, this._root);
      this.unknownFloats = [];
      for (var i = 0; i < 9; i++) {
        this.unknownFloats.push(this._io.readF4le());
      }
    }

    /**
     * Standard trimesh header
     */

    /**
     * Purpose unknown
     */

    /**
     * Unknown array definition
     */

    /**
     * Unknown float values
     */

    return AnimmeshHeader;
  })();

  /**
   * Array definition structure (offset, count, count duplicate)
   */

  var ArrayDefinition = Mdl.ArrayDefinition = (function() {
    function ArrayDefinition(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ArrayDefinition.prototype._read = function() {
      this.offset = this._io.readS4le();
      this.count = this._io.readU4le();
      this.countDuplicate = this._io.readU4le();
    }

    /**
     * Offset to array (relative to MDL data start, offset 12)
     */

    /**
     * Number of used entries
     */

    /**
     * Duplicate of count (allocated entries)
     */

    return ArrayDefinition;
  })();

  /**
   * Controller structure (16 bytes) - defines animation data for a node property over time
   */

  var Controller = Mdl.Controller = (function() {
    function Controller(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Controller.prototype._read = function() {
      this.type = this._io.readU4le();
      this.unknown = this._io.readU2le();
      this.rowCount = this._io.readU2le();
      this.timeIndex = this._io.readU2le();
      this.dataIndex = this._io.readU2le();
      this.columnCount = this._io.readU1();
      this.padding = [];
      for (var i = 0; i < 3; i++) {
        this.padding.push(this._io.readU1());
      }
    }

    /**
     * True if controller uses Bezier interpolation
     */
    Object.defineProperty(Controller.prototype, 'usesBezier', {
      get: function() {
        if (this._m_usesBezier !== undefined)
          return this._m_usesBezier;
        this._m_usesBezier = (this.columnCount & 16) != 0;
        return this._m_usesBezier;
      }
    });

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

    /**
     * Purpose unknown, typically 0xFFFF
     */

    /**
     * Number of keyframe rows (timepoints) for this controller
     */

    /**
     * Index into controller data array where time values begin
     */

    /**
     * Index into controller data array where property values begin
     */

    /**
     * Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
     * If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
     */

    /**
     * Padding bytes for 16-byte alignment
     */

    return Controller;
  })();

  /**
   * Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
   */

  var DanglymeshHeader = Mdl.DanglymeshHeader = (function() {
    function DanglymeshHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DanglymeshHeader.prototype._read = function() {
      this.trimeshBase = new TrimeshHeader(this._io, this, this._root);
      this.constraintsOffset = this._io.readU4le();
      this.constraintsCount = this._io.readU4le();
      this.constraintsCountDuplicate = this._io.readU4le();
      this.displacement = this._io.readF4le();
      this.tightness = this._io.readF4le();
      this.period = this._io.readF4le();
      this.unknown = this._io.readU4le();
    }

    /**
     * Standard trimesh header
     */

    /**
     * Offset to vertex constraint values array
     */

    /**
     * Number of vertex constraints (matches vertex count)
     */

    /**
     * Duplicate of constraints count
     */

    /**
     * Maximum displacement distance for physics simulation
     */

    /**
     * Tightness/stiffness of spring simulation (0.0-1.0)
     */

    /**
     * Oscillation period in seconds
     */

    /**
     * Purpose unknown
     */

    return DanglymeshHeader;
  })();

  /**
   * Emitter header (224 bytes)
   */

  var EmitterHeader = Mdl.EmitterHeader = (function() {
    function EmitterHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    EmitterHeader.prototype._read = function() {
      this.deadSpace = this._io.readF4le();
      this.blastRadius = this._io.readF4le();
      this.blastLength = this._io.readF4le();
      this.branchCount = this._io.readU4le();
      this.controlPointSmoothing = this._io.readF4le();
      this.xGrid = this._io.readU4le();
      this.yGrid = this._io.readU4le();
      this.paddingUnknown = this._io.readU4le();
      this.updateScript = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.renderScript = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.blendScript = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.textureName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.chunkName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.twoSidedTexture = this._io.readU4le();
      this.loop = this._io.readU4le();
      this.renderOrder = this._io.readU2le();
      this.frameBlending = this._io.readU1();
      this.depthTextureName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.padding = this._io.readU1();
      this.flags = this._io.readU4le();
    }

    /**
     * Minimum distance from emitter before particles become visible
     */

    /**
     * Radius of explosive/blast particle effects
     */

    /**
     * Length/duration of blast effects
     */

    /**
     * Number of branching paths for particle trails
     */

    /**
     * Smoothing factor for particle path control points
     */

    /**
     * Grid subdivisions along X axis for particle spawning
     */

    /**
     * Grid subdivisions along Y axis for particle spawning
     */

    /**
     * Purpose unknown or padding
     */

    /**
     * Update behavior script name (e.g., "single", "fountain")
     */

    /**
     * Render mode script name (e.g., "normal", "billboard_to_local_z")
     */

    /**
     * Blend mode script name (e.g., "normal", "lighten")
     */

    /**
     * Particle texture name (null-terminated string)
     */

    /**
     * Associated model chunk name (null-terminated string)
     */

    /**
     * 1 if texture should render two-sided, 0 for single-sided
     */

    /**
     * 1 if particle system loops, 0 for single playback
     */

    /**
     * Rendering priority/order for particle sorting
     */

    /**
     * 1 if frame blending enabled, 0 otherwise
     */

    /**
     * Depth/softparticle texture name (null-terminated string)
     */

    /**
     * Padding byte for alignment
     */

    /**
     * Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
     */

    return EmitterHeader;
  })();

  /**
   * MDL file header (12 bytes)
   */

  var FileHeader = Mdl.FileHeader = (function() {
    function FileHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    FileHeader.prototype._read = function() {
      this.unused = this._io.readU4le();
      this.mdlSize = this._io.readU4le();
      this.mdxSize = this._io.readU4le();
    }

    /**
     * Always 0
     */

    /**
     * Size of MDL file in bytes
     */

    /**
     * Size of MDX file in bytes
     */

    return FileHeader;
  })();

  /**
   * Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
   */

  var GeometryHeader = Mdl.GeometryHeader = (function() {
    function GeometryHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    GeometryHeader.prototype._read = function() {
      this.functionPointer0 = this._io.readU4le();
      this.functionPointer1 = this._io.readU4le();
      this.modelName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.rootNodeOffset = this._io.readU4le();
      this.nodeCount = this._io.readU4le();
      this.unknownArray1 = new ArrayDefinition(this._io, this, this._root);
      this.unknownArray2 = new ArrayDefinition(this._io, this, this._root);
      this.referenceCount = this._io.readU4le();
      this.geometryType = this._io.readU1();
      this.padding = [];
      for (var i = 0; i < 3; i++) {
        this.padding.push(this._io.readU1());
      }
    }

    /**
     * True if this is a KOTOR 2 model
     */
    Object.defineProperty(GeometryHeader.prototype, 'isKotor2', {
      get: function() {
        if (this._m_isKotor2 !== undefined)
          return this._m_isKotor2;
        this._m_isKotor2 =  ((this.functionPointer0 == 4285200) || (this.functionPointer0 == 4285872)) ;
        return this._m_isKotor2;
      }
    });

    /**
     * Game engine version identifier:
     * - KOTOR 1 PC: 4273776 (0x413670)
     * - KOTOR 2 PC: 4285200 (0x416310)
     * - KOTOR 1 Xbox: 4254992 (0x40ED10)
     * - KOTOR 2 Xbox: 4285872 (0x4165B0)
     */

    /**
     * Function pointer to ASCII model parser
     */

    /**
     * Model name, null-terminated string, max 32 (0x20) bytes
     */

    /**
     * Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
     */

    /**
     * Total number of nodes in model hierarchy, unsigned 32-bit integer
     */

    /**
     * Unknown array definition (offset, count, count duplicate)
     */

    /**
     * Unknown array definition (offset, count, count duplicate)
     */

    /**
     * Reference count (initialized to 0, incremented when model is referenced)
     */

    /**
     * Geometry type:
     * - 0x01: Basic geometry header (not in models)
     * - 0x02: Model geometry header
     * - 0x05: Animation geometry header
     * If bit 7 (0x80) is set, model is compiled binary with absolute addresses
     */

    /**
     * Padding bytes for alignment
     */

    return GeometryHeader;
  })();

  /**
   * Light header (92 bytes)
   */

  var LightHeader = Mdl.LightHeader = (function() {
    function LightHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LightHeader.prototype._read = function() {
      this.unknown = [];
      for (var i = 0; i < 4; i++) {
        this.unknown.push(this._io.readF4le());
      }
      this.flareSizesOffset = this._io.readU4le();
      this.flareSizesCount = this._io.readU4le();
      this.flareSizesCountDuplicate = this._io.readU4le();
      this.flarePositionsOffset = this._io.readU4le();
      this.flarePositionsCount = this._io.readU4le();
      this.flarePositionsCountDuplicate = this._io.readU4le();
      this.flareColorShiftsOffset = this._io.readU4le();
      this.flareColorShiftsCount = this._io.readU4le();
      this.flareColorShiftsCountDuplicate = this._io.readU4le();
      this.flareTextureNamesOffset = this._io.readU4le();
      this.flareTextureNamesCount = this._io.readU4le();
      this.flareTextureNamesCountDuplicate = this._io.readU4le();
      this.flareRadius = this._io.readF4le();
      this.lightPriority = this._io.readU4le();
      this.ambientOnly = this._io.readU4le();
      this.dynamicType = this._io.readU4le();
      this.affectDynamic = this._io.readU4le();
      this.shadow = this._io.readU4le();
      this.flare = this._io.readU4le();
      this.fadingLight = this._io.readU4le();
    }

    /**
     * Purpose unknown, possibly padding or reserved values
     */

    /**
     * Offset to flare sizes array (floats)
     */

    /**
     * Number of flare size entries
     */

    /**
     * Duplicate of flare sizes count
     */

    /**
     * Offset to flare positions array (floats, 0.0-1.0 along light ray)
     */

    /**
     * Number of flare position entries
     */

    /**
     * Duplicate of flare positions count
     */

    /**
     * Offset to flare color shift array (RGB floats)
     */

    /**
     * Number of flare color shift entries
     */

    /**
     * Duplicate of flare color shifts count
     */

    /**
     * Offset to flare texture name string offsets array
     */

    /**
     * Number of flare texture names
     */

    /**
     * Duplicate of flare texture names count
     */

    /**
     * Radius of flare effect
     */

    /**
     * Rendering priority for light culling/sorting
     */

    /**
     * 1 if light only affects ambient, 0 for full lighting
     */

    /**
     * Type of dynamic lighting behavior
     */

    /**
     * 1 if light affects dynamic objects, 0 otherwise
     */

    /**
     * 1 if light casts shadows, 0 otherwise
     */

    /**
     * 1 if lens flare effect enabled, 0 otherwise
     */

    /**
     * 1 if light intensity fades with distance, 0 otherwise
     */

    return LightHeader;
  })();

  /**
   * Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
   */

  var LightsaberHeader = Mdl.LightsaberHeader = (function() {
    function LightsaberHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LightsaberHeader.prototype._read = function() {
      this.trimeshBase = new TrimeshHeader(this._io, this, this._root);
      this.verticesOffset = this._io.readU4le();
      this.texcoordsOffset = this._io.readU4le();
      this.normalsOffset = this._io.readU4le();
      this.unknown1 = this._io.readU4le();
      this.unknown2 = this._io.readU4le();
    }

    /**
     * Standard trimesh header
     */

    /**
     * Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
     */

    /**
     * Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
     */

    /**
     * Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
     */

    /**
     * Purpose unknown
     */

    /**
     * Purpose unknown
     */

    return LightsaberHeader;
  })();

  /**
   * One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
   * Wraps the header so repeated root instances can use parametric types (user guide).
   */

  var MdlAnimationEntry = Mdl.MdlAnimationEntry = (function() {
    function MdlAnimationEntry(_io, _parent, _root, animIndex) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;
      this.animIndex = animIndex;

      this._read();
    }
    MdlAnimationEntry.prototype._read = function() {
    }
    Object.defineProperty(MdlAnimationEntry.prototype, 'header', {
      get: function() {
        if (this._m_header !== undefined)
          return this._m_header;
        var _pos = this._io.pos;
        this._io.seek(this._root.dataStart + this._root.animationOffsets[this.animIndex]);
        this._m_header = new AnimationHeader(this._io, this, this._root);
        this._io.seek(_pos);
        return this._m_header;
      }
    });

    return MdlAnimationEntry;
  })();

  /**
   * Model header (196 bytes) starting at offset 12 (data_start).
   * This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
   * model-wide metadata, offsets, and counts.
   */

  var ModelHeader = Mdl.ModelHeader = (function() {
    function ModelHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ModelHeader.prototype._read = function() {
      this.geometry = new GeometryHeader(this._io, this, this._root);
      this.modelType = this._io.readU1();
      this.unknown0 = this._io.readU1();
      this.padding0 = this._io.readU1();
      this.fog = this._io.readU1();
      this.unknown1 = this._io.readU4le();
      this.offsetToAnimations = this._io.readU4le();
      this.animationCount = this._io.readU4le();
      this.animationCount2 = this._io.readU4le();
      this.unknown2 = this._io.readU4le();
      this.boundingBoxMin = new Vec3f(this._io, this, this._root);
      this.boundingBoxMax = new Vec3f(this._io, this, this._root);
      this.radius = this._io.readF4le();
      this.animationScale = this._io.readF4le();
      this.supermodelName = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.offsetToSuperRoot = this._io.readU4le();
      this.unknown3 = this._io.readU4le();
      this.mdxDataSize = this._io.readU4le();
      this.mdxDataOffset = this._io.readU4le();
      this.offsetToNameOffsets = this._io.readU4le();
      this.nameOffsetsCount = this._io.readU4le();
      this.nameOffsetsCount2 = this._io.readU4le();
    }

    /**
     * Geometry header (80 bytes)
     */

    /**
     * Model classification byte
     */

    /**
     * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
     */

    /**
     * Padding byte
     */

    /**
     * Fog interaction (1 = affected, 0 = ignore fog)
     */

    /**
     * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
     */

    /**
     * Offset to animation offset array (relative to data_start)
     */

    /**
     * Number of animations
     */

    /**
     * Duplicate animation count / allocated count
     */

    /**
     * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
     */

    /**
     * Minimum coordinates of bounding box (X, Y, Z)
     */

    /**
     * Maximum coordinates of bounding box (X, Y, Z)
     */

    /**
     * Radius of model's bounding sphere
     */

    /**
     * Scale factor for animations (typically 1.0)
     */

    /**
     * Name of supermodel (null-terminated string, "null" if empty)
     */

    /**
     * TODO: VERIFY - offset to super-root node (relative to data_start)
     */

    /**
     * TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
     */

    /**
     * Size of MDX file data in bytes
     */

    /**
     * Offset to MDX data (typically 0)
     */

    /**
     * Offset to name offset array (relative to data_start)
     */

    /**
     * Count of name offsets / partnames
     */

    /**
     * Duplicate name offsets count / allocated count
     */

    return ModelHeader;
  })();

  /**
   * Array of null-terminated name strings
   */

  var NameStrings = Mdl.NameStrings = (function() {
    function NameStrings(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NameStrings.prototype._read = function() {
      this.strings = [];
      var i = 0;
      while (!this._io.isEof()) {
        this.strings.push(KaitaiStream.bytesToStr(this._io.readBytesTerm(0, false, true, true), "ASCII"));
        i++;
      }
    }

    return NameStrings;
  })();

  /**
   * Node structure - starts with 80-byte header, followed by type-specific sub-header
   */

  var Node = Mdl.Node = (function() {
    function Node(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Node.prototype._read = function() {
      this.header = new NodeHeader(this._io, this, this._root);
      if (this.header.nodeType == 3) {
        this.lightSubHeader = new LightHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 5) {
        this.emitterSubHeader = new EmitterHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 17) {
        this.referenceSubHeader = new ReferenceHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 33) {
        this.trimeshSubHeader = new TrimeshHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 97) {
        this.skinmeshSubHeader = new SkinmeshHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 161) {
        this.animmeshSubHeader = new AnimmeshHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 289) {
        this.danglymeshSubHeader = new DanglymeshHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 545) {
        this.aabbSubHeader = new AabbHeader(this._io, this, this._root);
      }
      if (this.header.nodeType == 2081) {
        this.lightsaberSubHeader = new LightsaberHeader(this._io, this, this._root);
      }
    }

    return Node;
  })();

  /**
   * Node header (80 bytes) - present in all node types
   */

  var NodeHeader = Mdl.NodeHeader = (function() {
    function NodeHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    NodeHeader.prototype._read = function() {
      this.nodeType = this._io.readU2le();
      this.nodeIndex = this._io.readU2le();
      this.nodeNameIndex = this._io.readU2le();
      this.padding = this._io.readU2le();
      this.rootNodeOffset = this._io.readU4le();
      this.parentNodeOffset = this._io.readU4le();
      this.position = new Vec3f(this._io, this, this._root);
      this.orientation = new Quaternion(this._io, this, this._root);
      this.childArrayOffset = this._io.readU4le();
      this.childCount = this._io.readU4le();
      this.childCountDuplicate = this._io.readU4le();
      this.controllerArrayOffset = this._io.readU4le();
      this.controllerCount = this._io.readU4le();
      this.controllerCountDuplicate = this._io.readU4le();
      this.controllerDataOffset = this._io.readU4le();
      this.controllerDataCount = this._io.readU4le();
      this.controllerDataCountDuplicate = this._io.readU4le();
    }
    Object.defineProperty(NodeHeader.prototype, 'hasAabb', {
      get: function() {
        if (this._m_hasAabb !== undefined)
          return this._m_hasAabb;
        this._m_hasAabb = (this.nodeType & 512) != 0;
        return this._m_hasAabb;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasAnim', {
      get: function() {
        if (this._m_hasAnim !== undefined)
          return this._m_hasAnim;
        this._m_hasAnim = (this.nodeType & 128) != 0;
        return this._m_hasAnim;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasDangly', {
      get: function() {
        if (this._m_hasDangly !== undefined)
          return this._m_hasDangly;
        this._m_hasDangly = (this.nodeType & 256) != 0;
        return this._m_hasDangly;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasEmitter', {
      get: function() {
        if (this._m_hasEmitter !== undefined)
          return this._m_hasEmitter;
        this._m_hasEmitter = (this.nodeType & 4) != 0;
        return this._m_hasEmitter;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasLight', {
      get: function() {
        if (this._m_hasLight !== undefined)
          return this._m_hasLight;
        this._m_hasLight = (this.nodeType & 2) != 0;
        return this._m_hasLight;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasMesh', {
      get: function() {
        if (this._m_hasMesh !== undefined)
          return this._m_hasMesh;
        this._m_hasMesh = (this.nodeType & 32) != 0;
        return this._m_hasMesh;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasReference', {
      get: function() {
        if (this._m_hasReference !== undefined)
          return this._m_hasReference;
        this._m_hasReference = (this.nodeType & 16) != 0;
        return this._m_hasReference;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasSaber', {
      get: function() {
        if (this._m_hasSaber !== undefined)
          return this._m_hasSaber;
        this._m_hasSaber = (this.nodeType & 2048) != 0;
        return this._m_hasSaber;
      }
    });
    Object.defineProperty(NodeHeader.prototype, 'hasSkin', {
      get: function() {
        if (this._m_hasSkin !== undefined)
          return this._m_hasSkin;
        this._m_hasSkin = (this.nodeType & 64) != 0;
        return this._m_hasSkin;
      }
    });

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

    /**
     * Sequential index of this node in the model
     */

    /**
     * Index into names array for this node's name
     */

    /**
     * Padding for alignment
     */

    /**
     * Offset to model's root node
     */

    /**
     * Offset to this node's parent node (0 if root)
     */

    /**
     * Node position in local space (X, Y, Z)
     */

    /**
     * Node orientation as quaternion (W, X, Y, Z)
     */

    /**
     * Offset to array of child node offsets
     */

    /**
     * Number of child nodes
     */

    /**
     * Duplicate value of child count
     */

    /**
     * Offset to array of controller structures
     */

    /**
     * Number of controllers attached to this node
     */

    /**
     * Duplicate value of controller count
     */

    /**
     * Offset to controller keyframe/data array
     */

    /**
     * Number of floats in controller data array
     */

    /**
     * Duplicate value of controller data count
     */

    return NodeHeader;
  })();

  /**
   * Quaternion rotation (4 floats W, X, Y, Z)
   */

  var Quaternion = Mdl.Quaternion = (function() {
    function Quaternion(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Quaternion.prototype._read = function() {
      this.w = this._io.readF4le();
      this.x = this._io.readF4le();
      this.y = this._io.readF4le();
      this.z = this._io.readF4le();
    }

    return Quaternion;
  })();

  /**
   * Reference header (36 bytes)
   */

  var ReferenceHeader = Mdl.ReferenceHeader = (function() {
    function ReferenceHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ReferenceHeader.prototype._read = function() {
      this.modelResref = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.reattachable = this._io.readU4le();
    }

    /**
     * Referenced model resource name without extension (null-terminated string)
     */

    /**
     * 1 if model can be detached and reattached dynamically, 0 if permanent
     */

    return ReferenceHeader;
  })();

  /**
   * Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
   */

  var SkinmeshHeader = Mdl.SkinmeshHeader = (function() {
    function SkinmeshHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    SkinmeshHeader.prototype._read = function() {
      this.trimeshBase = new TrimeshHeader(this._io, this, this._root);
      this.unknownWeights = this._io.readS4le();
      this.padding1 = [];
      for (var i = 0; i < 8; i++) {
        this.padding1.push(this._io.readU1());
      }
      this.mdxBoneWeightsOffset = this._io.readU4le();
      this.mdxBoneIndicesOffset = this._io.readU4le();
      this.boneMapOffset = this._io.readU4le();
      this.boneMapCount = this._io.readU4le();
      this.qbonesOffset = this._io.readU4le();
      this.qbonesCount = this._io.readU4le();
      this.qbonesCountDuplicate = this._io.readU4le();
      this.tbonesOffset = this._io.readU4le();
      this.tbonesCount = this._io.readU4le();
      this.tbonesCountDuplicate = this._io.readU4le();
      this.unknownArray = this._io.readU4le();
      this.boneNodeSerialNumbers = [];
      for (var i = 0; i < 16; i++) {
        this.boneNodeSerialNumbers.push(this._io.readU2le());
      }
      this.padding2 = this._io.readU2le();
    }

    /**
     * Standard trimesh header
     */

    /**
     * Purpose unknown (possibly compilation weights)
     */

    /**
     * Padding
     */

    /**
     * Offset to bone weight data in MDX file (4 floats per vertex)
     */

    /**
     * Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
     */

    /**
     * Offset to bone map array (maps local bone indices to skeleton bone numbers)
     */

    /**
     * Number of bones referenced by this mesh (max 16)
     */

    /**
     * Offset to quaternion bind pose array (4 floats per bone)
     */

    /**
     * Number of quaternion bind poses
     */

    /**
     * Duplicate of QBones count
     */

    /**
     * Offset to translation bind pose array (3 floats per bone)
     */

    /**
     * Number of translation bind poses
     */

    /**
     * Duplicate of TBones count
     */

    /**
     * Purpose unknown
     */

    /**
     * Serial indices of bone nodes (0xFFFF for unused slots)
     */

    /**
     * Padding for alignment
     */

    return SkinmeshHeader;
  })();

  /**
   * Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
   */

  var TrimeshHeader = Mdl.TrimeshHeader = (function() {
    function TrimeshHeader(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    TrimeshHeader.prototype._read = function() {
      this.functionPointer0 = this._io.readU4le();
      this.functionPointer1 = this._io.readU4le();
      this.facesArrayOffset = this._io.readU4le();
      this.facesCount = this._io.readU4le();
      this.facesCountDuplicate = this._io.readU4le();
      this.boundingBoxMin = new Vec3f(this._io, this, this._root);
      this.boundingBoxMax = new Vec3f(this._io, this, this._root);
      this.radius = this._io.readF4le();
      this.averagePoint = new Vec3f(this._io, this, this._root);
      this.diffuseColor = new Vec3f(this._io, this, this._root);
      this.ambientColor = new Vec3f(this._io, this, this._root);
      this.transparencyHint = this._io.readU4le();
      this.texture0Name = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.texture1Name = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(32), 0, false), "ASCII");
      this.texture2Name = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(12), 0, false), "ASCII");
      this.texture3Name = KaitaiStream.bytesToStr(KaitaiStream.bytesTerminate(this._io.readBytes(12), 0, false), "ASCII");
      this.indicesCountArrayOffset = this._io.readU4le();
      this.indicesCountArrayCount = this._io.readU4le();
      this.indicesCountArrayCountDuplicate = this._io.readU4le();
      this.indicesOffsetArrayOffset = this._io.readU4le();
      this.indicesOffsetArrayCount = this._io.readU4le();
      this.indicesOffsetArrayCountDuplicate = this._io.readU4le();
      this.invertedCounterArrayOffset = this._io.readU4le();
      this.invertedCounterArrayCount = this._io.readU4le();
      this.invertedCounterArrayCountDuplicate = this._io.readU4le();
      this.unknownValues = [];
      for (var i = 0; i < 3; i++) {
        this.unknownValues.push(this._io.readS4le());
      }
      this.saberUnknownData = [];
      for (var i = 0; i < 8; i++) {
        this.saberUnknownData.push(this._io.readU1());
      }
      this.unknown = this._io.readU4le();
      this.uvDirection = new Vec3f(this._io, this, this._root);
      this.uvJitter = this._io.readF4le();
      this.uvJitterSpeed = this._io.readF4le();
      this.mdxVertexSize = this._io.readU4le();
      this.mdxDataFlags = this._io.readU4le();
      this.mdxVerticesOffset = this._io.readS4le();
      this.mdxNormalsOffset = this._io.readS4le();
      this.mdxVertexColorsOffset = this._io.readS4le();
      this.mdxTex0UvsOffset = this._io.readS4le();
      this.mdxTex1UvsOffset = this._io.readS4le();
      this.mdxTex2UvsOffset = this._io.readS4le();
      this.mdxTex3UvsOffset = this._io.readS4le();
      this.mdxTangentSpaceOffset = this._io.readS4le();
      this.mdxUnknownOffset1 = this._io.readS4le();
      this.mdxUnknownOffset2 = this._io.readS4le();
      this.mdxUnknownOffset3 = this._io.readS4le();
      this.vertexCount = this._io.readU2le();
      this.textureCount = this._io.readU2le();
      this.lightmapped = this._io.readU1();
      this.rotateTexture = this._io.readU1();
      this.backgroundGeometry = this._io.readU1();
      this.shadow = this._io.readU1();
      this.beaming = this._io.readU1();
      this.render = this._io.readU1();
      this.unknownFlag = this._io.readU1();
      this.padding = this._io.readU1();
      this.totalArea = this._io.readF4le();
      this.unknown2 = this._io.readU4le();
      if (this._root.modelHeader.geometry.isKotor2) {
        this.k2Unknown1 = this._io.readU4le();
      }
      if (this._root.modelHeader.geometry.isKotor2) {
        this.k2Unknown2 = this._io.readU4le();
      }
      this.mdxDataOffset = this._io.readU4le();
      this.mdlVerticesOffset = this._io.readU4le();
    }

    /**
     * Game engine function pointer (version-specific)
     */

    /**
     * Secondary game engine function pointer
     */

    /**
     * Offset to face definitions array
     */

    /**
     * Number of triangular faces in mesh
     */

    /**
     * Duplicate of faces count
     */

    /**
     * Minimum bounding box coordinates (X, Y, Z)
     */

    /**
     * Maximum bounding box coordinates (X, Y, Z)
     */

    /**
     * Bounding sphere radius
     */

    /**
     * Average vertex position (centroid) X, Y, Z
     */

    /**
     * Material diffuse color (R, G, B, range 0.0-1.0)
     */

    /**
     * Material ambient color (R, G, B, range 0.0-1.0)
     */

    /**
     * Transparency rendering mode
     */

    /**
     * Primary diffuse texture name (null-terminated string)
     */

    /**
     * Secondary texture name, often lightmap (null-terminated string)
     */

    /**
     * Tertiary texture name (null-terminated string)
     */

    /**
     * Quaternary texture name (null-terminated string)
     */

    /**
     * Offset to vertex indices count array
     */

    /**
     * Number of entries in indices count array
     */

    /**
     * Duplicate of indices count array count
     */

    /**
     * Offset to vertex indices offset array
     */

    /**
     * Number of entries in indices offset array
     */

    /**
     * Duplicate of indices offset array count
     */

    /**
     * Offset to inverted counter array
     */

    /**
     * Number of entries in inverted counter array
     */

    /**
     * Duplicate of inverted counter array count
     */

    /**
     * Typically {-1, -1, 0}, purpose unknown
     */

    /**
     * Data specific to lightsaber meshes
     */

    /**
     * Purpose unknown
     */

    /**
     * UV animation direction X, Y components (Z = jitter speed)
     */

    /**
     * UV animation jitter amount
     */

    /**
     * UV animation jitter speed
     */

    /**
     * Size in bytes of each vertex in MDX data
     */

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

    /**
     * Relative offset to vertex positions in MDX (or -1 if none)
     */

    /**
     * Relative offset to vertex normals in MDX (or -1 if none)
     */

    /**
     * Relative offset to vertex colors in MDX (or -1 if none)
     */

    /**
     * Relative offset to primary texture UVs in MDX (or -1 if none)
     */

    /**
     * Relative offset to secondary texture UVs in MDX (or -1 if none)
     */

    /**
     * Relative offset to tertiary texture UVs in MDX (or -1 if none)
     */

    /**
     * Relative offset to quaternary texture UVs in MDX (or -1 if none)
     */

    /**
     * Relative offset to tangent space data in MDX (or -1 if none)
     */

    /**
     * Relative offset to unknown MDX data (or -1 if none)
     */

    /**
     * Relative offset to unknown MDX data (or -1 if none)
     */

    /**
     * Relative offset to unknown MDX data (or -1 if none)
     */

    /**
     * Number of vertices in mesh
     */

    /**
     * Number of textures used by mesh
     */

    /**
     * 1 if mesh uses lightmap, 0 otherwise
     */

    /**
     * 1 if texture should rotate, 0 otherwise
     */

    /**
     * 1 if background geometry, 0 otherwise
     */

    /**
     * 1 if mesh casts shadows, 0 otherwise
     */

    /**
     * 1 if beaming effect enabled, 0 otherwise
     */

    /**
     * 1 if mesh is renderable, 0 if hidden
     */

    /**
     * Purpose unknown (possibly UV animation enable)
     */

    /**
     * Padding byte
     */

    /**
     * Total surface area of all faces
     */

    /**
     * Purpose unknown
     */

    /**
     * KOTOR 2 only: Additional unknown field
     */

    /**
     * KOTOR 2 only: Additional unknown field
     */

    /**
     * Absolute offset to this mesh's vertex data in MDX file
     */

    /**
     * Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
     */

    return TrimeshHeader;
  })();

  /**
   * 3D vector (3 floats)
   */

  var Vec3f = Mdl.Vec3f = (function() {
    function Vec3f(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    Vec3f.prototype._read = function() {
      this.x = this._io.readF4le();
      this.y = this._io.readF4le();
      this.z = this._io.readF4le();
    }

    return Vec3f;
  })();

  /**
   * Animation header offsets (relative to data_start)
   */
  Object.defineProperty(Mdl.prototype, 'animationOffsets', {
    get: function() {
      if (this._m_animationOffsets !== undefined)
        return this._m_animationOffsets;
      if (this.modelHeader.animationCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.dataStart + this.modelHeader.offsetToAnimations);
        this._m_animationOffsets = [];
        for (var i = 0; i < this.modelHeader.animationCount; i++) {
          this._m_animationOffsets.push(this._io.readU4le());
        }
        this._io.seek(_pos);
      }
      return this._m_animationOffsets;
    }
  });

  /**
   * Animation headers (via offset table). Each list element is `mdl_animation_entry`;
   * the parsed header is `element.header` (same wire layout as `animation_header`).
   */
  Object.defineProperty(Mdl.prototype, 'animations', {
    get: function() {
      if (this._m_animations !== undefined)
        return this._m_animations;
      if (this.modelHeader.animationCount > 0) {
        this._m_animations = [];
        for (var i = 0; i < this.modelHeader.animationCount; i++) {
          this._m_animations.push(new MdlAnimationEntry(this._io, this, this._root, i));
        }
      }
      return this._m_animations;
    }
  });

  /**
   * MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
   * section, which begins immediately after the 12-byte file header.
   */
  Object.defineProperty(Mdl.prototype, 'dataStart', {
    get: function() {
      if (this._m_dataStart !== undefined)
        return this._m_dataStart;
      this._m_dataStart = 12;
      return this._m_dataStart;
    }
  });

  /**
   * Name string offsets (relative to data_start)
   */
  Object.defineProperty(Mdl.prototype, 'nameOffsets', {
    get: function() {
      if (this._m_nameOffsets !== undefined)
        return this._m_nameOffsets;
      if (this.modelHeader.nameOffsetsCount > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.dataStart + this.modelHeader.offsetToNameOffsets);
        this._m_nameOffsets = [];
        for (var i = 0; i < this.modelHeader.nameOffsetsCount; i++) {
          this._m_nameOffsets.push(this._io.readU4le());
        }
        this._io.seek(_pos);
      }
      return this._m_nameOffsets;
    }
  });

  /**
   * Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
   * Parsed as null-terminated ASCII strings in `name_strings`.
   */
  Object.defineProperty(Mdl.prototype, 'namesData', {
    get: function() {
      if (this._m_namesData !== undefined)
        return this._m_namesData;
      if (this.modelHeader.nameOffsetsCount > 0) {
        var _pos = this._io.pos;
        this._io.seek((this.dataStart + this.modelHeader.offsetToNameOffsets) + 4 * this.modelHeader.nameOffsetsCount);
        this._raw__m_namesData = this._io.readBytes((this.dataStart + this.modelHeader.offsetToAnimations) - ((this.dataStart + this.modelHeader.offsetToNameOffsets) + 4 * this.modelHeader.nameOffsetsCount));
        var _io__raw__m_namesData = new KaitaiStream(this._raw__m_namesData);
        this._m_namesData = new NameStrings(_io__raw__m_namesData, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_namesData;
    }
  });
  Object.defineProperty(Mdl.prototype, 'rootNode', {
    get: function() {
      if (this._m_rootNode !== undefined)
        return this._m_rootNode;
      if (this.modelHeader.geometry.rootNodeOffset > 0) {
        var _pos = this._io.pos;
        this._io.seek(this.dataStart + this.modelHeader.geometry.rootNodeOffset);
        this._m_rootNode = new Node(this._io, this, this._root);
        this._io.seek(_pos);
      }
      return this._m_rootNode;
    }
  });

  return Mdl;
})();
Mdl_.Mdl = Mdl;
});

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(['exports', 'kaitai-struct/KaitaiStream'], factory);
  } else if (typeof exports === 'object' && exports !== null && typeof exports.nodeType !== 'number') {
    factory(exports, require('kaitai-struct/KaitaiStream'));
  } else {
    factory(root.MdlAscii || (root.MdlAscii = {}), root.KaitaiStream);
  }
})(typeof self !== 'undefined' ? self : this, function (MdlAscii_, KaitaiStream) {
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
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79|xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)}
 * @see {@link https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88|xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format|PyKotor wiki — ASCII MDL}
 * @see {@link https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format|PyKotor wiki — binary MDL (wire vs ASCII)}
 * @see {@link https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html|xoreos-docs — Torlack binmdl}
 * @see {@link https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy|In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)}
 * @see {@link https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698|Community MDLOps — readasciimdl}
 */

var MdlAscii = (function() {
  function MdlAscii(_io, _parent, _root) {
    this._io = _io;
    this._parent = _parent;
    this._root = _root || this;

    this._read();
  }
  MdlAscii.prototype._read = function() {
    this.lines = [];
    var i = 0;
    while (!this._io.isEof()) {
      this.lines.push(new AsciiLine(this._io, this, this._root));
      i++;
    }
  }

  /**
   * Animation section keywords
   */

  var AnimationSection = MdlAscii.AnimationSection = (function() {
    function AnimationSection(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AnimationSection.prototype._read = function() {
      this.newanim = new LineText(this._io, this, this._root);
      this.doneanim = new LineText(this._io, this, this._root);
      this.length = new LineText(this._io, this, this._root);
      this.transtime = new LineText(this._io, this, this._root);
      this.animroot = new LineText(this._io, this, this._root);
      this.event = new LineText(this._io, this, this._root);
      this.eventlist = new LineText(this._io, this, this._root);
      this.endlist = new LineText(this._io, this, this._root);
    }

    /**
     * newanim <animation_name> <model_name> - Start of animation definition
     */

    /**
     * doneanim <animation_name> <model_name> - End of animation definition
     */

    /**
     * length <duration> - Animation duration in seconds
     */

    /**
     * transtime <transition_time> - Transition/blend time to this animation in seconds
     */

    /**
     * animroot <root_node_name> - Root node name for animation
     */

    /**
     * event <time> <event_name> - Animation event (triggers at specified time)
     */

    /**
     * eventlist - Start of animation events list
     */

    /**
     * endlist - End of list (controllers, events, etc.)
     */

    return AnimationSection;
  })();

  /**
   * Single line in ASCII MDL file
   */

  var AsciiLine = MdlAscii.AsciiLine = (function() {
    function AsciiLine(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    AsciiLine.prototype._read = function() {
      this.content = KaitaiStream.bytesToStr(this._io.readBytesTerm(10, false, true, false), "UTF-8");
    }

    return AsciiLine;
  })();

  /**
   * Bezier (smooth animated) controller format
   */

  var ControllerBezier = MdlAscii.ControllerBezier = (function() {
    function ControllerBezier(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ControllerBezier.prototype._read = function() {
      this.controllerName = new LineText(this._io, this, this._root);
      this.keyframes = [];
      var i = 0;
      while (!this._io.isEof()) {
        this.keyframes.push(new ControllerBezierKeyframe(this._io, this, this._root));
        i++;
      }
    }

    /**
     * Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
     */

    /**
     * Keyframe entries until endlist keyword
     */

    return ControllerBezier;
  })();

  /**
   * Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
   */

  var ControllerBezierKeyframe = MdlAscii.ControllerBezierKeyframe = (function() {
    function ControllerBezierKeyframe(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ControllerBezierKeyframe.prototype._read = function() {
      this.time = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
      this.valueData = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
    }

    /**
     * Time value (float)
     */

    /**
     * Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
     */

    return ControllerBezierKeyframe;
  })();

  /**
   * Keyed (animated) controller format
   */

  var ControllerKeyed = MdlAscii.ControllerKeyed = (function() {
    function ControllerKeyed(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ControllerKeyed.prototype._read = function() {
      this.controllerName = new LineText(this._io, this, this._root);
      this.keyframes = [];
      var i = 0;
      while (!this._io.isEof()) {
        this.keyframes.push(new ControllerKeyframe(this._io, this, this._root));
        i++;
      }
    }

    /**
     * Controller name followed by 'key' (e.g., positionkey, orientationkey)
     */

    /**
     * Keyframe entries until endlist keyword
     */

    return ControllerKeyed;
  })();

  /**
   * Single keyframe in keyed controller
   */

  var ControllerKeyframe = MdlAscii.ControllerKeyframe = (function() {
    function ControllerKeyframe(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ControllerKeyframe.prototype._read = function() {
      this.time = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
      this.values = KaitaiStream.bytesToStr(this._io.readBytesFull(), "UTF-8");
    }

    /**
     * Time value (float)
     */

    /**
     * Space-separated property values (number depends on controller type and column count)
     */

    return ControllerKeyframe;
  })();

  /**
   * Single (constant) controller format
   */

  var ControllerSingle = MdlAscii.ControllerSingle = (function() {
    function ControllerSingle(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ControllerSingle.prototype._read = function() {
      this.controllerName = new LineText(this._io, this, this._root);
      this.values = new LineText(this._io, this, this._root);
    }

    /**
     * Controller name (position, orientation, scale, color, radius, etc.)
     */

    /**
     * Space-separated controller values (number depends on controller type)
     */

    return ControllerSingle;
  })();

  /**
   * Danglymesh node properties
   */

  var DanglymeshProperties = MdlAscii.DanglymeshProperties = (function() {
    function DanglymeshProperties(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DanglymeshProperties.prototype._read = function() {
      this.displacement = new LineText(this._io, this, this._root);
      this.tightness = new LineText(this._io, this, this._root);
      this.period = new LineText(this._io, this, this._root);
    }

    /**
     * displacement <value> - Maximum displacement distance for physics simulation
     */

    /**
     * tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
     */

    /**
     * period <value> - Oscillation period in seconds
     */

    return DanglymeshProperties;
  })();

  /**
   * Data array keywords
   */

  var DataArrays = MdlAscii.DataArrays = (function() {
    function DataArrays(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    DataArrays.prototype._read = function() {
      this.verts = new LineText(this._io, this, this._root);
      this.faces = new LineText(this._io, this, this._root);
      this.tverts = new LineText(this._io, this, this._root);
      this.tverts1 = new LineText(this._io, this, this._root);
      this.lightmaptverts = new LineText(this._io, this, this._root);
      this.tverts2 = new LineText(this._io, this, this._root);
      this.tverts3 = new LineText(this._io, this, this._root);
      this.texindices1 = new LineText(this._io, this, this._root);
      this.texindices2 = new LineText(this._io, this, this._root);
      this.texindices3 = new LineText(this._io, this, this._root);
      this.colors = new LineText(this._io, this, this._root);
      this.colorindices = new LineText(this._io, this, this._root);
      this.weights = new LineText(this._io, this, this._root);
      this.constraints = new LineText(this._io, this, this._root);
      this.aabb = new LineText(this._io, this, this._root);
      this.saberVerts = new LineText(this._io, this, this._root);
      this.saberNorms = new LineText(this._io, this, this._root);
      this.name = new LineText(this._io, this, this._root);
    }

    /**
     * verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
     */

    /**
     * faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
     */

    /**
     * tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
     */

    /**
     * tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
     */

    /**
     * lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
     */

    /**
     * tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
     */

    /**
     * tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
     */

    /**
     * texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
     */

    /**
     * texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
     */

    /**
     * texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
     */

    /**
     * colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
     */

    /**
     * colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
     */

    /**
     * weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
     */

    /**
     * constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
     */

    /**
     * aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
     */

    /**
     * saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
     */

    /**
     * saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
     */

    /**
     * name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
     */

    return DataArrays;
  })();

  /**
   * Emitter behavior flags
   */

  var EmitterFlags = MdlAscii.EmitterFlags = (function() {
    function EmitterFlags(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    EmitterFlags.prototype._read = function() {
      this.p2p = new LineText(this._io, this, this._root);
      this.p2pSel = new LineText(this._io, this, this._root);
      this.affectedByWind = new LineText(this._io, this, this._root);
      this.mIsTinted = new LineText(this._io, this, this._root);
      this.bounce = new LineText(this._io, this, this._root);
      this.random = new LineText(this._io, this, this._root);
      this.inherit = new LineText(this._io, this, this._root);
      this.inheritvel = new LineText(this._io, this, this._root);
      this.inheritLocal = new LineText(this._io, this, this._root);
      this.splat = new LineText(this._io, this, this._root);
      this.inheritPart = new LineText(this._io, this, this._root);
      this.depthTexture = new LineText(this._io, this, this._root);
      this.emitterflag13 = new LineText(this._io, this, this._root);
    }

    /**
     * p2p <0_or_1> - Point-to-point flag (bit 0x0001)
     */

    /**
     * p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
     */

    /**
     * affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
     */

    /**
     * m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
     */

    /**
     * bounce <0_or_1> - Bounce flag (bit 0x0010)
     */

    /**
     * random <0_or_1> - Random flag (bit 0x0020)
     */

    /**
     * inherit <0_or_1> - Inherit flag (bit 0x0040)
     */

    /**
     * inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
     */

    /**
     * inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
     */

    /**
     * splat <0_or_1> - Splat flag (bit 0x0200)
     */

    /**
     * inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
     */

    /**
     * depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
     */

    /**
     * emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
     */

    return EmitterFlags;
  })();

  /**
   * Emitter node properties
   */

  var EmitterProperties = MdlAscii.EmitterProperties = (function() {
    function EmitterProperties(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    EmitterProperties.prototype._read = function() {
      this.deadspace = new LineText(this._io, this, this._root);
      this.blastRadius = new LineText(this._io, this, this._root);
      this.blastLength = new LineText(this._io, this, this._root);
      this.numBranches = new LineText(this._io, this, this._root);
      this.controlptsmoothing = new LineText(this._io, this, this._root);
      this.xgrid = new LineText(this._io, this, this._root);
      this.ygrid = new LineText(this._io, this, this._root);
      this.spawntype = new LineText(this._io, this, this._root);
      this.update = new LineText(this._io, this, this._root);
      this.render = new LineText(this._io, this, this._root);
      this.blend = new LineText(this._io, this, this._root);
      this.texture = new LineText(this._io, this, this._root);
      this.chunkname = new LineText(this._io, this, this._root);
      this.twosidedtex = new LineText(this._io, this, this._root);
      this.loop = new LineText(this._io, this, this._root);
      this.renderorder = new LineText(this._io, this, this._root);
      this.mBFrameBlending = new LineText(this._io, this, this._root);
      this.mSDepthTextureName = new LineText(this._io, this, this._root);
    }

    /**
     * deadspace <value> - Minimum distance from emitter before particles become visible
     */

    /**
     * blastRadius <value> - Radius of explosive/blast particle effects
     */

    /**
     * blastLength <value> - Length/duration of blast effects
     */

    /**
     * numBranches <value> - Number of branching paths for particle trails
     */

    /**
     * controlptsmoothing <value> - Smoothing factor for particle path control points
     */

    /**
     * xgrid <value> - Grid subdivisions along X axis for particle spawning
     */

    /**
     * ygrid <value> - Grid subdivisions along Y axis for particle spawning
     */

    /**
     * spawntype <value> - Particle spawn type
     */

    /**
     * update <script_name> - Update behavior script name (e.g., single, fountain)
     */

    /**
     * render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
     */

    /**
     * blend <script_name> - Blend mode script name (e.g., normal, lighten)
     */

    /**
     * texture <texture_name> - Particle texture name
     */

    /**
     * chunkname <chunk_name> - Associated model chunk name
     */

    /**
     * twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
     */

    /**
     * loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
     */

    /**
     * renderorder <value> - Rendering priority/order for particle sorting
     */

    /**
     * m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
     */

    /**
     * m_sDepthTextureName <texture_name> - Depth/softparticle texture name
     */

    return EmitterProperties;
  })();

  /**
   * Light node properties
   */

  var LightProperties = MdlAscii.LightProperties = (function() {
    function LightProperties(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LightProperties.prototype._read = function() {
      this.flareradius = new LineText(this._io, this, this._root);
      this.flarepositions = new LineText(this._io, this, this._root);
      this.flaresizes = new LineText(this._io, this, this._root);
      this.flarecolorshifts = new LineText(this._io, this, this._root);
      this.texturenames = new LineText(this._io, this, this._root);
      this.ambientonly = new LineText(this._io, this, this._root);
      this.ndynamictype = new LineText(this._io, this, this._root);
      this.affectdynamic = new LineText(this._io, this, this._root);
      this.flare = new LineText(this._io, this, this._root);
      this.lightpriority = new LineText(this._io, this, this._root);
      this.fadinglight = new LineText(this._io, this, this._root);
    }

    /**
     * flareradius <value> - Radius of lens flare effect
     */

    /**
     * flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
     */

    /**
     * flaresizes <count> - Start flare sizes array (count floats)
     */

    /**
     * flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
     */

    /**
     * texturenames <count> - Start flare texture names array (count strings)
     */

    /**
     * ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
     */

    /**
     * ndynamictype <value> - Type of dynamic lighting behavior
     */

    /**
     * affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
     */

    /**
     * flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
     */

    /**
     * lightpriority <value> - Rendering priority for light culling/sorting
     */

    /**
     * fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
     */

    return LightProperties;
  })();

  /**
   * A single UTF-8 text line (without the trailing newline).
   * Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
   */

  var LineText = MdlAscii.LineText = (function() {
    function LineText(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    LineText.prototype._read = function() {
      this.value = KaitaiStream.bytesToStr(this._io.readBytesTerm(10, false, true, false), "UTF-8");
    }

    return LineText;
  })();

  /**
   * Reference node properties
   */

  var ReferenceProperties = MdlAscii.ReferenceProperties = (function() {
    function ReferenceProperties(_io, _parent, _root) {
      this._io = _io;
      this._parent = _parent;
      this._root = _root;

      this._read();
    }
    ReferenceProperties.prototype._read = function() {
      this.refmodel = new LineText(this._io, this, this._root);
      this.reattachable = new LineText(this._io, this, this._root);
    }

    /**
     * refmodel <model_resref> - Referenced model resource name without extension
     */

    /**
     * reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
     */

    return ReferenceProperties;
  })();

  return MdlAscii;
})();
MdlAscii_.MdlAscii = MdlAscii;
});

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
    /// Used by modding tools for easier editing than binary MDL format.
    /// 
    /// The ASCII format represents the model structure using plain text with keyword-based syntax.
    /// Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
    /// 
    /// Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
    /// documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
    /// full binary-vs-text scope rule.
    /// 
    /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
    /// Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
    /// Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
    /// and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79">xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88">xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format">PyKotor wiki — ASCII MDL</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format">PyKotor wiki — binary MDL (wire vs ASCII)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy">In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698">Community MDLOps — readasciimdl</a>
    /// </remarks>
    public partial class MdlAscii : KaitaiStruct
    {
        public static MdlAscii FromFile(string fileName)
        {
            return new MdlAscii(new KaitaiStream(fileName));
        }

        public MdlAscii(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _lines = new List<AsciiLine>();
            {
                var i = 0;
                while (!m_io.IsEof) {
                    _lines.Add(new AsciiLine(m_io, this, m_root));
                    i++;
                }
            }
        }

        /// <summary>
        /// Animation section keywords
        /// </summary>
        public partial class AnimationSection : KaitaiStruct
        {
            public static AnimationSection FromFile(string fileName)
            {
                return new AnimationSection(new KaitaiStream(fileName));
            }

            public AnimationSection(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _newanim = new LineText(m_io, this, m_root);
                _doneanim = new LineText(m_io, this, m_root);
                _length = new LineText(m_io, this, m_root);
                _transtime = new LineText(m_io, this, m_root);
                _animroot = new LineText(m_io, this, m_root);
                _event = new LineText(m_io, this, m_root);
                _eventlist = new LineText(m_io, this, m_root);
                _endlist = new LineText(m_io, this, m_root);
            }
            private LineText _newanim;
            private LineText _doneanim;
            private LineText _length;
            private LineText _transtime;
            private LineText _animroot;
            private LineText _event;
            private LineText _eventlist;
            private LineText _endlist;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// newanim &lt;animation_name&gt; &lt;model_name&gt; - Start of animation definition
            /// </summary>
            public LineText Newanim { get { return _newanim; } }

            /// <summary>
            /// doneanim &lt;animation_name&gt; &lt;model_name&gt; - End of animation definition
            /// </summary>
            public LineText Doneanim { get { return _doneanim; } }

            /// <summary>
            /// length &lt;duration&gt; - Animation duration in seconds
            /// </summary>
            public LineText Length { get { return _length; } }

            /// <summary>
            /// transtime &lt;transition_time&gt; - Transition/blend time to this animation in seconds
            /// </summary>
            public LineText Transtime { get { return _transtime; } }

            /// <summary>
            /// animroot &lt;root_node_name&gt; - Root node name for animation
            /// </summary>
            public LineText Animroot { get { return _animroot; } }

            /// <summary>
            /// event &lt;time&gt; &lt;event_name&gt; - Animation event (triggers at specified time)
            /// </summary>
            public LineText Event { get { return _event; } }

            /// <summary>
            /// eventlist - Start of animation events list
            /// </summary>
            public LineText Eventlist { get { return _eventlist; } }

            /// <summary>
            /// endlist - End of list (controllers, events, etc.)
            /// </summary>
            public LineText Endlist { get { return _endlist; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Single line in ASCII MDL file
        /// </summary>
        public partial class AsciiLine : KaitaiStruct
        {
            public static AsciiLine FromFile(string fileName)
            {
                return new AsciiLine(new KaitaiStream(fileName));
            }

            public AsciiLine(KaitaiStream p__io, MdlAscii p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _content = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesTerm(10, false, true, false));
            }
            private string _content;
            private MdlAscii m_root;
            private MdlAscii m_parent;
            public string Content { get { return _content; } }
            public MdlAscii M_Root { get { return m_root; } }
            public MdlAscii M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Bezier (smooth animated) controller format
        /// </summary>
        public partial class ControllerBezier : KaitaiStruct
        {
            public static ControllerBezier FromFile(string fileName)
            {
                return new ControllerBezier(new KaitaiStream(fileName));
            }

            public ControllerBezier(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _controllerName = new LineText(m_io, this, m_root);
                _keyframes = new List<ControllerBezierKeyframe>();
                {
                    var i = 0;
                    while (!m_io.IsEof) {
                        _keyframes.Add(new ControllerBezierKeyframe(m_io, this, m_root));
                        i++;
                    }
                }
            }
            private LineText _controllerName;
            private List<ControllerBezierKeyframe> _keyframes;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
            /// </summary>
            public LineText ControllerName { get { return _controllerName; } }

            /// <summary>
            /// Keyframe entries until endlist keyword
            /// </summary>
            public List<ControllerBezierKeyframe> Keyframes { get { return _keyframes; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
        /// </summary>
        public partial class ControllerBezierKeyframe : KaitaiStruct
        {
            public static ControllerBezierKeyframe FromFile(string fileName)
            {
                return new ControllerBezierKeyframe(new KaitaiStream(fileName));
            }

            public ControllerBezierKeyframe(KaitaiStream p__io, MdlAscii.ControllerBezier p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _time = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
                _valueData = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
            }
            private string _time;
            private string _valueData;
            private MdlAscii m_root;
            private MdlAscii.ControllerBezier m_parent;

            /// <summary>
            /// Time value (float)
            /// </summary>
            public string Time { get { return _time; } }

            /// <summary>
            /// Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
            /// </summary>
            public string ValueData { get { return _valueData; } }
            public MdlAscii M_Root { get { return m_root; } }
            public MdlAscii.ControllerBezier M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Keyed (animated) controller format
        /// </summary>
        public partial class ControllerKeyed : KaitaiStruct
        {
            public static ControllerKeyed FromFile(string fileName)
            {
                return new ControllerKeyed(new KaitaiStream(fileName));
            }

            public ControllerKeyed(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _controllerName = new LineText(m_io, this, m_root);
                _keyframes = new List<ControllerKeyframe>();
                {
                    var i = 0;
                    while (!m_io.IsEof) {
                        _keyframes.Add(new ControllerKeyframe(m_io, this, m_root));
                        i++;
                    }
                }
            }
            private LineText _controllerName;
            private List<ControllerKeyframe> _keyframes;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Controller name followed by 'key' (e.g., positionkey, orientationkey)
            /// </summary>
            public LineText ControllerName { get { return _controllerName; } }

            /// <summary>
            /// Keyframe entries until endlist keyword
            /// </summary>
            public List<ControllerKeyframe> Keyframes { get { return _keyframes; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Single keyframe in keyed controller
        /// </summary>
        public partial class ControllerKeyframe : KaitaiStruct
        {
            public static ControllerKeyframe FromFile(string fileName)
            {
                return new ControllerKeyframe(new KaitaiStream(fileName));
            }

            public ControllerKeyframe(KaitaiStream p__io, MdlAscii.ControllerKeyed p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _time = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
                _values = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesFull());
            }
            private string _time;
            private string _values;
            private MdlAscii m_root;
            private MdlAscii.ControllerKeyed m_parent;

            /// <summary>
            /// Time value (float)
            /// </summary>
            public string Time { get { return _time; } }

            /// <summary>
            /// Space-separated property values (number depends on controller type and column count)
            /// </summary>
            public string Values { get { return _values; } }
            public MdlAscii M_Root { get { return m_root; } }
            public MdlAscii.ControllerKeyed M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Single (constant) controller format
        /// </summary>
        public partial class ControllerSingle : KaitaiStruct
        {
            public static ControllerSingle FromFile(string fileName)
            {
                return new ControllerSingle(new KaitaiStream(fileName));
            }

            public ControllerSingle(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _controllerName = new LineText(m_io, this, m_root);
                _values = new LineText(m_io, this, m_root);
            }
            private LineText _controllerName;
            private LineText _values;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Controller name (position, orientation, scale, color, radius, etc.)
            /// </summary>
            public LineText ControllerName { get { return _controllerName; } }

            /// <summary>
            /// Space-separated controller values (number depends on controller type)
            /// </summary>
            public LineText Values { get { return _values; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Danglymesh node properties
        /// </summary>
        public partial class DanglymeshProperties : KaitaiStruct
        {
            public static DanglymeshProperties FromFile(string fileName)
            {
                return new DanglymeshProperties(new KaitaiStream(fileName));
            }

            public DanglymeshProperties(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _displacement = new LineText(m_io, this, m_root);
                _tightness = new LineText(m_io, this, m_root);
                _period = new LineText(m_io, this, m_root);
            }
            private LineText _displacement;
            private LineText _tightness;
            private LineText _period;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// displacement &lt;value&gt; - Maximum displacement distance for physics simulation
            /// </summary>
            public LineText Displacement { get { return _displacement; } }

            /// <summary>
            /// tightness &lt;value&gt; - Tightness/stiffness of spring simulation (0.0-1.0)
            /// </summary>
            public LineText Tightness { get { return _tightness; } }

            /// <summary>
            /// period &lt;value&gt; - Oscillation period in seconds
            /// </summary>
            public LineText Period { get { return _period; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Data array keywords
        /// </summary>
        public partial class DataArrays : KaitaiStruct
        {
            public static DataArrays FromFile(string fileName)
            {
                return new DataArrays(new KaitaiStream(fileName));
            }

            public DataArrays(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _verts = new LineText(m_io, this, m_root);
                _faces = new LineText(m_io, this, m_root);
                _tverts = new LineText(m_io, this, m_root);
                _tverts1 = new LineText(m_io, this, m_root);
                _lightmaptverts = new LineText(m_io, this, m_root);
                _tverts2 = new LineText(m_io, this, m_root);
                _tverts3 = new LineText(m_io, this, m_root);
                _texindices1 = new LineText(m_io, this, m_root);
                _texindices2 = new LineText(m_io, this, m_root);
                _texindices3 = new LineText(m_io, this, m_root);
                _colors = new LineText(m_io, this, m_root);
                _colorindices = new LineText(m_io, this, m_root);
                _weights = new LineText(m_io, this, m_root);
                _constraints = new LineText(m_io, this, m_root);
                _aabb = new LineText(m_io, this, m_root);
                _saberVerts = new LineText(m_io, this, m_root);
                _saberNorms = new LineText(m_io, this, m_root);
                _name = new LineText(m_io, this, m_root);
            }
            private LineText _verts;
            private LineText _faces;
            private LineText _tverts;
            private LineText _tverts1;
            private LineText _lightmaptverts;
            private LineText _tverts2;
            private LineText _tverts3;
            private LineText _texindices1;
            private LineText _texindices2;
            private LineText _texindices3;
            private LineText _colors;
            private LineText _colorindices;
            private LineText _weights;
            private LineText _constraints;
            private LineText _aabb;
            private LineText _saberVerts;
            private LineText _saberNorms;
            private LineText _name;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// verts &lt;count&gt; - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
            /// </summary>
            public LineText Verts { get { return _verts; } }

            /// <summary>
            /// faces &lt;count&gt; - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
            /// </summary>
            public LineText Faces { get { return _faces; } }

            /// <summary>
            /// tverts &lt;count&gt; - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
            /// </summary>
            public LineText Tverts { get { return _tverts; } }

            /// <summary>
            /// tverts1 &lt;count&gt; - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
            /// </summary>
            public LineText Tverts1 { get { return _tverts1; } }

            /// <summary>
            /// lightmaptverts &lt;count&gt; - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
            /// </summary>
            public LineText Lightmaptverts { get { return _lightmaptverts; } }

            /// <summary>
            /// tverts2 &lt;count&gt; - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
            /// </summary>
            public LineText Tverts2 { get { return _tverts2; } }

            /// <summary>
            /// tverts3 &lt;count&gt; - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
            /// </summary>
            public LineText Tverts3 { get { return _tverts3; } }

            /// <summary>
            /// texindices1 &lt;count&gt; - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
            /// </summary>
            public LineText Texindices1 { get { return _texindices1; } }

            /// <summary>
            /// texindices2 &lt;count&gt; - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
            /// </summary>
            public LineText Texindices2 { get { return _texindices2; } }

            /// <summary>
            /// texindices3 &lt;count&gt; - Start texture indices array for 4th texture (count face indices, 3 indices per face)
            /// </summary>
            public LineText Texindices3 { get { return _texindices3; } }

            /// <summary>
            /// colors &lt;count&gt; - Start vertex colors array (count colors, 3 floats each: R, G, B)
            /// </summary>
            public LineText Colors { get { return _colors; } }

            /// <summary>
            /// colorindices &lt;count&gt; - Start vertex color indices array (count face indices, 3 indices per face)
            /// </summary>
            public LineText Colorindices { get { return _colorindices; } }

            /// <summary>
            /// weights &lt;count&gt; - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
            /// </summary>
            public LineText Weights { get { return _weights; } }

            /// <summary>
            /// constraints &lt;count&gt; - Start vertex constraints array for danglymesh (count floats, one per vertex)
            /// </summary>
            public LineText Constraints { get { return _constraints; } }

            /// <summary>
            /// aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
            /// </summary>
            public LineText Aabb { get { return _aabb; } }

            /// <summary>
            /// saber_verts &lt;count&gt; - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
            /// </summary>
            public LineText SaberVerts { get { return _saberVerts; } }

            /// <summary>
            /// saber_norms &lt;count&gt; - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
            /// </summary>
            public LineText SaberNorms { get { return _saberNorms; } }

            /// <summary>
            /// name &lt;node_name&gt; - MDLedit-style name entry for walkmesh nodes (fakenodes)
            /// </summary>
            public LineText Name { get { return _name; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Emitter behavior flags
        /// </summary>
        public partial class EmitterFlags : KaitaiStruct
        {
            public static EmitterFlags FromFile(string fileName)
            {
                return new EmitterFlags(new KaitaiStream(fileName));
            }

            public EmitterFlags(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _p2p = new LineText(m_io, this, m_root);
                _p2pSel = new LineText(m_io, this, m_root);
                _affectedByWind = new LineText(m_io, this, m_root);
                _mIsTinted = new LineText(m_io, this, m_root);
                _bounce = new LineText(m_io, this, m_root);
                _random = new LineText(m_io, this, m_root);
                _inherit = new LineText(m_io, this, m_root);
                _inheritvel = new LineText(m_io, this, m_root);
                _inheritLocal = new LineText(m_io, this, m_root);
                _splat = new LineText(m_io, this, m_root);
                _inheritPart = new LineText(m_io, this, m_root);
                _depthTexture = new LineText(m_io, this, m_root);
                _emitterflag13 = new LineText(m_io, this, m_root);
            }
            private LineText _p2p;
            private LineText _p2pSel;
            private LineText _affectedByWind;
            private LineText _mIsTinted;
            private LineText _bounce;
            private LineText _random;
            private LineText _inherit;
            private LineText _inheritvel;
            private LineText _inheritLocal;
            private LineText _splat;
            private LineText _inheritPart;
            private LineText _depthTexture;
            private LineText _emitterflag13;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// p2p &lt;0_or_1&gt; - Point-to-point flag (bit 0x0001)
            /// </summary>
            public LineText P2p { get { return _p2p; } }

            /// <summary>
            /// p2p_sel &lt;0_or_1&gt; - Point-to-point selection flag (bit 0x0002)
            /// </summary>
            public LineText P2pSel { get { return _p2pSel; } }

            /// <summary>
            /// affectedByWind &lt;0_or_1&gt; - Affected by wind flag (bit 0x0004)
            /// </summary>
            public LineText AffectedByWind { get { return _affectedByWind; } }

            /// <summary>
            /// m_isTinted &lt;0_or_1&gt; - Is tinted flag (bit 0x0008)
            /// </summary>
            public LineText MIsTinted { get { return _mIsTinted; } }

            /// <summary>
            /// bounce &lt;0_or_1&gt; - Bounce flag (bit 0x0010)
            /// </summary>
            public LineText Bounce { get { return _bounce; } }

            /// <summary>
            /// random &lt;0_or_1&gt; - Random flag (bit 0x0020)
            /// </summary>
            public LineText Random { get { return _random; } }

            /// <summary>
            /// inherit &lt;0_or_1&gt; - Inherit flag (bit 0x0040)
            /// </summary>
            public LineText Inherit { get { return _inherit; } }

            /// <summary>
            /// inheritvel &lt;0_or_1&gt; - Inherit velocity flag (bit 0x0080)
            /// </summary>
            public LineText Inheritvel { get { return _inheritvel; } }

            /// <summary>
            /// inherit_local &lt;0_or_1&gt; - Inherit local flag (bit 0x0100)
            /// </summary>
            public LineText InheritLocal { get { return _inheritLocal; } }

            /// <summary>
            /// splat &lt;0_or_1&gt; - Splat flag (bit 0x0200)
            /// </summary>
            public LineText Splat { get { return _splat; } }

            /// <summary>
            /// inherit_part &lt;0_or_1&gt; - Inherit part flag (bit 0x0400)
            /// </summary>
            public LineText InheritPart { get { return _inheritPart; } }

            /// <summary>
            /// depth_texture &lt;0_or_1&gt; - Depth texture flag (bit 0x0800)
            /// </summary>
            public LineText DepthTexture { get { return _depthTexture; } }

            /// <summary>
            /// emitterflag13 &lt;0_or_1&gt; - Emitter flag 13 (bit 0x1000)
            /// </summary>
            public LineText Emitterflag13 { get { return _emitterflag13; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Emitter node properties
        /// </summary>
        public partial class EmitterProperties : KaitaiStruct
        {
            public static EmitterProperties FromFile(string fileName)
            {
                return new EmitterProperties(new KaitaiStream(fileName));
            }

            public EmitterProperties(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _deadspace = new LineText(m_io, this, m_root);
                _blastRadius = new LineText(m_io, this, m_root);
                _blastLength = new LineText(m_io, this, m_root);
                _numBranches = new LineText(m_io, this, m_root);
                _controlptsmoothing = new LineText(m_io, this, m_root);
                _xgrid = new LineText(m_io, this, m_root);
                _ygrid = new LineText(m_io, this, m_root);
                _spawntype = new LineText(m_io, this, m_root);
                _update = new LineText(m_io, this, m_root);
                _render = new LineText(m_io, this, m_root);
                _blend = new LineText(m_io, this, m_root);
                _texture = new LineText(m_io, this, m_root);
                _chunkname = new LineText(m_io, this, m_root);
                _twosidedtex = new LineText(m_io, this, m_root);
                _loop = new LineText(m_io, this, m_root);
                _renderorder = new LineText(m_io, this, m_root);
                _mBFrameBlending = new LineText(m_io, this, m_root);
                _mSDepthTextureName = new LineText(m_io, this, m_root);
            }
            private LineText _deadspace;
            private LineText _blastRadius;
            private LineText _blastLength;
            private LineText _numBranches;
            private LineText _controlptsmoothing;
            private LineText _xgrid;
            private LineText _ygrid;
            private LineText _spawntype;
            private LineText _update;
            private LineText _render;
            private LineText _blend;
            private LineText _texture;
            private LineText _chunkname;
            private LineText _twosidedtex;
            private LineText _loop;
            private LineText _renderorder;
            private LineText _mBFrameBlending;
            private LineText _mSDepthTextureName;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// deadspace &lt;value&gt; - Minimum distance from emitter before particles become visible
            /// </summary>
            public LineText Deadspace { get { return _deadspace; } }

            /// <summary>
            /// blastRadius &lt;value&gt; - Radius of explosive/blast particle effects
            /// </summary>
            public LineText BlastRadius { get { return _blastRadius; } }

            /// <summary>
            /// blastLength &lt;value&gt; - Length/duration of blast effects
            /// </summary>
            public LineText BlastLength { get { return _blastLength; } }

            /// <summary>
            /// numBranches &lt;value&gt; - Number of branching paths for particle trails
            /// </summary>
            public LineText NumBranches { get { return _numBranches; } }

            /// <summary>
            /// controlptsmoothing &lt;value&gt; - Smoothing factor for particle path control points
            /// </summary>
            public LineText Controlptsmoothing { get { return _controlptsmoothing; } }

            /// <summary>
            /// xgrid &lt;value&gt; - Grid subdivisions along X axis for particle spawning
            /// </summary>
            public LineText Xgrid { get { return _xgrid; } }

            /// <summary>
            /// ygrid &lt;value&gt; - Grid subdivisions along Y axis for particle spawning
            /// </summary>
            public LineText Ygrid { get { return _ygrid; } }

            /// <summary>
            /// spawntype &lt;value&gt; - Particle spawn type
            /// </summary>
            public LineText Spawntype { get { return _spawntype; } }

            /// <summary>
            /// update &lt;script_name&gt; - Update behavior script name (e.g., single, fountain)
            /// </summary>
            public LineText Update { get { return _update; } }

            /// <summary>
            /// render &lt;script_name&gt; - Render mode script name (e.g., normal, billboard_to_local_z)
            /// </summary>
            public LineText Render { get { return _render; } }

            /// <summary>
            /// blend &lt;script_name&gt; - Blend mode script name (e.g., normal, lighten)
            /// </summary>
            public LineText Blend { get { return _blend; } }

            /// <summary>
            /// texture &lt;texture_name&gt; - Particle texture name
            /// </summary>
            public LineText Texture { get { return _texture; } }

            /// <summary>
            /// chunkname &lt;chunk_name&gt; - Associated model chunk name
            /// </summary>
            public LineText Chunkname { get { return _chunkname; } }

            /// <summary>
            /// twosidedtex &lt;0_or_1&gt; - Whether texture should render two-sided (1=two-sided, 0=single-sided)
            /// </summary>
            public LineText Twosidedtex { get { return _twosidedtex; } }

            /// <summary>
            /// loop &lt;0_or_1&gt; - Whether particle system loops (1=loops, 0=single playback)
            /// </summary>
            public LineText Loop { get { return _loop; } }

            /// <summary>
            /// renderorder &lt;value&gt; - Rendering priority/order for particle sorting
            /// </summary>
            public LineText Renderorder { get { return _renderorder; } }

            /// <summary>
            /// m_bFrameBlending &lt;0_or_1&gt; - Whether frame blending is enabled (1=enabled, 0=disabled)
            /// </summary>
            public LineText MBFrameBlending { get { return _mBFrameBlending; } }

            /// <summary>
            /// m_sDepthTextureName &lt;texture_name&gt; - Depth/softparticle texture name
            /// </summary>
            public LineText MSDepthTextureName { get { return _mSDepthTextureName; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Light node properties
        /// </summary>
        public partial class LightProperties : KaitaiStruct
        {
            public static LightProperties FromFile(string fileName)
            {
                return new LightProperties(new KaitaiStream(fileName));
            }

            public LightProperties(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _flareradius = new LineText(m_io, this, m_root);
                _flarepositions = new LineText(m_io, this, m_root);
                _flaresizes = new LineText(m_io, this, m_root);
                _flarecolorshifts = new LineText(m_io, this, m_root);
                _texturenames = new LineText(m_io, this, m_root);
                _ambientonly = new LineText(m_io, this, m_root);
                _ndynamictype = new LineText(m_io, this, m_root);
                _affectdynamic = new LineText(m_io, this, m_root);
                _flare = new LineText(m_io, this, m_root);
                _lightpriority = new LineText(m_io, this, m_root);
                _fadinglight = new LineText(m_io, this, m_root);
            }
            private LineText _flareradius;
            private LineText _flarepositions;
            private LineText _flaresizes;
            private LineText _flarecolorshifts;
            private LineText _texturenames;
            private LineText _ambientonly;
            private LineText _ndynamictype;
            private LineText _affectdynamic;
            private LineText _flare;
            private LineText _lightpriority;
            private LineText _fadinglight;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// flareradius &lt;value&gt; - Radius of lens flare effect
            /// </summary>
            public LineText Flareradius { get { return _flareradius; } }

            /// <summary>
            /// flarepositions &lt;count&gt; - Start flare positions array (count floats, 0.0-1.0 along light ray)
            /// </summary>
            public LineText Flarepositions { get { return _flarepositions; } }

            /// <summary>
            /// flaresizes &lt;count&gt; - Start flare sizes array (count floats)
            /// </summary>
            public LineText Flaresizes { get { return _flaresizes; } }

            /// <summary>
            /// flarecolorshifts &lt;count&gt; - Start flare color shifts array (count RGB floats)
            /// </summary>
            public LineText Flarecolorshifts { get { return _flarecolorshifts; } }

            /// <summary>
            /// texturenames &lt;count&gt; - Start flare texture names array (count strings)
            /// </summary>
            public LineText Texturenames { get { return _texturenames; } }

            /// <summary>
            /// ambientonly &lt;0_or_1&gt; - Whether light only affects ambient (1=ambient only, 0=full lighting)
            /// </summary>
            public LineText Ambientonly { get { return _ambientonly; } }

            /// <summary>
            /// ndynamictype &lt;value&gt; - Type of dynamic lighting behavior
            /// </summary>
            public LineText Ndynamictype { get { return _ndynamictype; } }

            /// <summary>
            /// affectdynamic &lt;0_or_1&gt; - Whether light affects dynamic objects (1=affects, 0=static only)
            /// </summary>
            public LineText Affectdynamic { get { return _affectdynamic; } }

            /// <summary>
            /// flare &lt;0_or_1&gt; - Whether lens flare effect is enabled (1=enabled, 0=disabled)
            /// </summary>
            public LineText Flare { get { return _flare; } }

            /// <summary>
            /// lightpriority &lt;value&gt; - Rendering priority for light culling/sorting
            /// </summary>
            public LineText Lightpriority { get { return _lightpriority; } }

            /// <summary>
            /// fadinglight &lt;0_or_1&gt; - Whether light intensity fades with distance (1=fades, 0=constant)
            /// </summary>
            public LineText Fadinglight { get { return _fadinglight; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// A single UTF-8 text line (without the trailing newline).
        /// Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
        /// </summary>
        public partial class LineText : KaitaiStruct
        {
            public static LineText FromFile(string fileName)
            {
                return new LineText(new KaitaiStream(fileName));
            }

            public LineText(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _value = System.Text.Encoding.GetEncoding("UTF-8").GetString(m_io.ReadBytesTerm(10, false, true, false));
            }
            private string _value;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;
            public string Value { get { return _value; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Reference node properties
        /// </summary>
        public partial class ReferenceProperties : KaitaiStruct
        {
            public static ReferenceProperties FromFile(string fileName)
            {
                return new ReferenceProperties(new KaitaiStream(fileName));
            }

            public ReferenceProperties(KaitaiStream p__io, KaitaiStruct p__parent = null, MdlAscii p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _refmodel = new LineText(m_io, this, m_root);
                _reattachable = new LineText(m_io, this, m_root);
            }
            private LineText _refmodel;
            private LineText _reattachable;
            private MdlAscii m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// refmodel &lt;model_resref&gt; - Referenced model resource name without extension
            /// </summary>
            public LineText Refmodel { get { return _refmodel; } }

            /// <summary>
            /// reattachable &lt;0_or_1&gt; - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
            /// </summary>
            public LineText Reattachable { get { return _reattachable; } }
            public MdlAscii M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private List<AsciiLine> _lines;
        private MdlAscii m_root;
        private KaitaiStruct m_parent;
        public List<AsciiLine> Lines { get { return _lines; } }
        public MdlAscii M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// BioWare MDL Model Format
    /// 
    /// The MDL file contains:
    /// - File header (12 bytes)
    /// - Model header (196 bytes) which begins with a Geometry header (80 bytes)
    /// - Name offset array + name strings
    /// - Animation offset array + animation headers + animation nodes
    /// - Node hierarchy with geometry data
    /// 
    /// Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.
    /// 
    /// Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.
    /// 
    /// Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
    /// are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&amp;`);
    /// compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy">In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408">PyKotor — MDLBinaryReader (binary MDL/MDX)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267">xoreos — Model_KotOR::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79">xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (controller / Aurora background)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118">reone — MdlMdxReader::load</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170">KotOR.js — OdysseyModel binary constructor</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407">Community MDLOps — controller name table</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698">Community MDLOps — `readasciimdl` (ASCII MDL ingest)</a>
    /// </remarks>
    public partial class Mdl : KaitaiStruct
    {
        public static Mdl FromFile(string fileName)
        {
            return new Mdl(new KaitaiStream(fileName));
        }

        public Mdl(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_animationOffsets = false;
            f_animations = false;
            f_dataStart = false;
            f_nameOffsets = false;
            f_namesData = false;
            f_rootNode = false;
            _read();
        }
        private void _read()
        {
            _fileHeader = new FileHeader(m_io, this, m_root);
            _modelHeader = new ModelHeader(m_io, this, m_root);
        }

        /// <summary>
        /// AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
        /// </summary>
        public partial class AabbHeader : KaitaiStruct
        {
            public static AabbHeader FromFile(string fileName)
            {
                return new AabbHeader(new KaitaiStream(fileName));
            }

            public AabbHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _trimeshBase = new TrimeshHeader(m_io, this, m_root);
                _unknown = m_io.ReadU4le();
            }
            private TrimeshHeader _trimeshBase;
            private uint _unknown;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Standard trimesh header
            /// </summary>
            public TrimeshHeader TrimeshBase { get { return _trimeshBase; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown { get { return _unknown; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Animation event (36 bytes)
        /// </summary>
        public partial class AnimationEvent : KaitaiStruct
        {
            public static AnimationEvent FromFile(string fileName)
            {
                return new AnimationEvent(new KaitaiStream(fileName));
            }

            public AnimationEvent(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _activationTime = m_io.ReadF4le();
                _eventName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
            }
            private float _activationTime;
            private string _eventName;
            private Mdl m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Time in seconds when event triggers during animation playback
            /// </summary>
            public float ActivationTime { get { return _activationTime; } }

            /// <summary>
            /// Name of event (null-terminated string, e.g., &quot;detonate&quot;)
            /// </summary>
            public string EventName { get { return _eventName; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
        /// </summary>
        public partial class AnimationHeader : KaitaiStruct
        {
            public static AnimationHeader FromFile(string fileName)
            {
                return new AnimationHeader(new KaitaiStream(fileName));
            }

            public AnimationHeader(KaitaiStream p__io, Mdl.MdlAnimationEntry p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _geoHeader = new GeometryHeader(m_io, this, m_root);
                _animationLength = m_io.ReadF4le();
                _transitionTime = m_io.ReadF4le();
                _animationRoot = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _eventArrayOffset = m_io.ReadU4le();
                _eventCount = m_io.ReadU4le();
                _eventCountDuplicate = m_io.ReadU4le();
                _unknown = m_io.ReadU4le();
            }
            private GeometryHeader _geoHeader;
            private float _animationLength;
            private float _transitionTime;
            private string _animationRoot;
            private uint _eventArrayOffset;
            private uint _eventCount;
            private uint _eventCountDuplicate;
            private uint _unknown;
            private Mdl m_root;
            private Mdl.MdlAnimationEntry m_parent;

            /// <summary>
            /// Standard 80-byte geometry header (geometry_type = 0x01 for animation)
            /// </summary>
            public GeometryHeader GeoHeader { get { return _geoHeader; } }

            /// <summary>
            /// Duration of animation in seconds
            /// </summary>
            public float AnimationLength { get { return _animationLength; } }

            /// <summary>
            /// Transition/blend time to this animation in seconds
            /// </summary>
            public float TransitionTime { get { return _transitionTime; } }

            /// <summary>
            /// Root node name for animation (null-terminated string)
            /// </summary>
            public string AnimationRoot { get { return _animationRoot; } }

            /// <summary>
            /// Offset to animation events array
            /// </summary>
            public uint EventArrayOffset { get { return _eventArrayOffset; } }

            /// <summary>
            /// Number of animation events
            /// </summary>
            public uint EventCount { get { return _eventCount; } }

            /// <summary>
            /// Duplicate value of event count
            /// </summary>
            public uint EventCountDuplicate { get { return _eventCountDuplicate; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown { get { return _unknown; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.MdlAnimationEntry M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
        /// </summary>
        public partial class AnimmeshHeader : KaitaiStruct
        {
            public static AnimmeshHeader FromFile(string fileName)
            {
                return new AnimmeshHeader(new KaitaiStream(fileName));
            }

            public AnimmeshHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _trimeshBase = new TrimeshHeader(m_io, this, m_root);
                _unknown = m_io.ReadF4le();
                _unknownArray = new ArrayDefinition(m_io, this, m_root);
                _unknownFloats = new List<float>();
                for (var i = 0; i < 9; i++)
                {
                    _unknownFloats.Add(m_io.ReadF4le());
                }
            }
            private TrimeshHeader _trimeshBase;
            private float _unknown;
            private ArrayDefinition _unknownArray;
            private List<float> _unknownFloats;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Standard trimesh header
            /// </summary>
            public TrimeshHeader TrimeshBase { get { return _trimeshBase; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public float Unknown { get { return _unknown; } }

            /// <summary>
            /// Unknown array definition
            /// </summary>
            public ArrayDefinition UnknownArray { get { return _unknownArray; } }

            /// <summary>
            /// Unknown float values
            /// </summary>
            public List<float> UnknownFloats { get { return _unknownFloats; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Array definition structure (offset, count, count duplicate)
        /// </summary>
        public partial class ArrayDefinition : KaitaiStruct
        {
            public static ArrayDefinition FromFile(string fileName)
            {
                return new ArrayDefinition(new KaitaiStream(fileName));
            }

            public ArrayDefinition(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _offset = m_io.ReadS4le();
                _count = m_io.ReadU4le();
                _countDuplicate = m_io.ReadU4le();
            }
            private int _offset;
            private uint _count;
            private uint _countDuplicate;
            private Mdl m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Offset to array (relative to MDL data start, offset 12)
            /// </summary>
            public int Offset { get { return _offset; } }

            /// <summary>
            /// Number of used entries
            /// </summary>
            public uint Count { get { return _count; } }

            /// <summary>
            /// Duplicate of count (allocated entries)
            /// </summary>
            public uint CountDuplicate { get { return _countDuplicate; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Controller structure (16 bytes) - defines animation data for a node property over time
        /// </summary>
        public partial class Controller : KaitaiStruct
        {
            public static Controller FromFile(string fileName)
            {
                return new Controller(new KaitaiStream(fileName));
            }

            public Controller(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_usesBezier = false;
                _read();
            }
            private void _read()
            {
                _type = ((BiowareMdlCommon.ControllerType) m_io.ReadU4le());
                _unknown = m_io.ReadU2le();
                _rowCount = m_io.ReadU2le();
                _timeIndex = m_io.ReadU2le();
                _dataIndex = m_io.ReadU2le();
                _columnCount = m_io.ReadU1();
                _padding = new List<byte>();
                for (var i = 0; i < 3; i++)
                {
                    _padding.Add(m_io.ReadU1());
                }
            }
            private bool f_usesBezier;
            private bool _usesBezier;

            /// <summary>
            /// True if controller uses Bezier interpolation
            /// </summary>
            public bool UsesBezier
            {
                get
                {
                    if (f_usesBezier)
                        return _usesBezier;
                    f_usesBezier = true;
                    _usesBezier = (bool) ((ColumnCount & 16) != 0);
                    return _usesBezier;
                }
            }
            private BiowareMdlCommon.ControllerType _type;
            private ushort _unknown;
            private ushort _rowCount;
            private ushort _timeIndex;
            private ushort _dataIndex;
            private byte _columnCount;
            private List<byte> _padding;
            private Mdl m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Controller type identifier. Controllers define animation data for node properties over time.
            /// 
            /// Common Node Controllers (used by all node types):
            /// - 8: Position (3 floats: X, Y, Z translation)
            /// - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
            /// - 36: Scale (3 floats: X, Y, Z scale factors)
            /// 
            /// Light Controllers (specific to light nodes):
            /// - 76: Color (light color, 3 floats: R, G, B)
            /// - 88: Radius (light radius, 1 float)
            /// - 96: Shadow Radius (shadow casting radius, 1 float)
            /// - 100: Vertical Displacement (vertical offset, 1 float)
            /// - 140: Multiplier (light intensity multiplier, 1 float)
            /// 
            /// Emitter Controllers (specific to emitter nodes):
            /// - 80: Alpha End (final alpha value, 1 float)
            /// - 84: Alpha Start (initial alpha value, 1 float)
            /// - 88: Birth Rate (particle spawn rate, 1 float)
            /// - 92: Bounce Coefficient (particle bounce factor, 1 float)
            /// - 96: Combine Time (particle combination timing, 1 float)
            /// - 100: Drag (particle drag/resistance, 1 float)
            /// - 104: FPS (frames per second, 1 float)
            /// - 108: Frame End (ending frame number, 1 float)
            /// - 112: Frame Start (starting frame number, 1 float)
            /// - 116: Gravity (gravity force, 1 float)
            /// - 120: Life Expectancy (particle lifetime, 1 float)
            /// - 124: Mass (particle mass, 1 float)
            /// - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
            /// - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
            /// - 136: Particle Rotation (particle rotation speed/angle, 1 float)
            /// - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
            /// - 144: Size Start (initial particle size, 1 float)
            /// - 148: Size End (final particle size, 1 float)
            /// - 152: Size Start Y (initial particle size Y component, 1 float)
            /// - 156: Size End Y (final particle size Y component, 1 float)
            /// - 160: Spread (particle spread angle, 1 float)
            /// - 164: Threshold (threshold value, 1 float)
            /// - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
            /// - 172: X Size (particle X dimension size, 1 float)
            /// - 176: Y Size (particle Y dimension size, 1 float)
            /// - 180: Blur Length (motion blur length, 1 float)
            /// - 184: Lightning Delay (lightning effect delay, 1 float)
            /// - 188: Lightning Radius (lightning effect radius, 1 float)
            /// - 192: Lightning Scale (lightning effect scale factor, 1 float)
            /// - 196: Lightning Subdivide (lightning subdivision count, 1 float)
            /// - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
            /// - 216: Alpha Mid (mid-point alpha value, 1 float)
            /// - 220: Percent Start (starting percentage, 1 float)
            /// - 224: Percent Mid (mid-point percentage, 1 float)
            /// - 228: Percent End (ending percentage, 1 float)
            /// - 232: Size Mid (mid-point particle size, 1 float)
            /// - 236: Size Mid Y (mid-point particle size Y component, 1 float)
            /// - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
            /// - 252: Target Size (target particle size, 1 float)
            /// - 256: Number of Control Points (control point count, 1 float)
            /// - 260: Control Point Radius (control point radius, 1 float)
            /// - 264: Control Point Delay (control point delay timing, 1 float)
            /// - 268: Tangent Spread (tangent spread angle, 1 float)
            /// - 272: Tangent Length (tangent vector length, 1 float)
            /// - 284: Color Mid (mid-point color, 3 floats: R, G, B)
            /// - 380: Color End (final color, 3 floats: R, G, B)
            /// - 392: Color Start (initial color, 3 floats: R, G, B)
            /// - 502: Emitter Detonate (detonation trigger, 1 float)
            /// 
            /// Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
            /// - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
            /// - 128: Alpha (transparency/opacity, 1 float)
            /// 
            /// Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
            /// Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
            /// Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list
            /// </summary>
            public BiowareMdlCommon.ControllerType Type { get { return _type; } }

            /// <summary>
            /// Purpose unknown, typically 0xFFFF
            /// </summary>
            public ushort Unknown { get { return _unknown; } }

            /// <summary>
            /// Number of keyframe rows (timepoints) for this controller
            /// </summary>
            public ushort RowCount { get { return _rowCount; } }

            /// <summary>
            /// Index into controller data array where time values begin
            /// </summary>
            public ushort TimeIndex { get { return _timeIndex; } }

            /// <summary>
            /// Index into controller data array where property values begin
            /// </summary>
            public ushort DataIndex { get { return _dataIndex; } }

            /// <summary>
            /// Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
            /// If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
            /// </summary>
            public byte ColumnCount { get { return _columnCount; } }

            /// <summary>
            /// Padding bytes for 16-byte alignment
            /// </summary>
            public List<byte> Padding { get { return _padding; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
        /// </summary>
        public partial class DanglymeshHeader : KaitaiStruct
        {
            public static DanglymeshHeader FromFile(string fileName)
            {
                return new DanglymeshHeader(new KaitaiStream(fileName));
            }

            public DanglymeshHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _trimeshBase = new TrimeshHeader(m_io, this, m_root);
                _constraintsOffset = m_io.ReadU4le();
                _constraintsCount = m_io.ReadU4le();
                _constraintsCountDuplicate = m_io.ReadU4le();
                _displacement = m_io.ReadF4le();
                _tightness = m_io.ReadF4le();
                _period = m_io.ReadF4le();
                _unknown = m_io.ReadU4le();
            }
            private TrimeshHeader _trimeshBase;
            private uint _constraintsOffset;
            private uint _constraintsCount;
            private uint _constraintsCountDuplicate;
            private float _displacement;
            private float _tightness;
            private float _period;
            private uint _unknown;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Standard trimesh header
            /// </summary>
            public TrimeshHeader TrimeshBase { get { return _trimeshBase; } }

            /// <summary>
            /// Offset to vertex constraint values array
            /// </summary>
            public uint ConstraintsOffset { get { return _constraintsOffset; } }

            /// <summary>
            /// Number of vertex constraints (matches vertex count)
            /// </summary>
            public uint ConstraintsCount { get { return _constraintsCount; } }

            /// <summary>
            /// Duplicate of constraints count
            /// </summary>
            public uint ConstraintsCountDuplicate { get { return _constraintsCountDuplicate; } }

            /// <summary>
            /// Maximum displacement distance for physics simulation
            /// </summary>
            public float Displacement { get { return _displacement; } }

            /// <summary>
            /// Tightness/stiffness of spring simulation (0.0-1.0)
            /// </summary>
            public float Tightness { get { return _tightness; } }

            /// <summary>
            /// Oscillation period in seconds
            /// </summary>
            public float Period { get { return _period; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown { get { return _unknown; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Emitter header (224 bytes)
        /// </summary>
        public partial class EmitterHeader : KaitaiStruct
        {
            public static EmitterHeader FromFile(string fileName)
            {
                return new EmitterHeader(new KaitaiStream(fileName));
            }

            public EmitterHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _deadSpace = m_io.ReadF4le();
                _blastRadius = m_io.ReadF4le();
                _blastLength = m_io.ReadF4le();
                _branchCount = m_io.ReadU4le();
                _controlPointSmoothing = m_io.ReadF4le();
                _xGrid = m_io.ReadU4le();
                _yGrid = m_io.ReadU4le();
                _paddingUnknown = m_io.ReadU4le();
                _updateScript = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _renderScript = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _blendScript = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _textureName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _chunkName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _twoSidedTexture = m_io.ReadU4le();
                _loop = m_io.ReadU4le();
                _renderOrder = m_io.ReadU2le();
                _frameBlending = m_io.ReadU1();
                _depthTextureName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _padding = m_io.ReadU1();
                _flags = m_io.ReadU4le();
            }
            private float _deadSpace;
            private float _blastRadius;
            private float _blastLength;
            private uint _branchCount;
            private float _controlPointSmoothing;
            private uint _xGrid;
            private uint _yGrid;
            private uint _paddingUnknown;
            private string _updateScript;
            private string _renderScript;
            private string _blendScript;
            private string _textureName;
            private string _chunkName;
            private uint _twoSidedTexture;
            private uint _loop;
            private ushort _renderOrder;
            private byte _frameBlending;
            private string _depthTextureName;
            private byte _padding;
            private uint _flags;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Minimum distance from emitter before particles become visible
            /// </summary>
            public float DeadSpace { get { return _deadSpace; } }

            /// <summary>
            /// Radius of explosive/blast particle effects
            /// </summary>
            public float BlastRadius { get { return _blastRadius; } }

            /// <summary>
            /// Length/duration of blast effects
            /// </summary>
            public float BlastLength { get { return _blastLength; } }

            /// <summary>
            /// Number of branching paths for particle trails
            /// </summary>
            public uint BranchCount { get { return _branchCount; } }

            /// <summary>
            /// Smoothing factor for particle path control points
            /// </summary>
            public float ControlPointSmoothing { get { return _controlPointSmoothing; } }

            /// <summary>
            /// Grid subdivisions along X axis for particle spawning
            /// </summary>
            public uint XGrid { get { return _xGrid; } }

            /// <summary>
            /// Grid subdivisions along Y axis for particle spawning
            /// </summary>
            public uint YGrid { get { return _yGrid; } }

            /// <summary>
            /// Purpose unknown or padding
            /// </summary>
            public uint PaddingUnknown { get { return _paddingUnknown; } }

            /// <summary>
            /// Update behavior script name (e.g., &quot;single&quot;, &quot;fountain&quot;)
            /// </summary>
            public string UpdateScript { get { return _updateScript; } }

            /// <summary>
            /// Render mode script name (e.g., &quot;normal&quot;, &quot;billboard_to_local_z&quot;)
            /// </summary>
            public string RenderScript { get { return _renderScript; } }

            /// <summary>
            /// Blend mode script name (e.g., &quot;normal&quot;, &quot;lighten&quot;)
            /// </summary>
            public string BlendScript { get { return _blendScript; } }

            /// <summary>
            /// Particle texture name (null-terminated string)
            /// </summary>
            public string TextureName { get { return _textureName; } }

            /// <summary>
            /// Associated model chunk name (null-terminated string)
            /// </summary>
            public string ChunkName { get { return _chunkName; } }

            /// <summary>
            /// 1 if texture should render two-sided, 0 for single-sided
            /// </summary>
            public uint TwoSidedTexture { get { return _twoSidedTexture; } }

            /// <summary>
            /// 1 if particle system loops, 0 for single playback
            /// </summary>
            public uint Loop { get { return _loop; } }

            /// <summary>
            /// Rendering priority/order for particle sorting
            /// </summary>
            public ushort RenderOrder { get { return _renderOrder; } }

            /// <summary>
            /// 1 if frame blending enabled, 0 otherwise
            /// </summary>
            public byte FrameBlending { get { return _frameBlending; } }

            /// <summary>
            /// Depth/softparticle texture name (null-terminated string)
            /// </summary>
            public string DepthTextureName { get { return _depthTextureName; } }

            /// <summary>
            /// Padding byte for alignment
            /// </summary>
            public byte Padding { get { return _padding; } }

            /// <summary>
            /// Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
            /// </summary>
            public uint Flags { get { return _flags; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// MDL file header (12 bytes)
        /// </summary>
        public partial class FileHeader : KaitaiStruct
        {
            public static FileHeader FromFile(string fileName)
            {
                return new FileHeader(new KaitaiStream(fileName));
            }

            public FileHeader(KaitaiStream p__io, Mdl p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _unused = m_io.ReadU4le();
                _mdlSize = m_io.ReadU4le();
                _mdxSize = m_io.ReadU4le();
            }
            private uint _unused;
            private uint _mdlSize;
            private uint _mdxSize;
            private Mdl m_root;
            private Mdl m_parent;

            /// <summary>
            /// Always 0
            /// </summary>
            public uint Unused { get { return _unused; } }

            /// <summary>
            /// Size of MDL file in bytes
            /// </summary>
            public uint MdlSize { get { return _mdlSize; } }

            /// <summary>
            /// Size of MDX file in bytes
            /// </summary>
            public uint MdxSize { get { return _mdxSize; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
        /// </summary>
        public partial class GeometryHeader : KaitaiStruct
        {
            public static GeometryHeader FromFile(string fileName)
            {
                return new GeometryHeader(new KaitaiStream(fileName));
            }

            public GeometryHeader(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_isKotor2 = false;
                _read();
            }
            private void _read()
            {
                _functionPointer0 = m_io.ReadU4le();
                _functionPointer1 = m_io.ReadU4le();
                _modelName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _rootNodeOffset = m_io.ReadU4le();
                _nodeCount = m_io.ReadU4le();
                _unknownArray1 = new ArrayDefinition(m_io, this, m_root);
                _unknownArray2 = new ArrayDefinition(m_io, this, m_root);
                _referenceCount = m_io.ReadU4le();
                _geometryType = m_io.ReadU1();
                _padding = new List<byte>();
                for (var i = 0; i < 3; i++)
                {
                    _padding.Add(m_io.ReadU1());
                }
            }
            private bool f_isKotor2;
            private bool _isKotor2;

            /// <summary>
            /// True if this is a KOTOR 2 model
            /// </summary>
            public bool IsKotor2
            {
                get
                {
                    if (f_isKotor2)
                        return _isKotor2;
                    f_isKotor2 = true;
                    _isKotor2 = (bool) ( ((FunctionPointer0 == 4285200) || (FunctionPointer0 == 4285872)) );
                    return _isKotor2;
                }
            }
            private uint _functionPointer0;
            private uint _functionPointer1;
            private string _modelName;
            private uint _rootNodeOffset;
            private uint _nodeCount;
            private ArrayDefinition _unknownArray1;
            private ArrayDefinition _unknownArray2;
            private uint _referenceCount;
            private byte _geometryType;
            private List<byte> _padding;
            private Mdl m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Game engine version identifier:
            /// - KOTOR 1 PC: 4273776 (0x413670)
            /// - KOTOR 2 PC: 4285200 (0x416310)
            /// - KOTOR 1 Xbox: 4254992 (0x40ED10)
            /// - KOTOR 2 Xbox: 4285872 (0x4165B0)
            /// </summary>
            public uint FunctionPointer0 { get { return _functionPointer0; } }

            /// <summary>
            /// Function pointer to ASCII model parser
            /// </summary>
            public uint FunctionPointer1 { get { return _functionPointer1; } }

            /// <summary>
            /// Model name, null-terminated string, max 32 (0x20) bytes
            /// </summary>
            public string ModelName { get { return _modelName; } }

            /// <summary>
            /// Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
            /// </summary>
            public uint RootNodeOffset { get { return _rootNodeOffset; } }

            /// <summary>
            /// Total number of nodes in model hierarchy, unsigned 32-bit integer
            /// </summary>
            public uint NodeCount { get { return _nodeCount; } }

            /// <summary>
            /// Unknown array definition (offset, count, count duplicate)
            /// </summary>
            public ArrayDefinition UnknownArray1 { get { return _unknownArray1; } }

            /// <summary>
            /// Unknown array definition (offset, count, count duplicate)
            /// </summary>
            public ArrayDefinition UnknownArray2 { get { return _unknownArray2; } }

            /// <summary>
            /// Reference count (initialized to 0, incremented when model is referenced)
            /// </summary>
            public uint ReferenceCount { get { return _referenceCount; } }

            /// <summary>
            /// Geometry type:
            /// - 0x01: Basic geometry header (not in models)
            /// - 0x02: Model geometry header
            /// - 0x05: Animation geometry header
            /// If bit 7 (0x80) is set, model is compiled binary with absolute addresses
            /// </summary>
            public byte GeometryType { get { return _geometryType; } }

            /// <summary>
            /// Padding bytes for alignment
            /// </summary>
            public List<byte> Padding { get { return _padding; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Light header (92 bytes)
        /// </summary>
        public partial class LightHeader : KaitaiStruct
        {
            public static LightHeader FromFile(string fileName)
            {
                return new LightHeader(new KaitaiStream(fileName));
            }

            public LightHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _unknown = new List<float>();
                for (var i = 0; i < 4; i++)
                {
                    _unknown.Add(m_io.ReadF4le());
                }
                _flareSizesOffset = m_io.ReadU4le();
                _flareSizesCount = m_io.ReadU4le();
                _flareSizesCountDuplicate = m_io.ReadU4le();
                _flarePositionsOffset = m_io.ReadU4le();
                _flarePositionsCount = m_io.ReadU4le();
                _flarePositionsCountDuplicate = m_io.ReadU4le();
                _flareColorShiftsOffset = m_io.ReadU4le();
                _flareColorShiftsCount = m_io.ReadU4le();
                _flareColorShiftsCountDuplicate = m_io.ReadU4le();
                _flareTextureNamesOffset = m_io.ReadU4le();
                _flareTextureNamesCount = m_io.ReadU4le();
                _flareTextureNamesCountDuplicate = m_io.ReadU4le();
                _flareRadius = m_io.ReadF4le();
                _lightPriority = m_io.ReadU4le();
                _ambientOnly = m_io.ReadU4le();
                _dynamicType = m_io.ReadU4le();
                _affectDynamic = m_io.ReadU4le();
                _shadow = m_io.ReadU4le();
                _flare = m_io.ReadU4le();
                _fadingLight = m_io.ReadU4le();
            }
            private List<float> _unknown;
            private uint _flareSizesOffset;
            private uint _flareSizesCount;
            private uint _flareSizesCountDuplicate;
            private uint _flarePositionsOffset;
            private uint _flarePositionsCount;
            private uint _flarePositionsCountDuplicate;
            private uint _flareColorShiftsOffset;
            private uint _flareColorShiftsCount;
            private uint _flareColorShiftsCountDuplicate;
            private uint _flareTextureNamesOffset;
            private uint _flareTextureNamesCount;
            private uint _flareTextureNamesCountDuplicate;
            private float _flareRadius;
            private uint _lightPriority;
            private uint _ambientOnly;
            private uint _dynamicType;
            private uint _affectDynamic;
            private uint _shadow;
            private uint _flare;
            private uint _fadingLight;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Purpose unknown, possibly padding or reserved values
            /// </summary>
            public List<float> Unknown { get { return _unknown; } }

            /// <summary>
            /// Offset to flare sizes array (floats)
            /// </summary>
            public uint FlareSizesOffset { get { return _flareSizesOffset; } }

            /// <summary>
            /// Number of flare size entries
            /// </summary>
            public uint FlareSizesCount { get { return _flareSizesCount; } }

            /// <summary>
            /// Duplicate of flare sizes count
            /// </summary>
            public uint FlareSizesCountDuplicate { get { return _flareSizesCountDuplicate; } }

            /// <summary>
            /// Offset to flare positions array (floats, 0.0-1.0 along light ray)
            /// </summary>
            public uint FlarePositionsOffset { get { return _flarePositionsOffset; } }

            /// <summary>
            /// Number of flare position entries
            /// </summary>
            public uint FlarePositionsCount { get { return _flarePositionsCount; } }

            /// <summary>
            /// Duplicate of flare positions count
            /// </summary>
            public uint FlarePositionsCountDuplicate { get { return _flarePositionsCountDuplicate; } }

            /// <summary>
            /// Offset to flare color shift array (RGB floats)
            /// </summary>
            public uint FlareColorShiftsOffset { get { return _flareColorShiftsOffset; } }

            /// <summary>
            /// Number of flare color shift entries
            /// </summary>
            public uint FlareColorShiftsCount { get { return _flareColorShiftsCount; } }

            /// <summary>
            /// Duplicate of flare color shifts count
            /// </summary>
            public uint FlareColorShiftsCountDuplicate { get { return _flareColorShiftsCountDuplicate; } }

            /// <summary>
            /// Offset to flare texture name string offsets array
            /// </summary>
            public uint FlareTextureNamesOffset { get { return _flareTextureNamesOffset; } }

            /// <summary>
            /// Number of flare texture names
            /// </summary>
            public uint FlareTextureNamesCount { get { return _flareTextureNamesCount; } }

            /// <summary>
            /// Duplicate of flare texture names count
            /// </summary>
            public uint FlareTextureNamesCountDuplicate { get { return _flareTextureNamesCountDuplicate; } }

            /// <summary>
            /// Radius of flare effect
            /// </summary>
            public float FlareRadius { get { return _flareRadius; } }

            /// <summary>
            /// Rendering priority for light culling/sorting
            /// </summary>
            public uint LightPriority { get { return _lightPriority; } }

            /// <summary>
            /// 1 if light only affects ambient, 0 for full lighting
            /// </summary>
            public uint AmbientOnly { get { return _ambientOnly; } }

            /// <summary>
            /// Type of dynamic lighting behavior
            /// </summary>
            public uint DynamicType { get { return _dynamicType; } }

            /// <summary>
            /// 1 if light affects dynamic objects, 0 otherwise
            /// </summary>
            public uint AffectDynamic { get { return _affectDynamic; } }

            /// <summary>
            /// 1 if light casts shadows, 0 otherwise
            /// </summary>
            public uint Shadow { get { return _shadow; } }

            /// <summary>
            /// 1 if lens flare effect enabled, 0 otherwise
            /// </summary>
            public uint Flare { get { return _flare; } }

            /// <summary>
            /// 1 if light intensity fades with distance, 0 otherwise
            /// </summary>
            public uint FadingLight { get { return _fadingLight; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
        /// </summary>
        public partial class LightsaberHeader : KaitaiStruct
        {
            public static LightsaberHeader FromFile(string fileName)
            {
                return new LightsaberHeader(new KaitaiStream(fileName));
            }

            public LightsaberHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _trimeshBase = new TrimeshHeader(m_io, this, m_root);
                _verticesOffset = m_io.ReadU4le();
                _texcoordsOffset = m_io.ReadU4le();
                _normalsOffset = m_io.ReadU4le();
                _unknown1 = m_io.ReadU4le();
                _unknown2 = m_io.ReadU4le();
            }
            private TrimeshHeader _trimeshBase;
            private uint _verticesOffset;
            private uint _texcoordsOffset;
            private uint _normalsOffset;
            private uint _unknown1;
            private uint _unknown2;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Standard trimesh header
            /// </summary>
            public TrimeshHeader TrimeshBase { get { return _trimeshBase; } }

            /// <summary>
            /// Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
            /// </summary>
            public uint VerticesOffset { get { return _verticesOffset; } }

            /// <summary>
            /// Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
            /// </summary>
            public uint TexcoordsOffset { get { return _texcoordsOffset; } }

            /// <summary>
            /// Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
            /// </summary>
            public uint NormalsOffset { get { return _normalsOffset; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown1 { get { return _unknown1; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown2 { get { return _unknown2; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
        /// Wraps the header so repeated root instances can use parametric types (user guide).
        /// </summary>
        public partial class MdlAnimationEntry : KaitaiStruct
        {
            public MdlAnimationEntry(uint p_animIndex, KaitaiStream p__io, Mdl p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _animIndex = p_animIndex;
                f_header = false;
                _read();
            }
            private void _read()
            {
            }
            private bool f_header;
            private AnimationHeader _header;
            public AnimationHeader Header
            {
                get
                {
                    if (f_header)
                        return _header;
                    f_header = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(M_Root.DataStart + M_Root.AnimationOffsets[AnimIndex]);
                    _header = new AnimationHeader(m_io, this, m_root);
                    m_io.Seek(_pos);
                    return _header;
                }
            }
            private uint _animIndex;
            private Mdl m_root;
            private Mdl m_parent;
            public uint AnimIndex { get { return _animIndex; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Model header (196 bytes) starting at offset 12 (data_start).
        /// This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
        /// model-wide metadata, offsets, and counts.
        /// </summary>
        public partial class ModelHeader : KaitaiStruct
        {
            public static ModelHeader FromFile(string fileName)
            {
                return new ModelHeader(new KaitaiStream(fileName));
            }

            public ModelHeader(KaitaiStream p__io, Mdl p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _geometry = new GeometryHeader(m_io, this, m_root);
                _modelType = ((BiowareMdlCommon.ModelClassification) m_io.ReadU1());
                _unknown0 = m_io.ReadU1();
                _padding0 = m_io.ReadU1();
                _fog = m_io.ReadU1();
                _unknown1 = m_io.ReadU4le();
                _offsetToAnimations = m_io.ReadU4le();
                _animationCount = m_io.ReadU4le();
                _animationCount2 = m_io.ReadU4le();
                _unknown2 = m_io.ReadU4le();
                _boundingBoxMin = new Vec3f(m_io, this, m_root);
                _boundingBoxMax = new Vec3f(m_io, this, m_root);
                _radius = m_io.ReadF4le();
                _animationScale = m_io.ReadF4le();
                _supermodelName = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _offsetToSuperRoot = m_io.ReadU4le();
                _unknown3 = m_io.ReadU4le();
                _mdxDataSize = m_io.ReadU4le();
                _mdxDataOffset = m_io.ReadU4le();
                _offsetToNameOffsets = m_io.ReadU4le();
                _nameOffsetsCount = m_io.ReadU4le();
                _nameOffsetsCount2 = m_io.ReadU4le();
            }
            private GeometryHeader _geometry;
            private BiowareMdlCommon.ModelClassification _modelType;
            private byte _unknown0;
            private byte _padding0;
            private byte _fog;
            private uint _unknown1;
            private uint _offsetToAnimations;
            private uint _animationCount;
            private uint _animationCount2;
            private uint _unknown2;
            private Vec3f _boundingBoxMin;
            private Vec3f _boundingBoxMax;
            private float _radius;
            private float _animationScale;
            private string _supermodelName;
            private uint _offsetToSuperRoot;
            private uint _unknown3;
            private uint _mdxDataSize;
            private uint _mdxDataOffset;
            private uint _offsetToNameOffsets;
            private uint _nameOffsetsCount;
            private uint _nameOffsetsCount2;
            private Mdl m_root;
            private Mdl m_parent;

            /// <summary>
            /// Geometry header (80 bytes)
            /// </summary>
            public GeometryHeader Geometry { get { return _geometry; } }

            /// <summary>
            /// Model classification byte
            /// </summary>
            public BiowareMdlCommon.ModelClassification ModelType { get { return _modelType; } }

            /// <summary>
            /// TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
            /// </summary>
            public byte Unknown0 { get { return _unknown0; } }

            /// <summary>
            /// Padding byte
            /// </summary>
            public byte Padding0 { get { return _padding0; } }

            /// <summary>
            /// Fog interaction (1 = affected, 0 = ignore fog)
            /// </summary>
            public byte Fog { get { return _fog; } }

            /// <summary>
            /// TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
            /// </summary>
            public uint Unknown1 { get { return _unknown1; } }

            /// <summary>
            /// Offset to animation offset array (relative to data_start)
            /// </summary>
            public uint OffsetToAnimations { get { return _offsetToAnimations; } }

            /// <summary>
            /// Number of animations
            /// </summary>
            public uint AnimationCount { get { return _animationCount; } }

            /// <summary>
            /// Duplicate animation count / allocated count
            /// </summary>
            public uint AnimationCount2 { get { return _animationCount2; } }

            /// <summary>
            /// TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
            /// </summary>
            public uint Unknown2 { get { return _unknown2; } }

            /// <summary>
            /// Minimum coordinates of bounding box (X, Y, Z)
            /// </summary>
            public Vec3f BoundingBoxMin { get { return _boundingBoxMin; } }

            /// <summary>
            /// Maximum coordinates of bounding box (X, Y, Z)
            /// </summary>
            public Vec3f BoundingBoxMax { get { return _boundingBoxMax; } }

            /// <summary>
            /// Radius of model's bounding sphere
            /// </summary>
            public float Radius { get { return _radius; } }

            /// <summary>
            /// Scale factor for animations (typically 1.0)
            /// </summary>
            public float AnimationScale { get { return _animationScale; } }

            /// <summary>
            /// Name of supermodel (null-terminated string, &quot;null&quot; if empty)
            /// </summary>
            public string SupermodelName { get { return _supermodelName; } }

            /// <summary>
            /// TODO: VERIFY - offset to super-root node (relative to data_start)
            /// </summary>
            public uint OffsetToSuperRoot { get { return _offsetToSuperRoot; } }

            /// <summary>
            /// TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
            /// </summary>
            public uint Unknown3 { get { return _unknown3; } }

            /// <summary>
            /// Size of MDX file data in bytes
            /// </summary>
            public uint MdxDataSize { get { return _mdxDataSize; } }

            /// <summary>
            /// Offset to MDX data (typically 0)
            /// </summary>
            public uint MdxDataOffset { get { return _mdxDataOffset; } }

            /// <summary>
            /// Offset to name offset array (relative to data_start)
            /// </summary>
            public uint OffsetToNameOffsets { get { return _offsetToNameOffsets; } }

            /// <summary>
            /// Count of name offsets / partnames
            /// </summary>
            public uint NameOffsetsCount { get { return _nameOffsetsCount; } }

            /// <summary>
            /// Duplicate name offsets count / allocated count
            /// </summary>
            public uint NameOffsetsCount2 { get { return _nameOffsetsCount2; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Array of null-terminated name strings
        /// </summary>
        public partial class NameStrings : KaitaiStruct
        {
            public static NameStrings FromFile(string fileName)
            {
                return new NameStrings(new KaitaiStream(fileName));
            }

            public NameStrings(KaitaiStream p__io, Mdl p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _strings = new List<string>();
                {
                    var i = 0;
                    while (!m_io.IsEof) {
                        _strings.Add(System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytesTerm(0, false, true, true)));
                        i++;
                    }
                }
            }
            private List<string> _strings;
            private Mdl m_root;
            private Mdl m_parent;
            public List<string> Strings { get { return _strings; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Node structure - starts with 80-byte header, followed by type-specific sub-header
        /// </summary>
        public partial class Node : KaitaiStruct
        {
            public static Node FromFile(string fileName)
            {
                return new Node(new KaitaiStream(fileName));
            }

            public Node(KaitaiStream p__io, Mdl p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _header = new NodeHeader(m_io, this, m_root);
                if (Header.NodeType == 3) {
                    _lightSubHeader = new LightHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 5) {
                    _emitterSubHeader = new EmitterHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 17) {
                    _referenceSubHeader = new ReferenceHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 33) {
                    _trimeshSubHeader = new TrimeshHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 97) {
                    _skinmeshSubHeader = new SkinmeshHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 161) {
                    _animmeshSubHeader = new AnimmeshHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 289) {
                    _danglymeshSubHeader = new DanglymeshHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 545) {
                    _aabbSubHeader = new AabbHeader(m_io, this, m_root);
                }
                if (Header.NodeType == 2081) {
                    _lightsaberSubHeader = new LightsaberHeader(m_io, this, m_root);
                }
            }
            private NodeHeader _header;
            private LightHeader _lightSubHeader;
            private EmitterHeader _emitterSubHeader;
            private ReferenceHeader _referenceSubHeader;
            private TrimeshHeader _trimeshSubHeader;
            private SkinmeshHeader _skinmeshSubHeader;
            private AnimmeshHeader _animmeshSubHeader;
            private DanglymeshHeader _danglymeshSubHeader;
            private AabbHeader _aabbSubHeader;
            private LightsaberHeader _lightsaberSubHeader;
            private Mdl m_root;
            private Mdl m_parent;
            public NodeHeader Header { get { return _header; } }
            public LightHeader LightSubHeader { get { return _lightSubHeader; } }
            public EmitterHeader EmitterSubHeader { get { return _emitterSubHeader; } }
            public ReferenceHeader ReferenceSubHeader { get { return _referenceSubHeader; } }
            public TrimeshHeader TrimeshSubHeader { get { return _trimeshSubHeader; } }
            public SkinmeshHeader SkinmeshSubHeader { get { return _skinmeshSubHeader; } }
            public AnimmeshHeader AnimmeshSubHeader { get { return _animmeshSubHeader; } }
            public DanglymeshHeader DanglymeshSubHeader { get { return _danglymeshSubHeader; } }
            public AabbHeader AabbSubHeader { get { return _aabbSubHeader; } }
            public LightsaberHeader LightsaberSubHeader { get { return _lightsaberSubHeader; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Node header (80 bytes) - present in all node types
        /// </summary>
        public partial class NodeHeader : KaitaiStruct
        {
            public static NodeHeader FromFile(string fileName)
            {
                return new NodeHeader(new KaitaiStream(fileName));
            }

            public NodeHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_hasAabb = false;
                f_hasAnim = false;
                f_hasDangly = false;
                f_hasEmitter = false;
                f_hasLight = false;
                f_hasMesh = false;
                f_hasReference = false;
                f_hasSaber = false;
                f_hasSkin = false;
                _read();
            }
            private void _read()
            {
                _nodeType = m_io.ReadU2le();
                _nodeIndex = m_io.ReadU2le();
                _nodeNameIndex = m_io.ReadU2le();
                _padding = m_io.ReadU2le();
                _rootNodeOffset = m_io.ReadU4le();
                _parentNodeOffset = m_io.ReadU4le();
                _position = new Vec3f(m_io, this, m_root);
                _orientation = new Quaternion(m_io, this, m_root);
                _childArrayOffset = m_io.ReadU4le();
                _childCount = m_io.ReadU4le();
                _childCountDuplicate = m_io.ReadU4le();
                _controllerArrayOffset = m_io.ReadU4le();
                _controllerCount = m_io.ReadU4le();
                _controllerCountDuplicate = m_io.ReadU4le();
                _controllerDataOffset = m_io.ReadU4le();
                _controllerDataCount = m_io.ReadU4le();
                _controllerDataCountDuplicate = m_io.ReadU4le();
            }
            private bool f_hasAabb;
            private bool _hasAabb;
            public bool HasAabb
            {
                get
                {
                    if (f_hasAabb)
                        return _hasAabb;
                    f_hasAabb = true;
                    _hasAabb = (bool) ((NodeType & 512) != 0);
                    return _hasAabb;
                }
            }
            private bool f_hasAnim;
            private bool _hasAnim;
            public bool HasAnim
            {
                get
                {
                    if (f_hasAnim)
                        return _hasAnim;
                    f_hasAnim = true;
                    _hasAnim = (bool) ((NodeType & 128) != 0);
                    return _hasAnim;
                }
            }
            private bool f_hasDangly;
            private bool _hasDangly;
            public bool HasDangly
            {
                get
                {
                    if (f_hasDangly)
                        return _hasDangly;
                    f_hasDangly = true;
                    _hasDangly = (bool) ((NodeType & 256) != 0);
                    return _hasDangly;
                }
            }
            private bool f_hasEmitter;
            private bool _hasEmitter;
            public bool HasEmitter
            {
                get
                {
                    if (f_hasEmitter)
                        return _hasEmitter;
                    f_hasEmitter = true;
                    _hasEmitter = (bool) ((NodeType & 4) != 0);
                    return _hasEmitter;
                }
            }
            private bool f_hasLight;
            private bool _hasLight;
            public bool HasLight
            {
                get
                {
                    if (f_hasLight)
                        return _hasLight;
                    f_hasLight = true;
                    _hasLight = (bool) ((NodeType & 2) != 0);
                    return _hasLight;
                }
            }
            private bool f_hasMesh;
            private bool _hasMesh;
            public bool HasMesh
            {
                get
                {
                    if (f_hasMesh)
                        return _hasMesh;
                    f_hasMesh = true;
                    _hasMesh = (bool) ((NodeType & 32) != 0);
                    return _hasMesh;
                }
            }
            private bool f_hasReference;
            private bool _hasReference;
            public bool HasReference
            {
                get
                {
                    if (f_hasReference)
                        return _hasReference;
                    f_hasReference = true;
                    _hasReference = (bool) ((NodeType & 16) != 0);
                    return _hasReference;
                }
            }
            private bool f_hasSaber;
            private bool _hasSaber;
            public bool HasSaber
            {
                get
                {
                    if (f_hasSaber)
                        return _hasSaber;
                    f_hasSaber = true;
                    _hasSaber = (bool) ((NodeType & 2048) != 0);
                    return _hasSaber;
                }
            }
            private bool f_hasSkin;
            private bool _hasSkin;
            public bool HasSkin
            {
                get
                {
                    if (f_hasSkin)
                        return _hasSkin;
                    f_hasSkin = true;
                    _hasSkin = (bool) ((NodeType & 64) != 0);
                    return _hasSkin;
                }
            }
            private ushort _nodeType;
            private ushort _nodeIndex;
            private ushort _nodeNameIndex;
            private ushort _padding;
            private uint _rootNodeOffset;
            private uint _parentNodeOffset;
            private Vec3f _position;
            private Quaternion _orientation;
            private uint _childArrayOffset;
            private uint _childCount;
            private uint _childCountDuplicate;
            private uint _controllerArrayOffset;
            private uint _controllerCount;
            private uint _controllerCountDuplicate;
            private uint _controllerDataOffset;
            private uint _controllerDataCount;
            private uint _controllerDataCountDuplicate;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Bitmask indicating node features (also carries the primary node kind in the composite values listed in
            /// `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&amp;` tests).
            /// - 0x0001: NODE_HAS_HEADER
            /// - 0x0002: NODE_HAS_LIGHT
            /// - 0x0004: NODE_HAS_EMITTER
            /// - 0x0008: NODE_HAS_CAMERA
            /// - 0x0010: NODE_HAS_REFERENCE
            /// - 0x0020: NODE_HAS_MESH
            /// - 0x0040: NODE_HAS_SKIN
            /// - 0x0080: NODE_HAS_ANIM
            /// - 0x0100: NODE_HAS_DANGLY
            /// - 0x0200: NODE_HAS_AABB
            /// - 0x0800: NODE_HAS_SABER
            /// </summary>
            public ushort NodeType { get { return _nodeType; } }

            /// <summary>
            /// Sequential index of this node in the model
            /// </summary>
            public ushort NodeIndex { get { return _nodeIndex; } }

            /// <summary>
            /// Index into names array for this node's name
            /// </summary>
            public ushort NodeNameIndex { get { return _nodeNameIndex; } }

            /// <summary>
            /// Padding for alignment
            /// </summary>
            public ushort Padding { get { return _padding; } }

            /// <summary>
            /// Offset to model's root node
            /// </summary>
            public uint RootNodeOffset { get { return _rootNodeOffset; } }

            /// <summary>
            /// Offset to this node's parent node (0 if root)
            /// </summary>
            public uint ParentNodeOffset { get { return _parentNodeOffset; } }

            /// <summary>
            /// Node position in local space (X, Y, Z)
            /// </summary>
            public Vec3f Position { get { return _position; } }

            /// <summary>
            /// Node orientation as quaternion (W, X, Y, Z)
            /// </summary>
            public Quaternion Orientation { get { return _orientation; } }

            /// <summary>
            /// Offset to array of child node offsets
            /// </summary>
            public uint ChildArrayOffset { get { return _childArrayOffset; } }

            /// <summary>
            /// Number of child nodes
            /// </summary>
            public uint ChildCount { get { return _childCount; } }

            /// <summary>
            /// Duplicate value of child count
            /// </summary>
            public uint ChildCountDuplicate { get { return _childCountDuplicate; } }

            /// <summary>
            /// Offset to array of controller structures
            /// </summary>
            public uint ControllerArrayOffset { get { return _controllerArrayOffset; } }

            /// <summary>
            /// Number of controllers attached to this node
            /// </summary>
            public uint ControllerCount { get { return _controllerCount; } }

            /// <summary>
            /// Duplicate value of controller count
            /// </summary>
            public uint ControllerCountDuplicate { get { return _controllerCountDuplicate; } }

            /// <summary>
            /// Offset to controller keyframe/data array
            /// </summary>
            public uint ControllerDataOffset { get { return _controllerDataOffset; } }

            /// <summary>
            /// Number of floats in controller data array
            /// </summary>
            public uint ControllerDataCount { get { return _controllerDataCount; } }

            /// <summary>
            /// Duplicate value of controller data count
            /// </summary>
            public uint ControllerDataCountDuplicate { get { return _controllerDataCountDuplicate; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Quaternion rotation (4 floats W, X, Y, Z)
        /// </summary>
        public partial class Quaternion : KaitaiStruct
        {
            public static Quaternion FromFile(string fileName)
            {
                return new Quaternion(new KaitaiStream(fileName));
            }

            public Quaternion(KaitaiStream p__io, Mdl.NodeHeader p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _w = m_io.ReadF4le();
                _x = m_io.ReadF4le();
                _y = m_io.ReadF4le();
                _z = m_io.ReadF4le();
            }
            private float _w;
            private float _x;
            private float _y;
            private float _z;
            private Mdl m_root;
            private Mdl.NodeHeader m_parent;
            public float W { get { return _w; } }
            public float X { get { return _x; } }
            public float Y { get { return _y; } }
            public float Z { get { return _z; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.NodeHeader M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Reference header (36 bytes)
        /// </summary>
        public partial class ReferenceHeader : KaitaiStruct
        {
            public static ReferenceHeader FromFile(string fileName)
            {
                return new ReferenceHeader(new KaitaiStream(fileName));
            }

            public ReferenceHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _modelResref = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _reattachable = m_io.ReadU4le();
            }
            private string _modelResref;
            private uint _reattachable;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Referenced model resource name without extension (null-terminated string)
            /// </summary>
            public string ModelResref { get { return _modelResref; } }

            /// <summary>
            /// 1 if model can be detached and reattached dynamically, 0 if permanent
            /// </summary>
            public uint Reattachable { get { return _reattachable; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
        /// </summary>
        public partial class SkinmeshHeader : KaitaiStruct
        {
            public static SkinmeshHeader FromFile(string fileName)
            {
                return new SkinmeshHeader(new KaitaiStream(fileName));
            }

            public SkinmeshHeader(KaitaiStream p__io, Mdl.Node p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _trimeshBase = new TrimeshHeader(m_io, this, m_root);
                _unknownWeights = m_io.ReadS4le();
                _padding1 = new List<byte>();
                for (var i = 0; i < 8; i++)
                {
                    _padding1.Add(m_io.ReadU1());
                }
                _mdxBoneWeightsOffset = m_io.ReadU4le();
                _mdxBoneIndicesOffset = m_io.ReadU4le();
                _boneMapOffset = m_io.ReadU4le();
                _boneMapCount = m_io.ReadU4le();
                _qbonesOffset = m_io.ReadU4le();
                _qbonesCount = m_io.ReadU4le();
                _qbonesCountDuplicate = m_io.ReadU4le();
                _tbonesOffset = m_io.ReadU4le();
                _tbonesCount = m_io.ReadU4le();
                _tbonesCountDuplicate = m_io.ReadU4le();
                _unknownArray = m_io.ReadU4le();
                _boneNodeSerialNumbers = new List<ushort>();
                for (var i = 0; i < 16; i++)
                {
                    _boneNodeSerialNumbers.Add(m_io.ReadU2le());
                }
                _padding2 = m_io.ReadU2le();
            }
            private TrimeshHeader _trimeshBase;
            private int _unknownWeights;
            private List<byte> _padding1;
            private uint _mdxBoneWeightsOffset;
            private uint _mdxBoneIndicesOffset;
            private uint _boneMapOffset;
            private uint _boneMapCount;
            private uint _qbonesOffset;
            private uint _qbonesCount;
            private uint _qbonesCountDuplicate;
            private uint _tbonesOffset;
            private uint _tbonesCount;
            private uint _tbonesCountDuplicate;
            private uint _unknownArray;
            private List<ushort> _boneNodeSerialNumbers;
            private ushort _padding2;
            private Mdl m_root;
            private Mdl.Node m_parent;

            /// <summary>
            /// Standard trimesh header
            /// </summary>
            public TrimeshHeader TrimeshBase { get { return _trimeshBase; } }

            /// <summary>
            /// Purpose unknown (possibly compilation weights)
            /// </summary>
            public int UnknownWeights { get { return _unknownWeights; } }

            /// <summary>
            /// Padding
            /// </summary>
            public List<byte> Padding1 { get { return _padding1; } }

            /// <summary>
            /// Offset to bone weight data in MDX file (4 floats per vertex)
            /// </summary>
            public uint MdxBoneWeightsOffset { get { return _mdxBoneWeightsOffset; } }

            /// <summary>
            /// Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
            /// </summary>
            public uint MdxBoneIndicesOffset { get { return _mdxBoneIndicesOffset; } }

            /// <summary>
            /// Offset to bone map array (maps local bone indices to skeleton bone numbers)
            /// </summary>
            public uint BoneMapOffset { get { return _boneMapOffset; } }

            /// <summary>
            /// Number of bones referenced by this mesh (max 16)
            /// </summary>
            public uint BoneMapCount { get { return _boneMapCount; } }

            /// <summary>
            /// Offset to quaternion bind pose array (4 floats per bone)
            /// </summary>
            public uint QbonesOffset { get { return _qbonesOffset; } }

            /// <summary>
            /// Number of quaternion bind poses
            /// </summary>
            public uint QbonesCount { get { return _qbonesCount; } }

            /// <summary>
            /// Duplicate of QBones count
            /// </summary>
            public uint QbonesCountDuplicate { get { return _qbonesCountDuplicate; } }

            /// <summary>
            /// Offset to translation bind pose array (3 floats per bone)
            /// </summary>
            public uint TbonesOffset { get { return _tbonesOffset; } }

            /// <summary>
            /// Number of translation bind poses
            /// </summary>
            public uint TbonesCount { get { return _tbonesCount; } }

            /// <summary>
            /// Duplicate of TBones count
            /// </summary>
            public uint TbonesCountDuplicate { get { return _tbonesCountDuplicate; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint UnknownArray { get { return _unknownArray; } }

            /// <summary>
            /// Serial indices of bone nodes (0xFFFF for unused slots)
            /// </summary>
            public List<ushort> BoneNodeSerialNumbers { get { return _boneNodeSerialNumbers; } }

            /// <summary>
            /// Padding for alignment
            /// </summary>
            public ushort Padding2 { get { return _padding2; } }
            public Mdl M_Root { get { return m_root; } }
            public Mdl.Node M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
        /// </summary>
        public partial class TrimeshHeader : KaitaiStruct
        {
            public static TrimeshHeader FromFile(string fileName)
            {
                return new TrimeshHeader(new KaitaiStream(fileName));
            }

            public TrimeshHeader(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _functionPointer0 = m_io.ReadU4le();
                _functionPointer1 = m_io.ReadU4le();
                _facesArrayOffset = m_io.ReadU4le();
                _facesCount = m_io.ReadU4le();
                _facesCountDuplicate = m_io.ReadU4le();
                _boundingBoxMin = new Vec3f(m_io, this, m_root);
                _boundingBoxMax = new Vec3f(m_io, this, m_root);
                _radius = m_io.ReadF4le();
                _averagePoint = new Vec3f(m_io, this, m_root);
                _diffuseColor = new Vec3f(m_io, this, m_root);
                _ambientColor = new Vec3f(m_io, this, m_root);
                _transparencyHint = m_io.ReadU4le();
                _texture0Name = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _texture1Name = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(32), 0, false));
                _texture2Name = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(12), 0, false));
                _texture3Name = System.Text.Encoding.GetEncoding("ASCII").GetString(KaitaiStream.BytesTerminate(m_io.ReadBytes(12), 0, false));
                _indicesCountArrayOffset = m_io.ReadU4le();
                _indicesCountArrayCount = m_io.ReadU4le();
                _indicesCountArrayCountDuplicate = m_io.ReadU4le();
                _indicesOffsetArrayOffset = m_io.ReadU4le();
                _indicesOffsetArrayCount = m_io.ReadU4le();
                _indicesOffsetArrayCountDuplicate = m_io.ReadU4le();
                _invertedCounterArrayOffset = m_io.ReadU4le();
                _invertedCounterArrayCount = m_io.ReadU4le();
                _invertedCounterArrayCountDuplicate = m_io.ReadU4le();
                _unknownValues = new List<int>();
                for (var i = 0; i < 3; i++)
                {
                    _unknownValues.Add(m_io.ReadS4le());
                }
                _saberUnknownData = new List<byte>();
                for (var i = 0; i < 8; i++)
                {
                    _saberUnknownData.Add(m_io.ReadU1());
                }
                _unknown = m_io.ReadU4le();
                _uvDirection = new Vec3f(m_io, this, m_root);
                _uvJitter = m_io.ReadF4le();
                _uvJitterSpeed = m_io.ReadF4le();
                _mdxVertexSize = m_io.ReadU4le();
                _mdxDataFlags = m_io.ReadU4le();
                _mdxVerticesOffset = m_io.ReadS4le();
                _mdxNormalsOffset = m_io.ReadS4le();
                _mdxVertexColorsOffset = m_io.ReadS4le();
                _mdxTex0UvsOffset = m_io.ReadS4le();
                _mdxTex1UvsOffset = m_io.ReadS4le();
                _mdxTex2UvsOffset = m_io.ReadS4le();
                _mdxTex3UvsOffset = m_io.ReadS4le();
                _mdxTangentSpaceOffset = m_io.ReadS4le();
                _mdxUnknownOffset1 = m_io.ReadS4le();
                _mdxUnknownOffset2 = m_io.ReadS4le();
                _mdxUnknownOffset3 = m_io.ReadS4le();
                _vertexCount = m_io.ReadU2le();
                _textureCount = m_io.ReadU2le();
                _lightmapped = m_io.ReadU1();
                _rotateTexture = m_io.ReadU1();
                _backgroundGeometry = m_io.ReadU1();
                _shadow = m_io.ReadU1();
                _beaming = m_io.ReadU1();
                _render = m_io.ReadU1();
                _unknownFlag = m_io.ReadU1();
                _padding = m_io.ReadU1();
                _totalArea = m_io.ReadF4le();
                _unknown2 = m_io.ReadU4le();
                if (M_Root.ModelHeader.Geometry.IsKotor2) {
                    _k2Unknown1 = m_io.ReadU4le();
                }
                if (M_Root.ModelHeader.Geometry.IsKotor2) {
                    _k2Unknown2 = m_io.ReadU4le();
                }
                _mdxDataOffset = m_io.ReadU4le();
                _mdlVerticesOffset = m_io.ReadU4le();
            }
            private uint _functionPointer0;
            private uint _functionPointer1;
            private uint _facesArrayOffset;
            private uint _facesCount;
            private uint _facesCountDuplicate;
            private Vec3f _boundingBoxMin;
            private Vec3f _boundingBoxMax;
            private float _radius;
            private Vec3f _averagePoint;
            private Vec3f _diffuseColor;
            private Vec3f _ambientColor;
            private uint _transparencyHint;
            private string _texture0Name;
            private string _texture1Name;
            private string _texture2Name;
            private string _texture3Name;
            private uint _indicesCountArrayOffset;
            private uint _indicesCountArrayCount;
            private uint _indicesCountArrayCountDuplicate;
            private uint _indicesOffsetArrayOffset;
            private uint _indicesOffsetArrayCount;
            private uint _indicesOffsetArrayCountDuplicate;
            private uint _invertedCounterArrayOffset;
            private uint _invertedCounterArrayCount;
            private uint _invertedCounterArrayCountDuplicate;
            private List<int> _unknownValues;
            private List<byte> _saberUnknownData;
            private uint _unknown;
            private Vec3f _uvDirection;
            private float _uvJitter;
            private float _uvJitterSpeed;
            private uint _mdxVertexSize;
            private uint _mdxDataFlags;
            private int _mdxVerticesOffset;
            private int _mdxNormalsOffset;
            private int _mdxVertexColorsOffset;
            private int _mdxTex0UvsOffset;
            private int _mdxTex1UvsOffset;
            private int _mdxTex2UvsOffset;
            private int _mdxTex3UvsOffset;
            private int _mdxTangentSpaceOffset;
            private int _mdxUnknownOffset1;
            private int _mdxUnknownOffset2;
            private int _mdxUnknownOffset3;
            private ushort _vertexCount;
            private ushort _textureCount;
            private byte _lightmapped;
            private byte _rotateTexture;
            private byte _backgroundGeometry;
            private byte _shadow;
            private byte _beaming;
            private byte _render;
            private byte _unknownFlag;
            private byte _padding;
            private float _totalArea;
            private uint _unknown2;
            private uint? _k2Unknown1;
            private uint? _k2Unknown2;
            private uint _mdxDataOffset;
            private uint _mdlVerticesOffset;
            private Mdl m_root;
            private KaitaiStruct m_parent;

            /// <summary>
            /// Game engine function pointer (version-specific)
            /// </summary>
            public uint FunctionPointer0 { get { return _functionPointer0; } }

            /// <summary>
            /// Secondary game engine function pointer
            /// </summary>
            public uint FunctionPointer1 { get { return _functionPointer1; } }

            /// <summary>
            /// Offset to face definitions array
            /// </summary>
            public uint FacesArrayOffset { get { return _facesArrayOffset; } }

            /// <summary>
            /// Number of triangular faces in mesh
            /// </summary>
            public uint FacesCount { get { return _facesCount; } }

            /// <summary>
            /// Duplicate of faces count
            /// </summary>
            public uint FacesCountDuplicate { get { return _facesCountDuplicate; } }

            /// <summary>
            /// Minimum bounding box coordinates (X, Y, Z)
            /// </summary>
            public Vec3f BoundingBoxMin { get { return _boundingBoxMin; } }

            /// <summary>
            /// Maximum bounding box coordinates (X, Y, Z)
            /// </summary>
            public Vec3f BoundingBoxMax { get { return _boundingBoxMax; } }

            /// <summary>
            /// Bounding sphere radius
            /// </summary>
            public float Radius { get { return _radius; } }

            /// <summary>
            /// Average vertex position (centroid) X, Y, Z
            /// </summary>
            public Vec3f AveragePoint { get { return _averagePoint; } }

            /// <summary>
            /// Material diffuse color (R, G, B, range 0.0-1.0)
            /// </summary>
            public Vec3f DiffuseColor { get { return _diffuseColor; } }

            /// <summary>
            /// Material ambient color (R, G, B, range 0.0-1.0)
            /// </summary>
            public Vec3f AmbientColor { get { return _ambientColor; } }

            /// <summary>
            /// Transparency rendering mode
            /// </summary>
            public uint TransparencyHint { get { return _transparencyHint; } }

            /// <summary>
            /// Primary diffuse texture name (null-terminated string)
            /// </summary>
            public string Texture0Name { get { return _texture0Name; } }

            /// <summary>
            /// Secondary texture name, often lightmap (null-terminated string)
            /// </summary>
            public string Texture1Name { get { return _texture1Name; } }

            /// <summary>
            /// Tertiary texture name (null-terminated string)
            /// </summary>
            public string Texture2Name { get { return _texture2Name; } }

            /// <summary>
            /// Quaternary texture name (null-terminated string)
            /// </summary>
            public string Texture3Name { get { return _texture3Name; } }

            /// <summary>
            /// Offset to vertex indices count array
            /// </summary>
            public uint IndicesCountArrayOffset { get { return _indicesCountArrayOffset; } }

            /// <summary>
            /// Number of entries in indices count array
            /// </summary>
            public uint IndicesCountArrayCount { get { return _indicesCountArrayCount; } }

            /// <summary>
            /// Duplicate of indices count array count
            /// </summary>
            public uint IndicesCountArrayCountDuplicate { get { return _indicesCountArrayCountDuplicate; } }

            /// <summary>
            /// Offset to vertex indices offset array
            /// </summary>
            public uint IndicesOffsetArrayOffset { get { return _indicesOffsetArrayOffset; } }

            /// <summary>
            /// Number of entries in indices offset array
            /// </summary>
            public uint IndicesOffsetArrayCount { get { return _indicesOffsetArrayCount; } }

            /// <summary>
            /// Duplicate of indices offset array count
            /// </summary>
            public uint IndicesOffsetArrayCountDuplicate { get { return _indicesOffsetArrayCountDuplicate; } }

            /// <summary>
            /// Offset to inverted counter array
            /// </summary>
            public uint InvertedCounterArrayOffset { get { return _invertedCounterArrayOffset; } }

            /// <summary>
            /// Number of entries in inverted counter array
            /// </summary>
            public uint InvertedCounterArrayCount { get { return _invertedCounterArrayCount; } }

            /// <summary>
            /// Duplicate of inverted counter array count
            /// </summary>
            public uint InvertedCounterArrayCountDuplicate { get { return _invertedCounterArrayCountDuplicate; } }

            /// <summary>
            /// Typically {-1, -1, 0}, purpose unknown
            /// </summary>
            public List<int> UnknownValues { get { return _unknownValues; } }

            /// <summary>
            /// Data specific to lightsaber meshes
            /// </summary>
            public List<byte> SaberUnknownData { get { return _saberUnknownData; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown { get { return _unknown; } }

            /// <summary>
            /// UV animation direction X, Y components (Z = jitter speed)
            /// </summary>
            public Vec3f UvDirection { get { return _uvDirection; } }

            /// <summary>
            /// UV animation jitter amount
            /// </summary>
            public float UvJitter { get { return _uvJitter; } }

            /// <summary>
            /// UV animation jitter speed
            /// </summary>
            public float UvJitterSpeed { get { return _uvJitterSpeed; } }

            /// <summary>
            /// Size in bytes of each vertex in MDX data
            /// </summary>
            public uint MdxVertexSize { get { return _mdxVertexSize; } }

            /// <summary>
            /// Bitmask of present vertex attributes:
            /// - 0x00000001: MDX_VERTICES (vertex positions)
            /// - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
            /// - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
            /// - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
            /// - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
            /// - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
            /// - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
            /// - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
            /// </summary>
            public uint MdxDataFlags { get { return _mdxDataFlags; } }

            /// <summary>
            /// Relative offset to vertex positions in MDX (or -1 if none)
            /// </summary>
            public int MdxVerticesOffset { get { return _mdxVerticesOffset; } }

            /// <summary>
            /// Relative offset to vertex normals in MDX (or -1 if none)
            /// </summary>
            public int MdxNormalsOffset { get { return _mdxNormalsOffset; } }

            /// <summary>
            /// Relative offset to vertex colors in MDX (or -1 if none)
            /// </summary>
            public int MdxVertexColorsOffset { get { return _mdxVertexColorsOffset; } }

            /// <summary>
            /// Relative offset to primary texture UVs in MDX (or -1 if none)
            /// </summary>
            public int MdxTex0UvsOffset { get { return _mdxTex0UvsOffset; } }

            /// <summary>
            /// Relative offset to secondary texture UVs in MDX (or -1 if none)
            /// </summary>
            public int MdxTex1UvsOffset { get { return _mdxTex1UvsOffset; } }

            /// <summary>
            /// Relative offset to tertiary texture UVs in MDX (or -1 if none)
            /// </summary>
            public int MdxTex2UvsOffset { get { return _mdxTex2UvsOffset; } }

            /// <summary>
            /// Relative offset to quaternary texture UVs in MDX (or -1 if none)
            /// </summary>
            public int MdxTex3UvsOffset { get { return _mdxTex3UvsOffset; } }

            /// <summary>
            /// Relative offset to tangent space data in MDX (or -1 if none)
            /// </summary>
            public int MdxTangentSpaceOffset { get { return _mdxTangentSpaceOffset; } }

            /// <summary>
            /// Relative offset to unknown MDX data (or -1 if none)
            /// </summary>
            public int MdxUnknownOffset1 { get { return _mdxUnknownOffset1; } }

            /// <summary>
            /// Relative offset to unknown MDX data (or -1 if none)
            /// </summary>
            public int MdxUnknownOffset2 { get { return _mdxUnknownOffset2; } }

            /// <summary>
            /// Relative offset to unknown MDX data (or -1 if none)
            /// </summary>
            public int MdxUnknownOffset3 { get { return _mdxUnknownOffset3; } }

            /// <summary>
            /// Number of vertices in mesh
            /// </summary>
            public ushort VertexCount { get { return _vertexCount; } }

            /// <summary>
            /// Number of textures used by mesh
            /// </summary>
            public ushort TextureCount { get { return _textureCount; } }

            /// <summary>
            /// 1 if mesh uses lightmap, 0 otherwise
            /// </summary>
            public byte Lightmapped { get { return _lightmapped; } }

            /// <summary>
            /// 1 if texture should rotate, 0 otherwise
            /// </summary>
            public byte RotateTexture { get { return _rotateTexture; } }

            /// <summary>
            /// 1 if background geometry, 0 otherwise
            /// </summary>
            public byte BackgroundGeometry { get { return _backgroundGeometry; } }

            /// <summary>
            /// 1 if mesh casts shadows, 0 otherwise
            /// </summary>
            public byte Shadow { get { return _shadow; } }

            /// <summary>
            /// 1 if beaming effect enabled, 0 otherwise
            /// </summary>
            public byte Beaming { get { return _beaming; } }

            /// <summary>
            /// 1 if mesh is renderable, 0 if hidden
            /// </summary>
            public byte Render { get { return _render; } }

            /// <summary>
            /// Purpose unknown (possibly UV animation enable)
            /// </summary>
            public byte UnknownFlag { get { return _unknownFlag; } }

            /// <summary>
            /// Padding byte
            /// </summary>
            public byte Padding { get { return _padding; } }

            /// <summary>
            /// Total surface area of all faces
            /// </summary>
            public float TotalArea { get { return _totalArea; } }

            /// <summary>
            /// Purpose unknown
            /// </summary>
            public uint Unknown2 { get { return _unknown2; } }

            /// <summary>
            /// KOTOR 2 only: Additional unknown field
            /// </summary>
            public uint? K2Unknown1 { get { return _k2Unknown1; } }

            /// <summary>
            /// KOTOR 2 only: Additional unknown field
            /// </summary>
            public uint? K2Unknown2 { get { return _k2Unknown2; } }

            /// <summary>
            /// Absolute offset to this mesh's vertex data in MDX file
            /// </summary>
            public uint MdxDataOffset { get { return _mdxDataOffset; } }

            /// <summary>
            /// Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
            /// </summary>
            public uint MdlVerticesOffset { get { return _mdlVerticesOffset; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }

        /// <summary>
        /// 3D vector (3 floats)
        /// </summary>
        public partial class Vec3f : KaitaiStruct
        {
            public static Vec3f FromFile(string fileName)
            {
                return new Vec3f(new KaitaiStream(fileName));
            }

            public Vec3f(KaitaiStream p__io, KaitaiStruct p__parent = null, Mdl p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _x = m_io.ReadF4le();
                _y = m_io.ReadF4le();
                _z = m_io.ReadF4le();
            }
            private float _x;
            private float _y;
            private float _z;
            private Mdl m_root;
            private KaitaiStruct m_parent;
            public float X { get { return _x; } }
            public float Y { get { return _y; } }
            public float Z { get { return _z; } }
            public Mdl M_Root { get { return m_root; } }
            public KaitaiStruct M_Parent { get { return m_parent; } }
        }
        private bool f_animationOffsets;
        private List<uint> _animationOffsets;

        /// <summary>
        /// Animation header offsets (relative to data_start)
        /// </summary>
        public List<uint> AnimationOffsets
        {
            get
            {
                if (f_animationOffsets)
                    return _animationOffsets;
                f_animationOffsets = true;
                if (ModelHeader.AnimationCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(DataStart + ModelHeader.OffsetToAnimations);
                    _animationOffsets = new List<uint>();
                    for (var i = 0; i < ModelHeader.AnimationCount; i++)
                    {
                        _animationOffsets.Add(m_io.ReadU4le());
                    }
                    m_io.Seek(_pos);
                }
                return _animationOffsets;
            }
        }
        private bool f_animations;
        private List<MdlAnimationEntry> _animations;

        /// <summary>
        /// Animation headers (via offset table). Each list element is `mdl_animation_entry`;
        /// the parsed header is `element.header` (same wire layout as `animation_header`).
        /// </summary>
        public List<MdlAnimationEntry> Animations
        {
            get
            {
                if (f_animations)
                    return _animations;
                f_animations = true;
                if (ModelHeader.AnimationCount > 0) {
                    _animations = new List<MdlAnimationEntry>();
                    for (var i = 0; i < ModelHeader.AnimationCount; i++)
                    {
                        _animations.Add(new MdlAnimationEntry(i, m_io, this, m_root));
                    }
                }
                return _animations;
            }
        }
        private bool f_dataStart;
        private sbyte _dataStart;

        /// <summary>
        /// MDL &quot;data start&quot; offset. Most offsets in this file are relative to the start of the MDL data
        /// section, which begins immediately after the 12-byte file header.
        /// </summary>
        public sbyte DataStart
        {
            get
            {
                if (f_dataStart)
                    return _dataStart;
                f_dataStart = true;
                _dataStart = (sbyte) (12);
                return _dataStart;
            }
        }
        private bool f_nameOffsets;
        private List<uint> _nameOffsets;

        /// <summary>
        /// Name string offsets (relative to data_start)
        /// </summary>
        public List<uint> NameOffsets
        {
            get
            {
                if (f_nameOffsets)
                    return _nameOffsets;
                f_nameOffsets = true;
                if (ModelHeader.NameOffsetsCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(DataStart + ModelHeader.OffsetToNameOffsets);
                    _nameOffsets = new List<uint>();
                    for (var i = 0; i < ModelHeader.NameOffsetsCount; i++)
                    {
                        _nameOffsets.Add(m_io.ReadU4le());
                    }
                    m_io.Seek(_pos);
                }
                return _nameOffsets;
            }
        }
        private bool f_namesData;
        private NameStrings _namesData;

        /// <summary>
        /// Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
        /// Parsed as null-terminated ASCII strings in `name_strings`.
        /// </summary>
        public NameStrings NamesData
        {
            get
            {
                if (f_namesData)
                    return _namesData;
                f_namesData = true;
                if (ModelHeader.NameOffsetsCount > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek((DataStart + ModelHeader.OffsetToNameOffsets) + 4 * ModelHeader.NameOffsetsCount);
                    __raw_namesData = m_io.ReadBytes((DataStart + ModelHeader.OffsetToAnimations) - ((DataStart + ModelHeader.OffsetToNameOffsets) + 4 * ModelHeader.NameOffsetsCount));
                    var io___raw_namesData = new KaitaiStream(__raw_namesData);
                    _namesData = new NameStrings(io___raw_namesData, this, m_root);
                    m_io.Seek(_pos);
                }
                return _namesData;
            }
        }
        private bool f_rootNode;
        private Node _rootNode;
        public Node RootNode
        {
            get
            {
                if (f_rootNode)
                    return _rootNode;
                f_rootNode = true;
                if (ModelHeader.Geometry.RootNodeOffset > 0) {
                    long _pos = m_io.Pos;
                    m_io.Seek(DataStart + ModelHeader.Geometry.RootNodeOffset);
                    _rootNode = new Node(m_io, this, m_root);
                    m_io.Seek(_pos);
                }
                return _rootNode;
            }
        }
        private FileHeader _fileHeader;
        private ModelHeader _modelHeader;
        private Mdl m_root;
        private KaitaiStruct m_parent;
        private byte[] __raw_namesData;
        public FileHeader FileHeader { get { return _fileHeader; } }
        public ModelHeader ModelHeader { get { return _modelHeader; } }
        public Mdl M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
        public byte[] M_RawNamesData { get { return __raw_namesData; } }
    }
}

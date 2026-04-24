// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
    /// `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
    /// Tooling alignment: PyKotor / MDLOps / xoreos.
    /// 
    /// - `model_classification` — `model_header.model_type` (`u1`).
    /// - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
    /// - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
    /// </summary>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/">PyKotor — MDL package</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267">xoreos — `Model_KotOR::load`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81">xoreos — `kFileTypeMDL`</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (controller IDs)</a>
    /// </remarks>
    /// <remarks>
    /// Reference: <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407">Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)</a>
    /// </remarks>
    public partial class BiowareMdlCommon : KaitaiStruct
    {
        public static BiowareMdlCommon FromFile(string fileName)
        {
            return new BiowareMdlCommon(new KaitaiStream(fileName));
        }


        public enum ControllerType
        {
            Position = 8,
            Orientation = 20,
            Scale = 36,
            Color = 76,
            EmitterAlphaEnd = 80,
            EmitterAlphaStart = 84,
            Radius = 88,
            EmitterBounceCoefficient = 92,
            ShadowRadius = 96,
            VerticalDisplacementOrDragOrSelfillumcolor = 100,
            EmitterFps = 104,
            EmitterFrameEnd = 108,
            EmitterFrameStart = 112,
            EmitterGravity = 116,
            EmitterLifeExpectancy = 120,
            EmitterMass = 124,
            Alpha = 132,
            EmitterParticleRotation = 136,
            MultiplierOrRandvel = 140,
            EmitterSizeStart = 144,
            EmitterSizeEnd = 148,
            EmitterSizeStartY = 152,
            EmitterSizeEndY = 156,
            EmitterSpread = 160,
            EmitterThreshold = 164,
            EmitterVelocity = 168,
            EmitterXSize = 172,
            EmitterYSize = 176,
            EmitterBlurLength = 180,
            EmitterLightningDelay = 184,
            EmitterLightningRadius = 188,
            EmitterLightningScale = 192,
            EmitterLightningSubdivide = 196,
            EmitterLightningZigZag = 200,
            EmitterAlphaMid = 216,
            EmitterPercentStart = 220,
            EmitterPercentMid = 224,
            EmitterPercentEnd = 228,
            EmitterSizeMid = 232,
            EmitterSizeMidY = 236,
            EmitterRandomBirthRate = 240,
            EmitterTargetSize = 252,
            EmitterNumControlPoints = 256,
            EmitterControlPointRadius = 260,
            EmitterControlPointDelay = 264,
            EmitterTangentSpread = 268,
            EmitterTangentLength = 272,
            EmitterColorMid = 284,
            EmitterColorEnd = 380,
            EmitterColorStart = 392,
            EmitterDetonate = 502,
        }

        public enum ModelClassification
        {
            Other = 0,
            Effect = 1,
            Tile = 2,
            Character = 4,
            Door = 8,
            Lightsaber = 16,
            Placeable = 32,
            Flyer = 64,
        }

        public enum NodeTypeValue
        {
            Dummy = 1,
            Light = 3,
            Emitter = 5,
            Reference = 17,
            Trimesh = 33,
            Skinmesh = 97,
            Animmesh = 161,
            Danglymesh = 289,
            Aabb = 545,
            Lightsaber = 2081,
        }
        public BiowareMdlCommon(KaitaiStream p__io, KaitaiStruct p__parent = null, BiowareMdlCommon p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
        }
        private BiowareMdlCommon m_root;
        private KaitaiStruct m_parent;
        public BiowareMdlCommon M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}

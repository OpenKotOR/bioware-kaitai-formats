// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


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
 * @see <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy">In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408">PyKotor — MDLBinaryReader (binary MDL/MDX)</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267">xoreos — Model_KotOR::load</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79">xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (controller / Aurora background)</a>
 * @see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118">reone — MdlMdxReader::load</a>
 * @see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170">KotOR.js — OdysseyModel binary constructor</a>
 * @see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407">Community MDLOps — controller name table</a>
 * @see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698">Community MDLOps — `readasciimdl` (ASCII MDL ingest)</a>
 */
public class Mdl extends KaitaiStruct {
    public static Mdl fromFile(String fileName) throws IOException {
        return new Mdl(new ByteBufferKaitaiStream(fileName));
    }

    public Mdl(KaitaiStream _io) {
        this(_io, null, null);
    }

    public Mdl(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public Mdl(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
        this.fileHeader = new FileHeader(this._io, this, _root);
        this.modelHeader = new ModelHeader(this._io, this, _root);
    }

    public void _fetchInstances() {
        this.fileHeader._fetchInstances();
        this.modelHeader._fetchInstances();
        animationOffsets();
        if (this.animationOffsets != null) {
            for (int i = 0; i < this.animationOffsets.size(); i++) {
            }
        }
        animations();
        if (this.animations != null) {
            for (int i = 0; i < this.animations.size(); i++) {
                this.animations.get(((Number) (i)).intValue())._fetchInstances();
            }
        }
        nameOffsets();
        if (this.nameOffsets != null) {
            for (int i = 0; i < this.nameOffsets.size(); i++) {
            }
        }
        namesData();
        if (this.namesData != null) {
            this.namesData._fetchInstances();
        }
        rootNode();
        if (this.rootNode != null) {
            this.rootNode._fetchInstances();
        }
    }

    /**
     * AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
     */
    public static class AabbHeader extends KaitaiStruct {
        public static AabbHeader fromFile(String fileName) throws IOException {
            return new AabbHeader(new ByteBufferKaitaiStream(fileName));
        }

        public AabbHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AabbHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public AabbHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.trimeshBase = new TrimeshHeader(this._io, this, _root);
            this.unknown = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.trimeshBase._fetchInstances();
        }
        private TrimeshHeader trimeshBase;
        private long unknown;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Standard trimesh header
         */
        public TrimeshHeader trimeshBase() { return trimeshBase; }

        /**
         * Purpose unknown
         */
        public long unknown() { return unknown; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Animation event (36 bytes)
     */
    public static class AnimationEvent extends KaitaiStruct {
        public static AnimationEvent fromFile(String fileName) throws IOException {
            return new AnimationEvent(new ByteBufferKaitaiStream(fileName));
        }

        public AnimationEvent(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AnimationEvent(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public AnimationEvent(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.activationTime = this._io.readF4le();
            this.eventName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
        }

        public void _fetchInstances() {
        }
        private float activationTime;
        private String eventName;
        private Mdl _root;
        private KaitaiStruct _parent;

        /**
         * Time in seconds when event triggers during animation playback
         */
        public float activationTime() { return activationTime; }

        /**
         * Name of event (null-terminated string, e.g., "detonate")
         */
        public String eventName() { return eventName; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
     */
    public static class AnimationHeader extends KaitaiStruct {
        public static AnimationHeader fromFile(String fileName) throws IOException {
            return new AnimationHeader(new ByteBufferKaitaiStream(fileName));
        }

        public AnimationHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AnimationHeader(KaitaiStream _io, Mdl.MdlAnimationEntry _parent) {
            this(_io, _parent, null);
        }

        public AnimationHeader(KaitaiStream _io, Mdl.MdlAnimationEntry _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.geoHeader = new GeometryHeader(this._io, this, _root);
            this.animationLength = this._io.readF4le();
            this.transitionTime = this._io.readF4le();
            this.animationRoot = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.eventArrayOffset = this._io.readU4le();
            this.eventCount = this._io.readU4le();
            this.eventCountDuplicate = this._io.readU4le();
            this.unknown = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.geoHeader._fetchInstances();
        }
        private GeometryHeader geoHeader;
        private float animationLength;
        private float transitionTime;
        private String animationRoot;
        private long eventArrayOffset;
        private long eventCount;
        private long eventCountDuplicate;
        private long unknown;
        private Mdl _root;
        private Mdl.MdlAnimationEntry _parent;

        /**
         * Standard 80-byte geometry header (geometry_type = 0x01 for animation)
         */
        public GeometryHeader geoHeader() { return geoHeader; }

        /**
         * Duration of animation in seconds
         */
        public float animationLength() { return animationLength; }

        /**
         * Transition/blend time to this animation in seconds
         */
        public float transitionTime() { return transitionTime; }

        /**
         * Root node name for animation (null-terminated string)
         */
        public String animationRoot() { return animationRoot; }

        /**
         * Offset to animation events array
         */
        public long eventArrayOffset() { return eventArrayOffset; }

        /**
         * Number of animation events
         */
        public long eventCount() { return eventCount; }

        /**
         * Duplicate value of event count
         */
        public long eventCountDuplicate() { return eventCountDuplicate; }

        /**
         * Purpose unknown
         */
        public long unknown() { return unknown; }
        public Mdl _root() { return _root; }
        public Mdl.MdlAnimationEntry _parent() { return _parent; }
    }

    /**
     * Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
     */
    public static class AnimmeshHeader extends KaitaiStruct {
        public static AnimmeshHeader fromFile(String fileName) throws IOException {
            return new AnimmeshHeader(new ByteBufferKaitaiStream(fileName));
        }

        public AnimmeshHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public AnimmeshHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public AnimmeshHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.trimeshBase = new TrimeshHeader(this._io, this, _root);
            this.unknown = this._io.readF4le();
            this.unknownArray = new ArrayDefinition(this._io, this, _root);
            this.unknownFloats = new ArrayList<Float>();
            for (int i = 0; i < 9; i++) {
                this.unknownFloats.add(this._io.readF4le());
            }
        }

        public void _fetchInstances() {
            this.trimeshBase._fetchInstances();
            this.unknownArray._fetchInstances();
            for (int i = 0; i < this.unknownFloats.size(); i++) {
            }
        }
        private TrimeshHeader trimeshBase;
        private float unknown;
        private ArrayDefinition unknownArray;
        private List<Float> unknownFloats;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Standard trimesh header
         */
        public TrimeshHeader trimeshBase() { return trimeshBase; }

        /**
         * Purpose unknown
         */
        public float unknown() { return unknown; }

        /**
         * Unknown array definition
         */
        public ArrayDefinition unknownArray() { return unknownArray; }

        /**
         * Unknown float values
         */
        public List<Float> unknownFloats() { return unknownFloats; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Array definition structure (offset, count, count duplicate)
     */
    public static class ArrayDefinition extends KaitaiStruct {
        public static ArrayDefinition fromFile(String fileName) throws IOException {
            return new ArrayDefinition(new ByteBufferKaitaiStream(fileName));
        }

        public ArrayDefinition(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ArrayDefinition(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public ArrayDefinition(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.offset = this._io.readS4le();
            this.count = this._io.readU4le();
            this.countDuplicate = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private int offset;
        private long count;
        private long countDuplicate;
        private Mdl _root;
        private KaitaiStruct _parent;

        /**
         * Offset to array (relative to MDL data start, offset 12)
         */
        public int offset() { return offset; }

        /**
         * Number of used entries
         */
        public long count() { return count; }

        /**
         * Duplicate of count (allocated entries)
         */
        public long countDuplicate() { return countDuplicate; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Controller structure (16 bytes) - defines animation data for a node property over time
     */
    public static class Controller extends KaitaiStruct {
        public static Controller fromFile(String fileName) throws IOException {
            return new Controller(new ByteBufferKaitaiStream(fileName));
        }

        public Controller(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Controller(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public Controller(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.type = BiowareMdlCommon.ControllerType.byId(this._io.readU4le());
            this.unknown = this._io.readU2le();
            this.rowCount = this._io.readU2le();
            this.timeIndex = this._io.readU2le();
            this.dataIndex = this._io.readU2le();
            this.columnCount = this._io.readU1();
            this.padding = new ArrayList<Integer>();
            for (int i = 0; i < 3; i++) {
                this.padding.add(this._io.readU1());
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.padding.size(); i++) {
            }
        }
        private Boolean usesBezier;

        /**
         * True if controller uses Bezier interpolation
         */
        public Boolean usesBezier() {
            if (this.usesBezier != null)
                return this.usesBezier;
            this.usesBezier = (columnCount() & 16) != 0;
            return this.usesBezier;
        }
        private BiowareMdlCommon.ControllerType type;
        private int unknown;
        private int rowCount;
        private int timeIndex;
        private int dataIndex;
        private int columnCount;
        private List<Integer> padding;
        private Mdl _root;
        private KaitaiStruct _parent;

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
        public BiowareMdlCommon.ControllerType type() { return type; }

        /**
         * Purpose unknown, typically 0xFFFF
         */
        public int unknown() { return unknown; }

        /**
         * Number of keyframe rows (timepoints) for this controller
         */
        public int rowCount() { return rowCount; }

        /**
         * Index into controller data array where time values begin
         */
        public int timeIndex() { return timeIndex; }

        /**
         * Index into controller data array where property values begin
         */
        public int dataIndex() { return dataIndex; }

        /**
         * Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
         * If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
         */
        public int columnCount() { return columnCount; }

        /**
         * Padding bytes for 16-byte alignment
         */
        public List<Integer> padding() { return padding; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
     */
    public static class DanglymeshHeader extends KaitaiStruct {
        public static DanglymeshHeader fromFile(String fileName) throws IOException {
            return new DanglymeshHeader(new ByteBufferKaitaiStream(fileName));
        }

        public DanglymeshHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public DanglymeshHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public DanglymeshHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.trimeshBase = new TrimeshHeader(this._io, this, _root);
            this.constraintsOffset = this._io.readU4le();
            this.constraintsCount = this._io.readU4le();
            this.constraintsCountDuplicate = this._io.readU4le();
            this.displacement = this._io.readF4le();
            this.tightness = this._io.readF4le();
            this.period = this._io.readF4le();
            this.unknown = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.trimeshBase._fetchInstances();
        }
        private TrimeshHeader trimeshBase;
        private long constraintsOffset;
        private long constraintsCount;
        private long constraintsCountDuplicate;
        private float displacement;
        private float tightness;
        private float period;
        private long unknown;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Standard trimesh header
         */
        public TrimeshHeader trimeshBase() { return trimeshBase; }

        /**
         * Offset to vertex constraint values array
         */
        public long constraintsOffset() { return constraintsOffset; }

        /**
         * Number of vertex constraints (matches vertex count)
         */
        public long constraintsCount() { return constraintsCount; }

        /**
         * Duplicate of constraints count
         */
        public long constraintsCountDuplicate() { return constraintsCountDuplicate; }

        /**
         * Maximum displacement distance for physics simulation
         */
        public float displacement() { return displacement; }

        /**
         * Tightness/stiffness of spring simulation (0.0-1.0)
         */
        public float tightness() { return tightness; }

        /**
         * Oscillation period in seconds
         */
        public float period() { return period; }

        /**
         * Purpose unknown
         */
        public long unknown() { return unknown; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Emitter header (224 bytes)
     */
    public static class EmitterHeader extends KaitaiStruct {
        public static EmitterHeader fromFile(String fileName) throws IOException {
            return new EmitterHeader(new ByteBufferKaitaiStream(fileName));
        }

        public EmitterHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public EmitterHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public EmitterHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.deadSpace = this._io.readF4le();
            this.blastRadius = this._io.readF4le();
            this.blastLength = this._io.readF4le();
            this.branchCount = this._io.readU4le();
            this.controlPointSmoothing = this._io.readF4le();
            this.xGrid = this._io.readU4le();
            this.yGrid = this._io.readU4le();
            this.paddingUnknown = this._io.readU4le();
            this.updateScript = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.renderScript = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.blendScript = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.textureName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.chunkName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.twoSidedTexture = this._io.readU4le();
            this.loop = this._io.readU4le();
            this.renderOrder = this._io.readU2le();
            this.frameBlending = this._io.readU1();
            this.depthTextureName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.padding = this._io.readU1();
            this.flags = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private float deadSpace;
        private float blastRadius;
        private float blastLength;
        private long branchCount;
        private float controlPointSmoothing;
        private long xGrid;
        private long yGrid;
        private long paddingUnknown;
        private String updateScript;
        private String renderScript;
        private String blendScript;
        private String textureName;
        private String chunkName;
        private long twoSidedTexture;
        private long loop;
        private int renderOrder;
        private int frameBlending;
        private String depthTextureName;
        private int padding;
        private long flags;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Minimum distance from emitter before particles become visible
         */
        public float deadSpace() { return deadSpace; }

        /**
         * Radius of explosive/blast particle effects
         */
        public float blastRadius() { return blastRadius; }

        /**
         * Length/duration of blast effects
         */
        public float blastLength() { return blastLength; }

        /**
         * Number of branching paths for particle trails
         */
        public long branchCount() { return branchCount; }

        /**
         * Smoothing factor for particle path control points
         */
        public float controlPointSmoothing() { return controlPointSmoothing; }

        /**
         * Grid subdivisions along X axis for particle spawning
         */
        public long xGrid() { return xGrid; }

        /**
         * Grid subdivisions along Y axis for particle spawning
         */
        public long yGrid() { return yGrid; }

        /**
         * Purpose unknown or padding
         */
        public long paddingUnknown() { return paddingUnknown; }

        /**
         * Update behavior script name (e.g., "single", "fountain")
         */
        public String updateScript() { return updateScript; }

        /**
         * Render mode script name (e.g., "normal", "billboard_to_local_z")
         */
        public String renderScript() { return renderScript; }

        /**
         * Blend mode script name (e.g., "normal", "lighten")
         */
        public String blendScript() { return blendScript; }

        /**
         * Particle texture name (null-terminated string)
         */
        public String textureName() { return textureName; }

        /**
         * Associated model chunk name (null-terminated string)
         */
        public String chunkName() { return chunkName; }

        /**
         * 1 if texture should render two-sided, 0 for single-sided
         */
        public long twoSidedTexture() { return twoSidedTexture; }

        /**
         * 1 if particle system loops, 0 for single playback
         */
        public long loop() { return loop; }

        /**
         * Rendering priority/order for particle sorting
         */
        public int renderOrder() { return renderOrder; }

        /**
         * 1 if frame blending enabled, 0 otherwise
         */
        public int frameBlending() { return frameBlending; }

        /**
         * Depth/softparticle texture name (null-terminated string)
         */
        public String depthTextureName() { return depthTextureName; }

        /**
         * Padding byte for alignment
         */
        public int padding() { return padding; }

        /**
         * Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
         */
        public long flags() { return flags; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * MDL file header (12 bytes)
     */
    public static class FileHeader extends KaitaiStruct {
        public static FileHeader fromFile(String fileName) throws IOException {
            return new FileHeader(new ByteBufferKaitaiStream(fileName));
        }

        public FileHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public FileHeader(KaitaiStream _io, Mdl _parent) {
            this(_io, _parent, null);
        }

        public FileHeader(KaitaiStream _io, Mdl _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.unused = this._io.readU4le();
            this.mdlSize = this._io.readU4le();
            this.mdxSize = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private long unused;
        private long mdlSize;
        private long mdxSize;
        private Mdl _root;
        private Mdl _parent;

        /**
         * Always 0
         */
        public long unused() { return unused; }

        /**
         * Size of MDL file in bytes
         */
        public long mdlSize() { return mdlSize; }

        /**
         * Size of MDX file in bytes
         */
        public long mdxSize() { return mdxSize; }
        public Mdl _root() { return _root; }
        public Mdl _parent() { return _parent; }
    }

    /**
     * Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
     */
    public static class GeometryHeader extends KaitaiStruct {
        public static GeometryHeader fromFile(String fileName) throws IOException {
            return new GeometryHeader(new ByteBufferKaitaiStream(fileName));
        }

        public GeometryHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public GeometryHeader(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public GeometryHeader(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.functionPointer0 = this._io.readU4le();
            this.functionPointer1 = this._io.readU4le();
            this.modelName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.rootNodeOffset = this._io.readU4le();
            this.nodeCount = this._io.readU4le();
            this.unknownArray1 = new ArrayDefinition(this._io, this, _root);
            this.unknownArray2 = new ArrayDefinition(this._io, this, _root);
            this.referenceCount = this._io.readU4le();
            this.geometryType = this._io.readU1();
            this.padding = new ArrayList<Integer>();
            for (int i = 0; i < 3; i++) {
                this.padding.add(this._io.readU1());
            }
        }

        public void _fetchInstances() {
            this.unknownArray1._fetchInstances();
            this.unknownArray2._fetchInstances();
            for (int i = 0; i < this.padding.size(); i++) {
            }
        }
        private Boolean isKotor2;

        /**
         * True if this is a KOTOR 2 model
         */
        public Boolean isKotor2() {
            if (this.isKotor2 != null)
                return this.isKotor2;
            this.isKotor2 =  ((functionPointer0() == 4285200) || (functionPointer0() == 4285872)) ;
            return this.isKotor2;
        }
        private long functionPointer0;
        private long functionPointer1;
        private String modelName;
        private long rootNodeOffset;
        private long nodeCount;
        private ArrayDefinition unknownArray1;
        private ArrayDefinition unknownArray2;
        private long referenceCount;
        private int geometryType;
        private List<Integer> padding;
        private Mdl _root;
        private KaitaiStruct _parent;

        /**
         * Game engine version identifier:
         * - KOTOR 1 PC: 4273776 (0x413670)
         * - KOTOR 2 PC: 4285200 (0x416310)
         * - KOTOR 1 Xbox: 4254992 (0x40ED10)
         * - KOTOR 2 Xbox: 4285872 (0x4165B0)
         */
        public long functionPointer0() { return functionPointer0; }

        /**
         * Function pointer to ASCII model parser
         */
        public long functionPointer1() { return functionPointer1; }

        /**
         * Model name, null-terminated string, max 32 (0x20) bytes
         */
        public String modelName() { return modelName; }

        /**
         * Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
         */
        public long rootNodeOffset() { return rootNodeOffset; }

        /**
         * Total number of nodes in model hierarchy, unsigned 32-bit integer
         */
        public long nodeCount() { return nodeCount; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        public ArrayDefinition unknownArray1() { return unknownArray1; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        public ArrayDefinition unknownArray2() { return unknownArray2; }

        /**
         * Reference count (initialized to 0, incremented when model is referenced)
         */
        public long referenceCount() { return referenceCount; }

        /**
         * Geometry type:
         * - 0x01: Basic geometry header (not in models)
         * - 0x02: Model geometry header
         * - 0x05: Animation geometry header
         * If bit 7 (0x80) is set, model is compiled binary with absolute addresses
         */
        public int geometryType() { return geometryType; }

        /**
         * Padding bytes for alignment
         */
        public List<Integer> padding() { return padding; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * Light header (92 bytes)
     */
    public static class LightHeader extends KaitaiStruct {
        public static LightHeader fromFile(String fileName) throws IOException {
            return new LightHeader(new ByteBufferKaitaiStream(fileName));
        }

        public LightHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LightHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public LightHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.unknown = new ArrayList<Float>();
            for (int i = 0; i < 4; i++) {
                this.unknown.add(this._io.readF4le());
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

        public void _fetchInstances() {
            for (int i = 0; i < this.unknown.size(); i++) {
            }
        }
        private List<Float> unknown;
        private long flareSizesOffset;
        private long flareSizesCount;
        private long flareSizesCountDuplicate;
        private long flarePositionsOffset;
        private long flarePositionsCount;
        private long flarePositionsCountDuplicate;
        private long flareColorShiftsOffset;
        private long flareColorShiftsCount;
        private long flareColorShiftsCountDuplicate;
        private long flareTextureNamesOffset;
        private long flareTextureNamesCount;
        private long flareTextureNamesCountDuplicate;
        private float flareRadius;
        private long lightPriority;
        private long ambientOnly;
        private long dynamicType;
        private long affectDynamic;
        private long shadow;
        private long flare;
        private long fadingLight;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Purpose unknown, possibly padding or reserved values
         */
        public List<Float> unknown() { return unknown; }

        /**
         * Offset to flare sizes array (floats)
         */
        public long flareSizesOffset() { return flareSizesOffset; }

        /**
         * Number of flare size entries
         */
        public long flareSizesCount() { return flareSizesCount; }

        /**
         * Duplicate of flare sizes count
         */
        public long flareSizesCountDuplicate() { return flareSizesCountDuplicate; }

        /**
         * Offset to flare positions array (floats, 0.0-1.0 along light ray)
         */
        public long flarePositionsOffset() { return flarePositionsOffset; }

        /**
         * Number of flare position entries
         */
        public long flarePositionsCount() { return flarePositionsCount; }

        /**
         * Duplicate of flare positions count
         */
        public long flarePositionsCountDuplicate() { return flarePositionsCountDuplicate; }

        /**
         * Offset to flare color shift array (RGB floats)
         */
        public long flareColorShiftsOffset() { return flareColorShiftsOffset; }

        /**
         * Number of flare color shift entries
         */
        public long flareColorShiftsCount() { return flareColorShiftsCount; }

        /**
         * Duplicate of flare color shifts count
         */
        public long flareColorShiftsCountDuplicate() { return flareColorShiftsCountDuplicate; }

        /**
         * Offset to flare texture name string offsets array
         */
        public long flareTextureNamesOffset() { return flareTextureNamesOffset; }

        /**
         * Number of flare texture names
         */
        public long flareTextureNamesCount() { return flareTextureNamesCount; }

        /**
         * Duplicate of flare texture names count
         */
        public long flareTextureNamesCountDuplicate() { return flareTextureNamesCountDuplicate; }

        /**
         * Radius of flare effect
         */
        public float flareRadius() { return flareRadius; }

        /**
         * Rendering priority for light culling/sorting
         */
        public long lightPriority() { return lightPriority; }

        /**
         * 1 if light only affects ambient, 0 for full lighting
         */
        public long ambientOnly() { return ambientOnly; }

        /**
         * Type of dynamic lighting behavior
         */
        public long dynamicType() { return dynamicType; }

        /**
         * 1 if light affects dynamic objects, 0 otherwise
         */
        public long affectDynamic() { return affectDynamic; }

        /**
         * 1 if light casts shadows, 0 otherwise
         */
        public long shadow() { return shadow; }

        /**
         * 1 if lens flare effect enabled, 0 otherwise
         */
        public long flare() { return flare; }

        /**
         * 1 if light intensity fades with distance, 0 otherwise
         */
        public long fadingLight() { return fadingLight; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
     */
    public static class LightsaberHeader extends KaitaiStruct {
        public static LightsaberHeader fromFile(String fileName) throws IOException {
            return new LightsaberHeader(new ByteBufferKaitaiStream(fileName));
        }

        public LightsaberHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public LightsaberHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public LightsaberHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.trimeshBase = new TrimeshHeader(this._io, this, _root);
            this.verticesOffset = this._io.readU4le();
            this.texcoordsOffset = this._io.readU4le();
            this.normalsOffset = this._io.readU4le();
            this.unknown1 = this._io.readU4le();
            this.unknown2 = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.trimeshBase._fetchInstances();
        }
        private TrimeshHeader trimeshBase;
        private long verticesOffset;
        private long texcoordsOffset;
        private long normalsOffset;
        private long unknown1;
        private long unknown2;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Standard trimesh header
         */
        public TrimeshHeader trimeshBase() { return trimeshBase; }

        /**
         * Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
         */
        public long verticesOffset() { return verticesOffset; }

        /**
         * Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
         */
        public long texcoordsOffset() { return texcoordsOffset; }

        /**
         * Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
         */
        public long normalsOffset() { return normalsOffset; }

        /**
         * Purpose unknown
         */
        public long unknown1() { return unknown1; }

        /**
         * Purpose unknown
         */
        public long unknown2() { return unknown2; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
     * Wraps the header so repeated root instances can use parametric types (user guide).
     */
    public static class MdlAnimationEntry extends KaitaiStruct {

        public MdlAnimationEntry(KaitaiStream _io, long animIndex) {
            this(_io, null, null, animIndex);
        }

        public MdlAnimationEntry(KaitaiStream _io, Mdl _parent, long animIndex) {
            this(_io, _parent, null, animIndex);
        }

        public MdlAnimationEntry(KaitaiStream _io, Mdl _parent, Mdl _root, long animIndex) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            this.animIndex = animIndex;
            _read();
        }
        private void _read() {
        }

        public void _fetchInstances() {
            header();
            if (this.header != null) {
                this.header._fetchInstances();
            }
        }
        private AnimationHeader header;
        public AnimationHeader header() {
            if (this.header != null)
                return this.header;
            long _pos = this._io.pos();
            this._io.seek(_root().dataStart() + _root().animationOffsets().get(((Number) (animIndex())).intValue()));
            this.header = new AnimationHeader(this._io, this, _root);
            this._io.seek(_pos);
            return this.header;
        }
        private long animIndex;
        private Mdl _root;
        private Mdl _parent;
        public long animIndex() { return animIndex; }
        public Mdl _root() { return _root; }
        public Mdl _parent() { return _parent; }
    }

    /**
     * Model header (196 bytes) starting at offset 12 (data_start).
     * This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
     * model-wide metadata, offsets, and counts.
     */
    public static class ModelHeader extends KaitaiStruct {
        public static ModelHeader fromFile(String fileName) throws IOException {
            return new ModelHeader(new ByteBufferKaitaiStream(fileName));
        }

        public ModelHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ModelHeader(KaitaiStream _io, Mdl _parent) {
            this(_io, _parent, null);
        }

        public ModelHeader(KaitaiStream _io, Mdl _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.geometry = new GeometryHeader(this._io, this, _root);
            this.modelType = BiowareMdlCommon.ModelClassification.byId(this._io.readU1());
            this.unknown0 = this._io.readU1();
            this.padding0 = this._io.readU1();
            this.fog = this._io.readU1();
            this.unknown1 = this._io.readU4le();
            this.offsetToAnimations = this._io.readU4le();
            this.animationCount = this._io.readU4le();
            this.animationCount2 = this._io.readU4le();
            this.unknown2 = this._io.readU4le();
            this.boundingBoxMin = new Vec3f(this._io, this, _root);
            this.boundingBoxMax = new Vec3f(this._io, this, _root);
            this.radius = this._io.readF4le();
            this.animationScale = this._io.readF4le();
            this.supermodelName = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.offsetToSuperRoot = this._io.readU4le();
            this.unknown3 = this._io.readU4le();
            this.mdxDataSize = this._io.readU4le();
            this.mdxDataOffset = this._io.readU4le();
            this.offsetToNameOffsets = this._io.readU4le();
            this.nameOffsetsCount = this._io.readU4le();
            this.nameOffsetsCount2 = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.geometry._fetchInstances();
            this.boundingBoxMin._fetchInstances();
            this.boundingBoxMax._fetchInstances();
        }
        private GeometryHeader geometry;
        private BiowareMdlCommon.ModelClassification modelType;
        private int unknown0;
        private int padding0;
        private int fog;
        private long unknown1;
        private long offsetToAnimations;
        private long animationCount;
        private long animationCount2;
        private long unknown2;
        private Vec3f boundingBoxMin;
        private Vec3f boundingBoxMax;
        private float radius;
        private float animationScale;
        private String supermodelName;
        private long offsetToSuperRoot;
        private long unknown3;
        private long mdxDataSize;
        private long mdxDataOffset;
        private long offsetToNameOffsets;
        private long nameOffsetsCount;
        private long nameOffsetsCount2;
        private Mdl _root;
        private Mdl _parent;

        /**
         * Geometry header (80 bytes)
         */
        public GeometryHeader geometry() { return geometry; }

        /**
         * Model classification byte
         */
        public BiowareMdlCommon.ModelClassification modelType() { return modelType; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public int unknown0() { return unknown0; }

        /**
         * Padding byte
         */
        public int padding0() { return padding0; }

        /**
         * Fog interaction (1 = affected, 0 = ignore fog)
         */
        public int fog() { return fog; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public long unknown1() { return unknown1; }

        /**
         * Offset to animation offset array (relative to data_start)
         */
        public long offsetToAnimations() { return offsetToAnimations; }

        /**
         * Number of animations
         */
        public long animationCount() { return animationCount; }

        /**
         * Duplicate animation count / allocated count
         */
        public long animationCount2() { return animationCount2; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public long unknown2() { return unknown2; }

        /**
         * Minimum coordinates of bounding box (X, Y, Z)
         */
        public Vec3f boundingBoxMin() { return boundingBoxMin; }

        /**
         * Maximum coordinates of bounding box (X, Y, Z)
         */
        public Vec3f boundingBoxMax() { return boundingBoxMax; }

        /**
         * Radius of model's bounding sphere
         */
        public float radius() { return radius; }

        /**
         * Scale factor for animations (typically 1.0)
         */
        public float animationScale() { return animationScale; }

        /**
         * Name of supermodel (null-terminated string, "null" if empty)
         */
        public String supermodelName() { return supermodelName; }

        /**
         * TODO: VERIFY - offset to super-root node (relative to data_start)
         */
        public long offsetToSuperRoot() { return offsetToSuperRoot; }

        /**
         * TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
         */
        public long unknown3() { return unknown3; }

        /**
         * Size of MDX file data in bytes
         */
        public long mdxDataSize() { return mdxDataSize; }

        /**
         * Offset to MDX data (typically 0)
         */
        public long mdxDataOffset() { return mdxDataOffset; }

        /**
         * Offset to name offset array (relative to data_start)
         */
        public long offsetToNameOffsets() { return offsetToNameOffsets; }

        /**
         * Count of name offsets / partnames
         */
        public long nameOffsetsCount() { return nameOffsetsCount; }

        /**
         * Duplicate name offsets count / allocated count
         */
        public long nameOffsetsCount2() { return nameOffsetsCount2; }
        public Mdl _root() { return _root; }
        public Mdl _parent() { return _parent; }
    }

    /**
     * Array of null-terminated name strings
     */
    public static class NameStrings extends KaitaiStruct {
        public static NameStrings fromFile(String fileName) throws IOException {
            return new NameStrings(new ByteBufferKaitaiStream(fileName));
        }

        public NameStrings(KaitaiStream _io) {
            this(_io, null, null);
        }

        public NameStrings(KaitaiStream _io, Mdl _parent) {
            this(_io, _parent, null);
        }

        public NameStrings(KaitaiStream _io, Mdl _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.strings = new ArrayList<String>();
            {
                int i = 0;
                while (!this._io.isEof()) {
                    this.strings.add(new String(this._io.readBytesTerm((byte) 0, false, true, true), StandardCharsets.US_ASCII));
                    i++;
                }
            }
        }

        public void _fetchInstances() {
            for (int i = 0; i < this.strings.size(); i++) {
            }
        }
        private List<String> strings;
        private Mdl _root;
        private Mdl _parent;
        public List<String> strings() { return strings; }
        public Mdl _root() { return _root; }
        public Mdl _parent() { return _parent; }
    }

    /**
     * Node structure - starts with 80-byte header, followed by type-specific sub-header
     */
    public static class Node extends KaitaiStruct {
        public static Node fromFile(String fileName) throws IOException {
            return new Node(new ByteBufferKaitaiStream(fileName));
        }

        public Node(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Node(KaitaiStream _io, Mdl _parent) {
            this(_io, _parent, null);
        }

        public Node(KaitaiStream _io, Mdl _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.header = new NodeHeader(this._io, this, _root);
            if (header().nodeType() == 3) {
                this.lightSubHeader = new LightHeader(this._io, this, _root);
            }
            if (header().nodeType() == 5) {
                this.emitterSubHeader = new EmitterHeader(this._io, this, _root);
            }
            if (header().nodeType() == 17) {
                this.referenceSubHeader = new ReferenceHeader(this._io, this, _root);
            }
            if (header().nodeType() == 33) {
                this.trimeshSubHeader = new TrimeshHeader(this._io, this, _root);
            }
            if (header().nodeType() == 97) {
                this.skinmeshSubHeader = new SkinmeshHeader(this._io, this, _root);
            }
            if (header().nodeType() == 161) {
                this.animmeshSubHeader = new AnimmeshHeader(this._io, this, _root);
            }
            if (header().nodeType() == 289) {
                this.danglymeshSubHeader = new DanglymeshHeader(this._io, this, _root);
            }
            if (header().nodeType() == 545) {
                this.aabbSubHeader = new AabbHeader(this._io, this, _root);
            }
            if (header().nodeType() == 2081) {
                this.lightsaberSubHeader = new LightsaberHeader(this._io, this, _root);
            }
        }

        public void _fetchInstances() {
            this.header._fetchInstances();
            if (header().nodeType() == 3) {
                this.lightSubHeader._fetchInstances();
            }
            if (header().nodeType() == 5) {
                this.emitterSubHeader._fetchInstances();
            }
            if (header().nodeType() == 17) {
                this.referenceSubHeader._fetchInstances();
            }
            if (header().nodeType() == 33) {
                this.trimeshSubHeader._fetchInstances();
            }
            if (header().nodeType() == 97) {
                this.skinmeshSubHeader._fetchInstances();
            }
            if (header().nodeType() == 161) {
                this.animmeshSubHeader._fetchInstances();
            }
            if (header().nodeType() == 289) {
                this.danglymeshSubHeader._fetchInstances();
            }
            if (header().nodeType() == 545) {
                this.aabbSubHeader._fetchInstances();
            }
            if (header().nodeType() == 2081) {
                this.lightsaberSubHeader._fetchInstances();
            }
        }
        private NodeHeader header;
        private LightHeader lightSubHeader;
        private EmitterHeader emitterSubHeader;
        private ReferenceHeader referenceSubHeader;
        private TrimeshHeader trimeshSubHeader;
        private SkinmeshHeader skinmeshSubHeader;
        private AnimmeshHeader animmeshSubHeader;
        private DanglymeshHeader danglymeshSubHeader;
        private AabbHeader aabbSubHeader;
        private LightsaberHeader lightsaberSubHeader;
        private Mdl _root;
        private Mdl _parent;
        public NodeHeader header() { return header; }
        public LightHeader lightSubHeader() { return lightSubHeader; }
        public EmitterHeader emitterSubHeader() { return emitterSubHeader; }
        public ReferenceHeader referenceSubHeader() { return referenceSubHeader; }
        public TrimeshHeader trimeshSubHeader() { return trimeshSubHeader; }
        public SkinmeshHeader skinmeshSubHeader() { return skinmeshSubHeader; }
        public AnimmeshHeader animmeshSubHeader() { return animmeshSubHeader; }
        public DanglymeshHeader danglymeshSubHeader() { return danglymeshSubHeader; }
        public AabbHeader aabbSubHeader() { return aabbSubHeader; }
        public LightsaberHeader lightsaberSubHeader() { return lightsaberSubHeader; }
        public Mdl _root() { return _root; }
        public Mdl _parent() { return _parent; }
    }

    /**
     * Node header (80 bytes) - present in all node types
     */
    public static class NodeHeader extends KaitaiStruct {
        public static NodeHeader fromFile(String fileName) throws IOException {
            return new NodeHeader(new ByteBufferKaitaiStream(fileName));
        }

        public NodeHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public NodeHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public NodeHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.nodeType = this._io.readU2le();
            this.nodeIndex = this._io.readU2le();
            this.nodeNameIndex = this._io.readU2le();
            this.padding = this._io.readU2le();
            this.rootNodeOffset = this._io.readU4le();
            this.parentNodeOffset = this._io.readU4le();
            this.position = new Vec3f(this._io, this, _root);
            this.orientation = new Quaternion(this._io, this, _root);
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

        public void _fetchInstances() {
            this.position._fetchInstances();
            this.orientation._fetchInstances();
        }
        private Boolean hasAabb;
        public Boolean hasAabb() {
            if (this.hasAabb != null)
                return this.hasAabb;
            this.hasAabb = (nodeType() & 512) != 0;
            return this.hasAabb;
        }
        private Boolean hasAnim;
        public Boolean hasAnim() {
            if (this.hasAnim != null)
                return this.hasAnim;
            this.hasAnim = (nodeType() & 128) != 0;
            return this.hasAnim;
        }
        private Boolean hasDangly;
        public Boolean hasDangly() {
            if (this.hasDangly != null)
                return this.hasDangly;
            this.hasDangly = (nodeType() & 256) != 0;
            return this.hasDangly;
        }
        private Boolean hasEmitter;
        public Boolean hasEmitter() {
            if (this.hasEmitter != null)
                return this.hasEmitter;
            this.hasEmitter = (nodeType() & 4) != 0;
            return this.hasEmitter;
        }
        private Boolean hasLight;
        public Boolean hasLight() {
            if (this.hasLight != null)
                return this.hasLight;
            this.hasLight = (nodeType() & 2) != 0;
            return this.hasLight;
        }
        private Boolean hasMesh;
        public Boolean hasMesh() {
            if (this.hasMesh != null)
                return this.hasMesh;
            this.hasMesh = (nodeType() & 32) != 0;
            return this.hasMesh;
        }
        private Boolean hasReference;
        public Boolean hasReference() {
            if (this.hasReference != null)
                return this.hasReference;
            this.hasReference = (nodeType() & 16) != 0;
            return this.hasReference;
        }
        private Boolean hasSaber;
        public Boolean hasSaber() {
            if (this.hasSaber != null)
                return this.hasSaber;
            this.hasSaber = (nodeType() & 2048) != 0;
            return this.hasSaber;
        }
        private Boolean hasSkin;
        public Boolean hasSkin() {
            if (this.hasSkin != null)
                return this.hasSkin;
            this.hasSkin = (nodeType() & 64) != 0;
            return this.hasSkin;
        }
        private int nodeType;
        private int nodeIndex;
        private int nodeNameIndex;
        private int padding;
        private long rootNodeOffset;
        private long parentNodeOffset;
        private Vec3f position;
        private Quaternion orientation;
        private long childArrayOffset;
        private long childCount;
        private long childCountDuplicate;
        private long controllerArrayOffset;
        private long controllerCount;
        private long controllerCountDuplicate;
        private long controllerDataOffset;
        private long controllerDataCount;
        private long controllerDataCountDuplicate;
        private Mdl _root;
        private Mdl.Node _parent;

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
        public int nodeType() { return nodeType; }

        /**
         * Sequential index of this node in the model
         */
        public int nodeIndex() { return nodeIndex; }

        /**
         * Index into names array for this node's name
         */
        public int nodeNameIndex() { return nodeNameIndex; }

        /**
         * Padding for alignment
         */
        public int padding() { return padding; }

        /**
         * Offset to model's root node
         */
        public long rootNodeOffset() { return rootNodeOffset; }

        /**
         * Offset to this node's parent node (0 if root)
         */
        public long parentNodeOffset() { return parentNodeOffset; }

        /**
         * Node position in local space (X, Y, Z)
         */
        public Vec3f position() { return position; }

        /**
         * Node orientation as quaternion (W, X, Y, Z)
         */
        public Quaternion orientation() { return orientation; }

        /**
         * Offset to array of child node offsets
         */
        public long childArrayOffset() { return childArrayOffset; }

        /**
         * Number of child nodes
         */
        public long childCount() { return childCount; }

        /**
         * Duplicate value of child count
         */
        public long childCountDuplicate() { return childCountDuplicate; }

        /**
         * Offset to array of controller structures
         */
        public long controllerArrayOffset() { return controllerArrayOffset; }

        /**
         * Number of controllers attached to this node
         */
        public long controllerCount() { return controllerCount; }

        /**
         * Duplicate value of controller count
         */
        public long controllerCountDuplicate() { return controllerCountDuplicate; }

        /**
         * Offset to controller keyframe/data array
         */
        public long controllerDataOffset() { return controllerDataOffset; }

        /**
         * Number of floats in controller data array
         */
        public long controllerDataCount() { return controllerDataCount; }

        /**
         * Duplicate value of controller data count
         */
        public long controllerDataCountDuplicate() { return controllerDataCountDuplicate; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Quaternion rotation (4 floats W, X, Y, Z)
     */
    public static class Quaternion extends KaitaiStruct {
        public static Quaternion fromFile(String fileName) throws IOException {
            return new Quaternion(new ByteBufferKaitaiStream(fileName));
        }

        public Quaternion(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Quaternion(KaitaiStream _io, Mdl.NodeHeader _parent) {
            this(_io, _parent, null);
        }

        public Quaternion(KaitaiStream _io, Mdl.NodeHeader _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.w = this._io.readF4le();
            this.x = this._io.readF4le();
            this.y = this._io.readF4le();
            this.z = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private float w;
        private float x;
        private float y;
        private float z;
        private Mdl _root;
        private Mdl.NodeHeader _parent;
        public float w() { return w; }
        public float x() { return x; }
        public float y() { return y; }
        public float z() { return z; }
        public Mdl _root() { return _root; }
        public Mdl.NodeHeader _parent() { return _parent; }
    }

    /**
     * Reference header (36 bytes)
     */
    public static class ReferenceHeader extends KaitaiStruct {
        public static ReferenceHeader fromFile(String fileName) throws IOException {
            return new ReferenceHeader(new ByteBufferKaitaiStream(fileName));
        }

        public ReferenceHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public ReferenceHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public ReferenceHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.modelResref = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.reattachable = this._io.readU4le();
        }

        public void _fetchInstances() {
        }
        private String modelResref;
        private long reattachable;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Referenced model resource name without extension (null-terminated string)
         */
        public String modelResref() { return modelResref; }

        /**
         * 1 if model can be detached and reattached dynamically, 0 if permanent
         */
        public long reattachable() { return reattachable; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
     */
    public static class SkinmeshHeader extends KaitaiStruct {
        public static SkinmeshHeader fromFile(String fileName) throws IOException {
            return new SkinmeshHeader(new ByteBufferKaitaiStream(fileName));
        }

        public SkinmeshHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public SkinmeshHeader(KaitaiStream _io, Mdl.Node _parent) {
            this(_io, _parent, null);
        }

        public SkinmeshHeader(KaitaiStream _io, Mdl.Node _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.trimeshBase = new TrimeshHeader(this._io, this, _root);
            this.unknownWeights = this._io.readS4le();
            this.padding1 = new ArrayList<Integer>();
            for (int i = 0; i < 8; i++) {
                this.padding1.add(this._io.readU1());
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
            this.boneNodeSerialNumbers = new ArrayList<Integer>();
            for (int i = 0; i < 16; i++) {
                this.boneNodeSerialNumbers.add(this._io.readU2le());
            }
            this.padding2 = this._io.readU2le();
        }

        public void _fetchInstances() {
            this.trimeshBase._fetchInstances();
            for (int i = 0; i < this.padding1.size(); i++) {
            }
            for (int i = 0; i < this.boneNodeSerialNumbers.size(); i++) {
            }
        }
        private TrimeshHeader trimeshBase;
        private int unknownWeights;
        private List<Integer> padding1;
        private long mdxBoneWeightsOffset;
        private long mdxBoneIndicesOffset;
        private long boneMapOffset;
        private long boneMapCount;
        private long qbonesOffset;
        private long qbonesCount;
        private long qbonesCountDuplicate;
        private long tbonesOffset;
        private long tbonesCount;
        private long tbonesCountDuplicate;
        private long unknownArray;
        private List<Integer> boneNodeSerialNumbers;
        private int padding2;
        private Mdl _root;
        private Mdl.Node _parent;

        /**
         * Standard trimesh header
         */
        public TrimeshHeader trimeshBase() { return trimeshBase; }

        /**
         * Purpose unknown (possibly compilation weights)
         */
        public int unknownWeights() { return unknownWeights; }

        /**
         * Padding
         */
        public List<Integer> padding1() { return padding1; }

        /**
         * Offset to bone weight data in MDX file (4 floats per vertex)
         */
        public long mdxBoneWeightsOffset() { return mdxBoneWeightsOffset; }

        /**
         * Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
         */
        public long mdxBoneIndicesOffset() { return mdxBoneIndicesOffset; }

        /**
         * Offset to bone map array (maps local bone indices to skeleton bone numbers)
         */
        public long boneMapOffset() { return boneMapOffset; }

        /**
         * Number of bones referenced by this mesh (max 16)
         */
        public long boneMapCount() { return boneMapCount; }

        /**
         * Offset to quaternion bind pose array (4 floats per bone)
         */
        public long qbonesOffset() { return qbonesOffset; }

        /**
         * Number of quaternion bind poses
         */
        public long qbonesCount() { return qbonesCount; }

        /**
         * Duplicate of QBones count
         */
        public long qbonesCountDuplicate() { return qbonesCountDuplicate; }

        /**
         * Offset to translation bind pose array (3 floats per bone)
         */
        public long tbonesOffset() { return tbonesOffset; }

        /**
         * Number of translation bind poses
         */
        public long tbonesCount() { return tbonesCount; }

        /**
         * Duplicate of TBones count
         */
        public long tbonesCountDuplicate() { return tbonesCountDuplicate; }

        /**
         * Purpose unknown
         */
        public long unknownArray() { return unknownArray; }

        /**
         * Serial indices of bone nodes (0xFFFF for unused slots)
         */
        public List<Integer> boneNodeSerialNumbers() { return boneNodeSerialNumbers; }

        /**
         * Padding for alignment
         */
        public int padding2() { return padding2; }
        public Mdl _root() { return _root; }
        public Mdl.Node _parent() { return _parent; }
    }

    /**
     * Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
     */
    public static class TrimeshHeader extends KaitaiStruct {
        public static TrimeshHeader fromFile(String fileName) throws IOException {
            return new TrimeshHeader(new ByteBufferKaitaiStream(fileName));
        }

        public TrimeshHeader(KaitaiStream _io) {
            this(_io, null, null);
        }

        public TrimeshHeader(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public TrimeshHeader(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.functionPointer0 = this._io.readU4le();
            this.functionPointer1 = this._io.readU4le();
            this.facesArrayOffset = this._io.readU4le();
            this.facesCount = this._io.readU4le();
            this.facesCountDuplicate = this._io.readU4le();
            this.boundingBoxMin = new Vec3f(this._io, this, _root);
            this.boundingBoxMax = new Vec3f(this._io, this, _root);
            this.radius = this._io.readF4le();
            this.averagePoint = new Vec3f(this._io, this, _root);
            this.diffuseColor = new Vec3f(this._io, this, _root);
            this.ambientColor = new Vec3f(this._io, this, _root);
            this.transparencyHint = this._io.readU4le();
            this.texture0Name = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.texture1Name = new String(KaitaiStream.bytesTerminate(this._io.readBytes(32), (byte) 0, false), StandardCharsets.US_ASCII);
            this.texture2Name = new String(KaitaiStream.bytesTerminate(this._io.readBytes(12), (byte) 0, false), StandardCharsets.US_ASCII);
            this.texture3Name = new String(KaitaiStream.bytesTerminate(this._io.readBytes(12), (byte) 0, false), StandardCharsets.US_ASCII);
            this.indicesCountArrayOffset = this._io.readU4le();
            this.indicesCountArrayCount = this._io.readU4le();
            this.indicesCountArrayCountDuplicate = this._io.readU4le();
            this.indicesOffsetArrayOffset = this._io.readU4le();
            this.indicesOffsetArrayCount = this._io.readU4le();
            this.indicesOffsetArrayCountDuplicate = this._io.readU4le();
            this.invertedCounterArrayOffset = this._io.readU4le();
            this.invertedCounterArrayCount = this._io.readU4le();
            this.invertedCounterArrayCountDuplicate = this._io.readU4le();
            this.unknownValues = new ArrayList<Integer>();
            for (int i = 0; i < 3; i++) {
                this.unknownValues.add(this._io.readS4le());
            }
            this.saberUnknownData = new ArrayList<Integer>();
            for (int i = 0; i < 8; i++) {
                this.saberUnknownData.add(this._io.readU1());
            }
            this.unknown = this._io.readU4le();
            this.uvDirection = new Vec3f(this._io, this, _root);
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
            if (_root().modelHeader().geometry().isKotor2()) {
                this.k2Unknown1 = this._io.readU4le();
            }
            if (_root().modelHeader().geometry().isKotor2()) {
                this.k2Unknown2 = this._io.readU4le();
            }
            this.mdxDataOffset = this._io.readU4le();
            this.mdlVerticesOffset = this._io.readU4le();
        }

        public void _fetchInstances() {
            this.boundingBoxMin._fetchInstances();
            this.boundingBoxMax._fetchInstances();
            this.averagePoint._fetchInstances();
            this.diffuseColor._fetchInstances();
            this.ambientColor._fetchInstances();
            for (int i = 0; i < this.unknownValues.size(); i++) {
            }
            for (int i = 0; i < this.saberUnknownData.size(); i++) {
            }
            this.uvDirection._fetchInstances();
            if (_root().modelHeader().geometry().isKotor2()) {
            }
            if (_root().modelHeader().geometry().isKotor2()) {
            }
        }
        private long functionPointer0;
        private long functionPointer1;
        private long facesArrayOffset;
        private long facesCount;
        private long facesCountDuplicate;
        private Vec3f boundingBoxMin;
        private Vec3f boundingBoxMax;
        private float radius;
        private Vec3f averagePoint;
        private Vec3f diffuseColor;
        private Vec3f ambientColor;
        private long transparencyHint;
        private String texture0Name;
        private String texture1Name;
        private String texture2Name;
        private String texture3Name;
        private long indicesCountArrayOffset;
        private long indicesCountArrayCount;
        private long indicesCountArrayCountDuplicate;
        private long indicesOffsetArrayOffset;
        private long indicesOffsetArrayCount;
        private long indicesOffsetArrayCountDuplicate;
        private long invertedCounterArrayOffset;
        private long invertedCounterArrayCount;
        private long invertedCounterArrayCountDuplicate;
        private List<Integer> unknownValues;
        private List<Integer> saberUnknownData;
        private long unknown;
        private Vec3f uvDirection;
        private float uvJitter;
        private float uvJitterSpeed;
        private long mdxVertexSize;
        private long mdxDataFlags;
        private int mdxVerticesOffset;
        private int mdxNormalsOffset;
        private int mdxVertexColorsOffset;
        private int mdxTex0UvsOffset;
        private int mdxTex1UvsOffset;
        private int mdxTex2UvsOffset;
        private int mdxTex3UvsOffset;
        private int mdxTangentSpaceOffset;
        private int mdxUnknownOffset1;
        private int mdxUnknownOffset2;
        private int mdxUnknownOffset3;
        private int vertexCount;
        private int textureCount;
        private int lightmapped;
        private int rotateTexture;
        private int backgroundGeometry;
        private int shadow;
        private int beaming;
        private int render;
        private int unknownFlag;
        private int padding;
        private float totalArea;
        private long unknown2;
        private Long k2Unknown1;
        private Long k2Unknown2;
        private long mdxDataOffset;
        private long mdlVerticesOffset;
        private Mdl _root;
        private KaitaiStruct _parent;

        /**
         * Game engine function pointer (version-specific)
         */
        public long functionPointer0() { return functionPointer0; }

        /**
         * Secondary game engine function pointer
         */
        public long functionPointer1() { return functionPointer1; }

        /**
         * Offset to face definitions array
         */
        public long facesArrayOffset() { return facesArrayOffset; }

        /**
         * Number of triangular faces in mesh
         */
        public long facesCount() { return facesCount; }

        /**
         * Duplicate of faces count
         */
        public long facesCountDuplicate() { return facesCountDuplicate; }

        /**
         * Minimum bounding box coordinates (X, Y, Z)
         */
        public Vec3f boundingBoxMin() { return boundingBoxMin; }

        /**
         * Maximum bounding box coordinates (X, Y, Z)
         */
        public Vec3f boundingBoxMax() { return boundingBoxMax; }

        /**
         * Bounding sphere radius
         */
        public float radius() { return radius; }

        /**
         * Average vertex position (centroid) X, Y, Z
         */
        public Vec3f averagePoint() { return averagePoint; }

        /**
         * Material diffuse color (R, G, B, range 0.0-1.0)
         */
        public Vec3f diffuseColor() { return diffuseColor; }

        /**
         * Material ambient color (R, G, B, range 0.0-1.0)
         */
        public Vec3f ambientColor() { return ambientColor; }

        /**
         * Transparency rendering mode
         */
        public long transparencyHint() { return transparencyHint; }

        /**
         * Primary diffuse texture name (null-terminated string)
         */
        public String texture0Name() { return texture0Name; }

        /**
         * Secondary texture name, often lightmap (null-terminated string)
         */
        public String texture1Name() { return texture1Name; }

        /**
         * Tertiary texture name (null-terminated string)
         */
        public String texture2Name() { return texture2Name; }

        /**
         * Quaternary texture name (null-terminated string)
         */
        public String texture3Name() { return texture3Name; }

        /**
         * Offset to vertex indices count array
         */
        public long indicesCountArrayOffset() { return indicesCountArrayOffset; }

        /**
         * Number of entries in indices count array
         */
        public long indicesCountArrayCount() { return indicesCountArrayCount; }

        /**
         * Duplicate of indices count array count
         */
        public long indicesCountArrayCountDuplicate() { return indicesCountArrayCountDuplicate; }

        /**
         * Offset to vertex indices offset array
         */
        public long indicesOffsetArrayOffset() { return indicesOffsetArrayOffset; }

        /**
         * Number of entries in indices offset array
         */
        public long indicesOffsetArrayCount() { return indicesOffsetArrayCount; }

        /**
         * Duplicate of indices offset array count
         */
        public long indicesOffsetArrayCountDuplicate() { return indicesOffsetArrayCountDuplicate; }

        /**
         * Offset to inverted counter array
         */
        public long invertedCounterArrayOffset() { return invertedCounterArrayOffset; }

        /**
         * Number of entries in inverted counter array
         */
        public long invertedCounterArrayCount() { return invertedCounterArrayCount; }

        /**
         * Duplicate of inverted counter array count
         */
        public long invertedCounterArrayCountDuplicate() { return invertedCounterArrayCountDuplicate; }

        /**
         * Typically {-1, -1, 0}, purpose unknown
         */
        public List<Integer> unknownValues() { return unknownValues; }

        /**
         * Data specific to lightsaber meshes
         */
        public List<Integer> saberUnknownData() { return saberUnknownData; }

        /**
         * Purpose unknown
         */
        public long unknown() { return unknown; }

        /**
         * UV animation direction X, Y components (Z = jitter speed)
         */
        public Vec3f uvDirection() { return uvDirection; }

        /**
         * UV animation jitter amount
         */
        public float uvJitter() { return uvJitter; }

        /**
         * UV animation jitter speed
         */
        public float uvJitterSpeed() { return uvJitterSpeed; }

        /**
         * Size in bytes of each vertex in MDX data
         */
        public long mdxVertexSize() { return mdxVertexSize; }

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
        public long mdxDataFlags() { return mdxDataFlags; }

        /**
         * Relative offset to vertex positions in MDX (or -1 if none)
         */
        public int mdxVerticesOffset() { return mdxVerticesOffset; }

        /**
         * Relative offset to vertex normals in MDX (or -1 if none)
         */
        public int mdxNormalsOffset() { return mdxNormalsOffset; }

        /**
         * Relative offset to vertex colors in MDX (or -1 if none)
         */
        public int mdxVertexColorsOffset() { return mdxVertexColorsOffset; }

        /**
         * Relative offset to primary texture UVs in MDX (or -1 if none)
         */
        public int mdxTex0UvsOffset() { return mdxTex0UvsOffset; }

        /**
         * Relative offset to secondary texture UVs in MDX (or -1 if none)
         */
        public int mdxTex1UvsOffset() { return mdxTex1UvsOffset; }

        /**
         * Relative offset to tertiary texture UVs in MDX (or -1 if none)
         */
        public int mdxTex2UvsOffset() { return mdxTex2UvsOffset; }

        /**
         * Relative offset to quaternary texture UVs in MDX (or -1 if none)
         */
        public int mdxTex3UvsOffset() { return mdxTex3UvsOffset; }

        /**
         * Relative offset to tangent space data in MDX (or -1 if none)
         */
        public int mdxTangentSpaceOffset() { return mdxTangentSpaceOffset; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public int mdxUnknownOffset1() { return mdxUnknownOffset1; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public int mdxUnknownOffset2() { return mdxUnknownOffset2; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public int mdxUnknownOffset3() { return mdxUnknownOffset3; }

        /**
         * Number of vertices in mesh
         */
        public int vertexCount() { return vertexCount; }

        /**
         * Number of textures used by mesh
         */
        public int textureCount() { return textureCount; }

        /**
         * 1 if mesh uses lightmap, 0 otherwise
         */
        public int lightmapped() { return lightmapped; }

        /**
         * 1 if texture should rotate, 0 otherwise
         */
        public int rotateTexture() { return rotateTexture; }

        /**
         * 1 if background geometry, 0 otherwise
         */
        public int backgroundGeometry() { return backgroundGeometry; }

        /**
         * 1 if mesh casts shadows, 0 otherwise
         */
        public int shadow() { return shadow; }

        /**
         * 1 if beaming effect enabled, 0 otherwise
         */
        public int beaming() { return beaming; }

        /**
         * 1 if mesh is renderable, 0 if hidden
         */
        public int render() { return render; }

        /**
         * Purpose unknown (possibly UV animation enable)
         */
        public int unknownFlag() { return unknownFlag; }

        /**
         * Padding byte
         */
        public int padding() { return padding; }

        /**
         * Total surface area of all faces
         */
        public float totalArea() { return totalArea; }

        /**
         * Purpose unknown
         */
        public long unknown2() { return unknown2; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        public Long k2Unknown1() { return k2Unknown1; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        public Long k2Unknown2() { return k2Unknown2; }

        /**
         * Absolute offset to this mesh's vertex data in MDX file
         */
        public long mdxDataOffset() { return mdxDataOffset; }

        /**
         * Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
         */
        public long mdlVerticesOffset() { return mdlVerticesOffset; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }

    /**
     * 3D vector (3 floats)
     */
    public static class Vec3f extends KaitaiStruct {
        public static Vec3f fromFile(String fileName) throws IOException {
            return new Vec3f(new ByteBufferKaitaiStream(fileName));
        }

        public Vec3f(KaitaiStream _io) {
            this(_io, null, null);
        }

        public Vec3f(KaitaiStream _io, KaitaiStruct _parent) {
            this(_io, _parent, null);
        }

        public Vec3f(KaitaiStream _io, KaitaiStruct _parent, Mdl _root) {
            super(_io);
            this._parent = _parent;
            this._root = _root;
            _read();
        }
        private void _read() {
            this.x = this._io.readF4le();
            this.y = this._io.readF4le();
            this.z = this._io.readF4le();
        }

        public void _fetchInstances() {
        }
        private float x;
        private float y;
        private float z;
        private Mdl _root;
        private KaitaiStruct _parent;
        public float x() { return x; }
        public float y() { return y; }
        public float z() { return z; }
        public Mdl _root() { return _root; }
        public KaitaiStruct _parent() { return _parent; }
    }
    private List<Long> animationOffsets;

    /**
     * Animation header offsets (relative to data_start)
     */
    public List<Long> animationOffsets() {
        if (this.animationOffsets != null)
            return this.animationOffsets;
        if (modelHeader().animationCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(dataStart() + modelHeader().offsetToAnimations());
            this.animationOffsets = new ArrayList<Long>();
            for (int i = 0; i < modelHeader().animationCount(); i++) {
                this.animationOffsets.add(this._io.readU4le());
            }
            this._io.seek(_pos);
        }
        return this.animationOffsets;
    }
    private List<MdlAnimationEntry> animations;

    /**
     * Animation headers (via offset table). Each list element is `mdl_animation_entry`;
     * the parsed header is `element.header` (same wire layout as `animation_header`).
     */
    public List<MdlAnimationEntry> animations() {
        if (this.animations != null)
            return this.animations;
        if (modelHeader().animationCount() > 0) {
            this.animations = new ArrayList<MdlAnimationEntry>();
            for (int i = 0; i < modelHeader().animationCount(); i++) {
                this.animations.add(new MdlAnimationEntry(this._io, this, _root, i));
            }
        }
        return this.animations;
    }
    private Byte dataStart;

    /**
     * MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
     * section, which begins immediately after the 12-byte file header.
     */
    public Byte dataStart() {
        if (this.dataStart != null)
            return this.dataStart;
        this.dataStart = ((byte) 12);
        return this.dataStart;
    }
    private List<Long> nameOffsets;

    /**
     * Name string offsets (relative to data_start)
     */
    public List<Long> nameOffsets() {
        if (this.nameOffsets != null)
            return this.nameOffsets;
        if (modelHeader().nameOffsetsCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek(dataStart() + modelHeader().offsetToNameOffsets());
            this.nameOffsets = new ArrayList<Long>();
            for (int i = 0; i < modelHeader().nameOffsetsCount(); i++) {
                this.nameOffsets.add(this._io.readU4le());
            }
            this._io.seek(_pos);
        }
        return this.nameOffsets;
    }
    private NameStrings namesData;

    /**
     * Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
     * Parsed as null-terminated ASCII strings in `name_strings`.
     */
    public NameStrings namesData() {
        if (this.namesData != null)
            return this.namesData;
        if (modelHeader().nameOffsetsCount() > 0) {
            long _pos = this._io.pos();
            this._io.seek((dataStart() + modelHeader().offsetToNameOffsets()) + 4 * modelHeader().nameOffsetsCount());
            KaitaiStream _io_namesData = this._io.substream((dataStart() + modelHeader().offsetToAnimations()) - ((dataStart() + modelHeader().offsetToNameOffsets()) + 4 * modelHeader().nameOffsetsCount()));
            this.namesData = new NameStrings(_io_namesData, this, _root);
            this._io.seek(_pos);
        }
        return this.namesData;
    }
    private Node rootNode;
    public Node rootNode() {
        if (this.rootNode != null)
            return this.rootNode;
        if (modelHeader().geometry().rootNodeOffset() > 0) {
            long _pos = this._io.pos();
            this._io.seek(dataStart() + modelHeader().geometry().rootNodeOffset());
            this.rootNode = new Node(this._io, this, _root);
            this._io.seek(_pos);
        }
        return this.rootNode;
    }
    private FileHeader fileHeader;
    private ModelHeader modelHeader;
    private Mdl _root;
    private KaitaiStruct _parent;
    public FileHeader fileHeader() { return fileHeader; }
    public ModelHeader modelHeader() { return modelHeader; }
    public Mdl _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}

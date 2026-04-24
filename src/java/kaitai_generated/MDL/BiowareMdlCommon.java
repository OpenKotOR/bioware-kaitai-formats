// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import io.kaitai.struct.ByteBufferKaitaiStream;
import io.kaitai.struct.KaitaiStruct;
import io.kaitai.struct.KaitaiStream;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


/**
 * Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
 * `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
 * Tooling alignment: PyKotor / MDLOps / xoreos.
 * 
 * - `model_classification` — `model_header.model_type` (`u1`).
 * - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
 * - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
 * @see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
 * @see <a href="https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/">PyKotor — MDL package</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267">xoreos — `Model_KotOR::load`</a>
 * @see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81">xoreos — `kFileTypeMDL`</a>
 * @see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview</a>
 * @see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (controller IDs)</a>
 * @see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407">Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)</a>
 */
public class BiowareMdlCommon extends KaitaiStruct {
    public static BiowareMdlCommon fromFile(String fileName) throws IOException {
        return new BiowareMdlCommon(new ByteBufferKaitaiStream(fileName));
    }

    public enum ControllerType {
        POSITION(8),
        ORIENTATION(20),
        SCALE(36),
        COLOR(76),
        EMITTER_ALPHA_END(80),
        EMITTER_ALPHA_START(84),
        RADIUS(88),
        EMITTER_BOUNCE_COEFFICIENT(92),
        SHADOW_RADIUS(96),
        VERTICAL_DISPLACEMENT_OR_DRAG_OR_SELFILLUMCOLOR(100),
        EMITTER_FPS(104),
        EMITTER_FRAME_END(108),
        EMITTER_FRAME_START(112),
        EMITTER_GRAVITY(116),
        EMITTER_LIFE_EXPECTANCY(120),
        EMITTER_MASS(124),
        ALPHA(132),
        EMITTER_PARTICLE_ROTATION(136),
        MULTIPLIER_OR_RANDVEL(140),
        EMITTER_SIZE_START(144),
        EMITTER_SIZE_END(148),
        EMITTER_SIZE_START_Y(152),
        EMITTER_SIZE_END_Y(156),
        EMITTER_SPREAD(160),
        EMITTER_THRESHOLD(164),
        EMITTER_VELOCITY(168),
        EMITTER_X_SIZE(172),
        EMITTER_Y_SIZE(176),
        EMITTER_BLUR_LENGTH(180),
        EMITTER_LIGHTNING_DELAY(184),
        EMITTER_LIGHTNING_RADIUS(188),
        EMITTER_LIGHTNING_SCALE(192),
        EMITTER_LIGHTNING_SUBDIVIDE(196),
        EMITTER_LIGHTNING_ZIG_ZAG(200),
        EMITTER_ALPHA_MID(216),
        EMITTER_PERCENT_START(220),
        EMITTER_PERCENT_MID(224),
        EMITTER_PERCENT_END(228),
        EMITTER_SIZE_MID(232),
        EMITTER_SIZE_MID_Y(236),
        EMITTER_RANDOM_BIRTH_RATE(240),
        EMITTER_TARGET_SIZE(252),
        EMITTER_NUM_CONTROL_POINTS(256),
        EMITTER_CONTROL_POINT_RADIUS(260),
        EMITTER_CONTROL_POINT_DELAY(264),
        EMITTER_TANGENT_SPREAD(268),
        EMITTER_TANGENT_LENGTH(272),
        EMITTER_COLOR_MID(284),
        EMITTER_COLOR_END(380),
        EMITTER_COLOR_START(392),
        EMITTER_DETONATE(502);

        private final long id;
        ControllerType(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ControllerType> byId = new HashMap<Long, ControllerType>(51);
        static {
            for (ControllerType e : ControllerType.values())
                byId.put(e.id(), e);
        }
        public static ControllerType byId(long id) { return byId.get(id); }
    }

    public enum ModelClassification {
        OTHER(0),
        EFFECT(1),
        TILE(2),
        CHARACTER(4),
        DOOR(8),
        LIGHTSABER(16),
        PLACEABLE(32),
        FLYER(64);

        private final long id;
        ModelClassification(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, ModelClassification> byId = new HashMap<Long, ModelClassification>(8);
        static {
            for (ModelClassification e : ModelClassification.values())
                byId.put(e.id(), e);
        }
        public static ModelClassification byId(long id) { return byId.get(id); }
    }

    public enum NodeTypeValue {
        DUMMY(1),
        LIGHT(3),
        EMITTER(5),
        REFERENCE(17),
        TRIMESH(33),
        SKINMESH(97),
        ANIMMESH(161),
        DANGLYMESH(289),
        AABB(545),
        LIGHTSABER(2081);

        private final long id;
        NodeTypeValue(long id) { this.id = id; }
        public long id() { return id; }
        private static final Map<Long, NodeTypeValue> byId = new HashMap<Long, NodeTypeValue>(10);
        static {
            for (NodeTypeValue e : NodeTypeValue.values())
                byId.put(e.id(), e);
        }
        public static NodeTypeValue byId(long id) { return byId.get(id); }
    }

    public BiowareMdlCommon(KaitaiStream _io) {
        this(_io, null, null);
    }

    public BiowareMdlCommon(KaitaiStream _io, KaitaiStruct _parent) {
        this(_io, _parent, null);
    }

    public BiowareMdlCommon(KaitaiStream _io, KaitaiStruct _parent, BiowareMdlCommon _root) {
        super(_io);
        this._parent = _parent;
        this._root = _root == null ? this : _root;
        _read();
    }
    private void _read() {
    }

    public void _fetchInstances() {
    }
    private BiowareMdlCommon _root;
    private KaitaiStruct _parent;
    public BiowareMdlCommon _root() { return _root; }
    public KaitaiStruct _parent() { return _parent; }
}

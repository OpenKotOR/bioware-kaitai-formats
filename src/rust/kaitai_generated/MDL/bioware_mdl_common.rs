// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#![allow(unused_imports)]
#![allow(non_snake_case)]
#![allow(non_camel_case_types)]
#![allow(irrefutable_let_patterns)]
#![allow(unused_comparisons)]

extern crate kaitai;
use kaitai::*;
use std::convert::{TryFrom, TryInto};
use std::cell::{Ref, Cell, RefCell};
use std::rc::{Rc, Weak};

/**
 * Wire enums shared by `formats/MDL/MDL.ksy` (imported there as `bioware_mdl_common`; field-bound on `model_type` and
 * `controller.type`; `node_header.node_type` is a bitmask so MDL.ksy keeps it as raw `u2` and references this enum for docs).
 * Tooling alignment: PyKotor / MDLOps / xoreos.
 * 
 * - `model_classification` — `model_header.model_type` (`u1`).
 * - `node_type_value` — primary node discriminator in `node_header.node_type` (`u2`); bitmask flags on the same field are documented in MDL.ksy.
 * - `controller_type` — **partial** list of `controller.type` (`u4`) values (common KotOR / Aurora); many emitter-specific IDs exist — see PyKotor wiki + torlack `binmdl` for the full set. `formats/MDL/MDL.ksy` attaches this enum to `controller.type`; unknown numeric IDs may still appear in data and should be treated as vendor-defined extensions.
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/ PyKotor — MDL package
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — `Model_KotOR::load`
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81 xoreos — `kFileTypeMDL`
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller IDs)
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — `MDLOpsM.pm` controller name table (legacy PyKotor `vendor/MDLOps` path 404 on current default branch)
 */

#[derive(Default, Debug, Clone)]
pub struct BiowareMdlCommon {
    pub _root: SharedType<BiowareMdlCommon>,
    pub _parent: SharedType<BiowareMdlCommon>,
    pub _self: SharedType<Self>,
    _io: RefCell<BytesReader>,
}
impl KStruct for BiowareMdlCommon {
    type Root = BiowareMdlCommon;
    type Parent = BiowareMdlCommon;

    fn read<S: KStream>(
        self_rc: &OptRc<Self>,
        _io: &S,
        _root: SharedType<Self::Root>,
        _parent: SharedType<Self::Parent>,
    ) -> KResult<()> {
        *self_rc._io.borrow_mut() = _io.clone();
        self_rc._root.set(_root.get());
        self_rc._parent.set(_parent.get());
        self_rc._self.set(Ok(self_rc.clone()));
        let _rrc = self_rc._root.get_value().borrow().upgrade();
        let _prc = self_rc._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        Ok(())
    }
}
impl BiowareMdlCommon {
}
impl BiowareMdlCommon {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
#[derive(Debug, PartialEq, Clone)]
pub enum BiowareMdlCommon_ControllerType {
    Position,
    Orientation,
    Scale,
    Color,
    EmitterAlphaEnd,
    EmitterAlphaStart,
    Radius,
    EmitterBounceCoefficient,
    ShadowRadius,
    VerticalDisplacementOrDragOrSelfillumcolor,
    EmitterFps,
    EmitterFrameEnd,
    EmitterFrameStart,
    EmitterGravity,
    EmitterLifeExpectancy,
    EmitterMass,
    Alpha,
    EmitterParticleRotation,
    MultiplierOrRandvel,
    EmitterSizeStart,
    EmitterSizeEnd,
    EmitterSizeStartY,
    EmitterSizeEndY,
    EmitterSpread,
    EmitterThreshold,
    EmitterVelocity,
    EmitterXSize,
    EmitterYSize,
    EmitterBlurLength,
    EmitterLightningDelay,
    EmitterLightningRadius,
    EmitterLightningScale,
    EmitterLightningSubdivide,
    EmitterLightningZigZag,
    EmitterAlphaMid,
    EmitterPercentStart,
    EmitterPercentMid,
    EmitterPercentEnd,
    EmitterSizeMid,
    EmitterSizeMidY,
    EmitterRandomBirthRate,
    EmitterTargetSize,
    EmitterNumControlPoints,
    EmitterControlPointRadius,
    EmitterControlPointDelay,
    EmitterTangentSpread,
    EmitterTangentLength,
    EmitterColorMid,
    EmitterColorEnd,
    EmitterColorStart,
    EmitterDetonate,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareMdlCommon_ControllerType {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareMdlCommon_ControllerType> {
        match flag {
            8 => Ok(BiowareMdlCommon_ControllerType::Position),
            20 => Ok(BiowareMdlCommon_ControllerType::Orientation),
            36 => Ok(BiowareMdlCommon_ControllerType::Scale),
            76 => Ok(BiowareMdlCommon_ControllerType::Color),
            80 => Ok(BiowareMdlCommon_ControllerType::EmitterAlphaEnd),
            84 => Ok(BiowareMdlCommon_ControllerType::EmitterAlphaStart),
            88 => Ok(BiowareMdlCommon_ControllerType::Radius),
            92 => Ok(BiowareMdlCommon_ControllerType::EmitterBounceCoefficient),
            96 => Ok(BiowareMdlCommon_ControllerType::ShadowRadius),
            100 => Ok(BiowareMdlCommon_ControllerType::VerticalDisplacementOrDragOrSelfillumcolor),
            104 => Ok(BiowareMdlCommon_ControllerType::EmitterFps),
            108 => Ok(BiowareMdlCommon_ControllerType::EmitterFrameEnd),
            112 => Ok(BiowareMdlCommon_ControllerType::EmitterFrameStart),
            116 => Ok(BiowareMdlCommon_ControllerType::EmitterGravity),
            120 => Ok(BiowareMdlCommon_ControllerType::EmitterLifeExpectancy),
            124 => Ok(BiowareMdlCommon_ControllerType::EmitterMass),
            132 => Ok(BiowareMdlCommon_ControllerType::Alpha),
            136 => Ok(BiowareMdlCommon_ControllerType::EmitterParticleRotation),
            140 => Ok(BiowareMdlCommon_ControllerType::MultiplierOrRandvel),
            144 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeStart),
            148 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeEnd),
            152 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeStartY),
            156 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeEndY),
            160 => Ok(BiowareMdlCommon_ControllerType::EmitterSpread),
            164 => Ok(BiowareMdlCommon_ControllerType::EmitterThreshold),
            168 => Ok(BiowareMdlCommon_ControllerType::EmitterVelocity),
            172 => Ok(BiowareMdlCommon_ControllerType::EmitterXSize),
            176 => Ok(BiowareMdlCommon_ControllerType::EmitterYSize),
            180 => Ok(BiowareMdlCommon_ControllerType::EmitterBlurLength),
            184 => Ok(BiowareMdlCommon_ControllerType::EmitterLightningDelay),
            188 => Ok(BiowareMdlCommon_ControllerType::EmitterLightningRadius),
            192 => Ok(BiowareMdlCommon_ControllerType::EmitterLightningScale),
            196 => Ok(BiowareMdlCommon_ControllerType::EmitterLightningSubdivide),
            200 => Ok(BiowareMdlCommon_ControllerType::EmitterLightningZigZag),
            216 => Ok(BiowareMdlCommon_ControllerType::EmitterAlphaMid),
            220 => Ok(BiowareMdlCommon_ControllerType::EmitterPercentStart),
            224 => Ok(BiowareMdlCommon_ControllerType::EmitterPercentMid),
            228 => Ok(BiowareMdlCommon_ControllerType::EmitterPercentEnd),
            232 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeMid),
            236 => Ok(BiowareMdlCommon_ControllerType::EmitterSizeMidY),
            240 => Ok(BiowareMdlCommon_ControllerType::EmitterRandomBirthRate),
            252 => Ok(BiowareMdlCommon_ControllerType::EmitterTargetSize),
            256 => Ok(BiowareMdlCommon_ControllerType::EmitterNumControlPoints),
            260 => Ok(BiowareMdlCommon_ControllerType::EmitterControlPointRadius),
            264 => Ok(BiowareMdlCommon_ControllerType::EmitterControlPointDelay),
            268 => Ok(BiowareMdlCommon_ControllerType::EmitterTangentSpread),
            272 => Ok(BiowareMdlCommon_ControllerType::EmitterTangentLength),
            284 => Ok(BiowareMdlCommon_ControllerType::EmitterColorMid),
            380 => Ok(BiowareMdlCommon_ControllerType::EmitterColorEnd),
            392 => Ok(BiowareMdlCommon_ControllerType::EmitterColorStart),
            502 => Ok(BiowareMdlCommon_ControllerType::EmitterDetonate),
            _ => Ok(BiowareMdlCommon_ControllerType::Unknown(flag)),
        }
    }
}

impl From<&BiowareMdlCommon_ControllerType> for i64 {
    fn from(v: &BiowareMdlCommon_ControllerType) -> Self {
        match *v {
            BiowareMdlCommon_ControllerType::Position => 8,
            BiowareMdlCommon_ControllerType::Orientation => 20,
            BiowareMdlCommon_ControllerType::Scale => 36,
            BiowareMdlCommon_ControllerType::Color => 76,
            BiowareMdlCommon_ControllerType::EmitterAlphaEnd => 80,
            BiowareMdlCommon_ControllerType::EmitterAlphaStart => 84,
            BiowareMdlCommon_ControllerType::Radius => 88,
            BiowareMdlCommon_ControllerType::EmitterBounceCoefficient => 92,
            BiowareMdlCommon_ControllerType::ShadowRadius => 96,
            BiowareMdlCommon_ControllerType::VerticalDisplacementOrDragOrSelfillumcolor => 100,
            BiowareMdlCommon_ControllerType::EmitterFps => 104,
            BiowareMdlCommon_ControllerType::EmitterFrameEnd => 108,
            BiowareMdlCommon_ControllerType::EmitterFrameStart => 112,
            BiowareMdlCommon_ControllerType::EmitterGravity => 116,
            BiowareMdlCommon_ControllerType::EmitterLifeExpectancy => 120,
            BiowareMdlCommon_ControllerType::EmitterMass => 124,
            BiowareMdlCommon_ControllerType::Alpha => 132,
            BiowareMdlCommon_ControllerType::EmitterParticleRotation => 136,
            BiowareMdlCommon_ControllerType::MultiplierOrRandvel => 140,
            BiowareMdlCommon_ControllerType::EmitterSizeStart => 144,
            BiowareMdlCommon_ControllerType::EmitterSizeEnd => 148,
            BiowareMdlCommon_ControllerType::EmitterSizeStartY => 152,
            BiowareMdlCommon_ControllerType::EmitterSizeEndY => 156,
            BiowareMdlCommon_ControllerType::EmitterSpread => 160,
            BiowareMdlCommon_ControllerType::EmitterThreshold => 164,
            BiowareMdlCommon_ControllerType::EmitterVelocity => 168,
            BiowareMdlCommon_ControllerType::EmitterXSize => 172,
            BiowareMdlCommon_ControllerType::EmitterYSize => 176,
            BiowareMdlCommon_ControllerType::EmitterBlurLength => 180,
            BiowareMdlCommon_ControllerType::EmitterLightningDelay => 184,
            BiowareMdlCommon_ControllerType::EmitterLightningRadius => 188,
            BiowareMdlCommon_ControllerType::EmitterLightningScale => 192,
            BiowareMdlCommon_ControllerType::EmitterLightningSubdivide => 196,
            BiowareMdlCommon_ControllerType::EmitterLightningZigZag => 200,
            BiowareMdlCommon_ControllerType::EmitterAlphaMid => 216,
            BiowareMdlCommon_ControllerType::EmitterPercentStart => 220,
            BiowareMdlCommon_ControllerType::EmitterPercentMid => 224,
            BiowareMdlCommon_ControllerType::EmitterPercentEnd => 228,
            BiowareMdlCommon_ControllerType::EmitterSizeMid => 232,
            BiowareMdlCommon_ControllerType::EmitterSizeMidY => 236,
            BiowareMdlCommon_ControllerType::EmitterRandomBirthRate => 240,
            BiowareMdlCommon_ControllerType::EmitterTargetSize => 252,
            BiowareMdlCommon_ControllerType::EmitterNumControlPoints => 256,
            BiowareMdlCommon_ControllerType::EmitterControlPointRadius => 260,
            BiowareMdlCommon_ControllerType::EmitterControlPointDelay => 264,
            BiowareMdlCommon_ControllerType::EmitterTangentSpread => 268,
            BiowareMdlCommon_ControllerType::EmitterTangentLength => 272,
            BiowareMdlCommon_ControllerType::EmitterColorMid => 284,
            BiowareMdlCommon_ControllerType::EmitterColorEnd => 380,
            BiowareMdlCommon_ControllerType::EmitterColorStart => 392,
            BiowareMdlCommon_ControllerType::EmitterDetonate => 502,
            BiowareMdlCommon_ControllerType::Unknown(v) => v
        }
    }
}

impl Default for BiowareMdlCommon_ControllerType {
    fn default() -> Self { BiowareMdlCommon_ControllerType::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareMdlCommon_ModelClassification {
    Other,
    Effect,
    Tile,
    Character,
    Door,
    Lightsaber,
    Placeable,
    Flyer,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareMdlCommon_ModelClassification {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareMdlCommon_ModelClassification> {
        match flag {
            0 => Ok(BiowareMdlCommon_ModelClassification::Other),
            1 => Ok(BiowareMdlCommon_ModelClassification::Effect),
            2 => Ok(BiowareMdlCommon_ModelClassification::Tile),
            4 => Ok(BiowareMdlCommon_ModelClassification::Character),
            8 => Ok(BiowareMdlCommon_ModelClassification::Door),
            16 => Ok(BiowareMdlCommon_ModelClassification::Lightsaber),
            32 => Ok(BiowareMdlCommon_ModelClassification::Placeable),
            64 => Ok(BiowareMdlCommon_ModelClassification::Flyer),
            _ => Ok(BiowareMdlCommon_ModelClassification::Unknown(flag)),
        }
    }
}

impl From<&BiowareMdlCommon_ModelClassification> for i64 {
    fn from(v: &BiowareMdlCommon_ModelClassification) -> Self {
        match *v {
            BiowareMdlCommon_ModelClassification::Other => 0,
            BiowareMdlCommon_ModelClassification::Effect => 1,
            BiowareMdlCommon_ModelClassification::Tile => 2,
            BiowareMdlCommon_ModelClassification::Character => 4,
            BiowareMdlCommon_ModelClassification::Door => 8,
            BiowareMdlCommon_ModelClassification::Lightsaber => 16,
            BiowareMdlCommon_ModelClassification::Placeable => 32,
            BiowareMdlCommon_ModelClassification::Flyer => 64,
            BiowareMdlCommon_ModelClassification::Unknown(v) => v
        }
    }
}

impl Default for BiowareMdlCommon_ModelClassification {
    fn default() -> Self { BiowareMdlCommon_ModelClassification::Unknown(0) }
}

#[derive(Debug, PartialEq, Clone)]
pub enum BiowareMdlCommon_NodeTypeValue {
    Dummy,
    Light,
    Emitter,
    Reference,
    Trimesh,
    Skinmesh,
    Animmesh,
    Danglymesh,
    Aabb,
    Lightsaber,
    Unknown(i64),
}

impl TryFrom<i64> for BiowareMdlCommon_NodeTypeValue {
    type Error = KError;
    fn try_from(flag: i64) -> KResult<BiowareMdlCommon_NodeTypeValue> {
        match flag {
            1 => Ok(BiowareMdlCommon_NodeTypeValue::Dummy),
            3 => Ok(BiowareMdlCommon_NodeTypeValue::Light),
            5 => Ok(BiowareMdlCommon_NodeTypeValue::Emitter),
            17 => Ok(BiowareMdlCommon_NodeTypeValue::Reference),
            33 => Ok(BiowareMdlCommon_NodeTypeValue::Trimesh),
            97 => Ok(BiowareMdlCommon_NodeTypeValue::Skinmesh),
            161 => Ok(BiowareMdlCommon_NodeTypeValue::Animmesh),
            289 => Ok(BiowareMdlCommon_NodeTypeValue::Danglymesh),
            545 => Ok(BiowareMdlCommon_NodeTypeValue::Aabb),
            2081 => Ok(BiowareMdlCommon_NodeTypeValue::Lightsaber),
            _ => Ok(BiowareMdlCommon_NodeTypeValue::Unknown(flag)),
        }
    }
}

impl From<&BiowareMdlCommon_NodeTypeValue> for i64 {
    fn from(v: &BiowareMdlCommon_NodeTypeValue) -> Self {
        match *v {
            BiowareMdlCommon_NodeTypeValue::Dummy => 1,
            BiowareMdlCommon_NodeTypeValue::Light => 3,
            BiowareMdlCommon_NodeTypeValue::Emitter => 5,
            BiowareMdlCommon_NodeTypeValue::Reference => 17,
            BiowareMdlCommon_NodeTypeValue::Trimesh => 33,
            BiowareMdlCommon_NodeTypeValue::Skinmesh => 97,
            BiowareMdlCommon_NodeTypeValue::Animmesh => 161,
            BiowareMdlCommon_NodeTypeValue::Danglymesh => 289,
            BiowareMdlCommon_NodeTypeValue::Aabb => 545,
            BiowareMdlCommon_NodeTypeValue::Lightsaber => 2081,
            BiowareMdlCommon_NodeTypeValue::Unknown(v) => v
        }
    }
}

impl Default for BiowareMdlCommon_NodeTypeValue {
    fn default() -> Self { BiowareMdlCommon_NodeTypeValue::Unknown(0) }
}


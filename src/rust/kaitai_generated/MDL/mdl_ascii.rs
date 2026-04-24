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
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88 xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format PyKotor wiki — ASCII MDL
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format PyKotor wiki — binary MDL (wire vs ASCII)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — readasciimdl
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<MdlAscii>,
    pub _self: SharedType<Self>,
    lines: RefCell<Vec<OptRc<MdlAscii_AsciiLine>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii {
    type Root = MdlAscii;
    type Parent = MdlAscii;

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
        *self_rc.lines.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while !_io.is_eof() {
                let t = Self::read_into::<_, MdlAscii_AsciiLine>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                self_rc.lines.borrow_mut().push(t);
                _i += 1;
            }
        }
        Ok(())
    }
}
impl MdlAscii {
}
impl MdlAscii {
    pub fn lines(&self) -> Ref<'_, Vec<OptRc<MdlAscii_AsciiLine>>> {
        self.lines.borrow()
    }
}
impl MdlAscii {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Animation section keywords
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_AnimationSection {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    newanim: RefCell<OptRc<MdlAscii_LineText>>,
    doneanim: RefCell<OptRc<MdlAscii_LineText>>,
    length: RefCell<OptRc<MdlAscii_LineText>>,
    transtime: RefCell<OptRc<MdlAscii_LineText>>,
    animroot: RefCell<OptRc<MdlAscii_LineText>>,
    event: RefCell<OptRc<MdlAscii_LineText>>,
    eventlist: RefCell<OptRc<MdlAscii_LineText>>,
    endlist: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_AnimationSection {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.newanim.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.doneanim.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.length.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.transtime.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.animroot.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.event.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.eventlist.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.endlist.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_AnimationSection {
}

/**
 * newanim <animation_name> <model_name> - Start of animation definition
 */
impl MdlAscii_AnimationSection {
    pub fn newanim(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.newanim.borrow()
    }
}

/**
 * doneanim <animation_name> <model_name> - End of animation definition
 */
impl MdlAscii_AnimationSection {
    pub fn doneanim(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.doneanim.borrow()
    }
}

/**
 * length <duration> - Animation duration in seconds
 */
impl MdlAscii_AnimationSection {
    pub fn length(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.length.borrow()
    }
}

/**
 * transtime <transition_time> - Transition/blend time to this animation in seconds
 */
impl MdlAscii_AnimationSection {
    pub fn transtime(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.transtime.borrow()
    }
}

/**
 * animroot <root_node_name> - Root node name for animation
 */
impl MdlAscii_AnimationSection {
    pub fn animroot(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.animroot.borrow()
    }
}

/**
 * event <time> <event_name> - Animation event (triggers at specified time)
 */
impl MdlAscii_AnimationSection {
    pub fn event(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.event.borrow()
    }
}

/**
 * eventlist - Start of animation events list
 */
impl MdlAscii_AnimationSection {
    pub fn eventlist(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.eventlist.borrow()
    }
}

/**
 * endlist - End of list (controllers, events, etc.)
 */
impl MdlAscii_AnimationSection {
    pub fn endlist(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.endlist.borrow()
    }
}
impl MdlAscii_AnimationSection {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Single line in ASCII MDL file
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_AsciiLine {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<MdlAscii>,
    pub _self: SharedType<Self>,
    content: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_AsciiLine {
    type Root = MdlAscii;
    type Parent = MdlAscii;

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
        *self_rc.content.borrow_mut() = bytes_to_str(&_io.read_bytes_term(10, false, true, false)?.into(), "UTF-8")?;
        Ok(())
    }
}
impl MdlAscii_AsciiLine {
}
impl MdlAscii_AsciiLine {
    pub fn content(&self) -> Ref<'_, String> {
        self.content.borrow()
    }
}
impl MdlAscii_AsciiLine {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Bezier (smooth animated) controller format
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ControllerBezier {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    controller_name: RefCell<OptRc<MdlAscii_LineText>>,
    keyframes: RefCell<Vec<OptRc<MdlAscii_ControllerBezierKeyframe>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ControllerBezier {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.controller_name.borrow_mut() = t;
        *self_rc.keyframes.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while !_io.is_eof() {
                let t = Self::read_into::<_, MdlAscii_ControllerBezierKeyframe>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                self_rc.keyframes.borrow_mut().push(t);
                _i += 1;
            }
        }
        Ok(())
    }
}
impl MdlAscii_ControllerBezier {
}

/**
 * Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
 */
impl MdlAscii_ControllerBezier {
    pub fn controller_name(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.controller_name.borrow()
    }
}

/**
 * Keyframe entries until endlist keyword
 */
impl MdlAscii_ControllerBezier {
    pub fn keyframes(&self) -> Ref<'_, Vec<OptRc<MdlAscii_ControllerBezierKeyframe>>> {
        self.keyframes.borrow()
    }
}
impl MdlAscii_ControllerBezier {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ControllerBezierKeyframe {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<MdlAscii_ControllerBezier>,
    pub _self: SharedType<Self>,
    time: RefCell<String>,
    value_data: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ControllerBezierKeyframe {
    type Root = MdlAscii;
    type Parent = MdlAscii_ControllerBezier;

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
        *self_rc.time.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        *self_rc.value_data.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        Ok(())
    }
}
impl MdlAscii_ControllerBezierKeyframe {
}

/**
 * Time value (float)
 */
impl MdlAscii_ControllerBezierKeyframe {
    pub fn time(&self) -> Ref<'_, String> {
        self.time.borrow()
    }
}

/**
 * Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
 */
impl MdlAscii_ControllerBezierKeyframe {
    pub fn value_data(&self) -> Ref<'_, String> {
        self.value_data.borrow()
    }
}
impl MdlAscii_ControllerBezierKeyframe {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Keyed (animated) controller format
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ControllerKeyed {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    controller_name: RefCell<OptRc<MdlAscii_LineText>>,
    keyframes: RefCell<Vec<OptRc<MdlAscii_ControllerKeyframe>>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ControllerKeyed {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.controller_name.borrow_mut() = t;
        *self_rc.keyframes.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while !_io.is_eof() {
                let t = Self::read_into::<_, MdlAscii_ControllerKeyframe>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
                self_rc.keyframes.borrow_mut().push(t);
                _i += 1;
            }
        }
        Ok(())
    }
}
impl MdlAscii_ControllerKeyed {
}

/**
 * Controller name followed by 'key' (e.g., positionkey, orientationkey)
 */
impl MdlAscii_ControllerKeyed {
    pub fn controller_name(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.controller_name.borrow()
    }
}

/**
 * Keyframe entries until endlist keyword
 */
impl MdlAscii_ControllerKeyed {
    pub fn keyframes(&self) -> Ref<'_, Vec<OptRc<MdlAscii_ControllerKeyframe>>> {
        self.keyframes.borrow()
    }
}
impl MdlAscii_ControllerKeyed {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Single keyframe in keyed controller
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ControllerKeyframe {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<MdlAscii_ControllerKeyed>,
    pub _self: SharedType<Self>,
    time: RefCell<String>,
    values: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ControllerKeyframe {
    type Root = MdlAscii;
    type Parent = MdlAscii_ControllerKeyed;

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
        *self_rc.time.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        *self_rc.values.borrow_mut() = bytes_to_str(&_io.read_bytes_full()?.into(), "UTF-8")?;
        Ok(())
    }
}
impl MdlAscii_ControllerKeyframe {
}

/**
 * Time value (float)
 */
impl MdlAscii_ControllerKeyframe {
    pub fn time(&self) -> Ref<'_, String> {
        self.time.borrow()
    }
}

/**
 * Space-separated property values (number depends on controller type and column count)
 */
impl MdlAscii_ControllerKeyframe {
    pub fn values(&self) -> Ref<'_, String> {
        self.values.borrow()
    }
}
impl MdlAscii_ControllerKeyframe {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Single (constant) controller format
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ControllerSingle {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    controller_name: RefCell<OptRc<MdlAscii_LineText>>,
    values: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ControllerSingle {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.controller_name.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.values.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_ControllerSingle {
}

/**
 * Controller name (position, orientation, scale, color, radius, etc.)
 */
impl MdlAscii_ControllerSingle {
    pub fn controller_name(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.controller_name.borrow()
    }
}

/**
 * Space-separated controller values (number depends on controller type)
 */
impl MdlAscii_ControllerSingle {
    pub fn values(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.values.borrow()
    }
}
impl MdlAscii_ControllerSingle {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Danglymesh node properties
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_DanglymeshProperties {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    displacement: RefCell<OptRc<MdlAscii_LineText>>,
    tightness: RefCell<OptRc<MdlAscii_LineText>>,
    period: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_DanglymeshProperties {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.displacement.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.tightness.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.period.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_DanglymeshProperties {
}

/**
 * displacement <value> - Maximum displacement distance for physics simulation
 */
impl MdlAscii_DanglymeshProperties {
    pub fn displacement(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.displacement.borrow()
    }
}

/**
 * tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
 */
impl MdlAscii_DanglymeshProperties {
    pub fn tightness(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.tightness.borrow()
    }
}

/**
 * period <value> - Oscillation period in seconds
 */
impl MdlAscii_DanglymeshProperties {
    pub fn period(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.period.borrow()
    }
}
impl MdlAscii_DanglymeshProperties {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Data array keywords
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_DataArrays {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    verts: RefCell<OptRc<MdlAscii_LineText>>,
    faces: RefCell<OptRc<MdlAscii_LineText>>,
    tverts: RefCell<OptRc<MdlAscii_LineText>>,
    tverts1: RefCell<OptRc<MdlAscii_LineText>>,
    lightmaptverts: RefCell<OptRc<MdlAscii_LineText>>,
    tverts2: RefCell<OptRc<MdlAscii_LineText>>,
    tverts3: RefCell<OptRc<MdlAscii_LineText>>,
    texindices1: RefCell<OptRc<MdlAscii_LineText>>,
    texindices2: RefCell<OptRc<MdlAscii_LineText>>,
    texindices3: RefCell<OptRc<MdlAscii_LineText>>,
    colors: RefCell<OptRc<MdlAscii_LineText>>,
    colorindices: RefCell<OptRc<MdlAscii_LineText>>,
    weights: RefCell<OptRc<MdlAscii_LineText>>,
    constraints: RefCell<OptRc<MdlAscii_LineText>>,
    aabb: RefCell<OptRc<MdlAscii_LineText>>,
    saber_verts: RefCell<OptRc<MdlAscii_LineText>>,
    saber_norms: RefCell<OptRc<MdlAscii_LineText>>,
    name: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_DataArrays {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.verts.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.faces.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.tverts.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.tverts1.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.lightmaptverts.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.tverts2.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.tverts3.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.texindices1.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.texindices2.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.texindices3.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.colors.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.colorindices.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.weights.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.constraints.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.aabb.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.saber_verts.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.saber_norms.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.name.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_DataArrays {
}

/**
 * verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
 */
impl MdlAscii_DataArrays {
    pub fn verts(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.verts.borrow()
    }
}

/**
 * faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
 */
impl MdlAscii_DataArrays {
    pub fn faces(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.faces.borrow()
    }
}

/**
 * tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
 */
impl MdlAscii_DataArrays {
    pub fn tverts(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.tverts.borrow()
    }
}

/**
 * tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
 */
impl MdlAscii_DataArrays {
    pub fn tverts1(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.tverts1.borrow()
    }
}

/**
 * lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
 */
impl MdlAscii_DataArrays {
    pub fn lightmaptverts(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.lightmaptverts.borrow()
    }
}

/**
 * tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
 */
impl MdlAscii_DataArrays {
    pub fn tverts2(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.tverts2.borrow()
    }
}

/**
 * tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
 */
impl MdlAscii_DataArrays {
    pub fn tverts3(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.tverts3.borrow()
    }
}

/**
 * texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
 */
impl MdlAscii_DataArrays {
    pub fn texindices1(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.texindices1.borrow()
    }
}

/**
 * texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
 */
impl MdlAscii_DataArrays {
    pub fn texindices2(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.texindices2.borrow()
    }
}

/**
 * texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
 */
impl MdlAscii_DataArrays {
    pub fn texindices3(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.texindices3.borrow()
    }
}

/**
 * colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
 */
impl MdlAscii_DataArrays {
    pub fn colors(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.colors.borrow()
    }
}

/**
 * colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
 */
impl MdlAscii_DataArrays {
    pub fn colorindices(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.colorindices.borrow()
    }
}

/**
 * weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
 */
impl MdlAscii_DataArrays {
    pub fn weights(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.weights.borrow()
    }
}

/**
 * constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
 */
impl MdlAscii_DataArrays {
    pub fn constraints(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.constraints.borrow()
    }
}

/**
 * aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
 */
impl MdlAscii_DataArrays {
    pub fn aabb(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.aabb.borrow()
    }
}

/**
 * saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
 */
impl MdlAscii_DataArrays {
    pub fn saber_verts(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.saber_verts.borrow()
    }
}

/**
 * saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
 */
impl MdlAscii_DataArrays {
    pub fn saber_norms(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.saber_norms.borrow()
    }
}

/**
 * name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
 */
impl MdlAscii_DataArrays {
    pub fn name(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.name.borrow()
    }
}
impl MdlAscii_DataArrays {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Emitter behavior flags
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_EmitterFlags {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    p2p: RefCell<OptRc<MdlAscii_LineText>>,
    p2p_sel: RefCell<OptRc<MdlAscii_LineText>>,
    affected_by_wind: RefCell<OptRc<MdlAscii_LineText>>,
    m_is_tinted: RefCell<OptRc<MdlAscii_LineText>>,
    bounce: RefCell<OptRc<MdlAscii_LineText>>,
    random: RefCell<OptRc<MdlAscii_LineText>>,
    inherit: RefCell<OptRc<MdlAscii_LineText>>,
    inheritvel: RefCell<OptRc<MdlAscii_LineText>>,
    inherit_local: RefCell<OptRc<MdlAscii_LineText>>,
    splat: RefCell<OptRc<MdlAscii_LineText>>,
    inherit_part: RefCell<OptRc<MdlAscii_LineText>>,
    depth_texture: RefCell<OptRc<MdlAscii_LineText>>,
    emitterflag13: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_EmitterFlags {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.p2p.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.p2p_sel.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.affected_by_wind.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.m_is_tinted.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounce.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.random.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.inherit.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.inheritvel.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.inherit_local.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.splat.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.inherit_part.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.depth_texture.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.emitterflag13.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_EmitterFlags {
}

/**
 * p2p <0_or_1> - Point-to-point flag (bit 0x0001)
 */
impl MdlAscii_EmitterFlags {
    pub fn p2p(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.p2p.borrow()
    }
}

/**
 * p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
 */
impl MdlAscii_EmitterFlags {
    pub fn p2p_sel(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.p2p_sel.borrow()
    }
}

/**
 * affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
 */
impl MdlAscii_EmitterFlags {
    pub fn affected_by_wind(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.affected_by_wind.borrow()
    }
}

/**
 * m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
 */
impl MdlAscii_EmitterFlags {
    pub fn m_is_tinted(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.m_is_tinted.borrow()
    }
}

/**
 * bounce <0_or_1> - Bounce flag (bit 0x0010)
 */
impl MdlAscii_EmitterFlags {
    pub fn bounce(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.bounce.borrow()
    }
}

/**
 * random <0_or_1> - Random flag (bit 0x0020)
 */
impl MdlAscii_EmitterFlags {
    pub fn random(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.random.borrow()
    }
}

/**
 * inherit <0_or_1> - Inherit flag (bit 0x0040)
 */
impl MdlAscii_EmitterFlags {
    pub fn inherit(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.inherit.borrow()
    }
}

/**
 * inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
 */
impl MdlAscii_EmitterFlags {
    pub fn inheritvel(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.inheritvel.borrow()
    }
}

/**
 * inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
 */
impl MdlAscii_EmitterFlags {
    pub fn inherit_local(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.inherit_local.borrow()
    }
}

/**
 * splat <0_or_1> - Splat flag (bit 0x0200)
 */
impl MdlAscii_EmitterFlags {
    pub fn splat(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.splat.borrow()
    }
}

/**
 * inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
 */
impl MdlAscii_EmitterFlags {
    pub fn inherit_part(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.inherit_part.borrow()
    }
}

/**
 * depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
 */
impl MdlAscii_EmitterFlags {
    pub fn depth_texture(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.depth_texture.borrow()
    }
}

/**
 * emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
 */
impl MdlAscii_EmitterFlags {
    pub fn emitterflag13(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.emitterflag13.borrow()
    }
}
impl MdlAscii_EmitterFlags {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Emitter node properties
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_EmitterProperties {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    deadspace: RefCell<OptRc<MdlAscii_LineText>>,
    blast_radius: RefCell<OptRc<MdlAscii_LineText>>,
    blast_length: RefCell<OptRc<MdlAscii_LineText>>,
    num_branches: RefCell<OptRc<MdlAscii_LineText>>,
    controlptsmoothing: RefCell<OptRc<MdlAscii_LineText>>,
    xgrid: RefCell<OptRc<MdlAscii_LineText>>,
    ygrid: RefCell<OptRc<MdlAscii_LineText>>,
    spawntype: RefCell<OptRc<MdlAscii_LineText>>,
    update: RefCell<OptRc<MdlAscii_LineText>>,
    render: RefCell<OptRc<MdlAscii_LineText>>,
    blend: RefCell<OptRc<MdlAscii_LineText>>,
    texture: RefCell<OptRc<MdlAscii_LineText>>,
    chunkname: RefCell<OptRc<MdlAscii_LineText>>,
    twosidedtex: RefCell<OptRc<MdlAscii_LineText>>,
    loop: RefCell<OptRc<MdlAscii_LineText>>,
    renderorder: RefCell<OptRc<MdlAscii_LineText>>,
    m_b_frame_blending: RefCell<OptRc<MdlAscii_LineText>>,
    m_s_depth_texture_name: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_EmitterProperties {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.deadspace.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.blast_radius.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.blast_length.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.num_branches.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.controlptsmoothing.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.xgrid.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.ygrid.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.spawntype.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.update.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.render.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.blend.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.texture.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.chunkname.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.twosidedtex.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.loop.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.renderorder.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.m_b_frame_blending.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.m_s_depth_texture_name.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_EmitterProperties {
}

/**
 * deadspace <value> - Minimum distance from emitter before particles become visible
 */
impl MdlAscii_EmitterProperties {
    pub fn deadspace(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.deadspace.borrow()
    }
}

/**
 * blastRadius <value> - Radius of explosive/blast particle effects
 */
impl MdlAscii_EmitterProperties {
    pub fn blast_radius(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.blast_radius.borrow()
    }
}

/**
 * blastLength <value> - Length/duration of blast effects
 */
impl MdlAscii_EmitterProperties {
    pub fn blast_length(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.blast_length.borrow()
    }
}

/**
 * numBranches <value> - Number of branching paths for particle trails
 */
impl MdlAscii_EmitterProperties {
    pub fn num_branches(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.num_branches.borrow()
    }
}

/**
 * controlptsmoothing <value> - Smoothing factor for particle path control points
 */
impl MdlAscii_EmitterProperties {
    pub fn controlptsmoothing(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.controlptsmoothing.borrow()
    }
}

/**
 * xgrid <value> - Grid subdivisions along X axis for particle spawning
 */
impl MdlAscii_EmitterProperties {
    pub fn xgrid(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.xgrid.borrow()
    }
}

/**
 * ygrid <value> - Grid subdivisions along Y axis for particle spawning
 */
impl MdlAscii_EmitterProperties {
    pub fn ygrid(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.ygrid.borrow()
    }
}

/**
 * spawntype <value> - Particle spawn type
 */
impl MdlAscii_EmitterProperties {
    pub fn spawntype(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.spawntype.borrow()
    }
}

/**
 * update <script_name> - Update behavior script name (e.g., single, fountain)
 */
impl MdlAscii_EmitterProperties {
    pub fn update(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.update.borrow()
    }
}

/**
 * render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
 */
impl MdlAscii_EmitterProperties {
    pub fn render(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.render.borrow()
    }
}

/**
 * blend <script_name> - Blend mode script name (e.g., normal, lighten)
 */
impl MdlAscii_EmitterProperties {
    pub fn blend(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.blend.borrow()
    }
}

/**
 * texture <texture_name> - Particle texture name
 */
impl MdlAscii_EmitterProperties {
    pub fn texture(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.texture.borrow()
    }
}

/**
 * chunkname <chunk_name> - Associated model chunk name
 */
impl MdlAscii_EmitterProperties {
    pub fn chunkname(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.chunkname.borrow()
    }
}

/**
 * twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
 */
impl MdlAscii_EmitterProperties {
    pub fn twosidedtex(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.twosidedtex.borrow()
    }
}

/**
 * loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
 */
impl MdlAscii_EmitterProperties {
    pub fn loop(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.loop.borrow()
    }
}

/**
 * renderorder <value> - Rendering priority/order for particle sorting
 */
impl MdlAscii_EmitterProperties {
    pub fn renderorder(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.renderorder.borrow()
    }
}

/**
 * m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
 */
impl MdlAscii_EmitterProperties {
    pub fn m_b_frame_blending(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.m_b_frame_blending.borrow()
    }
}

/**
 * m_sDepthTextureName <texture_name> - Depth/softparticle texture name
 */
impl MdlAscii_EmitterProperties {
    pub fn m_s_depth_texture_name(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.m_s_depth_texture_name.borrow()
    }
}
impl MdlAscii_EmitterProperties {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Light node properties
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_LightProperties {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    flareradius: RefCell<OptRc<MdlAscii_LineText>>,
    flarepositions: RefCell<OptRc<MdlAscii_LineText>>,
    flaresizes: RefCell<OptRc<MdlAscii_LineText>>,
    flarecolorshifts: RefCell<OptRc<MdlAscii_LineText>>,
    texturenames: RefCell<OptRc<MdlAscii_LineText>>,
    ambientonly: RefCell<OptRc<MdlAscii_LineText>>,
    ndynamictype: RefCell<OptRc<MdlAscii_LineText>>,
    affectdynamic: RefCell<OptRc<MdlAscii_LineText>>,
    flare: RefCell<OptRc<MdlAscii_LineText>>,
    lightpriority: RefCell<OptRc<MdlAscii_LineText>>,
    fadinglight: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_LightProperties {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.flareradius.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.flarepositions.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.flaresizes.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.flarecolorshifts.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.texturenames.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.ambientonly.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.ndynamictype.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.affectdynamic.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.flare.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.lightpriority.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.fadinglight.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_LightProperties {
}

/**
 * flareradius <value> - Radius of lens flare effect
 */
impl MdlAscii_LightProperties {
    pub fn flareradius(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.flareradius.borrow()
    }
}

/**
 * flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
 */
impl MdlAscii_LightProperties {
    pub fn flarepositions(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.flarepositions.borrow()
    }
}

/**
 * flaresizes <count> - Start flare sizes array (count floats)
 */
impl MdlAscii_LightProperties {
    pub fn flaresizes(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.flaresizes.borrow()
    }
}

/**
 * flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
 */
impl MdlAscii_LightProperties {
    pub fn flarecolorshifts(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.flarecolorshifts.borrow()
    }
}

/**
 * texturenames <count> - Start flare texture names array (count strings)
 */
impl MdlAscii_LightProperties {
    pub fn texturenames(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.texturenames.borrow()
    }
}

/**
 * ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
 */
impl MdlAscii_LightProperties {
    pub fn ambientonly(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.ambientonly.borrow()
    }
}

/**
 * ndynamictype <value> - Type of dynamic lighting behavior
 */
impl MdlAscii_LightProperties {
    pub fn ndynamictype(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.ndynamictype.borrow()
    }
}

/**
 * affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
 */
impl MdlAscii_LightProperties {
    pub fn affectdynamic(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.affectdynamic.borrow()
    }
}

/**
 * flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
 */
impl MdlAscii_LightProperties {
    pub fn flare(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.flare.borrow()
    }
}

/**
 * lightpriority <value> - Rendering priority for light culling/sorting
 */
impl MdlAscii_LightProperties {
    pub fn lightpriority(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.lightpriority.borrow()
    }
}

/**
 * fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
 */
impl MdlAscii_LightProperties {
    pub fn fadinglight(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.fadinglight.borrow()
    }
}
impl MdlAscii_LightProperties {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * A single UTF-8 text line (without the trailing newline).
 * Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_LineText {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    value: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_LineText {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        *self_rc.value.borrow_mut() = bytes_to_str(&_io.read_bytes_term(10, false, true, false)?.into(), "UTF-8")?;
        Ok(())
    }
}
impl MdlAscii_LineText {
}
impl MdlAscii_LineText {
    pub fn value(&self) -> Ref<'_, String> {
        self.value.borrow()
    }
}
impl MdlAscii_LineText {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Reference node properties
 */

#[derive(Default, Debug, Clone)]
pub struct MdlAscii_ReferenceProperties {
    pub _root: SharedType<MdlAscii>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    refmodel: RefCell<OptRc<MdlAscii_LineText>>,
    reattachable: RefCell<OptRc<MdlAscii_LineText>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for MdlAscii_ReferenceProperties {
    type Root = MdlAscii;
    type Parent = KStructUnit;

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
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.refmodel.borrow_mut() = t;
        let t = Self::read_into::<_, MdlAscii_LineText>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.reattachable.borrow_mut() = t;
        Ok(())
    }
}
impl MdlAscii_ReferenceProperties {
}

/**
 * refmodel <model_resref> - Referenced model resource name without extension
 */
impl MdlAscii_ReferenceProperties {
    pub fn refmodel(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.refmodel.borrow()
    }
}

/**
 * reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
 */
impl MdlAscii_ReferenceProperties {
    pub fn reattachable(&self) -> Ref<'_, OptRc<MdlAscii_LineText>> {
        self.reattachable.borrow()
    }
}
impl MdlAscii_ReferenceProperties {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

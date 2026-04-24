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
use super::bioware_mdl_common::BiowareMdlCommon_ControllerType;
use super::bioware_mdl_common::BiowareMdlCommon_ModelClassification;

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
 * \sa https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format PyKotor wiki — MDL/MDX
 * \sa https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408 PyKotor — MDLBinaryReader (binary MDL/MDX)
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267 xoreos — Model_KotOR::load
 * \sa https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79 xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)
 * \sa https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview
 * \sa https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html xoreos-docs — Torlack binmdl (controller / Aurora background)
 * \sa https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118 reone — MdlMdxReader::load
 * \sa https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170 KotOR.js — OdysseyModel binary constructor
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 Community MDLOps — controller name table
 * \sa https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 Community MDLOps — `readasciimdl` (ASCII MDL ingest)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    file_header: RefCell<OptRc<Mdl_FileHeader>>,
    model_header: RefCell<OptRc<Mdl_ModelHeader>>,
    _io: RefCell<BytesReader>,
    names_data_raw: RefCell<Vec<u8>>,
    f_animation_offsets: Cell<bool>,
    animation_offsets: RefCell<Vec<u32>>,
    f_animations: Cell<bool>,
    animations: RefCell<Vec<OptRc<Mdl_MdlAnimationEntry>>>,
    f_data_start: Cell<bool>,
    data_start: RefCell<i8>,
    f_name_offsets: Cell<bool>,
    name_offsets: RefCell<Vec<u32>>,
    f_names_data: Cell<bool>,
    names_data: RefCell<OptRc<Mdl_NameStrings>>,
    f_root_node: Cell<bool>,
    root_node: RefCell<OptRc<Mdl_Node>>,
}
impl KStruct for Mdl {
    type Root = Mdl;
    type Parent = Mdl;

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
        let t = Self::read_into::<_, Mdl_FileHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.file_header.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_ModelHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.model_header.borrow_mut() = t;
        Ok(())
    }
}
impl Mdl {

    /**
     * Animation header offsets (relative to data_start)
     */
    pub fn animation_offsets(
        &self
    ) -> KResult<Ref<'_, Vec<u32>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_animation_offsets.get() {
            return Ok(self.animation_offsets.borrow());
        }
        self.f_animation_offsets.set(true);
        if ((*self.model_header().animation_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(((*self.data_start()? as u32) + (*self.model_header().offset_to_animations() as u32)) as usize)?;
            *self.animation_offsets.borrow_mut() = Vec::new();
            let l_animation_offsets = *self.model_header().animation_count();
            for _i in 0..l_animation_offsets {
                self.animation_offsets.borrow_mut().push(_io.read_u4le()?.into());
            }
            _io.seek(_pos)?;
        }
        Ok(self.animation_offsets.borrow())
    }

    /**
     * Animation headers (via offset table). Each list element is `mdl_animation_entry`;
     * the parsed header is `element.header` (same wire layout as `animation_header`).
     */
    pub fn animations(
        &self
    ) -> KResult<Ref<'_, Vec<OptRc<Mdl_MdlAnimationEntry>>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_animations.get() {
            return Ok(self.animations.borrow());
        }
        self.f_animations.set(true);
        if ((*self.model_header().animation_count() as u32) > (0 as u32)) {
            *self.animations.borrow_mut() = Vec::new();
            let l_animations = *self.model_header().animation_count();
            for _i in 0..l_animations {
                let f = |t : &mut Mdl_MdlAnimationEntry| Ok(t.set_params((_i).try_into().map_err(|_| KError::CastError)?));
                let t = Self::read_into_with_init::<_, Mdl_MdlAnimationEntry>(&*_io, Some(self._root.clone()), Some(self._self.clone()), &f)?.into();
                self.animations.borrow_mut().push(t);
            }
        }
        Ok(self.animations.borrow())
    }

    /**
     * MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
     * section, which begins immediately after the 12-byte file header.
     */
    pub fn data_start(
        &self
    ) -> KResult<Ref<'_, i8>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_data_start.get() {
            return Ok(self.data_start.borrow());
        }
        self.f_data_start.set(true);
        *self.data_start.borrow_mut() = (12) as i8;
        Ok(self.data_start.borrow())
    }

    /**
     * Name string offsets (relative to data_start)
     */
    pub fn name_offsets(
        &self
    ) -> KResult<Ref<'_, Vec<u32>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_name_offsets.get() {
            return Ok(self.name_offsets.borrow());
        }
        self.f_name_offsets.set(true);
        if ((*self.model_header().name_offsets_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(((*self.data_start()? as u32) + (*self.model_header().offset_to_name_offsets() as u32)) as usize)?;
            *self.name_offsets.borrow_mut() = Vec::new();
            let l_name_offsets = *self.model_header().name_offsets_count();
            for _i in 0..l_name_offsets {
                self.name_offsets.borrow_mut().push(_io.read_u4le()?.into());
            }
            _io.seek(_pos)?;
        }
        Ok(self.name_offsets.borrow())
    }

    /**
     * Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
     * Parsed as null-terminated ASCII strings in `name_strings`.
     */
    pub fn names_data(
        &self
    ) -> KResult<Ref<'_, OptRc<Mdl_NameStrings>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_names_data.get() {
            return Ok(self.names_data.borrow());
        }
        if ((*self.model_header().name_offsets_count() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(((((*self.data_start()? as u32) + (*self.model_header().offset_to_name_offsets() as u32)) as i32) + (((4 as u32) * (*self.model_header().name_offsets_count() as u32)) as i32)) as usize)?;
            *self.names_data_raw.borrow_mut() = _io.read_bytes(((((*self.data_start()? as u32) + (*self.model_header().offset_to_animations() as u32)) as i32) - (((((*self.data_start()? as u32) + (*self.model_header().offset_to_name_offsets() as u32)) as i32) + (((4 as u32) * (*self.model_header().name_offsets_count() as u32)) as i32)) as i32)) as usize)?.into();
            let names_data_raw = self.names_data_raw.borrow();
            let _t_names_data_raw_io = BytesReader::from(names_data_raw.clone());
            let t = Self::read_into::<BytesReader, Mdl_NameStrings>(&_t_names_data_raw_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.names_data.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.names_data.borrow())
    }
    pub fn root_node(
        &self
    ) -> KResult<Ref<'_, OptRc<Mdl_Node>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_root_node.get() {
            return Ok(self.root_node.borrow());
        }
        if ((*self.model_header().geometry().root_node_offset() as u32) > (0 as u32)) {
            let _pos = _io.pos();
            _io.seek(((*self.data_start()? as u32) + (*self.model_header().geometry().root_node_offset() as u32)) as usize)?;
            let t = Self::read_into::<_, Mdl_Node>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
            *self.root_node.borrow_mut() = t;
            _io.seek(_pos)?;
        }
        Ok(self.root_node.borrow())
    }
}
impl Mdl {
    pub fn file_header(&self) -> Ref<'_, OptRc<Mdl_FileHeader>> {
        self.file_header.borrow()
    }
}
impl Mdl {
    pub fn model_header(&self) -> Ref<'_, OptRc<Mdl_ModelHeader>> {
        self.model_header.borrow()
    }
}
impl Mdl {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}
impl Mdl {
    pub fn names_data_raw(&self) -> Ref<'_, Vec<u8>> {
        self.names_data_raw.borrow()
    }
}

/**
 * AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_AabbHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    trimesh_base: RefCell<OptRc<Mdl_TrimeshHeader>>,
    unknown: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_AabbHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.trimesh_base.borrow_mut() = t;
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_AabbHeader {
}

/**
 * Standard trimesh header
 */
impl Mdl_AabbHeader {
    pub fn trimesh_base(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_base.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_AabbHeader {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}
impl Mdl_AabbHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Animation event (36 bytes)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_AnimationEvent {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    activation_time: RefCell<f32>,
    event_name: RefCell<String>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_AnimationEvent {
    type Root = Mdl;
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
        *self_rc.activation_time.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.event_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        Ok(())
    }
}
impl Mdl_AnimationEvent {
}

/**
 * Time in seconds when event triggers during animation playback
 */
impl Mdl_AnimationEvent {
    pub fn activation_time(&self) -> Ref<'_, f32> {
        self.activation_time.borrow()
    }
}

/**
 * Name of event (null-terminated string, e.g., "detonate")
 */
impl Mdl_AnimationEvent {
    pub fn event_name(&self) -> Ref<'_, String> {
        self.event_name.borrow()
    }
}
impl Mdl_AnimationEvent {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_AnimationHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_MdlAnimationEntry>,
    pub _self: SharedType<Self>,
    geo_header: RefCell<OptRc<Mdl_GeometryHeader>>,
    animation_length: RefCell<f32>,
    transition_time: RefCell<f32>,
    animation_root: RefCell<String>,
    event_array_offset: RefCell<u32>,
    event_count: RefCell<u32>,
    event_count_duplicate: RefCell<u32>,
    unknown: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_AnimationHeader {
    type Root = Mdl;
    type Parent = Mdl_MdlAnimationEntry;

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
        let t = Self::read_into::<_, Mdl_GeometryHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.geo_header.borrow_mut() = t;
        *self_rc.animation_length.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.transition_time.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.animation_root.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.event_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.event_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.event_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_AnimationHeader {
}

/**
 * Standard 80-byte geometry header (geometry_type = 0x01 for animation)
 */
impl Mdl_AnimationHeader {
    pub fn geo_header(&self) -> Ref<'_, OptRc<Mdl_GeometryHeader>> {
        self.geo_header.borrow()
    }
}

/**
 * Duration of animation in seconds
 */
impl Mdl_AnimationHeader {
    pub fn animation_length(&self) -> Ref<'_, f32> {
        self.animation_length.borrow()
    }
}

/**
 * Transition/blend time to this animation in seconds
 */
impl Mdl_AnimationHeader {
    pub fn transition_time(&self) -> Ref<'_, f32> {
        self.transition_time.borrow()
    }
}

/**
 * Root node name for animation (null-terminated string)
 */
impl Mdl_AnimationHeader {
    pub fn animation_root(&self) -> Ref<'_, String> {
        self.animation_root.borrow()
    }
}

/**
 * Offset to animation events array
 */
impl Mdl_AnimationHeader {
    pub fn event_array_offset(&self) -> Ref<'_, u32> {
        self.event_array_offset.borrow()
    }
}

/**
 * Number of animation events
 */
impl Mdl_AnimationHeader {
    pub fn event_count(&self) -> Ref<'_, u32> {
        self.event_count.borrow()
    }
}

/**
 * Duplicate value of event count
 */
impl Mdl_AnimationHeader {
    pub fn event_count_duplicate(&self) -> Ref<'_, u32> {
        self.event_count_duplicate.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_AnimationHeader {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}
impl Mdl_AnimationHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_AnimmeshHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    trimesh_base: RefCell<OptRc<Mdl_TrimeshHeader>>,
    unknown: RefCell<f32>,
    unknown_array: RefCell<OptRc<Mdl_ArrayDefinition>>,
    unknown_floats: RefCell<Vec<f32>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_AnimmeshHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.trimesh_base.borrow_mut() = t;
        *self_rc.unknown.borrow_mut() = _io.read_f4le()?.into();
        let t = Self::read_into::<_, Mdl_ArrayDefinition>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.unknown_array.borrow_mut() = t;
        *self_rc.unknown_floats.borrow_mut() = Vec::new();
        let l_unknown_floats = 9;
        for _i in 0..l_unknown_floats {
            self_rc.unknown_floats.borrow_mut().push(_io.read_f4le()?.into());
        }
        Ok(())
    }
}
impl Mdl_AnimmeshHeader {
}

/**
 * Standard trimesh header
 */
impl Mdl_AnimmeshHeader {
    pub fn trimesh_base(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_base.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_AnimmeshHeader {
    pub fn unknown(&self) -> Ref<'_, f32> {
        self.unknown.borrow()
    }
}

/**
 * Unknown array definition
 */
impl Mdl_AnimmeshHeader {
    pub fn unknown_array(&self) -> Ref<'_, OptRc<Mdl_ArrayDefinition>> {
        self.unknown_array.borrow()
    }
}

/**
 * Unknown float values
 */
impl Mdl_AnimmeshHeader {
    pub fn unknown_floats(&self) -> Ref<'_, Vec<f32>> {
        self.unknown_floats.borrow()
    }
}
impl Mdl_AnimmeshHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Array definition structure (offset, count, count duplicate)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_ArrayDefinition {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    offset: RefCell<i32>,
    count: RefCell<u32>,
    count_duplicate: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_ArrayDefinition {
    type Root = Mdl;
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
        *self_rc.offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_ArrayDefinition {
}

/**
 * Offset to array (relative to MDL data start, offset 12)
 */
impl Mdl_ArrayDefinition {
    pub fn offset(&self) -> Ref<'_, i32> {
        self.offset.borrow()
    }
}

/**
 * Number of used entries
 */
impl Mdl_ArrayDefinition {
    pub fn count(&self) -> Ref<'_, u32> {
        self.count.borrow()
    }
}

/**
 * Duplicate of count (allocated entries)
 */
impl Mdl_ArrayDefinition {
    pub fn count_duplicate(&self) -> Ref<'_, u32> {
        self.count_duplicate.borrow()
    }
}
impl Mdl_ArrayDefinition {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Controller structure (16 bytes) - defines animation data for a node property over time
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_Controller {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    type: RefCell<BiowareMdlCommon_ControllerType>,
    unknown: RefCell<u16>,
    row_count: RefCell<u16>,
    time_index: RefCell<u16>,
    data_index: RefCell<u16>,
    column_count: RefCell<u8>,
    padding: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_uses_bezier: Cell<bool>,
    uses_bezier: RefCell<bool>,
}
impl KStruct for Mdl_Controller {
    type Root = Mdl;
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
        *self_rc.type.borrow_mut() = (_io.read_u4le()? as i64).try_into()?;
        *self_rc.unknown.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.row_count.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.time_index.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.data_index.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.column_count.borrow_mut() = _io.read_u1()?.into();
        *self_rc.padding.borrow_mut() = Vec::new();
        let l_padding = 3;
        for _i in 0..l_padding {
            self_rc.padding.borrow_mut().push(_io.read_u1()?.into());
        }
        Ok(())
    }
}
impl Mdl_Controller {

    /**
     * True if controller uses Bezier interpolation
     */
    pub fn uses_bezier(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_uses_bezier.get() {
            return Ok(self.uses_bezier.borrow());
        }
        self.f_uses_bezier.set(true);
        *self.uses_bezier.borrow_mut() = (((((*self.column_count() as u8) & (16 as u8)) as i32) != (0 as i32))) as bool;
        Ok(self.uses_bezier.borrow())
    }
}

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
impl Mdl_Controller {
    pub fn type(&self) -> Ref<'_, BiowareMdlCommon_ControllerType> {
        self.type.borrow()
    }
}

/**
 * Purpose unknown, typically 0xFFFF
 */
impl Mdl_Controller {
    pub fn unknown(&self) -> Ref<'_, u16> {
        self.unknown.borrow()
    }
}

/**
 * Number of keyframe rows (timepoints) for this controller
 */
impl Mdl_Controller {
    pub fn row_count(&self) -> Ref<'_, u16> {
        self.row_count.borrow()
    }
}

/**
 * Index into controller data array where time values begin
 */
impl Mdl_Controller {
    pub fn time_index(&self) -> Ref<'_, u16> {
        self.time_index.borrow()
    }
}

/**
 * Index into controller data array where property values begin
 */
impl Mdl_Controller {
    pub fn data_index(&self) -> Ref<'_, u16> {
        self.data_index.borrow()
    }
}

/**
 * Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
 * If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
 */
impl Mdl_Controller {
    pub fn column_count(&self) -> Ref<'_, u8> {
        self.column_count.borrow()
    }
}

/**
 * Padding bytes for 16-byte alignment
 */
impl Mdl_Controller {
    pub fn padding(&self) -> Ref<'_, Vec<u8>> {
        self.padding.borrow()
    }
}
impl Mdl_Controller {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_DanglymeshHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    trimesh_base: RefCell<OptRc<Mdl_TrimeshHeader>>,
    constraints_offset: RefCell<u32>,
    constraints_count: RefCell<u32>,
    constraints_count_duplicate: RefCell<u32>,
    displacement: RefCell<f32>,
    tightness: RefCell<f32>,
    period: RefCell<f32>,
    unknown: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_DanglymeshHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.trimesh_base.borrow_mut() = t;
        *self_rc.constraints_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.constraints_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.constraints_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.displacement.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.tightness.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.period.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_DanglymeshHeader {
}

/**
 * Standard trimesh header
 */
impl Mdl_DanglymeshHeader {
    pub fn trimesh_base(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_base.borrow()
    }
}

/**
 * Offset to vertex constraint values array
 */
impl Mdl_DanglymeshHeader {
    pub fn constraints_offset(&self) -> Ref<'_, u32> {
        self.constraints_offset.borrow()
    }
}

/**
 * Number of vertex constraints (matches vertex count)
 */
impl Mdl_DanglymeshHeader {
    pub fn constraints_count(&self) -> Ref<'_, u32> {
        self.constraints_count.borrow()
    }
}

/**
 * Duplicate of constraints count
 */
impl Mdl_DanglymeshHeader {
    pub fn constraints_count_duplicate(&self) -> Ref<'_, u32> {
        self.constraints_count_duplicate.borrow()
    }
}

/**
 * Maximum displacement distance for physics simulation
 */
impl Mdl_DanglymeshHeader {
    pub fn displacement(&self) -> Ref<'_, f32> {
        self.displacement.borrow()
    }
}

/**
 * Tightness/stiffness of spring simulation (0.0-1.0)
 */
impl Mdl_DanglymeshHeader {
    pub fn tightness(&self) -> Ref<'_, f32> {
        self.tightness.borrow()
    }
}

/**
 * Oscillation period in seconds
 */
impl Mdl_DanglymeshHeader {
    pub fn period(&self) -> Ref<'_, f32> {
        self.period.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_DanglymeshHeader {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}
impl Mdl_DanglymeshHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Emitter header (224 bytes)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_EmitterHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    dead_space: RefCell<f32>,
    blast_radius: RefCell<f32>,
    blast_length: RefCell<f32>,
    branch_count: RefCell<u32>,
    control_point_smoothing: RefCell<f32>,
    x_grid: RefCell<u32>,
    y_grid: RefCell<u32>,
    padding_unknown: RefCell<u32>,
    update_script: RefCell<String>,
    render_script: RefCell<String>,
    blend_script: RefCell<String>,
    texture_name: RefCell<String>,
    chunk_name: RefCell<String>,
    two_sided_texture: RefCell<u32>,
    loop: RefCell<u32>,
    render_order: RefCell<u16>,
    frame_blending: RefCell<u8>,
    depth_texture_name: RefCell<String>,
    padding: RefCell<u8>,
    flags: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_EmitterHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        *self_rc.dead_space.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.blast_radius.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.blast_length.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.branch_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.control_point_smoothing.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.x_grid.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.y_grid.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.padding_unknown.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.update_script.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.render_script.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.blend_script.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.texture_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.chunk_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.two_sided_texture.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.loop.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.render_order.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.frame_blending.borrow_mut() = _io.read_u1()?.into();
        *self_rc.depth_texture_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.padding.borrow_mut() = _io.read_u1()?.into();
        *self_rc.flags.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_EmitterHeader {
}

/**
 * Minimum distance from emitter before particles become visible
 */
impl Mdl_EmitterHeader {
    pub fn dead_space(&self) -> Ref<'_, f32> {
        self.dead_space.borrow()
    }
}

/**
 * Radius of explosive/blast particle effects
 */
impl Mdl_EmitterHeader {
    pub fn blast_radius(&self) -> Ref<'_, f32> {
        self.blast_radius.borrow()
    }
}

/**
 * Length/duration of blast effects
 */
impl Mdl_EmitterHeader {
    pub fn blast_length(&self) -> Ref<'_, f32> {
        self.blast_length.borrow()
    }
}

/**
 * Number of branching paths for particle trails
 */
impl Mdl_EmitterHeader {
    pub fn branch_count(&self) -> Ref<'_, u32> {
        self.branch_count.borrow()
    }
}

/**
 * Smoothing factor for particle path control points
 */
impl Mdl_EmitterHeader {
    pub fn control_point_smoothing(&self) -> Ref<'_, f32> {
        self.control_point_smoothing.borrow()
    }
}

/**
 * Grid subdivisions along X axis for particle spawning
 */
impl Mdl_EmitterHeader {
    pub fn x_grid(&self) -> Ref<'_, u32> {
        self.x_grid.borrow()
    }
}

/**
 * Grid subdivisions along Y axis for particle spawning
 */
impl Mdl_EmitterHeader {
    pub fn y_grid(&self) -> Ref<'_, u32> {
        self.y_grid.borrow()
    }
}

/**
 * Purpose unknown or padding
 */
impl Mdl_EmitterHeader {
    pub fn padding_unknown(&self) -> Ref<'_, u32> {
        self.padding_unknown.borrow()
    }
}

/**
 * Update behavior script name (e.g., "single", "fountain")
 */
impl Mdl_EmitterHeader {
    pub fn update_script(&self) -> Ref<'_, String> {
        self.update_script.borrow()
    }
}

/**
 * Render mode script name (e.g., "normal", "billboard_to_local_z")
 */
impl Mdl_EmitterHeader {
    pub fn render_script(&self) -> Ref<'_, String> {
        self.render_script.borrow()
    }
}

/**
 * Blend mode script name (e.g., "normal", "lighten")
 */
impl Mdl_EmitterHeader {
    pub fn blend_script(&self) -> Ref<'_, String> {
        self.blend_script.borrow()
    }
}

/**
 * Particle texture name (null-terminated string)
 */
impl Mdl_EmitterHeader {
    pub fn texture_name(&self) -> Ref<'_, String> {
        self.texture_name.borrow()
    }
}

/**
 * Associated model chunk name (null-terminated string)
 */
impl Mdl_EmitterHeader {
    pub fn chunk_name(&self) -> Ref<'_, String> {
        self.chunk_name.borrow()
    }
}

/**
 * 1 if texture should render two-sided, 0 for single-sided
 */
impl Mdl_EmitterHeader {
    pub fn two_sided_texture(&self) -> Ref<'_, u32> {
        self.two_sided_texture.borrow()
    }
}

/**
 * 1 if particle system loops, 0 for single playback
 */
impl Mdl_EmitterHeader {
    pub fn loop(&self) -> Ref<'_, u32> {
        self.loop.borrow()
    }
}

/**
 * Rendering priority/order for particle sorting
 */
impl Mdl_EmitterHeader {
    pub fn render_order(&self) -> Ref<'_, u16> {
        self.render_order.borrow()
    }
}

/**
 * 1 if frame blending enabled, 0 otherwise
 */
impl Mdl_EmitterHeader {
    pub fn frame_blending(&self) -> Ref<'_, u8> {
        self.frame_blending.borrow()
    }
}

/**
 * Depth/softparticle texture name (null-terminated string)
 */
impl Mdl_EmitterHeader {
    pub fn depth_texture_name(&self) -> Ref<'_, String> {
        self.depth_texture_name.borrow()
    }
}

/**
 * Padding byte for alignment
 */
impl Mdl_EmitterHeader {
    pub fn padding(&self) -> Ref<'_, u8> {
        self.padding.borrow()
    }
}

/**
 * Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
 */
impl Mdl_EmitterHeader {
    pub fn flags(&self) -> Ref<'_, u32> {
        self.flags.borrow()
    }
}
impl Mdl_EmitterHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * MDL file header (12 bytes)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_FileHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    unused: RefCell<u32>,
    mdl_size: RefCell<u32>,
    mdx_size: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_FileHeader {
    type Root = Mdl;
    type Parent = Mdl;

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
        *self_rc.unused.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdl_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_size.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_FileHeader {
}

/**
 * Always 0
 */
impl Mdl_FileHeader {
    pub fn unused(&self) -> Ref<'_, u32> {
        self.unused.borrow()
    }
}

/**
 * Size of MDL file in bytes
 */
impl Mdl_FileHeader {
    pub fn mdl_size(&self) -> Ref<'_, u32> {
        self.mdl_size.borrow()
    }
}

/**
 * Size of MDX file in bytes
 */
impl Mdl_FileHeader {
    pub fn mdx_size(&self) -> Ref<'_, u32> {
        self.mdx_size.borrow()
    }
}
impl Mdl_FileHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_GeometryHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    function_pointer_0: RefCell<u32>,
    function_pointer_1: RefCell<u32>,
    model_name: RefCell<String>,
    root_node_offset: RefCell<u32>,
    node_count: RefCell<u32>,
    unknown_array_1: RefCell<OptRc<Mdl_ArrayDefinition>>,
    unknown_array_2: RefCell<OptRc<Mdl_ArrayDefinition>>,
    reference_count: RefCell<u32>,
    geometry_type: RefCell<u8>,
    padding: RefCell<Vec<u8>>,
    _io: RefCell<BytesReader>,
    f_is_kotor2: Cell<bool>,
    is_kotor2: RefCell<bool>,
}
impl KStruct for Mdl_GeometryHeader {
    type Root = Mdl;
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
        *self_rc.function_pointer_0.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.function_pointer_1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.model_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.root_node_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.node_count.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Mdl_ArrayDefinition>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.unknown_array_1.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_ArrayDefinition>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.unknown_array_2.borrow_mut() = t;
        *self_rc.reference_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.geometry_type.borrow_mut() = _io.read_u1()?.into();
        *self_rc.padding.borrow_mut() = Vec::new();
        let l_padding = 3;
        for _i in 0..l_padding {
            self_rc.padding.borrow_mut().push(_io.read_u1()?.into());
        }
        Ok(())
    }
}
impl Mdl_GeometryHeader {

    /**
     * True if this is a KOTOR 2 model
     */
    pub fn is_kotor2(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_is_kotor2.get() {
            return Ok(self.is_kotor2.borrow());
        }
        self.f_is_kotor2.set(true);
        *self.is_kotor2.borrow_mut() = ( ((((*self.function_pointer_0() as i32) == (4285200 as i32))) || (((*self.function_pointer_0() as i32) == (4285872 as i32)))) ) as bool;
        Ok(self.is_kotor2.borrow())
    }
}

/**
 * Game engine version identifier:
 * - KOTOR 1 PC: 4273776 (0x413670)
 * - KOTOR 2 PC: 4285200 (0x416310)
 * - KOTOR 1 Xbox: 4254992 (0x40ED10)
 * - KOTOR 2 Xbox: 4285872 (0x4165B0)
 */
impl Mdl_GeometryHeader {
    pub fn function_pointer_0(&self) -> Ref<'_, u32> {
        self.function_pointer_0.borrow()
    }
}

/**
 * Function pointer to ASCII model parser
 */
impl Mdl_GeometryHeader {
    pub fn function_pointer_1(&self) -> Ref<'_, u32> {
        self.function_pointer_1.borrow()
    }
}

/**
 * Model name, null-terminated string, max 32 (0x20) bytes
 */
impl Mdl_GeometryHeader {
    pub fn model_name(&self) -> Ref<'_, String> {
        self.model_name.borrow()
    }
}

/**
 * Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
 */
impl Mdl_GeometryHeader {
    pub fn root_node_offset(&self) -> Ref<'_, u32> {
        self.root_node_offset.borrow()
    }
}

/**
 * Total number of nodes in model hierarchy, unsigned 32-bit integer
 */
impl Mdl_GeometryHeader {
    pub fn node_count(&self) -> Ref<'_, u32> {
        self.node_count.borrow()
    }
}

/**
 * Unknown array definition (offset, count, count duplicate)
 */
impl Mdl_GeometryHeader {
    pub fn unknown_array_1(&self) -> Ref<'_, OptRc<Mdl_ArrayDefinition>> {
        self.unknown_array_1.borrow()
    }
}

/**
 * Unknown array definition (offset, count, count duplicate)
 */
impl Mdl_GeometryHeader {
    pub fn unknown_array_2(&self) -> Ref<'_, OptRc<Mdl_ArrayDefinition>> {
        self.unknown_array_2.borrow()
    }
}

/**
 * Reference count (initialized to 0, incremented when model is referenced)
 */
impl Mdl_GeometryHeader {
    pub fn reference_count(&self) -> Ref<'_, u32> {
        self.reference_count.borrow()
    }
}

/**
 * Geometry type:
 * - 0x01: Basic geometry header (not in models)
 * - 0x02: Model geometry header
 * - 0x05: Animation geometry header
 * If bit 7 (0x80) is set, model is compiled binary with absolute addresses
 */
impl Mdl_GeometryHeader {
    pub fn geometry_type(&self) -> Ref<'_, u8> {
        self.geometry_type.borrow()
    }
}

/**
 * Padding bytes for alignment
 */
impl Mdl_GeometryHeader {
    pub fn padding(&self) -> Ref<'_, Vec<u8>> {
        self.padding.borrow()
    }
}
impl Mdl_GeometryHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Light header (92 bytes)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_LightHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    unknown: RefCell<Vec<f32>>,
    flare_sizes_offset: RefCell<u32>,
    flare_sizes_count: RefCell<u32>,
    flare_sizes_count_duplicate: RefCell<u32>,
    flare_positions_offset: RefCell<u32>,
    flare_positions_count: RefCell<u32>,
    flare_positions_count_duplicate: RefCell<u32>,
    flare_color_shifts_offset: RefCell<u32>,
    flare_color_shifts_count: RefCell<u32>,
    flare_color_shifts_count_duplicate: RefCell<u32>,
    flare_texture_names_offset: RefCell<u32>,
    flare_texture_names_count: RefCell<u32>,
    flare_texture_names_count_duplicate: RefCell<u32>,
    flare_radius: RefCell<f32>,
    light_priority: RefCell<u32>,
    ambient_only: RefCell<u32>,
    dynamic_type: RefCell<u32>,
    affect_dynamic: RefCell<u32>,
    shadow: RefCell<u32>,
    flare: RefCell<u32>,
    fading_light: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_LightHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        *self_rc.unknown.borrow_mut() = Vec::new();
        let l_unknown = 4;
        for _i in 0..l_unknown {
            self_rc.unknown.borrow_mut().push(_io.read_f4le()?.into());
        }
        *self_rc.flare_sizes_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_sizes_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_sizes_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_positions_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_positions_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_positions_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_color_shifts_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_color_shifts_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_color_shifts_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_texture_names_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_texture_names_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_texture_names_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare_radius.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.light_priority.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.ambient_only.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.dynamic_type.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.affect_dynamic.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.shadow.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.flare.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.fading_light.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_LightHeader {
}

/**
 * Purpose unknown, possibly padding or reserved values
 */
impl Mdl_LightHeader {
    pub fn unknown(&self) -> Ref<'_, Vec<f32>> {
        self.unknown.borrow()
    }
}

/**
 * Offset to flare sizes array (floats)
 */
impl Mdl_LightHeader {
    pub fn flare_sizes_offset(&self) -> Ref<'_, u32> {
        self.flare_sizes_offset.borrow()
    }
}

/**
 * Number of flare size entries
 */
impl Mdl_LightHeader {
    pub fn flare_sizes_count(&self) -> Ref<'_, u32> {
        self.flare_sizes_count.borrow()
    }
}

/**
 * Duplicate of flare sizes count
 */
impl Mdl_LightHeader {
    pub fn flare_sizes_count_duplicate(&self) -> Ref<'_, u32> {
        self.flare_sizes_count_duplicate.borrow()
    }
}

/**
 * Offset to flare positions array (floats, 0.0-1.0 along light ray)
 */
impl Mdl_LightHeader {
    pub fn flare_positions_offset(&self) -> Ref<'_, u32> {
        self.flare_positions_offset.borrow()
    }
}

/**
 * Number of flare position entries
 */
impl Mdl_LightHeader {
    pub fn flare_positions_count(&self) -> Ref<'_, u32> {
        self.flare_positions_count.borrow()
    }
}

/**
 * Duplicate of flare positions count
 */
impl Mdl_LightHeader {
    pub fn flare_positions_count_duplicate(&self) -> Ref<'_, u32> {
        self.flare_positions_count_duplicate.borrow()
    }
}

/**
 * Offset to flare color shift array (RGB floats)
 */
impl Mdl_LightHeader {
    pub fn flare_color_shifts_offset(&self) -> Ref<'_, u32> {
        self.flare_color_shifts_offset.borrow()
    }
}

/**
 * Number of flare color shift entries
 */
impl Mdl_LightHeader {
    pub fn flare_color_shifts_count(&self) -> Ref<'_, u32> {
        self.flare_color_shifts_count.borrow()
    }
}

/**
 * Duplicate of flare color shifts count
 */
impl Mdl_LightHeader {
    pub fn flare_color_shifts_count_duplicate(&self) -> Ref<'_, u32> {
        self.flare_color_shifts_count_duplicate.borrow()
    }
}

/**
 * Offset to flare texture name string offsets array
 */
impl Mdl_LightHeader {
    pub fn flare_texture_names_offset(&self) -> Ref<'_, u32> {
        self.flare_texture_names_offset.borrow()
    }
}

/**
 * Number of flare texture names
 */
impl Mdl_LightHeader {
    pub fn flare_texture_names_count(&self) -> Ref<'_, u32> {
        self.flare_texture_names_count.borrow()
    }
}

/**
 * Duplicate of flare texture names count
 */
impl Mdl_LightHeader {
    pub fn flare_texture_names_count_duplicate(&self) -> Ref<'_, u32> {
        self.flare_texture_names_count_duplicate.borrow()
    }
}

/**
 * Radius of flare effect
 */
impl Mdl_LightHeader {
    pub fn flare_radius(&self) -> Ref<'_, f32> {
        self.flare_radius.borrow()
    }
}

/**
 * Rendering priority for light culling/sorting
 */
impl Mdl_LightHeader {
    pub fn light_priority(&self) -> Ref<'_, u32> {
        self.light_priority.borrow()
    }
}

/**
 * 1 if light only affects ambient, 0 for full lighting
 */
impl Mdl_LightHeader {
    pub fn ambient_only(&self) -> Ref<'_, u32> {
        self.ambient_only.borrow()
    }
}

/**
 * Type of dynamic lighting behavior
 */
impl Mdl_LightHeader {
    pub fn dynamic_type(&self) -> Ref<'_, u32> {
        self.dynamic_type.borrow()
    }
}

/**
 * 1 if light affects dynamic objects, 0 otherwise
 */
impl Mdl_LightHeader {
    pub fn affect_dynamic(&self) -> Ref<'_, u32> {
        self.affect_dynamic.borrow()
    }
}

/**
 * 1 if light casts shadows, 0 otherwise
 */
impl Mdl_LightHeader {
    pub fn shadow(&self) -> Ref<'_, u32> {
        self.shadow.borrow()
    }
}

/**
 * 1 if lens flare effect enabled, 0 otherwise
 */
impl Mdl_LightHeader {
    pub fn flare(&self) -> Ref<'_, u32> {
        self.flare.borrow()
    }
}

/**
 * 1 if light intensity fades with distance, 0 otherwise
 */
impl Mdl_LightHeader {
    pub fn fading_light(&self) -> Ref<'_, u32> {
        self.fading_light.borrow()
    }
}
impl Mdl_LightHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_LightsaberHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    trimesh_base: RefCell<OptRc<Mdl_TrimeshHeader>>,
    vertices_offset: RefCell<u32>,
    texcoords_offset: RefCell<u32>,
    normals_offset: RefCell<u32>,
    unknown1: RefCell<u32>,
    unknown2: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_LightsaberHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.trimesh_base.borrow_mut() = t;
        *self_rc.vertices_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.texcoords_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.normals_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown2.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_LightsaberHeader {
}

/**
 * Standard trimesh header
 */
impl Mdl_LightsaberHeader {
    pub fn trimesh_base(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_base.borrow()
    }
}

/**
 * Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
 */
impl Mdl_LightsaberHeader {
    pub fn vertices_offset(&self) -> Ref<'_, u32> {
        self.vertices_offset.borrow()
    }
}

/**
 * Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
 */
impl Mdl_LightsaberHeader {
    pub fn texcoords_offset(&self) -> Ref<'_, u32> {
        self.texcoords_offset.borrow()
    }
}

/**
 * Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
 */
impl Mdl_LightsaberHeader {
    pub fn normals_offset(&self) -> Ref<'_, u32> {
        self.normals_offset.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_LightsaberHeader {
    pub fn unknown1(&self) -> Ref<'_, u32> {
        self.unknown1.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_LightsaberHeader {
    pub fn unknown2(&self) -> Ref<'_, u32> {
        self.unknown2.borrow()
    }
}
impl Mdl_LightsaberHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
 * Wraps the header so repeated root instances can use parametric types (user guide).
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_MdlAnimationEntry {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    anim_index: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_header: Cell<bool>,
    header: RefCell<OptRc<Mdl_AnimationHeader>>,
}
impl KStruct for Mdl_MdlAnimationEntry {
    type Root = Mdl;
    type Parent = Mdl;

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
impl Mdl_MdlAnimationEntry {
    pub fn anim_index(&self) -> Ref<'_, u32> {
        self.anim_index.borrow()
    }
}
impl Mdl_MdlAnimationEntry {
    pub fn set_params(&mut self, anim_index: u32) {
        *self.anim_index.borrow_mut() = anim_index;
    }
}
impl Mdl_MdlAnimationEntry {
    pub fn header(
        &self
    ) -> KResult<Ref<'_, OptRc<Mdl_AnimationHeader>>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_header.get() {
            return Ok(self.header.borrow());
        }
        let _pos = _io.pos();
        _io.seek(((*_r.data_start()? as u32) + (_r.animation_offsets()?[*self.anim_index() as usize] as u32)) as usize)?;
        let t = Self::read_into::<_, Mdl_AnimationHeader>(&*_io, Some(self._root.clone()), Some(self._self.clone()))?.into();
        *self.header.borrow_mut() = t;
        _io.seek(_pos)?;
        Ok(self.header.borrow())
    }
}
impl Mdl_MdlAnimationEntry {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Model header (196 bytes) starting at offset 12 (data_start).
 * This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
 * model-wide metadata, offsets, and counts.
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_ModelHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    geometry: RefCell<OptRc<Mdl_GeometryHeader>>,
    model_type: RefCell<BiowareMdlCommon_ModelClassification>,
    unknown0: RefCell<u8>,
    padding0: RefCell<u8>,
    fog: RefCell<u8>,
    unknown1: RefCell<u32>,
    offset_to_animations: RefCell<u32>,
    animation_count: RefCell<u32>,
    animation_count2: RefCell<u32>,
    unknown2: RefCell<u32>,
    bounding_box_min: RefCell<OptRc<Mdl_Vec3f>>,
    bounding_box_max: RefCell<OptRc<Mdl_Vec3f>>,
    radius: RefCell<f32>,
    animation_scale: RefCell<f32>,
    supermodel_name: RefCell<String>,
    offset_to_super_root: RefCell<u32>,
    unknown3: RefCell<u32>,
    mdx_data_size: RefCell<u32>,
    mdx_data_offset: RefCell<u32>,
    offset_to_name_offsets: RefCell<u32>,
    name_offsets_count: RefCell<u32>,
    name_offsets_count2: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_ModelHeader {
    type Root = Mdl;
    type Parent = Mdl;

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
        let t = Self::read_into::<_, Mdl_GeometryHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.geometry.borrow_mut() = t;
        *self_rc.model_type.borrow_mut() = (_io.read_u1()? as i64).try_into()?;
        *self_rc.unknown0.borrow_mut() = _io.read_u1()?.into();
        *self_rc.padding0.borrow_mut() = _io.read_u1()?.into();
        *self_rc.fog.borrow_mut() = _io.read_u1()?.into();
        *self_rc.unknown1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_animations.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.animation_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.animation_count2.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown2.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounding_box_min.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounding_box_max.borrow_mut() = t;
        *self_rc.radius.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.animation_scale.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.supermodel_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.offset_to_super_root.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown3.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_data_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.offset_to_name_offsets.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.name_offsets_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.name_offsets_count2.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_ModelHeader {
}

/**
 * Geometry header (80 bytes)
 */
impl Mdl_ModelHeader {
    pub fn geometry(&self) -> Ref<'_, OptRc<Mdl_GeometryHeader>> {
        self.geometry.borrow()
    }
}

/**
 * Model classification byte
 */
impl Mdl_ModelHeader {
    pub fn model_type(&self) -> Ref<'_, BiowareMdlCommon_ModelClassification> {
        self.model_type.borrow()
    }
}

/**
 * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
 */
impl Mdl_ModelHeader {
    pub fn unknown0(&self) -> Ref<'_, u8> {
        self.unknown0.borrow()
    }
}

/**
 * Padding byte
 */
impl Mdl_ModelHeader {
    pub fn padding0(&self) -> Ref<'_, u8> {
        self.padding0.borrow()
    }
}

/**
 * Fog interaction (1 = affected, 0 = ignore fog)
 */
impl Mdl_ModelHeader {
    pub fn fog(&self) -> Ref<'_, u8> {
        self.fog.borrow()
    }
}

/**
 * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
 */
impl Mdl_ModelHeader {
    pub fn unknown1(&self) -> Ref<'_, u32> {
        self.unknown1.borrow()
    }
}

/**
 * Offset to animation offset array (relative to data_start)
 */
impl Mdl_ModelHeader {
    pub fn offset_to_animations(&self) -> Ref<'_, u32> {
        self.offset_to_animations.borrow()
    }
}

/**
 * Number of animations
 */
impl Mdl_ModelHeader {
    pub fn animation_count(&self) -> Ref<'_, u32> {
        self.animation_count.borrow()
    }
}

/**
 * Duplicate animation count / allocated count
 */
impl Mdl_ModelHeader {
    pub fn animation_count2(&self) -> Ref<'_, u32> {
        self.animation_count2.borrow()
    }
}

/**
 * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
 */
impl Mdl_ModelHeader {
    pub fn unknown2(&self) -> Ref<'_, u32> {
        self.unknown2.borrow()
    }
}

/**
 * Minimum coordinates of bounding box (X, Y, Z)
 */
impl Mdl_ModelHeader {
    pub fn bounding_box_min(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.bounding_box_min.borrow()
    }
}

/**
 * Maximum coordinates of bounding box (X, Y, Z)
 */
impl Mdl_ModelHeader {
    pub fn bounding_box_max(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.bounding_box_max.borrow()
    }
}

/**
 * Radius of model's bounding sphere
 */
impl Mdl_ModelHeader {
    pub fn radius(&self) -> Ref<'_, f32> {
        self.radius.borrow()
    }
}

/**
 * Scale factor for animations (typically 1.0)
 */
impl Mdl_ModelHeader {
    pub fn animation_scale(&self) -> Ref<'_, f32> {
        self.animation_scale.borrow()
    }
}

/**
 * Name of supermodel (null-terminated string, "null" if empty)
 */
impl Mdl_ModelHeader {
    pub fn supermodel_name(&self) -> Ref<'_, String> {
        self.supermodel_name.borrow()
    }
}

/**
 * TODO: VERIFY - offset to super-root node (relative to data_start)
 */
impl Mdl_ModelHeader {
    pub fn offset_to_super_root(&self) -> Ref<'_, u32> {
        self.offset_to_super_root.borrow()
    }
}

/**
 * TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
 */
impl Mdl_ModelHeader {
    pub fn unknown3(&self) -> Ref<'_, u32> {
        self.unknown3.borrow()
    }
}

/**
 * Size of MDX file data in bytes
 */
impl Mdl_ModelHeader {
    pub fn mdx_data_size(&self) -> Ref<'_, u32> {
        self.mdx_data_size.borrow()
    }
}

/**
 * Offset to MDX data (typically 0)
 */
impl Mdl_ModelHeader {
    pub fn mdx_data_offset(&self) -> Ref<'_, u32> {
        self.mdx_data_offset.borrow()
    }
}

/**
 * Offset to name offset array (relative to data_start)
 */
impl Mdl_ModelHeader {
    pub fn offset_to_name_offsets(&self) -> Ref<'_, u32> {
        self.offset_to_name_offsets.borrow()
    }
}

/**
 * Count of name offsets / partnames
 */
impl Mdl_ModelHeader {
    pub fn name_offsets_count(&self) -> Ref<'_, u32> {
        self.name_offsets_count.borrow()
    }
}

/**
 * Duplicate name offsets count / allocated count
 */
impl Mdl_ModelHeader {
    pub fn name_offsets_count2(&self) -> Ref<'_, u32> {
        self.name_offsets_count2.borrow()
    }
}
impl Mdl_ModelHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Array of null-terminated name strings
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_NameStrings {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    strings: RefCell<Vec<String>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_NameStrings {
    type Root = Mdl;
    type Parent = Mdl;

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
        *self_rc.strings.borrow_mut() = Vec::new();
        {
            let mut _i = 0;
            while !_io.is_eof() {
                self_rc.strings.borrow_mut().push(bytes_to_str(&_io.read_bytes_term(0, false, true, true)?.into(), "ASCII")?);
                _i += 1;
            }
        }
        Ok(())
    }
}
impl Mdl_NameStrings {
}
impl Mdl_NameStrings {
    pub fn strings(&self) -> Ref<'_, Vec<String>> {
        self.strings.borrow()
    }
}
impl Mdl_NameStrings {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Node structure - starts with 80-byte header, followed by type-specific sub-header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_Node {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl>,
    pub _self: SharedType<Self>,
    header: RefCell<OptRc<Mdl_NodeHeader>>,
    light_sub_header: RefCell<OptRc<Mdl_LightHeader>>,
    emitter_sub_header: RefCell<OptRc<Mdl_EmitterHeader>>,
    reference_sub_header: RefCell<OptRc<Mdl_ReferenceHeader>>,
    trimesh_sub_header: RefCell<OptRc<Mdl_TrimeshHeader>>,
    skinmesh_sub_header: RefCell<OptRc<Mdl_SkinmeshHeader>>,
    animmesh_sub_header: RefCell<OptRc<Mdl_AnimmeshHeader>>,
    danglymesh_sub_header: RefCell<OptRc<Mdl_DanglymeshHeader>>,
    aabb_sub_header: RefCell<OptRc<Mdl_AabbHeader>>,
    lightsaber_sub_header: RefCell<OptRc<Mdl_LightsaberHeader>>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_Node {
    type Root = Mdl;
    type Parent = Mdl;

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
        let t = Self::read_into::<_, Mdl_NodeHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.header.borrow_mut() = t;
        if ((*self_rc.header().node_type() as u16) == (3 as u16)) {
            let t = Self::read_into::<_, Mdl_LightHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.light_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as u16) == (5 as u16)) {
            let t = Self::read_into::<_, Mdl_EmitterHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.emitter_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as u16) == (17 as u16)) {
            let t = Self::read_into::<_, Mdl_ReferenceHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.reference_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as u16) == (33 as u16)) {
            let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
            *self_rc.trimesh_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as u16) == (97 as u16)) {
            let t = Self::read_into::<_, Mdl_SkinmeshHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.skinmesh_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as u16) == (161 as u16)) {
            let t = Self::read_into::<_, Mdl_AnimmeshHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.animmesh_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as i32) == (289 as i32)) {
            let t = Self::read_into::<_, Mdl_DanglymeshHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.danglymesh_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as i32) == (545 as i32)) {
            let t = Self::read_into::<_, Mdl_AabbHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.aabb_sub_header.borrow_mut() = t;
        }
        if ((*self_rc.header().node_type() as i32) == (2081 as i32)) {
            let t = Self::read_into::<_, Mdl_LightsaberHeader>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
            *self_rc.lightsaber_sub_header.borrow_mut() = t;
        }
        Ok(())
    }
}
impl Mdl_Node {
}
impl Mdl_Node {
    pub fn header(&self) -> Ref<'_, OptRc<Mdl_NodeHeader>> {
        self.header.borrow()
    }
}
impl Mdl_Node {
    pub fn light_sub_header(&self) -> Ref<'_, OptRc<Mdl_LightHeader>> {
        self.light_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn emitter_sub_header(&self) -> Ref<'_, OptRc<Mdl_EmitterHeader>> {
        self.emitter_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn reference_sub_header(&self) -> Ref<'_, OptRc<Mdl_ReferenceHeader>> {
        self.reference_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn trimesh_sub_header(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn skinmesh_sub_header(&self) -> Ref<'_, OptRc<Mdl_SkinmeshHeader>> {
        self.skinmesh_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn animmesh_sub_header(&self) -> Ref<'_, OptRc<Mdl_AnimmeshHeader>> {
        self.animmesh_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn danglymesh_sub_header(&self) -> Ref<'_, OptRc<Mdl_DanglymeshHeader>> {
        self.danglymesh_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn aabb_sub_header(&self) -> Ref<'_, OptRc<Mdl_AabbHeader>> {
        self.aabb_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn lightsaber_sub_header(&self) -> Ref<'_, OptRc<Mdl_LightsaberHeader>> {
        self.lightsaber_sub_header.borrow()
    }
}
impl Mdl_Node {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Node header (80 bytes) - present in all node types
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_NodeHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    node_type: RefCell<u16>,
    node_index: RefCell<u16>,
    node_name_index: RefCell<u16>,
    padding: RefCell<u16>,
    root_node_offset: RefCell<u32>,
    parent_node_offset: RefCell<u32>,
    position: RefCell<OptRc<Mdl_Vec3f>>,
    orientation: RefCell<OptRc<Mdl_Quaternion>>,
    child_array_offset: RefCell<u32>,
    child_count: RefCell<u32>,
    child_count_duplicate: RefCell<u32>,
    controller_array_offset: RefCell<u32>,
    controller_count: RefCell<u32>,
    controller_count_duplicate: RefCell<u32>,
    controller_data_offset: RefCell<u32>,
    controller_data_count: RefCell<u32>,
    controller_data_count_duplicate: RefCell<u32>,
    _io: RefCell<BytesReader>,
    f_has_aabb: Cell<bool>,
    has_aabb: RefCell<bool>,
    f_has_anim: Cell<bool>,
    has_anim: RefCell<bool>,
    f_has_dangly: Cell<bool>,
    has_dangly: RefCell<bool>,
    f_has_emitter: Cell<bool>,
    has_emitter: RefCell<bool>,
    f_has_light: Cell<bool>,
    has_light: RefCell<bool>,
    f_has_mesh: Cell<bool>,
    has_mesh: RefCell<bool>,
    f_has_reference: Cell<bool>,
    has_reference: RefCell<bool>,
    f_has_saber: Cell<bool>,
    has_saber: RefCell<bool>,
    f_has_skin: Cell<bool>,
    has_skin: RefCell<bool>,
}
impl KStruct for Mdl_NodeHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        *self_rc.node_type.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.node_index.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.node_name_index.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.padding.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.root_node_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.parent_node_offset.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.position.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_Quaternion>(&*_io, Some(self_rc._root.clone()), Some(self_rc._self.clone()))?.into();
        *self_rc.orientation.borrow_mut() = t;
        *self_rc.child_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.child_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.child_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_data_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.controller_data_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_NodeHeader {
    pub fn has_aabb(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_aabb.get() {
            return Ok(self.has_aabb.borrow());
        }
        self.f_has_aabb.set(true);
        *self.has_aabb.borrow_mut() = (((((*self.node_type() as i32) & (512 as i32)) as i32) != (0 as i32))) as bool;
        Ok(self.has_aabb.borrow())
    }
    pub fn has_anim(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_anim.get() {
            return Ok(self.has_anim.borrow());
        }
        self.f_has_anim.set(true);
        *self.has_anim.borrow_mut() = (((((*self.node_type() as u16) & (128 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_anim.borrow())
    }
    pub fn has_dangly(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_dangly.get() {
            return Ok(self.has_dangly.borrow());
        }
        self.f_has_dangly.set(true);
        *self.has_dangly.borrow_mut() = (((((*self.node_type() as i32) & (256 as i32)) as i32) != (0 as i32))) as bool;
        Ok(self.has_dangly.borrow())
    }
    pub fn has_emitter(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_emitter.get() {
            return Ok(self.has_emitter.borrow());
        }
        self.f_has_emitter.set(true);
        *self.has_emitter.borrow_mut() = (((((*self.node_type() as u16) & (4 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_emitter.borrow())
    }
    pub fn has_light(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_light.get() {
            return Ok(self.has_light.borrow());
        }
        self.f_has_light.set(true);
        *self.has_light.borrow_mut() = (((((*self.node_type() as u16) & (2 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_light.borrow())
    }
    pub fn has_mesh(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_mesh.get() {
            return Ok(self.has_mesh.borrow());
        }
        self.f_has_mesh.set(true);
        *self.has_mesh.borrow_mut() = (((((*self.node_type() as u16) & (32 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_mesh.borrow())
    }
    pub fn has_reference(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_reference.get() {
            return Ok(self.has_reference.borrow());
        }
        self.f_has_reference.set(true);
        *self.has_reference.borrow_mut() = (((((*self.node_type() as u16) & (16 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_reference.borrow())
    }
    pub fn has_saber(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_saber.get() {
            return Ok(self.has_saber.borrow());
        }
        self.f_has_saber.set(true);
        *self.has_saber.borrow_mut() = (((((*self.node_type() as i32) & (2048 as i32)) as i32) != (0 as i32))) as bool;
        Ok(self.has_saber.borrow())
    }
    pub fn has_skin(
        &self
    ) -> KResult<Ref<'_, bool>> {
        let _io = self._io.borrow();
        let _rrc = self._root.get_value().borrow().upgrade();
        let _prc = self._parent.get_value().borrow().upgrade();
        let _r = _rrc.as_ref().unwrap();
        if self.f_has_skin.get() {
            return Ok(self.has_skin.borrow());
        }
        self.f_has_skin.set(true);
        *self.has_skin.borrow_mut() = (((((*self.node_type() as u16) & (64 as u16)) as i32) != (0 as i32))) as bool;
        Ok(self.has_skin.borrow())
    }
}

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
impl Mdl_NodeHeader {
    pub fn node_type(&self) -> Ref<'_, u16> {
        self.node_type.borrow()
    }
}

/**
 * Sequential index of this node in the model
 */
impl Mdl_NodeHeader {
    pub fn node_index(&self) -> Ref<'_, u16> {
        self.node_index.borrow()
    }
}

/**
 * Index into names array for this node's name
 */
impl Mdl_NodeHeader {
    pub fn node_name_index(&self) -> Ref<'_, u16> {
        self.node_name_index.borrow()
    }
}

/**
 * Padding for alignment
 */
impl Mdl_NodeHeader {
    pub fn padding(&self) -> Ref<'_, u16> {
        self.padding.borrow()
    }
}

/**
 * Offset to model's root node
 */
impl Mdl_NodeHeader {
    pub fn root_node_offset(&self) -> Ref<'_, u32> {
        self.root_node_offset.borrow()
    }
}

/**
 * Offset to this node's parent node (0 if root)
 */
impl Mdl_NodeHeader {
    pub fn parent_node_offset(&self) -> Ref<'_, u32> {
        self.parent_node_offset.borrow()
    }
}

/**
 * Node position in local space (X, Y, Z)
 */
impl Mdl_NodeHeader {
    pub fn position(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.position.borrow()
    }
}

/**
 * Node orientation as quaternion (W, X, Y, Z)
 */
impl Mdl_NodeHeader {
    pub fn orientation(&self) -> Ref<'_, OptRc<Mdl_Quaternion>> {
        self.orientation.borrow()
    }
}

/**
 * Offset to array of child node offsets
 */
impl Mdl_NodeHeader {
    pub fn child_array_offset(&self) -> Ref<'_, u32> {
        self.child_array_offset.borrow()
    }
}

/**
 * Number of child nodes
 */
impl Mdl_NodeHeader {
    pub fn child_count(&self) -> Ref<'_, u32> {
        self.child_count.borrow()
    }
}

/**
 * Duplicate value of child count
 */
impl Mdl_NodeHeader {
    pub fn child_count_duplicate(&self) -> Ref<'_, u32> {
        self.child_count_duplicate.borrow()
    }
}

/**
 * Offset to array of controller structures
 */
impl Mdl_NodeHeader {
    pub fn controller_array_offset(&self) -> Ref<'_, u32> {
        self.controller_array_offset.borrow()
    }
}

/**
 * Number of controllers attached to this node
 */
impl Mdl_NodeHeader {
    pub fn controller_count(&self) -> Ref<'_, u32> {
        self.controller_count.borrow()
    }
}

/**
 * Duplicate value of controller count
 */
impl Mdl_NodeHeader {
    pub fn controller_count_duplicate(&self) -> Ref<'_, u32> {
        self.controller_count_duplicate.borrow()
    }
}

/**
 * Offset to controller keyframe/data array
 */
impl Mdl_NodeHeader {
    pub fn controller_data_offset(&self) -> Ref<'_, u32> {
        self.controller_data_offset.borrow()
    }
}

/**
 * Number of floats in controller data array
 */
impl Mdl_NodeHeader {
    pub fn controller_data_count(&self) -> Ref<'_, u32> {
        self.controller_data_count.borrow()
    }
}

/**
 * Duplicate value of controller data count
 */
impl Mdl_NodeHeader {
    pub fn controller_data_count_duplicate(&self) -> Ref<'_, u32> {
        self.controller_data_count_duplicate.borrow()
    }
}
impl Mdl_NodeHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Quaternion rotation (4 floats W, X, Y, Z)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_Quaternion {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_NodeHeader>,
    pub _self: SharedType<Self>,
    w: RefCell<f32>,
    x: RefCell<f32>,
    y: RefCell<f32>,
    z: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_Quaternion {
    type Root = Mdl;
    type Parent = Mdl_NodeHeader;

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
        *self_rc.w.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.x.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.y.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.z.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl Mdl_Quaternion {
}
impl Mdl_Quaternion {
    pub fn w(&self) -> Ref<'_, f32> {
        self.w.borrow()
    }
}
impl Mdl_Quaternion {
    pub fn x(&self) -> Ref<'_, f32> {
        self.x.borrow()
    }
}
impl Mdl_Quaternion {
    pub fn y(&self) -> Ref<'_, f32> {
        self.y.borrow()
    }
}
impl Mdl_Quaternion {
    pub fn z(&self) -> Ref<'_, f32> {
        self.z.borrow()
    }
}
impl Mdl_Quaternion {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Reference header (36 bytes)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_ReferenceHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    model_resref: RefCell<String>,
    reattachable: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_ReferenceHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        *self_rc.model_resref.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.reattachable.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_ReferenceHeader {
}

/**
 * Referenced model resource name without extension (null-terminated string)
 */
impl Mdl_ReferenceHeader {
    pub fn model_resref(&self) -> Ref<'_, String> {
        self.model_resref.borrow()
    }
}

/**
 * 1 if model can be detached and reattached dynamically, 0 if permanent
 */
impl Mdl_ReferenceHeader {
    pub fn reattachable(&self) -> Ref<'_, u32> {
        self.reattachable.borrow()
    }
}
impl Mdl_ReferenceHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_SkinmeshHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<Mdl_Node>,
    pub _self: SharedType<Self>,
    trimesh_base: RefCell<OptRc<Mdl_TrimeshHeader>>,
    unknown_weights: RefCell<i32>,
    padding1: RefCell<Vec<u8>>,
    mdx_bone_weights_offset: RefCell<u32>,
    mdx_bone_indices_offset: RefCell<u32>,
    bone_map_offset: RefCell<u32>,
    bone_map_count: RefCell<u32>,
    qbones_offset: RefCell<u32>,
    qbones_count: RefCell<u32>,
    qbones_count_duplicate: RefCell<u32>,
    tbones_offset: RefCell<u32>,
    tbones_count: RefCell<u32>,
    tbones_count_duplicate: RefCell<u32>,
    unknown_array: RefCell<u32>,
    bone_node_serial_numbers: RefCell<Vec<u16>>,
    padding2: RefCell<u16>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_SkinmeshHeader {
    type Root = Mdl;
    type Parent = Mdl_Node;

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
        let t = Self::read_into::<_, Mdl_TrimeshHeader>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.trimesh_base.borrow_mut() = t;
        *self_rc.unknown_weights.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.padding1.borrow_mut() = Vec::new();
        let l_padding1 = 8;
        for _i in 0..l_padding1 {
            self_rc.padding1.borrow_mut().push(_io.read_u1()?.into());
        }
        *self_rc.mdx_bone_weights_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_bone_indices_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.bone_map_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.bone_map_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.qbones_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.qbones_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.qbones_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.tbones_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.tbones_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.tbones_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown_array.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.bone_node_serial_numbers.borrow_mut() = Vec::new();
        let l_bone_node_serial_numbers = 16;
        for _i in 0..l_bone_node_serial_numbers {
            self_rc.bone_node_serial_numbers.borrow_mut().push(_io.read_u2le()?.into());
        }
        *self_rc.padding2.borrow_mut() = _io.read_u2le()?.into();
        Ok(())
    }
}
impl Mdl_SkinmeshHeader {
}

/**
 * Standard trimesh header
 */
impl Mdl_SkinmeshHeader {
    pub fn trimesh_base(&self) -> Ref<'_, OptRc<Mdl_TrimeshHeader>> {
        self.trimesh_base.borrow()
    }
}

/**
 * Purpose unknown (possibly compilation weights)
 */
impl Mdl_SkinmeshHeader {
    pub fn unknown_weights(&self) -> Ref<'_, i32> {
        self.unknown_weights.borrow()
    }
}

/**
 * Padding
 */
impl Mdl_SkinmeshHeader {
    pub fn padding1(&self) -> Ref<'_, Vec<u8>> {
        self.padding1.borrow()
    }
}

/**
 * Offset to bone weight data in MDX file (4 floats per vertex)
 */
impl Mdl_SkinmeshHeader {
    pub fn mdx_bone_weights_offset(&self) -> Ref<'_, u32> {
        self.mdx_bone_weights_offset.borrow()
    }
}

/**
 * Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
 */
impl Mdl_SkinmeshHeader {
    pub fn mdx_bone_indices_offset(&self) -> Ref<'_, u32> {
        self.mdx_bone_indices_offset.borrow()
    }
}

/**
 * Offset to bone map array (maps local bone indices to skeleton bone numbers)
 */
impl Mdl_SkinmeshHeader {
    pub fn bone_map_offset(&self) -> Ref<'_, u32> {
        self.bone_map_offset.borrow()
    }
}

/**
 * Number of bones referenced by this mesh (max 16)
 */
impl Mdl_SkinmeshHeader {
    pub fn bone_map_count(&self) -> Ref<'_, u32> {
        self.bone_map_count.borrow()
    }
}

/**
 * Offset to quaternion bind pose array (4 floats per bone)
 */
impl Mdl_SkinmeshHeader {
    pub fn qbones_offset(&self) -> Ref<'_, u32> {
        self.qbones_offset.borrow()
    }
}

/**
 * Number of quaternion bind poses
 */
impl Mdl_SkinmeshHeader {
    pub fn qbones_count(&self) -> Ref<'_, u32> {
        self.qbones_count.borrow()
    }
}

/**
 * Duplicate of QBones count
 */
impl Mdl_SkinmeshHeader {
    pub fn qbones_count_duplicate(&self) -> Ref<'_, u32> {
        self.qbones_count_duplicate.borrow()
    }
}

/**
 * Offset to translation bind pose array (3 floats per bone)
 */
impl Mdl_SkinmeshHeader {
    pub fn tbones_offset(&self) -> Ref<'_, u32> {
        self.tbones_offset.borrow()
    }
}

/**
 * Number of translation bind poses
 */
impl Mdl_SkinmeshHeader {
    pub fn tbones_count(&self) -> Ref<'_, u32> {
        self.tbones_count.borrow()
    }
}

/**
 * Duplicate of TBones count
 */
impl Mdl_SkinmeshHeader {
    pub fn tbones_count_duplicate(&self) -> Ref<'_, u32> {
        self.tbones_count_duplicate.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_SkinmeshHeader {
    pub fn unknown_array(&self) -> Ref<'_, u32> {
        self.unknown_array.borrow()
    }
}

/**
 * Serial indices of bone nodes (0xFFFF for unused slots)
 */
impl Mdl_SkinmeshHeader {
    pub fn bone_node_serial_numbers(&self) -> Ref<'_, Vec<u16>> {
        self.bone_node_serial_numbers.borrow()
    }
}

/**
 * Padding for alignment
 */
impl Mdl_SkinmeshHeader {
    pub fn padding2(&self) -> Ref<'_, u16> {
        self.padding2.borrow()
    }
}
impl Mdl_SkinmeshHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_TrimeshHeader {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    function_pointer_0: RefCell<u32>,
    function_pointer_1: RefCell<u32>,
    faces_array_offset: RefCell<u32>,
    faces_count: RefCell<u32>,
    faces_count_duplicate: RefCell<u32>,
    bounding_box_min: RefCell<OptRc<Mdl_Vec3f>>,
    bounding_box_max: RefCell<OptRc<Mdl_Vec3f>>,
    radius: RefCell<f32>,
    average_point: RefCell<OptRc<Mdl_Vec3f>>,
    diffuse_color: RefCell<OptRc<Mdl_Vec3f>>,
    ambient_color: RefCell<OptRc<Mdl_Vec3f>>,
    transparency_hint: RefCell<u32>,
    texture_0_name: RefCell<String>,
    texture_1_name: RefCell<String>,
    texture_2_name: RefCell<String>,
    texture_3_name: RefCell<String>,
    indices_count_array_offset: RefCell<u32>,
    indices_count_array_count: RefCell<u32>,
    indices_count_array_count_duplicate: RefCell<u32>,
    indices_offset_array_offset: RefCell<u32>,
    indices_offset_array_count: RefCell<u32>,
    indices_offset_array_count_duplicate: RefCell<u32>,
    inverted_counter_array_offset: RefCell<u32>,
    inverted_counter_array_count: RefCell<u32>,
    inverted_counter_array_count_duplicate: RefCell<u32>,
    unknown_values: RefCell<Vec<i32>>,
    saber_unknown_data: RefCell<Vec<u8>>,
    unknown: RefCell<u32>,
    uv_direction: RefCell<OptRc<Mdl_Vec3f>>,
    uv_jitter: RefCell<f32>,
    uv_jitter_speed: RefCell<f32>,
    mdx_vertex_size: RefCell<u32>,
    mdx_data_flags: RefCell<u32>,
    mdx_vertices_offset: RefCell<i32>,
    mdx_normals_offset: RefCell<i32>,
    mdx_vertex_colors_offset: RefCell<i32>,
    mdx_tex0_uvs_offset: RefCell<i32>,
    mdx_tex1_uvs_offset: RefCell<i32>,
    mdx_tex2_uvs_offset: RefCell<i32>,
    mdx_tex3_uvs_offset: RefCell<i32>,
    mdx_tangent_space_offset: RefCell<i32>,
    mdx_unknown_offset_1: RefCell<i32>,
    mdx_unknown_offset_2: RefCell<i32>,
    mdx_unknown_offset_3: RefCell<i32>,
    vertex_count: RefCell<u16>,
    texture_count: RefCell<u16>,
    lightmapped: RefCell<u8>,
    rotate_texture: RefCell<u8>,
    background_geometry: RefCell<u8>,
    shadow: RefCell<u8>,
    beaming: RefCell<u8>,
    render: RefCell<u8>,
    unknown_flag: RefCell<u8>,
    padding: RefCell<u8>,
    total_area: RefCell<f32>,
    unknown2: RefCell<u32>,
    k2_unknown_1: RefCell<u32>,
    k2_unknown_2: RefCell<u32>,
    mdx_data_offset: RefCell<u32>,
    mdl_vertices_offset: RefCell<u32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_TrimeshHeader {
    type Root = Mdl;
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
        *self_rc.function_pointer_0.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.function_pointer_1.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.faces_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.faces_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.faces_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounding_box_min.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.bounding_box_max.borrow_mut() = t;
        *self_rc.radius.borrow_mut() = _io.read_f4le()?.into();
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.average_point.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.diffuse_color.borrow_mut() = t;
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.ambient_color.borrow_mut() = t;
        *self_rc.transparency_hint.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.texture_0_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.texture_1_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(32 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.texture_2_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(12 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.texture_3_name.borrow_mut() = bytes_to_str(&bytes_terminate(&_io.read_bytes(12 as usize)?.into(), 0, false).into(), "ASCII")?;
        *self_rc.indices_count_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.indices_count_array_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.indices_count_array_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.indices_offset_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.indices_offset_array_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.indices_offset_array_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.inverted_counter_array_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.inverted_counter_array_count.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.inverted_counter_array_count_duplicate.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.unknown_values.borrow_mut() = Vec::new();
        let l_unknown_values = 3;
        for _i in 0..l_unknown_values {
            self_rc.unknown_values.borrow_mut().push(_io.read_s4le()?.into());
        }
        *self_rc.saber_unknown_data.borrow_mut() = Vec::new();
        let l_saber_unknown_data = 8;
        for _i in 0..l_saber_unknown_data {
            self_rc.saber_unknown_data.borrow_mut().push(_io.read_u1()?.into());
        }
        *self_rc.unknown.borrow_mut() = _io.read_u4le()?.into();
        let t = Self::read_into::<_, Mdl_Vec3f>(&*_io, Some(self_rc._root.clone()), None)?.into();
        *self_rc.uv_direction.borrow_mut() = t;
        *self_rc.uv_jitter.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.uv_jitter_speed.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.mdx_vertex_size.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_data_flags.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdx_vertices_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_normals_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_vertex_colors_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_tex0_uvs_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_tex1_uvs_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_tex2_uvs_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_tex3_uvs_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_tangent_space_offset.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_unknown_offset_1.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_unknown_offset_2.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.mdx_unknown_offset_3.borrow_mut() = _io.read_s4le()?.into();
        *self_rc.vertex_count.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.texture_count.borrow_mut() = _io.read_u2le()?.into();
        *self_rc.lightmapped.borrow_mut() = _io.read_u1()?.into();
        *self_rc.rotate_texture.borrow_mut() = _io.read_u1()?.into();
        *self_rc.background_geometry.borrow_mut() = _io.read_u1()?.into();
        *self_rc.shadow.borrow_mut() = _io.read_u1()?.into();
        *self_rc.beaming.borrow_mut() = _io.read_u1()?.into();
        *self_rc.render.borrow_mut() = _io.read_u1()?.into();
        *self_rc.unknown_flag.borrow_mut() = _io.read_u1()?.into();
        *self_rc.padding.borrow_mut() = _io.read_u1()?.into();
        *self_rc.total_area.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.unknown2.borrow_mut() = _io.read_u4le()?.into();
        if *_r.model_header().geometry().is_kotor2()? {
            *self_rc.k2_unknown_1.borrow_mut() = _io.read_u4le()?.into();
        }
        if *_r.model_header().geometry().is_kotor2()? {
            *self_rc.k2_unknown_2.borrow_mut() = _io.read_u4le()?.into();
        }
        *self_rc.mdx_data_offset.borrow_mut() = _io.read_u4le()?.into();
        *self_rc.mdl_vertices_offset.borrow_mut() = _io.read_u4le()?.into();
        Ok(())
    }
}
impl Mdl_TrimeshHeader {
}

/**
 * Game engine function pointer (version-specific)
 */
impl Mdl_TrimeshHeader {
    pub fn function_pointer_0(&self) -> Ref<'_, u32> {
        self.function_pointer_0.borrow()
    }
}

/**
 * Secondary game engine function pointer
 */
impl Mdl_TrimeshHeader {
    pub fn function_pointer_1(&self) -> Ref<'_, u32> {
        self.function_pointer_1.borrow()
    }
}

/**
 * Offset to face definitions array
 */
impl Mdl_TrimeshHeader {
    pub fn faces_array_offset(&self) -> Ref<'_, u32> {
        self.faces_array_offset.borrow()
    }
}

/**
 * Number of triangular faces in mesh
 */
impl Mdl_TrimeshHeader {
    pub fn faces_count(&self) -> Ref<'_, u32> {
        self.faces_count.borrow()
    }
}

/**
 * Duplicate of faces count
 */
impl Mdl_TrimeshHeader {
    pub fn faces_count_duplicate(&self) -> Ref<'_, u32> {
        self.faces_count_duplicate.borrow()
    }
}

/**
 * Minimum bounding box coordinates (X, Y, Z)
 */
impl Mdl_TrimeshHeader {
    pub fn bounding_box_min(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.bounding_box_min.borrow()
    }
}

/**
 * Maximum bounding box coordinates (X, Y, Z)
 */
impl Mdl_TrimeshHeader {
    pub fn bounding_box_max(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.bounding_box_max.borrow()
    }
}

/**
 * Bounding sphere radius
 */
impl Mdl_TrimeshHeader {
    pub fn radius(&self) -> Ref<'_, f32> {
        self.radius.borrow()
    }
}

/**
 * Average vertex position (centroid) X, Y, Z
 */
impl Mdl_TrimeshHeader {
    pub fn average_point(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.average_point.borrow()
    }
}

/**
 * Material diffuse color (R, G, B, range 0.0-1.0)
 */
impl Mdl_TrimeshHeader {
    pub fn diffuse_color(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.diffuse_color.borrow()
    }
}

/**
 * Material ambient color (R, G, B, range 0.0-1.0)
 */
impl Mdl_TrimeshHeader {
    pub fn ambient_color(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.ambient_color.borrow()
    }
}

/**
 * Transparency rendering mode
 */
impl Mdl_TrimeshHeader {
    pub fn transparency_hint(&self) -> Ref<'_, u32> {
        self.transparency_hint.borrow()
    }
}

/**
 * Primary diffuse texture name (null-terminated string)
 */
impl Mdl_TrimeshHeader {
    pub fn texture_0_name(&self) -> Ref<'_, String> {
        self.texture_0_name.borrow()
    }
}

/**
 * Secondary texture name, often lightmap (null-terminated string)
 */
impl Mdl_TrimeshHeader {
    pub fn texture_1_name(&self) -> Ref<'_, String> {
        self.texture_1_name.borrow()
    }
}

/**
 * Tertiary texture name (null-terminated string)
 */
impl Mdl_TrimeshHeader {
    pub fn texture_2_name(&self) -> Ref<'_, String> {
        self.texture_2_name.borrow()
    }
}

/**
 * Quaternary texture name (null-terminated string)
 */
impl Mdl_TrimeshHeader {
    pub fn texture_3_name(&self) -> Ref<'_, String> {
        self.texture_3_name.borrow()
    }
}

/**
 * Offset to vertex indices count array
 */
impl Mdl_TrimeshHeader {
    pub fn indices_count_array_offset(&self) -> Ref<'_, u32> {
        self.indices_count_array_offset.borrow()
    }
}

/**
 * Number of entries in indices count array
 */
impl Mdl_TrimeshHeader {
    pub fn indices_count_array_count(&self) -> Ref<'_, u32> {
        self.indices_count_array_count.borrow()
    }
}

/**
 * Duplicate of indices count array count
 */
impl Mdl_TrimeshHeader {
    pub fn indices_count_array_count_duplicate(&self) -> Ref<'_, u32> {
        self.indices_count_array_count_duplicate.borrow()
    }
}

/**
 * Offset to vertex indices offset array
 */
impl Mdl_TrimeshHeader {
    pub fn indices_offset_array_offset(&self) -> Ref<'_, u32> {
        self.indices_offset_array_offset.borrow()
    }
}

/**
 * Number of entries in indices offset array
 */
impl Mdl_TrimeshHeader {
    pub fn indices_offset_array_count(&self) -> Ref<'_, u32> {
        self.indices_offset_array_count.borrow()
    }
}

/**
 * Duplicate of indices offset array count
 */
impl Mdl_TrimeshHeader {
    pub fn indices_offset_array_count_duplicate(&self) -> Ref<'_, u32> {
        self.indices_offset_array_count_duplicate.borrow()
    }
}

/**
 * Offset to inverted counter array
 */
impl Mdl_TrimeshHeader {
    pub fn inverted_counter_array_offset(&self) -> Ref<'_, u32> {
        self.inverted_counter_array_offset.borrow()
    }
}

/**
 * Number of entries in inverted counter array
 */
impl Mdl_TrimeshHeader {
    pub fn inverted_counter_array_count(&self) -> Ref<'_, u32> {
        self.inverted_counter_array_count.borrow()
    }
}

/**
 * Duplicate of inverted counter array count
 */
impl Mdl_TrimeshHeader {
    pub fn inverted_counter_array_count_duplicate(&self) -> Ref<'_, u32> {
        self.inverted_counter_array_count_duplicate.borrow()
    }
}

/**
 * Typically {-1, -1, 0}, purpose unknown
 */
impl Mdl_TrimeshHeader {
    pub fn unknown_values(&self) -> Ref<'_, Vec<i32>> {
        self.unknown_values.borrow()
    }
}

/**
 * Data specific to lightsaber meshes
 */
impl Mdl_TrimeshHeader {
    pub fn saber_unknown_data(&self) -> Ref<'_, Vec<u8>> {
        self.saber_unknown_data.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_TrimeshHeader {
    pub fn unknown(&self) -> Ref<'_, u32> {
        self.unknown.borrow()
    }
}

/**
 * UV animation direction X, Y components (Z = jitter speed)
 */
impl Mdl_TrimeshHeader {
    pub fn uv_direction(&self) -> Ref<'_, OptRc<Mdl_Vec3f>> {
        self.uv_direction.borrow()
    }
}

/**
 * UV animation jitter amount
 */
impl Mdl_TrimeshHeader {
    pub fn uv_jitter(&self) -> Ref<'_, f32> {
        self.uv_jitter.borrow()
    }
}

/**
 * UV animation jitter speed
 */
impl Mdl_TrimeshHeader {
    pub fn uv_jitter_speed(&self) -> Ref<'_, f32> {
        self.uv_jitter_speed.borrow()
    }
}

/**
 * Size in bytes of each vertex in MDX data
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_vertex_size(&self) -> Ref<'_, u32> {
        self.mdx_vertex_size.borrow()
    }
}

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
impl Mdl_TrimeshHeader {
    pub fn mdx_data_flags(&self) -> Ref<'_, u32> {
        self.mdx_data_flags.borrow()
    }
}

/**
 * Relative offset to vertex positions in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_vertices_offset(&self) -> Ref<'_, i32> {
        self.mdx_vertices_offset.borrow()
    }
}

/**
 * Relative offset to vertex normals in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_normals_offset(&self) -> Ref<'_, i32> {
        self.mdx_normals_offset.borrow()
    }
}

/**
 * Relative offset to vertex colors in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_vertex_colors_offset(&self) -> Ref<'_, i32> {
        self.mdx_vertex_colors_offset.borrow()
    }
}

/**
 * Relative offset to primary texture UVs in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_tex0_uvs_offset(&self) -> Ref<'_, i32> {
        self.mdx_tex0_uvs_offset.borrow()
    }
}

/**
 * Relative offset to secondary texture UVs in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_tex1_uvs_offset(&self) -> Ref<'_, i32> {
        self.mdx_tex1_uvs_offset.borrow()
    }
}

/**
 * Relative offset to tertiary texture UVs in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_tex2_uvs_offset(&self) -> Ref<'_, i32> {
        self.mdx_tex2_uvs_offset.borrow()
    }
}

/**
 * Relative offset to quaternary texture UVs in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_tex3_uvs_offset(&self) -> Ref<'_, i32> {
        self.mdx_tex3_uvs_offset.borrow()
    }
}

/**
 * Relative offset to tangent space data in MDX (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_tangent_space_offset(&self) -> Ref<'_, i32> {
        self.mdx_tangent_space_offset.borrow()
    }
}

/**
 * Relative offset to unknown MDX data (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_unknown_offset_1(&self) -> Ref<'_, i32> {
        self.mdx_unknown_offset_1.borrow()
    }
}

/**
 * Relative offset to unknown MDX data (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_unknown_offset_2(&self) -> Ref<'_, i32> {
        self.mdx_unknown_offset_2.borrow()
    }
}

/**
 * Relative offset to unknown MDX data (or -1 if none)
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_unknown_offset_3(&self) -> Ref<'_, i32> {
        self.mdx_unknown_offset_3.borrow()
    }
}

/**
 * Number of vertices in mesh
 */
impl Mdl_TrimeshHeader {
    pub fn vertex_count(&self) -> Ref<'_, u16> {
        self.vertex_count.borrow()
    }
}

/**
 * Number of textures used by mesh
 */
impl Mdl_TrimeshHeader {
    pub fn texture_count(&self) -> Ref<'_, u16> {
        self.texture_count.borrow()
    }
}

/**
 * 1 if mesh uses lightmap, 0 otherwise
 */
impl Mdl_TrimeshHeader {
    pub fn lightmapped(&self) -> Ref<'_, u8> {
        self.lightmapped.borrow()
    }
}

/**
 * 1 if texture should rotate, 0 otherwise
 */
impl Mdl_TrimeshHeader {
    pub fn rotate_texture(&self) -> Ref<'_, u8> {
        self.rotate_texture.borrow()
    }
}

/**
 * 1 if background geometry, 0 otherwise
 */
impl Mdl_TrimeshHeader {
    pub fn background_geometry(&self) -> Ref<'_, u8> {
        self.background_geometry.borrow()
    }
}

/**
 * 1 if mesh casts shadows, 0 otherwise
 */
impl Mdl_TrimeshHeader {
    pub fn shadow(&self) -> Ref<'_, u8> {
        self.shadow.borrow()
    }
}

/**
 * 1 if beaming effect enabled, 0 otherwise
 */
impl Mdl_TrimeshHeader {
    pub fn beaming(&self) -> Ref<'_, u8> {
        self.beaming.borrow()
    }
}

/**
 * 1 if mesh is renderable, 0 if hidden
 */
impl Mdl_TrimeshHeader {
    pub fn render(&self) -> Ref<'_, u8> {
        self.render.borrow()
    }
}

/**
 * Purpose unknown (possibly UV animation enable)
 */
impl Mdl_TrimeshHeader {
    pub fn unknown_flag(&self) -> Ref<'_, u8> {
        self.unknown_flag.borrow()
    }
}

/**
 * Padding byte
 */
impl Mdl_TrimeshHeader {
    pub fn padding(&self) -> Ref<'_, u8> {
        self.padding.borrow()
    }
}

/**
 * Total surface area of all faces
 */
impl Mdl_TrimeshHeader {
    pub fn total_area(&self) -> Ref<'_, f32> {
        self.total_area.borrow()
    }
}

/**
 * Purpose unknown
 */
impl Mdl_TrimeshHeader {
    pub fn unknown2(&self) -> Ref<'_, u32> {
        self.unknown2.borrow()
    }
}

/**
 * KOTOR 2 only: Additional unknown field
 */
impl Mdl_TrimeshHeader {
    pub fn k2_unknown_1(&self) -> Ref<'_, u32> {
        self.k2_unknown_1.borrow()
    }
}

/**
 * KOTOR 2 only: Additional unknown field
 */
impl Mdl_TrimeshHeader {
    pub fn k2_unknown_2(&self) -> Ref<'_, u32> {
        self.k2_unknown_2.borrow()
    }
}

/**
 * Absolute offset to this mesh's vertex data in MDX file
 */
impl Mdl_TrimeshHeader {
    pub fn mdx_data_offset(&self) -> Ref<'_, u32> {
        self.mdx_data_offset.borrow()
    }
}

/**
 * Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
 */
impl Mdl_TrimeshHeader {
    pub fn mdl_vertices_offset(&self) -> Ref<'_, u32> {
        self.mdl_vertices_offset.borrow()
    }
}
impl Mdl_TrimeshHeader {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

/**
 * 3D vector (3 floats)
 */

#[derive(Default, Debug, Clone)]
pub struct Mdl_Vec3f {
    pub _root: SharedType<Mdl>,
    pub _parent: SharedType<KStructUnit>,
    pub _self: SharedType<Self>,
    x: RefCell<f32>,
    y: RefCell<f32>,
    z: RefCell<f32>,
    _io: RefCell<BytesReader>,
}
impl KStruct for Mdl_Vec3f {
    type Root = Mdl;
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
        *self_rc.x.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.y.borrow_mut() = _io.read_f4le()?.into();
        *self_rc.z.borrow_mut() = _io.read_f4le()?.into();
        Ok(())
    }
}
impl Mdl_Vec3f {
}
impl Mdl_Vec3f {
    pub fn x(&self) -> Ref<'_, f32> {
        self.x.borrow()
    }
}
impl Mdl_Vec3f {
    pub fn y(&self) -> Ref<'_, f32> {
        self.y.borrow()
    }
}
impl Mdl_Vec3f {
    pub fn z(&self) -> Ref<'_, f32> {
        self.z.borrow()
    }
}
impl Mdl_Vec3f {
    pub fn _io(&self) -> Ref<'_, BytesReader> {
        self._io.borrow()
    }
}

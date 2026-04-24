import kaitai_struct_nim_runtime
import options
import bioware_mdl_common

type
  Mdl* = ref object of KaitaiStruct
    `fileHeader`*: Mdl_FileHeader
    `modelHeader`*: Mdl_ModelHeader
    `parent`*: KaitaiStruct
    `rawNamesDataInst`*: seq[byte]
    `animationOffsetsInst`: seq[uint32]
    `animationOffsetsInstFlag`: bool
    `animationsInst`: seq[Mdl_MdlAnimationEntry]
    `animationsInstFlag`: bool
    `dataStartInst`: int8
    `dataStartInstFlag`: bool
    `nameOffsetsInst`: seq[uint32]
    `nameOffsetsInstFlag`: bool
    `namesDataInst`: Mdl_NameStrings
    `namesDataInstFlag`: bool
    `rootNodeInst`: Mdl_Node
    `rootNodeInstFlag`: bool
  Mdl_AabbHeader* = ref object of KaitaiStruct
    `trimeshBase`*: Mdl_TrimeshHeader
    `unknown`*: uint32
    `parent`*: Mdl_Node
  Mdl_AnimationEvent* = ref object of KaitaiStruct
    `activationTime`*: float32
    `eventName`*: string
    `parent`*: KaitaiStruct
  Mdl_AnimationHeader* = ref object of KaitaiStruct
    `geoHeader`*: Mdl_GeometryHeader
    `animationLength`*: float32
    `transitionTime`*: float32
    `animationRoot`*: string
    `eventArrayOffset`*: uint32
    `eventCount`*: uint32
    `eventCountDuplicate`*: uint32
    `unknown`*: uint32
    `parent`*: Mdl_MdlAnimationEntry
  Mdl_AnimmeshHeader* = ref object of KaitaiStruct
    `trimeshBase`*: Mdl_TrimeshHeader
    `unknown`*: float32
    `unknownArray`*: Mdl_ArrayDefinition
    `unknownFloats`*: seq[float32]
    `parent`*: Mdl_Node
  Mdl_ArrayDefinition* = ref object of KaitaiStruct
    `offset`*: int32
    `count`*: uint32
    `countDuplicate`*: uint32
    `parent`*: KaitaiStruct
  Mdl_Controller* = ref object of KaitaiStruct
    `type`*: BiowareMdlCommon_ControllerType
    `unknown`*: uint16
    `rowCount`*: uint16
    `timeIndex`*: uint16
    `dataIndex`*: uint16
    `columnCount`*: uint8
    `padding`*: seq[uint8]
    `parent`*: KaitaiStruct
    `usesBezierInst`: bool
    `usesBezierInstFlag`: bool
  Mdl_DanglymeshHeader* = ref object of KaitaiStruct
    `trimeshBase`*: Mdl_TrimeshHeader
    `constraintsOffset`*: uint32
    `constraintsCount`*: uint32
    `constraintsCountDuplicate`*: uint32
    `displacement`*: float32
    `tightness`*: float32
    `period`*: float32
    `unknown`*: uint32
    `parent`*: Mdl_Node
  Mdl_EmitterHeader* = ref object of KaitaiStruct
    `deadSpace`*: float32
    `blastRadius`*: float32
    `blastLength`*: float32
    `branchCount`*: uint32
    `controlPointSmoothing`*: float32
    `xGrid`*: uint32
    `yGrid`*: uint32
    `paddingUnknown`*: uint32
    `updateScript`*: string
    `renderScript`*: string
    `blendScript`*: string
    `textureName`*: string
    `chunkName`*: string
    `twoSidedTexture`*: uint32
    `loop`*: uint32
    `renderOrder`*: uint16
    `frameBlending`*: uint8
    `depthTextureName`*: string
    `padding`*: uint8
    `flags`*: uint32
    `parent`*: Mdl_Node
  Mdl_FileHeader* = ref object of KaitaiStruct
    `unused`*: uint32
    `mdlSize`*: uint32
    `mdxSize`*: uint32
    `parent`*: Mdl
  Mdl_GeometryHeader* = ref object of KaitaiStruct
    `functionPointer0`*: uint32
    `functionPointer1`*: uint32
    `modelName`*: string
    `rootNodeOffset`*: uint32
    `nodeCount`*: uint32
    `unknownArray1`*: Mdl_ArrayDefinition
    `unknownArray2`*: Mdl_ArrayDefinition
    `referenceCount`*: uint32
    `geometryType`*: uint8
    `padding`*: seq[uint8]
    `parent`*: KaitaiStruct
    `isKotor2Inst`: bool
    `isKotor2InstFlag`: bool
  Mdl_LightHeader* = ref object of KaitaiStruct
    `unknown`*: seq[float32]
    `flareSizesOffset`*: uint32
    `flareSizesCount`*: uint32
    `flareSizesCountDuplicate`*: uint32
    `flarePositionsOffset`*: uint32
    `flarePositionsCount`*: uint32
    `flarePositionsCountDuplicate`*: uint32
    `flareColorShiftsOffset`*: uint32
    `flareColorShiftsCount`*: uint32
    `flareColorShiftsCountDuplicate`*: uint32
    `flareTextureNamesOffset`*: uint32
    `flareTextureNamesCount`*: uint32
    `flareTextureNamesCountDuplicate`*: uint32
    `flareRadius`*: float32
    `lightPriority`*: uint32
    `ambientOnly`*: uint32
    `dynamicType`*: uint32
    `affectDynamic`*: uint32
    `shadow`*: uint32
    `flare`*: uint32
    `fadingLight`*: uint32
    `parent`*: Mdl_Node
  Mdl_LightsaberHeader* = ref object of KaitaiStruct
    `trimeshBase`*: Mdl_TrimeshHeader
    `verticesOffset`*: uint32
    `texcoordsOffset`*: uint32
    `normalsOffset`*: uint32
    `unknown1`*: uint32
    `unknown2`*: uint32
    `parent`*: Mdl_Node
  Mdl_MdlAnimationEntry* = ref object of KaitaiStruct
    `animIndex`*: uint32
    `parent`*: Mdl
    `headerInst`: Mdl_AnimationHeader
    `headerInstFlag`: bool
  Mdl_ModelHeader* = ref object of KaitaiStruct
    `geometry`*: Mdl_GeometryHeader
    `modelType`*: BiowareMdlCommon_ModelClassification
    `unknown0`*: uint8
    `padding0`*: uint8
    `fog`*: uint8
    `unknown1`*: uint32
    `offsetToAnimations`*: uint32
    `animationCount`*: uint32
    `animationCount2`*: uint32
    `unknown2`*: uint32
    `boundingBoxMin`*: Mdl_Vec3f
    `boundingBoxMax`*: Mdl_Vec3f
    `radius`*: float32
    `animationScale`*: float32
    `supermodelName`*: string
    `offsetToSuperRoot`*: uint32
    `unknown3`*: uint32
    `mdxDataSize`*: uint32
    `mdxDataOffset`*: uint32
    `offsetToNameOffsets`*: uint32
    `nameOffsetsCount`*: uint32
    `nameOffsetsCount2`*: uint32
    `parent`*: Mdl
  Mdl_NameStrings* = ref object of KaitaiStruct
    `strings`*: seq[string]
    `parent`*: Mdl
  Mdl_Node* = ref object of KaitaiStruct
    `header`*: Mdl_NodeHeader
    `lightSubHeader`*: Mdl_LightHeader
    `emitterSubHeader`*: Mdl_EmitterHeader
    `referenceSubHeader`*: Mdl_ReferenceHeader
    `trimeshSubHeader`*: Mdl_TrimeshHeader
    `skinmeshSubHeader`*: Mdl_SkinmeshHeader
    `animmeshSubHeader`*: Mdl_AnimmeshHeader
    `danglymeshSubHeader`*: Mdl_DanglymeshHeader
    `aabbSubHeader`*: Mdl_AabbHeader
    `lightsaberSubHeader`*: Mdl_LightsaberHeader
    `parent`*: Mdl
  Mdl_NodeHeader* = ref object of KaitaiStruct
    `nodeType`*: uint16
    `nodeIndex`*: uint16
    `nodeNameIndex`*: uint16
    `padding`*: uint16
    `rootNodeOffset`*: uint32
    `parentNodeOffset`*: uint32
    `position`*: Mdl_Vec3f
    `orientation`*: Mdl_Quaternion
    `childArrayOffset`*: uint32
    `childCount`*: uint32
    `childCountDuplicate`*: uint32
    `controllerArrayOffset`*: uint32
    `controllerCount`*: uint32
    `controllerCountDuplicate`*: uint32
    `controllerDataOffset`*: uint32
    `controllerDataCount`*: uint32
    `controllerDataCountDuplicate`*: uint32
    `parent`*: Mdl_Node
    `hasAabbInst`: bool
    `hasAabbInstFlag`: bool
    `hasAnimInst`: bool
    `hasAnimInstFlag`: bool
    `hasDanglyInst`: bool
    `hasDanglyInstFlag`: bool
    `hasEmitterInst`: bool
    `hasEmitterInstFlag`: bool
    `hasLightInst`: bool
    `hasLightInstFlag`: bool
    `hasMeshInst`: bool
    `hasMeshInstFlag`: bool
    `hasReferenceInst`: bool
    `hasReferenceInstFlag`: bool
    `hasSaberInst`: bool
    `hasSaberInstFlag`: bool
    `hasSkinInst`: bool
    `hasSkinInstFlag`: bool
  Mdl_Quaternion* = ref object of KaitaiStruct
    `w`*: float32
    `x`*: float32
    `y`*: float32
    `z`*: float32
    `parent`*: Mdl_NodeHeader
  Mdl_ReferenceHeader* = ref object of KaitaiStruct
    `modelResref`*: string
    `reattachable`*: uint32
    `parent`*: Mdl_Node
  Mdl_SkinmeshHeader* = ref object of KaitaiStruct
    `trimeshBase`*: Mdl_TrimeshHeader
    `unknownWeights`*: int32
    `padding1`*: seq[uint8]
    `mdxBoneWeightsOffset`*: uint32
    `mdxBoneIndicesOffset`*: uint32
    `boneMapOffset`*: uint32
    `boneMapCount`*: uint32
    `qbonesOffset`*: uint32
    `qbonesCount`*: uint32
    `qbonesCountDuplicate`*: uint32
    `tbonesOffset`*: uint32
    `tbonesCount`*: uint32
    `tbonesCountDuplicate`*: uint32
    `unknownArray`*: uint32
    `boneNodeSerialNumbers`*: seq[uint16]
    `padding2`*: uint16
    `parent`*: Mdl_Node
  Mdl_TrimeshHeader* = ref object of KaitaiStruct
    `functionPointer0`*: uint32
    `functionPointer1`*: uint32
    `facesArrayOffset`*: uint32
    `facesCount`*: uint32
    `facesCountDuplicate`*: uint32
    `boundingBoxMin`*: Mdl_Vec3f
    `boundingBoxMax`*: Mdl_Vec3f
    `radius`*: float32
    `averagePoint`*: Mdl_Vec3f
    `diffuseColor`*: Mdl_Vec3f
    `ambientColor`*: Mdl_Vec3f
    `transparencyHint`*: uint32
    `texture0Name`*: string
    `texture1Name`*: string
    `texture2Name`*: string
    `texture3Name`*: string
    `indicesCountArrayOffset`*: uint32
    `indicesCountArrayCount`*: uint32
    `indicesCountArrayCountDuplicate`*: uint32
    `indicesOffsetArrayOffset`*: uint32
    `indicesOffsetArrayCount`*: uint32
    `indicesOffsetArrayCountDuplicate`*: uint32
    `invertedCounterArrayOffset`*: uint32
    `invertedCounterArrayCount`*: uint32
    `invertedCounterArrayCountDuplicate`*: uint32
    `unknownValues`*: seq[int32]
    `saberUnknownData`*: seq[uint8]
    `unknown`*: uint32
    `uvDirection`*: Mdl_Vec3f
    `uvJitter`*: float32
    `uvJitterSpeed`*: float32
    `mdxVertexSize`*: uint32
    `mdxDataFlags`*: uint32
    `mdxVerticesOffset`*: int32
    `mdxNormalsOffset`*: int32
    `mdxVertexColorsOffset`*: int32
    `mdxTex0UvsOffset`*: int32
    `mdxTex1UvsOffset`*: int32
    `mdxTex2UvsOffset`*: int32
    `mdxTex3UvsOffset`*: int32
    `mdxTangentSpaceOffset`*: int32
    `mdxUnknownOffset1`*: int32
    `mdxUnknownOffset2`*: int32
    `mdxUnknownOffset3`*: int32
    `vertexCount`*: uint16
    `textureCount`*: uint16
    `lightmapped`*: uint8
    `rotateTexture`*: uint8
    `backgroundGeometry`*: uint8
    `shadow`*: uint8
    `beaming`*: uint8
    `render`*: uint8
    `unknownFlag`*: uint8
    `padding`*: uint8
    `totalArea`*: float32
    `unknown2`*: uint32
    `k2Unknown1`*: uint32
    `k2Unknown2`*: uint32
    `mdxDataOffset`*: uint32
    `mdlVerticesOffset`*: uint32
    `parent`*: KaitaiStruct
  Mdl_Vec3f* = ref object of KaitaiStruct
    `x`*: float32
    `y`*: float32
    `z`*: float32
    `parent`*: KaitaiStruct

proc read*(_: typedesc[Mdl], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl
proc read*(_: typedesc[Mdl_AabbHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_AabbHeader
proc read*(_: typedesc[Mdl_AnimationEvent], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_AnimationEvent
proc read*(_: typedesc[Mdl_AnimationHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_MdlAnimationEntry): Mdl_AnimationHeader
proc read*(_: typedesc[Mdl_AnimmeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_AnimmeshHeader
proc read*(_: typedesc[Mdl_ArrayDefinition], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_ArrayDefinition
proc read*(_: typedesc[Mdl_Controller], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_Controller
proc read*(_: typedesc[Mdl_DanglymeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_DanglymeshHeader
proc read*(_: typedesc[Mdl_EmitterHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_EmitterHeader
proc read*(_: typedesc[Mdl_FileHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_FileHeader
proc read*(_: typedesc[Mdl_GeometryHeader], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_GeometryHeader
proc read*(_: typedesc[Mdl_LightHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_LightHeader
proc read*(_: typedesc[Mdl_LightsaberHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_LightsaberHeader
proc read*(_: typedesc[Mdl_MdlAnimationEntry], io: KaitaiStream, root: KaitaiStruct, parent: Mdl, animIndex: any): Mdl_MdlAnimationEntry
proc read*(_: typedesc[Mdl_ModelHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_ModelHeader
proc read*(_: typedesc[Mdl_NameStrings], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_NameStrings
proc read*(_: typedesc[Mdl_Node], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_Node
proc read*(_: typedesc[Mdl_NodeHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_NodeHeader
proc read*(_: typedesc[Mdl_Quaternion], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_NodeHeader): Mdl_Quaternion
proc read*(_: typedesc[Mdl_ReferenceHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_ReferenceHeader
proc read*(_: typedesc[Mdl_SkinmeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_SkinmeshHeader
proc read*(_: typedesc[Mdl_TrimeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_TrimeshHeader
proc read*(_: typedesc[Mdl_Vec3f], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_Vec3f

proc animationOffsets*(this: Mdl): seq[uint32]
proc animations*(this: Mdl): seq[Mdl_MdlAnimationEntry]
proc dataStart*(this: Mdl): int8
proc nameOffsets*(this: Mdl): seq[uint32]
proc namesData*(this: Mdl): Mdl_NameStrings
proc rootNode*(this: Mdl): Mdl_Node
proc usesBezier*(this: Mdl_Controller): bool
proc isKotor2*(this: Mdl_GeometryHeader): bool
proc header*(this: Mdl_MdlAnimationEntry): Mdl_AnimationHeader
proc hasAabb*(this: Mdl_NodeHeader): bool
proc hasAnim*(this: Mdl_NodeHeader): bool
proc hasDangly*(this: Mdl_NodeHeader): bool
proc hasEmitter*(this: Mdl_NodeHeader): bool
proc hasLight*(this: Mdl_NodeHeader): bool
proc hasMesh*(this: Mdl_NodeHeader): bool
proc hasReference*(this: Mdl_NodeHeader): bool
proc hasSaber*(this: Mdl_NodeHeader): bool
proc hasSkin*(this: Mdl_NodeHeader): bool


##[
BioWare MDL Model Format

The MDL file contains:
- File header (12 bytes)
- Model header (196 bytes) which begins with a Geometry header (80 bytes)
- Name offset array + name strings
- Animation offset array + animation headers + animation nodes
- Node hierarchy with geometry data

Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.

Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.

Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.

@see <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy">In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format">PyKotor wiki — MDL/MDX</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408">PyKotor — MDLBinaryReader (binary MDL/MDX)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267">xoreos — Model_KotOR::load</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79">xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load)</a>
@see <a href="https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43">xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html">xoreos-docs — KotOR MDL overview</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl (controller / Aurora background)</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118">reone — MdlMdxReader::load</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170">KotOR.js — OdysseyModel binary constructor</a>
@see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407">Community MDLOps — controller name table</a>
@see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698">Community MDLOps — `readasciimdl` (ASCII MDL ingest)</a>
]##
proc read*(_: typedesc[Mdl], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl =
  template this: untyped = result
  this = new(Mdl)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent

  let fileHeaderExpr = Mdl_FileHeader.read(this.io, this.root, this)
  this.fileHeader = fileHeaderExpr
  let modelHeaderExpr = Mdl_ModelHeader.read(this.io, this.root, this)
  this.modelHeader = modelHeaderExpr

proc animationOffsets(this: Mdl): seq[uint32] = 

  ##[
  Animation header offsets (relative to data_start)
  ]##
  if this.animationOffsetsInstFlag:
    return this.animationOffsetsInst
  if this.modelHeader.animationCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.dataStart + this.modelHeader.offsetToAnimations))
    for i in 0 ..< int(this.modelHeader.animationCount):
      let it = this.io.readU4le()
      this.animationOffsetsInst.add(it)
    this.io.seek(pos)
  this.animationOffsetsInstFlag = true
  return this.animationOffsetsInst

proc animations(this: Mdl): seq[Mdl_MdlAnimationEntry] = 

  ##[
  Animation headers (via offset table). Each list element is `mdl_animation_entry`;
the parsed header is `element.header` (same wire layout as `animation_header`).

  ]##
  if this.animationsInstFlag:
    return this.animationsInst
  if this.modelHeader.animationCount > 0:
    for i in 0 ..< int(this.modelHeader.animationCount):
      let it = Mdl_MdlAnimationEntry.read(this.io, this.root, this, i)
      this.animationsInst.add(it)
  this.animationsInstFlag = true
  return this.animationsInst

proc dataStart(this: Mdl): int8 = 

  ##[
  MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
section, which begins immediately after the 12-byte file header.

  ]##
  if this.dataStartInstFlag:
    return this.dataStartInst
  let dataStartInstExpr = int8(12)
  this.dataStartInst = dataStartInstExpr
  this.dataStartInstFlag = true
  return this.dataStartInst

proc nameOffsets(this: Mdl): seq[uint32] = 

  ##[
  Name string offsets (relative to data_start)
  ]##
  if this.nameOffsetsInstFlag:
    return this.nameOffsetsInst
  if this.modelHeader.nameOffsetsCount > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.dataStart + this.modelHeader.offsetToNameOffsets))
    for i in 0 ..< int(this.modelHeader.nameOffsetsCount):
      let it = this.io.readU4le()
      this.nameOffsetsInst.add(it)
    this.io.seek(pos)
  this.nameOffsetsInstFlag = true
  return this.nameOffsetsInst

proc namesData(this: Mdl): Mdl_NameStrings = 

  ##[
  Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
Parsed as null-terminated ASCII strings in `name_strings`.

  ]##
  if this.namesDataInstFlag:
    return this.namesDataInst
  if this.modelHeader.nameOffsetsCount > 0:
    let pos = this.io.pos()
    this.io.seek(int((this.dataStart + this.modelHeader.offsetToNameOffsets) + 4 * this.modelHeader.nameOffsetsCount))
    let rawNamesDataInstExpr = this.io.readBytes(int((this.dataStart + this.modelHeader.offsetToAnimations) - ((this.dataStart + this.modelHeader.offsetToNameOffsets) + 4 * this.modelHeader.nameOffsetsCount)))
    this.rawNamesDataInst = rawNamesDataInstExpr
    let rawNamesDataInstIo = newKaitaiStream(rawNamesDataInstExpr)
    let namesDataInstExpr = Mdl_NameStrings.read(rawNamesDataInstIo, this.root, this)
    this.namesDataInst = namesDataInstExpr
    this.io.seek(pos)
  this.namesDataInstFlag = true
  return this.namesDataInst

proc rootNode(this: Mdl): Mdl_Node = 
  if this.rootNodeInstFlag:
    return this.rootNodeInst
  if this.modelHeader.geometry.rootNodeOffset > 0:
    let pos = this.io.pos()
    this.io.seek(int(this.dataStart + this.modelHeader.geometry.rootNodeOffset))
    let rootNodeInstExpr = Mdl_Node.read(this.io, this.root, this)
    this.rootNodeInst = rootNodeInstExpr
    this.io.seek(pos)
  this.rootNodeInstFlag = true
  return this.rootNodeInst

proc fromFile*(_: typedesc[Mdl], filename: string): Mdl =
  Mdl.read(newKaitaiFileStream(filename), nil, nil)


##[
AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
]##
proc read*(_: typedesc[Mdl_AabbHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_AabbHeader =
  template this: untyped = result
  this = new(Mdl_AabbHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard trimesh header
  ]##
  let trimeshBaseExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
  this.trimeshBase = trimeshBaseExpr

  ##[
  Purpose unknown
  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

proc fromFile*(_: typedesc[Mdl_AabbHeader], filename: string): Mdl_AabbHeader =
  Mdl_AabbHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Animation event (36 bytes)
]##
proc read*(_: typedesc[Mdl_AnimationEvent], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_AnimationEvent =
  template this: untyped = result
  this = new(Mdl_AnimationEvent)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Time in seconds when event triggers during animation playback
  ]##
  let activationTimeExpr = this.io.readF4le()
  this.activationTime = activationTimeExpr

  ##[
  Name of event (null-terminated string, e.g., "detonate")
  ]##
  let eventNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.eventName = eventNameExpr

proc fromFile*(_: typedesc[Mdl_AnimationEvent], filename: string): Mdl_AnimationEvent =
  Mdl_AnimationEvent.read(newKaitaiFileStream(filename), nil, nil)


##[
Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
]##
proc read*(_: typedesc[Mdl_AnimationHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_MdlAnimationEntry): Mdl_AnimationHeader =
  template this: untyped = result
  this = new(Mdl_AnimationHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard 80-byte geometry header (geometry_type = 0x01 for animation)
  ]##
  let geoHeaderExpr = Mdl_GeometryHeader.read(this.io, this.root, this)
  this.geoHeader = geoHeaderExpr

  ##[
  Duration of animation in seconds
  ]##
  let animationLengthExpr = this.io.readF4le()
  this.animationLength = animationLengthExpr

  ##[
  Transition/blend time to this animation in seconds
  ]##
  let transitionTimeExpr = this.io.readF4le()
  this.transitionTime = transitionTimeExpr

  ##[
  Root node name for animation (null-terminated string)
  ]##
  let animationRootExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.animationRoot = animationRootExpr

  ##[
  Offset to animation events array
  ]##
  let eventArrayOffsetExpr = this.io.readU4le()
  this.eventArrayOffset = eventArrayOffsetExpr

  ##[
  Number of animation events
  ]##
  let eventCountExpr = this.io.readU4le()
  this.eventCount = eventCountExpr

  ##[
  Duplicate value of event count
  ]##
  let eventCountDuplicateExpr = this.io.readU4le()
  this.eventCountDuplicate = eventCountDuplicateExpr

  ##[
  Purpose unknown
  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

proc fromFile*(_: typedesc[Mdl_AnimationHeader], filename: string): Mdl_AnimationHeader =
  Mdl_AnimationHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
]##
proc read*(_: typedesc[Mdl_AnimmeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_AnimmeshHeader =
  template this: untyped = result
  this = new(Mdl_AnimmeshHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard trimesh header
  ]##
  let trimeshBaseExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
  this.trimeshBase = trimeshBaseExpr

  ##[
  Purpose unknown
  ]##
  let unknownExpr = this.io.readF4le()
  this.unknown = unknownExpr

  ##[
  Unknown array definition
  ]##
  let unknownArrayExpr = Mdl_ArrayDefinition.read(this.io, this.root, this)
  this.unknownArray = unknownArrayExpr

  ##[
  Unknown float values
  ]##
  for i in 0 ..< int(9):
    let it = this.io.readF4le()
    this.unknownFloats.add(it)

proc fromFile*(_: typedesc[Mdl_AnimmeshHeader], filename: string): Mdl_AnimmeshHeader =
  Mdl_AnimmeshHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Array definition structure (offset, count, count duplicate)
]##
proc read*(_: typedesc[Mdl_ArrayDefinition], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_ArrayDefinition =
  template this: untyped = result
  this = new(Mdl_ArrayDefinition)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Offset to array (relative to MDL data start, offset 12)
  ]##
  let offsetExpr = this.io.readS4le()
  this.offset = offsetExpr

  ##[
  Number of used entries
  ]##
  let countExpr = this.io.readU4le()
  this.count = countExpr

  ##[
  Duplicate of count (allocated entries)
  ]##
  let countDuplicateExpr = this.io.readU4le()
  this.countDuplicate = countDuplicateExpr

proc fromFile*(_: typedesc[Mdl_ArrayDefinition], filename: string): Mdl_ArrayDefinition =
  Mdl_ArrayDefinition.read(newKaitaiFileStream(filename), nil, nil)


##[
Controller structure (16 bytes) - defines animation data for a node property over time
]##
proc read*(_: typedesc[Mdl_Controller], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_Controller =
  template this: untyped = result
  this = new(Mdl_Controller)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Controller type identifier. Controllers define animation data for node properties over time.

Common Node Controllers (used by all node types):
- 8: Position (3 floats: X, Y, Z translation)
- 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
- 36: Scale (3 floats: X, Y, Z scale factors)

Light Controllers (specific to light nodes):
- 76: Color (light color, 3 floats: R, G, B)
- 88: Radius (light radius, 1 float)
- 96: Shadow Radius (shadow casting radius, 1 float)
- 100: Vertical Displacement (vertical offset, 1 float)
- 140: Multiplier (light intensity multiplier, 1 float)

Emitter Controllers (specific to emitter nodes):
- 80: Alpha End (final alpha value, 1 float)
- 84: Alpha Start (initial alpha value, 1 float)
- 88: Birth Rate (particle spawn rate, 1 float)
- 92: Bounce Coefficient (particle bounce factor, 1 float)
- 96: Combine Time (particle combination timing, 1 float)
- 100: Drag (particle drag/resistance, 1 float)
- 104: FPS (frames per second, 1 float)
- 108: Frame End (ending frame number, 1 float)
- 112: Frame Start (starting frame number, 1 float)
- 116: Gravity (gravity force, 1 float)
- 120: Life Expectancy (particle lifetime, 1 float)
- 124: Mass (particle mass, 1 float)
- 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
- 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
- 136: Particle Rotation (particle rotation speed/angle, 1 float)
- 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
- 144: Size Start (initial particle size, 1 float)
- 148: Size End (final particle size, 1 float)
- 152: Size Start Y (initial particle size Y component, 1 float)
- 156: Size End Y (final particle size Y component, 1 float)
- 160: Spread (particle spread angle, 1 float)
- 164: Threshold (threshold value, 1 float)
- 168: Velocity (particle velocity, 3 floats: X, Y, Z)
- 172: X Size (particle X dimension size, 1 float)
- 176: Y Size (particle Y dimension size, 1 float)
- 180: Blur Length (motion blur length, 1 float)
- 184: Lightning Delay (lightning effect delay, 1 float)
- 188: Lightning Radius (lightning effect radius, 1 float)
- 192: Lightning Scale (lightning effect scale factor, 1 float)
- 196: Lightning Subdivide (lightning subdivision count, 1 float)
- 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
- 216: Alpha Mid (mid-point alpha value, 1 float)
- 220: Percent Start (starting percentage, 1 float)
- 224: Percent Mid (mid-point percentage, 1 float)
- 228: Percent End (ending percentage, 1 float)
- 232: Size Mid (mid-point particle size, 1 float)
- 236: Size Mid Y (mid-point particle size Y component, 1 float)
- 240: Random Birth Rate (randomized particle spawn rate, 1 float)
- 252: Target Size (target particle size, 1 float)
- 256: Number of Control Points (control point count, 1 float)
- 260: Control Point Radius (control point radius, 1 float)
- 264: Control Point Delay (control point delay timing, 1 float)
- 268: Tangent Spread (tangent spread angle, 1 float)
- 272: Tangent Length (tangent vector length, 1 float)
- 284: Color Mid (mid-point color, 3 floats: R, G, B)
- 380: Color End (final color, 3 floats: R, G, B)
- 392: Color Start (initial color, 3 floats: R, G, B)
- 502: Emitter Detonate (detonation trigger, 1 float)

Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
- 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
- 128: Alpha (transparency/opacity, 1 float)

Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list

  ]##
  let typeExpr = BiowareMdlCommon_ControllerType(this.io.readU4le())
  this.type = typeExpr

  ##[
  Purpose unknown, typically 0xFFFF
  ]##
  let unknownExpr = this.io.readU2le()
  this.unknown = unknownExpr

  ##[
  Number of keyframe rows (timepoints) for this controller
  ]##
  let rowCountExpr = this.io.readU2le()
  this.rowCount = rowCountExpr

  ##[
  Index into controller data array where time values begin
  ]##
  let timeIndexExpr = this.io.readU2le()
  this.timeIndex = timeIndexExpr

  ##[
  Index into controller data array where property values begin
  ]##
  let dataIndexExpr = this.io.readU2le()
  this.dataIndex = dataIndexExpr

  ##[
  Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe

  ]##
  let columnCountExpr = this.io.readU1()
  this.columnCount = columnCountExpr

  ##[
  Padding bytes for 16-byte alignment
  ]##
  for i in 0 ..< int(3):
    let it = this.io.readU1()
    this.padding.add(it)

proc usesBezier(this: Mdl_Controller): bool = 

  ##[
  True if controller uses Bezier interpolation
  ]##
  if this.usesBezierInstFlag:
    return this.usesBezierInst
  let usesBezierInstExpr = bool((this.columnCount and 16) != 0)
  this.usesBezierInst = usesBezierInstExpr
  this.usesBezierInstFlag = true
  return this.usesBezierInst

proc fromFile*(_: typedesc[Mdl_Controller], filename: string): Mdl_Controller =
  Mdl_Controller.read(newKaitaiFileStream(filename), nil, nil)


##[
Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
]##
proc read*(_: typedesc[Mdl_DanglymeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_DanglymeshHeader =
  template this: untyped = result
  this = new(Mdl_DanglymeshHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard trimesh header
  ]##
  let trimeshBaseExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
  this.trimeshBase = trimeshBaseExpr

  ##[
  Offset to vertex constraint values array
  ]##
  let constraintsOffsetExpr = this.io.readU4le()
  this.constraintsOffset = constraintsOffsetExpr

  ##[
  Number of vertex constraints (matches vertex count)
  ]##
  let constraintsCountExpr = this.io.readU4le()
  this.constraintsCount = constraintsCountExpr

  ##[
  Duplicate of constraints count
  ]##
  let constraintsCountDuplicateExpr = this.io.readU4le()
  this.constraintsCountDuplicate = constraintsCountDuplicateExpr

  ##[
  Maximum displacement distance for physics simulation
  ]##
  let displacementExpr = this.io.readF4le()
  this.displacement = displacementExpr

  ##[
  Tightness/stiffness of spring simulation (0.0-1.0)
  ]##
  let tightnessExpr = this.io.readF4le()
  this.tightness = tightnessExpr

  ##[
  Oscillation period in seconds
  ]##
  let periodExpr = this.io.readF4le()
  this.period = periodExpr

  ##[
  Purpose unknown
  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

proc fromFile*(_: typedesc[Mdl_DanglymeshHeader], filename: string): Mdl_DanglymeshHeader =
  Mdl_DanglymeshHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Emitter header (224 bytes)
]##
proc read*(_: typedesc[Mdl_EmitterHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_EmitterHeader =
  template this: untyped = result
  this = new(Mdl_EmitterHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Minimum distance from emitter before particles become visible
  ]##
  let deadSpaceExpr = this.io.readF4le()
  this.deadSpace = deadSpaceExpr

  ##[
  Radius of explosive/blast particle effects
  ]##
  let blastRadiusExpr = this.io.readF4le()
  this.blastRadius = blastRadiusExpr

  ##[
  Length/duration of blast effects
  ]##
  let blastLengthExpr = this.io.readF4le()
  this.blastLength = blastLengthExpr

  ##[
  Number of branching paths for particle trails
  ]##
  let branchCountExpr = this.io.readU4le()
  this.branchCount = branchCountExpr

  ##[
  Smoothing factor for particle path control points
  ]##
  let controlPointSmoothingExpr = this.io.readF4le()
  this.controlPointSmoothing = controlPointSmoothingExpr

  ##[
  Grid subdivisions along X axis for particle spawning
  ]##
  let xGridExpr = this.io.readU4le()
  this.xGrid = xGridExpr

  ##[
  Grid subdivisions along Y axis for particle spawning
  ]##
  let yGridExpr = this.io.readU4le()
  this.yGrid = yGridExpr

  ##[
  Purpose unknown or padding
  ]##
  let paddingUnknownExpr = this.io.readU4le()
  this.paddingUnknown = paddingUnknownExpr

  ##[
  Update behavior script name (e.g., "single", "fountain")
  ]##
  let updateScriptExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.updateScript = updateScriptExpr

  ##[
  Render mode script name (e.g., "normal", "billboard_to_local_z")
  ]##
  let renderScriptExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.renderScript = renderScriptExpr

  ##[
  Blend mode script name (e.g., "normal", "lighten")
  ]##
  let blendScriptExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.blendScript = blendScriptExpr

  ##[
  Particle texture name (null-terminated string)
  ]##
  let textureNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.textureName = textureNameExpr

  ##[
  Associated model chunk name (null-terminated string)
  ]##
  let chunkNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.chunkName = chunkNameExpr

  ##[
  1 if texture should render two-sided, 0 for single-sided
  ]##
  let twoSidedTextureExpr = this.io.readU4le()
  this.twoSidedTexture = twoSidedTextureExpr

  ##[
  1 if particle system loops, 0 for single playback
  ]##
  let loopExpr = this.io.readU4le()
  this.loop = loopExpr

  ##[
  Rendering priority/order for particle sorting
  ]##
  let renderOrderExpr = this.io.readU2le()
  this.renderOrder = renderOrderExpr

  ##[
  1 if frame blending enabled, 0 otherwise
  ]##
  let frameBlendingExpr = this.io.readU1()
  this.frameBlending = frameBlendingExpr

  ##[
  Depth/softparticle texture name (null-terminated string)
  ]##
  let depthTextureNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.depthTextureName = depthTextureNameExpr

  ##[
  Padding byte for alignment
  ]##
  let paddingExpr = this.io.readU1()
  this.padding = paddingExpr

  ##[
  Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
  ]##
  let flagsExpr = this.io.readU4le()
  this.flags = flagsExpr

proc fromFile*(_: typedesc[Mdl_EmitterHeader], filename: string): Mdl_EmitterHeader =
  Mdl_EmitterHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
MDL file header (12 bytes)
]##
proc read*(_: typedesc[Mdl_FileHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_FileHeader =
  template this: untyped = result
  this = new(Mdl_FileHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Always 0
  ]##
  let unusedExpr = this.io.readU4le()
  this.unused = unusedExpr

  ##[
  Size of MDL file in bytes
  ]##
  let mdlSizeExpr = this.io.readU4le()
  this.mdlSize = mdlSizeExpr

  ##[
  Size of MDX file in bytes
  ]##
  let mdxSizeExpr = this.io.readU4le()
  this.mdxSize = mdxSizeExpr

proc fromFile*(_: typedesc[Mdl_FileHeader], filename: string): Mdl_FileHeader =
  Mdl_FileHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
]##
proc read*(_: typedesc[Mdl_GeometryHeader], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_GeometryHeader =
  template this: untyped = result
  this = new(Mdl_GeometryHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Game engine version identifier:
- KOTOR 1 PC: 4273776 (0x413670)
- KOTOR 2 PC: 4285200 (0x416310)
- KOTOR 1 Xbox: 4254992 (0x40ED10)
- KOTOR 2 Xbox: 4285872 (0x4165B0)

  ]##
  let functionPointer0Expr = this.io.readU4le()
  this.functionPointer0 = functionPointer0Expr

  ##[
  Function pointer to ASCII model parser
  ]##
  let functionPointer1Expr = this.io.readU4le()
  this.functionPointer1 = functionPointer1Expr

  ##[
  Model name, null-terminated string, max 32 (0x20) bytes
  ]##
  let modelNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.modelName = modelNameExpr

  ##[
  Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
  ]##
  let rootNodeOffsetExpr = this.io.readU4le()
  this.rootNodeOffset = rootNodeOffsetExpr

  ##[
  Total number of nodes in model hierarchy, unsigned 32-bit integer
  ]##
  let nodeCountExpr = this.io.readU4le()
  this.nodeCount = nodeCountExpr

  ##[
  Unknown array definition (offset, count, count duplicate)
  ]##
  let unknownArray1Expr = Mdl_ArrayDefinition.read(this.io, this.root, this)
  this.unknownArray1 = unknownArray1Expr

  ##[
  Unknown array definition (offset, count, count duplicate)
  ]##
  let unknownArray2Expr = Mdl_ArrayDefinition.read(this.io, this.root, this)
  this.unknownArray2 = unknownArray2Expr

  ##[
  Reference count (initialized to 0, incremented when model is referenced)
  ]##
  let referenceCountExpr = this.io.readU4le()
  this.referenceCount = referenceCountExpr

  ##[
  Geometry type:
- 0x01: Basic geometry header (not in models)
- 0x02: Model geometry header
- 0x05: Animation geometry header
If bit 7 (0x80) is set, model is compiled binary with absolute addresses

  ]##
  let geometryTypeExpr = this.io.readU1()
  this.geometryType = geometryTypeExpr

  ##[
  Padding bytes for alignment
  ]##
  for i in 0 ..< int(3):
    let it = this.io.readU1()
    this.padding.add(it)

proc isKotor2(this: Mdl_GeometryHeader): bool = 

  ##[
  True if this is a KOTOR 2 model
  ]##
  if this.isKotor2InstFlag:
    return this.isKotor2Inst
  let isKotor2InstExpr = bool( ((this.functionPointer0 == 4285200) or (this.functionPointer0 == 4285872)) )
  this.isKotor2Inst = isKotor2InstExpr
  this.isKotor2InstFlag = true
  return this.isKotor2Inst

proc fromFile*(_: typedesc[Mdl_GeometryHeader], filename: string): Mdl_GeometryHeader =
  Mdl_GeometryHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Light header (92 bytes)
]##
proc read*(_: typedesc[Mdl_LightHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_LightHeader =
  template this: untyped = result
  this = new(Mdl_LightHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Purpose unknown, possibly padding or reserved values
  ]##
  for i in 0 ..< int(4):
    let it = this.io.readF4le()
    this.unknown.add(it)

  ##[
  Offset to flare sizes array (floats)
  ]##
  let flareSizesOffsetExpr = this.io.readU4le()
  this.flareSizesOffset = flareSizesOffsetExpr

  ##[
  Number of flare size entries
  ]##
  let flareSizesCountExpr = this.io.readU4le()
  this.flareSizesCount = flareSizesCountExpr

  ##[
  Duplicate of flare sizes count
  ]##
  let flareSizesCountDuplicateExpr = this.io.readU4le()
  this.flareSizesCountDuplicate = flareSizesCountDuplicateExpr

  ##[
  Offset to flare positions array (floats, 0.0-1.0 along light ray)
  ]##
  let flarePositionsOffsetExpr = this.io.readU4le()
  this.flarePositionsOffset = flarePositionsOffsetExpr

  ##[
  Number of flare position entries
  ]##
  let flarePositionsCountExpr = this.io.readU4le()
  this.flarePositionsCount = flarePositionsCountExpr

  ##[
  Duplicate of flare positions count
  ]##
  let flarePositionsCountDuplicateExpr = this.io.readU4le()
  this.flarePositionsCountDuplicate = flarePositionsCountDuplicateExpr

  ##[
  Offset to flare color shift array (RGB floats)
  ]##
  let flareColorShiftsOffsetExpr = this.io.readU4le()
  this.flareColorShiftsOffset = flareColorShiftsOffsetExpr

  ##[
  Number of flare color shift entries
  ]##
  let flareColorShiftsCountExpr = this.io.readU4le()
  this.flareColorShiftsCount = flareColorShiftsCountExpr

  ##[
  Duplicate of flare color shifts count
  ]##
  let flareColorShiftsCountDuplicateExpr = this.io.readU4le()
  this.flareColorShiftsCountDuplicate = flareColorShiftsCountDuplicateExpr

  ##[
  Offset to flare texture name string offsets array
  ]##
  let flareTextureNamesOffsetExpr = this.io.readU4le()
  this.flareTextureNamesOffset = flareTextureNamesOffsetExpr

  ##[
  Number of flare texture names
  ]##
  let flareTextureNamesCountExpr = this.io.readU4le()
  this.flareTextureNamesCount = flareTextureNamesCountExpr

  ##[
  Duplicate of flare texture names count
  ]##
  let flareTextureNamesCountDuplicateExpr = this.io.readU4le()
  this.flareTextureNamesCountDuplicate = flareTextureNamesCountDuplicateExpr

  ##[
  Radius of flare effect
  ]##
  let flareRadiusExpr = this.io.readF4le()
  this.flareRadius = flareRadiusExpr

  ##[
  Rendering priority for light culling/sorting
  ]##
  let lightPriorityExpr = this.io.readU4le()
  this.lightPriority = lightPriorityExpr

  ##[
  1 if light only affects ambient, 0 for full lighting
  ]##
  let ambientOnlyExpr = this.io.readU4le()
  this.ambientOnly = ambientOnlyExpr

  ##[
  Type of dynamic lighting behavior
  ]##
  let dynamicTypeExpr = this.io.readU4le()
  this.dynamicType = dynamicTypeExpr

  ##[
  1 if light affects dynamic objects, 0 otherwise
  ]##
  let affectDynamicExpr = this.io.readU4le()
  this.affectDynamic = affectDynamicExpr

  ##[
  1 if light casts shadows, 0 otherwise
  ]##
  let shadowExpr = this.io.readU4le()
  this.shadow = shadowExpr

  ##[
  1 if lens flare effect enabled, 0 otherwise
  ]##
  let flareExpr = this.io.readU4le()
  this.flare = flareExpr

  ##[
  1 if light intensity fades with distance, 0 otherwise
  ]##
  let fadingLightExpr = this.io.readU4le()
  this.fadingLight = fadingLightExpr

proc fromFile*(_: typedesc[Mdl_LightHeader], filename: string): Mdl_LightHeader =
  Mdl_LightHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
]##
proc read*(_: typedesc[Mdl_LightsaberHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_LightsaberHeader =
  template this: untyped = result
  this = new(Mdl_LightsaberHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard trimesh header
  ]##
  let trimeshBaseExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
  this.trimeshBase = trimeshBaseExpr

  ##[
  Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
  ]##
  let verticesOffsetExpr = this.io.readU4le()
  this.verticesOffset = verticesOffsetExpr

  ##[
  Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
  ]##
  let texcoordsOffsetExpr = this.io.readU4le()
  this.texcoordsOffset = texcoordsOffsetExpr

  ##[
  Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
  ]##
  let normalsOffsetExpr = this.io.readU4le()
  this.normalsOffset = normalsOffsetExpr

  ##[
  Purpose unknown
  ]##
  let unknown1Expr = this.io.readU4le()
  this.unknown1 = unknown1Expr

  ##[
  Purpose unknown
  ]##
  let unknown2Expr = this.io.readU4le()
  this.unknown2 = unknown2Expr

proc fromFile*(_: typedesc[Mdl_LightsaberHeader], filename: string): Mdl_LightsaberHeader =
  Mdl_LightsaberHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
Wraps the header so repeated root instances can use parametric types (user guide).

]##
proc read*(_: typedesc[Mdl_MdlAnimationEntry], io: KaitaiStream, root: KaitaiStruct, parent: Mdl, animIndex: any): Mdl_MdlAnimationEntry =
  template this: untyped = result
  this = new(Mdl_MdlAnimationEntry)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent
  let animIndexExpr = uint32(animIndex)
  this.animIndex = animIndexExpr


proc header(this: Mdl_MdlAnimationEntry): Mdl_AnimationHeader = 
  if this.headerInstFlag:
    return this.headerInst
  let pos = this.io.pos()
  this.io.seek(int(Mdl(this.root).dataStart + Mdl(this.root).animationOffsets[this.animIndex]))
  let headerInstExpr = Mdl_AnimationHeader.read(this.io, this.root, this)
  this.headerInst = headerInstExpr
  this.io.seek(pos)
  this.headerInstFlag = true
  return this.headerInst

proc fromFile*(_: typedesc[Mdl_MdlAnimationEntry], filename: string): Mdl_MdlAnimationEntry =
  Mdl_MdlAnimationEntry.read(newKaitaiFileStream(filename), nil, nil)


##[
Model header (196 bytes) starting at offset 12 (data_start).
This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
model-wide metadata, offsets, and counts.

]##
proc read*(_: typedesc[Mdl_ModelHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_ModelHeader =
  template this: untyped = result
  this = new(Mdl_ModelHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Geometry header (80 bytes)
  ]##
  let geometryExpr = Mdl_GeometryHeader.read(this.io, this.root, this)
  this.geometry = geometryExpr

  ##[
  Model classification byte
  ]##
  let modelTypeExpr = BiowareMdlCommon_ModelClassification(this.io.readU1())
  this.modelType = modelTypeExpr

  ##[
  TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
  ]##
  let unknown0Expr = this.io.readU1()
  this.unknown0 = unknown0Expr

  ##[
  Padding byte
  ]##
  let padding0Expr = this.io.readU1()
  this.padding0 = padding0Expr

  ##[
  Fog interaction (1 = affected, 0 = ignore fog)
  ]##
  let fogExpr = this.io.readU1()
  this.fog = fogExpr

  ##[
  TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
  ]##
  let unknown1Expr = this.io.readU4le()
  this.unknown1 = unknown1Expr

  ##[
  Offset to animation offset array (relative to data_start)
  ]##
  let offsetToAnimationsExpr = this.io.readU4le()
  this.offsetToAnimations = offsetToAnimationsExpr

  ##[
  Number of animations
  ]##
  let animationCountExpr = this.io.readU4le()
  this.animationCount = animationCountExpr

  ##[
  Duplicate animation count / allocated count
  ]##
  let animationCount2Expr = this.io.readU4le()
  this.animationCount2 = animationCount2Expr

  ##[
  TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
  ]##
  let unknown2Expr = this.io.readU4le()
  this.unknown2 = unknown2Expr

  ##[
  Minimum coordinates of bounding box (X, Y, Z)
  ]##
  let boundingBoxMinExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.boundingBoxMin = boundingBoxMinExpr

  ##[
  Maximum coordinates of bounding box (X, Y, Z)
  ]##
  let boundingBoxMaxExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.boundingBoxMax = boundingBoxMaxExpr

  ##[
  Radius of model's bounding sphere
  ]##
  let radiusExpr = this.io.readF4le()
  this.radius = radiusExpr

  ##[
  Scale factor for animations (typically 1.0)
  ]##
  let animationScaleExpr = this.io.readF4le()
  this.animationScale = animationScaleExpr

  ##[
  Name of supermodel (null-terminated string, "null" if empty)
  ]##
  let supermodelNameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.supermodelName = supermodelNameExpr

  ##[
  TODO: VERIFY - offset to super-root node (relative to data_start)
  ]##
  let offsetToSuperRootExpr = this.io.readU4le()
  this.offsetToSuperRoot = offsetToSuperRootExpr

  ##[
  TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
  ]##
  let unknown3Expr = this.io.readU4le()
  this.unknown3 = unknown3Expr

  ##[
  Size of MDX file data in bytes
  ]##
  let mdxDataSizeExpr = this.io.readU4le()
  this.mdxDataSize = mdxDataSizeExpr

  ##[
  Offset to MDX data (typically 0)
  ]##
  let mdxDataOffsetExpr = this.io.readU4le()
  this.mdxDataOffset = mdxDataOffsetExpr

  ##[
  Offset to name offset array (relative to data_start)
  ]##
  let offsetToNameOffsetsExpr = this.io.readU4le()
  this.offsetToNameOffsets = offsetToNameOffsetsExpr

  ##[
  Count of name offsets / partnames
  ]##
  let nameOffsetsCountExpr = this.io.readU4le()
  this.nameOffsetsCount = nameOffsetsCountExpr

  ##[
  Duplicate name offsets count / allocated count
  ]##
  let nameOffsetsCount2Expr = this.io.readU4le()
  this.nameOffsetsCount2 = nameOffsetsCount2Expr

proc fromFile*(_: typedesc[Mdl_ModelHeader], filename: string): Mdl_ModelHeader =
  Mdl_ModelHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Array of null-terminated name strings
]##
proc read*(_: typedesc[Mdl_NameStrings], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_NameStrings =
  template this: untyped = result
  this = new(Mdl_NameStrings)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent

  block:
    var i: int
    while not this.io.isEof:
      let it = encode(this.io.readBytesTerm(0, false, true, true), "ASCII")
      this.strings.add(it)
      inc i

proc fromFile*(_: typedesc[Mdl_NameStrings], filename: string): Mdl_NameStrings =
  Mdl_NameStrings.read(newKaitaiFileStream(filename), nil, nil)


##[
Node structure - starts with 80-byte header, followed by type-specific sub-header
]##
proc read*(_: typedesc[Mdl_Node], io: KaitaiStream, root: KaitaiStruct, parent: Mdl): Mdl_Node =
  template this: untyped = result
  this = new(Mdl_Node)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent

  let headerExpr = Mdl_NodeHeader.read(this.io, this.root, this)
  this.header = headerExpr
  if this.header.nodeType == 3:
    let lightSubHeaderExpr = Mdl_LightHeader.read(this.io, this.root, this)
    this.lightSubHeader = lightSubHeaderExpr
  if this.header.nodeType == 5:
    let emitterSubHeaderExpr = Mdl_EmitterHeader.read(this.io, this.root, this)
    this.emitterSubHeader = emitterSubHeaderExpr
  if this.header.nodeType == 17:
    let referenceSubHeaderExpr = Mdl_ReferenceHeader.read(this.io, this.root, this)
    this.referenceSubHeader = referenceSubHeaderExpr
  if this.header.nodeType == 33:
    let trimeshSubHeaderExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
    this.trimeshSubHeader = trimeshSubHeaderExpr
  if this.header.nodeType == 97:
    let skinmeshSubHeaderExpr = Mdl_SkinmeshHeader.read(this.io, this.root, this)
    this.skinmeshSubHeader = skinmeshSubHeaderExpr
  if this.header.nodeType == 161:
    let animmeshSubHeaderExpr = Mdl_AnimmeshHeader.read(this.io, this.root, this)
    this.animmeshSubHeader = animmeshSubHeaderExpr
  if this.header.nodeType == 289:
    let danglymeshSubHeaderExpr = Mdl_DanglymeshHeader.read(this.io, this.root, this)
    this.danglymeshSubHeader = danglymeshSubHeaderExpr
  if this.header.nodeType == 545:
    let aabbSubHeaderExpr = Mdl_AabbHeader.read(this.io, this.root, this)
    this.aabbSubHeader = aabbSubHeaderExpr
  if this.header.nodeType == 2081:
    let lightsaberSubHeaderExpr = Mdl_LightsaberHeader.read(this.io, this.root, this)
    this.lightsaberSubHeader = lightsaberSubHeaderExpr

proc fromFile*(_: typedesc[Mdl_Node], filename: string): Mdl_Node =
  Mdl_Node.read(newKaitaiFileStream(filename), nil, nil)


##[
Node header (80 bytes) - present in all node types
]##
proc read*(_: typedesc[Mdl_NodeHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_NodeHeader =
  template this: untyped = result
  this = new(Mdl_NodeHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Bitmask indicating node features (also carries the primary node kind in the composite values listed in
`bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
- 0x0001: NODE_HAS_HEADER
- 0x0002: NODE_HAS_LIGHT
- 0x0004: NODE_HAS_EMITTER
- 0x0008: NODE_HAS_CAMERA
- 0x0010: NODE_HAS_REFERENCE
- 0x0020: NODE_HAS_MESH
- 0x0040: NODE_HAS_SKIN
- 0x0080: NODE_HAS_ANIM
- 0x0100: NODE_HAS_DANGLY
- 0x0200: NODE_HAS_AABB
- 0x0800: NODE_HAS_SABER

  ]##
  let nodeTypeExpr = this.io.readU2le()
  this.nodeType = nodeTypeExpr

  ##[
  Sequential index of this node in the model
  ]##
  let nodeIndexExpr = this.io.readU2le()
  this.nodeIndex = nodeIndexExpr

  ##[
  Index into names array for this node's name
  ]##
  let nodeNameIndexExpr = this.io.readU2le()
  this.nodeNameIndex = nodeNameIndexExpr

  ##[
  Padding for alignment
  ]##
  let paddingExpr = this.io.readU2le()
  this.padding = paddingExpr

  ##[
  Offset to model's root node
  ]##
  let rootNodeOffsetExpr = this.io.readU4le()
  this.rootNodeOffset = rootNodeOffsetExpr

  ##[
  Offset to this node's parent node (0 if root)
  ]##
  let parentNodeOffsetExpr = this.io.readU4le()
  this.parentNodeOffset = parentNodeOffsetExpr

  ##[
  Node position in local space (X, Y, Z)
  ]##
  let positionExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.position = positionExpr

  ##[
  Node orientation as quaternion (W, X, Y, Z)
  ]##
  let orientationExpr = Mdl_Quaternion.read(this.io, this.root, this)
  this.orientation = orientationExpr

  ##[
  Offset to array of child node offsets
  ]##
  let childArrayOffsetExpr = this.io.readU4le()
  this.childArrayOffset = childArrayOffsetExpr

  ##[
  Number of child nodes
  ]##
  let childCountExpr = this.io.readU4le()
  this.childCount = childCountExpr

  ##[
  Duplicate value of child count
  ]##
  let childCountDuplicateExpr = this.io.readU4le()
  this.childCountDuplicate = childCountDuplicateExpr

  ##[
  Offset to array of controller structures
  ]##
  let controllerArrayOffsetExpr = this.io.readU4le()
  this.controllerArrayOffset = controllerArrayOffsetExpr

  ##[
  Number of controllers attached to this node
  ]##
  let controllerCountExpr = this.io.readU4le()
  this.controllerCount = controllerCountExpr

  ##[
  Duplicate value of controller count
  ]##
  let controllerCountDuplicateExpr = this.io.readU4le()
  this.controllerCountDuplicate = controllerCountDuplicateExpr

  ##[
  Offset to controller keyframe/data array
  ]##
  let controllerDataOffsetExpr = this.io.readU4le()
  this.controllerDataOffset = controllerDataOffsetExpr

  ##[
  Number of floats in controller data array
  ]##
  let controllerDataCountExpr = this.io.readU4le()
  this.controllerDataCount = controllerDataCountExpr

  ##[
  Duplicate value of controller data count
  ]##
  let controllerDataCountDuplicateExpr = this.io.readU4le()
  this.controllerDataCountDuplicate = controllerDataCountDuplicateExpr

proc hasAabb(this: Mdl_NodeHeader): bool = 
  if this.hasAabbInstFlag:
    return this.hasAabbInst
  let hasAabbInstExpr = bool((this.nodeType and 512) != 0)
  this.hasAabbInst = hasAabbInstExpr
  this.hasAabbInstFlag = true
  return this.hasAabbInst

proc hasAnim(this: Mdl_NodeHeader): bool = 
  if this.hasAnimInstFlag:
    return this.hasAnimInst
  let hasAnimInstExpr = bool((this.nodeType and 128) != 0)
  this.hasAnimInst = hasAnimInstExpr
  this.hasAnimInstFlag = true
  return this.hasAnimInst

proc hasDangly(this: Mdl_NodeHeader): bool = 
  if this.hasDanglyInstFlag:
    return this.hasDanglyInst
  let hasDanglyInstExpr = bool((this.nodeType and 256) != 0)
  this.hasDanglyInst = hasDanglyInstExpr
  this.hasDanglyInstFlag = true
  return this.hasDanglyInst

proc hasEmitter(this: Mdl_NodeHeader): bool = 
  if this.hasEmitterInstFlag:
    return this.hasEmitterInst
  let hasEmitterInstExpr = bool((this.nodeType and 4) != 0)
  this.hasEmitterInst = hasEmitterInstExpr
  this.hasEmitterInstFlag = true
  return this.hasEmitterInst

proc hasLight(this: Mdl_NodeHeader): bool = 
  if this.hasLightInstFlag:
    return this.hasLightInst
  let hasLightInstExpr = bool((this.nodeType and 2) != 0)
  this.hasLightInst = hasLightInstExpr
  this.hasLightInstFlag = true
  return this.hasLightInst

proc hasMesh(this: Mdl_NodeHeader): bool = 
  if this.hasMeshInstFlag:
    return this.hasMeshInst
  let hasMeshInstExpr = bool((this.nodeType and 32) != 0)
  this.hasMeshInst = hasMeshInstExpr
  this.hasMeshInstFlag = true
  return this.hasMeshInst

proc hasReference(this: Mdl_NodeHeader): bool = 
  if this.hasReferenceInstFlag:
    return this.hasReferenceInst
  let hasReferenceInstExpr = bool((this.nodeType and 16) != 0)
  this.hasReferenceInst = hasReferenceInstExpr
  this.hasReferenceInstFlag = true
  return this.hasReferenceInst

proc hasSaber(this: Mdl_NodeHeader): bool = 
  if this.hasSaberInstFlag:
    return this.hasSaberInst
  let hasSaberInstExpr = bool((this.nodeType and 2048) != 0)
  this.hasSaberInst = hasSaberInstExpr
  this.hasSaberInstFlag = true
  return this.hasSaberInst

proc hasSkin(this: Mdl_NodeHeader): bool = 
  if this.hasSkinInstFlag:
    return this.hasSkinInst
  let hasSkinInstExpr = bool((this.nodeType and 64) != 0)
  this.hasSkinInst = hasSkinInstExpr
  this.hasSkinInstFlag = true
  return this.hasSkinInst

proc fromFile*(_: typedesc[Mdl_NodeHeader], filename: string): Mdl_NodeHeader =
  Mdl_NodeHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Quaternion rotation (4 floats W, X, Y, Z)
]##
proc read*(_: typedesc[Mdl_Quaternion], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_NodeHeader): Mdl_Quaternion =
  template this: untyped = result
  this = new(Mdl_Quaternion)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent

  let wExpr = this.io.readF4le()
  this.w = wExpr
  let xExpr = this.io.readF4le()
  this.x = xExpr
  let yExpr = this.io.readF4le()
  this.y = yExpr
  let zExpr = this.io.readF4le()
  this.z = zExpr

proc fromFile*(_: typedesc[Mdl_Quaternion], filename: string): Mdl_Quaternion =
  Mdl_Quaternion.read(newKaitaiFileStream(filename), nil, nil)


##[
Reference header (36 bytes)
]##
proc read*(_: typedesc[Mdl_ReferenceHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_ReferenceHeader =
  template this: untyped = result
  this = new(Mdl_ReferenceHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Referenced model resource name without extension (null-terminated string)
  ]##
  let modelResrefExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.modelResref = modelResrefExpr

  ##[
  1 if model can be detached and reattached dynamically, 0 if permanent
  ]##
  let reattachableExpr = this.io.readU4le()
  this.reattachable = reattachableExpr

proc fromFile*(_: typedesc[Mdl_ReferenceHeader], filename: string): Mdl_ReferenceHeader =
  Mdl_ReferenceHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
]##
proc read*(_: typedesc[Mdl_SkinmeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: Mdl_Node): Mdl_SkinmeshHeader =
  template this: untyped = result
  this = new(Mdl_SkinmeshHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Standard trimesh header
  ]##
  let trimeshBaseExpr = Mdl_TrimeshHeader.read(this.io, this.root, this)
  this.trimeshBase = trimeshBaseExpr

  ##[
  Purpose unknown (possibly compilation weights)
  ]##
  let unknownWeightsExpr = this.io.readS4le()
  this.unknownWeights = unknownWeightsExpr

  ##[
  Padding
  ]##
  for i in 0 ..< int(8):
    let it = this.io.readU1()
    this.padding1.add(it)

  ##[
  Offset to bone weight data in MDX file (4 floats per vertex)
  ]##
  let mdxBoneWeightsOffsetExpr = this.io.readU4le()
  this.mdxBoneWeightsOffset = mdxBoneWeightsOffsetExpr

  ##[
  Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
  ]##
  let mdxBoneIndicesOffsetExpr = this.io.readU4le()
  this.mdxBoneIndicesOffset = mdxBoneIndicesOffsetExpr

  ##[
  Offset to bone map array (maps local bone indices to skeleton bone numbers)
  ]##
  let boneMapOffsetExpr = this.io.readU4le()
  this.boneMapOffset = boneMapOffsetExpr

  ##[
  Number of bones referenced by this mesh (max 16)
  ]##
  let boneMapCountExpr = this.io.readU4le()
  this.boneMapCount = boneMapCountExpr

  ##[
  Offset to quaternion bind pose array (4 floats per bone)
  ]##
  let qbonesOffsetExpr = this.io.readU4le()
  this.qbonesOffset = qbonesOffsetExpr

  ##[
  Number of quaternion bind poses
  ]##
  let qbonesCountExpr = this.io.readU4le()
  this.qbonesCount = qbonesCountExpr

  ##[
  Duplicate of QBones count
  ]##
  let qbonesCountDuplicateExpr = this.io.readU4le()
  this.qbonesCountDuplicate = qbonesCountDuplicateExpr

  ##[
  Offset to translation bind pose array (3 floats per bone)
  ]##
  let tbonesOffsetExpr = this.io.readU4le()
  this.tbonesOffset = tbonesOffsetExpr

  ##[
  Number of translation bind poses
  ]##
  let tbonesCountExpr = this.io.readU4le()
  this.tbonesCount = tbonesCountExpr

  ##[
  Duplicate of TBones count
  ]##
  let tbonesCountDuplicateExpr = this.io.readU4le()
  this.tbonesCountDuplicate = tbonesCountDuplicateExpr

  ##[
  Purpose unknown
  ]##
  let unknownArrayExpr = this.io.readU4le()
  this.unknownArray = unknownArrayExpr

  ##[
  Serial indices of bone nodes (0xFFFF for unused slots)
  ]##
  for i in 0 ..< int(16):
    let it = this.io.readU2le()
    this.boneNodeSerialNumbers.add(it)

  ##[
  Padding for alignment
  ]##
  let padding2Expr = this.io.readU2le()
  this.padding2 = padding2Expr

proc fromFile*(_: typedesc[Mdl_SkinmeshHeader], filename: string): Mdl_SkinmeshHeader =
  Mdl_SkinmeshHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
]##
proc read*(_: typedesc[Mdl_TrimeshHeader], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_TrimeshHeader =
  template this: untyped = result
  this = new(Mdl_TrimeshHeader)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Game engine function pointer (version-specific)
  ]##
  let functionPointer0Expr = this.io.readU4le()
  this.functionPointer0 = functionPointer0Expr

  ##[
  Secondary game engine function pointer
  ]##
  let functionPointer1Expr = this.io.readU4le()
  this.functionPointer1 = functionPointer1Expr

  ##[
  Offset to face definitions array
  ]##
  let facesArrayOffsetExpr = this.io.readU4le()
  this.facesArrayOffset = facesArrayOffsetExpr

  ##[
  Number of triangular faces in mesh
  ]##
  let facesCountExpr = this.io.readU4le()
  this.facesCount = facesCountExpr

  ##[
  Duplicate of faces count
  ]##
  let facesCountDuplicateExpr = this.io.readU4le()
  this.facesCountDuplicate = facesCountDuplicateExpr

  ##[
  Minimum bounding box coordinates (X, Y, Z)
  ]##
  let boundingBoxMinExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.boundingBoxMin = boundingBoxMinExpr

  ##[
  Maximum bounding box coordinates (X, Y, Z)
  ]##
  let boundingBoxMaxExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.boundingBoxMax = boundingBoxMaxExpr

  ##[
  Bounding sphere radius
  ]##
  let radiusExpr = this.io.readF4le()
  this.radius = radiusExpr

  ##[
  Average vertex position (centroid) X, Y, Z
  ]##
  let averagePointExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.averagePoint = averagePointExpr

  ##[
  Material diffuse color (R, G, B, range 0.0-1.0)
  ]##
  let diffuseColorExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.diffuseColor = diffuseColorExpr

  ##[
  Material ambient color (R, G, B, range 0.0-1.0)
  ]##
  let ambientColorExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.ambientColor = ambientColorExpr

  ##[
  Transparency rendering mode
  ]##
  let transparencyHintExpr = this.io.readU4le()
  this.transparencyHint = transparencyHintExpr

  ##[
  Primary diffuse texture name (null-terminated string)
  ]##
  let texture0NameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.texture0Name = texture0NameExpr

  ##[
  Secondary texture name, often lightmap (null-terminated string)
  ]##
  let texture1NameExpr = encode(this.io.readBytes(int(32)).bytesTerminate(0, false), "ASCII")
  this.texture1Name = texture1NameExpr

  ##[
  Tertiary texture name (null-terminated string)
  ]##
  let texture2NameExpr = encode(this.io.readBytes(int(12)).bytesTerminate(0, false), "ASCII")
  this.texture2Name = texture2NameExpr

  ##[
  Quaternary texture name (null-terminated string)
  ]##
  let texture3NameExpr = encode(this.io.readBytes(int(12)).bytesTerminate(0, false), "ASCII")
  this.texture3Name = texture3NameExpr

  ##[
  Offset to vertex indices count array
  ]##
  let indicesCountArrayOffsetExpr = this.io.readU4le()
  this.indicesCountArrayOffset = indicesCountArrayOffsetExpr

  ##[
  Number of entries in indices count array
  ]##
  let indicesCountArrayCountExpr = this.io.readU4le()
  this.indicesCountArrayCount = indicesCountArrayCountExpr

  ##[
  Duplicate of indices count array count
  ]##
  let indicesCountArrayCountDuplicateExpr = this.io.readU4le()
  this.indicesCountArrayCountDuplicate = indicesCountArrayCountDuplicateExpr

  ##[
  Offset to vertex indices offset array
  ]##
  let indicesOffsetArrayOffsetExpr = this.io.readU4le()
  this.indicesOffsetArrayOffset = indicesOffsetArrayOffsetExpr

  ##[
  Number of entries in indices offset array
  ]##
  let indicesOffsetArrayCountExpr = this.io.readU4le()
  this.indicesOffsetArrayCount = indicesOffsetArrayCountExpr

  ##[
  Duplicate of indices offset array count
  ]##
  let indicesOffsetArrayCountDuplicateExpr = this.io.readU4le()
  this.indicesOffsetArrayCountDuplicate = indicesOffsetArrayCountDuplicateExpr

  ##[
  Offset to inverted counter array
  ]##
  let invertedCounterArrayOffsetExpr = this.io.readU4le()
  this.invertedCounterArrayOffset = invertedCounterArrayOffsetExpr

  ##[
  Number of entries in inverted counter array
  ]##
  let invertedCounterArrayCountExpr = this.io.readU4le()
  this.invertedCounterArrayCount = invertedCounterArrayCountExpr

  ##[
  Duplicate of inverted counter array count
  ]##
  let invertedCounterArrayCountDuplicateExpr = this.io.readU4le()
  this.invertedCounterArrayCountDuplicate = invertedCounterArrayCountDuplicateExpr

  ##[
  Typically {-1, -1, 0}, purpose unknown
  ]##
  for i in 0 ..< int(3):
    let it = this.io.readS4le()
    this.unknownValues.add(it)

  ##[
  Data specific to lightsaber meshes
  ]##
  for i in 0 ..< int(8):
    let it = this.io.readU1()
    this.saberUnknownData.add(it)

  ##[
  Purpose unknown
  ]##
  let unknownExpr = this.io.readU4le()
  this.unknown = unknownExpr

  ##[
  UV animation direction X, Y components (Z = jitter speed)
  ]##
  let uvDirectionExpr = Mdl_Vec3f.read(this.io, this.root, this)
  this.uvDirection = uvDirectionExpr

  ##[
  UV animation jitter amount
  ]##
  let uvJitterExpr = this.io.readF4le()
  this.uvJitter = uvJitterExpr

  ##[
  UV animation jitter speed
  ]##
  let uvJitterSpeedExpr = this.io.readF4le()
  this.uvJitterSpeed = uvJitterSpeedExpr

  ##[
  Size in bytes of each vertex in MDX data
  ]##
  let mdxVertexSizeExpr = this.io.readU4le()
  this.mdxVertexSize = mdxVertexSizeExpr

  ##[
  Bitmask of present vertex attributes:
- 0x00000001: MDX_VERTICES (vertex positions)
- 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
- 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
- 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
- 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
- 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
- 0x00000040: MDX_VERTEX_COLORS (vertex colors)
- 0x00000080: MDX_TANGENT_SPACE (tangent space data)

  ]##
  let mdxDataFlagsExpr = this.io.readU4le()
  this.mdxDataFlags = mdxDataFlagsExpr

  ##[
  Relative offset to vertex positions in MDX (or -1 if none)
  ]##
  let mdxVerticesOffsetExpr = this.io.readS4le()
  this.mdxVerticesOffset = mdxVerticesOffsetExpr

  ##[
  Relative offset to vertex normals in MDX (or -1 if none)
  ]##
  let mdxNormalsOffsetExpr = this.io.readS4le()
  this.mdxNormalsOffset = mdxNormalsOffsetExpr

  ##[
  Relative offset to vertex colors in MDX (or -1 if none)
  ]##
  let mdxVertexColorsOffsetExpr = this.io.readS4le()
  this.mdxVertexColorsOffset = mdxVertexColorsOffsetExpr

  ##[
  Relative offset to primary texture UVs in MDX (or -1 if none)
  ]##
  let mdxTex0UvsOffsetExpr = this.io.readS4le()
  this.mdxTex0UvsOffset = mdxTex0UvsOffsetExpr

  ##[
  Relative offset to secondary texture UVs in MDX (or -1 if none)
  ]##
  let mdxTex1UvsOffsetExpr = this.io.readS4le()
  this.mdxTex1UvsOffset = mdxTex1UvsOffsetExpr

  ##[
  Relative offset to tertiary texture UVs in MDX (or -1 if none)
  ]##
  let mdxTex2UvsOffsetExpr = this.io.readS4le()
  this.mdxTex2UvsOffset = mdxTex2UvsOffsetExpr

  ##[
  Relative offset to quaternary texture UVs in MDX (or -1 if none)
  ]##
  let mdxTex3UvsOffsetExpr = this.io.readS4le()
  this.mdxTex3UvsOffset = mdxTex3UvsOffsetExpr

  ##[
  Relative offset to tangent space data in MDX (or -1 if none)
  ]##
  let mdxTangentSpaceOffsetExpr = this.io.readS4le()
  this.mdxTangentSpaceOffset = mdxTangentSpaceOffsetExpr

  ##[
  Relative offset to unknown MDX data (or -1 if none)
  ]##
  let mdxUnknownOffset1Expr = this.io.readS4le()
  this.mdxUnknownOffset1 = mdxUnknownOffset1Expr

  ##[
  Relative offset to unknown MDX data (or -1 if none)
  ]##
  let mdxUnknownOffset2Expr = this.io.readS4le()
  this.mdxUnknownOffset2 = mdxUnknownOffset2Expr

  ##[
  Relative offset to unknown MDX data (or -1 if none)
  ]##
  let mdxUnknownOffset3Expr = this.io.readS4le()
  this.mdxUnknownOffset3 = mdxUnknownOffset3Expr

  ##[
  Number of vertices in mesh
  ]##
  let vertexCountExpr = this.io.readU2le()
  this.vertexCount = vertexCountExpr

  ##[
  Number of textures used by mesh
  ]##
  let textureCountExpr = this.io.readU2le()
  this.textureCount = textureCountExpr

  ##[
  1 if mesh uses lightmap, 0 otherwise
  ]##
  let lightmappedExpr = this.io.readU1()
  this.lightmapped = lightmappedExpr

  ##[
  1 if texture should rotate, 0 otherwise
  ]##
  let rotateTextureExpr = this.io.readU1()
  this.rotateTexture = rotateTextureExpr

  ##[
  1 if background geometry, 0 otherwise
  ]##
  let backgroundGeometryExpr = this.io.readU1()
  this.backgroundGeometry = backgroundGeometryExpr

  ##[
  1 if mesh casts shadows, 0 otherwise
  ]##
  let shadowExpr = this.io.readU1()
  this.shadow = shadowExpr

  ##[
  1 if beaming effect enabled, 0 otherwise
  ]##
  let beamingExpr = this.io.readU1()
  this.beaming = beamingExpr

  ##[
  1 if mesh is renderable, 0 if hidden
  ]##
  let renderExpr = this.io.readU1()
  this.render = renderExpr

  ##[
  Purpose unknown (possibly UV animation enable)
  ]##
  let unknownFlagExpr = this.io.readU1()
  this.unknownFlag = unknownFlagExpr

  ##[
  Padding byte
  ]##
  let paddingExpr = this.io.readU1()
  this.padding = paddingExpr

  ##[
  Total surface area of all faces
  ]##
  let totalAreaExpr = this.io.readF4le()
  this.totalArea = totalAreaExpr

  ##[
  Purpose unknown
  ]##
  let unknown2Expr = this.io.readU4le()
  this.unknown2 = unknown2Expr

  ##[
  KOTOR 2 only: Additional unknown field
  ]##
  if Mdl(this.root).modelHeader.geometry.isKotor2:
    let k2Unknown1Expr = this.io.readU4le()
    this.k2Unknown1 = k2Unknown1Expr

  ##[
  KOTOR 2 only: Additional unknown field
  ]##
  if Mdl(this.root).modelHeader.geometry.isKotor2:
    let k2Unknown2Expr = this.io.readU4le()
    this.k2Unknown2 = k2Unknown2Expr

  ##[
  Absolute offset to this mesh's vertex data in MDX file
  ]##
  let mdxDataOffsetExpr = this.io.readU4le()
  this.mdxDataOffset = mdxDataOffsetExpr

  ##[
  Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
  ]##
  let mdlVerticesOffsetExpr = this.io.readU4le()
  this.mdlVerticesOffset = mdlVerticesOffsetExpr

proc fromFile*(_: typedesc[Mdl_TrimeshHeader], filename: string): Mdl_TrimeshHeader =
  Mdl_TrimeshHeader.read(newKaitaiFileStream(filename), nil, nil)


##[
3D vector (3 floats)
]##
proc read*(_: typedesc[Mdl_Vec3f], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Mdl_Vec3f =
  template this: untyped = result
  this = new(Mdl_Vec3f)
  let root = if root == nil: cast[Mdl](this) else: cast[Mdl](root)
  this.io = io
  this.root = root
  this.parent = parent

  let xExpr = this.io.readF4le()
  this.x = xExpr
  let yExpr = this.io.readF4le()
  this.y = yExpr
  let zExpr = this.io.readF4le()
  this.z = zExpr

proc fromFile*(_: typedesc[Mdl_Vec3f], filename: string): Mdl_Vec3f =
  Mdl_Vec3f.read(newKaitaiFileStream(filename), nil, nil)


import kaitai_struct_nim_runtime
import options

type
  MdlAscii* = ref object of KaitaiStruct
    `lines`*: seq[MdlAscii_AsciiLine]
    `parent`*: KaitaiStruct
  MdlAscii_AnimationSection* = ref object of KaitaiStruct
    `newanim`*: MdlAscii_LineText
    `doneanim`*: MdlAscii_LineText
    `length`*: MdlAscii_LineText
    `transtime`*: MdlAscii_LineText
    `animroot`*: MdlAscii_LineText
    `event`*: MdlAscii_LineText
    `eventlist`*: MdlAscii_LineText
    `endlist`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_AsciiLine* = ref object of KaitaiStruct
    `content`*: string
    `parent`*: MdlAscii
  MdlAscii_ControllerBezier* = ref object of KaitaiStruct
    `controllerName`*: MdlAscii_LineText
    `keyframes`*: seq[MdlAscii_ControllerBezierKeyframe]
    `parent`*: KaitaiStruct
  MdlAscii_ControllerBezierKeyframe* = ref object of KaitaiStruct
    `time`*: string
    `valueData`*: string
    `parent`*: MdlAscii_ControllerBezier
  MdlAscii_ControllerKeyed* = ref object of KaitaiStruct
    `controllerName`*: MdlAscii_LineText
    `keyframes`*: seq[MdlAscii_ControllerKeyframe]
    `parent`*: KaitaiStruct
  MdlAscii_ControllerKeyframe* = ref object of KaitaiStruct
    `time`*: string
    `values`*: string
    `parent`*: MdlAscii_ControllerKeyed
  MdlAscii_ControllerSingle* = ref object of KaitaiStruct
    `controllerName`*: MdlAscii_LineText
    `values`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_DanglymeshProperties* = ref object of KaitaiStruct
    `displacement`*: MdlAscii_LineText
    `tightness`*: MdlAscii_LineText
    `period`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_DataArrays* = ref object of KaitaiStruct
    `verts`*: MdlAscii_LineText
    `faces`*: MdlAscii_LineText
    `tverts`*: MdlAscii_LineText
    `tverts1`*: MdlAscii_LineText
    `lightmaptverts`*: MdlAscii_LineText
    `tverts2`*: MdlAscii_LineText
    `tverts3`*: MdlAscii_LineText
    `texindices1`*: MdlAscii_LineText
    `texindices2`*: MdlAscii_LineText
    `texindices3`*: MdlAscii_LineText
    `colors`*: MdlAscii_LineText
    `colorindices`*: MdlAscii_LineText
    `weights`*: MdlAscii_LineText
    `constraints`*: MdlAscii_LineText
    `aabb`*: MdlAscii_LineText
    `saberVerts`*: MdlAscii_LineText
    `saberNorms`*: MdlAscii_LineText
    `name`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_EmitterFlags* = ref object of KaitaiStruct
    `p2p`*: MdlAscii_LineText
    `p2pSel`*: MdlAscii_LineText
    `affectedByWind`*: MdlAscii_LineText
    `mIsTinted`*: MdlAscii_LineText
    `bounce`*: MdlAscii_LineText
    `random`*: MdlAscii_LineText
    `inherit`*: MdlAscii_LineText
    `inheritvel`*: MdlAscii_LineText
    `inheritLocal`*: MdlAscii_LineText
    `splat`*: MdlAscii_LineText
    `inheritPart`*: MdlAscii_LineText
    `depthTexture`*: MdlAscii_LineText
    `emitterflag13`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_EmitterProperties* = ref object of KaitaiStruct
    `deadspace`*: MdlAscii_LineText
    `blastRadius`*: MdlAscii_LineText
    `blastLength`*: MdlAscii_LineText
    `numBranches`*: MdlAscii_LineText
    `controlptsmoothing`*: MdlAscii_LineText
    `xgrid`*: MdlAscii_LineText
    `ygrid`*: MdlAscii_LineText
    `spawntype`*: MdlAscii_LineText
    `update`*: MdlAscii_LineText
    `render`*: MdlAscii_LineText
    `blend`*: MdlAscii_LineText
    `texture`*: MdlAscii_LineText
    `chunkname`*: MdlAscii_LineText
    `twosidedtex`*: MdlAscii_LineText
    `loop`*: MdlAscii_LineText
    `renderorder`*: MdlAscii_LineText
    `mBFrameBlending`*: MdlAscii_LineText
    `mSDepthTextureName`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_LightProperties* = ref object of KaitaiStruct
    `flareradius`*: MdlAscii_LineText
    `flarepositions`*: MdlAscii_LineText
    `flaresizes`*: MdlAscii_LineText
    `flarecolorshifts`*: MdlAscii_LineText
    `texturenames`*: MdlAscii_LineText
    `ambientonly`*: MdlAscii_LineText
    `ndynamictype`*: MdlAscii_LineText
    `affectdynamic`*: MdlAscii_LineText
    `flare`*: MdlAscii_LineText
    `lightpriority`*: MdlAscii_LineText
    `fadinglight`*: MdlAscii_LineText
    `parent`*: KaitaiStruct
  MdlAscii_LineText* = ref object of KaitaiStruct
    `value`*: string
    `parent`*: KaitaiStruct
  MdlAscii_ReferenceProperties* = ref object of KaitaiStruct
    `refmodel`*: MdlAscii_LineText
    `reattachable`*: MdlAscii_LineText
    `parent`*: KaitaiStruct

proc read*(_: typedesc[MdlAscii], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii
proc read*(_: typedesc[MdlAscii_AnimationSection], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_AnimationSection
proc read*(_: typedesc[MdlAscii_AsciiLine], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii): MdlAscii_AsciiLine
proc read*(_: typedesc[MdlAscii_ControllerBezier], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerBezier
proc read*(_: typedesc[MdlAscii_ControllerBezierKeyframe], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii_ControllerBezier): MdlAscii_ControllerBezierKeyframe
proc read*(_: typedesc[MdlAscii_ControllerKeyed], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerKeyed
proc read*(_: typedesc[MdlAscii_ControllerKeyframe], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii_ControllerKeyed): MdlAscii_ControllerKeyframe
proc read*(_: typedesc[MdlAscii_ControllerSingle], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerSingle
proc read*(_: typedesc[MdlAscii_DanglymeshProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_DanglymeshProperties
proc read*(_: typedesc[MdlAscii_DataArrays], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_DataArrays
proc read*(_: typedesc[MdlAscii_EmitterFlags], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_EmitterFlags
proc read*(_: typedesc[MdlAscii_EmitterProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_EmitterProperties
proc read*(_: typedesc[MdlAscii_LightProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_LightProperties
proc read*(_: typedesc[MdlAscii_LineText], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_LineText
proc read*(_: typedesc[MdlAscii_ReferenceProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ReferenceProperties



##[
MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
Used by modding tools for easier editing than binary MDL format.

The ASCII format represents the model structure using plain text with keyword-based syntax.
Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.

Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
full binary-vs-text scope rule.

Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).

@see <a href="https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79">xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88">xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs)</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format">PyKotor wiki — ASCII MDL</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format">PyKotor wiki — binary MDL (wire vs ASCII)</a>
@see <a href="https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html">xoreos-docs — Torlack binmdl</a>
@see <a href="https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy">In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords)</a>
@see <a href="https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L3916-L4698">Community MDLOps — readasciimdl</a>
]##
proc read*(_: typedesc[MdlAscii], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii =
  template this: untyped = result
  this = new(MdlAscii)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent

  block:
    var i: int
    while not this.io.isEof:
      let it = MdlAscii_AsciiLine.read(this.io, this.root, this)
      this.lines.add(it)
      inc i

proc fromFile*(_: typedesc[MdlAscii], filename: string): MdlAscii =
  MdlAscii.read(newKaitaiFileStream(filename), nil, nil)


##[
Animation section keywords
]##
proc read*(_: typedesc[MdlAscii_AnimationSection], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_AnimationSection =
  template this: untyped = result
  this = new(MdlAscii_AnimationSection)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  newanim <animation_name> <model_name> - Start of animation definition
  ]##
  let newanimExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.newanim = newanimExpr

  ##[
  doneanim <animation_name> <model_name> - End of animation definition
  ]##
  let doneanimExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.doneanim = doneanimExpr

  ##[
  length <duration> - Animation duration in seconds
  ]##
  let lengthExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.length = lengthExpr

  ##[
  transtime <transition_time> - Transition/blend time to this animation in seconds
  ]##
  let transtimeExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.transtime = transtimeExpr

  ##[
  animroot <root_node_name> - Root node name for animation
  ]##
  let animrootExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.animroot = animrootExpr

  ##[
  event <time> <event_name> - Animation event (triggers at specified time)
  ]##
  let eventExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.event = eventExpr

  ##[
  eventlist - Start of animation events list
  ]##
  let eventlistExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.eventlist = eventlistExpr

  ##[
  endlist - End of list (controllers, events, etc.)
  ]##
  let endlistExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.endlist = endlistExpr

proc fromFile*(_: typedesc[MdlAscii_AnimationSection], filename: string): MdlAscii_AnimationSection =
  MdlAscii_AnimationSection.read(newKaitaiFileStream(filename), nil, nil)


##[
Single line in ASCII MDL file
]##
proc read*(_: typedesc[MdlAscii_AsciiLine], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii): MdlAscii_AsciiLine =
  template this: untyped = result
  this = new(MdlAscii_AsciiLine)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent

  let contentExpr = encode(this.io.readBytesTerm(10, false, true, false), "UTF-8")
  this.content = contentExpr

proc fromFile*(_: typedesc[MdlAscii_AsciiLine], filename: string): MdlAscii_AsciiLine =
  MdlAscii_AsciiLine.read(newKaitaiFileStream(filename), nil, nil)


##[
Bezier (smooth animated) controller format
]##
proc read*(_: typedesc[MdlAscii_ControllerBezier], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerBezier =
  template this: untyped = result
  this = new(MdlAscii_ControllerBezier)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Controller name followed by 'bezierkey' (e.g., positionbezierkey, orientationbezierkey)
  ]##
  let controllerNameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.controllerName = controllerNameExpr

  ##[
  Keyframe entries until endlist keyword
  ]##
  block:
    var i: int
    while not this.io.isEof:
      let it = MdlAscii_ControllerBezierKeyframe.read(this.io, this.root, this)
      this.keyframes.add(it)
      inc i

proc fromFile*(_: typedesc[MdlAscii_ControllerBezier], filename: string): MdlAscii_ControllerBezier =
  MdlAscii_ControllerBezier.read(newKaitaiFileStream(filename), nil, nil)


##[
Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)
]##
proc read*(_: typedesc[MdlAscii_ControllerBezierKeyframe], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii_ControllerBezier): MdlAscii_ControllerBezierKeyframe =
  template this: untyped = result
  this = new(MdlAscii_ControllerBezierKeyframe)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Time value (float)
  ]##
  let timeExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.time = timeExpr

  ##[
  Space-separated values (3 times column_count floats: value, in_tangent, out_tangent for each column)
  ]##
  let valueDataExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.valueData = valueDataExpr

proc fromFile*(_: typedesc[MdlAscii_ControllerBezierKeyframe], filename: string): MdlAscii_ControllerBezierKeyframe =
  MdlAscii_ControllerBezierKeyframe.read(newKaitaiFileStream(filename), nil, nil)


##[
Keyed (animated) controller format
]##
proc read*(_: typedesc[MdlAscii_ControllerKeyed], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerKeyed =
  template this: untyped = result
  this = new(MdlAscii_ControllerKeyed)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Controller name followed by 'key' (e.g., positionkey, orientationkey)
  ]##
  let controllerNameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.controllerName = controllerNameExpr

  ##[
  Keyframe entries until endlist keyword
  ]##
  block:
    var i: int
    while not this.io.isEof:
      let it = MdlAscii_ControllerKeyframe.read(this.io, this.root, this)
      this.keyframes.add(it)
      inc i

proc fromFile*(_: typedesc[MdlAscii_ControllerKeyed], filename: string): MdlAscii_ControllerKeyed =
  MdlAscii_ControllerKeyed.read(newKaitaiFileStream(filename), nil, nil)


##[
Single keyframe in keyed controller
]##
proc read*(_: typedesc[MdlAscii_ControllerKeyframe], io: KaitaiStream, root: KaitaiStruct, parent: MdlAscii_ControllerKeyed): MdlAscii_ControllerKeyframe =
  template this: untyped = result
  this = new(MdlAscii_ControllerKeyframe)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Time value (float)
  ]##
  let timeExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.time = timeExpr

  ##[
  Space-separated property values (number depends on controller type and column count)
  ]##
  let valuesExpr = encode(this.io.readBytesFull(), "UTF-8")
  this.values = valuesExpr

proc fromFile*(_: typedesc[MdlAscii_ControllerKeyframe], filename: string): MdlAscii_ControllerKeyframe =
  MdlAscii_ControllerKeyframe.read(newKaitaiFileStream(filename), nil, nil)


##[
Single (constant) controller format
]##
proc read*(_: typedesc[MdlAscii_ControllerSingle], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ControllerSingle =
  template this: untyped = result
  this = new(MdlAscii_ControllerSingle)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Controller name (position, orientation, scale, color, radius, etc.)
  ]##
  let controllerNameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.controllerName = controllerNameExpr

  ##[
  Space-separated controller values (number depends on controller type)
  ]##
  let valuesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.values = valuesExpr

proc fromFile*(_: typedesc[MdlAscii_ControllerSingle], filename: string): MdlAscii_ControllerSingle =
  MdlAscii_ControllerSingle.read(newKaitaiFileStream(filename), nil, nil)


##[
Danglymesh node properties
]##
proc read*(_: typedesc[MdlAscii_DanglymeshProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_DanglymeshProperties =
  template this: untyped = result
  this = new(MdlAscii_DanglymeshProperties)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  displacement <value> - Maximum displacement distance for physics simulation
  ]##
  let displacementExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.displacement = displacementExpr

  ##[
  tightness <value> - Tightness/stiffness of spring simulation (0.0-1.0)
  ]##
  let tightnessExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.tightness = tightnessExpr

  ##[
  period <value> - Oscillation period in seconds
  ]##
  let periodExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.period = periodExpr

proc fromFile*(_: typedesc[MdlAscii_DanglymeshProperties], filename: string): MdlAscii_DanglymeshProperties =
  MdlAscii_DanglymeshProperties.read(newKaitaiFileStream(filename), nil, nil)


##[
Data array keywords
]##
proc read*(_: typedesc[MdlAscii_DataArrays], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_DataArrays =
  template this: untyped = result
  this = new(MdlAscii_DataArrays)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  verts <count> - Start vertex positions array (count vertices, 3 floats each: X, Y, Z)
  ]##
  let vertsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.verts = vertsExpr

  ##[
  faces <count> - Start faces array (count faces, format: normal_x normal_y normal_z plane_coeff mat_id adj1 adj2 adj3 v1 v2 v3 [t1 t2 t3])
  ]##
  let facesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.faces = facesExpr

  ##[
  tverts <count> - Start primary texture coordinates array (count UVs, 2 floats each: U, V)
  ]##
  let tvertsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.tverts = tvertsExpr

  ##[
  tverts1 <count> - Start secondary texture coordinates array (count UVs, 2 floats each: U, V)
  ]##
  let tverts1Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.tverts1 = tverts1Expr

  ##[
  lightmaptverts <count> - Start lightmap texture coordinates (magnusll export compatibility, same as tverts1)
  ]##
  let lightmaptvertsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.lightmaptverts = lightmaptvertsExpr

  ##[
  tverts2 <count> - Start tertiary texture coordinates array (count UVs, 2 floats each: U, V)
  ]##
  let tverts2Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.tverts2 = tverts2Expr

  ##[
  tverts3 <count> - Start quaternary texture coordinates array (count UVs, 2 floats each: U, V)
  ]##
  let tverts3Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.tverts3 = tverts3Expr

  ##[
  texindices1 <count> - Start texture indices array for 2nd texture (count face indices, 3 indices per face)
  ]##
  let texindices1Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.texindices1 = texindices1Expr

  ##[
  texindices2 <count> - Start texture indices array for 3rd texture (count face indices, 3 indices per face)
  ]##
  let texindices2Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.texindices2 = texindices2Expr

  ##[
  texindices3 <count> - Start texture indices array for 4th texture (count face indices, 3 indices per face)
  ]##
  let texindices3Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.texindices3 = texindices3Expr

  ##[
  colors <count> - Start vertex colors array (count colors, 3 floats each: R, G, B)
  ]##
  let colorsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.colors = colorsExpr

  ##[
  colorindices <count> - Start vertex color indices array (count face indices, 3 indices per face)
  ]##
  let colorindicesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.colorindices = colorindicesExpr

  ##[
  weights <count> - Start bone weights array (count weights, format: bone1 weight1 [bone2 weight2 [bone3 weight3 [bone4 weight4]]])
  ]##
  let weightsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.weights = weightsExpr

  ##[
  constraints <count> - Start vertex constraints array for danglymesh (count floats, one per vertex)
  ]##
  let constraintsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.constraints = constraintsExpr

  ##[
  aabb [min_x min_y min_z max_x max_y max_z leaf_part] - AABB tree node (can be inline or multi-line)
  ]##
  let aabbExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.aabb = aabbExpr

  ##[
  saber_verts <count> - Start lightsaber vertex positions array (count vertices, 3 floats each: X, Y, Z)
  ]##
  let saberVertsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.saberVerts = saberVertsExpr

  ##[
  saber_norms <count> - Start lightsaber vertex normals array (count normals, 3 floats each: X, Y, Z)
  ]##
  let saberNormsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.saberNorms = saberNormsExpr

  ##[
  name <node_name> - MDLedit-style name entry for walkmesh nodes (fakenodes)
  ]##
  let nameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.name = nameExpr

proc fromFile*(_: typedesc[MdlAscii_DataArrays], filename: string): MdlAscii_DataArrays =
  MdlAscii_DataArrays.read(newKaitaiFileStream(filename), nil, nil)


##[
Emitter behavior flags
]##
proc read*(_: typedesc[MdlAscii_EmitterFlags], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_EmitterFlags =
  template this: untyped = result
  this = new(MdlAscii_EmitterFlags)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  p2p <0_or_1> - Point-to-point flag (bit 0x0001)
  ]##
  let p2pExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.p2p = p2pExpr

  ##[
  p2p_sel <0_or_1> - Point-to-point selection flag (bit 0x0002)
  ]##
  let p2pSelExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.p2pSel = p2pSelExpr

  ##[
  affectedByWind <0_or_1> - Affected by wind flag (bit 0x0004)
  ]##
  let affectedByWindExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.affectedByWind = affectedByWindExpr

  ##[
  m_isTinted <0_or_1> - Is tinted flag (bit 0x0008)
  ]##
  let mIsTintedExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.mIsTinted = mIsTintedExpr

  ##[
  bounce <0_or_1> - Bounce flag (bit 0x0010)
  ]##
  let bounceExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.bounce = bounceExpr

  ##[
  random <0_or_1> - Random flag (bit 0x0020)
  ]##
  let randomExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.random = randomExpr

  ##[
  inherit <0_or_1> - Inherit flag (bit 0x0040)
  ]##
  let inheritExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.inherit = inheritExpr

  ##[
  inheritvel <0_or_1> - Inherit velocity flag (bit 0x0080)
  ]##
  let inheritvelExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.inheritvel = inheritvelExpr

  ##[
  inherit_local <0_or_1> - Inherit local flag (bit 0x0100)
  ]##
  let inheritLocalExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.inheritLocal = inheritLocalExpr

  ##[
  splat <0_or_1> - Splat flag (bit 0x0200)
  ]##
  let splatExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.splat = splatExpr

  ##[
  inherit_part <0_or_1> - Inherit part flag (bit 0x0400)
  ]##
  let inheritPartExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.inheritPart = inheritPartExpr

  ##[
  depth_texture <0_or_1> - Depth texture flag (bit 0x0800)
  ]##
  let depthTextureExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.depthTexture = depthTextureExpr

  ##[
  emitterflag13 <0_or_1> - Emitter flag 13 (bit 0x1000)
  ]##
  let emitterflag13Expr = MdlAscii_LineText.read(this.io, this.root, this)
  this.emitterflag13 = emitterflag13Expr

proc fromFile*(_: typedesc[MdlAscii_EmitterFlags], filename: string): MdlAscii_EmitterFlags =
  MdlAscii_EmitterFlags.read(newKaitaiFileStream(filename), nil, nil)


##[
Emitter node properties
]##
proc read*(_: typedesc[MdlAscii_EmitterProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_EmitterProperties =
  template this: untyped = result
  this = new(MdlAscii_EmitterProperties)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  deadspace <value> - Minimum distance from emitter before particles become visible
  ]##
  let deadspaceExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.deadspace = deadspaceExpr

  ##[
  blastRadius <value> - Radius of explosive/blast particle effects
  ]##
  let blastRadiusExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.blastRadius = blastRadiusExpr

  ##[
  blastLength <value> - Length/duration of blast effects
  ]##
  let blastLengthExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.blastLength = blastLengthExpr

  ##[
  numBranches <value> - Number of branching paths for particle trails
  ]##
  let numBranchesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.numBranches = numBranchesExpr

  ##[
  controlptsmoothing <value> - Smoothing factor for particle path control points
  ]##
  let controlptsmoothingExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.controlptsmoothing = controlptsmoothingExpr

  ##[
  xgrid <value> - Grid subdivisions along X axis for particle spawning
  ]##
  let xgridExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.xgrid = xgridExpr

  ##[
  ygrid <value> - Grid subdivisions along Y axis for particle spawning
  ]##
  let ygridExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.ygrid = ygridExpr

  ##[
  spawntype <value> - Particle spawn type
  ]##
  let spawntypeExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.spawntype = spawntypeExpr

  ##[
  update <script_name> - Update behavior script name (e.g., single, fountain)
  ]##
  let updateExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.update = updateExpr

  ##[
  render <script_name> - Render mode script name (e.g., normal, billboard_to_local_z)
  ]##
  let renderExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.render = renderExpr

  ##[
  blend <script_name> - Blend mode script name (e.g., normal, lighten)
  ]##
  let blendExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.blend = blendExpr

  ##[
  texture <texture_name> - Particle texture name
  ]##
  let textureExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.texture = textureExpr

  ##[
  chunkname <chunk_name> - Associated model chunk name
  ]##
  let chunknameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.chunkname = chunknameExpr

  ##[
  twosidedtex <0_or_1> - Whether texture should render two-sided (1=two-sided, 0=single-sided)
  ]##
  let twosidedtexExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.twosidedtex = twosidedtexExpr

  ##[
  loop <0_or_1> - Whether particle system loops (1=loops, 0=single playback)
  ]##
  let loopExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.loop = loopExpr

  ##[
  renderorder <value> - Rendering priority/order for particle sorting
  ]##
  let renderorderExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.renderorder = renderorderExpr

  ##[
  m_bFrameBlending <0_or_1> - Whether frame blending is enabled (1=enabled, 0=disabled)
  ]##
  let mBFrameBlendingExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.mBFrameBlending = mBFrameBlendingExpr

  ##[
  m_sDepthTextureName <texture_name> - Depth/softparticle texture name
  ]##
  let mSDepthTextureNameExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.mSDepthTextureName = mSDepthTextureNameExpr

proc fromFile*(_: typedesc[MdlAscii_EmitterProperties], filename: string): MdlAscii_EmitterProperties =
  MdlAscii_EmitterProperties.read(newKaitaiFileStream(filename), nil, nil)


##[
Light node properties
]##
proc read*(_: typedesc[MdlAscii_LightProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_LightProperties =
  template this: untyped = result
  this = new(MdlAscii_LightProperties)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  flareradius <value> - Radius of lens flare effect
  ]##
  let flareradiusExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.flareradius = flareradiusExpr

  ##[
  flarepositions <count> - Start flare positions array (count floats, 0.0-1.0 along light ray)
  ]##
  let flarepositionsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.flarepositions = flarepositionsExpr

  ##[
  flaresizes <count> - Start flare sizes array (count floats)
  ]##
  let flaresizesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.flaresizes = flaresizesExpr

  ##[
  flarecolorshifts <count> - Start flare color shifts array (count RGB floats)
  ]##
  let flarecolorshiftsExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.flarecolorshifts = flarecolorshiftsExpr

  ##[
  texturenames <count> - Start flare texture names array (count strings)
  ]##
  let texturenamesExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.texturenames = texturenamesExpr

  ##[
  ambientonly <0_or_1> - Whether light only affects ambient (1=ambient only, 0=full lighting)
  ]##
  let ambientonlyExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.ambientonly = ambientonlyExpr

  ##[
  ndynamictype <value> - Type of dynamic lighting behavior
  ]##
  let ndynamictypeExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.ndynamictype = ndynamictypeExpr

  ##[
  affectdynamic <0_or_1> - Whether light affects dynamic objects (1=affects, 0=static only)
  ]##
  let affectdynamicExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.affectdynamic = affectdynamicExpr

  ##[
  flare <0_or_1> - Whether lens flare effect is enabled (1=enabled, 0=disabled)
  ]##
  let flareExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.flare = flareExpr

  ##[
  lightpriority <value> - Rendering priority for light culling/sorting
  ]##
  let lightpriorityExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.lightpriority = lightpriorityExpr

  ##[
  fadinglight <0_or_1> - Whether light intensity fades with distance (1=fades, 0=constant)
  ]##
  let fadinglightExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.fadinglight = fadinglightExpr

proc fromFile*(_: typedesc[MdlAscii_LightProperties], filename: string): MdlAscii_LightProperties =
  MdlAscii_LightProperties.read(newKaitaiFileStream(filename), nil, nil)


##[
A single UTF-8 text line (without the trailing newline).
Used to make doc-oriented keyword/type listings schema-valid for Kaitai.

]##
proc read*(_: typedesc[MdlAscii_LineText], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_LineText =
  template this: untyped = result
  this = new(MdlAscii_LineText)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent

  let valueExpr = encode(this.io.readBytesTerm(10, false, true, false), "UTF-8")
  this.value = valueExpr

proc fromFile*(_: typedesc[MdlAscii_LineText], filename: string): MdlAscii_LineText =
  MdlAscii_LineText.read(newKaitaiFileStream(filename), nil, nil)


##[
Reference node properties
]##
proc read*(_: typedesc[MdlAscii_ReferenceProperties], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): MdlAscii_ReferenceProperties =
  template this: untyped = result
  this = new(MdlAscii_ReferenceProperties)
  let root = if root == nil: cast[MdlAscii](this) else: cast[MdlAscii](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  refmodel <model_resref> - Referenced model resource name without extension
  ]##
  let refmodelExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.refmodel = refmodelExpr

  ##[
  reattachable <0_or_1> - Whether model can be detached and reattached dynamically (1=reattachable, 0=permanent)
  ]##
  let reattachableExpr = MdlAscii_LineText.read(this.io, this.root, this)
  this.reattachable = reattachableExpr

proc fromFile*(_: typedesc[MdlAscii_ReferenceProperties], filename: string): MdlAscii_ReferenceProperties =
  MdlAscii_ReferenceProperties.read(newKaitaiFileStream(filename), nil, nil)


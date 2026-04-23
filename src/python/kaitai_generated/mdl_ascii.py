# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class MdlAscii(KaitaiStruct):
    """MDL ASCII format is a human-readable ASCII text representation of MDL (Model) binary files.
    Used by modding tools for easier editing than binary MDL format.
    
    The ASCII format represents the model structure using plain text with keyword-based syntax.
    Lines are parsed sequentially, with keywords indicating sections, nodes, properties, and data arrays.
    
    Repository policy: NWScript source (`.nss`) and other plaintext interchange (including ASCII MDL) are
    documented in `.ksy` only where a line-oriented schema is useful for tooling; see `AGENTS.md` for the
    full binary-vs-text scope rule.
    
    Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format — ASCII MDL Format section
    Reference: https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L3916-L4698 — `readasciimdl` (Perl; line band matches former PyKotor vendor drop)
    Binary wire IDs (for cross-checking ASCII integers): PyKotor wiki binary MDL section, xoreos-docs Torlack `binmdl.html`,
    and `formats/Common/bioware_mdl_common.ksy` (canonical enum tables; this ASCII spec does not duplicate them as local `enums:`).
    
    .. seealso::
       xoreos — `Model_KotOR::ParserContext` (binary KotOR MDL reader state; contrast with this plaintext ASCII wire) - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79
    
    
    .. seealso::
       xoreos — `kFileTypeMDL` / `kFileTypeMDX` (`FileType` IDs) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L81-L88
    
    
    .. seealso::
       PyKotor wiki — ASCII MDL - https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#ascii-mdl-format
    
    
    .. seealso::
       PyKotor wiki — binary MDL (wire vs ASCII) - https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format#binary-mdl-format
    
    
    .. seealso::
       xoreos-docs — Torlack binmdl - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html
    
    
    .. seealso::
       In-tree — shared MDL/MDX wire enums (cross-check ASCII numeric keywords) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy
    
    
    .. seealso::
       Community MDLOps — readasciimdl - https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L3916-L4698
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(MdlAscii, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.lines = []
        i = 0
        while not self._io.is_eof():
            self.lines.append(MdlAscii.AsciiLine(self._io, self, self._root))
            i += 1



    def _fetch_instances(self):
        pass
        for i in range(len(self.lines)):
            pass
            self.lines[i]._fetch_instances()


    class AnimationSection(KaitaiStruct):
        """Animation section keywords."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.AnimationSection, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.newanim = MdlAscii.LineText(self._io, self, self._root)
            self.doneanim = MdlAscii.LineText(self._io, self, self._root)
            self.length = MdlAscii.LineText(self._io, self, self._root)
            self.transtime = MdlAscii.LineText(self._io, self, self._root)
            self.animroot = MdlAscii.LineText(self._io, self, self._root)
            self.event = MdlAscii.LineText(self._io, self, self._root)
            self.eventlist = MdlAscii.LineText(self._io, self, self._root)
            self.endlist = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.newanim._fetch_instances()
            self.doneanim._fetch_instances()
            self.length._fetch_instances()
            self.transtime._fetch_instances()
            self.animroot._fetch_instances()
            self.event._fetch_instances()
            self.eventlist._fetch_instances()
            self.endlist._fetch_instances()


    class AsciiLine(KaitaiStruct):
        """Single line in ASCII MDL file."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.AsciiLine, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.content = (self._io.read_bytes_term(10, False, True, False)).decode(u"UTF-8")


        def _fetch_instances(self):
            pass


    class ControllerBezier(KaitaiStruct):
        """Bezier (smooth animated) controller format."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ControllerBezier, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.controller_name = MdlAscii.LineText(self._io, self, self._root)
            self.keyframes = []
            i = 0
            while not self._io.is_eof():
                self.keyframes.append(MdlAscii.ControllerBezierKeyframe(self._io, self, self._root))
                i += 1



        def _fetch_instances(self):
            pass
            self.controller_name._fetch_instances()
            for i in range(len(self.keyframes)):
                pass
                self.keyframes[i]._fetch_instances()



    class ControllerBezierKeyframe(KaitaiStruct):
        """Single keyframe in Bezier controller (stores value + in_tangent + out_tangent per column)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ControllerBezierKeyframe, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.time = (self._io.read_bytes_full()).decode(u"UTF-8")
            self.value_data = (self._io.read_bytes_full()).decode(u"UTF-8")


        def _fetch_instances(self):
            pass


    class ControllerKeyed(KaitaiStruct):
        """Keyed (animated) controller format."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ControllerKeyed, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.controller_name = MdlAscii.LineText(self._io, self, self._root)
            self.keyframes = []
            i = 0
            while not self._io.is_eof():
                self.keyframes.append(MdlAscii.ControllerKeyframe(self._io, self, self._root))
                i += 1



        def _fetch_instances(self):
            pass
            self.controller_name._fetch_instances()
            for i in range(len(self.keyframes)):
                pass
                self.keyframes[i]._fetch_instances()



    class ControllerKeyframe(KaitaiStruct):
        """Single keyframe in keyed controller."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ControllerKeyframe, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.time = (self._io.read_bytes_full()).decode(u"UTF-8")
            self.values = (self._io.read_bytes_full()).decode(u"UTF-8")


        def _fetch_instances(self):
            pass


    class ControllerSingle(KaitaiStruct):
        """Single (constant) controller format."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ControllerSingle, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.controller_name = MdlAscii.LineText(self._io, self, self._root)
            self.values = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.controller_name._fetch_instances()
            self.values._fetch_instances()


    class DanglymeshProperties(KaitaiStruct):
        """Danglymesh node properties."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.DanglymeshProperties, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.displacement = MdlAscii.LineText(self._io, self, self._root)
            self.tightness = MdlAscii.LineText(self._io, self, self._root)
            self.period = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.displacement._fetch_instances()
            self.tightness._fetch_instances()
            self.period._fetch_instances()


    class DataArrays(KaitaiStruct):
        """Data array keywords."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.DataArrays, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.verts = MdlAscii.LineText(self._io, self, self._root)
            self.faces = MdlAscii.LineText(self._io, self, self._root)
            self.tverts = MdlAscii.LineText(self._io, self, self._root)
            self.tverts1 = MdlAscii.LineText(self._io, self, self._root)
            self.lightmaptverts = MdlAscii.LineText(self._io, self, self._root)
            self.tverts2 = MdlAscii.LineText(self._io, self, self._root)
            self.tverts3 = MdlAscii.LineText(self._io, self, self._root)
            self.texindices1 = MdlAscii.LineText(self._io, self, self._root)
            self.texindices2 = MdlAscii.LineText(self._io, self, self._root)
            self.texindices3 = MdlAscii.LineText(self._io, self, self._root)
            self.colors = MdlAscii.LineText(self._io, self, self._root)
            self.colorindices = MdlAscii.LineText(self._io, self, self._root)
            self.weights = MdlAscii.LineText(self._io, self, self._root)
            self.constraints = MdlAscii.LineText(self._io, self, self._root)
            self.aabb = MdlAscii.LineText(self._io, self, self._root)
            self.saber_verts = MdlAscii.LineText(self._io, self, self._root)
            self.saber_norms = MdlAscii.LineText(self._io, self, self._root)
            self.name = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.verts._fetch_instances()
            self.faces._fetch_instances()
            self.tverts._fetch_instances()
            self.tverts1._fetch_instances()
            self.lightmaptverts._fetch_instances()
            self.tverts2._fetch_instances()
            self.tverts3._fetch_instances()
            self.texindices1._fetch_instances()
            self.texindices2._fetch_instances()
            self.texindices3._fetch_instances()
            self.colors._fetch_instances()
            self.colorindices._fetch_instances()
            self.weights._fetch_instances()
            self.constraints._fetch_instances()
            self.aabb._fetch_instances()
            self.saber_verts._fetch_instances()
            self.saber_norms._fetch_instances()
            self.name._fetch_instances()


    class EmitterFlags(KaitaiStruct):
        """Emitter behavior flags."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.EmitterFlags, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.p2p = MdlAscii.LineText(self._io, self, self._root)
            self.p2p_sel = MdlAscii.LineText(self._io, self, self._root)
            self.affected_by_wind = MdlAscii.LineText(self._io, self, self._root)
            self.m_is_tinted = MdlAscii.LineText(self._io, self, self._root)
            self.bounce = MdlAscii.LineText(self._io, self, self._root)
            self.random = MdlAscii.LineText(self._io, self, self._root)
            self.inherit = MdlAscii.LineText(self._io, self, self._root)
            self.inheritvel = MdlAscii.LineText(self._io, self, self._root)
            self.inherit_local = MdlAscii.LineText(self._io, self, self._root)
            self.splat = MdlAscii.LineText(self._io, self, self._root)
            self.inherit_part = MdlAscii.LineText(self._io, self, self._root)
            self.depth_texture = MdlAscii.LineText(self._io, self, self._root)
            self.emitterflag13 = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.p2p._fetch_instances()
            self.p2p_sel._fetch_instances()
            self.affected_by_wind._fetch_instances()
            self.m_is_tinted._fetch_instances()
            self.bounce._fetch_instances()
            self.random._fetch_instances()
            self.inherit._fetch_instances()
            self.inheritvel._fetch_instances()
            self.inherit_local._fetch_instances()
            self.splat._fetch_instances()
            self.inherit_part._fetch_instances()
            self.depth_texture._fetch_instances()
            self.emitterflag13._fetch_instances()


    class EmitterProperties(KaitaiStruct):
        """Emitter node properties."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.EmitterProperties, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.deadspace = MdlAscii.LineText(self._io, self, self._root)
            self.blast_radius = MdlAscii.LineText(self._io, self, self._root)
            self.blast_length = MdlAscii.LineText(self._io, self, self._root)
            self.num_branches = MdlAscii.LineText(self._io, self, self._root)
            self.controlptsmoothing = MdlAscii.LineText(self._io, self, self._root)
            self.xgrid = MdlAscii.LineText(self._io, self, self._root)
            self.ygrid = MdlAscii.LineText(self._io, self, self._root)
            self.spawntype = MdlAscii.LineText(self._io, self, self._root)
            self.update = MdlAscii.LineText(self._io, self, self._root)
            self.render = MdlAscii.LineText(self._io, self, self._root)
            self.blend = MdlAscii.LineText(self._io, self, self._root)
            self.texture = MdlAscii.LineText(self._io, self, self._root)
            self.chunkname = MdlAscii.LineText(self._io, self, self._root)
            self.twosidedtex = MdlAscii.LineText(self._io, self, self._root)
            self.loop = MdlAscii.LineText(self._io, self, self._root)
            self.renderorder = MdlAscii.LineText(self._io, self, self._root)
            self.m_b_frame_blending = MdlAscii.LineText(self._io, self, self._root)
            self.m_s_depth_texture_name = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.deadspace._fetch_instances()
            self.blast_radius._fetch_instances()
            self.blast_length._fetch_instances()
            self.num_branches._fetch_instances()
            self.controlptsmoothing._fetch_instances()
            self.xgrid._fetch_instances()
            self.ygrid._fetch_instances()
            self.spawntype._fetch_instances()
            self.update._fetch_instances()
            self.render._fetch_instances()
            self.blend._fetch_instances()
            self.texture._fetch_instances()
            self.chunkname._fetch_instances()
            self.twosidedtex._fetch_instances()
            self.loop._fetch_instances()
            self.renderorder._fetch_instances()
            self.m_b_frame_blending._fetch_instances()
            self.m_s_depth_texture_name._fetch_instances()


    class LightProperties(KaitaiStruct):
        """Light node properties."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.LightProperties, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.flareradius = MdlAscii.LineText(self._io, self, self._root)
            self.flarepositions = MdlAscii.LineText(self._io, self, self._root)
            self.flaresizes = MdlAscii.LineText(self._io, self, self._root)
            self.flarecolorshifts = MdlAscii.LineText(self._io, self, self._root)
            self.texturenames = MdlAscii.LineText(self._io, self, self._root)
            self.ambientonly = MdlAscii.LineText(self._io, self, self._root)
            self.ndynamictype = MdlAscii.LineText(self._io, self, self._root)
            self.affectdynamic = MdlAscii.LineText(self._io, self, self._root)
            self.flare = MdlAscii.LineText(self._io, self, self._root)
            self.lightpriority = MdlAscii.LineText(self._io, self, self._root)
            self.fadinglight = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.flareradius._fetch_instances()
            self.flarepositions._fetch_instances()
            self.flaresizes._fetch_instances()
            self.flarecolorshifts._fetch_instances()
            self.texturenames._fetch_instances()
            self.ambientonly._fetch_instances()
            self.ndynamictype._fetch_instances()
            self.affectdynamic._fetch_instances()
            self.flare._fetch_instances()
            self.lightpriority._fetch_instances()
            self.fadinglight._fetch_instances()


    class LineText(KaitaiStruct):
        """A single UTF-8 text line (without the trailing newline).
        Used to make doc-oriented keyword/type listings schema-valid for Kaitai.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.LineText, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(10, False, True, False)).decode(u"UTF-8")


        def _fetch_instances(self):
            pass


    class ReferenceProperties(KaitaiStruct):
        """Reference node properties."""
        def __init__(self, _io, _parent=None, _root=None):
            super(MdlAscii.ReferenceProperties, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.refmodel = MdlAscii.LineText(self._io, self, self._root)
            self.reattachable = MdlAscii.LineText(self._io, self, self._root)


        def _fetch_instances(self):
            pass
            self.refmodel._fetch_instances()
            self.reattachable._fetch_instances()




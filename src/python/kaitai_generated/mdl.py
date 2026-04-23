# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_mdl_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Mdl(KaitaiStruct):
    """BioWare MDL Model Format
    
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
    
    .. seealso::
       In-tree — shared MDL/MDX wire enums (`bioware_mdl_common`) - https://github.com/OpenKotOR/bioware-kaitai-formats/blob/master/formats/Common/bioware_mdl_common.ksy
    
    
    .. seealso::
       PyKotor wiki — MDL/MDX - https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    
    
    .. seealso::
       PyKotor — MDLBinaryReader (binary MDL/MDX) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408
    
    
    .. seealso::
       xoreos — Model_KotOR::load - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L184-L267
    
    
    .. seealso::
       xoreos — `Model_KotOR::ParserContext` (MDL/MDX stream pointers + cached header fields consumed during binary load) - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.h#L45-L79
    
    
    .. seealso::
       xoreos-tools — shipped CLI inventory (no MDL/MDX-specific tool) - https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43
    
    
    .. seealso::
       xoreos-docs — KotOR MDL overview - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html
    
    
    .. seealso::
       xoreos-docs — Torlack binmdl (controller / Aurora background) - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html
    
    
    .. seealso::
       reone — MdlMdxReader::load - https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L55-L118
    
    
    .. seealso::
       KotOR.js — OdysseyModel binary constructor - https://github.com/KobaltBlu/KotOR.js/blob/master/src/odyssey/OdysseyModel.ts#L56-L170
    
    
    .. seealso::
       Community MDLOps — controller name table - https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L342-L407
    
    
    .. seealso::
       Community MDLOps — `readasciimdl` (ASCII MDL ingest) - https://github.com/th3w1zard1/mdlops/blob/master/MDLOpsM.pm#L3916-L4698
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Mdl, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_header = Mdl.FileHeader(self._io, self, self._root)
        self.model_header = Mdl.ModelHeader(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.file_header._fetch_instances()
        self.model_header._fetch_instances()
        _ = self.animation_offsets
        if hasattr(self, '_m_animation_offsets'):
            pass
            for i in range(len(self._m_animation_offsets)):
                pass


        _ = self.animations
        if hasattr(self, '_m_animations'):
            pass
            for i in range(len(self._m_animations)):
                pass
                self._m_animations[i]._fetch_instances()


        _ = self.name_offsets
        if hasattr(self, '_m_name_offsets'):
            pass
            for i in range(len(self._m_name_offsets)):
                pass


        _ = self.names_data
        if hasattr(self, '_m_names_data'):
            pass
            self._m_names_data._fetch_instances()

        _ = self.root_node
        if hasattr(self, '_m_root_node'):
            pass
            self._m_root_node._fetch_instances()


    class AabbHeader(KaitaiStruct):
        """AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.AabbHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
            self.unknown = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.trimesh_base._fetch_instances()


    class AnimationEvent(KaitaiStruct):
        """Animation event (36 bytes)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.AnimationEvent, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.activation_time = self._io.read_f4le()
            self.event_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")


        def _fetch_instances(self):
            pass


    class AnimationHeader(KaitaiStruct):
        """Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.AnimationHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.geo_header = Mdl.GeometryHeader(self._io, self, self._root)
            self.animation_length = self._io.read_f4le()
            self.transition_time = self._io.read_f4le()
            self.animation_root = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.event_array_offset = self._io.read_u4le()
            self.event_count = self._io.read_u4le()
            self.event_count_duplicate = self._io.read_u4le()
            self.unknown = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.geo_header._fetch_instances()


    class AnimmeshHeader(KaitaiStruct):
        """Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.AnimmeshHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
            self.unknown = self._io.read_f4le()
            self.unknown_array = Mdl.ArrayDefinition(self._io, self, self._root)
            self.unknown_floats = []
            for i in range(9):
                self.unknown_floats.append(self._io.read_f4le())



        def _fetch_instances(self):
            pass
            self.trimesh_base._fetch_instances()
            self.unknown_array._fetch_instances()
            for i in range(len(self.unknown_floats)):
                pass



    class ArrayDefinition(KaitaiStruct):
        """Array definition structure (offset, count, count duplicate)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.ArrayDefinition, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.offset = self._io.read_s4le()
            self.count = self._io.read_u4le()
            self.count_duplicate = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class Controller(KaitaiStruct):
        """Controller structure (16 bytes) - defines animation data for a node property over time."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.Controller, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.type = KaitaiStream.resolve_enum(bioware_mdl_common.BiowareMdlCommon.ControllerType, self._io.read_u4le())
            self.unknown = self._io.read_u2le()
            self.row_count = self._io.read_u2le()
            self.time_index = self._io.read_u2le()
            self.data_index = self._io.read_u2le()
            self.column_count = self._io.read_u1()
            self.padding = []
            for i in range(3):
                self.padding.append(self._io.read_u1())



        def _fetch_instances(self):
            pass
            for i in range(len(self.padding)):
                pass


        @property
        def uses_bezier(self):
            """True if controller uses Bezier interpolation."""
            if hasattr(self, '_m_uses_bezier'):
                return self._m_uses_bezier

            self._m_uses_bezier = self.column_count & 16 != 0
            return getattr(self, '_m_uses_bezier', None)


    class DanglymeshHeader(KaitaiStruct):
        """Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.DanglymeshHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
            self.constraints_offset = self._io.read_u4le()
            self.constraints_count = self._io.read_u4le()
            self.constraints_count_duplicate = self._io.read_u4le()
            self.displacement = self._io.read_f4le()
            self.tightness = self._io.read_f4le()
            self.period = self._io.read_f4le()
            self.unknown = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.trimesh_base._fetch_instances()


    class EmitterHeader(KaitaiStruct):
        """Emitter header (224 bytes)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.EmitterHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.dead_space = self._io.read_f4le()
            self.blast_radius = self._io.read_f4le()
            self.blast_length = self._io.read_f4le()
            self.branch_count = self._io.read_u4le()
            self.control_point_smoothing = self._io.read_f4le()
            self.x_grid = self._io.read_u4le()
            self.y_grid = self._io.read_u4le()
            self.padding_unknown = self._io.read_u4le()
            self.update_script = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.render_script = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.blend_script = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.texture_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.chunk_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.two_sided_texture = self._io.read_u4le()
            self.loop = self._io.read_u4le()
            self.render_order = self._io.read_u2le()
            self.frame_blending = self._io.read_u1()
            self.depth_texture_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.padding = self._io.read_u1()
            self.flags = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class FileHeader(KaitaiStruct):
        """MDL file header (12 bytes)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.FileHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.unused = self._io.read_u4le()
            self.mdl_size = self._io.read_u4le()
            self.mdx_size = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class GeometryHeader(KaitaiStruct):
        """Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.GeometryHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.function_pointer_0 = self._io.read_u4le()
            self.function_pointer_1 = self._io.read_u4le()
            self.model_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.root_node_offset = self._io.read_u4le()
            self.node_count = self._io.read_u4le()
            self.unknown_array_1 = Mdl.ArrayDefinition(self._io, self, self._root)
            self.unknown_array_2 = Mdl.ArrayDefinition(self._io, self, self._root)
            self.reference_count = self._io.read_u4le()
            self.geometry_type = self._io.read_u1()
            self.padding = []
            for i in range(3):
                self.padding.append(self._io.read_u1())



        def _fetch_instances(self):
            pass
            self.unknown_array_1._fetch_instances()
            self.unknown_array_2._fetch_instances()
            for i in range(len(self.padding)):
                pass


        @property
        def is_kotor2(self):
            """True if this is a KOTOR 2 model."""
            if hasattr(self, '_m_is_kotor2'):
                return self._m_is_kotor2

            self._m_is_kotor2 =  ((self.function_pointer_0 == 4285200) or (self.function_pointer_0 == 4285872)) 
            return getattr(self, '_m_is_kotor2', None)


    class LightHeader(KaitaiStruct):
        """Light header (92 bytes)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.LightHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.unknown = []
            for i in range(4):
                self.unknown.append(self._io.read_f4le())

            self.flare_sizes_offset = self._io.read_u4le()
            self.flare_sizes_count = self._io.read_u4le()
            self.flare_sizes_count_duplicate = self._io.read_u4le()
            self.flare_positions_offset = self._io.read_u4le()
            self.flare_positions_count = self._io.read_u4le()
            self.flare_positions_count_duplicate = self._io.read_u4le()
            self.flare_color_shifts_offset = self._io.read_u4le()
            self.flare_color_shifts_count = self._io.read_u4le()
            self.flare_color_shifts_count_duplicate = self._io.read_u4le()
            self.flare_texture_names_offset = self._io.read_u4le()
            self.flare_texture_names_count = self._io.read_u4le()
            self.flare_texture_names_count_duplicate = self._io.read_u4le()
            self.flare_radius = self._io.read_f4le()
            self.light_priority = self._io.read_u4le()
            self.ambient_only = self._io.read_u4le()
            self.dynamic_type = self._io.read_u4le()
            self.affect_dynamic = self._io.read_u4le()
            self.shadow = self._io.read_u4le()
            self.flare = self._io.read_u4le()
            self.fading_light = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            for i in range(len(self.unknown)):
                pass



    class LightsaberHeader(KaitaiStruct):
        """Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.LightsaberHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
            self.vertices_offset = self._io.read_u4le()
            self.texcoords_offset = self._io.read_u4le()
            self.normals_offset = self._io.read_u4le()
            self.unknown1 = self._io.read_u4le()
            self.unknown2 = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.trimesh_base._fetch_instances()


    class MdlAnimationEntry(KaitaiStruct):
        """One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
        Wraps the header so repeated root instances can use parametric types (user guide).
        """
        def __init__(self, anim_index, _io, _parent=None, _root=None):
            super(Mdl.MdlAnimationEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self.anim_index = anim_index
            self._read()

        def _read(self):
            pass


        def _fetch_instances(self):
            pass
            _ = self.header
            if hasattr(self, '_m_header'):
                pass
                self._m_header._fetch_instances()


        @property
        def header(self):
            if hasattr(self, '_m_header'):
                return self._m_header

            _pos = self._io.pos()
            self._io.seek(self._root.data_start + self._root.animation_offsets[self.anim_index])
            self._m_header = Mdl.AnimationHeader(self._io, self, self._root)
            self._io.seek(_pos)
            return getattr(self, '_m_header', None)


    class ModelHeader(KaitaiStruct):
        """Model header (196 bytes) starting at offset 12 (data_start).
        This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
        model-wide metadata, offsets, and counts.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.ModelHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.geometry = Mdl.GeometryHeader(self._io, self, self._root)
            self.model_type = KaitaiStream.resolve_enum(bioware_mdl_common.BiowareMdlCommon.ModelClassification, self._io.read_u1())
            self.unknown0 = self._io.read_u1()
            self.padding0 = self._io.read_u1()
            self.fog = self._io.read_u1()
            self.unknown1 = self._io.read_u4le()
            self.offset_to_animations = self._io.read_u4le()
            self.animation_count = self._io.read_u4le()
            self.animation_count2 = self._io.read_u4le()
            self.unknown2 = self._io.read_u4le()
            self.bounding_box_min = Mdl.Vec3f(self._io, self, self._root)
            self.bounding_box_max = Mdl.Vec3f(self._io, self, self._root)
            self.radius = self._io.read_f4le()
            self.animation_scale = self._io.read_f4le()
            self.supermodel_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.offset_to_super_root = self._io.read_u4le()
            self.unknown3 = self._io.read_u4le()
            self.mdx_data_size = self._io.read_u4le()
            self.mdx_data_offset = self._io.read_u4le()
            self.offset_to_name_offsets = self._io.read_u4le()
            self.name_offsets_count = self._io.read_u4le()
            self.name_offsets_count2 = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.geometry._fetch_instances()
            self.bounding_box_min._fetch_instances()
            self.bounding_box_max._fetch_instances()


    class NameStrings(KaitaiStruct):
        """Array of null-terminated name strings."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.NameStrings, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.strings = []
            i = 0
            while not self._io.is_eof():
                self.strings.append((self._io.read_bytes_term(0, False, True, True)).decode(u"ASCII"))
                i += 1



        def _fetch_instances(self):
            pass
            for i in range(len(self.strings)):
                pass



    class Node(KaitaiStruct):
        """Node structure - starts with 80-byte header, followed by type-specific sub-header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.Node, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.header = Mdl.NodeHeader(self._io, self, self._root)
            if self.header.node_type == 3:
                pass
                self.light_sub_header = Mdl.LightHeader(self._io, self, self._root)

            if self.header.node_type == 5:
                pass
                self.emitter_sub_header = Mdl.EmitterHeader(self._io, self, self._root)

            if self.header.node_type == 17:
                pass
                self.reference_sub_header = Mdl.ReferenceHeader(self._io, self, self._root)

            if self.header.node_type == 33:
                pass
                self.trimesh_sub_header = Mdl.TrimeshHeader(self._io, self, self._root)

            if self.header.node_type == 97:
                pass
                self.skinmesh_sub_header = Mdl.SkinmeshHeader(self._io, self, self._root)

            if self.header.node_type == 161:
                pass
                self.animmesh_sub_header = Mdl.AnimmeshHeader(self._io, self, self._root)

            if self.header.node_type == 289:
                pass
                self.danglymesh_sub_header = Mdl.DanglymeshHeader(self._io, self, self._root)

            if self.header.node_type == 545:
                pass
                self.aabb_sub_header = Mdl.AabbHeader(self._io, self, self._root)

            if self.header.node_type == 2081:
                pass
                self.lightsaber_sub_header = Mdl.LightsaberHeader(self._io, self, self._root)



        def _fetch_instances(self):
            pass
            self.header._fetch_instances()
            if self.header.node_type == 3:
                pass
                self.light_sub_header._fetch_instances()

            if self.header.node_type == 5:
                pass
                self.emitter_sub_header._fetch_instances()

            if self.header.node_type == 17:
                pass
                self.reference_sub_header._fetch_instances()

            if self.header.node_type == 33:
                pass
                self.trimesh_sub_header._fetch_instances()

            if self.header.node_type == 97:
                pass
                self.skinmesh_sub_header._fetch_instances()

            if self.header.node_type == 161:
                pass
                self.animmesh_sub_header._fetch_instances()

            if self.header.node_type == 289:
                pass
                self.danglymesh_sub_header._fetch_instances()

            if self.header.node_type == 545:
                pass
                self.aabb_sub_header._fetch_instances()

            if self.header.node_type == 2081:
                pass
                self.lightsaber_sub_header._fetch_instances()



    class NodeHeader(KaitaiStruct):
        """Node header (80 bytes) - present in all node types."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.NodeHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.node_type = self._io.read_u2le()
            self.node_index = self._io.read_u2le()
            self.node_name_index = self._io.read_u2le()
            self.padding = self._io.read_u2le()
            self.root_node_offset = self._io.read_u4le()
            self.parent_node_offset = self._io.read_u4le()
            self.position = Mdl.Vec3f(self._io, self, self._root)
            self.orientation = Mdl.Quaternion(self._io, self, self._root)
            self.child_array_offset = self._io.read_u4le()
            self.child_count = self._io.read_u4le()
            self.child_count_duplicate = self._io.read_u4le()
            self.controller_array_offset = self._io.read_u4le()
            self.controller_count = self._io.read_u4le()
            self.controller_count_duplicate = self._io.read_u4le()
            self.controller_data_offset = self._io.read_u4le()
            self.controller_data_count = self._io.read_u4le()
            self.controller_data_count_duplicate = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.position._fetch_instances()
            self.orientation._fetch_instances()

        @property
        def has_aabb(self):
            if hasattr(self, '_m_has_aabb'):
                return self._m_has_aabb

            self._m_has_aabb = self.node_type & 512 != 0
            return getattr(self, '_m_has_aabb', None)

        @property
        def has_anim(self):
            if hasattr(self, '_m_has_anim'):
                return self._m_has_anim

            self._m_has_anim = self.node_type & 128 != 0
            return getattr(self, '_m_has_anim', None)

        @property
        def has_dangly(self):
            if hasattr(self, '_m_has_dangly'):
                return self._m_has_dangly

            self._m_has_dangly = self.node_type & 256 != 0
            return getattr(self, '_m_has_dangly', None)

        @property
        def has_emitter(self):
            if hasattr(self, '_m_has_emitter'):
                return self._m_has_emitter

            self._m_has_emitter = self.node_type & 4 != 0
            return getattr(self, '_m_has_emitter', None)

        @property
        def has_light(self):
            if hasattr(self, '_m_has_light'):
                return self._m_has_light

            self._m_has_light = self.node_type & 2 != 0
            return getattr(self, '_m_has_light', None)

        @property
        def has_mesh(self):
            if hasattr(self, '_m_has_mesh'):
                return self._m_has_mesh

            self._m_has_mesh = self.node_type & 32 != 0
            return getattr(self, '_m_has_mesh', None)

        @property
        def has_reference(self):
            if hasattr(self, '_m_has_reference'):
                return self._m_has_reference

            self._m_has_reference = self.node_type & 16 != 0
            return getattr(self, '_m_has_reference', None)

        @property
        def has_saber(self):
            if hasattr(self, '_m_has_saber'):
                return self._m_has_saber

            self._m_has_saber = self.node_type & 2048 != 0
            return getattr(self, '_m_has_saber', None)

        @property
        def has_skin(self):
            if hasattr(self, '_m_has_skin'):
                return self._m_has_skin

            self._m_has_skin = self.node_type & 64 != 0
            return getattr(self, '_m_has_skin', None)


    class Quaternion(KaitaiStruct):
        """Quaternion rotation (4 floats W, X, Y, Z)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.Quaternion, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.w = self._io.read_f4le()
            self.x = self._io.read_f4le()
            self.y = self._io.read_f4le()
            self.z = self._io.read_f4le()


        def _fetch_instances(self):
            pass


    class ReferenceHeader(KaitaiStruct):
        """Reference header (36 bytes)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.ReferenceHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.model_resref = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.reattachable = self._io.read_u4le()


        def _fetch_instances(self):
            pass


    class SkinmeshHeader(KaitaiStruct):
        """Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.SkinmeshHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.trimesh_base = Mdl.TrimeshHeader(self._io, self, self._root)
            self.unknown_weights = self._io.read_s4le()
            self.padding1 = []
            for i in range(8):
                self.padding1.append(self._io.read_u1())

            self.mdx_bone_weights_offset = self._io.read_u4le()
            self.mdx_bone_indices_offset = self._io.read_u4le()
            self.bone_map_offset = self._io.read_u4le()
            self.bone_map_count = self._io.read_u4le()
            self.qbones_offset = self._io.read_u4le()
            self.qbones_count = self._io.read_u4le()
            self.qbones_count_duplicate = self._io.read_u4le()
            self.tbones_offset = self._io.read_u4le()
            self.tbones_count = self._io.read_u4le()
            self.tbones_count_duplicate = self._io.read_u4le()
            self.unknown_array = self._io.read_u4le()
            self.bone_node_serial_numbers = []
            for i in range(16):
                self.bone_node_serial_numbers.append(self._io.read_u2le())

            self.padding2 = self._io.read_u2le()


        def _fetch_instances(self):
            pass
            self.trimesh_base._fetch_instances()
            for i in range(len(self.padding1)):
                pass

            for i in range(len(self.bone_node_serial_numbers)):
                pass



    class TrimeshHeader(KaitaiStruct):
        """Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.TrimeshHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.function_pointer_0 = self._io.read_u4le()
            self.function_pointer_1 = self._io.read_u4le()
            self.faces_array_offset = self._io.read_u4le()
            self.faces_count = self._io.read_u4le()
            self.faces_count_duplicate = self._io.read_u4le()
            self.bounding_box_min = Mdl.Vec3f(self._io, self, self._root)
            self.bounding_box_max = Mdl.Vec3f(self._io, self, self._root)
            self.radius = self._io.read_f4le()
            self.average_point = Mdl.Vec3f(self._io, self, self._root)
            self.diffuse_color = Mdl.Vec3f(self._io, self, self._root)
            self.ambient_color = Mdl.Vec3f(self._io, self, self._root)
            self.transparency_hint = self._io.read_u4le()
            self.texture_0_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.texture_1_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(32), 0, False)).decode(u"ASCII")
            self.texture_2_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(12), 0, False)).decode(u"ASCII")
            self.texture_3_name = (KaitaiStream.bytes_terminate(self._io.read_bytes(12), 0, False)).decode(u"ASCII")
            self.indices_count_array_offset = self._io.read_u4le()
            self.indices_count_array_count = self._io.read_u4le()
            self.indices_count_array_count_duplicate = self._io.read_u4le()
            self.indices_offset_array_offset = self._io.read_u4le()
            self.indices_offset_array_count = self._io.read_u4le()
            self.indices_offset_array_count_duplicate = self._io.read_u4le()
            self.inverted_counter_array_offset = self._io.read_u4le()
            self.inverted_counter_array_count = self._io.read_u4le()
            self.inverted_counter_array_count_duplicate = self._io.read_u4le()
            self.unknown_values = []
            for i in range(3):
                self.unknown_values.append(self._io.read_s4le())

            self.saber_unknown_data = []
            for i in range(8):
                self.saber_unknown_data.append(self._io.read_u1())

            self.unknown = self._io.read_u4le()
            self.uv_direction = Mdl.Vec3f(self._io, self, self._root)
            self.uv_jitter = self._io.read_f4le()
            self.uv_jitter_speed = self._io.read_f4le()
            self.mdx_vertex_size = self._io.read_u4le()
            self.mdx_data_flags = self._io.read_u4le()
            self.mdx_vertices_offset = self._io.read_s4le()
            self.mdx_normals_offset = self._io.read_s4le()
            self.mdx_vertex_colors_offset = self._io.read_s4le()
            self.mdx_tex0_uvs_offset = self._io.read_s4le()
            self.mdx_tex1_uvs_offset = self._io.read_s4le()
            self.mdx_tex2_uvs_offset = self._io.read_s4le()
            self.mdx_tex3_uvs_offset = self._io.read_s4le()
            self.mdx_tangent_space_offset = self._io.read_s4le()
            self.mdx_unknown_offset_1 = self._io.read_s4le()
            self.mdx_unknown_offset_2 = self._io.read_s4le()
            self.mdx_unknown_offset_3 = self._io.read_s4le()
            self.vertex_count = self._io.read_u2le()
            self.texture_count = self._io.read_u2le()
            self.lightmapped = self._io.read_u1()
            self.rotate_texture = self._io.read_u1()
            self.background_geometry = self._io.read_u1()
            self.shadow = self._io.read_u1()
            self.beaming = self._io.read_u1()
            self.render = self._io.read_u1()
            self.unknown_flag = self._io.read_u1()
            self.padding = self._io.read_u1()
            self.total_area = self._io.read_f4le()
            self.unknown2 = self._io.read_u4le()
            if self._root.model_header.geometry.is_kotor2:
                pass
                self.k2_unknown_1 = self._io.read_u4le()

            if self._root.model_header.geometry.is_kotor2:
                pass
                self.k2_unknown_2 = self._io.read_u4le()

            self.mdx_data_offset = self._io.read_u4le()
            self.mdl_vertices_offset = self._io.read_u4le()


        def _fetch_instances(self):
            pass
            self.bounding_box_min._fetch_instances()
            self.bounding_box_max._fetch_instances()
            self.average_point._fetch_instances()
            self.diffuse_color._fetch_instances()
            self.ambient_color._fetch_instances()
            for i in range(len(self.unknown_values)):
                pass

            for i in range(len(self.saber_unknown_data)):
                pass

            self.uv_direction._fetch_instances()
            if self._root.model_header.geometry.is_kotor2:
                pass

            if self._root.model_header.geometry.is_kotor2:
                pass



    class Vec3f(KaitaiStruct):
        """3D vector (3 floats)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(Mdl.Vec3f, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.x = self._io.read_f4le()
            self.y = self._io.read_f4le()
            self.z = self._io.read_f4le()


        def _fetch_instances(self):
            pass


    @property
    def animation_offsets(self):
        """Animation header offsets (relative to data_start)."""
        if hasattr(self, '_m_animation_offsets'):
            return self._m_animation_offsets

        if self.model_header.animation_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.data_start + self.model_header.offset_to_animations)
            self._m_animation_offsets = []
            for i in range(self.model_header.animation_count):
                self._m_animation_offsets.append(self._io.read_u4le())

            self._io.seek(_pos)

        return getattr(self, '_m_animation_offsets', None)

    @property
    def animations(self):
        """Animation headers (via offset table). Each list element is `mdl_animation_entry`;
        the parsed header is `element.header` (same wire layout as `animation_header`).
        """
        if hasattr(self, '_m_animations'):
            return self._m_animations

        if self.model_header.animation_count > 0:
            pass
            self._m_animations = []
            for i in range(self.model_header.animation_count):
                self._m_animations.append(Mdl.MdlAnimationEntry(i, self._io, self, self._root))


        return getattr(self, '_m_animations', None)

    @property
    def data_start(self):
        """MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
        section, which begins immediately after the 12-byte file header.
        """
        if hasattr(self, '_m_data_start'):
            return self._m_data_start

        self._m_data_start = 12
        return getattr(self, '_m_data_start', None)

    @property
    def name_offsets(self):
        """Name string offsets (relative to data_start)."""
        if hasattr(self, '_m_name_offsets'):
            return self._m_name_offsets

        if self.model_header.name_offsets_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.data_start + self.model_header.offset_to_name_offsets)
            self._m_name_offsets = []
            for i in range(self.model_header.name_offsets_count):
                self._m_name_offsets.append(self._io.read_u4le())

            self._io.seek(_pos)

        return getattr(self, '_m_name_offsets', None)

    @property
    def names_data(self):
        """Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
        Parsed as null-terminated ASCII strings in `name_strings`.
        """
        if hasattr(self, '_m_names_data'):
            return self._m_names_data

        if self.model_header.name_offsets_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek((self.data_start + self.model_header.offset_to_name_offsets) + 4 * self.model_header.name_offsets_count)
            self._raw__m_names_data = self._io.read_bytes((self.data_start + self.model_header.offset_to_animations) - ((self.data_start + self.model_header.offset_to_name_offsets) + 4 * self.model_header.name_offsets_count))
            _io__raw__m_names_data = KaitaiStream(BytesIO(self._raw__m_names_data))
            self._m_names_data = Mdl.NameStrings(_io__raw__m_names_data, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_names_data', None)

    @property
    def root_node(self):
        if hasattr(self, '_m_root_node'):
            return self._m_root_node

        if self.model_header.geometry.root_node_offset > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.data_start + self.model_header.geometry.root_node_offset)
            self._m_root_node = Mdl.Node(self._io, self, self._root)
            self._io.seek(_pos)

        return getattr(self, '_m_root_node', None)



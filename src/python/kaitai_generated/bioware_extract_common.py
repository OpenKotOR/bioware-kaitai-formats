# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareExtractCommon(KaitaiStruct):
    """Enums and small helper types used by installation/extraction tooling.
    
    Canonical links: `meta.doc-ref` and `meta.xref` (PyKotor `installation.py`; NickHugi `Installation.cs` for parallel .NET layout).
    
    .. seealso::
       xoreos — `FileType` enum start (Aurora resource type IDs; no dedicated extraction-layout parser — this `.ksy` is tooling-side) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60
    
    
    .. seealso::
       PyKotor — `SearchLocation` / `TexturePackNames` (maps to enums in this `.ksy`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/extract/installation.py#L67-L122
    
    
    .. seealso::
       PyKotor — `extract/` package - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/extract/
    
    
    .. seealso::
       NickHugi/Kotor.NET — `Installation` ctor (texture packs / capsules / folders) - https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Common/Installation.cs#L11-L79
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (tooling enums; no extraction-specific PDF) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    class BiowareSearchLocationId(IntEnum):
        override = 0
        modules = 1
        chitin = 2
        textures_tpa = 3
        textures_tpb = 4
        textures_tpc = 5
        textures_gui = 6
        music = 7
        sound = 8
        voice = 9
        lips = 10
        rims = 11
        custom_modules = 12
        custom_folders = 13
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareExtractCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass

    class BiowareTexturePackNameStr(KaitaiStruct):
        """String-valued enum equivalent for TexturePackNames (null-terminated ASCII filename)."""
        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareExtractCommon.BiowareTexturePackNameStr, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(0, False, True, True)).decode(u"ASCII")
            if not  ((self.value == u"swpc_tex_tpa.erf") or (self.value == u"swpc_tex_tpb.erf") or (self.value == u"swpc_tex_tpc.erf") or (self.value == u"swpc_tex_gui.erf")) :
                raise kaitaistruct.ValidationNotAnyOfError(self.value, self._io, u"/types/bioware_texture_pack_name_str/seq/0")


        def _fetch_instances(self):
            pass




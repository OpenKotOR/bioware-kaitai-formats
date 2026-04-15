# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Mdx(KaitaiStruct):
    """**MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
    Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
    opaque `size-eos` span — per-attribute layouts are MDL-driven.
    
    xoreos interleaved MDX reads: `meta.xref.xoreos_model_kotor_mdx_reads`.
    
    .. seealso::
       PyKotor wiki — MDL/MDX - https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format
    
    
    .. seealso::
       xoreos — Model_KotOR MDX reads - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/aurora/model_kotor.cpp#L885-L917
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Mdx, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.vertex_data = self._io.read_bytes_full()


    def _fetch_instances(self):
        pass



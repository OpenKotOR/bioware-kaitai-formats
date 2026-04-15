# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Mdx(KaitaiStruct):
    """**MDX** (model extension): interleaved vertex bytes for meshes declared in the paired **`MDL.ksy`** file.
    Offsets / `mdx_vertex_size` / `mdx_data_flags` live on MDL trimesh headers; this root is intentionally an
    opaque `size-eos` span — per-attribute layouts are MDL-driven.

    Cross-implementations: xoreos reads trimesh MDX stride and interleaved streams in `meta.xref.xoreos_model_kotor_*`;
    reone parses mesh MDX in `meta.xref.reone_mdlmdxreader_read_mesh`; KotOR.js uses `OdysseyModelNodeMesh` and
    `OdysseyModelMDXFlag` (`meta.xref.kotor_js_*`). Shared bitmask names: imported `bioware_mdl_common::mdx_vertex_stream_flag`.

    .. seealso::
       PyKotor wiki — MDL/MDX - https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format


    .. seealso::
       PyKotor — `MDLBinaryReader` / MDX tail read path - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/mdl/io_mdl.py#L2260-L2408


    .. seealso::
       xoreos — trimesh MDX header fields (mdxStructSize, UV offsets, counts) - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L809-L842


    .. seealso::
       xoreos — interleaved MDX vertex loop - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/model_kotor.cpp#L864-L917


    .. seealso::
       xoreos — `kFileTypeMDX` (3008) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L192


    .. seealso::
       xoreos — `kFileTypeMDX2` (3016) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L201


    .. seealso::
       xoreos-tools — shipped CLI inventory (no MDX-specific tool) - https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43


    .. seealso::
       xoreos-docs — KotOR MDL/MDX overview - https://github.com/xoreos/xoreos-docs/blob/master/specs/kotor_mdl.html


    .. seealso::
       xoreos-docs — Torlack binmdl (MDX-related controller / mesh background) - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html


    .. seealso::
       reone — MdlMdxReader::readMesh (MDX consumption) - https://github.com/modawan/reone/blob/master/src/libs/graphics/format/mdlmdxreader.cpp#L197-L487


    .. seealso::
       KotOR.js — MDX stream flag enum - https://github.com/KobaltBlu/KotOR.js/blob/master/src/enums/odyssey/OdysseyModelMDXFlag.ts
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

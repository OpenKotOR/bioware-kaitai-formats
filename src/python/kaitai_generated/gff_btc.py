# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import gff


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class GffBtc(KaitaiStruct):
    """**BTC** resources are **GFF3** on disk (Aurora `GFF ` prefix + V3.x version). Wire layout is fully defined by
    `formats/GFF/GFF.ksy` and `formats/Common/bioware_gff_common.ksy`; this file is a **template capsule** for tooling,
    `meta.xref` anchors, and game-specific `doc` without duplicating the GFF3 grammar.
    
    FileType / restype id **2026** — see `bioware_type_ids::xoreos_file_type_id` enum member `btc`.
    
    .. seealso::
       xoreos — GFF3 header read - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63
    
    
    .. seealso::
       PyKotor wiki — GFF binary - https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    
    
    .. seealso::
       xoreos-docs — GFF_Format.pdf (GFF3 wire) - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — CommonGFFStructs.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(GffBtc, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.contents = gff.Gff.GffUnionFile(self._io)


    def _fetch_instances(self):
        pass
        self.contents._fetch_instances()



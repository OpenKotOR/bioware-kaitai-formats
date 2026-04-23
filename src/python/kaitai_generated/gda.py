# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import gff


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Gda(KaitaiStruct):
    """**GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
    (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.
    
    G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.
    
    **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).
    
    .. seealso::
       formats/Common/bioware_gff_common.ksy In-tree — `gff4_g2da_file_type_be` / `gff4_g2da_type_version_be` (G2DA fourCC + V0.x — compare to `GFF.ksy` `gff4_after_aurora`)
    
    
    .. seealso::
       xoreos — `GDAFile::load` - https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305
    
    
    .. seealso::
       xoreos — `GFF4File` stream ctor (type dispatch) - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93
    
    
    .. seealso::
       xoreos — G2DA column field ids (excerpt) - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260
    
    
    .. seealso::
       xoreos — `TwoDAFile(const GDAFile &)` - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140
    
    
    .. seealso::
       xoreos — `TwoDAFile::load(const GDAFile &)` - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400
    
    
    .. seealso::
       xoreos-tools — `main` - https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86
    
    
    .. seealso::
       xoreos-tools — `get2DAGDA` - https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159
    
    
    .. seealso::
       xoreos-tools — multi-file `GDAFile` merge - https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181
    
    
    .. seealso::
       PyKotor — `ResourceType.GDA` - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472
    
    
    .. seealso::
       xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container) - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    
    
    .. seealso::
       xoreos-docs — CommonGFFStructs.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf
    
    
    .. seealso::
       xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA) - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Gda, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.as_gff4 = gff.Gff.Gff4File(self._io)


    def _fetch_instances(self):
        pass
        self.as_gff4._fetch_instances()



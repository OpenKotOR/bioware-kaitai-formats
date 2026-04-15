# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class GffXml(KaitaiStruct):
    """**GFF XML** (tooling interchange): UTF-8 XML projection of **binary GFF3** data — retail games read **binary**
    GFF; this format is for editors, converters, and diffs. Root tag is typically **`gff3`** with nested `<struct>` /
    `<list>` / typed scalar tags matching PyKotor `io_gff_xml.py`.
    
    This `.ksy` stores the document as one opaque UTF-8 string — validate with a real XML parser.
    
    PyKotor reader/writer + xoreos-tools `gffdumper` / `gffcreator`: `meta.xref`. K-GFF editor history (vector/orientation
    pitfalls for `.git` / `.ifo`): `meta.xref` `legacy_k_gff_*`.
    
    .. seealso::
       PyKotor wiki — GFF (binary + tooling context) - https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    
    
    .. seealso::
       PyKotor — GFFXMLReader / Writer - https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L37-L188
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(GffXml, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.xml_content = (self._io.read_bytes_full()).decode(u"UTF-8")


    def _fetch_instances(self):
        pass



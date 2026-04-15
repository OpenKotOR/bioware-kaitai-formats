# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct
from enum import IntEnum


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class BiowareGffCommon(KaitaiStruct):
    """Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).

    Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
    (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).

    **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
    this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.

    .. seealso::
       PyKotor wiki — GFF data types - https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types


    .. seealso::
       PyKotor — `GFFFieldType` enum - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367


    .. seealso::
       PyKotor — field read dispatch - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273


    .. seealso::
       xoreos — `GFF3File::readHeader` - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63


    .. seealso::
       xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above) - https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82


    .. seealso::
       reone — `GffReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225


    .. seealso::
       xoreos-tools — `gffdumper` (identify / dump) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176


    .. seealso::
       xoreos-tools — `gffcreator` (create) - https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60


    .. seealso::
       xoreos-docs — GFF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf


    .. seealso::
       xoreos-docs — CommonGFFStructs.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf


    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    class GffFieldType(IntEnum):
        uint8 = 0
        int8 = 1
        uint16 = 2
        int16 = 3
        uint32 = 4
        int32 = 5
        uint64 = 6
        int64 = 7
        single = 8
        double = 9
        string = 10
        resref = 11
        localized_string = 12
        binary = 13
        struct = 14
        list = 15
        vector4 = 16
        vector3 = 17
        str_ref = 18

    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareGffCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass

    def _fetch_instances(self):
        pass

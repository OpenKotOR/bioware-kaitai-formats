# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# Canonical Aurora **GFF3** `GFFFieldTypes` wire tags (`u4` at `GFFFieldData.field_type` / offset +0).
# 
# Imported by `formats/GFF/GFF.ksy`. Each enum member’s `doc:` is the **lowest-scope** narrative for that numeric ID
# (Ghidra symbol names, `ReadField*` addresses, PyKotor / reone / wiki line anchors).
# 
# **GFF4** uses a different container/struct layout on disk (`GFF4File::Header::read` in `meta.xref.xoreos_gff4file_header_read`);
# this enum remains the **GFF3** field-type table unless a future split spec proves wire-identical IDs across both.
# @see https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format#gff-data-types PyKotor wiki — GFF data types
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/gff_data.py#L347-L367 PyKotor — `GFFFieldType` enum
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff.py#L197-L273 PyKotor — field read dispatch
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff3file.cpp#L50-L63 xoreos — `GFF3File::readHeader`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L59-L82 xoreos — `GFF4File::Header::read` (GFF4 container; distinct from GFF3 field tags above)
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/gffreader.cpp#L27-L225 reone — `GffReader`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffdumper.cpp#L36-L176 xoreos-tools — `gffdumper` (identify / dump)
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/xml/gffcreator.cpp#L43-L60 xoreos-tools — `gffcreator` (create)
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf
# @see https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs PDF tree
class BiowareGffCommon < Kaitai::Struct::Struct

  GFF_FIELD_TYPE = {
    0 => :gff_field_type_uint8,
    1 => :gff_field_type_int8,
    2 => :gff_field_type_uint16,
    3 => :gff_field_type_int16,
    4 => :gff_field_type_uint32,
    5 => :gff_field_type_int32,
    6 => :gff_field_type_uint64,
    7 => :gff_field_type_int64,
    8 => :gff_field_type_single,
    9 => :gff_field_type_double,
    10 => :gff_field_type_string,
    11 => :gff_field_type_resref,
    12 => :gff_field_type_localized_string,
    13 => :gff_field_type_binary,
    14 => :gff_field_type_struct,
    15 => :gff_field_type_list,
    16 => :gff_field_type_vector4,
    17 => :gff_field_type_vector3,
    18 => :gff_field_type_str_ref,
  }
  I__GFF_FIELD_TYPE = GFF_FIELD_TYPE.invert
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    self
  end
end

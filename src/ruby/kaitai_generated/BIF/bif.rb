# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_type_ids'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
# the paired **KEY** (`KEY.ksy`), not in the BIF.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif PyKotor wiki — BIF
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215 PyKotor — `io_bif` (Kaitai + legacy + reader)
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71 PyKotor — `BIFType`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97 xoreos — `BIFFile::load` + `readVarResTable`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208 xoreos — `kFileTypeBIF`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209 xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63 reone — `BifReader`
# @see https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts KotOR.js — `BIFObject`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html xoreos-docs — Torlack bif.html
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
class Bif < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("BIFF", @file_type, @_io, "/seq/0") if not @file_type == "BIFF"
    @version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotAnyOfError.new(@version, @_io, "/seq/1") if not  ((@version == "V1  ") || (@version == "V1.1")) 
    @var_res_count = @_io.read_u4le
    @fixed_res_count = @_io.read_u4le
    raise Kaitai::Struct::ValidationNotEqualError.new(0, @fixed_res_count, @_io, "/seq/3") if not @fixed_res_count == 0
    @var_table_offset = @_io.read_u4le
    self
  end
  class VarResourceEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @resource_id = @_io.read_u4le
      @offset = @_io.read_u4le
      @file_size = @_io.read_u4le
      @resource_type = Kaitai::Struct::Stream::resolve_enum(BiowareTypeIds::XOREOS_FILE_TYPE_ID, @_io.read_u4le)
      self
    end

    ##
    # Resource ID (matches KEY file entry).
    # Encodes BIF index (bits 31-20) and resource index (bits 19-0).
    # Formula: resource_id = (bif_index << 20) | resource_index
    attr_reader :resource_id

    ##
    # Byte offset to resource data in file (absolute file offset).
    attr_reader :offset

    ##
    # Uncompressed size of resource data in bytes.
    attr_reader :file_size

    ##
    # Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
    # read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
    # `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.
    attr_reader :resource_type
  end
  class VarResourceTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.var_res_count).times { |i|
        @entries << VarResourceEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of variable resource entries.
    attr_reader :entries
  end

  ##
  # Variable resource table containing entries for each resource.
  def var_resource_table
    return @var_resource_table unless @var_resource_table.nil?
    if var_res_count > 0
      _pos = @_io.pos
      @_io.seek(var_table_offset)
      @var_resource_table = VarResourceTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @var_resource_table
  end

  ##
  # File type signature. Must be "BIFF" for BIF files.
  attr_reader :file_type

  ##
  # File format version. Typically "V1  " or "V1.1".
  attr_reader :version

  ##
  # Number of variable-size resources in this file.
  attr_reader :var_res_count

  ##
  # Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
  attr_reader :fixed_res_count

  ##
  # Byte offset to the variable resource table from the beginning of the file.
  attr_reader :var_table_offset
end

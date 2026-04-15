# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

require 'kaitai/struct/struct'
require_relative 'bioware_type_ids'

unless Gem::Version.new(Kaitai::Struct::VERSION) >= Gem::Version.new('0.11')
  raise "Incompatible Kaitai Struct Ruby API: 0.11 or later is required, but you have #{Kaitai::Struct::VERSION}"
end


##
# **KEY** (key table): Aurora master index — BIF catalog rows + `(ResRef, ResourceType) → resource_id` map.
# Resource types use `bioware_type_ids`.
# @see https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#key PyKotor wiki — KEY
# @see https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/key/io_key.py#L26-L183 PyKotor — `io_key` (Kaitai + legacy + header write)
# @see https://github.com/modawan/reone/blob/master/src/libs/resource/format/keyreader.cpp#L26-L80 reone — `KeyReader`
# @see https://github.com/xoreos/xoreos/blob/master/src/aurora/keyfile.cpp#L50-L88 xoreos — `KEYFile::load`
# @see https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L192-L210 xoreos-tools — `openKEYs` / `openKEYDataFiles`
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf
# @see https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/key.html xoreos-docs — Torlack key.html
class Key < Kaitai::Struct::Struct
  def initialize(_io, _parent = nil, _root = nil)
    super(_io, _parent, _root || self)
    _read
  end

  def _read
    @file_type = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotEqualError.new("KEY ", @file_type, @_io, "/seq/0") if not @file_type == "KEY "
    @file_version = (@_io.read_bytes(4)).force_encoding("ASCII").encode('UTF-8')
    raise Kaitai::Struct::ValidationNotAnyOfError.new(@file_version, @_io, "/seq/1") if not  ((@file_version == "V1  ") || (@file_version == "V1.1")) 
    @bif_count = @_io.read_u4le
    @key_count = @_io.read_u4le
    @file_table_offset = @_io.read_u4le
    @key_table_offset = @_io.read_u4le
    @build_year = @_io.read_u4le
    @build_day = @_io.read_u4le
    @reserved = @_io.read_bytes(32)
    self
  end
  class FileEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @file_size = @_io.read_u4le
      @filename_offset = @_io.read_u4le
      @filename_size = @_io.read_u2le
      @drives = @_io.read_u2le
      self
    end

    ##
    # BIF filename string at the absolute filename_offset in the KEY file.
    def filename
      return @filename unless @filename.nil?
      _pos = @_io.pos
      @_io.seek(filename_offset)
      @filename = (@_io.read_bytes(filename_size)).force_encoding("ASCII").encode('UTF-8')
      @_io.seek(_pos)
      @filename
    end

    ##
    # Size of the BIF file on disk in bytes.
    attr_reader :file_size

    ##
    # Absolute byte offset from the start of the KEY file where this BIF's filename is stored
    # (seek(filename_offset), then read filename_size bytes).
    # This is not relative to the file table or to the end of the BIF entry array.
    attr_reader :filename_offset

    ##
    # Length of the filename in bytes (including null terminator).
    attr_reader :filename_size

    ##
    # Drive flags indicating which media contains the BIF file.
    # Bit flags: 0x0001=HD0, 0x0002=CD1, 0x0004=CD2, 0x0008=CD3, 0x0010=CD4.
    # Modern distributions typically use 0x0001 (HD) for all files.
    attr_reader :drives
  end
  class FileTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.bif_count).times { |i|
        @entries << FileEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of BIF file entries.
    attr_reader :entries
  end
  class FilenameTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @filenames = (@_io.read_bytes_full).force_encoding("ASCII").encode('UTF-8')
      self
    end

    ##
    # Null-terminated BIF filenames concatenated together.
    # Each filename is read using the filename_offset and filename_size
    # from the corresponding file_entry.
    attr_reader :filenames
  end
  class KeyEntry < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @resref = (@_io.read_bytes(16)).force_encoding("ASCII").encode('UTF-8')
      @resource_type = Kaitai::Struct::Stream::resolve_enum(BiowareTypeIds::XOREOS_FILE_TYPE_ID, @_io.read_u2le)
      @resource_id = @_io.read_u4le
      self
    end

    ##
    # Resource filename (ResRef) without extension.
    # Null-padded, maximum 16 characters.
    # The game uses this name to access the resource.
    attr_reader :resref

    ##
    # Aurora resource type id (`u2` on disk). Symbol names and upstream mapping:
    # `formats/Common/bioware_type_ids.ksy` enum `xoreos_file_type_id` (xoreos `FileType` / PyKotor `ResourceType` alignment).
    attr_reader :resource_type

    ##
    # Encoded resource location.
    # Bits 31-20: BIF index (top 12 bits) - index into file table
    # Bits 19-0: Resource index (bottom 20 bits) - index within the BIF file
    # 
    # Formula: resource_id = (bif_index << 20) | resource_index
    # 
    # Decoding:
    # - bif_index = (resource_id >> 20) & 0xFFF
    # - resource_index = resource_id & 0xFFFFF
    attr_reader :resource_id
  end
  class KeyTable < Kaitai::Struct::Struct
    def initialize(_io, _parent = nil, _root = nil)
      super(_io, _parent, _root)
      _read
    end

    def _read
      @entries = []
      (_root.key_count).times { |i|
        @entries << KeyEntry.new(@_io, self, @_root)
      }
      self
    end

    ##
    # Array of resource entries.
    attr_reader :entries
  end

  ##
  # File table containing BIF file entries.
  def file_table
    return @file_table unless @file_table.nil?
    if bif_count > 0
      _pos = @_io.pos
      @_io.seek(file_table_offset)
      @file_table = FileTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @file_table
  end

  ##
  # KEY table containing resource entries.
  def key_table
    return @key_table unless @key_table.nil?
    if key_count > 0
      _pos = @_io.pos
      @_io.seek(key_table_offset)
      @key_table = KeyTable.new(@_io, self, @_root)
      @_io.seek(_pos)
    end
    @key_table
  end

  ##
  # File type signature. Must be "KEY " (space-padded).
  attr_reader :file_type

  ##
  # File format version. Typically "V1  " or "V1.1".
  attr_reader :file_version

  ##
  # Number of BIF files referenced by this KEY file.
  attr_reader :bif_count

  ##
  # Number of resource entries in the KEY table.
  attr_reader :key_count

  ##
  # Byte offset to the file table from the beginning of the file.
  attr_reader :file_table_offset

  ##
  # Byte offset to the KEY table from the beginning of the file.
  attr_reader :key_table_offset

  ##
  # Build year (years since 1900).
  attr_reader :build_year

  ##
  # Build day (days since January 1).
  attr_reader :build_day

  ##
  # Reserved padding (usually zeros).
  attr_reader :reserved
end

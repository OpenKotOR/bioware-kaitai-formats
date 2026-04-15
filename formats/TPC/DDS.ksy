meta:
  id: dds
  title: DirectDraw Surface (DDS) Texture Format
  license: MIT
  endian: le
  file-extension: dds
  imports:
    - ../Common/bioware_common
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: DDS payloads embedded or standalone per DirectX / PyKotor wiki.
    pykotor_wiki_dds: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds
    pykotor_io_dds_reader: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130
    xoreos_tools_dds: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/images/dds.cpp#L69-L158
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/dds.cpp
    xoreos_types_kfiletype_dds: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L98
    xoreos_dds_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/dds.cpp#L55-L67
    xoreos_dds_read_bioware_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/dds.cpp#L141-L210
    bioware_common_dds_variant_bpp: |
      `bioware_dds_header.bytes_per_pixel`: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
doc: |
  **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
  (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.

  BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds PyKotor wiki — DDS"
  - "https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130 PyKotor — TPCDDSReader"

seq:
  - id: magic
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File magic. Either "DDS " (0x44445320) for standard DDS,
      or check for BioWare variant (no magic, starts with width/height).
    valid:
      any-of:
        - "'DDS '"
        - "'    '"  # BioWare variant has no magic (allows empty check)
  
  - id: header
    type: dds_header
    if: magic == "DDS "
    doc: Standard DDS header (124 bytes) - only present if magic is "DDS "
  
  - id: bioware_header
    type: bioware_dds_header
    if: magic != "DDS "
    doc: BioWare DDS variant header - only present if magic is not "DDS "
  
  - id: pixel_data
    size-eos: true
    doc: |
      Pixel data (compressed or uncompressed); single blob to EOF.
      For standard DDS: format determined by DDPIXELFORMAT.
      For BioWare DDS: DXT1 or DXT5 compressed data.

types:
  dds_header:
    seq:
      - id: size
        type: u4
        doc: Header size (must be 124)
        valid: 124
      
      - id: flags
        type: u4
        doc: |
          DDS flags bitfield:
          - 0x00001007 = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT
          - 0x00020000 = DDSD_MIPMAPCOUNT (if mipmaps present)
      
      - id: height
        type: u4
        doc: Image height in pixels
      
      - id: width
        type: u4
        doc: Image width in pixels
      
      - id: pitch_or_linear_size
        type: u4
        doc: |
          Pitch (uncompressed) or linear size (compressed).
          For compressed formats: total size of all mip levels
      
      - id: depth
        type: u4
        doc: Depth for volume textures (usually 0 for 2D textures)
      
      - id: mipmap_count
        type: u4
        doc: Number of mipmap levels (0 or 1 = no mipmaps)
      
      - id: reserved1
        type: u4
        repeat: expr
        repeat-expr: 11
        doc: Reserved fields (unused)
      
      - id: pixel_format
        type: ddpixelformat
        doc: Pixel format structure
      
      - id: caps
        type: u4
        doc: |
          Capability flags:
          - 0x00001000 = DDSCAPS_TEXTURE
          - 0x00000008 = DDSCAPS_MIPMAP
          - 0x00000200 = DDSCAPS2_CUBEMAP
      
      - id: caps2
        type: u4
        doc: |
          Additional capability flags:
          - 0x00000200 = DDSCAPS2_CUBEMAP
          - 0x00000FC00 = Cube map face flags
      
      - id: caps3
        type: u4
        doc: Reserved capability flags
      
      - id: caps4
        type: u4
        doc: Reserved capability flags
      
      - id: reserved2
        type: u4
        doc: Reserved field
  
  ddpixelformat:
    seq:
      - id: size
        type: u4
        doc: Structure size (must be 32)
        valid: 32
      
      - id: flags
        type: u4
        doc: |
          Pixel format flags:
          - 0x00000001 = DDPF_ALPHAPIXELS
          - 0x00000002 = DDPF_ALPHA
          - 0x00000004 = DDPF_FOURCC
          - 0x00000040 = DDPF_RGB
          - 0x00000200 = DDPF_YUV
          - 0x00080000 = DDPF_LUMINANCE
      
      - id: fourcc
        type: str
        encoding: ASCII
        size: 4
        doc: |
          Four-character code for compressed formats:
          - "DXT1" = DXT1 compression
          - "DXT3" = DXT3 compression
          - "DXT5" = DXT5 compression
          - "    " = Uncompressed format
      
      - id: rgb_bit_count
        type: u4
        doc: Bits per pixel for uncompressed formats (16, 24, or 32)
      
      - id: r_bit_mask
        type: u4
        doc: Red channel bit mask (for uncompressed formats)
      
      - id: g_bit_mask
        type: u4
        doc: Green channel bit mask (for uncompressed formats)
      
      - id: b_bit_mask
        type: u4
        doc: Blue channel bit mask (for uncompressed formats)
      
      - id: a_bit_mask
        type: u4
        doc: Alpha channel bit mask (for uncompressed formats)
  
  bioware_dds_header:
    seq:
      - id: width
        type: u4
        doc: Image width in pixels (must be power of two, < 0x8000)
      
      - id: height
        type: u4
        doc: Image height in pixels (must be power of two, < 0x8000)
      
      - id: bytes_per_pixel
        type: u4
        enum: bioware_common::bioware_dds_variant_bytes_per_pixel
        doc: |
          BioWare variant “bytes per pixel” (`u4`): DXT1 vs DXT5 block stride hint. Canonical: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
      
      - id: data_size
        type: u4
        doc: |
          Total compressed data size.
          Must match (width*height)/2 for DXT1 or width*height for DXT5
      
      - id: unused_float
        type: f4
        doc: Unused float field (typically 0.0)

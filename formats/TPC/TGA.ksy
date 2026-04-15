meta:
  id: tga
  title: Targa (TGA) Image Format
  license: MIT
  endian: le
  file-extension:
    - tga
    - targa
  imports:
    - ../Common/tga_common
  xref:
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: TGA sources often converted to TPC for in-game use.
    pykotor_wiki_tpc: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    xoreos: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tga.cpp
    xoreos_types_kfiletype_tga: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L61
    xoreos_tga_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tga.cpp#L75-L87
    xoreos_tga_read_header: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tga.cpp#L89-L177
    tga_common_enums: |
      Header `color_map_type` / `image_type`: `formats/Common/tga_common.ksy` → `tga_color_map_type`, `tga_image_type`.
doc: |
  **TGA** (Truevision Targa): 18-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
  converts authoring TGAs to **TPC** for shipping.

  Shared header enums: `formats/Common/tga_common.ksy`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TPC/TGA pipeline)"
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/graphics/images/tga.cpp#L89-L177 xoreos — TGA::readHeader"

seq:
  - id: id_length
    type: u1
    doc: Length of image ID field (0-255 bytes)
  
  - id: color_map_type
    type: u1
    doc: |
      Color map type (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_color_map_type`.
    enum: tga_common::tga_color_map_type
  
  - id: image_type
    type: u1
    doc: |
      Image type / compression (`u1`). Canonical: `formats/Common/tga_common.ksy` → `tga_image_type`.
    enum: tga_common::tga_image_type
  
  - id: color_map_spec
    type: color_map_specification
    if: 'color_map_type == tga_common::tga_color_map_type::present'
    doc: Color map specification (only present if color_map_type == present)
  
  - id: image_spec
    type: image_specification
    doc: Image specification (dimensions and pixel format)
  
  - id: image_id
    type: str
    size: id_length
    encoding: ASCII
    if: id_length > 0
    doc: Image identification field (optional ASCII string)
  
  - id: color_map_data
    type: u1
    repeat: expr
    repeat-expr: color_map_spec.length
    if: 'color_map_type == tga_common::tga_color_map_type::present'
    doc: Color map data (palette entries)
  
  - id: image_data
    type: u1
    repeat: eos
    doc: |
      Image pixel data (raw or RLE-compressed).
      Size depends on image dimensions, pixel format, and compression.
      For uncompressed formats: width × height × bytes_per_pixel
      For RLE formats: Variable size depending on compression ratio

types:
  color_map_specification:
    seq:
      - id: first_entry_index
        type: u2
        doc: Index of first color map entry
      
      - id: length
        type: u2
        doc: Number of color map entries
      
      - id: entry_size
        type: u1
        doc: Size of each color map entry in bits (15, 16, 24, or 32)
  
  image_specification:
    seq:
      - id: x_origin
        type: u2
        doc: X coordinate of lower-left corner of image
      
      - id: y_origin
        type: u2
        doc: Y coordinate of lower-left corner of image
      
      - id: width
        type: u2
        doc: Image width in pixels
      
      - id: height
        type: u2
        doc: Image height in pixels
      
      - id: pixel_depth
        type: u1
        doc: |
          Bits per pixel:
          - 8 = Greyscale or indexed
          - 16 = RGB 5-5-5 or RGBA 1-5-5-5
          - 24 = RGB
          - 32 = RGBA

      - id: image_descriptor
        type: u1
        doc: |
          Image descriptor byte:
          - Bits 0-3: Number of attribute bits per pixel (alpha channel)
          - Bit 4: Reserved
          - Bit 5: Screen origin (0 = bottom-left, 1 = top-left)
          - Bits 6-7: Interleaving (usually 0)

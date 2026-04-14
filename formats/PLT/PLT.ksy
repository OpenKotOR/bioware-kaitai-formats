meta:
  id: plt
  title: BioWare PLT (Palette Texture) File Format
  license: MIT
  endian: le
  file-extension: plt
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: PLT type exists in Aurora tables but KotOR does not ship NWN-style PLT body usage (see doc)."
    pykotor_wiki_plt: https://github.com/OldRepublicDevs/PyKotor/wiki/PLT-File-Format.md
    xoreos_docs_plt: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
    xoreos: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp
doc: |
  PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
  palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
  that reference external palette files, enabling dynamic color customization for character models
  (skin, hair, armor colors, etc.).
  
  **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
  resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
  does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
  including character models. This documentation is provided for reference only.
  
  Binary Format Structure:
  - Header (24 bytes): Signature, Version, Unknown fields, Width, Height
  - Pixel Data: Array of 2-byte pixel entries (color index + palette group index)
  
  Palette System:
  PLT files work in conjunction with external palette files (.pal files) that contain the actual
  color values. The PLT file itself stores:
  1. Palette Group index (0-9): Which palette group to use for each pixel
  2. Color index (0-255): Which color within the selected palette to use
  
  At runtime, the game:
  1. Loads the appropriate palette file for the selected palette group
  2. Uses the palette index (supplied by the content creator) to select a row in the palette file
  3. Uses the color index from the PLT file to retrieve the final color value
  
  Palette Groups (10 total):
  0 = Skin, 1 = Hair, 2 = Metal 1, 3 = Metal 2, 4 = Cloth 1, 5 = Cloth 2,
  6 = Leather 1, 7 = Leather 2, 8 = Tattoo 1, 9 = Tattoo 2
  
  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/PLT-File-Format.md
  - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
  - https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp

seq:
  - id: header
    type: plt_header
    doc: PLT file header (24 bytes)
  
  - id: pixel_data
    type: pixel_data_section
    doc: Array of pixel entries (width × height entries, 2 bytes each)

types:
  plt_header:
    seq:
      - id: signature
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File signature. Must be "PLT " (space-padded).
          This identifies the file as a PLT palette texture.
        valid: "'PLT '"
      
      - id: version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Must be "V1  " (space-padded).
          This is the only known version of the PLT format.
        valid: "'V1  '"
      
      - id: unknown1
        type: u4
        doc: |
          Unknown field (4 bytes).
          Purpose is unknown, may be reserved for future use or internal engine flags.
      
      - id: unknown2
        type: u4
        doc: |
          Unknown field (4 bytes).
          Purpose is unknown, may be reserved for future use or internal engine flags.
      
      - id: width
        type: u4
        doc: |
          Texture width in pixels (uint32).
          Used to calculate the number of pixel entries in the pixel data section.
      
      - id: height
        type: u4
        doc: |
          Texture height in pixels (uint32).
          Used to calculate the number of pixel entries in the pixel data section.
          Total pixel count = width × height
  
  pixel_data_section:
    seq:
      - id: pixels
        type: plt_pixel
        repeat: expr
        repeat-expr: _root.header.width * _root.header.height
        doc: |
          Array of pixel entries, stored row by row, left to right, top to bottom.
          Total size = width × height × 2 bytes.
          Each pixel entry contains a color index and palette group index.
  
  plt_pixel:
    seq:
      - id: color_index
        type: u1
        doc: |
          Color index (0-255) within the selected palette.
          This value selects which color from the palette file row to use.
          The palette file contains 256 rows (one for each palette index 0-255),
          and each row contains 256 color values (one for each color index 0-255).
      
      - id: palette_group_index
        type: u1
        doc: |
          Palette group index (0-9) that determines which palette file to use.
          Palette groups:
          0 = Skin (pal_skin01.jpg)
          1 = Hair (pal_hair01.jpg)
          2 = Metal 1 (pal_armor01.jpg)
          3 = Metal 2 (pal_armor02.jpg)
          4 = Cloth 1 (pal_cloth01.jpg)
          5 = Cloth 2 (pal_cloth01.jpg)
          6 = Leather 1 (pal_leath01.jpg)
          7 = Leather 2 (pal_leath01.jpg)
          8 = Tattoo 1 (pal_tattoo01.jpg)
          9 = Tattoo 2 (pal_tattoo01.jpg)


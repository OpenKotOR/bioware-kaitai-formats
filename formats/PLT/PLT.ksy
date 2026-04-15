meta:
  id: plt
  title: BioWare PLT (Palette Texture) File Format
  license: MIT
  endian: le
  file-extension: plt
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_mcp_program_context: |
      PLT is **NWN / general Aurora** palette-indexed wire (`PLTFile` in xoreos). For Ghidra parity with **`pltfile.cpp`**, an
      **`nwmain.exe`** checkout in the Odyssey MCP project is appropriate. For **KotOR shipping evidence** (PLT type id present,
      body unused), correlate **`/K1/k1_win_gog_swkotor.exe`** / TSL builds per `AGENTS.md`.
    ghidra_odyssey_k1: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: PLT type exists in Aurora tables but KotOR does not ship NWN-style PLT body usage (see doc)."
    pykotor_wiki_plt: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    github_openkotor_pykotor_resource_type_plt: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/type.py`: **`ResourceType.PLT`** **374–380** (NWN-era type id **6**; KotOR does not ship PLT bodies — see `doc`).
    xoreos_docs_plt: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html
    xoreos_pltfile_cpp: https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145
    github_xoreos_pltfile: |
      https://github.com/xoreos/xoreos — `src/graphics/aurora/pltfile.cpp`: **`PLTFile::load`** **102–145**; **`PLTFile::build`** **147+** (palette expansion / surface build).
    github_xoreos_types_kfiletype_plt: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43
    xoreos_tools_upstream_note_plt: |
      No dedicated `plt*` extractor surfaced in a quick `xoreos-tools` `src/images/` scan on `master` — treat Torlack HTML + xoreos `pltfile.cpp` as primary wire references.
    reone_resource_type_plt_note: |
      `modawan/reone` `master`: no `*plt*` wire reader path in-tree; engine lists `Plt = 6` next to other Aurora type ids —
      https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35
doc: |
  PLT (Palette Texture) is a texture format used in Neverwinter Nights that allows runtime color
  palette selection. Instead of fixed colors, PLT files store palette group indices and color indices
  that reference external palette files, enabling dynamic color customization for character models
  (skin, hair, armor colors, etc.).
  
  **Note**: This format is Neverwinter Nights-specific and is NOT used in KotOR games. While the PLT
  resource type (0x0006) exists in KotOR's resource system due to shared Aurora engine heritage, KotOR
  does not load, parse, or use PLT files. KotOR uses standard TPC/TGA/DDS textures for all textures,
  including character models. This documentation is provided for reference only.

  **reone:** the KotOR-focused fork does not ship a standalone PLT body reader; see `meta.xref.reone_resource_type_plt_note` for the numeric `Plt` type id only.
  
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
  
  Canonical upstream links: `meta.doc-ref` and `meta.xref`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy PyKotor wiki — PLT (NWN legacy)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L374-L380 PyKotor — `ResourceType.PLT` (NWN-era id 6)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/plt.html xoreos-docs — Torlack plt.html"
  - "https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no PLT-specific tool on `master`)"
  - "https://github.com/xoreos/xoreos/blob/master/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L63 xoreos — `kFileTypePLT`"
  - "https://github.com/modawan/reone/blob/master/include/reone/resource/types.h#L35 reone — `ResourceType::Plt` (id 6; no `.plt` wire reader on default branch)"

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


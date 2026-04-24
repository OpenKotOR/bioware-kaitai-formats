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
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    in_tree_tga_crossrefs: |
      Aurora `ResourceType` **3 = TGA** echoed as `tga` in: `formats/Common/bioware_type_ids.ksy` (enum slot **3** / `tga`),
      `formats/ERF/ERF.ksy` (**304**: `3: tga`), `formats/RIM/RIM.ksy` (**176**: `3: tga`). Dragon Age save wrappers mention TGA/DDS portraits/screens:
      `formats/DAS/DAS.ksy` (**65**, **76**), `formats/DA2S/DA2S.ksy` (**65**, **76**). `formats/PLT/PLT.ksy` (**21**) notes KotOR ships **TPC/TGA/DDS** (not PLT).
      Shared enums: `formats/Common/tga_common.ksy` (`tga_color_map_type`, `tga_image_type`) — see `tga_common_enums` below.
    pykotor_wiki_tpc: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc
    github_openkotor_pykotor_tga_core: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py` (on `master` at time of indexing; line anchors):
      module doc **1–11** (Truevision TGA, uncompressed + RLE, TPC conversion); constants **`TGA_TYPE_*`** **23–25**; **`TGAImage`** dataclass **28–36** (`width`, `height`, `data` RGBA8888 top-left);
      **`read_tga(stream)`** **81+** (full header + pixel decode path); **`write_tga(..., rle=...)`** **141+** (encoder).
    github_openkotor_pykotor_io_tga_kaitai_bridge: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py`:
      imports generated **`Tga`** from **`bioware_kaitai_formats.tga`** (**15**) alongside `read_tga` from `tga.py` (**16–17**) — this repo’s **`formats/TPC/TGA.ksy`** is the schema behind that import when PyKotor consumes the published package.
      **`_write_tga_rgba`** **60–85** writes an uncompressed true-colour TGA (type **2**, 32 bpp, origin/descriptor bits **76–77**, BGRA body **79–85**).
      **`TPCTGAReader`** **87–257**: docstring **88–99** (uncompressed/RLE, colour map, grayscale, cube 6:1); **`load`** **214–257** validates with `Tga.from_bytes` then **`read_tga`**, splits **6×1** cubemap faces (**232–236**), builds **`TPC`** layers.
      **`TPCTGAWriter`** **259+**: **`write`** **280+** stitches animated / cube-map frames then **`_write_tga_rgba`** for flat output.
    xoreos_runtime_tga: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tga.cpp#L75-L87
    xoreos_types_kfiletype_tga: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L61
    xoreos_tga_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tga.cpp#L75-L87
    xoreos_tga_read_header: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tga.cpp#L89-L177
    xoreos_tga_read_data_rle: |
      Same file `tga.cpp`: **`TGA::readData`** **179+** (uncompressed pixel paths by `ImageType` + depth), **`TGA::readRLE`** **238+** (packet decode for RLE RGB/grayscale),
      plus earlier **`TGA::load`** **75–87** and **`readHeader`** **89–177** (already linked as `xoreos_tga_read_header`).
    github_xoreos_xoreos_tools_tga: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tga.cpp#L68-L241
    github_modawan_reone_tga: |
      https://github.com/modawan/reone (mirrored under `_upstream_refs/reone/` in this repo for line-accurate notes):
      **`ResType::Tga = 3`:** `include/reone/resource/types.h` **33**; extension **`"tga"`:** `src/libs/resource/typeutil.cpp` **29**.
      **Loader:** `src/libs/graphics/format/tgareader.cpp` **`TgaReader::load`** **29–74** (id length, colour-map byte skip **32**, image type → **`TGADataType`** **34–42**, skip colour-map spec **45**, width/height **47–48**, bpp validation **50–53**, descriptor / flip rejection **55–59**, cubemap 6:1 **61–70**, skip image ID **73**, **`loadTexture`** **74**),
      **`loadTexture`** **77–90**, **`readPixels` / `readPixelsRLE`** **93–140**, predicates **143–152**.
      **Writer:** `src/libs/graphics/format/tgawriter.cpp` **`save`** **34–73** (18 (0x12)-byte header **28**, fields **46–61**, raw vs per-scanline **RLE** **66–72**), **`getTexturePixels`** **76–120** (maps `PixelFormat` including **DXT1/DXT5** to exported TGA data types **86–94**).
      **Provider order:** `src/libs/resource/provider/textures.cpp` **72–77** (`find` `ResType::Tga`, `TgaReader`); **TPC branch** follows (**83–97** in same file).
      **In-game TGA:** `src/libs/game/gui/saveload.cpp` **176–181** loads ERF **`screen`/`ResType::Tga`** via `TgaReader`.
      **TPC↔TGA tool:** `src/libs/tools/legacy/tpc.cpp` **`toTGA`** **41–67** (`TgaWriter` on decoded `TpcReader` texture).
      **Test:** `test/graphics/format/tgareader.cpp` **`TEST(TgaReader, should_load_tga)`** **28–58** (minimal grayscale 1×1 (0x1) bytes).
    github_kobaltblu_kotor_js_tga: |
      https://github.com/KobaltBlu/KotOR.js (also `github.com/kobaltblu/kotor.js`); in-repo snapshot `_upstream_refs/kotor.js/`:
      **`"tga" : 3`:** `src/resource/ResourceTypes.ts` **15**; label **`'TGA Image'`:** `src/resource/ResourceTypeInfo.ts` **15**.
      **`TGALoader`:** `src/loaders/TGALoader.ts` **`fetch`** **28–62** (`ResourceLoader.loadResource(ResourceTypes.tga, …)` **32**, optional **TXI** sidecar **47–52**),
      **`fetchOverride` / `fetchLocal`** **65–134** (disk `.tga` + `.txi` / TPC fallback), **`parse`** **137+** (THREE-derived parser: header struct **162–178**, **`tgaCheckHeader`** **180–214**, RLE + indexed + RGB paths below — file continues to ~**650** lines total).
      **`TextureLoader` integration:** `src/loaders/TextureLoader.ts` **54–60** (TGA path before other fallbacks in `loadTexture`), **85–97** (`fetchLocal`), **116** (lightmaps).
      **`TGAObject`:** `src/resource/TGAObject.ts` **`readHeader`** **50+**, authoring helper **`fromCanvas`** **161–190** (writes header + BGRA flip).
      **Forge UI:** `src/apps/forge/components/treeview/ListItemNode.tsx` **`case 'tga'`** **124** (icon); image viewers use TGA buffers alongside TPC (`TabImageViewerState.tsx`, `TextureCanvas.tsx` — same tree).
    github_lachjames_northernlights_upstream: https://github.com/lachjames/NorthernLights
    github_th3w1zard1_northernlights_tga: |
      https://github.com/th3w1zard1/NorthernLights (fork of `lachjames/NorthernLights` — upstream repo: `meta.xref.github_lachjames_northernlights_upstream`):
      **`ResourceType.TGA = 3`** with comment **Truevision TARGA**: `Assets/Scripts/ResourceLoader/Resources.cs` **35** (enum mirrors xoreos `types.h` comment at **28** in that file).
      **`LoadTexture2D`:** same file **406–408** — if no **TPC**, opens **`ResourceType.TGA`** stream and **`TGALoader.LoadTGA(stream)`**.
      **Extension table:** `Assets/Scripts/GameData.cs` **67** (`{ "tga", ResourceType.TGA }`).
      **`TGALoader` implementation:** `Assets/Scripts/ResourceLoader/TGALoader.cs` **19–62** — seeks to byte **12**, reads **width/height/bitDepth**, supports **24/32** BGRA channel order (**39–59**), rejects other depths **62**.
    tga_common_enums: |
      Header `color_map_type` / `image_type`: `formats/Common/tga_common.ksy` → `tga_color_map_type`, `tga_image_type`.
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
    xoreos_docs_kotor_mdl: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html
doc: |
  **TGA** (Truevision Targa): 18 (0x12)-byte header, optional color map, image id, then raw or RLE pixels. KotOR often
  converts authoring TGAs to **TPC** for shipping.

  Shared header enums: `formats/Common/tga_common.ksy`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#tpc PyKotor wiki — textures (TPC/TGA pipeline)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/tga.py#L1-L40 PyKotor — compact TGA reader (`tga.py`)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_tga.py#L60-L120 PyKotor — TGA↔TPC bridge (`io_tga.py`, `_write_tga_rgba` + `TPCTGAReader`)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/images/tga.cpp#L89-L177 xoreos — `TGA::readHeader`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/images/tga.cpp#L68-L241 xoreos-tools — `TGA::load` through `readRLE` (tooling reader)"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs PDF tree"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/kotor_mdl.html xoreos-docs — KotOR MDL overview (texture pipeline context)"
  - "https://github.com/lachjames/NorthernLights lachjames/NorthernLights — upstream Unity Aurora sample (fork: `th3w1zard1/NorthernLights` in `meta.xref`)"

seq:
  - id: id_length
    type: u1
    doc: Length of image ID field (0-255 (0xff) bytes)
  
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

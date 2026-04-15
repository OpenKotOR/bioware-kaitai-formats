meta:
  id: dds
  title: DirectDraw Surface (DDS) Texture Format
  license: MIT
  endian: le
  file-extension: dds
  imports:
    - ../Common/bioware_common
  xref:
    ghidra_mcp_odyssey_program_paths: |
      Odyssey shared Ghidra (user-agdec-http): use `sync-project` then `checkout-program` with these repository paths.
      Programs used for DDS/TPC wiring below: `/K1/k1_win_gog_swkotor.exe` (x86 LE), `/TSL/k2_win_gog_aspyr_swkotor2.exe` (x86 LE),
      `/Other BioWare Engines/Aurora/nwmain.exe` (x64 LE). Jade Empire (`/JE/JadeEmpire.exe`) and Eclipse `daorigins.exe`
      were also checked out for diversity; JE had no demangled `CResDDS` / `CResTPC` function names in a function-table sweep,
      and a broad `search-everything` on `daorigins.exe` returned an MCP transport error (retry separately if needed).
    ghidra_k1_win_gog_swkotor_exe: |
      Binary: `/K1/k1_win_gog_swkotor.exe` — `.text` 00401000–0073cfff, `.rdata` 0073d000–0078cfff.
      `CResHelper<class_CResDDS,2033>` dtor `~CResHelper<CResDDS,2033>` at `007104d0`; `CResDDS` ctor `00710ea0` stores vtable pointer `0x0075fbe4`
      in `*(this)` after `CRes::CRes` at `00406460`, zeroes `this+0x28..+0x34`, sets `this+0x20` to `1`.
      Vtable at `0x0075fbe4` (first slots): `~CResDDS` `00710f70`, `return_minus_one` `00406490`, `return_zero` `0063e7f0`,
      `OnResourceFreed` `00711010`, `OnResourceServiced` `00710f30`, …
      `CResDDS::OnResourceServiced` (`00710f30`): requires `this+0x10` non-null; early-outs if `+0x28` or `+0x34` or `+0x30` already set;
      then `MOV [this+0x34], EAX` with `EAX = *(this+0x10)`; `ADD EAX, 0x14` at `00710f58`; `MOV [this+0x30], EAX`; `MOV dword [this+0x28], 1`.
      Same **0x14-byte skip** as KotOR II before exposing a payload pointer (standard `DDS ` + 124-byte header vs BioWare headerless branch is decided upstream of this slice).
      `CResDDS::OnResourceFreed` (`00711010`): clears `+0x28..+0x34` (32-bit fields).
      `CResDDS::GetDDSAttrib` (`00710ee0`): if `this+0x34` null, `RET 0x14` failure; else reads `uint32` at `[base+0]`, `[base+4]`, `uint8` at `[base+8]`, `uint32` at `[base+0xc]`, `uint32` at `[base+0x10]` from `this+0x34` into caller out-params (BioWare DDS prefix / first DWORDs of a Microsoft header, depending on what `+0x34` points at).
      `CAuroraCompressedTexture::GetCompressedTextureAttrib` (`007103c0`) calls `CRes::GetDemands` (`004064b0`) then dispatches to `GetDDSAttrib` (`00710ee0`) when `this+0x8` holds the `CResDDS` helper.
      `CResTPC::OnResourceServiced` (`00712ff0`): `LEA EDX,[ESI+0x80]` / `MOV [this+0x3c],EDX` with `ESI=*(this+0x10)` — **128-byte TPC header** before DDS-like layout; reads flags at `[ESI+0xc]`, dimensions `uint16` at `+8/+0xa`, mip count byte `+0xd`; `SUB EAX,0x80` at `00713156` when sizing tail payload — aligns with `TPC.ksy` wrapper + embedded DDS body.
    ghidra_nwmain_aurora_exe: |
      Binary: `/Other BioWare Engines/Aurora/nwmain.exe` — x64, `.text` 140001000–140d7bfff; MSVC symbols present on `CResDDS`.
      `CResDDS::CResDDS` (`1400f9a60`): calls `CRes::CRes` (`14018d920`), installs vtable at `0x140d92a70`, clears `this+0x60`, `+0x68`, `+0x70`, `+0x78` (qword state) and sets `dword [this+0x38]=1`.
      `CResDDS::OnResourceServiced` (`1400f9d10`): loads raw buffer `RAX=[this+0x20]`; compares **`CMP dword ptr [RAX], 0x20534444`** (`'DDS '` LE) at `1400f9d34`. If magic matches: `MOV [this+0x78],RAX`, `MOV EDX,0x80`, else `MOV [this+0x70],RAX`, `MOV EDX,0x14`; then `ADD RAX,RDX`, `MOV [this+0x68],RAX`, `MOV dword [this+0x60],1`. So Aurora explicitly forks **Microsoft DDS** (payload after **0x80** bytes from the start of the resource view) vs **non-magic / BioWare-style** (payload after **0x14** bytes), and stores the discriminant in `+0x70` vs `+0x78` (`GetContainerFormat` `1400f9b70` returns `1` when `+0x70` is non-zero, else derives `0/2` from `+0x78`).
      `GetDDSAttrib` (`1400f9b90`): prefers `this+0x70`; if null uses `this+0x78` path and reads standard DDS header fields from `RAX+0x10` etc.; classifies **DXT** by comparing `dword [RAX+0x54]` to `0x35545844` (`DXT5`), `0x31545844` (`DXT1`), `0x32495441` / `0x31495441` (ATI1/ATI2-style FOURCCs), then chooses **8** vs **16** byte block sizes for footprint math (`MOV R8D,8` vs `16` at `1400f9c49` / `1400f9c53`).
      `GetDDSDataPtr` (`1400f9cc0`): returns `this+0x68` (the post-offset payload pointer wired in `OnResourceServiced`).
      `CAuroraCompressedTextureDDS::CAuroraCompressedTextureDDS` (`1400f2c90`): allocates/`CResDDS` ctor (`1400f9a60`) and registers via `CExoResMan::SetResObject` (`140194470`) with Restype **`0x7f1`** (`R8D` before `SetResObject`); ties high-level texture objects to the same `CResDDS` Restype **2033** (`0x7f1`) seen in Odyssey KotOR classes.
    ghidra_tsl_k2_win_gog_aspyr_swkotor2_exe: |
      Binary: `/TSL/k2_win_gog_aspyr_swkotor2.exe` (KotOR II GOG Aspyr, x86 LE) — `.text` 00401000–00984bff, `.rdata` 00985000–009f1dff.
      `CResDDS` primary vtable pointer **`0x009a9180`** installed from `FUN_0090bfb0` (`0090bfb0`) used by `~CResDDS` (`0090bf80`); base teardown `FUN_0061ab00` shared with other `CRes*` types.
      Vtable slots (`.rdata` `0x009a9180`): slot0 `~CResDDS` `0090bf80`, slot1 `return_minus_one` `00663820`, slot2 `return_zero` `00410c20`, slot3 `FUN_0090c7a0` (`0090c7a0`, clears `this+0x28..+0x34`), slot4 `CResDDS::OnResourceServiced` **`0090c040`**.
      `CResDDS::OnResourceServiced` (`0090c040`): uses `this+0x10` as resource bytes; stores copy at `this+0x34`, sets `this+0x30` to **`*(this+0x10) + 0x14`** (`ADD EDX,0x14` at `0090c090`), sets `this+0x28` to `1` — same **0x14** skip as K1, without an in-function literal compare to `0x20534444` (magic discrimination not inlined in this build).
      `CResTPC::OnResourceServiced` (`00944550`): sets `this+0x3c` to **`*(this+0x10) + 0x80`** (`ADD EDX,0x80` at `009445bc`); byte tests on `[base+0xc]` for DXT block width; `SUB EAX,0x80` at `009447c8` when computing residual size — same **128-byte TPC** header constant as K1.
      Runtime GL path: imports `glBindTexture`, `glGenTextures`, etc.; `CAuroraCompressedTexture` destructor `00907b30` (vtable ref `009a9100`).
    github_modawan_reone_dds_tpc_dxt: |
      https://github.com/modawan/reone — pinned commit `61531089341caf5827abbc54346c8c959b03d449` (line anchors below use `/blob/61531089341caf5827abbc54346c8c959b03d449/`).
      **Literal `Dds` resource type (Aurora type id 2033):** `include/reone/resource/types.h` line **57** (`Dds = 2033,` in `enum class ResourceType`).
      **Extension string `"dds"` ↔ `ResType::Dds`:** `src/libs/resource/typeutil.cpp` line **53** (`{ResType::Dds, "dds"},` in the `ResType` → extension table).
      **Runtime texture load path (TPC first, not a separate `.dds` reader in this tree):** `src/libs/resource/provider/textures.cpp` lines **64–97** try `ResType::Txi` / `ResType::Tga` / `ResType::Tpc` (`TpcReader` at **87–88**); there is **no** `find(..., ResType::Dds)` branch here — standalone DDS assets would need another loader if present elsewhere.
      **TPC = 128-byte header + payload (DXT footprint matches Microsoft-style DDS block layout):** `src/libs/graphics/format/tpcreader.cpp` — header fields **29–37** (`dataSize`, width/height, encoding, mip count), **`_tpc.seek(128)`** at **65** before reading layer bytes, compressed mip byte math **112–118** (`DXT1` 8 bytes/block row, `DXT5` 16), `getPixelFormat()` **136–156** maps compressed `EncodingType::RGB` → `PixelFormat::DXT1`, `RGBA` → `DXT5`.
      **Regression fixture (minimal TPC bytes, grayscale header):** `test/graphics/format/tpcreader.cpp` lines **27–56** (`TEST(TpcReader, should_load_tpc)` builds header + 112-byte pad + 1 mip byte).
      **DXT block decode used by compressed paths (same DXT1/DXT5 payload family as DDS):** `src/libs/graphics/dxtutil.cpp` **129–151** (`decompressDXT1` / `decompressDXT5`), declarations `include/reone/graphics/dxtutil.h` **24–25**; GL internal formats `src/libs/graphics/pixelutil.cpp` **44–47** (`GL_COMPRESSED_*_DXT*_EXT`).
    github_kobaltblu_kotor_js_dds_tpc: |
      https://github.com/KobaltBlu/KotOR.js (user path `github.com/kobaltblu/kotor.js`) — pinned commit `12f8f29183a1c08d461a350b8fea947120ab5cd1`.
      **Resource id `2033` / extension `dds`:** `src/resource/ResourceTypes.ts` line **52** (`"dds" : 2033,`); human label `src/resource/ResourceTypeInfo.ts` line **51** (`"dds" : 'DDS Image',`).
      **128-byte TPC header constant:** `src/resource/TPCObject.ts` line **12** (`const TPCHeaderLength = 128;`); **TXI tail** after image bytes **50–66** (`getTXIData`, offset `getDataLength() + TPCHeaderLength`).
      **In-memory “DDS-like” mip structure from TPC (`getDDS`):** same file **79–263** — builds object with `mipmaps[]`, `mipmapCount`, `width`/`height`, `isCubemap`; lines **87–114** branch uncompressed vs compressed and assign legacy Three.js format constants **94–111** (`33776` DXT1, `33779` DXT5, `1023` RGBA); **121** `dataOffset = TPCHeaderLength`; **139–180** mip loop with DXT block size math **158–163**; **165–167** optional `dxt-js` decompress; **191–257** animated TXI `procedureType == 1` rebuild using `dxtJs.compress`/`decompress`.
      **Compressed texture upload path:** **428–432** `toCompressedTexture()` calls `this.getDDS(true)` then `OdysseyCompressedTexture`.
      **Worker decode (pixel extraction via `getDDS`):** `src/worker/worker-tex.ts` **25–54** (`const dds = tpc.getDDS(false);`, cubemap face loops).
      **Forge UI pixel readback:** `src/apps/forge/states/tabs/TabImageViewerState.tsx` **122–155**; `src/apps/forge/components/TextureCanvas/TextureCanvas.tsx` **24–56** (same `getDDS(false)` pattern).
      **Forge tree icon for `.dds`:** `src/apps/forge/components/treeview/ListItemNode.tsx` **124** (`case 'dds': return 'fa-file-image';` alongside `tpc`).
      **Three.js note on embedded mips (DDS convention):** `src/three/odyssey/OdysseyCompressedTexture.ts` **28–31** (`// mips must be embedded in DDS files`, `generateMipmaps = false`).
    github_th3w1zard1_northernlights_dds_tpc: |
      https://github.com/th3w1zard1/NorthernLights (fork of `lachjames/NorthernLights`) — pinned commit `e9a6cdedb9414de5ee89fe1cd766f1d1711fa247`.
      **`ResourceType` table (xoreos-aligned comment):** `Assets/Scripts/ResourceLoader/Resources.cs` line **28** cites `https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h`; **`DDS = 2033`** with comment **Texture, DirectDraw Surface** at line **72**; **`TPC = 3007`** at line **157** (`// Texture.`).
      **Runtime loader (TPC then TGA; DDS enum present but not used in this function):** same file **`LoadTexture2D`** **388–415** — `GetStream(resref, ResourceType.TPC)` **394–405** builds `TPCObject` and `LoadRawTextureData`, else **`ResourceType.TGA`** **406–409**; no `ResourceType.DDS` branch (DDS wire parsing not implemented on this path).
      **TPC on-disk → Unity `TextureFormat` (DXT1/DXT5 block sizes = DDS DXT payload rules):** `Assets/Scripts/FileObjects/TPCObject.cs` — **`HEADER_SIZE = 128`** **36**; **`readHeader`** **71–176** (`dataSize` at **75–76** drives compressed vs uncompressed, **83** encoding byte, **86** mip count, **95–116** sets `TextureFormat.DXT1`/`DXT5` vs RGB/RGBA, **`getDataSize`** **219–233** DXT mip footprint `((w+3)/4)*((h+3)/4)*8|16` with `Math.Max(8|16, …)`).
      **Legacy / commented binary TPC sketch (DXT branches):** `Assets/Scripts/AuroraBinary/Types/TPC.cs` (entire file commented) lines **35–55** show the same compressed/uncompressed DXT1/DXT5 split.
    pykotor_wiki_dds: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds
    pykotor_io_dds_reader: https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130
    xoreos_tools_dds: https://github.com/xoreos/xoreos-tools/blob/master/src/images/dds.cpp#L69-L158
    xoreos: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp
    xoreos_types_kfiletype_dds: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L98
    xoreos_dds_load: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L55-L67
    xoreos_dds_read_bioware_header: https://github.com/xoreos/xoreos/blob/master/src/graphics/images/dds.cpp#L141-L210
    bioware_common_dds_variant_bpp: |
      `bioware_dds_header.bytes_per_pixel`: `formats/Common/bioware_common.ksy` → `bioware_dds_variant_bytes_per_pixel`.
doc: |
  **DDS** in KotOR: either standard **DirectX** `DDS ` + 124-byte `DDS_HEADER`, or a **BioWare headerless** prefix
  (`width`, `height`, `bytes_per_pixel`, `data_size`) before DXT/RGBA bytes. DXT mips / cube faces follow usual DDS rules.

  BioWare BPP enum: `bioware_dds_variant_bytes_per_pixel` in `bioware_common.ksy`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#dds PyKotor wiki — DDS"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/tpc/io_dds.py#L50-L130 PyKotor — TPCDDSReader"

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

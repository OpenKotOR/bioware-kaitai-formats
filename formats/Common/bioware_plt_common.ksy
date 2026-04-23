meta:
  id: bioware_plt_common
  title: BioWare PLT (palette texture) shared wire enums
  license: MIT
  endian: le
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (NWN-era PLT; KotOR lists type id only — see `formats/PLT/PLT.ksy`).
    pykotor_wiki_plt: https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy
    xoreos_pltfile_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/pltfile.cpp#L102-L145
    xoreos_docs_torlack_plt: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/plt.html
    xoreos_types_kfiletype_plt: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L63
doc: |
  **PLT** wire: **file tag** LE ``u32`` pair (`plt_file_magic_le` / `plt_file_version_le` for ASCII ``PLT `` + ``V1  ``),
  plus per-pixel **`u8`** palette **group** ids (`0..9`) in `plt_palette_group_id` alongside an 8-bit color index into palette rows.

  **Lowest scope:** header tags + palette-group semantics live here; `formats/PLT/PLT.ksy` keeps dimensions + pixel grid layout.

doc-ref:
  - "formats/PLT/PLT.ksy#L137-L152 In-tree — `plt_pixel` + `palette_group_index` (`plt_palette_group_id`)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Texture-Formats#kotor-plt-file-format-documentation-nwn-legacy PyKotor wiki — PLT (NWN legacy)"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/torlack/plt.html xoreos-docs — Torlack plt.html"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/pltfile.cpp#L102-L145 xoreos — `PLTFile::load`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L63 xoreos — `kFileTypePLT`"

enums:
  plt_file_magic_le:
    0x20544c50:
      id: plt_space
      doc: |
        ASCII ``PLT `` as LE ``u32``. xoreos ``PLTFile::load`` signature check.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/pltfile.cpp#L102-L145

  plt_file_version_le:
    0x20203156:
      id: v1_two_spaces
      doc: |
        ASCII ``V1  `` (version + two ASCII spaces). NWN PLT header per Torlack / xoreos.
        https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/graphics/aurora/pltfile.cpp#L102-L145

  # Per-pixel palette group (`plt_pixel` second byte). Ten groups per Torlack / NWN PLT convention.
  plt_palette_group_id:
    0: skin
    1: hair
    2: metal_1
    3: metal_2
    4: cloth_1
    5: cloth_2
    6: leather_1
    7: leather_2
    8: tattoo_1
    9: tattoo_2

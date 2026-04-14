meta:
  id: rim
  title: BioWare RIM (Resource Information Manager) Format
  license: MIT
  endian: le
  file-extension: rim
  xref:
    ghidra_odyssey_k1:
      note: "Odyssey Ghidra /K1/k1_win_gog_swkotor.exe: RIM module templates are loaded through the same Aurora resource stack as ERF (implicit 120-byte header+padding behavior is KotOR-specific; keep aligned with PyKotor)."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/rim/
    reone: https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp
    xoreos: https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp
    pykotor_wiki_rim: https://github.com/OldRepublicDevs/PyKotor/wiki/RIM-File-Format.md
doc: |
  RIM (Resource Information Manager) files are self-contained archives used for module templates.
  RIM files are similar to ERF files but are read-only from the game's perspective. The game
  loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
  RIM files store all resources inline with metadata, making them self-contained archives.
  
  Format Variants:
  - Standard RIM: Basic module template files
  - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
  
  Binary Format (KotOR / PyKotor):
  - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
  - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
  - Key / resource entry table (32 bytes per entry): ResRef, type, ID, offset, size
  - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
  
  References:
  - https://github.com/OldRepublicDevs/PyKotor/wiki/RIM-File-Format.md
  - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp:24-100
  - https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp:40-160
  - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs:11-121
  - https://github.com/KotOR-Community-Patches/KotOR_IO/blob/master/KotOR_IO/File%20Formats/RIM.cs:20-260

seq:
  - id: header
    type: rim_header
    doc: RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
  
  - id: gap_before_key_table_implicit
    size: 96
    if: header.offset_to_resource_table == 0
    doc: |
      When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
      After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
  
  - id: gap_before_key_table_explicit
    size: header.offset_to_resource_table - 24
    if: header.offset_to_resource_table != 0
    doc: |
      When offset_to_resource_table is non-zero, skip until that byte offset (must be >= 24).
      Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
  
  - id: resource_entry_table
    type: resource_entry_table
    if: header.resource_count > 0
    doc: Array of resource entries mapping ResRefs to resource data

types:
  rim_header:
    seq:
      - id: file_type
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be "RIM " (0x52 0x49 0x4D 0x20).
          This identifies the file as a RIM archive.
        valid: "'RIM '"
      
      - id: file_version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V1.0" for KotOR RIM files.
          Other versions may exist in Neverwinter Nights but are not supported in KotOR.
        valid: "'V1.0'"
      
      - id: reserved
        type: u4
        doc: |
          Reserved field (typically 0x00000000).
          Unknown purpose, but always set to 0 in practice.
      
      - id: resource_count
        type: u4
        doc: |
          Number of resources in the archive. This determines:
          - Number of entries in resource_entry_table
          - Number of resources in resource_data_section
      
      - id: offset_to_resource_table
        type: u4
        doc: |
          Byte offset to the key / resource entry table from the beginning of the file.
          0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
          When non-zero, this offset is used directly (commonly 120).
      
      - id: offset_to_resources
        type: u4
        doc: |
          Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
          taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
    
    instances:
      has_resources:
        value: resource_count > 0
        doc: Whether the RIM file contains any resources
  
  resource_entry_table:
    seq:
      - id: entries
        type: resource_entry
        repeat: expr
        repeat-expr: _root.header.resource_count
        doc: Array of resource entries, one per resource in the archive
  
  resource_entry:
    seq:
      - id: resref
        type: str
        encoding: ASCII
        size: 16
        doc: |
          Resource filename (ResRef), null-padded to 16 bytes.
          Maximum 16 characters. If exactly 16 characters, no null terminator exists.
          Resource names can be mixed case, though most are lowercase in practice.
          The game engine typically lowercases ResRefs when loading.
      
      - id: resource_type
        type: u4
        enum: xoreos_file_type_id
        doc: |
          Resource type identifier (see ResourceType enum).
          Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
      
      - id: resource_id
        type: u4
        doc: |
          Resource ID (index, usually sequential).
          Typically matches the index of this entry in the resource_entry_table.
          Used for internal reference, but not critical for parsing.
      
      - id: offset_to_data
        type: u4
        doc: |
          Byte offset to resource data from the beginning of the file.
          Points to the actual binary data for this resource in resource_data_section.
      
      - id: resource_size
        type: u4
        doc: |
          Size of resource data in bytes.
          Uncompressed size of the resource.
    
    instances:
      data:
        type: u1
        pos: offset_to_data
        repeat: expr
        repeat-expr: resource_size
        doc: Raw binary data for this resource (read at specified offset)

enums:
  # NOTE: Mirrors `https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h` (`enum FileType`).
  # TODO: VERIFY - Aliases exist upstream (e.g. 2045 also known as DTF) but Kaitai enums cannot
  # represent multiple names for the same numeric key.
  xoreos_file_type_id:
    -1: none
    0: res
    1: bmp
    2: mve
    3: tga
    4: wav
    6: plt
    7: ini
    8: bmu
    9: mpg
    10: txt
    11: wma
    12: wmv
    13: xmv
    2000: plh
    2001: tex
    2002: mdl
    2003: thg
    2005: fnt
    2007: lua
    2008: slt
    2009: nss
    2010: ncs
    2011: mod
    2012: are
    2013: set
    2014: ifo
    2015: bic
    2016: wok
    2017: two_da
    2018: tlk
    2022: txi
    2023: git
    2024: bti
    2025: uti
    2026: btc
    2027: utc
    2029: dlg
    2030: itp
    2031: btt
    2032: utt
    2033: dds
    2034: bts
    2035: uts
    2036: ltr
    2037: gff
    2038: fac
    2039: bte
    2040: ute
    2041: btd
    2042: utd
    2043: btp
    2044: utp
    2045: dft
    2046: gic
    2047: gui
    2048: css
    2049: ccs
    2050: btm
    2051: utm
    2052: dwk
    2053: pwk
    2054: btg
    2055: utg
    2056: jrl
    2057: sav
    2058: utw
    2059: four_pc
    2060: ssf
    2061: hak
    2062: nwm
    2063: bik
    2064: ndb
    2065: ptm
    2066: ptt
    2067: ncm
    2068: mfx
    2069: mat
    2070: mdb
    2071: say
    2072: ttf
    2073: ttc
    2074: cut
    2075: ka
    2076: jpg
    2077: ico
    2078: ogg
    2079: spt
    2080: spw
    2081: wfx
    2082: ugm
    2083: qdb
    2084: qst
    2085: npc
    2086: spn
    2087: utx
    2088: mmd
    2089: smm
    2090: uta
    2091: mde
    2092: mdv
    2093: mda
    2094: mba
    2095: oct
    2096: bfx
    2097: pdb
    2098: the_witcher_save
    2099: pvs
    2100: cfx
    2101: luc
    2103: prb
    2104: cam
    2105: vds
    2106: bin
    2107: wob
    2108: api
    2109: properties
    2110: png
    3000: lyt
    3001: vis
    3002: rim
    3003: pth
    3004: lip
    3005: bwm
    3006: txb
    3007: tpc
    3008: mdx
    3009: rsv
    3010: sig
    3011: mab
    3012: qst2
    3013: sto
    3015: hex
    3016: mdx2
    3017: txb2
    3022: fsm
    3023: art
    3024: amp
    3025: cwa
    3028: bip
    4000: mdb2
    4001: mda2
    4002: spt2
    4003: gr2
    4004: fxa
    4005: fxe
    4007: jpg2
    4008: pwc
    9996: one_da
    9997: erf
    9998: bif
    9999: key
    19000: exe
    19001: dbf
    19002: cdx
    19003: fpt
    20000: zip
    20001: fxm
    20002: fxs
    20003: xml
    20004: wlk
    20005: utr
    20006: sef
    20007: pfx
    20008: tfx
    20009: ifx
    20010: lfx
    20011: bbx
    20012: pfb
    20013: upe
    20014: usc
    20015: ult
    20016: fx
    20017: max
    20018: doc
    20019: scc
    20020: wmp
    20021: osc
    20022: trn
    20023: uen
    20024: ros
    20025: rst
    20026: ptx
    20027: ltx
    20028: trx
    21000: nds
    21001: herf
    21002: dict
    21003: small
    21004: cbgt
    21005: cdpth
    21006: emit
    21007: itm
    21008: nanr
    21009: nbfp
    21010: nbfs
    21011: ncer
    21012: ncgr
    21013: nclr
    21014: nftr
    21015: nsbca
    21016: nsbmd
    21017: nsbta
    21018: nsbtp
    21019: nsbtx
    21020: pal
    21021: raw
    21022: sadl
    21023: sdat
    21024: smp
    21025: spl
    21026: vx
    22000: anb
    22001: ani
    22002: cns
    22003: cur
    22004: evt
    22005: fdl
    22006: fxo
    22007: gad
    22008: gda
    22009: gfx
    22010: ldf
    22011: lst
    22012: mal
    22013: mao
    22014: mmh
    22015: mop
    22016: mor
    22017: msh
    22018: mtx
    22019: ncc
    22020: phy
    22021: plo
    22022: stg
    22023: tbi
    22024: tnt
    22025: arl
    22026: fev
    22027: fsb
    22028: opf
    22029: crf
    22030: rimp
    22031: met
    22032: meta
    22033: fxr
    22034: cif
    22035: cub
    22036: dlb
    22037: nsc
    23000: mov
    23001: curs
    23002: pict
    23003: rsrc
    23004: plist
    24000: cre
    24001: pso
    24002: vso
    24003: abc
    24004: sbm
    24005: pvd
    24006: pla
    24007: trg
    24008: pk
    25000: als
    25001: apl
    25002: assembly
    25003: bak
    25004: bnk
    25005: cl
    25006: cnv
    25007: con
    25008: dat
    25009: dx11
    25010: ids
    25011: log
    25012: map
    25013: mml
    25014: mp3
    25015: pck
    25016: rml
    25017: s
    25018: sta
    25019: svr
    25020: vlm
    25021: wbd
    25022: xbx
    25023: xls
    26000: bzf
    27000: adv
    28000: json
    28001: tlk_expert
    28002: tlk_mobile
    28003: tlk_touch
    28004: otf
    28005: par
    29000: xwb
    29001: xsb
    30000: xds
    30001: wnd
    40000: xeositex
  


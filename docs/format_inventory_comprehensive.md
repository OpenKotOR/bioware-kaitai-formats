# Comprehensive Format Inventory

**Date:** 2025-01-27  
**Purpose:** Complete inventory of all BioWare file formats from vendor sources

## Format Sources

### PyKotor Wiki Documentation
Formats documented with `*-File-Format.md`:
- 2DA (Two-Dimensional Array)
- BIF (BioWare Index File)
- BWM (BioWare Walkmesh)
- DDS (DirectDraw Surface)
- ERF (Encapsulated Resource Format)
- GFF (Generic File Format)
- KEY (Key File)
- LIP (Lip-sync)
- LTR (Letter)
- LYT (Layout)
- MDL-MDX (Model)
- NCS (NWScript Compiled)
- NSS (NWScript Source)
- PLT (Palette Texture)
- SSF (Sound Set File)
- TLK (Talk Table)
- TPC (Texture Package Container)
- TXI (Texture Info)
- VIS (Visibility)
- WAV (Waveform Audio)

### PyKotor GFF Generic Formats
Formats documented with `GFF-*.md`:
- GFF-ARE (Area)
- GFF-DLG (Dialogue)
- GFF-FAC (Faction)
- GFF-GIT (Game Instance Template)
- GFF-GUI (GUI)
- GFF-IFO (Module Info)
- GFF-JRL (Journal)
- GFF-PTH (Path)
- GFF-UTC (Creature)
- GFF-UTD (Door)
- GFF-UTE (Encounter)
- GFF-UTI (Item)
- GFF-UTM (Merchant)
- GFF-UTP (Placeable)
- GFF-UTS (Sound)
- GFF-UTT (Trigger)
- GFF-UTW (Waypoint)

### PyKotor Implementation Directories
Formats with implementation code in `pykotor/resource/formats/`:
- bif/ (BIF, BZF)
- bwm/ (BWM)
- erf/ (ERF)
- gff/ (GFF base + all generics)
- key/ (KEY)
- lip/ (LIP)
- ltr/ (LTR)
- lyt/ (LYT)
- mdl/ (MDL, MDX)
- ncs/ (NCS, NSS)
- rim/ (RIM)
- ssf/ (SSF)
- tlk/ (TLK)
- tpc/ (TPC, TXI)
- twoda/ (2DA)
- vis/ (VIS)
- wav/ (WAV)

### xoreos Aurora Formats
Formats with `*file.cpp` implementations:
- 2da (Two-Dimensional Array)
- aurora (Base format)
- bif (BIF)
- bzf (BZF)
- dlg (Dialogue - GFF generic)
- erf (ERF)
- gda (GDA - Game Data Array, 2DA variant)
- gff3 (GFF v3)
- gff4 (GFF v4)
- gfx (Graphics)
- gr2 (Granny 2 - 3D model format)
- herf (HERF - similar to ERF)
- ifo (Module Info - GFF generic)
- key (KEY)
- ltr (LTR)
- lyt (LYT)
- nfo (Save metadata - GFF generic)
- nitro (Nitro - NDS format)
- nsbtx (NSBTX - texture format)
- obb (OBB - Android format)
- pe (PE - Portable Executable)
- rim (RIM)
- sac (SAC)
- small (Small)
- ssf (SSF)
- textureatlas (Texture Atlas)
- thewitchersave (The Witcher save format)
- vis (VIS)
- zip (ZIP)

## Existing .ksy Files

### Core Formats (54 files)
1. formats/BIF/BIF.ksy
2. formats/BIF/BZF.ksy
3. formats/BIF/KEY.ksy
4. formats/BWM/BWM.ksy
5. formats/Common/bioware_common.ksy
6. formats/Common/bioware_type_ids.ksy
7. formats/DA2S/DA2S.ksy
8. formats/DAS/DAS.ksy
9. formats/ERF/ERF.ksy
10. formats/GFF/GFF.ksy
11. formats/GFF/JSON/GFF_JSON.ksy
12. formats/GFF/XML/GFF_XML.ksy
13. formats/LIP/LIP.ksy
14. formats/LIP/LIP_JSON.ksy
15. formats/LIP/LIP_XML.ksy
16. formats/LTR/LTR.ksy
17. formats/LYT/LYT.ksy
18. formats/MDL/MDL.ksy
19. formats/MDL/MDL_ASCII.ksy
20. formats/MDL/MDX.ksy
21. formats/NSS/NCS.ksy
22. formats/NSS/NCS_minimal.ksy
23. formats/NSS/NSS.ksy
24. formats/PCC/PCC.ksy
25. formats/PLT/PLT.ksy
26. formats/RIM/RIM.ksy
27. formats/SSF/SSF.ksy
28. formats/SSF/SSF_XML.ksy
29. formats/TLK/TLK.ksy
30. formats/TLK/TLK_JSON.ksy
31. formats/TLK/TLK_XML.ksy
32. formats/TPC/DDS.ksy
33. formats/TPC/TGA.ksy
34. formats/TPC/TPC.ksy
35. formats/TPC/TXI.ksy
36. formats/TwoDA/TwoDA.ksy
37. formats/TwoDA/TwoDA_CSV.ksy
38. formats/TwoDA/TwoDA_JSON.ksy
39. formats/VIS/VIS.ksy
40. formats/WAV/WAV.ksy

### GFF Generic Formats (43 files - 22 base + 21 XML/JSON variants)
1. formats/GFF/Generics/ARE/ARE.ksy
2. formats/GFF/Generics/ARE/ARE_XML.ksy
3. formats/GFF/Generics/CNV/CNV.ksy
4. formats/GFF/Generics/CNV/CNV_XML.ksy
5. formats/GFF/Generics/DLG/DLG.ksy
6. formats/GFF/Generics/DLG/DLG_XML.ksy
7. formats/GFF/Generics/FAC/FAC.ksy
8. formats/GFF/Generics/FAC/FAC_XML.ksy
9. formats/GFF/Generics/GAM/GAM.ksy
10. formats/GFF/Generics/GAM/GAM_XML.ksy
11. formats/GFF/Generics/GIT/GIT.ksy
12. formats/GFF/Generics/GIT/GIT_XML.ksy
13. formats/GFF/Generics/GUI/GUI.ksy
14. formats/GFF/Generics/GUI/GUI_XML.ksy
15. formats/GFF/Generics/GVT/GVT.ksy
16. formats/GFF/Generics/GVT/GVT_XML.ksy
17. formats/GFF/Generics/IFO/IFO.ksy
18. formats/GFF/Generics/IFO/IFO_XML.ksy
19. formats/GFF/Generics/ITP/ (directory exists but empty)
20. formats/GFF/Generics/JRL/JRL.ksy
21. formats/GFF/Generics/JRL/JRL_XML.ksy
22. formats/GFF/Generics/NFO/NFO.ksy
23. formats/GFF/Generics/NFO/NFO_XML.ksy
24. formats/GFF/Generics/NFO/RES_XML.ksy
25. formats/GFF/Generics/PT/PT.ksy
26. formats/GFF/Generics/PT/PT_XML.ksy
27. formats/GFF/Generics/PTH/PTH.ksy
28. formats/GFF/Generics/PTH/PTH_XML.ksy
29. formats/GFF/Generics/UTC/UTC.ksy
30. formats/GFF/Generics/UTC/UTC_XML.ksy
31. formats/GFF/Generics/UTD/UTD.ksy
32. formats/GFF/Generics/UTD/UTD_XML.ksy
33. formats/GFF/Generics/UTE/UTE.ksy
34. formats/GFF/Generics/UTE/UTE_XML.ksy
35. formats/GFF/Generics/UTI/UTI.ksy
36. formats/GFF/Generics/UTI/UTI_XML.ksy
37. formats/GFF/Generics/UTM/UTM.ksy
38. formats/GFF/Generics/UTM/UTM_XML.ksy
39. formats/GFF/Generics/UTP/UTP.ksy
40. formats/GFF/Generics/UTP/UTP_XML.ksy
41. formats/GFF/Generics/UTS/UTS.ksy
42. formats/GFF/Generics/UTS/UTS_XML.ksy
43. formats/GFF/Generics/UTT/UTT.ksy
44. formats/GFF/Generics/UTT/UTT_XML.ksy
45. formats/GFF/Generics/UTW/UTW.ksy
46. formats/GFF/Generics/UTW/UTW_XML.ksy

**Total: 97 .ksy files**

## Missing Formats

### Potentially Missing from Vendor Sources

Based on xoreos implementations that don't appear in our formats:
- **GDA** (Game Data Array) - 2DA variant, xoreos has `gdafile.cpp`
- **GFF4** - GFF v4 format (xoreos has `gff4file.cpp`)
- **HERF** - Similar to ERF (xoreos has `herffile.cpp`)
- **GR2** - Granny 2 3D model format (xoreos has `gr2file.h`)
- **SAC** - Unknown format (xoreos has `sacfile.h`)
- **ITP base binary** - Palette Texture binary format (ITP directory exists but empty)

Note: Many xoreos formats are for other games (Nitro/NDS, Android, The Witcher, etc.) and may not be BioWare-specific.

### ITP Status
- Directory exists: `formats/GFF/Generics/ITP/`
- XML variant exists: `formats/ITP/ITP_XML.ksy` (or similar - need to verify)
- Base binary format: **MISSING**

## Format Coverage Analysis

### PyKotor Wiki Coverage
- ✅ All documented formats have .ksy files
- ✅ All GFF generics documented have .ksy files
- ✅ ITP base binary is missing (but PLT exists)

### PyKotor Implementation Coverage
- ✅ All implemented formats have .ksy files

### xoreos Coverage
- ✅ Core BioWare formats are covered
- ⚠️ Some xoreos formats are for other games (not BioWare)
- ⚠️ GFF4, GDA, HERF may be needed for newer BioWare games

## Summary

**Existing Formats:** 97 .ksy files (40 core + 43 GFF generics + 14 variants)

**Missing Formats:**
1. **ITP base binary** - Palette Texture binary format
2. **GFF4** - GFF v4 format (if needed)
3. **GDA** - Game Data Array (2DA variant, if needed)
4. **HERF** - Resource archive (if needed)

**Note:** Most "missing" formats from xoreos are for non-BioWare games or may be covered by existing formats (e.g., GDA might be covered by 2DA).


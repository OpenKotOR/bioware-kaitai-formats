meta:
  id: gda
  title: BioWare GDA (Dragon Age 2D array — GFF4 type G2DA)
  license: MIT
  endian: le
  file-extension: gda
  imports:
    - ../GFF/gff
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Dragon Age **G2DA** wire (not KotOR `k1_win_gog_swkotor.exe`). For Eclipse / DA engine binaries checked out in Odyssey,
      use **`user-agdec-http`** per `AGENTS.md` when correlating `GDAFile` / `GFF4File` consumption — same MCP id as other specs.
    xoreos_gdafile_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305
    github_xoreos_gdafile_add: https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L307
    xoreos_gff4_ctor_type: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93
    xoreos_types_kfiletype_gda: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L291
    xoreos_gff4_g2da_fields: https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260
    github_xoreos_2dafile_from_gda: |
      https://github.com/xoreos/xoreos — `src/aurora/2dafile.cpp`: **`TwoDAFile(const GDAFile &)`** **136–140**; **`TwoDAFile::load(const GDAFile &)`** **343–400** (GDA → classic TwoDA in-memory bridge).
    xoreos_2dafile_ctor_from_gda: https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140
    xoreos_2dafile_load_from_gda: https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400
    github_xoreos_tools_convert2da_gda: https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L21-L181
    github_openkotor_pykotor_resource_type_gda: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/type.py`: **`ResourceType.GDA`** **1466–1472** (Dragon Age table resource id **22008** class — no dedicated `formats/gda/` parser package on `master`).
    xoreos_docs_gff_format_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf
    xoreos_docs_common_gff_structs_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf
    xoreos_docs_2da_format_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf
    bioware_twoda_note: |
      Classic Aurora `.2da` wire layout: `formats/TwoDA/TwoDA.ksy`. GDA is a distinct GFF4 container (`G2DA` + `V0.1`/`V0.2`).
    reone_gda_consumer_note: |
      `modawan/reone` (KotOR scope) does not expose a GDA/G2DA ingestion path on default `master` — treat xoreos + xoreos-tools + PyKotor `ResourceType.GDA` as authorities here.
doc: |
  **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
  (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.

  G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.

  **reone:** not applicable for GDA wire ingestion on the KotOR fork (`meta.xref.reone_gda_consumer_note`).

doc-ref:
  - "formats/Common/bioware_gff_common.ksy In-tree — `gff4_g2da_file_type_be` / `gff4_g2da_type_version_be` (G2DA fourCC + V0.x — compare to `GFF.ksy` `gff4_after_aurora`)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gdafile.cpp#L275-L305 xoreos — `GDAFile::load`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4file.cpp#L87-L93 xoreos — `GFF4File` stream ctor (type dispatch)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/gff4fields.h#L1230-L1260 xoreos — G2DA column field ids (excerpt)"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L136-L140 xoreos — `TwoDAFile(const GDAFile &)`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L343-L400 xoreos — `TwoDAFile::load(const GDAFile &)`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86 xoreos-tools — `main`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L167-L181 xoreos-tools — multi-file `GDAFile` merge"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L1466-L1472 PyKotor — `ResourceType.GDA`"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/GFF_Format.pdf xoreos-docs — GFF_Format.pdf (GFF4 family; G2DA container)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/CommonGFFStructs.pdf xoreos-docs — CommonGFFStructs.pdf"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf (classic `.2da`; contrast with GDA)"

seq:
  - id: as_gff4
    type: gff::gff4_file
    doc: |
      On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
      (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).

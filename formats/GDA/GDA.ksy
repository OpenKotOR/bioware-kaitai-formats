meta:
  id: gda
  title: BioWare GDA (Dragon Age 2D array — GFF4 type G2DA)
  license: MIT
  endian: le
  file-extension: gda
  imports:
    - ../GFF/gff
  xref:
    xoreos_gdafile_load: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gdafile.cpp#L275-L305
    xoreos_gff4_ctor_type: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4file.cpp#L87-L93
    xoreos_types_kfiletype_gda: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L291
    xoreos_gff4_g2da_fields: https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gff4fields.h#L1230-L1260
    bioware_twoda_note: |
      Classic Aurora `.2da` wire layout: `formats/TwoDA/TwoDA.ksy`. GDA is a distinct GFF4 container (`G2DA` + `V0.1`/`V0.2`).
doc: |
  **GDA** (Dragon Age 2D array): **GFF4** stream with top-level FourCC **`G2DA`** and `type_version` `V0.1` / `V0.2`
  (`GDAFile::load` in xoreos). On-disk struct templates reuse imported **`gff::gff4_file`** from `formats/GFF/GFF.ksy`.

  G2DA column/row list field ids: `meta.xref.xoreos_gff4_g2da_fields`. Classic Aurora `.2da` binary: `formats/TwoDA/TwoDA.ksy`.

doc-ref:
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/gdafile.cpp#L275-L305 xoreos — GDAFile::load"

seq:
  - id: as_gff4
    type: gff::gff4_file
    doc: |
      On-disk bytes are a full GFF4 stream. Runtime check: `file_type` should equal `G2DA`
      (fourCC `0x47324441` as read by `readUint32BE` in xoreos `Header::read`).

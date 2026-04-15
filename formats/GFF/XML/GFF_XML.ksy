meta:
  id: gff_xml
  title: BioWare GFF XML Format
  license: MIT
  endian: le
  file-extension: gff.xml
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/XML interchange for GFF; not the binary parser path in k1_win_gog_swkotor.exe."
    wiki_gff_binary:
      gff: https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format
    pykotor:
      package: https://github.com/th3w1zard1/PyKotor/tree/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff
      io_gff_xml_reader_class_load: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L37-L75
      io_gff_xml_reader_load: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L61-L75
      io_gff_xml_field_dispatch: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L87-L166
      io_gff_xml_writer_write: https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L179-L188
    xoreos_tools:
      gffdumper_kgff_types_table: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffdumper.cpp#L36-L98
      gffdumper_identify_gff: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffdumper.cpp#L119-L161
      gffdumper_identify_factory: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffdumper.cpp#L163-L176
      gffcreator_create: https://github.com/th3w1zard1/xoreos-tools/blob/9ecd99facb6f3f9a1d4d96c5584add96a5f61800/src/xml/gffcreator.cpp#L43-L60
    legacy_k_gff_lucasforums_thread: https://www.lucasforumsarchive.com/thread/149407
    legacy_k_gff_deadly_stream_listing: https://deadlystream.com/files/file/719-k-gff/
    legacy_k_gff_deadly_stream_changelog: https://deadlystream.com/files/file/719-k-gff/?changelog=0
    legacy_k_gff_deadly_stream_changelog_1858: https://deadlystream.com/files/file/719-k-gff/?changelog=1858
    legacy_k_gff_deadly_stream_reviews: https://deadlystream.com/files/file/719-k-gff/?tab=reviews
doc: |
  **GFF XML** (tooling interchange): UTF-8 XML projection of **binary GFF3** data — retail games read **binary**
  GFF; this format is for editors, converters, and diffs. Root tag is typically **`gff3`** with nested `<struct>` /
  `<list>` / typed scalar tags matching PyKotor `io_gff_xml.py`.

  This `.ksy` stores the document as one opaque UTF-8 string — validate with a real XML parser.

  PyKotor reader/writer + xoreos-tools `gffdumper` / `gffcreator`: `meta.xref`. K-GFF editor history (vector/orientation
  pitfalls for `.git` / `.ifo`): `meta.xref` `legacy_k_gff_*`.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/GFF-File-Format PyKotor wiki — GFF (binary + tooling context)"
  - "https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L37-L188 PyKotor — GFFXMLReader / Writer"

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: |
      XML document as UTF-8 text. Typical PyKotor/xoreos shape: `<gff3><struct id="…">…</struct></gff3>`.
      This `.ksy` stores the payload as an opaque string; use a real XML parser for validation.
      PyKotor reader: [`GFFXMLReader.load` L61–L75](https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L61-L75); writer: [`GFFXMLWriter.write` L179–L188](https://github.com/th3w1zard1/PyKotor/blob/cfb5bb5070aff80ce9542f6968beb5fa5342bb33/Libraries/PyKotor/src/pykotor/resource/formats/gff/io_gff_xml.py#L179-L188).

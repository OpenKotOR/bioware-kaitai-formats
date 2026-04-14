meta:
  id: lip_xml
  title: BioWare LIP XML Format
  license: MIT
  endian: le
  file-extension: lip.xml
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/XML interchange for LIP; game loads binary LIP (see LIP.ksy)."
    pykotor_library_lip_binary: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip.py
    pykotor_library_lip_xml: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip_xml.py
    reone: https://github.com/seedhartha/reone/tree/master/src/libs/graphics/format/lipreader.cpp
    pykotor_wiki_lip: https://github.com/OldRepublicDevs/PyKotor/wiki/LIP-File-Format.md
    xoreos: https://github.com/xoreos/xoreos/tree/master/src/graphics/aurora/lipfile.cpp
doc: |
  LIP XML format is a human-readable XML representation of LIP (Lipsync) binary files.
  Provides easier editing than binary LIP format.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/lip.py
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip/io_lip_xml.py
  - https://github.com/seedhartha/reone/tree/master/src/libs/graphics/format/lipreader.cpp
  - https://github.com/OldRepublicDevs/PyKotor/wiki/LIP-File-Format.md
  - https://github.com/xoreos/xoreos/tree/master/src/graphics/aurora/lipfile.cpp

  - ../GFF/GFF
  - ../GFF/XML/GFF_XML
  - ../LIP/LIP

seq:
  - id: xml_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: XML document content as UTF-8 text


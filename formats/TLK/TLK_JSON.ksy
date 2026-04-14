meta:
  id: tlk_json
  title: BioWare TLK JSON Format
  license: MIT
  endian: le
  file-extension: tlk.json
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/JSON interchange for TLK; k1_win_gog_swkotor.exe reads binary .tlk (see TLK.ksy)."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/
    pykotor_wiki_tlk: https://github.com/OldRepublicDevs/PyKotor/wiki/TLK-File-Format.md
doc: |
  TLK JSON format is a human-readable JSON representation of TLK (Talk Table) binary files.
  Provides easier editing and translation than binary TLK format.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/tlk/io_tlk_xml.py

seq:
  - id: json_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: JSON document content as UTF-8 text


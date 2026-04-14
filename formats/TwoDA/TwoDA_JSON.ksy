meta:
  id: twoda_json
  title: BioWare TwoDA JSON Format
  license: MIT
  endian: le
  file-extension: 2da.json
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/JSON interchange for TwoDA; game loads .2da wire format (see TwoDA.ksy)."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/
    pykotor_wiki_twoda: https://github.com/OldRepublicDevs/PyKotor/wiki/TwoDA-File-Format.md
doc: |
  TwoDA JSON format is a human-readable JSON representation of TwoDA files.
  Provides easier editing and interoperability with modern tools than binary TwoDA format.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py

seq:
  - id: json_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: JSON document content as UTF-8 text


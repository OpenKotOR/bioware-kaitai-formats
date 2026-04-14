meta:
  id: twoda_csv
  title: BioWare TwoDA CSV Format
  license: MIT
  endian: le
  file-extension: 2da.csv
  encoding: UTF-8
  xref:
    ghidra_odyssey_k1:
      note: "Tooling/CSV interchange for TwoDA; game loads .2da wire format (see TwoDA.ksy)."
    pykotor: https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/
    pykotor_wiki_twoda: https://github.com/OldRepublicDevs/PyKotor/wiki/TwoDA-File-Format.md
doc: |
  TwoDA CSV format is a human-readable CSV (Comma-Separated Values) representation of TwoDA files.
  Provides easier editing in spreadsheet applications than binary TwoDA format.

  Each row represents a data row, with the first row containing column headers.

  References:
  - https://github.com/OldRepublicDevs/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py

seq:
  - id: csv_content
    type: str
    size-eos: true
    encoding: UTF-8
    doc: CSV text content with rows separated by newlines and columns by commas


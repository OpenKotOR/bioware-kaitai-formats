meta:
  id: twoda
  title: BioWare TwoDA (2D Array) File Format
  license: MIT
  endian: le
  file-extension:
    - 2da
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/twoda/
    github_openkotor_pykotor_io_twoda: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py`:
      binary magic **`2DA `** / **`V2.b`** **25–26**; **`TwoDABinaryReader.load`** **146–170**; **`TwoDABinaryWriter.write`** **204–238** (writer emits **`2DA V2.b`** then **newline** **204–207**); ASCII **`V2.0`** / CSV / JSON routed elsewhere **126–129**.
    github_openkotor_pykotor_twoda_data: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py`: binary vs ASCII note **8–47**; **`class TwoDA`** **68–114**.
    github_xoreos_2dafile: |
      https://github.com/xoreos/xoreos — `src/aurora/2dafile.cpp`: ids **`k2DAID` / `k2DAIDTab`** / versions **48–51**; **`TwoDAFile::load`** **145–172**;
      binary dispatch **`read2b`** **192–196**; V2.b helpers **`readHeaders2b`** **260–275**, **`skipRowNames2b`** **277–294**, **`readRows2b`** **296–336**; **`writeBinary`** **517–611**.
    xoreos_2dafile_magic_ids: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51
    xoreos_2dafile_load: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L145-L172
    xoreos_2dafile_read2b_binary: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L192-L336
    xoreos_2dafile_write_binary: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L517-L611
    xoreos_tools_convert2da_main: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/convert2da.cpp#L64-L86
    github_xoreos_tools_convert2da: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/convert2da.cpp#L64-L159
    github_xoreos_docs_2da_pdf: https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/2DA_Format.pdf
    github_modawan_reone_2dareader: |
      https://github.com/modawan/reone — `src/libs/resource/format/2dareader.cpp`: **`TwoDAReader::load`** **`2DA V2.b`** + newline + token reads **29–39**; **`loadRows`** uint16 offsets + **`dataSize`** + CString cells **41–66**.
    github_kobaltblu_kotor_js_twoda: https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/TwoDAObject.ts#L69-L155
    pykotor_wiki_twoda: https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format
doc: |
  TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
  including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
  
  TwoDA files are essentially two-dimensional arrays (tables) with:
  - Column headers (first row defines column names)
  - Row labels (first column defines row identifiers)
  - Cell values (data at row/column intersections)
  
  Binary Format Structure:
  - File Header (9 (0x9) bytes): Magic "2DA " (space-padded), version "V2.b", and newline
  - Column Headers Section: Tab-separated column names, terminated by null byte
  - Row Count (4 (0x4) bytes): uint32 indicating number of data rows
  - Row Labels Section: Tab-separated row labels (one per row)
  - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
  - Data Size (2 (0x2) bytes): uint16 indicating total size of cell data section
  - Cell Values Section: Null-terminated strings at offsets specified in offsets array
  
  The format uses an offset-based string table for cell values, allowing efficient
  storage of duplicate values (shared strings are stored once and referenced by offset).
  
  Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format PyKotor wiki — TwoDA"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238 PyKotor — `io_twoda` (binary `V2.b` + writer)"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114 PyKotor — `twoda_data` (model + ASCII/binary notes)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L48-L51 xoreos — `k2DAID` / `k2DAIDTab` + version tags"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L145-L172 xoreos — `TwoDAFile::load`"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L192-L336 xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`)"
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/2dafile.cpp#L517-L611 xoreos — `TwoDAFile::writeBinary`"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/convert2da.cpp#L64-L86 xoreos-tools — `convert2da` CLI (`main`)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/src/convert2da.cpp#L143-L159 xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/resource/format/2dareader.cpp#L29-L66 reone — `TwoDAReader`"
  - "https://github.com/KobaltBlu/KotOR.js/blob/83b27e2b4c61dfa6723e67995592c53ac88b21d9/src/resource/TwoDAObject.ts#L69-L155 KotOR.js — `TwoDAObject`"
  - "https://github.com/xoreos/xoreos-docs/blob/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware/2DA_Format.pdf xoreos-docs — 2DA_Format.pdf"

params:
  - id: column_count
    type: u4
    doc: |
      Number of tab-separated column headers in the file (excluding the trailing null terminator).
      Kaitai expressions cannot derive this from the header blob, so callers must pre-scan the
      column header section (same rule as PyKotor: count tab characters between the newline after
      V2.b and the first 0x00) and pass it into the parser.

seq:
  - id: header
    type: twoda_header
    doc: TwoDA file header (9 (0x9) bytes) - magic "2DA ", version "V2.b", and newline character
  
  - id: column_headers_raw
    type: strz
    encoding: ASCII
    doc: |
      Column headers section as a single null-terminated string.
      Contains tab-separated column names. The null terminator marks the end.
      Column names can be extracted by splitting on tab characters (0x09).
      Example: "col1\tcol2\tcol3\0" represents three columns: "col1", "col2", "col3"
  
  - id: row_count
    type: u4
    doc: |
      Number of data rows in the TwoDA table.
      This count determines how many row labels and how many cell entries per column.
  
  - id: row_labels_section
    type: row_labels_section
    doc: Row labels section - tab-separated row labels (one per row)
  
  - id: cell_offsets
    type: u2
    repeat: expr
    repeat-expr: row_count * column_count
    doc: |
      Array of cell value offsets (uint16 per cell). There are exactly row_count * column_count
      entries, in row-major order. Each offset is relative to the start of the cell values blob
      and points to a null-terminated string.
  
  - id: len_cell_values_section
    type: u2
    doc: |
      Total size in bytes of the cell values data section.
      This is the size of all unique cell value strings combined (including null terminators).
      Not used during reading but stored for format consistency.
  
  - id: cell_values_section
    type: cell_values_section
    size: len_cell_values_section
    doc: |
      Cell values data section containing all unique cell value strings.
      Each string is null-terminated. Offsets from cell_offsets point into this section.
      The section starts immediately after len_cell_values_section field and has size = len_cell_values_section bytes.

types:
  twoda_header:
    seq:
      - id: magic
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File type signature. Must be "2DA " (space-padded).
          Bytes: 0x32 0x44 0x41 0x20
          The space after "2DA" is significant and must be present.
      
      - id: version
        type: str
        encoding: ASCII
        size: 4
        doc: |
          File format version. Always "V2.b" for KotOR/TSL TwoDA files.
          Bytes: 0x56 0x32 0x2E 0x62
          This is the binary version identifier (V2.b = Version 2 binary).
      
      - id: newline
        type: u1
        doc: |
          Newline character (0x0A = '\n').
          Separates header from column headers section.
    
    instances:
      is_valid_twoda:
        value: magic == "2DA " and version == "V2.b" and newline == 0x0A
        doc: |
          Validation check that the file is a valid TwoDA file.
          All header fields must match expected values.

  row_labels_section:
    seq:
      - id: labels
        type: row_label_entry
        repeat: expr
        repeat-expr: _root.row_count
        doc: |
          Array of row label entries, one per row.
          Each label is terminated by tab character (0x09).
          Total count equals row_count from the header.
          Row labels typically identify each data row (e.g., numeric IDs, names, etc.).

  row_label_entry:
    seq:
      - id: label_value
        type: str
        encoding: ASCII
        terminator: 0x09
        include: false
        consume: true
        eos-error: false
        doc: |
          Row label value (ASCII string terminated by tab character 0x09).
          Tab terminator is consumed but not included in the string value.
          Row labels uniquely identify each row in the table.
          Often numeric (e.g., "0", "1", "2") but can be any string identifier.

  cell_values_section:
    seq:
      - id: raw_data
        type: str
        encoding: ASCII
        size: _root.len_cell_values_section
        doc: |
          Raw cell values data as a single string.
          Contains all null-terminated cell value strings concatenated together.
          Individual strings can be extracted using offsets from cell_offsets.
          Note: To read a specific cell value, seek to (cell_values_section start + offset) and read a null-terminated string.

# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Twoda(KaitaiStruct):
    """TwoDA (2D Array) files store tabular data in a binary format used by BioWare games
    including Knights of the Old Republic (KotOR) and The Sith Lords (TSL).
    
    TwoDA files are essentially two-dimensional arrays (tables) with:
    - Column headers (first row defines column names)
    - Row labels (first column defines row identifiers)
    - Cell values (data at row/column intersections)
    
    Binary Format Structure:
    - File Header (9 bytes): Magic "2DA " (space-padded), version "V2.b", and newline
    - Column Headers Section: Tab-separated column names, terminated by null byte
    - Row Count (4 bytes): uint32 indicating number of data rows
    - Row Labels Section: Tab-separated row labels (one per row)
    - Cell Offsets Array: Array of uint16 offsets (rowCount * columnCount entries)
    - Data Size (2 bytes): uint16 indicating total size of cell data section
    - Cell Values Section: Null-terminated strings at offsets specified in offsets array
    
    The format uses an offset-based string table for cell values, allowing efficient
    storage of duplicate values (shared strings are stored once and referenced by offset).
    
    Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_twoda` / `twoda_data`, xoreos `TwoDAFile`, xoreos-tools `convert2da`, reone `TwoDAReader`, KotOR.js `TwoDAObject`).
    
    .. seealso::
       PyKotor wiki — TwoDA - https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format
    
    
    .. seealso::
       PyKotor — `io_twoda` (binary `V2.b` + writer) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/io_twoda.py#L25-L238
    
    
    .. seealso::
       PyKotor — `twoda_data` (model + ASCII/binary notes) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/twoda/twoda_data.py#L8-L114
    
    
    .. seealso::
       xoreos — `k2DAID` / `k2DAIDTab` + version tags - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L48-L51
    
    
    .. seealso::
       xoreos — `TwoDAFile::load` - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L145-L172
    
    
    .. seealso::
       xoreos — binary `V2.b` (`read2b` + `readHeaders2b` / `skipRowNames2b` / `readRows2b`) - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L192-L336
    
    
    .. seealso::
       xoreos — `TwoDAFile::writeBinary` - https://github.com/xoreos/xoreos/blob/master/src/aurora/2dafile.cpp#L517-L611
    
    
    .. seealso::
       xoreos-tools — `convert2da` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L64-L86
    
    
    .. seealso::
       xoreos-tools — `get2DAGDA` / `TwoDAFile` dispatch - https://github.com/xoreos/xoreos-tools/blob/master/src/convert2da.cpp#L143-L159
    
    
    .. seealso::
       reone — `TwoDAReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/2dareader.cpp#L29-L66
    
    
    .. seealso::
       KotOR.js — `TwoDAObject` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/TwoDAObject.ts#L69-L155
    
    
    .. seealso::
       xoreos-docs — 2DA_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf
    """
    def __init__(self, column_count, _io, _parent=None, _root=None):
        super(Twoda, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self.column_count = column_count
        self._read()

    def _read(self):
        self.header = Twoda.TwodaHeader(self._io, self, self._root)
        self.column_headers_raw = (self._io.read_bytes_term(0, False, True, True)).decode(u"ASCII")
        self.row_count = self._io.read_u4le()
        self.row_labels_section = Twoda.RowLabelsSection(self._io, self, self._root)
        self.cell_offsets = []
        for i in range(self.row_count * self.column_count):
            self.cell_offsets.append(self._io.read_u2le())

        self.len_cell_values_section = self._io.read_u2le()
        self._raw_cell_values_section = self._io.read_bytes(self.len_cell_values_section)
        _io__raw_cell_values_section = KaitaiStream(BytesIO(self._raw_cell_values_section))
        self.cell_values_section = Twoda.CellValuesSection(_io__raw_cell_values_section, self, self._root)


    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        self.row_labels_section._fetch_instances()
        for i in range(len(self.cell_offsets)):
            pass

        self.cell_values_section._fetch_instances()

    class CellValuesSection(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Twoda.CellValuesSection, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.raw_data = (self._io.read_bytes(self._root.len_cell_values_section)).decode(u"ASCII")


        def _fetch_instances(self):
            pass


    class RowLabelEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Twoda.RowLabelEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.label_value = (self._io.read_bytes_term(9, False, True, False)).decode(u"ASCII")


        def _fetch_instances(self):
            pass


    class RowLabelsSection(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Twoda.RowLabelsSection, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.labels = []
            for i in range(self._root.row_count):
                self.labels.append(Twoda.RowLabelEntry(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.labels)):
                pass
                self.labels[i]._fetch_instances()



    class TwodaHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Twoda.TwodaHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.magic = (self._io.read_bytes(4)).decode(u"ASCII")
            self.version = (self._io.read_bytes(4)).decode(u"ASCII")
            self.newline = self._io.read_u1()


        def _fetch_instances(self):
            pass

        @property
        def is_valid_twoda(self):
            """Validation check that the file is a valid TwoDA file.
            All header fields must match expected values.
            """
            if hasattr(self, '_m_is_valid_twoda'):
                return self._m_is_valid_twoda

            self._m_is_valid_twoda =  ((self.magic == u"2DA ") and (self.version == u"V2.b") and (self.newline == 10)) 
            return getattr(self, '_m_is_valid_twoda', None)




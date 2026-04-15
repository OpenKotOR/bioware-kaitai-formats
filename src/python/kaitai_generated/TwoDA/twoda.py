# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Twoda(KaitaiStruct):
    """**TwoDA** (`.2da`): BioWare binary table — magic `2DA ` + `V2.b` line, tabbed column header row, `u4` row count,
    tabbed row labels, `u16` cell offset grid, `u16` data blob size, then deduped null-terminated cell strings.
    
    `column_count` is a **parameter** (Kaitai cannot derive it from the header blob); callers pre-scan tabs like PyKotor.
    
    Readers / GDA cousin: `meta.xref`.
    
    .. seealso::
       PyKotor wiki — TwoDA - https://github.com/OpenKotOR/PyKotor/wiki/2DA-File-Format
    
    
    .. seealso::
       xoreos — TwoDA::load - https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/2dafile.cpp#L145-L172
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




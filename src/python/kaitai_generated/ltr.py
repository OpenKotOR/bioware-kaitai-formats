# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class Ltr(KaitaiStruct):
    """**LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
    `letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
    `bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).
    
    .. seealso::
       PyKotor wiki — LTR - https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format
    
    
    .. seealso::
       PyKotor — `io_ltr` reader/writer (start of `write`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155
    
    
    .. seealso::
       xoreos — `kFileTypeLTR` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101
    
    
    .. seealso::
       xoreos — `LTRFile::readLetterSet` - https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L121-L133
    
    
    .. seealso::
       xoreos — `LTRFile::load` - https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168
    
    
    .. seealso::
       reone — `LtrReader::load` + `readLetterSet` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/ltrreader.cpp#L27-L74
    
    
    .. seealso::
       KotOR.js — `LTRObject.readBuffer` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LTRObject.ts#L51-L122
    
    
    .. seealso::
       xoreos-docs — BioWare specs tree (no dedicated LTR Torlack page; use `ltrfile.cpp` + PyKotor) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """
    def __init__(self, _io, _parent=None, _root=None):
        super(Ltr, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        self.letter_count = KaitaiStream.resolve_enum(bioware_common.BiowareCommon.BiowareLtrAlphabetLength, self._io.read_u1())
        self.single_letter_block = Ltr.LetterBlock(self._io, self, self._root)
        self.double_letter_blocks = Ltr.DoubleLetterBlocksArray(self._io, self, self._root)
        self.triple_letter_blocks = Ltr.TripleLetterBlocksArray(self._io, self, self._root)


    def _fetch_instances(self):
        pass
        self.single_letter_block._fetch_instances()
        self.double_letter_blocks._fetch_instances()
        self.triple_letter_blocks._fetch_instances()

    class DoubleLetterBlocksArray(KaitaiStruct):
        """Array of double-letter blocks. One block per character in the alphabet.
        Each block is indexed by the previous character (context length 1).
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Ltr.DoubleLetterBlocksArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.blocks = []
            for i in range(int(self._root.letter_count)):
                self.blocks.append(Ltr.LetterBlock(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.blocks)):
                pass
                self.blocks[i]._fetch_instances()



    class LetterBlock(KaitaiStruct):
        """A probability block containing three arrays of probabilities (start, middle, end).
        Each array has letter_count floats representing cumulative probabilities for each character
        in the alphabet appearing at that position (start, middle, or end of name).
        
        Blocks store cumulative probabilities (monotonically increasing floats) that are compared
        against random roll values during name generation.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Ltr.LetterBlock, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.start_probabilities = []
            for i in range(int(self._root.letter_count)):
                self.start_probabilities.append(self._io.read_f4le())

            self.middle_probabilities = []
            for i in range(int(self._root.letter_count)):
                self.middle_probabilities.append(self._io.read_f4le())

            self.end_probabilities = []
            for i in range(int(self._root.letter_count)):
                self.end_probabilities.append(self._io.read_f4le())



        def _fetch_instances(self):
            pass
            for i in range(len(self.start_probabilities)):
                pass

            for i in range(len(self.middle_probabilities)):
                pass

            for i in range(len(self.end_probabilities)):
                pass



    class TripleLetterBlocksArray(KaitaiStruct):
        """Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
        Each block is indexed by the previous two characters (context length 2).
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Ltr.TripleLetterBlocksArray, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.rows = []
            for i in range(int(self._root.letter_count)):
                self.rows.append(Ltr.TripleLetterRow(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.rows)):
                pass
                self.rows[i]._fetch_instances()



    class TripleLetterRow(KaitaiStruct):
        """A row in the triple-letter blocks array. Contains letter_count blocks,
        each indexed by the last character in the two-character context.
        """
        def __init__(self, _io, _parent=None, _root=None):
            super(Ltr.TripleLetterRow, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.blocks = []
            for i in range(int(self._root.letter_count)):
                self.blocks.append(Ltr.LetterBlock(self._io, self, self._root))



        def _fetch_instances(self):
            pass
            for i in range(len(self.blocks)):
                pass
                self.blocks[i]._fetch_instances()





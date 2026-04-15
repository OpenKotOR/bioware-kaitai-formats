# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
import bioware_ncs_common


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class NcsMinimal(KaitaiStruct):
    def __init__(self, _io, _parent=None, _root=None):
        super(NcsMinimal, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode(u"ASCII")
        self.file_version = (self._io.read_bytes(4)).decode(u"ASCII")
        self.size_marker = KaitaiStream.resolve_enum(bioware_ncs_common.BiowareNcsCommon.NcsProgramSizeMarker, self._io.read_u1())
        self.total_file_size = self._io.read_u4be()
        self.instructions = []
        i = 0
        while True:
            _ = NcsMinimal.Instruction(self._io, self, self._root)
            self.instructions.append(_)
            if self._io.pos() >= self._root.total_file_size:
                break
            i += 1


    def _fetch_instances(self):
        pass
        for i in range(len(self.instructions)):
            pass
            self.instructions[i]._fetch_instances()


    class Instruction(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(NcsMinimal.Instruction, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.bytecode = KaitaiStream.resolve_enum(bioware_ncs_common.BiowareNcsCommon.NcsBytecode, self._io.read_u1())
            self.qualifier = KaitaiStream.resolve_enum(bioware_ncs_common.BiowareNcsCommon.NcsInstructionQualifier, self._io.read_u1())


        def _fetch_instances(self):
            pass




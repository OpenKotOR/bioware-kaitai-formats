# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import bioware_ncs_common


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Ncs(KaitaiStruct):
    """NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
    Scripts run inside a stack-based virtual machine shared across Aurora engine games.

    Format Structure:
    - Header (13 bytes): Signature "NCS ", version "V1.0", size marker (0x42), file size
    - Instruction Stream: Sequence of bytecode instructions

    All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).

    NWScript **source** (`.nss`) is plaintext tooling; it is intentionally not modeled as Kaitai in this repository
    (see `AGENTS.md`). This spec covers the **binary** `.ncs` wire format only.

    Opcode / qualifier enumerations: imported from `formats/Common/bioware_ncs_common.ksy` (mirrors PyKotor `ncs_data.py`).

    Authoritative parsers and notes: `meta.xref` and `doc-ref` (PyKotor, xoreos, xoreos-tools, xoreos-docs Torlack, reone).

    .. seealso::
       PyKotor wiki — NCS - https://github.com/OpenKotOR/PyKotor/wiki/NCS-File-Format


    .. seealso::
       PyKotor — compiled script load path - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/io_ncs.py#L60-L90


    .. seealso::
       xoreos — NCSFile::load - https://github.com/xoreos/xoreos/blob/master/src/aurora/nwscript/ncsfile.cpp#L333-L355


    .. seealso::
       xoreos-tools — NCSFile::load - https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137


    .. seealso::
       xoreos-docs — Torlack ncs.html - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html


    .. seealso::
       reone — NcsReader::load - https://github.com/modawan/reone/blob/master/src/libs/script/format/ncsreader.cpp#L28-L40


    .. seealso::
       PyKotor — NCSByteCode / NCSInstructionQualifier (shared .ksy enums) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ncs/ncs_data.py#L69-L140
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Ncs, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.file_type = (self._io.read_bytes(4)).decode("ASCII")
        if not self.file_type == "NCS ":
            raise kaitaistruct.ValidationNotEqualError(
                "NCS ", self.file_type, self._io, "/seq/0"
            )
        self.file_version = (self._io.read_bytes(4)).decode("ASCII")
        if not self.file_version == "V1.0":
            raise kaitaistruct.ValidationNotEqualError(
                "V1.0", self.file_version, self._io, "/seq/1"
            )
        self.size_marker = self._io.read_u1()
        if not self.size_marker == 66:
            raise kaitaistruct.ValidationNotEqualError(
                66, self.size_marker, self._io, "/seq/2"
            )
        self.file_size = self._io.read_u4be()
        self.instructions = []
        i = 0
        while True:
            _ = Ncs.Instruction(self._io, self, self._root)
            self.instructions.append(_)
            if self._io.pos() >= self.file_size:
                break
            i += 1

    def _fetch_instances(self):
        pass
        for i in range(len(self.instructions)):
            pass
            self.instructions[i]._fetch_instances()

    class Instruction(KaitaiStruct):
        """NWScript bytecode instruction.
        Format: <opcode: uint8> <qualifier: uint8> <arguments: variable>

        Instruction size varies by opcode:
        - Base: 2 bytes (opcode + qualifier)
        - Arguments: 0 to variable bytes depending on instruction type

        Common instruction types:
        - Constants: CONSTI (6B), CONSTF (6B), CONSTS (2+N B), CONSTO (6B)
        - Stack ops: CPDOWNSP, CPTOPSP, MOVSP (variable size)
        - Arithmetic: ADDxx, SUBxx, MULxx, DIVxx (2B)
        - Control flow: JMP, JSR, JZ, JNZ (6B), RETN (2B)
        - Function calls: ACTION (5B)
        - And many more (see NCS format documentation)
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Ncs.Instruction, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.opcode = KaitaiStream.resolve_enum(
                bioware_ncs_common.BiowareNcsCommon.NcsBytecode, self._io.read_u1()
            )
            self.qualifier = KaitaiStream.resolve_enum(
                bioware_ncs_common.BiowareNcsCommon.NcsInstructionQualifier,
                self._io.read_u1(),
            )
            self.arguments = []
            i = 0
            while True:
                _ = self._io.read_u1()
                self.arguments.append(_)
                if self._io.pos() >= self._io.size():
                    break
                i += 1

        def _fetch_instances(self):
            pass
            for i in range(len(self.arguments)):
                pass

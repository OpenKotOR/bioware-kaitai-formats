# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareNcsCommon(KaitaiStruct):
    """Shared **opcode** (`u1`) and **type qualifier** (`u1`) bytes for NWScript compiled scripts (`NCS`).
    
    - `ncs_bytecode` mirrors PyKotor `NCSByteCode` (`ncs_data.py`). Value `0x1C` is unused on the wire
      (gap between `MOVSP` and `JMP` in Aurora bytecode tables).
    - `ncs_instruction_qualifier` mirrors PyKotor `NCSInstructionQualifier` for the second byte of each
      decoded instruction (`CONSTx`, `RSADDx`, `ADDxx`, … families dispatch on this value).
    - `ncs_program_size_marker` is the fixed header byte after `"V1.0"` in retail KotOR NCS blobs (`0x42`).
    
    **Lowest-scope authority:** numeric tables live here; `formats/NSS/NCS*.ksy` cite this file instead of
    duplicating opcode lists.
    """

    class NcsBytecode(IntEnum):
        reserved_bc = 0
        cpdownsp = 1
        rsaddx = 2
        cptopsp = 3
        constx = 4
        action = 5
        logandxx = 6
        logorxx = 7
        incorxx = 8
        excorxx = 9
        boolandxx = 10
        equalxx = 11
        nequalxx = 12
        geqxx = 13
        gtxx = 14
        ltxx = 15
        leqxx = 16
        shleftxx = 17
        shrightxx = 18
        ushrightxx = 19
        addxx = 20
        subxx = 21
        mulxx = 22
        divxx = 23
        modxx = 24
        negx = 25
        compx = 26
        movsp = 27
        unused_gap = 28
        jmp = 29
        jsr = 30
        jz = 31
        retn = 32
        destruct = 33
        notx = 34
        decxsp = 35
        incxsp = 36
        jnz = 37
        cpdownbp = 38
        cptopbp = 39
        decxbp = 40
        incxbp = 41
        savebp = 42
        restorebp = 43
        store_state = 44
        nop = 45

    class NcsInstructionQualifier(IntEnum):
        none = 0
        unary_operand_layout = 1
        int_type = 3
        float_type = 4
        string_type = 5
        object_type = 6
        effect_type = 16
        event_type = 17
        location_type = 18
        talent_type = 19
        int_int = 32
        float_float = 33
        object_object = 34
        string_string = 35
        struct_struct = 36
        int_float = 37
        float_int = 38
        effect_effect = 48
        event_event = 49
        location_location = 50
        talent_talent = 51
        vector_vector = 58
        vector_float = 59
        float_vector = 60

    class NcsProgramSizeMarker(IntEnum):
        program_size_prefix = 66
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareNcsCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Nss(KaitaiStruct):
    """NSS (NWScript Source) files contain human-readable NWScript source code
    that compiles to NCS bytecode. NWScript is the scripting language used
    in KotOR, TSL, and Neverwinter Nights.

    NSS files are plain text files (typically Windows-1252 or UTF-8 encoding)
    containing NWScript source code. The nwscript.nss file defines all
    engine-exposed functions and constants available to scripts.

    Format:
    - Plain text source code
    - May include BOM (Byte Order Mark) for UTF-8 files
    - Lines are typically terminated with CRLF (\r\n) or LF (\n)
    - Comments: // for single-line, /* */ for multi-line
    - Preprocessor directives: #include, #define, etc.

    Authoritative links: `meta.doc-ref` (PyKotor wiki, xoreos `types.h` `kFileTypeNSS`, xoreos-tools `NCSFile`, reone `NssWriter`).

    .. seealso::
       PyKotor wiki — NSS - https://github.com/OpenKotOR/PyKotor/wiki/NSS-File-Format


    .. seealso::
       xoreos — `kFileTypeNSS` / `kFileTypeNCS` (Aurora `FileType` IDs; NSS plaintext, NCS bytecode) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L85-L86


    .. seealso::
       xoreos-tools — `NCSFile` - https://github.com/xoreos/xoreos-tools/blob/master/src/nwscript/ncsfile.cpp#L106-L137


    .. seealso::
       reone — `NssWriter::save` - https://github.com/modawan/reone/blob/master/src/libs/tools/script/format/nsswriter.cpp#L33-L45


    .. seealso::
       xoreos-docs — Torlack NCS (bytecode companion to plaintext NSS) - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/ncs.html


    .. seealso::
       xoreos-docs — BioWare specs tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Nss, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        if self._io.pos() == 0:
            pass
            self.bom = self._io.read_u2le()
            if not ((self.bom == 65279) or (self.bom == 0)):
                raise kaitaistruct.ValidationNotAnyOfError(self.bom, self._io, "/seq/0")

        self.source_code = (self._io.read_bytes_full()).decode("UTF-8")

    def _fetch_instances(self):
        pass
        if self._io.pos() == 0:
            pass

    class NssSource(KaitaiStruct):
        """NWScript source code structure.
        This is primarily a text format, so the main content is the source_code string.

        The source can be parsed into:
        - Tokens (keywords, identifiers, operators, literals)
        - Statements (declarations, assignments, control flow)
        - Functions (definitions with parameters and body)
        - Preprocessor directives (#include, #define)
        """

        def __init__(self, _io, _parent=None, _root=None):
            super(Nss.NssSource, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.content = (self._io.read_bytes_full()).decode("UTF-8")

        def _fetch_instances(self):
            pass

# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct
from enum import IntEnum


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class BiowareTslpatcherCommon(KaitaiStruct):
    """Shared enums and small helper types used by TSLPatcher-style tooling.

    Notes:
    - Several upstream enums are string-valued (Python `Enum` of strings). Kaitai enums are numeric,
      so string-valued enums are modeled here as small string wrapper types with `valid` constraints.

    References:
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py
    - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py

    .. seealso::
       xoreos — `FileType` enum start (engine archive IDs; TSLPatcher enums here are community patch metadata, not read from `swkotor.exe`) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L53-L60


    .. seealso::
       PyKotor — `ModInstaller` (apply / backup entry band) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/patcher.py#L43-L120


    .. seealso::
       PyKotor — `memory` (patch address space / token helpers) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/memory.py#L1-L80


    .. seealso::
       PyKotor — `tslpatcher/` package - https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/tslpatcher/


    .. seealso::
       PyKotor — TwoDA patch helpers - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/twoda.py


    .. seealso::
       PyKotor — NCS patch helpers - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/mods/ncs.py


    .. seealso::
       PyKotor — TSLPatcher logging - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/logger.py


    .. seealso::
       PyKotor — diff resource objects - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/tslpatcher/diff/objects.py


    .. seealso::
       xoreos-docs — BioWare specs tree (TSLPatcher metadata; no dedicated PDF) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    class BiowareTslpatcherLogTypeId(IntEnum):
        verbose = 0
        note = 1
        warning = 2
        error = 3

    class BiowareTslpatcherTargetTypeId(IntEnum):
        row_index = 0
        row_label = 1
        label_column = 2

    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareTslpatcherCommon, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass

    def _fetch_instances(self):
        pass

    class BiowareDiffFormatStr(KaitaiStruct):
        """String-valued enum equivalent for DiffFormat (null-terminated ASCII)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareTslpatcherCommon.BiowareDiffFormatStr, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(0, False, True, True)).decode(
                "ASCII"
            )
            if not (
                (self.value == "default")
                or (self.value == "unified")
                or (self.value == "context")
                or (self.value == "side_by_side")
            ):
                raise kaitaistruct.ValidationNotAnyOfError(
                    self.value, self._io, "/types/bioware_diff_format_str/seq/0"
                )

        def _fetch_instances(self):
            pass

    class BiowareDiffResourceTypeStr(KaitaiStruct):
        """String-valued enum equivalent for DiffResourceType (null-terminated ASCII)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareTslpatcherCommon.BiowareDiffResourceTypeStr, self).__init__(
                _io
            )
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(0, False, True, True)).decode(
                "ASCII"
            )
            if not (
                (self.value == "gff")
                or (self.value == "2da")
                or (self.value == "tlk")
                or (self.value == "lip")
                or (self.value == "bytes")
            ):
                raise kaitaistruct.ValidationNotAnyOfError(
                    self.value, self._io, "/types/bioware_diff_resource_type_str/seq/0"
                )

        def _fetch_instances(self):
            pass

    class BiowareDiffTypeStr(KaitaiStruct):
        """String-valued enum equivalent for DiffType (null-terminated ASCII)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareTslpatcherCommon.BiowareDiffTypeStr, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(0, False, True, True)).decode(
                "ASCII"
            )
            if not (
                (self.value == "identical")
                or (self.value == "modified")
                or (self.value == "added")
                or (self.value == "removed")
                or (self.value == "error")
            ):
                raise kaitaistruct.ValidationNotAnyOfError(
                    self.value, self._io, "/types/bioware_diff_type_str/seq/0"
                )

        def _fetch_instances(self):
            pass

    class BiowareNcsTokenTypeStr(KaitaiStruct):
        """String-valued enum equivalent for NCSTokenType (null-terminated ASCII)."""

        def __init__(self, _io, _parent=None, _root=None):
            super(BiowareTslpatcherCommon.BiowareNcsTokenTypeStr, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.value = (self._io.read_bytes_term(0, False, True, True)).decode(
                "ASCII"
            )
            if not (
                (self.value == "strref")
                or (self.value == "strref32")
                or (self.value == "2damemory")
                or (self.value == "2damemory32")
                or (self.value == "uint32")
                or (self.value == "uint16")
                or (self.value == "uint8")
            ):
                raise kaitaistruct.ValidationNotAnyOfError(
                    self.value, self._io, "/types/bioware_ncs_token_type_str/seq/0"
                )

        def _fetch_instances(self):
            pass

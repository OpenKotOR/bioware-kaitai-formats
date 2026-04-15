# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Das(KaitaiStruct):
    """**DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
    tagged blocks. **Not KotOR** — reference serializers live under **Andastra** `Game/Games/Eclipse/...` on GitHub (`meta.xref`), not `Runtime/...`.

    .. seealso::
       xoreos — `GameID` (`kGameIDDragonAge` = 7) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408


    .. seealso::
       Andastra — `DragonAgeOriginsSaveSerializer` (signature + nfo + archive entrypoints) - https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs#L23-L180


    .. seealso::
       Andastra — `EclipseSaveSerializer` string + metadata helpers - https://github.com/OldRepublicDevs/Andastra/blob/master/src/Andastra/Game/Games/Eclipse/Save/EclipseSaveSerializer.cs#L35-L126


    .. seealso::
       xoreos-docs — BioWare specs tree (DAO saves via Andastra; no DAS-specific PDF here) - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Das, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.signature = (self._io.read_bytes(4)).decode("ASCII")
        if not self.signature == "DAS ":
            raise kaitaistruct.ValidationNotEqualError(
                "DAS ", self.signature, self._io, "/seq/0"
            )
        self.version = self._io.read_s4le()
        if not self.version == 1:
            raise kaitaistruct.ValidationNotEqualError(
                1, self.version, self._io, "/seq/1"
            )
        self.save_name = Das.LengthPrefixedString(self._io, self, self._root)
        self.module_name = Das.LengthPrefixedString(self._io, self, self._root)
        self.area_name = Das.LengthPrefixedString(self._io, self, self._root)
        self.time_played_seconds = self._io.read_s4le()
        self.timestamp_filetime = self._io.read_s8le()
        self.num_screenshot_data = self._io.read_s4le()
        if self.num_screenshot_data > 0:
            pass
            self.screenshot_data = []
            for i in range(self.num_screenshot_data):
                self.screenshot_data.append(self._io.read_u1())

        self.num_portrait_data = self._io.read_s4le()
        if self.num_portrait_data > 0:
            pass
            self.portrait_data = []
            for i in range(self.num_portrait_data):
                self.portrait_data.append(self._io.read_u1())

        self.player_name = Das.LengthPrefixedString(self._io, self, self._root)
        self.party_member_count = self._io.read_s4le()
        self.player_level = self._io.read_s4le()

    def _fetch_instances(self):
        pass
        self.save_name._fetch_instances()
        self.module_name._fetch_instances()
        self.area_name._fetch_instances()
        if self.num_screenshot_data > 0:
            pass
            for i in range(len(self.screenshot_data)):
                pass

        if self.num_portrait_data > 0:
            pass
            for i in range(len(self.portrait_data)):
                pass

        self.player_name._fetch_instances()

    class LengthPrefixedString(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Das.LengthPrefixedString, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.length = self._io.read_s4le()
            self.value = (
                KaitaiStream.bytes_terminate(self._io.read_bytes(self.length), 0, False)
            ).decode("UTF-8")

        def _fetch_instances(self):
            pass

        @property
        def value_trimmed(self):
            """String value.
            Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.
            """
            if hasattr(self, "_m_value_trimmed"):
                return self._m_value_trimmed

            self._m_value_trimmed = self.value
            return getattr(self, "_m_value_trimmed", None)

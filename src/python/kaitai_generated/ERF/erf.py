# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream
import bioware_type_ids


if getattr(kaitaistruct, "API_VERSION", (0, 9)) < (0, 11):
    raise Exception(
        "Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s"
        % (kaitaistruct.__version__)
    )


class Erf(KaitaiStruct):
    """ERF (Encapsulated Resource File) files are self-contained archives used for modules, save games,
    texture packs, and hak paks. Unlike BIF files which require a KEY file for filename lookups,
    ERF files store both resource names (ResRefs) and data in the same file. They also support
    localized strings for descriptions in multiple languages.

    Format Variants:
    - ERF: Generic encapsulated resource file (texture packs, etc.)
    - HAK: Hak pak file (contains override resources). Used for mod content distribution
    - MOD: Module file (game areas/levels). Contains area resources, scripts, and module-specific data
    - SAV: Save game file (contains saved game state). Uses MOD signature but typically has `description_strref == 0`

    All variants use the same binary format structure, differing only in the file type signature.

    Archive `resource_type` values use the shared **`bioware_type_ids::xoreos_file_type_id`** enum (xoreos `FileType`); see `formats/Common/bioware_type_ids.ksy`.

    Binary Format Structure:
    - Header (160 bytes): File type, version, entry counts, offsets, build date, description
    - Localized String List (optional, variable size): Multi-language descriptions. MOD files may
      include localized module names for the load screen. Each entry contains language_id (u4),
      string_size (u4), and string_data (UTF-8 encoded text)
    - Key List (24 bytes per entry): ResRef to resource index mapping. Each entry contains:
      - resref (16 bytes, ASCII, null-padded): Resource filename
      - resource_id (u4): Index into resource_list
      - resource_type (u2): Resource type identifier (`bioware_type_ids::xoreos_file_type_id`, xoreos `FileType`)
      - unused (u2): Padding/unused field (typically 0)
    - Resource List (8 bytes per entry): Resource offset and size. Each entry contains:
      - offset_to_data (u4): Byte offset to resource data from beginning of file
      - len_data (u4): Uncompressed size of resource data in bytes (Kaitai id for byte size of `data`)
    - Resource Data (variable size): Raw binary data for each resource, stored at offsets specified
      in resource_list

    File Access Pattern:
    1. Read header to get entry_count and offsets
    2. Read key_list to map ResRefs to resource_ids
    3. Use resource_id to index into resource_list
    4. Read resource data from offset_to_data with byte length len_data

    Authoritative index: `meta.xref` and `doc-ref` (PyKotor `io_erf` / `erf_data`, xoreos `ERFFile`, xoreos-tools `unerf` / `erf`, reone `ErfReader`, KotOR.js `ERFObject`, NickHugi `Kotor.NET/Formats/KotorERF`).

    .. seealso::
       PyKotor wiki — ERF - https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#erf


    .. seealso::
       PyKotor wiki — Aurora ERF notes - https://github.com/OpenKotOR/PyKotor/wiki/Bioware-Aurora-Core-Formats#erf


    .. seealso::
       PyKotor — `io_erf` (Kaitai + legacy + `ERFBinaryWriter.write`) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/io_erf.py#L22-L316


    .. seealso::
       PyKotor — `ERFType` + `ERF` model (opening) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/erf/erf_data.py#L91-L130


    .. seealso::
       xoreos — ERF type tags + `ERFFile::load` + `readV10Header` start - https://github.com/xoreos/xoreos/blob/master/src/aurora/erffile.cpp#L50-L335


    .. seealso::
       xoreos-tools — `unerf` CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/unerf.cpp#L69-L106


    .. seealso::
       xoreos-tools — `erf` packer CLI (`main`) - https://github.com/xoreos/xoreos-tools/blob/master/src/erf.cpp#L49-L96


    .. seealso::
       xoreos-docs — Torlack mod.html - https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/mod.html


    .. seealso::
       reone — `ErfReader` - https://github.com/modawan/reone/blob/master/src/libs/resource/format/erfreader.cpp#L26-L92


    .. seealso::
       KotOR.js — `ERFObject` - https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/ERFObject.ts#L70-L115


    .. seealso::
       NickHugi/Kotor.NET — `ERFBinaryStructure` - https://github.com/NickHugi/Kotor.NET/blob/master/Kotor.NET/Formats/KotorERF/ERFBinaryStructure.cs


    .. seealso::
       xoreos-docs — ERF_Format.pdf - https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/ERF_Format.pdf


    .. seealso::
       xoreos — `enum FileType` (numeric IDs in KEY/ERF/RIM tables) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L394


    .. seealso::
       PyKotor — `ResourceType` (tooling superset; overlaps FileType for KotOR rows) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py
    """

    def __init__(self, _io, _parent=None, _root=None):
        super(Erf, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        self.header = Erf.ErfHeader(self._io, self, self._root)

    def _fetch_instances(self):
        pass
        self.header._fetch_instances()
        _ = self.key_list
        if hasattr(self, "_m_key_list"):
            pass
            self._m_key_list._fetch_instances()

        _ = self.localized_string_list
        if hasattr(self, "_m_localized_string_list"):
            pass
            self._m_localized_string_list._fetch_instances()

        _ = self.resource_list
        if hasattr(self, "_m_resource_list"):
            pass
            self._m_resource_list._fetch_instances()

    class ErfHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ErfHeader, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.file_type = (self._io.read_bytes(4)).decode("ASCII")
            if not (
                (self.file_type == "ERF ")
                or (self.file_type == "MOD ")
                or (self.file_type == "SAV ")
                or (self.file_type == "HAK ")
            ):
                raise kaitaistruct.ValidationNotAnyOfError(
                    self.file_type, self._io, "/types/erf_header/seq/0"
                )
            self.file_version = (self._io.read_bytes(4)).decode("ASCII")
            if not self.file_version == "V1.0":
                raise kaitaistruct.ValidationNotEqualError(
                    "V1.0", self.file_version, self._io, "/types/erf_header/seq/1"
                )
            self.language_count = self._io.read_u4le()
            self.localized_string_size = self._io.read_u4le()
            self.entry_count = self._io.read_u4le()
            self.offset_to_localized_string_list = self._io.read_u4le()
            self.offset_to_key_list = self._io.read_u4le()
            self.offset_to_resource_list = self._io.read_u4le()
            self.build_year = self._io.read_u4le()
            self.build_day = self._io.read_u4le()
            self.description_strref = self._io.read_s4le()
            self.reserved = self._io.read_bytes(116)

        def _fetch_instances(self):
            pass

        @property
        def is_save_file(self):
            """Heuristic to detect save game files.
            Save games use MOD signature but typically have description_strref = 0.
            """
            if hasattr(self, "_m_is_save_file"):
                return self._m_is_save_file

            self._m_is_save_file = (self.file_type == "MOD ") and (
                self.description_strref == 0
            )
            return getattr(self, "_m_is_save_file", None)

    class KeyEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.KeyEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.resref = (self._io.read_bytes(16)).decode("ASCII")
            self.resource_id = self._io.read_u4le()
            self.resource_type = KaitaiStream.resolve_enum(
                bioware_type_ids.BiowareTypeIds.XoreosFileTypeId, self._io.read_u2le()
            )
            self.unused = self._io.read_u2le()

        def _fetch_instances(self):
            pass

    class KeyList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.KeyList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.entry_count):
                self.entries.append(Erf.KeyEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class LocalizedStringEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.LocalizedStringEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.language_id = self._io.read_u4le()
            self.string_size = self._io.read_u4le()
            self.string_data = (self._io.read_bytes(self.string_size)).decode("UTF-8")

        def _fetch_instances(self):
            pass

    class LocalizedStringList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.LocalizedStringList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.language_count):
                self.entries.append(
                    Erf.LocalizedStringEntry(self._io, self, self._root)
                )

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    class ResourceEntry(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ResourceEntry, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.offset_to_data = self._io.read_u4le()
            self.len_data = self._io.read_u4le()

        def _fetch_instances(self):
            pass
            _ = self.data
            if hasattr(self, "_m_data"):
                pass

        @property
        def data(self):
            """Raw binary data for this resource."""
            if hasattr(self, "_m_data"):
                return self._m_data

            _pos = self._io.pos()
            self._io.seek(self.offset_to_data)
            self._m_data = self._io.read_bytes(self.len_data)
            self._io.seek(_pos)
            return getattr(self, "_m_data", None)

    class ResourceList(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            super(Erf.ResourceList, self).__init__(_io)
            self._parent = _parent
            self._root = _root
            self._read()

        def _read(self):
            self.entries = []
            for i in range(self._root.header.entry_count):
                self.entries.append(Erf.ResourceEntry(self._io, self, self._root))

        def _fetch_instances(self):
            pass
            for i in range(len(self.entries)):
                pass
                self.entries[i]._fetch_instances()

    @property
    def key_list(self):
        """Array of key entries mapping ResRefs to resource indices."""
        if hasattr(self, "_m_key_list"):
            return self._m_key_list

        _pos = self._io.pos()
        self._io.seek(self.header.offset_to_key_list)
        self._m_key_list = Erf.KeyList(self._io, self, self._root)
        self._io.seek(_pos)
        return getattr(self, "_m_key_list", None)

    @property
    def localized_string_list(self):
        """Optional localized string entries for multi-language descriptions."""
        if hasattr(self, "_m_localized_string_list"):
            return self._m_localized_string_list

        if self.header.language_count > 0:
            pass
            _pos = self._io.pos()
            self._io.seek(self.header.offset_to_localized_string_list)
            self._m_localized_string_list = Erf.LocalizedStringList(
                self._io, self, self._root
            )
            self._io.seek(_pos)

        return getattr(self, "_m_localized_string_list", None)

    @property
    def resource_list(self):
        """Array of resource entries containing offset and size information."""
        if hasattr(self, "_m_resource_list"):
            return self._m_resource_list

        _pos = self._io.pos()
        self._io.seek(self.header.offset_to_resource_list)
        self._m_resource_list = Erf.ResourceList(self._io, self, self._root)
        self._io.seek(_pos)
        return getattr(self, "_m_resource_list", None)

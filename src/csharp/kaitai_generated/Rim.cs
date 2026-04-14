// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

using System.Collections.Generic;

namespace Kaitai
{

    /// <summary>
    /// RIM (Resource Information Manager) files are self-contained archives used for module templates.
    /// RIM files are similar to ERF files but are read-only from the game's perspective. The game
    /// loads RIM files as templates for modules and exports them to ERF format for runtime mutation.
    /// RIM files store all resources inline with metadata, making them self-contained archives.
    /// 
    /// Format Variants:
    /// - Standard RIM: Basic module template files
    /// - Extension RIM: Files ending in 'x' (e.g., module001x.rim) that extend other RIMs
    /// 
    /// Binary Format (KotOR / PyKotor):
    /// - Fixed header (24 bytes): File type, version, reserved, resource count, offset to key table, offset to resources
    /// - Padding to key table (96 bytes when offsets are implicit): total 120 bytes before the key table
    /// - Key / resource entry table (32 bytes per entry): ResRef, type, ID, offset, size
    /// - Resource data at per-entry offsets (variable size, with engine/tool-specific padding between resources)
    /// 
    /// References:
    /// - https://github.com/OldRepublicDevs/PyKotor/wiki/RIM-File-Format.md
    /// - https://github.com/seedhartha/reone/blob/master/src/libs/resource/format/rimreader.cpp:24-100
    /// - https://github.com/xoreos/xoreos/blob/master/src/aurora/rimfile.cpp:40-160
    /// - https://github.com/KotOR-Community-Patches/Kotor.NET/blob/master/Kotor.NET/Formats/KotorRIM/RIMBinaryStructure.cs:11-121
    /// - https://github.com/KotOR-Community-Patches/KotOR_IO/blob/master/KotOR_IO/File%20Formats/RIM.cs:20-260
    /// </summary>
    public partial class Rim : KaitaiStruct
    {
        public static Rim FromFile(string fileName)
        {
            return new Rim(new KaitaiStream(fileName));
        }


        public enum XoreosFileTypeId
        {
            None = -1,
            Res = 0,
            Bmp = 1,
            Mve = 2,
            Tga = 3,
            Wav = 4,
            Plt = 6,
            Ini = 7,
            Bmu = 8,
            Mpg = 9,
            Txt = 10,
            Wma = 11,
            Wmv = 12,
            Xmv = 13,
            Plh = 2000,
            Tex = 2001,
            Mdl = 2002,
            Thg = 2003,
            Fnt = 2005,
            Lua = 2007,
            Slt = 2008,
            Nss = 2009,
            Ncs = 2010,
            Mod = 2011,
            Are = 2012,
            Set = 2013,
            Ifo = 2014,
            Bic = 2015,
            Wok = 2016,
            TwoDa = 2017,
            Tlk = 2018,
            Txi = 2022,
            Git = 2023,
            Bti = 2024,
            Uti = 2025,
            Btc = 2026,
            Utc = 2027,
            Dlg = 2029,
            Itp = 2030,
            Btt = 2031,
            Utt = 2032,
            Dds = 2033,
            Bts = 2034,
            Uts = 2035,
            Ltr = 2036,
            Gff = 2037,
            Fac = 2038,
            Bte = 2039,
            Ute = 2040,
            Btd = 2041,
            Utd = 2042,
            Btp = 2043,
            Utp = 2044,
            Dft = 2045,
            Gic = 2046,
            Gui = 2047,
            Css = 2048,
            Ccs = 2049,
            Btm = 2050,
            Utm = 2051,
            Dwk = 2052,
            Pwk = 2053,
            Btg = 2054,
            Utg = 2055,
            Jrl = 2056,
            Sav = 2057,
            Utw = 2058,
            FourPc = 2059,
            Ssf = 2060,
            Hak = 2061,
            Nwm = 2062,
            Bik = 2063,
            Ndb = 2064,
            Ptm = 2065,
            Ptt = 2066,
            Ncm = 2067,
            Mfx = 2068,
            Mat = 2069,
            Mdb = 2070,
            Say = 2071,
            Ttf = 2072,
            Ttc = 2073,
            Cut = 2074,
            Ka = 2075,
            Jpg = 2076,
            Ico = 2077,
            Ogg = 2078,
            Spt = 2079,
            Spw = 2080,
            Wfx = 2081,
            Ugm = 2082,
            Qdb = 2083,
            Qst = 2084,
            Npc = 2085,
            Spn = 2086,
            Utx = 2087,
            Mmd = 2088,
            Smm = 2089,
            Uta = 2090,
            Mde = 2091,
            Mdv = 2092,
            Mda = 2093,
            Mba = 2094,
            Oct = 2095,
            Bfx = 2096,
            Pdb = 2097,
            TheWitcherSave = 2098,
            Pvs = 2099,
            Cfx = 2100,
            Luc = 2101,
            Prb = 2103,
            Cam = 2104,
            Vds = 2105,
            Bin = 2106,
            Wob = 2107,
            Api = 2108,
            Properties = 2109,
            Png = 2110,
            Lyt = 3000,
            Vis = 3001,
            Rim = 3002,
            Pth = 3003,
            Lip = 3004,
            Bwm = 3005,
            Txb = 3006,
            Tpc = 3007,
            Mdx = 3008,
            Rsv = 3009,
            Sig = 3010,
            Mab = 3011,
            Qst2 = 3012,
            Sto = 3013,
            Hex = 3015,
            Mdx2 = 3016,
            Txb2 = 3017,
            Fsm = 3022,
            Art = 3023,
            Amp = 3024,
            Cwa = 3025,
            Bip = 3028,
            Mdb2 = 4000,
            Mda2 = 4001,
            Spt2 = 4002,
            Gr2 = 4003,
            Fxa = 4004,
            Fxe = 4005,
            Jpg2 = 4007,
            Pwc = 4008,
            OneDa = 9996,
            Erf = 9997,
            Bif = 9998,
            Key = 9999,
            Exe = 19000,
            Dbf = 19001,
            Cdx = 19002,
            Fpt = 19003,
            Zip = 20000,
            Fxm = 20001,
            Fxs = 20002,
            Xml = 20003,
            Wlk = 20004,
            Utr = 20005,
            Sef = 20006,
            Pfx = 20007,
            Tfx = 20008,
            Ifx = 20009,
            Lfx = 20010,
            Bbx = 20011,
            Pfb = 20012,
            Upe = 20013,
            Usc = 20014,
            Ult = 20015,
            Fx = 20016,
            Max = 20017,
            Doc = 20018,
            Scc = 20019,
            Wmp = 20020,
            Osc = 20021,
            Trn = 20022,
            Uen = 20023,
            Ros = 20024,
            Rst = 20025,
            Ptx = 20026,
            Ltx = 20027,
            Trx = 20028,
            Nds = 21000,
            Herf = 21001,
            Dict = 21002,
            Small = 21003,
            Cbgt = 21004,
            Cdpth = 21005,
            Emit = 21006,
            Itm = 21007,
            Nanr = 21008,
            Nbfp = 21009,
            Nbfs = 21010,
            Ncer = 21011,
            Ncgr = 21012,
            Nclr = 21013,
            Nftr = 21014,
            Nsbca = 21015,
            Nsbmd = 21016,
            Nsbta = 21017,
            Nsbtp = 21018,
            Nsbtx = 21019,
            Pal = 21020,
            Raw = 21021,
            Sadl = 21022,
            Sdat = 21023,
            Smp = 21024,
            Spl = 21025,
            Vx = 21026,
            Anb = 22000,
            Ani = 22001,
            Cns = 22002,
            Cur = 22003,
            Evt = 22004,
            Fdl = 22005,
            Fxo = 22006,
            Gad = 22007,
            Gda = 22008,
            Gfx = 22009,
            Ldf = 22010,
            Lst = 22011,
            Mal = 22012,
            Mao = 22013,
            Mmh = 22014,
            Mop = 22015,
            Mor = 22016,
            Msh = 22017,
            Mtx = 22018,
            Ncc = 22019,
            Phy = 22020,
            Plo = 22021,
            Stg = 22022,
            Tbi = 22023,
            Tnt = 22024,
            Arl = 22025,
            Fev = 22026,
            Fsb = 22027,
            Opf = 22028,
            Crf = 22029,
            Rimp = 22030,
            Met = 22031,
            Meta = 22032,
            Fxr = 22033,
            Cif = 22034,
            Cub = 22035,
            Dlb = 22036,
            Nsc = 22037,
            Mov = 23000,
            Curs = 23001,
            Pict = 23002,
            Rsrc = 23003,
            Plist = 23004,
            Cre = 24000,
            Pso = 24001,
            Vso = 24002,
            Abc = 24003,
            Sbm = 24004,
            Pvd = 24005,
            Pla = 24006,
            Trg = 24007,
            Pk = 24008,
            Als = 25000,
            Apl = 25001,
            Assembly = 25002,
            Bak = 25003,
            Bnk = 25004,
            Cl = 25005,
            Cnv = 25006,
            Con = 25007,
            Dat = 25008,
            Dx11 = 25009,
            Ids = 25010,
            Log = 25011,
            Map = 25012,
            Mml = 25013,
            Mp3 = 25014,
            Pck = 25015,
            Rml = 25016,
            S = 25017,
            Sta = 25018,
            Svr = 25019,
            Vlm = 25020,
            Wbd = 25021,
            Xbx = 25022,
            Xls = 25023,
            Bzf = 26000,
            Adv = 27000,
            Json = 28000,
            TlkExpert = 28001,
            TlkMobile = 28002,
            TlkTouch = 28003,
            Otf = 28004,
            Par = 28005,
            Xwb = 29000,
            Xsb = 29001,
            Xds = 30000,
            Wnd = 30001,
            Xeositex = 40000,
        }
        public Rim(KaitaiStream p__io, KaitaiStruct p__parent = null, Rim p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            _read();
        }
        private void _read()
        {
            _header = new RimHeader(m_io, this, m_root);
            if (Header.OffsetToResourceTable == 0) {
                _gapBeforeKeyTableImplicit = m_io.ReadBytes(96);
            }
            if (Header.OffsetToResourceTable != 0) {
                _gapBeforeKeyTableExplicit = m_io.ReadBytes(Header.OffsetToResourceTable - 24);
            }
            if (Header.ResourceCount > 0) {
                _resourceEntryTable = new ResourceEntryTable(m_io, this, m_root);
            }
        }
        public partial class ResourceEntry : KaitaiStruct
        {
            public static ResourceEntry FromFile(string fileName)
            {
                return new ResourceEntry(new KaitaiStream(fileName));
            }

            public ResourceEntry(KaitaiStream p__io, Rim.ResourceEntryTable p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_data = false;
                _read();
            }
            private void _read()
            {
                _resref = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(16));
                _resourceType = ((Rim.XoreosFileTypeId) m_io.ReadU4le());
                _resourceId = m_io.ReadU4le();
                _offsetToData = m_io.ReadU4le();
                _numData = m_io.ReadU4le();
            }
            private bool f_data;
            private List<byte> _data;

            /// <summary>
            /// Raw binary data for this resource (read at specified offset)
            /// </summary>
            public List<byte> Data
            {
                get
                {
                    if (f_data)
                        return _data;
                    f_data = true;
                    long _pos = m_io.Pos;
                    m_io.Seek(OffsetToData);
                    _data = new List<byte>();
                    for (var i = 0; i < NumData; i++)
                    {
                        _data.Add(m_io.ReadU1());
                    }
                    m_io.Seek(_pos);
                    return _data;
                }
            }
            private string _resref;
            private XoreosFileTypeId _resourceType;
            private uint _resourceId;
            private uint _offsetToData;
            private uint _numData;
            private Rim m_root;
            private Rim.ResourceEntryTable m_parent;

            /// <summary>
            /// Resource filename (ResRef), null-padded to 16 bytes.
            /// Maximum 16 characters. If exactly 16 characters, no null terminator exists.
            /// Resource names can be mixed case, though most are lowercase in practice.
            /// The game engine typically lowercases ResRefs when loading.
            /// </summary>
            public string Resref { get { return _resref; } }

            /// <summary>
            /// Resource type identifier (see ResourceType enum).
            /// Examples: 0x000B (TPC/texture), 0x000A (MOD/module), 0x0000 (RES/unknown)
            /// </summary>
            public XoreosFileTypeId ResourceType { get { return _resourceType; } }

            /// <summary>
            /// Resource ID (index, usually sequential).
            /// Typically matches the index of this entry in the resource_entry_table.
            /// Used for internal reference, but not critical for parsing.
            /// </summary>
            public uint ResourceId { get { return _resourceId; } }

            /// <summary>
            /// Byte offset to resource data from the beginning of the file.
            /// Points to the actual binary data for this resource in resource_data_section.
            /// </summary>
            public uint OffsetToData { get { return _offsetToData; } }

            /// <summary>
            /// Size of resource data in bytes (repeat count for raw `data` bytes).
            /// Uncompressed size of the resource.
            /// </summary>
            public uint NumData { get { return _numData; } }
            public Rim M_Root { get { return m_root; } }
            public Rim.ResourceEntryTable M_Parent { get { return m_parent; } }
        }
        public partial class ResourceEntryTable : KaitaiStruct
        {
            public static ResourceEntryTable FromFile(string fileName)
            {
                return new ResourceEntryTable(new KaitaiStream(fileName));
            }

            public ResourceEntryTable(KaitaiStream p__io, Rim p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                _read();
            }
            private void _read()
            {
                _entries = new List<ResourceEntry>();
                for (var i = 0; i < M_Root.Header.ResourceCount; i++)
                {
                    _entries.Add(new ResourceEntry(m_io, this, m_root));
                }
            }
            private List<ResourceEntry> _entries;
            private Rim m_root;
            private Rim m_parent;

            /// <summary>
            /// Array of resource entries, one per resource in the archive
            /// </summary>
            public List<ResourceEntry> Entries { get { return _entries; } }
            public Rim M_Root { get { return m_root; } }
            public Rim M_Parent { get { return m_parent; } }
        }
        public partial class RimHeader : KaitaiStruct
        {
            public static RimHeader FromFile(string fileName)
            {
                return new RimHeader(new KaitaiStream(fileName));
            }

            public RimHeader(KaitaiStream p__io, Rim p__parent = null, Rim p__root = null) : base(p__io)
            {
                m_parent = p__parent;
                m_root = p__root;
                f_hasResources = false;
                _read();
            }
            private void _read()
            {
                _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_fileType == "RIM "))
                {
                    throw new ValidationNotEqualError("RIM ", _fileType, m_io, "/types/rim_header/seq/0");
                }
                _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
                if (!(_fileVersion == "V1.0"))
                {
                    throw new ValidationNotEqualError("V1.0", _fileVersion, m_io, "/types/rim_header/seq/1");
                }
                _reserved = m_io.ReadU4le();
                _resourceCount = m_io.ReadU4le();
                _offsetToResourceTable = m_io.ReadU4le();
                _offsetToResources = m_io.ReadU4le();
            }
            private bool f_hasResources;
            private bool _hasResources;

            /// <summary>
            /// Whether the RIM file contains any resources
            /// </summary>
            public bool HasResources
            {
                get
                {
                    if (f_hasResources)
                        return _hasResources;
                    f_hasResources = true;
                    _hasResources = (bool) (ResourceCount > 0);
                    return _hasResources;
                }
            }
            private string _fileType;
            private string _fileVersion;
            private uint _reserved;
            private uint _resourceCount;
            private uint _offsetToResourceTable;
            private uint _offsetToResources;
            private Rim m_root;
            private Rim m_parent;

            /// <summary>
            /// File type signature. Must be &quot;RIM &quot; (0x52 0x49 0x4D 0x20).
            /// This identifies the file as a RIM archive.
            /// </summary>
            public string FileType { get { return _fileType; } }

            /// <summary>
            /// File format version. Always &quot;V1.0&quot; for KotOR RIM files.
            /// Other versions may exist in Neverwinter Nights but are not supported in KotOR.
            /// </summary>
            public string FileVersion { get { return _fileVersion; } }

            /// <summary>
            /// Reserved field (typically 0x00000000).
            /// Unknown purpose, but always set to 0 in practice.
            /// </summary>
            public uint Reserved { get { return _reserved; } }

            /// <summary>
            /// Number of resources in the archive. This determines:
            /// - Number of entries in resource_entry_table
            /// - Number of resources in resource_data_section
            /// </summary>
            public uint ResourceCount { get { return _resourceCount; } }

            /// <summary>
            /// Byte offset to the key / resource entry table from the beginning of the file.
            /// 0 means implicit offset 120 (24-byte header + 96-byte padding), matching PyKotor and vanilla KotOR.
            /// When non-zero, this offset is used directly (commonly 120).
            /// </summary>
            public uint OffsetToResourceTable { get { return _offsetToResourceTable; } }

            /// <summary>
            /// Optional offset to resource data section. Vanilla module RIMs often store 0 here (offsets are
            /// taken only from per-entry offset_to_data). PyKotor writes 0 when serializing.
            /// </summary>
            public uint OffsetToResources { get { return _offsetToResources; } }
            public Rim M_Root { get { return m_root; } }
            public Rim M_Parent { get { return m_parent; } }
        }
        private RimHeader _header;
        private byte[] _gapBeforeKeyTableImplicit;
        private byte[] _gapBeforeKeyTableExplicit;
        private ResourceEntryTable _resourceEntryTable;
        private Rim m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// RIM file header (24 bytes) plus padding to the key table (PyKotor total 120 bytes when implicit)
        /// </summary>
        public RimHeader Header { get { return _header; } }

        /// <summary>
        /// When offset_to_resource_table is 0, the engine treats the key table as starting at byte 120.
        /// After the 24-byte header, skip 96 bytes of padding (24 + 96 = 120).
        /// </summary>
        public byte[] GapBeforeKeyTableImplicit { get { return _gapBeforeKeyTableImplicit; } }

        /// <summary>
        /// When offset_to_resource_table is non-zero, skip until that byte offset (must be &gt;= 24).
        /// Vanilla files often store 120 here, which yields the same 96 bytes of padding as the implicit case.
        /// </summary>
        public byte[] GapBeforeKeyTableExplicit { get { return _gapBeforeKeyTableExplicit; } }

        /// <summary>
        /// Array of resource entries mapping ResRefs to resource data
        /// </summary>
        public ResourceEntryTable ResourceEntryTable { get { return _resourceEntryTable; } }
        public Rim M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}

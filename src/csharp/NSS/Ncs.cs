// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild



namespace Kaitai
{

    /// <summary>
    /// NCS (NWScript Compiled) files contain compiled NWScript bytecode used in KotOR and TSL.
    /// Scripts run inside a stack-based virtual machine shared across Aurora engine games.
    /// 
    /// Format Structure:
    /// - Header (13 bytes): Signature &quot;NCS &quot;, version &quot;V1.0&quot;, size marker (0x42), file size
    /// - Instruction Stream: Sequence of bytecode instructions
    /// 
    /// All multi-byte values in NCS files are stored in BIG-ENDIAN byte order (network byte order).
    /// 
    /// References:
    /// - https://github.com/OldRepublicDevs/PyKotor/wiki/NCS-File-Format.md - Complete NCS format documentation
    /// - NSS.ksy - NWScript source code that compiles to NCS
    /// </summary>
    public partial class Ncs : KaitaiStruct
    {
        public static Ncs FromFile(string fileName)
        {
            return new Ncs(new KaitaiStream(fileName));
        }

        public Ncs(KaitaiStream p__io, KaitaiStruct p__parent = null, Ncs p__root = null) : base(p__io)
        {
            m_parent = p__parent;
            m_root = p__root ?? this;
            f_lenBytecode = false;
            _read();
        }
        private void _read()
        {
            _fileType = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileType == "NCS "))
            {
                throw new ValidationNotEqualError("NCS ", _fileType, m_io, "/seq/0");
            }
            _fileVersion = System.Text.Encoding.GetEncoding("ASCII").GetString(m_io.ReadBytes(4));
            if (!(_fileVersion == "V1.0"))
            {
                throw new ValidationNotEqualError("V1.0", _fileVersion, m_io, "/seq/1");
            }
            _sizeMarker = m_io.ReadU1();
            if (!(_sizeMarker == 66))
            {
                throw new ValidationNotEqualError(66, _sizeMarker, m_io, "/seq/2");
            }
            _fileSize = m_io.ReadU4be();
            _bytecode = m_io.ReadBytes(LenBytecode);
        }
        private bool f_lenBytecode;
        private int _lenBytecode;

        /// <summary>
        /// Byte length of bytecode (total file size minus 13-byte header).
        /// </summary>
        public int LenBytecode
        {
            get
            {
                if (f_lenBytecode)
                    return _lenBytecode;
                f_lenBytecode = true;
                _lenBytecode = (int) ((FileSize >= 13 ? FileSize - 13 : 0));
                return _lenBytecode;
            }
        }
        private string _fileType;
        private string _fileVersion;
        private byte _sizeMarker;
        private uint _fileSize;
        private byte[] _bytecode;
        private Ncs m_root;
        private KaitaiStruct m_parent;

        /// <summary>
        /// File type signature. Must be &quot;NCS &quot; (0x4E 0x43 0x53 0x20).
        /// </summary>
        public string FileType { get { return _fileType; } }

        /// <summary>
        /// File format version. Must be &quot;V1.0&quot; (0x56 0x31 0x2E 0x30).
        /// </summary>
        public string FileVersion { get { return _fileVersion; } }

        /// <summary>
        /// Program size marker opcode. Must be 0x42.
        /// This is not a real instruction but a metadata field containing the total file size.
        /// All implementations validate this marker before parsing instructions.
        /// </summary>
        public byte SizeMarker { get { return _sizeMarker; } }

        /// <summary>
        /// Total file size in bytes (big-endian).
        /// This value should match the actual file size.
        /// </summary>
        public uint FileSize { get { return _fileSize; } }

        /// <summary>
        /// Raw NWScript bytecode from offset 13 through file_size (variable-length instructions).
        /// Per-instruction layout is opcode-specific; PyKotor decodes this stream in io_ncs.
        /// </summary>
        public byte[] Bytecode { get { return _bytecode; } }
        public Ncs M_Root { get { return m_root; } }
        public KaitaiStruct M_Parent { get { return m_parent; } }
    }
}

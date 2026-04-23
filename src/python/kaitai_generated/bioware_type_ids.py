# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
# type: ignore

import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO
from enum import IntEnum


if getattr(kaitaistruct, 'API_VERSION', (0, 9)) < (0, 11):
    raise Exception("Incompatible Kaitai Struct Python API: 0.11 or later is required, but you have %s" % (kaitaistruct.__version__))

class BiowareTypeIds(KaitaiStruct):
    """This file provides **exhaustive enum mappings** for resource/type identifiers used across
    BioWare-family games and their tooling ecosystems.
    
    **Consumers:** KEY / ERF / RIM import `xoreos_file_type_id` from here instead of duplicating the archive
    type table; cite this file for upstream alias/conflict notes. TLK/ERF language ids and LIP visemes live in
    `bioware_common.ksy` (`bioware_language_id`, `bioware_lip_viseme_id`).
    Additional **xoreos-only** Aurora enums (`xoreos_game_id`, `xoreos_archive_type`, `xoreos_resource_category`, `xoreos_platform_id`)
    mirror the same `types.h` header (distinct from PyKotor `ResourceType` / archive `FileType` IDs).
    
    **xoreos naming (do not conflate):**
    - `Aurora::ResourceType` in `types.h` is a **tiny media-class enum** (`kResourceImage` … `kResourceMAX`) — not archive numeric IDs.
      It is mirrored here as `xoreos_resource_category` (`meta.xref.xoreos_types_resource_type_enum`).
    - Archive **numeric restype** values come from `Aurora::FileType` (`kFileType*` constants) — mirrored here as `xoreos_file_type_id`.
    
    Why two ID columns?
    - `xoreos_file_type_id` mirrors xoreos `enum FileType` in `src/aurora/types.h` (`meta.xref.xoreos_types_file_type_enum`; full header band: `meta.xref.xoreos_types`) and is the
      canonical set of **engine-facing** numeric type IDs found in archives (KEY/BIF/ERF/RIM, etc).
    - `bioware_resource_type_id` mirrors PyKotor `ResourceType` (`type.py#L123-L322`; see `meta.xref.pykotor_types`).
      and includes additional **toolset-only** IDs (e.g. XML/JSON abstractions).
    
    Important notes:
    - **Duplicates / aliases** exist in upstream definitions (e.g., `DFT`/`DTF` share `2045`,
      `FXR`/`FXT` share `22033` — see `meta.xref.xoreos_types_fxr_fxt_duplicate`). Kaitai enums cannot represent multiple names for the same numeric key,
      so this file keeps a single canonical name per value.
    - **Conflicts between ecosystems** exist: PyKotor assigns `25015` to `wav_deob` for toolset use,
      while xoreos uses `25015` for `pck` (Dragon Age II). Keeping the enums separate preserves both.
    
    References: `meta.doc-ref` and `meta.xref` (xoreos `types.h` bands; PyKotor `ResourceType`).
    
    .. seealso::
       xoreos — `FileType` comment block - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L34-L55
    
    
    .. seealso::
       xoreos — `enum FileType` (engine-facing archive type IDs; includes post-`kFileTypeXEOSITEX` entries such as `kFileTypeWBM`) - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L56-L450
    
    
    .. seealso::
       xoreos — `enum GameID` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L396-L408
    
    
    .. seealso::
       xoreos — `enum ResourceType` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L410-L417
    
    
    .. seealso::
       xoreos — `enum ArchiveType` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L419-L430
    
    
    .. seealso::
       xoreos — `enum Platform` - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L432-L443
    
    
    .. seealso::
       xoreos — `FXR` / `FXT` duplicate numeric key - https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L316-L317
    
    
    .. seealso::
       xoreos — `ResourceManager::addTypeAlias` - https://github.com/xoreos/xoreos/blob/master/src/aurora/resman.cpp#L610-L612
    
    
    .. seealso::
       xoreos-tools — README tool inventory (which CLIs touch which formats) - https://github.com/xoreos/xoreos-tools/blob/master/README.md#L17-L43
    
    
    .. seealso::
       xoreos-docs — BioWare specs PDF tree - https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
    
    
    .. seealso::
       PyKotor — `ResourceType` members (engine + toolset-only ids) - https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/type.py#L123-L322
    """

    class BiowareResourceTypeId(IntEnum):
        invalid = -1
        res = 0
        bmp = 1
        mve = 2
        tga = 3
        wav = 4
        plt = 6
        ini = 7
        bmu = 8
        mpg = 9
        txt = 10
        wma = 11
        wmv = 12
        xmv = 13
        plh = 2000
        tex = 2001
        mdl = 2002
        thg = 2003
        fnt = 2005
        lua = 2007
        slt = 2008
        nss = 2009
        ncs = 2010
        mod = 2011
        are = 2012
        set = 2013
        ifo = 2014
        bic = 2015
        wok = 2016
        tlk = 2018
        txi = 2022
        git = 2023
        bti = 2024
        uti = 2025
        btc = 2026
        utc = 2027
        dlg = 2029
        itp = 2030
        btt = 2031
        utt = 2032
        dds = 2033
        bts = 2034
        uts = 2035
        ltr = 2036
        gff = 2037
        fac = 2038
        bte = 2039
        ute = 2040
        btd = 2041
        utd = 2042
        btp = 2043
        utp = 2044
        dft = 2045
        gic = 2046
        gui = 2047
        css = 2048
        ccs = 2049
        btm = 2050
        utm = 2051
        dwk = 2052
        pwk = 2053
        btg = 2054
        utg = 2055
        jrl = 2056
        sav = 2057
        utw = 2058
        ssf = 2060
        hak = 2061
        nwm = 2062
        bik = 2063
        ndb = 2064
        ptm = 2065
        ptt = 2066
        ncm = 2067
        mfx = 2068
        mat = 2069
        mdb = 2070
        say = 2071
        ttf = 2072
        ttc = 2073
        cut = 2074
        ka = 2075
        jpg = 2076
        ico = 2077
        ogg = 2078
        spt = 2079
        spw = 2080
        wfx = 2081
        ugm = 2082
        qdb = 2083
        qst = 2084
        npc = 2085
        spn = 2086
        utx = 2087
        mmd = 2088
        smm = 2089
        uta = 2090
        mde = 2091
        mdv = 2092
        mda = 2093
        mba = 2094
        oct = 2095
        bfx = 2096
        pdb = 2097
        pvs = 2099
        cfx = 2100
        luc = 2101
        prb = 2103
        cam = 2104
        vds = 2105
        bin = 2106
        wob = 2107
        api = 2108
        png = 2110
        lyt = 3000
        vis = 3001
        rim = 3002
        pth = 3003
        lip = 3004
        bwm = 3005
        txb = 3006
        tpc = 3007
        mdx = 3008
        rsv = 3009
        sig = 3010
        mab = 3011
        qst2 = 3012
        sto = 3013
        hex = 3015
        mdx2 = 3016
        txb2 = 3017
        fsm = 3022
        art = 3023
        amp = 3024
        cwa = 3025
        bip = 3028
        erf = 9997
        bif = 9998
        key = 9999
        mp3 = 25014
        wav_deob = 25015
        tlk_xml = 50001
        mdl_ascii = 50002
        ifo_xml = 50006
        git_xml = 50007
        uti_xml = 50008
        utc_xml = 50009
        dlg_xml = 50010
        itp_xml = 50011
        utt_xml = 50012
        uts_xml = 50013
        fac_xml = 50014
        ute_xml = 50015
        utd_xml = 50016
        utp_xml = 50017
        gui_xml = 50018
        utm_xml = 50019
        jrl_xml = 50020
        utw_xml = 50021
        pth_xml = 50022
        lip_xml = 50023
        ssf_xml = 50024
        are_xml = 50025
        tlk_json = 50027
        lip_json = 50028
        res_xml = 50029

    class XoreosArchiveType(IntEnum):
        key = 0
        bif = 1
        erf = 2
        rim = 3
        zip = 4
        exe = 5
        nds = 6
        herf = 7
        nsbtx = 8
        max = 9

    class XoreosFileTypeId(IntEnum):
        none = -1
        res = 0
        bmp = 1
        mve = 2
        tga = 3
        wav = 4
        plt = 6
        ini = 7
        bmu = 8
        mpg = 9
        txt = 10
        wma = 11
        wmv = 12
        xmv = 13
        plh = 2000
        tex = 2001
        mdl = 2002
        thg = 2003
        fnt = 2005
        lua = 2007
        slt = 2008
        nss = 2009
        ncs = 2010
        mod = 2011
        are = 2012
        set = 2013
        ifo = 2014
        bic = 2015
        wok = 2016
        two_da = 2017
        tlk = 2018
        txi = 2022
        git = 2023
        bti = 2024
        uti = 2025
        btc = 2026
        utc = 2027
        dlg = 2029
        itp = 2030
        btt = 2031
        utt = 2032
        dds = 2033
        bts = 2034
        uts = 2035
        ltr = 2036
        gff = 2037
        fac = 2038
        bte = 2039
        ute = 2040
        btd = 2041
        utd = 2042
        btp = 2043
        utp = 2044
        dft = 2045
        gic = 2046
        gui = 2047
        css = 2048
        ccs = 2049
        btm = 2050
        utm = 2051
        dwk = 2052
        pwk = 2053
        btg = 2054
        utg = 2055
        jrl = 2056
        sav = 2057
        utw = 2058
        four_pc = 2059
        ssf = 2060
        hak = 2061
        nwm = 2062
        bik = 2063
        ndb = 2064
        ptm = 2065
        ptt = 2066
        ncm = 2067
        mfx = 2068
        mat = 2069
        mdb = 2070
        say = 2071
        ttf = 2072
        ttc = 2073
        cut = 2074
        ka = 2075
        jpg = 2076
        ico = 2077
        ogg = 2078
        spt = 2079
        spw = 2080
        wfx = 2081
        ugm = 2082
        qdb = 2083
        qst = 2084
        npc = 2085
        spn = 2086
        utx = 2087
        mmd = 2088
        smm = 2089
        uta = 2090
        mde = 2091
        mdv = 2092
        mda = 2093
        mba = 2094
        oct = 2095
        bfx = 2096
        pdb = 2097
        the_witcher_save = 2098
        pvs = 2099
        cfx = 2100
        luc = 2101
        prb = 2103
        cam = 2104
        vds = 2105
        bin = 2106
        wob = 2107
        api = 2108
        properties = 2109
        png = 2110
        lyt = 3000
        vis = 3001
        rim = 3002
        pth = 3003
        lip = 3004
        bwm = 3005
        txb = 3006
        tpc = 3007
        mdx = 3008
        rsv = 3009
        sig = 3010
        mab = 3011
        qst2 = 3012
        sto = 3013
        hex = 3015
        mdx2 = 3016
        txb2 = 3017
        fsm = 3022
        art = 3023
        amp = 3024
        cwa = 3025
        bip = 3028
        mdb2 = 4000
        mda2 = 4001
        spt2 = 4002
        gr2 = 4003
        fxa = 4004
        fxe = 4005
        jpg2 = 4007
        pwc = 4008
        one_da = 9996
        erf = 9997
        bif = 9998
        key = 9999
        exe = 19000
        dbf = 19001
        cdx = 19002
        fpt = 19003
        zip = 20000
        fxm = 20001
        fxs = 20002
        xml = 20003
        wlk = 20004
        utr = 20005
        sef = 20006
        pfx = 20007
        tfx = 20008
        ifx = 20009
        lfx = 20010
        bbx = 20011
        pfb = 20012
        upe = 20013
        usc = 20014
        ult = 20015
        fx = 20016
        max = 20017
        doc = 20018
        scc = 20019
        wmp = 20020
        osc = 20021
        trn = 20022
        uen = 20023
        ros = 20024
        rst = 20025
        ptx = 20026
        ltx = 20027
        trx = 20028
        nds = 21000
        herf = 21001
        dict = 21002
        small = 21003
        cbgt = 21004
        cdpth = 21005
        emit = 21006
        itm = 21007
        nanr = 21008
        nbfp = 21009
        nbfs = 21010
        ncer = 21011
        ncgr = 21012
        nclr = 21013
        nftr = 21014
        nsbca = 21015
        nsbmd = 21016
        nsbta = 21017
        nsbtp = 21018
        nsbtx = 21019
        pal = 21020
        raw = 21021
        sadl = 21022
        sdat = 21023
        smp = 21024
        spl = 21025
        vx = 21026
        anb = 22000
        ani = 22001
        cns = 22002
        cur = 22003
        evt = 22004
        fdl = 22005
        fxo = 22006
        gad = 22007
        gda = 22008
        gfx = 22009
        ldf = 22010
        lst = 22011
        mal = 22012
        mao = 22013
        mmh = 22014
        mop = 22015
        mor = 22016
        msh = 22017
        mtx = 22018
        ncc = 22019
        phy = 22020
        plo = 22021
        stg = 22022
        tbi = 22023
        tnt = 22024
        arl = 22025
        fev = 22026
        fsb = 22027
        opf = 22028
        crf = 22029
        rimp = 22030
        met = 22031
        meta = 22032
        fxr = 22033
        cif = 22034
        cub = 22035
        dlb = 22036
        nsc = 22037
        mov = 23000
        curs = 23001
        pict = 23002
        rsrc = 23003
        plist = 23004
        cre = 24000
        pso = 24001
        vso = 24002
        abc = 24003
        sbm = 24004
        pvd = 24005
        pla = 24006
        trg = 24007
        pk = 24008
        als = 25000
        apl = 25001
        assembly = 25002
        bak = 25003
        bnk = 25004
        cl = 25005
        cnv = 25006
        con = 25007
        dat = 25008
        dx11 = 25009
        ids = 25010
        log = 25011
        map = 25012
        mml = 25013
        mp3 = 25014
        pck = 25015
        rml = 25016
        s = 25017
        sta = 25018
        svr = 25019
        vlm = 25020
        wbd = 25021
        xbx = 25022
        xls = 25023
        bzf = 26000
        adv = 27000
        json = 28000
        tlk_expert = 28001
        tlk_mobile = 28002
        tlk_touch = 28003
        otf = 28004
        par = 28005
        xwb = 29000
        xsb = 29001
        xds = 30000
        wnd = 30001
        xeositex = 40000
        wbm = 41000

    class XoreosGameId(IntEnum):
        unknown = -1
        nwn = 0
        nwn2 = 1
        kotor = 2
        kotor2 = 3
        jade = 4
        witcher = 5
        sonic = 6
        dragon_age = 7
        dragon_age2 = 8
        max = 9

    class XoreosPlatformId(IntEnum):
        windows = 0
        mac_osx = 1
        linux = 2
        xbox = 3
        xbox360 = 4
        ps3 = 5
        nds = 6
        android = 7
        ios = 8
        unknown = 9

    class XoreosResourceCategory(IntEnum):
        image = 0
        video = 1
        sound = 2
        music = 3
        cursor = 4
        max = 5
    def __init__(self, _io, _parent=None, _root=None):
        super(BiowareTypeIds, self).__init__(_io)
        self._parent = _parent
        self._root = _root or self
        self._read()

    def _read(self):
        pass


    def _fetch_instances(self):
        pass



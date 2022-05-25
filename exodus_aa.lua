
function GetHWID()
--     local a = require("ffi") or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!", 2)
--     a.cdef [[
--     typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
--     typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
-- ]]
--     local b = a.typeof("void***")
--     local c = Utils.CreateInterface("filesystem_stdio.dll", "VBaseFileSystem011") or error(_debug and "Failed to get VBaseFileSystem011 interface" or "error", 2)
--     local d = a.cast(b, c) or error(_debug and "Failed to cast rawfilesystem to filesystem" or "error", 2)
--     local e = a.cast("file_exists_t", d[0][10]) or error(_debug and "Failed to cast file_exists_t" or "error", 2)
--     local f = a.cast("get_file_time_t", d[0][13]) or error(_debug and "Failed to cast get_file_time_t" or "error", 2)
--     local function g() for h = 65, 90 do local i = string.char(h) .. ":\\Windows\\Setup\\State\\State.ini" if e(d, i, "ROOT") then return i end end return nil end

--     ;local i = g() or error(_debug and "Failed to bruteforce system directory" or "error", 2)
--     local j = f(d, i, "ROOT") or error(_debug and "get_file_time failed" or "error", 2)
--     local k = j * 2;
--     return k;

    return 69
end

Cheat.GetCheatUserName = function ()
    return 'SmoK'
end

local hwid = GetHWID()
-- BC_WATERMARK("")
function loadsex()
    Menu_invert_side = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Inverter")
    Menu_left_limit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Left Limit")
    Menu_fake_options = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
    Menu_fake_option = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
    Menu_right_limit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Right Limit")
    Menu_leg_movement = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Leg Movement")
    Menu_fakelag_limit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Limit")
    Menu_fakelag_enable = Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag")
    Menu_fakelag_randomization = Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Randomization")
    Menu_freestand_desync = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
    Menu_slowwalk = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Slow Walk")
    double_tap = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
    hide_shots = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots")
    _yawbase = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
    onko_tp = Menu.FindVar("Visuals", "View", "Thirdperson", "Enable Thirdperson")
    lbreaker = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Leg Movement")
    autopeekuwu = Menu.FindVar("Miscellaneous", "Main", "Movement", "Auto Peek")
    inverter = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Inverter")
    local flick_side = true
    local dont_flick = false
    local function text_color(alpha)
        return Color.new(0.9, 0.9, 0.9, 0.95 * alpha)
    end

    local function color(r, g, b, a) return Color.new(r / 255, g / 255, b / 255, a / 255) end

    local function in_box(mouse, x, y, x2, y2) return (mouse.x > x) and (mouse.y > y) and (mouse.x < x2) and (mouse.y < y2) end

    local function clamp(val, min, max) if val > max then return max end if min > val then return min end return val end

    local screen_size = EngineClient.GetScreenSize()
    local cheat_username = Cheat.GetCheatUserName():gsub("%#", "_")
    local font = Render.InitFont("Calibri", 12, { 'b' })
    local image_size = Vector2.new(746 / 5, 1070 / 5)
    local url = "https://cdn.discordapp.com/attachments/913347418538516500/920750654706843678/marius.png"
    local bytes = Http.Get(url)
    local penguin = Render.LoadImage(bytes, image_size)
    local floor = math.floor
    local last_time = 0.5
    local font_size = 12
    local fps_info = {}
    local fake_dt_w = 0
    local hz_io_w = 0
    local delta = 0
    local lag
    local cfg = {
        DTSettings = Menu.Switch("Rage", "General", "Double tap Modifications", false),
        IdealTick = Menu.Switch("Rage", "General", "Ideal Tick", false, "After shooting you will teleport a far distance. (highly recommended that you bind this)"),
        LegsBreaker = Menu.Switch("Rage", 'General', "Legs Breaker", false),
        predict_improved = Menu.Combo("Rage", "General", "Extrapolate Mode", { "Normal", "High", "Ultra" }, 0, "Forces the cheat to extrapolate in some angles (Very similar to anti-exploit)"),
        tabsdesyncmod = Menu.Combo("Anti-Aim", "Builder", "Categories", { "Standing", "Moving", "In Air", "Slowwalk" }, 0),
        desyncmodowostanding = Menu.Combo("Anti-Aim", "Builder", "Stand", { "Ideal Fake", "Low Delta Sway", "Jitter", "Smart Jitter", "Tank", "Custom" }, 0),
        randomizeeveryroundstanding = Menu.Switch("Anti-Aim", "Builder", "Randomize every round", false),
        desyncmodowomoving = Menu.Combo("Anti-Aim", "Builder", "Move", { "Ideal Fake", "Low Delta Sway", "Jitter", "Smart Jitter", "Tank", "Custom" }, 0),
        randomizeeveryroundmoving = Menu.Switch("Anti-Aim", "Builder", "Randomize every round", false),
        desyncmodowoair = Menu.Combo("Anti-Aim", "Builder", "Air", { "Ideal Fake", "Low Delta Sway", "Jitter", "Smart Jitter", "Tank", "Custom" }, 0),
        randomizeeveryroundair = Menu.Switch("Anti-Aim", "Builder", "Randomize every round", false),
        desyncmodowoslowwalk = Menu.Combo("Anti-Aim", "Builder", "Slow Walk", { "Ideal Fake", "Low Delta Sway", "Jitter", "Smart Jitter", "Tank", "Custom" }, 0),
        randomizeeveryroundslowwalk = Menu.Switch("Anti-Aim", "Builder", "Randomize every round", false),

        sinv = Menu.Switch("Anti-Aim", "Builder", "[S] Inverter", false),
        sleft = Menu.SliderInt("Anti-Aim", "Builder", "[S] Left Limit", 0, 0, 60),
        sright = Menu.SliderInt("Anti-Aim", "Builder", "[S] Right Limit", 0, 0, 60),
        sfkopt = Menu.MultiCombo("Anti-Aim", "Builder", "[S] Fake Options", { "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce" }, 0),
        slby = Menu.Combo("Anti-Aim", "Builder", "[S] LBY Mode", { "Disabled", "Opposite", "Sway" }, 0),
        sfr = Menu.Combo("Anti-Aim", "Builder", "[S] Freestanding Desync", { "Disabled", "Peek Fake", "Peek Real" }, 0),
        sdes = Menu.Combo("Anti-Aim", "Builder", "[S] Desync On Shot", { "Disabled", "Opposite", "Freestanding", "Switch" }, 0),
        winv = Menu.Switch("Anti-Aim", "Builder", "[M] Inverter", false),
        wleft = Menu.SliderInt("Anti-Aim", "Builder", "[M] Left Limit", 0, 0, 60),
        wright = Menu.SliderInt("Anti-Aim", "Builder", "[M] Right Limit", 0, 0, 60),
        wfkopt = Menu.MultiCombo("Anti-Aim", "Builder", "[M] Fake Options", { "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce" }, 0),
        wlby = Menu.Combo("Anti-Aim", "Builder", "[M] LBY Mode", { "Disabled", "Opposite", "Sway" }, 0),
        wfr = Menu.Combo("Anti-Aim", "Builder", "[M] Freestanding Desync", { "Disabled", "Peek Fake", "Peek Real" }, 0),
        wdes = Menu.Combo("Anti-Aim", "Builder", "[M] Desync On Shot", { "Disabled", "Opposite", "Freestanding", "Switch" }, 0),
        swinv = Menu.Switch("Anti-Aim", "Builder", "[SW] Inverter", false),
        swleft = Menu.SliderInt("Anti-Aim", "Builder", "[SW] Left Limit", 0, 0, 60),
        swright = Menu.SliderInt("Anti-Aim", "Builder", "[SW] Right Limit", 0, 0, 60),
        swfkopt = Menu.MultiCombo("Anti-Aim", "Builder", "[SW] Fake Options", { "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce" }, 0),
        swlby = Menu.Combo("Anti-Aim", "Builder", "[SW] LBY Mode", { "Disabled", "Opposite", "Sway" }, 0),
        swfr = Menu.Combo("Anti-Aim", "Builder", "[SW] Freestanding Desync", { "Disabled", "Peek Fake", "Peek Real" }, 0),
        swdes = Menu.Combo("Anti-Aim", "Builder", "[SW] Desync On Shot", { "Disabled", "Opposite", "Freestanding", "Switch" }, 0),
        ainv = Menu.Switch("Anti-Aim", "Builder", "[A] Inverter", false),
        aleft = Menu.SliderInt("Anti-Aim", "Builder", "[A] Left Limit", 0, 0, 60),
        aright = Menu.SliderInt("Anti-Aim", "Builder", "[A] Right Limit", 0, 0, 60),
        afkopt = Menu.MultiCombo("Anti-Aim", "Builder", "[A] Fake Options", { "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce" }, 0),
        alby = Menu.Combo("Anti-Aim", "Builder", "[A] LBY Mode", { "Disabled", "Opposite", "Sway" }, 0),
        afr = Menu.Combo("Anti-Aim", "Builder", "[A] Freestanding Desync", { "Disabled", "Peek Fake", "Peek Real" }, 0),
        ades = Menu.Combo("Anti-Aim", "Builder", "[A] Desync On Shot", { "Disabled", "Opposite", "Freestanding", "Switch" }, 0),

        antionshot = Menu.Switch("Anti-Aim", "Misc", "Anti-OnShot", false, "Tries to Force Pitch Back down immeadiately after ragebot shot gets registered"),
        fakeflickescheck = Menu.Switch("Anti-Aim", "Misc", "Fake Flick", false, "Flicks your yaw with freestanding (recommanded to bind)"),
        fakeflickesmode = Menu.Combo("Anti-Aim", "Misc", "Fake Flick Mode", { "Normal", "Fakelag", "Auto" }, 0, ""),
        ExtendedLean = Menu.Switch("Anti-Aim", "Main", "Extended Lean", false, ""),
        ExtendedLeanMode = Menu.Combo("Anti-Aim", "Extended Lean", "Mode", { "Static", "Jitter", "Dynamic" }, 0, ""),
        ExtendedLeanVal = Menu.SliderInt("Anti-Aim", "Extended Lean", "Extended Lean Value", 0, 0, 180),
        ExtendedLeanJitter = Menu.SliderInt("Anti-Aim", "Extended Lean", "Extended Lean Jitter", 0, 0, 180),
        AvoidBackStab = Menu.Switch("Anti-Aim", "Misc", "Avoid BackStab", false),
        desyncmod = Menu.Switch("Anti-Aim", "Main", "Anti-Aim Builder", false, ""),
        legitaa = Menu.Switch("Anti-Aim", "Main", "Legit AA on E", false),
        instantrecharge = Menu.Switch("Rage", "Doubletap", "Instant Recharge", false, ""),
        instantrecharge_mode = Menu.Combo("Rage", "Doubletap", "Mode", { "Old", "New" }, 0, ""),
        dtcorrection = Menu.Switch("Rage", "Doubletap", "Disable DT Correction", false, "Will make your DoubleTap innacurate but faster!"),
        dt_lethal = Menu.Switch("Rage", "Doubletap", "Lethal Doubletap", false),
        dtmodes = Menu.Combo("Rage", "Doubletap", "Modes", { "Instant", "Safe", "UnSafe", "Custom" }, 0, "Multiple DoubleTap speed modes!"),
        dt_ticks = Menu.SliderInt("Rage", "Doubletap", "Ticks", 1, 1, 16, ""),
        antibrute = Menu.Switch("Anti-Aim", "Main", "Anti Brute", false),
        ReverseFreeStand = Menu.Switch("Anti-Aim", "Main", "Reverse Freestand", false),
        IdealMode = Menu.Switch("Anti-Aim", "Main", "Ideal Yaw", false, "Makes your real go in an ideal way."),
        teleowo = Menu.Switch("Anti-Aim", "Misc", "Teleport In air", false, "Enable DT first"),
        ReverseFreeStand_Combo = Menu.MultiCombo("Anti-Aim", "Reverse Freestand", "Conditions", { "Standing", "Moving", "In Air", "Slow walk" }, 0, "Items in Indicator list!"),
        desyncarrows = Menu.Switch("Visuals", 'General', "Desync Arrows", false),
        desyncarrowscombo = Menu.Combo("Visuals", "General", "Desync Arrows Style", { "Classic", "New" }, 0),
        SkeetScope = Menu.SwitchColor("Visuals", "General", "Custom scope", false, Color.new(1.0, 1.0, 1.0, 1.0), "Scope color"),
        ScopeOrigin = Menu.SliderInt("Visuals", 'General', 'Custom scope origin', 0, 0, 100),
        ScopeWidth = Menu.SliderInt("Visuals", 'General', 'Custom scope width', 0, 0, 100),
        indicators = Menu.Switch("Visuals", 'Misc', "Indicators", false),
        glowautopeek = Menu.SwitchColor("Visuals", "Misc", "Custom Autopeek", false, Color.new(1, 1, 1, 1), ""),
        logsowoowowowo = Menu.MultiCombo("Visuals", "Misc", "Logs", { "Purchases", "Shots", "Anti-aim" }, 0, "Logs for in-game events!"),
        clantagcheckbox = Menu.Switch("Visuals", "Misc", "Clantag", false),
        indicators_type = Menu.Combo("Visuals", "Indicators", "Indicators type", { "Off", "prediction", "Acatel", "Ideal Fake", "Killaura", "Arctic", "Invictus" }, 0, "Multiple indicators type"),
        indicators_list = Menu.MultiCombo("Visuals", "Indicators", "Indicators to show", { "Script name", "Anti-aim status", "Doubletap", "Hide shots", "Quickpeek", "Freestanding", "Force body aim", "Force safe point" }, 0, "Prediction indicators to show"),
        customslowwalkspeed = Menu.Switch("Anti-Aim", "Misc", "Custom Slowwalk Speed", false, "Enables the anti aim"),
        slowwalkspeed = Menu.SliderInt("Anti-Aim", "Misc", "Slowwalk Speed", 10, 10, 130),
        aimdorm = Menu.Switch("Rage", "General", "Dormant Aim", false),
        fakelagexploit = Menu.Switch("Anti-Aim", "Fake Lag", "FakeLag Exploit", false, "(BETA) Makes your fakelag go double"),
        lcbreak = Menu.Switch("Anti-Aim", "Misc", "Break LC", false, "Breaks LC when possible"),
        aimdormmd = Menu.SliderInt("Rage", "Dormant Aim", "Minimum damage", 1, 1, 130),
        fakelagesEnable = Menu.Switch("Anti-Aim", "Main", "Fake Lag Customization", false),
        fakelagesEnableDT = Menu.Switch("Anti-Aim", "Fake Lag", "DoubleTap FakeLag", false),
        fakelagesType = Menu.Combo("Anti-Aim", "Fake Lag", "Fake Lag Type", { "None", "Ticks", "Fluctuate", "Randomized", "Dynamic" }, 0),
        fakelagesCustomTicks = Menu.SliderInt("Anti-Aim", "Fake Lag", "Ticks", 1, 1, CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt(), "Only without exploits"),
        fakelagesCustomLimitTime = Menu.SliderFloat("Anti-Aim", "Fake Lag", "Time to Switch", 0.4, 0, 2),
        fakelagesLimit = Menu.SliderInt("Anti-Aim", "Fake Lag", "Limit", 8, 0, 14),
        fakelagesRandomization = Menu.SliderInt("Anti-Aim", "Fake Lag", "Randomization", 4, 0, 14),
        fakelagesRandomizedtime = Menu.SliderFloat("Anti-Aim", "Fake Lag", "Time", 0.6, 0, 3),
        fakelagesRandomizedmin = Menu.SliderInt("Anti-Aim", "Fake Lag", "Min", 4, 0, 14),
        fakelagesRandomizedmax = Menu.SliderInt("Anti-Aim", "Fake Lag", "Max", 12, 0, 14),
        uisexwindows = Menu.MultiCombo("Visuals", "UI", "Windows", { "Watermark", "Spectators", "Keybinds", "IO", "Fake", "FL", "MS" }, 0),
        uisexthemes = Menu.Combo("Visuals", "UI", "Theme", { "Gradient line", "Static line", "Fade line" }, 3),
        uisextext_outline = Menu.Switch("Visuals", "UI", "Text outline", true),
        uisexbox_alpha = Menu.SliderInt("Visuals", "UI", "Box alpha", 150, 0, 255),

        uisexkeybinds_x = Menu.SliderInt("Visuals", "UI", "keybinds x", 5, 0, screen_size.x),
        uisexkeybinds_y = Menu.SliderInt("Visuals", "UI", "keybinds y", math.floor(screen_size.y / 2), 0, screen_size.y),
        uisexspectators_x = Menu.SliderInt("Visuals", "UI", "spectators x", 5, 0, screen_size.x),
        uisexspectators_y = Menu.SliderInt("Visuals", "UI", "spectators y", math.floor(screen_size.y / 3), 0, screen_size.y),
    }

    local menu = {}
    local items = {}

    items.min_count = 2
    items.max_count = 10


    menu.index = Menu.SliderInt("Rage", "General", "Index", 0, items.min_count, items.max_count)
    menu.index:SetVisible(false)

    menu.get_index = function()
        return menu.index:Get()
    end

    menu.set_index = function(int)
        return menu.index:Set(int)
    end


    items.menu = {}

    items.add = function()
        if menu.get_index() >= items.max_count then
            return
        end

        menu.set_index(menu.get_index() + 1)

        table.insert(items.menu, Menu.SliderInt("Anti-Aim", "Anti-brute", ("#%s"):format(menu.get_index()), 30, 0, 60))
    end

    items.remove = function()
        if menu.get_index() <= items.min_count then
            return
        end

        Menu.DestroyItem(items.menu[menu.get_index()])
        table.remove(items.menu, menu.get_index())

        menu.set_index(menu.get_index() - 1)
    end

    menu.add = Menu.Button("Anti-Aim", "Anti-brute", "                               Add new phase                        ", "", items.add)
    menu.remove = Menu.Button("Anti-Aim", "Anti-brute", "                           Remove old phase                      ", "", items.remove)


    for load_index = 1, menu.get_index() do
        table.insert(items.menu, Menu.SliderInt("Anti-Aim", "Anti-brute", ("#%s"):format(load_index), 30, 0, 60))
    end
    uisexcustom_cheat_name = Menu.TextBox("Visuals", "UI", "Watermark cheat", 20, "")
    uisexcustom_username = Menu.TextBox("Visuals", "UI", "Watermark username", 20, "")
    color_main = Menu.ColorEdit("Visuals", "Indicators", "Main color", Color.new(1, 1, 1, 1), "")
    color_accent = Menu.ColorEdit("Visuals", "Indicators", "Accent color", Color.new(0.6, 0.8, 1, 1), "")
    desyncarrowscolors = Menu.ColorEdit("Visuals", "General", "Desync Arrows color", Color.new(1.0, 1.0, 1.0, 1.0))
    uisexline_color = Menu.ColorEdit("Visuals", "UI", "Line color", color(100, 100, 255, 255))
    local cl_predictweapons = CVar.FindVar("cl_predictweapons")
    local cl_predict_basetoggles = CVar.FindVar("cl_predict_basetoggles")
    local ffi = require("ffi")
    user32, kernel32 = ffi.load("USER32"), ffi.load("KERNEL32")

    ffi.cdef [[
        typedef struct tagPOINT {
            long x;
            long y;
        } POINT;
    
        bool GetCursorPos(
            POINT* lpPoint
        );
    ]]

    pointer = ffi.new("POINT[1]")
    ffi.cdef [[
        enum { CF_TEXT = 1 };
        int      OpenClipboard(void*);
        void*    GetClipboardData(unsigned);
        int      CloseClipboard();
        void*    GlobalLock(void*);
        int      GlobalUnlock(void*);
        size_t   GlobalSize(void*);
            typedef void(__thiscall* asp_t)(void*, const char*, const char*, int);
            typedef bool(__thiscall* rsp_t)(void*, const char*, const char*);
            typedef int(__thiscall* gcpbs_t)(void*);
            typedef int(__thiscall* gcpbt_t)(void*, int,  char*, int);
            typedef char(__thiscall* gcd_t)(void*, char*, int);
            typedef bool(__thiscall* mv_t)(void*, const char*, const char*, const char*);
            typedef int(__thiscall* get_clipboard_text_count)(void*);
            typedef void(__thiscall* set_clipboard_text)(void*, const char*, int);
            typedef void(__thiscall* get_clipboard_text)(void*, int, const char*, int);
        void* CreateFileA(
            const char*                lpFileName,
            unsigned long                 dwDesiredAccess,
            unsigned long                 dwShareMode,
            unsigned long lpSecurityAttributes,
            unsigned long                 dwCreationDisposition,
            unsigned long                 dwFlagsAndAttributes,
            void*                hTemplateFile
        );
        short GetKeyState(
            int nVirtKey
        );
        bool ReadFile(
            void*       hFile,
            char*       lpBuffer,
            unsigned long        nNumberOfBytesToRead,
            unsigned long*      lpNumberOfBytesRead,
            int lpOverlapped
        );
        bool WriteFile(
            void*       hFile,
            char*      lpBuffer,
            unsigned long        nNumberOfBytesToWrite,
            unsigned long*      lpNumberOfBytesWritten,
            int lpOverlapped
        );
        unsigned long GetFileSize(
            void*  hFile,
            unsigned long* lpFileSizeHigh
        );
        void* CloseHandle(void *hFile);
        int MessageBoxA(void *w, const char *txt, const char *cap, int type);
        bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
        int exit(int arg);
    
        void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);        
        void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
    
        int AddFontResourceA(const char* unnamedParam1);
    
        bool DeleteUrlCacheEntryA(const char* lpszUrlName);
        typedef int BOOL;
        typedef long LONG;
        typedef struct{
            LONG x, y;
        }POINT, *LPPOINT;
        BOOL GetCursorPos(LPPOINT);
        short GetAsyncKeyState(int);
        void* GetProcAddress(void* hModule, const char* lpProcName);
        void* GetModuleHandleA(const char* lpModuleName);
        
        typedef struct {
          uint8_t r;
          uint8_t g;
          uint8_t b;
          uint8_t a;
      } color_struct_t;
  
      typedef void (*console_color_print)(const color_struct_t&, const char*, ...);
    
        typedef struct
        {
            unsigned char r, g, b;
            signed char exponent;
        } ColorRGBExp32;
    
        typedef struct
        {
            float x;
            float y;
            float z;
        } vec3_t;
    
        typedef struct
        {
            int		flags;
            vec3_t	origin;
            float	radius;
            ColorRGBExp32	color;
            float	die;
            float	decay;
            float	minlight;
            int		key;
            int		style;
            vec3_t	m_Direction;
            float	m_InnerAngle;
            float	m_OuterAngle;
        } dlight_t, *dlight_ptr_t;
    
        typedef dlight_ptr_t(__thiscall* alloc_dlight_t)(void*, int);
        typedef dlight_ptr_t(__thiscall* alloc_elight_t)(void*, int);
        typedef dlight_ptr_t(__thiscall* get_elight_by_key_t)(void*, int);
        typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
        typedef int(__fastcall* clantag_t)(const char*, const char*);
        struct c_animstate { 
            char pad[ 3 ];
            char m_bForceWeaponUpdate; //0x4
            char pad1[ 91 ];
            void* m_pBaseEntity; //0x60
            void* m_pActiveWeapon; //0x64
            void* m_pLastActiveWeapon; //0x68
            float m_flLastClientSideAnimationUpdateTime; //0x6C
            int m_iLastClientSideAnimationUpdateFramecount; //0x70
            float m_flAnimUpdateDelta; //0x74
            float m_flEyeYaw; //0x78
            float m_flPitch; //0x7C
            float m_flGoalFeetYaw; //0x80
            float m_flCurrentFeetYaw; //0x84
            float m_flCurrentTorsoYaw; //0x88
            float m_flUnknownVelocityLean; //0x8C
            float m_flLeanAmount; //0x90
            char pad2[ 4 ];
            float m_flFeetCycle; //0x98
            float m_flFeetYawRate; //0x9C
            char pad3[ 4 ];
            float m_fDuckAmount; //0xA4
            float m_fLandingDuckAdditiveSomething; //0xA8
            char pad4[ 4 ];
            float m_vOriginX; //0xB0
            float m_vOriginY; //0xB4
            float m_vOriginZ; //0xB8
            float m_vLastOriginX; //0xBC
            float m_vLastOriginY; //0xC0
            float m_vLastOriginZ; //0xC4
            float m_vVelocityX; //0xC8
            float m_vVelocityY; //0xCC
            char pad5[ 4 ];
            float m_flUnknownFloat1; //0xD4
            char pad6[ 8 ];
            float m_flUnknownFloat2; //0xE0
            float m_flUnknownFloat3; //0xE4
            float m_flUnknown; //0xE8
            float m_flSpeed2D; //0xEC
            float m_flUpVelocity; //0xF0
            float m_flSpeedNormalized; //0xF4
            float m_flFeetSpeedForwardsOrSideWays; //0xF8
            float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
            float m_flTimeSinceStartedMoving; //0x100
            float m_flTimeSinceStoppedMoving; //0x104
            bool m_bOnGround; //0x108
            bool m_bInHitGroundAnimation; //0x109
            float m_flTimeSinceInAir; //0x10A
            float m_flLastOriginZ; //0x10E
            float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
            float m_flStopToFullRunningFraction; //0x116
            char pad7[ 4 ]; //0x11A
            float m_flMagicFraction; //0x11E
            char pad8[ 60 ]; //0x122
            float m_flWorldForce; //0x15E
            char pad9[ 462 ]; //0x162
            float m_flMaxYaw; //0x334
        };
        struct animation_layer_t {
            char pad20[24];
            uint32_t m_nSequence;
            float m_flPrevCycle;
            float m_flWeight;
            char pad20[8];
            float m_flCycle;
            void *m_pOwner;
            char pad_0038[ 4 ];
        };
    ]]


    local ffi_helpers = {
        get_animstate_offset = function()
            return 14612
        end,
        get_entity_address = function(ent_index)
            local addr = get_client_entity_fn(entity_list_ptr, ent_index)
            return addr
        end,
        color_print_fn = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ")),
        color_print = function(self, text, color)
            local col = ffi.new("color_struct_t")

            col.r = color.r * 255
            col.g = color.g * 255
            col.b = color.b * 255
            col.a = color.a * 255

            self.color_print_fn(col, text)
        end
    }


    local function coloredPrint(color, text)
        ffi_helpers.color_print(ffi_helpers, text, color)
    end

    local json = { _version = "0.1.2" }

    -------------------------------------------------------------------------------
    -- Encode
    -------------------------------------------------------------------------------

    local encode

    local escape_char_map = {
        ["\\"] = "\\",
        ["\""] = "\"",
        ["\b"] = "b",
        ["\f"] = "f",
        ["\n"] = "n",
        ["\r"] = "r",
        ["\t"] = "t",
    }

    local escape_char_map_inv = { ["/"] = "/" }
    for k, v in pairs(escape_char_map) do
        escape_char_map_inv[v] = k
    end


    local function escape_char(c)
        return "\\" .. (escape_char_map[c] or string.format("u%04x", c:byte()))
    end

    local function encode_nil(val)
        return "null"
    end

    local function encode_table(val, stack)
        local res = {}
        stack = stack or {}

        -- Circular reference?
        if stack[val] then error("circular reference") end

        stack[val] = true

        if rawget(val, 1) ~= nil or next(val) == nil then
            -- Treat as array -- check keys are valid and it is not sparse
            local n = 0
            for k in pairs(val) do
                if type(k) ~= "number" then
                    error("invalid table: mixed or invalid key types")
                end
                n = n + 1
            end
            if n ~= #val then
                error("invalid table: sparse array")
            end
            -- Encode
            for i, v in ipairs(val) do
                table.insert(res, encode(v, stack))
            end
            stack[val] = nil
            return "[" .. table.concat(res, ",") .. "]"

        else
            -- Treat as an object
            for k, v in pairs(val) do
                if type(k) ~= "string" then
                    error("invalid table: mixed or invalid key types")
                end
                table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
            end
            stack[val] = nil
            return "{" .. table.concat(res, ",") .. "}"
        end
    end

    local function encode_string(val)
        return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
    end

    local function encode_number(val)
        -- Check for NaN, -inf and inf
        if val ~= val or val <= -math.huge or val >= math.huge then
            error("unexpected number value '" .. tostring(val) .. "'")
        end
        return string.format("%.14g", val)
    end

    local type_func_map = {
        ["nil"] = encode_nil,
        ["table"] = encode_table,
        ["string"] = encode_string,
        ["number"] = encode_number,
        ["boolean"] = tostring,
    }


    encode = function(val, stack)
        local t = type(val)
        local f = type_func_map[t]
        if f then
            return f(val, stack)
        end
        error("unexpected type '" .. t .. "'")
    end


    function json.encode(val)
        return (encode(val))
    end

    -------------------------------------------------------------------------------
    -- Decode
    -------------------------------------------------------------------------------

    local parse

    local function create_set(...)
        local res = {}
        for i = 1, select("#", ...) do
            res[select(i, ...)] = true
        end
        return res
    end

    local space_chars  = create_set(" ", "\t", "\r", "\n")
    local delim_chars  = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
    local escape_chars = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
    local literals     = create_set("true", "false", "null")

    local literal_map = {
        ["true"] = true,
        ["false"] = false,
        ["null"] = nil,
    }


    local function next_char(str, idx, set, negate)
        for i = idx, #str do
            if set[str:sub(i, i)] ~= negate then
                return i
            end
        end
        return #str + 1
    end

    local function decode_error(str, idx, msg)
        local line_count = 1
        local col_count = 1
        for i = 1, idx - 1 do
            col_count = col_count + 1
            if str:sub(i, i) == "\n" then
                line_count = line_count + 1
                col_count = 1
            end
        end
        error(string.format("%s at line %d col %d", msg, line_count, col_count))
    end

    local function codepoint_to_utf8(n)
        -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
        local f = math.floor
        if n <= 0x7f then
            return string.char(n)
        elseif n <= 0x7ff then
            return string.char(f(n / 64) + 192, n % 64 + 128)
        elseif n <= 0xffff then
            return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
        elseif n <= 0x10ffff then
            return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
                f(n % 4096 / 64) + 128, n % 64 + 128)
        end
        error(string.format("invalid unicode codepoint '%x'", n))
    end

    local function parse_unicode_escape(s)
        local n1 = tonumber(s:sub(1, 4), 16)
        local n2 = tonumber(s:sub(7, 10), 16)
        -- Surrogate pair?
        if n2 then
            return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
        else
            return codepoint_to_utf8(n1)
        end
    end

    local function parse_string(str, i)
        local res = ""
        local j = i + 1
        local k = j

        while j <= #str do
            local x = str:byte(j)

            if x < 32 then
                decode_error(str, j, "control character in string")

            elseif x == 92 then -- `\`: Escape
                res = res .. str:sub(k, j - 1)
                j = j + 1
                local c = str:sub(j, j)
                if c == "u" then
                    local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
                        or str:match("^%x%x%x%x", j + 1)
                        or decode_error(str, j - 1, "invalid unicode escape in string")
                    res = res .. parse_unicode_escape(hex)
                    j = j + #hex
                else
                    if not escape_chars[c] then
                        decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
                    end
                    res = res .. escape_char_map_inv[c]
                end
                k = j + 1

            elseif x == 34 then -- `"`: End of string
                res = res .. str:sub(k, j - 1)
                return res, j + 1
            end

            j = j + 1
        end

        decode_error(str, i, "expected closing quote for string")
    end

    local function parse_number(str, i)
        local x = next_char(str, i, delim_chars)
        local s = str:sub(i, x - 1)
        local n = tonumber(s)
        if not n then
            decode_error(str, i, "invalid number '" .. s .. "'")
        end
        return n, x
    end

    local function parse_literal(str, i)
        local x = next_char(str, i, delim_chars)
        local word = str:sub(i, x - 1)
        if not literals[word] then
            decode_error(str, i, "invalid literal '" .. word .. "'")
        end
        return literal_map[word], x
    end

    local function parse_array(str, i)
        local res = {}
        local n = 1
        i = i + 1
        while 1 do
            local x
            i = next_char(str, i, space_chars, true)
            -- Empty / end of array?
            if str:sub(i, i) == "]" then
                i = i + 1
                break
            end
            -- Read token
            x, i = parse(str, i)
            res[n] = x
            n = n + 1
            -- Next token
            i = next_char(str, i, space_chars, true)
            local chr = str:sub(i, i)
            i = i + 1
            if chr == "]" then break end
            if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
        end
        return res, i
    end

    local function parse_object(str, i)
        local res = {}
        i = i + 1
        while 1 do
            local key, val
            i = next_char(str, i, space_chars, true)
            -- Empty / end of object?
            if str:sub(i, i) == "}" then
                i = i + 1
                break
            end
            -- Read key
            if str:sub(i, i) ~= '"' then
                decode_error(str, i, "expected string for key")
            end
            key, i = parse(str, i)
            -- Read ':' delimiter
            i = next_char(str, i, space_chars, true)
            if str:sub(i, i) ~= ":" then
                decode_error(str, i, "expected ':' after key")
            end
            i = next_char(str, i + 1, space_chars, true)
            -- Read value
            val, i = parse(str, i)
            -- Set
            res[key] = val
            -- Next token
            i = next_char(str, i, space_chars, true)
            local chr = str:sub(i, i)
            i = i + 1
            if chr == "}" then break end
            if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
        end
        return res, i
    end

    local char_func_map = {
        ['"'] = parse_string,
        ["0"] = parse_number,
        ["1"] = parse_number,
        ["2"] = parse_number,
        ["3"] = parse_number,
        ["4"] = parse_number,
        ["5"] = parse_number,
        ["6"] = parse_number,
        ["7"] = parse_number,
        ["8"] = parse_number,
        ["9"] = parse_number,
        ["-"] = parse_number,
        ["t"] = parse_literal,
        ["f"] = parse_literal,
        ["n"] = parse_literal,
        ["["] = parse_array,
        ["{"] = parse_object,
    }


    parse = function(str, idx)
        local chr = str:sub(idx, idx)
        local f = char_func_map[chr]
        if f then
            return f(str, idx)
        end
        decode_error(str, idx, "unexpected character '" .. chr .. "'")
    end


    function json.decode(str)
        if type(str) ~= "string" then
            error("expected argument of type string, got " .. type(str))
        end
        local res, idx = parse(str, next_char(str, 1, space_chars, true))
        idx = next_char(str, idx, space_chars, true)
        if idx <= #str then
            decode_error(str, idx, "trailing garbage")
        end
        return res
    end

    local bit = require "bit"
    local M = {}

    local shl, shr, band = bit.lshift, bit.rshift, bit.band
    local char, byte, gsub, sub, format, concat, tostring, error, pairs =
    string.char,
        string.byte,
        string.gsub,
        string.sub,
        string.format,
        table.concat,
        tostring,
        error,
        pairs

    local extract = function(v, from, width)
        return band(shr(v, from), shl(1, width) - 1)
    end

    local function makeencoder(alphabet)
        local encoder, decoder = {}, {}
        for i = 1, 65 do
            local chr = byte(sub(alphabet, i, i)) or 32 -- or " "
            if decoder[chr] ~= nil then
                error("invalid alphabet: duplicate character " .. tostring(chr), 3)
            end
            encoder[i - 1] = chr
            decoder[chr] = i - 1
        end
        return encoder, decoder
    end

    local encoders, decoders = {}, {}

    encoders["base64"], decoders["base64"] = makeencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=")
    encoders["base64url"], decoders["base64url"] = makeencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")

    local alphabet_mt = {
        __index = function(tbl, key)
            if type(key) == "string" and key:len() == 64 or key:len() == 65 then
                -- if key is a valid looking base64 alphabet, try to make an encoder/decoder pair from it
                encoders[key], decoders[key] = makeencoder(key)
                return tbl[key]
            end
        end
    }

    setmetatable(encoders, alphabet_mt)
    setmetatable(decoders, alphabet_mt)

    function M.encode(str, encoder)
        encoder = encoders[encoder or "base64"] or error("invalid alphabet specified", 2)

        str = tostring(str)

        local t, k, n = {}, 1, #str
        local lastn = n % 3
        local cache = {}

        for i = 1, n - lastn, 3 do
            local a, b, c = byte(str, i, i + 2)
            local v = a * 0x10000 + b * 0x100 + c
            local s = cache[v]

            if not s then
                s = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)], encoder[extract(v, 0, 6)])
                cache[v] = s
            end

            t[k] = s
            k = k + 1
        end

        if lastn == 2 then
            local a, b = byte(str, n - 1, n)
            local v = a * 0x10000 + b * 0x100
            t[k] = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)], encoder[64])
        elseif lastn == 1 then
            local v = byte(str, n) * 0x10000
            t[k] = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[64], encoder[64])
        end

        return concat(t)
    end

    function M.decode(b64, decoder)
        decoder = decoders[decoder or "base64"] or error("invalid alphabet specified", 2)

        local pattern = "[^%w%+%/%=]"
        if decoder then
            local s62, s63
            for charcode, b64code in pairs(decoder) do
                if b64code == 62 then
                    s62 = charcode
                elseif b64code == 63 then
                    s63 = charcode
                end
            end
            pattern = format("[^%%w%%%s%%%s%%=]", char(s62), char(s63))
        end

        b64 = gsub(tostring(b64), pattern, "")

        local cache = {}
        local t, k = {}, 1
        local n = #b64
        local padding = sub(b64, -2) == "==" and 2 or sub(b64, -1) == "=" and 1 or 0

        for i = 1, padding > 0 and n - 4 or n, 4 do
            local a, b, c, d = byte(b64, i, i + 3)

            local v0 = a * 0x1000000 + b * 0x10000 + c * 0x100 + d
            local s = cache[v0]
            if not s then
                local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40 + decoder[d]
                s = char(extract(v, 16, 8), extract(v, 8, 8), extract(v, 0, 8))
                cache[v0] = s
            end

            t[k] = s
            k = k + 1
        end

        if padding == 1 then
            local a, b, c = byte(b64, n - 3, n - 1)
            local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40
            t[k] = char(extract(v, 16, 8), extract(v, 8, 8))
        elseif padding == 2 then
            local a, b = byte(b64, n - 3, n - 2)
            local v = decoder[a] * 0x40000 + decoder[b] * 0x1000
            t[k] = char(extract(v, 16, 8))
        end
        return concat(t)
    end

    function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end

    username = Cheat.GetCheatUserName():gsub("%#", "_")
    local string1 = ""
    local string2 = ""
    local mama = 0
    local mama2 = 0
    local tata = tablelength(cfg)
    ffi.cdef [[
        typedef int(__thiscall* get_clipboard_text_count)(void*);
        typedef void(__thiscall* set_clipboard_text)(void*, const char*, int);
        typedef void(__thiscall* get_clipboard_text)(void*, int, const char*, int);
    ]]

    local VGUI_System = ffi.cast("void***", Utils.CreateInterface("vgui2.dll", "VGUI_System010"))
    local get_clipboard_text_count = ffi.cast("get_clipboard_text_count", VGUI_System[0][7])
    local set_clipboard_text = ffi.cast("set_clipboard_text", VGUI_System[0][9])
    local get_clipboard_text = ffi.cast("get_clipboard_text", VGUI_System[0][11])

    local function clipboard_import()
        local clipboard_text_length = get_clipboard_text_count(VGUI_System)
        local clipboard_data = ""

        if clipboard_text_length > 0 then
            buffer = ffi.new("char[?]", clipboard_text_length)
            size = clipboard_text_length * ffi.sizeof("char[?]", clipboard_text_length)

            get_clipboard_text(VGUI_System, 0, buffer, size)

            clipboard_data = ffi.string(buffer, clipboard_text_length - 1)
        end
        return clipboard_data
    end

    local function clipboard_export(string)
        if string then
            set_clipboard_text(VGUI_System, string, string:len())
        end
    end

    function Split(s, delimiter)
        result = {};
        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match);
        end
        return result;
    end

    local last
    function count(base, pattern)
        return select(2, string.gsub(base, pattern, ""))
    end

    local cfglistcloud
    asdhsahdashbkdahskb = Menu.TextBox("Config", "Main", "CFG Name", 10000, "")
    sadhgiashgidashgdashg = Menu.TextBox("Config", "Main", "Config Code", 10000, "")
    local cfglistcloud
    local currentcfgname
    local currentcfgname2 = "Unknown"
    local currentcfgauthor2 = "Unknown"
    local currentcfgauthor
    local jsonraw
    local refreshcloud = Menu.Button("Config", "Main", " 																	               Refresh                                        	   				 							 ", "", function()
        lmaooooo = Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()):sub(1, -2)
        cfgcount = count(Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()), ';')
        elements = Split(lmaooooo, ";")
        Menu.DestroyItem(cfglistcloud)
        cfglistcloud = Menu.Combo("Config", "Main", "", elements, 0)
        Menu.DestroyItem(currentcfgname)
        Menu.DestroyItem(currentcfgauthor)
        currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: " .. currentcfgname2)
        currentcfgauthor = Menu.Text("Config", "Main", "Config author: " .. currentcfgauthor2)
    end)
    savecloud = Menu.Button("Config", "Main", " 																	                 Save                                         	   				 							 ", "", function()
        for index, object in pairs(cfg) do
            if mama < tablelength(cfg) - 1 then
                mama = mama + 1
                string1 = string1 .. tostring(object:Get()) .. ','
            else
                string1 = string1 .. tostring(object:Get())
            end
        end
        for index, object in pairs(items.menu) do
            if mama2 < menu.index:Get() - 1 then
                mama2 = mama2 + 1
                string2 = string2 .. tostring(object:Get()) .. ','
            else
                string2 = string2 .. tostring(object:Get())
            end
        end
        if currentcfgauthor2 == "Unknown" then
            jsonraw = '{"Settings":[' .. string1 .. '], "BruteForce":[' .. string2 .. '], "BruteForcePhases":[' .. menu.index:Get() .. '], "UserName":["' .. username .. '"], "CfgName":["' .. elements[cfglistcloud:GetInt() + 1] .. '"]}'
        elseif currentcfgauthor2 ~= username then
            jsonraw = '{"Settings":[' .. string1 .. '], "BruteForce":[' .. string2 .. '], "BruteForcePhases":[' .. menu.index:Get() .. '], "UserName":["' .. currentcfgauthor2 .. '"], "CfgName":["' .. elements[cfglistcloud:GetInt() + 1] .. '"]}'
        else
            jsonraw = '{"Settings":[' .. string1 .. '], "BruteForce":[' .. string2 .. '], "BruteForcePhases":[' .. menu.index:Get() .. '], "UserName":["' .. username .. '"], "CfgName":["' .. elements[cfglistcloud:GetInt() + 1] .. '"]}'
        end
        if asdhsahdashbkdahskb:GetString() == "" or asdhsahdashbkdahskb:GetString() == nil then
            Http.Get("https://exodus.wtf/bard/add_cfg.php?user=" .. Cheat.GetCheatUserName() .. "&cfgname=" .. elements[cfglistcloud:GetInt() + 1] .. "&cfg=" .. M.encode(jsonraw))
        else
            Http.Get("https://exodus.wtf/bard/add_cfg.php?user=" .. Cheat.GetCheatUserName() .. "&cfgname=" .. asdhsahdashbkdahskb:GetString() .. "&cfg=" .. M.encode(jsonraw))
        end
        mama = 0
        mama2 = 0
        string1 = ""
        string2 = ""
        lmaooooo = Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()):sub(1, -2)
        cfgcount = count(Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()), ';')
        elements = Split(lmaooooo, ";")
        Menu.DestroyItem(cfglistcloud)
        cfglistcloud = Menu.Combo("Config", "Main", "", elements, 0)
        Menu.DestroyItem(currentcfgname)
        Menu.DestroyItem(currentcfgauthor)
        currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: " .. currentcfgname2)
        currentcfgauthor = Menu.Text("Config", "Main", "Config author: " .. currentcfgauthor2)
        asdhsahdashbkdahskb:SetString("")
    end)
    loadcloud = Menu.Button("Config", "Main", " 																	                 Load                                         	   				 							 ", "", function()
        local jsonparse = json.decode(M.decode(Http.Get("https://exodus.wtf/bard/getcfg.php?user=" .. 'SmoK' .. "&cfg=" .. elements[cfglistcloud:GetInt() + 1])))
        for i = 1, jsonparse["BruteForcePhases"][1] - menu.index:Get() do
            items.add()
        end

        for index, object in pairs(cfg) do
            mama = mama + 1
            object:Set(jsonparse["Settings"][mama])
        end

        for index, object in pairs(items.menu) do
            mama2 = mama2 + 1
            object:Set(jsonparse["BruteForce"][mama2])
        end
        mama = 0
        mama2 = 0
        string1 = ""
        string2 = ""
        asdhsahdashbkdahskb:SetString("")
        Cheat.AddNotify("Success", "Loaded " .. elements[cfglistcloud:GetInt() + 1])
        Menu.DestroyItem(currentcfgname)
        Menu.DestroyItem(currentcfgauthor)
        currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: " .. elements[cfglistcloud:GetInt() + 1])
        currentcfgname2 = elements[cfglistcloud:GetInt() + 1]
        currentcfgauthor = Menu.Text("Config", "Main", "Config author: " .. jsonparse["UserName"][1])
        currentcfgauthor2 = jsonparse["UserName"][1]
    end)
    deletecloud = Menu.Button("Config", "Main", " 																	               Delete                                         	   				 							 ", "", function()
        Http.Get("https://exodus.wtf/bard/del_cfg.php?user=" .. Cheat.GetCheatUserName() .. "&cfgname=" .. elements[cfglistcloud:GetInt() + 1])
        lmaooooo = Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()):sub(1, -2)
        cfgcount = count(Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()), ';')
        elements = Split(lmaooooo, ";")
        Menu.DestroyItem(cfglistcloud)
        Menu.DestroyItem(currentcfgname)
        Menu.DestroyItem(currentcfgauthor)
        cfglistcloud = Menu.Combo("Config", "Main", "", elements, 0)
        currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: Unknown")
        currentcfgauthor = Menu.Text("Config", "Main", "Config author: Unknown")
    end)
    import = Menu.Button("Config", "Main", "																	         Use 1-time code                          							 							", "", function()
        getsharedcfgowo = Http.Get(string.format("https://exodus.wtf/bard/getsharedcfg.php?user=%s&cfg=%s", Cheat.GetCheatUserName(), sadhgiashgidashgdashg:GetString()))
        if getsharedcfgowo == "error" then
            Cheat.AddNotify("Error", "Failed to get config")
            return
        elseif getsharedcfgowo == "error2" then
            Cheat.AddNotify("Error", "Failed to get config")
        else
            Cheat.AddNotify("Success", "Successfully got cfg")
        end
        lmaooooo = Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()):sub(1, -2)
        cfgcount = count(Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()), ';')
        elements = Split(lmaooooo, ";")
        Menu.DestroyItem(cfglistcloud)
        cfglistcloud = Menu.Combo("Config", "Main", "", elements, 0)
        Menu.DestroyItem(currentcfgname)
        Menu.DestroyItem(currentcfgauthor)
        currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: " .. currentcfgname2)
        currentcfgauthor = Menu.Text("Config", "Main", "Config author: " .. currentcfgauthor2)
    end)
    export = Menu.Button("Config", "Main", "																	       Create 1-time code                     							 							 ", "", function()
        local onetimecode = Http.Get("https://exodus.wtf/bard/sharecfg.php?user=" .. Cheat.GetCheatUserName() .. "&cfg=" .. elements[cfglistcloud:GetInt() + 1])
        if onetimecode == "error" then
            Cheat.AddNotify("Error", "You don't have permission to share this config")
            return
        else
            Cheat.AddNotify("Success", "1-time code copied to clipboard")
            clipboard_export(onetimecode)
        end
    end)

    local function coloredPrint(color, text)
        ffi_helpers.color_print(ffi_helpers, text, color)
    end

    local function text_color(alpha)
        return Color.new(0.9, 0.9, 0.9, 0.95 * alpha)
    end

    local function color(r, g, b, a) return Color.new(r / 255, g / 255, b / 255, a / 255) end

    local function in_box(mouse, x, y, x2, y2) return (mouse.x > x) and (mouse.y > y) and (mouse.x < x2) and (mouse.y < y2) end

    local function clamp(val, min, max) if val > max then return max end if min > val then return min end return val end

    local fakelaglimitmad = Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Limit")
    -- LUA Info
    subssex = Menu.Text("Info", "Info", days .. " Days Remaining")
    local defaultsett = Menu.Button("Config", "Main", "							 							    	            Load Default CFG             	      						 							 ", "", function()
        local jsonparse = json.decode(M.decode(Http.Get("https://exodus.wtf/config.txt", true)))
        for i = 1, jsonparse["BruteForcePhases"][1] - menu.index:Get() do
            items.add()
        end

        for index, object in pairs(cfg) do
            mama = mama + 1
            object:Set(jsonparse["Settings"][mama])
        end

        for index, object in pairs(items.menu) do
            mama2 = mama2 + 1
            object:Set(jsonparse["BruteForce"][mama2])
        end
        print("\n Success loaded Default CFG!")
        mama = 0
        mama2 = 0
        string1 = ""
        string2 = ""
        asdhsahdashbkdahskb:SetString("")
    end)
    lmaooooo = Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()):sub(1, -2)
    elements = Split(lmaooooo, ";")
    cfgcount = count(Http.Get("https://exodus.wtf/bard/getcfglist.php?user=" .. Cheat.GetCheatUserName()), ';')
    cfglistcloud = Menu.Combo("Config", "Main", "", elements, 0)
    currentcfgname = Menu.Text("Config", "Main", "Currently loaded config: Unknown")
    currentcfgauthor = Menu.Text("Config", "Main", "Config author: Unknown")
    mathhypot = function(a, b)
        return math.sqrt(a * a + b * b)
    end
    noti = false
    aa = 0
    switch = 0
    local lbyb = 0
    ffi.cdef [[
        typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    struct c_animstate_128983475223458080 { 
        char pad[ 3 ];
        char m_bForceWeaponUpdate; //0x4
        char pad1[ 91 ];
        void* m_pBaseEntity; //0x60
        void* m_pActiveWeapon; //0x64
        void* m_pLastActiveWeapon; //0x68
        float m_flLastClientSideAnimationUpdateTime; //0x6C
        int m_iLastClientSideAnimationUpdateFramecount; //0x70
        float m_flAnimUpdateDelta; //0x74
        float m_flEyeYaw; //0x78
        float m_flPitch; //0x7C
        float m_flGoalFeetYaw; //0x80
        float m_flCurrentFeetYaw; //0x84
        float m_flCurrentTorsoYaw; //0x88
        float m_flUnknownVelocityLean; //0x8C
        float m_flLeanAmount; //0x90
        char pad2[ 4 ];
        float m_flFeetCycle; //0x98
        float m_flFeetYawRate; //0x9C
        char pad3[ 4 ];
        float m_fDuckAmount; //0xA4
        float m_fLandingDuckAdditiveSomething; //0xA8
        char pad4[ 4 ];
        float m_vOriginX; //0xB0
        float m_vOriginY; //0xB4
        float m_vOriginZ; //0xB8
        float m_vLastOriginX; //0xBC
        float m_vLastOriginY; //0xC0
        float m_vLastOriginZ; //0xC4
        float m_vVelocityX; //0xC8
        float m_vVelocityY; //0xCC
        char pad5[ 4 ];
        float m_flUnknownFloat1; //0xD4
        char pad6[ 8 ];
        float m_flUnknownFloat2; //0xE0
        float m_flUnknownFloat3; //0xE4
        float m_flUnknown; //0xE8
        float m_flSpeed2D; //0xEC
        float m_flUpVelocity; //0xF0
        float m_flSpeedNormalized; //0xF4
        float m_flFeetSpeedForwardsOrSideWays; //0xF8
        float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
        float m_flTimeSinceStartedMoving; //0x100
        float m_flTimeSinceStoppedMoving; //0x104
        bool m_bOnGround; //0x108
        bool m_bInHitGroundAnimation; //0x109
        float m_flTimeSinceInAir; //0x10A
        float m_flLastOriginZ; //0x10E
        float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
        float m_flStopToFullRunningFraction; //0x116
        char pad7[ 4 ]; //0x11A
        float m_flMagicFraction; //0x11E
        char pad8[ 60 ]; //0x122
        float m_flWorldForce; //0x15E
        char pad9[ 462 ]; //0x162
        float m_flMaxYaw; //0x334
    };
    ]]
    local ref = {
        yaw_base = Menu.FindVar('Aimbot', 'Anti Aim', 'Main', 'Yaw Base'),
        yaw_add = Menu.FindVar('Aimbot', 'Anti Aim', 'Main', 'Yaw Add'),
        yaw_modifier = Menu.FindVar('Aimbot', 'Anti Aim', 'Main', 'Yaw Modifier'),
        modifier_degree = Menu.FindVar('Aimbot', 'Anti Aim', 'Main', 'Modifier Degree'),
        fake_options = Menu.FindVar('Aimbot', 'Anti Aim', 'Fake Angle', 'Fake Options'),
        lby_mode = Menu.FindVar('Aimbot', 'Anti Aim', 'Fake Angle', 'LBY Mode'),
        freestanding_desync = Menu.FindVar('Aimbot', 'Anti Aim', 'Fake Angle', 'Freestanding Desync'),
        slow_walk = Menu.FindVar('Aimbot', 'Anti Aim', 'Misc', 'Slow Walk')
    }
    local yaw_add_ref = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Add")
    local ref_modifier = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Modifier")
    local ref_modifier_off = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Modifier Degree")
    -- lmfao :)
    local ENTITY_LIST_POINTER = ffi.cast("void***", Utils.CreateInterface("client.dll", "VClientEntityList003")) or error("Failed to find VClientEntityList003!")
    local GET_CLIENT_ENTITY_FN = ffi.cast("GetClientEntity_4242425_t", ENTITY_LIST_POINTER[0][3])

    -- class of ffi_helpers
    -- edi sry for pasting ur ffi_helper :) <3
    local ffi_helpers = {

        -- get entity address.
        get_entity_address = function(entity_index)
            local addr = GET_CLIENT_ENTITY_FN(ENTITY_LIST_POINTER, entity_index)
            return addr
        end
    }
    local function on_ground(player)
        local flags = local_player:GetProp("DT_BasePlayer", "m_fFlags")

        if bit.band(flags, 1) == 1 then
            return true
        end

        return false
    end

    local function in_air(player)
        local flags = local_player:GetProp("DT_BasePlayer", "m_fFlags")

        if bit.band(flags, 1) == 0 then
            return true
        end

        return false
    end

    local peeking = false
    local canSeePlayer = function(plyr, localplayer)
        local plyrOrigin = plyr:GetProp("DT_BaseEntity", "m_vecOrigin");
        local localOrigin = localplayer:GetProp("DT_BaseEntity", "m_vecOrigin");
        local origins = { Vector.new(plyrOrigin.x, plyrOrigin.y, plyrOrigin.z + 80.0) };
        local lOrigins = { Vector.new(localOrigin.x, localOrigin.y, localOrigin.z + 80.0) };
        for i = 1, table.getn(lOrigins), 1 do
            for u = 1, table.getn(origins), 1 do
                if ((Cheat.FireBullet(localplayer:GetPlayer(), lOrigins[i], origins[u]).damage > 0) or (Cheat.FireBullet(plyr, lOrigins[i], origins[u]).damage > 0)) then
                    return true;
                end
            end
        end
        return false;
    end
    local function is_crouching(player)
        local flags = local_player:GetProp("DT_BasePlayer", "m_fFlags")

        if bit.band(flags, 4) == 4 then
            return true
        end

        return false
    end

    function under_health()
        local local_health = local_player:GetProp("m_iHealth")
        if local_health <= 92 then
            underhp = true
        else
            underhp = false
        end

        return underhp
    end

    local function is_local_peeked()
        local is_connected = EngineClient.IsConnected()
        if is_connected then
            peeking = false;
            local localPlayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer());
            local me = localPlayer:GetPlayer()
            local weapon = me:GetActiveWeapon()
            if weapon == nil then
                return
            end
            for i = 0, 32, 1 do
                local entity = EntityList.GetClientEntity(i)
                if (entity == nil or i == EngineClient.GetLocalPlayer() or not entity:IsPlayer()) then
                    return;
                end
                local player = entity:GetPlayer();
                if (player == nil or player:IsTeamMate()) then
                    return;
                end
                --local health = player:m_iHealth()
                local health = player:GetProp("DT_BasePlayer", "m_iHealth")

                local activeWeapon = player:GetActiveWeapon();
                if (activeWeapon == nil) then
                    return;
                end
                local next_primary_attack = activeWeapon:GetProp("DT_BaseCombatWeapon", "m_flNextPrimaryAttack")
                local canShoot = next_primary_attack < GlobalVars.curtime;
                if (canSeePlayer(player, localPlayer) and canShoot) then
                    peeking = true;
                end
            end
        end

        return peeking
    end

    Cheat.RegisterCallback("events", function(event)
        if event:GetName() ~= "player_hurt" then return end
        local me = EngineClient.GetLocalPlayer()
        local victim = EntityList.GetPlayerForUserID(event:GetInt("userid", 0))
        --local attacker = EngineClient.GetPlayerForUserId(event:GetInt("attacker"))
        local dmg_health = event:GetInt("dmg_health")
        hitgroup = event:GetString("hitgroup")
        local hitgroups = { "generic body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "unsure", "gear" }
        local hitbox = hitgroups[hitgroup + 1]

        if victim == me then
            local x = inverter_state

            --print( side )
            --print( dmg_health )
            --print( hitgroups[hitgroup+1] )

            -- global vars for debug text
            --attacker_x = attacker:GetName()
            hit_side = side
            last_dmg = dmg_health
            hit_hitbox = hitbox
        end
    end)
    function left_static()
        yaw_add_ref:SetInt(-4)
        ref_modifier:SetBool(-1, true)
        ref_modifier:SetBool(1, false)
        -- ref_modifier_off:SetInt( 0 )
    end

    function left_jitter() -- dynamic_plus_multicombo:GetBool( 2 )
        yaw_add_ref:SetInt(0)
        ref_modifier:SetBool(1, true)
        ref_modifier:SetBool(-1, false)
        -- ref_modifier_off:SetInt( 23 )
    end

    function right_static()
        yaw_add_ref:SetInt(5)
        ref_modifier:SetBool(-1, true)
        ref_modifier:SetBool(1, false)
        -- ref_modifier_off:SetInt( 0 )
    end

    function right_jitter() -- dynamic_plus_multicombo:GetBool( 2 )
        yaw_add_ref:SetInt(3)
        ref_modifier:SetBool(1, true)
        ref_modifier:SetBool(-1, false)
        -- ref_modifier_off:SetInt( 23 )
    end

    local normalize_yaw = function(m_flValue)

        while m_flValue < -180 do
            m_flValue = m_flValue + 360.0;
        end

        while m_flValue > 180 do
            m_flValue = m_flValue - 360.0;
        end

        return m_flValue;

    end

    -- basic clamp function lol.
    local clamp = function(value, low, high)

        if value <= low then
            return low
        end

        if value >= high then
            return high
        end

        return value

    end
    local m_max_delta = function()

        -- get local player.
        local _ent_idx = EngineClient.GetLocalPlayer()
        local _ent = EntityList.GetClientEntity(_ent_idx)
        local local_player = _ent:GetPlayer()

        -- Get a local player
        -- animstate ptr.
        local animstate = ffi.cast("struct c_animstate_128983475223458080**", ffi_helpers.get_entity_address(local_player:EntIndex()) + 0x9960)[0]

        -- if animstate is not initialized.
        if not animstate then
            return 0.0;
        end

        -- speed factor.
        local speedfactor = clamp(animstate.m_flFeetSpeedForwardsOrSideWays, 0.0, 1.0);

        --avr.
        local avg_speedfactor = (animstate.m_flStopToFullRunningFraction * -0.3 - 0.2) * speedfactor + 1.0;

        -- duckamount.
        local duck_amount = animstate.m_fDuckAmount;

        -- ducking.
        if duck_amount > 0.0 then

            -- animated max vel.
            local max_velocity = clamp(animstate.m_flFeetSpeedUnknownForwardOrSideways, 0.0, 1.0);

            -- duck speed.
            local duck_speed = duck_amount * max_velocity;

            -- recalc avg_speedfactor.
            avg_speedfactor = avg_speedfactor + (duck_speed * (0.5 - avg_speedfactor));
        end

        -- return :).
        return animstate.m_flMaxYaw * avg_speedfactor;

    end
    local ref_fs = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
    function handle_anti_aim()
        inverter_state = AntiAim.GetInverterState()


        if on_ground(local_player) and not in_air(local_player) then
            --print( under_health( ) )
            if under_health() == true then
                ref_fs:SetInt(2)
            elseif under_health() == false then
                -- IDEAL yaw option
                if (hit_hitbox == "left leg" or hit_hitbox == "right leg") and last_dmg < 27 then
                    -- print("IDEAL CALCULATION [ACTIVATED]")
                    ref_fs:SetInt(2)
                else
                    -- ref_fs:SetBool( 0, true )
                    -- ref_fs:SetBool( 1, false )
                    ref_fs:SetInt(1)
                end
            end

            -- in air anti aim improvements
            if in_air(local_player) and not on_ground(local_player) then
                if ClientState.m_choked_commands <= 1 then
                    ref_modifier:SetBool(-1, true)
                elseif ClientState.m_choked_commands > 1 then
                    ref_modifier:SetBool(1, true)
                end
            end
            if inverter_state == false then
                if is_local_peeked() then
                    left_jitter()
                else
                    left_static()
                end
            elseif inverter_state == true then
                if is_local_peeked() then
                    right_jitter()
                else
                    right_static()
                end
            end
        end
    end

    local t = 0
    local desync = 58
    mintanke = 55
    maxtanke = 62

    smartjittervalueone = 27
    smartjittervaluetwo = -15
    smartjittervaluethree = 47
    smartjittervaluefour = -23

    smartaaone = 30
    smartaatwo = 60

    multipleaaone = 35
    multipleaatwo = 60

    local_player = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
    local function prediction_callback()
        if local_player == nil then return end
        is_local_peeked()
        handle_anti_aim()
    end

    function smartaa()
        Menu_fake_option:SetInt(1)
        AntiAim.OverrideLimit(math.random(45, 80))
        Menu_left_limit:SetInt(math.random(smartaaone, smartaatwo))
        Menu_right_limit:SetInt(math.random(smartaaone, smartaatwo))
        ref_modifier_off:SetInt(0)
    end

    function multipleaa()
        Menu_fake_option:SetInt(Utils.RandomInt(2, 3))
        Menu_left_limit:SetInt(Utils.RandomInt(multipleaaone, multipleaatwo))
        Menu_right_limit:SetInt(Utils.RandomInt(multipleaaone, multipleaatwo))
        ref_modifier_off:SetInt(0)
    end

    function preferlowdeltaaa()
        Menu_fake_option:SetInt(1)
        AntiAim.OverrideLimit(math.random(15, 45))
        Menu_left_limit:SetInt(math.random(15, 35))
        Menu_right_limit:SetInt(math.random(15, 35))
        ref_modifier_off:SetInt(0)
    end

    function tankeaa()
        if t > GlobalVars.curtime then
            t = GlobalVars.curtime
        end
        if GlobalVars.curtime - t > 0.12 then
            t = GlobalVars.curtime
            desync = Utils.RandomInt(32, 60)
            ref.modifier_degree:Set(Utils.RandomInt(mintanke, maxtanke))
        end
        ref.yaw_add:Set(0)
        ref.fake_options:Set(1, false)
        ref.fake_options:Set(2, true)
        ref.fake_options:Set(3, false)
        ref.fake_options:Set(4, false)
        ref.yaw_modifier:Set(1)
        AntiAim.OverrideLimit(desync)
        ref.lby_mode:Set(0)
        ref.freestanding_desync:Set(0)
    end

    local function jittersex()
        if switch == 0 then
            switch = 12
            if aa == 0 then
                lbyb = 27
                aa = 1
            elseif aa == 1 then
                lbyb = -15
                aa = 2
            elseif aa == 2 then
                lbyb = 47
                aa = 3
            else
                lbyb = -23
                aa = 0
            end
        end
        if lbyb < 0 then
            AntiAim.OverrideInverter(true)
            AntiAim.OverrideLimit(lbyb * -1)
        else
            AntiAim.OverrideInverter(false)
            AntiAim.OverrideLimit(lbyb)
        end
        switch = switch - 1
        ref_modifier_off:SetInt(0)
    end

    function reversefreestanding()

        local_idx = EngineClient.GetLocalPlayer()
        local_entity = EntityList.GetClientEntity(local_idx)

        if local_entity == nil then
            return
        end
        local_player = local_entity:GetPlayer();
        speed_x = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[0]")
        speed_y = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[1]")
        speed = math.sqrt(speed_x * speed_x + speed_y * speed_y)
        local localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
        if not localplayer then return end
        local bOnGround = bit.band(localplayer:GetPlayer():GetProp("DT_BasePlayer", "m_fFlags"), bit.lshift(1, 0)) ~= 0
        speed_per_tick = math.sqrt(speed_x * speed_x + speed_y * speed_y) * GlobalVars.interval_per_tick
        if (cfg.ReverseFreeStand:GetBool()) then
            if math.floor(speed) <= 1 and bOnGround and cfg.ReverseFreeStand_Combo:GetBool(1) then -- standing
                Menu_freestand_desync:SetInt(2)
            elseif Menu_slowwalk:GetBool() == true and bOnGround and cfg.ReverseFreeStand_Combo:GetBool(4) then -- SlowWalk
                Menu_freestand_desync:SetInt(2)
            elseif math.floor(speed) > 1 and bOnGround and cfg.ReverseFreeStand_Combo:GetBool(2) and not Menu_slowwalk:GetBool() then -- Moving
                Menu_freestand_desync:SetInt(2)
            elseif not bOnGround and cfg.ReverseFreeStand_Combo:GetBool(3) then -- Air
                Menu_freestand_desync:SetInt(2)
            else
                Menu_freestand_desync:SetInt(1)
            end
        end
    end

    local leftlimit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Left Limit")
    local rightlimit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Right Limit")
    local fakeopt = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
    local lbymode = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
    local freestd = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
    local desyn = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
    local slowwalk = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Slow Walk")
    local inverter = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Inverter")
    function antiaim_helpers()

        local_idx = EngineClient.GetLocalPlayer()
        local_entity = EntityList.GetClientEntity(local_idx)


        if local_entity == nil then
            return
        end
        if cfg.IdealMode:GetBool() then
            prediction_callback()
        end
        local_player = local_entity:GetPlayer();
        speed_x = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[0]")
        speed_y = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[1]")
        speed = math.sqrt(speed_x * speed_x + speed_y * speed_y)
        local localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
        if not localplayer then return end
        local bOnGround = bit.band(localplayer:GetPlayer():GetProp("DT_BasePlayer", "m_fFlags"), bit.lshift(1, 0)) ~= 0
        speed_per_tick = math.sqrt(speed_x * speed_x + speed_y * speed_y) * GlobalVars.interval_per_tick
        if (cfg.desyncmod:GetBool()) then
            if math.floor(speed) <= 1 and bOnGround then -- standing
                if (cfg.desyncmodowostanding:GetInt() == 0) then --smart
                    smartaa()
                end
                if (cfg.desyncmodowostanding:GetInt() == 2) then --Multiple
                    multipleaa()
                end
                if (cfg.desyncmodowostanding:GetInt() == 1) then --prefer low delta
                    preferlowdeltaaa()
                end
                if (cfg.desyncmodowostanding:GetInt() == 3) then --Smart Jitter
                    jittersex()
                end
                if (cfg.desyncmodowostanding:GetInt() == 4) then --Smart Jitter
                    tankeaa()
                end
                if (cfg.desyncmodowostanding:GetInt() == 5) then --Custom
                    inverter:Set(cfg.sinv:Get())
                    leftlimit:Set(cfg.sleft:Get())
                    rightlimit:Set(cfg.sright:Get())
                    fakeopt:Set(cfg.sfkopt:Get())
                    lbymode:Set(cfg.slby:Get())
                    freestd:Set(cfg.sfr:Get())
                    desyn:Set(cfg.sdes:Get())
                    ref_modifier_off:SetInt(0)
                end
            elseif Menu_slowwalk:GetBool() == true and bOnGround then -- Moving
                if (cfg.desyncmodowoslowwalk:GetInt() == 0) then --smart
                    smartaa()
                end
                if (cfg.desyncmodowoslowwalk:GetInt() == 2) then --Multiple
                    multipleaa()
                end
                if (cfg.desyncmodowoslowwalk:GetInt() == 1) then --prefer low delta
                    preferlowdeltaaa()
                end
                if (cfg.desyncmodowoslowwalk:GetInt() == 3) then --Smart Jitter
                    jittersex()
                end
                if (cfg.desyncmodowoslowwalk:GetInt() == 4) then --Smart Jitter
                    tankeaa()
                end
                if (cfg.desyncmodowoslowwalk:GetInt() == 5) then --Custom
                    inverter:Set(cfg.swinv:Get())
                    leftlimit:Set(cfg.swleft:Get())
                    rightlimit:Set(cfg.swright:Get())
                    fakeopt:Set(cfg.swfkopt:Get())
                    lbymode:Set(cfg.swlby:Get())
                    freestd:Set(cfg.swfr:Get())
                    desyn:Set(cfg.swdes:Get())
                    ref_modifier_off:SetInt(0)
                end
            elseif math.floor(speed) > 1 and bOnGround and not Menu_slowwalk:GetBool() then -- Moving
                if (cfg.desyncmodowomoving:GetInt() == 0) then --smart
                    smartaa()
                end
                if (cfg.desyncmodowomoving:GetInt() == 2) then --Multiple
                    multipleaa()
                end
                if (cfg.desyncmodowomoving:GetInt() == 1) then --prefer low delta
                    preferlowdeltaaa()
                end
                if (cfg.desyncmodowomoving:GetInt() == 3) then --Smart Jitter
                    jittersex()
                end
                if (cfg.desyncmodowomoving:GetInt() == 4) then --Smart Jitter
                    tankeaa()
                end
                if (cfg.desyncmodowomoving:GetInt() == 5) then --Custom
                    inverter:Set(cfg.winv:Get())
                    leftlimit:Set(cfg.wleft:Get())
                    rightlimit:Set(cfg.wright:Get())
                    fakeopt:Set(cfg.wfkopt:Get())
                    lbymode:Set(cfg.wlby:Get())
                    freestd:Set(cfg.wfr:Get())
                    desyn:Set(cfg.wdes:Get())
                    ref_modifier_off:SetInt(0)
                end
            elseif not bOnGround then -- Air
                if (cfg.desyncmodowoair:GetInt() == 0) then --smart
                    smartaa()
                end
                if (cfg.desyncmodowoair:GetInt() == 2) then --Multiple
                    multipleaa()
                end
                if (cfg.desyncmodowoair:GetInt() == 1) then --prefer low delta
                    preferlowdeltaaa()
                end
                if (cfg.desyncmodowoair:GetInt() == 3) then --Smart Jitter
                    jittersex()
                end
                if (cfg.desyncmodowoair:GetInt() == 4) then --Smart Jitter
                    tankeaa()
                end
                if (cfg.desyncmodowoair:GetInt() == 5) then --Custom
                    inverter:Set(cfg.ainv:Get())
                    leftlimit:Set(cfg.aleft:Get())
                    rightlimit:Set(cfg.aright:Get())
                    fakeopt:Set(cfg.afkopt:Get())
                    lbymode:Set(cfg.alby:Get())
                    freestd:Set(cfg.afr:Get())
                    desyn:Set(cfg.ades:Get())
                    ref_modifier_off:SetInt(0)
                end
            end

        end
    end

    function ideal_tick_shot()
        if cfg.IdealTick:GetBool() == true then
            Exploits.ForceTeleport()
        end
    end

    function ideal_tick()
        Exploits.ForceCharge()
        Exploits.OverrideDoubleTapSpeed(18)
        double_tap:SetBool(true)
        autopeekuwu:SetBool(true)
        allow = true
    end

    function Exploits_func()

        --Speed modes
        instant = 16
        default = 13

        --Preserve modes
        insecure = 0
        secure = 1
        safe = 2
        local is_charged = Exploits.GetCharge()
        if not cfg.DTSettings:GetBool() then
            return
        end
        cl_clock_correction = CVar.FindVar("cl_clock_correction") --clock correction OOPS: I think soufiw already manages with this but whatever...
        sv_maxusrcmdprocessticks = CVar.FindVar("sv_maxusrcmdprocessticks") --sv_maxusrcmdprocessticks

        if (cfg.dtcorrection:GetBool()) then
            CVar.FindVar("cl_clock_correction"):SetInt(0)
            CVar.FindVar("cl_clock_correction_adjustment_max_amount"):SetInt(450)
        else
            CVar.FindVar("cl_clock_correction"):SetInt(1)
        end
        if (cfg.dtmodes:GetInt() == 0 and not cfg.IdealTick:GetBool()) then --Instant mode
            if (can_shift_shot(instant) and is_charged ~= 1) then
                Exploits.AllowCharge(true)
                Exploits.ForceCharge()
            end
            Exploits.OverrideDoubleTapSpeed(instant)


            -- if (c_Menu_doubletap_debug_mode:GetBool()) then
            --    print("[DOUBLETAP] TICKS: MAX | PRESERVE: INSECURE | CORRECTION: DISABLED ")
            -- end

        else if (cfg.dtmodes:GetInt() == 1 and not cfg.IdealTick:GetBool()) then --Slow mode
                if (can_shift_shot(default) and is_charged ~= 1) then
                    Exploits.AllowCharge(true)
                    Exploits.ForceCharge()
                end
                Exploits.OverrideDoubleTapSpeed(default)


                -- if (c_Menu_doubletap_debug_mode:GetBool()) then
                -- print("[DOUBLETAP] TICKS: 13 | PRESERVE: SAFETY | CORRECTION: ENABLED ")
                -- end
            else if (cfg.dtmodes:GetInt() == 2 and not cfg.IdealTick:GetBool()) then --Sonic mode
                    localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
                    getplayer = localplayer:GetPlayer()
                    active_weapon = getplayer:GetActiveWeapon()

                    Exploits.OverrideDoubleTapSpeed(17)
                    CVar.FindVar("cl_clock_correction"):SetInt(0)
                    CVar.FindVar("cl_clock_correction_adjustment_max_amount"):SetInt(450)

                    -- Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag"):SetBool(true)

                    -- if (c_Menu_doubletap_debug_mode:GetBool()) then
                    -- print("[DOUBLETAP] TICKS: SONIC | PRESERVE: -1 | CORRECTION: DISABLED ")
                    -- end
                else if (cfg.dtmodes:GetInt() == 3 and not cfg.IdealTick:GetBool()) then --Custom Mode
                        if (can_shift_shot(cfg.dt_ticks:GetInt()) and is_charged ~= 1) then
                            Exploits.AllowCharge(true)
                            Exploits.ForceCharge()
                        end
                        Exploits.OverrideDoubleTapSpeed(cfg.dt_ticks:GetInt())
                    else
                        -- Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag"):SetBool(true)
                    end
                end
            end
        end
    end

    hitboxes = {
        'generic',
        'head',
        'chest',
        'stomach',
        'left arm',
        'right arm',
        'left leg',
        'right leg',
        'neck'
    };
    function Split(s, delimiter)
        result = {};
        for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match);
        end
        return result;
    end

    vector_add = function(vec1, vec2)
        newVec = { vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2] }
        return newVec;
    end

    degreesToRadians = function(radians)
        arifemtic = (radians * math.pi / 180)
        return arifemtic
    end

    vector_sub = function(vec1, vec2)
        return { vec1[1] - vec2.x, vec1[2] - vec2.y, vec1[3] - vec2.z };
    end

    vector_add = function(vec1, vec2)
        newVec = { vec1[1] + vec2[1], vec1[2] + vec2[2], vec1[3] + vec2[3] };
        return newVec;
    end
    vec_mul_fl = function(vec1, vec2)
        return { vec1[1] * vec2, vec1[2] * vec2, vec1[3] * vec2 };
    end

    angle_to_vec = function(x, y)
        vecx = degreesToRadians(x);
        vecy = degreesToRadians(y);
        vectorx = math.sin(vecx);
        vectory = math.cos(vecx);
        vectorz = math.sin(vecy);
        vectoroffset = math.cos(vecy);
        return { (vectory * vectoroffset), (vectory * vectorz), (vectorx / -1) }
    end

    previoustrails = {}
    can_shift_shot = function(tts)
        me = EntityList.GetClientEntity(EngineClient.GetLocalPlayer()):GetPlayer()
        if me == nil then return end
        wpn = me:GetActiveWeapon()
        if (me == null or wpn == null) then
            return false;
        end
        player = EntityList.GetLocalPlayer()
        tickbase = player:GetProp("m_nTickBase");
        curtime = GlobalVars.interval_per_tick * (tickbase - tts)

        if (curtime < player:GetProp("m_flNextAttack")) then
            return false;
        end
        if (curtime < wpn:GetProp("m_flNextPrimaryAttack")) then
            return false;
        end
        return true;
    end
    quest = function(cond, T, F)
        if cond then return true else return false end
    end

    toleng = 0

    SkeetScope = function()
        sc = EngineClient.GetScreenSize()
        player = EntityList.GetLocalPlayer()
        scoped = player:GetProp("m_bIsScoped");
        gui = CVar.FindVar("r_drawvgui")
        if scoped then
            if toleng < (cfg.ScopeOrigin:GetInt() / 2 + cfg.ScopeWidth:GetInt()) then toleng = toleng + 2 else toleng = (cfg.ScopeOrigin:GetInt() / 2 + cfg.ScopeWidth:GetInt()) end
            gui:SetInt(0);
            Render.GradientBoxFilled(Vector2.new(sc.x / 2 - 0.1, sc.y / 2 - math.min(cfg.ScopeOrigin:GetInt(), toleng)), Vector2.new(sc.x / 2 + 1, sc.y / 2 - math.min(cfg.ScopeOrigin:GetInt(), toleng) - math.min(cfg.ScopeWidth:GetInt(), toleng)), cfg.SkeetScope:GetColor(), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0))
            Render.GradientBoxFilled(Vector2.new(sc.x / 2 - math.min(cfg.ScopeOrigin:GetInt(), toleng), sc.y / 2 - 0.1), Vector2.new(sc.x / 2 - math.min(cfg.ScopeOrigin:GetInt(), toleng) - math.min(cfg.ScopeWidth:GetInt(), toleng), sc.y / 2 + 1), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0))
            Render.GradientBoxFilled(Vector2.new(sc.x / 2 - 0.1, sc.y / 2 + math.min(cfg.ScopeOrigin:GetInt(), toleng)), Vector2.new(sc.x / 2 + 1, sc.y / 2 + math.min(cfg.ScopeOrigin:GetInt(), toleng) + math.min(cfg.ScopeWidth:GetInt(), toleng)), cfg.SkeetScope:GetColor(), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0))
            Render.GradientBoxFilled(Vector2.new(sc.x / 2 + math.min(cfg.ScopeOrigin:GetInt(), toleng), sc.y / 2 - 0.1), Vector2.new(sc.x / 2 + math.min(cfg.ScopeOrigin:GetInt(), toleng) + math.min(cfg.ScopeWidth:GetInt(), toleng), sc.y / 2 + 1), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0), cfg.SkeetScope:GetColor(), Color.new(cfg.SkeetScope:GetColor().r, cfg.SkeetScope:GetColor().g, cfg.SkeetScope:GetColor().b, 0))
        else
            if toleng > 0 then toleng = toleng - 2 else toleng = 0 end
            gui:SetInt(1);
        end
    end

    movement = function(to_pos, curr_pos, view)
        diff_x = curr_pos.x - to_pos.x
        diff_y = curr_pos.y - to_pos.y

        yaw = view.yaw

        translatedVelocity = { diff_x * math.cos(yaw / 180 * math.pi) + diff_y * math.sin(yaw / 180 * math.pi), diff_y * math.cos(yaw / 180 * math.pi) - diff_x * math.sin(yaw / 180 * math.pi) }

        return { -translatedVelocity[1] * 40, translatedVelocity[2] * 40 }
    end


    alpha = {
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    }
    dtspeed = 0
    local maxdt = 0
    -- findvars
    local math_lib = {
        clamp = function(val, lower, upper)
            if lower > upper then lower, upper = upper, lower end
            return math.max(lower, math.min(upper, val))
        end
    }
    local lua = {
        color = Color.RGBA(157, 162, 255, 255),
        font = Render.InitFont('Verdana', 11, { 'r' }),
        screen = EngineClient.GetScreenSize(),
        logs = {
            stuff = {},
            num = 0,
            reason = {
                [1] = 'resolver',
                [2] = 'spread',
                [3] = 'occlusion',
                [4] = 'prediction error'
            },
            hitgroups = {
                [0] = "generic",
                [1] = "head",
                [2] = "chest",
                [3] = "stomach",
                [4] = "left arm",
                [5] = "right arm",
                [6] = "left leg",
                [7] = "right leg",
                [10] = "gear"
            }
        }
    }
    local render = {
        box = function(string, y, alpha)
            local stringsize = Render.CalcTextSize(string, 11, lua.font).x
            Render.BoxFilled(Vector2.new(lua.screen.x / 2 - stringsize / 2 - 6.5, lua.screen.y - 150 - y), Vector2.new(lua.screen.x / 2 + stringsize / 2 + 6.5, lua.screen.y - 120 - y), Color.RGBA(0, 0, 0, 80))
            Render.BoxFilled(Vector2.new(lua.screen.x / 2 - stringsize / 2 - 6.5, lua.screen.y - 151 - y), Vector2.new(lua.screen.x / 2 + stringsize / 2 + 6.5, lua.screen.y - 150 - y), lua.color)
            Render.Text(string, Vector2.new(lua.screen.x / 2, lua.screen.y - 136 - y), Color.RGBA(255, 255, 255, 255), 11, lua.font, true, true)
        end
    }
    local dt_ref = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
    local hs_ref = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots")
    local safepoint_ref = Menu.FindVar("Aimbot", "Ragebot", "Misc", "Safe Points")
    local baim_ref = Menu.FindVar("Aimbot", "Ragebot", "Misc", "Body Aim")
    local min_dmg = Menu.FindVar("Aimbot", "Ragebot", "Accuracy", "Minimum Damage")
    local freestand_ref = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
    local autopeek_ref = Menu.FindVar("Miscellaneous", "Main", "Movement", "Auto Peek")
    local fl_ref = Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Limit")
    local autopeek_backup = autopeek_ref:GetBool()
    local dt_backup = dt_ref:GetBool()
    local yaw_base_backup = freestand_ref:GetInt()
    -- anti aim references
    local sw_ref = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Slow Walk")
    local yaw_base_ref = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
    function C_BaseEntity:m_iHealth()
        return self:GetProp("DT_BasePlayer", "m_iHealth")
    end

    function render_text(text, pos, color, size, text_font, outline, align)
        local text_size = Render.CalcTextSize(text, size, text_font)

        if align == 0 then -- To the left
            Render.Text(text, Vector2.new(pos.x - text_size.x, pos.y), color, size, text_font, outline)
        elseif align == 1 then -- To the center
            Render.Text(text, Vector2.new(pos.x - (text_size.x / 2), pos.y), color, size, text_font, outline)
        elseif align == 2 then -- To the right
            Render.Text(text, pos, color, size, text_font, outline)
        end
    end

    local font_verdana12 = Render.InitFont("Verdana", 12, { ' r ' })
    local font_title = Render.InitFont("Verdana Bold", 11, { ' ' })
    local font_inds = Render.InitFont("Smallest Pixel-7", 10, { ' ' })
    local font_idealyaw = Render.InitFont("Verdana", 13, { ' ' })
    local y = 0
    function drawIndicators()

        -- visuals needed stuff
        local get_screen = EngineClient:GetScreenSize()
        local x = get_screen.x / 2

        if cfg.SkeetScope:GetBool() then
            if (cfg.Scoped) then
                y = get_screen.y / 2 + ScopeOrigin:GetInt()
            else
                y = get_screen.y / 2 + toleng
            end
        else
            y = get_screen.y / 2 + 20
        end
        local arrows_size = 17
        local text_inds = 10
        local text_title = 16
        local ind_dst = 0
        local ind_spr = 8
        local charge = Exploits.GetCharge()
        local dmg_value = min_dmg:GetInt()
        local main_color = color_main:GetColor()
        local accent_color = color_accent:GetColor()

        -- prediction textbox
        local txt_pred_left = "EXO"
        local txt_pred_right = "DUS"
        -- acatel textbox
        local txt_acatel = "EXODUS."
        local txt_acatel_version = "WTF"
        -- ideal yaw textbox
        local txt_ideal = "EXODUS YAW"
        -- killaura textbox
        local txt_killaura = "EXODUS"
        -- Arctic textbox
        local txt_arctic = "EXODUS"
        -- Invictus textbox
        local txt_invictus = "EXODUS"

        local local_player = EngineClient.GetLocalPlayer()
        local player = EntityList.GetClientEntity(local_player)
        if not player then
            return
        end

        local flags = player:GetProp("m_fFlags")
        local inverted = AntiAim.GetInverterState()

        local real = AntiAim.GetCurrentRealRotation()
        local fake = AntiAim.GetFakeRotation()
        local max_dsy = AntiAim.GetMaxDesyncDelta()
        local min_dsy = AntiAim.GetMinDesyncDelta()
        local delta = real - fake

        if (delta > max_dsy) then
            delta = max_dsy
        elseif (delta < min_dsy) then
            delta = min_dsy
        end

        local baim_color = Color.new(0.3, 0.3, 0.3, 1)
        local sp_color = Color.new(0.3, 0.3, 0.3, 1)
        local freestanding_color = Color.new(0.3, 0.3, 0.3, 1)

        if (baim_ref:GetInt() == 2) then
            baim_color = main_color
        end

        if (safepoint_ref:GetInt() == 2) then
            sp_color = main_color
        end

        if (freestand_ref:GetInt() == 5) then
            freestanding_color = main_color
        end

        local fakeyaw_text = "-"
        if (inverted) then
            fakeyaw_text = "L"
        else
            fakeyaw_text = "R"
        end

        r = main_color.r
        g = main_color.g
        b = main_color.b
        r2 = accent_color.r
        g2 = accent_color.g
        b2 = accent_color.b
        a = (math.floor(math.sin(GlobalVars.curtime * 2) * 220 + 221)) / 1000 * 6.92

        local hdf = Color.new(r2, g2, b2, a)
        local hrsn = Color.new(r, g, b, 0)
        local desyncdelta = math.min(math.abs(AntiAim.GetCurrentRealRotation() - AntiAim.GetFakeRotation()) / 2, 58)

        -- drawing visualsssss

        if player:m_iHealth() > 0 then

            -- prediction indicators
            if (cfg.indicators_type:GetInt() == 1) then

                if cfg.indicators_list:GetBool(1) then

                    if (inverted) then
                        render_text("" .. txt_pred_left .. "", Vector2.new(x, y + 20), main_color, 11, font_title, false, 0)
                        render_text("" .. txt_pred_right .. "", Vector2.new(x, y + 20), accent_color, 11, font_title, false, 2)

                    elseif not (inverted) then
                        render_text("" .. txt_pred_left .. "", Vector2.new(x, y + 20), accent_color, 11, font_title, false, 0)
                        render_text("" .. txt_pred_right .. "", Vector2.new(x, y + 20), main_color, 11, font_title, false, 2)

                    end
                end
                --Drawing custom arrows
                -- drawing arrows


                if cfg.indicators_list:GetBool(2) then
                    -- checking if is in air or ducking for the anti-aim status
                    local aa_status = "DYNAMIC-"

                    if (flags == 256) then
                        aa_status = "AEROBIC^"

                        render_text(aa_status, Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr

                    elseif player:GetProp("m_flDuckAmount") > 0.8 then
                        aa_status = "TANK"

                        render_text(aa_status, Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr

                    else
                        aa_status = "DYNAMIC-"

                        render_text(aa_status, Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(3) then

                    if (charge <= 0) then
                        dt_state = Color.new(255, 0, 0, 255)

                    else
                        dt_state = accent_color
                    end
                    if (dt_ref:GetBool()) then

                        render_text("DT", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr

                    elseif not (dt_ref:GetBool()) then
                        render_text("DT", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(4) then

                    if (hs_ref:GetBool()) then

                        render_text("OS-AA", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr

                    elseif not (hs_ref:GetBool()) then
                        render_text("OS-AA", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(5) then

                    if (autopeek_ref:GetBool()) then

                        render_text("QUICKPEEK", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr

                    else
                        render_text("QUICKPEEK", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(6) then
                    if (freestand_ref:GetInt() == 5) then

                        render_text("FREESTANDING", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("FREESTANDING", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(7) then
                    if (baim_ref:GetInt() == 2) then

                        render_text("BAIM", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("BAIM", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if cfg.indicators_list:GetBool(8) then
                    if (safepoint_ref:GetInt() == 2) then

                        render_text("SAFE", Vector2.new(x, y + 30 + ind_dst), accent_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("SAFE", Vector2.new(x, y + 30 + ind_dst), main_color, text_inds, font_inds, true, 1)
                        ind_dst = ind_dst + ind_spr
                    end
                end
            end

            -- acatel indiicators
            if (cfg.indicators_type:GetInt() == 2) then


                local pene = string.format("" .. txt_acatel .. "")
                local pene2 = string.format("" .. txt_acatel_version .. "")
                local text_size = Render.CalcTextSize("" .. txt_acatel .. "", text_inds, font_inds)

                render_text(pene, Vector2.new(x + 2, y + 30), main_color, text_inds, font_inds, true, 2)
                render_text(pene2, Vector2.new(x + 2 + text_size.x, y + 30), hdf, text_inds, font_inds, true, 2)

                render_text("FAKE", Vector2.new(x + 2, y + 38.5), Color.new(197 / 255, 198 / 255, 254 / 255, 1), text_inds, font_inds, true, 2)
                render_text("YAW", Vector2.new(x + 2 + 21, y + 38.5), Color.new(197 / 255, 198 / 255, 254 / 255, 1), text_inds, font_inds, true, 2)
                render_text(fakeyaw_text, Vector2.new(x + 39, y + 38.5), Color.new(1, 1, 1, 1), text_inds, font_inds, true, 2)

                if (dt_ref:GetBool()) then

                    if (charge <= 0) then
                        render_text("DT", Vector2.new(x + 2, y + 46), Color.new(255, 0, 0, 255), text_inds, font_inds, true, 2)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("DT", Vector2.new(x + 2, y + 46), Color.new(0, 255, 0, 255), text_inds, font_inds, true, 2)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                -- baim
                render_text("BAIM", Vector2.new(x + 2, y + 46 + ind_dst), baim_color, text_inds, font_inds, true, 2)
                -- safepoint
                render_text("SP", Vector2.new(x + 2 + 23, y + 46 + ind_dst), sp_color, text_inds, font_inds, true, 2)
                -- freestanding
                render_text("FS", Vector2.new(x + 2 + 35, y + 46 + ind_dst), freestanding_color, text_inds, font_inds, true, 2)
                if min_dmg:GetInt() > 0 then
                    if min_dmg:GetInt() > 100 then
                        render_text("DMG:+" .. min_dmg:GetInt() - 100, Vector2.new(x + 2, y + 46 + ind_dst + 8.5), Color.new(255, 255, 255, 255), text_inds, font_inds, true, 2)
                    else
                        render_text("DMG:" .. min_dmg:GetInt(), Vector2.new(x + 2, y + 46 + ind_dst + 8.5), Color.new(255, 255, 255, 255), text_inds, font_inds, true, 2)
                    end
                else
                    render_text("DMG:AUTO", Vector2.new(x + 2, y + 46 + ind_dst + 8.5), Color.new(255, 255, 255, 255), text_inds, font_inds, true, 2)
                end
            end

            -- ideal yaw indicators (hardcoded)
            if (cfg.indicators_type:GetInt() == 3) then

                local draw_arrow = false

                if (flags == 256) then
                    draw_arrow = false

                elseif not (flags == 256) then
                    draw_arrow = true
                end

                render_text("" .. txt_ideal .. "", Vector2.new(x + 1, y + 30 + ind_dst), Color.new(0 / 255, 0 / 0, 0 / 255, 1), 13, font_idealyaw, false, 2)
                render_text("" .. txt_ideal .. "", Vector2.new(x, y + 30 + ind_dst), Color.new(255 / 255, 128 / 255, 0 / 255, 1), 13, font_idealyaw, false, 2)

                render_text("DYNAMIC", Vector2.new(x + 1, y + 42 + ind_dst), Color.new(0 / 255, 0 / 255, 0 / 255, 1), 13, font_idealyaw, false, 2)
                render_text("DYNAMIC", Vector2.new(x, y + 42 + ind_dst), Color.new(192 / 255, 175 / 255, 226 / 255, 1), 13, font_idealyaw, false, 2)

                if (dt_ref:GetBool()) then

                    if (charge <= 0) then
                        render_text("DT", Vector2.new(x + 1, y + 53 + ind_dst), Color.new(0, 0, 0, 255), 13, font_idealyaw, false, 2)
                        render_text("DT", Vector2.new(x, y + 53 + ind_dst), Color.new(255, 0, 0, 255), 13, font_idealyaw, false, 2)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("DT", Vector2.new(x + 1, y + 53 + ind_dst), Color.new(0, 0, 0, 255), 13, font_idealyaw, false, 2)
                        render_text("DT", Vector2.new(x, y + 53 + ind_dst), Color.new(0, 255, 0, 255), 13, font_idealyaw, false, 2)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                if (hs_ref:GetBool()) then

                    render_text("AA", Vector2.new(x + 1, y + 55 + ind_dst), Color.new(0 / 255, 0 / 255, 0 / 255, 1), 12, font_idealyaw, false, 2)
                    render_text("AA", Vector2.new(x, y + 55 + ind_dst), Color.new(192 / 255, 175 / 255, 226 / 255, 1), 12, font_idealyaw, false, 2)
                    ind_dst = ind_dst + ind_spr
                end
            end

            -- killaura indicators
            if (cfg.indicators_type:GetInt() == 4) then

                local choke = ClientState.m_choked_commands
                local fl_str = string.format("FL:" .. choke)
                local aa_status = "AA:STABLE AURA"

                if (flags == 256) then
                    aa_state = "AA:FLYING JESUS"

                elseif player:GetProp("m_flDuckAmount") > 0.8 then
                    aa_state = "AA:CROUCHING"

                else
                    aa_state = "AA:STABLE AURA"
                end


                render_text("" .. txt_killaura .. "", Vector2.new(x, y + 30), main_color, text_inds, font_inds, true, 0)

                render_text(aa_state, Vector2.new(x, y + 38), accent_color, text_inds, font_inds, true, 0)

                if (dt_ref:GetBool()) then

                    if (charge <= 0) then
                        render_text("DT:SHIFTING", Vector2.new(x, y + 46 + ind_dst), accent_color, text_inds, font_inds, true, 0)
                        ind_dst = ind_dst + ind_spr
                    else
                        render_text("DT:NERVOUS", Vector2.new(x, y + 46 + ind_dst), accent_color, text_inds, font_inds, true, 0)
                        ind_dst = ind_dst + ind_spr
                    end
                end

                render_text(fl_str, Vector2.new(x, y + 46 + ind_dst), accent_color, text_inds, font_inds, true, 0)

            end

            if (cfg.indicators_type:GetInt() == 5) then
                local aa_status = "STANDING"

                render_text("" .. txt_arctic .. "", Vector2.new(x, y + 32), main_color, text_inds, font_inds, true, 1)


                if (flags == 256) then
                    aa_status = "AIR"
                    render_text(aa_status, Vector2.new(x, y + 40), main_color, text_inds, font_inds, true, 1)

                elseif player:GetProp("m_flDuckAmount") > 0.8 then
                    aa_status = "CROUCHING"
                    render_text(aa_status, Vector2.new(x, y + 40), main_color, text_inds, font_inds, true, 1)

                elseif (sw_ref:GetBool()) then
                    aa_status = "SLOWWALK"
                    render_text(aa_status, Vector2.new(x, y + 40), main_color, text_inds, font_inds, true, 1)
                else
                    aa_status = "STANDING"
                    render_text(aa_status, Vector2.new(x, y + 40), main_color, text_inds, font_inds, true, 1)
                end

                if (dt_ref:GetBool()) then
                    if (charge <= 0) then
                        render_text("DT", Vector2.new(x - 8, y + 48), Color.new(0.5, 0.5, 0.5, 1), text_inds, font_inds, true, 0)

                    else
                        render_text("DT", Vector2.new(x - 8, y + 48), accent_color, text_inds, font_inds, true, 0)

                    end
                elseif not (dt_ref:GetBool()) then
                    render_text("DT", Vector2.new(x - 8, y + 48), Color.new(0.5, 0.5, 0.5, 1), text_inds, font_inds, true, 0)

                end

                if (yaw_base_ref:GetInt() == 5) then
                    render_text("FS", Vector2.new(x, y + 48 + ind_dst), accent_color, text_inds, font_inds, true, 1)

                elseif not (yaw_base_ref:GetInt() == 5) then
                    render_text("FS", Vector2.new(x, y + 48 + ind_dst), Color.new(0.5, 0.5, 0.5, 1), text_inds, font_inds, true, 1)

                end

                if (hs_ref:GetBool()) then

                    render_text("HS", Vector2.new(x + 8, y + 48), accent_color, text_inds, font_inds, true, 2)

                elseif not (hs_ref:GetBool()) then
                    render_text("HS", Vector2.new(x + 8, y + 48), Color.new(0.5, 0.5, 0.5, 1), text_inds, font_inds, true, 2)
                end

            end

            -- Invictus indicators

            if (cfg.indicators_type:GetInt() == 6) then

                render_text("" .. txt_invictus .. "", Vector2.new(x + 1, y + 33), Color.new(0, 0, 0, 1), 12, font_verdana12, false, 1)
                render_text("" .. txt_invictus .. "", Vector2.new(x, y + 32), main_color, 12, font_verdana12, false, 1)

                Render.GradientBoxFilled(Vector2.new(x, y + 47), Vector2.new(x + (math.abs(desyncdelta * 58 / 60)), y + 49), main_color, hrsn, main_color, hrsn)
                Render.GradientBoxFilled(Vector2.new(x, y + 47), Vector2.new(x + (-math.abs(desyncdelta * 58 / 60)), y + 49), main_color, hrsn, main_color, hrsn)
            end
        end
    end

    -- LowdeltaPreset = function()
    --     AntiAim.OverrideYawOffset(0.0)
    --     AntiAim.OverrideLimit(-20.0)
    --     AntiAim.OverrideLBYOffset(21)
    -- end

    -- LegitAAPreset = function(cmd)
    --     -- cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
    --     if AntiAim.GetInverterState() then
    --         AntiAim.OverrideLBYOffset(-60)
    --     else
    --         AntiAim.OverrideLBYOffset(60)
    --     end
    --     AntiAim.OverrideYawOffset(180.0)
    --     AntiAim.OverrideLimit(60)
    --     AntiAim.OverridePitch(0.0)
    -- end

    manualalpha = 0
    manualminus = false
    tolengf = 0
    local YawAdd = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Add")
    manuals = function()
        local_player_index = EngineClient.GetLocalPlayer()
        local_player       = EntityList.GetClientEntity(local_player_index):GetPlayer()
        me                 = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
        if local_player and local_player:GetProp("m_iHealth") > 0 then
            if manualminus == false then
                if manualalpha < 255 then manualalpha = manualalpha + 2 else manualminus = true end
            else
                if manualalpha > 0 then manualalpha = manualalpha - 2 else manualminus = false end
            end
            manual = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
            sc = EngineClient.GetScreenSize()
            x = sc.x / 2
            y = sc.y / 2
            ctx = sc.x / 2
            cty = sc.y / 2
            player = EntityList.GetLocalPlayer()
            scoped = player:GetProp("m_bIsScoped");
            gui = CVar.FindVar("r_drawvgui")
            if scoped and cfg.SkeetScope:GetBool() then
                if tolengf < (cfg.ScopeOrigin:GetInt() + cfg.ScopeWidth:GetInt()) then tolengf = tolengf + 2 else tolengf = (cfg.ScopeOrigin:GetInt() + cfg.ScopeWidth:GetInt()) end
            else
                if tolengf > 0 then tolengf = tolengf - 2 else tolengf = 0 end
            end
            arrow = 40 + tolengf
            -- Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x+arrow, y-10), Vector2.new(x+arrow, y+10), Vector2.new(x+arrow+20, y), Vector2.new(x+arrow, y-10))
            -- Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x-arrow, y-10), Vector2.new(x-arrow, y+10), Vector2.new(x-arrow-20, y), Vector2.new(x-arrow, y-10))
            if cfg.desyncarrowscombo:GetInt() == 0 then
                if inverter:GetBool() == true then --right
                    Render.PolyFilled(desyncarrowscolors:GetColor(), Vector2.new(x + arrow, y - 10), Vector2.new(x + arrow, y + 10), Vector2.new(x + arrow + 20, y), Vector2.new(x + arrow, y - 10))
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x - arrow, y - 10), Vector2.new(x - arrow, y + 10), Vector2.new(x - arrow - 20, y), Vector2.new(x - arrow, y - 10))
                elseif inverter:GetBool() == false then --left
                    Render.PolyFilled(desyncarrowscolors:GetColor(), Vector2.new(x - arrow, y - 10), Vector2.new(x - arrow, y + 10), Vector2.new(x - arrow - 20, y), Vector2.new(x - arrow, y - 10))
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x + arrow, y - 10), Vector2.new(x + arrow, y + 10), Vector2.new(x + arrow + 20, y), Vector2.new(x + arrow, y - 10))
                end
            end
            if cfg.desyncarrowscombo:GetInt() == 1 then
                if inverter:GetBool() then
                    Render.BoxFilled(Vector2.new(ctx - arrow - 2, cty - 11), Vector2.new(ctx - arrow, cty + 8), desyncarrowscolors:GetColor())
                    Render.BoxFilled(Vector2.new(ctx + arrow + 2, cty - 11), Vector2.new(ctx + arrow, cty + 8), Color.new(0.0, 0.0, 0.0, 1.0))
                else
                    Render.BoxFilled(Vector2.new(ctx + arrow + 2, cty - 11), Vector2.new(ctx + arrow, cty + 8), desyncarrowscolors:GetColor())
                    Render.BoxFilled(Vector2.new(ctx - arrow - 2, cty - 11), Vector2.new(ctx - arrow, cty + 8), Color.new(0.0, 0.0, 0.0, 1.0))
                end
                if _yawbase:GetInt() == 2 or YawAdd:GetInt() == 90 then
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 1.0), Vector2.new(ctx - arrow - 4, cty - 11), Vector2.new(ctx - arrow - 4, cty + 8), Vector2.new(ctx - arrow - 20, cty - 1))
                    Render.PolyFilled(desyncarrowscolors:GetColor(), Vector2.new(ctx + arrow + 5, cty - 11), Vector2.new(ctx + arrow + 5, cty + 8), Vector2.new(ctx + arrow + 19, cty - 1))
                elseif _yawbase:GetInt() == 3 or YawAdd:GetInt() == -90 then
                    Render.PolyFilled(desyncarrowscolors:GetColor(), Vector2.new(ctx - arrow - 4, cty - 11), Vector2.new(ctx - arrow - 4, cty + 8), Vector2.new(ctx - arrow - 20, cty - 1))
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 1.0), Vector2.new(ctx + arrow + 5, cty - 11), Vector2.new(ctx + arrow + 5, cty + 8), Vector2.new(ctx + arrow + 19, cty - 1))
                else
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 1.0), Vector2.new(ctx - arrow - 4, cty - 11), Vector2.new(ctx - arrow - 4, cty + 8), Vector2.new(ctx - arrow - 20, cty - 1))
                    Render.PolyFilled(Color.new(0.0, 0.0, 0.0, 1.0), Vector2.new(ctx + arrow + 5, cty - 11), Vector2.new(ctx + arrow + 5, cty + 8), Vector2.new(ctx + arrow + 19, cty - 1))
                end
            end
        end
    end




    oldDamage = 0
    oldAutowall = 0
    oldHitChance = 0
    function instant_recharge()
        if cfg.instantrecharge:GetBool() then
            if cfg.instantrecharge_mode:GetInt() == 0 then
                Exploits.ForceCharge()
            end
        end

    end

    function vec_distance(vec_one, vec_two)

        delta_x, delta_y, delta_z = vec_one.x - vec_two.x, vec_one.y - vec_two.y

        return math.sqrt(delta_x * delta_x + delta_y * delta_y)

    end

    setLegitOptions = false
    local marius = 0
    local diduans = false
    LegitAA = function(cmd)
        ents = EntityList.GetEntitiesByClassID(129)
        hosts = EntityList.GetEntitiesByClassID(97)
        if ents[1] ~= nil or ents[0] ~= nil then
            for i = 1, #ents do
                localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
                position = ents[i]:GetProp("DT_BaseEntity", "m_vecOrigin")
                origin = localplayer:GetPlayer():GetEyePosition()
                vec = Vector.new(origin.x, origin.y, origin.z)
                distance = vec:DistTo(position)
                if distance > 100 then
                    cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
                end
            end
        elseif hosts[1] ~= nil then
            for f = 1, #hosts do
                if f > 1 then
                    localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
                    position = hosts[f]:GetProp("DT_BaseEntity", "m_vecOrigin")
                    position2 = hosts[f - 1]:GetProp("DT_BaseEntity", "m_vecOrigin")
                    origin = localplayer:GetPlayer():GetEyePosition()
                    vec = Vector.new(origin.x, origin.y, origin.z)
                    distance = vec:DistTo(position)
                    distance2 = vec:DistTo(position2)
                    if distance > 100 and distance2 > 100 then
                        cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
                    end
                end
            end
        else
            cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
        end
        if setLegitOptions == false then
            FakeOptions = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
            LBYMode = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
            freestandDesync = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
            DesyncOnShot = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
            FakeOptions:SetInt(8)
            LBYMode:SetInt(1)
            freestandDesync:SetInt(0)
            DesyncOnShot:SetInt(0)
            setLegitOptions = true
        end
        if AntiAim.GetInverterState() then
            AntiAim.OverrideLBYOffset(-60)
        else
            AntiAim.OverrideLBYOffset(60)
        end
        AntiAim.OverrideYawOffset(180)
        AntiAim.OverrideLimit(60)
        AntiAim.OverridePitch(EngineClient.GetViewAngles().pitch)
    end

    pingticks = 0
    antiAims = false
    set = false
    settwo = false
    setthree = false
    ticksAfterUpload = 0
    savedAntiAims = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    }
    presaveforlegit = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    }
    presaveforldelta = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    }
    function fast_charge()
        if cfg.instantrecharge:GetBool() then
            if cfg.instantrecharge_mode:GetInt() == 1 then
                Exploits.ForceCharge()
            end
        end
    end

    local function fast_recharge()

        if EngineClient.IsConnected() then
            local netchann_info = EngineClient.GetNetChannelInfo()
            if netchann_info == nil then
                return
            end
        end
    end

    local nexttickfakelag = true
    function isempty(value)
        if value == nil then
            return "nil"
        else
            return value
        end
    end

    Cheat.RegisterCallback('registered_shot', function(shot)
        if cfg.logsowoowowowo:GetBool(2) then
            lua.logs.num = lua.logs.num + 1
            if shot.reason == 0 then
                table.insert(lua.logs.stuff, { text = 'Hit ' .. isempty(EntityList.GetClientEntity(shot.target_index):GetPlayer():GetName()) .. "'s in " .. isempty(lua.logs.hitgroups[math_lib.clamp(shot.hitgroup, 0, 10)]) .. ' for ' .. isempty(shot.damage) .. ' damage [spread: ' .. isempty(string.format('%.3f°', shot.spread_degree)) .. '] [hitchance:' .. isempty(shot.hitchance) .. ' | history:' .. isempty(shot.backtrack) .. ']', time = GlobalVars.realtime })
                print('[exodus] Hit ' .. isempty(EntityList.GetClientEntity(shot.target_index):GetPlayer():GetName()) .. "'s in " .. isempty(lua.logs.hitgroups[math_lib.clamp(shot.hitgroup, 0, 10)]) .. ' for ' .. isempty(shot.damage) .. ' damage [spread: ' .. isempty(string.format('%.3f°', shot.spread_degree)) .. '] [hitchance:' .. isempty(shot.hitchance) .. ' | history:' .. isempty(shot.backtrack) .. ']')
            else
                table.insert(lua.logs.stuff, { text = 'Missed shot in ' .. isempty(EntityList.GetClientEntity(shot.target_index):GetPlayer():GetName()) .. "'s " .. isempty(lua.logs.hitgroups[math_lib.clamp(shot.wanted_hitgroup, 0, 10)]) .. ' due to ' .. isempty(lua.logs.reason[shot.reason]) .. ' [spread: ' .. isempty(string.format('%.3f°', shot.spread_degree)) .. '] [hitchance:' .. isempty(shot.hitchance) .. ' | history:' .. isempty(shot.backtrack) .. ']', time = GlobalVars.realtime })
                print('[exodus] Missed shot in ' .. isempty(EntityList.GetClientEntity(shot.target_index):GetPlayer():GetName()) .. "'s " .. isempty(lua.logs.hitgroups[math_lib.clamp(shot.wanted_hitgroup, 0, 10)]) .. ' due to ' .. isempty(lua.logs.reason[shot.reason]) .. ' [spread: ' .. isempty(string.format('%.3f°', shot.spread_degree)) .. '] [hitchance:' .. isempty(shot.hitchance) .. ' | history:' .. isempty(shot.backtrack) .. ']')
            end
        end
    end)
    Cheat.RegisterCallback("ragebot_shot", function()
        ideal_tick_shot()
        fast_charge()
        nexttickfakelag = false
    end)
    local hide_shots = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots")
    function antionshotfunc()
        if cfg.antionshot:GetBool() then
            Menu_fakelag_enable:SetBool(true)
            if not nexttickfakelag then
                if double_tap:GetBool() or hide_shots:GetBool() then
                    FakeLag.ForceSend()
                else
                    FakeLag.ForceSend()
                end
                -- print('SHOT!')
                nexttickfakelag = true
            end
        end
    end

    function antibackstab()
        local all_players = EntityList.GetEntitiesByName("CCSPlayer")
        for i = 1, #all_players do
            local target = all_players[i]:GetPlayer()
            if target ~= EntityList.GetLocalPlayer() and not target:IsTeamMate() and target:GetProp("m_iHealth") > 0 then
                local localplayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
                local origin = localplayer:GetRenderOrigin()
                local origin2 = target:GetRenderOrigin()
                local my_vec = Vector.new(origin.x, origin.y, origin.z)
                local dest = Vector.new(origin2.x, origin2.y, origin2.z)
                local length = my_vec:DistTo(dest)
                weap = target:GetActiveWeapon()

                if length < 170 and weap ~= nil and weap:IsKnife() and cfg.AvoidBackStab:GetBool() then
                    AntiAim.OverrideYawOffset(180)
                    AntiAim.OverridePitch(0)
                else
                    return
                end
            end
        end
    end

    local function breaklc()
        local localplayer = EntityList.GetClientEntity(EngineClient:GetLocalPlayer())
        if not localplayer then return end
        localplayer = localplayer:GetPlayer()
        local lhealth = localplayer:GetProp("m_iHealth")
        if not lhealth or lhealth <= 0 then return end
        local fakeduck_enable = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Fake Duck")
        if fakeduck_enable:GetBool() then return end
        local doubletap_enable = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
        if (doubletap_enable:GetBool() == false or Exploits.GetCharge() < 1) then
            local origin = localplayer:GetProp("m_vecOrigin")
            if origin:DistTo(lastSentPos) >= math.random(46, 64) then
                FakeLag.ForceSend()
                lastSentPos = origin
                return
            end
        end
    end

    local mamatatapapa = 0
    function mafutemama(cmd)
        local_idx = EngineClient.GetLocalPlayer()
        local_entity = EntityList.GetClientEntity(local_idx)
        local_player = local_entity:GetPlayer();
        if not cfg.ExtendedLean:GetBool() then return end
        speed_x = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[0]")
        speed_y = local_player:GetProp("DT_BasePlayer", "m_vecVelocity[1]")
        speed = math.sqrt(speed_x * speed_x + speed_y * speed_y)
        if cfg.ExtendedLeanMode:GetInt() == 0 then
            mamatatapapa = cfg.ExtendedLeanVal:GetInt()
        elseif cfg.ExtendedLeanMode:GetInt() == 1 then
            mamatatapapa = math.random(cfg.ExtendedLeanVal:GetInt(), cfg.ExtendedLeanVal:GetInt() - cfg.ExtendedLeanJitter:GetInt())
        elseif cfg.ExtendedLeanMode:GetInt() == 2 then
            hp = 100 - local_entity:GetProp("m_iHealth")
            rounds = EntityList.GetGameRules():GetProp("m_totalRoundsPlayed") * 2
            mamatatapapa = (math.min(math.abs(AntiAim.GetCurrentRealRotation() - AntiAim.GetFakeRotation()) / 2, 58)) + hp + rounds + (speed / 1.8)
        end
        if speed > 1.5 and not Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Slow Walk"):GetBool() then return end
        cmd.viewangles.roll = flick_side and mamatatapapa or -mamatatapapa
    end

    local fake_duck = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Fake Duck")
    fakelagtyme2 = GlobalVars.curtime
    local randomized_fakelags = function()
        if not cfg.fakelagesEnable:GetBool() then return end
        local count = math.random(cfg.fakelagesRandomizedmin:Get(), cfg.fakelagesRandomizedmax:Get())
        if cfg.fakelagesType:Get() == 3 then
            Menu_fakelag_enable:Set(true)
            if fakelagtyme2 > GlobalVars.curtime or GlobalVars.curtime - fakelagtyme2 > cfg.fakelagesRandomizedtime:Get() then
                Menu_fakelag_limit:SetInt(count)
                Menu_fakelag_randomization:SetInt(count)
                fakelagtyme2 = GlobalVars.curtime
            end
        end
    end

    fakelagtyme = GlobalVars.curtime

    local function fluctuate_fakelag()
        if not cfg.fakelagesEnable:GetBool() then return end
        if cfg.fakelagesType:Get() == 2 then
            Menu_fakelag_enable:Set(true)
            if fakelagtyme > GlobalVars.curtime or GlobalVars.curtime - fakelagtyme > cfg.fakelagesCustomLimitTime:Get() then
                Menu_fakelag_limit:SetInt(0)
                Menu_fakelag_randomization:SetInt(0)
                fakelagtyme = GlobalVars.curtime
            else
                Menu_fakelag_limit:SetInt(cfg.fakelagesLimit:Get())
                Menu_fakelag_randomization:SetInt(cfg.fakelagesRandomization:Get())
            end

        end
    end

    local CustomTicks = function()
        if not cfg.fakelagesEnable:GetBool() then return end
        if cfg.fakelagesType:Get() == 1 then
            Menu.FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag"):Set(false)
        end

        if cfg.fakelagesType:Get() == 1 then
            if cfg.fakelagesCustomTicks:Get() > 16 then
                CVar.FindVar("sv_maxusrcmdprocessticks"):SetInt(cfg.fakelagesCustomTicks:Get())
            end
            if not Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap"):Get() and not Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots"):Get() then
                if ClientState.m_choked_commands >= cfg.fakelagesCustomTicks:Get() then
                    FakeLag.SetState(true)
                else
                    FakeLag.SetState(false)
                end
            end
        end
    end
    local CustomTicksDT = function()
        if not cfg.fakelagesEnable:GetBool() then return end
        if cfg.DTSettings:GetBool() then
            if cfg.dtmodes:GetInt() == 0 then
                mamaiadt = 16
            elseif cfg.dtmodes:GetInt() == 1 then
                mamaiadt = 13
            elseif cfg.dtmodes:GetInt() == 2 then
                mamaiadt = 16
            elseif cfg.dtmodes:GetInt() == 3 then
                mamaiadt = cfg.dt_ticks:GetInt()
            end
        else
            mamaiadt = 14
        end
        if Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap"):Get() and cfg.fakelagesEnableDT:Get() then
            if ClientState.m_choked_commands >= (CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() - mamaiadt) then
                FakeLag.SetState(true)
            else
                FakeLag.SetState(false)
            end
        end
    end
    local Dynamic = function()
        if not cfg.fakelagesEnable:GetBool() then return end
        local lp = EntityList:GetLocalPlayer()
        local air = bit.band(lp:GetPlayer():GetProp("m_fFlags"), bit.lshift(1, 0)) == 0
        local speed = Vector.new(lp:GetProp("m_vecVelocity[0]"), lp:GetProp("m_vecVelocity[1]"), lp:GetProp("m_vecVelocity[2]")):Length2D()


        if cfg.fakelagesType:Get() == 4 then
            Menu_fakelag_enable:Set(true)
            if not air then
                if math.floor(speed / 15) > 14 then return end
                Menu_fakelag_randomization:Set(math.floor(speed / 15))
                Menu_fakelag_limit:Set(math.floor(speed / 15))
            else
                Menu_fakelag_randomization:Set(math.floor(speed / 26))
                Menu_fakelag_limit:Set(math.floor(speed / 26))
            end
        end
    end
    local DoubleTap = Menu.FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
    function C_BasePlayer:CanHit()
        local Localplayer = EntityList.GetLocalPlayer()
        local TraceInfo = Cheat.FireBullet(self, self:GetEyePosition(), Localplayer:GetEyePosition())

        if (TraceInfo.damage > 0 and ((TraceInfo.trace.hit_entity and TraceInfo.trace.hit_entity:GetPlayer() == Localplayer) or false)) then
            return true
        end

        return false
    end

    function C_BasePlayer:GetFlag(shift)
        return bit.band(self:GetProp("m_fFlags"), bit.lshift(1, shift)) ~= 0
    end

    function GetEnemies()
        local Enemies = {}

        for _, Player in pairs(EntityList.GetPlayers()) do
            if (not Player:IsTeamMate() and Player:IsAlive()) then
                table.insert(Enemies, Player:GetPlayer())
            end
        end

        return Enemies
    end

    local function dtinair()
        if (cfg.teleowo:Get() and DoubleTap:Get()) then
            local Need_Teleport = false

            local Localplayer = EntityList.GetLocalPlayer()
            local Weapon = Localplayer:GetActiveWeapon()
            local WeaponID = Weapon:GetWeaponID()

            for _, Enemy in pairs(GetEnemies()) do
                if (not Enemy:IsDormant() and Enemy:CanHit()) then
                    Need_Teleport = true
                end
            end

            if (Need_Teleport and not Localplayer:GetFlag(0)) then
                Exploits.ForceTeleport()
            end
        end
    end

    local min = Vector.new()
    local max = Vector.new()
    local target_correct = true
    function calc_angle(src, dst)
        local vecdelta = Vector.new(dst.x - src.x, dst.y - src.y, dst.z - src.z)
        local angles = QAngle.new(math.atan2(-vecdelta.z, vecdelta:Length2D()) * 180.0 / math.pi, (math.atan2(vecdelta.y, vecdelta.x) * 180.0 / math.pi), 0.0)
        return angles
    end

    function get_localplayer()
        local local_index = EngineClient.GetLocalPlayer()
        local localplayer = EntityList.GetClientEntity(local_index)
        if localplayer == nil then return end
        local me = localplayer:GetPlayer()
        return me
    end

    function is_in_air(entity)
        local flags = entity:GetProp("DT_BasePlayer", "m_fFlags")

        return bit.band(flags, 1) == 0
    end

    function autostop(cmd)
        local vecvelocity1 = Vector.new(get_localplayer():GetProp("m_vecVelocity[0]"), get_localplayer():GetProp("m_vecVelocity[1]"), 0.0)
        local viewangles = get_localplayer():GetEyePosition()
        local direction = Cheat.VectorToAngle(vecvelocity1)
        direction.yaw = cmd.viewangles.yaw - direction.yaw

        local forward = Cheat.AngleToForward(direction)
        local negative = Vector2.new(forward.x * -200, forward.y * -200)


        cmd.forwardmove = negative.x
        cmd.sidemove = negative.y
    end

    function get_dormant_enemy()
        local players = EntityList.GetEntitiesByName("CCSPlayer")
        for i = 1, #players do
            local enemies = players[i];
            local enemy = enemies:GetPlayer()
            target_correct = enemy:GetNetworkState() ~= -1
            if enemy ~= get_localplayer() and not enemy:IsTeamMate() and enemy:GetProp("DT_BasePlayer", "m_iHealth") > 0 and enemy:IsDormant() and target_correct then
                return i
            end
        end
    end

    function dormantaimsex(cmd)
        local players = EntityList.GetEntitiesByName("CCSPlayer")
        local weap = get_localplayer():GetActiveWeapon()
        if weap ~= nil then
            local weapon_id = weap:GetWeaponID()
        end

        if cfg.aimdorm:GetBool() and get_dormant_enemy() then
            local dormant_target = players[get_dormant_enemy()]:GetPlayer()
            local weap_delay = (weapon_id == 9 or weapon_id == 40) and 0.15 or 0.0
            if dormant_target and weap_delay and weap:GetProp("m_flNextPrimaryAttack") and GlobalVars.curtime and weap:GetProp("m_flNextPrimaryAttack") + weap_delay <= GlobalVars.curtime and get_localplayer():GetProp("m_bIsScoped") and not is_in_air(get_localplayer()) then
                local bounds = dormant_target:GetRenderBounds(min, max)
                local pos = dormant_target:GetProp("m_vecOrigin") + Vector.new((min.x + max.x) / 4, (min.y + max.y) / 16, (min.z + max.z / 2))
                if Cheat.FireBullet(get_localplayer(), get_localplayer():GetEyePosition(), pos).damage >= cfg.aimdormmd:GetInt() then
                    autostop(cmd)

                    if 1 / weap:GetInaccuracy(weap) >= 100 then
                        local getaimpunch = get_localplayer():GetProp("DT_BasePlayer", "m_aimPunchAngle")
                        local aimpunch = QAngle.new(getaimpunch.x, getaimpunch.y, 0.0)
                        local aim_angle = calc_angle(get_localplayer():GetEyePosition(), pos)
                        cmd.viewangles.pitch = aim_angle.pitch - aimpunch.pitch * 2
                        cmd.viewangles.yaw = aim_angle.yaw - aimpunch.yaw * 2
                        cmd.buttons = bit.bor(cmd.buttons, 1)
                    end
                end
            end
        end
    end

    Cheat.RegisterCallback('prediction', function(cmd)
        dormantaimsex(cmd)
        antibackstab()
    end)
    Cheat.RegisterCallback('pre_prediction', function(cmd)
        Pitch = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Pitch")
        YawBase = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
        YawAdd = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Add")
        YawMod = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Modifier")
        ModDeg = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Modifier Degree")
        LeftLimit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Left Limit")
        RightLimit = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Right Limit")
        FakeOptions = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
        LBYMode = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
        freestandDesync = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
        DesyncOnShot = Menu.FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
        instant_recharge()
        Exploits_func()
        if marius > GlobalVars.curtime or not cfg.legitaa:GetBool() then
            marius = GlobalVars.curtime
        end
        if cfg.legitaa:GetBool() and GlobalVars.curtime - marius > 0.1 then
            marius = GlobalVars.curtime
            diduans = true
        end
        if cfg.legitaa:GetBool() and diduans and Cheat.IsKeyDown(0x45) then
            LegitAA(cmd)
        else
            if setLegitOptions == true then
                FakeOptions:SetInt(presaveforlegit[1])
                LBYMode:SetInt(presaveforlegit[2])
                freestandDesync:SetInt(presaveforlegit[3])
                DesyncOnShot:SetInt(presaveforlegit[4])
                setLegitOptions = false
            else
                presaveforlegit[1] = FakeOptions:GetInt()
                presaveforlegit[2] = LBYMode:GetInt()
                presaveforlegit[3] = freestandDesync:GetInt()
                presaveforlegit[4] = DesyncOnShot:GetInt()
            end
            diduans = false
        end
        CustomTicks()
        CustomTicksDT()
        fluctuate_fakelag()
        dtinair()
        randomized_fakelags()
        Dynamic()
        mafutemama(cmd)
        fakeflickes(cmd)
        dormantaimsex(cmd)
        antionshotfunc()
        antiaim_helpers()
        antibackstab()
        reversefreestanding()
        if cfg.lcbreak:GetBool() then
            breaklc()
        end
    end)
    function lethaldt()
        binds = Cheat.GetBinds()
        for i = 1, #binds do --  Iterate over our binds...
            bind = binds[i]
            if bind:GetName() == 'Minimum Damage' then
                return
            end
        end
        if cfg.dt_lethal:GetBool() == true and cfg.DTSettings:GetBool() and double_tap:GetBool() then
            local local_player = EntityList.GetClientEntity(EngineClient.GetLocalPlayer()):GetPlayer()
            is_alive = local_player:GetProp("DT_BasePlayer", "m_iHealth") > 0
            if not is_alive then return end
            local players = EntityList.GetPlayers()

            for _, player in ipairs(players) do
                if not player:IsTeamMate() then
                    local user_index = player:EntIndex()

                    local health = player:GetProp("m_iHealth")
                    if health > 0 then
                        if health > 90 then
                            dmg = 50
                        end
                        if health < 50 then
                            dmg = 30
                        end
                        RageBot.OverrideMinDamage(user_index, dmg)
                    end
                end
            end
        end
    end

    local last_taim = 0
    Cheat.RegisterCallback("createmove", function(cmd)
        dormantaimsex(cmd)
        antionshotfunc()
        antiaim_helpers()
        lethaldt()
        if cfg.fakelagexploit:GetBool() and not fake_duck:GetBool() then
            if last_taim > GlobalVars.curtime then
                last_taim = GlobalVars.curtime
            end
            if GlobalVars.curtime - last_taim > 0.32 then
                last_taim = GlobalVars.curtime
                FakeLag.SetState(true)
            end
        end
        local slowwalk_ref = Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Slow Walk")
        local slowwalk_speed = cfg.slowwalkspeed:GetInt()
        if not cfg.customslowwalkspeed:GetBool() or not slowwalk_ref:GetBool() then
            return
        end

        local min_speed = math.sqrt((cmd.forwardmove * cmd.forwardmove) + (cmd.sidemove * cmd.sidemove))
        if min_speed <= 0 then
            return
        end

        if lp:GetPlayer():GetProp("m_fFlags") == 262 or lp:GetPlayer():GetProp("m_fFlags") == 263 then
            slowwalk_speed = slowwalk_speed * 2.94117647
        end

        if min_speed <= slowwalk_speed then
            return
        end

        local speed_factor = slowwalk_speed / min_speed
        cmd.forwardmove = cmd.forwardmove * speed_factor
        cmd.sidemove = cmd.sidemove * speed_factor

    end);
    local ffi = require "ffi"
    ffi.cdef [[

    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

]]


    local entity_list_ptr = ffi.cast("void***", Utils.CreateInterface("client.dll", "VClientEntityList003"))
    local get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])


    local ffi_helpers = {

        get_animstate_offset = function()

            return 14612

        end,



        get_entity_address = function(ent_index)

            local addr = get_client_entity_fn(entity_list_ptr, ent_index)

            return addr

        end

    }

    function get_velocity(player)
        local vel = {}
        -- Velocity calculation
        vel[1] = player:GetProp("m_vecVelocity[0]")
        vel[2] = player:GetProp("m_vecVelocity[1]")
        vel[3] = math.sqrt(vel[1] * vel[1] + vel[2] * vel[2])
        return math.floor(math.min(350, vel[3]))
    end

    function fakeflickes(cmd)
        if not cfg.fakeflickescheck:Get() then return end
        if fake_duck:Get() then return end
        local localplayer = EntityList.GetLocalPlayer()
        if (localplayer == nil) then
            return
        end
        if cfg.fakeflickesmode:GetInt() == 0 then
            if get_velocity(localplayer) > 15 or dont_flick then return end
            if GlobalVars.tickcount % 64 == 1 or GlobalVars.tickcount % 64 == 2 then
                AntiAim.OverrideYawOffset(95 * (flick_side and 1 or -1))
                AntiAim.OverrideInverter(flick_side)
            end
            actual_yaw = cmd.viewangles.yaw
        elseif cfg.fakeflickesmode:GetInt() == 2 then
            if double_tap:Get() or hide_shots:Get() then
                if get_velocity(localplayer) > 15 or dont_flick then return end
                if GlobalVars.tickcount % 64 == 1 or GlobalVars.tickcount % 64 == 2 then
                    AntiAim.OverrideYawOffset(95 * (flick_side and 1 or -1))
                    AntiAim.OverrideInverter(flick_side)
                end
                actual_yaw = cmd.viewangles.yaw
            else
                local velocity = localplayer:GetProp("m_vecVelocity"):Length2D()

                if double_tap:Get() or hide_shots:Get() then
                    return
                end

                if velocity > 10 then return end

                if ClientState.m_choked_commands < CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() then
                    FakeLag.SetState(false)
                end

                if ClientState.m_choked_commands >= CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() - 2 and ClientState.m_choked_commands < CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() then
                    AntiAim.OverrideYawOffset(flick_side and 104 or -104)
                end
            end
        else

            local velocity = localplayer:GetProp("m_vecVelocity"):Length2D()

            if double_tap:Get() or hide_shots:Get() then
                return
            end

            if velocity > 10 then return end

            if ClientState.m_choked_commands < CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() then
                FakeLag.SetState(false)
            end

            if ClientState.m_choked_commands >= CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() - 2 and ClientState.m_choked_commands < CVar.FindVar("sv_maxusrcmdprocessticks"):GetInt() then
                AntiAim.OverrideYawOffset(flick_side and 104 or -104)
            end
        end
    end

    function Menufunc()
        cfg.dtmodes:SetVisible(cfg.DTSettings:GetBool())
        cfg.dt_ticks:SetVisible(cfg.DTSettings:GetBool() and cfg.dtmodes:GetInt() == 3)
        cfg.dtcorrection:SetVisible(cfg.DTSettings:GetBool())
        cfg.ReverseFreeStand_Combo:SetVisible(cfg.ReverseFreeStand:GetBool())
        cfg.instantrecharge:SetVisible(cfg.DTSettings:GetBool())
        cfg.instantrecharge_mode:SetVisible(cfg.DTSettings:GetBool() and cfg.instantrecharge:GetBool())
        cfg.ScopeOrigin:SetVisible(quest(cfg.SkeetScope:GetBool()))
        cfg.ScopeWidth:SetVisible(quest(cfg.SkeetScope:GetBool()))
        cfg.slowwalkspeed:SetVisible(cfg.customslowwalkspeed:GetBool())
        cfg.dt_lethal:SetVisible(cfg.DTSettings:GetBool())
        cfg.indicators_type:SetVisible(cfg.indicators:GetBool())
        color_main:SetVisible(cfg.indicators:GetBool())
        color_accent:SetVisible(cfg.indicators:GetBool())
        cfg.indicators_list:SetVisible(cfg.indicators:GetBool() and cfg.indicators_type:GetInt() == 1)
        cfg.aimdormmd:SetVisible(quest(cfg.aimdorm:GetBool()))
        cfg.fakelagesEnableDT:SetVisible(cfg.fakelagesEnable:GetBool())
        cfg.fakelagexploit:SetVisible(cfg.fakelagesEnable:GetBool())
        cfg.fakelagesCustomTicks:SetVisible(cfg.fakelagesType:Get() == 1 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesType:SetVisible(cfg.fakelagesEnable:GetBool())
        cfg.fakelagesCustomLimitTime:SetVisible(cfg.fakelagesType:Get() == 2 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesLimit:SetVisible(cfg.fakelagesType:Get() == 2 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesRandomization:SetVisible(cfg.fakelagesType:Get() == 2 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesRandomizedmin:SetVisible(cfg.fakelagesType:Get() == 3 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesRandomizedmax:SetVisible(cfg.fakelagesType:Get() == 3 and cfg.fakelagesEnable:GetBool())
        cfg.fakelagesRandomizedtime:SetVisible(cfg.fakelagesType:Get() == 3 and cfg.fakelagesEnable:GetBool())
        cfg.tabsdesyncmod:SetVisible(quest(cfg.desyncmod:GetBool()))
        cfg.desyncmodowostanding:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.desyncmodowomoving:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.desyncmodowoair:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.desyncmodowoslowwalk:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.randomizeeveryroundstanding:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.randomizeeveryroundmoving:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.randomizeeveryroundair:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.randomizeeveryroundslowwalk:SetVisible(quest(cfg.desyncmod:GetBool()) and cfg.tabsdesyncmod:GetInt() == 3)
        for index, object in pairs(items.menu) do
            object:SetVisible(quest(cfg.antibrute:GetBool()))
        end
        loadcloud:SetVisible(quest(cfgcount > 0))
        export:SetVisible(quest(cfgcount > 0))
        deletecloud:SetVisible(quest(cfgcount > 0))
        menu.add:SetVisible(quest(cfg.antibrute:GetBool()))
        menu.remove:SetVisible(quest(cfg.antibrute:GetBool()))

        cfg.uisexkeybinds_x:SetVisible(false)
        cfg.uisexkeybinds_y:SetVisible(false)
        cfg.uisexspectators_x:SetVisible(false)
        cfg.uisexspectators_y:SetVisible(false)
        cfg.uisexbox_alpha:SetVisible(false)

        cfg.sinv:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.sleft:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.sright:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.sfkopt:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.slby:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.sfr:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.sdes:SetVisible(cfg.desyncmodowostanding:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 0)
        cfg.winv:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wleft:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wright:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wfkopt:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wlby:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wfr:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.wdes:SetVisible(cfg.desyncmodowomoving:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 1)
        cfg.swinv:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swleft:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swright:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swfkopt:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swlby:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swfr:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.swdes:SetVisible(cfg.desyncmodowoslowwalk:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 3)
        cfg.ainv:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.aleft:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.aright:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.afkopt:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.alby:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.afr:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)
        cfg.ades:SetVisible(cfg.desyncmodowoair:GetInt() == 5 and cfg.tabsdesyncmod:GetInt() == 2)

        desyncarrowscolors:SetVisible(cfg.desyncarrows:GetBool())
        cfg.desyncarrowscombo:SetVisible(cfg.desyncarrows:GetBool())
        cfg.ExtendedLeanVal:SetVisible(cfg.ExtendedLean:GetBool() and cfg.ExtendedLeanMode:GetInt() < 2)
        cfg.ExtendedLeanMode:SetVisible(cfg.ExtendedLean:GetBool())
        cfg.ExtendedLeanJitter:SetVisible(cfg.ExtendedLean:GetBool() and cfg.ExtendedLeanMode:GetInt() == 1)
        if cfg.fakelagexploit:Get() then
            cfg.lcbreak:SetBool(false)
            cfg.lcbreak:SetVisible(false)
        else
            cfg.lcbreak:SetVisible(true)
        end
        if cfg.lcbreak:Get() then
            cfg.fakelagexploit:SetBool(false)
            cfg.fakelagexploit:SetVisible(false)
        else
            cfg.fakelagexploit:SetVisible(true)
        end
    end

    function move(x, y, w, h, slider_x, slider_y)
        mouse = Cheat.GetMousePos()
        if (Cheat.IsKeyDown(0x1) and Cheat.IsMenuVisible() and in_box(mouse, x, y, x + w, y + h)) then
            slider_x:SetInt(mouse.x - w / 2)
            slider_y:SetInt(mouse.y - 10)
        end
    end

    function get_time()
        seconds = math.floor(Utils.UnixTime() / 1000)
        hours = math.floor((seconds / 3600 + 3) % 24)
        minutes = math.floor(seconds / 60 % 60)
        sec = math.floor(seconds % 60)

        if sec < 10 then sec = "0" .. sec end
        if minutes < 10 then minutes = "0" .. minutes end
        if hours < 10 then hours = "0" .. hours end

        return hours .. ":" .. minutes .. ":" .. sec
    end

    function get_spectators()
        spectators = {}
        players = EntityList.GetPlayers()
        local_player = EntityList.GetLocalPlayer()

        for i, spects in pairs(players) do
            if not spects:IsDormant() and spects:GetProp("m_iHealth") < 1 then
                target = EntityList.GetPlayerFromHandle(spects:GetProp("m_hObserverTarget"))

                if target == local_player then
                    table.insert(spectators, spects:GetName())
                end
            end
        end
        return spectators
    end

    get_theme = {
        [0] = function(x, y, w, col)
            Render.GradientBoxFilled(Vector2.new(x + w, y), Vector2.new(x + w / 2, y - 2), color(255, 234, 0, col.a), color(255, 0, 238, col.a), color(255, 234, 0, col.a), color(255, 0, 238, col.a))
            Render.GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - 2), color(0, 200, 255, col.a), color(255, 0, 238, col.a), color(0, 200, 255, col.a), color(255, 0, 238, col.a))
        end,

        [1] = function(x, y, w, col)
            Render.BoxFilled(Vector2.new(x, y), Vector2.new(x + w, y - 2), col)
        end,

        [2] = function(x, y, w, col, col2)
            Render.GradientBoxFilled(Vector2.new(x + w, y), Vector2.new(x + w / 2, y - 2), color(1, 1, 1, col2), col, color(1, 1, 1, col2), col)
            Render.GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - 2), color(1, 1, 1, col2), col, color(1, 1, 1, col2), col)
        end
    }

    local function get_box_alpha() return cfg.uisexbox_alpha:GetInt() end

    local function get_local_ping()
        local ping

        if EngineClient.IsConnected() == true then ping = math.floor(EngineClient.GetNetChannelInfo():GetLatency(0) * 1000) else ping = 0 end

        return ping
    end

    local function get_server_tick()
        local tick

        if EngineClient.IsConnected() == true then tick = math.floor(1.0 / GlobalVars.interval_per_tick) else tick = 0 end

        return tostring(tick)
    end

    local function get_custom_text_from_ui(text, ui_text)
        local results_text

        if ui_text:GetString() == "" then results_text = text else results_text = ui_text:GetString() end

        return tostring(results_text)
    end

    local function get_slowly_info()
        if last_time > GlobalVars.curtime then
            last_time = GlobalVars.curtime
        end
        if GlobalVars.curtime - last_time > 0.5 then
            last_time = GlobalVars.curtime
            table.insert(fps_info, 1 / GlobalVars.frametime)
            if cfg.fakelagexploit:Get() and Exploits.GetCharge() <= 0 then
                lag = ClientState.m_choked_commands * 2
            else
                lag = ClientState.m_choked_commands
            end
            delta = math.min(math.abs(AntiAim.GetCurrentRealRotation() - AntiAim.GetFakeRotation()) / 2, 58)
        end
    end

    local function adaptive_color(val)
        if val < 40 then return { 255, 255, 255 } end
        if val < 100 then return { 255, 125, 95 } end

        return { 255, 60, 80 }
    end

    local function render_adaptive_box(type, x, y, name, alpha)
        name_size = Render.CalcTextSize(name, font_size, font)
        line = uisexline_color:GetColor()

        if type == "watermark" then
            get_theme[cfg.uisexthemes:GetInt()](x - name_size.x - 16, y, name_size.x + 6, Color.new(uisexline_color:GetColor().r, uisexline_color:GetColor().g, uisexline_color:GetColor().b, 255 * alpha), 10 * alpha)
            Render.BoxFilled(Vector2.new(x - 10, y), Vector2.new(x - name_size.x - 16, y + 17), color(20, 20, 20, get_box_alpha() * alpha))
            Render.Text(name, Vector2.new(x - name_size.x - 12.5, y + 2), text_color(alpha), font_size, font, cfg.uisextext_outline:GetBool())
        end

        if type == "keybinds" then
            get_theme[cfg.uisexthemes:GetInt()](x, y, 150, Color.new(uisexline_color:GetColor().r, uisexline_color:GetColor().g, uisexline_color:GetColor().b, 255 * alpha), 10 * alpha)
            Render.BoxFilled(Vector2.new(x, y), Vector2.new(x + 150, y + 17), color(20, 20, 20, get_box_alpha() * alpha))
            Render.Text(name, Vector2.new(x + 150 / 2 - name_size.x / 2, y + 2), text_color(alpha), font_size, font, cfg.uisextext_outline:GetBool())
        end
    end

    local function gradient_rect(x, y, w, h)
        Render.GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w, y - h), color(134, 175, 255, 255), color(134, 175, 255, 255), color(134, 175, 255, 0), color(134, 175, 255, 0))
    end

    local function gradient_background(x, y, w, h, color_1, color_2)
        Render.GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - h), color_2, color_1, color_2, color_1)
        Render.GradientBoxFilled(Vector2.new(x + w / 2, y), Vector2.new(x + w, y - h), color_1, color_2, color_1, color_2)
    end

    local function gradient_for_fake(x, y, w, h, color_1, color_2)
        Render.GradientBoxFilled(Vector2.new(x, y), Vector2.new(x - w, y - h / 2), color_2, color_2, color_1, color_1)
        Render.GradientBoxFilled(Vector2.new(x, y - h / 2), Vector2.new(x - w, y - h), color_1, color_1, color_2, color_2)
    end

    local function draw_fucking_box(x, y, w, text, style, line, line_color)
        text_size = Render.CalcTextSize(text, 12, font) + 10 + w

        if style == 1 then
            gradient_background(x - text_size.x, y + 19, text_size.x, 19, color(17, 17, 17, 80), color(17, 17, 17, 10))
        end

        if style == 0 then
            Render.BoxFilled(Vector2.new(x - text_size.x, y), Vector2.new(x, y + 19), color(17, 17, 17, 100))
        end

        Render.Text(text, Vector2.new(x - text_size.x + 5, y + 3), text_color(1), 12, font, cfg.uisextext_outline:GetBool())

        if line and line_color == nil then return end

        if line == 0 then
            gradient_background(x - text_size.x, y + 20, text_size.x, 1, color(line_color[1], line_color[2], line_color[3], 255), color(line_color[1], line_color[2], line_color[3], 0))
        end

        if line == 1 then
            gradient_for_fake(x - text_size.x, y + 19, 2, 19, color(line_color[1], line_color[2], line_color[3], 255), color(line_color[1], line_color[2], line_color[3], 0))
        end
    end

    local function draw_fake()
        local fake_text = string.format("FAKE (%s°)", string.format("%.1f", delta))
        local fake_color = { 255 - delta * 4, 15 + delta * 4, 0 }

        draw_fucking_box(screen_size.x - fake_dt_w - 10, 32, 0, fake_text, 1, 1, fake_color)
    end

    function draw_watermark()
        watermark_text = string.format("%s | %s | delay: %sms | %stick | %s", get_custom_text_from_ui("exodus", uisexcustom_cheat_name), get_custom_text_from_ui(cheat_username, uisexcustom_cheat_name), get_local_ping(), get_server_tick(), get_time())

        render_adaptive_box("watermark", screen_size.x, 10, watermark_text, 1)
    end

    function draw_dt()
        fl_text = string.format("FL: %s", lag)
        if double_tap:GetBool() then fl_text = fl_text .. " | SHIFTING" end

        dt_text_size = Render.CalcTextSize(fl_text, 12, font)

        fake_dt_w = dt_text_size.x + 15

        draw_fucking_box(screen_size.x - 10, 32, 0, fl_text, 0)
    end

    function draw_hz()
        hz_text = string.format("%sms", get_local_ping())

        hz_text_size = Render.CalcTextSize(hz_text, 12, font)

        get_adap_col = adaptive_color(get_local_ping())

        frame_color = { get_adap_col[1], get_adap_col[2], get_adap_col[3] }

        hz_io_w = hz_text_size.x + 15

        draw_fucking_box(screen_size.x - 10, 57, 0, hz_text, 0, 0, frame_color)
    end

    function draw_io()
        cvar_fps_max = CVar.FindVar("fps_max"):GetInt()

        if #fps_info > 4 then table.remove(fps_info, 1) end

        draw_fucking_box(screen_size.x - hz_io_w - 10, 57, 25, "IO |", 0)

        if cvar_fps_max > 100 then fps_max = cvar_fps_max else fps_max = 100 end

        for i = 1, #fps_info do
            gradient_rect(screen_size.x - hz_io_w - 42 - i * 5 + 25, 72, 6, fps_info[i] / fps_max * 9)
        end
    end

    keybinds_alpha = 0

    function draw_keybinds()
        binds = Cheat.GetBinds()
        keybinds_next_line = 0

        keybinds_x, keybinds_y = cfg.uisexkeybinds_x:GetInt(), cfg.uisexkeybinds_y:GetInt()

        function render_binds(binds)
            if not binds:IsActive() then return end
            bind_name = binds:GetName()
            binds_state = string.format("[%s]", binds:GetValue())

            binds_state_size = Render.CalcTextSize(binds_state, 12, font)

            Render.Text(bind_name, Vector2.new(keybinds_x + 1, keybinds_y + 21 + keybinds_next_line), text_color(1), 12, font, cfg.uisextext_outline:GetBool())
            Render.Text(binds_state, Vector2.new(keybinds_x + 149 - binds_state_size.x, keybinds_y + 21 + keybinds_next_line), text_color(1), 12, font, cfg.uisextext_outline:GetBool())

            keybinds_next_line = keybinds_next_line + 16
        end

        if #binds > 0 or Cheat.IsMenuVisible() then
            keybinds_alpha = clamp(keybinds_alpha + (1 / .15) * GlobalVars.frametime, 0, 1)
        else
            keybinds_alpha = clamp(keybinds_alpha - (1 / .15) * GlobalVars.frametime, 0, 1)
        end

        render_adaptive_box("keybinds", keybinds_x, keybinds_y, "keybinds", keybinds_alpha)

        for i = 1, #binds do
            render_binds(binds[i])
        end

        move(keybinds_x, keybinds_y, 150, 25 + 15 * #binds, cfg.uisexkeybinds_x, cfg.uisexkeybinds_y)
    end

    spectators_alpha = 0

    function draw_spectators()
        spectators = get_spectators()
        spectators_next_line = 0

        spectators_x, spectators_y = cfg.uisexspectators_x:GetInt(), cfg.uisexspectators_y:GetInt()

        function render_spectators(spectators_name)
            spectators_state = "[watching]"
            spectators_state_size = Render.CalcTextSize(spectators_state, 12, font)

            Render.Text(spectators_name, Vector2.new(spectators_x + 1, spectators_y + 21 + spectators_next_line), text_color(1), 12, font, cfg.uisextext_outline:GetBool())
            Render.Text(spectators_state, Vector2.new(spectators_x + 149 - spectators_state_size.x, spectators_y + 21 + spectators_next_line), text_color(1), 12, font, cfg.uisextext_outline:GetBool())
            spectators_next_line = spectators_next_line + 16
        end

        if #spectators > 0 or Cheat.IsMenuVisible() then
            spectators_alpha = clamp(spectators_alpha + (1 / .15) * GlobalVars.frametime, 0, 1)
        else
            spectators_alpha = clamp(spectators_alpha - (1 / .15) * GlobalVars.frametime, 0, 1)
        end

        render_adaptive_box("keybinds", spectators_x, spectators_y, "spectators", spectators_alpha)

        for i = 1, #spectators do
            render_spectators(spectators[i])
        end

        move(spectators_x, spectators_y, 150, 25 + 15 * #spectators, cfg.uisexspectators_x, cfg.uisexspectators_y)
    end

    ffi.cdef [[
        typedef int(__fastcall* clantag_t)(const char*, const char*);
    ]]
    local fn_change_clantag = Utils.PatternScan("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
    local set_clantag = ffi.cast("clantag_t", fn_change_clantag)
    local animation = {
        "3",
        "E><",
        "EX0",
        "EXO|)",
        "EXOD|_|",
        "EXODU$",
        "EXODUS˙",
        "EXODUS·",
        "EXODUS.",
        "EXODUS.ω",
        "EXODUS.Wτ",
        "EXODUS.WTƒ",
        "EXODUS.WTF",
        "EXODUS.WTF",
        "EXODUS.WTF",
    }


    local old_time = 0
    local didonce = true
    local draw_autopeek = function()

        if cfg.glowautopeek:Get() == true then
            if EntityList.GetLocalPlayer() == nil then return end
            if EntityList.GetLocalPlayer():GetProp("m_iHealth") <= 0 then return end

            if Menu.FindVar("Miscellaneous", "Main", "Movement", "Auto Peek"):Get() == false then
                apeekorigin = EntityList.GetLocalPlayer():GetProp('m_vecOrigin')
                return
            end
            if not apeekorigin then return end

            for i = 1, 60 do

                local apeekval = 1 / i

                if i <= 60 then

                    apeekval = apeekval + 1.5

                end

                apeekcolor = cfg.glowautopeek:GetColor()

                apeekcolor.a = apeekval / 50
                Render.Circle3DFilled(apeekorigin, 28, i / -2.5, apeekcolor)
                Render.Circle3DFilled(apeekorigin, 18, i / -2.6, apeekcolor)

            end
        end
    end
    function drawlogesowo()
        lua.color = Color.RGBA(255, 255, 255, 255)
        if #lua.logs.stuff > 4 then
            table.remove(lua.logs.stuff, 1)
        end
        if not EngineClient.IsConnected() then
            lua.logs.stuff = {}
            return
        end
        for i, log in ipairs(lua.logs.stuff) do
            render.box(log.text, i * 45, 255)
            if log.time + 5 < GlobalVars.realtime then table.remove(lua.logs.stuff, i) end
        end
    end

    Cheat.RegisterCallback('draw', function()
        Menufunc()
        fast_recharge()
        drawlogesowo()
        if cfg.clantagcheckbox:GetBool() then
            local curtime = math.floor(GlobalVars.curtime)
            if old_time ~= curtime then
                set_clantag(animation[curtime % #animation + 1], "EXODUS.WTF")
            end
            old_time = curtime
            didonce = false
        elseif not cfg.clantagcheckbox:GetBool() and not didonce then
            set_clantag(" ", " ")
            didonce = true
        end
        local_player_index = EngineClient.GetLocalPlayer()
        local_player       = EntityList.GetClientEntity(local_player_index)
        lp                 = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
        if not local_player then
            CVar.FindVar("hidehud"):SetInt(0)
            CVar.FindVar("r_drawvgui"):SetInt(1)
            return
        end
        if local_player:GetProp("m_iHealth") <= 0 then
            CVar.FindVar("hidehud"):SetInt(0)
            CVar.FindVar("r_drawvgui"):SetInt(1)
            return
        end

        local player = EntityList.GetLocalPlayer()
        if player == nil then return end
        local lp_origin = player:GetHitboxCenter(3)
        lp_origin = lp_origin + Vector.new(0, 0, 0)
        local lp_screen = Render.ScreenPosition(lp_origin)
        local viewangles = EngineClient.GetViewAngles()
        local closest_left = {
            length = nil,
            angle = nil,
        }
        for i = 20, 120, 10 do
            local trace_angle = lp_origin + Cheat.AngleToForward(QAngle.new(0, i + viewangles.yaw, 0)) * 100
            local current_trace = EngineTrace.TraceRay(lp_origin, trace_angle, player, 0xFFFFFFFF)
            local screen_trace = Render.ScreenPosition(current_trace.endpos)
            local length = lp_origin:DistTo(current_trace.endpos)
            if closest_left.length == nil or length - 1 > closest_left.length then
                closest_left.length = length
                closest_left.angle = i
            end
        end
        local closest_right = {
            length = nil,
            angle = nil,
        }
        for i = -20, -120, -10 do
            local trace_angle = lp_origin + Cheat.AngleToForward(QAngle.new(0, i + viewangles.yaw, 0)) * 100
            local current_trace = EngineTrace.TraceRay(lp_origin, trace_angle, player, 0xFFFFFFFF)
            local screen_trace = Render.ScreenPosition(current_trace.endpos)
            local length = lp_origin:DistTo(current_trace.endpos)
            if closest_right.length == nil or length - 1 > closest_right.length then
                closest_right.length = length
                closest_right.angle = i
            end
        end
        if math.abs(closest_left.angle) < math.abs(closest_right.angle) then
            flick_side = false
            dont_flick = false
            local trace_angle = lp_origin + Cheat.AngleToForward(QAngle.new(0, closest_left.angle + viewangles.yaw, 0)) * 100
            local current_trace = EngineTrace.TraceRay(lp_origin, trace_angle, player, 0xFFFFFFFF)
            local screen_trace = Render.ScreenPosition(current_trace.endpos)
            --Render.Line(lp_screen, screen_trace, Color.new(1.0, 0.0, 0.0, 1.0))
            -- print("Flicking left")
        elseif math.abs(closest_left.angle) > math.abs(closest_right.angle) then
            flick_side = true
            dont_flick = false
            local trace_angle = lp_origin + Cheat.AngleToForward(QAngle.new(0, closest_right.angle + viewangles.yaw, 0)) * 100
            local current_trace = EngineTrace.TraceRay(lp_origin, trace_angle, player, 0xFFFFFFFF)
            local screen_trace = Render.ScreenPosition(current_trace.endpos)
            --Render.Line(lp_screen, screen_trace, Color.new(1.0, 0.0, 0.0, 1.0))
            -- print("Flicking right")
        elseif math.abs(closest_left.angle) == math.abs(closest_right.angle) then
            dont_flick = true
        end
        if cfg.uisexwindows:GetBool(1) then draw_watermark() end
        if EngineClient.IsConnected() == true then
            if cfg.indicators:GetBool() then drawIndicators() end
            if cfg.SkeetScope:GetBool() then SkeetScope() else CVar.FindVar("r_drawvgui"):SetInt(1) end
            if cfg.desyncarrows:GetBool() then manuals() end
            get_slowly_info()
            draw_autopeek()
            if cfg.uisexwindows:GetBool(2) then draw_spectators() end
            if cfg.uisexwindows:GetBool(3) then draw_keybinds() end
            if cfg.uisexwindows:GetBool(4) then draw_io() end
            if cfg.uisexwindows:GetBool(5) then draw_fake() end
            if cfg.uisexwindows:GetBool(6) then draw_dt() end
            if cfg.uisexwindows:GetBool(7) then draw_hz() end
        end
    end)

    local function get_closest_enemy()
        local best_dist = 190.0
        local best_enemy = nil
        local me = EntityList.GetLocalPlayer()
        local local_origin = me:GetProp("DT_BaseEntity", "m_vecOrigin")
        local local_screen_orig = Render.ScreenPosition(local_origin)
        local screen = EngineClient.GetScreenSize()

        for idx = 1, GlobalVars.maxClients + 1 do
            local ent = EntityList.GetClientEntity(idx)
            if ent and ent:IsPlayer() then
                local player = ent:GetPlayer()
                local health = player:GetProp("DT_BasePlayer", "m_iHealth")

                if not player:IsTeamMate() and health > 0 and not player:IsDormant() then
                    local origin = ent:GetProp("DT_BaseEntity", "m_vecOrigin")
                    local screen_orig = Render.ScreenPosition(origin)
                    local temp_dist = vec_distance(Vector2.new(screen.x / 2, screen.y / 2), screen_orig)

                    if (temp_dist < best_dist) then
                        best_dist = temp_dist
                        best_enemy = ent
                    end
                end
            end
        end

        return best_enemy
    end

    lastSentPos = Vector.new(0, 0, 0)
    Cheat.RegisterCallback("frame_stage", function()
        if cfg.LegsBreaker:GetBool() then
            if (GlobalVars.tickcount % 5 > 2.5) then Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Leg Movement"):SetInt(1) else Menu.FindVar("Aimbot", "Anti Aim", "Misc", "Leg Movement"):SetInt(2)
            end
        end
        if (cfg.IdealTick:GetBool()) then
            ideal_tick()
        elseif not cfg.IdealTick:GetBool() and allow == true then
            double_tap:SetBool(false)
            autopeekuwu:SetBool(false)
            allow = false
        end
        local local_player = EngineClient.GetLocalPlayer()
        local player = EntityList.GetClientEntity(local_player)
        if EngineClient.IsConnected() and player and player:m_iHealth() > 0 and cfg.predict_improved:GetInt() > 0 then
            if cfg.predict_improved:GetInt() == 1 then
                cl_predictweapons:SetInt(0)
                cl_predict_basetoggles:SetInt(1)
            elseif cfg.predict_improved:GetInt() == 2 then
                cl_predictweapons:SetInt(0)
                cl_predict_basetoggles:SetInt(0)
            end
        else
            cl_predictweapons:SetInt(1)
            cl_predict_basetoggles:SetInt(1)
        end
    end)
    local miss_counter = 0
    function antibrutesowosex(event)
        if event:GetName() == "weapon_fire" and cfg.antibrute:GetBool() then --Weapon Fire event later we run FOV check so we can make sure the bullet is on our direction!
            user_id = event:GetInt("userid", -1)
            user = EntityList.GetPlayerForUserID(user_id)
            local_player = EntityList.GetClientEntity(EngineClient.GetLocalPlayer()) --Get Entity
            player = local_player:GetPlayer()
            health = player:GetProp("DT_BasePlayer", "m_iHealth")

            if (health > 0) then -- if our player is alive we run the AntiBrute Logic!
                closest_enemy = get_closest_enemy() --Get Closest enemy based on distance
                if (closest_enemy ~= nil and user:EntIndex() == closest_enemy:EntIndex()) then
                    if miss_counter >= tablelength(items.menu) then miss_counter = 0 end
                    miss_counter = miss_counter + 1 --Basic so we calculate missed shots of enemy also some checks so if we get hit don't run the code!
                    if cfg.logsowoowowowo:GetBool(3) then
                        table.insert(lua.logs.stuff, { text = "Changed Anti-Bruteforce to phase #" .. miss_counter .. "(" .. items.menu[miss_counter]:Get() .. "°)", time = GlobalVars.realtime })
                        print("[exodus] Changed Anti-Bruteforce to phase #" .. miss_counter .. "(" .. items.menu[miss_counter]:Get() .. "°)")
                    end
                    if miss_counter % 2 == 0 then
                        Menu_invert_side:SetBool(true)
                    else
                        Menu_invert_side:SetBool(false)
                    end
                    AntiAim.OverrideLimit(items.menu[miss_counter]:Get())
                end
            end
        end
    end

    aatypes = {
        'Ideal Fake',
        'Low Delta Sway',
        'Jitter',
        'Smart Jitter',
        'Tank'
    };
    Cheat.RegisterCallback('events', function(event)
        antibrutesowosex(event)
        if event:GetName() == "round_start" then
            mintanke = math.random(45, 59)
            maxtanke = math.random(62, 79)
            smartjittervalueone = math.random(22, 32)
            smartjittervaluetwo = math.random(-25, -5)
            smartjittervaluethree = math.random(41, 52)
            smartjittervaluefour = math.random(-30, -18)
            smartaaone = math.random(20, 35)
            smartaatwo = math.random(50, 65)
            multipleaaone = math.random(25, 35)
            multipleaatwo = math.random(50, 65)
            if cfg.randomizeeveryroundstanding:GetBool() then
                cfg.desyncmodowostanding:SetInt(math.random(1, 4))
                if cfg.logsowoowowowo:GetBool(3) then
                    table.insert(lua.logs.stuff, { text = "New round started, randomized standing anti-aim mode to " .. aatypes[cfg.desyncmodowostanding:GetInt() + 1], time = GlobalVars.realtime })
                    print("[exodus] New round started, randomized standing anti-aim mode to " .. aatypes[cfg.desyncmodowostanding:GetInt() + 1])
                end
            end
            if cfg.randomizeeveryroundmoving:GetBool() then
                cfg.desyncmodowomoving:SetInt(math.random(1, 4))
                if cfg.logsowoowowowo:GetBool(3) then
                    table.insert(lua.logs.stuff, { text = "New round started, randomized moving anti-aim mode to " .. aatypes[cfg.desyncmodowomoving:GetInt() + 1], time = GlobalVars.realtime })
                    print("[exodus] New round started, randomized moving anti-aim mode to " .. aatypes[cfg.desyncmodowomoving:GetInt() + 1])
                end
            end
            if cfg.randomizeeveryroundair:GetBool() then
                cfg.desyncmodowoair:SetInt(math.random(1, 4))
                if cfg.logsowoowowowo:GetBool(3) then
                    table.insert(lua.logs.stuff, { text = "New round started, randomized air anti-aim mode to " .. aatypes[cfg.desyncmodowoair:GetInt() + 1], time = GlobalVars.realtime })
                    print("[exodus] New round started, randomized air anti-aim mode to " .. aatypes[cfg.desyncmodowoair:GetInt() + 1])
                end
            end
            if cfg.randomizeeveryroundslowwalk:GetBool() then
                cfg.desyncmodowoslowwalk:SetInt(math.random(1, 4))
                if cfg.logsowoowowowo:GetBool(3) then
                    table.insert(lua.logs.stuff, { text = "New round started, randomized slowwalk anti-aim mode to " .. aatypes[cfg.desyncmodowoslowwalk:GetInt() + 1], time = GlobalVars.realtime })
                    print("[exodus] New round started, randomized slowwalk anti-aim mode to " .. aatypes[cfg.desyncmodowoslowwalk:GetInt() + 1])
                end
            end

            if cfg.logsowoowowowo:GetBool(3) and (cfg.desyncmodowostanding:GetInt() == 4 or cfg.desyncmodowomoving:GetInt() == 4 or cfg.desyncmodowoair:GetInt() == 4 or cfg.desyncmodowoslowwalk:GetInt() == 4) then
                table.insert(lua.logs.stuff, { text = "New round started, randomized Tank anti-aim values to " .. mintanke .. ", " .. maxtanke, time = GlobalVars.realtime })
                print("[exodus] New round started, randomized Tank anti-aim values to " .. mintanke .. ", " .. maxtanke)
            end
            if cfg.logsowoowowowo:GetBool(3) and (cfg.desyncmodowostanding:GetInt() == 2 or cfg.desyncmodowomoving:GetInt() == 2 or cfg.desyncmodowoair:GetInt() == 2 or cfg.desyncmodowoslowwalk:GetInt() == 2) then
                table.insert(lua.logs.stuff, { text = "New round started, randomized Jitter anti-aim values to " .. multipleaaone .. ", " .. multipleaatwo, time = GlobalVars.realtime })
                print("[exodus] New round started, randomized Jitter anti-aim values to " .. multipleaaone .. ", " .. multipleaatwo)
            end
            if cfg.logsowoowowowo:GetBool(3) and (cfg.desyncmodowostanding:GetInt() == 3 or cfg.desyncmodowomoving:GetInt() == 3 or cfg.desyncmodowoair:GetInt() == 3 or cfg.desyncmodowoslowwalk:GetInt() == 3) then
                table.insert(lua.logs.stuff, { text = "New round started, randomized Smart Jitter anti-aim values to " .. smartjittervalueone .. ", " .. smartjittervaluetwo .. ", " .. smartjittervaluethree .. ", " .. smartjittervaluefour, time = GlobalVars.realtime })
                print("[exodus] New round started, randomized Smart Jitter anti-aim values to " .. smartjittervalueone .. ", " .. smartjittervaluetwo .. ", " .. smartjittervaluethree .. ", " .. smartjittervaluefour)
            end
            if cfg.logsowoowowowo:GetBool(3) and (cfg.desyncmodowostanding:GetInt() == 0 or cfg.desyncmodowomoving:GetInt() == 0 or cfg.desyncmodowoair:GetInt() == 0 or cfg.desyncmodowoslowwalk:GetInt() == 0) then
                table.insert(lua.logs.stuff, { text = "New round started, randomized Ideal Fake anti-aim values to " .. smartaaone .. ", " .. smartaatwo, time = GlobalVars.realtime })
                print("[exodus] New round started, randomized Ideal Fake anti-aim values to " .. smartaaone .. ", " .. smartaatwo)
            end
        end
        if event:GetName() ~= "item_purchase" then
            return
        end
        if not cfg.logsowoowowowo:GetBool(1) then return end

        local player = EntityList.GetPlayerForUserID(event:GetInt("userid", 0))
        if not player then return end
        EntityList.GetLocalPlayer():GetName()
        local name = player:GetName()
        if name == EntityList.GetLocalPlayer():GetName() then
            return
        end
        sex = string.gsub(event:GetString("weapon"), "weapon_", "")
        sex2 = string.gsub(sex, "item_", "")
        if sex2 == "unknown" then return end
        table.insert(lua.logs.stuff, { text = name .. " bought " .. sex2, time = GlobalVars.realtime })
        print('[exodus] ' .. name .. " bought " .. sex2)
    end)
    Cheat.RegisterCallback("destroy", function()
        CVar.FindVar("r_drawvgui"):SetInt(1)
    end)
    print('         √ Succesfully Loaded EXODUS')
    print('               Welcome, ' .. Cheat:GetCheatUserName() .. "!")
    print('         LAST UPDATED: 4/10/2022')
    -- Http.Get(string.format("https://exodus.wtf/getloggedbitch.php?name=%s&lual=%s&succes=%s", Cheat.GetCheatUserName():gsub("%#", "_"), "exodus", "true"))
end

days = 999999
hwidcloud = hwid
EngineClient.ExecuteClientCmd("clear")
-- print('███████╗██╗  ██╗ ██████╗ ██████╗ ██╗   ██╗███████╗')
-- print('██╔════╝╚██╗██╔╝██╔═══██╗██╔══██╗██║   ██║██╔════╝')
-- print('█████╗   ╚███╔╝ ██║   ██║██║  ██║██║   ██║███████╗')
-- print('██╔══╝   ██╔██╗ ██║   ██║██║  ██║██║   ██║╚════██║')
-- print('███████╗██╔╝ ██╗╚██████╔╝██████╔╝╚██████╔╝███████║')
-- print('╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝')
print('shitxodus.lua loaded!')
if days <= 0 then
    -- Http.Get(string.format("https://exodus.wtf/getloggedbitch.php?name=%s&lual=%s&succes=%s", Cheat.GetCheatUserName():gsub("%#", "_"), "exodus", "false"))
    print('         X Failed To Load EXODUS')
    print('               No License')
elseif days > 0 then
    if hwidcloud == 000000 then
        -- Http.Get("https://exodus.wtf/bard/add_hwid.php?user=" .. Cheat.GetCheatUserName():gsub("%#", "_") .. "&hwid=" .. hwid)
        loadsex()
    elseif hwidcloud ~= hwid then
        -- Http.Get(string.format("https://exodus.wtf/getloggedbitch.php?name=%s&lual=%s&succes=%s", Cheat.GetCheatUserName():gsub("%#", "_"), "exodus", "false"))
        print('         X Failed To Load EXODUS')
        print('               Invalid HWID')
    else
        loadsex()
    end
end

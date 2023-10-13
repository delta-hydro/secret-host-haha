--[[ Initialisation ]]--

do
    local replicatedFirst = game:GetService("ReplicatedFirst");

    if replicatedFirst:IsFinishedReplicating() == false then
        replicatedFirst.FinishedReplicating:Wait();
    end
end

--[[ Fake Script ]]--

local script = Instance.new("LocalScript");
script.Name = "HydrogenInit";
getfenv().script = script;

--[[ Variables ]]--

local virtualInputManager = cloneref(Instance.new("VirtualInputManager"));
local guiService = cloneref(game:GetService("GuiService"));

local identifiedcheat = identifyexecutor();
local hui = cloneref(gethui());
local mouse = cloneref(game:GetService("Players").LocalPlayer:GetMouse());
local mouseButton1 = Enum.UserInputType.MouseButton1;
local mouseButton2 = Enum.UserInputType.MouseButton2;

local renv = getrenv();
local genv = getgenv();

local _getinfo = clonefunction(debug.getinfo);
local _getgc = clonefunction(getgc);
local _getreg = clonefunction(getreg);
local _getscripts = clonefunction(getscripts);
local _getmodules = clonefunction(getmodules);
local _gettenv = clonefunction(gettenv);
local _getthreadidentity = clonefunction(getthreadidentity);
local _setthreadidentity = clonefunction(setthreadidentity);
local _newcclosure = clonefunction(newcclosure);
local _gethiddenproperty = clonefunction(gethiddenproperty);
local _getconnections = clonefunction(getconnections);
local _checkcaller = clonefunction(checkcaller);

local _assert = clonefunction(renv.assert);
local _error = clonefunction(renv.error);
local _getfenv = clonefunction(renv.getfenv);
local _mathabs = clonefunction(renv.math.abs);
local _mathfloor = clonefunction(renv.math.floor);
local _pcall = clonefunction(renv.pcall);
local _rawset = clonefunction(renv.rawset);
local _setfenv = clonefunction(renv.setfenv);
local _setmetatable = clonefunction(renv.setmetatable);
local _stringbyte = clonefunction(renv.string.byte);
local _stringchar = clonefunction(renv.string.char);
local _stringformat = clonefunction(renv.string.format);
local _stringgsub = clonefunction(renv.string.gsub);
local _stringfind = clonefunction(renv.string.find)İ
local _tablefind = clonefunction(renv.table.find);
local _taskwait = clonefunction(renv.task.wait);
local _tonumber = clonefunction(renv.tonumber);
local _type = clonefunction(renv.type);
local _typeof = clonefunction(renv.typeof);
local _ipairs = clonefunction(renv.ipairs);

local _isA = clonefunction(game.IsA);
local _isDescendantOf = clonefunction(game.IsDescendantOf);

local _sendKeyEvent = clonefunction(virtualInputManager.SendKeyEvent);
local _sendMouseButtonEvent = clonefunction(virtualInputManager.SendMouseButtonEvent);
local _sendMouseMoveEvent = clonefunction(virtualInputManager.SendMouseMoveEvent);
local _sendMouseWheelEvent = clonefunction(virtualInputManager.SendMouseWheelEvent);

local _getGuiInset = clonefunction(guiService.GetGuiInset);

local httpService = cloneref(game:GetService("HttpService"));
local requestInternal = clonefunction(httpService.RequestInternal);
local startRequest = clonefunction(requestInternal(httpService, { Url = "https://google.com" }).Start);

local _coroutineresume = clonefunction(renv.coroutine.resume);
local _coroutinerunning = clonefunction(renv.coroutine.running);
local _coroutineyield = clonefunction(renv.coroutine.yield);

local _tablefind = clonefunction(table.find);

local isA = clonefunction(game.IsA);

local userAgent = table.concat({ identifyexecutor() }, " ");
local userFingerprint = gethwid();
local userIdentifier = ""; -- Add this when you actually make it work, don't fake it

local cheatIdentifier = {
    Hydrogen = "Hydrogen-Fingerprint",
    Delta = "Delta-Fingerprint",
    Codex = "Hydrogen-Fingerprint"
}

local specialInfo = {
	MeshPart = { "PhysicsData", "InitialSize" },
	UnionOperation = { "AssetId", "ChildData", "FormFactor", "InitialSize", "MeshData", "PhysicsData" },
	Terrain = { "SmoothGrid", "MaterialColors" },
};

local selected_identifier = cheatIdentifier[identifiedcheat];

local hs = game:GetService("HttpService");
local ras = game:GetService("HttpRbxApiService");

local blockedURLs = {
    "auth.roblox.com",
    "advertise.roblox.com",
    "billing.roblox.com",
    "catalog.roblox.com",
    "apis.roblox.com/contacts-api",
    "develop.roblox.com",
    "economy.roblox.com",
    "groups.roblox.com",
    "inventory.roblox.com",
    "apis.roblox.com/pass-product-purchasing",
    "apis.roblox.com/bundles-product-purchasing",
    "publish.roblox.com",
    "trades.roblox.com",
    "twostepverification.roblox.com"
}

local old; old = hookfunction(hs.RequestInternal, newcclosure(function(httpService, requestData)
    if _checkcaller() then
        if requestData.Url then
            for _, blockedURL in _ipairs(blockedURLs) do
                if _stringfind(requestData.Url, blockedURL) then
                    _error("Malicious URL interrupted: " .. requestData.Url)
                end
            end
        end
    end

    return old(httpService, requestData)
end))

local old2; old2 = hookfunction(requestInternal, newcclosure(function(httpService, requestData)
    if _checkcaller() then
        if requestData.Url then
            for _, blockedURL in _ipairs(blockedURLs) do
                if _stringfind(requestData.Url, blockedURL) then
                    _error("Malicious URL interrupted: " .. requestData.Url)
                end
            end
        end
    end

    return old2(httpService, requestData)
end))

--[[ Compatibility ]]--

setreadonly(debug, false);
for i, v in renv.debug do
	debug[i] = v;
end
setreadonly(debug, true);

--[[ Functions ]]--

do
	local coreGui, corePackages = cloneref(game:GetService("CoreGui")), cloneref(game:GetService("CorePackages"));

	local isFromValidDirectory = newcclosure(function(x)
		return not (_isDescendantOf(x, coreGui) or _isDescendantOf(x, corePackages));
	end);

	genv.getloadedmodules = newcclosure(function()
		local modules = {};
		for i, v in _getmodules() do
			if isFromValidDirectory(v) then
				modules[#modules + 1] = v;
			end
		end
		return modules;
	end);
end

genv.getallthreads = newcclosure(function()
	local threads = {};
    for i, v in _getreg() do
		if _type(v) == "thread" then
			threads[#threads + 1] = v;
		end
	end
	return threads;
end);

genv.getrunningscripts = newcclosure(function()
	local scripts = {};
	for i, v in _getreg() do
		if _type(v) == "thread" then
			local scr = _gettenv(v).script;
			if scr and _tablefind(scripts, scr) == nil then
				scripts[#scripts + 1] = scr;
			end
		end
	end
	return scripts;
end);

genv.getcurrentline = newcclosure(function(level)
	_assert(level == nil or _type(level) == "number", "invalid argument #1 to 'getcurrentline' (number or nil expected)");
	return _getinfo((level or 0) + 3).currentline;
end);

genv.getsenv = newcclosure(function(scr)
	_assert(_typeof(scr) == "Instance" and (scr.ClassName == "LocalScript" or scr.ClassName == "ModuleScript"), "invalid argument #1 to 'getsenv' (LocalScript or ModuleScript expected)");
    for i, v in _getreg() do
        if _type(v) == "thread" then
            local tenv = _gettenv(v);
            if tenv.script == scr then
                return tenv;
            end
        end
    end
end);

local _getsenv = clonefunction(getsenv);

genv.getscriptenvs = newcclosure(function()
    local envs = {};
    for i, v in _getreg() do
        if _type(v) == "thread" then
            local env = _gettenv(v);
            local scr = env.script;
            if scr and envs[scr] == nil then
                envs[scr] = env;
            end
        end
    end
    return envs;
end);

genv.getspecialinfo = newcclosure(function(inst)
    local classInfo = _assert(_typeof(inst) == "Instance" and specialInfo[inst.ClassName], "invalid argument #1 to 'getspecialinfo' (MeshPart or UnionOperation or Terrain expected)");
	local instInfo = {};
	for i, v in classInfo do
		instInfo[v] = _gethiddenproperty(inst, v);
	end
	return instInfo;
end);

genv.firesignal = newcclosure(function(signal, ...)
    _assert(_typeof(signal) == "RBXScriptSignal", _stringformat("invalid argument #1 to 'firesignal' (RBXScriptSignal expected, got %s)", _typeof(signal)));
    for i, v in _getconnections(signal) do
        task.spawn(v.Function, ...);
    end
end);

genv.emulate_call = newcclosure(function(func, targetScript, ...)
    _assert(_typeof(func) == "function", _stringformat("invalid argument #1 to 'emulate_call' (function expected, got %s)", _typeof(func)));
    _assert(_typeof(targetScript) == "Instance" and (targetScript.ClassName == "LocalScript" or targetScript.ClassName == "ModuleScript"), "invalid argument #2 to 'emulate_call' (LocalScript or ModuleScript expected)");

    local scriptEnv = _getsenv(targetScript);

    local env = _setmetatable({}, {
        __index = _newcclosure(function(self, idx)
            return scriptEnv[idx];
        end),
        __newindex = _newcclosure(function(self, idx, newval)
            _rawset(self, idx, newval);
        end),
        __metatable = "This metatable is locked."
    });

    return (_newcclosure(function(...)
        local realEnv = _getfenv(1);
        local oldIdentity = _getthreadidentity();
        _setthreadidentity(2);
        _setfenv(1, env);
        local ret = func(...);
        _setfenv(1, realEnv);
        _setthreadidentity(oldIdentity);
        return ret;
    end))(...);
end);

local function performRequest(options)
    local crt = _coroutinerunning();
    local req = startRequest(requestInternal(httpService, options), function(x, y)
        _coroutineresume(crt, y);
    end);
    return _coroutineyield();
end;

genv.request = function(options)
    local headers = {
        ["User-Agent"] = userAgent
    };

    if options.Headers ~= nil then
        for i, v in options.Headers do
            headers[i] = v;
        end
    end

    headers[selected_identifier] = userFingerprint;
    -- headers["Hydrogen-User-Identifier"] = userIdentifier;

    local res = performRequest({
        Url = options.Url,
        Method = options.Method,
        Headers = headers,
        Body = options.Body
    });
    res.Success = res.StatusCode >= 200 and res.StatusCode <= 299;
    return res;
end;

--[[ Input Library ]]--

do
    local keyToEnum = {
        [0x08] = Enum.KeyCode.Backspace;
        [0x09] = Enum.KeyCode.Tab;
        [0x0C] = Enum.KeyCode.Clear;
        [0x0D] = Enum.KeyCode.Return;
        [0x10] = Enum.KeyCode.LeftShift;
        [0x11] = Enum.KeyCode.LeftControl;
        [0x12] = Enum.KeyCode.LeftAlt;
        [0xA5] = Enum.KeyCode.RightAlt;
        [0x13] = Enum.KeyCode.Pause;
        [0x14] = Enum.KeyCode.CapsLock;
        [0x1B] = Enum.KeyCode.Escape;
        [0x20] = Enum.KeyCode.Space;
        [0x21] = Enum.KeyCode.PageUp;
        [0x22] = Enum.KeyCode.PageDown;
        [0x23] = Enum.KeyCode.End;
        [0x24] = Enum.KeyCode.Home;
        [0x25] = Enum.KeyCode.Left;
        [0x26] = Enum.KeyCode.Up;
        [0x27] = Enum.KeyCode.Right;
        [0x28] = Enum.KeyCode.Down;
        [0x2A] = Enum.KeyCode.Print;
        [0x2D] = Enum.KeyCode.Insert;
        [0x2E] = Enum.KeyCode.Delete;
        [0x2F] = Enum.KeyCode.Help;
        [0x30] = Enum.KeyCode.Zero;
        [0x31] = Enum.KeyCode.One;
        [0x32] = Enum.KeyCode.Two;
        [0x33] = Enum.KeyCode.Three;
        [0x34] = Enum.KeyCode.Four;
        [0x35] = Enum.KeyCode.Five;
        [0x36] = Enum.KeyCode.Six;
        [0x37] = Enum.KeyCode.Seven;
        [0x38] = Enum.KeyCode.Eight;
        [0x39] = Enum.KeyCode.Nine;
        [0x41] = Enum.KeyCode.A;
        [0x42] = Enum.KeyCode.B;
        [0x43] = Enum.KeyCode.C;
        [0x44] = Enum.KeyCode.D;
        [0x45] = Enum.KeyCode.E;
        [0x46] = Enum.KeyCode.F;
        [0x47] = Enum.KeyCode.G;
        [0x48] = Enum.KeyCode.H;
        [0x49] = Enum.KeyCode.I;
        [0x4A] = Enum.KeyCode.J;
        [0x4B] = Enum.KeyCode.K;
        [0x4C] = Enum.KeyCode.L;
        [0x4D] = Enum.KeyCode.M;
        [0x4E] = Enum.KeyCode.N;
        [0x4F] = Enum.KeyCode.O;
        [0x50] = Enum.KeyCode.P;
        [0x51] = Enum.KeyCode.Q;
        [0x52] = Enum.KeyCode.R;
        [0x53] = Enum.KeyCode.S;
        [0x54] = Enum.KeyCode.T;
        [0x55] = Enum.KeyCode.U;
        [0x56] = Enum.KeyCode.V;
        [0x57] = Enum.KeyCode.W;
        [0x58] = Enum.KeyCode.X;
        [0x59] = Enum.KeyCode.Y;
        [0x5A] = Enum.KeyCode.Z;
        [0x5B] = Enum.KeyCode.LeftSuper;
        [0x5C] = Enum.KeyCode.RightSuper;
        [0x60] = Enum.KeyCode.KeypadZero;
        [0x61] = Enum.KeyCode.KeypadOne;
        [0x62] = Enum.KeyCode.KeypadTwo;
        [0x63] = Enum.KeyCode.KeypadThree;
        [0x64] = Enum.KeyCode.KeypadFour;
        [0x65] = Enum.KeyCode.KeypadFive;
        [0x66] = Enum.KeyCode.KeypadSix;
        [0x67] = Enum.KeyCode.KeypadSeven;
        [0x68] = Enum.KeyCode.KeypadEight;
        [0x69] = Enum.KeyCode.KeypadNine;
        [0x6A] = Enum.KeyCode.Asterisk;
        [0x6B] = Enum.KeyCode.Plus;
        [0x6D] = Enum.KeyCode.Minus;
        [0x6E] = Enum.KeyCode.Period;
        [0x6F] = Enum.KeyCode.Slash;
        [0x70] = Enum.KeyCode.F1;
        [0x71] = Enum.KeyCode.F2;
        [0x72] = Enum.KeyCode.F3;
        [0x73] = Enum.KeyCode.F4;
        [0x74] = Enum.KeyCode.F5;
        [0x75] = Enum.KeyCode.F6;
        [0x76] = Enum.KeyCode.F7;
        [0x77] = Enum.KeyCode.F8;
        [0x78] = Enum.KeyCode.F9;
        [0x79] = Enum.KeyCode.F10;
        [0x7A] = Enum.KeyCode.F11;
        [0x7B] = Enum.KeyCode.F12;
        [0x7C] = Enum.KeyCode.F13;
        [0x7D] = Enum.KeyCode.F14;
        [0x7E] = Enum.KeyCode.F15;
        [0x90] = Enum.KeyCode.NumLock;
        [0x91] = Enum.KeyCode.ScrollLock;
        [0xA0] = Enum.KeyCode.LeftShift;
        [0xA1] = Enum.KeyCode.RightShift;
        [0xA2] = Enum.KeyCode.LeftControl;
        [0xA3] = Enum.KeyCode.RightControl;
        [0xFE] = Enum.KeyCode.Clear;
        [0xBB] = Enum.KeyCode.Equals;
        [0xDB] = Enum.KeyCode.LeftBracket;
        [0xDD] = Enum.KeyCode.RightBracket;
    };

    local getEnumFromKey = newcclosure(function(key)
        return keyToEnum[key] or Enum.KeyCode.Unknown;
    end);

    genv.keypress = newcclosure(function(key)
		local keyType = _typeof(key);
		_assert(keyType == "string" or keyType == "number" or (keyType == "EnumItem" and key.EnumType == Enum.KeyCode), "invalid argument #1 to 'keypress' (string or number or KeyCode expected)");
        _sendKeyEvent(virtualInputManager, true, keyType == "EnumItem" and key or getEnumFromKey(keyType == "string" and _tonumber(key) or key), false, nil);
    end);

    genv.keyrelease = newcclosure(function(key)
		local keyType = _typeof(key);
		_assert(keyType == "string" or keyType == "number" or (keyType == "EnumItem" and key.EnumType == Enum.KeyCode), "invalid argument #1 to 'keyrelease' (string or number or KeyCode expected)");
        _sendKeyEvent(virtualInputManager, false, keyType == "EnumItem" and key or getEnumFromKey(keyType == "string" and _tonumber(key) or key), false, nil);
    end);

	genv.keyclick = newcclosure(function(key)
		local keyType = _typeof(key);
		_assert(keyType == "string" or keyType == "number" or (keyType == "EnumItem" and key.EnumType == Enum.KeyCode), "invalid argument #1 to 'keyclick' (string or number or KeyCode expected)");
		local input = keyType == "EnumItem" and key or getEnumFromKey(keyType == "string" and _tonumber(key) or key);
        _sendKeyEvent(virtualInputManager, true, input, false, nil);
        _sendKeyEvent(virtualInputManager, false, input, false, nil);
    end);
end

genv.mouse1press = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse1press' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse1press' (number or nil expected)");
    _sendMouseButtonEvent(virtualInputManager, x or mouse.X, y or mouse.Y, mouseButton1, true, nil, 0);
end);

genv.mouse1release = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse1release' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse1release' (number or nil expected)");
    _sendMouseButtonEvent(virtualInputManager, x or mouse.X, y or mouse.Y, mouseButton1, false, nil, 0);
end);

genv.mouse1click = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse1click' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse1click' (number or nil expected)");
    local clickX, clickY = x or mouse.X, y or mouse.Y;
    _sendMouseButtonEvent(virtualInputManager, clickX, clickY, mouseButton1, true, nil, 0);
    _sendMouseButtonEvent(virtualInputManager, clickX, clickY, mouseButton1, false, nil, 0);
end);

genv.mouse2press = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse2press' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse2press' (number or nil expected)");
    _sendMouseButtonEvent(virtualInputManager, x or mouse.X, y or mouse.Y, mouseButton2, true, nil, 0);
end);

genv.mouse2release = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse2release' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse2release' (number or nil expected)");
    _sendMouseButtonEvent(virtualInputManager, x or mouse.X, y or mouse.Y, mouseButton2, false, nil, 0);
end);

genv.mouse2click = newcclosure(function(x, y)
	_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'mouse2click' (number or nil expected)");
	_assert(y == nil or _typeof(y) == "number", "invalid argument #2 to 'mouse2click' (number or nil expected)");
    local clickX, clickY = x or mouse.X, y or mouse.Y;
    _sendMouseButtonEvent(virtualInputManager, clickX, clickY, mouseButton2, true, nil, 0);
    _sendMouseButtonEvent(virtualInputManager, clickX, clickY, mouseButton2, false, nil, 0);
end);

genv.mousemoverel = newcclosure(function(x, y)
	_assert(_typeof(x) == "number", _stringformat("invalid argument #1 to 'mousemoverel' (number expected, got %s)", _typeof(x)));
	_assert(_typeof(y) == "number", _stringformat("invalid argument #2 to 'mousemoverel' (number expected, got %s)", _typeof(y)));
    local inset = _getGuiInset(guiService);
    _sendMouseMoveEvent(virtualInputManager, mouse.X + inset.X + x, mouse.Y + inset.Y + y, nil);
end);

genv.mousemoveabs = newcclosure(function(x, y)
	_assert(_typeof(x) == "number", _stringformat("invalid argument #1 to 'mousemoveabs' (number expected, got %s)", _typeof(x)));
	_assert(_typeof(y) == "number", _stringformat("invalid argument #2 to 'mousemoveabs' (number expected, got %s)", _typeof(y)));
    local inset = _getGuiInset(guiService);
    _sendMouseMoveEvent(virtualInputManager, inset.X + x, inset.Y + y, nil);
end);

genv.mousescroll = newcclosure(function(amount)
	_assert(_typeof(amount) == "number", _stringformat("invalid argument #1 to 'mousescroll' (number expected, got %s)", _typeof(amount)));
    for i = 1, _mathabs(_mathfloor(amount / 120)) do
        _sendMouseWheelEvent(virtualInputManager, mouse.X, mouse.Y, amount >= 0, nil);
        _taskwait();
    end
end);

--[[ ProtoSmasher Input Library ]]--

local _mouse1click = clonefunction(mouse1click);
local _mouse1press = clonefunction(mouse1press);
local _mouse1release = clonefunction(mouse1release);
local _mouse2click = clonefunction(mouse2click);
local _mouse2press = clonefunction(mouse2press);
local _mouse2release = clonefunction(mouse2release);

genv.MOUSE_CLICK = 0;
genv.MOUSE_DOWN = 1;
genv.MOUSE_UP = 2;

genv.Input = {
	LeftClick = newcclosure(function(x)
		_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'LeftClick' (number or nil expected)");
		_assert(x == nil or (x >= 0 and x <= 2), "invalid argument #1 to 'LeftClick' (value between 0 and 2 expected)");
		if x == nil or x == MOUSE_CLICK then
			_mouse1click();
		elseif x == MOUSE_DOWN then
			_mouse1press();
		elseif x == MOUSE_UP then
			_mouse1release();
		end
	end),
	RightClick = newcclosure(function(x)
		_assert(x == nil or _typeof(x) == "number", "invalid argument #1 to 'RightClick' (number or nil expected)");
		_assert(x == nil or (x >= 0 and x <= 2), "invalid argument #1 to 'RightClick' (value between 0 and 2 expected)");
		if x == nil or x == MOUSE_CLICK then
			_mouse2click();
		elseif x == MOUSE_DOWN then
			_mouse2press();
		elseif x == MOUSE_UP then
			_mouse2release();
		end
	end),
	MoveMouse = mousemoverel,
	ScrollMouse = mousescroll,
	KeyPress = keyclick,
	KeyDown = keypress,
	KeyUp = keyrelease
};

--[[ Crypt Library ]]--

crypt.hex = {
	encode = newcclosure(function(str)
		_assert(_typeof(str) == "string", _stringformat("invalid argument #1 to 'encode' (string expected, got %s)", _typeof(str)));
		return _stringgsub(str, ".", function(x)
			return _stringformat("%2x", _stringbyte(x));
		end);
	end),
	decode = newcclosure(function(str)
		_assert(_typeof(str) == "string", _stringformat("invalid argument #1 to 'decode' (string expected, got %s)", _typeof(str)));
		return _stringgsub(str, "%x%x", function(x)
			return _stringchar(_tonumber(x, 16));
		end);
	end)
};

crypt.url = {
	encode = newcclosure(function(str)
		_assert(_typeof(str) == "string", _stringformat("invalid argument #1 to 'encode' (string expected, got %s)", _typeof(str)));
		return _stringgsub(_stringgsub(_stringgsub(str, "\n", "\r\n"), "([^%w _%%%-%.~])", function(x)
			return _stringformat("%%%02X", _stringbyte(x));
		end), " ", "+");
	end),
	decode = newcclosure(function(str)
		_assert(_typeof(str) == "string", _stringformat("invalid argument #1 to 'decode' (string expected, got %s)", _typeof(str)));
		return _stringgsub(_stringgsub(str, "+", " "), "%%(%x%x)", function(x)
			return _stringchar(_tonumber(x, 16));
		end);
	end)
};

--[[ Syn Library ]]--

genv.syn = {
	queue_on_teleport = queueonteleport,
	clear_teleport_queue = clearteleportqueue,
	request = request,
	get_thread_identity = getthreadidentity,
	set_thread_identity = setthreadidentity,
	secure_call = emulate_call,
	crypt = crypt,
	crypto = crypt,
	cache_replace = cache.replace,
	cache_invalidate = cache.invalidate,
	is_cached = cache.iscached,
	write_clipboard = setclipboard,
	is_beta = newcclosure(function()
		return false;
	end)
};

do
	local redirections = {};
	
	syn.protect_gui = newcclosure(function(x)
		_assert(_typeof(x) == "Instance", _stringformat("invalid argument #1 to 'protect_gui' (Instance expected, got %s)", _typeof(x)));
		redirections[x] = x.Parent or false;
		x.Parent = hui;
	end);

	syn.unprotect_gui = newcclosure(function(x)
		_assert(_typeof(x) == "Instance", _stringformat("invalid argument #1 to 'unprotect_gui' (Instance expected, got %s)", _typeof(x)));
		local y = redirections[x];
		if y ~= nil then
			redirections[x] = nil;
			x.Parent = y or nil;
		end
	end);
end

setreadonly(syn, true);

--[[ Aliases ]]--

--[[ ew some more table aliases ]]--
genv.http = {
request = request
}

do
	local aliasData = {
        [getclipboard] = { "fromclipboard" },
        [executeclipboard] = { "execclipboard" },
        [setclipboard] = { "setrbxclipboard", "toclipboard" },
        [hookfunction] = { "hookfunc", "replaceclosure", "replacefunction", "replacefunc", "detourfunction", "replacecclosure", "detour_function" },
        [isfunctionhooked] = { "ishooked" },
        [restorefunction] = { "restorefunc", "restoreclosure" },
        [clonefunction] = { "clonefunc" },
        [makewriteable] = { "make_writeable" },
        [makereadonly] = { "make_readonly" },
        [getinstances] = { "get_instances" },
        [getscripts] = { "get_scripts" },
        [getmodules] = { "get_modules" },
        [getloadedmodules] = { "get_loaded_modules" },
        [getnilinstances] = { "get_nil_instances" },
        [getcallingscript] = { "get_calling_script", "getscriptcaller", "getcaller" },
        [getallthreads] = { "get_all_threads" },
        [getgc] = { "get_gc_objects" },
        [gettenv] = { "getstateenv" },
        [getnamecallmethod] = { "get_namecall_method" },
        [setnamecallmethod] = { "set_namecall_method" },
        [debug.getupvalue] = { "getupvalue" },
        [debug.getupvalues] = { "getupvalues" },
        [debug.setupvalue] = { "setupvalue" },
        [debug.getconstant] = { "getconstant" },
        [debug.getconstants] = { "getconstants" },
        [debug.setconstant] = { "setconstant" },
        [debug.getproto] = { "getproto" },
        [debug.getprotos] = { "getprotos" },
        [debug.getstack] = { "getstack" },
        [debug.setstack] = { "setstack" },
        [debug.getinfo] = { "getinfo" },
        [debug.validlevel] = { "validlevel", "isvalidlevel" },
        [islclosure] = { "is_l_closure" },
        [iscclosure] = { "is_c_closure" },
        [isourclosure] = { "isexecutorclosure", "is_our_closure", "is_executor_closure", "is_krnl_closure", "is_fluxus_closure", "isfluxusclosure", "is_fluxus_function", "isfluxusfunction", "is_protosmasher_closure","checkclosure", "issynapsefunction", "is_synapse_function" },
        [getscriptclosure] = { "getscriptfunction", "get_script_function" },
        [getscriptbytecode] = { "dumpstring" },
        [emulate_call] = { "secure_call", "securecall" },
        [queueonteleport] = { "queue_on_teleport" },
        [clearteleportqueue] = { "clear_teleport_queue" },
        [request] = { "http_request" },
        [getsenv] = { "getmenv" },
        [getfpscap] = { "get_fps_cap" },
        [identifyexecutor] = { "getexecutorname" },
        [getcustomasset] = { "getsynasset" },
        [base64_encode] = { "base64encode" },
        [base64_decode] = { "base64decode" },
        [isrbxactive] = { "isgameactive", "iswindowactive" },
        [delfile] = { "deletefile" },
        [delfolder] = { "deletefolder" },
        [getthreadidentity] = { "getidentity", "getcontext", "getthreadcontext", "get_thread_context", "get_thread_identity" },
        [setthreadidentity] = { "setidentity", "setcontext", "setthreadcontext", "set_thread_context", "set_thread_identity" },
        [iswriteable] = { "iswritable" },
        [makewriteable] = { "makewritable" },
        [rconsoleshow] = { "rconsolecreate", "consolecreate" },
        [rconsolename] = { "consolesettitle" },
        [rconsoleinput] = { "consoleinput" },
        [logprint] = { "rconsoleprint", "consoleprint", "printuiconsole", "printdebug" },
        [logwarn] = { "rconsolewarn", "consolewarn", "warnuiconsole", "printuiwarn" },
        [logerror] = { "rconsoleerror", "consoleerror", "erroruiconsole", "printuierror", "rconsoleerr", "consoleerr" },
        [loginfo] = { "rconsoleinfo", "consoleinfo", "infouiconsole" }
    };

	for i, v in aliasData do
		for i2 = 1, #v do
			genv[v[i2]] = i;
		end
	end
end

--[[ UI Communication ]]--

genv.initLoaded = true;

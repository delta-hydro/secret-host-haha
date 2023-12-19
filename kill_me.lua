-- Plato configuration
local accountId = 2569; -- Plato account id [IMPORTANT]
local allowPassThrough = false; -- Allow user through if error occurs, may reduce security
local allowKeyRedeeming = true; -- Automatically check keys to redeem if valid
local useDataModel = false;

-- Plato callbacks
local onMessage = function(message)
    --logic
end;

-- Plato internals [START]
local fRequest, fStringFormat, fSpawn, fWait = request or http.request or http_request or syn.request, string.format, task.spawn, task.wait;
local localPlayerId = game:GetService("Players").LocalPlayer.UserId;
local rateLimit, rateLimitCountdown, errorWait = false, 0, false;
-- Plato internals [END]

-- Plato global functions [START]
function getLink()
    return fStringFormat("https://gateway.platoboost.com/a/%i?id=%i", accountId, localPlayerId);
end;

function verify(key)
    if errorWait or rateLimit then 
        return false;
    end;

    onMessage("Checking key...");

    if (useDataModel) then
        local status, result = pcall(function() 
            return game:HttpGetAsync(fStringFormat("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", accountId, localPlayerId, key));
        end);
        
        if status then
            if string.find(result, "true") then
                onMessage("Successfully whitelisted!");
                return true;
            elseif string.find(result, "false") then
                if allowKeyRedeeming then
                    local status1, result1 = pcall(function()
                        return game:HttpPostAsync(fStringFormat("https://api-gateway.platoboost.com/v1/authenticators/redeem/%i/%i/%s", accountId, localPlayerId, key), {});
                    end);

                    if status1 then
                        if string.find(result1, "true") then
                            onMessage("Successfully redeemed key!");
                            return true;
                        end;
                    end;
                end;
                
                onMessage("Key is invalid!");
                return false;
            else
                return false;
            end;
        else
            onMessage("An error occured while contacting the server!");
            return allowPassThrough;
        end;
    else
        local status, result = pcall(function() 
            return fRequest({
                Url = fStringFormat("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", accountId, localPlayerId, key),
                Method = "GET"
            });
        end);

        if status then
            if result.StatusCode == 200 then
                if string.find(result.Body, "true") then
                    onMessage("Successfully whitelisted key!");
                    return true;
                else
                    if (allowKeyRedeeming) then
                        local status1, result1 = pcall(function() 
                            return fRequest({
                                Url = fStringFormat("https://api-gateway.platoboost.com/v1/authenticators/redeem/%i/%i/%s", accountId, localPlayerId, key),
                                Method = "POST"
                            });
                        end);

                        if status1 then
                            if result1.StatusCode == 200 then
                                if string.find(result1.Body, "true") then
                                    onMessage("Successfully redeemed key!");
                                    return true;
                                end;
                            end;
                        end;
                    end;
                    
                    return false;
                end;
            elseif result.StatusCode == 204 then
                onMessage("Account wasn't found, check accountId");
                return false;
            elseif result.StatusCode == 429 then
                if not rateLimit then 
                    rateLimit = true;
                    rateLimitCountdown = 10;
                    fSpawn(function() 
                        while rateLimit do
                            onMessage(fStringFormat("You are being rate-limited, please slow down. Try again in %i second(s).", rateLimitCountdown));
                            fWait(1);
                            rateLimitCountdown = rateLimitCountdown - 1;
                            if rateLimitCountdown < 0 then
                                rateLimit = false;
                                rateLimitCountdown = 0;
                                onMessage("Rate limit is over, please try again.");
                            end;
                        end;
                    end); 
                end;
            else
                return allowPassThrough;
            end;    
        else
            return allowPassThrough;
        end;
    end;
end;
-- Plato global functions [END]

local cache = {
	modules = {
		home = {},
		monitors = {}
	},
	ui = {
		tabs = {
			executor = {},
			hide = {},
			home = {
				templates = {}
			},
			scripts = {
				templates = {}
			},
			settings = {}
		},
		popups = {}
	},
	startup = {}
};

do
	--[[ Connection ]]--

	local connection = {};
	connection.__index = connection;

	function connection.new(signal, fn)
		return setmetatable({
			_signal = signal,
			_fn = fn
		}, connection);
	end

	function connection:Disconnect()
		self._signal[self] = nil;
	end

	--[[ Signal ]]--

	local signal = {};
	signal.__index = signal;

	function signal.new()
		return setmetatable({}, signal);
	end

	function signal:Connect(fn: any)
		local conn = connection.new(self, fn);
		self[conn] = true;
		return conn;
	end

	function signal:Once(fn: any)
		local conn; conn = self:Connect(function(...)
			conn:Disconnect();
			fn(...);
		end);
		return conn;
	end

	function signal:Fire(...)
		for conn, _ in self do
			task.spawn(conn._fn, ...);
		end
	end

	function signal:Wait()
		local thread = coroutine.running();
		local conn; conn = self:Connect(function(...)
			conn:Disconnect();
			task.spawn(thread, ...);
		end);
		return coroutine.yield();
	end

	function signal:DisconnectAll()
		table.clear(self);
	end

	cache.modules.signal = signal;
end

do
	local tweenService = game:GetService("TweenService");

	local linkRegex = "^[%s]*loadstring%(game:HttpGet[Async]*%([\"'](.+)[\"'][%s*,%s*true]*%)%)%b();?[%s]*$";
	local fileRegex = "^.+/(.+)";

	local testStrings = {
		Standard = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua"))()]],
		OtherQuotationMark = [[loadstring(game:HttpGet('https://projectevo.xyz/loader.lua'))()]],
		GetAsync = [[loadstring(game:HttpGetAsync("https://projectevo.xyz/loader.lua"))()]],
		TrueNoSpace = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua",true))()]],
		TrueSpace = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua", true))()]],
		TrueWrongSpace = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua",true))()]],
		TrueTooMuchSpace = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua",  true))()]],
		SemiColon = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua"))();]],
		TrimStart = [[ loadstring(game:HttpGet("https://projectevo.xyz/loader.lua"))()]],
		TrimEnd = [[loadstring(game:HttpGet("https://projectevo.xyz/loader.lua"))() ]],
		TrimBoth = [[ loadstring(game:HttpGet("https://projectevo.xyz/loader.lua"))() ]]
	};

	--[[ Module ]]--

	local regex = {};

	function regex:Test()
		for i, v in testStrings do
			print(i, string.match(v, linkRegex));
		end
	end

	function regex:ExtractLink(content: string): string?
		return string.match(content, linkRegex);
	end

	function regex:ExtractFile(content: string): string?
		return string.match(content, fileRegex);
	end

	cache.modules.regex = regex;
end

do
	local tweenService = game:GetService("TweenService");

	local denominations = {"K", "M", "B", "T", "q", "Q", "s", "S", "O", "N", "d", "U", "D"};

	--[[ Module ]]--

	local utils = {};

	function utils:Create(className: string, properties: table?, children: table?)
		local x = Instance.new(className);
		for i, v in properties do
			if i ~= "Parent" then
				x[i] = v;
			end
		end
		if children then
			for i, v in children do
				v.Parent = x;
			end
		end
		if properties.Parent then
			x.Parent = properties.Parent;
		end
		return x;
	end

	function utils:Iconize(id: string)
		--[[if self:IsThirdParty() then
			return getcustomasset(string.format("internalicons/%s.png", id));
		end]]

		return "rbxassetid://" .. id;
	end

	function utils:Tween(inst: Instance, duration: number, properties: table, ...): Tween
		local tween = tweenService:Create(inst, TweenInfo.new(duration, ...), properties);
		task.spawn(tween.Play, tween);
		return tween;
	end

	function utils:DynamicParent(inst: Instance)
		inst.Parent = self:IsThirdParty() and gethui() or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
	end

	function utils:IsThirdParty(): boolean
		return identifyexecutor ~= nil;
	end

	function utils:RoundNumber(input: number, float: number): number
		local bracket = 1 / float;
		return math.round(input * bracket) / bracket;
	end

	function utils:FormatNumber(input: number, float: number): string
		if input < 1000 then
			return tostring(input);
		end
		local denominationIndex = math.floor(math.log10(input) / 3);
		local substring = tostring(self:RoundNumber(input / (10 ^ (denominationIndex * 3)), float));
		return substring .. tostring(denominations[denominationIndex]);
	end

	function utils:Request(url: string, method: string, headers: any?, body: any?): any
		local s, r = pcall(request, {
			Url = url,
			Method = method,
			Headers = headers,
			Body = body
		});
		if s == false or r.Success == false or r.StatusCode ~= 200 then
			return;
		end
		return r.Body;
	end

	function utils:DeepCopy(x: {any})
		local y = {};
		for i, v in x do
			y[i] = type(v) == "table" and self:DeepCopy(v) or v;
		end
		return y;
	end

	cache.modules.utils = utils;
end

do
	--[[ Variables ]]--

	local signal = cache.modules.signal;

	local signalCache = {};

	--[[ Module ]]--

	local settingsUpdates = {};

	function settingsUpdates:GetPropertyUpdatedSignal(path: string)
		if signalCache[path] == nil then
			signalCache[path] = signal.new();
		end
		return signalCache[path];
	end

	function settingsUpdates:Fire(path: string, value: any)
		local sig = signalCache[path];
		if sig then
			sig:Fire(value);
		end
	end
	
	cache.modules.settingsUpdates = settingsUpdates;
end

do
	--[[ Variables ]]--

	local httpService = game:GetService("HttpService");

	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local customSettings = {
		autoExecute = true,
		consoleLogs = false,
		isMenuExtended = false,
		saveData = {
			key = "",
			username = "",
			password = ""
		},
		monitors = { 
			fps = true,
			ping = true,
			signal = false,
			battery = false,
			playerCount = false
		},
		fps = {
			unlocked = false,
			vSync = false,
			cap = 60
		},
		spoofInfo = {
			enabled = false,
			name = "Psst. Don't tell anyone ;)",
			id = 156
		}
	};

	local isThirdParty = utils:IsThirdParty();
	
	local _writeuifile = isThirdParty and clonefunction(writeuifile);

	--[[ Functions ]]--

	local function recurSettings(base: {any}, json: {any})
		for i, v in json do
			if base[i] ~= nil and typeof(base[i]) == typeof(v) then
				if typeof(base[i]) == "table" then
					recurSettings(base[i], v);
				else
					base[i] = v;
				end
			end
		end
	end

	local function saveSettings()
		if isThirdParty then
			_writeuifile("settings.json", httpService:JSONEncode(utils:DeepCopy(customSettings)));
		end
	end

	local function createAutosaveMetatable(options: {any}, hierarchy: string)
		return setmetatable({}, {
			__index = function(_, k)
				return options[k];
			end,
			__newindex = function(_, k, v)
				options[k] = v;
				saveSettings();
				settingsUpdates:Fire(string.format("%s.%s", hierarchy, k), v);
			end,
			__iter = function()
				return next, options;
			end
		});
	end

	--[[ Setup ]]--

	if isThirdParty and isuifile("settings.json") then
		local succ, res = pcall(httpService.JSONDecode, httpService, readuifile("settings.json"));
		if succ then
			recurSettings(customSettings, res);
		else
			task.defer(error, "settings file is corrupted");
		end
	end

	for i, v in customSettings do
		if type(v) == "table" then
			customSettings[i] = createAutosaveMetatable(v, i);
		end
	end

	--[[ Module ]]--

	cache.modules.globals = {
		isMinimised = false,
		isPremium = false,
		defaultContent = "print('Hydrogen V2 Winning');",
		customSettings = setmetatable({}, {
			__index = function(_, k)
				return customSettings[k];
			end,
			__newindex = function(_, k, v)
				customSettings[k] = v;
				saveSettings();
				settingsUpdates:Fire(k, v);
			end
		})
	};
end

do
	local utils = cache.modules.utils;

	local monitorCache = {};
	local monitorHandlers = {};

	--[[ Functions ]]--

	function monitorHandlers.fps(frame: Frame, monitor: any, value: any)
		local percentage = math.clamp(value / monitor.max, 0, 1);
		frame.text.Text = math.round(value);
		utils:Tween(frame.icon.background.highlight.gradient, 0.25, {
			Offset = Vector2.new(percentage - 0.5, 0)
		});
		utils:Tween(frame.icon.needleContainer, 0.25, {
			Rotation = percentage * 90 - 45
		});
	end

	function monitorHandlers.ping(frame: Frame, monitor: any, value: any)
		local percentage = 1 - math.clamp(value / 1000, 0, 1);
		frame.text.Text = math.round(value);
		utils:Tween(frame.icon.background.highlight.gradient, 0.25, {
			Offset = Vector2.new(percentage - 0.5, 0)
		});
		utils:Tween(frame.icon.needleContainer, 0.25, {
			Rotation = percentage * 90 - 45
		});
	end

	function monitorHandlers.signal(frame: Frame, monitor: any, value: any)
		frame.text.Text = value;
		utils:Tween(frame.icon.gradient, 0.25, {
			Offset = Vector2.new(-0.75 + (math.floor((value - 5) * (1 / 25)) / (1 / 25)) / 100, 0)
		});
	end

	function monitorHandlers.battery(frame: Frame, monitor: any, value: any)
		frame.text.Text = value;
		utils:Tween(frame.icon.fill.gradient, 0.25, {
			Offset = Vector2.new(value / 100 - 0.5, 0)
		});
	end
	
	function monitorHandlers.playerCount(frame: Frame, monitor: any, value: any)
		frame.text.Text = value;
	end

	--[[ Module ]]--

	local monitors = {}

	function monitors:Start(monitorData: any)
		for i, v in monitorData do
			local monitor = cache.modules.monitors[i];
			monitorCache[i] = monitor;
			monitor.updated:Connect(function(...)
				monitorHandlers[i](v, monitorCache[i], ...);
			end);
			monitor:Start();
		end
	end

	cache.modules.home.monitors = monitors;
end

do
	local httpService = game:GetService("HttpService");

	local regex = cache.modules.regex;

	local isThirdParty = cache.modules.utils:IsThirdParty();

	local backupCache = {};
	
	local _isuifile = isThirdParty and clonefunction(isuifile);

	--[[ Functions ]]--

	local function validateLink(link: string): boolean
		if isThirdParty then
			return select(1, pcall(game.HttpGet, game, link));
		end
		return true;
	end

	--[[ Module ]]--

	local recent = {
		onNewLinkExecuted = cache.modules.signal.new()
	};

	function recent:GetCache(): any
		if self.cache == nil then
			local store, cache = backupCache, {};
			if isThirdParty then
				if _isuifile("cache.json") then
					local success, res = pcall(httpService.JSONDecode, httpService, readuifile("cache.json"));
					store = success and res or {};
					if success == false then
						task.defer(error, "recent script cache file is corrupted");
					end
				end
			end
			for i, v in store do
				local link = type(v) == "string" and regex:ExtractLink(v);
				if link and validateLink(link) then
					cache[#cache + 1] = {
						src = v,
						link = link,
						name = regex:ExtractFile(link)
					};
				end
			end
			self.cache = cache;
		end
		return self.cache;
	end

	function recent:Parse(content: string)
		local link = regex:ExtractLink(content);
		if link and validateLink(link) then
			local data = {
				src = content,
				link = link,
				name = regex:ExtractFile(link)
			};
			self.cache[#self.cache + 1] = data;
			self.onNewLinkExecuted:Fire(data);
		end
	end

	cache.modules.home.recent = recent;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local heartbeat = game:GetService("RunService").Heartbeat;

	local isThirdParty = utils:IsThirdParty();

	--[[ Module ]]--

	local batteryMonitor = {
		running = false,
		interval = 0.5,
		value = isThirdParty and getbatterypercentage() or 0,
		updated = cache.modules.signal.new()
	};

	function batteryMonitor:Start()
		if self.running == false then
			self.running = true;
			local init = 0;
			if isThirdParty then
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = getbatterypercentage();
							self.updated:Fire(self.value);
						end
					end
				end);
			else
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = self.value == 0 and 100 or self.value - 5;
							self.updated:Fire(self.value);
						end
					end
				end);
			end
		end
	end

	function batteryMonitor:Stop()
		if self.running == true then
			self.running = false;
			self.connection:Disconnect();
			self.connection = nil;
		end
	end

	function batteryMonitor:Validate()
		return globals.customSettings.monitors.battery and not globals.isMinimised;
	end

	cache.modules.monitors.battery = batteryMonitor;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local players = game:GetService("Players");

	local isThirdParty = utils:IsThirdParty();

	--[[ Module ]]--

	local playerMonitor = {
		running = false,
		interval = 0.5, -- doesn't matter for this one lol
		value = #players:GetPlayers(),
		updated = cache.modules.signal.new()
	};

	function playerMonitor:Start()
		if self.running == false then
			self.running = true;
			playerMonitor.updated:Fire(#players:GetPlayers());
			self.playerAdded = players.PlayerAdded:Connect(function()
				playerMonitor.updated:Fire(#players:GetPlayers());
			end);
			self.playerRemoving = players.PlayerRemoving:Connect(function()
				playerMonitor.updated:Fire(#players:GetPlayers());
			end);
		end
	end

	function playerMonitor:Stop()
		if self.running == true then
			self.running = false;
			self.playerAdded:Disconnect();
			self.playerAdded = nil;
			self.playerRemoving:Disconnect();
			self.playerRemoving = nil;
		end
	end

	function playerMonitor:Validate()
		return globals.customSettings.monitors.playerCount and not globals.isMinimised;
	end

	cache.modules.monitors.playerCount = playerMonitor;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local heartbeat = game:GetService("RunService").Heartbeat;
	local fps = game:GetService("Stats").Workspace.FPS;

	local isThirdParty = utils:IsThirdParty();

	--[[ Module ]]--

	local fpsMonitor = {
		running = false,
		interval = 0.5,
		value = isThirdParty and fps:GetValue() or 0,
		max = isThirdParty and getfpsmax() or 60,
		updated = cache.modules.signal.new()
	};

	function fpsMonitor:Start()
		if self.running == false then
			self.running = true;
			local init = 0;
			if isThirdParty then
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = fps:GetValue();
							self.updated:Fire(self.value);
						end
					end
				end);
			else
				self.connection = heartbeat:Connect(function(step)
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = 1 / step;
							self.updated:Fire(self.value);
						end
					end
				end);
			end
		end
	end

	function fpsMonitor:Stop()
		if self.running == true then
			self.running = false;
			self.connection:Disconnect();
			self.connection = nil;
		end
	end

	function fpsMonitor:Validate()
		return globals.customSettings.monitors.fps and not globals.isMinimised;
	end

	cache.modules.monitors.fps = fpsMonitor;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local localPlayer = game:GetService("Players").LocalPlayer;

	local heartbeat = game:GetService("RunService").Heartbeat;
	local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"];

	local isThirdParty = utils:IsThirdParty();
	local pinger = isThirdParty == false and script:WaitForChild("pinger");

	--[[ Module ]]--

	local pingMonitor = {
		running = false,
		interval = 0.5,
		value = isThirdParty and ping:GetValue() or 0,
		updated = cache.modules.signal.new()
	};

	function pingMonitor:Start()
		if self.running == false then
			self.running = true;
			local init = 0;
			if isThirdParty then
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = ping:GetValue();
							self.updated:Fire(self.value);
						end
					end
				end);
			else
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							task.spawn(function()
								self.value = (pinger:InvokeServer() - now) * 2000;
							end);
							self.updated:Fire(self.value);
						end
					end
				end);
			end
		end
	end

	function pingMonitor:Stop()
		if self.running == true then
			self.running = false;
			self.connection:Disconnect();
			self.connection = nil;
		end
	end

	function pingMonitor:Validate()
		return globals.customSettings.monitors.ping and not globals.isMinimised;
	end

	cache.modules.monitors.ping = pingMonitor;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local heartbeat = game:GetService("RunService").Heartbeat;

	local isThirdParty = utils:IsThirdParty();

	--[[ Module ]]--

	local signalMonitor = {
		running = false,
		interval = 0.5,
		value = isThirdParty and getsignalstrength() or 0,
		updated = cache.modules.signal.new()
	};

	function signalMonitor:Start()
		if self.running == false then
			self.running = true;
			local init = 0;
			if isThirdParty then
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = getsignalstrength();
							self.updated:Fire(self.value);
						end
					end
				end);
			else
				self.connection = heartbeat:Connect(function()
					if self:Validate() then
						local now = tick();
						if now - init >= self.interval then
							init = now;
							self.value = self.value == 100 and 0 or self.value + 5;
							self.updated:Fire(self.value);
						end
					end
				end);
			end
		end
	end

	function signalMonitor:Stop()
		if self.running == true then
			self.running = false;
			self.connection:Disconnect();
			self.connection = nil;
		end
	end

	function signalMonitor:Validate()
		return globals.customSettings.monitors.signal and not globals.isMinimised;
	end

	cache.modules.monitors.signal = signalMonitor;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local basis;

	--[[ Functions ]]--

	local function toggleIndicator(instance: Instance, value: boolean)
		utils:Tween(instance.toggle.indicator, 0.25, {
			Position = UDim2.new(0.5, value and 11 or -11, 0.5, 0)
		});
		utils:Tween(instance.toggle.indicator.gradient, 0.25, {
			Offset = Vector2.new(value and 0 or -1.25, 0)
		});
	end

	local function createBasis(directory: Instance)
		basis = utils:Create("Frame", { 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("1f2022"), 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = "monitorChoice", 
			Parent = directory,
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Size = UDim2.new(0, 420, 0, 212),
			Visible = false
		}, {
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 6), 
				Name = "corner"
			}),
			utils:Create("UIStroke", { 
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
				Color = Color3.fromHex("474d57"), 
				Name = "stroke"
			}),
			utils:Create("TextLabel", { 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size18, 
				Name = "title", 
				Position = UDim2.new(0, 16, 0, 12), 
				Size = UDim2.new(1, -32, 0, 18), 
				Text = "Monitors", 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 18, 
				TextTruncate = Enum.TextTruncate.AtEnd, 
				TextWrap = true, 
				TextWrapped = true, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("TextLabel", { 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "description", 
				Position = UDim2.new(0, 16, 0, 32), 
				Size = UDim2.new(1, -32, 0, 14), 
				Text = "Choose which monitors are displayed on the home page.", 
				TextColor3 = Color3.fromHex("adb0ba"), 
				TextSize = 14, 
				TextTruncate = Enum.TextTruncate.AtEnd, 
				TextWrap = true, 
				TextWrapped = true, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "container", 
				Position = UDim2.new(0.5, 0, 1, -8), 
				Size = UDim2.new(1, -16, 1, -60)
			}, {
				utils:Create("UIGridLayout", { 
					CellPadding = UDim2.new(0, 10, 0, 15), 
					CellSize = UDim2.new(0.5, -5, 0, 28), 
					Name = "grid", 
					SortOrder = Enum.SortOrder.LayoutOrder, 
					VerticalAlignment = Enum.VerticalAlignment.Center
				}),
				utils:Create("TextButton", { 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "fps", 
					Size = UDim2.new(1, -4, 0, 50), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("2b2c2f"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "toggle", 
						Position = UDim2.new(1, -16, 0.5, 0), 
						Size = UDim2.new(0, 50, 0, 28)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "indicator", 
							Position = UDim2.new(0.5, globals.customSettings.monitors.fps and 11 or -11, 0.5, 0), 
							Size = UDim2.new(0, 22, 0, 22)
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(globals.customSettings.monitors.fps and 0 or -1.25, 0),
								Rotation = 30
							})
						})
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "title", 
						Position = UDim2.new(0, 12, 0.5, 0), 
						Size = UDim2.new(1, -24, 1, 0), 
						Text = "FPS", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("TextButton", { 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "ping", 
					Size = UDim2.new(1, -4, 0, 50), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("2b2c2f"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "toggle", 
						Position = UDim2.new(1, -16, 0.5, 0), 
						Size = UDim2.new(0, 50, 0, 28)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "indicator", 
							Position = UDim2.new(0.5, globals.customSettings.monitors.ping and 11 or -11, 0.5, 0), 
							Size = UDim2.new(0, 22, 0, 22)
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(globals.customSettings.monitors.ping and 0 or -1.25),
								Rotation = 30
							})
						})
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "title", 
						Position = UDim2.new(0, 12, 0.5, 0), 
						Size = UDim2.new(1, -24, 1, 0), 
						Text = "Ping", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("TextButton", { 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "signal", 
					Size = UDim2.new(1, -4, 0, 50), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("2b2c2f"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "toggle", 
						Position = UDim2.new(1, -16, 0.5, 0), 
						Size = UDim2.new(0, 50, 0, 28)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "indicator", 
							Position = UDim2.new(0.5, globals.customSettings.monitors.signal and 11 or -11, 0.5, 0), 
							Size = UDim2.new(0, 22, 0, 22)
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(globals.customSettings.monitors.signal and 0 or -1.25, 0), 
								Rotation = 30
							})
						})
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "title", 
						Position = UDim2.new(0, 12, 0.5, 0), 
						Size = UDim2.new(1, -24, 1, 0), 
						Text = "WiFi Signal", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("TextButton", { 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "battery", 
					Size = UDim2.new(1, -4, 0, 50), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("2b2c2f"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "toggle", 
						Position = UDim2.new(1, -16, 0.5, 0), 
						Size = UDim2.new(0, 50, 0, 28)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "indicator", 
							Position = UDim2.new(0.5, globals.customSettings.monitors.battery and 11 or -11, 0.5, 0), 
							Size = UDim2.new(0, 22, 0, 22)
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(globals.customSettings.monitors.battery and 0 or -1.25, 0), 
								Rotation = 30
							})
						})
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "title", 
						Position = UDim2.new(0, 12, 0.5, 0), 
						Size = UDim2.new(1, -24, 1, 0), 
						Text = "Battery Life", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("TextButton", { 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "playerCount", 
					Size = UDim2.new(1, -4, 0, 50), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("2b2c2f"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "toggle", 
						Position = UDim2.new(1, -16, 0.5, 0), 
						Size = UDim2.new(0, 50, 0, 28)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "indicator", 
							Position = UDim2.new(0.5, globals.customSettings.monitors.playerCount and 11 or -11, 0.5, 0), 
							Size = UDim2.new(0, 22, 0, 22)
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(globals.customSettings.monitors.playerCount and 0 or -1.25, 0), 
								Rotation = 30
							})
						})
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "title", 
						Position = UDim2.new(0, 12, 0.5, 0), 
						Size = UDim2.new(1, -24, 1, 0), 
						Text = "Player Count", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				})
			}),
			utils:Create("ImageButton", { 
				AnchorPoint = Vector2.new(1, 0), 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Image = "rbxassetid://14544922843", 
				Name = "close", 
				Position = UDim2.new(1, -10, 0, 10), 
				Size = UDim2.new(0, 24, 0, 24)
			})
		});
		
		for i, v in basis.container:GetChildren() do
			if v:IsA("TextButton") then
				settingsUpdates:GetPropertyUpdatedSignal("monitors." .. v.Name):Connect(function(value)
					toggleIndicator(v, value);
				end);
				
				v.MouseButton1Click:Connect(function()
					globals.customSettings.monitors[v.Name] = not globals.customSettings.monitors[v.Name];
				end);
			end
		end
		
		basis.close.MouseButton1Click:Connect(function()
			basis.Visible = false
		end);
		
		return basis;
	end

	--[[ Module ]]--

	local init = {};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end
		
		return createBasis(directory);
	end

	function init:IsInitialized()
		return basis ~= nil;
	end

	cache.ui.popups.monitors = init;
end

do
	--[[ Variables ]]--

	local basis;

	--[[ Functions ]]--

	local function createBasis(directory: Instance)
		basis = cache.modules.utils:Create("ScreenGui", { 
			DisplayOrder = 999999, 
			IgnoreGuiInset = true, 
			Name = "popups", 
			Parent = directory, 
			ResetOnSpawn = false, 
			ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
		});
	end

	--[[ Module ]]--

	local init = {
		instances = {};	
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end

		createBasis(directory);
		self:LoadPopups();
	end

	function init:IsInitialized(): boolean
		return basis ~= nil;
	end

	function init:LoadPopups()
		for i, v in { "monitors" } do
			self.instances[v] = cache.ui.popups[v]:Initialize(basis);
		end
	end

	cache.ui.popups.init = init;
end

do
	--[[ Variables ]]--

	local userInputService = game:GetService("UserInputService");

	local currentCamera = workspace.CurrentCamera;

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local menus;
	local tabs;
	local dragBar;

	local background;
	local dragBarInternal;

	local selectedTab;
	local selectedButton;

	--[[ Functions ]]--

	local function deselectTab()
		if selectedTab then
			utils:Tween(selectedButton.title, 0.25, { TextColor3 = Color3.fromHex("adb0ba") });
			utils:Tween(selectedButton.icon.gradient, 0.25, { Offset = Vector2.new(1.5, 0) });
			selectedTab.Visible = false;
		end
	end

	local function selectTab(button: TextButton)
		if selectedButton ~= button then
			if selectedTab then
				deselectTab();
			end
			selectedButton, selectedTab = button, tabs[button.Name];
			utils:Tween(selectedButton.title, 0.25, { TextColor3 = Color3.fromHex("ffffff") });
			utils:Tween(selectedButton.icon.gradient, 0.25, { Offset = Vector2.new() });
			selectedTab.Visible = true;
		end
	end

	local function triggerMenuUpdate(offset: number)
		utils:Tween(background, 0.25, { BackgroundTransparency = 0.7 + offset * 0.3 });
		utils:Tween(dragBarInternal, 0.25, { BackgroundTransparency = 0.25 + (1 - offset) * 0.75 });
		return utils:Tween(menus, 0.25, { Position = UDim2.new(1, (globals.customSettings.isMenuExtended and 170 or 80) * offset, 0.5, 0) });
	end

	local function triggerMenuSwitch(open: boolean)
		globals.isMinimised = not open;
		if open then
			triggerMenuUpdate(0).Completed:Connect(function()
				selectedTab.Visible = true;
			end);
		else
			selectedTab.Visible = false;
			triggerMenuUpdate(1);
		end
	end

	--[[ Module ]]--

	local menu = {};

	function menu:AddMenuOption(title: string, id: string, override: boolean)
		if not menus then
			menus = cache.basis.gui.menu;
			tabs = cache.basis.gui.tabs;
		end

		local option = utils:Create("TextButton", { 
			AutoButtonColor = false, 
			BackgroundColor3 = Color3.fromHex("ffff00"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			ClipsDescendants = true, 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = string.lower(title), 
			Parent = menus.container, 
			Size = UDim2.new(1, -32, 0, 48), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14
		}, {
			utils:Create("UICorner", { 
				Name = "corner"
			}),
			utils:Create("ImageLabel", { 
				AnchorPoint = Vector2.new(0, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Image = utils:Iconize(id), 
				Name = "icon", 
				Position = UDim2.new(0, 8, 0.5, 0), 
				Size = UDim2.new(0, 32, 0, 32)
			}, {
				utils:Create("UIGradient", { 
					Color = ColorSequence.new({ 
						ColorSequenceKeypoint.new(0, Color3.fromHex("474d57")), 
						ColorSequenceKeypoint.new(0.05, Color3.fromHex("4aa8fd")), 
						ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
					}), 
					Name = "gradient", 
					Offset = Vector2.new(1.5, 0), 
					Rotation = 30
				})
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size18, 
				Name = "title", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -52, 1, 0), 
				Text = title, 
				TextColor3 = Color3.fromHex("adb0ba"), 
				TextSize = 16, 
				TextXAlignment = Enum.TextXAlignment.Left
			})
		});

		if not override then
			option.MouseButton1Click:Connect(function()
				selectTab(option);
			end);
		end
		
		return option;
	end

	function menu:AddPlaceholder()
		utils:Create("Frame", { 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = "placeholder", 
			Parent = menus.container, 
			Size = UDim2.new(0, 48, 0, 24)
		});
	end

	function menu:SetupDragBar()
		if not background then
			background = cache.basis.gui.background;
			dragBar = cache.basis.gui.menu.dragBar;
			dragBarInternal = cache.basis.gui.menu.dragBar.internal;
		end

		local isDragging = false;
		local startX, passX;

		dragBar.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and globals.isMinimised then
				isDragging = true;
				startX = input.Position.X;
				passX = startX - 40;
				local conn; conn = input.Changed:Connect(function(prop)
					if prop == "UserInputState" and input.UserInputState == Enum.UserInputState.End then
						conn:Disconnect();
						triggerMenuSwitch(input.Position.X <= passX);
						isDragging = false;
					end
				end);
			end
		end);

		userInputService.TouchMoved:Connect(function(input)
			if isDragging then
				triggerMenuUpdate(math.clamp((input.Position.X - passX) / 40, 0, 1));
			end
		end);
	end

	function menu:ForceSelect(title: string)
		selectTab(menus.container[title]);
	end

	cache.ui.menu = menu;
end

do
	--[[ Variables ]]--

	local menu = cache.ui.menu;

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local basis;

	--[[ Functions ]]--

	local function createBasis(directory: Instance)
		basis = utils:Create("ScreenGui", {
			DisplayOrder = 999999,
			IgnoreGuiInset = true, 
			Name = "gui",
			Parent = directory,
			ResetOnSpawn = false,
			ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, 
			ZIndexBehavior = Enum.ZIndexBehavior.Global
		}, {
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("000000"), 
				BackgroundTransparency = 0.7, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "background", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(1, 0, 1, 0)
			}),
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "menu", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(0, globals.customSettings.isMenuExtended and 170 or 80, 1, 0)
			}, {
				utils:Create("ImageLabel", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = utils:Iconize("14086106160"), 
					Name = "icon", 
					Position = UDim2.new(0.5, 0, 0, 26), 
					Size = UDim2.new(0, 48, 0, 48)
				}),
				utils:Create("ScrollingFrame", { 
					Active = true, 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					BottomImage = utils:Iconize("14086218904"), 
					CanvasSize = UDim2.new(0, 0, 0, 0), 
					MidImage = utils:Iconize("14086220094"), 
					Name = "container", 
					Position = UDim2.new(0.5, 0, 1, 0), 
					ScrollBarImageColor3 = Color3.fromHex("101216"), 
					ScrollBarThickness = 4, 
					ScrollingDirection = Enum.ScrollingDirection.Y,
					Size = UDim2.new(1, 0, 1, -96), 
					TopImage = utils:Iconize("14086221127")
				}, {
					utils:Create("UIListLayout", { 
						HorizontalAlignment = Enum.HorizontalAlignment.Center, 
						Name = "list", 
						Padding = UDim.new(0, 8), 
						SortOrder = Enum.SortOrder.LayoutOrder, 
						VerticalAlignment = Enum.VerticalAlignment.Top
					})
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "dragBar", 
					Position = UDim2.new(0, -12, 0.5, 0), 
					Size = UDim2.new(0, 28, 0.4, 0)
				}, {
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("5f6067"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "internal", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -20, 1, -20)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						})
					})
				})
			}),
			utils:Create("Folder", {
				Name = "tabs"
			})
		});
		
		settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
			if not globals.isMinimised then
				utils:Tween(basis.menu, 0.25, {
					Size = UDim2.new(0, value and 170 or 80, 1, 0)
				});
			end
		end);
		
		do
			local container = basis.menu.container;

			container.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				container.CanvasSize = UDim2.new(0, 0, 0, container.list.AbsoluteContentSize.Y + 12);
			end);
		end

		return basis;
	end

	--[[ Module ]]--

	local init = {
		instances = {};	
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end

		createBasis(directory);
		cache.ui.popups.init:Initialize(directory);
	end

	function init:IsInitialized(): boolean
		return basis ~= nil;
	end

	function init:AddTabs()
		local tabs = { "home", "executor", "scripts", "settings", "hide" };
		for i, v in tabs do
			local tab = cache.ui.tabs[v].init;
			if tab.separate then
				menu:AddPlaceholder();
			end
			tab:Initialize(menu:AddMenuOption(tab.title, tab.id, tab.override));
		end
		menu:SetupDragBar();
		menu:ForceSelect(tabs[1]);
	end

	cache.ui.init = init;
end

do
	--[[ Variables ]]--

	local mainInit = cache.ui.init;
	local menu = cache.ui.menu;

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	local basis;

	local assets = {
		fonts = {
			Consolas = { "Regular", "Bold" },
			Montserrat = { "Regular",  "SemiBold" }
		},
		images = {}
	};
	local assetCount = 0;
	local totalAssets;

	local isThirdParty = utils:IsThirdParty();
	globals.customAssetPath = isThirdParty and string.match(writecustomasset("x.txt", ""), "rbxasset://(%w+)") or "";

	--[[ Functions ]]--

	local function getTotalAssets()
		local count = 0;
		for i, v in assets do
			for _, v2 in v do
				count += type(v2) == "table" and #v2 or 1;
				if i == "fonts" then
					count += 1; -- to account for the json files
				end
			end
		end
		return count;
	end

	local function createBasis(directory: Instance)
		totalAssets = getTotalAssets();
		
		basis = utils:Create("ScreenGui", { 
			DisplayOrder = 999998, 
			IgnoreGuiInset = true, 
			Name = "startup", 
			Parent = directory,
			ResetOnSpawn = false, 
			ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
		}, {
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "main", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(0, 420, 0, 247)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "bootstrapper", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0)
				}, {
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "progress", 
						Position = UDim2.new(0.5, 0, 0, 178), 
						Size = UDim2.new(1, -52, 0, 22), 
						Text = string.format("0/%d | Downloading Assets...", totalAssets), 
						TextColor3 = Color3.fromHex("adb0ba"), 
						TextSize = 19
					}),
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size24, 
						Name = "title", 
						Position = UDim2.new(0.5, 0, 0, 100), 
						Size = UDim2.new(1, -52, 0, 22), 
						Text = isThirdParty and table.concat({ identifyexecutor() }, " ") or "Hydrogen Android V2.0.0", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 24
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "bar", 
						Position = UDim2.new(0.5, 0, 0, 142), 
						Size = UDim2.new(0, 300, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 6), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(-1, 0)
						})
					})
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "login", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0), 
					Visible = false
				}, {
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 0), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "keyBtn", 
						Position = UDim2.new(0.5, -20, 0, 100), 
						Size = UDim2.new(0, 90, 0, 32), 
						Text = "Key", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 18
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						})
					}),
					utils:Create("TextButton", { 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "adlessBtn", 
						Position = UDim2.new(0.5, 20, 0, 100), 
						Size = UDim2.new(0, 90, 0, 32), 
						Text = "Adless", 
						TextColor3 = Color3.fromHex("adb0ba"), 
						TextSize = 18
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						})
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 1), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "key", 
						Position = UDim2.new(0.5, 0, 1, 0), 
						Size = UDim2.new(1, 0, 0, 97)
					}, {
						utils:Create("TextBox", { 
							AnchorPoint = Vector2.new(0.5, 0), 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "input", 
							PlaceholderColor3 = Color3.fromHex("adb0ba"), 
							PlaceholderText = "Input Key...", 
							Position = UDim2.new(0.5, 0, 0, 0), 
							Size = UDim2.new(1, -46, 0, 32), 
							Text = "", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14, 
							TextXAlignment = Enum.TextXAlignment.Left
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 6), 
								Name = "corner"
							}),
							utils:Create("UIPadding", { 
								Name = "padding", 
								PaddingLeft = UDim.new(0, 12), 
								PaddingRight = UDim.new(0, 6)
							})
						}),
						utils:Create("TextButton", { 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "getKeyBtn", 
							Position = UDim2.new(0, 23, 0, 42), 
							Size = UDim2.new(0, 90, 0, 32), 
							Text = "Get Key", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							})
						}),
						utils:Create("TextButton", { 
							AnchorPoint = Vector2.new(1, 0), 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "continueBtn", 
							Position = UDim2.new(1, -23, 0, 42), 
							Size = UDim2.new(0, 90, 0, 32), 
							Text = "Continue", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							})
						})
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 1), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "adless", 
						Position = UDim2.new(0.5, 0, 1, 0), 
						Size = UDim2.new(1, 0, 0, 97), 
						Visible = false
					}, {
						utils:Create("TextBox", { 
							AnchorPoint = Vector2.new(0.5, 0), 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "username", 
							PlaceholderColor3 = Color3.fromHex("adb0ba"), 
							PlaceholderText = "Username...", 
							Position = UDim2.new(0.5, 0, 0, 0), 
							Size = UDim2.new(1, -46, 0, 32), 
							Text = "", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14, 
							TextXAlignment = Enum.TextXAlignment.Left
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 6), 
								Name = "corner"
							}),
							utils:Create("UIPadding", { 
								Name = "padding", 
								PaddingLeft = UDim.new(0, 12), 
								PaddingRight = UDim.new(0, 6)
							})
						}),
						utils:Create("TextButton", { 
							AnchorPoint = Vector2.new(1, 0), 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "loginBtn", 
							Position = UDim2.new(1, -23, 0, 42), 
							Size = UDim2.new(0, 90, 0, 32), 
							Text = "Login", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							})
						}),
						utils:Create("TextBox", { 
							BackgroundColor3 = Color3.fromHex("32363d"), 
							BackgroundTransparency = 0.35, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "password", 
							PlaceholderColor3 = Color3.fromHex("adb0ba"), 
							PlaceholderText = "Password...", 
							Position = UDim2.new(0, 23, 0, 42), 
							Size = UDim2.new(1, -146, 0, 32), 
							Text = "", 
							TextColor3 = Color3.fromHex("ffffff"), 
							TextSize = 14, 
							TextXAlignment = Enum.TextXAlignment.Left
						}, {
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 6), 
								Name = "corner"
							}),
							utils:Create("UIPadding", { 
								Name = "padding", 
								PaddingLeft = UDim.new(0, 12), 
								PaddingRight = UDim.new(0, 6)
							}),
							utils:Create("TextBox", { 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderColor3 = Color3.fromHex("000000"), 
								BorderSizePixel = 0, 
								CursorPosition = -1, 
								FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size14, 
								Name = "content", 
								Position = UDim2.new(0, -12, 0, 0), 
								Size = UDim2.new(1, 18, 1, 0), 
								Text = "", 
								TextColor3 = Color3.fromHex("000000"), 
								TextSize = 14, 
								TextTransparency = 1
							})
						})
					})
				}),
				utils:Create("ImageLabel", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = "rbxassetid://14086106160", 
					Name = "icon", 
					Position = UDim2.new(0.5, 0, 0, 26), 
					Size = UDim2.new(0, 48, 0, 48)
				})
			})
		});
	end

	local function successfulLogin(directory: Instance)
		basis:Destroy();
		if isThirdParty then
			for i, v in { "IjHyfuyuHeg", "cHjGyjKbe", "cHpRmejNAJ", "isuifile", "readuifile", "writeuifile", "iscustomasset", "writecustomasset" } do
				getgenv()[v] = nil;
			end
			if globals.customSettings.autoExecute then
				runautoexec();
			end
		end
		mainInit:Initialize(directory);
		mainInit:AddTabs();
	end

	local function selectTab(btn: Button, frame: Frame)
		for i, v in basis.main.login:GetChildren() do
			if v:IsA("Frame") then
				v.Visible = v == frame;
			elseif v:IsA("TextButton") then
				utils:Tween(v, 0.25, {
					TextColor3 = Color3.fromHex(v == btn and "ffffff" or "adb0ba"),
					BackgroundTransparency = v == btn and 0.35 or 1
				});
			end
		end
	end

	local function loadLoginPage()
		local directory = basis.Parent;
		local login = basis.main.login;

		local map = {
			[login.adlessBtn] = login.adless,
			[login.keyBtn] = login.key
		};

		for i, v in map do
			i.MouseButton1Click:Connect(function()
				selectTab(i, v);
			end);
		end
		
		login.key.getKeyBtn.MouseButton1Click:Connect(function()
			--setclipboard(IjHyfuyuHeg());
			setclipboard(getLink()); --Plato replacement
		end);
		
		login.key.continueBtn.MouseButton1Click:Connect(function()
			--if cHjGyjKbe(login.key.input.Text) then
			if verify(login.key.input.Text) then --Plato replacement
				globals.customSettings.saveData.key = login.key.input.Text;
				successfulLogin(directory);
			end
		end);
		
		login.adless.password.content:GetPropertyChangedSignal("Text"):Connect(function()
			login.adless.password.Text = string.rep("•", #login.adless.password.content.Text);
		end);
		
		login.adless.loginBtn.MouseButton1Click:Connect(function()
			if cHpRmejNAJ(login.adless.username.Text, login.adless.password.content.Text) then
				globals.customSettings.saveData.username = login.adless.username.Text;
				globals.customSettings.saveData.password = login.adless.password.content.Text;
				globals.isPremium = true;
				successfulLogin(directory);
			end
		end);

		basis.main.bootstrapper.Visible = false;
		login.Visible = true;
	end

	local function updateCount()
		assetCount += 1;
		basis.main.bootstrapper.progress.Text = string.format("%d/%d | Downloading Assets...", assetCount, totalAssets);
		utils:Tween(basis.main.bootstrapper.bar.gradient, 0.25, {
			Offset = Vector2.new(assetCount / totalAssets * 1.1 - 1, 0);
		});
	end

	local function setupBootstrapper()
		if isThirdParty then
			for i, v in assets.fonts do
				local hasDownloadedSomething = false;
				for _, v2 in v do
					local fileName = string.format("Custom Fonts/%s/%s-%s.ttf", i, i, v2);
					if iscustomasset(fileName) == false then
						writecustomasset(fileName, game:HttpGet(string.format("https://raw.githubusercontent.com/VersatileTeam/hydrogen-assets/main/fonts/%s/%s-%s.ttf", i, i, v2), true));
						hasDownloadedSomething = true;
					end
					updateCount();
				end
				if hasDownloadedSomething then
					local fontData = game:HttpGet(string.format("https://raw.githubusercontent.com/VersatileTeam/hydrogen-assets/main/fonts/%s/%s.json", i, i), true);
					writecustomasset(string.format("Custom Fonts/%s/%s.json", i, i), string.gsub(fontData, "Custom Fonts", globals.customAssetPath .. "/Custom Fonts"));
				end
				updateCount();
			end
			
			for i, v in basis.main.login:GetDescendants() do
				if pcall(function() return v.Font; end) then
					v.FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), v.FontFace.Weight, v.FontFace.Style);
				end
			end
		end

		local saveData = globals.customSettings.saveData;
		--if saveData.key ~= "" and cHjGyjKbe(saveData.key) then
		if saveData.key ~= "" and verify(saveData.key) then --Plato replacement
			successfulLogin(basis.Parent);
		elseif saveData.username ~= "" and saveData.password ~= "" and cHpRmejNAJ(saveData.username, saveData.password) then
			globals.isPremium = true;
			successfulLogin(basis.Parent);
		else
			loadLoginPage();
		end
	end

	--[[ Module ]]--

	local init = {};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end

		createBasis(directory);
		setupBootstrapper();
		return basis;
	end

	function init:IsInitialized(): boolean
		return basis ~= nil;
	end

	cache.startup.init = init;
end

do
	--[[ Variables ]]--

	local httpService = game:GetService("HttpService");

	local utils = cache.modules.utils;
	local isThirdParty = utils:IsThirdParty();

	local backupCache = {
		{
			title = "Script 1",
			content = "print('Hydrogen V2 Winning');"
		}
	};

	local tab;
	
	local _isuifile = isThirdParty and clonefunction(isuifile);

	--[[ Module ]]--

	local tabSystem = {
		cache = backupCache,
		accumulator = 1,
		selected = nil,
		connection = nil
	};

	function tabSystem:Initialize(basis: Frame)
		tab = basis;
		if isThirdParty then
			if _isuifile("tabs.json") then
				local success, res = pcall(httpService.JSONDecode, httpService, readuifile("tabs.json"));
				self.cache = success and res or backupCache;
				if success == false then
					task.defer(error, "tab cache file is corrupted");
				end
			end
		end
		
		basis.content.input:GetPropertyChangedSignal("Text"):Connect(function()
			local index, selection = self:Get(self.selected);
			if index then
				selection.content = basis.content.input.Text;
			end
		end);

		for i, v in self.cache do
			self:Add(v.title, v.content, true);
		end
		self:Select(self.cache[1].title);
	end

	function tabSystem:Get(title: string)
		for i, v in self.cache do
			if v.title == title then
				return i, v;
			end
		end
	end

	function tabSystem:Select(title: string)
		if self.selected == title then
			return;
		end
		local index, selection = self:Get(title);
		if index ~= nil then
			self.selected = title;
			tab.content.input.Text = selection.content;
		end
	end

	function tabSystem:Add(title: string, content: string, isCached: boolean?)
		if self:Get(title) and not isCached then
			return;
		end
		self.accumulator += 1;

		local header = utils:Create("TextButton", { 
			BackgroundColor3 = Color3.fromHex("32363d"), 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = title,  
			Parent = tab.tabs,
			Size = UDim2.new(0, game:GetService("TextService"):GetTextBoundsAsync(utils:Create("GetTextBoundsParams", {
				Font = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				Size = 14,
				Text = title,
				Width = math.huge
			})).X + 45, 1, 0), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14
		}, {
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			utils:Create("UIStroke", { 
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
				Color = Color3.fromHex("474d57"), 
				Name = "stroke"
			}),
			utils:Create("ImageButton", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Image = "rbxassetid://14544922843", 
				Name = "close", 
				Position = UDim2.new(1, -5, 0.5, 0), 
				Size = UDim2.new(0, 20, 0, 20)
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "title", 
				Position = UDim2.new(0, 10, 0.5, 0), 
				Size = UDim2.new(1, -45, 1, 0), 
				Text = title, 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 14, 
				TextXAlignment = Enum.TextXAlignment.Left
			})
		});
		
		header.MouseButton1Click:Connect(function()
			self:Select(title);
		end);
		
		header.close.MouseButton1Click:Connect(function()
			self:Remove(title);
		end);
		
		if isCached then
			select(2, self:Get(title)).header = header;
		else
			table.insert(self.cache, {
				title = title,
				content = content,
				header = header
			});
		end
		return header;
	end

	function tabSystem:Remove(title: string)
		if self:Get(title) == nil or #self.cache == 1 then
			return;
		end
		local index, selection = self:Get(title);
		if index ~= nil then
			selection.header:Destroy();
			table.remove(self.cache, index);
			if self.selected == title then
				self:Select(self.cache[1].title);
			end
		end
	end

	cache.ui.tabs.executor.tabSystem = tabSystem;
end

do
	--[[ Variables ]]--

	local tabSystem = cache.ui.tabs.executor.tabSystem;

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local recent = cache.modules.home.recent;

	--[[ Module ]]--

	local init = {
		title = "Executor",
		id = "14009418338"	
	};

	function init:Initialize()
		self.tab = utils:Create("Frame", { 
			AnchorPoint = Vector2.new(0, 0.5), 
			BackgroundColor3 = Color3.fromHex("1f2022"), 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = string.lower(self.title), 
			Parent = cache.basis.gui.tabs, 
			Position = UDim2.new(0, 15, 0.5, 0), 
			Size = UDim2.new(1, globals.customSettings.isMenuExtended and -200 or -110, 1, -30),
			Visible = false
		}, {
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 6), 
				Name = "corner"
			}),
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "buttons", 
				Position = UDim2.new(0.5, 0, 1, -9), 
				Size = UDim2.new(1, -18, 0, 30)
			}, {
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "leftAlign", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0)
				}, {
					utils:Create("UIListLayout", { 
						FillDirection = Enum.FillDirection.Horizontal, 
						Name = "list", 
						Padding = UDim.new(0, 10), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "execute", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 71, 1, 0), 
						Text = "Execute", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "clear", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 52, 1, 0), 
						Text = "Clear", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "copy", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 50, 1, 0), 
						Text = "Copy", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					})
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "rightAlign", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0)
				}, {
					utils:Create("UIListLayout", { 
						FillDirection = Enum.FillDirection.Horizontal, 
						HorizontalAlignment = Enum.HorizontalAlignment.Right, 
						Name = "list", 
						Padding = UDim.new(0, 10), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "execute", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 135, 1, 0), 
						Text = "Execute Clipboard", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "load", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 114, 1, 0), 
						Text = "Load Clipboard", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					})
				})
			}),
			utils:Create("ScrollingFrame", { 
				Active = true, 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				BottomImage = "rbxassetid://14086218904", 
				CanvasSize = UDim2.new(0, 0, 0, 0), 
				HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar, 
				MidImage = "rbxassetid://14086220094", 
				Name = "tabs", 
				Position = UDim2.new(0, 9, 0, 9), 
				ScrollBarImageColor3 = Color3.fromHex("101216"), 
				ScrollBarThickness = 4, 
				ScrollingDirection = Enum.ScrollingDirection.X, 
				Size = UDim2.new(1, -56, 0, 32), 
				TopImage = "rbxassetid://14086221127"
			}, {
				utils:Create("UIListLayout", { 
					FillDirection = Enum.FillDirection.Horizontal, 
					Name = "list", 
					Padding = UDim.new(0, 8), 
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				utils:Create("UIPadding", { 
					Name = "padding", 
					PaddingBottom = UDim.new(0, 1), 
					PaddingLeft = UDim.new(0, 1), 
					PaddingRight = UDim.new(0, 1), 
					PaddingTop = UDim.new(0, 1)
				})
			}),
			utils:Create("ScrollingFrame", { 
				Active = true, 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				BottomImage = "rbxassetid://14086218904", 
				CanvasSize = UDim2.new(0, 0, 0, 12), 
				HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar, 
				MidImage = "rbxassetid://14086220094", 
				Name = "content", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				ScrollBarImageColor3 = Color3.fromHex("101216"), 
				ScrollBarThickness = 4, 
				Size = UDim2.new(1, -18, 1, -98), 
				TopImage = "rbxassetid://14086221127", 
				VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			}, {
				utils:Create("TextBox", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					ClearTextOnFocus = false, 
					CursorPosition = -1, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Consolas/Consolas.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size12, 
					Name = "input", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0), 
					Text = "print(\"Hydrogen V2 Winning\");", 
					TextColor3 = Color3.fromHex("e1e1e1"), 
					TextSize = 12, 
					TextXAlignment = Enum.TextXAlignment.Left, 
					TextYAlignment = Enum.TextYAlignment.Top
				}),
				utils:Create("UIStroke", { 
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
					Color = Color3.fromHex("474d57"), 
					Name = "stroke"
				}),
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				utils:Create("UIPadding", { 
					Name = "padding", 
					PaddingBottom = UDim.new(0, 8), 
					PaddingLeft = UDim.new(0, 8), 
					PaddingRight = UDim.new(0, 8), 
					PaddingTop = UDim.new(0, 8)
				})
			}),
			utils:Create("ImageButton", { 
				AnchorPoint = Vector2.new(1, 0), 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Image = "rbxassetid://14544873276", 
				Name = "newTab", 
				Position = UDim2.new(1, -9, 0, 9), 
				Size = UDim2.new(0, 30, 0, 30)
			}, {
				utils:Create("UIGradient", { 
					Color = ColorSequence.new({ 
						ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
						ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
					}), 
					Name = "gradient", 
					Rotation = 30
				})
			})
		});
		
		settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
			utils:Tween(self.tab, 0.25, {
				Size = UDim2.new(1, value and -200 or -110, 1, -30)
			});
		end);

		tabSystem:Initialize(self.tab);

		local function execute(content: string)
			(runcode or function() end)(content);
			recent:Parse(content);
		end
		
		self.tab.newTab.MouseButton1Click:Connect(function()
			tabSystem:Add("Script " .. tostring(tabSystem.accumulator), globals.defaultContent);
		end);
		
		self.tab.buttons.leftAlign.execute.MouseButton1Click:Connect(function()
			execute(self.tab.content.input.Text);
		end);

		self.tab.buttons.leftAlign.clear.MouseButton1Click:Connect(function()
			self.tab.content.input.Text = "";
		end);

		self.tab.buttons.leftAlign.copy.MouseButton1Click:Connect(function()
			setclipboard(self.tab.content.input.Text);
		end);

		self.tab.buttons.rightAlign.execute.MouseButton1Click:Connect(function()
			execute(getclipboard());
		end);

		self.tab.buttons.rightAlign.load.MouseButton1Click:Connect(function()
			self.tab.content.input.Text = getclipboard();
		end);
	end

	cache.ui.tabs.executor.init = init;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local utils = cache.modules.utils;

	--[[ Module ]]--

	local init = {
		title = "Hide",
		id = "14033140039",
		separate = true,
		override = true
	};

	function init:Initialize(btn: TextButton)
		btn.MouseButton1Click:Connect(function()
			globals.isMinimised = true;
			for i, v in cache.basis.gui.tabs:GetChildren() do
				if v:IsA("Frame") and v.Visible then
					v.Visible = false;
				end
			end
			utils:Tween(cache.basis.gui.background, 0.4, { BackgroundTransparency = 1 });
			utils:Tween(cache.basis.gui.menu.dragBar.internal, 0.4, { BackgroundTransparency = 0.25 });
			utils:Tween(cache.basis.gui.menu, 0.4, { Position = UDim2.new(1, globals.customSettings.isMenuExtended and 170 or 80, 0.5, 0) });
		end);
	end

	cache.ui.tabs.hide.init = init;
end

do
	--[[ Variables ]]--

	local regex = cache.modules.regex;
	local utils = cache.modules.utils;

	--[[ Template ]]--

	cache.ui.tabs.home.templates.recentLink = function(link: string, name: string): Instance
		return utils:Create("TextButton", { 
			BackgroundColor3 = Color3.fromHex("32363d"), 
			BackgroundTransparency = 0.35, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = link, 
			Size = UDim2.new(1, -4, 0, 48), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14
		}, {
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 6), 
				Name = "corner"
			}),
			utils:Create("UIStroke", { 
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
				Color = Color3.fromHex("474d57"), 
				Name = "stroke"
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "full", 
				Position = UDim2.new(0, 12, 1, -8), 
				Size = UDim2.new(1, -24, 0, 16), 
				Text = link, 
				TextColor3 = Color3.fromHex("adb0ba"), 
				TextSize = 14, 
				TextTruncate = Enum.TextTruncate.AtEnd, 
				TextWrap = true, 
				TextWrapped = true, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("TextLabel", { 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size18, 
				Name = "title", 
				Position = UDim2.new(0, 12, 0, 8), 
				Size = UDim2.new(1, -24, 0, 16), 
				Text = name, 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 15, 
				TextWrap = true, 
				TextWrapped = true, 
				TextXAlignment = Enum.TextXAlignment.Left
			})
		});
	end
end

do
	--[[ Variables ]]--

	local isThirdParty = cache.modules.utils:IsThirdParty();

	--[[ Module ]]--

	local premium = {};

	function premium:Initialize(frame: Frame)
		self.frame = frame;
		frame.container.purchase.MouseButton1Click:Connect(function()
			if isThirdParty then
				setclipboard("https://hydrogen.sh/adless");
			end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Hydrogen V2",
				Text = "Premium link set to clipboard",
				Duration = 5
			});
		end);
	end

	function premium:ToggleVisual(enabled: boolean)
		if self.frame == nil then
			return;
		end
		self.frame.container.Visible = not enabled;
		self.frame.alreadyPremium.Visible = enabled;
	end

	cache.ui.tabs.home.premium = premium;
end

do
	--[[ Variables ]]--

	local localPlayer = game:GetService("Players").LocalPlayer;

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local monitors = cache.modules.home.monitors;
	local recent = cache.modules.home.recent;

	local premium = cache.ui.tabs.home.premium;
	local recentLinkTemplate = cache.ui.tabs.home.templates.recentLink;

	local tabMap = {
		stats = {
			value = 50,
			reverse = "recent"
		},
		premium = {
			value = 130,
			reverse = "welcome"
		}
	};

	local spoofInfo = globals.customSettings.spoofInfo;

	--[[ Functions ]]--

	local function createTab()
		local frame = utils:Create("Frame", { 
			AnchorPoint = Vector2.new(0, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = "home", 
			Parent = cache.basis.gui.tabs, 
			Position = UDim2.new(0, 15, 0.5, 0), 
			Size = UDim2.new(1, globals.customSettings.isMenuExtended and -200 or -110, 1, -30),
			Visible = false
		}, {
			utils:Create("UIGridLayout", { 
				CellPadding = UDim2.new(0, 10, 0, 10), 
				CellSize = UDim2.new(0.5, -5, 0, 10), 
				Name = "grid", 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			utils:Create("Frame", { 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "welcome", 
				Size = UDim2.new(0, 100, 0, 100)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UISizeConstraint", { 
					MinSize = Vector2.new(0, 0), 
					Name = "constraint"
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -76, 0, 30), 
					Text = string.format("Welcome, %s!", spoofInfo.enabled and spoofInfo.name or localPlayer.Name),
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 16, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "id", 
					Position = UDim2.new(0, 12, 0, 32), 
					Size = UDim2.new(1, -24, 0, 16), 
					Text = tostring(spoofInfo.enabled and spoofInfo.id or localPlayer.UserId), 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("ImageLabel", { 
					AnchorPoint = Vector2.new(1, 0), 
					BackgroundColor3 = Color3.fromHex("32363d"), 
					BackgroundTransparency = 0.35, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = string.format("rbxthumb://type=AvatarHeadShot&amp;id=%d&amp;w=48&amp;h=48", spoofInfo.enabled and spoofInfo.id or localPlayer.UserId), 
					Name = "icon", 
					Position = UDim2.new(1, -12, 0, 12), 
					Size = UDim2.new(0, 48, 0, 48)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("UIStroke", { 
						Color = Color3.fromHex("474d57"), 
						Name = "stroke"
					})
				})
			}),
			utils:Create("Frame", { 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "stats", 
				Size = UDim2.new(0, 100, 0, 100)
			}, {
				utils:Create("UISizeConstraint", { 
					MinSize = Vector2.new(0, 0), 
					Name = "constraint"
				}),
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UIListLayout", { 
					FillDirection = Enum.FillDirection.Horizontal, 
					HorizontalAlignment = Enum.HorizontalAlignment.Center, 
					Name = "list", 
					Padding = UDim.new(0, 0), 
					SortOrder = Enum.SortOrder.LayoutOrder, 
					VerticalAlignment = Enum.VerticalAlignment.Center
				}),
				utils:Create("Frame", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "fps", 
					Size = UDim2.new(0, 60, 0, 48),
					Visible = globals.customSettings.monitors.fps
				}, {
					utils:Create("TextLabel", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "text", 
						Size = UDim2.new(1, 0, 1, 0), 
						Text = "0", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = utils:Iconize("14146393062"), 
						ImageColor3 = Color3.fromHex("1f2022"), 
						Name = "icon", 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 28, 0, 28), 
						ZIndex = 2
					}, {
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("474d57"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "background", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 1, 0)
						}, {
							utils:Create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderColor3 = Color3.fromHex("000000"), 
								BorderSizePixel = 0, 
								Image = utils:Iconize("14100873244"), 
								Name = "highlight", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, 0, 1, 0)
							}, {
								utils:Create("UIGradient", { 
									Name = "gradient", 
									Offset = Vector2.new(-0.5, 0), 
									Transparency = NumberSequence.new({ 
										NumberSequenceKeypoint.new(0, 0), 
										NumberSequenceKeypoint.new(0.5, 0), 
										NumberSequenceKeypoint.new(0.501, 1), 
										NumberSequenceKeypoint.new(1, 1)
									})
								})
							})
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "needleContainer", 
							Position = UDim2.new(0.5, 0, 0, 23), 
							Rotation = -45, 
							Size = UDim2.new(1, -4, 1, -4)
						}, {
							utils:Create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderColor3 = Color3.fromHex("000000"), 
								BorderSizePixel = 0, 
								Image = utils:Iconize("14088844339"), 
								Name = "needle", 
								Position = UDim2.new(0.5, 0, 0.5, -7), 
								Size = UDim2.new(1, 0, 1, 0), 
								ZIndex = 2
							})
						})
					})
				}),
				utils:Create("Frame", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "ping", 
					Size = UDim2.new(0, 60, 0, 48),
					Visible = globals.customSettings.monitors.ping
				}, {
					utils:Create("TextLabel", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "text", 
						Size = UDim2.new(1, 0, 1, 0), 
						Text = "0", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = utils:Iconize("14146567970"), 
						ImageColor3 = Color3.fromHex("1f2022"), 
						Name = "icon", 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 28, 0, 28), 
						ZIndex = 2
					}, {
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("474d57"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "background", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 1, 0)
						}, {
							utils:Create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderColor3 = Color3.fromHex("000000"), 
								BorderSizePixel = 0, 
								Image = utils:Iconize("14146512973"), 
								Name = "highlight", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, 0, 1, 0)
							}, {
								utils:Create("UIGradient", { 
									Name = "gradient", 
									Offset = Vector2.new(-0.5, 0), 
									Transparency = NumberSequence.new({ 
										NumberSequenceKeypoint.new(0, 0), 
										NumberSequenceKeypoint.new(0.5, 0), 
										NumberSequenceKeypoint.new(0.501, 1), 
										NumberSequenceKeypoint.new(1, 1)
									})
								})
							})
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "needleContainer", 
							Position = UDim2.new(0.5, 0, 0, 23), 
							Rotation = -45, 
							Size = UDim2.new(1, -4, 1, -4)
						}, {
							utils:Create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderColor3 = Color3.fromHex("000000"), 
								BorderSizePixel = 0, 
								Image = utils:Iconize("14088844339"), 
								Name = "needle", 
								Position = UDim2.new(0.5, 0, 0.5, -7), 
								Size = UDim2.new(1, 0, 1, 0), 
								ZIndex = 2
							})
						})
					})
				}),
				utils:Create("Frame", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "signal", 
					Size = UDim2.new(0, 58, 0, 48),
					Visible = globals.customSettings.monitors.signal
				}, {
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = utils:Iconize("14087596935"), 
						Name = "icon", 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 28, 0, 28)
					}, {
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.98, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(-1, 0)
						})
					}),
					utils:Create("TextLabel", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "text", 
						Size = UDim2.new(1, 0, 1, 0), 
						Text = "0%", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("Frame", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "battery", 
					Size = UDim2.new(0, 58, 0, 48),
					Visible = globals.customSettings.monitors.battery
				}, {
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = utils:Iconize("14098342733"), 
						Name = "icon", 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 28, 0, 28)
					}, {
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
							}), 
							Name = "gradient"
						}),
						utils:Create("Frame", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderColor3 = Color3.fromHex("000000"), 
							BorderSizePixel = 0, 
							Name = "fill", 
							Position = UDim2.new(0, 4, 0.5, 0), 
							Size = UDim2.new(0, 18, 0, 8)
						}, {
							utils:Create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
									ColorSequenceKeypoint.new(0.5, Color3.fromHex("97b9d8")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
								}), 
								Name = "gradient", 
								Offset = Vector2.new(-0.5, 0), 
								Transparency = NumberSequence.new({ 
									NumberSequenceKeypoint.new(0, 0), 
									NumberSequenceKeypoint.new(0.5, 0), 
									NumberSequenceKeypoint.new(0.501, 1), 
									NumberSequenceKeypoint.new(1, 1)
								})
							}),
							utils:Create("UICorner", { 
								CornerRadius = UDim.new(0, 2), 
								Name = "corner"
							})
						})
					}),
					utils:Create("TextLabel", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "text", 
						Size = UDim2.new(1, 0, 1, 0), 
						Text = "0%", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				utils:Create("Frame", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "playerCount", 
					Size = UDim2.new(0, 54, 0, 48),
					Visible = globals.customSettings.monitors.playerCount
				}, {
					utils:Create("TextLabel", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size18, 
						Name = "text", 
						Size = UDim2.new(1, 0, 1, 0), 
						Text = #game:GetService("Players"):GetPlayers(), 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 15, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = "rbxassetid://14660449618", 
						Name = "icon", 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 28, 0, 28), 
						ZIndex = 2
					}, {
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
							}), 
							Name = "gradient"
						})
					})
				})
			}),
			utils:Create("Frame", { 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "recent", 
				Size = UDim2.new(0, 100, 0, 100)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UISizeConstraint", { 
					MinSize = Vector2.new(0, 0), 
					Name = "constraint"
				}),
				utils:Create("ScrollingFrame", { 
					Active = true, 
					AnchorPoint = Vector2.new(1, 1), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					BottomImage = utils:Iconize("14086218904"), 
					CanvasSize = UDim2.new(0, 0, 0, 0), 
					MidImage = utils:Iconize("14086220094"), 
					Name = "container", 
					Position = UDim2.new(1, -4, 1, -8), 
					ScrollBarImageColor3 = Color3.fromHex("101216"), 
					ScrollBarThickness = 4, 
					Size = UDim2.new(1, -12, 1, -52), 
					TopImage = utils:Iconize("14086221127"), 
					VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
				}, {
					utils:Create("UIListLayout", { 
						Name = "list", 
						Padding = UDim.new(0, 8), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					utils:Create("UIPadding", { 
						Name = "padding", 
						PaddingBottom = UDim.new(0, 1), 
						PaddingLeft = UDim.new(0, 1), 
						PaddingRight = UDim.new(0, 1), 
						PaddingTop = UDim.new(0, 1)
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 50, 0, 8), 
					Size = UDim2.new(1, -58, 0, 28), 
					Text = "Recent Links", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 16, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("ImageLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = "rbxassetid://14216122819", 
					Name = "icon", 
					Position = UDim2.new(0, 14, 0, 8), 
					Size = UDim2.new(0, 28, 0, 28)
				}, {
					utils:Create("UIGradient", { 
						Color = ColorSequence.new({ 
							ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
							ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
						}), 
						Name = "gradient"
					})
				})
			}),
			utils:Create("Frame", { 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "premium", 
				Size = UDim2.new(0, 100, 0, 100)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UISizeConstraint", { 
					MinSize = Vector2.new(0, 0), 
					Name = "constraint"
				}),
				utils:Create("TextLabel", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "alreadyPremium", 
					Position = UDim2.new(0.5, 0, 1, -16), 
					Size = UDim2.new(1, -32, 1, -40), 
					Text = "You're already Premium!", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextWrap = true, 
					TextWrapped = true, 
					Visible = globals.isPremium or false
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "container", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0),
					Visible = not (globals.isPremium or false)
				}, {
					utils:Create("TextLabel", { 
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "note", 
						Position = UDim2.new(0.5, 0, 0, 40), 
						Size = UDim2.new(1, -32, 1, -48), 
						Text = "Fed up of going through our key system every day? Click here!", 
						TextColor3 = Color3.fromHex("adb0ba"), 
						TextSize = 14, 
						TextTruncate = Enum.TextTruncate.AtEnd, 
						TextWrap = true, 
						TextWrapped = true, 
						TextXAlignment = Enum.TextXAlignment.Left, 
						TextYAlignment = Enum.TextYAlignment.Top
					}),
					utils:Create("TextButton", { 
						AnchorPoint = Vector2.new(1, 1), 
						BackgroundColor3 = Color3.fromHex("32363d"), 
						BackgroundTransparency = 0.35, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "purchase", 
						Position = UDim2.new(1, -9, 1, -9), 
						Size = UDim2.new(0, 103, 0, 28), 
						Text = "Buy Premium", 
						TextColor3 = Color3.fromHex("ffffff"), 
						TextSize = 14
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						utils:Create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("474d57"), 
							Name = "stroke"
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 50, 0, 8), 
					Size = UDim2.new(1, -58, 0, 28), 
					Text = "Premium", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 16, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("ImageLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = "rbxassetid://14216160359", 
					Name = "icon", 
					Position = UDim2.new(0, 14, 0, 8), 
					Size = UDim2.new(0, 28, 0, 28)
				}, {
					utils:Create("UIGradient", { 
						Color = ColorSequence.new({ 
							ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
							ColorSequenceKeypoint.new(1, Color3.fromHex("97b9d8"))
						}), 
						Name = "gradient"
					})
				})
			})
		});
		
		settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
			utils:Tween(frame, 0.25, {
				Size = UDim2.new(1, value and -200 or -110, 1, -30)
			});
		end);

		settingsUpdates:GetPropertyUpdatedSignal("spoofInfo.enabled"):Connect(function(value)
			frame.welcome.title.Text = string.format("Welcome, %s!", value and spoofInfo.name or localPlayer.Name);
			frame.welcome.id.Text = tostring(value and spoofInfo.id or localPlayer.UserId);
			frame.welcome.icon.Image = string.format("rbxthumb://type=AvatarHeadShot&amp;id=%d&amp;w=48&amp;h=48", value and spoofInfo.id or localPlayer.UserId);
		end);
		
		settingsUpdates:GetPropertyUpdatedSignal("spoofInfo.name"):Connect(function()
			if spoofInfo.enabled then
				frame.welcome.title.Text = string.format("Welcome, %s!", spoofInfo.name);
			end
		end);
		
		settingsUpdates:GetPropertyUpdatedSignal("spoofInfo.id"):Connect(function()
			if spoofInfo.enabled then
				frame.welcome.id.Text = tostring(spoofInfo.id);
				frame.welcome.icon.Image = string.format("rbxthumb://type=AvatarHeadShot&amp;id=%d&amp;w=48&amp;h=48", spoofInfo.id);
			end
		end);
		
		for i, v in frame.stats:GetChildren() do
			if v:IsA("Frame") then
				settingsUpdates:GetPropertyUpdatedSignal("monitors." .. v.Name):Connect(function(value)
					v.Visible = value;
				end);
			end
		end
		
		return frame;
	end

	local function calculateAbsoluteSize(inputValue, interval, absoluteSize)
		local value = inputValue < 0 and absoluteSize + inputValue or inputValue;
		local result = -10;
		repeat
			result += interval + 10;
		until result >= value;
		return result;
	end

	--[[ Module ]]--

	local init = {
		title = "Home",
		id = "14009418896"	
	};

	function init:Initialize()
		self.tab = createTab();

		self:ResizeGrid();
		self.tab.grid:GetPropertyChangedSignal("AbsoluteCellSize"):Connect(function()
			self:ResizeGrid();
		end);
		
		self.tab.stats.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			self:ResizeGrid();
		end);

		self.tab.recent.container.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			self.tab.recent.container.CanvasSize = UDim2.new(0, 0, 0, self.tab.recent.container.list.AbsoluteContentSize.Y + 2);
		end);

		monitors:Start({
			fps = self.tab.stats.fps,
			ping = self.tab.stats.ping,
			signal = self.tab.stats.signal,
			battery = self.tab.stats.battery
		});
		
		premium:Initialize(self.tab.premium);

		for i, v in recent:GetCache() do
			self:AddLink(v);
		end

		recent.onNewLinkExecuted:Connect(function(data)
			self:AddLink(data);
		end);
	end

	function init:ResizeGrid()
		local absoluteSize = self.tab.AbsoluteSize;
		local absoluteCellSize = self.tab.grid.AbsoluteCellSize;

		for i, v in tabMap do
			local size = calculateAbsoluteSize(v.value, absoluteCellSize.Y, absoluteSize.Y);
			self.tab[i].constraint.MinSize = Vector2.new(absoluteCellSize.X, size);
			self.tab[v.reverse].constraint.MinSize = Vector2.new(absoluteCellSize.X, absoluteSize.Y - (size + 10));
		end

		local statsFrame = self.tab.stats;
		local count, total = 1, 0;
		for i, v in statsFrame:GetChildren() do
			if v:IsA("Frame") and v.Visible then
				count += 1;
				total += v.AbsoluteSize.X;
			end
		end
		statsFrame.list.Padding = UDim.new(0, math.max(12, math.floor((statsFrame.AbsoluteSize.X - total) / count)));
	end

	function init:AddLink(data: string)
		local btn = recentLinkTemplate(data.link, data.name);
		
		btn.MouseButton1Click:Connect(function()
			(runcode or function() end)(data.src);
		end);

		btn.Parent = self.tab.recent.container;
	end

	cache.ui.tabs.home.init = init;
end

do
	--[[ Variables ]]--

	local httpService = game:GetService("HttpService");

	local utils = cache.modules.utils;
	
	local count = 0;
	local placeIdCache = {};
	
	local _writecustomasset = utils:IsThirdParty() and clonefunction(writecustomasset);

	--[[ Template ]]--

	cache.ui.tabs.scripts.templates.scriptResult = function(scriptResult: {any}): Instance
		local y = count;
		count = count + 1;

		local x = utils:Create("Frame", { 
			BackgroundColor3 = Color3.fromHex("1f2022"), 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = scriptResult.title, 
			Size = UDim2.new(0, 100, 0, 100)
		}, {
			utils:Create("UIAspectRatioConstraint", { 
				AspectRatio = 1.7, 
				AspectType = Enum.AspectType.ScaleWithParentSize, 
				Name = "aspectRatio"
			}),
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 6), 
				Name = "corner"
			}),
			utils:Create("ImageLabel", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Image = "rbxassetid://14578693435", 
				ImageColor3 = Color3.fromHex("515151"), 
				ImageTransparency = 0.5, 
				Name = "background", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(1, 0, 1, 0)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				})
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "game", 
				Position = UDim2.new(0.5, 0, 0, 26), 
				Size = UDim2.new(1, -24, 0, 16), 
				Text = scriptResult.game.name, 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 14, 
				TextTruncate = Enum.TextTruncate.AtEnd, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size18, 
				Name = "title", 
				Position = UDim2.new(0.5, 0, 0, 10), 
				Size = UDim2.new(1, -24, 0, 16), 
				Text = scriptResult.title, 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 16, 
				TextTruncate = Enum.TextTruncate.AtEnd, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "time", 
				Position = UDim2.new(0.5, 0, 1, -10), 
				Size = UDim2.new(1, -24, 0, 14), 
				Text = DateTime.fromIsoDate(scriptResult.updatedAt):FormatLocalTime("ll", "en-us"),
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 14, 
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			utils:Create("TextButton", { 
				AnchorPoint = Vector2.new(1, 1), 
				BackgroundColor3 = Color3.fromHex("32363d"), 
				BackgroundTransparency = 0.35, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "execute", 
				Position = UDim2.new(1, -9, 1, -9), 
				Size = UDim2.new(0, 71, 0, 28), 
				Text = "Execute", 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				utils:Create("UIStroke", { 
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
					Color = Color3.fromHex("474d57"), 
					Name = "stroke"
				})
			}),
			utils:Create("TextLabel", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "views", 
				Position = UDim2.new(0.5, 0, 1, -24), 
				Size = UDim2.new(1, -24, 0, 14), 
				Text = utils:FormatNumber(scriptResult.views, 0.1), 
				TextColor3 = Color3.fromHex("ffffff"), 
				TextSize = 14, 
				TextXAlignment = Enum.TextXAlignment.Left
			})
		});

		task.spawn(function()
			local imageData = scriptResult.game.imageUrl;
			local ext = "jpg";
			if string.sub(scriptResult.game.imageUrl, 1, 4) == "http" then
				local data = utils:Request(scriptResult.game.imageUrl, "GET");
				if data then
					imageData = data;
					local lastSection = select(-1, string.split(scriptResult.game.imageUrl, "/"));
					ext = lastSection == "Jpeg" and "jpg" or string.match(lastSection, "^[^/%.]+%.(%w+)$") or "jpg";
				elseif scriptResult.game.name ~= "Universal Script 📌" then
					local gameId = scriptResult.game.gameId;
					if placeIdCache[gameId] == nil then
						local res = utils:Request(string.format("https://thumbnails.roblox.com/v1/places/gameicons?placeIds=%d&amp;returnPolicy=PlaceHolder&amp;size=256x256&amp;format=Png&amp;isCircular=false", gameId), "GET");
						if res then
							placeIdCache[gameId] = _writecustomasset(string.format("Search Images/%d.png", gameId), utils:Request(httpService:JSONDecode(res).data[1].imageUrl, "GET"));
						end
					end
					x.background.Image = placeIdCache[gameId];
					return;
				else
					return;
				end
			end
			x.background.Image = _writecustomasset(string.format("Search Images/%s.%s", y, ext), imageData);
		end);
		
		return x;
	end
end

do
	--[[ Variables ]]--

	local httpService = game:GetService("HttpService");

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local template = cache.ui.tabs.scripts.templates.scriptResult;
	local webpConversionCache = {};

	--[[ Module ]]--

	local init = {
		title = "Scripts",
		id = "14009418740",
		searching = false,
		randomFolderName = randomstring and randomstring(16) or "thisWillNeverBeUsed"
	};

	function init:Initialize()
		self.tab = utils:Create("Frame", { 
			AnchorPoint = Vector2.new(0, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = "scripts", 
			Parent = cache.basis.gui.tabs, 
			Position = UDim2.new(0, 15, 0.5, 0), 
			Size = UDim2.new(1, globals.customSettings.isMenuExtended and -200 or -110, 1, -30),
			Visible = false
		}, {
			utils:Create("TextBox", { 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "input", 
				PlaceholderColor3 = Color3.fromHex("707070"), 
				PlaceholderText = "Search...", 
				Size = UDim2.new(1, -46, 0, 36), 
				Text = "", 
				TextColor3 = Color3.fromHex("adb0ba"), 
				TextSize = 14, 
				TextXAlignment = Enum.TextXAlignment.Left
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UIPadding", { 
					Name = "padding", 
					PaddingLeft = UDim.new(0, 12), 
					PaddingRight = UDim.new(0, 6)
				}),
				utils:Create("TextButton", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "search", 
					Position = UDim2.new(1, 0, 0.5, 0), 
					Size = UDim2.new(0, 28, 0, 28), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					utils:Create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Image = "rbxassetid://14556026415", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(0, 24, 0, 24)
					}),
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 6), 
						Name = "corner"
					})
				})
			}),
			utils:Create("TextButton", { 
				AnchorPoint = Vector2.new(1, 0), 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "filter", 
				Position = UDim2.new(1, 0, 0, 0), 
				Size = UDim2.new(0, 36, 0, 36), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("ImageLabel", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = "rbxassetid://14555967527", 
					Name = "icon", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(0, 24, 0, 24)
				}),
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				})
			}),
			utils:Create("ScrollingFrame", { 
				Active = true, 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				CanvasSize = UDim2.new(0, 0, 0, 0),
				BottomImage = "rbxassetid://14086218904", 
				MidImage = "rbxassetid://14086220094", 
				Name = "container", 
				Position = UDim2.new(0.5, 0, 1, 0), 
				ScrollBarImageColor3 = Color3.fromHex("1f2022"), 
				ScrollBarThickness = 4, 
				ScrollingDirection = Enum.ScrollingDirection.Y, 
				Size = UDim2.new(1, 0, 1, -46), 
				TopImage = "rbxassetid://14086221127", 
				VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			}, {
				utils:Create("UIGridLayout", { 
					CellPadding = UDim2.new(0, 12, 0, 12), 
					CellSize = UDim2.new(0.333, -8, 0, 0), 
					FillDirectionMaxCells = 3, 
					Name = "grid", 
					SortOrder = Enum.SortOrder.LayoutOrder
				})
			})
		});
		
		settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
			utils:Tween(self.tab, 0.25, {
				Size = UDim2.new(1, value and -200 or -110, 1, -30)
			});
		end);
			
		self.tab.filter.MouseButton1Click:Connect(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Hydrogen V2",
				Text = "Search filters coming soon!",
				Duration = 5
			});
		end);
		
		self.tab.input.search.MouseButton1Click:Connect(function()
			self:Search(string.gsub(self.tab.input.Text, " ", "+"));
		end);

		self.tab.container.grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			self.tab.container.CanvasSize = UDim2.new(0, 0, 0, self.tab.container.grid.AbsoluteContentSize.Y);
		end);
	end

	function init:Search(query: string)
		if self.searching then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Hydrogen V2",
				Text = "Already searching...",
				Duration = 5
			});
			return;
		end
		self.searching = true;
		self:ClearResults();
		local res = utils:Request(string.format("https://scriptblox.com/api/script/search?q=%s&amp;max=20&amp;mode=free", query), "GET");
		if res then
			local validResults, webps, webpMap = {}, {}, {};
			for i, v in httpService:JSONDecode(res).result.scripts do
				if v.isPatched == false then
					if string.sub(v.game.imageUrl, 1, 1) == "/" then
						v.game.imageUrl = "https://scriptblox.com" .. v.game.imageUrl;
					end
					local lastSection = select(-1, unpack(string.split(v.game.imageUrl, "/")));
					local ext = lastSection == "Jpeg" and "jpg" or string.match(lastSection, "^[^/%.]+%.(%w+)$") or "jpg";
					local index = #validResults + 1;
					if ext == "webp" then
						if webpConversionCache[v.game.imageUrl] then
							v.game.imageUrl = webpConversionCache[v.game.imageUrl];
						else
							webps[#webps + 1] = v.game.imageUrl;
							webpMap[#webps] = index;
						end
					end
					validResults[index] = v;
				end
			end
			if #webps > 0 then
				local res = utils:Request("https://projectevo.xyz/api/v1/utils/webptopng", "POST", { ["Content-Type"] = "application/json" }, httpService:JSONEncode(webps));
				if res then
					local x = httpService:JSONDecode(res);
					if x.images then
						for i, v in x.images do
							if v ~= nil then
								local jpg = base64decode(v);
								webpConversionCache[validResults[webpMap[i]].game.imageUrl] = jpg;
								validResults[webpMap[i]].game.imageUrl = jpg;
							else
								print("failed image:", validResults[webpMap[i]].game.imageUrl);
							end
						end
					end
				end
			end
			for i, v in validResults do
				self:AddResult(v);
			end
		end
		self.searching = false;
	end

	function init:AddResult(scriptResult: any)
		local result = template(scriptResult);
		result.execute.MouseButton1Click:Connect(function()
			runcode(scriptResult.script);
		end);
		result.Parent = self.tab.container;
	end

	function init:ClearResults()
		for i, v in self.tab.container:GetChildren() do
			if v:IsA("Frame") then
				v:Destroy();
			end
		end
	end

	cache.ui.tabs.scripts.init = init;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local basis;

	--[[ Functions ]]--

	local function toggleIndicator(instance: Instance, value: boolean)
		utils:Tween(instance.toggle.indicator, 0.25, {
			Position = UDim2.new(0.5, value and 11 or -11, 0.5, 0)
		});
		utils:Tween(instance.toggle.indicator.gradient, 0.25, {
			Offset = Vector2.new(value and 0 or -1.25, 0)
		});
	end

	local function createBasis(directory: Instance)
		basis = utils:Create("ScrollingFrame", { 
			Active = true, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			BottomImage = "rbxassetid://14086218904", 
			CanvasSize = UDim2.new(0, 0, 0, 32), 
			MidImage = "rbxassetid://14086220094", 
			Name = "exploit", 
			Parent = directory,
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScrollBarImageColor3 = Color3.fromHex("101216"), 
			ScrollBarThickness = 4, 
			ScrollingDirection = Enum.ScrollingDirection.Y, 
			Size = UDim2.new(1, 0, 1, 0), 
			TopImage = "rbxassetid://14086221127", 
			Visible = false
		}, {
			utils:Create("UIListLayout", { 
				Name = "list", 
				Padding = UDim.new(0, 8), 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "autoExecute", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.autoExecute and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.autoExecute and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					RichText = true, 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Executes scripts in your `autoexec` folder when you join a game.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Auto Execute", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "consoleLogs", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.consoleLogs and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.consoleLogs and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Logs all exploit-related outputs to a `console.log` file.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Console Logs", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			})
		});
		
		do
			settingsUpdates:GetPropertyUpdatedSignal("autoExecute"):Connect(function(value)
				toggleIndicator(basis.autoExecute, value);
			end);

			basis.autoExecute.MouseButton1Click:Connect(function()
				globals.customSettings.autoExecute = not globals.customSettings.autoExecute;
			end);
		end
		
		do
			settingsUpdates:GetPropertyUpdatedSignal("consoleLogs"):Connect(function(value)
				toggleIndicator(basis.consoleLogs, value);
			end);

			basis.consoleLogs.MouseButton1Click:Connect(function()
				globals.customSettings.consoleLogs = not globals.customSettings.consoleLogs;
			end);
		end
	end

	--[[ Module ]]--

	local init = {
		title = "Exploit"
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end
		
		createBasis(directory);
	end

	function init:IsInitialized()
		return basis ~= nil;
	end

	cache.ui.tabs.settings.exploit = init;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local basis;
	local isThirdParty = utils:IsThirdParty();

	--[[ Functions ]]--

	local function toggleIndicator(instance: Instance, value: boolean)
		utils:Tween(instance.toggle.indicator, 0.25, {
			Position = UDim2.new(0.5, value and 11 or -11, 0.5, 0)
		});
		utils:Tween(instance.toggle.indicator.gradient, 0.25, {
			Offset = Vector2.new(value and 0 or -1.25, 0)
		});
	end

	local function createBasis(directory: Instance)
		basis = utils:Create("ScrollingFrame", { 
			Active = true, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			BottomImage = "rbxassetid://14086218904", 
			CanvasSize = UDim2.new(0, 0, 0, 32), 
			MidImage = "rbxassetid://14086220094", 
			Name = "game", 
			Parent = directory,
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScrollBarImageColor3 = Color3.fromHex("101216"), 
			ScrollBarThickness = 4, 
			ScrollingDirection = Enum.ScrollingDirection.Y, 
			Size = UDim2.new(1, 0, 1, 0), 
			TopImage = "rbxassetid://14086221127", 
			Visible = false
		}, {
			utils:Create("UIListLayout", { 
				Name = "list", 
				Padding = UDim.new(0, 8), 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "unlockFps", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.fps.unlocked and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.fps.unlocked and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Allows your FPS to exceed Roblox's base cap of 60.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Unlock FPS", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "vSync", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.fps.vSync and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.fps.vSync and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Sets your FPS cap equal to your monitor's refresh rate.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "V-Sync", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "fpsCap", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Decides what your FPS cap is when \"Unlock FPS\" is enabled.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "FPS Cap", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextBox", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "input", 
					PlaceholderColor3 = Color3.fromHex("707070"), 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28), 
					Text = tostring(globals.customSettings.fps.cap), 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				})
			})
		});
		
		do
			settingsUpdates:GetPropertyUpdatedSignal("fps.unlocked"):Connect(function(value)
				toggleIndicator(basis.unlockFps, value);
			end);

			basis.unlockFps.MouseButton1Click:Connect(function()
				globals.customSettings.fps.unlocked = not globals.customSettings.fps.unlocked;
				if isThirdParty then
					setfpscap(globals.customSettings.fps.unlocked and (globals.customSettings.fps.vSync and getfpsmax() or globals.customSettings.fps.cap) or 60);
				end
			end);
		end

		do
			settingsUpdates:GetPropertyUpdatedSignal("fps.vSync"):Connect(function(value)
				toggleIndicator(basis.vSync, value);
			end);

			basis.vSync.MouseButton1Click:Connect(function()
				globals.customSettings.fps.vSync = not globals.customSettings.fps.vSync;
				basis.fpsCap.input.Text = tostring(globals.customSettings.fps.vSync and getfpsmax() or globals.customSettings.fps.cap);
				if isThirdParty and globals.customSettings.fps.unlocked then
					setfpscap(globals.customSettings.fps.vSync and getfpsmax() or globals.customSettings.fps.cap);
				end
			end);
		end

		do
			settingsUpdates:GetPropertyUpdatedSignal("fps.cap"):Connect(function(value)
				basis.fpsCap.input.Text = tostring(value);
				if isThirdParty and globals.customSettings.fps.unlocked and not globals.customSettings.fps.vSync then
					setfpscap(value);
				end
			end);

			basis.fpsCap.input.FocusLost:Connect(function()
				if globals.customSettings.fps.vSync then
					basis.fpsCap.input.Text = tostring(getfpsmax());
				else
					local x = tonumber(basis.fpsCap.input.Text);
					if x then
						globals.customSettings.fps.cap = x;
					else
						basis.fpsCap.input.Text = tostring(globals.customSettings.fps.cap);
					end
				end
			end);
		end
		
		if isThirdParty and globals.customSettings.fps.unlocked then
			setfpscap(globals.customSettings.fps.vSync and getfpsmax() or globals.customSettings.fps.cap);
		end
	end

	--[[ Module ]]--

	local init = {
		title = "Game"
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end
		
		createBasis(directory);
	end

	function init:IsInitialized()
		return basis ~= nil;
	end

	cache.ui.tabs.settings.game = init;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local popups = cache.ui.popups.init;

	local basis;

	--[[ Functions ]]--

	local function toggleIndicator(instance: Instance, value: boolean)
		utils:Tween(instance.toggle.indicator, 0.25, {
			Position = UDim2.new(0.5, value and 11 or -11, 0.5, 0)
		});
		utils:Tween(instance.toggle.indicator.gradient, 0.25, {
			Offset = Vector2.new(value and 0 or -1.25, 0)
		});
	end

	local function createBasis(directory: Instance)
		basis = utils:Create("ScrollingFrame", { 
			Active = true, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			BottomImage = "rbxassetid://14086218904", 
			CanvasSize = UDim2.new(0, 0, 0, 32), 
			MidImage = "rbxassetid://14086220094", 
			Name = "interface", 
			Parent = directory,
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScrollBarImageColor3 = Color3.fromHex("101216"), 
			ScrollBarThickness = 4, 
			ScrollingDirection = Enum.ScrollingDirection.Y, 
			Size = UDim2.new(1, 0, 1, 0), 
			TopImage = "rbxassetid://14086221127", 
			Visible = false
		}, {
			utils:Create("UIListLayout", { 
				Name = "list", 
				Padding = UDim.new(0, 8), 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "enlargedMenu", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.isMenuExtended and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.isMenuExtended and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Enlarges the right-hand scroll menu to include text.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Enlarged Menu", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "monitors", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Choose which monitors are displayed on the home page.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Monitors", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("ImageLabel", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Image = "rbxassetid://14617554127", 
					Name = "expand", 
					Position = UDim2.new(1, -27, 0.5, 0), 
					Size = UDim2.new(0, 28, 0, 28)
				})
			})
		});
		
		do
			settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
				toggleIndicator(basis.enlargedMenu, value);
			end);
			
			basis.enlargedMenu.MouseButton1Click:Connect(function()
				globals.customSettings.isMenuExtended = not globals.customSettings.isMenuExtended;
			end);
		end
		
		basis.monitors.MouseButton1Click:Connect(function()
			popups.instances.monitors.Visible = true;
		end);
	end

	--[[ Module ]]--

	local init = {
		title = "Interface"	
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end
		
		createBasis(directory);
	end

	function init:IsInitialized()
		return basis ~= nil;
	end

	cache.ui.tabs.settings.interface = init;
end

do
	--[[ Variables ]]--

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	local basis;

	--[[ Functions ]]--
	
	local function toggleIndicator(instance: Instance, value: boolean)
		utils:Tween(instance.toggle.indicator, 0.25, {
			Position = UDim2.new(0.5, value and 11 or -11, 0.5, 0)
		});
		utils:Tween(instance.toggle.indicator.gradient, 0.25, {
			Offset = Vector2.new(value and 0 or -1.25, 0)
		});
	end

	local function createBasis(directory: Instance)
		basis = utils:Create("ScrollingFrame", { 
			Active = true, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			BottomImage = "rbxassetid://14086218904", 
			CanvasSize = UDim2.new(0, 0, 0, 32), 
			MidImage = "rbxassetid://14086220094", 
			Name = "miscellaneous", 
			Parent = directory,
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScrollBarImageColor3 = Color3.fromHex("101216"), 
			ScrollBarThickness = 4, 
			ScrollingDirection = Enum.ScrollingDirection.Y, 
			Size = UDim2.new(1, 0, 1, 0), 
			TopImage = "rbxassetid://14086221127", 
			Visible = false
		}, {
			utils:Create("UIListLayout", { 
				Name = "list", 
				Padding = UDim.new(0, 8), 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "spoofInfo", 
				Size = UDim2.new(1, -4, 0, 50), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("Frame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					Name = "toggle", 
					Position = UDim2.new(1, -16, 0.5, 0), 
					Size = UDim2.new(0, 50, 0, 28)
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					utils:Create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BorderColor3 = Color3.fromHex("000000"), 
						BorderSizePixel = 0, 
						Name = "indicator", 
						Position = UDim2.new(0.5, globals.customSettings.spoofInfo.enabled and 11 or -11, 0.5, 0), 
						Size = UDim2.new(0, 22, 0, 22)
					}, {
						utils:Create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						}),
						utils:Create("UIGradient", { 
							Color = ColorSequence.new({ 
								ColorSequenceKeypoint.new(0, Color3.fromHex("4aa8fd")), 
								ColorSequenceKeypoint.new(0.95, Color3.fromHex("97b9d8")), 
								ColorSequenceKeypoint.new(1, Color3.fromHex("474d57"))
							}), 
							Name = "gradient", 
							Offset = Vector2.new(globals.customSettings.spoofInfo.enabled and 0 or -1.25, 0), 
							Rotation = 30
						})
					})
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "Changes the profile data displayed on the home page.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Spoof Personal Info", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				})
			}),
			utils:Create("TextButton", { 
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("2b2c2f"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size14, 
				Name = "fakeData", 
				Size = UDim2.new(1, -4, 0, 126), 
				Text = "", 
				TextColor3 = Color3.fromHex("000000"), 
				TextSize = 14
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "description", 
					Position = UDim2.new(0, 12, 0, 25), 
					Size = UDim2.new(1, -24, 0, 14), 
					Text = "The information to be displayed when \"Spoof Personal Info\" is enabled.", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextLabel", { 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size18, 
					Name = "title", 
					Position = UDim2.new(0, 12, 0, 8), 
					Size = UDim2.new(1, -24, 0, 15), 
					Text = "Personal Info", 
					TextColor3 = Color3.fromHex("ffffff"), 
					TextSize = 15, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utils:Create("TextBox", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "username", 
					PlaceholderColor3 = Color3.fromHex("707070"), 
					PlaceholderText = "Username...", 
					Position = UDim2.new(0.5, 0, 1, -48), 
					Size = UDim2.new(1, -22, 0, 28), 
					Text = globals.customSettings.spoofInfo.enabled and globals.customSettings.spoofInfo.name or "", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				}),
				utils:Create("TextBox", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("1f2022"), 
					BorderColor3 = Color3.fromHex("000000"), 
					BorderSizePixel = 0, 
					FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "userId", 
					PlaceholderColor3 = Color3.fromHex("707070"), 
					PlaceholderText = "User ID...", 
					Position = UDim2.new(0.5, 0, 1, -11), 
					Size = UDim2.new(1, -22, 0, 28), 
					Text = globals.customSettings.spoofInfo.enabled and tostring(globals.customSettings.spoofInfo.id) or "", 
					TextColor3 = Color3.fromHex("adb0ba"), 
					TextSize = 14
				}, {
					utils:Create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				})
			})
		});
		
		do
			settingsUpdates:GetPropertyUpdatedSignal("spoofInfo.enabled"):Connect(function(value)
				toggleIndicator(basis.spoofInfo, value);
			end);

			basis.spoofInfo.MouseButton1Click:Connect(function()
				globals.customSettings.spoofInfo.enabled = not globals.customSettings.spoofInfo.enabled;
			end);
			
			basis.fakeData.username.FocusLost:Connect(function()
				local x = basis.fakeData.username.Text;
				if #x > 0 then
					globals.customSettings.spoofInfo.name = basis.fakeData.username.Text;
				else
					basis.fakeData.username.Text = globals.customSettings.spoofInfo.name;
				end
			end);

			basis.fakeData.userId.FocusLost:Connect(function()
				local x = tonumber(basis.fakeData.userId.Text);
				if x then
					globals.customSettings.spoofInfo.id = x;
				else
					basis.fakeData.userId.Text = globals.customSettings.spoofInfo.id;
				end
			end);
		end
	end

	--[[ Module ]]--

	local init = {
		title = "Miscellaneous"
	};

	function init:Initialize(directory: Instance)
		if self:IsInitialized() then
			return;
		end
		
		createBasis(directory);
	end

	function init:IsInitialized()
		return basis ~= nil;
	end

	cache.ui.tabs.settings.miscellaneous = init;
end

do
	--[[ Variables ]]--

	local textService = game:GetService("TextService");

	local globals = cache.modules.globals;
	local settingsUpdates = cache.modules.settingsUpdates;
	local utils = cache.modules.utils;

	--[[ Module ]]--

	local init = {
		title = "Settings",
		id = "14009418156"	
	};

	function init:Initialize()
		self.tab = utils:Create("Frame", { 
			AnchorPoint = Vector2.new(0, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			Name = "settings", 
			Parent = cache.basis.gui.tabs, 
			Position = UDim2.new(0, 15, 0.5, 0), 
			Size = UDim2.new(1, globals.customSettings.isMenuExtended and -200 or -110, 1, -30),
			Visible = false
		}, {
			utils:Create("ScrollingFrame", { 
				Active = true, 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				BottomImage = "rbxassetid://14086218904", 
				CanvasSize = UDim2.new(0, 0, 0, 0), 
				HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar, 
				MidImage = "rbxassetid://14086220094", 
				Name = "categories", 
				Position = UDim2.new(0.5, 0, 0, 0), 
				ScrollBarImageColor3 = Color3.fromHex("101216"), 
				ScrollBarThickness = 4, 
				ScrollingDirection = Enum.ScrollingDirection.X, 
				Size = UDim2.new(1, 0, 0, 32), 
				TopImage = "rbxassetid://14086221127"
			}, {
				utils:Create("UIListLayout", { 
					FillDirection = Enum.FillDirection.Horizontal, 
					Name = "list", 
					Padding = UDim.new(0, 8), 
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				utils:Create("UIPadding", { 
					Name = "padding", 
					PaddingBottom = UDim.new(0, 1), 
					PaddingLeft = UDim.new(0, 1), 
					PaddingRight = UDim.new(0, 1), 
					PaddingTop = UDim.new(0, 1)
				})
			}),
			utils:Create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("1f2022"), 
				BorderColor3 = Color3.fromHex("000000"), 
				BorderSizePixel = 0, 
				Name = "holder", 
				Position = UDim2.new(0.5, 0, 1, 0), 
				Size = UDim2.new(1, 0, 1, -40)
			}, {
				utils:Create("UICorner", { 
					CornerRadius = UDim.new(0, 6), 
					Name = "corner"
				}),
				utils:Create("UIPadding", { 
					Name = "padding", 
					PaddingBottom = UDim.new(0, 8), 
					PaddingLeft = UDim.new(0, 8), 
					PaddingRight = UDim.new(0, 4), 
					PaddingTop = UDim.new(0, 8)
				})
			})
		});

		settingsUpdates:GetPropertyUpdatedSignal("isMenuExtended"):Connect(function(value)
			utils:Tween(self.tab, 0.25, {
				Size = UDim2.new(1, value and -200 or -110, 1, -30)
			});
		end);
		
		local menus = { "exploit", "game", "interface", "miscellaneous" };
		
		for i, v in menus do
			local module = cache.ui.tabs.settings[v];
			self:AddMenuOption(module.title);
			module:Initialize(self.tab.holder);
		end
		
		self:ForceSelect(menus[1]);
	end

	function init:AddMenuOption(title: string)
		utils:Create("TextButton", { 
			BackgroundColor3 = Color3.fromHex("1f2022"), 
			BorderColor3 = Color3.fromHex("000000"), 
			BorderSizePixel = 0, 
			FontFace = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = string.lower(title), 
			Parent = self.tab.categories,
			Size = UDim2.new(0, textService:GetTextBoundsAsync(utils:Create("GetTextBoundsParams", {
				Font = Font.new(string.format("rbxasset://%s/Custom Fonts/Montserrat/Montserrat.json", cache.modules.globals.customAssetPath), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				Size = 14,
				Text = title,
				Width = math.huge
			})).X + 18, 1, 0), 
			Text = title, 
			TextColor3 = Color3.fromHex("ffffff"), 
			TextSize = 14
		}, {
			utils:Create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			})
		}).MouseButton1Click:Connect(function()
			self:ForceSelect(string.lower(title));
		end);
	end

	function init:ForceSelect(menu: string)
		for i, v in self.tab.holder:GetChildren() do
			if v:IsA("ScrollingFrame") then
				v.Visible = v.Name == menu;
			end
		end
	end

	cache.ui.tabs.settings.init = init;
end

do
	local globals = cache.modules.globals;
	
	game:GetService("LogService").MessageOut:Connect(function(msg: string, msgType: Enum.MessageType)
		if globals.customSettings.consoleLogs then
			(isfile("console.log") and appendfile or writefile)("console.log", string.format("[%s]: %s\n", msgType.Name, msg));
		end
	end);

	local utils = cache.modules.utils;
		
	basis = utils:Create("Folder", {
		Name = "Hydrogen"
	}, {
		utils:Create("Folder", {
			Name = "bin"
		})
	});
		
	utils:DynamicParent(basis);

	cache.basis = basis;
	cache.startup.init:Initialize(basis);
end

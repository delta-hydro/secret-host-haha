-- Synapse X Remake made by @chillz_azy (yt)

local synversion = "April Fools!"

-- this shit function makes my script fucked
--[[pcall(function()
    local HttpService = game:GetService("HttpService")
    local response = game:HttpGet("https://api.whatexploitsare.online/status")
    local data = HttpService:JSONDecode(response)

    for _, item in pairs(data) do
        if item.Synapse then
            synversion = item.Synapse.exploit_version
	end
    end
end)]]

-- Instances: 150 | Scripts: 8 | Modules: 4
local G2L = {};
-- StarterGui.SynapseX
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
G2L["1"]["Name"] = [[SynapseX]];
G2L["1"]["ResetOnSpawn"] = false;

-- StarterGui.SynapseX.FloatingIcon
G2L["2"] = Instance.new("ImageButton", G2L["1"]);
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["2"]["Size"] = UDim2.new(0, 36, 0, 36);
G2L["2"]["Name"] = [[FloatingIcon]];
G2L["2"].Visible = false
G2L["2"]["Position"] = UDim2.new(0.7019911956787109, 0, 0.7092568278312683, 0);

-- StarterGui.SynapseX.FloatingIcon. 
G2L["3"] = Instance.new("ImageLabel", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["3"]["Size"] = UDim2.new(0, 23, 0, 26);
G2L["3"]["Name"] = [[ ]];
G2L["3"]["BackgroundTransparency"] = 1;
G2L["3"]["Position"] = UDim2.new(0.16640418767929077, 0, 0.13268542289733887, 0);

-- StarterGui.SynapseX.FloatingIcon.UICorner
G2L["4"] = Instance.new("UICorner", G2L["2"]);
G2L["4"]["CornerRadius"] = UDim.new(1, 8);

-- StarterGui.SynapseX.FloatingIcon.UIGradient
G2L["5"] = Instance.new("UIGradient", G2L["2"]);
G2L["5"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.720, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

-- StarterGui.SynapseX.Main
G2L["6"] = Instance.new("Frame", G2L["1"]);
G2L["6"]["Active"] = true;
G2L["6"]["ZIndex"] = 4;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
G2L["6"]["BackgroundTransparency"] = 1;
G2L["6"]["Size"] = UDim2.new(0, 646, 0, 283);
G2L["6"]["Position"] = UDim2.new(0, 19, 0, 23);
G2L["6"]["Name"] = [[Main]];

-- StarterGui.SynapseX.Main.Icon
G2L["7"] = Instance.new("ImageLabel", G2L["6"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["7"]["Size"] = UDim2.new(0, 23, 0, 26);
G2L["7"]["Name"] = [[Icon]];
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["Position"] = UDim2.new(0, 5, 0, 0);

-- StarterGui.SynapseX.Main.Background
G2L["8"] = Instance.new("ImageLabel", G2L["6"]);
G2L["8"]["ZIndex"] = 0;
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["ScaleType"] = Enum.ScaleType.Tile;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(52, 52, 52);
G2L["8"]["TileSize"] = UDim2.new(0, 25, 0, 25);
G2L["8"]["Size"] = UDim2.new(0, 647, 0, 283);
G2L["8"]["Name"] = [[Background]];

-- StarterGui.SynapseX.Main.Panel
G2L["9"] = Instance.new("Frame", G2L["6"]);
G2L["9"]["ZIndex"] = 0;
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["9"]["Size"] = UDim2.new(0, 647, 0, 27);
G2L["9"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Name"] = [[Panel]];

-- StarterGui.SynapseX.Main.MainFunc
G2L["a"] = Instance.new("Frame", G2L["6"]);
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["BackgroundTransparency"] = 1;
G2L["a"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["a"]["Name"] = [[MainFunc]];

-- StarterGui.SynapseX.Main.MainFunc.Needs
G2L["b"] = Instance.new("Folder", G2L["a"]);
G2L["b"]["Name"] = [[Needs]];

-- StarterGui.SynapseX.Main.MainFunc.Needs.Tab
G2L["c"] = Instance.new("TextButton", G2L["b"]);
G2L["c"]["ZIndex"] = 0;
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
G2L["c"]["TextSize"] = 14;
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["Visible"] = false;
G2L["c"]["Size"] = UDim2.new(0, 56, 0, 16);
G2L["c"]["Name"] = [[Tab]];
G2L["c"]["Text"] = [[  Script 1]];
G2L["c"]["Position"] = UDim2.new(-0.0003878306597471237, 0, -0.011710520833730698, 0);
G2L["c"]["BackgroundTransparency"] = 0.10000000149011612;

-- StarterGui.SynapseX.Main.MainFunc.Needs.Tab.Remove
G2L["d"] = Instance.new("TextButton", G2L["c"]);
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
G2L["d"]["TextSize"] = 15;
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["Size"] = UDim2.new(0, 10, 0, 10);
G2L["d"]["Name"] = [[Remove]];
G2L["d"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["d"]["Text"] = [[x]];
G2L["d"]["Position"] = UDim2.new(0, 46, 0, 2);
G2L["d"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.MainFunc.Needs.ScriptHubButton
G2L["e"] = Instance.new("TextButton", G2L["b"]);
G2L["e"]["ZIndex"] = 3;
G2L["e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["e"]["TextSize"] = 14;
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["Visible"] = false;
G2L["e"]["Size"] = UDim2.new(0, 96, 0, 15);
G2L["e"]["Name"] = [[ScriptHubButton]];
G2L["e"]["BorderColor3"] = Color3.fromRGB(61, 61, 61);
G2L["e"]["Text"] = [[test.lua]];
G2L["e"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["e"]["Position"] = UDim2.new(0.039603959769010544, 0, 0, 0);

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox
G2L["f"] = Instance.new("ScrollingFrame", G2L["b"]);
G2L["f"]["Active"] = true;
G2L["f"]["BorderSizePixel"] = 0;
G2L["f"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["f"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY;
G2L["f"]["Size"] = UDim2.new(0, 533, 0, 197);
G2L["f"]["Position"] = UDim2.new(0.05999999865889549, 0, 0.48061829805374146, 0);
G2L["f"]["Visible"] = false;
G2L["f"]["Name"] = [[Textbox]];

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame
G2L["10"] = Instance.new("Frame", G2L["f"]);
G2L["10"]["Active"] = true;
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["10"]["Size"] = UDim2.new(0, 533, 0, 200);
G2L["10"]["Selectable"] = true;
G2L["10"]["ClipsDescendants"] = true;
G2L["10"]["AutomaticSize"] = Enum.AutomaticSize.XY;
G2L["10"]["SelectionGroup"] = true;

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame.Textbox
G2L["11"] = Instance.new("TextBox", G2L["10"]);
G2L["11"]["ZIndex"] = 4;
G2L["11"]["BorderSizePixel"] = 0;
G2L["11"]["TextSize"] = 14;
G2L["11"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["11"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["11"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["11"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["11"]["MultiLine"] = true;
G2L["11"]["Size"] = UDim2.new(0, 486, 0, 194);
G2L["11"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11"]["Text"] = [[]];
G2L["11"]["Position"] = UDim2.new(0, 35, 0, 0);
G2L["11"]["AutomaticSize"] = Enum.AutomaticSize.XY;
G2L["11"]["Name"] = [[Textbox]];
G2L["11"]["ClearTextOnFocus"] = false;

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame.Linebar
G2L["12"] = Instance.new("Frame", G2L["10"]);
G2L["12"]["ZIndex"] = 2;
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
G2L["12"]["Size"] = UDim2.new(0, 32, 1, 0);
G2L["12"]["Name"] = [[Linebar]];

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame.Linebar.LineText
G2L["13"] = Instance.new("TextLabel", G2L["12"]);
G2L["13"]["ZIndex"] = 5;
G2L["13"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["13"]["TextSize"] = 14;
G2L["13"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["Size"] = UDim2.new(0, 24, 0, 197);
G2L["13"]["Text"] = [[1]];
G2L["13"]["Name"] = [[LineText]];
G2L["13"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame.Highlighted
G2L["14"] = Instance.new("Frame", G2L["10"]);
G2L["14"]["ZIndex"] = 5;
G2L["14"]["BorderSizePixel"] = 0;
G2L["14"]["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
G2L["14"]["BackgroundTransparency"] = 0.699999988079071;
G2L["14"]["Size"] = UDim2.new(1.0958691835403442, 0, 0, 13);
G2L["14"]["Position"] = UDim2.new(0, -44, 0, 0);
G2L["14"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["14"]["Name"] = [[Highlighted]];

-- StarterGui.SynapseX.Main.MainFunc.Needs.Textbox.Frame.Highlighted.LineText
G2L["15"] = Instance.new("TextLabel", G2L["14"]);
G2L["15"]["ZIndex"] = 5;
G2L["15"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["15"]["TextTransparency"] = 1;
G2L["15"]["TextSize"] = 14;
G2L["15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15"]["Size"] = UDim2.new(0, 24, 0, 197);
G2L["15"]["Text"] = [[1]];
G2L["15"]["Name"] = [[LineText]];
G2L["15"]["Visible"] = false;
G2L["15"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.MainFunc.Textboxes
G2L["16"] = Instance.new("Folder", G2L["a"]);
G2L["16"]["Name"] = [[Textboxes]];

-- StarterGui.SynapseX.Main.MainFunc.ScriptHub
G2L["17"] = Instance.new("ScrollingFrame", G2L["a"]);
G2L["17"]["Active"] = true;
G2L["17"]["ZIndex"] = 2;
G2L["17"]["BorderSizePixel"] = 0;
G2L["17"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["17"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY;
G2L["17"]["Size"] = UDim2.new(0, 101, 0, 215);
G2L["17"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17"]["Position"] = UDim2.new(5.420000076293945, 0, 0.30000001192092896, 0);
G2L["17"]["Name"] = [[ScriptHub]];

-- StarterGui.SynapseX.Main.MainFunc.ScriptHub.UIListLayout
G2L["18"] = Instance.new("UIListLayout", G2L["17"]);
G2L["18"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- StarterGui.SynapseX.Main.MainFunc.ScriptHub.UIPadding
G2L["19"] = Instance.new("UIPadding", G2L["17"]);
G2L["19"]["PaddingLeft"] = UDim.new(0.05000000074505806, 0);

-- StarterGui.SynapseX.Main.Maximize
G2L["1a"] = Instance.new("ImageButton", G2L["6"]);
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["1a"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["1a"]["Name"] = [[Maximize]];
G2L["1a"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["1a"]["Position"] = UDim2.new(0, 606, 0, 2);

-- StarterGui.SynapseX.Main.Maximize.NameText
G2L["1b"] = Instance.new("TextLabel", G2L["1a"]);
G2L["1b"]["TextWrapped"] = true;
G2L["1b"]["ZIndex"] = 2;
G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1b"]["TextSize"] = 12;
G2L["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["1b"]["Active"] = true;
G2L["1b"]["Text"] = [[M]];
G2L["1b"]["Name"] = [[NameText]];
G2L["1b"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Maximize.ImageButton
G2L["1c"] = Instance.new("ImageButton", G2L["1a"]);
G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["1c"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["1c"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["1c"]["Visible"] = false;
G2L["1c"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Maximize.UICorner
G2L["1d"] = Instance.new("UICorner", G2L["1a"]);
G2L["1d"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.TitleSynapse
G2L["1e"] = Instance.new("TextLabel", G2L["6"]);
G2L["1e"]["BorderSizePixel"] = 0;
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1e"]["TextSize"] = 15;
G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["Size"] = UDim2.new(0, 646, 0, 27);
G2L["1e"]["Text"] = "Synapse X - "..synversion;
G2L["1e"]["Name"] = [[TitleSynapse]];
G2L["1e"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.ScriptHub
G2L["1f"] = Instance.new("ImageButton", G2L["6"]);
G2L["1f"]["BorderSizePixel"] = 0;
G2L["1f"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["1f"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["1f"]["Name"] = [[ScriptHub]];
G2L["1f"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["1f"]["Position"] = UDim2.new(0, 560, 0, 250);

-- StarterGui.SynapseX.Main.ScriptHub.NameText
G2L["20"] = Instance.new("TextLabel", G2L["1f"]);
G2L["20"]["TextWrapped"] = true;
G2L["20"]["ZIndex"] = 2;
G2L["20"]["BorderSizePixel"] = 0;
G2L["20"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["20"]["TextSize"] = 14;
G2L["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["20"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["20"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["20"]["Text"] = [[Script Hub]];
G2L["20"]["Name"] = [[NameText]];
G2L["20"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.ScriptHub.ImageButton
G2L["21"] = Instance.new("ImageButton", G2L["1f"]);
G2L["21"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["21"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["21"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["21"]["Visible"] = false;
G2L["21"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.ScriptHub.UICorner
G2L["22"] = Instance.new("UICorner", G2L["1f"]);
G2L["22"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Options
G2L["23"] = Instance.new("ImageButton", G2L["6"]);
G2L["23"]["BorderSizePixel"] = 0;
G2L["23"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["23"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["23"]["Name"] = [[Options]];
G2L["23"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["23"]["Position"] = UDim2.new(0, 352, 0, 250);

-- StarterGui.SynapseX.Main.Options.NameText
G2L["24"] = Instance.new("TextLabel", G2L["23"]);
G2L["24"]["TextWrapped"] = true;
G2L["24"]["ZIndex"] = 2;
G2L["24"]["BorderSizePixel"] = 0;
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["24"]["TextSize"] = 14;
G2L["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["24"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["24"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["24"]["Text"] = [[Options]];
G2L["24"]["Name"] = [[NameText]];
G2L["24"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Options.ImageButton
G2L["25"] = Instance.new("ImageButton", G2L["23"]);
G2L["25"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["25"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["25"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["25"]["Visible"] = false;
G2L["25"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Options.UICorner
G2L["26"] = Instance.new("UICorner", G2L["23"]);
G2L["26"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Minimize
G2L["27"] = Instance.new("ImageButton", G2L["6"]);
G2L["27"]["BorderSizePixel"] = 0;
G2L["27"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["27"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["27"]["Name"] = [[Minimize]];
G2L["27"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["27"]["Position"] = UDim2.new(0, 582, 0, 2);

-- StarterGui.SynapseX.Main.Minimize.NameText
G2L["28"] = Instance.new("TextLabel", G2L["27"]);
G2L["28"]["TextWrapped"] = true;
G2L["28"]["ZIndex"] = 2;
G2L["28"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["28"]["TextSize"] = 15;
G2L["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["28"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["28"]["Active"] = true;
G2L["28"]["Text"] = [[_]];
G2L["28"]["Name"] = [[NameText]];
G2L["28"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Minimize.ImageButton
G2L["29"] = Instance.new("ImageButton", G2L["27"]);
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["29"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["29"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["29"]["Visible"] = false;
G2L["29"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Minimize.UICorner
G2L["2a"] = Instance.new("UICorner", G2L["27"]);
G2L["2a"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Execute
G2L["2b"] = Instance.new("ImageButton", G2L["6"]);
G2L["2b"]["BorderSizePixel"] = 0;
G2L["2b"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["2b"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["2b"]["Name"] = [[Execute]];
G2L["2b"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["2b"]["Position"] = UDim2.new(0, 6, 0, 250);

-- StarterGui.SynapseX.Main.Execute.NameText
G2L["2c"] = Instance.new("TextLabel", G2L["2b"]);
G2L["2c"]["TextWrapped"] = true;
G2L["2c"]["ZIndex"] = 2;
G2L["2c"]["BorderSizePixel"] = 0;
G2L["2c"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["2c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2c"]["TextSize"] = 14;
G2L["2c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2c"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["2c"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2c"]["Text"] = [[Execute]];
G2L["2c"]["Name"] = [[NameText]];
G2L["2c"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Execute.ImageButton
G2L["2d"] = Instance.new("ImageButton", G2L["2b"]);
G2L["2d"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["2d"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["2d"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["2d"]["Visible"] = false;
G2L["2d"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Execute.UICorner
G2L["2e"] = Instance.new("UICorner", G2L["2b"]);
G2L["2e"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.SaveFile
G2L["2f"] = Instance.new("ImageButton", G2L["6"]);
G2L["2f"]["BorderSizePixel"] = 0;
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["2f"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["2f"]["Name"] = [[SaveFile]];
G2L["2f"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["2f"]["Position"] = UDim2.new(0, 266, 0, 250);

-- StarterGui.SynapseX.Main.SaveFile.NameText
G2L["30"] = Instance.new("TextLabel", G2L["2f"]);
G2L["30"]["TextWrapped"] = true;
G2L["30"]["ZIndex"] = 2;
G2L["30"]["BorderSizePixel"] = 0;
G2L["30"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["30"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["30"]["TextSize"] = 14;
G2L["30"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["30"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["Text"] = [[Save File]];
G2L["30"]["Name"] = [[NameText]];
G2L["30"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.SaveFile.ImageButton
G2L["31"] = Instance.new("ImageButton", G2L["2f"]);
G2L["31"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["31"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["31"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["31"]["Visible"] = false;
G2L["31"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.SaveFile.UICorner
G2L["32"] = Instance.new("UICorner", G2L["2f"]);
G2L["32"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Close
G2L["33"] = Instance.new("ImageButton", G2L["6"]);
G2L["33"]["BorderSizePixel"] = 0;
G2L["33"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["33"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["33"]["Name"] = [[Close]];
G2L["33"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["33"]["Position"] = UDim2.new(0, 627, 0, 2);

-- StarterGui.SynapseX.Main.Close.NameText
G2L["34"] = Instance.new("TextLabel", G2L["33"]);
G2L["34"]["TextWrapped"] = true;
G2L["34"]["ZIndex"] = 2;
G2L["34"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["34"]["TextSize"] = 14;
G2L["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["34"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["34"]["Active"] = true;
G2L["34"]["Text"] = [[x]];
G2L["34"]["Name"] = [[NameText]];
G2L["34"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Close.ImageButton
G2L["35"] = Instance.new("ImageButton", G2L["33"]);
G2L["35"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["35"]["Size"] = UDim2.new(0, 15, 0, 15);
G2L["35"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["35"]["Visible"] = false;
G2L["35"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Close.UICorner
G2L["36"] = Instance.new("UICorner", G2L["33"]);
G2L["36"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Clear
G2L["37"] = Instance.new("ImageButton", G2L["6"]);
G2L["37"]["BorderSizePixel"] = 0;
G2L["37"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["37"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["37"]["Name"] = [[Clear]];
G2L["37"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["37"]["Position"] = UDim2.new(0, 92, 0, 250);

-- StarterGui.SynapseX.Main.Clear.NameText
G2L["38"] = Instance.new("TextLabel", G2L["37"]);
G2L["38"]["TextWrapped"] = true;
G2L["38"]["ZIndex"] = 2;
G2L["38"]["BorderSizePixel"] = 0;
G2L["38"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["38"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["38"]["TextSize"] = 14;
G2L["38"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["38"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["38"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["38"]["Text"] = [[Clear]];
G2L["38"]["Name"] = [[NameText]];
G2L["38"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Clear.ImageButton
G2L["39"] = Instance.new("ImageButton", G2L["37"]);
G2L["39"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["39"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["39"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["39"]["Visible"] = false;
G2L["39"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Clear.UICorner
G2L["3a"] = Instance.new("UICorner", G2L["37"]);
G2L["3a"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.Attach
G2L["3b"] = Instance.new("ImageButton", G2L["6"]);
G2L["3b"]["BorderSizePixel"] = 0;
G2L["3b"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["3b"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["3b"]["Name"] = [[Attach]];
G2L["3b"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["3b"]["Position"] = UDim2.new(0, 474, 0, 250);

-- StarterGui.SynapseX.Main.Attach.NameText
G2L["3c"] = Instance.new("TextLabel", G2L["3b"]);
G2L["3c"]["TextWrapped"] = true;
G2L["3c"]["ZIndex"] = 2;
G2L["3c"]["BorderSizePixel"] = 0;
G2L["3c"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["3c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["3c"]["TextSize"] = 14;
G2L["3c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3c"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["3c"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3c"]["Text"] = [[Attach]];
G2L["3c"]["Name"] = [[NameText]];
G2L["3c"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.Attach.ImageButton
G2L["3d"] = Instance.new("ImageButton", G2L["3b"]);
G2L["3d"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["3d"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["3d"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["3d"]["Visible"] = false;
G2L["3d"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.Attach.UICorner
G2L["3e"] = Instance.new("UICorner", G2L["3b"]);
G2L["3e"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.OpenFile
G2L["3f"] = Instance.new("ImageButton", G2L["6"]);
G2L["3f"]["BorderSizePixel"] = 0;
G2L["3f"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["3f"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["3f"]["Name"] = [[OpenFile]];
G2L["3f"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["3f"]["Position"] = UDim2.new(0, 179, 0, 250);

-- StarterGui.SynapseX.Main.OpenFile.NameText
G2L["40"] = Instance.new("TextLabel", G2L["3f"]);
G2L["40"]["TextWrapped"] = true;
G2L["40"]["ZIndex"] = 2;
G2L["40"]["BorderSizePixel"] = 0;
G2L["40"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["40"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["40"]["TextSize"] = 14;
G2L["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["40"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["40"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["40"]["Text"] = [[Open File]];
G2L["40"]["Name"] = [[NameText]];
G2L["40"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.Main.OpenFile.ImageButton
G2L["41"] = Instance.new("ImageButton", G2L["3f"]);
G2L["41"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["41"]["Size"] = UDim2.new(0, 82, 0, 27);
G2L["41"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["41"]["Visible"] = false;
G2L["41"]["BackgroundTransparency"] = 0.6000000238418579;

-- StarterGui.SynapseX.Main.OpenFile.UICorner
G2L["42"] = Instance.new("UICorner", G2L["3f"]);
G2L["42"]["CornerRadius"] = UDim.new(0, 0);

-- StarterGui.SynapseX.Main.ScriptTab
G2L["43"] = Instance.new("ScrollingFrame", G2L["6"]);
G2L["43"]["Active"] = true;
G2L["43"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["43"]["SizeConstraint"] = Enum.SizeConstraint.RelativeYY;
G2L["43"]["ZIndex"] = 6;
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["43"]["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Left;
G2L["43"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.Always;
G2L["43"]["AutomaticCanvasSize"] = Enum.AutomaticSize.X;
G2L["43"]["BackgroundTransparency"] = 0.9990000128746033;
G2L["43"]["Size"] = UDim2.new(0, 533, 0, 16);
G2L["43"]["Selectable"] = false;
G2L["43"]["ClipsDescendants"] = false;
G2L["43"]["ScrollBarThickness"] = 3;
G2L["43"]["Position"] = UDim2.new(0, 6, 0, 32);
G2L["43"]["Name"] = [[ScriptTab]];
G2L["43"]["SelectionGroup"] = false;

-- StarterGui.SynapseX.Main.ScriptTab.ScriptTabHandler
G2L["44"] = Instance.new("LocalScript", G2L["43"]);
G2L["44"]["Name"] = [[ScriptTabHandler]];

-- StarterGui.SynapseX.Main.ScriptTab.Tabs
G2L["45"] = Instance.new("Folder", G2L["43"]);
G2L["45"]["Name"] = [[Tabs]];

-- StarterGui.SynapseX.Main.ScriptTab.Tabs.AddScript
G2L["46"] = Instance.new("Frame", G2L["45"]);
G2L["46"]["Active"] = true;
G2L["46"]["ZIndex"] = 0;
G2L["46"]["BorderSizePixel"] = 0;
G2L["46"]["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
G2L["46"]["BackgroundTransparency"] = 1;
G2L["46"]["LayoutOrder"] = 999999999;
G2L["46"]["Size"] = UDim2.new(0, 10, 0, 11);
G2L["46"]["Selectable"] = true;
G2L["46"]["Name"] = [[AddScript]];

-- StarterGui.SynapseX.Main.ScriptTab.Tabs.AddScript.Button
G2L["47"] = Instance.new("TextButton", G2L["46"]);
G2L["47"]["BorderSizePixel"] = 0;
G2L["47"]["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
G2L["47"]["TextSize"] = 20;
G2L["47"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["47"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["47"]["Size"] = UDim2.new(0, 10, 0, 11);
G2L["47"]["LayoutOrder"] = 999999999;
G2L["47"]["Name"] = [[Button]];
G2L["47"]["Text"] = [[+]];
G2L["47"]["Position"] = UDim2.new(0.1599999964237213, 0, 0.25, 0);
G2L["47"]["BackgroundTransparency"] = 0.10000000149011612;

-- StarterGui.SynapseX.Main.ScriptTab.Tabs.UIListLayout
G2L["48"] = Instance.new("UIListLayout", G2L["45"]);
G2L["48"]["FillDirection"] = Enum.FillDirection.Horizontal;
G2L["48"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- StarterGui.SynapseX.Main.ButtonsHandler
G2L["49"] = Instance.new("LocalScript", G2L["6"]);
G2L["49"]["Name"] = [[ButtonsHandler]];

-- StarterGui.SynapseX.SaveScript
G2L["4a"] = Instance.new("Frame", G2L["1"]);
G2L["4a"]["Active"] = true;
G2L["4a"]["ZIndex"] = 10;
G2L["4a"]["BorderSizePixel"] = 0;
G2L["4a"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["4a"]["Size"] = UDim2.new(0, 322, 0, 81);
G2L["4a"]["Position"] = UDim2.new(0.2866774797439575, 0, 0.3861943185329437, 0);
G2L["4a"]["Visible"] = false;
G2L["4a"]["Name"] = [[SaveScript]];

-- StarterGui.SynapseX.SaveScript.scriptname
G2L["4b"] = Instance.new("TextBox", G2L["4a"]);
G2L["4b"]["ZIndex"] = 11;
G2L["4b"]["BorderSizePixel"] = 0;
G2L["4b"]["TextSize"] = 14;
G2L["4b"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["4b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4b"]["PlaceholderText"] = [[File Name]];
G2L["4b"]["Size"] = UDim2.new(0, 317, 0, 22);
G2L["4b"]["Text"] = [[]];
G2L["4b"]["Position"] = UDim2.new(0, 3, 0, 32);
G2L["4b"]["Name"] = [[scriptname]];

-- StarterGui.SynapseX.SaveScript.savescript
G2L["4c"] = Instance.new("TextButton", G2L["4a"]);
G2L["4c"]["ZIndex"] = 11;
G2L["4c"]["BorderSizePixel"] = 0;
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(46, 46, 46);
G2L["4c"]["TextSize"] = 14;
G2L["4c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["Size"] = UDim2.new(0, 317, 0, 19);
G2L["4c"]["Name"] = [[savescript]];
G2L["4c"]["Text"] = [[Save File]];
G2L["4c"]["Position"] = UDim2.new(0, 3, 0, 56);

-- StarterGui.SynapseX.SaveScript.Icon
G2L["4d"] = Instance.new("ImageLabel", G2L["4a"]);
G2L["4d"]["ZIndex"] = 11;
G2L["4d"]["BorderSizePixel"] = 0;
G2L["4d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4d"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["4d"]["Size"] = UDim2.new(0, 48, 0, 23);
G2L["4d"]["Name"] = [[Icon]];
G2L["4d"]["BackgroundTransparency"] = 1;
G2L["4d"]["Position"] = UDim2.new(0.008999999612569809, 0, 0.05000000074505806, 0);

-- StarterGui.SynapseX.SaveScript.Icon.UIAspectRatioConstraint
G2L["4e"] = Instance.new("UIAspectRatioConstraint", G2L["4d"]);
G2L["4e"]["AspectRatio"] = 0.8846153616905212;

-- StarterGui.SynapseX.SaveScript.Title
G2L["4f"] = Instance.new("TextLabel", G2L["4a"]);
G2L["4f"]["TextWrapped"] = true;
G2L["4f"]["ZIndex"] = 11;
G2L["4f"]["BorderSizePixel"] = 4;
G2L["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4f"]["TextSize"] = 15;
G2L["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4f"]["Size"] = UDim2.new(0, 322, 0, 30);
G2L["4f"]["Active"] = true;
G2L["4f"]["Text"] = [[Synapse X - Save File]];
G2L["4f"]["Name"] = [[Title]];
G2L["4f"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.SaveScript.Close
G2L["50"] = Instance.new("TextButton", G2L["4a"]);
G2L["50"]["TextWrapped"] = true;
G2L["50"]["ZIndex"] = 12;
G2L["50"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["50"]["TextSize"] = 17;
G2L["50"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["50"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["50"]["Selectable"] = false;
G2L["50"]["Size"] = UDim2.new(0, 26, 0, 26);
G2L["50"]["Name"] = [[Close]];
G2L["50"]["Text"] = [[x]];
G2L["50"]["Position"] = UDim2.new(0.9130434989929199, 0, 0.024690981954336166, 0);
G2L["50"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.SaveScript.Handler
G2L["51"] = Instance.new("LocalScript", G2L["4a"]);
G2L["51"]["Name"] = [[Handler]];

-- StarterGui.SynapseX.ScriptLog
G2L["52"] = Instance.new("Frame", G2L["1"]);
G2L["52"]["Active"] = true;
G2L["52"]["BorderSizePixel"] = 0;
G2L["52"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
G2L["52"]["Size"] = UDim2.new(0, 353, 0, 26);
G2L["52"]["Position"] = UDim2.new(0.25691962242126465, 0, 0.26443204283714294, 0);
G2L["52"]["Visible"] = false;
G2L["52"]["Name"] = [[ScriptLog]];

-- StarterGui.SynapseX.ScriptLog.MainFrame
G2L["53"] = Instance.new("Frame", G2L["52"]);
G2L["53"]["BorderSizePixel"] = 0;
G2L["53"]["BackgroundColor3"] = Color3.fromRGB(51, 51, 51);
G2L["53"]["Size"] = UDim2.new(0, 353, 0, 185);
G2L["53"]["Position"] = UDim2.new(0, 0, 1, 0);
G2L["53"]["Name"] = [[MainFrame]];

-- StarterGui.SynapseX.ScriptLog.MainFrame.ANS9DZNASD8Z7NAS987NAFA
G2L["54"] = Instance.new("ScrollingFrame", G2L["53"]);
G2L["54"]["Active"] = true;
G2L["54"]["BorderSizePixel"] = 0;
G2L["54"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["54"]["Size"] = UDim2.new(0, 116, 0, 162);
G2L["54"]["Position"] = UDim2.new(0.033443499356508255, 0, 0.06024263799190521, 0);
G2L["54"]["Name"] = [[ANS9DZNASD8Z7NAS987NAFA]];

-- StarterGui.SynapseX.ScriptLog.MainFrame.ANS9DZNASD8Z7NAS987NAFA.Script1
G2L["55"] = Instance.new("TextButton", G2L["54"]);
G2L["55"]["BorderSizePixel"] = 0;
G2L["55"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["55"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
G2L["55"]["TextSize"] = 14;
G2L["55"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["55"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["55"]["Size"] = UDim2.new(0, 116, 0, 19);
G2L["55"]["Name"] = [[Script1]];
G2L["55"]["Text"] = [[Script1]];

-- StarterGui.SynapseX.ScriptLog.MainFrame.A8SDMZAS89DZANSA98F
G2L["56"] = Instance.new("TextButton", G2L["53"]);
G2L["56"]["BorderSizePixel"] = 0;
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["56"]["TextSize"] = 14;
G2L["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["56"]["Size"] = UDim2.new(0, 97, 0, 25);
G2L["56"]["Name"] = [[A8SDMZAS89DZANSA98F]];
G2L["56"]["Text"] = [[Close]];
G2L["56"]["Position"] = UDim2.new(0.7019798755645752, 0, 0.800000011920929, 0);

-- StarterGui.SynapseX.ScriptLog.MainFrame.9NAC7A9S7N8ZASFH9ASF87NAS8YGA9GSA7
G2L["57"] = Instance.new("TextBox", G2L["53"]);
G2L["57"]["BorderSizePixel"] = 0;
G2L["57"]["TextEditable"] = false;
G2L["57"]["TextSize"] = 14;
G2L["57"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["57"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["57"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["57"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["57"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["57"]["Size"] = UDim2.new(0, 200, 0, 129);
G2L["57"]["Text"] = [[]];
G2L["57"]["Position"] = UDim2.new(0.4107648730278015, 0, 0.05550934001803398, 0);
G2L["57"]["Name"] = [[9NAC7A9S7N8ZASFH9ASF87NAS8YGA9GSA7]];
G2L["57"]["ClearTextOnFocus"] = false;

-- StarterGui.SynapseX.ScriptLog.MainFrame.9A8D7NAS9Z87NZDA98S7DNA98DNZ9A8SN
G2L["58"] = Instance.new("TextButton", G2L["53"]);
G2L["58"]["BorderSizePixel"] = 0;
G2L["58"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["58"]["TextSize"] = 14;
G2L["58"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["58"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["58"]["Size"] = UDim2.new(0, 97, 0, 25);
G2L["58"]["Name"] = [[9A8D7NAS9Z87NZDA98S7DNA98DNZ9A8SN]];
G2L["58"]["Text"] = [[Copy Code]];
G2L["58"]["Position"] = UDim2.new(0.4107648730278015, 0, 0.800000011920929, 0);

-- StarterGui.SynapseX.ScriptLog.Icon
G2L["59"] = Instance.new("ImageLabel", G2L["52"]);
G2L["59"]["BorderSizePixel"] = 0;
G2L["59"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["59"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["59"]["Size"] = UDim2.new(0, 23, 0, 26);
G2L["59"]["Name"] = [[Icon]];
G2L["59"]["BackgroundTransparency"] = 1;
G2L["59"]["Position"] = UDim2.new(0.00932147353887558, 0, -0.006203480064868927, 0);

-- StarterGui.SynapseX.ScriptLog.Title
G2L["5a"] = Instance.new("TextLabel", G2L["52"]);
G2L["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5a"]["TextSize"] = 14;
G2L["5a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5a"]["Size"] = UDim2.new(0, 353, 0, 26);
G2L["5a"]["Text"] = [[Script Log]];
G2L["5a"]["Name"] = [[Title]];
G2L["5a"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu
G2L["5b"] = Instance.new("Frame", G2L["1"]);
G2L["5b"]["Active"] = true;
G2L["5b"]["BorderSizePixel"] = 0;
G2L["5b"]["BackgroundColor3"] = Color3.fromRGB(67, 67, 67);
G2L["5b"]["Size"] = UDim2.new(0, 411, 0, 31);
G2L["5b"]["Position"] = UDim2.new(0, 13, 0, 13);
G2L["5b"]["Visible"] = false;
G2L["5b"]["Name"] = [[ScriptHubMenu]];

-- StarterGui.SynapseX.ScriptHubMenu.Background
G2L["5c"] = Instance.new("ImageLabel", G2L["5b"]);
G2L["5c"]["BorderSizePixel"] = 0;
G2L["5c"]["ScaleType"] = Enum.ScaleType.Tile;
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(50, 50, 50);
G2L["5c"]["Size"] = UDim2.new(0, 411, 0, 275);
G2L["5c"]["Active"] = true;
G2L["5c"]["BorderColor3"] = Color3.fromRGB(55, 55, 55);
G2L["5c"]["Name"] = [[Background]];

-- StarterGui.SynapseX.ScriptHubMenu.Background.ScrollingFrame
G2L["5d"] = Instance.new("ScrollingFrame", G2L["5c"]);
G2L["5d"]["Active"] = true;
G2L["5d"]["BorderSizePixel"] = 0;
G2L["5d"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["5d"]["TopImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];
G2L["5d"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["5d"]["Size"] = UDim2.new(0, 109, 0, 226);
G2L["5d"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5d"]["ScrollBarThickness"] = 14;
G2L["5d"]["Position"] = UDim2.new(0.020667528733611107, 0, 0.13779912889003754, 0);
G2L["5d"]["BottomImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];

-- StarterGui.SynapseX.ScriptHubMenu.Background.ScrollingFrame.Dex
G2L["5e"] = Instance.new("TextButton", G2L["5d"]);
G2L["5e"]["TextWrapped"] = true;
G2L["5e"]["BorderSizePixel"] = 0;
G2L["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5e"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["5e"]["TextSize"] = 14;
G2L["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5e"]["Size"] = UDim2.new(0, 107, 0, 18);
G2L["5e"]["Name"] = [[Dex]];
G2L["5e"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["5e"]["Text"] = [[Dex Explorer]];
G2L["5e"]["Position"] = UDim2.new(0, 1, 0, 1);
G2L["5e"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu.Background.ScrollingFrame.ScriptDumper
G2L["5f"] = Instance.new("TextButton", G2L["5d"]);
G2L["5f"]["BorderSizePixel"] = 0;
G2L["5f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5f"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["5f"]["TextSize"] = 14;
G2L["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5f"]["Size"] = UDim2.new(0, 107, 0, 18);
G2L["5f"]["Name"] = [[ScriptDumper]];
G2L["5f"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["5f"]["Text"] = [[Script Dumper]];
G2L["5f"]["Position"] = UDim2.new(0.008999999612569809, 0, 0.34637168049812317, 0);
G2L["5f"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu.Background.ScrollingFrame.RemoteSpy
G2L["60"] = Instance.new("TextButton", G2L["5d"]);
G2L["60"]["BorderSizePixel"] = 0;
G2L["60"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["60"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["60"]["TextSize"] = 14;
G2L["60"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["60"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["60"]["Size"] = UDim2.new(0, 107, 0, 18);
G2L["60"]["Name"] = [[RemoteSpy]];
G2L["60"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["60"]["Text"] = [[Remote Spy]];
G2L["60"]["Position"] = UDim2.new(0.008999999612569809, 0, 0.23982301354408264, 0);
G2L["60"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu.Background.ScrollingFrame.UnnamedESP
G2L["61"] = Instance.new("TextButton", G2L["5d"]);
G2L["61"]["BorderSizePixel"] = 0;
G2L["61"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["61"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["61"]["TextSize"] = 14;
G2L["61"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["61"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["61"]["Size"] = UDim2.new(0, 107, 0, 18);
G2L["61"]["Name"] = [[UnnamedESP]];
G2L["61"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["61"]["Text"] = [[Unnamed ESP]];
G2L["61"]["Position"] = UDim2.new(0.00917431153357029, 0, 0.11946903169155121, 0);
G2L["61"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu.Close
G2L["62"] = Instance.new("TextButton", G2L["5b"]);
G2L["62"]["BorderSizePixel"] = 0;
G2L["62"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
G2L["62"]["TextSize"] = 14;
G2L["62"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["62"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["62"]["Size"] = UDim2.new(0, 121, 0, 23);
G2L["62"]["Name"] = [[Close]];
G2L["62"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["62"]["Text"] = [[Close]];
G2L["62"]["Position"] = UDim2.new(0.6677603721618652, 0, 7.790436744689941, 0);

-- StarterGui.SynapseX.ScriptHubMenu.Title
G2L["63"] = Instance.new("TextLabel", G2L["5b"]);
G2L["63"]["TextWrapped"] = true;
G2L["63"]["ZIndex"] = 3;
G2L["63"].Draggable = true;
G2L["63"]["BorderSizePixel"] = 4;
G2L["63"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["63"]["TextSize"] = 15;
G2L["63"].Active = true;
G2L["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["63"]["Size"] = UDim2.new(0, 410, 0, 30);
G2L["63"]["Text"] = [[Synapse X - Script Hub]];
G2L["63"]["Name"] = [[Title]];
G2L["63"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.ScriptHubMenu.Description
G2L["64"] = Instance.new("TextLabel", G2L["5b"]);
G2L["64"]["TextWrapped"] = true;
G2L["64"]["BorderSizePixel"] = 0;
G2L["64"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["64"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["64"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["64"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["64"]["TextSize"] = 14;
G2L["64"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["64"]["Size"] = UDim2.new(0, 272, 0, 60);
G2L["64"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["64"]["Text"] = [[]];
G2L["64"]["Name"] = [[Description]];
G2L["64"]["Position"] = UDim2.new(0.31386861205101013, 0, 5.612903118133545, 0);

-- StarterGui.SynapseX.ScriptHubMenu.Minimize
G2L["65"] = Instance.new("TextButton", G2L["5b"]);
G2L["65"]["ZIndex"] = 3;
G2L["65"]["BorderSizePixel"] = 0;
G2L["65"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
G2L["65"]["TextSize"] = 14;
G2L["65"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["65"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["65"]["Size"] = UDim2.new(0, 21, 0, 21);
G2L["65"]["Name"] = [[Minimize]];
G2L["65"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["65"]["Text"] = [[_]];
G2L["65"]["Position"] = UDim2.new(0.9318734407424927, 0, 0.16129040718078613, 0);

-- StarterGui.SynapseX.ScriptHubMenu.Dex
G2L["66"] = Instance.new("Frame", G2L["5b"]);
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["66"]["BackgroundTransparency"] = 1;
G2L["66"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["66"]["Visible"] = false;
G2L["66"]["Name"] = [[Dex]];

-- StarterGui.SynapseX.ScriptHubMenu.Dex.Image
G2L["67"] = Instance.new("ImageLabel", G2L["66"]);
G2L["67"]["BorderSizePixel"] = 0;
G2L["67"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["67"]["Image"] = [[http://www.roblox.com/asset/?id=7070160765]];
G2L["67"]["Size"] = UDim2.new(0, 272, 0, 126);
G2L["67"]["Name"] = [[Image]];
G2L["67"]["BackgroundTransparency"] = 1;
G2L["67"]["Position"] = UDim2.new(1.283868670463562, 0, 0.38265305757522583, 0);

-- StarterGui.SynapseX.ScriptHubMenu.RemoteSpy
G2L["68"] = Instance.new("Frame", G2L["5b"]);
G2L["68"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["68"]["BackgroundTransparency"] = 1;
G2L["68"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["68"]["Visible"] = false;
G2L["68"]["Name"] = [[RemoteSpy]];

-- StarterGui.SynapseX.ScriptHubMenu.RemoteSpy.Image
G2L["69"] = Instance.new("ImageLabel", G2L["68"]);
G2L["69"]["BorderSizePixel"] = 0;
G2L["69"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["69"]["Image"] = [[http://www.roblox.com/asset/?id=7370616106]];
G2L["69"]["Size"] = UDim2.new(0, 272, 0, 126);
G2L["69"]["Name"] = [[Image]];
G2L["69"]["BackgroundTransparency"] = 1;
G2L["69"]["Position"] = UDim2.new(1.283868670463562, 0, 0.38265305757522583, 0);

-- StarterGui.SynapseX.ScriptHubMenu.UnnamedESP
G2L["6a"] = Instance.new("Frame", G2L["5b"]);
G2L["6a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6a"]["BackgroundTransparency"] = 1;
G2L["6a"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["6a"]["Visible"] = false;
G2L["6a"]["Name"] = [[UnnamedESP]];

-- StarterGui.SynapseX.ScriptHubMenu.UnnamedESP.Image
G2L["6b"] = Instance.new("ImageLabel", G2L["6a"]);
G2L["6b"]["BorderSizePixel"] = 0;
G2L["6b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6b"]["Image"] = [[http://www.roblox.com/asset/?id=7370616607]];
G2L["6b"]["Size"] = UDim2.new(0, 272, 0, 126);
G2L["6b"]["Name"] = [[Image]];
G2L["6b"]["BackgroundTransparency"] = 1;
G2L["6b"]["Position"] = UDim2.new(1.283868670463562, 0, 0.38265305757522583, 0);

-- StarterGui.SynapseX.ScriptHubMenu.ScriptDumper
G2L["6c"] = Instance.new("Frame", G2L["5b"]);
G2L["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6c"]["BackgroundTransparency"] = 1;
G2L["6c"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["6c"]["Visible"] = false;
G2L["6c"]["Name"] = [[ScriptDumper]];

-- StarterGui.SynapseX.ScriptHubMenu.ScriptDumper.Image
G2L["6d"] = Instance.new("ImageLabel", G2L["6c"]);
G2L["6d"]["BorderSizePixel"] = 0;
G2L["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6d"]["Image"] = [[http://www.roblox.com/asset/?id=7370669353]];
G2L["6d"]["Size"] = UDim2.new(0, 272, 0, 126);
G2L["6d"]["Name"] = [[Image]];
G2L["6d"]["BackgroundTransparency"] = 1;
G2L["6d"]["Position"] = UDim2.new(1.283868670463562, 0, 0.38265305757522583, 0);

-- StarterGui.SynapseX.ScriptHubMenu.Icon
G2L["6e"] = Instance.new("ImageLabel", G2L["5b"]);
G2L["6e"]["ZIndex"] = 6;
G2L["6e"]["BorderSizePixel"] = 0;
G2L["6e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6e"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["6e"]["Size"] = UDim2.new(0, 23, 0, 26);
G2L["6e"]["Name"] = [[Icon]];
G2L["6e"]["BackgroundTransparency"] = 1;
G2L["6e"]["Position"] = UDim2.new(0.00932147353887558, 0, 0.05000000074505806, 0);

-- StarterGui.SynapseX.ScriptHubMenu.Panel
G2L["6f"] = Instance.new("Frame", G2L["5b"]);
G2L["6f"]["BorderSizePixel"] = 0;
G2L["6f"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
G2L["6f"]["Size"] = UDim2.new(0, 411, 0, 30);
G2L["6f"]["Position"] = UDim2.new(0, 0, -0.009731169790029526, 0);
G2L["6f"]["Name"] = [[Panel]];

-- StarterGui.SynapseX.ScriptHubMenu.Execute
G2L["70"] = Instance.new("TextButton", G2L["5b"]);
G2L["70"]["BorderSizePixel"] = 0;
G2L["70"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
G2L["70"]["TextSize"] = 14;
G2L["70"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["70"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["70"]["Visible"] = false;
G2L["70"]["Size"] = UDim2.new(0, 121, 0, 23);
G2L["70"]["Name"] = [[Execute]];
G2L["70"]["BorderColor3"] = Color3.fromRGB(99, 150, 182);
G2L["70"]["Text"] = [[Execute]];
G2L["70"]["Position"] = UDim2.new(0.31386861205101013, 0, 7.764839172363281, 0);

-- StarterGui.SynapseX.ScriptHubMenu.ScriptHubHandler
G2L["71"] = Instance.new("LocalScript", G2L["5b"]);
G2L["71"]["Name"] = [[ScriptHubHandler]];

-- StarterGui.SynapseX.OptionMenu
G2L["72"] = Instance.new("Frame", G2L["1"]);
G2L["72"]["Active"] = true;
G2L["72"]["ZIndex"] = 5;
G2L["72"]["BorderSizePixel"] = 0;
G2L["72"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["72"]["Size"] = UDim2.new(0, 199, 0, 31);
G2L["72"]["Position"] = UDim2.new(0, 671, 0, 16);
G2L["72"]["Visible"] = false;
G2L["72"]["Name"] = [[OptionMenu]];

-- StarterGui.SynapseX.OptionMenu.Title
G2L["73"] = Instance.new("TextLabel", G2L["72"]);
G2L["73"]["ZIndex"] = 6;
G2L["73"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["73"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["73"]["TextSize"] = 14;
G2L["73"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["73"]["Size"] = UDim2.new(0, 199, 0, 26);
G2L["73"]["Text"] = [[Options]];
G2L["73"]["Name"] = [[Title]];
G2L["73"]["BackgroundTransparency"] = 1;
G2L["73"]["Position"] = UDim2.new(-0.0011280769249424338, 0, 0.07083868235349655, 0);

-- StarterGui.SynapseX.OptionMenu.FPSUnlocker
G2L["74"] = Instance.new("TextLabel", G2L["72"]);
G2L["74"]["ZIndex"] = 6;
G2L["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["74"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["74"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["74"]["TextSize"] = 14;
G2L["74"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["74"]["Size"] = UDim2.new(0, 63, 0, 16);
G2L["74"]["Text"] = 'FPS Unlock [BETA]';
G2L["74"]["Name"] = [[FPSUnlocker]];
G2L["74"]["BackgroundTransparency"] = 1;
G2L["74"]["Position"] = UDim2.new(0.35585591197013855, 0, 1.5485485792160034, 0);

-- StarterGui.SynapseX.OptionMenu.TopMost
G2L["75"] = Instance.new("TextLabel", G2L["72"]);
G2L["75"]["ZIndex"] = 6;
G2L["75"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["75"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["75"]["TextSize"] = 14;
G2L["75"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["Size"] = UDim2.new(0, 63, 0, 16);
G2L["75"]["Text"] = [[TopMost]];
G2L["75"]["Name"] = [[TopMost]];
G2L["75"]["BackgroundTransparency"] = 1;
G2L["75"]["Position"] = UDim2.new(0.35585591197013855, 0, 3.7420969009399414, 0);

-- StarterGui.SynapseX.OptionMenu.InternalUI
G2L["76"] = Instance.new("TextLabel", G2L["72"]);
G2L["76"]["ZIndex"] = 6;
G2L["76"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["76"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["76"]["TextSize"] = 14;
G2L["76"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["Size"] = UDim2.new(0, 63, 0, 16);
G2L["76"]["Text"] = [[Internal UI]];
G2L["76"]["Name"] = [[InternalUI]];
G2L["76"]["BackgroundTransparency"] = 1;
G2L["76"]["Position"] = UDim2.new(0.35585591197013855, 0, 3.0001611709594727, 0);

-- StarterGui.SynapseX.OptionMenu.Close
G2L["77"] = Instance.new("TextButton", G2L["72"]);
G2L["77"]["ZIndex"] = 6;
G2L["77"]["BorderSizePixel"] = 0;
G2L["77"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["77"]["TextSize"] = 14;
G2L["77"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["77"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["77"]["Size"] = UDim2.new(0, 178, 0, 25);
G2L["77"]["Name"] = [[Close]];
G2L["77"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["77"]["Text"] = [[Close]];
G2L["77"]["Position"] = UDim2.new(0.04838477447628975, 0, 6.747819900512695, 0);

-- StarterGui.SynapseX.OptionMenu.ToggleFPSUnlocker
G2L["78"] = Instance.new("TextButton", G2L["72"]);
G2L["78"]["TextWrapped"] = true;
G2L["78"]["ZIndex"] = 6;
G2L["78"]["BorderSizePixel"] = 0;
G2L["78"]["BackgroundColor3"] = Color3.fromRGB(167, 167, 167);
G2L["78"]["TextSize"] = 13;
G2L["78"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["78"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["78"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["78"]["Name"] = [[ToggleFPSUnlocker]];
G2L["78"]["Text"] = [[]];
G2L["78"]["Position"] = UDim2.new(0.24308274686336517, 0, 1.5808066129684448, 0);

-- StarterGui.SynapseX.OptionMenu.ToggleInternalUI
G2L["79"] = Instance.new("TextButton", G2L["72"]);
G2L["79"]["TextWrapped"] = true;
G2L["79"]["ZIndex"] = 6;
G2L["79"]["BorderSizePixel"] = 0;
G2L["79"]["BackgroundColor3"] = Color3.fromRGB(113, 113, 113);
G2L["79"]["TextSize"] = 13;
G2L["79"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["79"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["79"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["79"]["Name"] = [[ToggleInternalUI]];
G2L["79"]["Text"] = [[x]];
G2L["79"]["Position"] = UDim2.new(0.24308274686336517, 0, 3.032419204711914, 0);

-- StarterGui.SynapseX.OptionMenu.ToggleTopMost
G2L["7a"] = Instance.new("TextButton", G2L["72"]);
G2L["7a"]["TextWrapped"] = true;
G2L["7a"]["ZIndex"] = 6;
G2L["7a"]["BorderSizePixel"] = 0;
G2L["7a"]["BackgroundColor3"] = Color3.fromRGB(113, 113, 113);
G2L["7a"]["TextSize"] = 13;
G2L["7a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7a"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7a"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["7a"]["Name"] = [[ToggleTopMost]];
G2L["7a"]["Text"] = [[x]];
G2L["7a"]["Position"] = UDim2.new(0.24308274686336517, 0, 3.774354934692383, 0);

-- StarterGui.SynapseX.OptionMenu.Icon
G2L["7b"] = Instance.new("ImageLabel", G2L["72"]);
G2L["7b"]["ZIndex"] = 6;
G2L["7b"]["BorderSizePixel"] = 0;
G2L["7b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7b"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["7b"]["Size"] = UDim2.new(0, 23, 0, 26);
G2L["7b"]["Name"] = [[Icon]];
G2L["7b"]["BackgroundTransparency"] = 1;
G2L["7b"]["Position"] = UDim2.new(0.014999999664723873, 0, 0.057999998331069946, 0);

-- StarterGui.SynapseX.OptionMenu.ToggleAutoExec
G2L["7c"] = Instance.new("TextButton", G2L["72"]);
G2L["7c"]["TextWrapped"] = true;
G2L["7c"]["ZIndex"] = 6;
G2L["7c"]["BorderSizePixel"] = 0;
G2L["7c"]["BackgroundColor3"] = Color3.fromRGB(167, 167, 167);
G2L["7c"]["TextSize"] = 13;
G2L["7c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7c"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7c"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["7c"]["Name"] = [[ToggleAutoExec]];
G2L["7c"]["Text"] = [[]];
G2L["7c"]["Position"] = UDim2.new(0.24308274686336517, 0, 2.2904839515686035, 0);

-- StarterGui.SynapseX.OptionMenu.AutoExec
G2L["7d"] = Instance.new("TextLabel", G2L["72"]);
G2L["7d"]["ZIndex"] = 6;
G2L["7d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["7d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7d"]["TextSize"] = 14;
G2L["7d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7d"]["Size"] = UDim2.new(0, 63, 0, 16);
G2L["7d"]["Text"] = [[Auto Exec scripts]];
G2L["7d"]["Name"] = [[AutoExec]];
G2L["7d"]["BackgroundTransparency"] = 1;
G2L["7d"]["Position"] = UDim2.new(0.35585591197013855, 0, 2.258225917816162, 0);

-- StarterGui.SynapseX.OptionMenu.Buttons
G2L["7e"] = Instance.new("Frame", G2L["72"]);
G2L["7e"]["ZIndex"] = 6;
G2L["7e"]["BorderSizePixel"] = 0;
G2L["7e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7e"]["BackgroundTransparency"] = 1;
G2L["7e"]["Size"] = UDim2.new(0, 176, 0, 58);
G2L["7e"]["Position"] = UDim2.new(0.05500003695487976, 0, 4.516129493713379, 0);
G2L["7e"]["Name"] = [[Buttons]];

-- StarterGui.SynapseX.OptionMenu.Buttons.UIListLayout
G2L["7f"] = Instance.new("UIListLayout", G2L["7e"]);
G2L["7f"]["Padding"] = UDim.new(0, 5);
G2L["7f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- StarterGui.SynapseX.OptionMenu.Buttons.Rejoin
G2L["80"] = Instance.new("TextButton", G2L["7e"]);
G2L["80"]["ZIndex"] = 6;
G2L["80"]["BorderSizePixel"] = 0;
G2L["80"]["Modal"] = true;
G2L["80"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["80"]["TextSize"] = 14;
G2L["80"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["80"]["TextColor3"] = Color3.fromRGB(251, 251, 251);
G2L["80"]["Size"] = UDim2.new(0, 177, 0, 17);
G2L["80"]["Name"] = [[Rejoin]];
G2L["80"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["80"]["Text"] = [[Rejoin]];
G2L["80"]["Position"] = UDim2.new(0.054999999701976776, 0, 5.838741779327393, 0);

-- StarterGui.SynapseX.OptionMenu.Buttons.Discord
G2L["81"] = Instance.new("TextButton", G2L["7e"]);
G2L["81"]["ZIndex"] = 6;
G2L["81"]["BorderSizePixel"] = 0;
G2L["81"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["81"]["TextSize"] = 14;
G2L["81"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["81"]["TextColor3"] = Color3.fromRGB(251, 251, 251);
G2L["81"]["Size"] = UDim2.new(0, 177, 0, 17);
G2L["81"]["Name"] = [[Discord]];
G2L["81"]["BorderColor3"] = Color3.fromRGB(0, 231, 255);
G2L["81"]["Text"] = [[Discord]];
G2L["81"]["Position"] = UDim2.new(0.054999999701976776, 0, 5.838741779327393, 0);

-- StarterGui.SynapseX.OptionMenu.MainFrame
G2L["82"] = Instance.new("Frame", G2L["72"]);
G2L["82"]["ZIndex"] = 5;
G2L["82"]["BorderSizePixel"] = 0;
G2L["82"]["BackgroundColor3"] = Color3.fromRGB(52, 52, 52);
G2L["82"]["Size"] = UDim2.new(0, 199, 0, 211);
G2L["82"]["Position"] = UDim2.new(0, 0, 0.988335907459259, 0);
G2L["82"]["Name"] = [[MainFrame]];

-- StarterGui.SynapseX.OptionMenu.Optionhandler
G2L["83"] = Instance.new("LocalScript", G2L["72"]);
G2L["83"]["Name"] = [[Optionhandler]];

-- StarterGui.SynapseX.GetSavedScripts
G2L["84"] = Instance.new("LocalScript", G2L["1"]);
G2L["84"]["Name"] = [[GetSavedScripts]];

-- StarterGui.SynapseX.Injected
G2L["85"] = Instance.new("BoolValue", G2L["1"]);
G2L["85"]["Name"] = [[Injected]];

-- StarterGui.SynapseX.Module
G2L["86"] = Instance.new("ModuleScript", G2L["1"]);
G2L["86"]["Name"] = [[Module]];

-- StarterGui.SynapseX.Module.RClick
G2L["87"] = Instance.new("Frame", G2L["86"]);
G2L["87"]["ZIndex"] = 7;
G2L["87"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44);
G2L["87"]["Size"] = UDim2.new(0, 94, 0, 63);
G2L["87"]["BorderColor3"] = Color3.fromRGB(119, 119, 119);
G2L["87"]["Position"] = UDim2.new(-0.0146878557279706, 0, 1.0666667222976685, 0);
G2L["87"]["Visible"] = false;
G2L["87"]["Name"] = [[RClick]];

-- StarterGui.SynapseX.Module.RClick.Execute
G2L["88"] = Instance.new("TextButton", G2L["87"]);
G2L["88"]["ZIndex"] = 7;
G2L["88"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44);
G2L["88"]["TextSize"] = 14;
G2L["88"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["88"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["88"]["Size"] = UDim2.new(0, 93, 0, 21);
G2L["88"]["Name"] = [[Execute]];
G2L["88"]["BorderColor3"] = Color3.fromRGB(119, 119, 119);
G2L["88"]["Text"] = [[Execute]];
G2L["88"]["Position"] = UDim2.new(0.005026959348469973, 0, 0, 0);

-- StarterGui.SynapseX.Module.RClick.Load
G2L["89"] = Instance.new("TextButton", G2L["87"]);
G2L["89"]["ZIndex"] = 7;
G2L["89"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44);
G2L["89"]["TextSize"] = 14;
G2L["89"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["89"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["89"]["Size"] = UDim2.new(0, 93, 0, 21);
G2L["89"]["Name"] = [[Load]];
G2L["89"]["BorderColor3"] = Color3.fromRGB(119, 119, 119);
G2L["89"]["Text"] = [[Load into Editor]];
G2L["89"]["Position"] = UDim2.new(0.005026959348469973, 0, 0.3174603283405304, 0);

-- StarterGui.SynapseX.Module.RClick.Delete
G2L["8a"] = Instance.new("TextButton", G2L["87"]);
G2L["8a"]["ZIndex"] = 7;
G2L["8a"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44);
G2L["8a"]["TextSize"] = 14;
G2L["8a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["8a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8a"]["Size"] = UDim2.new(0, 93, 0, 21);
G2L["8a"]["Name"] = [[Delete]];
G2L["8a"]["BorderColor3"] = Color3.fromRGB(119, 119, 119);
G2L["8a"]["Text"] = [[Delete]];
G2L["8a"]["Position"] = UDim2.new(0.005026959348469973, 0, 0.6666666865348816, 0);

-- StarterGui.SynapseX.OpenScript
G2L["8b"] = Instance.new("Frame", G2L["1"]);
G2L["8b"]["Active"] = true;
G2L["8b"]["ZIndex"] = 10;
G2L["8b"]["BorderSizePixel"] = 0;
G2L["8b"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
G2L["8b"]["Size"] = UDim2.new(0, 322, 0, 81);
G2L["8b"]["Position"] = UDim2.new(0.2866109609603882, 0, 0.5302865505218506, 0);
G2L["8b"]["Visible"] = false;
G2L["8b"]["Name"] = [[OpenScript]];

-- StarterGui.SynapseX.OpenScript.scriptname
G2L["8c"] = Instance.new("TextBox", G2L["8b"]);
G2L["8c"]["ZIndex"] = 11;
G2L["8c"]["BorderSizePixel"] = 0;
G2L["8c"]["TextSize"] = 14;
G2L["8c"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["8c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["8c"]["PlaceholderText"] = [[File Name]];
G2L["8c"]["Size"] = UDim2.new(0, 317, 0, 22);
G2L["8c"]["Text"] = [[]];
G2L["8c"]["Position"] = UDim2.new(0, 3, 0, 32);
G2L["8c"]["Name"] = [[scriptname]];

-- StarterGui.SynapseX.OpenScript.savescript
G2L["8d"] = Instance.new("TextButton", G2L["8b"]);
G2L["8d"]["ZIndex"] = 11;
G2L["8d"]["BorderSizePixel"] = 0;
G2L["8d"]["BackgroundColor3"] = Color3.fromRGB(46, 46, 46);
G2L["8d"]["TextSize"] = 14;
G2L["8d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["8d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["Size"] = UDim2.new(0, 317, 0, 19);
G2L["8d"]["Name"] = [[savescript]];
G2L["8d"]["Text"] = [[Open FIle]];
G2L["8d"]["Position"] = UDim2.new(0, 3, 0, 56);

-- StarterGui.SynapseX.OpenScript.Icon
G2L["8e"] = Instance.new("ImageLabel", G2L["8b"]);
G2L["8e"]["ZIndex"] = 11;
G2L["8e"]["BorderSizePixel"] = 0;
G2L["8e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8e"]["Image"] = [[http://www.roblox.com/asset/?id=9483813933]];
G2L["8e"]["Size"] = UDim2.new(0, 48, 0, 23);
G2L["8e"]["Name"] = [[Icon]];
G2L["8e"]["BackgroundTransparency"] = 1;
G2L["8e"]["Position"] = UDim2.new(0.008999999612569809, 0, 0.05000000074505806, 0);

-- StarterGui.SynapseX.OpenScript.Icon.UIAspectRatioConstraint
G2L["8f"] = Instance.new("UIAspectRatioConstraint", G2L["8e"]);
G2L["8f"]["AspectRatio"] = 0.8846153616905212;

-- StarterGui.SynapseX.OpenScript.Title
G2L["90"] = Instance.new("TextLabel", G2L["8b"]);
G2L["90"]["TextWrapped"] = true;
G2L["90"]["ZIndex"] = 11;
G2L["90"]["BorderSizePixel"] = 4;
G2L["90"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["90"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["90"]["TextSize"] = 15;
G2L["90"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["90"]["Size"] = UDim2.new(0, 322, 0, 30);
G2L["90"]["Active"] = true;
G2L["90"]["Text"] = [[Synapse X - Open FIle]];
G2L["90"]["Name"] = [[Title]];
G2L["90"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.OpenScript.Close
G2L["91"] = Instance.new("TextButton", G2L["8b"]);
G2L["91"]["TextWrapped"] = true;
G2L["91"]["ZIndex"] = 12;
G2L["91"]["BackgroundColor3"] = Color3.fromRGB(0, 55, 81);
G2L["91"]["TextSize"] = 17;
G2L["91"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["91"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["91"]["Selectable"] = false;
G2L["91"]["Size"] = UDim2.new(0, 26, 0, 26);
G2L["91"]["Name"] = [[Close]];
G2L["91"]["Text"] = [[x]];
G2L["91"]["Position"] = UDim2.new(0.9130434989929199, 0, 0.024690981954336166, 0);
G2L["91"]["BackgroundTransparency"] = 1;

-- StarterGui.SynapseX.OpenScript.Handler
G2L["92"] = Instance.new("LocalScript", G2L["8b"]);
G2L["92"]["Name"] = [[Handler]];

-- StarterGui.SynapseX.SetDraggable
G2L["93"] = Instance.new("LocalScript", G2L["1"]);
G2L["93"]["Name"] = [[SetDraggable]];

-- StarterGui.SynapseX.Highlighter
G2L["94"] = Instance.new("ModuleScript", G2L["1"]);
G2L["94"]["Name"] = [[Highlighter]];

-- StarterGui.SynapseX.Highlighter.lexer
G2L["95"] = Instance.new("ModuleScript", G2L["94"]);
G2L["95"]["Name"] = [[lexer]];

-- StarterGui.SynapseX.Highlighter.lexer.language
G2L["96"] = Instance.new("ModuleScript", G2L["95"]);
G2L["96"]["Name"] = [[language]];

-- Require G2L wrapper
local G2L_REQUIRE = require;
local G2L_MODULES = {};
local function require(Module:ModuleScript)
    local ModuleState = G2L_MODULES[Module];
    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true;
            ModuleState.Value = ModuleState.Closure();
        end
        return ModuleState.Value;
    end;
    return G2L_REQUIRE(Module);
end

G2L_MODULES[G2L["86"]] = {
Closure = function()
    local script = G2L["86"];
local module = {}
local highlighter = require(script.Parent.Highlighter)

function module:AddTab(title, source)
	local NewTextbox = script.Parent.Main.MainFunc.Needs.Textbox:Clone()
	local NewTab = script.Parent.Main.MainFunc.Needs.Tab:Clone()
	local num = 0

	NewTextbox.Parent = script.Parent.Main.MainFunc.Textboxes
	NewTab.Parent=  script.Parent.Main.ScriptTab.Tabs
	NewTab.Visible = true
	NewTextbox.Visible = true
	NewTab.BackgroundColor3 = Color3.fromRGB(80,80,80)
	highlighter.highlight({
		textObject = NewTextbox.Frame.Textbox,
		src = NewTextbox.Frame.Textbox.Text,
		forceUpdate = true
	})

    NewTab.MouseButton1Up:Connect(function()
        
        -- Set any textbox except new disabled (not visible)
	for _,tabs in pairs(script.Parent.Main.MainFunc.Textboxes:GetChildren()) do
		if tabs.Name ~= NewTextbox.Name then
			tabs.Visible = false
		elseif tabs.Name == NewTextbox.Name then
			tabs.Visible = true
			end
	end

	-- Set any Tab color back except this
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("TextButton") and v.Name ~= NewTab.Name then
			v.BackgroundColor3 = Color3.fromRGB(100,100,100)
		end
	end
    
    end)
    NewTab:FindFirstChild("Remove").MouseButton1Up:Connect(function()

        NewTab:Destroy()
		

    end)

	-- Set da name as yes
	for i,v in pairs(script.Parent.Main.MainFunc.Textboxes:GetChildren()) do
		num += 1
	end
	if type(title) == "string" then
		NewTab.Name = '  '..title
		NewTab.Text = '  '..title
		NewTextbox.Name = '  '..title
		NewTextbox.Frame.Textbox.Text = source
	else
		NewTab.Name = "  Script "..tostring(num)
		NewTab.Text = "  Script "..tostring(num)
		NewTextbox.Name = "  Script "..tostring(num)
	end

	-- Set any textbox except new disabled (not visible)
	for _,tabs in pairs(script.Parent.Main.MainFunc.Textboxes:GetChildren()) do
		if tabs.Name ~= NewTextbox.Name then
			tabs.Visible = false
		end
	end

	-- Set any Tab color back except this
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("TextButton") and v.Name ~= NewTab.Name then
			v.BackgroundColor3 = Color3.fromRGB(100,100,100)
		end
	end
end

function module:GetActiveTextbox()
	for _, textbox in pairs(script.Parent.Main.MainFunc.Textboxes:GetChildren()) do
		if textbox.Visible then
			return textbox
		end
	end
end

function module:AddScriptTabSave(name, source)
	local Button = script.Parent.Main.MainFunc.Needs.ScriptHubButton:Clone()
	local click = false
	Button.Parent = script.Parent.Main.MainFunc.ScriptHub
	Button.Text = name
	Button.Visible = true

	Button.MouseButton1Up:Connect(function()
		if not click then
			click = true
			wait(0.5) -- Adjust this delay if needed
			if click then
				module:AddTab(name, source)
			end
			click = false
		end
	end)
	Button.MouseButton2Up:Connect(function()
		local rclick = script.RClick:Clone()
		rclick.Visible = true
		rclick.Parent = Button
		rclick.MouseEnter:Connect(function()
			rclick.Execute.MouseButton1Up:Connect(function()
				loadstring(source)()
			end)
			rclick.Load.MouseButton1Up:Connect(function()
				module:AddTab(name, source)
			end)
			rclick.Delete.MouseButton1Up:Connect(function()
				rclick.Parent:Destroy()
			end)
			rclick.MouseLeave:Connect(function()
				rclick:Destroy()
			end)
		end)
	end)
end

return module

end;
};
G2L_MODULES[G2L["94"]] = {
Closure = function()
    local script = G2L["94"];
export type HighlighterColors = { [string]: Color3 }

export type TextObject = TextLabel | TextBox

export type HighlightProps = {
	textObject: TextObject,
	src: string?,
	forceUpdate: boolean?,
	lexer: Lexer?,
	customLang: { [string]: string }?
}

export type Lexer = {
	scan: (src: string) -> () -> (string, string),
	navigator: () -> any,
	finished: boolean?,
}

export type Highlighter = {
	defaultLexer: Lexer,
	setTokenColors: (colors: HighlighterColors?) -> (),
	highlight: (props: HighlightProps) -> (() -> ())?,
	refresh: () -> (),
}

export type ObjectData = {
	Text: string,
	Labels: { TextLabel },
	Lines: { string },
	Lexer: Lexer?,
	CustomLang: { [string]: string }?,
}

local function SanitizeRichText(s: string): string
	return string.gsub(
		string.gsub(string.gsub(string.gsub(string.gsub(s, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), '"', "&quot;"),
		"'",
		"&apos;"
	)
end

local function SanitizeTabs(s: string): string
	return string.gsub(s, "\t", "    ")
end

local function SanitizeControl(s: string): string
	return string.gsub(s, "[\0\1\2\3\4\5\6\7\8\11\12\13\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31]+", "")
end

local TokenColors: HighlighterColors = {
	["background"] = Color3.fromRGB(41, 41, 41),
	["iden"] = Color3.fromRGB(234, 234, 234),
	["keyword"] = Color3.fromRGB(215, 174, 255),
	["builtin"] = Color3.fromRGB(131, 206, 255),
	["string"] = Color3.fromRGB(196, 255, 193),
	["number"] = Color3.fromRGB(255, 125, 125),
	["comment"] = Color3.fromRGB(140, 140, 155),
	["operator"] = Color3.fromRGB(255, 239, 148),
	["custom"] = Color3.fromRGB(119, 122, 255),
}
local ColorFormatter: { [Color3]: string } = {}
local LastData: { [TextObject]: ObjectData } = {}
local Cleanups: { [TextObject]: () -> () } = {}

local Highlighter = {
	defaultLexer = require(script.lexer),
}

function Highlighter.highlight(props: HighlightProps)
	-- Gather props
	local textObject = props.textObject
	local src = SanitizeTabs(SanitizeControl(props.src or textObject.Text))
	local lexer = props.lexer or Highlighter.defaultLexer
	local customLang = props.customLang
	local forceUpdate = props.forceUpdate

	-- Avoid updating when unnecessary
	local data = LastData[textObject]
	if data == nil then
		data = {
			Text = "",
			Labels = {},
			Lines = {},
			Lexer = lexer,
			CustomLang = customLang,
		}
		LastData[textObject] = data
	elseif forceUpdate ~= true and data.Text == src then
		return
	end

	local lineLabels = data.Labels
	local previousLines = data.Lines

	local lines = string.split(src, "\n")

	data.Lines = lines
	data.Text = src
	data.Lexer = lexer
	data.CustomLang = customLang

	-- Ensure valid object properties
	textObject.RichText = false
	textObject.Text = src
	textObject.TextXAlignment = Enum.TextXAlignment.Left
	textObject.TextYAlignment = Enum.TextYAlignment.Top
	textObject.BackgroundColor3 = TokenColors.background
	textObject.TextColor3 = TokenColors.iden
	textObject.TextTransparency = 0.5

	-- Build the highlight labels
	local lineFolder = textObject:FindFirstChild("SyntaxHighlights")
	if lineFolder == nil then
		local newLineFolder = Instance.new("Folder")
		newLineFolder.Name = "SyntaxHighlights"
		newLineFolder.Parent = textObject

		lineFolder = newLineFolder
	end

	-- Add a cleanup handler for this textObject
	local cleanup = Cleanups[textObject]
	if not cleanup then
		local connections: { RBXScriptConnection } = {}
		local function newCleanup()
			for _, label in ipairs(lineLabels) do
				label:Destroy()
			end
			table.clear(lineLabels)
			lineLabels = nil

			LastData[textObject] = nil
			Cleanups[textObject] = nil

			for _, connection in connections do
				connection:Disconnect()
			end
			table.clear(connections)
			connections = nil
		end
		Cleanups[textObject] = newCleanup
		cleanup = newCleanup

		table.insert(
			connections,
			textObject.AncestryChanged:Connect(function()
				if textObject.Parent then
					return
				end

				cleanup()
			end)
		)
		table.insert(
			connections,
			textObject:GetPropertyChangedSignal("TextBounds"):Connect(function()
				Highlighter.highlight({
					textObject = textObject,
					forceUpdate = true,
					lexer = lexer,
					customLang = customLang,
				})
			end)
		)
		table.insert(
			connections,
			textObject:GetPropertyChangedSignal("Text"):Connect(function()
				Highlighter.highlight({
					textObject = textObject,
					lexer = lexer,
					customLang = customLang,
				})
			end)
		)
		table.insert(
			connections,
			textObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				Highlighter.highlight({
					textObject = textObject,
					forceUpdate = true,
					lexer = lexer,
					customLang = customLang,
				})
			end)
		)
	end

	-- Shortcut empty labels
	if src == "" then
		for l=1, #lineLabels do
			if lineLabels[l].Text == "" then continue end
			lineLabels[l].Text = ""
		end
		return cleanup
	end

	-- Wait for TextBounds to be non-NaN and non-zero because Roblox
	local textBounds = textObject.TextBounds
	while (textBounds.Y ~= textBounds.Y) or (textBounds.Y < 1) do
		task.wait()
		textBounds = textObject.TextBounds
	end

	if LastData[textObject] == nil then
		-- Got cleaned up while we were waiting
		return cleanup
	end

	local numLines = #lines
	local textHeight = textBounds.Y / numLines * textObject.LineHeight

	local richText, index, lineNumber = table.create(5), 0, 1
	for token: string, content: string in lexer.scan(src) do
		local Color =
			if customLang and customLang[content] then
				TokenColors["custom"]
			else
				TokenColors[token] or TokenColors["iden"]

		local tokenLines = string.split(SanitizeRichText(content), "\n")

		for l, line in ipairs(tokenLines) do
			-- Find line label
			local lineLabel = lineLabels[lineNumber]
			if not lineLabel then
				local newLabel = Instance.new("TextLabel")
				newLabel.Name = "Line_" .. lineNumber
				newLabel.RichText = true
				newLabel.BackgroundTransparency = 1
				newLabel.ZIndex = 4
				newLabel.Text = ""
				newLabel.TextXAlignment = Enum.TextXAlignment.Left
				newLabel.TextYAlignment = Enum.TextYAlignment.Top
				newLabel.Parent = lineFolder
				lineLabels[lineNumber] = newLabel
				lineLabel = newLabel
			end

			-- Align line label
			lineLabel.TextColor3 = TokenColors["iden"]
			lineLabel.Font = textObject.Font
			lineLabel.TextSize = textObject.TextSize
			lineLabel.Size = UDim2.new(1, 0, 0, math.ceil(textHeight))
			lineLabel.Position = UDim2.fromScale(0, textHeight * (lineNumber - 1) / textObject.AbsoluteSize.Y)

			-- If multiline token, then set line & move to next
			if l > 1 then
				if forceUpdate or lines[lineNumber] ~= previousLines[lineNumber] then
					-- Set line
					lineLabels[lineNumber].Text = table.concat(richText)
				end
				-- Move to next line
				lineNumber += 1
				index = 0
				table.clear(richText)
			end

			-- If changed, add token to line
			if forceUpdate or lines[lineNumber] ~= previousLines[lineNumber] then
				index += 1
				-- Only add RichText tags when the color is non-default and the characters are non-whitespace
				if Color ~= TokenColors["iden"] and string.find(line, "[%S%C]") then
					richText[index] = string.format(ColorFormatter[Color], line)
				else
					richText[index] = line
				end
			end
		end
	end

	-- Set final line
	if richText[1] and lineLabels[lineNumber] then
		lineLabels[lineNumber].Text = table.concat(richText)
	end

	-- Clear unused line labels
	for l=lineNumber+1, #lineLabels do
		if lineLabels[l].Text == "" then continue end
		lineLabels[l].Text = ""
	end

	return cleanup
end

function Highlighter.refresh(): ()
	-- Rehighlight existing labels using latest colors
	for textObject, data in pairs(LastData) do
		for _, lineLabel in ipairs(data.Labels) do
			lineLabel.TextColor3 = TokenColors["iden"]
		end

		Highlighter.highlight({
			textObject = textObject,
			forceUpdate = true,
			src = data.Text,
			lexer = data.Lexer,
			customLang = data.CustomLang,
		})
	end
end

function Highlighter.setTokenColors(colors: HighlighterColors)
	for token, color in colors do
		TokenColors[token] = color
		ColorFormatter[color] = string.format(
			'<font color="#%.2x%.2x%.2x">',
			color.R * 255,
			color.G * 255,
			color.B * 255
		) .. "%s</font>"
	end

	Highlighter.refresh()
end
Highlighter.setTokenColors(TokenColors)

return Highlighter :: Highlighter

end;
};
G2L_MODULES[G2L["95"]] = {
Closure = function()
    local script = G2L["95"];
--[=[
	Lexical scanner for creating a sequence of tokens from Lua source code.
	This is a heavily modified and Roblox-optimized version of
	the original Penlight Lexer module:
		https://github.com/stevedonovan/Penlight
	Authors:
		stevedonovan <https://github.com/stevedonovan> ----------- Original Penlight lexer author
		ryanjmulder <https://github.com/ryanjmulder> ------------- Penlight lexer contributer
		mpeterv <https://github.com/mpeterv> --------------------- Penlight lexer contributer
		Tieske <https://github.com/Tieske> ----------------------- Penlight lexer contributer
		boatbomber <https://github.com/boatbomber> --------------- Roblox port, added builtin token,
		                                                           added patterns for incomplete syntax, bug fixes,
		                                                           behavior changes, token optimization, thread optimization
		                                                           Added lexer.navigator() for non-sequential reads
		Sleitnick <https://github.com/Sleitnick> ----------------- Roblox optimizations
		howmanysmall <https://github.com/howmanysmall> ----------- Lua + Roblox optimizations

	List of possible tokens:
		- iden
		- keyword
		- builtin
		- string
		- number
		- comment
		- operator
--]=]

local lexer = {}

local Prefix, Suffix, Cleaner = "^[%c%s]*", "[%c%s]*", "[%c%s]+"
local UNICODE = "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]+"
local NUMBER_A = "0[xX][%da-fA-F_]+"
local NUMBER_B = "0[bB][01_]+"
local NUMBER_C = "%d+%.?%d*[eE][%+%-]?%d+"
local NUMBER_D = "%d+[%._]?[%d_eE]*"
local OPERATORS = "[:;<>/~%*%(%)%-={},%.#%^%+%%]+"
local BRACKETS = "[%[%]]+" -- needs to be separate pattern from other operators or it'll mess up multiline strings
local IDEN = "[%a_][%w_]*"
local STRING_EMPTY = "(['\"])%1" --Empty String
local STRING_PLAIN = "(['\"])[^\n]-([^\\]%1)" --TODO: Handle escaping escapes
local STRING_INTER = "`[^\n]-`"
local STRING_INCOMP_A = "(['\"]).-\n" --Incompleted String with next line
local STRING_INCOMP_B = "(['\"])[^\n]*" --Incompleted String without next line
local STRING_MULTI = "%[(=*)%[.-%]%1%]" --Multiline-String
local STRING_MULTI_INCOMP = "%[=*%[.-.*" --Incompleted Multiline-String
local COMMENT_MULTI = "%-%-%[(=*)%[.-%]%1%]" --Completed Multiline-Comment
local COMMENT_MULTI_INCOMP = "%-%-%[=*%[.-.*" --Incompleted Multiline-Comment
local COMMENT_PLAIN = "%-%-.-\n" --Completed Singleline-Comment
local COMMENT_INCOMP = "%-%-.*" --Incompleted Singleline-Comment
-- local TYPED_VAR = ":%s*([%w%?%| \t]+%s*)" --Typed variable, parameter, function

local lang = require(script.language)
local lua_keyword = lang.keyword
local lua_builtin = lang.builtin
local lua_libraries = lang.libraries

lexer.language = lang

local lua_matches = {
	-- Indentifiers
	{ Prefix .. IDEN .. Suffix, "var" },

	-- Numbers
	{ Prefix .. NUMBER_A .. Suffix, "number" },
	{ Prefix .. NUMBER_B .. Suffix, "number" },
	{ Prefix .. NUMBER_C .. Suffix, "number" },
	{ Prefix .. NUMBER_D .. Suffix, "number" },

	-- Strings
	{ Prefix .. STRING_EMPTY .. Suffix, "string" },
	{ Prefix .. STRING_PLAIN .. Suffix, "string" },
	{ Prefix .. STRING_INCOMP_A .. Suffix, "string" },
	{ Prefix .. STRING_INCOMP_B .. Suffix, "string" },
	{ Prefix .. STRING_MULTI .. Suffix, "string" },
	{ Prefix .. STRING_MULTI_INCOMP .. Suffix, "string" },
	{ Prefix .. STRING_INTER .. Suffix, "string_inter" },

	-- Comments
	{ Prefix .. COMMENT_MULTI .. Suffix, "comment" },
	{ Prefix .. COMMENT_MULTI_INCOMP .. Suffix, "comment" },
	{ Prefix .. COMMENT_PLAIN .. Suffix, "comment" },
	{ Prefix .. COMMENT_INCOMP .. Suffix, "comment" },

	-- Operators
	{ Prefix .. OPERATORS .. Suffix, "operator" },
	{ Prefix .. BRACKETS .. Suffix, "operator" },

	-- Unicode
	{ Prefix .. UNICODE .. Suffix, "iden" },

	-- Unknown
	{ "^.", "iden" },
}

-- To reduce the amount of table indexing during lexing, we separate the matches now
local PATTERNS, TOKENS = {}, {}
for i, m in lua_matches do
	PATTERNS[i] = m[1]
	TOKENS[i] = m[2]
end

--- Create a plain token iterator from a string.
-- @tparam string s a string.

function lexer.scan(s: string)
	local index = 1
	local size = #s
	local previousContent1, previousContent2, previousContent3, previousToken = "", "", "", ""

	local thread = coroutine.create(function()
		while index <= size do
			local matched = false
			for tokenType, pattern in ipairs(PATTERNS) do
				-- Find match
				local start, finish = string.find(s, pattern, index)
				if start == nil then continue end

				-- Move head
				index = finish + 1
				matched = true

				-- Gather results
				local content = string.sub(s, start, finish)
				local rawToken = TOKENS[tokenType]
				local processedToken = rawToken

				-- Process token
				if rawToken == "var" then
					-- Since we merge spaces into the tok, we need to remove them
					-- in order to check the actual word it contains
					local cleanContent = string.gsub(content, Cleaner, "")

					if lua_keyword[cleanContent] then
						processedToken = "keyword"
					elseif lua_builtin[cleanContent] then
						processedToken = "builtin"
					elseif string.find(previousContent1, "%.[%s%c]*$") and previousToken ~= "comment" then
						-- The previous was a . so we need to special case indexing things
						local parent = string.gsub(previousContent2, Cleaner, "")
						local lib = lua_libraries[parent]
						if lib and lib[cleanContent] and not string.find(previousContent3, "%.[%s%c]*$") then
							-- Indexing a builtin lib with existing item, treat as a builtin
							processedToken = "builtin"
						else
							-- Indexing a non builtin, can't be treated as a keyword/builtin
							processedToken = "iden"
						end
						-- print("indexing",parent,"with",cleanTok,"as",t2)
					else
						processedToken = "iden"
					end
				elseif rawToken == "string_inter" then
					if not string.find(content, "[^\\]{") then
						-- This inter string doesnt actually have any inters
						processedToken = "string"
					else
						-- We're gonna do our own yields, so the main loop won't need to
						-- Our yields will be a mix of string and whatever is inside the inters
						processedToken = nil

						local isString = true
						local subIndex = 1
						local subSize = #content
						while subIndex <= subSize do
							-- Find next brace
							local subStart, subFinish = string.find(content, "^.-[^\\][{}]", subIndex)
							if subStart == nil then
								-- No more braces, all string
								coroutine.yield("string", string.sub(content, subIndex))
								break
							end

							if isString then
								-- We are currently a string
								subIndex = subFinish + 1
								coroutine.yield("string", string.sub(content, subStart, subFinish))

								-- This brace opens code
								isString = false
							else
								-- We are currently in code
								subIndex = subFinish
								local subContent = string.sub(content, subStart, subFinish-1)
								for innerToken, innerContent in lexer.scan(subContent) do
									coroutine.yield(innerToken, innerContent)
								end

								-- This brace opens string/closes code
								isString = true
							end
						end
					end
				end

				-- Record last 3 tokens for the indexing context check
				previousContent3 = previousContent2
				previousContent2 = previousContent1
				previousContent1 = content
				previousToken = processedToken or rawToken
				if processedToken then
					coroutine.yield(processedToken, content)
				end
				break
			end

			-- No matches found
			if not matched then
				return
			end
		end

		-- Completed the scan
		return
	end)

	return function()
		if coroutine.status(thread) == "dead" then
			return
		end

		local success, token, content = coroutine.resume(thread)
		if success and token then
			return token, content
		end

		return
	end
end

function lexer.navigator()
	local nav = {
		Source = "",
		TokenCache = table.create(50),

		_RealIndex = 0,
		_UserIndex = 0,
		_ScanThread = nil,
	}

	function nav:Destroy()
		self.Source = nil
		self._RealIndex = nil
		self._UserIndex = nil
		self.TokenCache = nil
		self._ScanThread = nil
	end

	function nav:SetSource(SourceString)
		self.Source = SourceString

		self._RealIndex = 0
		self._UserIndex = 0
		table.clear(self.TokenCache)

		self._ScanThread = coroutine.create(function()
			for Token, Src in lexer.scan(self.Source) do
				self._RealIndex += 1
				self.TokenCache[self._RealIndex] = { Token, Src }
				coroutine.yield(Token, Src)
			end
		end)
	end

	function nav.Next()
		nav._UserIndex += 1

		if nav._RealIndex >= nav._UserIndex then
			-- Already scanned, return cached
			return table.unpack(nav.TokenCache[nav._UserIndex])
		else
			if coroutine.status(nav._ScanThread) == "dead" then
				-- Scan thread dead
				return
			else
				local success, token, src = coroutine.resume(nav._ScanThread)
				if success and token then
					-- Scanned new data
					return token, src
				else
					-- Lex completed
					return
				end
			end
		end
	end

	function nav.Peek(PeekAmount)
		local GoalIndex = nav._UserIndex + PeekAmount

		if nav._RealIndex >= GoalIndex then
			-- Already scanned, return cached
			if GoalIndex > 0 then
				return table.unpack(nav.TokenCache[GoalIndex])
			else
				-- Invalid peek
				return
			end
		else
			if coroutine.status(nav._ScanThread) == "dead" then
				-- Scan thread dead
				return
			else
				local IterationsAway = GoalIndex - nav._RealIndex

				local success, token, src = nil, nil, nil

				for _ = 1, IterationsAway do
					success, token, src = coroutine.resume(nav._ScanThread)
					if not (success or token) then
						-- Lex completed
						break
					end
				end

				return token, src
			end
		end
	end

	return nav
end

return lexer

end;
};
G2L_MODULES[G2L["96"]] = {
Closure = function()
    local script = G2L["96"];
local language = {
	keyword = {
		["and"] = "keyword",
		["break"] = "keyword",
		["continue"] = "keyword",
		["do"] = "keyword",
		["else"] = "keyword",
		["elseif"] = "keyword",
		["end"] = "keyword",
		["export"] = "keyword",
		["false"] = "keyword",
		["for"] = "keyword",
		["function"] = "keyword",
		["if"] = "keyword",
		["in"] = "keyword",
		["local"] = "keyword",
		["nil"] = "keyword",
		["not"] = "keyword",
		["or"] = "keyword",
		["repeat"] = "keyword",
		["return"] = "keyword",
		["self"] = "keyword",
		["then"] = "keyword",
		["true"] = "keyword",
		["type"] = "keyword",
		["typeof"] = "keyword",
		["until"] = "keyword",
		["while"] = "keyword",
	},

	builtin = {
		-- Luau Functions
		["assert"] = "function",
		["error"] = "function",
		["getfenv"] = "function",
		["getmetatable"] = "function",
		["ipairs"] = "function",
		["loadstring"] = "function",
		["newproxy"] = "function",
		["next"] = "function",
		["pairs"] = "function",
		["pcall"] = "function",
		["print"] = "function",
		["rawequal"] = "function",
		["rawget"] = "function",
		["rawlen"] = "function",
		["rawset"] = "function",
		["select"] = "function",
		["setfenv"] = "function",
		["setmetatable"] = "function",
		["tonumber"] = "function",
		["tostring"] = "function",
		["unpack"] = "function",
		["xpcall"] = "function",

		-- Luau Functions (Deprecated)
		["collectgarbage"] = "function",

		-- Luau Variables
		["_G"] = "table",
		["_VERSION"] = "string",

		-- Luau Tables
		["bit32"] = "table",
		["coroutine"] = "table",
		["debug"] = "table",
		["math"] = "table",
		["os"] = "table",
		["string"] = "table",
		["table"] = "table",
		["utf8"] = "table",

		-- Roblox Functions
		["DebuggerManager"] = "function",
		["delay"] = "function",
		["gcinfo"] = "function",
		["PluginManager"] = "function",
		["require"] = "function",
		["settings"] = "function",
		["spawn"] = "function",
		["tick"] = "function",
		["time"] = "function",
		["UserSettings"] = "function",
		["wait"] = "function",
		["warn"] = "function",

		-- Roblox Functions (Deprecated)
		["Delay"] = "function",
		["ElapsedTime"] = "function",
		["elapsedTime"] = "function",
		["printidentity"] = "function",
		["Spawn"] = "function",
		["Stats"] = "function",
		["stats"] = "function",
		["Version"] = "function",
		["version"] = "function",
		["Wait"] = "function",
		["ypcall"] = "function",

		-- Roblox Variables
		["game"] = "Instance",
		["plugin"] = "Instance",
		["script"] = "Instance",
		["shared"] = "Instance",
		["workspace"] = "Instance",

		-- Roblox Variables (Deprecated)
		["Game"] = "Instance",
		["Workspace"] = "Instance",

		-- Roblox Tables
		["Axes"] = "table",
		["BrickColor"] = "table",
		["CatalogSearchParams"] = "table",
		["CFrame"] = "table",
		["Color3"] = "table",
		["ColorSequence"] = "table",
		["ColorSequenceKeypoint"] = "table",
		["DateTime"] = "table",
		["DockWidgetPluginGuiInfo"] = "table",
		["Enum"] = "table",
		["Faces"] = "table",
		["FloatCurveKey"] = "table",
		["Font"] = "table",
		["Instance"] = "table",
		["NumberRange"] = "table",
		["NumberSequence"] = "table",
		["NumberSequenceKeypoint"] = "table",
		["OverlapParams"] = "table",
		["PathWaypoint"] = "table",
		["PhysicalProperties"] = "table",
		["Random"] = "table",
		["Ray"] = "table",
		["RaycastParams"] = "table",
		["Rect"] = "table",
		["Region3"] = "table",
		["Region3int16"] = "table",
		["RotationCurveKey"] = "table",
		["task"] = "table",
		["TweenInfo"] = "table",
		["UDim"] = "table",
		["UDim2"] = "table",
		["Vector2"] = "table",
		["Vector2int16"] = "table",
		["Vector3"] = "table",
		["Vector3int16"] = "table",
	},

	libraries = {

		-- Luau Libraries
		bit32 = {
			arshift = "function",
			band = "function",
			bnot = "function",
			bor = "function",
			btest = "function",
			bxor = "function",
			countlz = "function",
			countrz = "function",
			extract = "function",
			lrotate = "function",
			lshift = "function",
			replace = "function",
			rrotate = "function",
			rshift = "function",
		},

		coroutine = {
			close = "function",
			create = "function",
			isyieldable = "function",
			resume = "function",
			running = "function",
			status = "function",
			wrap = "function",
			yield = "function",
		},

		debug = {
			dumpheap = "function",
			info = "function",
			loadmodule = "function",
			profilebegin = "function",
			profileend = "function",
			resetmemorycategory = "function",
			setmemorycategory = "function",
			traceback = "function",
		},

		math = {
			abs = "function",
			acos = "function",
			asin = "function",
			atan2 = "function",
			atan = "function",
			ceil = "function",
			clamp = "function",
			cos = "function",
			cosh = "function",
			deg = "function",
			exp = "function",
			floor = "function",
			fmod = "function",
			frexp = "function",
			ldexp = "function",
			log10 = "function",
			log = "function",
			max = "function",
			min = "function",
			modf = "function",
			noise = "function",
			pow = "function",
			rad = "function",
			random = "function",
			randomseed = "function",
			round = "function",
			sign = "function",
			sin = "function",
			sinh = "function",
			sqrt = "function",
			tan = "function",
			tanh = "function",

			huge = "number",
			pi = "number",
		},

		os = {
			clock = "function",
			date = "function",
			difftime = "function",
			time = "function",
		},

		string = {
			byte = "function",
			char = "function",
			find = "function",
			format = "function",
			gmatch = "function",
			gsub = "function",
			len = "function",
			lower = "function",
			match = "function",
			pack = "function",
			packsize = "function",
			rep = "function",
			reverse = "function",
			split = "function",
			sub = "function",
			unpack = "function",
			upper = "function",
		},

		table = {
			clear = "function",
			clone = "function",
			concat = "function",
			create = "function",
			find = "function",
			foreach = "function",
			foreachi = "function",
			freeze = "function",
			getn = "function",
			insert = "function",
			isfrozen = "function",
			maxn = "function",
			move = "function",
			pack = "function",
			remove = "function",
			sort = "function",
			unpack = "function",
		},

		utf8 = {
			char = "function",
			codepoint = "function",
			codes = "function",
			graphemes = "function",
			len = "function",
			nfcnormalize = "function",
			nfdnormalize = "function",
			offset = "function",

			charpattern = "string",
		},

		-- Roblox Libraries
		Axes = {
			new = "function",
		},

		BrickColor = {
			Black = "function",
			Blue = "function",
			DarkGray = "function",
			Gray = "function",
			Green = "function",
			new = "function",
			New = "function",
			palette = "function",
			Random = "function",
			random = "function",
			Red = "function",
			White = "function",
			Yellow = "function",
		},

		CatalogSearchParams = {
			new = "function",
		},

		CFrame = {
			Angles = "function",
			fromAxisAngle = "function",
			fromEulerAngles = "function",
			fromEulerAnglesXYZ = "function",
			fromEulerAnglesYXZ = "function",
			fromMatrix = "function",
			fromOrientation = "function",
			lookAt = "function",
			new = "function",

			identity = "CFrame",
		},

		Color3 = {
			fromHex = "function",
			fromHSV = "function",
			fromRGB = "function",
			new = "function",
			toHSV = "function",
		},

		ColorSequence = {
			new = "function",
		},

		ColorSequenceKeypoint = {
			new = "function",
		},

		DateTime = {
			fromIsoDate = "function",
			fromLocalTime = "function",
			fromUniversalTime = "function",
			fromUnixTimestamp = "function",
			fromUnixTimestampMillis = "function",
			now = "function",
		},

		DockWidgetPluginGuiInfo = {
			new = "function",
		},

		Enum = {},

		Faces = {
			new = "function",
		},

		FloatCurveKey = {
			new = "function",
		},

		Font = {
			fromEnum = "function",
			fromId = "function",
			fromName = "function",
			new = "function",
		},

		Instance = {
			new = "function",
		},

		NumberRange = {
			new = "function",
		},

		NumberSequence = {
			new = "function",
		},

		NumberSequenceKeypoint = {
			new = "function",
		},

		OverlapParams = {
			new = "function",
		},

		PathWaypoint = {
			new = "function",
		},

		PhysicalProperties = {
			new = "function",
		},

		Random = {
			new = "function",
		},

		Ray = {
			new = "function",
		},

		RaycastParams = {
			new = "function",
		},

		Rect = {
			new = "function",
		},

		Region3 = {
			new = "function",
		},

		Region3int16 = {
			new = "function",
		},

		RotationCurveKey = {
			new = "function",
		},

		task = {
			cancel = "function",
			defer = "function",
			delay = "function",
			desynchronize = "function",
			spawn = "function",
			synchronize = "function",
			wait = "function",
		},

		TweenInfo = {
			new = "function",
		},

		UDim = {
			new = "function",
		},

		UDim2 = {
			fromOffset = "function",
			fromScale = "function",
			new = "function",
		},

		Vector2 = {
			new = "function",

			one = "Vector2",
			xAxis = "Vector2",
			yAxis = "Vector2",
			zero = "Vector2",
		},

		Vector2int16 = {
			new = "function",
		},

		Vector3 = {
			fromAxis = "function",
			FromAxis = "function",
			fromNormalId = "function",
			FromNormalId = "function",
			new = "function",

			one = "Vector3",
			xAxis = "Vector3",
			yAxis = "Vector3",
			zAxis = "Vector3",
			zero = "Vector3",
		},

		Vector3int16 = {
			new = "function",
		},
	},
}

-- Filling up language.libraries.Enum table
local enumLibraryTable = language.libraries.Enum

for _, enum in ipairs(Enum:GetEnums()) do
	--TODO: Remove tostring from here once there is a better way to get the name of an Enum
	enumLibraryTable[tostring(enum)] = "Enum"
end

return language

end;
};
-- StarterGui.SynapseX.Main.ScriptTab.ScriptTabHandler
local function C_44()
local script = G2L["44"];
	local function AddTab()
		local NewTextbox = script.Parent.Parent.MainFunc.Needs.Textbox:Clone()
		local NewTab = script.Parent.Parent.MainFunc.Needs.Tab:Clone()
		local num = 0
		
		NewTextbox.Parent = script.Parent.Parent.MainFunc.Textboxes
		NewTab.Parent=  script.Parent.Tabs
		NewTab.Visible = true
		NewTextbox.Visible = true
		NewTab.BackgroundColor3 = Color3.fromRGB(80,80,80)
		
		-- Set da name as yes
		for i,v in pairs(script.Parent.Parent.MainFunc.Textboxes:GetChildren()) do
			num += 1
		end
		NewTab.Name = "  Script "..tostring(num)
		NewTab.Text = "  Script "..tostring(num)
		NewTextbox.Name = "  Script "..tostring(num)
		
		-- Set any textbox except new disabled (not visible)
		for _,tabs in pairs(script.Parent.Parent.MainFunc.Textboxes:GetChildren()) do
			if tabs.Name ~= NewTextbox.Name then
				tabs.Visible = false
			end
		end

		-- Set any Tab color back except this
		for i,v in pairs(script.Parent.Tabs:GetChildren()) do
			if v:IsA("TextButton") and v.Name ~= NewTab.Name then
				v.BackgroundColor3 = Color3.fromRGB(100,100,100)
			end
		end





		NewTab:FindFirstChild("Remove").MouseButton1Up:Connect(function()
			local num = 0
			for _, textboxes in pairs(script.Parent.Parent.MainFunc.Textboxes:GetChildren()) do
				num += 1

			end
			if num > 1 then
				for i,v in pairs(script.Parent.Parent.MainFunc.Textboxes:GetChildren()) do
					if v.Name == NewTab.Name then
						v:Destroy()
					end
				end
				NewTab:Destroy()
			end
		end)
		NewTab.MouseButton1Up:Connect(function()
			for i,v in pairs(script.Parent.Parent.MainFunc.Textboxes:GetChildren()) do
				if v.Name == NewTab.Name then
					v.Visible = true
				else
					v.Visible = false
				end
			end
			for i,v in pairs(script.Parent.Tabs:GetChildren()) do
				if v:IsA("TextButton") and v.Name ~= NewTab.Name then
					v.BackgroundColor3 = Color3.fromRGB(100,100,100)
				else
					if v:IsA("TextButton") then
						v.BackgroundColor3 = Color3.fromRGB(80,80,80)
					end
				end
			end
		end)




		-- Textbox handler
		local Highlighter = require(script.Parent.Parent.Parent.Highlighter)

		local textBox = NewTextbox.Frame.Textbox



		local TextBox = textBox
		local LineIndicator = NewTextbox.Frame.Linebar.LineText


		local function updateLineIndicator()
			local text = TextBox.Text
			local lineCount = select(2, text:gsub('\n', '\n'))

			LineIndicator.Text = ""

			for lineNumber = 1, lineCount + 1 do
				LineIndicator.Text = LineIndicator.Text .. lineNumber .. "\n"
			end
		end

		local function autoHighlight()
			Highlighter.highlight({
				textObject = textBox,
				src = textBox.Text,
				forceUpdate = true
			})
		end
		textBox:GetPropertyChangedSignal("Text"):Connect(function()
			autoHighlight()
		end)

		task.spawn(function()
			local UserInputService = game:GetService("UserInputService")
			local textBox = NewTextbox.Frame.Textbox -- Replace with the instance of your TextBox
			local lineIndicatorFrame = NewTextbox.Frame.Highlighted -- Replace with the instance of your line indicator frame

			local function moveLineIndicatorFrame(lineNumber)
				local lineHeight = lineIndicatorFrame.LineText.TextSize -- Adjust this value as per your line indicator's line height

				local newYOffset
				if lineNumber then
					newYOffset = (lineNumber - 10) * lineHeight
				else
					newYOffset = lineIndicatorFrame.Position.Y.Offset + 14
				end

				lineIndicatorFrame.Position = UDim2.new(0, 0, 0, newYOffset)
			end

			local function onMouseMove()
				if textBox:IsFocused() then
					UserInputService.InputBegan:Connect(function(input)
						if  input == Enum.UserInputType.MouseButton1 or input == Enum.UserInputType.Touch then
							local mouse = UserInputService:GetMouseLocation()
							local y = mouse.Y
							local lineHeight = lineIndicatorFrame.LineText.TextSize -- Adjust this value as per your line indicator's line height

							local lineNumber = math.floor(y / lineHeight) + 1
							moveLineIndicatorFrame(lineNumber)
						end
					end)
				end
			end

			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					onMouseMove()
				end
			end)

			UserInputService.InputBegan:Connect(function(input)
            pcall(function() -- i hate the errors, so yes
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local mouse = UserInputService:GetMouseLocation()
					local y = mouse.Y
					pcall(function() lineHeight = lineIndicatorFrame:FindFirstChild("LineText").TextSize end)

					local lineNumber = math.floor(y / lineHeight) + 1
					moveLineIndicatorFrame(lineNumber)
				elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Return and textBox:IsFocused() then
					moveLineIndicatorFrame(nil)
				end
            end)
            end)

			textBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					local lineNumber = textBox.CursorPosition.Y
					moveLineIndicatorFrame(lineNumber)
				end
			end)
		end)





		updateLineIndicator()


		TextBox.Changed:Connect(function(property)
			if property == "Text" then
				updateLineIndicator()
			end
		end)


		textBox:GetPropertyChangedSignal("Text"):Connect(function()
			NewTextbox.Frame.Size = UDim2.new(script.Parent.Size.X.Scale, script.Parent.Size.X.Offset, script.Parent.Parent.Size.Y.Scale, script.Parent.Parent.Size.Y.Offset + 150)
			NewTextbox.Frame.Highlighted.Size = UDim2.new(0, script.Parent.Parent.Size.X.Offset + 150,0, 13)
		end)














	end

	script.Parent.Tabs.AddScript.Button.MouseButton1Up:Connect(function()
		AddTab()
	end)
	AddTab()
end;
task.spawn(C_44);
-- StarterGui.SynapseX.Main.ButtonsHandler
local function C_49()
	local script = G2L["49"];
	local buttons = script.Parent
	local title = buttons.TitleSynapse
	local injected =  script.Parent.Parent.Injected.Value


	local function GetTextbox()
		for _,textbox in pairs(script.Parent.MainFunc.Textboxes:GetChildren()) do
			if textbox.Visible then
				return textbox
			end
		end
	end
	buttons.Clear.MouseButton1Up:Connect(function()
		for _, textbox in pairs(buttons.MainFunc.Textboxes:GetChildren()) do
			if textbox.Visible then
				textbox.Frame.Textbox.Text = ''
			end
		end
	end)
	buttons.Execute.MouseButton1Up:Connect(function()
		local textbox = GetTextbox()

			loadstring(textbox.Frame.Textbox.Text)()
	end)
	buttons.Attach.MouseButton1Up:Connect(function()
		if not injected then
			title.Text = "Synapse X - "..synversion.." (checking...)"
			task.wait(0.8)
			title.Text = "Synapse X - "..synversion.." (injecting...)"
			task.wait(2.3)
			title.Text = "Synapse X - "..synversion.." (checking whitelist...)"
			task.wait(1.6)
			title.Text = "Synapse X - "..synversion.." (scanning...)"
			task.wait(1.3)
			title.Text = "Synapse X - "..synversion.." (ready!)"
			injected = true
			task.wait(1)
			title.Text = "Synapse X - "..synversion
		else
			title.Text = "Synapse X - "..synversion.." (already injected!)"
			task.wait(1)
			title.Text = "Synapse X - "..synversion
		end
	end)

	buttons.Options.MouseButton1Up:Connect(function()
		script.Parent.Parent.OptionMenu.Position = UDim2.new(0.367, -11,0.317, -6)
		script.Parent.Parent.OptionMenu.Visible = true
	end)

	buttons.OpenFile.MouseButton1Up:Connect(function()
		script.Parent.Parent.OpenScript.Visible = true
	end)
	buttons.SaveFile.MouseButton1Up:Connect(function()
		script.Parent.Parent.SaveScript.Visible = true
	end)
	buttons.Close.MouseButton1Up:Connect(function()
		buttons.Visible = false
		script.Parent.Parent.FloatingIcon.Visible = true
	end)
	buttons.Maximize.MouseButton1Up:Connect(function()
		--idkkk
	end)
	buttons.Minimize.MouseButton1Up:Connect(function()
		buttons.Visible = false
		script.Parent.Parent.FloatingIcon.Visible = true
	end)

	script.Parent.Parent.FloatingIcon.MouseButton1Up:Connect(function()
		buttons.Visible = true
		script.Parent.Parent.FloatingIcon.Visible = false
	end)

	buttons.ScriptHub.MouseButton1Up:Connect(function()
		script.Parent.Parent.ScriptHubMenu.Visible = true
	end)
end;
task.spawn(C_49);
-- StarterGui.SynapseX.SaveScript.Handler
local function C_51()
	local script = G2L["51"];
	script.Parent.savescript.MouseButton1Up:Connect(function()
		local module = require(script.Parent.Parent.Module)
		module:AddScriptTabSave(script.Parent.scriptname.Text..".lua", module:GetActiveTextbox().Frame.Textbox.Text)
		script.Parent.Visible = false
		script.Parent.scriptname.Text = ''
		makefolder("d_android_script_dir")
		writefile("d_android_script_dir/"..script.Parent.scriptname.Text..".lua", module:GetActiveTextbox().Frame.Textbox.Text)
	end)

	script.Parent.Close.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
		script.Parent.scriptname.Text = ''
	end)
end;
task.spawn(C_51);
-- StarterGui.SynapseX.ScriptHubMenu.ScriptHubHandler
local function C_71()
	local script = G2L["71"];
	local yes = script.Parent
	yes.Background.ScrollingFrame.Dex.MouseButton1Up:Connect(function()
		for i,v in pairs(script.Parent:GetChildren()) do
			if v.Name ~= script.Parent.Background.ScrollingFrame.Dex.Name and v:IsA("Frame") then
				pcall(function() v.Visible = false end)
			else
				pcall(function() v.Visible = true end)
			end
		end
		script.Parent.Description.Text = [[A version of the popular Dex explorer with
		patches specifically for Synapse X.]]
	end)

	yes.Background.ScrollingFrame.RemoteSpy.MouseButton1Up:Connect(function()
		for i,v in pairs(script.Parent:GetChildren()) do
			if v.Name ~= script.Parent.Background.ScrollingFrame.RemoteSpy.Name and v:IsA("Frame") then
				pcall(function() v.Visible = false end)
			else
				pcall(function() v.Visible = true end)
			end
		end
		script.Parent.Description.Text = [[Allows you to view RemoteEvents and
		RemoteFunctions calleld.]]
	end)

	yes.Background.ScrollingFrame.UnnamedESP.MouseButton1Up:Connect(function()
		for i,v in pairs(script.Parent:GetChildren()) do
			if v.Name ~= script.Parent.Background.ScrollingFrame.UnnamedESP.Name and v:IsA("Frame") then
				pcall(function() v.Visible = false end)
			else
				pcall(function() v.Visible = true end)
			end
		end
		script.Parent.Description.Text = [[ESP made by ic3w0lf using the Drawing API.]]
	end)

	yes.Background.ScrollingFrame.ScriptDumper.MouseButton1Up:Connect(function()
		for i,v in pairs(script.Parent:GetChildren()) do
			if v.Name ~= script.Parent.Background.ScrollingFrame.ScriptDumper.Name and v:IsA("Frame") then
				pcall(function() pcall(function() v.Visible = false end) end)
			else
				pcall(function() v.Visible = true end)
			end
		end
		script.Parent.Description.Text = [[Dumps all LocalScripts an ModuleScripts.]]
	end)

	yes.Execute.MouseButton1Up:Connect(function()
		for i,v in pairs(yes:GetChildren()) do
			if v.Visible then
				if v.Name == "Dex" then
				loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
			elseif v.Name == "RemoteSpy" then
				loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
			elseif v.Name == "UnnamedESP" then
				pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
			elseif v.Name == "ScriptDumper" then
				saveinstance()
			end
			end
		end
	end)

	yes.Close.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
	end)

	yes.Minimize.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
	end)
end;
task.spawn(C_71);
-- StarterGui.SynapseX.OptionMenu.Optionhandler
local function C_83()
	local script = G2L["83"];
	local stuff  =script.Parent

	stuff.Buttons.Discord.MouseButton1Up:Connect(function()
		setclipboard("XYFXYNmG4D")
	end)
	stuff.Buttons.Rejoin.MouseButton1Up:Connect(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end)

	stuff.Close.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
	end)



	-- Toggles
	stuff.ToggleAutoExec.MouseButton1Up:Connect(function()
		if stuff.ToggleAutoExec.Text == '' then
			stuff.ToggleAutoExec.BackgroundColor3 = Color3.fromRGB(112,112,112)
			stuff.ToggleAutoExec.Text = 'x'



		else
			stuff.ToggleAutoExec.BackgroundColor3 = Color3.fromRGB(166,166,166)
			stuff.ToggleAutoExec.Text = ''



		end
	end)

	stuff.ToggleFPSUnlocker.MouseButton1Up:Connect(function()
		if stuff.ToggleFPSUnlocker.Text == '' then
			stuff.ToggleFPSUnlocker.BackgroundColor3 = Color3.fromRGB(112,112,112)
			stuff.ToggleFPSUnlocker.Text = 'x'

			setfpscap(math.huge)

		else
			stuff.ToggleFPSUnlocker.BackgroundColor3 = Color3.fromRGB(166,166,166)
			stuff.ToggleFPSUnlocker.Text = ''

			setfpscap(60)

		end
	end)

	stuff.ToggleInternalUI.MouseButton1Up:Connect(function()
		if stuff.ToggleInternalUI.Text == '' then
			stuff.ToggleInternalUI.BackgroundColor3 = Color3.fromRGB(112,112,112)
			stuff.ToggleInternalUI.Text = 'x'

			-- idk

		else
			stuff.ToggleInternalUI.BackgroundColor3 = Color3.fromRGB(166,166,166)
			stuff.ToggleInternalUI.Text = ''

			-- idk

		end
	end)

	stuff.ToggleTopMost.MouseButton1Up:Connect(function()
		if stuff.ToggleTopMost.Text == '' then
			stuff.ToggleTopMost.BackgroundColor3 = Color3.fromRGB(112,112,112)
			stuff.ToggleTopMost.Text = 'x'

			-- idk

		else
			stuff.ToggleTopMost.BackgroundColor3 = Color3.fromRGB(166,166,166)
			stuff.ToggleTopMost.Text = ''

			-- idk

		end
	end)
end;
task.spawn(C_83);
-- StarterGui.SynapseX.GetSavedScripts
local function C_84()

	local script = G2L["84"];
	local module = require(script.Parent.Module)
    
	for index, value in pairs(listfiles("d_android_script_dir")) do
    	print(value)
		if isfile(value) then
			task.wait(0.05)
            local editedString = string.gsub(value, [[d_android_script_dir\]], "")
			print(editedString)
			module:AddScriptTabSave(editedString, readfile(value))
		end
	end
end;
task.spawn(C_84);
-- StarterGui.SynapseX.OpenScript.Handler
local function C_92()
	local script = G2L["92"];
	script.Parent.savescript.MouseButton1Up:Connect(function()
		local module = require(script.Parent.Parent.Module)
		if isfile(script.Parent.scriptname.Text) then
			local a = script.Parent.scriptname.Text
			script.Parent.Visible = false
			script.Parent.scriptname.Text = ''
			module:AddTab(script.Parent.scriptname.Text, readfile(a))
		else
			script.Parent.Title.Text = "Synapse X - Open File (File not found!)"
			task.wait(1)
			script.Parent.Title.Text = "Synapse X - Open File"
		end
	end)

	script.Parent.Close.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
		script.Parent.scriptname.Text = ''
	end)
end;
task.spawn(C_92);
-- StarterGui.SynapseX.SetDraggable
local function C_93()
	local script = G2L["93"];
	local yes =  script.Parent
	yes.Main.Draggable = true
	yes.OpenScript.Draggable = true
	yes.OptionMenu.Draggable = true
	yes.SaveScript.Draggable = true
	yes.ScriptHubMenu.Draggable = true
	yes.ScriptLog.Draggable = true
	yes.FloatingIcon.Draggable = true
	
	
	
	yes.Main.MainFunc.ScriptHub.ChildAdded:Connect(function(v)
		
		if v:IsA("TextButton") then
        		local color = v.BackgroundColor3
            	local bordercolor = v.BorderColor3
            	local bordersize = v.BorderSizePixel
            	v.MouseEnter:Connect(function()
               	 	v.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	v.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	v.BorderSizePixel = 1
            	end)
           		 v.MouseLeave:Connect(function()
               		 v.BackgroundColor3 = color
               	 	v.BorderColor3 = bordercolor
               	 	v.BorderSizePixel = bordersize
           		 end)
           	end
	
	end)
	
	yes.Main.MainFunc.ScriptHub.ChildAdded:Connect(function(v)
		if yes:IsA("TextButton") then
			v.ChildAdded:Connect(function(RClick)
			print(RClick.Name)
			local del = RCLick.Delete
				local color = del.BackgroundColor3
            	local bordercolor = del.BorderColor3
            	local bordersize = del.BorderSizePixel
            	del.MouseEnter:Connect(function()
               	 	del.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	del.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	del.BorderSizePixel = 1
            	end)
           		 del.MouseLeave:Connect(function()
               		 del.BackgroundColor3 = color
               	 	del.BorderColor3 = bordercolor
               	 	del.BorderSizePixel = bordersize
           		 end)
           		 
           		 
           		 local exec = RCLick.Execute
				local color = exec.BackgroundColor3
            	local bordercolor = exec.BorderColor3
            	local bordersize = exec.BorderSizePixel
            	exec.MouseEnter:Connect(function()
               	 	exec.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	exec.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	exec.BorderSizePixel = 1
            	end)
           		exec.MouseLeave:Connect(function()
               		 exec.BackgroundColor3 = color
               	 	exec.BorderColor3 = bordercolor
               	 	exec.BorderSizePixel = bordersize
           		 end)
           		 
           		 local load = RCLick.Load
				local color = load.BackgroundColor3
            	local bordercolor = load.BorderColor3
            	local bordersize =load.BorderSizePixel
            	load.MouseEnter:Connect(function()
               	 	load.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	load.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	load.BorderSizePixel = 1
            	end)
           		load.MouseLeave:Connect(function()
               		load.BackgroundColor3 = color
               	 	load.BorderColor3 = bordercolor
               	 	load.BorderSizePixel = bordersize
           		 end)
		end)

		end
	end)
	
	
	
	task.spawn(function()
		
		for i,v in pairs(yes.Main.MainFunc.ScriptHub:GetChildren()) do
        	if v:IsA("TextButton") then
        		local color = v.BackgroundColor3
            	local bordercolor = v.BorderColor3
            	local bordersize = v.BorderSizePixel
            	v.MouseEnter:Connect(function()
               	 	v.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	v.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	v.BorderSizePixel = 1
            	end)
           		 v.MouseLeave:Connect(function()
               		 v.BackgroundColor3 = color
               	 	v.BorderColor3 = bordercolor
               	 	v.BorderSizePixel = bordersize
           		 end)
           	end
        end
	
	end)
   for i,v in pairs(G2L["1"]:GetDescendants()) do
        if (v:IsA("TextButton") and v.Parent.Parent.Name ~= "Tabs" and v.Parent.Name ~= "Tabs") or (v:IsA("ImageButton")) then
            task.spawn(function()
            	local color = v.BackgroundColor3
            	local bordercolor = v.BorderColor3
            	local bordersize = v.BorderSizePixel
            	v.BackgroundTransparency = 0
            	v.MouseEnter:Connect(function()
               	 	v.BackgroundColor3 = Color3.fromRGB(0,47,80)
               	 	v.BorderColor3 = Color3.fromRGB(91,139,168)
               	 	v.BorderSizePixel = 1
            	end)
           		 v.MouseLeave:Connect(function()
               		 v.BackgroundColor3 = color
               	 	v.BorderColor3 = bordercolor
               	 	v.BorderSizePixel = bordersize
           		 end)
            end)
        end
   end
   
end;
task.spawn(C_93);

return G2L["1"], require;

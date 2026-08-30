local RunService = game:GetService("RunService");

if _G.MatchaUIDemo and type(_G.MatchaUIDemo.stop) == "function" then -- tear down a previous run
	pcall(_G.MatchaUIDemo.stop);
end;
_G.MatchaUIDemo = {}; -- fresh namespace for this instance

local UI_URL = "https://raw.githubusercontent.com/Shoobie-code/matcha-ui/refs/heads/main/Ui.lua";
local UI_PREFER_REMOTE = true; -- false reads the cached workspace copy first instead

local UILib do
	local function fromDisk() -- the workspace copy, written by the last fetch
		if type(isfile) ~= "function" or type(readfile) ~= "function" then
			return nil;
		end;
		local ok, exists = pcall(isfile, "ui.lua"); -- readfile throws on a missing path
		if not (ok and exists) then
			return nil;
		end;
		local okRead, body = pcall(readfile, "ui.lua");
		if okRead and type(body) == "string" and #body > 0 then
			return body;
		end;
		return nil;
	end;

	local function fromWeb() -- the repo, cached on the way through
		if type(game.HttpGet) ~= "function" then
			return nil;
		end;
		local ok, body = pcall(function()
			return game:HttpGet(UI_URL);
		end);
		if not (ok and type(body) == "string" and #body > 0) then
			return nil;
		end;
		if type(writefile) == "function" then
			pcall(writefile, "ui.lua", body); -- so the next offline run still works
		end;
		return body;
	end;

	local src;
	if UI_PREFER_REMOTE then
		src = fromWeb() or fromDisk(); -- the link wins; disk is the offline fallback
	else
		src = fromDisk() or fromWeb();
	end;

	if src and type(loadstring) == "function" then
		local chunk = loadstring(src);
		if chunk then
			pcall(chunk); -- the library assigns itself to _G.MatchaUI
		end;
	end;
	if type(getfenv) == "function" then -- guarded: an unguarded getfenv kills the chunk
		pcall(function()
			UILib = rawget(getfenv(0), "MatchaUI");
		end);
	end;
	if not UILib then
		pcall(function()
			UILib = _G.MatchaUI;
		end);
	end;
	if not UILib and type(getgenv) == "function" then
		pcall(function()
			UILib = getgenv().MatchaUI;
		end);
	end;
end;

if not UILib then
	notify("MatchaUI unavailable - check UI_URL or drop ui.lua in the workspace.", "UI Demo", 6);
	return;
end;

-- Everything the library can do, on one window.


-- Plain rgb triples rather than Color3 values: ThemeFrom needs the channels,
-- and Drawing offers no way to read them back off a Color3.
local ACCENTS = {
		purple = { 143, 123, 245 }, green = { 120, 210, 150 },
		amber  = { 235, 180, 90 },  blue  = { 110, 170, 240 },
	};

-- The loader fetches the library at run time, so it can be older than this
-- demo. ThemeFrom arrived after the first release; without it, recolour just
-- the accent rather than erroring on a nil call.
local hasThemeFrom = type(UILib.ThemeFrom) == "function";

local function themeFor(c)
	if hasThemeFrom then
		return UILib.ThemeFrom(c[1], c[2], c[3]);
	end;
	return { accent = Color3.fromRGB(c[1], c[2], c[3]) };
end;

if not hasThemeFrom then
	notify("MatchaUI is out of date - Accent will only recolour the accent.", "UI Demo", 6);
end;

local big = UILib.CreateWindow({
		title = "Kitchen Sink",
		x = 60, y = 120,
		width = 300,
		maxHeight = 400, -- the Scroll tab below is taller than this on purpose
		toggleKey = 35, -- END
		config = "ui_demo.json",
		-- Seeded from the same accent the dropdown below starts on, so the
		-- panel does not shift the first time that dropdown is touched.
		theme = themeFor(ACCENTS.purple),
	});

local home = big:AddTab("Home");
home:AddSection({ name = "Controls" });

local sw = home:AddToggle({
		name = "Toggle", key = "demoToggle", default = true,
		keybind = true, bindKey = "demoBind", bindDefault = 112, -- F1
		onBind = function(wid)
			wid:Set(not wid:Get()); -- the bound key flips the switch
		end,
	});

local status = home:AddLabel({ name = "switch is on" });
sw.callback = function(on)
	status:SetText(on and "switch is on" or "switch is off");
end;

home:AddSlider({
		name = "Amount", key = "demoAmount",
		min = 0, max = 100, step = 5, unit = "%", default = 40,
	});

home:AddDropdown({
		name = "Preset", key = "demoPreset",
		options = { "low", "medium", "high" }, default = "medium",
		display = function(id)
			return (tostring(id):gsub("^%l", string.upper)); -- ASCII only
		end,
	});

home:AddButton({
		name = "Reset position",
		callback = function()
			big.x, big.y = 60, 120;
			big.dirty = true;
			big:Save();
		end,
	});

-- Style tab: proves theme, layout and tab visibility are all live-changeable.
local style = big:AddTab("Style");
style:AddSection({ name = "Appearance" });

style:AddDropdown({
		name = "Accent", key = "demoAccent",
		options = { "purple", "green", "amber", "blue" }, default = "purple",
		callback = function(value)
			big:SetTheme(themeFor(ACCENTS[value])); -- retints the whole card
		end,
	});

style:AddToggle({
		name = "Borderless", key = "demoBorderless", default = false,
		callback = function(on)
			big:SetLayout({ border = on and 0 or 1 });
		end,
	});

style:AddSlider({
		name = "Width", key = "demoWidth",
		min = 220, max = 420, step = 10, unit = "px", default = 300,
		callback = function(v)
			big.width = v;
			big.dirty = true;
		end,
	});

style:AddSlider({
		name = "Max height", key = "demoMaxH",
		min = 160, max = 600, step = 20, unit = "px", default = 400,
		callback = function(v)
			big.maxHeight = v; -- shrink this to watch the scrollbar appear
			big.dirty = true;
		end,
	});

-- Font pickers, offering exactly the faces this build exposes. Guarded the same
-- way as ThemeFrom: a library older than this demo would be a nil call.
if type(big.SetFonts) == "function" and type(UILib.Fonts) == "table"
	and #UILib.Fonts > 0 then
	style:AddSection({ name = "Fonts" });
	style:AddDropdown({
			name = "Title font", key = "demoTitleFont",
			options = UILib.Fonts, default = big.opts.titleFont,
			callback = function(value)
				big:SetFonts({ title = value }); -- window title and section headings
			end,
		});
	style:AddDropdown({
			name = "Text font", key = "demoTextFont",
			options = UILib.Fonts, default = big.opts.textFont,
			callback = function(value)
				big:SetFonts({ text = value }); -- every other row
			end,
		});
else
	notify("MatchaUI is out of date - no font pickers.", "UI Demo", 6);
end;

-- Scroll tab: more rows than the cap allows, so the bar has to appear.
local scroll = big:AddTab("Scroll");
scroll:AddSection({ name = "Twenty rows" });
for i = 1, 20 do
	scroll:AddSlider({
			name = "Row " .. i, min = 0, max = 100, step = 1, default = i * 5,
		});
end;

-- Hidden tab: shown and hidden from the Home tab, to show the pill row reflow.
local extra = big:AddTab({ name = "Extra", visible = false });
extra:AddLabel({ name = "This tab was hidden until you asked for it." });
extra:AddButton({
		name = "Hide me again",
		callback = function()
			extra:SetVisible(false);
			big:SelectTab(1);
		end,
	});

home:AddToggle({
		name = "Show Extra tab", default = false,
		callback = function(on)
			extra:SetVisible(on);
		end,
	});

-- Loop and teardown

local fails = 0; -- consecutive UI errors, so a broken panel cannot spam forever

local CONNS = {
		heartbeat = RunService.Heartbeat:Connect(function() -- the callback itself never raises
			if fails >= 240 then
				return;
			end;
			local ok = pcall(function()
				big:Update();
			end);
			fails = ok and 0 or (fails + 1);
		end),
	};

_G.MatchaUIDemo.stop = function()
	for key, conn in pairs(CONNS) do
		CONNS[key] = nil; -- drop the handle before touching it, as with the window below
		pcall(function()
			conn:Disconnect();
		end);
	end;
	pcall(function()
		big:Destroy();
	end);
end;

notify("UI demo loaded. END toggles the kitchen sink.", "UI Demo", 4);

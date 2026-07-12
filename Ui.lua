local G = game:GetService("Players") or game.Players;
local f = game:GetService("RunService") or game.RunService;
local N = game:GetService("HttpService") or game.HttpService;
if _G.LinLib and _G.LinLib._destroy then
	pcall(_G.LinLib._destroy);
end;
local k = {
		_objects = {},
		_texts = {},
		_conn = nil,
		_windows = {},
		Open = true,
		Unloaded = false,
		ToggleKey = 161,
		CursorInset = 0,
		StepRate = 60,
		UIRate = 30,
		Toggles = {},
		Options = {},
		_popupWidgets = {},
		_focus = nil,
		_popup = nil,
		_capturing = nil,
		_notifs = {},
		_keybinds = {},
		ConfigFolder = "linlib_configs",
		Scheme = {
			Accent = Color3.fromRGB(0, 85, 255),
			Outline = Color3.fromRGB(0, 0, 0),
			WindowBg = Color3.fromRGB(20, 20, 20),
			PanelBg = Color3.fromRGB(28, 28, 28),
			ElementBg = Color3.fromRGB(15, 15, 15),
			Border = Color3.fromRGB(50, 50, 50),
			Divider = Color3.fromRGB(40, 40, 40),
			Text = Color3.fromRGB(255, 255, 255),
			DimText = Color3.fromRGB(120, 120, 120),
			TextOutline = false,
			FontSize = 16,
			Font = "System",
			TitleFont = "SystemBold",
		},
	};
_G.LinLib = k;
_G.Library = k;
local Z = k.Scheme;
local M, p;
local function Q(G)
	local f;
	pcall(function()
		f = Drawing.Fonts[G];
	end);
	if f == nil then
		pcall(function()
			f = Drawing.Fonts.System;
		end);
	end;
	return f;
end;
local function o()
	M = Q(Z.Font);
	p = Q(Z.TitleFont);
end;
o();
function k.SetFont(G, f)
	Z.Font = f;
	o();
	for G, f in ipairs(G._texts) do
		pcall(function()
			f.d.Font = f.title and p or M;
		end);
	end;
end;
function k.SetTitleFont(G, f)
	Z.TitleFont = f;
	o();
	for G, f in ipairs(G._texts) do
		if f.title then
			pcall(function()
				f.d.Font = p;
			end);
		end;
	end;
end;
local function x(G)
	k._objects[#k._objects + 1] = G;
	return G;
end;
local function K(G, f)
	if not pcall(function()
		G.Size = f;
	end) then
		pcall(function()
			G.FontSize = f;
		end);
	end;
end;
local function h(G, f)
	return #tostring(G) * ((f * .6));
end;
local function D(G, f)
	local N = Drawing.new("Square");
	N.Filled, N.ZIndex, N.Visible = true, G or 1, false;
	if f then
		f[#f + 1] = N;
	end;
	return x(N);
end;
local function z(G, f, N, Q)
	local o = Drawing.new("Text");
	pcall(function()
		o.Font = Q and p or M;
	end);
	K(o, f or Z.FontSize);
	o.ZIndex, o.Visible, o.Center, o.Color = G or 1, false, false, Z.Text;
	o.Outline = Z.TextOutline and true or false;
	if N then
		N[#N + 1] = o;
	end;
	k._texts[#k._texts + 1] = { d = o, title = Q and true or false };
	return x(o);
end;
local function R(G, f, N, k, Z, M)
	return G >= N and ((G <= N + Z and ((f >= k and f <= k + M))));
end;
local function y(G, f, N)
	return math.max(f, math.min(N, G));
end;
local b, u, A = 1920, 1080, 0;
local function r()
	if tick() - A > 1 then
		A = tick();
		pcall(function()
			local G = workspace.CurrentCamera.ViewportSize;
			b, u = G.X, G.Y;
		end);
	end;
	return b, u;
end;
local E = setmetatable({}, { __mode = "k" });
local function U(G, f, N)
	local k = E[G];
	if not k then
		k = {};
		E[G] = k;
	end;
	if k[f] == N then
		return;
	end;
	k[f] = N;
	G[f] = N;
end;
local function L(G, f, N)
	local k = E[G];
	if not k then
		k = {};
		E[G] = k;
	end;
	if k.px == f and k.py == N then
		return;
	end;
	k.px, k.py = f, N;
	G.Position = Vector2.new(f, N);
end;
local function a(G, f, N)
	local k = E[G];
	if not k then
		k = {};
		E[G] = k;
	end;
	if k.sw == f and k.sh == N then
		return;
	end;
	k.sw, k.sh = f, N;
	G.Size = Vector2.new(f, N);
end;
local function e(G, f)
	U(G, "Visible", f);
end;
local function s(G, f)
	U(G, "Text", f);
end;
local function X(G, f)
	U(G, "Color", f);
end;
local function c(G, f)
	for G, N in ipairs(G) do
		U(N, "Visible", f);
	end;
end;
local W = { Color3.fromRGB(200, 60, 60), Color3.fromRGB(60, 200, 60), Color3.fromRGB(60, 90, 220) };
local O = {
		[48] = { "0", ")" },
		[49] = { "1", "!" },
		[50] = { "2", "@" },
		[51] = { "3", "#" },
		[52] = { "4", "$" },
		[53] = { "5", "%" },
		[54] = { "6", "^" },
		[55] = { "7", "&" },
		[56] = { "8", "*" },
		[57] = { "9", "(" },
		[32] = { " ", " " },
		[186] = { ";", ":" },
		[187] = { "=", "+" },
		[188] = { ",", "<" },
		[189] = { "-", "_" },
		[190] = { ".", ">" },
		[191] = { "/", "?" },
		[192] = { "`", "~" },
		[219] = { "[", "{" },
		[220] = { "\\", "|" },
		[221] = { "]", "}" },
		[222] = { "\'", "\"" },
	};
for G = 65, 90, 1 do
	O[G] = { string.char(G + 32), string.char(G) };
end;
local P = { [32] = { " ", " " } };
for G = 65, 90, 1 do
	P[G] = O[G];
end;
local d = {
		[1] = "MB1",
		[2] = "MB2",
		[4] = "MB3",
		[8] = "BACK",
		[9] = "TAB",
		[13] = "ENTER",
		[16] = "SHIFT",
		[17] = "CTRL",
		[18] = "ALT",
		[20] = "CAPS",
		[27] = "ESC",
		[32] = "SPACE",
		[37] = "LEFT",
		[38] = "UP",
		[39] = "RIGHT",
		[40] = "DOWN",
		[160] = "LSHIFT",
		[161] = "RSHIFT",
		[162] = "LCTRL",
		[163] = "RCTRL",
	};
for G = 48, 57, 1 do
	d[G] = string.char(G);
end;
for G = 65, 90, 1 do
	d[G] = string.char(G);
end;
for G = 1, 12, 1 do
	d[112 + ((G - 1))] = "F" .. G;
end;
local B = {};
for G, f in pairs(d) do
	B[f] = G;
end;
local function i(G)
	return d[G] or ("VK" .. tostring(G));
end;
local l = { 2, 4 };
for G = 8, 13, 1 do
	l[#l + 1] = G;
end;
for G = 32, 47, 1 do
	l[#l + 1] = G;
end;
for G = 48, 90, 1 do
	l[#l + 1] = G;
end;
for G = 112, 123, 1 do
	l[#l + 1] = G;
end;
k._mouse = nil;
k._m = {
		x = 0,
		y = 0,
		down = false,
		justDown = false,
		justUp = false,
		_handled = false,
	};
k._keyWas = {};
k._drag = nil;
k._activeSlider = nil;
local function I()
	if k._mouse then
		return k._mouse;
	end;
	local f, N = pcall(function()
			return G.LocalPlayer:GetMouse();
		end);
	if f then
		k._mouse = N;
	end;
	return k._mouse;
end;
local function n(G)
	local f, N = pcall(iskeypressed, G);
	return f and N or false;
end;
local function T()
	return n(16);
end;
function k._readInput(G)
	local f = G._m;
	local N = I();
	local Z, M = f.x, f.y;
	if N then
		pcall(function()
			Z = N.X;
			M = N.Y + k.CursorInset;
		end);
	end;
	f.x, f.y = Z, M;
	local p = false;
	pcall(function()
		p = ismouse1pressed();
	end);
	f.justDown = p and not f.down;
	f.justUp = (not p) and f.down;
	f.down = p;
end;
function k._keyEdge(G, f)
	local N = n(f);
	local k = G._keyWas[f];
	G._keyWas[f] = N;
	return N and not k;
end;
function k.Notify(G, f, N)
	local k = {
			text = tostring(f),
			until_ = tick() + ((tonumber(N) or 4)),
			_bd = D(90),
			_bf = D(91),
			_ac = D(92),
			_tx = z(93, 12),
		};
	k._ac.Color = Z.Accent;
	k._tx.Text = k.text;
	G._notifs[#G._notifs + 1] = k;
	return k;
end;
function k._paintNotifs(G)
	if #G._notifs == 0 then
		return;
	end;
	local f = r();
	local N = 20;
	for f = #G._notifs, 1, -1 do
		local N = G._notifs[f];
		if tick() >= N.until_ then
			N._bd:Remove();
			N._bf:Remove();
			N._ac:Remove();
			N._tx:Remove();
			table.remove(G._notifs, f);
		end;
	end;
	for G, k in ipairs(G._notifs) do
		local M = h(k.text, 12) + 24;
		local p = ((f - M)) - 16;
		L(k._bd, p, N);
		a(k._bd, M, 24);
		X(k._bd, Z.Outline);
		e(k._bd, true);
		L(k._bf, p + 1, N + 1);
		a(k._bf, M - 2, 22);
		X(k._bf, Z.PanelBg);
		e(k._bf, true);
		L(k._ac, p + 1, N + 1);
		a(k._ac, 2, 22);
		e(k._ac, true);
		L(k._tx, p + 10, N + 5);
		e(k._tx, true);
		N = N + 28;
	end;
end;
k._wm = {
		text = "LinLib",
		visible = false,
		x = 16,
		y = 16,
		showFps = false,
		_bd = D(50),
		_bf = D(51),
		_ac = D(52),
		_tx = z(53, 13),
		_frames = 0,
		_fpsAt = 0,
		_fps = 0,
	};
k._wm._ac.Color = Z.Accent;
function k.SetWatermark(G, f)
	G._wm.text = tostring(f);
end;
function k.SetWatermarkVisibility(G, f)
	G._wm.visible = f and true or false;
end;
function k.SetWatermarkFPS(G, f)
	G._wm.showFps = f and true or false;
end;
function k._paintWatermark(G, f)
	local N = G._wm;
	if not N.visible then
		c({
			N._bd,
			N._bf,
			N._ac,
			N._tx,
		}, false);
		return;
	end;
	N._frames = N._frames + 1;
	if tick() - N._fpsAt >= .5 then
		N._fps = math.floor(N._frames / ((tick() - N._fpsAt)) + .5);
		N._frames = 0;
		N._fpsAt = tick();
	end;
	local k = N.text;
	if N.showFps then
		k = k .. (("  |  " .. ((N._fps .. " fps"))));
	end;
	local M = h(k, 13) + 20;
	L(N._bd, N.x, N.y);
	a(N._bd, M, 22);
	X(N._bd, Z.Accent);
	e(N._bd, true);
	L(N._bf, N.x + 1, N.y + 1);
	a(N._bf, M - 2, 20);
	X(N._bf, Z.WindowBg);
	e(N._bf, true);
	e(N._ac, false);
	L(N._tx, N.x + 9, N.y + 4);
	s(N._tx, k);
	e(N._tx, true);
	if G.Open and ((f.justDown and ((not f._handled and R(f.x, f.y, N.x, N.y, M, 22))))) then
		G._drag = { wm = N, dx = f.x - N.x, dy = f.y - N.y };
		f._handled = true;
	end;
end;
k._kbList = {
		visible = true,
		x = 16,
		y = 300,
		_bd = D(50),
		_bf = D(51),
		_title = z(53, 13),
		_under = D(52),
		_rows = {},
	};
k._kbList._under.Color = Z.Accent;
function k.SetKeybindListVisibility(G, f)
	G._kbList.visible = f and true or false;
end;
function k._paintKeybinds(G, f)
	local N = G._kbList;
	local k = N.visible and #G._keybinds > 0;
	if not k then
		c({
			N._bd,
			N._bf,
			N._title,
			N._under,
		}, false);
		for G, f in ipairs(N._rows) do
			c({ f.a, f.b }, false);
		end;
		return;
	end;
	local M, p = 150, ((24 + #G._keybinds * 16)) + 6;
	L(N._bd, N.x, N.y);
	a(N._bd, M, p);
	X(N._bd, Z.Border);
	e(N._bd, true);
	L(N._bf, N.x + 1, N.y + 1);
	a(N._bf, M - 2, p - 2);
	X(N._bf, Z.PanelBg);
	e(N._bf, true);
	L(N._title, N.x + 8, N.y + 5);
	s(N._title, "Keybinds");
	X(N._title, Z.Accent);
	e(N._title, true);
	L(N._under, N.x + 6, N.y + 19);
	a(N._under, M - 12, 1);
	e(N._under, true);
	for G, f in ipairs(G._keybinds) do
		local k = N._rows[G];
		if not k then
			k = { a = z(53, 12), b = z(53, 12) };
			k.b.Color = Z.DimText;
			N._rows[G] = k;
		end;
		local p = ((N.y + 24)) + ((G - 1)) * 16;
		L(k.a, N.x + 8, p);
		s(k.a, f.text or f.id or "bind");
		e(k.a, true);
		L(k.b, ((((N.x + M)) - 8)) - h(f:label(), 12), p);
		s(k.b, f:label());
		e(k.b, true);
	end;
	for G = #G._keybinds + 1, #N._rows, 1 do
		c({ N._rows[G].a, N._rows[G].b }, false);
	end;
	if G.Open and ((f.justDown and ((not f._handled and R(f.x, f.y, N.x, N.y, M, 20))))) then
		G._drag = { kb = N, dx = f.x - N.x, dy = f.y - N.y };
		f._handled = true;
	end;
end;
local function J(G, f)
	k._dirty = true;
	if G.cb then
		pcall(G.cb, f);
	end;
	if G._listeners then
		for G, N in ipairs(G._listeners) do
			pcall(N, f);
		end;
	end;
end;
local function Y(G)
	G._listeners = {};
	function G.OnChanged(G, f)
		G._listeners[#G._listeners + 1] = f;
		return G;
	end;
end;
local function F(G, f)
	if type(G) == "string" then
		return G, f or {};
	end;
	return (G and G.Id), G or {};
end;
function k.CreateWindow(G, f)
	f = f or {};
	local N = {
			title = f.Title or "LinLib",
			sub = f.SubTitle,
			x = (f.Position and f.Position.X) or 120,
			y = (f.Position and f.Position.Y) or 90,
			w = (f.Size and f.Size.X) or 640,
			h = (f.Size and f.Size.Y) or 660,
			TB = 36,
			NAV = 36,
			PAD = 10,
			tabs = {},
			activeTab = nil,
			_chrome = {},
			_navObjs = {},
		};
	if f.Center then
		N.x, N.y = 0, 0;
	end;
	N._center = f.Center;
	G._windows[#G._windows + 1] = N;
	G._dirty = true;
	N._frameBorder = D(20, N._chrome);
	N._frameFill = D(21, N._chrome);
	N._titleBar = D(22, N._chrome);
	N._tabBar = D(22, N._chrome);
	N._navDiv = D(23, N._chrome);
	N._sbTrack = D(40, N._chrome);
	N._sbThumb = D(41, N._chrome);
	N._titleTx = z(24, 19, N._chrome, true);
	N._titleTx.Color = Z.Text;
	N._subTx = z(24, 15, N._chrome);
	N._subTx.Color = Z.DimText;
	N._minH = N.h;
	local function M(G, f)
		local N = {};
		function N.AddLabel(N, k)
			local Z = type(k) == "table" and k.Text or k;
			local M = {
					kind = "label",
					eh = 24,
					tab = f,
					_tx = z(28, 17, f._contentObjs),
				};
			M._tx.Text = Z or "";
			function M.SetText(G, f)
				G._tx.Text = f or "";
			end;
			G[#G + 1] = M;
			return M;
		end;
		function N.AddDivider(N)
			local k = {
					kind = "divider",
					eh = 14,
					tab = f,
					_ln = D(28, f._contentObjs),
				};
			k._ln.Color = Z.Divider;
			G[#G + 1] = k;
			return k;
		end;
		function N.AddButton(N, k, Z)
			local M = type(k) == "table" and k or { Text = k, Func = Z };
			local p = {
					kind = "button",
					eh = 34,
					tab = f,
					cb = M.Func or M.Callback,
					tooltip = M.Tooltip,
					_bd = D(26, f._contentObjs),
					_bf = D(27, f._contentObjs),
					_tx = z(28, 17, f._contentObjs),
				};
			p.text = M.Text or "Button";
			p._tx.Text = p.text;
			G[#G + 1] = p;
			return p;
		end;
		function N.AddToggle(Z, M, p)
			local Q, o = F(M, p);
			local x = {
					kind = "toggle",
					eh = 30,
					tab = f,
					id = Q,
					value = o.Default and true or false,
					cb = o.Callback,
					tooltip = o.Tooltip,
					addons = {},
					_bd = D(26, f._contentObjs),
					_bf = D(27, f._contentObjs),
					_tx = z(28, 17, f._contentObjs),
				};
			x.text = o.Text or "Toggle";
			x._tx.Text = x.text;
			Y(x);
			function x.SetValue(G, f)
				f = f and true or false;
				if f == G.value then
					return;
				end;
				G.value = f;
				J(G, f);
			end;
			x.Set = x.SetValue;
			function x.AddKeyPicker(G, f, k)
				local Z, M = F(f, k);
				local p = N._mkKeyPicker(G, Z, M);
				G.addons[#G.addons + 1] = p;
				return G;
			end;
			function x.AddColorPicker(G, f, k)
				local Z, M = F(f, k);
				local p = N._mkColorPicker(G, Z, M);
				G.addons[#G.addons + 1] = p;
				return G;
			end;
			G[#G + 1] = x;
			if Q then
				k.Toggles[Q] = x;
			end;
			if x.value and x.cb then
				pcall(x.cb, true);
			end;
			return x;
		end;
		function N.AddSlider(N, M, p)
			local Q, o = F(M, p);
			local x = {
					kind = "slider",
					eh = 54,
					tab = f,
					id = Q,
					min = o.Min or 0,
					max = o.Max or 100,
					value = o.Default or o.Min or 0,
					round = o.Rounding or 0,
					suffix = o.Suffix or "",
					title = o.Text or "Slider",
					cb = o.Callback,
					tooltip = o.Tooltip,
					_title = z(28, 16, f._contentObjs),
					_td = D(26, f._contentObjs),
					_tf = D(27, f._contentObjs),
					_fill = D(28, f._contentObjs),
					_val = z(29, 15, f._contentObjs),
				};
			x._title.Color = Z.Text;
			x._fill.Color = Z.Accent;
			local function K(G)
				if x.round <= 0 then
					return tostring(math.floor(G + .5));
				end;
				local f = 10 ^ x.round;
				return tostring(math.floor(G * f + .5) / f);
			end;
			local function h()
				return K(x.value) .. ((x.suffix .. (("/" .. ((K(x.max) .. x.suffix))))));
			end;
			Y(x);
			function x.SetValue(G, f)
				f = y(f, G.min, G.max);
				G.value = f;
				G._valStr = h();
				J(G, f);
			end;
			x.Set = x.SetValue;
			x._title.Text = x.title;
			x._valStr = h();
			G[#G + 1] = x;
			if Q then
				k.Options[Q] = x;
			end;
			return x;
		end;
		function N.AddInput(N, M, p)
			local Q, o = F(M, p);
			local x = {
					kind = "input",
					eh = 56,
					tab = f,
					id = Q,
					value = o.Default or "",
					placeholder = o.Placeholder or "",
					numeric = o.Numeric,
					finished = o.Finished,
					charset = o.Charset,
					title = o.Text,
					cb = o.Callback,
					tooltip = o.Tooltip,
					_title = z(28, 16, f._contentObjs),
					_bd = D(26, f._contentObjs),
					_bf = D(27, f._contentObjs),
					_tx = z(28, 17, f._contentObjs),
				};
			x._title.Color = Z.Text;
			Y(x);
			function x.SetValue(G, f)
				G.value = tostring(f or "");
				J(G, G.value);
			end;
			x.Set = x.SetValue;
			G[#G + 1] = x;
			if Q then
				k.Options[Q] = x;
			end;
			return x;
		end;
		function N.AddDropdown(N, M, p)
			local Q, o = F(M, p);
			local x = {
					kind = "dropdown",
					eh = 56,
					tab = f,
					id = Q,
					values = o.Values or {},
					multi = o.Multi and true or false,
					title = o.Text,
					cb = o.Callback,
					tooltip = o.Tooltip,
					scroll = 0,
					_title = z(28, 16, f._contentObjs),
					_bd = D(26, f._contentObjs),
					_bf = D(27, f._contentObjs),
					_tx = z(28, 17, f._contentObjs),
					_arrow = z(28, 16, f._contentObjs),
					_pbd = D(62),
					_pbf = D(63),
					_thumb = D(65),
					_rows = {},
				};
			x._title.Color = Z.Text;
			x._arrow.Text = "v";
			x.value = x.multi and {} or (o.Default or nil);
			if x.multi and type(o.Default) == "table" then
				for G, f in ipairs(o.Default) do
					x.value[f] = true;
				end;
			end;
			Y(x);
			local function K()
				if x.multi then
					local G = {};
					for f, N in ipairs(x.values) do
						if x.value[N] then
							G[#G + 1] = tostring(N);
						end;
					end;
					return #G > 0 and table.concat(G, ", ") or "---";
				end;
				return x.value ~= nil and tostring(x.value) or "---";
			end;
			x.display = K;
			function x.SetValue(G, f)
				if G.multi then
					G.value = {};
					if type(f) == "table" then
						for f, N in ipairs(f) do
							G.value[N] = true;
						end;
					end;
				else
					G.value = f;
				end;
				J(G, G.value);
			end;
			x.Set = x.SetValue;
			G[#G + 1] = x;
			k._popupWidgets[#k._popupWidgets + 1] = x;
			if Q then
				k.Options[Q] = x;
			end;
			return x;
		end;
		function N._mkKeyPicker(G, N, Z)
			local M = {
					kind = "keypicker",
					id = N,
					owner = G,
					tab = f,
					vk = B[Z.Default or "None"],
					mode = Z.Mode or "Toggle",
					text = Z.Text or (N or "Keybind"),
					cb = Z.Callback,
					active = false,
					held = false,
					_bd = D(28, f._contentObjs),
					_bf = D(29, f._contentObjs),
					_tx = z(30, 14, f._contentObjs),
				};
			Y(M);
			function M.label(G)
				return G.binding and "..." or (G.vk and i(G.vk) or "None");
			end;
			function M.SetValue(G, f)
				G.vk = B[f];
			end;
			M.value = false;
			if N then
				k.Options[N] = M;
			end;
			k._keybinds[#k._keybinds + 1] = M;
			return M;
		end;
		function N._mkColorPicker(G, N, M)
			local p = M.Default or Color3.fromRGB(255, 0, 0);
			local Q = {
					kind = "colorpicker",
					id = N,
					owner = G,
					tab = f,
					title = M.Title or M.Text or "Color",
					r = 255,
					g = 0,
					b = 0,
					cb = M.Callback,
					_sw = D(28, f._contentObjs),
					_swb = D(29, f._contentObjs),
					_pbd = D(62),
					_pbf = D(63),
					_prev = D(64),
					_rows = {},
				};
			Q._swb.Color = Z.Outline;
			pcall(function()
				Q.r = math.floor(p.R * 255 + .5);
				Q.g = math.floor(p.G * 255 + .5);
				Q.b = math.floor(p.B * 255 + .5);
			end);
			Q.value = Color3.fromRGB(Q.r, Q.g, Q.b);
			Y(Q);
			function Q.SetRGB(G, f, N, k)
				G.r, G.g, G.b = f, N, k;
				G.value = Color3.fromRGB(f, N, k);
				J(G, G.value);
			end;
			function Q.SetValue(G, f)
				local N, k, Z = G.r, G.g, G.b;
				pcall(function()
					N = math.floor(f.R * 255 + .5);
					k = math.floor(f.G * 255 + .5);
					Z = math.floor(f.B * 255 + .5);
				end);
				G:SetRGB(N, k, Z);
			end;
			Q.Set = Q.SetValue;
			k._popupWidgets[#k._popupWidgets + 1] = Q;
			if N then
				k.Options[N] = Q;
			end;
			return Q;
		end;
		return N;
	end;
	function N.AddTab(G, f)
		local N = {
				name = f,
				leftBoxes = {},
				rightBoxes = {},
				_contentObjs = {},
				_navBg = D(24, G._navObjs),
				_navAcc = D(25, G._navObjs),
				_navTx = z(26, 16, G._navObjs, true),
			};
		G.tabs[#G.tabs + 1] = N;
		if not G.activeTab then
			G.activeTab = N;
		end;
		local function k(G, f)
			local k = {
					kind = "group",
					title = f,
					elements = {},
					_bd = D(24, N._contentObjs),
					_bf = D(25, N._contentObjs),
					_title = z(26, 16, N._contentObjs, true),
					_under = D(26, N._contentObjs),
				};
			k._title.Color = Z.Text;
			k._under.Color = Z.Accent;
			G[#G + 1] = k;
			local p = M(k.elements, N);
			for G, f in ipairs({
				"AddLabel",
				"AddDivider",
				"AddButton",
				"AddToggle",
				"AddSlider",
				"AddInput",
				"AddDropdown",
			}) do
				k[f] = function(G, ...)
						return p[f](p, ...);
					end;
			end;
			return k;
		end;
		local function p(G)
			local f = {
					kind = "tabbox",
					subtabs = {},
					active = 1,
					_bd = D(24, N._contentObjs),
					_bf = D(25, N._contentObjs),
					_under = D(26, N._contentObjs),
				};
			f._under.Color = Z.Accent;
			G[#G + 1] = f;
			function f.AddTab(G, f)
				local k = { name = f, elements = {}, _tx = z(26, 16, N._contentObjs, true) };
				G.subtabs[#G.subtabs + 1] = k;
				local Z = M(k.elements, N);
				for G, f in ipairs({
					"AddLabel",
					"AddDivider",
					"AddButton",
					"AddToggle",
					"AddSlider",
					"AddInput",
					"AddDropdown",
				}) do
					k[f] = function(G, ...)
							return Z[f](Z, ...);
						end;
				end;
				return k;
			end;
			return f;
		end;
		function N.AddLeftGroupbox(G, f)
			return k(G.leftBoxes, f);
		end;
		function N.AddRightGroupbox(G, f)
			return k(G.rightBoxes, f);
		end;
		function N.AddLeftTabbox(G)
			return p(G.leftBoxes);
		end;
		function N.AddRightTabbox(G)
			return p(G.rightBoxes);
		end;
		return N;
	end;
	return N;
end;
local j, g = 9, 14;
local function V(G)
	local f, N, k, Z = G.PAD, G.TB, G.NAV, G.w - G.PAD;
	for M, p in ipairs(G.tabs) do
		local Q = h(p.name, 16) + 32;
		if f + Q > Z and f > G.PAD then
			f = G.PAD;
			N = N + k;
		end;
		p._nav = {
				x = f,
				y = N,
				w = Q,
				h = k,
			};
		f = f + Q;
	end;
	G._contentTop = ((N + k)) + G.PAD;
end;
local function v(G)
	local f = 0;
	for G, N in ipairs(G) do
		local k;
		if N.kind == "group" then
			local G = 28;
			for f, N in ipairs(N.elements) do
				G = ((G + N.eh)) + j;
			end;
			k = G + 10;
		else
			local G = 0;
			for f, N in ipairs(N.subtabs) do
				local k = 0;
				for G, f in ipairs(N.elements) do
					k = ((k + f.eh)) + j;
				end;
				G = math.max(G, k);
			end;
			k = ((44 + G)) + 10;
		end;
		f = ((f + k)) + g;
	end;
	return f;
end;
local function t(G, f, N, k, Z)
	local M = Z or G._contentTop;
	for G, f in ipairs(f) do
		f.ox, f.oy, f.w = N, M, k;
		local Z, p = N + 12, k - 24;
		if f.kind == "group" then
			local G = M + 36;
			for f, N in ipairs(f.elements) do
				N.ox, N.oy, N.w = Z, G, p;
				G = ((G + N.eh)) + j;
			end;
			f.h = ((G - M)) + 10;
		else
			local G, N = M + 44, 0;
			for f, k in ipairs(f.subtabs) do
				local M = G;
				for G, f in ipairs(k.elements) do
					f.ox, f.oy, f.w = Z, M, p;
					M = ((M + f.eh)) + j;
				end;
				N = math.max(N, M - G);
			end;
			f.h = ((44 + N)) + 10;
		end;
		M = ((M + f.h)) + g;
	end;
end;
local H, S, q;
local function m(G, f, N, k, Z, M, p, Q)
	L(G, N, k);
	a(G, Z, M);
	X(G, Q);
	L(f, N + 1, k + 1);
	a(f, Z - 2, M - 2);
	X(f, p);
	e(G, true);
	e(f, true);
end;
local function C(G, f, N, k, Z)
	s(G, f);
	L(G, math.floor(N - h(f, Z) / 2), k);
end;
H = function(G, f, N, M)
		local p, Q = G.x + f.ox, G.y + f.oy;
		local o = M and R(N.x, N.y, p, Q, f.w, f.eh);
		if f.kind == "label" then
			L(f._tx, p, Q + math.floor(((f.eh - 17)) / 2));
			e(f._tx, M);
		elseif f.kind == "divider" then
			L(f._ln, p, Q + math.floor(f.eh / 2));
			a(f._ln, f.w, 1);
			e(f._ln, M);
		elseif f.kind == "button" then
			m(f._bd, f._bf, p, Q, f.w, f.eh, o and Z.Border or Z.ElementBg, Z.Outline);
			e(f._bd, M);
			e(f._bf, M);
			C(f._tx, f.text, p + f.w / 2, Q + math.floor(((f.eh - 17)) / 2), 17);
			e(f._tx, M);
			if o and ((N.justDown and not N._handled)) then
				N._handled = true;
				if f.cb then
					pcall(f.cb);
				end;
			end;
		elseif f.kind == "toggle" then
			local G = 18;
			local o = Q + math.floor(((f.eh - G)) / 2);
			L(f._bd, p, o);
			a(f._bd, G, G);
			X(f._bd, f.value and Z.Accent or Z.Border);
			L(f._bf, p + 1, o + 1);
			a(f._bf, G - 2, G - 2);
			X(f._bf, f.value and Z.Accent or Z.ElementBg);
			e(f._bd, M);
			e(f._bf, M);
			L(f._tx, ((p + G)) + 11, Q + math.floor(((f.eh - 17)) / 2));
			e(f._tx, M);
			local x = R(N.x, N.y, p, Q, ((h(f.text, 17) + G)) + 16, f.eh);
			if M and ((x and ((N.justDown and not N._handled)))) then
				N._handled = true;
				f:SetValue(not f.value);
			end;
			local K = p + f.w;
			for G, p in ipairs(f.addons) do
				if p.kind == "keypicker" then
					local G = p:label();
					local o = h(G, 14) + 20;
					K = K - o;
					local x, D = 24, Q + math.floor(((f.eh - 24)) / 2);
					m(p._bd, p._bf, K, D, o, x, Z.ElementBg, Z.Border);
					e(p._bd, M);
					e(p._bf, M);
					L(p._tx, K + 10, D + 4);
					s(p._tx, G);
					e(p._tx, M);
					if M and ((N.justDown and ((not N._handled and R(N.x, N.y, K, D, o, x))))) then
						N._handled = true;
						p.binding = true;
						k._capturing = p;
					end;
					K = K - 8;
				elseif p.kind == "colorpicker" then
					local G, Z = 38, 24;
					K = K - G;
					local o = Q + math.floor(((f.eh - Z)) / 2);
					L(p._swb, K, o);
					a(p._swb, G, Z);
					e(p._swb, M);
					L(p._sw, K + 1, o + 1);
					a(p._sw, G - 2, Z - 2);
					X(p._sw, p.value);
					e(p._sw, M);
					if M and ((N.justDown and ((not N._handled and R(N.x, N.y, K, o, G, Z))))) then
						N._handled = true;
						k._popup = { kind = "colorpicker", el = p };
					end;
					K = K - 8;
				end;
			end;
		elseif f.kind == "slider" then
			L(f._title, p, Q);
			e(f._title, M);
			local G, o = Q + 24, 24;
			m(f._td, f._tf, p, G, f.w, o, Z.ElementBg, Z.Outline);
			e(f._td, M);
			e(f._tf, M);
			local x = (f.max > f.min) and ((f.value - f.min)) / ((f.max - f.min)) or 0;
			L(f._fill, p + 1, G + 1);
			a(f._fill, math.max(0, ((f.w - 2)) * x), o - 2);
			e(f._fill, M);
			C(f._val, f._valStr or "", p + f.w / 2, G + math.floor(((o - 15)) / 2), 15);
			e(f._val, M);
			if M and ((R(N.x, N.y, p, G, f.w, o) and ((N.justDown and not N._handled)))) then
				N._handled = true;
				k._activeSlider = f;
			end;
			if k._activeSlider == f and N.down then
				f:SetValue(f.min + y(((N.x - p)) / f.w, 0, 1) * ((f.max - f.min)));
			end;
		elseif f.kind == "input" then
			if f.title then
				L(f._title, p, Q);
				s(f._title, f.title);
				e(f._title, M);
			else
				e(f._title, false);
			end;
			local G = f.title and (Q + 24) or Q;
			local o = (k._focus == f);
			m(f._bd, f._bf, p, G, f.w, 28, Z.ElementBg, o and Z.Accent or Z.Border);
			e(f._bd, M);
			e(f._bf, M);
			local x = f.value ~= "" and f.value or f.placeholder;
			L(f._tx, p + 8, G + 6);
			s(f._tx, o and (f.value .. "|") or x);
			X(f._tx, ((f.value ~= "" or o)) and Z.Text or Z.DimText);
			e(f._tx, M);
			if M and ((N.justDown and ((not N._handled and R(N.x, N.y, p, G, f.w, 28))))) then
				N._handled = true;
				k._focus = f;
			end;
			if o and ((N.justDown and not R(N.x, N.y, p, G, f.w, 28))) then
				k._focus = nil;
				k._dirty = true;
				if f.finished and f.cb then
					pcall(f.cb, f.value);
				end;
			end;
		elseif f.kind == "dropdown" then
			if f.title then
				L(f._title, p, Q);
				s(f._title, f.title);
				e(f._title, M);
			else
				e(f._title, false);
			end;
			local G = f.title and (Q + 24) or Q;
			local o = k._popup and k._popup.el == f;
			m(f._bd, f._bf, p, G, f.w, 28, Z.ElementBg, o and Z.Accent or Z.Border);
			e(f._bd, M);
			e(f._bf, M);
			L(f._tx, p + 8, G + 6);
			s(f._tx, f.display());
			e(f._tx, M);
			L(f._arrow, ((p + f.w)) - 20, G + 6);
			e(f._arrow, M);
			f._boxY = G;
			if M and ((N.justDown and ((not N._handled and R(N.x, N.y, p, G, f.w, 28))))) then
				N._handled = true;
				k._popup = o and nil or { kind = "dropdown", el = f };
			end;
		end;
	end;
S = function(G, f, N)
		local k, M = G._vpTop, G._vpBot;
		local p, Q = f.oy, f.oy + f.h;
		local o = G.x + f.ox;
		if Q < k or p > M then
			e(f._bd, false);
			e(f._bf, false);
			e(f._title, false);
			e(f._under, false);
			if f.kind == "group" then
				for f, k in ipairs(f.elements) do
					H(G, k, N, false);
				end;
			else
				for f, k in ipairs(f.subtabs) do
					e(k._tx, false);
					for f, k in ipairs(k.elements) do
						H(G, k, N, false);
					end;
				end;
			end;
			return;
		end;
		local x, K = math.max(p, k), math.min(Q, M);
		m(f._bd, f._bf, o, G.y + x, f.w, K - x, Z.PanelBg, Z.Border);
		if f.kind == "group" then
			if f.oy + 6 >= k and f.oy + 24 <= M then
				L(f._title, o + 12, ((G.y + f.oy)) + 10);
				s(f._title, f.title or "");
				e(f._title, true);
			else
				e(f._title, false);
			end;
			e(f._under, false);
			for f, Z in ipairs(f.elements) do
				H(G, Z, N, not ((Z.oy + Z.eh < k or Z.oy > M)));
			end;
		else
			local p = (f.oy + 6 >= k) and (f.oy + 34 <= M);
			local Q = #f.subtabs;
			local x = ((f.w - 8)) / math.max(1, Q);
			local K = f.subtabs[f.active];
			local h = false;
			for k, M in ipairs(f.subtabs) do
				if p then
					local p = ((o + 4)) + ((k - 1)) * x;
					C(M._tx, M.name, p + x / 2, ((G.y + f.oy)) + 11, 16);
					X(M._tx, (k == f.active) and Z.Text or Z.DimText);
					e(M._tx, true);
					if R(N.x, N.y, p, G.y + f.oy, x, 34) and ((N.justDown and not N._handled)) then
						N._handled = true;
						f.active = k;
						K = M;
					end;
					if k == f.active then
						L(f._under, p + 4, ((G.y + f.oy)) + 35);
						a(f._under, x - 8, 2);
						e(f._under, true);
						h = true;
					end;
				else
					e(M._tx, false);
				end;
			end;
			if not h then
				e(f._under, false);
			end;
			for f, Z in ipairs(f.subtabs) do
				for f, p in ipairs(Z.elements) do
					H(G, p, N, (Z == K) and not ((p.oy + p.eh < k or p.oy > M)));
				end;
			end;
		end;
	end;
q = function(G, f)
		if not k.Open then
			c(G._chrome, false);
			c(G._navObjs, false);
			for G, f in ipairs(G.tabs) do
				c(f._contentObjs, false);
			end;
			return;
		end;
		local N = k._drag and k._drag.win == G;
		if N then
			if not G._ghosted then
				G._ghosted = true;
				for G, f in ipairs(G.tabs) do
					c(f._contentObjs, false);
				end;
				c(G._navObjs, false);
				e(G._navDiv, false);
				e(G._tabBar, false);
				e(G._sbTrack, false);
				e(G._sbThumb, false);
			end;
			m(G._frameBorder, G._frameFill, G.x, G.y, G.w, G.h, Z.WindowBg, Z.Accent);
			L(G._titleBar, G.x + 1, G.y + 1);
			a(G._titleBar, G.w - 2, G.TB - 1);
			X(G._titleBar, Z.PanelBg);
			e(G._titleBar, true);
			L(G._titleTx, G.x + 12, G.y + 9);
			s(G._titleTx, G.title);
			e(G._titleTx, true);
			if G.sub then
				L(G._subTx, ((((G.x + 14)) + h(G.title, 19))) + 10, G.y + 13);
				s(G._subTx, G.sub);
				e(G._subTx, true);
			end;
			return;
		end;
		G._ghosted = false;
		V(G);
		for N, Z in ipairs(G.tabs) do
			if f.justDown and ((not f._handled and R(f.x, f.y, G.x + Z._nav.x, G.y + Z._nav.y, Z._nav.w, Z._nav.h))) then
				G.activeTab = Z;
				k._popup = nil;
				k._focus = nil;
				f._handled = true;
			end;
		end;
		local M = G.activeTab;
		local p = 0;
		if M then
			p = math.max(v(M.leftBoxes), v(M.rightBoxes));
		end;
		local Q, o = r();
		local x = k.MaxHeight or (o - 40);
		local K = ((G._contentTop + p)) + 8;
		G.h = math.max(G._minH, math.min(K, x));
		G._vpTop, G._vpBot = G._contentTop, G.h - 6;
		G._scrollMax = math.max(0, K - G.h);
		if M then
			M.scroll = math.max(0, math.min(M.scroll or 0, G._scrollMax));
		end;
		if G._center then
			local f = r();
			G.x, G.y = math.floor(((f - G.w)) / 2), math.floor(((o - G._minH)) / 2);
			G._center = false;
		end;
		if G.y + G.h > o - 8 then
			G.y = math.max(6, ((o - 8)) - G.h);
		end;
		m(G._frameBorder, G._frameFill, G.x, G.y, G.w, G.h, Z.WindowBg, Z.Accent);
		L(G._titleBar, G.x + 1, G.y + 1);
		a(G._titleBar, G.w - 2, G.TB - 1);
		X(G._titleBar, Z.PanelBg);
		e(G._titleBar, true);
		L(G._titleTx, G.x + 12, G.y + 9);
		s(G._titleTx, G.title);
		e(G._titleTx, true);
		if G.sub then
			L(G._subTx, ((((G.x + 14)) + h(G.title, 19))) + 10, G.y + 13);
			s(G._subTx, G.sub);
			e(G._subTx, true);
		else
			e(G._subTx, false);
		end;
		local D = ((G._contentTop - G.PAD)) - G.TB;
		L(G._tabBar, G.x + 1, G.y + G.TB);
		a(G._tabBar, G.w - 2, D);
		X(G._tabBar, Z.WindowBg);
		e(G._tabBar, true);
		for N, k in ipairs(G.tabs) do
			local M, p = G.x + k._nav.x, G.y + k._nav.y;
			local Q = (G.activeTab == k);
			local o = R(f.x, f.y, M, p, k._nav.w, k._nav.h);
			if Q then
				L(k._navBg, M, p);
				a(k._navBg, k._nav.w, k._nav.h);
				X(k._navBg, Z.PanelBg);
				e(k._navBg, true);
				L(k._navAcc, M, ((p + k._nav.h)) - 3);
				a(k._navAcc, k._nav.w, 3);
				X(k._navAcc, Z.Accent);
				e(k._navAcc, true);
			else
				e(k._navBg, false);
				e(k._navAcc, false);
			end;
			L(k._navTx, M + 13, p + 10);
			s(k._navTx, k.name);
			X(k._navTx, ((Q or o)) and Z.Text or Z.DimText);
			e(k._navTx, true);
		end;
		L(G._navDiv, G.x + 1, ((G.y + G._contentTop)) - G.PAD);
		a(G._navDiv, G.w - 2, 1);
		X(G._navDiv, Z.Border);
		e(G._navDiv, true);
		if G._lastActive ~= G.activeTab then
			for f, N in ipairs(G.tabs) do
				if N ~= G.activeTab then
					c(N._contentObjs, false);
				end;
			end;
			G._lastActive = G.activeTab;
		end;
		if M then
			local N = ((G.w - G.PAD * 3)) / 2;
			local p = G._contentTop - ((M.scroll or 0));
			t(G, M.leftBoxes, G.PAD, N, p);
			t(G, M.rightBoxes, G.PAD * 2 + N, N, p);
			for N, k in ipairs(M.leftBoxes) do
				S(G, k, f);
			end;
			for N, k in ipairs(M.rightBoxes) do
				S(G, k, f);
			end;
			if G._scrollMax > 0 then
				local N = ((G.x + G.w)) - 6;
				local p, Q = G.y + G._vpTop, G._vpBot - G._vpTop;
				L(G._sbTrack, N, p);
				a(G._sbTrack, 4, Q);
				X(G._sbTrack, Z.ElementBg);
				e(G._sbTrack, true);
				local o = math.max(24, ((Q * Q)) / ((Q + G._scrollMax)));
				local x = p + ((((M.scroll or 0)) / G._scrollMax)) * ((Q - o));
				L(G._sbThumb, N, x);
				a(G._sbThumb, 4, o);
				X(G._sbThumb, Z.Accent);
				e(G._sbThumb, true);
				if f.justDown and ((not f._handled and R(f.x, f.y, N - 3, p, 10, Q))) then
					k._scrollDrag = {
							win = G,
							tab = M,
							trackY = p,
							trackH = Q,
							thumbH = o,
						};
					f._handled = true;
				end;
			else
				e(G._sbTrack, false);
				e(G._sbThumb, false);
			end;
		end;
	end;
local function w(G, f)
	local N = k._windows[1];
	local M = N.x + G.ox;
	local p = ((G._boxY or (((N.y + G.oy)) + 24))) + 28;
	local Q, o = 24, 8;
	local x = #G.values;
	local K = math.min(x, o);
	local h = G.w;
	local b = K * Q + 4;
	L(G._pbd, M, p);
	a(G._pbd, h, b);
	X(G._pbd, Z.Accent);
	e(G._pbd, true);
	L(G._pbf, M + 1, p + 1);
	a(G._pbf, h - 2, b - 2);
	X(G._pbf, Z.WindowBg);
	e(G._pbf, true);
	G.scroll = y(G.scroll or 0, 0, math.max(0, x - o));
	for N = 1, o, 1 do
		local o = G._rows[N];
		if not o then
			o = { bf = D(64), tx = z(65, 15) };
			G._rows[N] = o;
		end;
		local x = N + math.floor(G.scroll + .5);
		local y = G.values[x];
		if N <= K and y ~= nil then
			local x = ((p + 2)) + ((N - 1)) * Q;
			local K = G.multi and G.value[y] or (not G.multi and G.value == y);
			local D = R(f.x, f.y, M + 2, x, h - 4, Q);
			L(o.bf, M + 2, x);
			a(o.bf, h - 4, Q);
			X(o.bf, K and Z.Accent or (D and Z.PanelBg or Z.WindowBg));
			e(o.bf, true);
			L(o.tx, M + 10, x + 5);
			s(o.tx, tostring(y));
			X(o.tx, K and Z.WindowBg or Z.Text);
			e(o.tx, true);
			if D and f.justDown then
				f._handled = true;
				if G.multi then
					G.value[y] = not G.value[y] or nil;
					J(G, G.value);
				else
					G.value = y;
					J(G, y);
					k._popup = nil;
				end;
			end;
		else
			if o then
				e(o.bf, false);
				e(o.tx, false);
			end;
		end;
	end;
	if x > o then
		local N = ((M + h)) - 4;
		L(G._thumb, N, ((p + 2)) + ((G.scroll / ((x - o)))) * ((((b - 4)) - 18)));
		a(G._thumb, 3, 18);
		X(G._thumb, Z.Accent);
		e(G._thumb, true);
		if f.down and R(f.x, f.y, N - 3, p, 8, b) then
			G.scroll = y(((((f.y - p)) / b)) * x, 0, x - o);
		end;
	else
		e(G._thumb, false);
	end;
	if f.justDown and ((not f._handled and not R(f.x, f.y, M, p, h, b))) then
		k._popup = nil;
		f._handled = true;
	end;
	return {
		x = M,
		y = p,
		w = h,
		h = b,
	};
end;
local function GM(G)
	e(G._pbd, false);
	e(G._pbf, false);
	e(G._thumb, false);
	for G, f in ipairs(G._rows) do
		e(f.bf, false);
		e(f.tx, false);
	end;
end;
local function fM(G, f)
	local N = k._windows[1];
	local M = ((((N.x + G.owner.ox)) + G.owner.w)) - 160;
	local p = ((N.y + G.owner.oy)) + 30;
	local Q, o = 150, 92;
	L(G._pbd, M, p);
	a(G._pbd, Q, o);
	X(G._pbd, Z.Accent);
	e(G._pbd, true);
	L(G._pbf, M + 1, p + 1);
	a(G._pbf, Q - 2, o - 2);
	X(G._pbf, Z.WindowBg);
	e(G._pbf, true);
	local x = { "R", "G", "B" };
	local K = { G.r, G.g, G.b };
	for N = 1, 3, 1 do
		local k = ((p + 6)) + ((N - 1)) * 20;
		local o = G._rows[N];
		if not o then
			o = {
					td = D(64),
					tf = D(64),
					fill = D(65),
					tx = z(66, 12),
				};
			G._rows[N] = o;
		end;
		m(o.td, o.tf, M + 8, k, Q - 46, 14, Z.ElementBg, Z.Outline);
		L(o.fill, M + 9, k + 1);
		a(o.fill, ((Q - 48)) * ((K[N] / 255)), 12);
		X(o.fill, W[N]);
		e(o.fill, true);
		C(o.tx, x[N] .. ((" " .. K[N])), ((M + 8)) + ((Q - 46)) / 2, k + 1, 12);
		e(o.tx, true);
		if f.down and R(f.x, f.y, M + 8, k, Q - 46, 14) then
			K[N] = math.floor(y(((f.x - ((M + 8)))) / ((Q - 46)), 0, 1) * 255 + .5);
			G:SetRGB(K[1], K[2], K[3]);
		end;
	end;
	L(G._prev, ((M + Q)) - 30, p + 8);
	a(G._prev, 22, o - 16);
	X(G._prev, G.value);
	e(G._prev, true);
	if f.justDown and ((not f._handled and not R(f.x, f.y, M, p, Q, o))) then
		k._popup = nil;
		f._handled = true;
	end;
end;
local function NM(G)
	e(G._pbd, false);
	e(G._pbf, false);
	e(G._prev, false);
	for G, f in ipairs(G._rows) do
		e(f.td, false);
		e(f.tf, false);
		e(f.fill, false);
		e(f.tx, false);
	end;
end;
local function kM()
	local G = k._focus;
	if not G then
		return;
	end;
	k._typePhase = not k._typePhase;
	if k._typePhase then
		return;
	end;
	if k:_keyEdge(13) then
		k._focus = nil;
		k._dirty = true;
		if G.finished and G.cb then
			pcall(G.cb, G.value);
		end;
		return;
	end;
	if k:_keyEdge(27) then
		k._focus = nil;
		k._dirty = true;
		return;
	end;
	if k:_keyEdge(8) then
		G.value = G.value:sub(1, -2);
		if not G.finished then
			J(G, G.value);
		end;
		return;
	end;
	local f = T();
	for N, Z in pairs(G.charset == "alpha" and P or O) do
		if k:_keyEdge(N) then
			local N = f and Z[2] or Z[1];
			if not ((G.numeric and not N:match("[%d%.%-]"))) then
				G.value = G.value .. N;
				if not G.finished then
					J(G, G.value);
				end;
			end;
		end;
	end;
end;
local function ZM()
	local G = k._capturing;
	if not G then
		return;
	end;
	if k:_keyEdge(27) then
		G.binding = false;
		k._capturing = nil;
		k._dirty = true;
		return;
	end;
	for f, N in ipairs(l) do
		local Z = false;
		if N == 2 then
			pcall(function()
				Z = ismouse2pressed();
			end);
		else
			Z = n(N);
		end;
		local M = k._keyWas["cap" .. N];
		k._keyWas["cap" .. N] = Z;
		if Z and not M then
			G.vk = N;
			G.binding = false;
			k._capturing = nil;
			k._dirty = true;
			if G.cb then
				pcall(G.cb);
			end;
			return;
		end;
	end;
end;
local function MM()
	for G, f in ipairs(k._keybinds) do
		if f.vk and not f.binding then
			local G = (f.vk == 2) and ((function()
					local G = false;
					pcall(function()
						G = ismouse2pressed();
					end);
					return G;
				end))() or n(f.vk);
			if f.mode == "Hold" then
				if f.value ~= G then
					f.value = G;
					J(f, G);
				end;
			elseif f.mode == "Always" then
				f.value = true;
			else
				local N = f.held;
				f.held = G;
				if G and not N then
					f.value = not f.value;
					J(f, f.value);
				end;
			end;
		end;
	end;
end;
function k._step(G)
	local f = tick();
	if G._nextStep and f < G._nextStep then
		return;
	end;
	G._nextStep = f + .85 / ((G.StepRate or 60));
	G:_readInput();
	local N = G._m;
	N._handled = false;
	if G:_keyEdge(G.ToggleKey) then
		G.Open = not G.Open;
		G._dirty = true;
		if not G.Open then
			G._popup = nil;
			G._focus = nil;
			G._capturing = nil;
			local f = G._lastPopupEl;
			if f then
				if f.kind == "dropdown" then
					GM(f);
				else
					NM(f);
				end;
				G._lastPopupEl = nil;
			end;
		end;
	end;
	if N.justUp then
		if G._activeSlider or G._drag or G._scrollDrag then
			G._dirty = true;
		end;
		G._activeSlider = nil;
		G._drag = nil;
		G._scrollDrag = nil;
	end;
	if not G.Open then
		if not G._closedDone then
			for G, f in ipairs(G._windows) do
				q(f, N);
			end;
			G._closedDone = true;
		end;
		G:_paintWatermark(N);
		G:_paintKeybinds(N);
		G:_paintNotifs();
		return;
	end;
	G._closedDone = false;
	local k = G._popup;
	local Z = false;
	for G, f in ipairs(G._windows) do
		if R(N.x, N.y, f.x, f.y, f.w, f.h) then
			Z = true;
			break;
		end;
	end;
	local M = N.x ~= G._lastMX or N.y ~= G._lastMY or N.justDown or N.justUp or N.down;
	G._lastMX, G._lastMY = N.x, N.y;
	local p = Z or G._drag or G._activeSlider or G._scrollDrag or k or G._focus or G._capturing;
	local Q = (p and M) or (Z ~= G._insideLast) or G._dirty;
	G._insideLast = Z;
	local o = N.justDown or N.justUp or G._dirty or (f - ((G._lastPaint or 0))) >= .85 / ((G.UIRate or 30));
	if Q and o then
		G._lastPaint = f;
		if k then
			if k.kind == "dropdown" then
				w(k.el, N);
			else
				fM(k.el, N);
			end;
		end;
		for G, f in ipairs(G._windows) do
			q(f, N);
		end;
		G._dirty = false;
	end;
	local x = G._lastPopupEl;
	if x and x ~= ((k and k.el)) then
		if x.kind == "dropdown" then
			GM(x);
		else
			NM(x);
		end;
	end;
	G._lastPopupEl = k and k.el or nil;
	G:_paintWatermark(N);
	G:_paintKeybinds(N);
	G:_paintNotifs();
	kM();
	ZM();
	MM();
	for f, k in ipairs(G._windows) do
		if N.justDown and ((not N._handled and R(N.x, N.y, k.x, k.y, k.w, k.TB))) then
			G._drag = { win = k, dx = N.x - k.x, dy = N.y - k.y };
			N._handled = true;
			G._dirty = true;
		end;
	end;
	if G._drag and N.down then
		local f = G._drag;
		local k = f.win or f.wm or f.kb;
		if k then
			k.x = N.x - f.dx;
			k.y = N.y - f.dy;
		end;
		G._dirty = true;
	end;
	if G._scrollDrag and N.down then
		local f = G._scrollDrag;
		local k = y(((((N.y - f.trackY)) - f.thumbH / 2)) / math.max(1, f.trackH - f.thumbH), 0, 1);
		f.tab.scroll = k * f.win._scrollMax;
		G._dirty = true;
	end;
end;
function k._start(G)
	if G._conn then
		return;
	end;
	G._conn = f.Heartbeat:Connect(function()
			local G, f = pcall(function()
					k:_step();
				end);
			if not G then
				warn("[LinLib] " .. tostring(f));
			end;
		end);
end;
function k._destroy()
	k.Unloaded = true;
	if k._onUnload then
		pcall(k._onUnload);
	end;
	if k._conn then
		pcall(function()
			k._conn:Disconnect();
		end);
		k._conn = nil;
	end;
	for G, f in ipairs(k._objects) do
		pcall(function()
			f:Remove();
		end);
	end;
	k._objects = {};
end;
k.Unload = k._destroy;
function k.OnUnload(G, f)
	G._onUnload = f;
end;
function k.RemoveWindow(G, f)
	if not f then
		return;
	end;
	for N, k in ipairs(G._windows) do
		if k == f then
			table.remove(G._windows, N);
			break;
		end;
	end;
	local function N(G)
		for G, f in ipairs(G or {}) do
			pcall(function()
				f:Remove();
			end);
		end;
	end;
	N(f._chrome);
	N(f._navObjs);
	for G, f in ipairs(f.tabs) do
		N(f._contentObjs);
	end;
	G._dirty = true;
end;
local function pM()
	local G = { toggles = {}, options = {} };
	for f, N in pairs(k.Toggles) do
		G.toggles[f] = N.value;
	end;
	for f, N in pairs(k.Options) do
		if N.kind == "slider" then
			G.options[f] = { t = "n", v = N.value };
		elseif N.kind == "input" then
			G.options[f] = { t = "s", v = N.value };
		elseif N.kind == "dropdown" then
			if N.multi then
				local k = {};
				for G, f in pairs(N.value) do
					if f then
						k[#k + 1] = G;
					end;
				end;
				G.options[f] = { t = "m", v = k };
			else
				G.options[f] = { t = "d", v = N.value };
			end;
		elseif N.kind == "colorpicker" then
			G.options[f] = { t = "c", v = { N.r or 255, N.g or 0, N.b or 0 } };
		elseif N.kind == "keypicker" then
			G.options[f] = { t = "k", v = N.vk and i(N.vk) or "None" };
		end;
	end;
	return G;
end;
local function QM(G)
	for G, f in pairs(G.toggles or {}) do
		local N = k.Toggles[G];
		if N then
			N:SetValue(f);
		end;
	end;
	for G, f in pairs(G.options or {}) do
		local N = k.Options[G];
		if N then
			if f.t == "c" and type(f.v) == "table" then
				if N.SetRGB then
					N:SetRGB(f.v[1], f.v[2], f.v[3]);
				else
					N:SetValue(Color3.fromRGB(f.v[1], f.v[2], f.v[3]));
				end;
			elseif f.t == "k" then
				N.vk = B[f.v];
			else
				N:SetValue(f.v);
			end;
		end;
	end;
end;
function k.SaveConfig(G, f)
	pcall(function()
		if not isfolder(G.ConfigFolder) then
			makefolder(G.ConfigFolder);
		end;
	end);
	local k, Z = pcall(function()
			return N:JSONEncode(pM());
		end);
	if k then
		pcall(function()
			writefile(G.ConfigFolder .. (("/" .. ((f .. ".json")))), Z);
		end);
	end;
	return k;
end;
function k.LoadConfig(G, f)
	local k = G.ConfigFolder .. (("/" .. ((f .. ".json"))));
	local Z, M = pcall(function()
			if isfile(k) then
				return readfile(k);
			end;
		end);
	if Z and M then
		local G = pcall(function()
				QM(N:JSONDecode(M));
			end);
		return G;
	end;
	return false;
end;
function k.ListConfigs(G)
	local f = {};
	pcall(function()
		if isfolder(G.ConfigFolder) then
			for G, N in ipairs(listfiles(G.ConfigFolder)) do
				local k = ((tostring(N))):match("([^/\\]+)%.json$");
				if k then
					f[#f + 1] = k;
				end;
			end;
		end;
	end);
	return f;
end;
k:_start();

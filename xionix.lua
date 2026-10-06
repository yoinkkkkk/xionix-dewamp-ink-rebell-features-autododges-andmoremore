local N = game:GetService("Players");
local G = game:GetService("Workspace");
local V = game:GetService("UserInputService");
local z = game:GetService("ContextActionService");
local v = game:GetService("RunService");
local R = game:GetService("HttpService");
local C = game:GetService("TweenService");
local b = game:GetService("SoundService");
local y = game:GetService("Stats");
local P = game:GetService("Lighting");
local O = game:GetService("ReplicatedStorage");
local q = nil;
pcall(function()
	q = game:GetService("ProximityPromptService");
end);
local F = N.LocalPlayer;
while not F do
	task.wait(.1);
	F = N.LocalPlayer;
end;
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
local n = "x1oni1x dew4mp 1NK (X/D)";
local m = "v5.4";
local x = {};
x.FILE = ((function()
		local N = (getgenv and getgenv()) or _G;
		local function G(G)
			local V = _G[G] or rawget(_G, G);
			if V then
				return V;
			end;
			if N and N[G] then
				return N[G];
			end;
			return nil;
		end;
		return {
			writefile = G("writefile"),
			readfile = G("readfile"),
			isfile = G("isfile"),
			isfolder = G("isfolder"),
			makefolder = G("makefolder"),
			listfiles = G("listfiles"),
			delfile = G("delfile"),
		};
	end))();
x.running = true;
x.unloaded = false;
x.conns = {};
x.hooks = {};
x.added = {};
x.oneClickDalgona = false;
x.dalgonaConn = nil;
x.cachedSlot = "T";
x.cachedDodgeSlot = "1";
x.cachedUITool = nil;
x.cachedDodgeTool = nil;
x.lastDodgeUI = 0;
x.lastDodgeH = 0;
x.lastMenuToggle = 0;
x.gui = nil;
x.shadow = nil;
x.glow = nil;
x.panel = nil;
x.tracerGui = nil;
x.overlayGui = nil;
x.infoGui = nil;
x.wmFrame = nil;
x.wmLabel = nil;
x.kbFrame = nil;
x.kbLabel = nil;
x.menuAction = nil;
x.clickSound = nil;
x.combatHooked = false;
x.origFiredGun = nil;
x.origGetBuffs = nil;
x.gunMod = nil;
x.fovGui = nil;
x.fovFrame = nil;
x.fovStroke = nil;
x.colorPickerOpen = nil;
x.fovRainbowConn = nil;
x.panelRainbowConn = nil;
x.notifHolder = nil;
x.fbInst = nil;
x.fogBackup = nil;
x.bindingMenuKey = false;
x.currentConfigName = "default";
x.animEnabled = {};
x.hideConns = {};
x.handCache = {};
x.legCache = {};
x.torsoCache = {};
x.origTransparency = {};
x.handsConn = nil;
x.korbloxData = {};
x.lastBrewTick = 0;
x.brewLoopConn = nil;
x.activeNotifs = {};
x.btAnimConn = nil;
x.btLastIdTime = {};
x.btLastShot = 0;
x._nickLoop = nil;
x.menuOpen = true;
x.menuTweens = {};
_G.__adEspDone = 0;
_G.__adEspTotal = 0;
_G.__dalgonaCache = {};
_G.__adWatchers = {};
_G.__rlglLast = 0;
_G.__rlglRedStartAt = 0;
_G.__rlglWasRed = false;
_G.__rlglLastSec = nil;
_G.__rlglTimerEndedAt = 0;
_G.__rlglLastFire = 0;
_G.__adUnloaded = false;
do
	if getgenv and ((getgenv()).__ui_dodge and (getgenv()).__ui_dodge.shutdown) then
		pcall(function()
			(getgenv()).__ui_dodge.shutdown();
		end);
	end;
	local N = {};
	if gethui then
		pcall(function()
			table.insert(N, gethui());
		end);
	end;
	pcall(function()
		table.insert(N, game:GetService("CoreGui"));
	end);
	if F then
		pcall(function()
			table.insert(N, F:FindFirstChildOfClass("PlayerGui"));
		end);
	end;
	for N, G in ipairs(N) do
		if G and typeof(G) == "Instance" then
			for N, G in ipairs(G:GetChildren()) do
				if G:IsA("ScreenGui") and (tostring(G.Name)):find("^XD_") then
					pcall(function()
						G:Destroy();
					end);
				end;
			end;
		end;
	end;
end;
local w = {
		["rbxassetid://124637626540536"] = "HK416",
		["rbxassetid://138748957635848"] = "G3SG1",
		["rbxassetid://96837363717592"] = "Deagle",
		["rbxassetid://88111250846452"] = "Glock 17",
		["rbxassetid://87593987526528"] = "FN Fal",
		["rbxassetid://76674339459544"] = "MP5K",
		["rbxassetid://122334383661670"] = "M4A1",
		["rbxassetid://93906174064273"] = "Five Seven",
		["rbxassetid://84089564531020"] = "Thompson M1A1",
		["rbxassetid://78301729996106"] = "P90",
		["rbxassetid://94523642657060"] = "Uzi",
		["rbxassetid://83718615035368"] = "Colt M1911",
		["rbxassetid://129874518877211"] = "MP5",
	};
local h = {};
for N, G in pairs(w) do
	h[N] = G;
	local V = N:match("%d+");
	if V then
		h[V] = G;
	end;
end;
local function S(N, G, V, z, v, R, C, b, y, P, O, q, F, n, m, x)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(N, G, V)),
		ColorSequenceKeypoint.new(.25, Color3.fromRGB(z, v, R)),
		ColorSequenceKeypoint.new(.5, Color3.fromRGB(C, b, y)),
		ColorSequenceKeypoint.new(.75, Color3.fromRGB(P, O, q)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(F, n, m)),
	});
end;
local o = {
		Enabled = false,
		Distance = 18,
		Delay = 0,
		MinInterval = .02,
		AnimWatch = .4,
		WatchAfter = .3,
		RadiusVis = false,
		RadiusTransparency = .55,
		RadiusR = 255,
		RadiusG = 70,
		RadiusB = 160,
		GuardESP = false,
		GuardESP_HP = true,
		GuardESP_Name = true,
		GuardESP_Tool = true,
		GuardESP_ForceAll = false,
		GuardESP_Highlight = true,
		GuardESP_Tracer = false,
		GuardESP_Box = false,
		GuardESP_Skeleton = false,
		GuardESP_HPBarThickness = 8,
		GuardESP_HPBarLength = 1.5,
		GuardESP_HPBarRoundness = 3,
		GuardESP_ColorR = 255,
		GuardESP_ColorG = 50,
		GuardESP_ColorB = 50,
		GuardESP_TracerR = 255,
		GuardESP_TracerG = 50,
		GuardESP_TracerB = 50,
		GuardESP_BoxR = 255,
		GuardESP_BoxG = 50,
		GuardESP_BoxB = 50,
		GuardESP_SkeletonR = 255,
		GuardESP_SkeletonG = 50,
		GuardESP_SkeletonB = 50,
		GuardESP_BoxThickness = 2,
		GuardESP_SkeletonThickness = 1.5,
		GuardESP_NameSize = 17,
		GuardESP_Distance = false,
		GuardESP_MaxDist = 500,
		GuardESP_HP_TopR = 80,
		GuardESP_HP_TopG = 255,
		GuardESP_HP_TopB = 80,
		GuardESP_HP_M1R = 180,
		GuardESP_HP_M1G = 255,
		GuardESP_HP_M1B = 60,
		GuardESP_HP_M2R = 255,
		GuardESP_HP_M2G = 200,
		GuardESP_HP_M2B = 40,
		GuardESP_HP_M3R = 255,
		GuardESP_HP_M3G = 120,
		GuardESP_HP_M3B = 60,
		GuardESP_HP_BotR = 255,
		GuardESP_HP_BotG = 40,
		GuardESP_HP_BotB = 40,
		GuardESP_HP_State1_R = 74,
		GuardESP_HP_State1_G = 222,
		GuardESP_HP_State1_B = 74,
		GuardESP_HP_State2_R = 255,
		GuardESP_HP_State2_G = 210,
		GuardESP_HP_State2_B = 60,
		GuardESP_HP_State3_R = 255,
		GuardESP_HP_State3_G = 130,
		GuardESP_HP_State3_B = 40,
		GuardESP_HP_State4_R = 255,
		GuardESP_HP_State4_G = 55,
		GuardESP_HP_State4_B = 55,
		GuardESP_HP_Outline = false,
		PlayerESP = false,
		PlayerESP_HP = true,
		PlayerESP_Name = true,
		PlayerESP_Tool = true,
		PlayerESP_Highlight = true,
		PlayerESP_Tracer = false,
		PlayerESP_Box = false,
		PlayerESP_Skeleton = false,
		PlayerESP_HPBarThickness = 8,
		PlayerESP_HPBarLength = 1.5,
		PlayerESP_HPBarRoundness = 3,
		PlayerESP_ColorR = 80,
		PlayerESP_ColorG = 255,
		PlayerESP_ColorB = 120,
		PlayerESP_TracerR = 80,
		PlayerESP_TracerG = 255,
		PlayerESP_TracerB = 120,
		PlayerESP_BoxR = 80,
		PlayerESP_BoxG = 255,
		PlayerESP_BoxB = 120,
		PlayerESP_SkeletonR = 80,
		PlayerESP_SkeletonG = 255,
		PlayerESP_SkeletonB = 120,
		PlayerESP_BoxThickness = 2,
		PlayerESP_SkeletonThickness = 1.5,
		PlayerESP_NameSize = 17,
		PlayerESP_Distance = false,
		PlayerESP_MaxDist = 500,
		PlayerESP_HP_TopR = 80,
		PlayerESP_HP_TopG = 255,
		PlayerESP_HP_TopB = 80,
		PlayerESP_HP_M1R = 180,
		PlayerESP_HP_M1G = 255,
		PlayerESP_HP_M1B = 60,
		PlayerESP_HP_M2R = 255,
		PlayerESP_HP_M2G = 200,
		PlayerESP_HP_M2B = 40,
		PlayerESP_HP_M3R = 255,
		PlayerESP_HP_M3G = 120,
		PlayerESP_HP_M3B = 60,
		PlayerESP_HP_BotR = 255,
		PlayerESP_HP_BotG = 40,
		PlayerESP_HP_BotB = 40,
		PlayerESP_HP_State1_R = 74,
		PlayerESP_HP_State1_G = 222,
		PlayerESP_HP_State1_B = 74,
		PlayerESP_HP_State2_R = 255,
		PlayerESP_HP_State2_G = 210,
		PlayerESP_HP_State2_B = 60,
		PlayerESP_HP_State3_R = 255,
		PlayerESP_HP_State3_G = 130,
		PlayerESP_HP_State3_B = 40,
		PlayerESP_HP_State4_R = 255,
		PlayerESP_HP_State4_G = 55,
		PlayerESP_HP_State4_B = 55,
		PlayerESP_HP_Outline = false,
		Watermark = true,
		KeybindList = true,
		InstantInteract = false,
		InstantInteractInsta = false,
		InstantInteractMult = 2,
		MenuKey = Enum.KeyCode.N,
		RemoveLegs = false,
		RemoveHands = false,
		RemoveTorso = false,
		Headless = false,
		Korblox = false,
		HideNick = false,
		FullBright = false,
		RemoveFog = false,
		ESP_FontIdx = 1,
		PanelRainbow = true,
		FOVRainbow = false,
		FOVRainbowMode = 1,
		FOVUseCustom = false,
		FOVCustomIdx = 1,
		FOVCustomR1 = 255,
		FOVCustomG1 = 60,
		FOVCustomB1 = 60,
		FOVCustomR2 = 60,
		FOVCustomG2 = 255,
		FOVCustomB2 = 60,
		FOVCustomR3 = 60,
		FOVCustomG3 = 140,
		FOVCustomB3 = 255,
		FOVCustomR4 = 255,
		FOVCustomG4 = 255,
		FOVCustomB4 = 60,
		FOVCustomR5 = 255,
		FOVCustomG5 = 60,
		FOVCustomB5 = 255,
		FOVCustomR6 = 60,
		FOVCustomG6 = 255,
		FOVCustomB6 = 255,
		FOVCustomR7 = 255,
		FOVCustomG7 = 180,
		FOVCustomB7 = 60,
		FOVCustomR8 = 255,
		FOVCustomG8 = 255,
		FOVCustomB8 = 255,
		FOVCustomR9 = 180,
		FOVCustomG9 = 60,
		FOVCustomB9 = 255,
		AutoBrew = false,
		AutoBrewSlot = "E",
		AutoBrewInterval = 60,
		AutoBrewCollectHold = 2,
		BulletTracer = false,
		BulletTracerR = 255,
		BulletTracerG = 147,
		BulletTracerB = 255,
		BulletTracerThickness = .2,
		BulletTracerSpeed = 800,
		BulletTracerLifetime = 2,
		BulletTracerRange = 1050,
		BulletTracerStartOffset = .3,
		BulletTracerEndOffset = 0,
		BulletTracerOpacity = 0,
		BulletTracerGlow = true,
		BulletTracerWhiteCore = true,
		BulletTracerFadeIdx = 1,
		BulletTracerCooldown = .03,
		ManualUISlot = "",
		ManualHnSSlot = "",
		GuiR = 200,
		GuiG = 60,
		GuiB = 255,
		GuiTextR = 235,
		GuiTextG = 225,
		GuiTextB = 250,
		AnimSpeed = false,
		AnimSpeedValue = 2.5,
		MenuAnimSpeed = .35,
		MenuDodgeAnimSpeed = .5,
		CircleTextR = 255,
		CircleTextG = 255,
		CircleTextB = 255,
		CircleRainbowText = false,
		CircleRainbowOutline = true,
		CircleSize = 64,
		CircleRainbowSpeed = 1,
		RLGL_AutoDodge = false,
		RLGL_OnlyRedLight = true,
		RLGL_MinInterval = .75,
		RLGL_RedDelay = .55,
		RLGL_VelThreshold = .1,
		RLGL_TimerEndDodge = true,
		RLGL_TimerEndDelay = 12,
		RLGL_TimerEndInterval = .75,
		RLGL_TimerEndMaxDuration = 9,
		RebelSilentAim = false,
		RebelNoRecoil = false,
		RebelRapidFire = false,
		RebelFOV = 250,
		RebelFOVCircle = false,
		RebelFOVNeon = true,
		RebelFOVBlackOutline = true,
		RebelFOV_OutlineThickness = 5,
		RebelFOV_OutlineR = 0,
		RebelFOV_OutlineG = 0,
		RebelFOV_OutlineB = 0,
		RebelFOVCircleWidth = 1.6,
		RebelFOVBlendSpeed = .5,
		RebelFOVR = 255,
		RebelFOVG = 60,
		RebelFOVB = 60,
		RebelTargetPlayers = true,
		RebelTargetNPCs = true,
		RebelBodyHead = true,
		RebelBodyTorso = true,
		RebelBodyHRP = false,
		RebelBodyLeftArm = false,
		RebelBodyRightArm = false,
		RebelBodyLeftLeg = false,
		RebelBodyRightLeg = false,
	};
local i = {
		Enabled = false,
		Distance = 18,
		Delay = 0,
		MinInterval = .02,
		AnimWatch = .4,
		WatchAfter = .3,
		RadiusVis = false,
		RadiusTransparency = .55,
		RadiusR = 70,
		RadiusG = 210,
		RadiusB = 255,
		HollyMode = true,
	};
local j = {
		"GothamBlack",
		"GothamBold",
		"Gotham",
		"Code",
		"Arial",
		"ArialBold",
		"SourceSans",
		"SourceSansBold",
		"SciFi",
		"Fantasy",
		"Roboto",
		"RobotoMono",
		"Ubuntu",
		"Oswald",
		"Nunito",
		"Bodoni",
		"Cartoon",
		"IndieFlower",
		"PatrickHand",
		"Antique",
		"Garamond",
		"Highway",
		"Legacy",
		"PermanentMarker",
		"Sarpanch",
		"SpecialElite",
		"Michroma",
	};
local function J()
	local N = math.clamp(o.ESP_FontIdx or 1, 1, #j);
	local G = Enum.Font[j[N]];
	if not G then
		G = Enum.Font.GothamBlack;
	end;
	return G;
end;
local function M(N)
	local G, V, z;
	if N > .75 then
		G, V, z = o.GuardESP_HP_State1_R or 74, o.GuardESP_HP_State1_G or 222, o.GuardESP_HP_State1_B or 74;
	elseif N > .5 then
		G, V, z = o.GuardESP_HP_State2_R or 255, o.GuardESP_HP_State2_G or 210, o.GuardESP_HP_State2_B or 60;
	elseif N > .25 then
		G, V, z = o.GuardESP_HP_State3_R or 255, o.GuardESP_HP_State3_G or 130, o.GuardESP_HP_State3_B or 40;
	else
		G, V, z = o.GuardESP_HP_State4_R or 255, o.GuardESP_HP_State4_G or 55, o.GuardESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(G, V, z);
end;
local function Z(N)
	local G, V, z;
	if N > .75 then
		G, V, z = o.PlayerESP_HP_State1_R or 74, o.PlayerESP_HP_State1_G or 222, o.PlayerESP_HP_State1_B or 74;
	elseif N > .5 then
		G, V, z = o.PlayerESP_HP_State2_R or 255, o.PlayerESP_HP_State2_G or 210, o.PlayerESP_HP_State2_B or 60;
	elseif N > .25 then
		G, V, z = o.PlayerESP_HP_State3_R or 255, o.PlayerESP_HP_State3_G or 130, o.PlayerESP_HP_State3_B or 40;
	else
		G, V, z = o.PlayerESP_HP_State4_R or 255, o.PlayerESP_HP_State4_G or 55, o.PlayerESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(G, V, z);
end;
local function r(N)
	if not N then
		return N;
	end;
	if x.unloaded then
		pcall(function()
			N:Disconnect();
		end);
		return N;
	end;
	table.insert(x.conns, N);
	return N;
end;
local function Y()
	return Color3.fromRGB(o.GuiR or 200, o.GuiG or 60, o.GuiB or 255);
end;
local function E()
	return Color3.fromRGB(o.GuiTextR or 235, o.GuiTextG or 225, o.GuiTextB or 250);
end;
local function A(N)
	return N:Lerp(Color3.new(0, 0, 0), .7);
end;
local function s()
	return Color3.fromRGB(o.RadiusR or 255, o.RadiusG or 70, o.RadiusB or 160);
end;
local function f()
	return Color3.fromRGB(i.RadiusR or 70, i.RadiusG or 210, i.RadiusB or 255);
end;
local function p()
	return Color3.fromRGB(o.CircleTextR or 255, o.CircleTextG or 255, o.CircleTextB or 255);
end;
local function B(N)
	local G = math.clamp(N, 1, 9);
	local V, z, v = 255, 60, 60;
	if G == 1 then
		V, z, v = o.FOVCustomR1 or 255, o.FOVCustomG1 or 60, o.FOVCustomB1 or 60;
	elseif G == 2 then
		V, z, v = o.FOVCustomR2 or 60, o.FOVCustomG2 or 255, o.FOVCustomB2 or 60;
	elseif G == 3 then
		V, z, v = o.FOVCustomR3 or 60, o.FOVCustomG3 or 140, o.FOVCustomB3 or 255;
	elseif G == 4 then
		V, z, v = o.FOVCustomR4 or 255, o.FOVCustomG4 or 255, o.FOVCustomB4 or 60;
	elseif G == 5 then
		V, z, v = o.FOVCustomR5 or 255, o.FOVCustomG5 or 60, o.FOVCustomB5 or 255;
	elseif G == 6 then
		V, z, v = o.FOVCustomR6 or 60, o.FOVCustomG6 or 255, o.FOVCustomB6 or 255;
	elseif G == 7 then
		V, z, v = o.FOVCustomR7 or 255, o.FOVCustomG7 or 180, o.FOVCustomB7 or 60;
	elseif G == 8 then
		V, z, v = o.FOVCustomR8 or 255, o.FOVCustomG8 or 255, o.FOVCustomB8 or 255;
	elseif G == 9 then
		V, z, v = o.FOVCustomR9 or 180, o.FOVCustomG9 or 60, o.FOVCustomB9 or 255;
	end;
	return Color3.fromRGB(V, z, v);
end;
local function I()
	if o.FOVUseCustom then
		return B(o.FOVCustomIdx or 1);
	end;
	return Color3.fromRGB(o.RebelFOVR or 255, o.RebelFOVG or 60, o.RebelFOVB or 60);
end;
local function k()
	return Color3.fromRGB(o.RebelFOV_OutlineR or 0, o.RebelFOV_OutlineG or 0, o.RebelFOV_OutlineB or 0);
end;
local function T()
	return Color3.fromRGB(o.GuardESP_ColorR or 255, o.GuardESP_ColorG or 50, o.GuardESP_ColorB or 50);
end;
local function Q()
	return Color3.fromRGB(o.PlayerESP_ColorR or 80, o.PlayerESP_ColorG or 255, o.PlayerESP_ColorB or 120);
end;
local function D()
	return Color3.fromRGB(o.GuardESP_TracerR or 255, o.GuardESP_TracerG or 50, o.GuardESP_TracerB or 50);
end;
local function X()
	return Color3.fromRGB(o.PlayerESP_TracerR or 80, o.PlayerESP_TracerG or 255, o.PlayerESP_TracerB or 120);
end;
local function K()
	return Color3.fromRGB(o.GuardESP_BoxR or 255, o.GuardESP_BoxG or 50, o.GuardESP_BoxB or 50);
end;
local function c()
	return Color3.fromRGB(o.PlayerESP_BoxR or 80, o.PlayerESP_BoxG or 255, o.PlayerESP_BoxB or 120);
end;
local function l()
	return Color3.fromRGB(o.GuardESP_SkeletonR or 255, o.GuardESP_SkeletonG or 50, o.GuardESP_SkeletonB or 50);
end;
local function u()
	return Color3.fromRGB(o.PlayerESP_SkeletonR or 80, o.PlayerESP_SkeletonG or 255, o.PlayerESP_SkeletonB or 120);
end;
local function e()
	return S(o.GuardESP_HP_TopR or 80, o.GuardESP_HP_TopG or 255, o.GuardESP_HP_TopB or 80, o.GuardESP_HP_M1R or 180, o.GuardESP_HP_M1G or 255, o.GuardESP_HP_M1B or 60, o.GuardESP_HP_M2R or 255, o.GuardESP_HP_M2G or 200, o.GuardESP_HP_M2B or 40, o.GuardESP_HP_M3R or 255, o.GuardESP_HP_M3G or 120, o.GuardESP_HP_M3B or 60, o.GuardESP_HP_BotR or 255, o.GuardESP_HP_BotG or 40, o.GuardESP_HP_BotB or 40);
end;
local function d()
	return S(o.PlayerESP_HP_TopR or 80, o.PlayerESP_HP_TopG or 255, o.PlayerESP_HP_TopB or 80, o.PlayerESP_HP_M1R or 180, o.PlayerESP_HP_M1G or 255, o.PlayerESP_HP_M1B or 60, o.PlayerESP_HP_M2R or 255, o.PlayerESP_HP_M2G or 200, o.PlayerESP_HP_M2B or 40, o.PlayerESP_HP_M3R or 255, o.PlayerESP_HP_M3G or 120, o.PlayerESP_HP_M3B or 60, o.PlayerESP_HP_BotR or 255, o.PlayerESP_HP_BotG or 40, o.PlayerESP_HP_BotB or 40);
end;
local function t()
	return Color3.fromRGB(o.GuardESP_HP_State1_R or 74, o.GuardESP_HP_State1_G or 222, o.GuardESP_HP_State1_B or 74);
end;
local function W()
	return Color3.fromRGB(o.GuardESP_HP_State2_R or 255, o.GuardESP_HP_State2_G or 210, o.GuardESP_HP_State2_B or 60);
end;
local function g()
	return Color3.fromRGB(o.GuardESP_HP_State3_R or 255, o.GuardESP_HP_State3_G or 130, o.GuardESP_HP_State3_B or 40);
end;
local function a()
	return Color3.fromRGB(o.GuardESP_HP_State4_R or 255, o.GuardESP_HP_State4_G or 55, o.GuardESP_HP_State4_B or 55);
end;
local function L()
	return Color3.fromRGB(o.PlayerESP_HP_State1_R or 74, o.PlayerESP_HP_State1_G or 222, o.PlayerESP_HP_State1_B or 74);
end;
local function U()
	return Color3.fromRGB(o.PlayerESP_HP_State2_R or 255, o.PlayerESP_HP_State2_G or 210, o.PlayerESP_HP_State2_B or 60);
end;
local function H()
	return Color3.fromRGB(o.PlayerESP_HP_State3_R or 255, o.PlayerESP_HP_State3_G or 130, o.PlayerESP_HP_State3_B or 40);
end;
local function Ni()
	return Color3.fromRGB(o.PlayerESP_HP_State4_R or 255, o.PlayerESP_HP_State4_G or 55, o.PlayerESP_HP_State4_B or 55);
end;
local function Gi(N)
	local G = "";
	for N = 1, N, 1 do
		G = G .. string.char(math.random(97, 122));
	end;
	return G;
end;
local function Vi(N, G)
	return N + ((math.random() * 2 - 1)) * ((G or .006));
end;
local zi = {};
local function vi(N)
	table.insert(zi, N);
end;
local function Ri()
	for N = 1, #zi, 1 do
		pcall(zi[N]);
	end;
end;
local function Ci()
	if x.unloaded then
		return;
	end;
	pcall(function()
		if not x.clickSound then
			x.clickSound = Instance.new("Sound");
			x.clickSound.SoundId = "rbxassetid://876939830";
			x.clickSound.Volume = .3;
			x.clickSound.Parent = b;
		end;
		x.clickSound.TimePosition = 0;
		x.clickSound:Play();
	end);
end;
local function bi(N, G)
	local V = Instance.new("UICorner");
	V.CornerRadius = UDim.new(0, G or 8);
	V.Parent = N;
	return V;
end;
local function yi(N, G, V, z)
	local v = Instance.new("UIGradient");
	v.Color = ColorSequence.new(G, V);
	v.Rotation = z or 90;
	v.Parent = N;
	return v;
end;
local function Pi(N, G, V, z)
	local v = Instance.new("UIStroke");
	v.Color = G or Color3.new(1, 1, 1);
	v.Thickness = V or 1;
	v.Transparency = z or 0;
	v.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	v.Parent = N;
	return v;
end;
local function Oi()
	if x.tracerGui and x.tracerGui.Parent then
		return;
	end;
	x.tracerGui = Instance.new("ScreenGui");
	x.tracerGui.Name = "XD_Tr_" .. Gi(6);
	x.tracerGui.IgnoreGuiInset = true;
	x.tracerGui.ResetOnSpawn = false;
	x.tracerGui.DisplayOrder = 99990;
	local N = nil;
	if gethui then
		local G, V = pcall(gethui);
		if G and (V and typeof(V) == "Instance") then
			N = V;
		end;
	end;
	if not N then
		N = F:FindFirstChildOfClass("PlayerGui");
	end;
	if not N then
		N = game:GetService("CoreGui");
	end;
	pcall(function()
		x.tracerGui.Parent = N;
	end);
	if not x.tracerGui.Parent then
		pcall(function()
			x.tracerGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local function qi()
	if x.overlayGui and x.overlayGui.Parent then
		return;
	end;
	x.overlayGui = Instance.new("ScreenGui");
	x.overlayGui.Name = "XD_Ov_" .. Gi(6);
	x.overlayGui.IgnoreGuiInset = true;
	x.overlayGui.ResetOnSpawn = false;
	x.overlayGui.DisplayOrder = 99985;
	local N = nil;
	if gethui then
		local G, V = pcall(gethui);
		if G and (V and typeof(V) == "Instance") then
			N = V;
		end;
	end;
	if not N then
		N = F:FindFirstChildOfClass("PlayerGui");
	end;
	if not N then
		N = game:GetService("CoreGui");
	end;
	pcall(function()
		x.overlayGui.Parent = N;
	end);
	if not x.overlayGui.Parent then
		pcall(function()
			x.overlayGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local Fi = {
		{ "Head", "Torso" },
		{ "Torso", "Left Arm" },
		{ "Torso", "Right Arm" },
		{ "Torso", "Left Leg" },
		{ "Torso", "Right Leg" },
		{ "Head", "HumanoidRootPart" },
	};
local ni = {
		{ "Head", "UpperTorso" },
		{ "UpperTorso", "LowerTorso" },
		{ "UpperTorso", "LeftUpperArm" },
		{ "LeftUpperArm", "LeftLowerArm" },
		{ "LeftLowerArm", "LeftHand" },
		{ "UpperTorso", "RightUpperArm" },
		{ "RightUpperArm", "RightLowerArm" },
		{ "RightLowerArm", "RightHand" },
		{ "LowerTorso", "LeftUpperLeg" },
		{ "LeftUpperLeg", "LeftLowerLeg" },
		{ "LeftLowerLeg", "LeftFoot" },
		{ "LowerTorso", "RightUpperLeg" },
		{ "RightUpperLeg", "RightLowerLeg" },
		{ "RightLowerLeg", "RightFoot" },
	};
local function mi(N)
	return (string.lower(tostring(N or ""))):gsub("[%s%-_%.]", "");
end;
local function xi(N, G)
	if not N or not G then
		return nil;
	end;
	local V = N:FindFirstChild(G);
	if V and V:IsA("BasePart") then
		return V;
	end;
	local z = mi(G);
	for N, G in ipairs(N:GetChildren()) do
		if G:IsA("BasePart") and mi(G.Name) == z then
			return G;
		end;
	end;
	for N, G in ipairs(N:GetDescendants()) do
		if G:IsA("BasePart") and (G.Parent ~= nil and mi(G.Name) == z) then
			return G;
		end;
	end;
	return nil;
end;
local function wi(N, G)
	if not N or not G then
		return nil;
	end;
	local V, z = math.huge, math.huge;
	local v, R = -math.huge, -math.huge;
	local C = false;
	for N, b in ipairs(N:GetDescendants()) do
		if b:IsA("BasePart") then
			local N, y = G:WorldToViewportPoint(b.Position);
			if y then
				C = true;
				if N.X < V then
					V = N.X;
				end;
				if N.Y < z then
					z = N.Y;
				end;
				if N.X > v then
					v = N.X;
				end;
				if N.Y > R then
					R = N.Y;
				end;
			end;
		end;
	end;
	if not C then
		return nil;
	end;
	return V, z, v, R;
end;
local function hi()
	if x.infoGui and x.infoGui.Parent then
		return;
	end;
	x.infoGui = Instance.new("ScreenGui");
	x.infoGui.Name = "XD_I_" .. Gi(6);
	x.infoGui.IgnoreGuiInset = true;
	x.infoGui.ResetOnSpawn = false;
	x.infoGui.DisplayOrder = 99995;
	local N = nil;
	if gethui then
		local G, V = pcall(gethui);
		if G and (V and typeof(V) == "Instance") then
			N = V;
		end;
	end;
	if not N then
		N = F:FindFirstChildOfClass("PlayerGui");
	end;
	if not N then
		N = game:GetService("CoreGui");
	end;
	pcall(function()
		x.infoGui.Parent = N;
	end);
	if not x.infoGui.Parent then
		pcall(function()
			x.infoGui.Parent = game:GetService("CoreGui");
		end);
	end;
	x.wmFrame = Instance.new("Frame");
	x.wmFrame.AnchorPoint = Vector2.new(1, 0);
	x.wmFrame.Position = UDim2.new(1, -12, 0, 12);
	x.wmFrame.Size = UDim2.fromOffset(210, 52);
	x.wmFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	x.wmFrame.BackgroundTransparency = .25;
	x.wmFrame.BorderSizePixel = 0;
	x.wmFrame.ZIndex = 10;
	x.wmFrame.Parent = x.infoGui;
	bi(x.wmFrame, 6);
	local G = Instance.new("UIStroke");
	G.Color = Y();
	G.Thickness = 1.2;
	G.Transparency = .3;
	G.Parent = x.wmFrame;
	vi(function()
		G.Color = Y();
	end);
	x.wmLabel = Instance.new("TextLabel");
	x.wmLabel.Size = UDim2.new(1, -12, 1, -4);
	x.wmLabel.Position = UDim2.fromOffset(6, 2);
	x.wmLabel.BackgroundTransparency = 1;
	x.wmLabel.Font = Enum.Font.Code;
	x.wmLabel.TextSize = 11;
	x.wmLabel.TextXAlignment = Enum.TextXAlignment.Left;
	x.wmLabel.TextYAlignment = Enum.TextYAlignment.Top;
	x.wmLabel.TextColor3 = Color3.fromRGB(220, 220, 240);
	x.wmLabel.TextStrokeTransparency = .4;
	x.wmLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	x.wmLabel.Text = n;
	x.wmLabel.ZIndex = 11;
	x.wmLabel.Parent = x.wmFrame;
	x.kbFrame = Instance.new("Frame");
	x.kbFrame.AnchorPoint = Vector2.new(1, 0);
	x.kbFrame.Position = UDim2.new(1, -12, 0, 72);
	x.kbFrame.Size = UDim2.fromOffset(210, 100);
	x.kbFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	x.kbFrame.BackgroundTransparency = .25;
	x.kbFrame.BorderSizePixel = 0;
	x.kbFrame.ZIndex = 10;
	x.kbFrame.Parent = x.infoGui;
	bi(x.kbFrame, 6);
	local V = Instance.new("UIStroke");
	V.Color = Y();
	V.Thickness = 1.2;
	V.Transparency = .3;
	V.Parent = x.kbFrame;
	vi(function()
		V.Color = Y();
	end);
	x.kbLabel = Instance.new("TextLabel");
	x.kbLabel.Size = UDim2.new(1, -12, 1, -4);
	x.kbLabel.Position = UDim2.fromOffset(6, 2);
	x.kbLabel.BackgroundTransparency = 1;
	x.kbLabel.Font = Enum.Font.Code;
	x.kbLabel.TextSize = 10;
	x.kbLabel.TextXAlignment = Enum.TextXAlignment.Left;
	x.kbLabel.TextYAlignment = Enum.TextYAlignment.Top;
	x.kbLabel.TextColor3 = Color3.fromRGB(200, 200, 220);
	x.kbLabel.TextStrokeTransparency = .5;
	x.kbLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	x.kbLabel.Text = "[no features]";
	x.kbLabel.ZIndex = 11;
	x.kbLabel.Parent = x.kbFrame;
end;
local function Si()
	if not x.infoGui then
		return;
	end;
	if x.wmFrame then
		x.wmFrame.Visible = o.Watermark and true or false;
	end;
	if x.kbFrame then
		x.kbFrame.Visible = o.KeybindList and true or false;
	end;
end;
local oi = {
		"76323709902827",
		"132207921464999",
		"72649558888714",
		"84036894358514",
		"103062305177426",
		"79649041083405",
		"73242877658272",
		"121147456137931",
		"105341857343164",
		"116839849594540",
		"96924216250322",
		"85793691404836",
		"86197206792061",
		"104041807075625",
		"114928327045353",
		"135690448001690",
		"103355259844069",
		"128452090955120",
		"71000246338579",
		"125906547773381",
		"107989020363293",
		"85623602463927",
		"87978085217719",
		"112950478995075",
		"94443309383954",
		"81766558426599",
		"90654171377736",
		"72128148665361",
		"94960826047243",
		"114769224376981",
		"92844369847738",
		"106908462496291",
		"109822392402606",
		"119784367902126",
		"89439896387299",
		"132070051408308",
		"131235569946744",
		"123834203617100",
		"98785078701251",
		"103318207627541",
		"99844967459345",
		"101703309225906",
		"97863204720378",
		"137824029524579",
		"87041753984253",
		"81533666958052",
		"79549040943367",
		"81392013026663",
		"77595339119545",
		"75611037033634",
		"123370871049938",
		"106756593687295",
		"128733894961951",
		"137659772694747",
		"93105538774923",
		"129324788590686",
		"134675465964672",
		"85285032162865",
		"125283605050829",
		"93373403484012",
		"108262048142532",
		"106370995610424",
		"114617637295467",
		"115386570583557",
		"70775136168849",
		"72557176302052",
		"94215646393565",
		"73150160715773",
		"7052329948932",
		"9915750592076",
		"85743982894847",
		"82579449181823",
		"114687917628569",
		"9915750926076",
		"99157505926076",
	};
local ii = {
		"84075526494569",
		"112693580156198",
		"116089915329773",
		"123441836092792",
		"76593886937703",
		"71214385249268",
		"91345240826151",
		"107476375951001",
		"97049872073368",
		"73421886855742",
		"140302976506103",
		"108126144370302",
		"115836393562566",
		"102891247801142",
		"73748962069265",
		"88654124229687",
		"12214474272195",
	};
local ji = {
		["131235569946744"] = .9,
		["114687917628569"] = 3.4,
		["115386570583557"] = .6,
		["70775136168849"] = .7,
		["132207921464999"] = .4,
	};
local Ji, Mi = {}, {};
for N = 1, #oi, 1 do
	Ji[oi[N]] = true;
	x.animEnabled[oi[N]] = true;
end;
for N = 1, #ii, 1 do
	Mi[ii[N]] = true;
	x.animEnabled[ii[N]] = false;
end;
local Zi = {
		["power hold"] = true,
		powerhold = true,
		power_hold = true,
		["pocket sand"] = true,
		pocketsand = true,
		pocket_sand = true,
		sand = true,
	};
local function ri(N)
	if not N then
		return false;
	end;
	local G = (tostring(N)):match("%d+");
	if not G then
		return false;
	end;
	if Mi[G] then
		return false;
	end;
	if Ji[G] then
		return x.animEnabled[G] ~= false;
	end;
	for N in pairs(Ji) do
		if x.animEnabled[N] ~= false and (not Mi[N] and ((G:find(N, 1, true) or N:find(G, 1, true)))) then
			return true;
		end;
	end;
	return false;
end;
local function Yi(N)
	if not N then
		return "";
	end;
	for N, G in ipairs(N:GetChildren()) do
		if G:IsA("Tool") then
			return G.Name;
		end;
	end;
	local G = N:FindFirstChildOfClass("Humanoid");
	if G then
		for N, G in ipairs(G:GetChildren()) do
			if G:IsA("Tool") then
				return G.Name;
			end;
		end;
	end;
	local V = N:GetAttribute("HoldingWeapon");
	if type(V) == "string" and V ~= "" then
		local G = N:FindFirstChild(V);
		if G then
			return G.Name;
		end;
		return V;
	end;
	return "";
end;
local function Ei(N)
	if not N then
		return false;
	end;
	for N, G in ipairs(N:GetChildren()) do
		if G:IsA("Tool") then
			local N = string.lower(G.Name);
			for G in pairs(Zi) do
				if N:find(G, 1, true) then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function Ai(N)
	if not N then
		return false;
	end;
	for N, G in ipairs(N:GetDescendants()) do
		if G:IsA("ParticleEmitter") or G:IsA("Smoke") then
			local N = string.lower(G.Name);
			if N:find("sand", 1, true) or N:find("dust", 1, true) or N:find("dirt", 1, true) then
				if G.Enabled then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function si(N)
	if not N or not N:IsA("Tool") then
		return false;
	end;
	local G = string.lower(N.Name);
	if G:find("ultra", 1, true) or G:find("instinct", 1, true) then
		return false;
	end;
	return G:find("dodge", 1, true) ~= nil;
end;
local fi = {
		["1"] = 49,
		["2"] = 50,
		["3"] = 51,
		["4"] = 52,
		["5"] = 53,
		["6"] = 54,
		["7"] = 55,
		["8"] = 56,
		["9"] = 57,
		["0"] = 48,
		e = 69,
		t = 84,
		y = 89,
		r = 82,
		f = 70,
		q = 81,
		g = 71,
		space = 32,
	};
local pi = {
		["1"] = 1,
		["2"] = 1,
		["3"] = 1,
		["4"] = 1,
		["5"] = 1,
		["6"] = 1,
		["7"] = 1,
		["8"] = 1,
		["9"] = 1,
		["0"] = 1,
		E = 1,
		T = 1,
		Y = 1,
		Q = 1,
		F = 1,
		R = 1,
		G = 1,
	};
local Bi = (type(keypress) == "function" and type(keyrelease) == "function");
local function Ii(N)
	if x.unloaded then
		return;
	end;
	N = string.lower(tostring(N or "t"));
	local G = fi[N];
	if not G then
		return;
	end;
	if Bi then
		pcall(function()
			keypress(G);
			task.delay(Vi(.006, .002), function()
				pcall(function()
					keyrelease(G);
				end);
			end);
		end);
	else
		pcall(function()
			local G = game:GetService("VirtualInputManager");
			local V = Enum.KeyCode[string.upper(N)] or Enum.KeyCode.T;
			G:SendKeyEvent(true, V, false, game);
			task.delay(Vi(.006, .002), function()
				pcall(function()
					G:SendKeyEvent(false, V, false, game);
				end);
			end);
		end);
	end;
end;
local function ki()
	if x.unloaded then
		return;
	end;
	local N = G.CurrentCamera;
	local V = (N and N.ViewportSize) or Vector2.new(800, 600);
	local z = math.floor(V.X / 2);
	local v = math.floor(V.Y / 2);
	local R = false;
	pcall(function()
		if mouse1click then
			mouse1click();
			R = true;
		end;
	end);
	if R then
		return;
	end;
	pcall(function()
		if mouse1press and mouse1release then
			mouse1press();
			task.wait(.03);
			mouse1release();
			R = true;
		end;
	end);
	if R then
		return;
	end;
	pcall(function()
		local N = game:GetService("VirtualInputManager");
		N:SendMouseButtonEvent(z, v, 0, true, game, 1);
		task.wait(.03);
		N:SendMouseButtonEvent(z, v, 0, false, game, 1);
	end);
end;
local function Ti(N, G, V)
	if V and V ~= "" then
		local N = string.upper(tostring(V));
		if pi[N] then
			return N;
		end;
	end;
	return G;
end;
local function Qi(N)
	local G = string.lower(tostring(N or ""));
	return G:find("ultra", 1, true) ~= nil or G:find("instinct", 1, true) ~= nil;
end;
local function Di()
	local function N(N)
		if not N then
			return nil;
		end;
		for N, G in ipairs(N:GetChildren()) do
			if G:IsA("Tool") and Qi(G.Name) then
				return G;
			end;
		end;
		return nil;
	end;
	return N(F.Character) or N(F:FindFirstChild("Backpack"));
end;
local function Xi()
	local function N(N)
		if not N then
			return nil;
		end;
		for N, G in ipairs(N:GetChildren()) do
			if si(G) then
				return G;
			end;
		end;
		return nil;
	end;
	return N(F.Character) or N(F:FindFirstChild("Backpack"));
end;
local function Ki()
	if x.unloaded or not o.Enabled then
		return;
	end;
	local N = tick();
	if N - x.lastDodgeUI < ((o.MinInterval or .02)) then
		return;
	end;
	x.lastDodgeUI = N;
	local G = x.cachedSlot or "T";
	local V = o.Delay or 0;
	if V > 0 then
		task.delay(V, function()
			if not x.unloaded and o.Enabled then
				Ii(G);
			end;
		end);
	else
		Ii(G);
	end;
end;
local function ci()
	if x.unloaded or not i.Enabled then
		return;
	end;
	local N = tick();
	if N - x.lastDodgeH < ((i.MinInterval or .02)) then
		return;
	end;
	x.lastDodgeH = N;
	local G = x.cachedDodgeTool or Xi();
	local V = x.cachedDodgeSlot or "1";
	local z = i.Delay or 0;
	local function v()
		if x.unloaded or not i.Enabled then
			return;
		end;
		local N = F.Character;
		local z = N and N:FindFirstChildOfClass("Humanoid");
		if G and z then
			Ii(V);
			task.wait(.06);
			if G.Parent ~= N then
				pcall(function()
					z:EquipTool(G);
				end);
				task.wait(.06);
			end;
			pcall(function()
				G:Activate();
			end);
			task.wait(.02);
			ki();
			task.wait(.04);
			ki();
		else
			Ii(V);
			task.wait(.05);
			ki();
		end;
	end;
	if z > 0 then
		task.delay(z, v);
	else
		v();
	end;
end;
local function li(N, G, V, z)
	if not N or not G then
		return false;
	end;
	if G.Parent == F.Character then
		return false;
	end;
	local v = N.Position.X - G.Position.X;
	local R = N.Position.Z - G.Position.Z;
	local C = N.Position.Y - G.Position.Y;
	if math.abs(C) > 7 then
		return false;
	end;
	local b = v * v + R * R;
	local y = ((V or 18)) + ((z or 0));
	if b > y * y then
		return false;
	end;
	return true, math.sqrt(b);
end;
local function ui()
	for N, G in pairs(x.hooks) do
		pcall(function()
			G:Disconnect();
		end);
	end;
	table.clear(x.hooks);
end;
local function ei()
	return o.Enabled or i.Enabled;
end;
local function di(N, G, V)
	if x.unloaded or not ei() then
		return;
	end;
	if not G or not G.Parent then
		return;
	end;
	local z = _G.__adWatchers[G];
	if not z then
		z = { c = 0 };
		_G.__adWatchers[G] = z;
	end;
	if z.c >= 3 then
		return;
	end;
	z.c = z.c + 1;
	local R = V and 8 or 0;
	local C = false;
	local b = false;
	local y = false;
	if i.Enabled then
		if not i.HollyMode then
			y = true;
		elseif V then
			y = true;
		elseif N and (N.Animation and ri(N.Animation.AnimationId)) then
			y = true;
		end;
	end;
	local P = 0;
	if N and (N.Animation and not V) then
		local G = (tostring(N.Animation.AnimationId)):match("%d+");
		if G and ji[G] then
			P = ji[G];
		end;
	end;
	local O = 0;
	if N then
		local G, V = pcall(function()
				return N.Length;
			end);
		if G and (tonumber(V) and V > 0) then
			O = V;
		end;
	end;
	if not o.Enabled then
		C = true;
	end;
	if not i.Enabled or not y then
		b = true;
	end;
	if C and b then
		z.c = z.c - 1;
		if z.c <= 0 then
			_G.__adWatchers[G] = nil;
		end;
		return;
	end;
	local q = tick();
	local n = math.max(o.AnimWatch or .4, O + ((o.WatchAfter or .3)));
	local m = math.max(i.AnimWatch or .4, O + ((i.WatchAfter or .3)));
	local w = math.max(n + P, m + P);
	local h;
	local function S()
		if h then
			pcall(function()
				h:Disconnect();
			end);
			h = nil;
		end;
		z.c = z.c - 1;
		if z.c <= 0 then
			_G.__adWatchers[G] = nil;
		end;
	end;
	local function j()
		if x.unloaded or (C and b) then
			S();
			return;
		end;
		if tick() - q > w then
			S();
			return;
		end;
		local N = F.Character and F.Character:FindFirstChild("HumanoidRootPart");
		if not N or not G or not G.Parent then
			S();
			return;
		end;
		local V = tick() - q;
		local z = o.Distance or 18;
		local v = i.Distance or 18;
		local O = G.AssemblyLinearVelocity;
		local n = math.sqrt(O.X * O.X + O.Z * O.Z);
		if n > 15 then
			local V = N.Position.X - G.Position.X;
			local R = N.Position.Z - G.Position.Z;
			local C = math.sqrt(V * V + R * R);
			if C > .5 then
				local N = ((O.X * V + O.Z * R)) / ((C * n));
				if N > .5 then
					local N = n * .2;
					z = z + N;
					v = v + N;
				end;
			end;
		end;
		if o.Enabled and (not C and V >= P) then
			if li(N, G, z, R) then
				C = true;
				Ki();
			end;
		end;
		if i.Enabled and (y and (not b and V >= P)) then
			if li(N, G, v, R) then
				b = true;
				ci();
			end;
		end;
		if C and b then
			S();
		end;
	end;
	h = v.Heartbeat:Connect(j);
end;
local function ti(N, G)
	if not N or x.hooks[N] then
		return;
	end;
	x.hooks[N] = N.Activated:Connect(function()
			if x.unloaded or not ei() then
				return;
			end;
			if Ei(G.Parent) then
				di(nil, G, true);
			end;
		end);
end;
local function Wi(N, G)
	if x.hooks[N] or x.unloaded then
		return;
	end;
	x.hooks[N] = N.AnimationPlayed:Connect(function(N)
			if x.unloaded or not ei() then
				return;
			end;
			if not N or not N.Animation then
				return;
			end;
			if G.Parent == F.Character then
				return;
			end;
			local V = (tostring(N.Animation.AnimationId)):match("%d+");
			if V and Mi[V] then
				return;
			end;
			if ri(N.Animation.AnimationId) then
				di(N, G, false);
				return;
			end;
			local z = G.Parent;
			if Ei(z) and Ai(z) then
				di(N, G, true);
			end;
		end);
end;
local function gi(N)
	if x.unloaded or not N or N == F.Character then
		return;
	end;
	local G = N:FindFirstChildOfClass("Humanoid");
	local V = N:FindFirstChild("HumanoidRootPart");
	if not G or not V then
		return;
	end;
	local z = G:FindFirstChildOfClass("Animator");
	if z then
		Wi(z, V);
	else
		local N;
		N = G.ChildAdded:Connect(function(G)
				if G:IsA("Animator") then
					Wi(G, V);
					pcall(function()
						N:Disconnect();
					end);
				end;
			end);
		table.insert(x.hooks, N);
	end;
	for N, G in ipairs(N:GetChildren()) do
		if G:IsA("Tool") then
			ti(G, V);
		end;
	end;
	local v;
	v = N.ChildAdded:Connect(function(N)
			if N:IsA("Tool") then
				ti(N, V);
			end;
		end);
	table.insert(x.hooks, v);
end;
local function ai()
	if x.unloaded then
		return;
	end;
	ui();
	for N, G in ipairs(N:GetPlayers()) do
		if G ~= F then
			if G.Character then
				gi(G.Character);
			end;
			if not x.added[G] then
				x.added[G] = G.CharacterAdded:Connect(function(N)
						if ei() and not x.unloaded then
							task.wait(.15);
							gi(N);
						end;
					end);
			end;
		end;
	end;
	if not x.added._j then
		x.added._j = N.PlayerAdded:Connect(function(N)
				if x.unloaded then
					return;
				end;
				x.added[N] = N.CharacterAdded:Connect(function(N)
						if ei() and not x.unloaded then
							task.wait(.15);
							gi(N);
						end;
					end);
			end);
	end;
	if not x.added._r then
		x.added._r = N.PlayerRemoving:Connect(function(N)
				if x.added[N] then
					pcall(function()
						x.added[N]:Disconnect();
					end);
					x.added[N] = nil;
				end;
			end);
	end;
end;
local function Li()
	if ei() then
		ai();
	else
		ui();
	end;
end;
local function Ui(N)
	if not N then
		return nil;
	end;
	local G = {};
	local function V(V)
		for V, z in ipairs(V) do
			local v = xi(N, z);
			if v then
				table.insert(G, v);
				return;
			end;
		end;
	end;
	if o.RebelBodyHead then
		V({ "Head" });
	end;
	if o.RebelBodyTorso then
		V({ "Torso", "UpperTorso", "LowerTorso" });
	end;
	if o.RebelBodyHRP then
		V({ "HumanoidRootPart" });
	end;
	if o.RebelBodyLeftArm then
		V({ "Left Arm", "LeftUpperArm", "LeftLowerArm" });
	end;
	if o.RebelBodyRightArm then
		V({ "Right Arm", "RightUpperArm", "RightLowerArm" });
	end;
	if o.RebelBodyLeftLeg then
		V({ "Left Leg", "LeftUpperLeg", "LeftLowerLeg" });
	end;
	if o.RebelBodyRightLeg then
		V({ "Right Leg", "RightUpperLeg", "RightLowerLeg" });
	end;
	if #G == 0 then
		return N:FindFirstChild("Head") or N:FindFirstChild("HumanoidRootPart");
	end;
	return G[math.random(1, #G)];
end;
local function Hi(N)
	if not N then
		return false;
	end;
	if ((o.RebelFOV or 0)) <= 0 then
		return true;
	end;
	local V = G.CurrentCamera;
	if not V then
		return false;
	end;
	local z, v = V:WorldToViewportPoint(N.Position);
	if not v then
		return false;
	end;
	local R = V.ViewportSize.X / 2;
	local C = V.ViewportSize.Y / 2;
	local b = z.X - R;
	local y = z.Y - C;
	return math.sqrt(b * b + y * y) <= o.RebelFOV;
end;
local function NO(G)
	if not G or G == F.Character or not G.Parent then
		return false;
	end;
	if not G:IsA("Model") then
		return false;
	end;
	local V = G:FindFirstChildOfClass("Humanoid");
	if not V or V.Health <= 0 then
		return false;
	end;
	local z = G:FindFirstChild("HumanoidRootPart");
	if not z then
		return false;
	end;
	local v = F:GetAttribute("IsGuard") == true;
	local R = N:GetPlayerFromCharacter(G);
	if v then
		local N = G:FindFirstChild("GuardCanKill") or z:FindFirstChild("GuardCanKillLockOn") or z:FindFirstChild("GuardCanKillLockOut");
		if N then
			return true;
		end;
		if o.RebelTargetPlayers and (R and (R ~= F and R:GetAttribute("IsGuard") ~= true)) then
			return true;
		end;
	else
		if o.RebelTargetPlayers and (R and (R ~= F and R:GetAttribute("IsGuard") == true)) then
			return true;
		end;
		if o.RebelTargetNPCs then
			if G.Name:match("Guard") then
				return true;
			end;
			if G:FindFirstChild("TypeOfGuard") then
				return true;
			end;
			local N = G:FindFirstChild("GuardCanKill") or z:FindFirstChild("GuardCanKillLockOut") or z:FindFirstChild("GuardCanKillLockOn");
			if N then
				return true;
			end;
		end;
	end;
	return false;
end;
local function GO(V)
	local z = G.CurrentCamera;
	if not z then
		return nil;
	end;
	local v = z.ViewportSize.X / 2;
	local R = z.ViewportSize.Y / 2;
	local C, b = nil, math.huge;
	local y = {};
	local function P(N)
		if not N or y[N] then
			return;
		end;
		y[N] = true;
		if not NO(N) then
			return;
		end;
		local G = Ui(N);
		if not G or not Hi(G) then
			return;
		end;
		local V, P = z:WorldToViewportPoint(G.Position);
		if not P then
			return;
		end;
		local O = V.X - v;
		local q = V.Y - R;
		local F = math.sqrt(O * O + q * q);
		if F < b then
			b = F;
			C = G;
		end;
	end;
	local O = G:FindFirstChild("Live");
	if O then
		for N, G in ipairs(O:GetChildren()) do
			if G:IsA("Model") then
				P(G);
			end;
		end;
	end;
	local q = G:FindFirstChild("Characters");
	if q then
		for N, G in ipairs(q:GetChildren()) do
			if G:IsA("Model") then
				P(G);
			end;
		end;
	end;
	for N, G in ipairs(N:GetPlayers()) do
		if G ~= F and G.Character then
			P(G.Character);
		end;
	end;
	return C;
end;
local function VO()
	if x.combatHooked then
		return;
	end;
	local N = O;
	local G = N:FindFirstChild("Modules");
	if not G then
		pcall(function()
			G = N:WaitForChild("Modules", 2);
		end);
	end;
	if not G then
		return;
	end;
	local V = G:FindFirstChild("GunFunctions");
	if not V then
		pcall(function()
			V = G:WaitForChild("GunFunctions", 2);
		end);
	end;
	if not V then
		return;
	end;
	local z, v = pcall(require, V);
	if not z or not v or type(v) ~= "table" then
		return;
	end;
	x.gunMod = v;
	x.origFiredGun = v.FiredGun;
	x.origGetBuffs = v.GetBuffs;
	if type(x.origFiredGun) == "function" then
		v.FiredGun = function(N, G, V, ...)
				if x.unloaded or not o.RebelSilentAim then
					return x.origFiredGun(N, G, V, ...);
				end;
				if N ~= F.Character then
					return x.origFiredGun(N, G, V, ...);
				end;
				V = V or {};
				local z = N and N:FindFirstChild("HumanoidRootPart");
				if not z then
					return x.origFiredGun(N, G, V, ...);
				end;
				local v = z.Position;
				pcall(function()
					local G = N:GetAttribute("HoldingWeapon");
					if G then
						local V = N:FindFirstChild(G);
						if V then
							local N = V:FindFirstChild("FireFrom");
							if N then
								v = N.Position;
							end;
						end;
					end;
				end);
				local R = GO(v);
				if R then
					G = R.Position;
					V.CustomFireFrom = true;
					V.spread = 0;
				end;
				return x.origFiredGun(N, G, V, ...);
			end;
	end;
	if type(x.origGetBuffs) == "function" then
		v.GetBuffs = function(...)
				local N = x.origGetBuffs(...);
				if type(N) ~= "table" then
					N = {};
				end;
				local G = {};
				for N, V in pairs(N) do
					G[N] = V;
				end;
				if o.RebelNoRecoil then
					G.RecoilDiv = 999999;
				end;
				if o.RebelRapidFire then
					G.FireRateMult = 9999;
				end;
				return G;
			end;
	end;
	x.combatHooked = true;
end;
local function zO()
	if not x.combatHooked or not x.gunMod then
		return;
	end;
	pcall(function()
		if x.origFiredGun then
			x.gunMod.FiredGun = x.origFiredGun;
		end;
		if x.origGetBuffs then
			x.gunMod.GetBuffs = x.origGetBuffs;
		end;
	end);
	x.combatHooked = false;
end;
local function vO()
	if x.fovGui then
		pcall(function()
			x.fovGui:Destroy();
		end);
	end;
	x.fovGui = nil;
	x.fovFrame = nil;
	x.fovStroke = nil;
end;
local function RO()
	if x.fovRainbowConn then
		pcall(function()
			x.fovRainbowConn:Disconnect();
		end);
		x.fovRainbowConn = nil;
	end;
end;
local function CO()
	if not x.fovFrame then
		return;
	end;
	for N, G in ipairs(x.fovFrame:GetChildren()) do
		if G:IsA("Frame") then
			for N, G in ipairs(G:GetChildren()) do
				if G:IsA("UIStroke") then
					local N = G:FindFirstChildOfClass("UIGradient");
					if N then
						N:Destroy();
					end;
				end;
			end;
		end;
	end;
	if x.fovStroke then
		local N = x.fovStroke:FindFirstChildOfClass("UIGradient");
		if N then
			N:Destroy();
		end;
	end;
end;
local function bO(N, G, V, z, v, R)
	local C = B(1);
	local b = B(2);
	local y = B(3);
	local P = B(4);
	local O = ColorSequence.new({
			ColorSequenceKeypoint.new(0, N),
			ColorSequenceKeypoint.new(.11, G),
			ColorSequenceKeypoint.new(.22, V),
			ColorSequenceKeypoint.new(.33, z),
			ColorSequenceKeypoint.new(.44, v),
			ColorSequenceKeypoint.new(.55, C),
			ColorSequenceKeypoint.new(.66, b),
			ColorSequenceKeypoint.new(.77, y),
			ColorSequenceKeypoint.new(.88, P),
			ColorSequenceKeypoint.new(1, N),
		});
	for N, G in ipairs(x.fovFrame:GetChildren()) do
		if G:IsA("Frame") and (G.Name ~= "BlackOuter" and G.Name ~= "BlackInner") then
			for N, G in ipairs(G:GetChildren()) do
				if G:IsA("UIStroke") and (G.Name ~= "BlackStrokeOuter" and (G.Name ~= "BlackStrokeInner" and G.Name ~= "InnerStroke")) then
					local N = G:FindFirstChildOfClass("UIGradient");
					if not N then
						N = Instance.new("UIGradient");
						N.Parent = G;
					end;
					N.Color = O;
					N.Rotation = R;
				end;
			end;
		end;
	end;
	if x.fovStroke then
		local N = x.fovStroke:FindFirstChildOfClass("UIGradient");
		if not N then
			N = Instance.new("UIGradient");
			N.Parent = x.fovStroke;
		end;
		N.Color = O;
		N.Rotation = R;
	end;
end;
local function yO()
	RO();
	x.fovRainbowConn = v.RenderStepped:Connect(function()
			if x.unloaded or not o.FOVRainbow then
				return;
			end;
			if not x.fovFrame or not x.fovFrame.Parent then
				return;
			end;
			local N = tick();
			local G = o.FOVRainbowMode or 1;
			local V = o.FOVUseCustom;
			local z = tonumber(o.RebelFOVBlendSpeed) or .5;
			if G ~= 6 then
				CO();
			end;
			if G == 6 then
				local G = B(5);
				local V = B(6);
				local v = B(7);
				local R = B(8);
				local C = B(9);
				bO(G, V, v, R, C, (((N * z) * 60)) % 360);
				return;
			end;
			local v;
			if G == 1 then
				if V then
					local G = B(1);
					local V = B(2);
					v = G:Lerp(V, .5 + .5 * math.sin((N * z) * 2));
				else
					v = Color3.fromHSV(((N * .35)) % 1, 1, 1);
				end;
			elseif G == 2 then
				if V then
					local G = B(1);
					local V = B(2);
					v = G:Lerp(V, .5 + .5 * math.sin((N * z) * 3));
				else
					v = Color3.fromHSV(((N * .2)) % 1, 1, .7 + .3 * math.sin(N * 3));
				end;
			elseif G == 3 then
				if V then
					local G = B(1);
					local V = B(2);
					local R = B(3);
					local C = .5 + .5 * math.sin((N * z) * 1.8);
					local b = .5 + .5 * math.sin((N * z) * 2.6 + 1.7);
					v = (G:Lerp(V, C)):Lerp(R, b * .5);
				else
					local G = Color3.fromHSV(((N * .4)) % 1, 1, 1);
					local V = Color3.fromHSV(((N * .4 + .5)) % 1, 1, 1);
					v = G:Lerp(V, .5 + .5 * math.sin(N * 2.2));
				end;
			elseif G == 4 then
				if V then
					local G = B(1);
					local V = B(2);
					v = G:Lerp(V, .5 + .5 * math.sin((N * z) * 3.5));
				else
					v = Color3.fromHSV(((N * .15)) % 1, .9, .55 + .45 * ((.5 + .5 * math.sin(N * 3.5))));
				end;
			elseif G == 5 then
				if V then
					local G = B(1);
					local V = B(2);
					local R = B(3);
					local C = B(4);
					local b = .5 + .5 * math.sin((N * z) * 1.6);
					local y = .5 + .5 * math.sin((N * z) * 2.3 + 1.7);
					v = ((G:Lerp(V, b)):Lerp(R, y * .4)):Lerp(C, b * .3);
				else
					local G = Color3.fromHSV(((N * .25)) % 1, 1, 1);
					local V = Color3.fromHSV(((N * .25 + .5)) % 1, 1, 1);
					local z = Color3.fromHSV(((N * .25 + .75)) % 1, .9, 1);
					local R = .5 + .5 * math.sin(N * 1.6);
					local C = .5 + .5 * math.sin(N * 2.3 + 1.7);
					v = (G:Lerp(V, R)):Lerp(z, C * .4);
				end;
			end;
			if v then
				for N, G in ipairs(x.fovFrame:GetChildren()) do
					if G:IsA("Frame") then
						for N, G in ipairs(G:GetChildren()) do
							if G:IsA("UIStroke") and (G.Name ~= "BlackStrokeOuter" and G.Name ~= "BlackStrokeInner") then
								G.Color = v;
							end;
						end;
					end;
				end;
				if x.fovStroke then
					x.fovStroke.Color = v;
				end;
			end;
		end);
end;
local function PO()
	if x.panelRainbowConn then
		pcall(function()
			x.panelRainbowConn:Disconnect();
		end);
		x.panelRainbowConn = nil;
	end;
end;
local function OO()
	PO();
	x.panelRainbowConn = v.RenderStepped:Connect(function()
			if x.unloaded or not o.PanelRainbow then
				return;
			end;
			if not x.panel or not x.panel.Parent then
				return;
			end;
			local N = Color3.fromHSV(((tick() * .15)) % 1, 1, 1);
			local G = x.panel:FindFirstChildOfClass("UIStroke");
			if G then
				G.Color = N;
			end;
		end);
end;
local function qO()
	vO();
	if not o.RebelFOVCircle then
		return;
	end;
	local N = nil;
	if gethui then
		local G, V = pcall(gethui);
		if G and (V and typeof(V) == "Instance") then
			N = V;
		end;
	end;
	if not N then
		N = F:FindFirstChildOfClass("PlayerGui");
	end;
	if not N then
		N = game:GetService("CoreGui");
	end;
	x.fovGui = Instance.new("ScreenGui");
	x.fovGui.Name = "XD_FOV_" .. Gi(6);
	x.fovGui.IgnoreGuiInset = true;
	x.fovGui.ResetOnSpawn = false;
	x.fovGui.DisplayOrder = 99998;
	pcall(function()
		x.fovGui.Parent = N;
	end);
	if not x.fovGui.Parent then
		pcall(function()
			x.fovGui.Parent = game:GetService("CoreGui");
		end);
	end;
	local G = math.max(4, ((o.RebelFOV or 150)) * 2);
	local V = math.floor(G / 2);
	local z = o.RebelFOV_OutlineThickness or 5;
	x.fovFrame = Instance.new("Frame");
	x.fovFrame.BackgroundTransparency = 1;
	x.fovFrame.AnchorPoint = Vector2.new(.5, .5);
	x.fovFrame.Position = UDim2.new(.5, 0, .5, 0);
	x.fovFrame.Size = UDim2.fromOffset(G, G);
	x.fovFrame.ZIndex = 1000;
	x.fovFrame.Parent = x.fovGui;
	bi(x.fovFrame, V);
	if o.RebelFOVBlackOutline then
		local N = Instance.new("Frame");
		N.Name = "BlackOuter";
		N.BackgroundTransparency = 1;
		N.Size = UDim2.fromScale(1, 1);
		N.AnchorPoint = Vector2.new(.5, .5);
		N.Position = UDim2.fromScale(.5, .5);
		N.ZIndex = 996;
		N.Parent = x.fovFrame;
		bi(N, V);
		local G = Instance.new("UIStroke");
		G.Name = "BlackStrokeOuter";
		G.Color = k();
		G.Thickness = z;
		G.Transparency = 0;
		G.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		G.Parent = N;
		local v = Instance.new("Frame");
		v.Name = "BlackInner";
		v.BackgroundTransparency = 1;
		v.Size = UDim2.new(1, -((z + 3)), 1, -((z + 3)));
		v.AnchorPoint = Vector2.new(.5, .5);
		v.Position = UDim2.fromScale(.5, .5);
		v.ZIndex = 996;
		v.Parent = x.fovFrame;
		bi(v, V);
		local R = Instance.new("UIStroke");
		R.Name = "BlackStrokeInner";
		R.Color = k();
		R.Thickness = math.max(1, z - 2);
		R.Transparency = 0;
		R.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		R.Parent = v;
	end;
	if o.RebelFOVNeon then
		local N = Instance.new("Frame");
		N.Name = "Glow1";
		N.BackgroundTransparency = 1;
		N.Size = UDim2.fromScale(1, 1);
		N.AnchorPoint = Vector2.new(.5, .5);
		N.Position = UDim2.fromScale(.5, .5);
		N.ZIndex = 999;
		N.Parent = x.fovFrame;
		bi(N, V);
		local G = Instance.new("UIStroke");
		G.Color = I();
		G.Thickness = 14;
		G.Transparency = .82;
		G.Parent = N;
		local z = Instance.new("Frame");
		z.Name = "Glow2";
		z.BackgroundTransparency = 1;
		z.Size = UDim2.fromScale(1, 1);
		z.AnchorPoint = Vector2.new(.5, .5);
		z.Position = UDim2.fromScale(.5, .5);
		z.ZIndex = 999;
		z.Parent = x.fovFrame;
		bi(z, V);
		local v = Instance.new("UIStroke");
		v.Color = I();
		v.Thickness = 6;
		v.Transparency = .55;
		v.Parent = z;
	end;
	x.fovStroke = Instance.new("UIStroke");
	x.fovStroke.Color = Color3.new(1, 1, 1);
	local v = tonumber(o.RebelFOVCircleWidth) or 1.6;
	if o.FOVRainbow and ((o.FOVRainbowMode or 1)) == 6 then
		v = v * 2.5;
	end;
	x.fovStroke.Thickness = v;
	x.fovStroke.Transparency = 0;
	x.fovStroke.Parent = x.fovFrame;
	local R = Instance.new("Frame");
	R.Name = "Inner";
	R.BackgroundTransparency = 1;
	R.Size = UDim2.fromScale(1, 1);
	R.AnchorPoint = Vector2.new(.5, .5);
	R.Position = UDim2.fromScale(.5, .5);
	R.ZIndex = 1001;
	R.Parent = x.fovFrame;
	bi(R, V);
	local C = Instance.new("UIStroke");
	C.Name = "InnerStroke";
	C.Color = I();
	C.Thickness = 1.2;
	C.Transparency = .15;
	C.Parent = R;
	if o.FOVRainbow then
		yO();
	end;
end;
local function FO()
	if not x.fovFrame then
		return;
	end;
	local N = math.max(4, ((o.RebelFOV or 150)) * 2);
	local G = math.floor(N / 2);
	local V = o.RebelFOV_OutlineThickness or 5;
	x.fovFrame.Size = UDim2.fromOffset(N, N);
	local z = x.fovFrame:FindFirstChildOfClass("UICorner");
	if z then
		z.CornerRadius = UDim.new(0, G);
	end;
	for N, z in ipairs(x.fovFrame:GetChildren()) do
		if z:IsA("Frame") then
			local N = z:FindFirstChildOfClass("UICorner");
			if N then
				N.CornerRadius = UDim.new(0, G);
			end;
			if z.Name == "BlackInner" then
				z.Size = UDim2.new(1, -((V + 3)), 1, -((V + 3)));
			end;
			for N, G in ipairs(z:GetChildren()) do
				if G:IsA("UIStroke") then
					if G.Name == "BlackStrokeOuter" then
						G.Color = k();
						G.Thickness = V;
						G.Transparency = 0;
					elseif G.Name == "BlackStrokeInner" then
						G.Color = k();
						G.Thickness = math.max(1, V - 2);
						G.Transparency = 0;
					elseif G.Parent and G.Parent.Name == "Glow1" then
						G.Color = I();
						G.Transparency = .82;
					elseif G.Parent and G.Parent.Name == "Glow2" then
						G.Color = I();
						G.Transparency = .55;
					elseif G.Name == "InnerStroke" then
						G.Color = I();
						G.Transparency = .15;
					end;
				end;
			end;
		end;
	end;
	if x.fovStroke then
		local N = tonumber(o.RebelFOVCircleWidth) or 1.6;
		if o.FOVRainbow and ((o.FOVRainbowMode or 1)) == 6 then
			N = N * 2.5;
		end;
		x.fovStroke.Thickness = N;
	end;
end;
local nO, mO, xO;
local function wO()
	if xO then
		pcall(function()
			xO:Disconnect();
		end);
		xO = nil;
	end;
	if nO then
		pcall(function()
			nO:Destroy();
		end);
		nO = nil;
	end;
	if mO then
		pcall(function()
			mO:Destroy();
		end);
		mO = nil;
	end;
end;
local function hO(N)
	local V = Instance.new("Part");
	V.Name = "UIRadiusDisc";
	V.Anchored = true;
	V.CanCollide = false;
	V.CanQuery = false;
	V.CanTouch = false;
	V.CastShadow = false;
	V.Massless = true;
	V.Locked = true;
	V.Material = Enum.Material.Plastic;
	V.Color = N;
	V.Shape = Enum.PartType.Cylinder;
	V.Size = Vector3.new(.08, 2, 2);
	V.Transparency = .55;
	pcall(function()
		V.Parent = G.CurrentCamera or G;
	end);
	return V;
end;
local function SO()
	if x.unloaded then
		return;
	end;
	wO();
	if not o.RadiusVis and not i.RadiusVis then
		return;
	end;
	if o.RadiusVis then
		nO = hO(s());
	end;
	if i.RadiusVis then
		mO = hO(f());
	end;
	xO = v.RenderStepped:Connect(function()
			if x.unloaded then
				return;
			end;
			local N = F.Character and F.Character:FindFirstChild("HumanoidRootPart");
			if not N then
				return;
			end;
			local G = N.Position - Vector3.new(0, 2.9, 0);
			if nO then
				local N = math.max(2, o.Distance or 16) * 2;
				nO.CFrame = CFrame.new(G) * CFrame.Angles(0, 0, math.rad(90));
				nO.Size = Vector3.new(.08, N, N);
				nO.Color = s();
				nO.Transparency = math.clamp(1 - ((o.RadiusTransparency or .55)), .1, .9);
			end;
			if mO then
				local N = math.max(2, i.Distance or 16) * 2;
				local V = G + Vector3.new(0, .02, 0);
				mO.CFrame = CFrame.new(V) * CFrame.Angles(0, 0, math.rad(90));
				mO.Size = Vector3.new(.08, N, N);
				mO.Color = f();
				mO.Transparency = math.clamp(1 - ((i.RadiusTransparency or .55)), .1, .9);
			end;
		end);
end;
local function oO()
	wO();
end;
local iO = "rbxassetid://88400194373338";
_G.__rlgl_isRed = function()
		local N, G = pcall(function()
				local N = F:FindFirstChild("PlayerGui");
				if not N then
					return false;
				end;
				local G = N:FindFirstChild("ImpactFrames");
				if not G then
					return false;
				end;
				local V = G:FindFirstChild("TrafficLightEmpty");
				if not V or not V:IsA("ImageLabel") then
					return false;
				end;
				return V.Image == iO;
			end);
		if N and G then
			return true;
		end;
		local V, z = pcall(function()
				local N = P:FindFirstChildOfClass("ColorCorrectionEffect");
				if not N or not N.Enabled then
					return false;
				end;
				local G = N.TintColor;
				return G.R > .6 and (G.G < .4 and G.B < .4);
			end);
		if V and z then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inSafeZone = function()
		local N = F.Character;
		if not N then
			return false;
		end;
		local G = N:FindFirstChild("HumanoidRootPart");
		if not G then
			return false;
		end;
		local V = G.Position;
		if math.abs(V.Y - 1023) > 80 then
			return false;
		end;
		local function z(N, G, z, v)
			return V.X >= N and (V.X <= G and (V.Z >= z and V.Z <= v));
		end;
		if z(-219, 135, -656, -511) then
			return true;
		end;
		if z(-215, 115, 82, 168) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inFinishZone = function()
		local N = F.Character;
		if not N then
			return false;
		end;
		local G = N:FindFirstChild("HumanoidRootPart");
		if not G then
			return false;
		end;
		local V = G.Position;
		if math.abs(V.Y - 1023) > 80 then
			return false;
		end;
		if V.X >= -215 and (V.X <= 115 and (V.Z >= 82 and V.Z <= 168)) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_isMoving = function(N)
		local G = F.Character;
		if not G then
			return false;
		end;
		local V = G:FindFirstChildOfClass("Humanoid");
		local z = G:FindFirstChild("HumanoidRootPart");
		if not V or not z then
			return false;
		end;
		if V.MoveDirection.Magnitude > .1 then
			return true;
		end;
		local v = z.AssemblyLinearVelocity;
		return math.sqrt(v.X * v.X + v.Z * v.Z) > ((N or .3));
	end;
_G.__rlgl_isOnMap = function()
		local N = workspace:FindFirstChild("Values");
		if N then
			local G = N:FindFirstChild("CurrentGame");
			if G and G.Value == "RedLightGreenLight" then
				return true;
			end;
		end;
		local G = F.Character;
		if not G then
			return false;
		end;
		local V = G:FindFirstChild("HumanoidRootPart");
		if not V then
			return false;
		end;
		return V.Position.Y > 1000 and V.Position.Y < 1050;
	end;
_G.__rlgl_timerSeconds = function()
		local N = workspace:GetAttribute("CurrentGameTime");
		if type(N) == "number" then
			return N, tostring(N);
		end;
		for N, G in ipairs({
			"TimeLeft",
			"Timer",
			"RoundTime",
			"TimeRemaining",
		}) do
			local V = workspace:GetAttribute(G);
			if type(V) == "number" then
				return V, tostring(V);
			end;
		end;
		local function G(N)
			if not N or N == "" then
				return nil;
			end;
			N = ((tostring(N)):gsub("^%s+", "")):gsub("%s+$", "");
			local G, V = N:match("^(%d+):(%d+)");
			if G then
				return tonumber(G) * 60 + tonumber(V), N;
			end;
			local z = N:match("^(%d+)");
			if z then
				return tonumber(z), N;
			end;
			return nil, N;
		end;
		if _G.__rlgl_timerLabel and _G.__rlgl_timerLabel.Parent then
			local N, V = G(_G.__rlgl_timerLabel.Text);
			if N ~= nil then
				return N, V;
			end;
		end;
		return nil, nil;
	end;
_G.__rlgl_fireDodge = function()
		if x.unloaded then
			return;
		end;
		local N = F.Character;
		if not N then
			return;
		end;
		local G = N:FindFirstChildOfClass("Humanoid");
		if not G or G.Health <= 0 then
			return;
		end;
		if type(keypress) == "function" and type(keyrelease) == "function" then
			pcall(function()
				keypress(84);
				task.delay(.012, function()
					pcall(function()
						keyrelease(84);
					end);
				end);
			end);
		else
			pcall(function()
				local N = game:GetService("VirtualInputManager");
				N:SendKeyEvent(true, Enum.KeyCode.T, false, game);
				task.delay(.012, function()
					pcall(function()
						N:SendKeyEvent(false, Enum.KeyCode.T, false, game);
					end);
				end);
			end);
		end;
	end;
local function jO(N)
	if N then
		if not x.fbInst then
			x.fbInst = Instance.new("ColorCorrectionEffect");
			x.fbInst.Name = "_XD_FB";
			x.fbInst.Brightness = .3;
			x.fbInst.Contrast = .15;
			x.fbInst.Saturation = .05;
			x.fbInst.Parent = P;
		end;
	else
		if x.fbInst then
			pcall(function()
				x.fbInst:Destroy();
			end);
			x.fbInst = nil;
		end;
	end;
end;
local function JO(N)
	if N then
		if not x.fogBackup then
			x.fogBackup = { FogEnd = P.FogEnd, FogStart = P.FogStart, FogColor = P.FogColor };
		end;
		P.FogEnd = 1000000;
		P.FogStart = 1000000;
	else
		if x.fogBackup then
			P.FogEnd = x.fogBackup.FogEnd;
			P.FogStart = x.fogBackup.FogStart;
			P.FogColor = x.fogBackup.FogColor;
			x.fogBackup = nil;
		end;
	end;
end;
local MO = {};
local function ZO(N, G)
	if x.unloaded then
		return;
	end;
	pcall(function()
		if not x.notifHolder or not x.notifHolder.Parent then
			x.notifHolder = Instance.new("ScreenGui");
			x.notifHolder.Name = "XD_Nf_" .. Gi(6);
			x.notifHolder.IgnoreGuiInset = true;
			x.notifHolder.ResetOnSpawn = false;
			x.notifHolder.DisplayOrder = 99999;
			local N = nil;
			if gethui then
				local G, V = pcall(gethui);
				if G and (V and typeof(V) == "Instance") then
					N = V;
				end;
			end;
			if not N then
				N = F:FindFirstChildOfClass("PlayerGui");
			end;
			if not N then
				N = game:GetService("CoreGui");
			end;
			pcall(function()
				x.notifHolder.Parent = N;
			end);
			if not x.notifHolder.Parent then
				pcall(function()
					x.notifHolder.Parent = game:GetService("CoreGui");
				end);
			end;
		end;
		local V = Instance.new("Frame");
		V.Size = UDim2.fromOffset(250, 36);
		V.AnchorPoint = Vector2.new(.5, 0);
		V.Position = UDim2.new(.5, 0, 0, -60);
		V.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
		V.BackgroundTransparency = .12;
		V.BorderSizePixel = 0;
		V.ZIndex = 5;
		V.Parent = x.notifHolder;
		bi(V, 8);
		local z = Instance.new("UIStroke");
		z.Color = G or Y();
		z.Thickness = 1.5;
		z.Transparency = .1;
		z.Parent = V;
		local v = Instance.new("TextLabel");
		v.Size = UDim2.new(1, -12, 1, 0);
		v.Position = UDim2.fromOffset(6, 0);
		v.BackgroundTransparency = 1;
		v.Font = Enum.Font.GothamBold;
		v.TextSize = 12;
		v.TextColor3 = Color3.fromRGB(235, 225, 250);
		v.Text = tostring(N or "");
		v.ZIndex = 6;
		v.Parent = V;
		table.insert(MO, 1, V);
		for N, G in ipairs(MO) do
			if G and G.Parent then
				local V = 20 + ((N - 1)) * 42;
				(C:Create(G, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, V) })):Play();
			end;
		end;
		(C:Create(V, TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, 20) })):Play();
		task.delay(2.2, function()
			if not V or not V.Parent then
				return;
			end;
			local N = TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
			(C:Create(V, N, { Position = UDim2.new(.5, 0, 0, -60), BackgroundTransparency = 1 })):Play();
			(C:Create(z, N, { Transparency = 1 })):Play();
			(C:Create(v, N, { TextTransparency = 1 })):Play();
			task.delay(.35, function()
				for N = #MO, 1, -1 do
					if MO[N] == V then
						table.remove(MO, N);
						break;
					end;
				end;
				pcall(function()
					V:Destroy();
				end);
				for N, G in ipairs(MO) do
					if G and G.Parent then
						local V = 20 + ((N - 1)) * 42;
						(C:Create(G, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, V) })):Play();
					end;
				end;
			end);
		end);
	end);
end;
_G.__adShowNotif = ZO;
local function rO()
	if x.unloaded or not o.AutoBrew then
		return;
	end;
	local N = string.lower(tostring(o.AutoBrewSlot or "e"));
	Ii(N);
	task.wait(.2);
	local G = fi[N];
	if not G then
		return;
	end;
	local V = tonumber(o.AutoBrewCollectHold) or 2;
	if Bi then
		pcall(function()
			keypress(G);
			task.wait(V);
			keyrelease(G);
		end);
	else
		pcall(function()
			local G = game:GetService("VirtualInputManager");
			local z = Enum.KeyCode[string.upper(N)] or Enum.KeyCode.E;
			G:SendKeyEvent(true, z, false, game);
			task.wait(V);
			G:SendKeyEvent(false, z, false, game);
		end);
	end;
end;
local function YO()
	if x.brewLoopConn then
		return;
	end;
	x.lastBrewTick = tick();
	x.brewLoopConn = task.spawn(function()
			while not x.unloaded and o.AutoBrew do
				local N = tonumber(o.AutoBrewInterval) or 60;
				if tick() - x.lastBrewTick >= N then
					x.lastBrewTick = tick();
					pcall(rO);
				end;
				task.wait(.5);
			end;
		end);
end;
local function EO()
	if x.brewLoopConn then
		pcall(function()
			task.cancel(x.brewLoopConn);
		end);
		x.brewLoopConn = nil;
	end;
end;
local AO = {
		{ name = "Quad", style = Enum.EasingStyle.Quad },
		{ name = "Linear", style = Enum.EasingStyle.Linear },
		{ name = "Expo", style = Enum.EasingStyle.Exponential },
		{ name = "Back", style = Enum.EasingStyle.Back },
		{ name = "Circ", style = Enum.EasingStyle.Circular },
		{ name = "Sine", style = Enum.EasingStyle.Sine },
		{ name = "Quint", style = Enum.EasingStyle.Quint },
		{ name = "Bounce", style = Enum.EasingStyle.Bounce },
		{ name = "Elastic", style = Enum.EasingStyle.Elastic },
	};
local function sO()
	local N = F.Character;
	if not N then
		return nil;
	end;
	local G = N:FindFirstChild("HumanoidRootPart");
	if not G then
		return nil;
	end;
	local V = N:GetAttribute("HoldingWeapon");
	if type(V) == "string" and V ~= "" then
		local G = N:FindFirstChild(V);
		if G then
			local N = G:FindFirstChild("FireFrom");
			if N and N:IsA("BasePart") then
				return N.Position;
			end;
			local V = G:FindFirstChild("Handle");
			if V and V:IsA("BasePart") then
				return V.Position + V.CFrame.LookVector * .5;
			end;
		end;
	end;
	return (G.Position + G.CFrame.LookVector * 1.5) + Vector3.new(0, .8, 0);
end;
local function fO(N)
	local z = G.CurrentCamera;
	if not z then
		return nil;
	end;
	local v;
	if V.TouchEnabled and not V.MouseEnabled then
		v = z.CFrame.LookVector;
	else
		local N = F:GetMouse();
		if not N then
			return nil;
		end;
		v = (z:ScreenPointToRay(N.X, N.Y)).Direction;
	end;
	local R = RaycastParams.new();
	R.FilterType = Enum.RaycastFilterType.Exclude;
	R.FilterDescendantsInstances = { F.Character };
	local C = G:Raycast(N, v * o.BulletTracerRange, R);
	if C then
		return C.Position;
	end;
	return N + v * o.BulletTracerRange;
end;
local function pO(N, G)
	local V = G - N;
	local z = V.Magnitude;
	if z < 1 then
		return;
	end;
	local R = V.Unit;
	local b = N + R * o.BulletTracerStartOffset;
	local y = G - R * o.BulletTracerEndOffset;
	local P = ((y - b)).Magnitude;
	if P < .3 then
		return;
	end;
	local O = ((b + y)) / 2;
	local q = CFrame.lookAt(O, y);
	local F = Color3.fromRGB(o.BulletTracerR, o.BulletTracerG, o.BulletTracerB);
	local n = o.BulletTracerThickness;
	local m = o.BulletTracerLifetime;
	local w = AO[o.BulletTracerFadeIdx or 1].style;
	local h = TweenInfo.new(m, w, Enum.EasingDirection.Out);
	local S = math.max(50, tonumber(o.BulletTracerSpeed) or 800);
	local i = z / S;
	if i < .015 then
		i = .015;
	end;
	local function j(N, G, V)
		local z = Instance.new("Part");
		z.Name = "_XD_BTracer";
		z.Anchored = true;
		z.CanCollide = false;
		z.CanQuery = false;
		z.CanTouch = false;
		z.CastShadow = false;
		z.Material = Enum.Material.Neon;
		z.Color = G;
		z.Transparency = V;
		z.Size = N;
		z.CFrame = q;
		z.Parent = workspace;
		return z;
	end;
	local function J(N, G, V, z)
		task.spawn(function()
			local C = tick();
			while true do
				if x.unloaded or not N or not N.Parent then
					return;
				end;
				local P = ((tick() - C)) / i;
				if P >= 1 then
					P = 1;
				end;
				local O = z * P;
				if O < .01 then
					O = .01;
				end;
				N.Size = Vector3.new(G, V, O);
				N.CFrame = CFrame.lookAt(b + R * ((O / 2)), y);
				if P >= 1 then
					break;
				end;
				v.Heartbeat:Wait();
			end;
		end);
	end;
	if o.BulletTracerGlow then
		local N = j(Vector3.new(n * 3, n * 3, .01), F, math.clamp(o.BulletTracerOpacity + .4, 0, 1));
		task.delay((m + i) + .1, function()
			pcall(function()
				N:Destroy();
			end);
		end);
		J(N, n * 3, n * 3, P);
		task.delay(i, function()
			if N and N.Parent then
				(C:Create(N, h, { Transparency = 1, Size = Vector3.new(.01, .01, P) })):Play();
			end;
		end);
	end;
	local M = j(Vector3.new(n, n, .01), F, o.BulletTracerOpacity);
	if o.BulletTracerGlow then
		local N = Instance.new("PointLight");
		N.Color = F;
		N.Brightness = 3;
		N.Range = 8;
		N.Parent = M;
	end;
	task.delay((m + i) + .1, function()
		pcall(function()
			M:Destroy();
		end);
	end);
	J(M, n, n, P);
	task.delay(i, function()
		if M and M.Parent then
			(C:Create(M, h, { Transparency = 1, Size = Vector3.new(.01, .01, P) })):Play();
		end;
	end);
	if o.BulletTracerWhiteCore then
		local N = j(Vector3.new(n * .3, n * .3, .01), Color3.new(1, 1, 1), math.clamp(o.BulletTracerOpacity + .1, 0, 1));
		task.delay((m + i) + .1, function()
			pcall(function()
				N:Destroy();
			end);
		end);
		J(N, n * .3, n * .3, P);
		task.delay(i, function()
			if N and N.Parent then
				(C:Create(N, h, { Transparency = 1, Size = Vector3.new(.005, .005, P) })):Play();
			end;
		end);
	end;
end;
local function BO()
	if not o.BulletTracer then
		return;
	end;
	local N = tick();
	if N - x.btLastShot < o.BulletTracerCooldown then
		return;
	end;
	x.btLastShot = N;
	local G = sO();
	if not G then
		return;
	end;
	local V = fO(G);
	if not V then
		return;
	end;
	pO(G, V);
end;
local function IO(N)
	if not N then
		return;
	end;
	if x.btAnimConn then
		pcall(function()
			x.btAnimConn:Disconnect();
		end);
		x.btAnimConn = nil;
	end;
	x.btAnimConn = N.AnimationPlayed:Connect(function(N)
			local G = N.Animation;
			if not G then
				return;
			end;
			local V = G.AnimationId;
			if not h[V] then
				return;
			end;
			local z = tick();
			if z - ((x.btLastIdTime[V] or 0)) < o.BulletTracerCooldown then
				return;
			end;
			x.btLastIdTime[V] = z;
			BO();
		end);
end;
local function kO(N)
	if not N then
		return;
	end;
	local G = N:FindFirstChildOfClass("Humanoid");
	if not G then
		return;
	end;
	local V = G:FindFirstChildOfClass("Animator");
	if V then
		IO(V);
	else
		local N;
		N = G.ChildAdded:Connect(function(G)
				if G:IsA("Animator") then
					IO(G);
					pcall(function()
						N:Disconnect();
					end);
				end;
			end);
	end;
end;
if F.Character then
	kO(F.Character);
end;
r(F.CharacterAdded:Connect(function(N)
	task.wait(.5);
	kO(N);
end));
local TO = {};
local QO = {};
local function DO()
	for N, G in pairs(TO) do
		pcall(function()
			if G.hl then
				G.hl:Destroy();
			end;
		end);
		pcall(function()
			if G.nameBill then
				G.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if G.hpBar then
				G.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if G.distBill then
				G.distBill:Destroy();
			end;
		end);
		pcall(function()
			if G.toolBill then
				G.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if G.tracer then
				G.tracer:Destroy();
			end;
		end);
		pcall(function()
			if G.box then
				G.box:Destroy();
			end;
		end);
	end;
	table.clear(TO);
end;
local function XO()
	for N, G in pairs(QO) do
		pcall(function()
			if G.hl then
				G.hl:Destroy();
			end;
		end);
		pcall(function()
			if G.nameBill then
				G.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if G.hpBar then
				G.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if G.distBill then
				G.distBill:Destroy();
			end;
		end);
		pcall(function()
			if G.toolBill then
				G.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if G.tracer then
				G.tracer:Destroy();
			end;
		end);
		pcall(function()
			if G.box then
				G.box:Destroy();
			end;
		end);
	end;
	table.clear(QO);
end;
local function KO(N, G)
	if not N or not G then
		return false;
	end;
	if G:GetAttribute("IsGuard") == true then
		return true;
	end;
	if N:FindFirstChild("GuardPlayerOutift") then
		return true;
	end;
	if N:FindFirstChild("G3SG1") then
		return true;
	end;
	return false;
end;
local function cO(N)
	local G = N and N:FindFirstChild("HumanoidRootPart");
	if not G then
		return 5.5;
	end;
	local V, z = math.huge, -math.huge;
	for N, G in ipairs(N:GetDescendants()) do
		if G:IsA("BasePart") then
			local N = G.Position.Y;
			if N < V then
				V = N;
			end;
			if N > z then
				z = N;
			end;
		end;
	end;
	if V == math.huge then
		return 5.5;
	end;
	local v = z - V;
	if v < 3 then
		v = 3;
	end;
	if v > 10 then
		v = 10;
	end;
	return v;
end;
local function lO(N)
	if N > .6 then
		return Color3.fromRGB(74, 222, 74);
	elseif N > .3 then
		return Color3.fromRGB(255, 210, 60);
	else
		return Color3.fromRGB(255, 55, 55);
	end;
end;
local function uO(N, G, V, z, v, R)
	local C = N:GetAttribute("IsGuard") and T() or Q();
	local b = C:Lerp(Color3.new(0, 0, 0), .35);
	local y = cO(G);
	Oi();
	qi();
	local P = Instance.new("Highlight");
	P.Name = "_XD_HL";
	P.FillTransparency = .4;
	P.OutlineTransparency = 0;
	P.FillColor = C;
	P.OutlineColor = b;
	P.Adornee = G;
	P.Parent = G;
	local O = Instance.new("BillboardGui");
	O.Name = "_XD_NAME";
	O.Size = UDim2.fromOffset(360, 26);
	O.StudsOffset = Vector3.new(0, y * .5 + .6, 0);
	O.AlwaysOnTop = true;
	O.LightInfluence = 0;
	O.Adornee = V;
	O.Parent = G;
	local q = Instance.new("Frame");
	q.BackgroundTransparency = 1;
	q.Size = UDim2.fromOffset(0, 24);
	q.AutomaticSize = Enum.AutomaticSize.X;
	q.AnchorPoint = Vector2.new(.5, .5);
	q.Position = UDim2.fromScale(.5, .5);
	q.Parent = O;
	local F = Instance.new("UIListLayout");
	F.FillDirection = Enum.FillDirection.Horizontal;
	F.SortOrder = Enum.SortOrder.LayoutOrder;
	F.VerticalAlignment = Enum.VerticalAlignment.Center;
	F.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	F.Padding = UDim.new(0, 6);
	F.Parent = q;
	local n = Instance.new("Frame");
	n.LayoutOrder = 1;
	n.Size = UDim2.fromOffset(42, 20);
	n.BackgroundColor3 = Color3.fromRGB(74, 222, 74);
	n.BorderSizePixel = 0;
	n.Parent = q;
	bi(n, 5);
	local m = Instance.new("UIStroke");
	m.Thickness = 1.5;
	m.Transparency = 0;
	m.Color = Color3.new(0, 0, 0);
	m.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	m.Parent = n;
	local w = Instance.new("TextLabel");
	w.Size = UDim2.fromScale(1, 1);
	w.BackgroundTransparency = 1;
	w.Font = Enum.Font.GothamBlack;
	w.TextSize = 13;
	w.TextColor3 = Color3.fromRGB(255, 255, 255);
	w.TextStrokeTransparency = 0;
	w.TextStrokeColor3 = Color3.new(0, 0, 0);
	w.Text = "[100]";
	w.Parent = n;
	local h = Instance.new("TextLabel");
	h.LayoutOrder = 2;
	h.BackgroundTransparency = 1;
	h.AutomaticSize = Enum.AutomaticSize.X;
	h.Size = UDim2.fromOffset(0, 24);
	h.Font = J();
	h.TextSize = v or 17;
	h.TextColor3 = Color3.fromRGB(255, 255, 255);
	h.TextStrokeTransparency = 0;
	h.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	h.Text = N.Name;
	h.Parent = q;
	local o = Instance.new("BillboardGui");
	o.Size = UDim2.fromOffset(220, 20);
	o.StudsOffset = Vector3.new(0, -y * .5 - 1.2, 0);
	o.AlwaysOnTop = true;
	o.LightInfluence = 0;
	o.Adornee = V;
	o.Parent = G;
	local i = Instance.new("TextLabel");
	i.Size = UDim2.new(1, 0, 1, 0);
	i.BackgroundTransparency = 1;
	i.TextColor3 = C;
	i.TextStrokeTransparency = 0;
	i.TextStrokeColor3 = Color3.new(0, 0, 0);
	i.Font = J();
	i.TextSize = 13;
	i.Text = "";
	i.Parent = o;
	local j = Instance.new("BillboardGui");
	j.Size = UDim2.fromOffset(8, y * 24);
	j.StudsOffset = Vector3.new(-2.5, 0, 0);
	j.AlwaysOnTop = true;
	j.LightInfluence = 0;
	j.Adornee = V;
	j.Parent = G;
	local M = Instance.new("Frame");
	M.Size = UDim2.fromScale(1, 1);
	M.AnchorPoint = Vector2.new(.5, .5);
	M.Position = UDim2.fromScale(.5, .5);
	M.BackgroundColor3 = Color3.fromRGB(25, 8, 8);
	M.BackgroundTransparency = .2;
	M.BorderSizePixel = 0;
	M.Parent = j;
	local Z = bi(M, 3);
	Pi(M, Color3.new(0, 0, 0), 1, .3);
	local r = Instance.new("Frame");
	r.Size = UDim2.fromScale(1, 1);
	r.BackgroundColor3 = Color3.new(1, 1, 1);
	r.BorderSizePixel = 0;
	r.AnchorPoint = Vector2.new(0, 1);
	r.Position = UDim2.fromScale(0, 1);
	r.Parent = M;
	local Y = bi(r, 3);
	local E = Instance.new("UIGradient");
	E.Color = R or S(80, 255, 80, 180, 255, 60, 255, 200, 40, 255, 120, 60, 255, 40, 40);
	E.Rotation = 90;
	E.Parent = r;
	local A = Instance.new("BillboardGui");
	A.Size = UDim2.fromOffset(160, 18);
	A.StudsOffset = Vector3.new(2.8, 0, 0);
	A.AlwaysOnTop = true;
	A.LightInfluence = 0;
	A.Adornee = V;
	A.Parent = G;
	local s = Instance.new("TextLabel");
	s.Size = UDim2.new(1, 0, 1, 0);
	s.BackgroundTransparency = 1;
	s.TextColor3 = C;
	s.TextStrokeTransparency = 0;
	s.TextStrokeColor3 = Color3.new(0, 0, 0);
	s.Font = Enum.Font.Code;
	s.TextSize = 13;
	s.Text = "";
	s.TextXAlignment = Enum.TextXAlignment.Left;
	s.Parent = A;
	local f = Instance.new("Frame");
	f.AnchorPoint = Vector2.new(.5, .5);
	f.BorderSizePixel = 0;
	f.ZIndex = 5;
	f.Visible = false;
	f.BackgroundColor3 = C;
	f.Parent = x.tracerGui;
	local p = Instance.new("Frame");
	p.BackgroundTransparency = 1;
	p.BorderSizePixel = 0;
	p.Visible = false;
	p.ZIndex = 4;
	p.Parent = x.overlayGui;
	local B = Instance.new("UIStroke");
	B.Thickness = 2;
	B.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	B.Parent = p;
	return {
		hl = P,
		nameBill = O,
		hpChip = n,
		hpChipStroke = m,
		hpLbl = w,
		nameL = h,
		toolBill = o,
		toolL = i,
		hpBar = j,
		hpBg = M,
		hpFill = r,
		hpGradient = E,
		hpBgCorner = Z,
		hpFillCorner = Y,
		distBill = A,
		distL = s,
		tracer = f,
		box = p,
		boxStroke = B,
		char = G,
		color = C,
		charHeight = y,
	};
end;
local function eO(N)
	if not N then
		return;
	end;
	pcall(function()
		if N.hl then
			N.hl:Destroy();
		end;
	end);
	pcall(function()
		if N.nameBill then
			N.nameBill:Destroy();
		end;
	end);
	pcall(function()
		if N.hpBar then
			N.hpBar:Destroy();
		end;
	end);
	pcall(function()
		if N.distBill then
			N.distBill:Destroy();
		end;
	end);
	pcall(function()
		if N.toolBill then
			N.toolBill:Destroy();
		end;
	end);
	pcall(function()
		if N.tracer then
			N.tracer:Destroy();
		end;
	end);
	pcall(function()
		if N.box then
			N.box:Destroy();
		end;
	end);
end;
local function dO(N, G, V, z)
	if not N then
		return;
	end;
	local v = G:Lerp(Color3.new(0, 0, 0), .35);
	N.color = G;
	pcall(function()
		N.hl.FillColor = G;
		N.hl.OutlineColor = v;
	end);
	if N.nameL then
		pcall(function()
			local G = V or 17;
			N.nameL.TextSize = G;
			N.nameL.Font = J();
			if N.hpChip and N.hpLbl then
				local V = G / 17;
				N.hpChip.Size = UDim2.fromOffset(math.max(24, math.floor(42 * V + .5)), math.max(12, math.floor(20 * V + .5)));
				N.hpLbl.TextSize = math.max(8, math.floor(13 * V + .5));
			end;
		end);
	end;
	if N.distL then
		pcall(function()
			N.distL.TextColor3 = G;
		end);
	end;
	if N.toolL then
		pcall(function()
			N.toolL.TextColor3 = G;
			N.toolL.Font = J();
		end);
	end;
	if N.hpBg then
		local V = N.hpBg:FindFirstChildOfClass("UIStroke");
		if V then
			pcall(function()
				V.Color = G:Lerp(Color3.new(0, 0, 0), .4);
			end);
		end;
	end;
	if N.hpGradient and z then
		pcall(function()
			N.hpGradient.Color = z;
		end);
	end;
end;
local function tO()
	if x.unloaded then
		return;
	end;
	_G.__adEspDone = 0;
	_G.__adEspTotal = 0;
	local G = o.GuardESP;
	local V = o.PlayerESP;
	if not ((G or V)) then
		if next(TO) then
			DO();
		end;
		if next(QO) then
			XO();
		end;
		return;
	end;
	local z = F.Character and F.Character:FindFirstChild("HumanoidRootPart");
	for N, v in ipairs(N:GetPlayers()) do
		if v ~= F then
			_G.__adEspTotal = _G.__adEspTotal + 1;
			pcall(function()
				local N = v.Character;
				local R = N and N:FindFirstChildOfClass("Humanoid");
				local C = N and N:FindFirstChild("HumanoidRootPart");
				local b = o.GuardESP_ForceAll or KO(N, v);
				local y = G and b;
				local P = V and not b;
				if R and (C and (R.Health > 0 and ((y or P)))) then
					local G = y and ((o.GuardESP_MaxDist or 0)) or (o.PlayerESP_MaxDist or 0);
					local V = z and z.Position or Vector3.zero;
					local b = ((V - C.Position)).Magnitude;
					if G > 0 and b > G then
						if TO[v] then
							eO(TO[v]);
							TO[v] = nil;
						end;
						if QO[v] then
							eO(QO[v]);
							QO[v] = nil;
						end;
						return;
					end;
					_G.__adEspDone = _G.__adEspDone + 1;
					local O = y and T() or Q();
					local q = y and ((o.GuardESP_NameSize or 17)) or (o.PlayerESP_NameSize or 17);
					local F = y and e() or d();
					local n = y and TO or QO;
					local m = y and QO or TO;
					if m[v] then
						eO(m[v]);
						m[v] = nil;
					end;
					if not n[v] or n[v].char ~= N then
						if n[v] then
							eO(n[v]);
							n[v] = nil;
						end;
						n[v] = uO(v, N, C, R, q, F);
					else
						dO(n[v], O, q, F);
					end;
					local x = n[v];
					if x then
						local G = y and o.GuardESP_HP or (P and o.PlayerESP_HP);
						local V = y and o.GuardESP_Name or (P and o.PlayerESP_Name);
						local O = y and o.GuardESP_Tool or (P and o.PlayerESP_Tool);
						local q = y and o.GuardESP_Distance or (P and o.PlayerESP_Distance);
						local F = y and o.GuardESP_Highlight or (P and o.PlayerESP_Highlight);
						local n = y and o.GuardESP_Tracer or (P and o.PlayerESP_Tracer);
						local m = y and o.GuardESP_Box or (P and o.PlayerESP_Box);
						x.showHPBar = G;
						x.showTracer = n;
						x.showBox = m;
						x.boxColor = y and K() or c();
						x.boxThick = y and ((o.GuardESP_BoxThickness or 2)) or (o.PlayerESP_BoxThickness or 2);
						x.hpBarThickness = y and ((o.GuardESP_HPBarThickness or 8)) or (o.PlayerESP_HPBarThickness or 8);
						x.hpBarLength = y and ((o.GuardESP_HPBarLength or 1.5)) or (o.PlayerESP_HPBarLength or 1.5);
						x.hpBarRoundness = y and ((o.GuardESP_HPBarRoundness or 3)) or (o.PlayerESP_HPBarRoundness or 3);
						x.tracerColor = y and D() or X();
						x.nameBill.Enabled = V and true or false;
						x.toolBill.Enabled = O and true or false;
						if x.hl then
							x.hl.Enabled = F and true or false;
						end;
						if O then
							local G = Yi(N);
							if G == "" then
								G = "- none -";
							end;
							if x.toolL.Text ~= G then
								x.toolL.Text = G;
							end;
						end;
						local w = math.clamp(R.Health / math.max(R.MaxHealth, 1), 0, 1);
						x.hpFill.Size = UDim2.fromScale(1, w);
						if x.hpLbl then
							x.hpLbl.Text = "[" .. (tostring(math.floor(R.Health + .5)) .. "]");
						end;
						local h = y and o.GuardESP_HP_ChipBg or (P and o.PlayerESP_HP_ChipBg);
						local S = y and M(w) or Z(w);
						if x.hpChip then
							x.hpChip.BackgroundColor3 = S;
							x.hpChip.BackgroundTransparency = h and 0 or 1;
						end;
						if x.hpLbl then
							x.hpLbl.TextColor3 = S;
						end;
						if x.hpChipStroke then
							local N = y and o.GuardESP_HP_Outline or (P and o.PlayerESP_HP_Outline);
							x.hpChipStroke.Enabled = ((N and h)) and true or false;
						end;
						if q then
							if z and C then
								x.distBill.Enabled = true;
								x.distL.Text = string.format("[%d studs]", math.floor(b + .5));
							else
								x.distBill.Enabled = false;
							end;
						else
							x.distBill.Enabled = false;
						end;
						if x.tracer then
							x.tracer.BackgroundColor3 = x.tracerColor;
						end;
						if not y and x.nameL then
							local N = v.Name;
							if o.PlayerESP_CustomName and o.PlayerESP_CustomName ~= "" then
								N = o.PlayerESP_CustomName;
							end;
							if x.nameL.Text ~= N then
								x.nameL.Text = N;
							end;
							if not o.PlayerESP_NameRainbow then
								x.nameL.TextColor3 = Color3.fromRGB(255, 255, 255);
							end;
						end;
					end;
				else
					if TO[v] then
						eO(TO[v]);
						TO[v] = nil;
					end;
					if QO[v] then
						eO(QO[v]);
						QO[v] = nil;
					end;
				end;
			end);
		end;
	end;
end;
task.spawn(function()
	while x.running and not x.unloaded do
		pcall(function()
			if o.GuardESP or o.PlayerESP then
				local N = G.CurrentCamera;
				if N then
					local G = math.rad(N.FieldOfView);
					local V = N.ViewportSize;
					local z = V.Y;
					local v = N.CFrame.Position;
					local R = V.X / 2;
					local C = V.Y / 2;
					local b = math.tan(G / 2);
					if b > .01 then
						local function G(G)
							if not G then
								return;
							end;
							local y = G.char and G.char:FindFirstChild("HumanoidRootPart");
							if G.hpBar then
								if G.showHPBar and y then
									local N = ((v - y.Position)).Magnitude;
									if N < 1 then
										N = 1;
									end;
									local V = z / (((2 * N) * b));
									local R = G.hpBarThickness or 8;
									local C = G.hpBarLength or 1.5;
									local P = (((G.charHeight or 5.5)) * V) * C;
									if P > 3500 then
										P = 3500;
									end;
									if P < 20 then
										P = 20;
									end;
									G.hpBar.Enabled = true;
									G.hpBar.Size = UDim2.fromOffset(R, P);
									local O = G.hpBarRoundness or 3;
									pcall(function()
										if G.hpBgCorner then
											G.hpBgCorner.CornerRadius = UDim.new(0, O);
										end;
										if G.hpFillCorner then
											G.hpFillCorner.CornerRadius = UDim.new(0, O);
										end;
									end);
								else
									G.hpBar.Enabled = false;
								end;
							end;
							if G.tracer then
								if not G.showTracer or not y then
									if G.tracer.Visible then
										G.tracer.Visible = false;
									end;
								else
									local z, v = N:WorldToViewportPoint(y.Position);
									local b = z.X - R;
									local P = z.Y - C;
									local O = (z.Z < 0);
									if O then
										b = -b;
										P = -P;
									end;
									local q = math.sqrt(b * b + P * P);
									local F, n;
									if q < .001 then
										F, n = 0, 1;
									else
										F = b / q;
										n = P / q;
									end;
									local m = math.huge;
									if F > .0001 then
										m = math.min(m, ((V.X - R)) / F);
									end;
									if F < -0.0001 then
										m = math.min(m, -R / F);
									end;
									if n > .0001 then
										m = math.min(m, ((V.Y - C)) / n);
									end;
									if n < -0.0001 then
										m = math.min(m, -C / n);
									end;
									if m == math.huge or m < 1 then
										m = 1;
									end;
									local x, w;
									if v and not O then
										x = z.X;
										w = z.Y;
									else
										x = R + F * m;
										w = C + n * m;
									end;
									local h = x - R;
									local S = w - C;
									local o = math.sqrt(h * h + S * S);
									if o < 1 then
										o = 1;
									end;
									local i = math.deg(math.atan2(S, h));
									G.tracer.Visible = true;
									G.tracer.Position = UDim2.fromOffset(((R + x)) / 2, ((C + w)) / 2);
									G.tracer.Size = UDim2.fromOffset(o, 1.5);
									G.tracer.Rotation = i;
								end;
							end;
							if G.box and G.boxStroke then
								if not G.showBox then
									if G.box.Visible then
										G.box.Visible = false;
									end;
								else
									local V = G.char;
									if V and V.Parent then
										local z, v, R, C = wi(V, N);
										if z then
											G.box.Visible = true;
											G.box.Position = UDim2.fromOffset(z - 4, v - 4);
											G.box.Size = UDim2.fromOffset((R - z) + 8, (C - v) + 8);
											G.boxStroke.Color = G.boxColor or Color3.new(1, 1, 1);
											G.boxStroke.Thickness = G.boxThick or 2;
										elseif G.box.Visible then
											G.box.Visible = false;
										end;
									elseif G.box.Visible then
										G.box.Visible = false;
									end;
								end;
							end;
						end;
						for N, V in pairs(TO) do
							G(V);
						end;
						for N, V in pairs(QO) do
							G(V);
						end;
					end;
				end;
			end;
		end);
		v.RenderStepped:Wait();
	end;
end);
task.spawn(function()
	while x.running and not x.unloaded do
		pcall(function()
			if o.PlayerESP and o.PlayerESP_NameRainbow then
				local N = ((tick() * ((o.PlayerESP_NameRainbowSpeed or 1)))) % 1;
				local G = Color3.fromHSV(N, 1, 1);
				for N, V in pairs(QO) do
					if V.nameL and V.nameL.Parent then
						pcall(function()
							V.nameL.TextColor3 = G;
						end);
					end;
				end;
			end;
		end);
		v.RenderStepped:Wait();
	end;
end);
local function WO(N)
	x.oneClickDalgona = N and true or false;
	if x.dalgonaConn then
		pcall(function()
			x.dalgonaConn:Disconnect();
		end);
		x.dalgonaConn = nil;
	end;
	if not x.oneClickDalgona then
		for N, G in pairs(_G.__dalgonaCache) do
			if N and N.Parent then
				pcall(function()
					N.Position = G.Position;
					N.Transparency = G.Transparency;
				end);
			end;
		end;
		table.clear(_G.__dalgonaCache);
		return;
	end;
	table.clear(_G.__dalgonaCache);
	x.dalgonaConn = v.RenderStepped:Connect(function()
			if x.unloaded or not x.oneClickDalgona then
				return;
			end;
			pcall(function()
				local N = F:GetMouse();
				if not N or not N.Hit then
					return;
				end;
				local G = workspace:FindFirstChild("Effects");
				local V = nil;
				if G then
					for N, G in pairs(G:GetChildren()) do
						if G:IsA("Model") and string.match(G.Name, "Outline$") then
							V = G;
							break;
						end;
					end;
				end;
				if not V then
					return;
				end;
				local z = N.Hit.Position;
				for N, G in ipairs(V:GetChildren()) do
					if G:IsA("BasePart") then
						if not _G.__dalgonaCache[G] then
							_G.__dalgonaCache[G] = { Position = G.Position, Transparency = G.Transparency };
						end;
						G.Position = z;
						G.Transparency = 1;
					end;
				end;
			end);
		end);
end;
local function gO()
	table.clear(x.handCache);
	table.clear(x.legCache);
	table.clear(x.torsoCache);
	local N = F.Character;
	if not N then
		return;
	end;
	local G = {
			LeftArm = true,
			RightArm = true,
			["Left Arm"] = true,
			["Right Arm"] = true,
			LeftUpperArm = true,
			RightUpperArm = true,
			LeftLowerArm = true,
			RightLowerArm = true,
			LeftHand = true,
			RightHand = true,
		};
	local V = {
			LeftUpperLeg = true,
			LeftLowerLeg = true,
			LeftFoot = true,
			["Left Leg"] = true,
			RightUpperLeg = true,
			RightLowerLeg = true,
			RightFoot = true,
			["Right Leg"] = true,
		};
	local z = { Torso = true, UpperTorso = true, LowerTorso = true };
	local v = {
			lefthand = true,
			righthand = true,
			leftgrip = true,
			rightgrip = true,
			leftwrist = true,
			rightwrist = true,
			leftcuff = true,
			rightcuff = true,
			leftglove = true,
			rightglove = true,
			leftarm = true,
			rightarm = true,
		};
	local function R(N)
		if not N or not N:IsA("Accessory") then
			return false;
		end;
		local G = string.lower(N.Name);
		if G:find("glove") or G:find("hand") or G:find("wrist") or G:find("cuff") then
			return true;
		end;
		local V = N:FindFirstChild("Handle");
		if V then
			for N, G in ipairs(V:GetChildren()) do
				if G:IsA("Attachment") and v[string.lower(G.Name)] then
					return true;
				end;
			end;
		end;
		return false;
	end;
	for N, v in ipairs(N:GetDescendants()) do
		if v:IsA("BasePart") then
			if G[v.Name] then
				table.insert(x.handCache, v);
			elseif V[v.Name] then
				table.insert(x.legCache, v);
			elseif z[v.Name] then
				table.insert(x.torsoCache, v);
			else
				local N = v:FindFirstAncestorOfClass("Accessory");
				if N and R(N) then
					table.insert(x.handCache, v);
				end;
			end;
		end;
	end;
end;
local function aO(N, G)
	for V = 1, #N, 1 do
		local z = N[V];
		if z and z.Parent then
			if G then
				if x.origTransparency[z] == nil then
					x.origTransparency[z] = z.Transparency;
				end;
				z.LocalTransparencyModifier = 1;
				z.Transparency = 1;
			else
				z.LocalTransparencyModifier = 0;
				z.Transparency = x.origTransparency[z] or 0;
			end;
		end;
	end;
end;
local function LO(N)
	o.RemoveHands = N and true or false;
	gO();
	aO(x.handCache, o.RemoveHands);
	return true;
end;
local function UO(N)
	o.RemoveLegs = N and true or false;
	gO();
	aO(x.legCache, o.RemoveLegs);
	return true;
end;
local function HO(N)
	o.RemoveTorso = N and true or false;
	gO();
	aO(x.torsoCache, o.RemoveTorso);
	return true;
end;
local function NG()
	if x.handsConn then
		return;
	end;
	x.handsConn = v.Heartbeat:Connect(function()
			if x.unloaded then
				return;
			end;
			if o.RemoveHands then
				aO(x.handCache, true);
			end;
			if o.RemoveLegs then
				aO(x.legCache, true);
			end;
			if o.RemoveTorso then
				aO(x.torsoCache, true);
			end;
		end);
	table.insert(x.conns, x.handsConn);
end;
local function GG(N)
	local G = F.Character;
	if not G then
		return false;
	end;
	local V = G:FindFirstChild("Head");
	if not V then
		return false;
	end;
	if N == false then
		V.LocalTransparencyModifier = 0;
		V.Transparency = 0;
		for N, G in ipairs(V:GetChildren()) do
			if G:IsA("Decal") then
				G.Transparency = 0;
			end;
		end;
		return true;
	end;
	for N, G in ipairs(V:GetChildren()) do
		if G:IsA("Decal") then
			G.Transparency = 1;
		end;
	end;
	V.LocalTransparencyModifier = 1;
	V.Transparency = 1;
	return true;
end;
local VG = "rbxassetid://959831634";
local zG = {
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot",
		"Left Leg",
	};
local function vG(N)
	local G = F.Character;
	if not G then
		return false;
	end;
	if N then
		for N, V in ipairs(zG) do
			local z = G:FindFirstChild(V);
			if z and (z:IsA("BasePart") and not x.korbloxData[z]) then
				local N = z.Transparency;
				local V = z.LocalTransparencyModifier;
				z.LocalTransparencyModifier = 1;
				z.Transparency = 1;
				local v = Instance.new("Part");
				v.Name = "KorbloxDeco";
				v.Size = z.Size;
				v.CFrame = z.CFrame;
				v.Color = Color3.fromRGB(0, 0, 0);
				v.Material = Enum.Material.Plastic;
				v.CanCollide = false;
				v.CanQuery = false;
				v.CanTouch = false;
				v.CastShadow = false;
				v.Massless = true;
				v.Anchored = false;
				local R = Instance.new("SpecialMesh");
				R.MeshType = Enum.MeshType.FileMesh;
				R.MeshId = VG;
				R.Scale = Vector3.new(1, 1, 1);
				R.Parent = v;
				v.Parent = G;
				local C = Instance.new("WeldConstraint");
				C.Part0 = z;
				C.Part1 = v;
				C.Parent = v;
				v.CFrame = z.CFrame;
				x.korbloxData[z] = { deco = v, origTrans = N, origLTM = V };
			end;
		end;
	else
		for N, G in pairs(x.korbloxData) do
			if N and N.Parent then
				N.LocalTransparencyModifier = G.origLTM;
				N.Transparency = G.origTrans;
			end;
			if G.deco and G.deco.Parent then
				G.deco:Destroy();
			end;
		end;
		table.clear(x.korbloxData);
	end;
	return true;
end;
local function RG()
	for N, G in ipairs(x.hideConns) do
		pcall(function()
			G:Disconnect();
		end);
	end;
	table.clear(x.hideConns);
end;
local function CG()
	RG();
	if x.unloaded then
		return;
	end;
	local function G(N)
		if not N then
			return false;
		end;
		if not ((N:IsA("BillboardGui") or N:IsA("SurfaceGui"))) then
			return false;
		end;
		local G = string.lower(tostring(N.Name));
		if G:find("nick") or G:find("name") or G:find("tag") or G:find("title") or G:find("label") then
			return true;
		end;
		local V = N.Parent;
		if V and V.Name == "Head" then
			return true;
		end;
		return false;
	end;
	local function V(N)
		if not N or not N.Parent then
			return;
		end;
		pcall(function()
			N.Enabled = false;
		end);
		pcall(function()
			N.Visible = false;
		end);
		if not N:GetAttribute("_XD_nickHooked") then
			N:SetAttribute("_XD_nickHooked", true);
			table.insert(x.hideConns, (N:GetPropertyChangedSignal("Enabled")):Connect(function()
				if N.Enabled then
					pcall(function()
						N.Enabled = false;
					end);
				end;
			end));
			table.insert(x.hideConns, (N:GetPropertyChangedSignal("Visible")):Connect(function()
				if N.Visible then
					pcall(function()
						N.Visible = false;
					end);
				end;
			end));
		end;
	end;
	local function z(N)
		if not N then
			return;
		end;
		for N, z in ipairs(N:GetDescendants()) do
			if G(z) then
				V(z);
			end;
		end;
	end;
	local function R(N)
		if not N then
			return;
		end;
		z(N);
		table.insert(x.hideConns, N.DescendantAdded:Connect(function(N)
			if G(N) then
				task.defer(function()
					V(N);
				end);
			end;
		end));
	end;
	if F.Character then
		R(F.Character);
	end;
	table.insert(x.hideConns, F.CharacterAdded:Connect(function(N)
		task.wait(.3);
		R(N);
	end));
	table.insert(x.hideConns, N.PlayerAdded:Connect(function(N)
		N.CharacterAdded:Connect(function(N)
			if x.unloaded then
				return;
			end;
			task.wait(.3);
			R(N);
		end);
	end));
	for N, G in ipairs(N:GetPlayers()) do
		if G ~= F and G.Character then
			R(G.Character);
			table.insert(x.hideConns, G.CharacterAdded:Connect(function(N)
				if x.unloaded then
					return;
				end;
				task.wait(.3);
				R(N);
			end));
		end;
	end;
	if x._nickLoop then
		pcall(function()
			task.cancel(x._nickLoop);
		end);
	end;
	x._nickLoop = task.spawn(function()
			while not x.unloaded and o.HideNick do
				pcall(function()
					if F.Character then
						z(F.Character);
					end;
					for N, G in ipairs(N:GetPlayers()) do
						if G ~= F and G.Character then
							z(G.Character);
						end;
					end;
				end);
				v.RenderStepped:Wait();
			end;
		end);
end;
local bG = "InkInstinct";
local function yG()
	if x.FILE.isfolder and x.FILE.makefolder then
		local N, G = pcall(x.FILE.isfolder, bG);
		if not N or not G then
			pcall(x.FILE.makefolder, bG);
		end;
	end;
end;
local function PG(N)
	return bG .. ("/" .. (tostring(N) .. ".json"));
end;
local function OG(N)
	local G = {};
	for N, V in pairs(N) do
		if typeof(V) == "Color3" then
			G[N] = { V.R, V.G, V.B };
		elseif typeof(V) == "EnumItem" then
			G[N] = V.Name;
		else
			G[N] = V;
		end;
	end;
	return G;
end;
local function qG(N, G)
	if type(G) ~= "table" then
		return;
	end;
	for G, V in pairs(G) do
		if G == "MenuKey" and type(V) == "string" then
			local z, v = pcall(function()
					return Enum.KeyCode[V];
				end);
			if z and v then
				N[G] = v;
			end;
		elseif N[G] ~= nil and type(V) == type(N[G]) then
			N[G] = V;
		end;
	end;
end;
local function FG(N)
	if N.C or N.H or N.anim then
		qG(o, N.C or N.ui);
		qG(i, N.H or N.hns);
		if type(N.anim) == "table" then
			for N, G in pairs(N.anim) do
				if Ji[tostring(N)] ~= nil and not Mi[tostring(N)] then
					x.animEnabled[tostring(N)] = G and true or false;
				end;
			end;
		end;
	else
		qG(o, N);
	end;
	SO();
	Li();
	Ri();
	tO();
	qO();
	Si();
end;
local function nG(N)
	N = N or x.currentConfigName;
	if not x.FILE.writefile then
		return false, "no writefile";
	end;
	yG();
	local G = (tostring(N)):gsub("[^%w%-%_]", "");
	if G == "" then
		G = "default";
	end;
	x.currentConfigName = G;
	local V = { C = OG(o), H = OG(i), anim = x.animEnabled };
	local z = pcall(function()
			x.FILE.writefile(PG(G), R:JSONEncode(V));
		end);
	if not z then
		return false, "writefile failed";
	end;
	return true, "ok";
end;
local function mG(N)
	N = N or x.currentConfigName;
	if not x.FILE.readfile or not x.FILE.isfile then
		return false, "no readfile";
	end;
	local G = PG(N);
	local V, z = pcall(x.FILE.isfile, G);
	if not V or not z then
		return false, "not found";
	end;
	local v, C = pcall(x.FILE.readfile, G);
	if not v or not C then
		return false, "read failed";
	end;
	local b, y = pcall(function()
			return R:JSONDecode(C);
		end);
	if not b or type(y) ~= "table" then
		return false, "bad json";
	end;
	FG(y);
	x.currentConfigName = (tostring(N)):gsub("[^%w%-%_]", "");
	return true, "ok";
end;
local function xG()
	local N = {};
	if not x.FILE.listfiles or not x.FILE.isfolder then
		return N;
	end;
	local G, V = pcall(x.FILE.isfolder, bG);
	if not G or not V then
		return N;
	end;
	local z, v = pcall(x.FILE.listfiles, bG);
	if not z or type(v) ~= "table" then
		return N;
	end;
	for G, V in ipairs(v) do
		local z = (tostring(V)):match("([^/\\]+)%.json$");
		if z and z ~= "" then
			table.insert(N, z);
		end;
	end;
	table.sort(N);
	return N;
end;
local function wG(N)
	if not x.FILE.delfile then
		return false, "no delfile";
	end;
	local G = pcall(x.FILE.delfile, PG(N));
	return G;
end;
x.ui = {};
x.ui.PANEL_W = 400;
x.ui.PANEL_H = 660;
x.ui.CONTENT_W = x.ui.PANEL_W - 16;
x.ui.CONTENT_H = x.ui.PANEL_H - 90;
x.ui.BTN_W = x.ui.CONTENT_W - 8;
x.ui.COL = {
		bg = Color3.fromRGB(11, 9, 18),
		bg2 = Color3.fromRGB(22, 15, 36),
		card = Color3.fromRGB(26, 20, 40),
		text = Color3.fromRGB(235, 225, 250),
		textDim = Color3.fromRGB(150, 135, 175),
		off = Color3.fromRGB(22, 17, 34),
	};
x.ui.tabFrames = {};
x.ui.activeTab = "Main";
x.ui.pickerOverlay = nil;
function x.ui.mkDivider(N, G, V)
	local z = Instance.new("Frame");
	z.Size = UDim2.new(1, -8, 0, 18);
	z.Position = UDim2.fromOffset(4, G);
	z.BackgroundTransparency = 1;
	z.ZIndex = 5;
	z.Parent = N;
	local v = Instance.new("TextLabel");
	v.Size = UDim2.fromOffset(180, 18);
	v.BackgroundTransparency = 1;
	v.Font = Enum.Font.GothamBold;
	v.TextSize = 9;
	v.Text = string.upper(V or "");
	v.TextColor3 = Y();
	v.TextXAlignment = Enum.TextXAlignment.Left;
	v.ZIndex = 6;
	v.Parent = z;
	vi(function()
		v.TextColor3 = Y();
	end);
	local R = Instance.new("Frame");
	R.Size = UDim2.new(1, -190, 0, 1);
	R.Position = UDim2.fromOffset(190, 9);
	R.BackgroundColor3 = Y();
	R.BackgroundTransparency = .72;
	R.BorderSizePixel = 0;
	R.ZIndex = 6;
	R.Parent = z;
	vi(function()
		R.BackgroundColor3 = Y();
	end);
end;
function x.ui.makeToggle(N, G, V, z, v, R, b)
	local y = x.ui.COL;
	local P = x.ui.BTN_W;
	b = b or o;
	local O = Instance.new("TextButton");
	O.Size = UDim2.fromOffset(P, 26);
	O.Position = UDim2.fromOffset(4, G);
	O.BorderSizePixel = 0;
	O.Font = Enum.Font.Gotham;
	O.TextSize = 12;
	O.TextXAlignment = Enum.TextXAlignment.Left;
	O.TextColor3 = E();
	O.AutoButtonColor = false;
	O.ZIndex = 6;
	O.Parent = N;
	bi(O, 7);
	local q = Instance.new("Frame");
	q.Size = UDim2.fromOffset(30, 16);
	q.Position = UDim2.new(1, -38, .5, -8);
	q.BorderSizePixel = 0;
	q.ZIndex = 7;
	q.Parent = O;
	bi(q, 8);
	local F = Instance.new("Frame");
	F.Size = UDim2.fromOffset(12, 12);
	F.Position = UDim2.fromOffset(2, 2);
	F.BackgroundColor3 = Color3.new(1, 1, 1);
	F.BorderSizePixel = 0;
	F.ZIndex = 8;
	F.Parent = q;
	bi(F, 6);
	local function n()
		if v then
			return v() and true or false;
		end;
		if z then
			return b[z] and true or false;
		end;
		return false;
	end;
	local function m(N)
		local G = n();
		O.Text = "   " .. V;
		local z = G and A(Y()) or y.off;
		local v = G and Y() or Color3.fromRGB(60, 50, 78);
		local R = G and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
		if N then
			local N = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			(C:Create(O, N, { BackgroundColor3 = z })):Play();
			(C:Create(q, N, { BackgroundColor3 = v })):Play();
			(C:Create(F, N, { Position = R })):Play();
		else
			O.BackgroundColor3 = z;
			q.BackgroundColor3 = v;
			F.Position = R;
		end;
		O.TextColor3 = E();
	end;
	vi(function()
		local N = n();
		O.BackgroundColor3 = N and A(Y()) or y.off;
		O.TextColor3 = E();
		q.BackgroundColor3 = N and Y() or Color3.fromRGB(60, 50, 78);
		F.Position = N and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
	end);
	m(false);
	O.MouseButton1Click:Connect(function()
		if x.unloaded then
			return;
		end;
		Ci();
		local N = not n();
		if z then
			b[z] = N;
		end;
		if R then
			R(N);
		else
			if z == "Enabled" then
				Li();
			elseif z == "RadiusVis" then
				SO();
			elseif z == "RemoveLegs" then
				UO(b.RemoveLegs);
				NG();
			elseif z == "RemoveHands" then
				LO(b.RemoveHands);
				NG();
				gO();
			elseif z == "RemoveTorso" then
				HO(b.RemoveTorso);
				NG();
				gO();
			elseif z == "Headless" then
				GG(b.Headless);
			elseif z == "Korblox" then
				vG(b.Korblox);
			elseif z == "RebelFOVCircle" then
				qO();
			elseif z == "RebelFOVNeon" or z == "RebelFOVBlackOutline" then
				qO();
			elseif z == "Watermark" or z == "KeybindList" then
				Si();
			elseif z == "GuardESP" or z == "PlayerESP" then
				tO();
			elseif z == "HideNick" then
				CG();
			elseif z == "FullBright" then
				jO(b.FullBright);
			elseif z == "RemoveFog" then
				JO(b.RemoveFog);
			elseif z == "FOVRainbow" then
				if b.FOVRainbow then
					yO();
				else
					RO();
					qO();
				end;
			elseif z == "PanelRainbow" then
				if b.PanelRainbow then
					OO();
				else
					PO();
					if x.panel then
						local N = x.panel:FindFirstChildOfClass("UIStroke");
						if N then
							N.Color = Y();
						end;
					end;
				end;
			elseif z == "BulletTracer" then
 
			elseif z == "FOVUseCustom" then
				qO();
				if b.FOVRainbow then
					yO();
				end;
			elseif z == "AutoBrew" then
				if b.AutoBrew then
					YO();
				else
					EO();
				end;
			elseif z == "CircleRainbowText" or z == "CircleRainbowOutline" then
				Ri();
			elseif type(z) == "string" and ((z:sub(1, 9) == "GuardESP_" or z:sub(1, 10) == "PlayerESP_")) then
				tO();
			end;
		end;
		m(true);
		if _G.__adShowNotif then
			_G.__adShowNotif(V .. (":  " .. ((N and "ON" or "OFF"))), N and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80));
		end;
	end);
	return m;
end;
function x.ui.makeSlider(N, G, z, v, R, C, b, y, P)
	local O = x.ui.COL;
	local q = x.ui.BTN_W;
	y = y or o;
	local F = Instance.new("Frame");
	F.Size = UDim2.fromOffset(q, 40);
	F.Position = UDim2.fromOffset(4, G);
	F.BackgroundTransparency = 1;
	F.ZIndex = 5;
	F.Parent = N;
	local n = Instance.new("TextLabel");
	n.Size = UDim2.fromOffset(q, 14);
	n.BackgroundTransparency = 1;
	n.Font = Enum.Font.Gotham;
	n.TextSize = 11;
	n.TextXAlignment = Enum.TextXAlignment.Left;
	n.TextColor3 = E();
	n.ZIndex = 6;
	n.Parent = F;
	vi(function()
		n.TextColor3 = E();
	end);
	local function m()
		n.Text = z .. ("   " .. tostring(y[v]));
	end;
	m();
	local w = Instance.new("TextButton");
	w.Size = UDim2.fromOffset(q, 14);
	w.Position = UDim2.fromOffset(0, 18);
	w.BackgroundColor3 = O.card;
	w.BorderSizePixel = 0;
	w.Text = "";
	w.AutoButtonColor = false;
	w.ZIndex = 6;
	w.Parent = F;
	bi(w, 7);
	local h = Instance.new("Frame");
	h.Size = UDim2.new(math.clamp(((((y[v] or R)) - R)) / ((C - R)), 0, 1), 0, 1, 0);
	h.BorderSizePixel = 0;
	h.ZIndex = 7;
	h.Parent = w;
	bi(h, 7);
	h.BackgroundColor3 = Y();
	vi(function()
		h.BackgroundColor3 = Y();
	end);
	local S = Instance.new("Frame");
	S.Size = UDim2.fromOffset(12, 12);
	S.BackgroundColor3 = Color3.new(1, 1, 1);
	S.BorderSizePixel = 0;
	S.ZIndex = 8;
	S.Parent = w;
	bi(S, 6);
	Pi(S, Color3.new(0, 0, 0), 1, .5);
	local i = false;
	local function j()
		local N = ((((y[v] or R)) - R)) / ((C - R));
		S.Position = UDim2.new(N, -6, .5, -6);
	end;
	j();
	local function J(N)
		local G = math.clamp(((N - w.AbsolutePosition.X)) / math.max(w.AbsoluteSize.X, 1), 0, 1);
		local V = R + G * ((C - R));
		V = math.floor(V / b + .5) * b;
		if b < 1 then
			V = math.floor(V * 100 + .5) / 100;
		end;
		y[v] = math.clamp(V, R, C);
		h.Size = UDim2.new(((y[v] - R)) / ((C - R)), 0, 1, 0);
		j();
		m();
		if P then
			pcall(P);
		end;
	end;
	w.InputBegan:Connect(function(N)
		if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
			i = true;
			J(N.Position.X);
		end;
	end);
	r(V.InputEnded:Connect(function(N)
		if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
			i = false;
		end;
	end));
	r(V.InputChanged:Connect(function(N)
		if i and ((N.UserInputType == Enum.UserInputType.MouseMovement or N.UserInputType == Enum.UserInputType.Touch)) then
			J(N.Position.X);
		end;
	end));
	return m;
end;
function x.ui.makeBtn(N, G, V, z)
	local v = x.ui.COL;
	local R = x.ui.BTN_W;
	local C = Instance.new("TextButton");
	C.Size = UDim2.fromOffset(R, 28);
	C.Position = UDim2.fromOffset(4, G);
	C.BackgroundColor3 = v.card;
	C.BorderSizePixel = 0;
	C.Font = Enum.Font.GothamBold;
	C.TextSize = 12;
	C.TextColor3 = E();
	C.Text = V;
	C.ZIndex = 6;
	C.Parent = N;
	bi(C, 7);
	vi(function()
		C.TextColor3 = E();
	end);
	local b = Pi(C, Y(), 1, .55);
	vi(function()
		b.Color = Y();
	end);
	C.MouseButton1Click:Connect(function()
		if x.unloaded then
			return;
		end;
		Ci();
		z();
	end);
	return C;
end;
function x.ui.makeInput(N, G, V)
	local z = x.ui.COL;
	local v = x.ui.BTN_W;
	local R = Instance.new("TextBox");
	R.Size = UDim2.fromOffset(v, 26);
	R.Position = UDim2.fromOffset(4, G);
	R.BackgroundColor3 = z.card;
	R.BorderSizePixel = 0;
	R.Font = Enum.Font.Gotham;
	R.TextSize = 12;
	R.TextColor3 = E();
	R.PlaceholderText = V;
	R.PlaceholderColor3 = z.textDim;
	R.Text = "";
	R.ClearTextOnFocus = false;
	R.ZIndex = 6;
	R.Parent = N;
	bi(R, 7);
	vi(function()
		R.TextColor3 = E();
	end);
	local C = Pi(R, z.off, 1, .4);
	vi(function()
		C.Color = Y();
	end);
	return R;
end;
function x.ui.colorRow(N, G, V, z, v)
	local R = x.ui.COL;
	local C = x.ui.BTN_W;
	local b = Instance.new("Frame");
	b.Size = UDim2.fromOffset(C, 30);
	b.Position = UDim2.fromOffset(4, G);
	b.BackgroundTransparency = 1;
	b.ZIndex = 5;
	b.Parent = N;
	local y = Instance.new("TextLabel");
	y.Size = UDim2.fromOffset(120, 30);
	y.Position = UDim2.fromOffset(0, 0);
	y.BackgroundTransparency = 1;
	y.Font = Enum.Font.Gotham;
	y.TextSize = 11;
	y.TextXAlignment = Enum.TextXAlignment.Left;
	y.TextColor3 = E();
	y.Text = V or "";
	y.ZIndex = 6;
	y.Parent = b;
	vi(function()
		y.TextColor3 = E();
	end);
	local P = Instance.new("Frame");
	P.Size = UDim2.fromOffset(28, 28);
	P.Position = UDim2.fromOffset(C - 148, 1);
	P.BorderSizePixel = 0;
	P.BackgroundColor3 = z();
	P.ZIndex = 6;
	P.Parent = b;
	bi(P, 8);
	local O = Pi(P, Y(), 1.5, .2);
	vi(function()
		O.Color = Y();
	end);
	local q = Instance.new("TextButton");
	q.Size = UDim2.fromOffset(114, 26);
	q.Position = UDim2.fromOffset(C - 116, 2);
	q.BackgroundColor3 = R.card;
	q.BorderSizePixel = 0;
	q.Font = Enum.Font.GothamBold;
	q.TextSize = 11;
	q.TextColor3 = E();
	q.Text = "Change color";
	q.AutoButtonColor = false;
	q.ZIndex = 6;
	q.Parent = b;
	vi(function()
		q.TextColor3 = E();
	end);
	bi(q, 6);
	local F = Pi(q, Y(), 1, .5);
	vi(function()
		F.Color = Y();
	end);
	q.MouseButton1Click:Connect(function()
		if x.unloaded then
			return;
		end;
		Ci();
		if x.colorPickerOpen then
			x.colorPickerOpen(z(), function(N)
				pcall(v, N);
				P.BackgroundColor3 = N;
			end);
		end;
	end);
	vi(function()
		P.BackgroundColor3 = z();
	end);
end;
function x.ui.buildPanel()
	local N = x.ui.COL;
	local G = x.ui.PANEL_W;
	local z = x.ui.PANEL_H;
	local R = nil;
	if gethui then
		local N, G = pcall(gethui);
		if N and (G and typeof(G) == "Instance") then
			R = G;
		end;
	end;
	if not R or typeof(R) ~= "Instance" then
		R = F:FindFirstChildOfClass("PlayerGui");
	end;
	if not R then
		R = F:WaitForChild("PlayerGui", 5);
	end;
	if not R then
		R = game:GetService("CoreGui");
	end;
	x.gui = Instance.new("ScreenGui");
	x.gui.Name = "XD_x1oni1x_" .. Gi(6);
	x.gui.ResetOnSpawn = false;
	x.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	x.gui.DisplayOrder = 100000;
	x.gui.IgnoreGuiInset = true;
	x.gui.Enabled = true;
	pcall(function()
		x.gui.Parent = R;
	end);
	if not x.gui.Parent then
		pcall(function()
			x.gui.Parent = game:GetService("CoreGui");
		end);
	end;
	x.glow = Instance.new("Frame");
	x.glow.Size = UDim2.fromOffset(G + 40, z + 40);
	x.glow.Position = UDim2.new(.5, (-G / 2 - 20) - 800, .5, -z / 2 - 20);
	x.glow.BackgroundColor3 = Y();
	x.glow.BackgroundTransparency = .86;
	x.glow.BorderSizePixel = 0;
	x.glow.ZIndex = 0;
	x.glow.Parent = x.gui;
	bi(x.glow, 22);
	vi(function()
		x.glow.BackgroundColor3 = Y();
	end);
	x.shadow = Instance.new("Frame");
	x.shadow.Size = UDim2.fromOffset(G + 12, z + 12);
	x.shadow.Position = UDim2.new(.5, (-G / 2 + 6) - 800, .5, -z / 2 + 6);
	x.shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	x.shadow.BackgroundTransparency = .65;
	x.shadow.BorderSizePixel = 0;
	x.shadow.ZIndex = 1;
	x.shadow.Parent = x.gui;
	bi(x.shadow, 18);
	x.panel = Instance.new("Frame");
	x.panel.Size = UDim2.fromOffset(G, z);
	x.panel.Position = UDim2.new(.5, -G / 2 - 800, .5, -z / 2);
	x.panel.BackgroundColor3 = N.bg;
	x.panel.BorderSizePixel = 0;
	x.panel.Active = true;
	x.panel.Visible = true;
	x.panel.ZIndex = 2;
	x.panel.Parent = x.gui;
	x.panel.ClipsDescendants = true;
	bi(x.panel, 14);
	yi(x.panel, N.bg2, N.bg, 90);
	local b = Pi(x.panel, Y(), 1.4, .35);
	vi(function()
		if not o.PanelRainbow then
			b.Color = Y();
		end;
	end);
	r((x.panel:GetPropertyChangedSignal("Position")):Connect(function()
		x.shadow.Position = UDim2.new(x.panel.Position.X.Scale, x.panel.Position.X.Offset + 6, x.panel.Position.Y.Scale, x.panel.Position.Y.Offset + 6);
		x.glow.Position = UDim2.new(x.panel.Position.X.Scale, x.panel.Position.X.Offset - 20, x.panel.Position.Y.Scale, x.panel.Position.Y.Offset - 20);
	end));
	task.spawn(function()
		task.wait(.05);
		if x.unloaded or not x.panel or not x.panel.Parent then
			return;
		end;
		local N = TweenInfo.new(.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
		(C:Create(x.panel, N, { Position = UDim2.new(.5, -G / 2, .5, -z / 2) })):Play();
		if x.shadow and x.shadow.Parent then
			(C:Create(x.shadow, N, { Position = UDim2.new(.5, -G / 2 + 6, .5, -z / 2 + 6) })):Play();
		end;
		if x.glow and x.glow.Parent then
			(C:Create(x.glow, N, { Position = UDim2.new(.5, -G / 2 - 20, .5, -z / 2 - 20) })):Play();
		end;
	end);
	do
		local N = false;
		local G = nil;
		local z = nil;
		r(x.panel.InputBegan:Connect(function(V)
			if V.UserInputType == Enum.UserInputType.MouseButton1 or V.UserInputType == Enum.UserInputType.Touch then
				N = true;
				G = V.Position;
				z = x.panel.Position;
				V.Changed:Connect(function()
					if V.UserInputState == Enum.UserInputState.End then
						N = false;
					end;
				end);
			end;
		end));
		r(V.InputChanged:Connect(function(V)
			if not N then
				return;
			end;
			if V.UserInputType == Enum.UserInputType.MouseMovement or V.UserInputType == Enum.UserInputType.Touch then
				local N = V.Position - G;
				x.panel.Position = UDim2.new(z.X.Scale, z.X.Offset + N.X, z.Y.Scale, z.Y.Offset + N.Y);
			end;
		end));
	end;
	local P = Instance.new("Frame");
	P.Size = UDim2.new(1, -28, 0, 2);
	P.Position = UDim2.fromOffset(14, 0);
	P.BackgroundColor3 = Y();
	P.BorderSizePixel = 0;
	P.ZIndex = 3;
	P.Parent = x.panel;
	bi(P, 2);
	vi(function()
		P.BackgroundColor3 = Y();
	end);
	local O = Instance.new("TextLabel");
	O.Size = UDim2.fromOffset(240, 20);
	O.Position = UDim2.fromOffset(14, 12);
	O.BackgroundTransparency = 1;
	O.Font = Enum.Font.GothamBlack;
	O.TextSize = 13;
	O.TextXAlignment = Enum.TextXAlignment.Left;
	O.TextColor3 = Y();
	O.Text = n;
	O.ZIndex = 3;
	O.Parent = x.panel;
	vi(function()
		O.TextColor3 = Y();
	end);
	local q = Instance.new("TextLabel");
	q.Size = UDim2.fromOffset(140, 40);
	q.Position = UDim2.new(1, -192, 0, 12);
	q.BackgroundTransparency = 1;
	q.Font = Enum.Font.Code;
	q.TextSize = 10;
	q.TextXAlignment = Enum.TextXAlignment.Right;
	q.TextYAlignment = Enum.TextYAlignment.Top;
	q.TextColor3 = N.textDim;
	q.Text = "fps ---\nping ---";
	q.ZIndex = 3;
	q.Parent = x.panel;
	local w = Instance.new("TextLabel");
	w.Size = UDim2.new(1, -20, 0, 12);
	w.Position = UDim2.fromOffset(14, 30);
	w.BackgroundTransparency = 1;
	w.Font = Enum.Font.Gotham;
	w.TextSize = 9;
	w.TextXAlignment = Enum.TextXAlignment.Left;
	w.TextColor3 = E();
	w.Text = "ink game - auto dodge";
	w.ZIndex = 3;
	w.Parent = x.panel;
	vi(function()
		w.TextColor3 = E();
	end);
	local h = Instance.new("TextLabel");
	h.Size = UDim2.new(1, -20, 0, 12);
	h.Position = UDim2.fromOffset(14, 44);
	h.BackgroundTransparency = 1;
	h.Font = Enum.Font.Code;
	h.TextSize = 10;
	h.TextXAlignment = Enum.TextXAlignment.Left;
	h.TextColor3 = E();
	h.Text = "ready - N to close";
	h.ZIndex = 3;
	h.Parent = x.panel;
	vi(function()
		h.TextColor3 = E();
	end);
	local S = Instance.new("TextButton");
	S.AnchorPoint = Vector2.new(1, 0);
	S.Size = UDim2.fromOffset(24, 24);
	S.Position = UDim2.new(1, -12, 0, 12);
	S.BackgroundColor3 = N.card;
	S.BorderSizePixel = 0;
	S.Font = Enum.Font.GothamBlack;
	S.TextSize = 18;
	S.TextColor3 = E();
	S.Text = "-";
	S.AutoButtonColor = false;
	S.ZIndex = 12;
	S.Parent = x.panel;
	vi(function()
		S.TextColor3 = E();
	end);
	bi(S, 6);
	local j = Pi(S, Y(), 1.5, 0);
	vi(function()
		j.Color = Y();
	end);
	local function J(N)
		if not x.unloaded and (h and h.Parent) then
			h.Text = tostring(N or "");
		end;
	end;
	_G.__ad_statusCb = J;
	local M = 0;
	local Z = tick();
	local A = 0;
	r(v.RenderStepped:Connect(function()
		M = M + 1;
		local N = tick();
		if N - Z >= 2 then
			A = math.floor(M / ((N - Z)));
			M = 0;
			Z = N;
		end;
	end));
	task.spawn(function()
		while not x.unloaded do
			local N = 0;
			pcall(function()
				local G = y.Network.ServerStatsItem["Data Ping"];
				if G then
					N = math.floor(G:GetValue());
				end;
			end);
			if not x.unloaded and (q and q.Parent) then
				local G = game.JobId or "";
				if #G > 8 then
					G = G:sub(1, 8);
				end;
				if G == "" then
					G = "studio";
				end;
				q.Text = string.format("fps %d\nping %d - srv %s", A, N, G);
			end;
			if not x.unloaded and (x.wmLabel and o.Watermark) then
				pcall(function()
					local G = tostring(F.Name or "?");
					if #G > 14 then
						G = G:sub(1, 14) .. "...";
					end;
					local V = (o.MenuKey and o.MenuKey.Name) or "N";
					x.wmLabel.Text = string.format("%s %s\n%s | %dms | [%s]", n, m, G, N, V);
				end);
			end;
			if not x.unloaded and (x.kbLabel and o.KeybindList) then
				pcall(function()
					local N = {};
					if o.Enabled then
						table.insert(N, "AutoDodge:  ON");
					end;
					if i.Enabled then
						table.insert(N, "HnS Dodge:  ON");
					end;
					if o.RLGL_AutoDodge then
						table.insert(N, "RLGL:  ON");
					end;
					if o.RebelSilentAim then
						table.insert(N, "Silent Aim:  ON");
					end;
					if o.RebelNoRecoil then
						table.insert(N, "No Recoil:  ON");
					end;
					if o.RebelRapidFire then
						table.insert(N, "Rapid Fire:  ON");
					end;
					if o.BulletTracer then
						table.insert(N, "Bullet Tracer:  ON");
					end;
					if o.GuardESP then
						table.insert(N, "Guard ESP:  ON");
					end;
					if o.PlayerESP then
						table.insert(N, "Player ESP:  ON");
					end;
					if o.HideNick then
						table.insert(N, "HideNick:  ON");
					end;
					if o.FullBright then
						table.insert(N, "Full Bright:  ON");
					end;
					if o.RemoveFog then
						table.insert(N, "No Fog:  ON");
					end;
					if o.AutoBrew then
						table.insert(N, "Auto Brew:  ON");
					end;
					if o.AnimSpeed then
						table.insert(N, "Anim 2.5x:  ON");
					end;
					x.kbLabel.Text = (#N == 0) and "[no features]" or table.concat(N, "\n");
					if x.kbFrame then
						local G = math.max(1, #N);
						x.kbFrame.Size = UDim2.fromOffset(210, math.max(30, G * 12 + 8));
					end;
				end);
			end;
			task.wait(3);
		end;
	end);
	local s = Instance.new("Frame");
	s.Size = UDim2.new(1, -16, 0, 26);
	s.Position = UDim2.fromOffset(8, 58);
	s.BackgroundColor3 = N.off;
	s.BackgroundTransparency = .35;
	s.BorderSizePixel = 0;
	s.ZIndex = 3;
	s.Parent = x.panel;
	bi(s, 8);
	local f = {
			"Main",
			"HnS",
			"Rebel",
			"RLGL",
			"ESP",
			"Dalgona",
			"Extra",
			"Configs",
		};
	local p = Instance.new("Frame");
	p.Size = UDim2.fromOffset(x.ui.CONTENT_W, x.ui.CONTENT_H);
	p.Position = UDim2.fromOffset(8, 88);
	p.BackgroundTransparency = 1;
	p.ZIndex = 4;
	p.Parent = x.panel;
	for N, G in ipairs(f) do
		local V = Instance.new("ScrollingFrame");
		V.Size = UDim2.fromOffset(x.ui.CONTENT_W, x.ui.CONTENT_H);
		V.BackgroundTransparency = 1;
		V.BorderSizePixel = 0;
		V.ScrollBarThickness = 3;
		V.ScrollBarImageColor3 = Y();
		V.ScrollingDirection = Enum.ScrollingDirection.Y;
		V.CanvasSize = UDim2.fromOffset(0, 5000);
		V.ElasticBehavior = Enum.ElasticBehavior.Never;
		V.Visible = G == "Main";
		V.ZIndex = 5;
		V.Parent = p;
		vi(function()
			if V and V.Parent then
				V.ScrollBarImageColor3 = Y();
			end;
		end);
		x.ui.tabFrames[G] = V;
	end;
	x.ui.showTab = function(N)
			x.ui.activeTab = N;
			for G, V in pairs(x.ui.tabFrames) do
				V.Visible = G == N;
			end;
			Ri();
			if N == "Configs" and _G.__adRefreshConfigs then
				pcall(_G.__adRefreshConfigs);
			end;
		end;
	do
		local G = #f;
		local V = math.floor(((x.ui.CONTENT_W - 4)) / G);
		local z = 2;
		for G, v in ipairs(f) do
			local R = Instance.new("TextButton");
			R.Size = UDim2.fromOffset(V, 22);
			R.Position = UDim2.fromOffset(z, 2);
			R.BorderSizePixel = 0;
			R.Font = Enum.Font.GothamBold;
			R.TextSize = 8;
			R.Text = v;
			R.AutoButtonColor = false;
			R.ZIndex = 4;
			R.Parent = s;
			R.TextTruncate = Enum.TextTruncate.AtEnd;
			R.TextScaled = false;
			bi(R, 6);
			R.MouseButton1Click:Connect(function()
				Ci();
				x.ui.showTab(v);
			end);
			vi(function()
				local G = x.ui.activeTab == v;
				R.BackgroundColor3 = G and Y() or N.off;
				R.BackgroundTransparency = G and 0 or 1;
				R.TextColor3 = G and Color3.new(1, 1, 1) or E();
			end);
			z = z + V;
		end;
	end;
	Ri();
	x.ui.collapseBtn = S;
	x.ui.buildColorPicker();
end;
function x.ui.buildColorPicker()
	local N = x.ui.COL;
	local G = x.ui.PANEL_W;
	local z = x.ui.PANEL_H;
	local v = Instance.new("Frame");
	v.Size = UDim2.fromOffset(G, z);
	v.Position = UDim2.fromOffset(0, 0);
	v.BackgroundColor3 = N.bg;
	v.BackgroundTransparency = .02;
	v.Visible = false;
	v.ZIndex = 60;
	v.Parent = x.panel;
	bi(v, 14);
	yi(v, N.bg2, N.bg, 90);
	x.ui.pickerOverlay = v;
	local R = Instance.new("TextLabel");
	R.Size = UDim2.new(1, -40, 0, 22);
	R.Position = UDim2.fromOffset(14, 14);
	R.BackgroundTransparency = 1;
	R.Font = Enum.Font.GothamBlack;
	R.TextSize = 14;
	R.TextXAlignment = Enum.TextXAlignment.Left;
	R.TextColor3 = Y();
	R.Text = "COLOR PICKER";
	R.ZIndex = 61;
	R.Parent = v;
	vi(function()
		R.TextColor3 = Y();
	end);
	local C = Instance.new("TextButton");
	C.Size = UDim2.fromOffset(60, 24);
	C.Position = UDim2.new(1, -74, 0, 12);
	C.BackgroundColor3 = N.card;
	C.BorderSizePixel = 0;
	C.Font = Enum.Font.GothamBold;
	C.TextSize = 11;
	C.TextColor3 = E();
	C.Text = "X close";
	C.ZIndex = 61;
	C.Parent = v;
	vi(function()
		C.TextColor3 = E();
	end);
	bi(C, 6);
	local b = Pi(C, Y(), 1, .5);
	vi(function()
		b.Color = Y();
	end);
	local y = Instance.new("Frame");
	y.Size = UDim2.fromOffset(150, 120);
	y.Position = UDim2.new(.5, -75, 0, 40);
	y.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	y.BorderSizePixel = 0;
	y.ZIndex = 61;
	y.Parent = v;
	bi(y, 12);
	local P = Pi(y, Y(), 2, 0);
	vi(function()
		P.Color = Y();
	end);
	local O = Instance.new("TextLabel");
	O.Size = UDim2.new(1, 0, 0, 18);
	O.Position = UDim2.new(0, 0, 1, -22);
	O.BackgroundTransparency = 1;
	O.Font = Enum.Font.Code;
	O.TextSize = 11;
	O.TextColor3 = Color3.fromRGB(255, 255, 255);
	O.TextStrokeTransparency = .4;
	O.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	O.Text = "#FFFFFF";
	O.ZIndex = 62;
	O.Parent = y;
	local q = {
			R = 255,
			G = 255,
			B = 255,
			bright = 1,
			callback = nil,
		};
	local function F(N)
		return math.clamp(math.floor(N * q.bright + .5), 0, 255);
	end;
	local function n()
		local N = F(q.R);
		local G = F(q.G);
		local V = F(q.B);
		y.BackgroundColor3 = Color3.fromRGB(N, G, V);
		O.Text = string.format("RGB %d,%d,%d  x%.2f", N, G, V, q.bright);
	end;
	local function m(G, z, R, C, b, y)
		local P = Instance.new("Frame");
		P.Size = UDim2.new(1, -28, 0, 46);
		P.Position = UDim2.fromOffset(14, G);
		P.BackgroundTransparency = 1;
		P.ZIndex = 61;
		P.Parent = v;
		local O = Instance.new("TextLabel");
		O.Size = UDim2.new(1, -60, 0, 16);
		O.BackgroundTransparency = 1;
		O.Font = Enum.Font.GothamBold;
		O.TextSize = 11;
		O.TextXAlignment = Enum.TextXAlignment.Left;
		O.TextColor3 = E();
		O.Text = z;
		O.ZIndex = 62;
		O.Parent = P;
		local F = Instance.new("TextLabel");
		F.Size = UDim2.fromOffset(60, 16);
		F.Position = UDim2.new(1, -60, 0, 0);
		F.BackgroundTransparency = 1;
		F.Font = Enum.Font.Code;
		F.TextSize = 11;
		F.TextXAlignment = Enum.TextXAlignment.Right;
		F.TextColor3 = E();
		F.Text = "255";
		F.ZIndex = 62;
		F.Parent = P;
		local m = Instance.new("TextButton");
		m.Size = UDim2.new(1, 0, 0, 18);
		m.Position = UDim2.fromOffset(0, 20);
		m.BackgroundColor3 = N.card;
		m.BorderSizePixel = 0;
		m.Text = "";
		m.AutoButtonColor = false;
		m.ZIndex = 62;
		m.Parent = P;
		bi(m, 6);
		local x = Instance.new("Frame");
		x.Size = UDim2.new(1, 0, 1, 0);
		x.BorderSizePixel = 0;
		x.ZIndex = 63;
		x.Parent = m;
		bi(x, 6);
		x.BackgroundColor3 = C;
		local w = Instance.new("Frame");
		w.Size = UDim2.fromOffset(14, 14);
		w.BackgroundColor3 = Color3.new(1, 1, 1);
		w.BorderSizePixel = 0;
		w.ZIndex = 64;
		w.Parent = m;
		bi(w, 7);
		Pi(w, Color3.new(0, 0, 0), 1, .4);
		local h = false;
		local function S()
			local N = q[R];
			local G = ((N - b)) / ((y - b));
			w.Position = UDim2.new(G, -7, .5, -7);
			if y <= 3 then
				F.Text = string.format("%.2f", N);
			else
				F.Text = tostring(math.floor(N + .5));
			end;
		end;
		S();
		local function o(N)
			local G = math.clamp(((N - m.AbsolutePosition.X)) / math.max(m.AbsoluteSize.X, 1), 0, 1);
			local V = b + G * ((y - b));
			if y <= 3 then
				q[R] = math.floor(V * 100 + .5) / 100;
			else
				q[R] = math.floor(V + .5);
			end;
			S();
			n();
		end;
		m.InputBegan:Connect(function(N)
			if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
				h = true;
				o(N.Position.X);
			end;
		end);
		r(V.InputEnded:Connect(function(N)
			if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
				h = false;
			end;
		end));
		r(V.InputChanged:Connect(function(N)
			if h and ((N.UserInputType == Enum.UserInputType.MouseMovement or N.UserInputType == Enum.UserInputType.Touch)) then
				o(N.Position.X);
			end;
		end));
		return S;
	end;
	local w = m(175, "Red", "R", Color3.fromRGB(255, 60, 60), 0, 255);
	local h = m(228, "Green", "G", Color3.fromRGB(80, 255, 100), 0, 255);
	local S = m(281, "Blue", "B", Color3.fromRGB(80, 140, 255), 0, 255);
	local o = m(334, "Brightness x", "bright", Color3.fromRGB(255, 255, 255), 0, 2);
	local i = Instance.new("TextButton");
	i.Size = UDim2.fromOffset(140, 34);
	i.Position = UDim2.new(0, 14, 0, 400);
	i.BackgroundColor3 = Y();
	i.BorderSizePixel = 0;
	i.Font = Enum.Font.GothamBlack;
	i.TextSize = 13;
	i.TextColor3 = Color3.fromRGB(255, 255, 255);
	i.Text = "APPLY";
	i.ZIndex = 61;
	i.Parent = v;
	bi(i, 8);
	vi(function()
		i.BackgroundColor3 = Y();
	end);
	local j = Instance.new("TextButton");
	j.Size = UDim2.fromOffset(140, 34);
	j.Position = UDim2.new(1, -154, 0, 400);
	j.BackgroundColor3 = N.card;
	j.BorderSizePixel = 0;
	j.Font = Enum.Font.GothamBold;
	j.TextSize = 13;
	j.TextColor3 = E();
	j.Text = "Cancel";
	j.ZIndex = 61;
	j.Parent = v;
	bi(j, 8);
	local J = Pi(j, Y(), 1, .5);
	vi(function()
		J.Color = Y();
	end);
	local function M()
		v.Visible = false;
		q.callback = nil;
	end;
	C.MouseButton1Click:Connect(function()
		Ci();
		M();
	end);
	j.MouseButton1Click:Connect(function()
		Ci();
		M();
	end);
	i.MouseButton1Click:Connect(function()
		Ci();
		if q.callback then
			local N = F(q.R);
			local G = F(q.G);
			local V = F(q.B);
			pcall(q.callback, Color3.fromRGB(N, G, V));
		end;
		M();
	end);
	x.colorPickerOpen = function(N, G)
			q.R = math.floor(N.R * 255 + .5);
			q.G = math.floor(N.G * 255 + .5);
			q.B = math.floor(N.B * 255 + .5);
			q.bright = 1;
			q.callback = G;
			w();
			h();
			S();
			o();
			n();
			v.Visible = true;
		end;
	n();
end;
function x.ui.buildMain()
	local N = x.ui.tabFrames.Main;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	local v = x.ui.makeInput;
	local R = x.ui.colorRow;
	G(N, 0, "Auto Dodge");
	V(N, 22, "Ultra Instinct", "Enabled", nil, nil, o);
	z(N, 52, "Radius (studs)", "Distance", 1, 95, 1, o, function()
		if o.RadiusVis or i.RadiusVis then
			SO();
		end;
	end);
	z(N, 96, "Delay (s)", "Delay", 0, .25, .01, o);
	z(N, 140, "Min interval (s)", "MinInterval", .02, 1, .01, o);
	z(N, 184, "Anim watch min (s)", "AnimWatch", .05, 2, .05, o);
	z(N, 228, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, o);
	G(N, 274, "Radius visualizer");
	V(N, 296, "Show radius", "RadiusVis", nil, nil, o);
	z(N, 326, "Visibility", "RadiusTransparency", .15, .95, .05, o, function()
		if o.RadiusVis or i.RadiusVis then
			SO();
		end;
	end);
	R(N, 370, "Radius color", s, function(N)
		o.RadiusR = math.floor(N.R * 255 + .5);
		o.RadiusG = math.floor(N.G * 255 + .5);
		o.RadiusB = math.floor(N.B * 255 + .5);
		if o.RadiusVis then
			SO();
		end;
	end);
	G(N, 410, "Slot (optional)");
	local C = v(N, 430, "auto = leave empty");
	C.Text = o.ManualUISlot or "";
	(C:GetPropertyChangedSignal("Text")):Connect(function()
		if x.unloaded then
			return;
		end;
		o.ManualUISlot = string.upper(C.Text or "");
	end);
end;
function x.ui.buildHnS()
	local N = x.ui.tabFrames.HnS;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	local v = x.ui.makeInput;
	local R = x.ui.colorRow;
	G(N, 0, "HnS Dodge");
	V(N, 22, "HnS Dodge", "Enabled", nil, nil, i);
	V(N, 52, "Strict mode", "HollyMode", nil, nil, i);
	z(N, 82, "Radius (studs)", "Distance", 1, 95, 1, i, function()
		if o.RadiusVis or i.RadiusVis then
			SO();
		end;
	end);
	z(N, 126, "Delay (s)", "Delay", 0, .25, .01, i);
	z(N, 170, "Min interval (s)", "MinInterval", .02, 1, .01, i);
	z(N, 214, "Anim watch min (s)", "AnimWatch", .05, 2, .05, i);
	z(N, 258, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, i);
	G(N, 304, "Radius visualizer");
	V(N, 326, "Show radius", "RadiusVis", nil, nil, i);
	z(N, 356, "Visibility", "RadiusTransparency", .15, .95, .05, i, function()
		if o.RadiusVis or i.RadiusVis then
			SO();
		end;
	end);
	R(N, 400, "HnS color", f, function(N)
		i.RadiusR = math.floor(N.R * 255 + .5);
		i.RadiusG = math.floor(N.G * 255 + .5);
		i.RadiusB = math.floor(N.B * 255 + .5);
		if i.RadiusVis then
			SO();
		end;
	end);
	G(N, 440, "Slot (optional)");
	local C = v(N, 460, "auto = leave empty");
	C.Text = o.ManualHnSSlot or "";
	(C:GetPropertyChangedSignal("Text")):Connect(function()
		if x.unloaded then
			return;
		end;
		o.ManualHnSSlot = string.upper(C.Text or "");
	end);
end;
function x.ui.buildRebel()
	local N = x.ui.tabFrames.Rebel;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	local v = x.ui.makeBtn;
	local R = x.ui.makeInput;
	local C = x.ui.colorRow;
	G(N, 0, "Silent Aim");
	V(N, 22, "Silent Aim", "RebelSilentAim", nil, function(N)
		o.RebelSilentAim = N;
		if N then
			VO();
		end;
	end, o);
	V(N, 52, "FOV Circle", "RebelFOVCircle", nil, function(N)
		o.RebelFOVCircle = N;
		qO();
	end, o);
	V(N, 82, "Neon glow", "RebelFOVNeon", nil, function(N)
		o.RebelFOVNeon = N;
		qO();
	end, o);
	V(N, 112, "Black outline", "RebelFOVBlackOutline", nil, function(N)
		o.RebelFOVBlackOutline = N;
		qO();
	end, o);
	z(N, 144, "Outline thickness", "RebelFOV_OutlineThickness", 1, 20, 1, o, FO);
	C(N, 188, "Outline color", k, function(N)
		o.RebelFOV_OutlineR = math.floor(N.R * 255 + .5);
		o.RebelFOV_OutlineG = math.floor(N.G * 255 + .5);
		o.RebelFOV_OutlineB = math.floor(N.B * 255 + .5);
		o.FOVRainbow = false;
		RO();
		qO();
	end);
	z(N, 230, "FOV radius (px)", "RebelFOV", 10, 1200, 5, o, FO);
	z(N, 274, "Circle line width", "RebelFOVCircleWidth", .5, 15, .1, o, FO);
	C(N, 318, "FOV color", I, function(N)
		o.RebelFOVR = math.floor(N.R * 255 + .5);
		o.RebelFOVG = math.floor(N.G * 255 + .5);
		o.RebelFOVB = math.floor(N.B * 255 + .5);
		o.FOVUseCustom = false;
		o.FOVRainbow = false;
		RO();
		qO();
	end);
	G(N, 358, "FOV Rainbow (6 modes)");
	local b = V(N, 380, "Rainbow FOV", "FOVRainbow", nil, function(N)
			if N then
				yO();
			else
				RO();
				qO();
			end;
		end, o);
	x.ui.fovRainbowPaint = b;
	z(N, 410, "Blend speed", "RebelFOVBlendSpeed", .1, 3, .05, o);
	local function y(N)
		o.FOVRainbowMode = N;
		o.FOVRainbow = true;
		if x.ui.fovRainbowPaint then
			pcall(x.ui.fovRainbowPaint);
		end;
		qO();
		yO();
	end;
	v(N, 454, "Mode 1: Cycle hue", function()
		y(1);
	end);
	v(N, 486, "Mode 2: Wave", function()
		y(2);
	end);
	v(N, 518, "Mode 3: Gradient blend", function()
		y(3);
	end);
	v(N, 550, "Mode 4: Breathing pulse", function()
		y(4);
	end);
	v(N, 582, "Mode 5: Aurora", function()
		y(5);
	end);
	v(N, 614, "Mode 6: FUSION", function()
		y(6);
	end);
	G(N, 656, "Custom FOV colors (1-9)");
	V(N, 678, "Use custom color", "FOVUseCustom", nil, function(N)
		qO();
		if o.FOVRainbow then
			yO();
		end;
	end, o);
	local function P(N)
		return function()
			local G, V, z = 60, 60, 255;
			if N == 1 then
				G, V, z = o.FOVCustomR1 or 255, o.FOVCustomG1 or 60, o.FOVCustomB1 or 60;
			elseif N == 2 then
				G, V, z = o.FOVCustomR2 or 60, o.FOVCustomG2 or 255, o.FOVCustomB2 or 60;
			elseif N == 3 then
				G, V, z = o.FOVCustomR3 or 60, o.FOVCustomG3 or 140, o.FOVCustomB3 or 255;
			elseif N == 4 then
				G, V, z = o.FOVCustomR4 or 255, o.FOVCustomG4 or 255, o.FOVCustomB4 or 60;
			elseif N == 5 then
				G, V, z = o.FOVCustomR5 or 255, o.FOVCustomG5 or 60, o.FOVCustomB5 or 255;
			elseif N == 6 then
				G, V, z = o.FOVCustomR6 or 60, o.FOVCustomG6 or 255, o.FOVCustomB6 or 255;
			elseif N == 7 then
				G, V, z = o.FOVCustomR7 or 255, o.FOVCustomG7 or 180, o.FOVCustomB7 or 60;
			elseif N == 8 then
				G, V, z = o.FOVCustomR8 or 255, o.FOVCustomG8 or 255, o.FOVCustomB8 or 255;
			elseif N == 9 then
				G, V, z = o.FOVCustomR9 or 180, o.FOVCustomG9 or 60, o.FOVCustomB9 or 255;
			end;
			return Color3.fromRGB(G, V, z);
		end;
	end;
	local function O(N)
		return function(G)
			local V, z, v = math.floor(G.R * 255 + .5), math.floor(G.G * 255 + .5), math.floor(G.B * 255 + .5);
			if N == 1 then
				o.FOVCustomR1, o.FOVCustomG1, o.FOVCustomB1 = V, z, v;
			elseif N == 2 then
				o.FOVCustomR2, o.FOVCustomG2, o.FOVCustomB2 = V, z, v;
			elseif N == 3 then
				o.FOVCustomR3, o.FOVCustomG3, o.FOVCustomB3 = V, z, v;
			elseif N == 4 then
				o.FOVCustomR4, o.FOVCustomG4, o.FOVCustomB4 = V, z, v;
			elseif N == 5 then
				o.FOVCustomR5, o.FOVCustomG5, o.FOVCustomB5 = V, z, v;
			elseif N == 6 then
				o.FOVCustomR6, o.FOVCustomG6, o.FOVCustomB6 = V, z, v;
			elseif N == 7 then
				o.FOVCustomR7, o.FOVCustomG7, o.FOVCustomB7 = V, z, v;
			elseif N == 8 then
				o.FOVCustomR8, o.FOVCustomG8, o.FOVCustomB8 = V, z, v;
			elseif N == 9 then
				o.FOVCustomR9, o.FOVCustomG9, o.FOVCustomB9 = V, z, v;
			end;
			if o.FOVUseCustom then
				qO();
				if o.FOVRainbow then
					yO();
				end;
			end;
		end;
	end;
	for G = 1, 9, 1 do
		local V = 710 + ((G - 1)) * 62;
		C(N, V, "Slot " .. G, P(G), O(G));
		v(N, V + 32, "Use slot " .. G, function()
			o.FOVCustomIdx = G;
			o.FOVUseCustom = true;
			qO();
			if o.FOVRainbow then
				yO();
			end;
		end);
	end;
	G(N, 1278, "Target filter");
	V(N, 1300, "Target players", "RebelTargetPlayers", nil, nil, o);
	V(N, 1330, "Target game guards (NPC)", "RebelTargetNPCs", nil, nil, o);
	G(N, 1366, "Body parts (random)");
	V(N, 1388, "Head", "RebelBodyHead", nil, nil, o);
	V(N, 1418, "Torso", "RebelBodyTorso", nil, nil, o);
	V(N, 1448, "HumanoidRootPart", "RebelBodyHRP", nil, nil, o);
	V(N, 1478, "Left Arm", "RebelBodyLeftArm", nil, nil, o);
	V(N, 1508, "Right Arm", "RebelBodyRightArm", nil, nil, o);
	V(N, 1538, "Left Leg", "RebelBodyLeftLeg", nil, nil, o);
	V(N, 1568, "Right Leg", "RebelBodyRightLeg", nil, nil, o);
	G(N, 1604, "Gun mods");
	V(N, 1626, "No Recoil & Spread", "RebelNoRecoil", nil, function(N)
		o.RebelNoRecoil = N;
		if N then
			VO();
		end;
	end, o);
	V(N, 1656, "Rapid Fire", "RebelRapidFire", nil, function(N)
		o.RebelRapidFire = N;
		if N then
			VO();
		end;
	end, o);
	G(N, 1692, "Bullet tracer");
	V(N, 1714, "Enable Bullet Tracer", "BulletTracer", nil, nil, o);
	V(N, 1744, "Glow", "BulletTracerGlow", nil, nil, o);
	V(N, 1774, "White core", "BulletTracerWhiteCore", nil, nil, o);
	C(N, 1804, "Tracer color", function()
		return Color3.fromRGB(o.BulletTracerR, o.BulletTracerG, o.BulletTracerB);
	end, function(N)
		o.BulletTracerR = math.floor(N.R * 255 + .5);
		o.BulletTracerG = math.floor(N.G * 255 + .5);
		o.BulletTracerB = math.floor(N.B * 255 + .5);
	end);
	z(N, 1846, "Thickness", "BulletTracerThickness", .05, 1, .01, o);
	z(N, 1890, "Speed (studs/s)", "BulletTracerSpeed", 50, 5000, 50, o);
	z(N, 1934, "Lifetime (s)", "BulletTracerLifetime", .1, 5, .05, o);
	z(N, 1978, "Range (studs)", "BulletTracerRange", 50, 2000, 25, o);
	z(N, 2022, "Start offset", "BulletTracerStartOffset", 0, 5, .1, o);
	z(N, 2066, "End offset", "BulletTracerEndOffset", 0, 5, .1, o);
	z(N, 2110, "Opacity", "BulletTracerOpacity", 0, .5, .01, o);
	z(N, 2154, "Cooldown (s)", "BulletTracerCooldown", .01, .5, .01, o);
	local q = {
			"Quad",
			"Linear",
			"Expo",
			"Back",
			"Circ",
			"Sine",
			"Quint",
			"Bounce",
			"Elastic",
		};
	v(N, 2198, "Fade: " .. q[o.BulletTracerFadeIdx or 1], function()
		o.BulletTracerFadeIdx = ((o.BulletTracerFadeIdx or 1)) + 1;
		if o.BulletTracerFadeIdx > #q then
			o.BulletTracerFadeIdx = 1;
		end;
	end);
	G(N, 2240, "Auto Brew (Soda Fountain)");
	V(N, 2262, "Auto brew + collect", "AutoBrew", nil, function(N)
		if N then
			YO();
		else
			EO();
		end;
	end, o);
	local F = R(N, 2292, "brew key (E)");
	F.Text = o.AutoBrewSlot or "E";
	(F:GetPropertyChangedSignal("Text")):Connect(function()
		if x.unloaded then
			return;
		end;
		local N = string.upper(F.Text or "E");
		if N == "" then
			N = "E";
		end;
		o.AutoBrewSlot = N;
	end);
	z(N, 2324, "Brew cooldown (s)", "AutoBrewInterval", 5, 300, 5, o);
	z(N, 2368, "Collect hold (s)", "AutoBrewCollectHold", .5, 5, .1, o);
end;
function x.ui.buildRLGL()
	local N = x.ui.tabFrames.RLGL;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	G(N, 0, "RLGL Auto Dodge");
	V(N, 22, "RLGL Auto Dodge", "RLGL_AutoDodge");
	V(N, 52, "Only on red light", "RLGL_OnlyRedLight");
	V(N, 82, "Auto-dodge after timer 0", "RLGL_TimerEndDodge");
	G(N, 118, "Red light tuning");
	z(N, 140, "Delay after red (s)", "RLGL_RedDelay", .05, 2, .05, o);
	z(N, 184, "Interval (s)", "RLGL_MinInterval", .05, 2, .05, o);
	z(N, 228, "Velocity threshold", "RLGL_VelThreshold", .1, 8, .1, o);
	G(N, 274, "Timer-end tuning");
	z(N, 296, "Delay after 0 (s)", "RLGL_TimerEndDelay", 0, 3, .05, o);
	z(N, 340, "Interval between (s)", "RLGL_TimerEndInterval", .05, 2, .05, o);
	z(N, 384, "Max duration (s)", "RLGL_TimerEndMaxDuration", 3, 30, 1, o);
end;
function x.ui.buildESP()
	local N = x.ui.tabFrames.ESP;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	local v = x.ui.makeBtn;
	local R = x.ui.makeInput;
	local C = x.ui.colorRow;
	G(N, 0, "Playable Guard ESP");
	V(N, 22, "Playable Guard ESP", "GuardESP");
	V(N, 52, "Show HP bar", "GuardESP_HP");
	V(N, 82, "Show Name", "GuardESP_Name");
	V(N, 112, "Show Highlight (chams)", "GuardESP_Highlight");
	V(N, 142, "Show Tracer", "GuardESP_Tracer");
	V(N, 172, "Show Box (2D)", "GuardESP_Box");
	V(N, 202, "HP chip colored BG", "GuardESP_HP_ChipBg", nil, nil, o);
	V(N, 232, "Show Tool (under feet)", "GuardESP_Tool");
	V(N, 262, "Show Distance (right)", "GuardESP_Distance");
	V(N, 292, "Force ALL as Guard (debug)", "GuardESP_ForceAll");
	z(N, 322, "Name size", "GuardESP_NameSize", 8, 32, 1, o);
	z(N, 366, "Max distance (studs)", "GuardESP_MaxDist", 0, 1000, 10, o, tO);
	z(N, 410, "Box thickness", "GuardESP_BoxThickness", 1, 6, .5, o);
	G(N, 454, "Guard accent color");
	C(N, 476, "Guard accent", T, function(N)
		o.GuardESP_ColorR = math.floor(N.R * 255 + .5);
		o.GuardESP_ColorG = math.floor(N.G * 255 + .5);
		o.GuardESP_ColorB = math.floor(N.B * 255 + .5);
		if o.GuardESP then
			tO();
		end;
	end);
	C(N, 508, "Guard tracer", D, function(N)
		o.GuardESP_TracerR = math.floor(N.R * 255 + .5);
		o.GuardESP_TracerG = math.floor(N.G * 255 + .5);
		o.GuardESP_TracerB = math.floor(N.B * 255 + .5);
	end);
	C(N, 540, "Guard box", K, function(N)
		o.GuardESP_BoxR = math.floor(N.R * 255 + .5);
		o.GuardESP_BoxG = math.floor(N.G * 255 + .5);
		o.GuardESP_BoxB = math.floor(N.B * 255 + .5);
	end);
	G(N, 582, "Guard HP chip (4 states)");
	V(N, 604, "Black outline (chip + number)", "GuardESP_HP_Outline", nil, nil, o);
	C(N, 636, "State 1 (>75%)", t, function(N)
		o.GuardESP_HP_State1_R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_State1_G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_State1_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 668, "State 2 (50-75%)", W, function(N)
		o.GuardESP_HP_State2_R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_State2_G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_State2_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 700, "State 3 (25-50%)", g, function(N)
		o.GuardESP_HP_State3_R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_State3_G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_State3_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 732, "State 4 (<25%)", a, function(N)
		o.GuardESP_HP_State4_R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_State4_G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_State4_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	G(N, 776, "Guard HP gradient (vertical bar)");
	local function b()
		return Color3.fromRGB(o.GuardESP_HP_TopR or 80, o.GuardESP_HP_TopG or 255, o.GuardESP_HP_TopB or 80);
	end;
	local function y()
		return Color3.fromRGB(o.GuardESP_HP_M1R or 180, o.GuardESP_HP_M1G or 255, o.GuardESP_HP_M1B or 60);
	end;
	local function P()
		return Color3.fromRGB(o.GuardESP_HP_M2R or 255, o.GuardESP_HP_M2G or 200, o.GuardESP_HP_M2B or 40);
	end;
	local function O()
		return Color3.fromRGB(o.GuardESP_HP_M3R or 255, o.GuardESP_HP_M3G or 120, o.GuardESP_HP_M3B or 60);
	end;
	local function q()
		return Color3.fromRGB(o.GuardESP_HP_BotR or 255, o.GuardESP_HP_BotG or 40, o.GuardESP_HP_BotB or 40);
	end;
	C(N, 798, "Top", b, function(N)
		o.GuardESP_HP_TopR = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_TopG = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_TopB = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 830, "Mid1", y, function(N)
		o.GuardESP_HP_M1R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_M1G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_M1B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 862, "Mid2", P, function(N)
		o.GuardESP_HP_M2R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_M2G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_M2B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 894, "Mid3", O, function(N)
		o.GuardESP_HP_M3R = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_M3G = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_M3B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 926, "Bottom", q, function(N)
		o.GuardESP_HP_BotR = math.floor(N.R * 255 + .5);
		o.GuardESP_HP_BotG = math.floor(N.G * 255 + .5);
		o.GuardESP_HP_BotB = math.floor(N.B * 255 + .5);
		tO();
	end);
	G(N, 970, "Player ESP");
	V(N, 992, "Player ESP", "PlayerESP");
	V(N, 1022, "Show HP bar", "PlayerESP_HP");
	V(N, 1052, "Show Name", "PlayerESP_Name");
	V(N, 1082, "Show Highlight (chams)", "PlayerESP_Highlight");
	V(N, 1112, "Show Tracer", "PlayerESP_Tracer");
	V(N, 1142, "Show Box (2D)", "PlayerESP_Box");
	V(N, 1172, "HP chip colored BG", "PlayerESP_HP_ChipBg", nil, nil, o);
	V(N, 1202, "Show Tool (under feet)", "PlayerESP_Tool");
	V(N, 1232, "Show Distance (right)", "PlayerESP_Distance");
	G(N, 1262, "Custom name");
	local F = R(N, 1284, "custom name (empty = real)");
	F.Text = o.PlayerESP_CustomName or "";
	(F:GetPropertyChangedSignal("Text")):Connect(function()
		if x.unloaded then
			return;
		end;
		o.PlayerESP_CustomName = F.Text or "";
		tO();
	end);
	V(N, 1318, "Rainbow name", "PlayerESP_NameRainbow", nil, nil, o);
	z(N, 1348, "Rainbow speed", "PlayerESP_NameRainbowSpeed", .1, 3, .05, o);
	z(N, 1392, "Name size", "PlayerESP_NameSize", 8, 32, 1, o);
	z(N, 1436, "Max distance (studs)", "PlayerESP_MaxDist", 0, 1000, 10, o, tO);
	z(N, 1480, "Box thickness", "PlayerESP_BoxThickness", 1, 6, .5, o);
	G(N, 1524, "Player accent color");
	C(N, 1546, "Player accent", Q, function(N)
		o.PlayerESP_ColorR = math.floor(N.R * 255 + .5);
		o.PlayerESP_ColorG = math.floor(N.G * 255 + .5);
		o.PlayerESP_ColorB = math.floor(N.B * 255 + .5);
		if o.PlayerESP then
			tO();
		end;
	end);
	C(N, 1578, "Player tracer", X, function(N)
		o.PlayerESP_TracerR = math.floor(N.R * 255 + .5);
		o.PlayerESP_TracerG = math.floor(N.G * 255 + .5);
		o.PlayerESP_TracerB = math.floor(N.B * 255 + .5);
	end);
	C(N, 1610, "Player box", c, function(N)
		o.PlayerESP_BoxR = math.floor(N.R * 255 + .5);
		o.PlayerESP_BoxG = math.floor(N.G * 255 + .5);
		o.PlayerESP_BoxB = math.floor(N.B * 255 + .5);
	end);
	G(N, 1652, "Player HP chip (4 states)");
	V(N, 1674, "Black outline (chip + number)", "PlayerESP_HP_Outline", nil, nil, o);
	C(N, 1706, "State 1 (>75%)", L, function(N)
		o.PlayerESP_HP_State1_R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_State1_G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_State1_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1738, "State 2 (50-75%)", U, function(N)
		o.PlayerESP_HP_State2_R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_State2_G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_State2_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1770, "State 3 (25-50%)", H, function(N)
		o.PlayerESP_HP_State3_R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_State3_G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_State3_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1802, "State 4 (<25%)", Ni, function(N)
		o.PlayerESP_HP_State4_R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_State4_G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_State4_B = math.floor(N.B * 255 + .5);
		tO();
	end);
	G(N, 1846, "Player HP gradient (vertical bar)");
	local function n()
		return Color3.fromRGB(o.PlayerESP_HP_TopR or 80, o.PlayerESP_HP_TopG or 255, o.PlayerESP_HP_TopB or 80);
	end;
	local function m()
		return Color3.fromRGB(o.PlayerESP_HP_M1R or 180, o.PlayerESP_HP_M1G or 255, o.PlayerESP_HP_M1B or 60);
	end;
	local function w()
		return Color3.fromRGB(o.PlayerESP_HP_M2R or 255, o.PlayerESP_HP_M2G or 200, o.PlayerESP_HP_M2B or 40);
	end;
	local function h()
		return Color3.fromRGB(o.PlayerESP_HP_M3R or 255, o.PlayerESP_HP_M3G or 120, o.PlayerESP_HP_M3B or 60);
	end;
	local function S()
		return Color3.fromRGB(o.PlayerESP_HP_BotR or 255, o.PlayerESP_HP_BotG or 40, o.PlayerESP_HP_BotB or 40);
	end;
	C(N, 1868, "Top", n, function(N)
		o.PlayerESP_HP_TopR = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_TopG = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_TopB = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1900, "Mid1", m, function(N)
		o.PlayerESP_HP_M1R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_M1G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_M1B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1932, "Mid2", w, function(N)
		o.PlayerESP_HP_M2R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_M2G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_M2B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1964, "Mid3", h, function(N)
		o.PlayerESP_HP_M3R = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_M3G = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_M3B = math.floor(N.B * 255 + .5);
		tO();
	end);
	C(N, 1996, "Bottom", S, function(N)
		o.PlayerESP_HP_BotR = math.floor(N.R * 255 + .5);
		o.PlayerESP_HP_BotG = math.floor(N.G * 255 + .5);
		o.PlayerESP_HP_BotB = math.floor(N.B * 255 + .5);
		tO();
	end);
	G(N, 2040, "HP bar size");
	z(N, 2062, "Guard bar thickness", "GuardESP_HPBarThickness", 2, 30, 1, o);
	z(N, 2106, "Guard bar length", "GuardESP_HPBarLength", .3, 3, .1, o);
	z(N, 2150, "Guard bar roundness", "GuardESP_HPBarRoundness", 0, 20, 1, o);
	z(N, 2194, "Player bar thickness", "PlayerESP_HPBarThickness", 2, 30, 1, o);
	z(N, 2238, "Player bar length", "PlayerESP_HPBarLength", .3, 3, .1, o);
	z(N, 2282, "Player bar roundness", "PlayerESP_HPBarRoundness", 0, 20, 1, o);
	G(N, 2326, "ESP text");
	local i;
	local function M()
		if i then
			i.Text = "Next font: " .. ((j[o.ESP_FontIdx or 1] or "?"));
		end;
	end;
	i = v(N, 2348, "Next font: " .. ((j[o.ESP_FontIdx or 1] or "?")), function()
			o.ESP_FontIdx = ((o.ESP_FontIdx or 1)) + 1;
			if o.ESP_FontIdx > #j then
				o.ESP_FontIdx = 1;
			end;
			M();
			for N, G in pairs(TO) do
				pcall(function()
					if G.nameL then
						G.nameL.Font = J();
					end;
					if G.toolL then
						G.toolL.Font = J();
					end;
				end);
			end;
			for N, G in pairs(QO) do
				pcall(function()
					if G.nameL then
						G.nameL.Font = J();
					end;
					if G.toolL then
						G.toolL.Font = J();
					end;
				end);
			end;
		end);
	v(N, 2380, "Reset font (GothamBlack)", function()
		o.ESP_FontIdx = 1;
		M();
		for N, G in pairs(TO) do
			pcall(function()
				if G.nameL then
					G.nameL.Font = Enum.Font.GothamBlack;
					G.nameL.TextSize = (o.GuardESP_NameSize or 17);
				end;
				if G.toolL then
					G.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		for N, G in pairs(QO) do
			pcall(function()
				if G.nameL then
					G.nameL.Font = Enum.Font.GothamBlack;
					G.nameL.TextSize = (o.PlayerESP_NameSize or 17);
				end;
				if G.toolL then
					G.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("font reset - GothamBlack");
		end;
	end);
end;
function x.ui.buildDalgona()
	local N = x.ui.tabFrames.Dalgona;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.BTN_W;
	local v = x.ui.COL;
	G(N, 0, "Cookie");
	V(N, 22, "One Click Complete", nil, function()
		return x.oneClickDalgona;
	end, function(N)
		WO(N);
	end);
	local R = Instance.new("TextLabel");
	R.Size = UDim2.fromOffset(z, 70);
	R.Position = UDim2.fromOffset(4, 56);
	R.BackgroundTransparency = 1;
	R.Font = Enum.Font.Gotham;
	R.TextSize = 9;
	R.TextWrapped = true;
	R.TextXAlignment = Enum.TextXAlignment.Left;
	R.TextYAlignment = Enum.TextYAlignment.Top;
	R.TextColor3 = E();
	R.Text = "Vklyuchi i vedi myshkoi po konturu pechenki.";
	R.ZIndex = 6;
	R.Parent = N;
	vi(function()
		R.TextColor3 = E();
	end);
end;
function x.ui.buildExtra()
	local N = x.ui.tabFrames.Extra;
	local G = x.ui.mkDivider;
	local V = x.ui.makeToggle;
	local z = x.ui.makeSlider;
	local v = x.ui.makeBtn;
	G(N, 0, "Instant Interact");
	V(N, 22, "Enable Instant Interact", "InstantInteract");
	V(N, 52, "Insta mode (0ms)", "InstantInteractInsta");
	z(N, 82, "Custom speed x", "InstantInteractMult", .5, 50, .5, o);
	G(N, 128, "Hide overhead");
	V(N, 150, "Hide nickname", "HideNick", nil, function()
		CG();
	end, o);
	G(N, 186, "Visual");
	V(N, 208, "Full Bright", "FullBright", nil, function(N)
		jO(N);
	end, o);
	V(N, 238, "Remove Fog", "RemoveFog", nil, function(N)
		JO(N);
	end, o);
	G(N, 274, "Overlay");
	V(N, 296, "Watermark", "Watermark", nil, function()
		Si();
	end, o);
	V(N, 326, "Keybind list", "KeybindList", nil, function()
		Si();
	end, o);
	G(N, 362, "Cosmetics");
	V(N, 384, "Headless", "Headless");
	V(N, 414, "Korblox Left Leg", "Korblox");
	V(N, 444, "Remove Legs", "RemoveLegs");
	V(N, 474, "Remove Hands", "RemoveHands");
	V(N, 504, "Remove Torso (client)", "RemoveTorso");
	G(N, 544, "Animation Speed");
	V(N, 566, "Speed 2.5x", "AnimSpeed");
	v(N, 598, "Reset anim speed", function()
		local N = F.Character;
		local G = N and N:FindFirstChildOfClass("Humanoid");
		local V = G and G:FindFirstChildOfClass("Animator");
		if V then
			for N, G in ipairs(V:GetPlayingAnimationTracks()) do
				pcall(function()
					G:AdjustSpeed(1);
				end);
			end;
		end;
	end);
	G(N, 636, "Extra");
	v(N, 658, "Open Infinite Yield", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local N, G = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(N and "Infinite Yield loaded" or ("IY fail: " .. tostring(G)));
		end;
	end);
	v(N, 690, "Jerk off", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local N, G = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jerk-off-script-OG-245780")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(N and "Jerk off loaded" or ("fail: " .. tostring(G)));
		end;
	end);
end;
function x.ui.buildConfigs()
	local N = x.ui.tabFrames.Configs;
	local G = x.ui.mkDivider;
	local z = x.ui.makeToggle;
	local v = x.ui.makeSlider;
	local C = x.ui.makeBtn;
	local b = x.ui.makeInput;
	local y = x.ui.colorRow;
	local P = x.ui.COL;
	G(N, 0, "Config");
	local O;
	local q = b(N, 22, "config name");
	q.Text = x.currentConfigName;
	C(N, 54, "Save", function()
		local N = q.Text;
		if N == "" then
			N = "default";
		end;
		local G, V = nG(N);
		if G then
			q.Text = x.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved - " .. x.currentConfigName);
			end;
			task.defer(function()
				if O then
					O();
				end;
			end);
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("save fail - " .. tostring(V));
			end;
		end;
	end);
	C(N, 86, "Load", function()
		local N = q.Text;
		if N == "" then
			N = "default";
		end;
		local G, V = mG(N);
		if G then
			q.Text = x.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("loaded - " .. x.currentConfigName);
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("load fail - " .. tostring(V));
			end;
		end;
	end);
	G(N, 124, "Menu animation");
	v(N, 146, "Open/close speed", "MenuAnimSpeed", .1, 1.5, .05, o);
	v(N, 190, "Collapse anim speed", "MenuDodgeAnimSpeed", .1, 2, .05, o);
	G(N, 236, "Circle menu button");
	v(N, 258, "Circle size", "CircleSize", 32, 120, 2, o);
	y(N, 300, "Circle text color", p, function(N)
		o.CircleTextR = math.floor(N.R * 255 + .5);
		o.CircleTextG = math.floor(N.G * 255 + .5);
		o.CircleTextB = math.floor(N.B * 255 + .5);
		Ri();
	end);
	z(N, 334, "Rainbow text color", "CircleRainbowText", nil, function()
		Ri();
	end, o);
	z(N, 364, "Rainbow outline", "CircleRainbowOutline", nil, function()
		Ri();
	end, o);
	G(N, 400, "Text color (all GUI)");
	y(N, 422, "Text color", E, function(N)
		o.GuiTextR = math.floor(N.R * 255 + .5);
		o.GuiTextG = math.floor(N.G * 255 + .5);
		o.GuiTextB = math.floor(N.B * 255 + .5);
		Ri();
	end);
	G(N, 462, "Panel border");
	z(N, 484, "Rainbow panel border", "PanelRainbow", nil, function(N)
		if N then
			OO();
		else
			PO();
			if x.panel then
				local N = x.panel:FindFirstChildOfClass("UIStroke");
				if N then
					N.Color = Y();
				end;
			end;
		end;
	end, o);
	G(N, 520, "Accent color");
	y(N, 542, "GUI accent", Y, function(N)
		o.GuiR = math.floor(N.R * 255 + .5);
		o.GuiG = math.floor(N.G * 255 + .5);
		o.GuiB = math.floor(N.B * 255 + .5);
		Ri();
	end);
	v(N, 584, "R", "GuiR", 0, 255, 1, o, Ri);
	v(N, 628, "G", "GuiG", 0, 255, 1, o, Ri);
	v(N, 672, "B", "GuiB", 0, 255, 1, o, Ri);
	G(N, 716, "Saved");
	local F = Instance.new("ScrollingFrame");
	F.Size = UDim2.new(1, -8, 0, 90);
	F.Position = UDim2.fromOffset(4, 736);
	F.BackgroundColor3 = P.card;
	F.BorderSizePixel = 0;
	F.ScrollBarThickness = 3;
	F.CanvasSize = UDim2.fromOffset(0, 0);
	F.ZIndex = 6;
	F.Parent = N;
	bi(F, 7);
	local n = Instance.new("TextLabel");
	n.Size = UDim2.new(1, -8, 0, 20);
	n.Position = UDim2.fromOffset(4, 6);
	n.BackgroundTransparency = 1;
	n.Font = Enum.Font.Gotham;
	n.TextSize = 11;
	n.TextColor3 = E();
	n.TextXAlignment = Enum.TextXAlignment.Left;
	n.Text = "no configs saved yet";
	n.ZIndex = 7;
	n.Parent = F;
	vi(function()
		n.TextColor3 = E();
	end);
	O = function()
			if x.unloaded or not F or not F.Parent then
				return;
			end;
			for N, G in ipairs(F:GetChildren()) do
				if G:IsA("TextButton") then
					G:Destroy();
				end;
			end;
			local N = xG();
			F.CanvasSize = UDim2.fromOffset(0, math.max(#N * 26 + 8, 26));
			n.Visible = (#N == 0);
			for N, G in ipairs(N) do
				local V = Instance.new("TextButton");
				V.Size = UDim2.new(1, -8, 0, 22);
				V.Position = UDim2.fromOffset(4, ((N - 1)) * 26 + 4);
				V.BackgroundColor3 = P.off;
				V.BorderSizePixel = 0;
				V.Font = Enum.Font.Gotham;
				V.TextSize = 12;
				V.TextColor3 = E();
				V.Text = "  " .. G;
				V.TextXAlignment = Enum.TextXAlignment.Left;
				V.ZIndex = 7;
				V.Parent = F;
				bi(V, 5);
				vi(function()
					V.TextColor3 = E();
				end);
				V.MouseButton1Click:Connect(function()
					Ci();
					q.Text = G;
					local N = mG(G);
					if _G.__ad_statusCb then
						_G.__ad_statusCb(N and ("loaded - " .. G) or "load failed");
					end;
				end);
				local z = Instance.new("TextButton");
				z.Size = UDim2.fromOffset(20, 18);
				z.Position = UDim2.new(1, -24, .5, -9);
				z.BackgroundColor3 = Color3.fromRGB(120, 30, 30);
				z.BorderSizePixel = 0;
				z.Font = Enum.Font.GothamBold;
				z.TextSize = 11;
				z.TextColor3 = Color3.new(1, 1, 1);
				z.Text = "x";
				z.ZIndex = 8;
				z.Parent = V;
				bi(z, 4);
				z.MouseButton1Click:Connect(function()
					if x.unloaded then
						return;
					end;
					Ci();
					local N, V = wG(G);
					if N then
						if _G.__ad_statusCb then
							_G.__ad_statusCb("deleted - " .. G);
						end;
						task.defer(function()
							if O then
								O();
							end;
						end);
					else
						if _G.__ad_statusCb then
							_G.__ad_statusCb("del fail - " .. tostring(V));
						end;
					end;
				end);
			end;
		end;
	O();
	_G.__adRefreshConfigs = O;
	C(N, 834, "Refresh List", function()
		O();
	end);
	C(N, 868, "Set Menu Key", function()
		x.bindingMenuKey = true;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("press a key...");
		end;
		local N;
		N = V.InputBegan:Connect(function(G)
				if G.UserInputType ~= Enum.UserInputType.Keyboard then
					return;
				end;
				o.MenuKey = G.KeyCode;
				if _G.__ad_statusCb then
					_G.__ad_statusCb("menu key = " .. G.KeyCode.Name);
				end;
				task.defer(function()
					x.bindingMenuKey = false;
				end);
				if N then
					N:Disconnect();
				end;
				if x.rebindMenu then
					x.rebindMenu();
				end;
			end);
	end);
	C(N, 902, "FULL UNLOAD", function()
		if x.doFullUnload then
			pcall(x.doFullUnload);
		end;
	end);
	G(N, 940, "Share config (JSON / TXT)");
	local m = b(N, 962, "paste JSON here to import");
	m.Text = "";
	C(N, 994, "Export (copy JSON to clipboard)", function()
		local N = { C = OG(o), H = OG(i), anim = x.animEnabled };
		local G = R:JSONEncode(N);
		local V = false;
		if setclipboard then
			pcall(function()
				setclipboard(G);
				V = true;
			end);
		end;
		if V then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("copied (" .. (#G .. " chars) - send to friend"));
			end;
		else
			m.Text = G;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no setclipboard - JSON in box, copy manually");
			end;
		end;
	end);
	C(N, 1026, "Export to file (XD_config.txt)", function()
		if not x.FILE.writefile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no writefile in executor");
			end;
			return;
		end;
		local N = { C = OG(o), H = OG(i), anim = x.animEnabled };
		local G = R:JSONEncode(N);
		local V = pcall(function()
				x.FILE.writefile("XD_config.txt", G);
			end);
		if V then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved XD_config.txt (" .. (#G .. ")"));
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("writefile failed");
			end;
		end;
	end);
	C(N, 1058, "Load from file (XD_config.txt)", function()
		if not x.FILE.readfile or not x.FILE.isfile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no readfile");
			end;
			return;
		end;
		local N, G = pcall(x.FILE.isfile, "XD_config.txt");
		if not N or not G then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("XD_config.txt not found");
			end;
			return;
		end;
		local V, z = pcall(x.FILE.readfile, "XD_config.txt");
		if not V or not z then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("read failed");
			end;
			return;
		end;
		local v, C = pcall(function()
				return R:JSONDecode(z);
			end);
		if not v or type(C) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in file");
			end;
			return;
		end;
		FG(C);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("loaded from XD_config.txt");
		end;
	end);
	C(N, 1090, "Import from clipboard", function()
		local N = "";
		if getclipboard then
			pcall(function()
				N = getclipboard();
			end);
		end;
		if not N or N == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("clipboard empty or no getclipboard");
			end;
			return;
		end;
		local G, V = pcall(function()
				return R:JSONDecode(N);
			end);
		if not G or type(V) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in clipboard");
			end;
			return;
		end;
		FG(V);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from clipboard");
		end;
	end);
	C(N, 1122, "Import from box above", function()
		local N = m.Text or "";
		if N == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("box empty");
			end;
			return;
		end;
		local G, V = pcall(function()
				return R:JSONDecode(N);
			end);
		if not G or type(V) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json");
			end;
			return;
		end;
		FG(V);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from box");
		end;
	end);
	G(N, 1158, "Circle rainbow glow");
	v(N, 1180, "Glow speed", "CircleRainbowSpeed", .1, 5, .1, o);
end;
function x.ui.buildCollapseCircle()
	local N = x.ui.PANEL_W;
	local G = x.ui.PANEL_H;
	local z = Instance.new("TextButton");
	z.AnchorPoint = Vector2.new(1, 0);
	z.Position = UDim2.new(1, -16, 0, 90);
	z.Size = UDim2.fromOffset(0, 0);
	z.BackgroundColor3 = Y();
	z.BorderSizePixel = 0;
	z.Text = "";
	z.AutoButtonColor = false;
	z.Visible = false;
	z.ZIndex = 50;
	z.Parent = x.gui;
	bi(z, 32);
	local R = Pi(z, Color3.fromRGB(0, 0, 0), 3, 0);
	vi(function()
		z.BackgroundColor3 = Y();
	end);
	x.ui.expandCircle = z;
	local b = false;
	local y = false;
	local P = nil;
	local O = nil;
	z.InputBegan:Connect(function(N)
		if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
			b = true;
			y = false;
			P = N.Position;
			O = z.Position;
			N.Changed:Connect(function()
				if N.UserInputState == Enum.UserInputState.End then
					b = false;
				end;
			end);
		end;
	end);
	r(V.InputChanged:Connect(function(N)
		if not b then
			return;
		end;
		if N.UserInputType == Enum.UserInputType.MouseMovement or N.UserInputType == Enum.UserInputType.Touch then
			local G = N.Position - P;
			if math.abs(G.X) > 3 or math.abs(G.Y) > 3 then
				y = true;
			end;
			z.Position = UDim2.new(O.X.Scale, O.X.Offset + G.X, O.Y.Scale, O.Y.Offset + G.Y);
		end;
	end));
	local q = Instance.new("TextLabel");
	q.AnchorPoint = Vector2.new(.5, .5);
	q.Size = UDim2.fromScale(.55, .55);
	q.Position = UDim2.fromScale(.34, .52);
	q.BackgroundTransparency = 1;
	q.Font = Enum.Font.GothamBlack;
	q.TextSize = 26;
	q.TextColor3 = p();
	q.TextStrokeTransparency = 0;
	q.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	q.Text = "X";
	q.Rotation = -8;
	q.ZIndex = 52;
	q.Parent = z;
	local F = Instance.new("TextLabel");
	F.AnchorPoint = Vector2.new(.5, .5);
	F.Size = UDim2.fromScale(.5, .55);
	F.Position = UDim2.fromScale(.68, .52);
	F.BackgroundTransparency = 1;
	F.Font = Enum.Font.GothamBlack;
	F.TextSize = 24;
	F.TextColor3 = p();
	F.TextStrokeTransparency = 0;
	F.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	F.Text = "D";
	F.Rotation = 6;
	F.ZIndex = 52;
	F.Parent = z;
	vi(function()
		R.Color = Color3.fromRGB(0, 0, 0);
		if not o.CircleRainbowOutline then
			q.TextStrokeColor3 = p();
			F.TextStrokeColor3 = p();
		end;
		if not o.CircleRainbowText then
			q.TextColor3 = p();
			F.TextColor3 = p();
		end;
	end);
	task.spawn(function()
		local N = 0;
		while x.running and not x.unloaded do
			if o.CircleRainbowOutline then
				local G = Color3.fromHSV(N, 1, 1);
				pcall(function()
					q.TextStrokeColor3 = G;
					F.TextStrokeColor3 = G;
				end);
			end;
			if o.CircleRainbowText then
				local G = Color3.fromHSV(((N + .5)) % 1, 1, 1);
				pcall(function()
					q.TextColor3 = G;
					F.TextColor3 = G;
				end);
			end;
			N = ((N + .008 * ((o.CircleRainbowSpeed or 1)))) % 1;
			v.RenderStepped:Wait();
		end;
	end);
	local n = false;
	local function m(V)
		if x.unloaded or not x.panel or not x.panel.Parent then
			return;
		end;
		V = V and true or false;
		if V == n then
			return;
		end;
		n = V;
		local v = tonumber(o.MenuAnimSpeed) or .35;
		local R = tonumber(o.MenuDodgeAnimSpeed) or .5;
		if V then
			local N = TweenInfo.new(v, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			(C:Create(x.panel, N, { Position = UDim2.new(x.panel.Position.X.Scale, x.panel.Position.X.Offset - 800, x.panel.Position.Y.Scale, x.panel.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(C:Create(x.shadow, N, { Position = UDim2.new(x.shadow.Position.X.Scale, x.shadow.Position.X.Offset - 800, x.shadow.Position.Y.Scale, x.shadow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(C:Create(x.glow, N, { Position = UDim2.new(x.glow.Position.X.Scale, x.glow.Position.X.Offset - 800, x.glow.Position.Y.Scale, x.glow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			task.delay(v + .02, function()
				if x.unloaded or not n then
					return;
				end;
				x.panel.Visible = false;
				x.shadow.Visible = false;
				x.glow.Visible = false;
				x.panel.BackgroundTransparency = 0;
				x.shadow.BackgroundTransparency = .65;
				x.glow.BackgroundTransparency = .86;
				z.Visible = true;
				z.Size = UDim2.fromOffset(0, 0);
				local N = tonumber(o.CircleSize) or 64;
				(C:Create(z, TweenInfo.new(R, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(N, N) })):Play();
			end);
		else
			z.Visible = false;
			z.Size = UDim2.fromOffset(0, 0);
			x.panel.Visible = true;
			x.shadow.Visible = true;
			x.glow.Visible = true;
			local V = -N / 2 - 800;
			local R = -G / 2;
			x.panel.Position = UDim2.new(.5, V, .5, R);
			x.shadow.Position = UDim2.new(.5, V + 6, .5, R + 6);
			x.glow.Position = UDim2.new(.5, V - 20, .5, R - 20);
			x.panel.BackgroundTransparency = 1;
			x.shadow.BackgroundTransparency = 1;
			x.glow.BackgroundTransparency = 1;
			local b = TweenInfo.new(v, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			(C:Create(x.panel, b, { Position = UDim2.new(.5, -N / 2, .5, -G / 2), BackgroundTransparency = 0 })):Play();
			(C:Create(x.shadow, b, { Position = UDim2.new(.5, -N / 2 + 6, .5, -G / 2 + 6), BackgroundTransparency = .65 })):Play();
			(C:Create(x.glow, b, { Position = UDim2.new(.5, -N / 2 - 20, .5, -G / 2 - 20), BackgroundTransparency = .86 })):Play();
		end;
	end;
	_G.__adSetCollapsed = m;
	_G.__adIsCollapsed = function()
			return n;
		end;
	if x.ui.collapseBtn then
		x.ui.collapseBtn.MouseButton1Click:Connect(function()
			if x.unloaded then
				return;
			end;
			Ci();
			m(true);
		end);
	end;
	z.MouseButton1Click:Connect(function()
		if x.unloaded then
			return;
		end;
		if y then
			y = false;
			return;
		end;
		Ci();
		m(false);
	end);
end;
local function hG(N, G)
	local V, z = pcall(G);
	if not V then
		print("[XD] BUILD ERROR in " .. (tostring(N) .. ":"), tostring(z));
		warn("[XD] BUILD ERROR in " .. (tostring(N) .. ":"), tostring(z));
	end;
end;
hG("buildPanel", x.ui.buildPanel);
hG("buildMain", x.ui.buildMain);
hG("buildHnS", x.ui.buildHnS);
hG("buildRebel", x.ui.buildRebel);
hG("buildRLGL", x.ui.buildRLGL);
hG("buildESP", x.ui.buildESP);
hG("buildDalgona", x.ui.buildDalgona);
hG("buildExtra", x.ui.buildExtra);
hG("buildConfigs", x.ui.buildConfigs);
hG("buildCollapseCircle", x.ui.buildCollapseCircle);
pcall(hi);
pcall(Si);
pcall(CG);
if o.PanelRainbow then
	OO();
end;
if o.FullBright then
	jO(true);
end;
if o.RemoveFog then
	JO(true);
end;
do
	if q then
		local N = nil;
		local function G()
			if N then
				N.cancelled = true;
				N = nil;
			end;
		end;
		pcall(function()
			q.PromptButtonHoldBegan:Connect(function(V, z)
				if x.unloaded or z ~= F or not o.InstantInteract then
					return;
				end;
				G();
				if o.InstantInteractInsta then
					pcall(fireproximityprompt, V);
					return;
				end;
				local v = { cancelled = false };
				N = v;
				task.spawn(function()
					local N = tonumber(o.InstantInteractMult) or 2;
					if N < .5 then
						N = .5;
					end;
					local G = 1 / N;
					while not v.cancelled and (not x.unloaded and o.InstantInteract) do
						pcall(fireproximityprompt, V);
						task.wait(G);
					end;
				end);
			end);
		end);
		pcall(function()
			q.PromptButtonHoldEnded:Connect(function(N, V)
				if V ~= F then
					return;
				end;
				G();
			end);
		end);
	end;
end;
x.toggleMenu = function()
		if x.unloaded then
			return;
		end;
		if x.bindingMenuKey then
			return;
		end;
		if not x.panel or not x.panel.Parent then
			return;
		end;
		local N = tick();
		if N - x.lastMenuToggle < .15 then
			return;
		end;
		x.lastMenuToggle = N;
		Ci();
		if _G.__adSetCollapsed and _G.__adIsCollapsed then
			local N = _G.__adIsCollapsed();
			_G.__adSetCollapsed(not N);
		else
			x.panel.Visible = not x.panel.Visible;
			if x.shadow then
				x.shadow.Visible = x.panel.Visible;
			end;
			if x.glow then
				x.glow.Visible = x.panel.Visible;
			end;
		end;
	end;
x.rebindMenu = function()
		if x.menuAction then
			pcall(function()
				z:UnbindAction(x.menuAction);
			end);
		end;
		x.menuAction = "XDMenu_" .. Gi(6);
		pcall(function()
			z:BindAction(x.menuAction, function(N, G)
				if G ~= Enum.UserInputState.Begin then
					return;
				end;
				x.toggleMenu();
			end, false, o.MenuKey);
		end);
	end;
x.rebindMenu();
r(V.InputBegan:Connect(function(N)
	if x.unloaded or x.bindingMenuKey then
		return;
	end;
	if N.UserInputType ~= Enum.UserInputType.Keyboard then
		return;
	end;
	if N.KeyCode ~= o.MenuKey then
		return;
	end;
	x.toggleMenu();
end));
x.doFullUnload = function()
		if x.unloaded then
			return;
		end;
		if x.panel and (x.panel.Parent and x.panel.Visible) then
			local N = x.panel.Position.X.Scale;
			local G = x.panel.Position.Y.Scale;
			local V = x.panel.Position.X.Offset;
			local z = x.panel.Position.Y.Offset;
			local v = TweenInfo.new(.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			pcall(function()
				(C:Create(x.panel, v, { Position = UDim2.new(N, V - 800, G, z), BackgroundTransparency = 1 })):Play();
				(C:Create(x.shadow, v, { Position = UDim2.new(N, (V - 800) + 6, G, z + 6), BackgroundTransparency = 1 })):Play();
				(C:Create(x.glow, v, { Position = UDim2.new(N, (V - 800) - 20, G, z - 20), BackgroundTransparency = 1 })):Play();
			end);
			task.wait(.42);
		end;
		_G.__adUnloaded = true;
		x.running = false;
		pcall(zO);
		pcall(vO);
		pcall(RO);
		pcall(PO);
		pcall(EO);
		if x.btAnimConn then
			pcall(function()
				x.btAnimConn:Disconnect();
			end);
			x.btAnimConn = nil;
		end;
		if x._nickLoop then
			pcall(function()
				task.cancel(x._nickLoop);
			end);
			x._nickLoop = nil;
		end;
		pcall(function()
			jO(false);
		end);
		pcall(function()
			JO(false);
		end);
		if x.notifHolder then
			pcall(function()
				x.notifHolder:Destroy();
			end);
			x.notifHolder = nil;
		end;
		x.unloaded = true;
		pcall(function()
			o.Enabled = false;
			i.Enabled = false;
			o.RadiusVis = false;
			i.RadiusVis = false;
			o.AnimSpeed = false;
			o.GuardESP = false;
			o.PlayerESP = false;
			o.RemoveHands = false;
			o.RemoveLegs = false;
			o.RemoveTorso = false;
			o.Headless = false;
			o.Korblox = false;
			o.HideNick = false;
			o.FullBright = false;
			o.RemoveFog = false;
			o.AutoBrew = false;
			o.BulletTracer = false;
			x.oneClickDalgona = false;
			o.RLGL_AutoDodge = false;
			o.RLGL_TimerEndDodge = false;
			o.RebelSilentAim = false;
			o.RebelNoRecoil = false;
			o.RebelRapidFire = false;
			o.RebelFOVCircle = false;
		end);
		pcall(function()
			for N, G in pairs(_G.__dalgonaCache) do
				if N and N.Parent then
					pcall(function()
						N.Position = G.Position;
						N.Transparency = G.Transparency;
					end);
				end;
			end;
			table.clear(_G.__dalgonaCache);
		end);
		pcall(function()
			for N, G in pairs(x.origTransparency) do
				if N and N.Parent then
					pcall(function()
						N.LocalTransparencyModifier = 0;
						N.Transparency = G;
					end);
				end;
			end;
			table.clear(x.origTransparency);
			local function N(N)
				for G = 1, #N, 1 do
					local V = N[G];
					if V and V.Parent then
						pcall(function()
							V.LocalTransparencyModifier = 0;
						end);
					end;
				end;
			end;
			N(x.handCache);
			N(x.legCache);
			N(x.torsoCache);
			table.clear(x.handCache);
			table.clear(x.legCache);
			table.clear(x.torsoCache);
		end);
		pcall(function()
			vG(false);
		end);
		pcall(function()
			GG(false);
		end);
		pcall(ui);
		pcall(DO);
		pcall(XO);
		pcall(RG);
		pcall(oO);
		for N = 1, #x.conns, 1 do
			pcall(function()
				if x.conns[N] and x.conns[N].Disconnect then
					x.conns[N]:Disconnect();
				end;
			end);
		end;
		table.clear(x.conns);
		for N, G in pairs(x.added) do
			pcall(function()
				if G and G.Disconnect then
					G:Disconnect();
				end;
			end);
		end;
		table.clear(x.added);
		if x.handsConn then
			pcall(function()
				x.handsConn:Disconnect();
			end);
			x.handsConn = nil;
		end;
		if x.dalgonaConn then
			pcall(function()
				x.dalgonaConn:Disconnect();
			end);
			x.dalgonaConn = nil;
		end;
		if x.tracerGui then
			pcall(function()
				x.tracerGui:Destroy();
			end);
			x.tracerGui = nil;
		end;
		if x.overlayGui then
			pcall(function()
				x.overlayGui:Destroy();
			end);
			x.overlayGui = nil;
		end;
		if x.infoGui then
			pcall(function()
				x.infoGui:Destroy();
			end);
			x.infoGui = nil;
		end;
		if x.menuAction then
			pcall(function()
				z:UnbindAction(x.menuAction);
			end);
			x.menuAction = nil;
		end;
		if x.clickSound then
			pcall(function()
				x.clickSound:Destroy();
			end);
			x.clickSound = nil;
		end;
		pcall(function()
			if x.gui then
				x.gui.Enabled = false;
				for N, G in ipairs(x.gui:GetDescendants()) do
					pcall(function()
						if G and G.Destroy then
							G:Destroy();
						end;
					end);
				end;
				x.gui:Destroy();
			end;
		end);
		x.gui = nil;
		x.shadow = nil;
		x.glow = nil;
		x.panel = nil;
		if getgenv then
			pcall(function()
				if (getgenv()).__ui_dodge then
					(getgenv()).__ui_dodge = nil;
				end;
			end);
		end;
		_G.__XD_UNLOAD = nil;
		_G.__ad_statusCb = nil;
		_G.__adShowNotif = nil;
		_G.__adSetCollapsed = nil;
		_G.__adIsCollapsed = nil;
	end;
_G.__XD_UNLOAD = x.doFullUnload;
task.spawn(function()
	while x.running and not x.unloaded do
		pcall(function()
			if o.AnimSpeed then
				local N = F.Character;
				local G = N and N:FindFirstChildOfClass("Humanoid");
				local V = G and G:FindFirstChildOfClass("Animator");
				if V then
					local N = o.AnimSpeedValue or 2.5;
					for G, V in ipairs(V:GetPlayingAnimationTracks()) do
						pcall(function()
							if V.Speed ~= N then
								V:AdjustSpeed(N);
							end;
						end);
					end;
				end;
			end;
			if o.RemoveHands or o.RemoveLegs or o.RemoveTorso then
				gO();
			end;
			if o.Headless then
				GG(true);
			end;
			if o.Korblox then
				vG(true);
			end;
			if o.Enabled or i.Enabled then
				x.cachedUITool = Di();
				x.cachedDodgeTool = Xi();
				x.cachedSlot = Ti(x.cachedUITool, "T", o.ManualUISlot);
				x.cachedDodgeSlot = Ti(x.cachedDodgeTool, "1", o.ManualHnSSlot);
			end;
			if ((o.RebelSilentAim or o.RebelNoRecoil or o.RebelRapidFire)) and not x.combatHooked then
				VO();
			end;
		end);
		task.wait(.1);
	end;
end);
task.spawn(function()
	while x.running and not x.unloaded do
		if o.GuardESP or o.PlayerESP then
			pcall(tO);
		end;
		task.wait(.5);
	end;
end);
task.spawn(function()
	while x.running and not x.unloaded do
		pcall(function()
			local N = {};
			if o.Enabled then
				table.insert(N, "ui " .. x.cachedSlot);
			end;
			if i.Enabled then
				table.insert(N, "hns " .. x.cachedDodgeSlot);
			end;
			if o.RebelSilentAim then
				table.insert(N, "aim");
			end;
			if o.RebelNoRecoil then
				table.insert(N, "norec");
			end;
			if o.RebelRapidFire then
				table.insert(N, "rapid");
			end;
			if o.BulletTracer then
				table.insert(N, "btracer");
			end;
			if o.RLGL_AutoDodge then
				table.insert(N, "rlgl");
			end;
			if o.RLGL_TimerEndDodge then
				table.insert(N, "timer-end");
			end;
			if o.HideNick then
				table.insert(N, "hide-nick");
			end;
			if o.AutoBrew then
				table.insert(N, "auto-brew");
			end;
			if x.oneClickDalgona then
				table.insert(N, "dalgona ON");
			end;
			if o.GuardESP or o.PlayerESP then
				table.insert(N, string.format("esp %d/%d", _G.__adEspDone or 0, _G.__adEspTotal or 0));
			end;
			if o.AnimSpeed then
				table.insert(N, "anim");
			end;
			if _G.__ad_statusCb then
				if #N == 0 then
					_G.__ad_statusCb("paused - N");
				else
					_G.__ad_statusCb(table.concat(N, " - "));
				end;
			end;
		end);
		task.wait(1);
	end;
end);
task.spawn(function()
	_G.__rlglLastSec = nil;
	_G.__rlglTimerEndedAt = 0;
	_G.__rlglLastFire = 0;
	while x.running and not x.unloaded do
		pcall(function()
			local N = _G.__rlgl_isOnMap();
			if not N then
				_G.__rlglLastSec = nil;
				_G.__rlglTimerEndedAt = 0;
				_G.__rlglWasRed = false;
				task.wait(.5);
				return;
			end;
			if o.RLGL_AutoDodge then
				local N = _G.__rlgl_isRed();
				local G = _G.__rlgl_isMoving(o.RLGL_VelThreshold or .3);
				local V = _G.__rlgl_inSafeZone();
				if N and not _G.__rlglWasRed then
					_G.__rlglRedStartAt = tick();
				end;
				_G.__rlglWasRed = N;
				local z = N and (tick() - _G.__rlglRedStartAt) or 0;
				local v = o.RLGL_RedDelay or .1;
				local R = true;
				if V then
					R = false;
				end;
				if o.RLGL_OnlyRedLight and R then
					if not N then
						R = false;
					end;
					if z < v then
						R = false;
					end;
				end;
				if R and not G then
					R = false;
				end;
				local C = tick();
				if R and (C - _G.__rlglLast) >= ((o.RLGL_MinInterval or .15)) then
					_G.__rlglLast = C;
					task.spawn(_G.__rlgl_fireDodge);
				end;
			end;
			if o.RLGL_TimerEndDodge then
				local N = _G.__rlgl_timerSeconds();
				local G = _G.__rlgl_inSafeZone();
				local V = _G.__rlgl_inFinishZone();
				if N ~= nil then
					_G.__rlglLastSec = N;
				end;
				if N ~= nil and N > 10 then
					_G.__rlglTimerEndedAt = 0;
				end;
				local z = false;
				if N ~= nil and N <= 0 then
					z = true;
				end;
				if N == nil and (_G.__rlglLastSec and _G.__rlglLastSec <= 3) then
					z = true;
				end;
				if z and _G.__rlglTimerEndedAt == 0 then
					_G.__rlglTimerEndedAt = tick();
					_G.__rlglLastFire = 0;
				end;
				if _G.__rlglTimerEndedAt > 0 and (not G and not V) then
					local N = o.RLGL_TimerEndDelay or 0;
					local G = o.RLGL_TimerEndInterval or .15;
					local V = o.RLGL_TimerEndMaxDuration or 12;
					local z = tick() - _G.__rlglTimerEndedAt;
					if z > V then
						_G.__rlglTimerEndedAt = 0;
					elseif z >= N then
						local N = tick();
						if _G.__rlglLastFire == 0 or (N - _G.__rlglLastFire >= G) then
							_G.__rlglLastFire = N;
							task.spawn(_G.__rlgl_fireDodge);
						end;
					end;
				end;
			end;
		end);
		task.wait(.05);
	end;
end);
r(F.CharacterAdded:Connect(function(N)
	task.wait(.5);
	if x.unloaded then
		return;
	end;
	gO();
	if o.RemoveHands then
		LO(true);
	end;
	if o.RemoveLegs then
		UO(true);
	end;
	if o.RemoveTorso then
		HO(true);
	end;
	if o.Headless then
		GG(true);
	end;
	if o.Korblox then
		vG(true);
	end;
end));
if F.Character then
	r(F.Character.DescendantAdded:Connect(function()
		if x.unloaded then
			return;
		end;
		if o.RemoveHands or o.RemoveLegs or o.RemoveTorso or o.Headless or o.Korblox then
			task.defer(function()
				gO();
				if o.RemoveHands then
					LO(true);
				end;
				if o.RemoveLegs then
					UO(true);
				end;
				if o.RemoveTorso then
					HO(true);
				end;
				if o.Headless then
					GG(true);
				end;
				if o.Korblox then
					vG(true);
				end;
			end);
		end;
	end));
end;
NG();
do
	local function G(N)
		if not N or N == F then
			return;
		end;
		r((N:GetPropertyChangedSignal("Team")):Connect(function()
			if not x.unloaded and ((o.GuardESP or o.PlayerESP)) then
				task.defer(tO);
			end;
		end));
	end;
	for N, V in ipairs(N:GetPlayers()) do
		G(V);
	end;
	r(N.PlayerAdded:Connect(G));
end;
pcall(function()
	if x.FILE.isfile and x.FILE.isfile(PG("default")) then
		mG("default");
	end;
end);
if getgenv then
	(getgenv()).__ui_dodge = { shutdown = x.doFullUnload, config = o, H = i };
end;
if _G.__adStatusCb then
	_G.__adStatusCb("ready - N");
end;
print("[XD] LOADED", n, m);

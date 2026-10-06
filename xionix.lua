local q = game:GetService("Players");
local s = game:GetService("Workspace");
local Y = game:GetService("UserInputService");
local O = game:GetService("ContextActionService");
local a = game:GetService("RunService");
local T = game:GetService("HttpService");
local S = game:GetService("TweenService");
local M = game:GetService("SoundService");
local G = game:GetService("Stats");
local f = game:GetService("Lighting");
local W = game:GetService("ReplicatedStorage");
local F = nil;
pcall(function()
	F = game:GetService("ProximityPromptService");
end);
local D = q.LocalPlayer;
while not D do
	task.wait(.1);
	D = q.LocalPlayer;
end;
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
local h = "x1oni1x dew4mp 1NK (X/D)";
local K = "v5.4";
local o = {};
o.FILE = ((function()
		local q = (getgenv and getgenv()) or _G;
		local function s(s)
			local Y = _G[s] or rawget(_G, s);
			if Y then
				return Y;
			end;
			if q and q[s] then
				return q[s];
			end;
			return nil;
		end;
		return {
			writefile = s("writefile"),
			readfile = s("readfile"),
			isfile = s("isfile"),
			isfolder = s("isfolder"),
			makefolder = s("makefolder"),
			listfiles = s("listfiles"),
			delfile = s("delfile"),
		};
	end))();
o.running = true;
o.unloaded = false;
o.conns = {};
o.hooks = {};
o.added = {};
o.oneClickDalgona = false;
o.dalgonaConn = nil;
o.cachedSlot = "T";
o.cachedDodgeSlot = "1";
o.cachedUITool = nil;
o.cachedDodgeTool = nil;
o.lastDodgeUI = 0;
o.lastDodgeH = 0;
o.lastMenuToggle = 0;
o.gui = nil;
o.shadow = nil;
o.glow = nil;
o.panel = nil;
o.tracerGui = nil;
o.overlayGui = nil;
o.infoGui = nil;
o.wmFrame = nil;
o.wmLabel = nil;
o.kbFrame = nil;
o.kbLabel = nil;
o.menuAction = nil;
o.clickSound = nil;
o.combatHooked = false;
o.origFiredGun = nil;
o.origGetBuffs = nil;
o.gunMod = nil;
o.fovGui = nil;
o.fovFrame = nil;
o.fovStroke = nil;
o.colorPickerOpen = nil;
o.fovRainbowConn = nil;
o.panelRainbowConn = nil;
o.notifHolder = nil;
o.fbInst = nil;
o.fogBackup = nil;
o.bindingMenuKey = false;
o.currentConfigName = "default";
o.animEnabled = {};
o.hideConns = {};
o.handCache = {};
o.legCache = {};
o.torsoCache = {};
o.origTransparency = {};
o.handsConn = nil;
o.korbloxData = {};
o.lastBrewTick = 0;
o.brewLoopConn = nil;
o.activeNotifs = {};
o.btAnimConn = nil;
o.btLastIdTime = {};
o.btLastShot = 0;
o._nickLoop = nil;
o.menuOpen = true;
o.menuTweens = {};
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
	local q = {};
	if gethui then
		pcall(function()
			table.insert(q, gethui());
		end);
	end;
	pcall(function()
		table.insert(q, game:GetService("CoreGui"));
	end);
	if D then
		pcall(function()
			table.insert(q, D:FindFirstChildOfClass("PlayerGui"));
		end);
	end;
	for q, s in ipairs(q) do
		if s and typeof(s) == "Instance" then
			for q, s in ipairs(s:GetChildren()) do
				if s:IsA("ScreenGui") and (tostring(s.Name)):find("^XD_") then
					pcall(function()
						s:Destroy();
					end);
				end;
			end;
		end;
	end;
end;
local C = {
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
local b = {};
for q, s in pairs(C) do
	b[q] = s;
	local Y = q:match("%d+");
	if Y then
		b[Y] = s;
	end;
end;
local function d(q, s, Y, O, a, T, S, M, G, f, W, F, D, h, K, o)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(q, s, Y)),
		ColorSequenceKeypoint.new(.25, Color3.fromRGB(O, a, T)),
		ColorSequenceKeypoint.new(.5, Color3.fromRGB(S, M, G)),
		ColorSequenceKeypoint.new(.75, Color3.fromRGB(f, W, F)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(D, h, K)),
	});
end;
local c = {
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
local v = {
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
local H = {
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
local function B()
	local q = math.clamp(c.ESP_FontIdx or 1, 1, #H);
	local s = Enum.Font[H[q]];
	if not s then
		s = Enum.Font.GothamBlack;
	end;
	return s;
end;
local function A(q)
	local s, Y, O;
	if q > .75 then
		s, Y, O = c.GuardESP_HP_State1_R or 74, c.GuardESP_HP_State1_G or 222, c.GuardESP_HP_State1_B or 74;
	elseif q > .5 then
		s, Y, O = c.GuardESP_HP_State2_R or 255, c.GuardESP_HP_State2_G or 210, c.GuardESP_HP_State2_B or 60;
	elseif q > .25 then
		s, Y, O = c.GuardESP_HP_State3_R or 255, c.GuardESP_HP_State3_G or 130, c.GuardESP_HP_State3_B or 40;
	else
		s, Y, O = c.GuardESP_HP_State4_R or 255, c.GuardESP_HP_State4_G or 55, c.GuardESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(s, Y, O);
end;
local function j(q)
	local s, Y, O;
	if q > .75 then
		s, Y, O = c.PlayerESP_HP_State1_R or 74, c.PlayerESP_HP_State1_G or 222, c.PlayerESP_HP_State1_B or 74;
	elseif q > .5 then
		s, Y, O = c.PlayerESP_HP_State2_R or 255, c.PlayerESP_HP_State2_G or 210, c.PlayerESP_HP_State2_B or 60;
	elseif q > .25 then
		s, Y, O = c.PlayerESP_HP_State3_R or 255, c.PlayerESP_HP_State3_G or 130, c.PlayerESP_HP_State3_B or 40;
	else
		s, Y, O = c.PlayerESP_HP_State4_R or 255, c.PlayerESP_HP_State4_G or 55, c.PlayerESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(s, Y, O);
end;
local function J(q)
	if not q then
		return q;
	end;
	if o.unloaded then
		pcall(function()
			q:Disconnect();
		end);
		return q;
	end;
	table.insert(o.conns, q);
	return q;
end;
local function L()
	return Color3.fromRGB(c.GuiR or 200, c.GuiG or 60, c.GuiB or 255);
end;
local function U()
	return Color3.fromRGB(c.GuiTextR or 235, c.GuiTextG or 225, c.GuiTextB or 250);
end;
local function P(q)
	return q:Lerp(Color3.new(0, 0, 0), .7);
end;
local function z()
	return Color3.fromRGB(c.RadiusR or 255, c.RadiusG or 70, c.RadiusB or 160);
end;
local function V()
	return Color3.fromRGB(v.RadiusR or 70, v.RadiusG or 210, v.RadiusB or 255);
end;
local function Q()
	return Color3.fromRGB(c.CircleTextR or 255, c.CircleTextG or 255, c.CircleTextB or 255);
end;
local function X(q)
	local s = math.clamp(q, 1, 9);
	local Y, O, a = 255, 60, 60;
	if s == 1 then
		Y, O, a = c.FOVCustomR1 or 255, c.FOVCustomG1 or 60, c.FOVCustomB1 or 60;
	elseif s == 2 then
		Y, O, a = c.FOVCustomR2 or 60, c.FOVCustomG2 or 255, c.FOVCustomB2 or 60;
	elseif s == 3 then
		Y, O, a = c.FOVCustomR3 or 60, c.FOVCustomG3 or 140, c.FOVCustomB3 or 255;
	elseif s == 4 then
		Y, O, a = c.FOVCustomR4 or 255, c.FOVCustomG4 or 255, c.FOVCustomB4 or 60;
	elseif s == 5 then
		Y, O, a = c.FOVCustomR5 or 255, c.FOVCustomG5 or 60, c.FOVCustomB5 or 255;
	elseif s == 6 then
		Y, O, a = c.FOVCustomR6 or 60, c.FOVCustomG6 or 255, c.FOVCustomB6 or 255;
	elseif s == 7 then
		Y, O, a = c.FOVCustomR7 or 255, c.FOVCustomG7 or 180, c.FOVCustomB7 or 60;
	elseif s == 8 then
		Y, O, a = c.FOVCustomR8 or 255, c.FOVCustomG8 or 255, c.FOVCustomB8 or 255;
	elseif s == 9 then
		Y, O, a = c.FOVCustomR9 or 180, c.FOVCustomG9 or 60, c.FOVCustomB9 or 255;
	end;
	return Color3.fromRGB(Y, O, a);
end;
local function r()
	if c.FOVUseCustom then
		return X(c.FOVCustomIdx or 1);
	end;
	return Color3.fromRGB(c.RebelFOVR or 255, c.RebelFOVG or 60, c.RebelFOVB or 60);
end;
local function u()
	return Color3.fromRGB(c.RebelFOV_OutlineR or 0, c.RebelFOV_OutlineG or 0, c.RebelFOV_OutlineB or 0);
end;
local function k()
	return Color3.fromRGB(c.GuardESP_ColorR or 255, c.GuardESP_ColorG or 50, c.GuardESP_ColorB or 50);
end;
local function y()
	return Color3.fromRGB(c.PlayerESP_ColorR or 80, c.PlayerESP_ColorG or 255, c.PlayerESP_ColorB or 120);
end;
local function p()
	return Color3.fromRGB(c.GuardESP_TracerR or 255, c.GuardESP_TracerG or 50, c.GuardESP_TracerB or 50);
end;
local function R()
	return Color3.fromRGB(c.PlayerESP_TracerR or 80, c.PlayerESP_TracerG or 255, c.PlayerESP_TracerB or 120);
end;
local function g()
	return Color3.fromRGB(c.GuardESP_BoxR or 255, c.GuardESP_BoxG or 50, c.GuardESP_BoxB or 50);
end;
local function E()
	return Color3.fromRGB(c.PlayerESP_BoxR or 80, c.PlayerESP_BoxG or 255, c.PlayerESP_BoxB or 120);
end;
local function e()
	return Color3.fromRGB(c.GuardESP_SkeletonR or 255, c.GuardESP_SkeletonG or 50, c.GuardESP_SkeletonB or 50);
end;
local function w()
	return Color3.fromRGB(c.PlayerESP_SkeletonR or 80, c.PlayerESP_SkeletonG or 255, c.PlayerESP_SkeletonB or 120);
end;
local function N()
	return d(c.GuardESP_HP_TopR or 80, c.GuardESP_HP_TopG or 255, c.GuardESP_HP_TopB or 80, c.GuardESP_HP_M1R or 180, c.GuardESP_HP_M1G or 255, c.GuardESP_HP_M1B or 60, c.GuardESP_HP_M2R or 255, c.GuardESP_HP_M2G or 200, c.GuardESP_HP_M2B or 40, c.GuardESP_HP_M3R or 255, c.GuardESP_HP_M3G or 120, c.GuardESP_HP_M3B or 60, c.GuardESP_HP_BotR or 255, c.GuardESP_HP_BotG or 40, c.GuardESP_HP_BotB or 40);
end;
local function m()
	return d(c.PlayerESP_HP_TopR or 80, c.PlayerESP_HP_TopG or 255, c.PlayerESP_HP_TopB or 80, c.PlayerESP_HP_M1R or 180, c.PlayerESP_HP_M1G or 255, c.PlayerESP_HP_M1B or 60, c.PlayerESP_HP_M2R or 255, c.PlayerESP_HP_M2G or 200, c.PlayerESP_HP_M2B or 40, c.PlayerESP_HP_M3R or 255, c.PlayerESP_HP_M3G or 120, c.PlayerESP_HP_M3B or 60, c.PlayerESP_HP_BotR or 255, c.PlayerESP_HP_BotG or 40, c.PlayerESP_HP_BotB or 40);
end;
local function x()
	return Color3.fromRGB(c.GuardESP_HP_State1_R or 74, c.GuardESP_HP_State1_G or 222, c.GuardESP_HP_State1_B or 74);
end;
local function I()
	return Color3.fromRGB(c.GuardESP_HP_State2_R or 255, c.GuardESP_HP_State2_G or 210, c.GuardESP_HP_State2_B or 60);
end;
local function Z()
	return Color3.fromRGB(c.GuardESP_HP_State3_R or 255, c.GuardESP_HP_State3_G or 130, c.GuardESP_HP_State3_B or 40);
end;
local function n()
	return Color3.fromRGB(c.GuardESP_HP_State4_R or 255, c.GuardESP_HP_State4_G or 55, c.GuardESP_HP_State4_B or 55);
end;
local function t()
	return Color3.fromRGB(c.PlayerESP_HP_State1_R or 74, c.PlayerESP_HP_State1_G or 222, c.PlayerESP_HP_State1_B or 74);
end;
local function l()
	return Color3.fromRGB(c.PlayerESP_HP_State2_R or 255, c.PlayerESP_HP_State2_G or 210, c.PlayerESP_HP_State2_B or 60);
end;
local function i()
	return Color3.fromRGB(c.PlayerESP_HP_State3_R or 255, c.PlayerESP_HP_State3_G or 130, c.PlayerESP_HP_State3_B or 40);
end;
local function qk()
	return Color3.fromRGB(c.PlayerESP_HP_State4_R or 255, c.PlayerESP_HP_State4_G or 55, c.PlayerESP_HP_State4_B or 55);
end;
local function sk(q)
	local s = "";
	for q = 1, q, 1 do
		s = s .. string.char(math.random(97, 122));
	end;
	return s;
end;
local function Yk(q, s)
	return q + ((math.random() * 2 - 1)) * ((s or .006));
end;
local Ok = {};
local function ak(q)
	table.insert(Ok, q);
end;
local function Tk()
	for q = 1, #Ok, 1 do
		pcall(Ok[q]);
	end;
end;
local function Sk()
	if o.unloaded then
		return;
	end;
	pcall(function()
		if not o.clickSound then
			o.clickSound = Instance.new("Sound");
			o.clickSound.SoundId = "rbxassetid://876939830";
			o.clickSound.Volume = .3;
			o.clickSound.Parent = M;
		end;
		o.clickSound.TimePosition = 0;
		o.clickSound:Play();
	end);
end;
local function Mk(q, s)
	local Y = Instance.new("UICorner");
	Y.CornerRadius = UDim.new(0, s or 8);
	Y.Parent = q;
	return Y;
end;
local function Gk(q, s, Y, O)
	local a = Instance.new("UIGradient");
	a.Color = ColorSequence.new(s, Y);
	a.Rotation = O or 90;
	a.Parent = q;
	return a;
end;
local function fk(q, s, Y, O)
	local a = Instance.new("UIStroke");
	a.Color = s or Color3.new(1, 1, 1);
	a.Thickness = Y or 1;
	a.Transparency = O or 0;
	a.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	a.Parent = q;
	return a;
end;
local function Wk()
	if o.tracerGui and o.tracerGui.Parent then
		return;
	end;
	o.tracerGui = Instance.new("ScreenGui");
	o.tracerGui.Name = "XD_Tr_" .. sk(6);
	o.tracerGui.IgnoreGuiInset = true;
	o.tracerGui.ResetOnSpawn = false;
	o.tracerGui.DisplayOrder = 99990;
	local q = nil;
	if gethui then
		local s, Y = pcall(gethui);
		if s and (Y and typeof(Y) == "Instance") then
			q = Y;
		end;
	end;
	if not q then
		q = D:FindFirstChildOfClass("PlayerGui");
	end;
	if not q then
		q = game:GetService("CoreGui");
	end;
	pcall(function()
		o.tracerGui.Parent = q;
	end);
	if not o.tracerGui.Parent then
		pcall(function()
			o.tracerGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local function Fk()
	if o.overlayGui and o.overlayGui.Parent then
		return;
	end;
	o.overlayGui = Instance.new("ScreenGui");
	o.overlayGui.Name = "XD_Ov_" .. sk(6);
	o.overlayGui.IgnoreGuiInset = true;
	o.overlayGui.ResetOnSpawn = false;
	o.overlayGui.DisplayOrder = 99985;
	local q = nil;
	if gethui then
		local s, Y = pcall(gethui);
		if s and (Y and typeof(Y) == "Instance") then
			q = Y;
		end;
	end;
	if not q then
		q = D:FindFirstChildOfClass("PlayerGui");
	end;
	if not q then
		q = game:GetService("CoreGui");
	end;
	pcall(function()
		o.overlayGui.Parent = q;
	end);
	if not o.overlayGui.Parent then
		pcall(function()
			o.overlayGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local Dk = {
		{ "Head", "Torso" },
		{ "Torso", "Left Arm" },
		{ "Torso", "Right Arm" },
		{ "Torso", "Left Leg" },
		{ "Torso", "Right Leg" },
		{ "Head", "HumanoidRootPart" },
	};
local hk = {
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
local function Kk(q)
	return (string.lower(tostring(q or ""))):gsub("[%s%-_%.]", "");
end;
local function ok(q, s)
	if not q or not s then
		return nil;
	end;
	local Y = q:FindFirstChild(s);
	if Y and Y:IsA("BasePart") then
		return Y;
	end;
	local O = Kk(s);
	for q, s in ipairs(q:GetChildren()) do
		if s:IsA("BasePart") and Kk(s.Name) == O then
			return s;
		end;
	end;
	for q, s in ipairs(q:GetDescendants()) do
		if s:IsA("BasePart") and (s.Parent ~= nil and Kk(s.Name) == O) then
			return s;
		end;
	end;
	return nil;
end;
local function Ck(q, s)
	if not q or not s then
		return nil;
	end;
	local Y, O = math.huge, math.huge;
	local a, T = -math.huge, -math.huge;
	local S = false;
	for q, M in ipairs(q:GetDescendants()) do
		if M:IsA("BasePart") then
			local q, G = s:WorldToViewportPoint(M.Position);
			if G then
				S = true;
				if q.X < Y then
					Y = q.X;
				end;
				if q.Y < O then
					O = q.Y;
				end;
				if q.X > a then
					a = q.X;
				end;
				if q.Y > T then
					T = q.Y;
				end;
			end;
		end;
	end;
	if not S then
		return nil;
	end;
	return Y, O, a, T;
end;
local function bk()
	if o.infoGui and o.infoGui.Parent then
		return;
	end;
	o.infoGui = Instance.new("ScreenGui");
	o.infoGui.Name = "XD_I_" .. sk(6);
	o.infoGui.IgnoreGuiInset = true;
	o.infoGui.ResetOnSpawn = false;
	o.infoGui.DisplayOrder = 99995;
	local q = nil;
	if gethui then
		local s, Y = pcall(gethui);
		if s and (Y and typeof(Y) == "Instance") then
			q = Y;
		end;
	end;
	if not q then
		q = D:FindFirstChildOfClass("PlayerGui");
	end;
	if not q then
		q = game:GetService("CoreGui");
	end;
	pcall(function()
		o.infoGui.Parent = q;
	end);
	if not o.infoGui.Parent then
		pcall(function()
			o.infoGui.Parent = game:GetService("CoreGui");
		end);
	end;
	o.wmFrame = Instance.new("Frame");
	o.wmFrame.AnchorPoint = Vector2.new(1, 0);
	o.wmFrame.Position = UDim2.new(1, -12, 0, 12);
	o.wmFrame.Size = UDim2.fromOffset(210, 52);
	o.wmFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	o.wmFrame.BackgroundTransparency = .25;
	o.wmFrame.BorderSizePixel = 0;
	o.wmFrame.ZIndex = 10;
	o.wmFrame.Parent = o.infoGui;
	Mk(o.wmFrame, 6);
	local s = Instance.new("UIStroke");
	s.Color = L();
	s.Thickness = 1.2;
	s.Transparency = .3;
	s.Parent = o.wmFrame;
	ak(function()
		s.Color = L();
	end);
	o.wmLabel = Instance.new("TextLabel");
	o.wmLabel.Size = UDim2.new(1, -12, 1, -4);
	o.wmLabel.Position = UDim2.fromOffset(6, 2);
	o.wmLabel.BackgroundTransparency = 1;
	o.wmLabel.Font = Enum.Font.Code;
	o.wmLabel.TextSize = 11;
	o.wmLabel.TextXAlignment = Enum.TextXAlignment.Left;
	o.wmLabel.TextYAlignment = Enum.TextYAlignment.Top;
	o.wmLabel.TextColor3 = Color3.fromRGB(220, 220, 240);
	o.wmLabel.TextStrokeTransparency = .4;
	o.wmLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	o.wmLabel.Text = h;
	o.wmLabel.ZIndex = 11;
	o.wmLabel.Parent = o.wmFrame;
	o.kbFrame = Instance.new("Frame");
	o.kbFrame.AnchorPoint = Vector2.new(1, 0);
	o.kbFrame.Position = UDim2.new(1, -12, 0, 72);
	o.kbFrame.Size = UDim2.fromOffset(210, 100);
	o.kbFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	o.kbFrame.BackgroundTransparency = .25;
	o.kbFrame.BorderSizePixel = 0;
	o.kbFrame.ZIndex = 10;
	o.kbFrame.Parent = o.infoGui;
	Mk(o.kbFrame, 6);
	local Y = Instance.new("UIStroke");
	Y.Color = L();
	Y.Thickness = 1.2;
	Y.Transparency = .3;
	Y.Parent = o.kbFrame;
	ak(function()
		Y.Color = L();
	end);
	o.kbLabel = Instance.new("TextLabel");
	o.kbLabel.Size = UDim2.new(1, -12, 1, -4);
	o.kbLabel.Position = UDim2.fromOffset(6, 2);
	o.kbLabel.BackgroundTransparency = 1;
	o.kbLabel.Font = Enum.Font.Code;
	o.kbLabel.TextSize = 10;
	o.kbLabel.TextXAlignment = Enum.TextXAlignment.Left;
	o.kbLabel.TextYAlignment = Enum.TextYAlignment.Top;
	o.kbLabel.TextColor3 = Color3.fromRGB(200, 200, 220);
	o.kbLabel.TextStrokeTransparency = .5;
	o.kbLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	o.kbLabel.Text = "[no features]";
	o.kbLabel.ZIndex = 11;
	o.kbLabel.Parent = o.kbFrame;
end;
local function dk()
	if not o.infoGui then
		return;
	end;
	if o.wmFrame then
		o.wmFrame.Visible = c.Watermark and true or false;
	end;
	if o.kbFrame then
		o.kbFrame.Visible = c.KeybindList and true or false;
	end;
end;
local ck = {
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
local vk = {
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
local Hk = {
		["131235569946744"] = .9,
		["114687917628569"] = 3.4,
		["115386570583557"] = .6,
		["70775136168849"] = .7,
		["132207921464999"] = .4,
	};
local Bk, Ak = {}, {};
for q = 1, #ck, 1 do
	Bk[ck[q]] = true;
	o.animEnabled[ck[q]] = true;
end;
for q = 1, #vk, 1 do
	Ak[vk[q]] = true;
	o.animEnabled[vk[q]] = false;
end;
local jk = {
		["power hold"] = true,
		powerhold = true,
		power_hold = true,
		["pocket sand"] = true,
		pocketsand = true,
		pocket_sand = true,
		sand = true,
	};
local function Jk(q)
	if not q then
		return false;
	end;
	local s = (tostring(q)):match("%d+");
	if not s then
		return false;
	end;
	if Ak[s] then
		return false;
	end;
	if Bk[s] then
		return o.animEnabled[s] ~= false;
	end;
	for q in pairs(Bk) do
		if o.animEnabled[q] ~= false and (not Ak[q] and ((s:find(q, 1, true) or q:find(s, 1, true)))) then
			return true;
		end;
	end;
	return false;
end;
local function Lk(q)
	if not q then
		return "";
	end;
	for q, s in ipairs(q:GetChildren()) do
		if s:IsA("Tool") then
			return s.Name;
		end;
	end;
	local s = q:FindFirstChildOfClass("Humanoid");
	if s then
		for q, s in ipairs(s:GetChildren()) do
			if s:IsA("Tool") then
				return s.Name;
			end;
		end;
	end;
	local Y = q:GetAttribute("HoldingWeapon");
	if type(Y) == "string" and Y ~= "" then
		local s = q:FindFirstChild(Y);
		if s then
			return s.Name;
		end;
		return Y;
	end;
	return "";
end;
local function Uk(q)
	if not q then
		return false;
	end;
	for q, s in ipairs(q:GetChildren()) do
		if s:IsA("Tool") then
			local q = string.lower(s.Name);
			for s in pairs(jk) do
				if q:find(s, 1, true) then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function Pk(q)
	if not q then
		return false;
	end;
	for q, s in ipairs(q:GetDescendants()) do
		if s:IsA("ParticleEmitter") or s:IsA("Smoke") then
			local q = string.lower(s.Name);
			if q:find("sand", 1, true) or q:find("dust", 1, true) or q:find("dirt", 1, true) then
				if s.Enabled then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function zk(q)
	if not q or not q:IsA("Tool") then
		return false;
	end;
	local s = string.lower(q.Name);
	if s:find("ultra", 1, true) or s:find("instinct", 1, true) then
		return false;
	end;
	return s:find("dodge", 1, true) ~= nil;
end;
local Vk = {
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
local Qk = {
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
local Xk = (type(keypress) == "function" and type(keyrelease) == "function");
local function rk(q)
	if o.unloaded then
		return;
	end;
	q = string.lower(tostring(q or "t"));
	local s = Vk[q];
	if not s then
		return;
	end;
	if Xk then
		pcall(function()
			keypress(s);
			task.delay(Yk(.006, .002), function()
				pcall(function()
					keyrelease(s);
				end);
			end);
		end);
	else
		pcall(function()
			local s = game:GetService("VirtualInputManager");
			local Y = Enum.KeyCode[string.upper(q)] or Enum.KeyCode.T;
			s:SendKeyEvent(true, Y, false, game);
			task.delay(Yk(.006, .002), function()
				pcall(function()
					s:SendKeyEvent(false, Y, false, game);
				end);
			end);
		end);
	end;
end;
local function uk()
	if o.unloaded then
		return;
	end;
	local q = s.CurrentCamera;
	local Y = (q and q.ViewportSize) or Vector2.new(800, 600);
	local O = math.floor(Y.X / 2);
	local a = math.floor(Y.Y / 2);
	local T = false;
	pcall(function()
		if mouse1click then
			mouse1click();
			T = true;
		end;
	end);
	if T then
		return;
	end;
	pcall(function()
		if mouse1press and mouse1release then
			mouse1press();
			task.wait(.03);
			mouse1release();
			T = true;
		end;
	end);
	if T then
		return;
	end;
	pcall(function()
		local q = game:GetService("VirtualInputManager");
		q:SendMouseButtonEvent(O, a, 0, true, game, 1);
		task.wait(.03);
		q:SendMouseButtonEvent(O, a, 0, false, game, 1);
	end);
end;
local function kk(q, s, Y)
	if Y and Y ~= "" then
		local q = string.upper(tostring(Y));
		if Qk[q] then
			return q;
		end;
	end;
	return s;
end;
local function yk(q)
	local s = string.lower(tostring(q or ""));
	return s:find("ultra", 1, true) ~= nil or s:find("instinct", 1, true) ~= nil;
end;
local function pk()
	local function q(q)
		if not q then
			return nil;
		end;
		for q, s in ipairs(q:GetChildren()) do
			if s:IsA("Tool") and yk(s.Name) then
				return s;
			end;
		end;
		return nil;
	end;
	return q(D.Character) or q(D:FindFirstChild("Backpack"));
end;
local function Rk()
	local function q(q)
		if not q then
			return nil;
		end;
		for q, s in ipairs(q:GetChildren()) do
			if zk(s) then
				return s;
			end;
		end;
		return nil;
	end;
	return q(D.Character) or q(D:FindFirstChild("Backpack"));
end;
local function gk()
	if o.unloaded or not c.Enabled then
		return;
	end;
	local q = tick();
	if q - o.lastDodgeUI < ((c.MinInterval or .02)) then
		return;
	end;
	o.lastDodgeUI = q;
	local s = o.cachedSlot or "T";
	local Y = c.Delay or 0;
	if Y > 0 then
		task.delay(Y, function()
			if not o.unloaded and c.Enabled then
				rk(s);
			end;
		end);
	else
		rk(s);
	end;
end;
local function Ek()
	if o.unloaded or not v.Enabled then
		return;
	end;
	local q = tick();
	if q - o.lastDodgeH < ((v.MinInterval or .02)) then
		return;
	end;
	o.lastDodgeH = q;
	local s = o.cachedDodgeTool or Rk();
	local Y = o.cachedDodgeSlot or "1";
	local O = v.Delay or 0;
	local function a()
		if o.unloaded or not v.Enabled then
			return;
		end;
		local q = D.Character;
		local O = q and q:FindFirstChildOfClass("Humanoid");
		if s and O then
			rk(Y);
			task.wait(.06);
			if s.Parent ~= q then
				pcall(function()
					O:EquipTool(s);
				end);
				task.wait(.06);
			end;
			pcall(function()
				s:Activate();
			end);
			task.wait(.02);
			uk();
			task.wait(.04);
			uk();
		else
			rk(Y);
			task.wait(.05);
			uk();
		end;
	end;
	if O > 0 then
		task.delay(O, a);
	else
		a();
	end;
end;
local function ek(q, s, Y, O)
	if not q or not s then
		return false;
	end;
	if s.Parent == D.Character then
		return false;
	end;
	local a = q.Position.X - s.Position.X;
	local T = q.Position.Z - s.Position.Z;
	local S = q.Position.Y - s.Position.Y;
	if math.abs(S) > 7 then
		return false;
	end;
	local M = a * a + T * T;
	local G = ((Y or 18)) + ((O or 0));
	if M > G * G then
		return false;
	end;
	return true, math.sqrt(M);
end;
local function wk()
	for q, s in pairs(o.hooks) do
		pcall(function()
			s:Disconnect();
		end);
	end;
	table.clear(o.hooks);
end;
local function Nk()
	return c.Enabled or v.Enabled;
end;
local function mk(q, s, Y)
	if o.unloaded or not Nk() then
		return;
	end;
	if not s or not s.Parent then
		return;
	end;
	local O = _G.__adWatchers[s];
	if not O then
		O = { c = 0 };
		_G.__adWatchers[s] = O;
	end;
	if O.c >= 3 then
		return;
	end;
	O.c = O.c + 1;
	local T = Y and 8 or 0;
	local S = false;
	local M = false;
	local G = false;
	if v.Enabled then
		if not v.HollyMode then
			G = true;
		elseif Y then
			G = true;
		elseif q and (q.Animation and Jk(q.Animation.AnimationId)) then
			G = true;
		end;
	end;
	local f = 0;
	if q and (q.Animation and not Y) then
		local s = (tostring(q.Animation.AnimationId)):match("%d+");
		if s and Hk[s] then
			f = Hk[s];
		end;
	end;
	local W = 0;
	if q then
		local s, Y = pcall(function()
				return q.Length;
			end);
		if s and (tonumber(Y) and Y > 0) then
			W = Y;
		end;
	end;
	if not c.Enabled then
		S = true;
	end;
	if not v.Enabled or not G then
		M = true;
	end;
	if S and M then
		O.c = O.c - 1;
		if O.c <= 0 then
			_G.__adWatchers[s] = nil;
		end;
		return;
	end;
	local F = tick();
	local h = math.max(c.AnimWatch or .4, W + ((c.WatchAfter or .3)));
	local K = math.max(v.AnimWatch or .4, W + ((v.WatchAfter or .3)));
	local C = math.max(h + f, K + f);
	local b;
	local function d()
		if b then
			pcall(function()
				b:Disconnect();
			end);
			b = nil;
		end;
		O.c = O.c - 1;
		if O.c <= 0 then
			_G.__adWatchers[s] = nil;
		end;
	end;
	local function H()
		if o.unloaded or (S and M) then
			d();
			return;
		end;
		if tick() - F > C then
			d();
			return;
		end;
		local q = D.Character and D.Character:FindFirstChild("HumanoidRootPart");
		if not q or not s or not s.Parent then
			d();
			return;
		end;
		local Y = tick() - F;
		local O = c.Distance or 18;
		local a = v.Distance or 18;
		local W = s.AssemblyLinearVelocity;
		local h = math.sqrt(W.X * W.X + W.Z * W.Z);
		if h > 15 then
			local Y = q.Position.X - s.Position.X;
			local T = q.Position.Z - s.Position.Z;
			local S = math.sqrt(Y * Y + T * T);
			if S > .5 then
				local q = ((W.X * Y + W.Z * T)) / ((S * h));
				if q > .5 then
					local q = h * .2;
					O = O + q;
					a = a + q;
				end;
			end;
		end;
		if c.Enabled and (not S and Y >= f) then
			if ek(q, s, O, T) then
				S = true;
				gk();
			end;
		end;
		if v.Enabled and (G and (not M and Y >= f)) then
			if ek(q, s, a, T) then
				M = true;
				Ek();
			end;
		end;
		if S and M then
			d();
		end;
	end;
	b = a.Heartbeat:Connect(H);
end;
local function xk(q, s)
	if not q or o.hooks[q] then
		return;
	end;
	o.hooks[q] = q.Activated:Connect(function()
			if o.unloaded or not Nk() then
				return;
			end;
			if Uk(s.Parent) then
				mk(nil, s, true);
			end;
		end);
end;
local function Ik(q, s)
	if o.hooks[q] or o.unloaded then
		return;
	end;
	o.hooks[q] = q.AnimationPlayed:Connect(function(q)
			if o.unloaded or not Nk() then
				return;
			end;
			if not q or not q.Animation then
				return;
			end;
			if s.Parent == D.Character then
				return;
			end;
			local Y = (tostring(q.Animation.AnimationId)):match("%d+");
			if Y and Ak[Y] then
				return;
			end;
			if Jk(q.Animation.AnimationId) then
				mk(q, s, false);
				return;
			end;
			local O = s.Parent;
			if Uk(O) and Pk(O) then
				mk(q, s, true);
			end;
		end);
end;
local function Zk(q)
	if o.unloaded or not q or q == D.Character then
		return;
	end;
	local s = q:FindFirstChildOfClass("Humanoid");
	local Y = q:FindFirstChild("HumanoidRootPart");
	if not s or not Y then
		return;
	end;
	local O = s:FindFirstChildOfClass("Animator");
	if O then
		Ik(O, Y);
	else
		local q;
		q = s.ChildAdded:Connect(function(s)
				if s:IsA("Animator") then
					Ik(s, Y);
					pcall(function()
						q:Disconnect();
					end);
				end;
			end);
		table.insert(o.hooks, q);
	end;
	for q, s in ipairs(q:GetChildren()) do
		if s:IsA("Tool") then
			xk(s, Y);
		end;
	end;
	local a;
	a = q.ChildAdded:Connect(function(q)
			if q:IsA("Tool") then
				xk(q, Y);
			end;
		end);
	table.insert(o.hooks, a);
end;
local function nk()
	if o.unloaded then
		return;
	end;
	wk();
	for q, s in ipairs(q:GetPlayers()) do
		if s ~= D then
			if s.Character then
				Zk(s.Character);
			end;
			if not o.added[s] then
				o.added[s] = s.CharacterAdded:Connect(function(q)
						if Nk() and not o.unloaded then
							task.wait(.15);
							Zk(q);
						end;
					end);
			end;
		end;
	end;
	if not o.added._j then
		o.added._j = q.PlayerAdded:Connect(function(q)
				if o.unloaded then
					return;
				end;
				o.added[q] = q.CharacterAdded:Connect(function(q)
						if Nk() and not o.unloaded then
							task.wait(.15);
							Zk(q);
						end;
					end);
			end);
	end;
	if not o.added._r then
		o.added._r = q.PlayerRemoving:Connect(function(q)
				if o.added[q] then
					pcall(function()
						o.added[q]:Disconnect();
					end);
					o.added[q] = nil;
				end;
			end);
	end;
end;
local function tk()
	if Nk() then
		nk();
	else
		wk();
	end;
end;
local function lk(q)
	if not q then
		return nil;
	end;
	local s = {};
	local function Y(Y)
		for Y, O in ipairs(Y) do
			local a = ok(q, O);
			if a then
				table.insert(s, a);
				return;
			end;
		end;
	end;
	if c.RebelBodyHead then
		Y({ "Head" });
	end;
	if c.RebelBodyTorso then
		Y({ "Torso", "UpperTorso", "LowerTorso" });
	end;
	if c.RebelBodyHRP then
		Y({ "HumanoidRootPart" });
	end;
	if c.RebelBodyLeftArm then
		Y({ "Left Arm", "LeftUpperArm", "LeftLowerArm" });
	end;
	if c.RebelBodyRightArm then
		Y({ "Right Arm", "RightUpperArm", "RightLowerArm" });
	end;
	if c.RebelBodyLeftLeg then
		Y({ "Left Leg", "LeftUpperLeg", "LeftLowerLeg" });
	end;
	if c.RebelBodyRightLeg then
		Y({ "Right Leg", "RightUpperLeg", "RightLowerLeg" });
	end;
	if #s == 0 then
		return q:FindFirstChild("Head") or q:FindFirstChild("HumanoidRootPart");
	end;
	return s[math.random(1, #s)];
end;
local function ik(q)
	if not q then
		return false;
	end;
	if ((c.RebelFOV or 0)) <= 0 then
		return true;
	end;
	local Y = s.CurrentCamera;
	if not Y then
		return false;
	end;
	local O, a = Y:WorldToViewportPoint(q.Position);
	if not a then
		return false;
	end;
	local T = Y.ViewportSize.X / 2;
	local S = Y.ViewportSize.Y / 2;
	local M = O.X - T;
	local G = O.Y - S;
	return math.sqrt(M * M + G * G) <= c.RebelFOV;
end;
local function q4(s)
	if not s or s == D.Character or not s.Parent then
		return false;
	end;
	if not s:IsA("Model") then
		return false;
	end;
	local Y = s:FindFirstChildOfClass("Humanoid");
	if not Y or Y.Health <= 0 then
		return false;
	end;
	local O = s:FindFirstChild("HumanoidRootPart");
	if not O then
		return false;
	end;
	local a = D:GetAttribute("IsGuard") == true;
	local T = q:GetPlayerFromCharacter(s);
	if a then
		local q = s:FindFirstChild("GuardCanKill") or O:FindFirstChild("GuardCanKillLockOn") or O:FindFirstChild("GuardCanKillLockOut");
		if q then
			return true;
		end;
		if c.RebelTargetPlayers and (T and (T ~= D and T:GetAttribute("IsGuard") ~= true)) then
			return true;
		end;
	else
		if c.RebelTargetPlayers and (T and (T ~= D and T:GetAttribute("IsGuard") == true)) then
			return true;
		end;
		if c.RebelTargetNPCs then
			if s.Name:match("Guard") then
				return true;
			end;
			if s:FindFirstChild("TypeOfGuard") then
				return true;
			end;
			local q = s:FindFirstChild("GuardCanKill") or O:FindFirstChild("GuardCanKillLockOut") or O:FindFirstChild("GuardCanKillLockOn");
			if q then
				return true;
			end;
		end;
	end;
	return false;
end;
local function s4(Y)
	local O = s.CurrentCamera;
	if not O then
		return nil;
	end;
	local a = O.ViewportSize.X / 2;
	local T = O.ViewportSize.Y / 2;
	local S, M = nil, math.huge;
	local G = {};
	local function f(q)
		if not q or G[q] then
			return;
		end;
		G[q] = true;
		if not q4(q) then
			return;
		end;
		local s = lk(q);
		if not s or not ik(s) then
			return;
		end;
		local Y, f = O:WorldToViewportPoint(s.Position);
		if not f then
			return;
		end;
		local W = Y.X - a;
		local F = Y.Y - T;
		local D = math.sqrt(W * W + F * F);
		if D < M then
			M = D;
			S = s;
		end;
	end;
	local W = s:FindFirstChild("Live");
	if W then
		for q, s in ipairs(W:GetChildren()) do
			if s:IsA("Model") then
				f(s);
			end;
		end;
	end;
	local F = s:FindFirstChild("Characters");
	if F then
		for q, s in ipairs(F:GetChildren()) do
			if s:IsA("Model") then
				f(s);
			end;
		end;
	end;
	for q, s in ipairs(q:GetPlayers()) do
		if s ~= D and s.Character then
			f(s.Character);
		end;
	end;
	return S;
end;
local function Y4()
	if o.combatHooked then
		return;
	end;
	local q = W;
	local s = q:FindFirstChild("Modules");
	if not s then
		pcall(function()
			s = q:WaitForChild("Modules", 2);
		end);
	end;
	if not s then
		return;
	end;
	local Y = s:FindFirstChild("GunFunctions");
	if not Y then
		pcall(function()
			Y = s:WaitForChild("GunFunctions", 2);
		end);
	end;
	if not Y then
		return;
	end;
	local O, a = pcall(require, Y);
	if not O or not a or type(a) ~= "table" then
		return;
	end;
	o.gunMod = a;
	o.origFiredGun = a.FiredGun;
	o.origGetBuffs = a.GetBuffs;
	if type(o.origFiredGun) == "function" then
		a.FiredGun = function(q, s, Y, ...)
				if o.unloaded or not c.RebelSilentAim then
					return o.origFiredGun(q, s, Y, ...);
				end;
				if q ~= D.Character then
					return o.origFiredGun(q, s, Y, ...);
				end;
				Y = Y or {};
				local O = q and q:FindFirstChild("HumanoidRootPart");
				if not O then
					return o.origFiredGun(q, s, Y, ...);
				end;
				local a = O.Position;
				pcall(function()
					local s = q:GetAttribute("HoldingWeapon");
					if s then
						local Y = q:FindFirstChild(s);
						if Y then
							local q = Y:FindFirstChild("FireFrom");
							if q then
								a = q.Position;
							end;
						end;
					end;
				end);
				local T = s4(a);
				if T then
					s = T.Position;
					Y.CustomFireFrom = true;
					Y.spread = 0;
				end;
				return o.origFiredGun(q, s, Y, ...);
			end;
	end;
	if type(o.origGetBuffs) == "function" then
		a.GetBuffs = function(...)
				local q = o.origGetBuffs(...);
				if type(q) ~= "table" then
					q = {};
				end;
				local s = {};
				for q, Y in pairs(q) do
					s[q] = Y;
				end;
				if c.RebelNoRecoil then
					s.RecoilDiv = 999999;
				end;
				if c.RebelRapidFire then
					s.FireRateMult = 9999;
				end;
				return s;
			end;
	end;
	o.combatHooked = true;
end;
local function O4()
	if not o.combatHooked or not o.gunMod then
		return;
	end;
	pcall(function()
		if o.origFiredGun then
			o.gunMod.FiredGun = o.origFiredGun;
		end;
		if o.origGetBuffs then
			o.gunMod.GetBuffs = o.origGetBuffs;
		end;
	end);
	o.combatHooked = false;
end;
local function a4()
	if o.fovGui then
		pcall(function()
			o.fovGui:Destroy();
		end);
	end;
	o.fovGui = nil;
	o.fovFrame = nil;
	o.fovStroke = nil;
end;
local function T4()
	if o.fovRainbowConn then
		pcall(function()
			o.fovRainbowConn:Disconnect();
		end);
		o.fovRainbowConn = nil;
	end;
end;
local function S4()
	if not o.fovFrame then
		return;
	end;
	for q, s in ipairs(o.fovFrame:GetChildren()) do
		if s:IsA("Frame") then
			for q, s in ipairs(s:GetChildren()) do
				if s:IsA("UIStroke") then
					local q = s:FindFirstChildOfClass("UIGradient");
					if q then
						q:Destroy();
					end;
				end;
			end;
		end;
	end;
	if o.fovStroke then
		local q = o.fovStroke:FindFirstChildOfClass("UIGradient");
		if q then
			q:Destroy();
		end;
	end;
end;
local function M4(q, s, Y, O, a, T)
	local S = X(1);
	local M = X(2);
	local G = X(3);
	local f = X(4);
	local W = ColorSequence.new({
			ColorSequenceKeypoint.new(0, q),
			ColorSequenceKeypoint.new(.11, s),
			ColorSequenceKeypoint.new(.22, Y),
			ColorSequenceKeypoint.new(.33, O),
			ColorSequenceKeypoint.new(.44, a),
			ColorSequenceKeypoint.new(.55, S),
			ColorSequenceKeypoint.new(.66, M),
			ColorSequenceKeypoint.new(.77, G),
			ColorSequenceKeypoint.new(.88, f),
			ColorSequenceKeypoint.new(1, q),
		});
	for q, s in ipairs(o.fovFrame:GetChildren()) do
		if s:IsA("Frame") and (s.Name ~= "BlackOuter" and s.Name ~= "BlackInner") then
			for q, s in ipairs(s:GetChildren()) do
				if s:IsA("UIStroke") and (s.Name ~= "BlackStrokeOuter" and (s.Name ~= "BlackStrokeInner" and s.Name ~= "InnerStroke")) then
					local q = s:FindFirstChildOfClass("UIGradient");
					if not q then
						q = Instance.new("UIGradient");
						q.Parent = s;
					end;
					q.Color = W;
					q.Rotation = T;
				end;
			end;
		end;
	end;
	if o.fovStroke then
		local q = o.fovStroke:FindFirstChildOfClass("UIGradient");
		if not q then
			q = Instance.new("UIGradient");
			q.Parent = o.fovStroke;
		end;
		q.Color = W;
		q.Rotation = T;
	end;
end;
local function G4()
	T4();
	o.fovRainbowConn = a.RenderStepped:Connect(function()
			if o.unloaded or not c.FOVRainbow then
				return;
			end;
			if not o.fovFrame or not o.fovFrame.Parent then
				return;
			end;
			local q = tick();
			local s = c.FOVRainbowMode or 1;
			local Y = c.FOVUseCustom;
			local O = tonumber(c.RebelFOVBlendSpeed) or .5;
			if s ~= 6 then
				S4();
			end;
			if s == 6 then
				local s = X(5);
				local Y = X(6);
				local a = X(7);
				local T = X(8);
				local S = X(9);
				M4(s, Y, a, T, S, (((q * O) * 60)) % 360);
				return;
			end;
			local a;
			if s == 1 then
				if Y then
					local s = X(1);
					local Y = X(2);
					a = s:Lerp(Y, .5 + .5 * math.sin((q * O) * 2));
				else
					a = Color3.fromHSV(((q * .35)) % 1, 1, 1);
				end;
			elseif s == 2 then
				if Y then
					local s = X(1);
					local Y = X(2);
					a = s:Lerp(Y, .5 + .5 * math.sin((q * O) * 3));
				else
					a = Color3.fromHSV(((q * .2)) % 1, 1, .7 + .3 * math.sin(q * 3));
				end;
			elseif s == 3 then
				if Y then
					local s = X(1);
					local Y = X(2);
					local T = X(3);
					local S = .5 + .5 * math.sin((q * O) * 1.8);
					local M = .5 + .5 * math.sin((q * O) * 2.6 + 1.7);
					a = (s:Lerp(Y, S)):Lerp(T, M * .5);
				else
					local s = Color3.fromHSV(((q * .4)) % 1, 1, 1);
					local Y = Color3.fromHSV(((q * .4 + .5)) % 1, 1, 1);
					a = s:Lerp(Y, .5 + .5 * math.sin(q * 2.2));
				end;
			elseif s == 4 then
				if Y then
					local s = X(1);
					local Y = X(2);
					a = s:Lerp(Y, .5 + .5 * math.sin((q * O) * 3.5));
				else
					a = Color3.fromHSV(((q * .15)) % 1, .9, .55 + .45 * ((.5 + .5 * math.sin(q * 3.5))));
				end;
			elseif s == 5 then
				if Y then
					local s = X(1);
					local Y = X(2);
					local T = X(3);
					local S = X(4);
					local M = .5 + .5 * math.sin((q * O) * 1.6);
					local G = .5 + .5 * math.sin((q * O) * 2.3 + 1.7);
					a = ((s:Lerp(Y, M)):Lerp(T, G * .4)):Lerp(S, M * .3);
				else
					local s = Color3.fromHSV(((q * .25)) % 1, 1, 1);
					local Y = Color3.fromHSV(((q * .25 + .5)) % 1, 1, 1);
					local O = Color3.fromHSV(((q * .25 + .75)) % 1, .9, 1);
					local T = .5 + .5 * math.sin(q * 1.6);
					local S = .5 + .5 * math.sin(q * 2.3 + 1.7);
					a = (s:Lerp(Y, T)):Lerp(O, S * .4);
				end;
			end;
			if a then
				for q, s in ipairs(o.fovFrame:GetChildren()) do
					if s:IsA("Frame") then
						for q, s in ipairs(s:GetChildren()) do
							if s:IsA("UIStroke") and (s.Name ~= "BlackStrokeOuter" and s.Name ~= "BlackStrokeInner") then
								s.Color = a;
							end;
						end;
					end;
				end;
				if o.fovStroke then
					o.fovStroke.Color = a;
				end;
			end;
		end);
end;
local function f4()
	if o.panelRainbowConn then
		pcall(function()
			o.panelRainbowConn:Disconnect();
		end);
		o.panelRainbowConn = nil;
	end;
end;
local function W4()
	f4();
	o.panelRainbowConn = a.RenderStepped:Connect(function()
			if o.unloaded or not c.PanelRainbow then
				return;
			end;
			if not o.panel or not o.panel.Parent then
				return;
			end;
			local q = Color3.fromHSV(((tick() * .15)) % 1, 1, 1);
			local s = o.panel:FindFirstChildOfClass("UIStroke");
			if s then
				s.Color = q;
			end;
		end);
end;
local function F4()
	a4();
	if not c.RebelFOVCircle then
		return;
	end;
	local q = nil;
	if gethui then
		local s, Y = pcall(gethui);
		if s and (Y and typeof(Y) == "Instance") then
			q = Y;
		end;
	end;
	if not q then
		q = D:FindFirstChildOfClass("PlayerGui");
	end;
	if not q then
		q = game:GetService("CoreGui");
	end;
	o.fovGui = Instance.new("ScreenGui");
	o.fovGui.Name = "XD_FOV_" .. sk(6);
	o.fovGui.IgnoreGuiInset = true;
	o.fovGui.ResetOnSpawn = false;
	o.fovGui.DisplayOrder = 99998;
	pcall(function()
		o.fovGui.Parent = q;
	end);
	if not o.fovGui.Parent then
		pcall(function()
			o.fovGui.Parent = game:GetService("CoreGui");
		end);
	end;
	local s = math.max(4, ((c.RebelFOV or 150)) * 2);
	local Y = math.floor(s / 2);
	local O = c.RebelFOV_OutlineThickness or 5;
	o.fovFrame = Instance.new("Frame");
	o.fovFrame.BackgroundTransparency = 1;
	o.fovFrame.AnchorPoint = Vector2.new(.5, .5);
	o.fovFrame.Position = UDim2.new(.5, 0, .5, 0);
	o.fovFrame.Size = UDim2.fromOffset(s, s);
	o.fovFrame.ZIndex = 1000;
	o.fovFrame.Parent = o.fovGui;
	Mk(o.fovFrame, Y);
	if c.RebelFOVBlackOutline then
		local q = Instance.new("Frame");
		q.Name = "BlackOuter";
		q.BackgroundTransparency = 1;
		q.Size = UDim2.fromScale(1, 1);
		q.AnchorPoint = Vector2.new(.5, .5);
		q.Position = UDim2.fromScale(.5, .5);
		q.ZIndex = 996;
		q.Parent = o.fovFrame;
		Mk(q, Y);
		local s = Instance.new("UIStroke");
		s.Name = "BlackStrokeOuter";
		s.Color = u();
		s.Thickness = O;
		s.Transparency = 0;
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		s.Parent = q;
		local a = Instance.new("Frame");
		a.Name = "BlackInner";
		a.BackgroundTransparency = 1;
		a.Size = UDim2.new(1, -((O + 3)), 1, -((O + 3)));
		a.AnchorPoint = Vector2.new(.5, .5);
		a.Position = UDim2.fromScale(.5, .5);
		a.ZIndex = 996;
		a.Parent = o.fovFrame;
		Mk(a, Y);
		local T = Instance.new("UIStroke");
		T.Name = "BlackStrokeInner";
		T.Color = u();
		T.Thickness = math.max(1, O - 2);
		T.Transparency = 0;
		T.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		T.Parent = a;
	end;
	if c.RebelFOVNeon then
		local q = Instance.new("Frame");
		q.Name = "Glow1";
		q.BackgroundTransparency = 1;
		q.Size = UDim2.fromScale(1, 1);
		q.AnchorPoint = Vector2.new(.5, .5);
		q.Position = UDim2.fromScale(.5, .5);
		q.ZIndex = 999;
		q.Parent = o.fovFrame;
		Mk(q, Y);
		local s = Instance.new("UIStroke");
		s.Color = r();
		s.Thickness = 14;
		s.Transparency = .82;
		s.Parent = q;
		local O = Instance.new("Frame");
		O.Name = "Glow2";
		O.BackgroundTransparency = 1;
		O.Size = UDim2.fromScale(1, 1);
		O.AnchorPoint = Vector2.new(.5, .5);
		O.Position = UDim2.fromScale(.5, .5);
		O.ZIndex = 999;
		O.Parent = o.fovFrame;
		Mk(O, Y);
		local a = Instance.new("UIStroke");
		a.Color = r();
		a.Thickness = 6;
		a.Transparency = .55;
		a.Parent = O;
	end;
	o.fovStroke = Instance.new("UIStroke");
	o.fovStroke.Color = Color3.new(1, 1, 1);
	local a = tonumber(c.RebelFOVCircleWidth) or 1.6;
	if c.FOVRainbow and ((c.FOVRainbowMode or 1)) == 6 then
		a = a * 2.5;
	end;
	o.fovStroke.Thickness = a;
	o.fovStroke.Transparency = 0;
	o.fovStroke.Parent = o.fovFrame;
	local T = Instance.new("Frame");
	T.Name = "Inner";
	T.BackgroundTransparency = 1;
	T.Size = UDim2.fromScale(1, 1);
	T.AnchorPoint = Vector2.new(.5, .5);
	T.Position = UDim2.fromScale(.5, .5);
	T.ZIndex = 1001;
	T.Parent = o.fovFrame;
	Mk(T, Y);
	local S = Instance.new("UIStroke");
	S.Name = "InnerStroke";
	S.Color = r();
	S.Thickness = 1.2;
	S.Transparency = .15;
	S.Parent = T;
	if c.FOVRainbow then
		G4();
	end;
end;
local function D4()
	if not o.fovFrame then
		return;
	end;
	local q = math.max(4, ((c.RebelFOV or 150)) * 2);
	local s = math.floor(q / 2);
	local Y = c.RebelFOV_OutlineThickness or 5;
	o.fovFrame.Size = UDim2.fromOffset(q, q);
	local O = o.fovFrame:FindFirstChildOfClass("UICorner");
	if O then
		O.CornerRadius = UDim.new(0, s);
	end;
	for q, O in ipairs(o.fovFrame:GetChildren()) do
		if O:IsA("Frame") then
			local q = O:FindFirstChildOfClass("UICorner");
			if q then
				q.CornerRadius = UDim.new(0, s);
			end;
			if O.Name == "BlackInner" then
				O.Size = UDim2.new(1, -((Y + 3)), 1, -((Y + 3)));
			end;
			for q, s in ipairs(O:GetChildren()) do
				if s:IsA("UIStroke") then
					if s.Name == "BlackStrokeOuter" then
						s.Color = u();
						s.Thickness = Y;
						s.Transparency = 0;
					elseif s.Name == "BlackStrokeInner" then
						s.Color = u();
						s.Thickness = math.max(1, Y - 2);
						s.Transparency = 0;
					elseif s.Parent and s.Parent.Name == "Glow1" then
						s.Color = r();
						s.Transparency = .82;
					elseif s.Parent and s.Parent.Name == "Glow2" then
						s.Color = r();
						s.Transparency = .55;
					elseif s.Name == "InnerStroke" then
						s.Color = r();
						s.Transparency = .15;
					end;
				end;
			end;
		end;
	end;
	if o.fovStroke then
		local q = tonumber(c.RebelFOVCircleWidth) or 1.6;
		if c.FOVRainbow and ((c.FOVRainbowMode or 1)) == 6 then
			q = q * 2.5;
		end;
		o.fovStroke.Thickness = q;
	end;
end;
local h4, K4, o4;
local function C4()
	if o4 then
		pcall(function()
			o4:Disconnect();
		end);
		o4 = nil;
	end;
	if h4 then
		pcall(function()
			h4:Destroy();
		end);
		h4 = nil;
	end;
	if K4 then
		pcall(function()
			K4:Destroy();
		end);
		K4 = nil;
	end;
end;
local function b4(q)
	local Y = Instance.new("Part");
	Y.Name = "UIRadiusDisc";
	Y.Anchored = true;
	Y.CanCollide = false;
	Y.CanQuery = false;
	Y.CanTouch = false;
	Y.CastShadow = false;
	Y.Massless = true;
	Y.Locked = true;
	Y.Material = Enum.Material.Plastic;
	Y.Color = q;
	Y.Shape = Enum.PartType.Cylinder;
	Y.Size = Vector3.new(.08, 2, 2);
	Y.Transparency = .55;
	pcall(function()
		Y.Parent = s.CurrentCamera or s;
	end);
	return Y;
end;
local function d4()
	if o.unloaded then
		return;
	end;
	C4();
	if not c.RadiusVis and not v.RadiusVis then
		return;
	end;
	if c.RadiusVis then
		h4 = b4(z());
	end;
	if v.RadiusVis then
		K4 = b4(V());
	end;
	o4 = a.RenderStepped:Connect(function()
			if o.unloaded then
				return;
			end;
			local q = D.Character and D.Character:FindFirstChild("HumanoidRootPart");
			if not q then
				return;
			end;
			local s = q.Position - Vector3.new(0, 2.9, 0);
			if h4 then
				local q = math.max(2, c.Distance or 16) * 2;
				h4.CFrame = CFrame.new(s) * CFrame.Angles(0, 0, math.rad(90));
				h4.Size = Vector3.new(.08, q, q);
				h4.Color = z();
				h4.Transparency = math.clamp(1 - ((c.RadiusTransparency or .55)), .1, .9);
			end;
			if K4 then
				local q = math.max(2, v.Distance or 16) * 2;
				local Y = s + Vector3.new(0, .02, 0);
				K4.CFrame = CFrame.new(Y) * CFrame.Angles(0, 0, math.rad(90));
				K4.Size = Vector3.new(.08, q, q);
				K4.Color = V();
				K4.Transparency = math.clamp(1 - ((v.RadiusTransparency or .55)), .1, .9);
			end;
		end);
end;
local function c4()
	C4();
end;
local v4 = "rbxassetid://88400194373338";
_G.__rlgl_isRed = function()
		local q, s = pcall(function()
				local q = D:FindFirstChild("PlayerGui");
				if not q then
					return false;
				end;
				local s = q:FindFirstChild("ImpactFrames");
				if not s then
					return false;
				end;
				local Y = s:FindFirstChild("TrafficLightEmpty");
				if not Y or not Y:IsA("ImageLabel") then
					return false;
				end;
				return Y.Image == v4;
			end);
		if q and s then
			return true;
		end;
		local Y, O = pcall(function()
				local q = f:FindFirstChildOfClass("ColorCorrectionEffect");
				if not q or not q.Enabled then
					return false;
				end;
				local s = q.TintColor;
				return s.R > .6 and (s.G < .4 and s.B < .4);
			end);
		if Y and O then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inSafeZone = function()
		local q = D.Character;
		if not q then
			return false;
		end;
		local s = q:FindFirstChild("HumanoidRootPart");
		if not s then
			return false;
		end;
		local Y = s.Position;
		if math.abs(Y.Y - 1023) > 80 then
			return false;
		end;
		local function O(q, s, O, a)
			return Y.X >= q and (Y.X <= s and (Y.Z >= O and Y.Z <= a));
		end;
		if O(-219, 135, -656, -511) then
			return true;
		end;
		if O(-215, 115, 82, 168) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inFinishZone = function()
		local q = D.Character;
		if not q then
			return false;
		end;
		local s = q:FindFirstChild("HumanoidRootPart");
		if not s then
			return false;
		end;
		local Y = s.Position;
		if math.abs(Y.Y - 1023) > 80 then
			return false;
		end;
		if Y.X >= -215 and (Y.X <= 115 and (Y.Z >= 82 and Y.Z <= 168)) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_isMoving = function(q)
		local s = D.Character;
		if not s then
			return false;
		end;
		local Y = s:FindFirstChildOfClass("Humanoid");
		local O = s:FindFirstChild("HumanoidRootPart");
		if not Y or not O then
			return false;
		end;
		if Y.MoveDirection.Magnitude > .1 then
			return true;
		end;
		local a = O.AssemblyLinearVelocity;
		return math.sqrt(a.X * a.X + a.Z * a.Z) > ((q or .3));
	end;
_G.__rlgl_isOnMap = function()
		local q = workspace:FindFirstChild("Values");
		if q then
			local s = q:FindFirstChild("CurrentGame");
			if s and s.Value == "RedLightGreenLight" then
				return true;
			end;
		end;
		local s = D.Character;
		if not s then
			return false;
		end;
		local Y = s:FindFirstChild("HumanoidRootPart");
		if not Y then
			return false;
		end;
		return Y.Position.Y > 1000 and Y.Position.Y < 1050;
	end;
_G.__rlgl_timerSeconds = function()
		local q = workspace:GetAttribute("CurrentGameTime");
		if type(q) == "number" then
			return q, tostring(q);
		end;
		for q, s in ipairs({
			"TimeLeft",
			"Timer",
			"RoundTime",
			"TimeRemaining",
		}) do
			local Y = workspace:GetAttribute(s);
			if type(Y) == "number" then
				return Y, tostring(Y);
			end;
		end;
		local function s(q)
			if not q or q == "" then
				return nil;
			end;
			q = ((tostring(q)):gsub("^%s+", "")):gsub("%s+$", "");
			local s, Y = q:match("^(%d+):(%d+)");
			if s then
				return tonumber(s) * 60 + tonumber(Y), q;
			end;
			local O = q:match("^(%d+)");
			if O then
				return tonumber(O), q;
			end;
			return nil, q;
		end;
		if _G.__rlgl_timerLabel and _G.__rlgl_timerLabel.Parent then
			local q, Y = s(_G.__rlgl_timerLabel.Text);
			if q ~= nil then
				return q, Y;
			end;
		end;
		return nil, nil;
	end;
_G.__rlgl_fireDodge = function()
		if o.unloaded then
			return;
		end;
		local q = D.Character;
		if not q then
			return;
		end;
		local s = q:FindFirstChildOfClass("Humanoid");
		if not s or s.Health <= 0 then
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
				local q = game:GetService("VirtualInputManager");
				q:SendKeyEvent(true, Enum.KeyCode.T, false, game);
				task.delay(.012, function()
					pcall(function()
						q:SendKeyEvent(false, Enum.KeyCode.T, false, game);
					end);
				end);
			end);
		end;
	end;
local function H4(q)
	if q then
		if not o.fbInst then
			o.fbInst = Instance.new("ColorCorrectionEffect");
			o.fbInst.Name = "_XD_FB";
			o.fbInst.Brightness = .3;
			o.fbInst.Contrast = .15;
			o.fbInst.Saturation = .05;
			o.fbInst.Parent = f;
		end;
	else
		if o.fbInst then
			pcall(function()
				o.fbInst:Destroy();
			end);
			o.fbInst = nil;
		end;
	end;
end;
local function B4(q)
	if q then
		if not o.fogBackup then
			o.fogBackup = { FogEnd = f.FogEnd, FogStart = f.FogStart, FogColor = f.FogColor };
		end;
		f.FogEnd = 1000000;
		f.FogStart = 1000000;
	else
		if o.fogBackup then
			f.FogEnd = o.fogBackup.FogEnd;
			f.FogStart = o.fogBackup.FogStart;
			f.FogColor = o.fogBackup.FogColor;
			o.fogBackup = nil;
		end;
	end;
end;
local A4 = {};
local function j4(q, s)
	if o.unloaded then
		return;
	end;
	pcall(function()
		if not o.notifHolder or not o.notifHolder.Parent then
			o.notifHolder = Instance.new("ScreenGui");
			o.notifHolder.Name = "XD_Nf_" .. sk(6);
			o.notifHolder.IgnoreGuiInset = true;
			o.notifHolder.ResetOnSpawn = false;
			o.notifHolder.DisplayOrder = 99999;
			local q = nil;
			if gethui then
				local s, Y = pcall(gethui);
				if s and (Y and typeof(Y) == "Instance") then
					q = Y;
				end;
			end;
			if not q then
				q = D:FindFirstChildOfClass("PlayerGui");
			end;
			if not q then
				q = game:GetService("CoreGui");
			end;
			pcall(function()
				o.notifHolder.Parent = q;
			end);
			if not o.notifHolder.Parent then
				pcall(function()
					o.notifHolder.Parent = game:GetService("CoreGui");
				end);
			end;
		end;
		local Y = Instance.new("Frame");
		Y.Size = UDim2.fromOffset(250, 36);
		Y.AnchorPoint = Vector2.new(.5, 0);
		Y.Position = UDim2.new(.5, 0, 0, -60);
		Y.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
		Y.BackgroundTransparency = .12;
		Y.BorderSizePixel = 0;
		Y.ZIndex = 5;
		Y.Parent = o.notifHolder;
		Mk(Y, 8);
		local O = Instance.new("UIStroke");
		O.Color = s or L();
		O.Thickness = 1.5;
		O.Transparency = .1;
		O.Parent = Y;
		local a = Instance.new("TextLabel");
		a.Size = UDim2.new(1, -12, 1, 0);
		a.Position = UDim2.fromOffset(6, 0);
		a.BackgroundTransparency = 1;
		a.Font = Enum.Font.GothamBold;
		a.TextSize = 12;
		a.TextColor3 = Color3.fromRGB(235, 225, 250);
		a.Text = tostring(q or "");
		a.ZIndex = 6;
		a.Parent = Y;
		table.insert(A4, 1, Y);
		for q, s in ipairs(A4) do
			if s and s.Parent then
				local Y = 20 + ((q - 1)) * 42;
				(S:Create(s, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, Y) })):Play();
			end;
		end;
		(S:Create(Y, TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, 20) })):Play();
		task.delay(2.2, function()
			if not Y or not Y.Parent then
				return;
			end;
			local q = TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
			(S:Create(Y, q, { Position = UDim2.new(.5, 0, 0, -60), BackgroundTransparency = 1 })):Play();
			(S:Create(O, q, { Transparency = 1 })):Play();
			(S:Create(a, q, { TextTransparency = 1 })):Play();
			task.delay(.35, function()
				for q = #A4, 1, -1 do
					if A4[q] == Y then
						table.remove(A4, q);
						break;
					end;
				end;
				pcall(function()
					Y:Destroy();
				end);
				for q, s in ipairs(A4) do
					if s and s.Parent then
						local Y = 20 + ((q - 1)) * 42;
						(S:Create(s, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, Y) })):Play();
					end;
				end;
			end);
		end);
	end);
end;
_G.__adShowNotif = j4;
local function J4()
	if o.unloaded or not c.AutoBrew then
		return;
	end;
	local q = string.lower(tostring(c.AutoBrewSlot or "e"));
	rk(q);
	task.wait(.2);
	local s = Vk[q];
	if not s then
		return;
	end;
	local Y = tonumber(c.AutoBrewCollectHold) or 2;
	if Xk then
		pcall(function()
			keypress(s);
			task.wait(Y);
			keyrelease(s);
		end);
	else
		pcall(function()
			local s = game:GetService("VirtualInputManager");
			local O = Enum.KeyCode[string.upper(q)] or Enum.KeyCode.E;
			s:SendKeyEvent(true, O, false, game);
			task.wait(Y);
			s:SendKeyEvent(false, O, false, game);
		end);
	end;
end;
local function L4()
	if o.brewLoopConn then
		return;
	end;
	o.lastBrewTick = tick();
	o.brewLoopConn = task.spawn(function()
			while not o.unloaded and c.AutoBrew do
				local q = tonumber(c.AutoBrewInterval) or 60;
				if tick() - o.lastBrewTick >= q then
					o.lastBrewTick = tick();
					pcall(J4);
				end;
				task.wait(.5);
			end;
		end);
end;
local function U4()
	if o.brewLoopConn then
		pcall(function()
			task.cancel(o.brewLoopConn);
		end);
		o.brewLoopConn = nil;
	end;
end;
local P4 = {
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
local function z4()
	local q = D.Character;
	if not q then
		return nil;
	end;
	local s = q:FindFirstChild("HumanoidRootPart");
	if not s then
		return nil;
	end;
	local Y = q:GetAttribute("HoldingWeapon");
	if type(Y) == "string" and Y ~= "" then
		local s = q:FindFirstChild(Y);
		if s then
			local q = s:FindFirstChild("FireFrom");
			if q and q:IsA("BasePart") then
				return q.Position;
			end;
			local Y = s:FindFirstChild("Handle");
			if Y and Y:IsA("BasePart") then
				return Y.Position + Y.CFrame.LookVector * .5;
			end;
		end;
	end;
	return (s.Position + s.CFrame.LookVector * 1.5) + Vector3.new(0, .8, 0);
end;
local function V4(q)
	local Y = s.CurrentCamera;
	if not Y then
		return nil;
	end;
	local O = D:GetMouse();
	if not O then
		return nil;
	end;
	local a = Y:ScreenPointToRay(O.X, O.Y);
	local T = RaycastParams.new();
	T.FilterType = Enum.RaycastFilterType.Exclude;
	T.FilterDescendantsInstances = { D.Character };
	local S = s:Raycast(q, a.Direction * c.BulletTracerRange, T);
	if S then
		return S.Position;
	end;
	return q + a.Direction * c.BulletTracerRange;
end;
local function Q4(q, s)
	local Y = s - q;
	local O = Y.Magnitude;
	if O < 1 then
		return;
	end;
	local T = Y.Unit;
	local M = q + T * c.BulletTracerStartOffset;
	local G = s - T * c.BulletTracerEndOffset;
	local f = ((G - M)).Magnitude;
	if f < .3 then
		return;
	end;
	local W = ((M + G)) / 2;
	local F = CFrame.lookAt(W, G);
	local D = Color3.fromRGB(c.BulletTracerR, c.BulletTracerG, c.BulletTracerB);
	local h = c.BulletTracerThickness;
	local K = c.BulletTracerLifetime;
	local C = P4[c.BulletTracerFadeIdx or 1].style;
	local b = TweenInfo.new(K, C, Enum.EasingDirection.Out);
	local d = math.max(50, tonumber(c.BulletTracerSpeed) or 800);
	local v = O / d;
	if v < .015 then
		v = .015;
	end;
	local function H(q, s, Y)
		local O = Instance.new("Part");
		O.Name = "_XD_BTracer";
		O.Anchored = true;
		O.CanCollide = false;
		O.CanQuery = false;
		O.CanTouch = false;
		O.CastShadow = false;
		O.Material = Enum.Material.Neon;
		O.Color = s;
		O.Transparency = Y;
		O.Size = q;
		O.CFrame = F;
		O.Parent = workspace;
		return O;
	end;
	local function B(q, s, Y, O)
		task.spawn(function()
			local S = tick();
			while true do
				if o.unloaded or not q or not q.Parent then
					return;
				end;
				local f = ((tick() - S)) / v;
				if f >= 1 then
					f = 1;
				end;
				local W = O * f;
				if W < .01 then
					W = .01;
				end;
				q.Size = Vector3.new(s, Y, W);
				q.CFrame = CFrame.lookAt(M + T * ((W / 2)), G);
				if f >= 1 then
					break;
				end;
				a.Heartbeat:Wait();
			end;
		end);
	end;
	if c.BulletTracerGlow then
		local q = H(Vector3.new(h * 3, h * 3, .01), D, math.clamp(c.BulletTracerOpacity + .4, 0, 1));
		task.delay((K + v) + .1, function()
			pcall(function()
				q:Destroy();
			end);
		end);
		B(q, h * 3, h * 3, f);
		task.delay(v, function()
			if q and q.Parent then
				(S:Create(q, b, { Transparency = 1, Size = Vector3.new(.01, .01, f) })):Play();
			end;
		end);
	end;
	local A = H(Vector3.new(h, h, .01), D, c.BulletTracerOpacity);
	if c.BulletTracerGlow then
		local q = Instance.new("PointLight");
		q.Color = D;
		q.Brightness = 3;
		q.Range = 8;
		q.Parent = A;
	end;
	task.delay((K + v) + .1, function()
		pcall(function()
			A:Destroy();
		end);
	end);
	B(A, h, h, f);
	task.delay(v, function()
		if A and A.Parent then
			(S:Create(A, b, { Transparency = 1, Size = Vector3.new(.01, .01, f) })):Play();
		end;
	end);
	if c.BulletTracerWhiteCore then
		local q = H(Vector3.new(h * .3, h * .3, .01), Color3.new(1, 1, 1), math.clamp(c.BulletTracerOpacity + .1, 0, 1));
		task.delay((K + v) + .1, function()
			pcall(function()
				q:Destroy();
			end);
		end);
		B(q, h * .3, h * .3, f);
		task.delay(v, function()
			if q and q.Parent then
				(S:Create(q, b, { Transparency = 1, Size = Vector3.new(.005, .005, f) })):Play();
			end;
		end);
	end;
end;
local function X4()
	if not c.BulletTracer then
		return;
	end;
	local q = tick();
	if q - o.btLastShot < c.BulletTracerCooldown then
		return;
	end;
	o.btLastShot = q;
	local s = z4();
	if not s then
		return;
	end;
	local Y = V4(s);
	if not Y then
		return;
	end;
	Q4(s, Y);
end;
local function r4(q)
	if not q then
		return;
	end;
	if o.btAnimConn then
		pcall(function()
			o.btAnimConn:Disconnect();
		end);
		o.btAnimConn = nil;
	end;
	o.btAnimConn = q.AnimationPlayed:Connect(function(q)
			local s = q.Animation;
			if not s then
				return;
			end;
			local Y = s.AnimationId;
			if not b[Y] then
				return;
			end;
			local O = tick();
			if O - ((o.btLastIdTime[Y] or 0)) < c.BulletTracerCooldown then
				return;
			end;
			o.btLastIdTime[Y] = O;
			X4();
		end);
end;
local function u4(q)
	if not q then
		return;
	end;
	local s = q:FindFirstChildOfClass("Humanoid");
	if not s then
		return;
	end;
	local Y = s:FindFirstChildOfClass("Animator");
	if Y then
		r4(Y);
	else
		local q;
		q = s.ChildAdded:Connect(function(s)
				if s:IsA("Animator") then
					r4(s);
					pcall(function()
						q:Disconnect();
					end);
				end;
			end);
	end;
end;
if D.Character then
	u4(D.Character);
end;
J(D.CharacterAdded:Connect(function(q)
	task.wait(.5);
	u4(q);
end));
local k4 = {};
local y4 = {};
local function p4()
	for q, s in pairs(k4) do
		pcall(function()
			if s.hl then
				s.hl:Destroy();
			end;
		end);
		pcall(function()
			if s.nameBill then
				s.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if s.hpBar then
				s.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if s.distBill then
				s.distBill:Destroy();
			end;
		end);
		pcall(function()
			if s.toolBill then
				s.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if s.tracer then
				s.tracer:Destroy();
			end;
		end);
		pcall(function()
			if s.box then
				s.box:Destroy();
			end;
		end);
		if s.skeleton then
			for q, s in ipairs(s.skeleton) do
				pcall(function()
					s:Destroy();
				end);
			end;
		end;
	end;
	table.clear(k4);
end;
local function R4()
	for q, s in pairs(y4) do
		pcall(function()
			if s.hl then
				s.hl:Destroy();
			end;
		end);
		pcall(function()
			if s.nameBill then
				s.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if s.hpBar then
				s.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if s.distBill then
				s.distBill:Destroy();
			end;
		end);
		pcall(function()
			if s.toolBill then
				s.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if s.tracer then
				s.tracer:Destroy();
			end;
		end);
		pcall(function()
			if s.box then
				s.box:Destroy();
			end;
		end);
		if s.skeleton then
			for q, s in ipairs(s.skeleton) do
				pcall(function()
					s:Destroy();
				end);
			end;
		end;
	end;
	table.clear(y4);
end;
local function g4(q, s)
	if not q or not s then
		return false;
	end;
	if s:GetAttribute("IsGuard") == true then
		return true;
	end;
	if q:FindFirstChild("GuardPlayerOutift") then
		return true;
	end;
	if q:FindFirstChild("G3SG1") then
		return true;
	end;
	return false;
end;
local function E4(q)
	local s = q and q:FindFirstChild("HumanoidRootPart");
	if not s then
		return 5.5;
	end;
	local Y, O = math.huge, -math.huge;
	for q, s in ipairs(q:GetDescendants()) do
		if s:IsA("BasePart") then
			local q = s.Position.Y;
			if q < Y then
				Y = q;
			end;
			if q > O then
				O = q;
			end;
		end;
	end;
	if Y == math.huge then
		return 5.5;
	end;
	local a = O - Y;
	if a < 3 then
		a = 3;
	end;
	if a > 10 then
		a = 10;
	end;
	return a;
end;
local function e4(q)
	if q > .6 then
		return Color3.fromRGB(74, 222, 74);
	elseif q > .3 then
		return Color3.fromRGB(255, 210, 60);
	else
		return Color3.fromRGB(255, 55, 55);
	end;
end;
local function w4(q, s, Y, O, a, T)
	local S = q:GetAttribute("IsGuard") and k() or y();
	local M = S:Lerp(Color3.new(0, 0, 0), .35);
	local G = E4(s);
	Wk();
	Fk();
	local f = Instance.new("Highlight");
	f.Name = "_XD_HL";
	f.FillTransparency = .4;
	f.OutlineTransparency = 0;
	f.FillColor = S;
	f.OutlineColor = M;
	f.Adornee = s;
	f.Parent = s;
	local W = Instance.new("BillboardGui");
	W.Name = "_XD_NAME";
	W.Size = UDim2.fromOffset(360, 26);
	W.StudsOffset = Vector3.new(0, G * .5 + .6, 0);
	W.AlwaysOnTop = true;
	W.LightInfluence = 0;
	W.Adornee = Y;
	W.Parent = s;
	local F = Instance.new("Frame");
	F.BackgroundTransparency = 1;
	F.Size = UDim2.fromOffset(0, 24);
	F.AutomaticSize = Enum.AutomaticSize.X;
	F.AnchorPoint = Vector2.new(.5, .5);
	F.Position = UDim2.fromScale(.5, .5);
	F.Parent = W;
	local D = Instance.new("UIListLayout");
	D.FillDirection = Enum.FillDirection.Horizontal;
	D.SortOrder = Enum.SortOrder.LayoutOrder;
	D.VerticalAlignment = Enum.VerticalAlignment.Center;
	D.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	D.Padding = UDim.new(0, 6);
	D.Parent = F;
	local h = Instance.new("Frame");
	h.LayoutOrder = 1;
	h.Size = UDim2.fromOffset(42, 20);
	h.BackgroundColor3 = Color3.fromRGB(74, 222, 74);
	h.BorderSizePixel = 0;
	h.Parent = F;
	Mk(h, 5);
	local K = Instance.new("UIStroke");
	K.Thickness = 1.5;
	K.Transparency = 0;
	K.Color = Color3.new(0, 0, 0);
	K.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	K.Parent = h;
	local C = Instance.new("TextLabel");
	C.Size = UDim2.fromScale(1, 1);
	C.BackgroundTransparency = 1;
	C.Font = Enum.Font.GothamBlack;
	C.TextSize = 13;
	C.TextColor3 = Color3.fromRGB(255, 255, 255);
	C.TextStrokeTransparency = 0;
	C.TextStrokeColor3 = Color3.new(0, 0, 0);
	C.Text = "[100]";
	C.Parent = h;
	local b = Instance.new("TextLabel");
	b.LayoutOrder = 2;
	b.BackgroundTransparency = 1;
	b.AutomaticSize = Enum.AutomaticSize.X;
	b.Size = UDim2.fromOffset(0, 24);
	b.Font = B();
	b.TextSize = a or 17;
	b.TextColor3 = Color3.fromRGB(255, 255, 255);
	b.TextStrokeTransparency = 0;
	b.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	b.Text = q.Name;
	b.Parent = F;
	local c = Instance.new("BillboardGui");
	c.Size = UDim2.fromOffset(220, 20);
	c.StudsOffset = Vector3.new(0, -G * .5 - 1.2, 0);
	c.AlwaysOnTop = true;
	c.LightInfluence = 0;
	c.Adornee = Y;
	c.Parent = s;
	local v = Instance.new("TextLabel");
	v.Size = UDim2.new(1, 0, 1, 0);
	v.BackgroundTransparency = 1;
	v.TextColor3 = S;
	v.TextStrokeTransparency = 0;
	v.TextStrokeColor3 = Color3.new(0, 0, 0);
	v.Font = B();
	v.TextSize = 13;
	v.Text = "";
	v.Parent = c;
	local H = Instance.new("BillboardGui");
	H.Size = UDim2.fromOffset(8, G * 24);
	H.StudsOffset = Vector3.new(-2.5, 0, 0);
	H.AlwaysOnTop = true;
	H.LightInfluence = 0;
	H.Adornee = Y;
	H.Parent = s;
	local A = Instance.new("Frame");
	A.Size = UDim2.fromScale(1, 1);
	A.AnchorPoint = Vector2.new(.5, .5);
	A.Position = UDim2.fromScale(.5, .5);
	A.BackgroundColor3 = Color3.fromRGB(25, 8, 8);
	A.BackgroundTransparency = .2;
	A.BorderSizePixel = 0;
	A.Parent = H;
	local j = Mk(A, 3);
	fk(A, Color3.new(0, 0, 0), 1, .3);
	local J = Instance.new("Frame");
	J.Size = UDim2.fromScale(1, 1);
	J.BackgroundColor3 = Color3.new(1, 1, 1);
	J.BorderSizePixel = 0;
	J.AnchorPoint = Vector2.new(0, 1);
	J.Position = UDim2.fromScale(0, 1);
	J.Parent = A;
	local L = Mk(J, 3);
	local U = Instance.new("UIGradient");
	U.Color = T or d(80, 255, 80, 180, 255, 60, 255, 200, 40, 255, 120, 60, 255, 40, 40);
	U.Rotation = 90;
	U.Parent = J;
	local P = Instance.new("BillboardGui");
	P.Size = UDim2.fromOffset(160, 18);
	P.StudsOffset = Vector3.new(2.8, 0, 0);
	P.AlwaysOnTop = true;
	P.LightInfluence = 0;
	P.Adornee = Y;
	P.Parent = s;
	local z = Instance.new("TextLabel");
	z.Size = UDim2.new(1, 0, 1, 0);
	z.BackgroundTransparency = 1;
	z.TextColor3 = S;
	z.TextStrokeTransparency = 0;
	z.TextStrokeColor3 = Color3.new(0, 0, 0);
	z.Font = Enum.Font.Code;
	z.TextSize = 13;
	z.Text = "";
	z.TextXAlignment = Enum.TextXAlignment.Left;
	z.Parent = P;
	local V = Instance.new("Frame");
	V.AnchorPoint = Vector2.new(.5, .5);
	V.BorderSizePixel = 0;
	V.ZIndex = 5;
	V.Visible = false;
	V.BackgroundColor3 = S;
	V.Parent = o.tracerGui;
	local Q = Instance.new("Frame");
	Q.BackgroundTransparency = 1;
	Q.BorderSizePixel = 0;
	Q.Visible = false;
	Q.ZIndex = 4;
	Q.Parent = o.overlayGui;
	local X = Instance.new("UIStroke");
	X.Thickness = 2;
	X.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	X.Parent = Q;
	local r = false;
	do
		local q = s:FindFirstChildOfClass("Humanoid");
		if q then
			r = q.RigType == Enum.HumanoidRigType.R15;
		else
			r = s:FindFirstChild("UpperTorso") ~= nil;
		end;
	end;
	local u = r and hk or Dk;
	local p = {};
	for q = 1, #u, 1 do
		local s = Instance.new("Frame");
		s.AnchorPoint = Vector2.new(0, .5);
		s.BorderSizePixel = 0;
		s.Visible = false;
		s.ZIndex = 4;
		s.Parent = o.overlayGui;
		p[q] = s;
	end;
	return {
		hl = f,
		nameBill = W,
		hpChip = h,
		hpChipStroke = K,
		hpLbl = C,
		nameL = b,
		toolBill = c,
		toolL = v,
		hpBar = H,
		hpBg = A,
		hpFill = J,
		hpGradient = U,
		hpBgCorner = j,
		hpFillCorner = L,
		distBill = P,
		distL = z,
		tracer = V,
		box = Q,
		boxStroke = X,
		skeleton = p,
		skeletonConns = u,
		char = s,
		color = S,
		charHeight = G,
	};
end;
local function N4(q)
	if not q then
		return;
	end;
	pcall(function()
		if q.hl then
			q.hl:Destroy();
		end;
	end);
	pcall(function()
		if q.nameBill then
			q.nameBill:Destroy();
		end;
	end);
	pcall(function()
		if q.hpBar then
			q.hpBar:Destroy();
		end;
	end);
	pcall(function()
		if q.distBill then
			q.distBill:Destroy();
		end;
	end);
	pcall(function()
		if q.toolBill then
			q.toolBill:Destroy();
		end;
	end);
	pcall(function()
		if q.tracer then
			q.tracer:Destroy();
		end;
	end);
	pcall(function()
		if q.box then
			q.box:Destroy();
		end;
	end);
	if q.skeleton then
		for q, s in ipairs(q.skeleton) do
			pcall(function()
				s:Destroy();
			end);
		end;
	end;
end;
local function m4(s, Y, O, a)
	if not s then
		return;
	end;
	local T = Y:Lerp(Color3.new(0, 0, 0), .35);
	s.color = Y;
	pcall(function()
		s.hl.FillColor = Y;
		s.hl.OutlineColor = T;
	end);
	if s.nameL then
		pcall(function()
			local Y = O or 17;
			s.nameL.TextSize = Y;
			s.nameL.Font = B();
			local a = s.char and s.char.Name or "";
			local T = q:GetPlayerFromCharacter(s.char);
			if T then
				a = T.Name;
			end;
			s.nameL.Text = a;
			if s.hpChip and s.hpLbl then
				local q = Y / 17;
				s.hpChip.Size = UDim2.fromOffset(math.max(24, math.floor(42 * q + .5)), math.max(12, math.floor(20 * q + .5)));
				s.hpLbl.TextSize = math.max(8, math.floor(13 * q + .5));
			end;
		end);
	end;
	if s.distL then
		pcall(function()
			s.distL.TextColor3 = Y;
		end);
	end;
	if s.toolL then
		pcall(function()
			s.toolL.TextColor3 = Y;
			s.toolL.Font = B();
		end);
	end;
	if s.hpBg then
		local q = s.hpBg:FindFirstChildOfClass("UIStroke");
		if q then
			pcall(function()
				q.Color = Y:Lerp(Color3.new(0, 0, 0), .4);
			end);
		end;
	end;
	if s.hpGradient and a then
		pcall(function()
			s.hpGradient.Color = a;
		end);
	end;
end;
local function x4()
	if o.unloaded then
		return;
	end;
	_G.__adEspDone = 0;
	_G.__adEspTotal = 0;
	local s = c.GuardESP;
	local Y = c.PlayerESP;
	if not ((s or Y)) then
		if next(k4) then
			p4();
		end;
		if next(y4) then
			R4();
		end;
		return;
	end;
	local O = D.Character and D.Character:FindFirstChild("HumanoidRootPart");
	for q, a in ipairs(q:GetPlayers()) do
		if a ~= D then
			_G.__adEspTotal = _G.__adEspTotal + 1;
			pcall(function()
				local q = a.Character;
				local T = q and q:FindFirstChildOfClass("Humanoid");
				local S = q and q:FindFirstChild("HumanoidRootPart");
				local M = c.GuardESP_ForceAll or g4(q, a);
				local G = s and M;
				local f = Y and not M;
				if T and (S and (T.Health > 0 and ((G or f)))) then
					local s = G and ((c.GuardESP_MaxDist or 0)) or (c.PlayerESP_MaxDist or 0);
					local Y = O and O.Position or Vector3.zero;
					local M = ((Y - S.Position)).Magnitude;
					if s > 0 and M > s then
						if k4[a] then
							N4(k4[a]);
							k4[a] = nil;
						end;
						if y4[a] then
							N4(y4[a]);
							y4[a] = nil;
						end;
						return;
					end;
					_G.__adEspDone = _G.__adEspDone + 1;
					local W = G and k() or y();
					local F = G and ((c.GuardESP_NameSize or 17)) or (c.PlayerESP_NameSize or 17);
					local D = G and N() or m();
					local h = G and k4 or y4;
					local K = G and y4 or k4;
					if K[a] then
						N4(K[a]);
						K[a] = nil;
					end;
					if not h[a] or h[a].char ~= q then
						if h[a] then
							N4(h[a]);
							h[a] = nil;
						end;
						h[a] = w4(a, q, S, T, F, D);
					else
						m4(h[a], W, F, D);
					end;
					local o = h[a];
					if o then
						local s = G and c.GuardESP_HP or (f and c.PlayerESP_HP);
						local Y = G and c.GuardESP_Name or (f and c.PlayerESP_Name);
						local a = G and c.GuardESP_Tool or (f and c.PlayerESP_Tool);
						local W = G and c.GuardESP_Distance or (f and c.PlayerESP_Distance);
						local F = G and c.GuardESP_Highlight or (f and c.PlayerESP_Highlight);
						local D = G and c.GuardESP_Tracer or (f and c.PlayerESP_Tracer);
						local h = G and c.GuardESP_Box or (f and c.PlayerESP_Box);
						local K = G and c.GuardESP_Skeleton or (f and c.PlayerESP_Skeleton);
						o.showHPBar = s;
						o.showTracer = D;
						o.showBox = h;
						o.showSkel = K;
						o.boxColor = G and g() or E();
						o.skelColor = G and e() or w();
						o.boxThick = G and ((c.GuardESP_BoxThickness or 2)) or (c.PlayerESP_BoxThickness or 2);
						o.skelThick = G and ((c.GuardESP_SkeletonThickness or 1.5)) or (c.PlayerESP_SkeletonThickness or 1.5);
						o.hpBarThickness = G and ((c.GuardESP_HPBarThickness or 8)) or (c.PlayerESP_HPBarThickness or 8);
						o.hpBarLength = G and ((c.GuardESP_HPBarLength or 1.5)) or (c.PlayerESP_HPBarLength or 1.5);
						o.hpBarRoundness = G and ((c.GuardESP_HPBarRoundness or 3)) or (c.PlayerESP_HPBarRoundness or 3);
						o.tracerColor = G and p() or R();
						o.nameBill.Enabled = Y and true or false;
						o.toolBill.Enabled = a and true or false;
						if o.hl then
							o.hl.Enabled = F and true or false;
						end;
						if a then
							local s = Lk(q);
							if s == "" then
								s = "- none -";
							end;
							if o.toolL.Text ~= s then
								o.toolL.Text = s;
							end;
						end;
						local C = math.clamp(T.Health / math.max(T.MaxHealth, 1), 0, 1);
						o.hpFill.Size = UDim2.fromScale(1, C);
						if o.hpLbl then
							o.hpLbl.Text = "[" .. (tostring(math.floor(T.Health + .5)) .. "]");
						end;
						if o.hpChip then
							local q = G and A(C) or j(C);
							o.hpChip.BackgroundColor3 = q;
						end;
						if o.hpChipStroke then
							local q = G and c.GuardESP_HP_Outline or (f and c.PlayerESP_HP_Outline);
							o.hpChipStroke.Enabled = q and true or false;
						end;
						if o.distBill then
							if W and (O and S) then
								o.distBill.Enabled = true;
								o.distL.Text = string.format("[%d studs]", math.floor(M + .5));
							else
								o.distBill.Enabled = false;
							end;
						end;
						if o.tracer then
							o.tracer.BackgroundColor3 = o.tracerColor;
						end;
					end;
				else
					if k4[a] then
						N4(k4[a]);
						k4[a] = nil;
					end;
					if y4[a] then
						N4(y4[a]);
						y4[a] = nil;
					end;
				end;
			end);
		end;
	end;
end;
task.spawn(function()
	while o.running and not o.unloaded do
		pcall(function()
			if c.GuardESP or c.PlayerESP then
				local q = s.CurrentCamera;
				if q then
					local s = math.rad(q.FieldOfView);
					local Y = q.ViewportSize;
					local O = Y.Y;
					local a = q.CFrame.Position;
					local T = Y.X / 2;
					local S = Y.Y / 2;
					local M = math.tan(s / 2);
					if M > .01 then
						local function s(s)
							if not s then
								return;
							end;
							local G = s.char and s.char:FindFirstChild("HumanoidRootPart");
							if s.hpBar then
								if s.showHPBar and G then
									local q = ((a - G.Position)).Magnitude;
									if q < 1 then
										q = 1;
									end;
									local Y = O / (((2 * q) * M));
									local T = s.hpBarThickness or 8;
									local S = s.hpBarLength or 1.5;
									local f = (((s.charHeight or 5.5)) * Y) * S;
									if f > 3500 then
										f = 3500;
									end;
									if f < 20 then
										f = 20;
									end;
									s.hpBar.Enabled = true;
									s.hpBar.Size = UDim2.fromOffset(T, f);
									local W = s.hpBarRoundness or 3;
									pcall(function()
										if s.hpBgCorner then
											s.hpBgCorner.CornerRadius = UDim.new(0, W);
										end;
										if s.hpFillCorner then
											s.hpFillCorner.CornerRadius = UDim.new(0, W);
										end;
									end);
								else
									s.hpBar.Enabled = false;
								end;
							end;
							if s.tracer then
								if not s.showTracer or not G then
									if s.tracer.Visible then
										s.tracer.Visible = false;
									end;
								else
									local O, a = q:WorldToViewportPoint(G.Position);
									local M = O.X - T;
									local f = O.Y - S;
									local W = (O.Z < 0);
									if W then
										M = -M;
										f = -f;
									end;
									local F = math.sqrt(M * M + f * f);
									local D, h;
									if F < .001 then
										D, h = 0, 1;
									else
										D = M / F;
										h = f / F;
									end;
									local K = math.huge;
									if D > .0001 then
										K = math.min(K, ((Y.X - T)) / D);
									end;
									if D < -0.0001 then
										K = math.min(K, -T / D);
									end;
									if h > .0001 then
										K = math.min(K, ((Y.Y - S)) / h);
									end;
									if h < -0.0001 then
										K = math.min(K, -S / h);
									end;
									if K == math.huge or K < 1 then
										K = 1;
									end;
									local o, C;
									if a and not W then
										o = O.X;
										C = O.Y;
									else
										o = T + D * K;
										C = S + h * K;
									end;
									local b = o - T;
									local d = C - S;
									local c = math.sqrt(b * b + d * d);
									if c < 1 then
										c = 1;
									end;
									local v = math.deg(math.atan2(d, b));
									s.tracer.Visible = true;
									s.tracer.Position = UDim2.fromOffset(((T + o)) / 2, ((S + C)) / 2);
									s.tracer.Size = UDim2.fromOffset(c, 1.5);
									s.tracer.Rotation = v;
								end;
							end;
							if s.box and s.boxStroke then
								if not s.showBox then
									if s.box.Visible then
										s.box.Visible = false;
									end;
								else
									local Y = s.char;
									if Y and Y.Parent then
										local O, a, T, S = Ck(Y, q);
										if O then
											s.box.Visible = true;
											s.box.Position = UDim2.fromOffset(O - 4, a - 4);
											s.box.Size = UDim2.fromOffset((T - O) + 8, (S - a) + 8);
											s.boxStroke.Color = s.boxColor or Color3.new(1, 1, 1);
											s.boxStroke.Thickness = s.boxThick or 2;
										elseif s.box.Visible then
											s.box.Visible = false;
										end;
									elseif s.box.Visible then
										s.box.Visible = false;
									end;
								end;
							end;
							if s.skeleton and s.skeletonConns then
								if not s.showSkel then
									for q = 1, #s.skeleton, 1 do
										local Y = s.skeleton[q];
										if Y.Visible then
											Y.Visible = false;
										end;
									end;
								else
									local Y = s.char;
									if Y and Y.Parent then
										for O, a in ipairs(s.skeletonConns) do
											local T = s.skeleton[O];
											if T then
												local O = ok(Y, a[1]);
												local S = ok(Y, a[2]);
												if O and (S and ((O.Position - S.Position)).Magnitude > .3) then
													local Y, a = q:WorldToViewportPoint(O.Position);
													local M, G = q:WorldToViewportPoint(S.Position);
													if a and G then
														local q = M.X - Y.X;
														local O = M.Y - Y.Y;
														local a = math.sqrt(q * q + O * O);
														local S = math.deg(math.atan2(O, q));
														T.Visible = true;
														T.Position = UDim2.fromOffset(Y.X, Y.Y);
														T.Size = UDim2.fromOffset(a, s.skelThick or 1.5);
														T.Rotation = S;
														T.BackgroundColor3 = s.skelColor or Color3.new(1, 1, 1);
													elseif T.Visible then
														T.Visible = false;
													end;
												elseif T.Visible then
													T.Visible = false;
												end;
											end;
										end;
									else
										for q = 1, #s.skeleton, 1 do
											local Y = s.skeleton[q];
											if Y.Visible then
												Y.Visible = false;
											end;
										end;
									end;
								end;
							end;
						end;
						for q, Y in pairs(k4) do
							s(Y);
						end;
						for q, Y in pairs(y4) do
							s(Y);
						end;
					end;
				end;
			end;
		end);
		a.RenderStepped:Wait();
	end;
end);
local function I4(q)
	o.oneClickDalgona = q and true or false;
	if o.dalgonaConn then
		pcall(function()
			o.dalgonaConn:Disconnect();
		end);
		o.dalgonaConn = nil;
	end;
	if not o.oneClickDalgona then
		for q, s in pairs(_G.__dalgonaCache) do
			if q and q.Parent then
				pcall(function()
					q.Position = s.Position;
					q.Transparency = s.Transparency;
				end);
			end;
		end;
		table.clear(_G.__dalgonaCache);
		return;
	end;
	table.clear(_G.__dalgonaCache);
	o.dalgonaConn = a.RenderStepped:Connect(function()
			if o.unloaded or not o.oneClickDalgona then
				return;
			end;
			pcall(function()
				local q = D:GetMouse();
				if not q or not q.Hit then
					return;
				end;
				local s = workspace:FindFirstChild("Effects");
				local Y = nil;
				if s then
					for q, s in pairs(s:GetChildren()) do
						if s:IsA("Model") and string.match(s.Name, "Outline$") then
							Y = s;
							break;
						end;
					end;
				end;
				if not Y then
					return;
				end;
				local O = q.Hit.Position;
				for q, s in ipairs(Y:GetChildren()) do
					if s:IsA("BasePart") then
						if not _G.__dalgonaCache[s] then
							_G.__dalgonaCache[s] = { Position = s.Position, Transparency = s.Transparency };
						end;
						s.Position = O;
						s.Transparency = 1;
					end;
				end;
			end);
		end);
end;
local function Z4()
	table.clear(o.handCache);
	table.clear(o.legCache);
	table.clear(o.torsoCache);
	local q = D.Character;
	if not q then
		return;
	end;
	local s = {
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
	local Y = {
			LeftUpperLeg = true,
			LeftLowerLeg = true,
			LeftFoot = true,
			["Left Leg"] = true,
			RightUpperLeg = true,
			RightLowerLeg = true,
			RightFoot = true,
			["Right Leg"] = true,
		};
	local O = { Torso = true, UpperTorso = true, LowerTorso = true };
	local a = {
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
	local function T(q)
		if not q or not q:IsA("Accessory") then
			return false;
		end;
		local s = string.lower(q.Name);
		if s:find("glove") or s:find("hand") or s:find("wrist") or s:find("cuff") then
			return true;
		end;
		local Y = q:FindFirstChild("Handle");
		if Y then
			for q, s in ipairs(Y:GetChildren()) do
				if s:IsA("Attachment") and a[string.lower(s.Name)] then
					return true;
				end;
			end;
		end;
		return false;
	end;
	for q, a in ipairs(q:GetDescendants()) do
		if a:IsA("BasePart") then
			if s[a.Name] then
				table.insert(o.handCache, a);
			elseif Y[a.Name] then
				table.insert(o.legCache, a);
			elseif O[a.Name] then
				table.insert(o.torsoCache, a);
			else
				local q = a:FindFirstAncestorOfClass("Accessory");
				if q and T(q) then
					table.insert(o.handCache, a);
				end;
			end;
		end;
	end;
end;
local function n4(q, s)
	for Y = 1, #q, 1 do
		local O = q[Y];
		if O and O.Parent then
			if s then
				if o.origTransparency[O] == nil then
					o.origTransparency[O] = O.Transparency;
				end;
				O.LocalTransparencyModifier = 1;
				O.Transparency = 1;
			else
				O.LocalTransparencyModifier = 0;
				O.Transparency = o.origTransparency[O] or 0;
			end;
		end;
	end;
end;
local function t4(q)
	c.RemoveHands = q and true or false;
	Z4();
	n4(o.handCache, c.RemoveHands);
	return true;
end;
local function l4(q)
	c.RemoveLegs = q and true or false;
	Z4();
	n4(o.legCache, c.RemoveLegs);
	return true;
end;
local function i4(q)
	c.RemoveTorso = q and true or false;
	Z4();
	n4(o.torsoCache, c.RemoveTorso);
	return true;
end;
local function q9()
	if o.handsConn then
		return;
	end;
	o.handsConn = a.Heartbeat:Connect(function()
			if o.unloaded then
				return;
			end;
			if c.RemoveHands then
				n4(o.handCache, true);
			end;
			if c.RemoveLegs then
				n4(o.legCache, true);
			end;
			if c.RemoveTorso then
				n4(o.torsoCache, true);
			end;
		end);
	table.insert(o.conns, o.handsConn);
end;
local function s9(q)
	local s = D.Character;
	if not s then
		return false;
	end;
	local Y = s:FindFirstChild("Head");
	if not Y then
		return false;
	end;
	if q == false then
		Y.LocalTransparencyModifier = 0;
		Y.Transparency = 0;
		for q, s in ipairs(Y:GetChildren()) do
			if s:IsA("Decal") then
				s.Transparency = 0;
			end;
		end;
		return true;
	end;
	for q, s in ipairs(Y:GetChildren()) do
		if s:IsA("Decal") then
			s.Transparency = 1;
		end;
	end;
	Y.LocalTransparencyModifier = 1;
	Y.Transparency = 1;
	return true;
end;
local Y9 = "rbxassetid://959831634";
local O9 = {
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot",
		"Left Leg",
	};
local function a9(q)
	local s = D.Character;
	if not s then
		return false;
	end;
	if q then
		for q, Y in ipairs(O9) do
			local O = s:FindFirstChild(Y);
			if O and (O:IsA("BasePart") and not o.korbloxData[O]) then
				local q = O.Transparency;
				local Y = O.LocalTransparencyModifier;
				O.LocalTransparencyModifier = 1;
				O.Transparency = 1;
				local a = Instance.new("Part");
				a.Name = "KorbloxDeco";
				a.Size = O.Size;
				a.CFrame = O.CFrame;
				a.Color = Color3.fromRGB(0, 0, 0);
				a.Material = Enum.Material.Plastic;
				a.CanCollide = false;
				a.CanQuery = false;
				a.CanTouch = false;
				a.CastShadow = false;
				a.Massless = true;
				a.Anchored = false;
				local T = Instance.new("SpecialMesh");
				T.MeshType = Enum.MeshType.FileMesh;
				T.MeshId = Y9;
				T.Scale = Vector3.new(1, 1, 1);
				T.Parent = a;
				a.Parent = s;
				local S = Instance.new("WeldConstraint");
				S.Part0 = O;
				S.Part1 = a;
				S.Parent = a;
				a.CFrame = O.CFrame;
				o.korbloxData[O] = { deco = a, origTrans = q, origLTM = Y };
			end;
		end;
	else
		for q, s in pairs(o.korbloxData) do
			if q and q.Parent then
				q.LocalTransparencyModifier = s.origLTM;
				q.Transparency = s.origTrans;
			end;
			if s.deco and s.deco.Parent then
				s.deco:Destroy();
			end;
		end;
		table.clear(o.korbloxData);
	end;
	return true;
end;
local function T9()
	for q, s in ipairs(o.hideConns) do
		pcall(function()
			s:Disconnect();
		end);
	end;
	table.clear(o.hideConns);
end;
local function S9()
	T9();
	if o.unloaded then
		return;
	end;
	local function s(q)
		if not q then
			return false;
		end;
		if not ((q:IsA("BillboardGui") or q:IsA("SurfaceGui"))) then
			return false;
		end;
		local s = string.lower(tostring(q.Name));
		if s:find("nick") or s:find("name") or s:find("tag") or s:find("title") or s:find("label") then
			return true;
		end;
		local Y = q.Parent;
		if Y and Y.Name == "Head" then
			return true;
		end;
		return false;
	end;
	local function Y(q)
		if not q or not q.Parent then
			return;
		end;
		pcall(function()
			q.Enabled = false;
		end);
		pcall(function()
			q.Visible = false;
		end);
		if not q:GetAttribute("_XD_nickHooked") then
			q:SetAttribute("_XD_nickHooked", true);
			table.insert(o.hideConns, (q:GetPropertyChangedSignal("Enabled")):Connect(function()
				if q.Enabled then
					pcall(function()
						q.Enabled = false;
					end);
				end;
			end));
			table.insert(o.hideConns, (q:GetPropertyChangedSignal("Visible")):Connect(function()
				if q.Visible then
					pcall(function()
						q.Visible = false;
					end);
				end;
			end));
		end;
	end;
	local function O(q)
		if not q then
			return;
		end;
		for q, O in ipairs(q:GetDescendants()) do
			if s(O) then
				Y(O);
			end;
		end;
	end;
	local function T(q)
		if not q then
			return;
		end;
		O(q);
		table.insert(o.hideConns, q.DescendantAdded:Connect(function(q)
			if s(q) then
				task.defer(function()
					Y(q);
				end);
			end;
		end));
	end;
	if D.Character then
		T(D.Character);
	end;
	table.insert(o.hideConns, D.CharacterAdded:Connect(function(q)
		task.wait(.3);
		T(q);
	end));
	table.insert(o.hideConns, q.PlayerAdded:Connect(function(q)
		q.CharacterAdded:Connect(function(q)
			if o.unloaded then
				return;
			end;
			task.wait(.3);
			T(q);
		end);
	end));
	for q, s in ipairs(q:GetPlayers()) do
		if s ~= D and s.Character then
			T(s.Character);
			table.insert(o.hideConns, s.CharacterAdded:Connect(function(q)
				if o.unloaded then
					return;
				end;
				task.wait(.3);
				T(q);
			end));
		end;
	end;
	if o._nickLoop then
		pcall(function()
			task.cancel(o._nickLoop);
		end);
	end;
	o._nickLoop = task.spawn(function()
			while not o.unloaded and c.HideNick do
				pcall(function()
					if D.Character then
						O(D.Character);
					end;
					for q, s in ipairs(q:GetPlayers()) do
						if s ~= D and s.Character then
							O(s.Character);
						end;
					end;
				end);
				a.RenderStepped:Wait();
			end;
		end);
end;
local M9 = "InkInstinct";
local function G9()
	if o.FILE.isfolder and o.FILE.makefolder then
		local q, s = pcall(o.FILE.isfolder, M9);
		if not q or not s then
			pcall(o.FILE.makefolder, M9);
		end;
	end;
end;
local function f9(q)
	return M9  .. ("/" .. (tostring(q) .. ".json"));
end;
local function W9(q)
	local s = {};
	for q, Y in pairs(q) do
		if typeof(Y) == "Color3" then
			s[q] = { Y.R, Y.G, Y.B };
		elseif typeof(Y) == "EnumItem" then
			s[q] = Y.Name;
		else
			s[q] = Y;
		end;
	end;
	return s;
end;
local function F9(q, s)
	if type(s) ~= "table" then
		return;
	end;
	for s, Y in pairs(s) do
		if s == "MenuKey" and type(Y) == "string" then
			local O, a = pcall(function()
					return Enum.KeyCode[Y];
				end);
			if O and a then
				q[s] = a;
			end;
		elseif q[s] ~= nil and type(Y) == type(q[s]) then
			q[s] = Y;
		end;
	end;
end;
local function D9(q)
	if q.C or q.H or q.anim then
		F9(c, q.C or q.ui);
		F9(v, q.H or q.hns);
		if type(q.anim) == "table" then
			for q, s in pairs(q.anim) do
				if Bk[tostring(q)] ~= nil and not Ak[tostring(q)] then
					o.animEnabled[tostring(q)] = s and true or false;
				end;
			end;
		end;
	else
		F9(c, q);
	end;
	d4();
	tk();
	Tk();
	x4();
	F4();
	dk();
end;
local function h9(q)
	q = q or o.currentConfigName;
	if not o.FILE.writefile then
		return false, "no writefile";
	end;
	G9();
	local s = (tostring(q)):gsub("[^%w%-%_]", "");
	if s == "" then
		s = "default";
	end;
	o.currentConfigName = s;
	local Y = { C = W9(c), H = W9(v), anim = o.animEnabled };
	local O = pcall(function()
			o.FILE.writefile(f9(s), T:JSONEncode(Y));
		end);
	if not O then
		return false, "writefile failed";
	end;
	return true, "ok";
end;
local function K9(q)
	q = q or o.currentConfigName;
	if not o.FILE.readfile or not o.FILE.isfile then
		return false, "no readfile";
	end;
	local s = f9(q);
	local Y, O = pcall(o.FILE.isfile, s);
	if not Y or not O then
		return false, "not found";
	end;
	local a, S = pcall(o.FILE.readfile, s);
	if not a or not S then
		return false, "read failed";
	end;
	local M, G = pcall(function()
			return T:JSONDecode(S);
		end);
	if not M or type(G) ~= "table" then
		return false, "bad json";
	end;
	D9(G);
	o.currentConfigName = (tostring(q)):gsub("[^%w%-%_]", "");
	return true, "ok";
end;
local function o9()
	local q = {};
	if not o.FILE.listfiles or not o.FILE.isfolder then
		return q;
	end;
	local s, Y = pcall(o.FILE.isfolder, M9);
	if not s or not Y then
		return q;
	end;
	local O, a = pcall(o.FILE.listfiles, M9);
	if not O or type(a) ~= "table" then
		return q;
	end;
	for s, Y in ipairs(a) do
		local O = (tostring(Y)):match("([^/\\]+)%.json$");
		if O and O ~= "" then
			table.insert(q, O);
		end;
	end;
	table.sort(q);
	return q;
end;
local function C9(q)
	if not o.FILE.delfile then
		return false, "no delfile";
	end;
	local s = pcall(o.FILE.delfile, f9(q));
	return s;
end;
o.ui = {};
o.ui.PANEL_W = 400;
o.ui.PANEL_H = 660;
o.ui.CONTENT_W = o.ui.PANEL_W - 16;
o.ui.CONTENT_H = o.ui.PANEL_H - 90;
o.ui.BTN_W = o.ui.CONTENT_W - 8;
o.ui.COL = {
		bg = Color3.fromRGB(11, 9, 18),
		bg2 = Color3.fromRGB(22, 15, 36),
		card = Color3.fromRGB(26, 20, 40),
		text = Color3.fromRGB(235, 225, 250),
		textDim = Color3.fromRGB(150, 135, 175),
		off = Color3.fromRGB(22, 17, 34),
	};
o.ui.tabFrames = {};
o.ui.activeTab = "Main";
o.ui.pickerOverlay = nil;
function o.ui.mkDivider(q, s, Y)
	local O = Instance.new("Frame");
	O.Size = UDim2.new(1, -8, 0, 18);
	O.Position = UDim2.fromOffset(4, s);
	O.BackgroundTransparency = 1;
	O.ZIndex = 5;
	O.Parent = q;
	local a = Instance.new("TextLabel");
	a.Size = UDim2.fromOffset(180, 18);
	a.BackgroundTransparency = 1;
	a.Font = Enum.Font.GothamBold;
	a.TextSize = 9;
	a.Text = string.upper(Y or "");
	a.TextColor3 = L();
	a.TextXAlignment = Enum.TextXAlignment.Left;
	a.ZIndex = 6;
	a.Parent = O;
	ak(function()
		a.TextColor3 = L();
	end);
	local T = Instance.new("Frame");
	T.Size = UDim2.new(1, -190, 0, 1);
	T.Position = UDim2.fromOffset(190, 9);
	T.BackgroundColor3 = L();
	T.BackgroundTransparency = .72;
	T.BorderSizePixel = 0;
	T.ZIndex = 6;
	T.Parent = O;
	ak(function()
		T.BackgroundColor3 = L();
	end);
end;
function o.ui.makeToggle(q, s, Y, O, a, T, M)
	local G = o.ui.COL;
	local f = o.ui.BTN_W;
	M = M or c;
	local W = Instance.new("TextButton");
	W.Size = UDim2.fromOffset(f, 26);
	W.Position = UDim2.fromOffset(4, s);
	W.BorderSizePixel = 0;
	W.Font = Enum.Font.Gotham;
	W.TextSize = 12;
	W.TextXAlignment = Enum.TextXAlignment.Left;
	W.TextColor3 = U();
	W.AutoButtonColor = false;
	W.ZIndex = 6;
	W.Parent = q;
	Mk(W, 7);
	local F = Instance.new("Frame");
	F.Size = UDim2.fromOffset(30, 16);
	F.Position = UDim2.new(1, -38, .5, -8);
	F.BorderSizePixel = 0;
	F.ZIndex = 7;
	F.Parent = W;
	Mk(F, 8);
	local D = Instance.new("Frame");
	D.Size = UDim2.fromOffset(12, 12);
	D.Position = UDim2.fromOffset(2, 2);
	D.BackgroundColor3 = Color3.new(1, 1, 1);
	D.BorderSizePixel = 0;
	D.ZIndex = 8;
	D.Parent = F;
	Mk(D, 6);
	local function h()
		if a then
			return a() and true or false;
		end;
		if O then
			return M[O] and true or false;
		end;
		return false;
	end;
	local function K(q)
		local s = h();
		W.Text = "   " .. Y;
		local O = s and P(L()) or G.off;
		local a = s and L() or Color3.fromRGB(60, 50, 78);
		local T = s and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
		if q then
			local q = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			(S:Create(W, q, { BackgroundColor3 = O })):Play();
			(S:Create(F, q, { BackgroundColor3 = a })):Play();
			(S:Create(D, q, { Position = T })):Play();
		else
			W.BackgroundColor3 = O;
			F.BackgroundColor3 = a;
			D.Position = T;
		end;
		W.TextColor3 = U();
	end;
	ak(function()
		local q = h();
		W.BackgroundColor3 = q and P(L()) or G.off;
		W.TextColor3 = U();
		F.BackgroundColor3 = q and L() or Color3.fromRGB(60, 50, 78);
		D.Position = q and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
	end);
	K(false);
	W.MouseButton1Click:Connect(function()
		if o.unloaded then
			return;
		end;
		Sk();
		local q = not h();
		if O then
			M[O] = q;
		end;
		if T then
			T(q);
		else
			if O == "Enabled" then
				tk();
			elseif O == "RadiusVis" then
				d4();
			elseif O == "RemoveLegs" then
				l4(M.RemoveLegs);
				q9();
			elseif O == "RemoveHands" then
				t4(M.RemoveHands);
				q9();
				Z4();
			elseif O == "RemoveTorso" then
				i4(M.RemoveTorso);
				q9();
				Z4();
			elseif O == "Headless" then
				s9(M.Headless);
			elseif O == "Korblox" then
				a9(M.Korblox);
			elseif O == "RebelFOVCircle" then
				F4();
			elseif O == "RebelFOVNeon" or O == "RebelFOVBlackOutline" then
				F4();
			elseif O == "Watermark" or O == "KeybindList" then
				dk();
			elseif O == "GuardESP" or O == "PlayerESP" then
				x4();
			elseif O == "HideNick" then
				S9();
			elseif O == "FullBright" then
				H4(M.FullBright);
			elseif O == "RemoveFog" then
				B4(M.RemoveFog);
			elseif O == "FOVRainbow" then
				if M.FOVRainbow then
					G4();
				else
					T4();
					F4();
				end;
			elseif O == "PanelRainbow" then
				if M.PanelRainbow then
					W4();
				else
					f4();
					if o.panel then
						local q = o.panel:FindFirstChildOfClass("UIStroke");
						if q then
							q.Color = L();
						end;
					end;
				end;
			elseif O == "BulletTracer" then
 
			elseif O == "FOVUseCustom" then
				F4();
				if M.FOVRainbow then
					G4();
				end;
			elseif O == "AutoBrew" then
				if M.AutoBrew then
					L4();
				else
					U4();
				end;
			elseif O == "CircleRainbowText" or O == "CircleRainbowOutline" then
				Tk();
			elseif type(O) == "string" and ((O:sub(1, 9) == "GuardESP_" or O:sub(1, 10) == "PlayerESP_")) then
				x4();
			end;
		end;
		K(true);
		if _G.__adShowNotif then
			_G.__adShowNotif(Y .. (":  " .. ((q and "ON" or "OFF"))), q and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80));
		end;
	end);
	return K;
end;
function o.ui.makeSlider(q, s, O, a, T, S, M, G, f)
	local W = o.ui.COL;
	local F = o.ui.BTN_W;
	G = G or c;
	local D = Instance.new("Frame");
	D.Size = UDim2.fromOffset(F, 40);
	D.Position = UDim2.fromOffset(4, s);
	D.BackgroundTransparency = 1;
	D.ZIndex = 5;
	D.Parent = q;
	local h = Instance.new("TextLabel");
	h.Size = UDim2.fromOffset(F, 14);
	h.BackgroundTransparency = 1;
	h.Font = Enum.Font.Gotham;
	h.TextSize = 11;
	h.TextXAlignment = Enum.TextXAlignment.Left;
	h.TextColor3 = U();
	h.ZIndex = 6;
	h.Parent = D;
	ak(function()
		h.TextColor3 = U();
	end);
	local function K()
		h.Text = O .. ("   " .. tostring(G[a]));
	end;
	K();
	local C = Instance.new("TextButton");
	C.Size = UDim2.fromOffset(F, 14);
	C.Position = UDim2.fromOffset(0, 18);
	C.BackgroundColor3 = W.card;
	C.BorderSizePixel = 0;
	C.Text = "";
	C.AutoButtonColor = false;
	C.ZIndex = 6;
	C.Parent = D;
	Mk(C, 7);
	local b = Instance.new("Frame");
	b.Size = UDim2.new(math.clamp(((((G[a] or T)) - T)) / ((S - T)), 0, 1), 0, 1, 0);
	b.BorderSizePixel = 0;
	b.ZIndex = 7;
	b.Parent = C;
	Mk(b, 7);
	b.BackgroundColor3 = L();
	ak(function()
		b.BackgroundColor3 = L();
	end);
	local d = Instance.new("Frame");
	d.Size = UDim2.fromOffset(12, 12);
	d.BackgroundColor3 = Color3.new(1, 1, 1);
	d.BorderSizePixel = 0;
	d.ZIndex = 8;
	d.Parent = C;
	Mk(d, 6);
	fk(d, Color3.new(0, 0, 0), 1, .5);
	local v = false;
	local function H()
		local q = ((((G[a] or T)) - T)) / ((S - T));
		d.Position = UDim2.new(q, -6, .5, -6);
	end;
	H();
	local function B(q)
		local s = math.clamp(((q - C.AbsolutePosition.X)) / math.max(C.AbsoluteSize.X, 1), 0, 1);
		local Y = T + s * ((S - T));
		Y = math.floor(Y / M + .5) * M;
		if M < 1 then
			Y = math.floor(Y * 100 + .5) / 100;
		end;
		G[a] = math.clamp(Y, T, S);
		b.Size = UDim2.new(((G[a] - T)) / ((S - T)), 0, 1, 0);
		H();
		K();
		if f then
			pcall(f);
		end;
	end;
	C.InputBegan:Connect(function(q)
		if q.UserInputType == Enum.UserInputType.MouseButton1 or q.UserInputType == Enum.UserInputType.Touch then
			v = true;
			B(q.Position.X);
		end;
	end);
	J(Y.InputEnded:Connect(function(q)
		if q.UserInputType == Enum.UserInputType.MouseButton1 or q.UserInputType == Enum.UserInputType.Touch then
			v = false;
		end;
	end));
	J(Y.InputChanged:Connect(function(q)
		if v and ((q.UserInputType == Enum.UserInputType.MouseMovement or q.UserInputType == Enum.UserInputType.Touch)) then
			B(q.Position.X);
		end;
	end));
	return K;
end;
function o.ui.makeBtn(q, s, Y, O)
	local a = o.ui.COL;
	local T = o.ui.BTN_W;
	local S = Instance.new("TextButton");
	S.Size = UDim2.fromOffset(T, 28);
	S.Position = UDim2.fromOffset(4, s);
	S.BackgroundColor3 = a.card;
	S.BorderSizePixel = 0;
	S.Font = Enum.Font.GothamBold;
	S.TextSize = 12;
	S.TextColor3 = U();
	S.Text = Y;
	S.ZIndex = 6;
	S.Parent = q;
	Mk(S, 7);
	ak(function()
		S.TextColor3 = U();
	end);
	local M = fk(S, L(), 1, .55);
	ak(function()
		M.Color = L();
	end);
	S.MouseButton1Click:Connect(function()
		if o.unloaded then
			return;
		end;
		Sk();
		O();
	end);
	return S;
end;
function o.ui.makeInput(q, s, Y)
	local O = o.ui.COL;
	local a = o.ui.BTN_W;
	local T = Instance.new("TextBox");
	T.Size = UDim2.fromOffset(a, 26);
	T.Position = UDim2.fromOffset(4, s);
	T.BackgroundColor3 = O.card;
	T.BorderSizePixel = 0;
	T.Font = Enum.Font.Gotham;
	T.TextSize = 12;
	T.TextColor3 = U();
	T.PlaceholderText = Y;
	T.PlaceholderColor3 = O.textDim;
	T.Text = "";
	T.ClearTextOnFocus = false;
	T.ZIndex = 6;
	T.Parent = q;
	Mk(T, 7);
	ak(function()
		T.TextColor3 = U();
	end);
	local S = fk(T, O.off, 1, .4);
	ak(function()
		S.Color = L();
	end);
	return T;
end;
function o.ui.colorRow(q, s, Y, O, a)
	local T = o.ui.COL;
	local S = o.ui.BTN_W;
	local M = Instance.new("Frame");
	M.Size = UDim2.fromOffset(S, 30);
	M.Position = UDim2.fromOffset(4, s);
	M.BackgroundTransparency = 1;
	M.ZIndex = 5;
	M.Parent = q;
	local G = Instance.new("TextLabel");
	G.Size = UDim2.fromOffset(120, 30);
	G.Position = UDim2.fromOffset(0, 0);
	G.BackgroundTransparency = 1;
	G.Font = Enum.Font.Gotham;
	G.TextSize = 11;
	G.TextXAlignment = Enum.TextXAlignment.Left;
	G.TextColor3 = U();
	G.Text = Y or "";
	G.ZIndex = 6;
	G.Parent = M;
	ak(function()
		G.TextColor3 = U();
	end);
	local f = Instance.new("Frame");
	f.Size = UDim2.fromOffset(28, 28);
	f.Position = UDim2.fromOffset(S - 148, 1);
	f.BorderSizePixel = 0;
	f.BackgroundColor3 = O();
	f.ZIndex = 6;
	f.Parent = M;
	Mk(f, 8);
	local W = fk(f, L(), 1.5, .2);
	ak(function()
		W.Color = L();
	end);
	local F = Instance.new("TextButton");
	F.Size = UDim2.fromOffset(114, 26);
	F.Position = UDim2.fromOffset(S - 116, 2);
	F.BackgroundColor3 = T.card;
	F.BorderSizePixel = 0;
	F.Font = Enum.Font.GothamBold;
	F.TextSize = 11;
	F.TextColor3 = U();
	F.Text = "Change color";
	F.AutoButtonColor = false;
	F.ZIndex = 6;
	F.Parent = M;
	ak(function()
		F.TextColor3 = U();
	end);
	Mk(F, 6);
	local D = fk(F, L(), 1, .5);
	ak(function()
		D.Color = L();
	end);
	F.MouseButton1Click:Connect(function()
		if o.unloaded then
			return;
		end;
		Sk();
		if o.colorPickerOpen then
			o.colorPickerOpen(O(), function(q)
				pcall(a, q);
				f.BackgroundColor3 = q;
			end);
		end;
	end);
	ak(function()
		f.BackgroundColor3 = O();
	end);
end;
function o.ui.buildPanel()
	local q = o.ui.COL;
	local s = o.ui.PANEL_W;
	local O = o.ui.PANEL_H;
	local T = nil;
	if gethui then
		local q, s = pcall(gethui);
		if q and (s and typeof(s) == "Instance") then
			T = s;
		end;
	end;
	if not T or typeof(T) ~= "Instance" then
		T = D:FindFirstChildOfClass("PlayerGui");
	end;
	if not T then
		T = D:WaitForChild("PlayerGui", 5);
	end;
	if not T then
		T = game:GetService("CoreGui");
	end;
	o.gui = Instance.new("ScreenGui");
	o.gui.Name = "XD_x1oni1x_" .. sk(6);
	o.gui.ResetOnSpawn = false;
	o.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	o.gui.DisplayOrder = 100000;
	o.gui.IgnoreGuiInset = true;
	o.gui.Enabled = true;
	pcall(function()
		o.gui.Parent = T;
	end);
	if not o.gui.Parent then
		pcall(function()
			o.gui.Parent = game:GetService("CoreGui");
		end);
	end;
	o.glow = Instance.new("Frame");
	o.glow.Size = UDim2.fromOffset(s + 40, O + 40);
	o.glow.Position = UDim2.new(.5, (-s / 2 - 20) - 800, .5, -O / 2 - 20);
	o.glow.BackgroundColor3 = L();
	o.glow.BackgroundTransparency = .86;
	o.glow.BorderSizePixel = 0;
	o.glow.ZIndex = 0;
	o.glow.Parent = o.gui;
	Mk(o.glow, 22);
	ak(function()
		o.glow.BackgroundColor3 = L();
	end);
	o.shadow = Instance.new("Frame");
	o.shadow.Size = UDim2.fromOffset(s + 12, O + 12);
	o.shadow.Position = UDim2.new(.5, (-s / 2 + 6) - 800, .5, -O / 2 + 6);
	o.shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	o.shadow.BackgroundTransparency = .65;
	o.shadow.BorderSizePixel = 0;
	o.shadow.ZIndex = 1;
	o.shadow.Parent = o.gui;
	Mk(o.shadow, 18);
	o.panel = Instance.new("Frame");
	o.panel.Size = UDim2.fromOffset(s, O);
	o.panel.Position = UDim2.new(.5, -s / 2 - 800, .5, -O / 2);
	o.panel.BackgroundColor3 = q.bg;
	o.panel.BorderSizePixel = 0;
	o.panel.Active = true;
	o.panel.Visible = true;
	o.panel.ZIndex = 2;
	o.panel.Parent = o.gui;
	o.panel.ClipsDescendants = true;
	Mk(o.panel, 14);
	Gk(o.panel, q.bg2, q.bg, 90);
	local M = fk(o.panel, L(), 1.4, .35);
	ak(function()
		if not c.PanelRainbow then
			M.Color = L();
		end;
	end);
	J((o.panel:GetPropertyChangedSignal("Position")):Connect(function()
		o.shadow.Position = UDim2.new(o.panel.Position.X.Scale, o.panel.Position.X.Offset + 6, o.panel.Position.Y.Scale, o.panel.Position.Y.Offset + 6);
		o.glow.Position = UDim2.new(o.panel.Position.X.Scale, o.panel.Position.X.Offset - 20, o.panel.Position.Y.Scale, o.panel.Position.Y.Offset - 20);
	end));
	task.spawn(function()
		task.wait(.05);
		if o.unloaded or not o.panel or not o.panel.Parent then
			return;
		end;
		local q = TweenInfo.new(.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
		(S:Create(o.panel, q, { Position = UDim2.new(.5, -s / 2, .5, -O / 2) })):Play();
		if o.shadow and o.shadow.Parent then
			(S:Create(o.shadow, q, { Position = UDim2.new(.5, -s / 2 + 6, .5, -O / 2 + 6) })):Play();
		end;
		if o.glow and o.glow.Parent then
			(S:Create(o.glow, q, { Position = UDim2.new(.5, -s / 2 - 20, .5, -O / 2 - 20) })):Play();
		end;
	end);
	do
		local q = false;
		local s = nil;
		local O = nil;
		J(o.panel.InputBegan:Connect(function(Y)
			if Y.UserInputType == Enum.UserInputType.MouseButton1 or Y.UserInputType == Enum.UserInputType.Touch then
				q = true;
				s = Y.Position;
				O = o.panel.Position;
				Y.Changed:Connect(function()
					if Y.UserInputState == Enum.UserInputState.End then
						q = false;
					end;
				end);
			end;
		end));
		J(Y.InputChanged:Connect(function(Y)
			if not q then
				return;
			end;
			if Y.UserInputType == Enum.UserInputType.MouseMovement or Y.UserInputType == Enum.UserInputType.Touch then
				local q = Y.Position - s;
				o.panel.Position = UDim2.new(O.X.Scale, O.X.Offset + q.X, O.Y.Scale, O.Y.Offset + q.Y);
			end;
		end));
	end;
	local f = Instance.new("Frame");
	f.Size = UDim2.new(1, -28, 0, 2);
	f.Position = UDim2.fromOffset(14, 0);
	f.BackgroundColor3 = L();
	f.BorderSizePixel = 0;
	f.ZIndex = 3;
	f.Parent = o.panel;
	Mk(f, 2);
	ak(function()
		f.BackgroundColor3 = L();
	end);
	local W = Instance.new("TextLabel");
	W.Size = UDim2.fromOffset(240, 20);
	W.Position = UDim2.fromOffset(14, 12);
	W.BackgroundTransparency = 1;
	W.Font = Enum.Font.GothamBlack;
	W.TextSize = 13;
	W.TextXAlignment = Enum.TextXAlignment.Left;
	W.TextColor3 = L();
	W.Text = h;
	W.ZIndex = 3;
	W.Parent = o.panel;
	ak(function()
		W.TextColor3 = L();
	end);
	local F = Instance.new("TextLabel");
	F.Size = UDim2.fromOffset(140, 40);
	F.Position = UDim2.new(1, -192, 0, 12);
	F.BackgroundTransparency = 1;
	F.Font = Enum.Font.Code;
	F.TextSize = 10;
	F.TextXAlignment = Enum.TextXAlignment.Right;
	F.TextYAlignment = Enum.TextYAlignment.Top;
	F.TextColor3 = q.textDim;
	F.Text = "fps ---\nping ---";
	F.ZIndex = 3;
	F.Parent = o.panel;
	local C = Instance.new("TextLabel");
	C.Size = UDim2.new(1, -20, 0, 12);
	C.Position = UDim2.fromOffset(14, 30);
	C.BackgroundTransparency = 1;
	C.Font = Enum.Font.Gotham;
	C.TextSize = 9;
	C.TextXAlignment = Enum.TextXAlignment.Left;
	C.TextColor3 = U();
	C.Text = "ink game - auto dodge";
	C.ZIndex = 3;
	C.Parent = o.panel;
	ak(function()
		C.TextColor3 = U();
	end);
	local b = Instance.new("TextLabel");
	b.Size = UDim2.new(1, -20, 0, 12);
	b.Position = UDim2.fromOffset(14, 44);
	b.BackgroundTransparency = 1;
	b.Font = Enum.Font.Code;
	b.TextSize = 10;
	b.TextXAlignment = Enum.TextXAlignment.Left;
	b.TextColor3 = U();
	b.Text = "ready - N to close";
	b.ZIndex = 3;
	b.Parent = o.panel;
	ak(function()
		b.TextColor3 = U();
	end);
	local d = Instance.new("TextButton");
	d.AnchorPoint = Vector2.new(1, 0);
	d.Size = UDim2.fromOffset(24, 24);
	d.Position = UDim2.new(1, -12, 0, 12);
	d.BackgroundColor3 = q.card;
	d.BorderSizePixel = 0;
	d.Font = Enum.Font.GothamBlack;
	d.TextSize = 18;
	d.TextColor3 = U();
	d.Text = "-";
	d.AutoButtonColor = false;
	d.ZIndex = 12;
	d.Parent = o.panel;
	ak(function()
		d.TextColor3 = U();
	end);
	Mk(d, 6);
	local H = fk(d, L(), 1.5, 0);
	ak(function()
		H.Color = L();
	end);
	local function B(q)
		if not o.unloaded and (b and b.Parent) then
			b.Text = tostring(q or "");
		end;
	end;
	_G.__ad_statusCb = B;
	local A = 0;
	local j = tick();
	local P = 0;
	J(a.RenderStepped:Connect(function()
		A = A + 1;
		local q = tick();
		if q - j >= 2 then
			P = math.floor(A / ((q - j)));
			A = 0;
			j = q;
		end;
	end));
	task.spawn(function()
		while not o.unloaded do
			local q = 0;
			pcall(function()
				local s = G.Network.ServerStatsItem["Data Ping"];
				if s then
					q = math.floor(s:GetValue());
				end;
			end);
			if not o.unloaded and (F and F.Parent) then
				local s = game.JobId or "";
				if #s > 8 then
					s = s:sub(1, 8);
				end;
				if s == "" then
					s = "studio";
				end;
				F.Text = string.format("fps %d\nping %d - srv %s", P, q, s);
			end;
			if not o.unloaded and (o.wmLabel and c.Watermark) then
				pcall(function()
					local s = tostring(D.Name or "?");
					if #s > 14 then
						s = s:sub(1, 14) .. "...";
					end;
					local Y = (c.MenuKey and c.MenuKey.Name) or "N";
					o.wmLabel.Text = string.format("%s %s\n%s | %dms | [%s]", h, K, s, q, Y);
				end);
			end;
			if not o.unloaded and (o.kbLabel and c.KeybindList) then
				pcall(function()
					local q = {};
					if c.Enabled then
						table.insert(q, "AutoDodge:  ON");
					end;
					if v.Enabled then
						table.insert(q, "HnS Dodge:  ON");
					end;
					if c.RLGL_AutoDodge then
						table.insert(q, "RLGL:  ON");
					end;
					if c.RebelSilentAim then
						table.insert(q, "Silent Aim:  ON");
					end;
					if c.RebelNoRecoil then
						table.insert(q, "No Recoil:  ON");
					end;
					if c.RebelRapidFire then
						table.insert(q, "Rapid Fire:  ON");
					end;
					if c.BulletTracer then
						table.insert(q, "Bullet Tracer:  ON");
					end;
					if c.GuardESP then
						table.insert(q, "Guard ESP:  ON");
					end;
					if c.PlayerESP then
						table.insert(q, "Player ESP:  ON");
					end;
					if c.HideNick then
						table.insert(q, "HideNick:  ON");
					end;
					if c.FullBright then
						table.insert(q, "Full Bright:  ON");
					end;
					if c.RemoveFog then
						table.insert(q, "No Fog:  ON");
					end;
					if c.AutoBrew then
						table.insert(q, "Auto Brew:  ON");
					end;
					if c.AnimSpeed then
						table.insert(q, "Anim 2.5x:  ON");
					end;
					o.kbLabel.Text = (#q == 0) and "[no features]" or table.concat(q, "\n");
					if o.kbFrame then
						local s = math.max(1, #q);
						o.kbFrame.Size = UDim2.fromOffset(210, math.max(30, s * 12 + 8));
					end;
				end);
			end;
			task.wait(3);
		end;
	end);
	local z = Instance.new("Frame");
	z.Size = UDim2.new(1, -16, 0, 26);
	z.Position = UDim2.fromOffset(8, 58);
	z.BackgroundColor3 = q.off;
	z.BackgroundTransparency = .35;
	z.BorderSizePixel = 0;
	z.ZIndex = 3;
	z.Parent = o.panel;
	Mk(z, 8);
	local V = {
			"Main",
			"HnS",
			"Rebel",
			"RLGL",
			"ESP",
			"Dalgona",
			"Extra",
			"Configs",
		};
	local Q = Instance.new("Frame");
	Q.Size = UDim2.fromOffset(o.ui.CONTENT_W, o.ui.CONTENT_H);
	Q.Position = UDim2.fromOffset(8, 88);
	Q.BackgroundTransparency = 1;
	Q.ZIndex = 4;
	Q.Parent = o.panel;
	for q, s in ipairs(V) do
		local Y = Instance.new("ScrollingFrame");
		Y.Size = UDim2.fromOffset(o.ui.CONTENT_W, o.ui.CONTENT_H);
		Y.BackgroundTransparency = 1;
		Y.BorderSizePixel = 0;
		Y.ScrollBarThickness = 3;
		Y.ScrollBarImageColor3 = L();
		Y.ScrollingDirection = Enum.ScrollingDirection.Y;
		Y.CanvasSize = UDim2.fromOffset(0, 5000);
		Y.ElasticBehavior = Enum.ElasticBehavior.Never;
		Y.Visible = s == "Main";
		Y.ZIndex = 5;
		Y.Parent = Q;
		ak(function()
			if Y and Y.Parent then
				Y.ScrollBarImageColor3 = L();
			end;
		end);
		o.ui.tabFrames[s] = Y;
	end;
	o.ui.showTab = function(q)
			o.ui.activeTab = q;
			for s, Y in pairs(o.ui.tabFrames) do
				Y.Visible = s == q;
			end;
			Tk();
			if q == "Configs" and _G.__adRefreshConfigs then
				pcall(_G.__adRefreshConfigs);
			end;
		end;
	do
		local s = #V;
		local Y = math.floor(((o.ui.CONTENT_W - 4)) / s);
		local O = 2;
		for s, a in ipairs(V) do
			local T = Instance.new("TextButton");
			T.Size = UDim2.fromOffset(Y, 22);
			T.Position = UDim2.fromOffset(O, 2);
			T.BorderSizePixel = 0;
			T.Font = Enum.Font.GothamBold;
			T.TextSize = 8;
			T.Text = a;
			T.AutoButtonColor = false;
			T.ZIndex = 4;
			T.Parent = z;
			T.TextTruncate = Enum.TextTruncate.AtEnd;
			T.TextScaled = false;
			Mk(T, 6);
			T.MouseButton1Click:Connect(function()
				Sk();
				o.ui.showTab(a);
			end);
			ak(function()
				local s = o.ui.activeTab == a;
				T.BackgroundColor3 = s and L() or q.off;
				T.BackgroundTransparency = s and 0 or 1;
				T.TextColor3 = s and Color3.new(1, 1, 1) or U();
			end);
			O = O + Y;
		end;
	end;
	Tk();
	o.ui.collapseBtn = d;
	o.ui.buildColorPicker();
end;
function o.ui.buildColorPicker()
	local q = o.ui.COL;
	local s = o.ui.PANEL_W;
	local O = o.ui.PANEL_H;
	local a = Instance.new("Frame");
	a.Size = UDim2.fromOffset(s, O);
	a.Position = UDim2.fromOffset(0, 0);
	a.BackgroundColor3 = q.bg;
	a.BackgroundTransparency = .02;
	a.Visible = false;
	a.ZIndex = 60;
	a.Parent = o.panel;
	Mk(a, 14);
	Gk(a, q.bg2, q.bg, 90);
	o.ui.pickerOverlay = a;
	local T = Instance.new("TextLabel");
	T.Size = UDim2.new(1, -40, 0, 22);
	T.Position = UDim2.fromOffset(14, 14);
	T.BackgroundTransparency = 1;
	T.Font = Enum.Font.GothamBlack;
	T.TextSize = 14;
	T.TextXAlignment = Enum.TextXAlignment.Left;
	T.TextColor3 = L();
	T.Text = "COLOR PICKER";
	T.ZIndex = 61;
	T.Parent = a;
	ak(function()
		T.TextColor3 = L();
	end);
	local S = Instance.new("TextButton");
	S.Size = UDim2.fromOffset(60, 24);
	S.Position = UDim2.new(1, -74, 0, 12);
	S.BackgroundColor3 = q.card;
	S.BorderSizePixel = 0;
	S.Font = Enum.Font.GothamBold;
	S.TextSize = 11;
	S.TextColor3 = U();
	S.Text = "X close";
	S.ZIndex = 61;
	S.Parent = a;
	ak(function()
		S.TextColor3 = U();
	end);
	Mk(S, 6);
	local M = fk(S, L(), 1, .5);
	ak(function()
		M.Color = L();
	end);
	local G = Instance.new("Frame");
	G.Size = UDim2.fromOffset(150, 120);
	G.Position = UDim2.new(.5, -75, 0, 40);
	G.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	G.BorderSizePixel = 0;
	G.ZIndex = 61;
	G.Parent = a;
	Mk(G, 12);
	local f = fk(G, L(), 2, 0);
	ak(function()
		f.Color = L();
	end);
	local W = Instance.new("TextLabel");
	W.Size = UDim2.new(1, 0, 0, 18);
	W.Position = UDim2.new(0, 0, 1, -22);
	W.BackgroundTransparency = 1;
	W.Font = Enum.Font.Code;
	W.TextSize = 11;
	W.TextColor3 = Color3.fromRGB(255, 255, 255);
	W.TextStrokeTransparency = .4;
	W.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	W.Text = "#FFFFFF";
	W.ZIndex = 62;
	W.Parent = G;
	local F = {
			R = 255,
			G = 255,
			B = 255,
			bright = 1,
			callback = nil,
		};
	local function D(q)
		return math.clamp(math.floor(q * F.bright + .5), 0, 255);
	end;
	local function h()
		local q = D(F.R);
		local s = D(F.G);
		local Y = D(F.B);
		G.BackgroundColor3 = Color3.fromRGB(q, s, Y);
		W.Text = string.format("RGB %d,%d,%d  x%.2f", q, s, Y, F.bright);
	end;
	local function K(s, O, T, S, M, G)
		local f = Instance.new("Frame");
		f.Size = UDim2.new(1, -28, 0, 46);
		f.Position = UDim2.fromOffset(14, s);
		f.BackgroundTransparency = 1;
		f.ZIndex = 61;
		f.Parent = a;
		local W = Instance.new("TextLabel");
		W.Size = UDim2.new(1, -60, 0, 16);
		W.BackgroundTransparency = 1;
		W.Font = Enum.Font.GothamBold;
		W.TextSize = 11;
		W.TextXAlignment = Enum.TextXAlignment.Left;
		W.TextColor3 = U();
		W.Text = O;
		W.ZIndex = 62;
		W.Parent = f;
		local D = Instance.new("TextLabel");
		D.Size = UDim2.fromOffset(60, 16);
		D.Position = UDim2.new(1, -60, 0, 0);
		D.BackgroundTransparency = 1;
		D.Font = Enum.Font.Code;
		D.TextSize = 11;
		D.TextXAlignment = Enum.TextXAlignment.Right;
		D.TextColor3 = U();
		D.Text = "255";
		D.ZIndex = 62;
		D.Parent = f;
		local K = Instance.new("TextButton");
		K.Size = UDim2.new(1, 0, 0, 18);
		K.Position = UDim2.fromOffset(0, 20);
		K.BackgroundColor3 = q.card;
		K.BorderSizePixel = 0;
		K.Text = "";
		K.AutoButtonColor = false;
		K.ZIndex = 62;
		K.Parent = f;
		Mk(K, 6);
		local o = Instance.new("Frame");
		o.Size = UDim2.new(1, 0, 1, 0);
		o.BorderSizePixel = 0;
		o.ZIndex = 63;
		o.Parent = K;
		Mk(o, 6);
		o.BackgroundColor3 = S;
		local C = Instance.new("Frame");
		C.Size = UDim2.fromOffset(14, 14);
		C.BackgroundColor3 = Color3.new(1, 1, 1);
		C.BorderSizePixel = 0;
		C.ZIndex = 64;
		C.Parent = K;
		Mk(C, 7);
		fk(C, Color3.new(0, 0, 0), 1, .4);
		local b = false;
		local function d()
			local q = F[T];
			local s = ((q - M)) / ((G - M));
			C.Position = UDim2.new(s, -7, .5, -7);
			if G <= 3 then
				D.Text = string.format("%.2f", q);
			else
				D.Text = tostring(math.floor(q + .5));
			end;
		end;
		d();
		local function c(q)
			local s = math.clamp(((q - K.AbsolutePosition.X)) / math.max(K.AbsoluteSize.X, 1), 0, 1);
			local Y = M + s * ((G - M));
			if G <= 3 then
				F[T] = math.floor(Y * 100 + .5) / 100;
			else
				F[T] = math.floor(Y + .5);
			end;
			d();
			h();
		end;
		K.InputBegan:Connect(function(q)
			if q.UserInputType == Enum.UserInputType.MouseButton1 or q.UserInputType == Enum.UserInputType.Touch then
				b = true;
				c(q.Position.X);
			end;
		end);
		J(Y.InputEnded:Connect(function(q)
			if q.UserInputType == Enum.UserInputType.MouseButton1 or q.UserInputType == Enum.UserInputType.Touch then
				b = false;
			end;
		end));
		J(Y.InputChanged:Connect(function(q)
			if b and ((q.UserInputType == Enum.UserInputType.MouseMovement or q.UserInputType == Enum.UserInputType.Touch)) then
				c(q.Position.X);
			end;
		end));
		return d;
	end;
	local C = K(175, "Red", "R", Color3.fromRGB(255, 60, 60), 0, 255);
	local b = K(228, "Green", "G", Color3.fromRGB(80, 255, 100), 0, 255);
	local d = K(281, "Blue", "B", Color3.fromRGB(80, 140, 255), 0, 255);
	local c = K(334, "Brightness x", "bright", Color3.fromRGB(255, 255, 255), 0, 2);
	local v = Instance.new("TextButton");
	v.Size = UDim2.fromOffset(140, 34);
	v.Position = UDim2.new(0, 14, 0, 400);
	v.BackgroundColor3 = L();
	v.BorderSizePixel = 0;
	v.Font = Enum.Font.GothamBlack;
	v.TextSize = 13;
	v.TextColor3 = Color3.fromRGB(255, 255, 255);
	v.Text = "APPLY";
	v.ZIndex = 61;
	v.Parent = a;
	Mk(v, 8);
	ak(function()
		v.BackgroundColor3 = L();
	end);
	local H = Instance.new("TextButton");
	H.Size = UDim2.fromOffset(140, 34);
	H.Position = UDim2.new(1, -154, 0, 400);
	H.BackgroundColor3 = q.card;
	H.BorderSizePixel = 0;
	H.Font = Enum.Font.GothamBold;
	H.TextSize = 13;
	H.TextColor3 = U();
	H.Text = "Cancel";
	H.ZIndex = 61;
	H.Parent = a;
	Mk(H, 8);
	local B = fk(H, L(), 1, .5);
	ak(function()
		B.Color = L();
	end);
	local function A()
		a.Visible = false;
		F.callback = nil;
	end;
	S.MouseButton1Click:Connect(function()
		Sk();
		A();
	end);
	H.MouseButton1Click:Connect(function()
		Sk();
		A();
	end);
	v.MouseButton1Click:Connect(function()
		Sk();
		if F.callback then
			local q = D(F.R);
			local s = D(F.G);
			local Y = D(F.B);
			pcall(F.callback, Color3.fromRGB(q, s, Y));
		end;
		A();
	end);
	o.colorPickerOpen = function(q, s)
			F.R = math.floor(q.R * 255 + .5);
			F.G = math.floor(q.G * 255 + .5);
			F.B = math.floor(q.B * 255 + .5);
			F.bright = 1;
			F.callback = s;
			C();
			b();
			d();
			c();
			h();
			a.Visible = true;
		end;
	h();
end;
function o.ui.buildMain()
	local q = o.ui.tabFrames.Main;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	local a = o.ui.makeInput;
	local T = o.ui.colorRow;
	s(q, 0, "Auto Dodge");
	Y(q, 22, "Ultra Instinct", "Enabled", nil, nil, c);
	O(q, 52, "Radius (studs)", "Distance", 1, 95, 1, c, function()
		if c.RadiusVis or v.RadiusVis then
			d4();
		end;
	end);
	O(q, 96, "Delay (s)", "Delay", 0, .25, .01, c);
	O(q, 140, "Min interval (s)", "MinInterval", .02, 1, .01, c);
	O(q, 184, "Anim watch min (s)", "AnimWatch", .05, 2, .05, c);
	O(q, 228, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, c);
	s(q, 274, "Radius visualizer");
	Y(q, 296, "Show radius", "RadiusVis", nil, nil, c);
	O(q, 326, "Visibility", "RadiusTransparency", .15, .95, .05, c, function()
		if c.RadiusVis or v.RadiusVis then
			d4();
		end;
	end);
	T(q, 370, "Radius color", z, function(q)
		c.RadiusR = math.floor(q.R * 255 + .5);
		c.RadiusG = math.floor(q.G * 255 + .5);
		c.RadiusB = math.floor(q.B * 255 + .5);
		if c.RadiusVis then
			d4();
		end;
	end);
	s(q, 410, "Slot (optional)");
	local S = a(q, 430, "auto = leave empty");
	S.Text = c.ManualUISlot or "";
	(S:GetPropertyChangedSignal("Text")):Connect(function()
		if o.unloaded then
			return;
		end;
		c.ManualUISlot = string.upper(S.Text or "");
	end);
end;
function o.ui.buildHnS()
	local q = o.ui.tabFrames.HnS;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	local a = o.ui.makeInput;
	local T = o.ui.colorRow;
	s(q, 0, "HnS Dodge");
	Y(q, 22, "HnS Dodge", "Enabled", nil, nil, v);
	Y(q, 52, "Strict mode", "HollyMode", nil, nil, v);
	O(q, 82, "Radius (studs)", "Distance", 1, 95, 1, v, function()
		if c.RadiusVis or v.RadiusVis then
			d4();
		end;
	end);
	O(q, 126, "Delay (s)", "Delay", 0, .25, .01, v);
	O(q, 170, "Min interval (s)", "MinInterval", .02, 1, .01, v);
	O(q, 214, "Anim watch min (s)", "AnimWatch", .05, 2, .05, v);
	O(q, 258, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, v);
	s(q, 304, "Radius visualizer");
	Y(q, 326, "Show radius", "RadiusVis", nil, nil, v);
	O(q, 356, "Visibility", "RadiusTransparency", .15, .95, .05, v, function()
		if c.RadiusVis or v.RadiusVis then
			d4();
		end;
	end);
	T(q, 400, "HnS color", V, function(q)
		v.RadiusR = math.floor(q.R * 255 + .5);
		v.RadiusG = math.floor(q.G * 255 + .5);
		v.RadiusB = math.floor(q.B * 255 + .5);
		if v.RadiusVis then
			d4();
		end;
	end);
	s(q, 440, "Slot (optional)");
	local S = a(q, 460, "auto = leave empty");
	S.Text = c.ManualHnSSlot or "";
	(S:GetPropertyChangedSignal("Text")):Connect(function()
		if o.unloaded then
			return;
		end;
		c.ManualHnSSlot = string.upper(S.Text or "");
	end);
end;
function o.ui.buildRebel()
	local q = o.ui.tabFrames.Rebel;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	local a = o.ui.makeBtn;
	local T = o.ui.makeInput;
	local S = o.ui.colorRow;
	s(q, 0, "Silent Aim");
	Y(q, 22, "Silent Aim", "RebelSilentAim", nil, function(q)
		c.RebelSilentAim = q;
		if q then
			Y4();
		end;
	end, c);
	Y(q, 52, "FOV Circle", "RebelFOVCircle", nil, function(q)
		c.RebelFOVCircle = q;
		F4();
	end, c);
	Y(q, 82, "Neon glow", "RebelFOVNeon", nil, function(q)
		c.RebelFOVNeon = q;
		F4();
	end, c);
	Y(q, 112, "Black outline", "RebelFOVBlackOutline", nil, function(q)
		c.RebelFOVBlackOutline = q;
		F4();
	end, c);
	O(q, 144, "Outline thickness", "RebelFOV_OutlineThickness", 1, 20, 1, c, D4);
	S(q, 188, "Outline color", u, function(q)
		c.RebelFOV_OutlineR = math.floor(q.R * 255 + .5);
		c.RebelFOV_OutlineG = math.floor(q.G * 255 + .5);
		c.RebelFOV_OutlineB = math.floor(q.B * 255 + .5);
		c.FOVRainbow = false;
		T4();
		F4();
	end);
	O(q, 230, "FOV radius (px)", "RebelFOV", 10, 1200, 5, c, D4);
	O(q, 274, "Circle line width", "RebelFOVCircleWidth", .5, 15, .1, c, D4);
	S(q, 318, "FOV color", r, function(q)
		c.RebelFOVR = math.floor(q.R * 255 + .5);
		c.RebelFOVG = math.floor(q.G * 255 + .5);
		c.RebelFOVB = math.floor(q.B * 255 + .5);
		c.FOVUseCustom = false;
		c.FOVRainbow = false;
		T4();
		F4();
	end);
	s(q, 358, "FOV Rainbow (6 modes)");
	local M = Y(q, 380, "Rainbow FOV", "FOVRainbow", nil, function(q)
			if q then
				G4();
			else
				T4();
				F4();
			end;
		end, c);
	o.ui.fovRainbowPaint = M;
	O(q, 410, "Blend speed", "RebelFOVBlendSpeed", .1, 3, .05, c);
	local function G(q)
		c.FOVRainbowMode = q;
		c.FOVRainbow = true;
		if o.ui.fovRainbowPaint then
			pcall(o.ui.fovRainbowPaint);
		end;
		F4();
		G4();
	end;
	a(q, 454, "Mode 1: Cycle hue", function()
		G(1);
	end);
	a(q, 486, "Mode 2: Wave", function()
		G(2);
	end);
	a(q, 518, "Mode 3: Gradient blend", function()
		G(3);
	end);
	a(q, 550, "Mode 4: Breathing pulse", function()
		G(4);
	end);
	a(q, 582, "Mode 5: Aurora", function()
		G(5);
	end);
	a(q, 614, "Mode 6: FUSION", function()
		G(6);
	end);
	s(q, 656, "Custom FOV colors (1-9)");
	Y(q, 678, "Use custom color", "FOVUseCustom", nil, function(q)
		F4();
		if c.FOVRainbow then
			G4();
		end;
	end, c);
	local function f(q)
		return function()
			local s, Y, O = 60, 60, 255;
			if q == 1 then
				s, Y, O = c.FOVCustomR1 or 255, c.FOVCustomG1 or 60, c.FOVCustomB1 or 60;
			elseif q == 2 then
				s, Y, O = c.FOVCustomR2 or 60, c.FOVCustomG2 or 255, c.FOVCustomB2 or 60;
			elseif q == 3 then
				s, Y, O = c.FOVCustomR3 or 60, c.FOVCustomG3 or 140, c.FOVCustomB3 or 255;
			elseif q == 4 then
				s, Y, O = c.FOVCustomR4 or 255, c.FOVCustomG4 or 255, c.FOVCustomB4 or 60;
			elseif q == 5 then
				s, Y, O = c.FOVCustomR5 or 255, c.FOVCustomG5 or 60, c.FOVCustomB5 or 255;
			elseif q == 6 then
				s, Y, O = c.FOVCustomR6 or 60, c.FOVCustomG6 or 255, c.FOVCustomB6 or 255;
			elseif q == 7 then
				s, Y, O = c.FOVCustomR7 or 255, c.FOVCustomG7 or 180, c.FOVCustomB7 or 60;
			elseif q == 8 then
				s, Y, O = c.FOVCustomR8 or 255, c.FOVCustomG8 or 255, c.FOVCustomB8 or 255;
			elseif q == 9 then
				s, Y, O = c.FOVCustomR9 or 180, c.FOVCustomG9 or 60, c.FOVCustomB9 or 255;
			end;
			return Color3.fromRGB(s, Y, O);
		end;
	end;
	local function W(q)
		return function(s)
			local Y, O, a = math.floor(s.R * 255 + .5), math.floor(s.G * 255 + .5), math.floor(s.B * 255 + .5);
			if q == 1 then
				c.FOVCustomR1, c.FOVCustomG1, c.FOVCustomB1 = Y, O, a;
			elseif q == 2 then
				c.FOVCustomR2, c.FOVCustomG2, c.FOVCustomB2 = Y, O, a;
			elseif q == 3 then
				c.FOVCustomR3, c.FOVCustomG3, c.FOVCustomB3 = Y, O, a;
			elseif q == 4 then
				c.FOVCustomR4, c.FOVCustomG4, c.FOVCustomB4 = Y, O, a;
			elseif q == 5 then
				c.FOVCustomR5, c.FOVCustomG5, c.FOVCustomB5 = Y, O, a;
			elseif q == 6 then
				c.FOVCustomR6, c.FOVCustomG6, c.FOVCustomB6 = Y, O, a;
			elseif q == 7 then
				c.FOVCustomR7, c.FOVCustomG7, c.FOVCustomB7 = Y, O, a;
			elseif q == 8 then
				c.FOVCustomR8, c.FOVCustomG8, c.FOVCustomB8 = Y, O, a;
			elseif q == 9 then
				c.FOVCustomR9, c.FOVCustomG9, c.FOVCustomB9 = Y, O, a;
			end;
			if c.FOVUseCustom then
				F4();
				if c.FOVRainbow then
					G4();
				end;
			end;
		end;
	end;
	for s = 1, 9, 1 do
		local Y = 710 + ((s - 1)) * 62;
		S(q, Y, "Slot " .. s, f(s), W(s));
		a(q, Y + 32, "Use slot " .. s, function()
			c.FOVCustomIdx = s;
			c.FOVUseCustom = true;
			F4();
			if c.FOVRainbow then
				G4();
			end;
		end);
	end;
	s(q, 1278, "Target filter");
	Y(q, 1300, "Target players", "RebelTargetPlayers", nil, nil, c);
	Y(q, 1330, "Target game guards (NPC)", "RebelTargetNPCs", nil, nil, c);
	s(q, 1366, "Body parts (random)");
	Y(q, 1388, "Head", "RebelBodyHead", nil, nil, c);
	Y(q, 1418, "Torso", "RebelBodyTorso", nil, nil, c);
	Y(q, 1448, "HumanoidRootPart", "RebelBodyHRP", nil, nil, c);
	Y(q, 1478, "Left Arm", "RebelBodyLeftArm", nil, nil, c);
	Y(q, 1508, "Right Arm", "RebelBodyRightArm", nil, nil, c);
	Y(q, 1538, "Left Leg", "RebelBodyLeftLeg", nil, nil, c);
	Y(q, 1568, "Right Leg", "RebelBodyRightLeg", nil, nil, c);
	s(q, 1604, "Gun mods");
	Y(q, 1626, "No Recoil & Spread", "RebelNoRecoil", nil, function(q)
		c.RebelNoRecoil = q;
		if q then
			Y4();
		end;
	end, c);
	Y(q, 1656, "Rapid Fire", "RebelRapidFire", nil, function(q)
		c.RebelRapidFire = q;
		if q then
			Y4();
		end;
	end, c);
	s(q, 1692, "Bullet tracer");
	Y(q, 1714, "Enable Bullet Tracer", "BulletTracer", nil, nil, c);
	Y(q, 1744, "Glow", "BulletTracerGlow", nil, nil, c);
	Y(q, 1774, "White core", "BulletTracerWhiteCore", nil, nil, c);
	S(q, 1804, "Tracer color", function()
		return Color3.fromRGB(c.BulletTracerR, c.BulletTracerG, c.BulletTracerB);
	end, function(q)
		c.BulletTracerR = math.floor(q.R * 255 + .5);
		c.BulletTracerG = math.floor(q.G * 255 + .5);
		c.BulletTracerB = math.floor(q.B * 255 + .5);
	end);
	O(q, 1846, "Thickness", "BulletTracerThickness", .05, 1, .01, c);
	O(q, 1890, "Speed (studs/s)", "BulletTracerSpeed", 50, 5000, 50, c);
	O(q, 1934, "Lifetime (s)", "BulletTracerLifetime", .1, 5, .05, c);
	O(q, 1978, "Range (studs)", "BulletTracerRange", 50, 2000, 25, c);
	O(q, 2022, "Start offset", "BulletTracerStartOffset", 0, 5, .1, c);
	O(q, 2066, "End offset", "BulletTracerEndOffset", 0, 5, .1, c);
	O(q, 2110, "Opacity", "BulletTracerOpacity", 0, .5, .01, c);
	O(q, 2154, "Cooldown (s)", "BulletTracerCooldown", .01, .5, .01, c);
	local F = {
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
	a(q, 2198, "Fade: " .. F[c.BulletTracerFadeIdx or 1], function()
		c.BulletTracerFadeIdx = ((c.BulletTracerFadeIdx or 1)) + 1;
		if c.BulletTracerFadeIdx > #F then
			c.BulletTracerFadeIdx = 1;
		end;
	end);
	s(q, 2240, "Auto Brew (Soda Fountain)");
	Y(q, 2262, "Auto brew + collect", "AutoBrew", nil, function(q)
		if q then
			L4();
		else
			U4();
		end;
	end, c);
	local D = T(q, 2292, "brew key (E)");
	D.Text = c.AutoBrewSlot or "E";
	(D:GetPropertyChangedSignal("Text")):Connect(function()
		if o.unloaded then
			return;
		end;
		local q = string.upper(D.Text or "E");
		if q == "" then
			q = "E";
		end;
		c.AutoBrewSlot = q;
	end);
	O(q, 2324, "Brew cooldown (s)", "AutoBrewInterval", 5, 300, 5, c);
	O(q, 2368, "Collect hold (s)", "AutoBrewCollectHold", .5, 5, .1, c);
end;
function o.ui.buildRLGL()
	local q = o.ui.tabFrames.RLGL;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	s(q, 0, "RLGL Auto Dodge");
	Y(q, 22, "RLGL Auto Dodge", "RLGL_AutoDodge");
	Y(q, 52, "Only on red light", "RLGL_OnlyRedLight");
	Y(q, 82, "Auto-dodge after timer 0", "RLGL_TimerEndDodge");
	s(q, 118, "Red light tuning");
	O(q, 140, "Delay after red (s)", "RLGL_RedDelay", .05, 2, .05, c);
	O(q, 184, "Interval (s)", "RLGL_MinInterval", .05, 2, .05, c);
	O(q, 228, "Velocity threshold", "RLGL_VelThreshold", .1, 8, .1, c);
	s(q, 274, "Timer-end tuning");
	O(q, 296, "Delay after 0 (s)", "RLGL_TimerEndDelay", 0, 3, .05, c);
	O(q, 340, "Interval between (s)", "RLGL_TimerEndInterval", .05, 2, .05, c);
	O(q, 384, "Max duration (s)", "RLGL_TimerEndMaxDuration", 3, 30, 1, c);
end;
function o.ui.buildESP()
	local q = o.ui.tabFrames.ESP;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	local a = o.ui.makeBtn;
	local T = o.ui.colorRow;
	s(q, 0, "Playable Guard ESP");
	Y(q, 22, "Playable Guard ESP", "GuardESP");
	Y(q, 52, "Show HP bar", "GuardESP_HP");
	Y(q, 82, "Show Name", "GuardESP_Name");
	Y(q, 112, "Show Highlight (chams)", "GuardESP_Highlight");
	Y(q, 142, "Show Tracer", "GuardESP_Tracer");
	Y(q, 172, "Show Box (2D)", "GuardESP_Box");
	Y(q, 202, "Show Skeleton", "GuardESP_Skeleton");
	Y(q, 232, "Show Tool (under feet)", "GuardESP_Tool");
	Y(q, 262, "Show Distance (right)", "GuardESP_Distance");
	Y(q, 292, "Force ALL as Guard (debug)", "GuardESP_ForceAll");
	O(q, 322, "Name size", "GuardESP_NameSize", 8, 32, 1, c);
	O(q, 366, "Max distance (studs)", "GuardESP_MaxDist", 0, 1000, 10, c, x4);
	O(q, 410, "Box thickness", "GuardESP_BoxThickness", 1, 6, .5, c);
	O(q, 454, "Skeleton thickness", "GuardESP_SkeletonThickness", 1, 6, .5, c);
	s(q, 500, "Guard accent color");
	T(q, 522, "Guard accent", k, function(q)
		c.GuardESP_ColorR = math.floor(q.R * 255 + .5);
		c.GuardESP_ColorG = math.floor(q.G * 255 + .5);
		c.GuardESP_ColorB = math.floor(q.B * 255 + .5);
		if c.GuardESP then
			x4();
		end;
	end);
	T(q, 554, "Guard tracer", p, function(q)
		c.GuardESP_TracerR = math.floor(q.R * 255 + .5);
		c.GuardESP_TracerG = math.floor(q.G * 255 + .5);
		c.GuardESP_TracerB = math.floor(q.B * 255 + .5);
	end);
	T(q, 586, "Guard box", g, function(q)
		c.GuardESP_BoxR = math.floor(q.R * 255 + .5);
		c.GuardESP_BoxG = math.floor(q.G * 255 + .5);
		c.GuardESP_BoxB = math.floor(q.B * 255 + .5);
	end);
	T(q, 618, "Guard skeleton", e, function(q)
		c.GuardESP_SkeletonR = math.floor(q.R * 255 + .5);
		c.GuardESP_SkeletonG = math.floor(q.G * 255 + .5);
		c.GuardESP_SkeletonB = math.floor(q.B * 255 + .5);
	end);
	s(q, 658, "Guard HP chip (4 states)");
	Y(q, 680, "Black outline (chip + number)", "GuardESP_HP_Outline", nil, nil, c);
	T(q, 712, "State 1 (>75%)", x, function(q)
		c.GuardESP_HP_State1_R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_State1_G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_State1_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 744, "State 2 (50-75%)", I, function(q)
		c.GuardESP_HP_State2_R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_State2_G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_State2_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 776, "State 3 (25-50%)", Z, function(q)
		c.GuardESP_HP_State3_R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_State3_G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_State3_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 808, "State 4 (<25%)", n, function(q)
		c.GuardESP_HP_State4_R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_State4_G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_State4_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	s(q, 852, "Guard HP gradient (vertical bar)");
	local function S()
		return Color3.fromRGB(c.GuardESP_HP_TopR or 80, c.GuardESP_HP_TopG or 255, c.GuardESP_HP_TopB or 80);
	end;
	local function M()
		return Color3.fromRGB(c.GuardESP_HP_M1R or 180, c.GuardESP_HP_M1G or 255, c.GuardESP_HP_M1B or 60);
	end;
	local function G()
		return Color3.fromRGB(c.GuardESP_HP_M2R or 255, c.GuardESP_HP_M2G or 200, c.GuardESP_HP_M2B or 40);
	end;
	local function f()
		return Color3.fromRGB(c.GuardESP_HP_M3R or 255, c.GuardESP_HP_M3G or 120, c.GuardESP_HP_M3B or 60);
	end;
	local function W()
		return Color3.fromRGB(c.GuardESP_HP_BotR or 255, c.GuardESP_HP_BotG or 40, c.GuardESP_HP_BotB or 40);
	end;
	T(q, 874, "Top", S, function(q)
		c.GuardESP_HP_TopR = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_TopG = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_TopB = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 906, "Mid1", M, function(q)
		c.GuardESP_HP_M1R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_M1G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_M1B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 938, "Mid2", G, function(q)
		c.GuardESP_HP_M2R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_M2G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_M2B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 970, "Mid3", f, function(q)
		c.GuardESP_HP_M3R = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_M3G = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_M3B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1002, "Bottom", W, function(q)
		c.GuardESP_HP_BotR = math.floor(q.R * 255 + .5);
		c.GuardESP_HP_BotG = math.floor(q.G * 255 + .5);
		c.GuardESP_HP_BotB = math.floor(q.B * 255 + .5);
		x4();
	end);
	s(q, 1046, "Player ESP");
	Y(q, 1068, "Player ESP", "PlayerESP");
	Y(q, 1098, "Show HP bar", "PlayerESP_HP");
	Y(q, 1128, "Show Name", "PlayerESP_Name");
	Y(q, 1158, "Show Highlight (chams)", "PlayerESP_Highlight");
	Y(q, 1188, "Show Tracer", "PlayerESP_Tracer");
	Y(q, 1218, "Show Box (2D)", "PlayerESP_Box");
	Y(q, 1248, "Show Skeleton", "PlayerESP_Skeleton");
	Y(q, 1278, "Show Tool (under feet)", "PlayerESP_Tool");
	Y(q, 1308, "Show Distance (right)", "PlayerESP_Distance");
	O(q, 1338, "Name size", "PlayerESP_NameSize", 8, 32, 1, c);
	O(q, 1382, "Max distance (studs)", "PlayerESP_MaxDist", 0, 1000, 10, c, x4);
	O(q, 1426, "Box thickness", "PlayerESP_BoxThickness", 1, 6, .5, c);
	O(q, 1470, "Skeleton thickness", "PlayerESP_SkeletonThickness", 1, 6, .5, c);
	s(q, 1516, "Player accent color");
	T(q, 1538, "Player accent", y, function(q)
		c.PlayerESP_ColorR = math.floor(q.R * 255 + .5);
		c.PlayerESP_ColorG = math.floor(q.G * 255 + .5);
		c.PlayerESP_ColorB = math.floor(q.B * 255 + .5);
		if c.PlayerESP then
			x4();
		end;
	end);
	T(q, 1570, "Player tracer", R, function(q)
		c.PlayerESP_TracerR = math.floor(q.R * 255 + .5);
		c.PlayerESP_TracerG = math.floor(q.G * 255 + .5);
		c.PlayerESP_TracerB = math.floor(q.B * 255 + .5);
	end);
	T(q, 1602, "Player box", E, function(q)
		c.PlayerESP_BoxR = math.floor(q.R * 255 + .5);
		c.PlayerESP_BoxG = math.floor(q.G * 255 + .5);
		c.PlayerESP_BoxB = math.floor(q.B * 255 + .5);
	end);
	T(q, 1634, "Player skeleton", w, function(q)
		c.PlayerESP_SkeletonR = math.floor(q.R * 255 + .5);
		c.PlayerESP_SkeletonG = math.floor(q.G * 255 + .5);
		c.PlayerESP_SkeletonB = math.floor(q.B * 255 + .5);
	end);
	s(q, 1674, "Player HP chip (4 states)");
	Y(q, 1696, "Black outline (chip + number)", "PlayerESP_HP_Outline", nil, nil, c);
	T(q, 1728, "State 1 (>75%)", t, function(q)
		c.PlayerESP_HP_State1_R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_State1_G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_State1_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1760, "State 2 (50-75%)", l, function(q)
		c.PlayerESP_HP_State2_R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_State2_G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_State2_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1792, "State 3 (25-50%)", i, function(q)
		c.PlayerESP_HP_State3_R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_State3_G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_State3_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1824, "State 4 (<25%)", qk, function(q)
		c.PlayerESP_HP_State4_R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_State4_G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_State4_B = math.floor(q.B * 255 + .5);
		x4();
	end);
	s(q, 1868, "Player HP gradient (vertical bar)");
	local function F()
		return Color3.fromRGB(c.PlayerESP_HP_TopR or 80, c.PlayerESP_HP_TopG or 255, c.PlayerESP_HP_TopB or 80);
	end;
	local function D()
		return Color3.fromRGB(c.PlayerESP_HP_M1R or 180, c.PlayerESP_HP_M1G or 255, c.PlayerESP_HP_M1B or 60);
	end;
	local function h()
		return Color3.fromRGB(c.PlayerESP_HP_M2R or 255, c.PlayerESP_HP_M2G or 200, c.PlayerESP_HP_M2B or 40);
	end;
	local function K()
		return Color3.fromRGB(c.PlayerESP_HP_M3R or 255, c.PlayerESP_HP_M3G or 120, c.PlayerESP_HP_M3B or 60);
	end;
	local function C()
		return Color3.fromRGB(c.PlayerESP_HP_BotR or 255, c.PlayerESP_HP_BotG or 40, c.PlayerESP_HP_BotB or 40);
	end;
	T(q, 1890, "Top", F, function(q)
		c.PlayerESP_HP_TopR = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_TopG = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_TopB = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1922, "Mid1", D, function(q)
		c.PlayerESP_HP_M1R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_M1G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_M1B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1954, "Mid2", h, function(q)
		c.PlayerESP_HP_M2R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_M2G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_M2B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 1986, "Mid3", K, function(q)
		c.PlayerESP_HP_M3R = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_M3G = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_M3B = math.floor(q.B * 255 + .5);
		x4();
	end);
	T(q, 2018, "Bottom", C, function(q)
		c.PlayerESP_HP_BotR = math.floor(q.R * 255 + .5);
		c.PlayerESP_HP_BotG = math.floor(q.G * 255 + .5);
		c.PlayerESP_HP_BotB = math.floor(q.B * 255 + .5);
		x4();
	end);
	s(q, 2064, "HP bar size");
	O(q, 2086, "Guard bar thickness", "GuardESP_HPBarThickness", 2, 30, 1, c);
	O(q, 2130, "Guard bar length", "GuardESP_HPBarLength", .3, 3, .1, c);
	O(q, 2174, "Guard bar roundness", "GuardESP_HPBarRoundness", 0, 20, 1, c);
	O(q, 2218, "Player bar thickness", "PlayerESP_HPBarThickness", 2, 30, 1, c);
	O(q, 2262, "Player bar length", "PlayerESP_HPBarLength", .3, 3, .1, c);
	O(q, 2306, "Player bar roundness", "PlayerESP_HPBarRoundness", 0, 20, 1, c);
	s(q, 2350, "ESP text");
	local b;
	local function d()
		if b then
			b.Text = "Next font: " .. ((H[c.ESP_FontIdx or 1] or "?"));
		end;
	end;
	b = a(q, 2372, "Next font: " .. ((H[c.ESP_FontIdx or 1] or "?")), function()
			c.ESP_FontIdx = ((c.ESP_FontIdx or 1)) + 1;
			if c.ESP_FontIdx > #H then
				c.ESP_FontIdx = 1;
			end;
			d();
			for q, s in pairs(k4) do
				pcall(function()
					if s.nameL then
						s.nameL.Font = B();
					end;
					if s.toolL then
						s.toolL.Font = B();
					end;
				end);
			end;
			for q, s in pairs(y4) do
				pcall(function()
					if s.nameL then
						s.nameL.Font = B();
					end;
					if s.toolL then
						s.toolL.Font = B();
					end;
				end);
			end;
		end);
	a(q, 2404, "Reset font (GothamBlack)", function()
		c.ESP_FontIdx = 1;
		d();
		for q, s in pairs(k4) do
			pcall(function()
				if s.nameL then
					s.nameL.Font = Enum.Font.GothamBlack;
					s.nameL.TextSize = (c.GuardESP_NameSize or 17);
				end;
				if s.toolL then
					s.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		for q, s in pairs(y4) do
			pcall(function()
				if s.nameL then
					s.nameL.Font = Enum.Font.GothamBlack;
					s.nameL.TextSize = (c.PlayerESP_NameSize or 17);
				end;
				if s.toolL then
					s.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("font reset - GothamBlack");
		end;
	end);
end;
function o.ui.buildDalgona()
	local q = o.ui.tabFrames.Dalgona;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.BTN_W;
	local a = o.ui.COL;
	s(q, 0, "Cookie");
	Y(q, 22, "One Click Complete", nil, function()
		return o.oneClickDalgona;
	end, function(q)
		I4(q);
	end);
	local T = Instance.new("TextLabel");
	T.Size = UDim2.fromOffset(O, 70);
	T.Position = UDim2.fromOffset(4, 56);
	T.BackgroundTransparency = 1;
	T.Font = Enum.Font.Gotham;
	T.TextSize = 9;
	T.TextWrapped = true;
	T.TextXAlignment = Enum.TextXAlignment.Left;
	T.TextYAlignment = Enum.TextYAlignment.Top;
	T.TextColor3 = U();
	T.Text = "Vklyuchi i vedi myshkoi po konturu pechenki.";
	T.ZIndex = 6;
	T.Parent = q;
	ak(function()
		T.TextColor3 = U();
	end);
end;
function o.ui.buildExtra()
	local q = o.ui.tabFrames.Extra;
	local s = o.ui.mkDivider;
	local Y = o.ui.makeToggle;
	local O = o.ui.makeSlider;
	local a = o.ui.makeBtn;
	s(q, 0, "Instant Interact");
	Y(q, 22, "Enable Instant Interact", "InstantInteract");
	Y(q, 52, "Insta mode (0ms)", "InstantInteractInsta");
	O(q, 82, "Custom speed x", "InstantInteractMult", .5, 50, .5, c);
	s(q, 128, "Hide overhead");
	Y(q, 150, "Hide nickname", "HideNick", nil, function()
		S9();
	end, c);
	s(q, 186, "Visual");
	Y(q, 208, "Full Bright", "FullBright", nil, function(q)
		H4(q);
	end, c);
	Y(q, 238, "Remove Fog", "RemoveFog", nil, function(q)
		B4(q);
	end, c);
	s(q, 274, "Overlay");
	Y(q, 296, "Watermark", "Watermark", nil, function()
		dk();
	end, c);
	Y(q, 326, "Keybind list", "KeybindList", nil, function()
		dk();
	end, c);
	s(q, 362, "Cosmetics");
	Y(q, 384, "Headless", "Headless");
	Y(q, 414, "Korblox Left Leg", "Korblox");
	Y(q, 444, "Remove Legs", "RemoveLegs");
	Y(q, 474, "Remove Hands", "RemoveHands");
	Y(q, 504, "Remove Torso (client)", "RemoveTorso");
	s(q, 544, "Animation Speed");
	Y(q, 566, "Speed 2.5x", "AnimSpeed");
	a(q, 598, "Reset anim speed", function()
		local q = D.Character;
		local s = q and q:FindFirstChildOfClass("Humanoid");
		local Y = s and s:FindFirstChildOfClass("Animator");
		if Y then
			for q, s in ipairs(Y:GetPlayingAnimationTracks()) do
				pcall(function()
					s:AdjustSpeed(1);
				end);
			end;
		end;
	end);
	s(q, 636, "Extra");
	a(q, 658, "Open Infinite Yield", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local q, s = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(q and "Infinite Yield loaded" or ("IY fail: " .. tostring(s)));
		end;
	end);
	a(q, 690, "Jerk off", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local q, s = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jerk-off-script-OG-245780")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(q and "Jerk off loaded" or ("fail: " .. tostring(s)));
		end;
	end);
end;
function o.ui.buildConfigs()
	local q = o.ui.tabFrames.Configs;
	local s = o.ui.mkDivider;
	local O = o.ui.makeToggle;
	local a = o.ui.makeSlider;
	local S = o.ui.makeBtn;
	local M = o.ui.makeInput;
	local G = o.ui.colorRow;
	local f = o.ui.COL;
	s(q, 0, "Config");
	local W;
	local F = M(q, 22, "config name");
	F.Text = o.currentConfigName;
	S(q, 54, "Save", function()
		local q = F.Text;
		if q == "" then
			q = "default";
		end;
		local s, Y = h9(q);
		if s then
			F.Text = o.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved - " .. o.currentConfigName);
			end;
			task.defer(function()
				if W then
					W();
				end;
			end);
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("save fail - " .. tostring(Y));
			end;
		end;
	end);
	S(q, 86, "Load", function()
		local q = F.Text;
		if q == "" then
			q = "default";
		end;
		local s, Y = K9(q);
		if s then
			F.Text = o.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("loaded - " .. o.currentConfigName);
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("load fail - " .. tostring(Y));
			end;
		end;
	end);
	s(q, 124, "Menu animation");
	a(q, 146, "Open/close speed", "MenuAnimSpeed", .1, 1.5, .05, c);
	a(q, 190, "Collapse anim speed", "MenuDodgeAnimSpeed", .1, 2, .05, c);
	s(q, 236, "Circle menu button");
	a(q, 258, "Circle size", "CircleSize", 32, 120, 2, c);
	G(q, 300, "Circle text color", Q, function(q)
		c.CircleTextR = math.floor(q.R * 255 + .5);
		c.CircleTextG = math.floor(q.G * 255 + .5);
		c.CircleTextB = math.floor(q.B * 255 + .5);
		Tk();
	end);
	O(q, 334, "Rainbow text color", "CircleRainbowText", nil, function()
		Tk();
	end, c);
	O(q, 364, "Rainbow outline", "CircleRainbowOutline", nil, function()
		Tk();
	end, c);
	s(q, 400, "Text color (all GUI)");
	G(q, 422, "Text color", U, function(q)
		c.GuiTextR = math.floor(q.R * 255 + .5);
		c.GuiTextG = math.floor(q.G * 255 + .5);
		c.GuiTextB = math.floor(q.B * 255 + .5);
		Tk();
	end);
	s(q, 462, "Panel border");
	O(q, 484, "Rainbow panel border", "PanelRainbow", nil, function(q)
		if q then
			W4();
		else
			f4();
			if o.panel then
				local q = o.panel:FindFirstChildOfClass("UIStroke");
				if q then
					q.Color = L();
				end;
			end;
		end;
	end, c);
	s(q, 520, "Accent color");
	G(q, 542, "GUI accent", L, function(q)
		c.GuiR = math.floor(q.R * 255 + .5);
		c.GuiG = math.floor(q.G * 255 + .5);
		c.GuiB = math.floor(q.B * 255 + .5);
		Tk();
	end);
	a(q, 584, "R", "GuiR", 0, 255, 1, c, Tk);
	a(q, 628, "G", "GuiG", 0, 255, 1, c, Tk);
	a(q, 672, "B", "GuiB", 0, 255, 1, c, Tk);
	s(q, 716, "Saved");
	local D = Instance.new("ScrollingFrame");
	D.Size = UDim2.new(1, -8, 0, 90);
	D.Position = UDim2.fromOffset(4, 736);
	D.BackgroundColor3 = f.card;
	D.BorderSizePixel = 0;
	D.ScrollBarThickness = 3;
	D.CanvasSize = UDim2.fromOffset(0, 0);
	D.ZIndex = 6;
	D.Parent = q;
	Mk(D, 7);
	local h = Instance.new("TextLabel");
	h.Size = UDim2.new(1, -8, 0, 20);
	h.Position = UDim2.fromOffset(4, 6);
	h.BackgroundTransparency = 1;
	h.Font = Enum.Font.Gotham;
	h.TextSize = 11;
	h.TextColor3 = U();
	h.TextXAlignment = Enum.TextXAlignment.Left;
	h.Text = "no configs saved yet";
	h.ZIndex = 7;
	h.Parent = D;
	ak(function()
		h.TextColor3 = U();
	end);
	W = function()
			if o.unloaded or not D or not D.Parent then
				return;
			end;
			for q, s in ipairs(D:GetChildren()) do
				if s:IsA("TextButton") then
					s:Destroy();
				end;
			end;
			local q = o9();
			D.CanvasSize = UDim2.fromOffset(0, math.max(#q * 26 + 8, 26));
			h.Visible = (#q == 0);
			for q, s in ipairs(q) do
				local Y = Instance.new("TextButton");
				Y.Size = UDim2.new(1, -8, 0, 22);
				Y.Position = UDim2.fromOffset(4, ((q - 1)) * 26 + 4);
				Y.BackgroundColor3 = f.off;
				Y.BorderSizePixel = 0;
				Y.Font = Enum.Font.Gotham;
				Y.TextSize = 12;
				Y.TextColor3 = U();
				Y.Text = "  " .. s;
				Y.TextXAlignment = Enum.TextXAlignment.Left;
				Y.ZIndex = 7;
				Y.Parent = D;
				Mk(Y, 5);
				ak(function()
					Y.TextColor3 = U();
				end);
				Y.MouseButton1Click:Connect(function()
					Sk();
					F.Text = s;
					local q = K9(s);
					if _G.__ad_statusCb then
						_G.__ad_statusCb(q and ("loaded - " .. s) or "load failed");
					end;
				end);
				local O = Instance.new("TextButton");
				O.Size = UDim2.fromOffset(20, 18);
				O.Position = UDim2.new(1, -24, .5, -9);
				O.BackgroundColor3 = Color3.fromRGB(120, 30, 30);
				O.BorderSizePixel = 0;
				O.Font = Enum.Font.GothamBold;
				O.TextSize = 11;
				O.TextColor3 = Color3.new(1, 1, 1);
				O.Text = "x";
				O.ZIndex = 8;
				O.Parent = Y;
				Mk(O, 4);
				O.MouseButton1Click:Connect(function()
					if o.unloaded then
						return;
					end;
					Sk();
					local q, Y = C9(s);
					if q then
						if _G.__ad_statusCb then
							_G.__ad_statusCb("deleted - " .. s);
						end;
						task.defer(function()
							if W then
								W();
							end;
						end);
					else
						if _G.__ad_statusCb then
							_G.__ad_statusCb("del fail - " .. tostring(Y));
						end;
					end;
				end);
			end;
		end;
	W();
	_G.__adRefreshConfigs = W;
	S(q, 834, "Refresh List", function()
		W();
	end);
	S(q, 868, "Set Menu Key", function()
		o.bindingMenuKey = true;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("press a key...");
		end;
		local q;
		q = Y.InputBegan:Connect(function(s)
				if s.UserInputType ~= Enum.UserInputType.Keyboard then
					return;
				end;
				c.MenuKey = s.KeyCode;
				if _G.__ad_statusCb then
					_G.__ad_statusCb("menu key = " .. s.KeyCode.Name);
				end;
				task.defer(function()
					o.bindingMenuKey = false;
				end);
				if q then
					q:Disconnect();
				end;
				if o.rebindMenu then
					o.rebindMenu();
				end;
			end);
	end);
	S(q, 902, "FULL UNLOAD", function()
		if o.doFullUnload then
			pcall(o.doFullUnload);
		end;
	end);
	s(q, 940, "Share config (JSON / TXT)");
	local K = M(q, 962, "paste JSON here to import");
	K.Text = "";
	S(q, 994, "Export (copy JSON to clipboard)", function()
		local q = { C = W9(c), H = W9(v), anim = o.animEnabled };
		local s = T:JSONEncode(q);
		local Y = false;
		if setclipboard then
			pcall(function()
				setclipboard(s);
				Y = true;
			end);
		end;
		if Y then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("copied (" .. (#s .. " chars) - send to friend"));
			end;
		else
			K.Text = s;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no setclipboard - JSON in box, copy manually");
			end;
		end;
	end);
	S(q, 1026, "Export to file (XD_config.txt)", function()
		if not o.FILE.writefile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no writefile in executor");
			end;
			return;
		end;
		local q = { C = W9(c), H = W9(v), anim = o.animEnabled };
		local s = T:JSONEncode(q);
		local Y = pcall(function()
				o.FILE.writefile("XD_config.txt", s);
			end);
		if Y then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved XD_config.txt (" .. (#s .. ")"));
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("writefile failed");
			end;
		end;
	end);
	S(q, 1058, "Load from file (XD_config.txt)", function()
		if not o.FILE.readfile or not o.FILE.isfile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no readfile");
			end;
			return;
		end;
		local q, s = pcall(o.FILE.isfile, "XD_config.txt");
		if not q or not s then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("XD_config.txt not found");
			end;
			return;
		end;
		local Y, O = pcall(o.FILE.readfile, "XD_config.txt");
		if not Y or not O then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("read failed");
			end;
			return;
		end;
		local a, S = pcall(function()
				return T:JSONDecode(O);
			end);
		if not a or type(S) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in file");
			end;
			return;
		end;
		D9(S);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("loaded from XD_config.txt");
		end;
	end);
	S(q, 1090, "Import from clipboard", function()
		local q = "";
		if getclipboard then
			pcall(function()
				q = getclipboard();
			end);
		end;
		if not q or q == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("clipboard empty or no getclipboard");
			end;
			return;
		end;
		local s, Y = pcall(function()
				return T:JSONDecode(q);
			end);
		if not s or type(Y) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in clipboard");
			end;
			return;
		end;
		D9(Y);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from clipboard");
		end;
	end);
	S(q, 1122, "Import from box above", function()
		local q = K.Text or "";
		if q == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("box empty");
			end;
			return;
		end;
		local s, Y = pcall(function()
				return T:JSONDecode(q);
			end);
		if not s or type(Y) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json");
			end;
			return;
		end;
		D9(Y);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from box");
		end;
	end);
	s(q, 1158, "Circle rainbow glow");
	a(q, 1180, "Glow speed", "CircleRainbowSpeed", .1, 5, .1, c);
end;
function o.ui.buildCollapseCircle()
	local q = o.ui.PANEL_W;
	local s = o.ui.PANEL_H;
	local O = Instance.new("TextButton");
	O.AnchorPoint = Vector2.new(1, 0);
	O.Position = UDim2.new(1, -16, 0, 90);
	O.Size = UDim2.fromOffset(0, 0);
	O.BackgroundColor3 = L();
	O.BorderSizePixel = 0;
	O.Text = "";
	O.AutoButtonColor = false;
	O.Visible = false;
	O.ZIndex = 50;
	O.Parent = o.gui;
	Mk(O, 32);
	local T = fk(O, Color3.fromRGB(0, 0, 0), 3, 0);
	ak(function()
		O.BackgroundColor3 = L();
	end);
	o.ui.expandCircle = O;
	local M = false;
	local G = false;
	local f = nil;
	local W = nil;
	O.InputBegan:Connect(function(q)
		if q.UserInputType == Enum.UserInputType.MouseButton1 or q.UserInputType == Enum.UserInputType.Touch then
			M = true;
			G = false;
			f = q.Position;
			W = O.Position;
			q.Changed:Connect(function()
				if q.UserInputState == Enum.UserInputState.End then
					M = false;
				end;
			end);
		end;
	end);
	J(Y.InputChanged:Connect(function(q)
		if not M then
			return;
		end;
		if q.UserInputType == Enum.UserInputType.MouseMovement or q.UserInputType == Enum.UserInputType.Touch then
			local s = q.Position - f;
			if math.abs(s.X) > 3 or math.abs(s.Y) > 3 then
				G = true;
			end;
			O.Position = UDim2.new(W.X.Scale, W.X.Offset + s.X, W.Y.Scale, W.Y.Offset + s.Y);
		end;
	end));
	local F = Instance.new("TextLabel");
	F.AnchorPoint = Vector2.new(.5, .5);
	F.Size = UDim2.fromScale(.55, .55);
	F.Position = UDim2.fromScale(.34, .52);
	F.BackgroundTransparency = 1;
	F.Font = Enum.Font.GothamBlack;
	F.TextSize = 26;
	F.TextColor3 = Q();
	F.TextStrokeTransparency = 0;
	F.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	F.Text = "X";
	F.Rotation = -8;
	F.ZIndex = 52;
	F.Parent = O;
	local D = Instance.new("TextLabel");
	D.AnchorPoint = Vector2.new(.5, .5);
	D.Size = UDim2.fromScale(.5, .55);
	D.Position = UDim2.fromScale(.68, .52);
	D.BackgroundTransparency = 1;
	D.Font = Enum.Font.GothamBlack;
	D.TextSize = 24;
	D.TextColor3 = Q();
	D.TextStrokeTransparency = 0;
	D.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	D.Text = "D";
	D.Rotation = 6;
	D.ZIndex = 52;
	D.Parent = O;
	ak(function()
		T.Color = Color3.fromRGB(0, 0, 0);
		if not c.CircleRainbowOutline then
			F.TextStrokeColor3 = Q();
			D.TextStrokeColor3 = Q();
		end;
		if not c.CircleRainbowText then
			F.TextColor3 = Q();
			D.TextColor3 = Q();
		end;
	end);
	task.spawn(function()
		local q = 0;
		while o.running and not o.unloaded do
			if c.CircleRainbowOutline then
				local s = Color3.fromHSV(q, 1, 1);
				pcall(function()
					F.TextStrokeColor3 = s;
					D.TextStrokeColor3 = s;
				end);
			end;
			if c.CircleRainbowText then
				local s = Color3.fromHSV(((q + .5)) % 1, 1, 1);
				pcall(function()
					F.TextColor3 = s;
					D.TextColor3 = s;
				end);
			end;
			q = ((q + .008 * ((c.CircleRainbowSpeed or 1)))) % 1;
			a.RenderStepped:Wait();
		end;
	end);
	local h = false;
	local K = nil;
	local C = nil;
	local b = nil;
	local function d(Y)
		if o.unloaded or not o.panel or not o.panel.Parent then
			return;
		end;
		Y = Y and true or false;
		if Y == h then
			return;
		end;
		h = Y;
		local a = tonumber(c.MenuAnimSpeed) or .35;
		local T = tonumber(c.MenuDodgeAnimSpeed) or .5;
		if Y then
			K = o.panel.Position;
			C = o.shadow.Position;
			b = o.glow.Position;
			local q = TweenInfo.new(a, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			(S:Create(o.panel, q, { Position = UDim2.new(o.panel.Position.X.Scale, o.panel.Position.X.Offset - 800, o.panel.Position.Y.Scale, o.panel.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(S:Create(o.shadow, q, { Position = UDim2.new(o.shadow.Position.X.Scale, o.shadow.Position.X.Offset - 800, o.shadow.Position.Y.Scale, o.shadow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(S:Create(o.glow, q, { Position = UDim2.new(o.glow.Position.X.Scale, o.glow.Position.X.Offset - 800, o.glow.Position.Y.Scale, o.glow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			task.delay(a + .02, function()
				if o.unloaded or not h then
					return;
				end;
				o.panel.Visible = false;
				o.shadow.Visible = false;
				o.glow.Visible = false;
				o.panel.BackgroundTransparency = 0;
				o.shadow.BackgroundTransparency = .65;
				o.glow.BackgroundTransparency = .86;
				O.Visible = true;
				O.Size = UDim2.fromOffset(0, 0);
				local q = tonumber(c.CircleSize) or 64;
				(S:Create(O, TweenInfo.new(T, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(q, q) })):Play();
			end);
		else
			O.Visible = false;
			O.Size = UDim2.fromOffset(0, 0);
			o.panel.Visible = true;
			o.shadow.Visible = true;
			o.glow.Visible = true;
			local Y = -q / 2 - 800;
			local T = -s / 2;
			o.panel.Position = UDim2.new(.5, Y, .5, T);
			o.shadow.Position = UDim2.new(.5, Y + 6, .5, T + 6);
			o.glow.Position = UDim2.new(.5, Y - 20, .5, T - 20);
			o.panel.BackgroundTransparency = 1;
			o.shadow.BackgroundTransparency = 1;
			o.glow.BackgroundTransparency = 1;
			local M = TweenInfo.new(a, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			(S:Create(o.panel, M, { Position = UDim2.new(.5, -q / 2, .5, -s / 2), BackgroundTransparency = 0 })):Play();
			(S:Create(o.shadow, M, { Position = UDim2.new(.5, -q / 2 + 6, .5, -s / 2 + 6), BackgroundTransparency = .65 })):Play();
			(S:Create(o.glow, M, { Position = UDim2.new(.5, -q / 2 - 20, .5, -s / 2 - 20), BackgroundTransparency = .86 })):Play();
		end;
	end;
	_G.__adSetCollapsed = d;
	_G.__adIsCollapsed = function()
			return h;
		end;
	if o.ui.collapseBtn then
		o.ui.collapseBtn.MouseButton1Click:Connect(function()
			if o.unloaded then
				return;
			end;
			Sk();
			d(true);
		end);
	end;
	O.MouseButton1Click:Connect(function()
		if o.unloaded then
			return;
		end;
		if G then
			G = false;
			return;
		end;
		Sk();
		d(false);
	end);
end;
local function b9(q, s)
	local Y, O = pcall(s);
	if not Y then
		print("[XD] BUILD ERROR in " .. (tostring(q) .. ":"), tostring(O));
		warn("[XD] BUILD ERROR in " .. (tostring(q) .. ":"), tostring(O));
	end;
end;
b9("buildPanel", o.ui.buildPanel);
b9("buildMain", o.ui.buildMain);
b9("buildHnS", o.ui.buildHnS);
b9("buildRebel", o.ui.buildRebel);
b9("buildRLGL", o.ui.buildRLGL);
b9("buildESP", o.ui.buildESP);
b9("buildDalgona", o.ui.buildDalgona);
b9("buildExtra", o.ui.buildExtra);
b9("buildConfigs", o.ui.buildConfigs);
b9("buildCollapseCircle", o.ui.buildCollapseCircle);
pcall(bk);
pcall(dk);
pcall(S9);
if c.PanelRainbow then
	W4();
end;
if c.FullBright then
	H4(true);
end;
if c.RemoveFog then
	B4(true);
end;
do
	if F then
		local q = nil;
		local function s()
			if q then
				q.cancelled = true;
				q = nil;
			end;
		end;
		pcall(function()
			F.PromptButtonHoldBegan:Connect(function(Y, O)
				if o.unloaded or O ~= D or not c.InstantInteract then
					return;
				end;
				s();
				if c.InstantInteractInsta then
					pcall(fireproximityprompt, Y);
					return;
				end;
				local a = { cancelled = false };
				q = a;
				task.spawn(function()
					local q = tonumber(c.InstantInteractMult) or 2;
					if q < .5 then
						q = .5;
					end;
					local s = 1 / q;
					while not a.cancelled and (not o.unloaded and c.InstantInteract) do
						pcall(fireproximityprompt, Y);
						task.wait(s);
					end;
				end);
			end);
		end);
		pcall(function()
			F.PromptButtonHoldEnded:Connect(function(q, Y)
				if Y ~= D then
					return;
				end;
				s();
			end);
		end);
	end;
end;
o.toggleMenu = function()
		if o.unloaded then
			return;
		end;
		if o.bindingMenuKey then
			return;
		end;
		if not o.panel or not o.panel.Parent then
			return;
		end;
		local q = tick();
		if q - o.lastMenuToggle < .15 then
			return;
		end;
		o.lastMenuToggle = q;
		Sk();
		if _G.__adSetCollapsed and _G.__adIsCollapsed then
			local q = _G.__adIsCollapsed();
			_G.__adSetCollapsed(not q);
		else
			o.panel.Visible = not o.panel.Visible;
			if o.shadow then
				o.shadow.Visible = o.panel.Visible;
			end;
			if o.glow then
				o.glow.Visible = o.panel.Visible;
			end;
		end;
	end;
o.rebindMenu = function()
		if o.menuAction then
			pcall(function()
				O:UnbindAction(o.menuAction);
			end);
		end;
		o.menuAction = "XDMenu_" .. sk(6);
		pcall(function()
			O:BindAction(o.menuAction, function(q, s)
				if s ~= Enum.UserInputState.Begin then
					return;
				end;
				o.toggleMenu();
			end, false, c.MenuKey);
		end);
	end;
o.rebindMenu();
J(Y.InputBegan:Connect(function(q)
	if o.unloaded or o.bindingMenuKey then
		return;
	end;
	if q.UserInputType ~= Enum.UserInputType.Keyboard then
		return;
	end;
	if q.KeyCode ~= c.MenuKey then
		return;
	end;
	o.toggleMenu();
end));
o.doFullUnload = function()
		if o.unloaded then
			return;
		end;
		if o.panel and (o.panel.Parent and o.panel.Visible) then
			local q = o.panel.Position.X.Scale;
			local s = o.panel.Position.Y.Scale;
			local Y = o.panel.Position.X.Offset;
			local O = o.panel.Position.Y.Offset;
			local a = TweenInfo.new(.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			pcall(function()
				(S:Create(o.panel, a, { Position = UDim2.new(q, Y - 800, s, O), BackgroundTransparency = 1 })):Play();
				(S:Create(o.shadow, a, { Position = UDim2.new(q, (Y - 800) + 6, s, O + 6), BackgroundTransparency = 1 })):Play();
				(S:Create(o.glow, a, { Position = UDim2.new(q, (Y - 800) - 20, s, O - 20), BackgroundTransparency = 1 })):Play();
			end);
			task.wait(.42);
		end;
		_G.__adUnloaded = true;
		o.running = false;
		pcall(O4);
		pcall(a4);
		pcall(T4);
		pcall(f4);
		pcall(U4);
		if o.btAnimConn then
			pcall(function()
				o.btAnimConn:Disconnect();
			end);
			o.btAnimConn = nil;
		end;
		if o._nickLoop then
			pcall(function()
				task.cancel(o._nickLoop);
			end);
			o._nickLoop = nil;
		end;
		pcall(function()
			H4(false);
		end);
		pcall(function()
			B4(false);
		end);
		if o.notifHolder then
			pcall(function()
				o.notifHolder:Destroy();
			end);
			o.notifHolder = nil;
		end;
		o.unloaded = true;
		pcall(function()
			c.Enabled = false;
			v.Enabled = false;
			c.RadiusVis = false;
			v.RadiusVis = false;
			c.AnimSpeed = false;
			c.GuardESP = false;
			c.PlayerESP = false;
			c.RemoveHands = false;
			c.RemoveLegs = false;
			c.RemoveTorso = false;
			c.Headless = false;
			c.Korblox = false;
			c.HideNick = false;
			c.FullBright = false;
			c.RemoveFog = false;
			c.AutoBrew = false;
			c.BulletTracer = false;
			o.oneClickDalgona = false;
			c.RLGL_AutoDodge = false;
			c.RLGL_TimerEndDodge = false;
			c.RebelSilentAim = false;
			c.RebelNoRecoil = false;
			c.RebelRapidFire = false;
			c.RebelFOVCircle = false;
		end);
		pcall(function()
			for q, s in pairs(_G.__dalgonaCache) do
				if q and q.Parent then
					pcall(function()
						q.Position = s.Position;
						q.Transparency = s.Transparency;
					end);
				end;
			end;
			table.clear(_G.__dalgonaCache);
		end);
		pcall(function()
			for q, s in pairs(o.origTransparency) do
				if q and q.Parent then
					pcall(function()
						q.LocalTransparencyModifier = 0;
						q.Transparency = s;
					end);
				end;
			end;
			table.clear(o.origTransparency);
			local function q(q)
				for s = 1, #q, 1 do
					local Y = q[s];
					if Y and Y.Parent then
						pcall(function()
							Y.LocalTransparencyModifier = 0;
						end);
					end;
				end;
			end;
			q(o.handCache);
			q(o.legCache);
			q(o.torsoCache);
			table.clear(o.handCache);
			table.clear(o.legCache);
			table.clear(o.torsoCache);
		end);
		pcall(function()
			a9(false);
		end);
		pcall(function()
			s9(false);
		end);
		pcall(wk);
		pcall(p4);
		pcall(R4);
		pcall(T9);
		pcall(c4);
		for q = 1, #o.conns, 1 do
			pcall(function()
				if o.conns[q] and o.conns[q].Disconnect then
					o.conns[q]:Disconnect();
				end;
			end);
		end;
		table.clear(o.conns);
		for q, s in pairs(o.added) do
			pcall(function()
				if s and s.Disconnect then
					s:Disconnect();
				end;
			end);
		end;
		table.clear(o.added);
		if o.handsConn then
			pcall(function()
				o.handsConn:Disconnect();
			end);
			o.handsConn = nil;
		end;
		if o.dalgonaConn then
			pcall(function()
				o.dalgonaConn:Disconnect();
			end);
			o.dalgonaConn = nil;
		end;
		if o.tracerGui then
			pcall(function()
				o.tracerGui:Destroy();
			end);
			o.tracerGui = nil;
		end;
		if o.overlayGui then
			pcall(function()
				o.overlayGui:Destroy();
			end);
			o.overlayGui = nil;
		end;
		if o.infoGui then
			pcall(function()
				o.infoGui:Destroy();
			end);
			o.infoGui = nil;
		end;
		if o.menuAction then
			pcall(function()
				O:UnbindAction(o.menuAction);
			end);
			o.menuAction = nil;
		end;
		if o.clickSound then
			pcall(function()
				o.clickSound:Destroy();
			end);
			o.clickSound = nil;
		end;
		pcall(function()
			if o.gui then
				o.gui.Enabled = false;
				for q, s in ipairs(o.gui:GetDescendants()) do
					pcall(function()
						if s and s.Destroy then
							s:Destroy();
						end;
					end);
				end;
				o.gui:Destroy();
			end;
		end);
		o.gui = nil;
		o.shadow = nil;
		o.glow = nil;
		o.panel = nil;
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
_G.__XD_UNLOAD = o.doFullUnload;
task.spawn(function()
	while o.running and not o.unloaded do
		pcall(function()
			if c.AnimSpeed then
				local q = D.Character;
				local s = q and q:FindFirstChildOfClass("Humanoid");
				local Y = s and s:FindFirstChildOfClass("Animator");
				if Y then
					local q = c.AnimSpeedValue or 2.5;
					for s, Y in ipairs(Y:GetPlayingAnimationTracks()) do
						pcall(function()
							if Y.Speed ~= q then
								Y:AdjustSpeed(q);
							end;
						end);
					end;
				end;
			end;
			if c.RemoveHands or c.RemoveLegs or c.RemoveTorso then
				Z4();
			end;
			if c.Headless then
				s9(true);
			end;
			if c.Korblox then
				a9(true);
			end;
			if c.Enabled or v.Enabled then
				o.cachedUITool = pk();
				o.cachedDodgeTool = Rk();
				o.cachedSlot = kk(o.cachedUITool, "T", c.ManualUISlot);
				o.cachedDodgeSlot = kk(o.cachedDodgeTool, "1", c.ManualHnSSlot);
			end;
			if ((c.RebelSilentAim or c.RebelNoRecoil or c.RebelRapidFire)) and not o.combatHooked then
				Y4();
			end;
		end);
		task.wait(.1);
	end;
end);
task.spawn(function()
	while o.running and not o.unloaded do
		if c.GuardESP or c.PlayerESP then
			pcall(x4);
		end;
		task.wait(.5);
	end;
end);
task.spawn(function()
	while o.running and not o.unloaded do
		pcall(function()
			local q = {};
			if c.Enabled then
				table.insert(q, "ui " .. o.cachedSlot);
			end;
			if v.Enabled then
				table.insert(q, "hns " .. o.cachedDodgeSlot);
			end;
			if c.RebelSilentAim then
				table.insert(q, "aim");
			end;
			if c.RebelNoRecoil then
				table.insert(q, "norec");
			end;
			if c.RebelRapidFire then
				table.insert(q, "rapid");
			end;
			if c.BulletTracer then
				table.insert(q, "btracer");
			end;
			if c.RLGL_AutoDodge then
				table.insert(q, "rlgl");
			end;
			if c.RLGL_TimerEndDodge then
				table.insert(q, "timer-end");
			end;
			if c.HideNick then
				table.insert(q, "hide-nick");
			end;
			if c.AutoBrew then
				table.insert(q, "auto-brew");
			end;
			if o.oneClickDalgona then
				table.insert(q, "dalgona ON");
			end;
			if c.GuardESP or c.PlayerESP then
				table.insert(q, string.format("esp %d/%d", _G.__adEspDone or 0, _G.__adEspTotal or 0));
			end;
			if c.AnimSpeed then
				table.insert(q, "anim");
			end;
			if _G.__ad_statusCb then
				if #q == 0 then
					_G.__ad_statusCb("paused - N");
				else
					_G.__ad_statusCb(table.concat(q, " - "));
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
	while o.running and not o.unloaded do
		pcall(function()
			local q = _G.__rlgl_isOnMap();
			if not q then
				_G.__rlglLastSec = nil;
				_G.__rlglTimerEndedAt = 0;
				_G.__rlglWasRed = false;
				task.wait(.5);
				return;
			end;
			if c.RLGL_AutoDodge then
				local q = _G.__rlgl_isRed();
				local s = _G.__rlgl_isMoving(c.RLGL_VelThreshold or .3);
				local Y = _G.__rlgl_inSafeZone();
				if q and not _G.__rlglWasRed then
					_G.__rlglRedStartAt = tick();
				end;
				_G.__rlglWasRed = q;
				local O = q and (tick() - _G.__rlglRedStartAt) or 0;
				local a = c.RLGL_RedDelay or .1;
				local T = true;
				if Y then
					T = false;
				end;
				if c.RLGL_OnlyRedLight and T then
					if not q then
						T = false;
					end;
					if O < a then
						T = false;
					end;
				end;
				if T and not s then
					T = false;
				end;
				local S = tick();
				if T and (S - _G.__rlglLast) >= ((c.RLGL_MinInterval or .15)) then
					_G.__rlglLast = S;
					task.spawn(_G.__rlgl_fireDodge);
				end;
			end;
			if c.RLGL_TimerEndDodge then
				local q = _G.__rlgl_timerSeconds();
				local s = _G.__rlgl_inSafeZone();
				local Y = _G.__rlgl_inFinishZone();
				if q ~= nil then
					_G.__rlglLastSec = q;
				end;
				if q ~= nil and q > 10 then
					_G.__rlglTimerEndedAt = 0;
				end;
				local O = false;
				if q ~= nil and q <= 0 then
					O = true;
				end;
				if q == nil and (_G.__rlglLastSec and _G.__rlglLastSec <= 3) then
					O = true;
				end;
				if O and _G.__rlglTimerEndedAt == 0 then
					_G.__rlglTimerEndedAt = tick();
					_G.__rlglLastFire = 0;
				end;
				if _G.__rlglTimerEndedAt > 0 and (not s and not Y) then
					local q = c.RLGL_TimerEndDelay or 0;
					local s = c.RLGL_TimerEndInterval or .15;
					local Y = c.RLGL_TimerEndMaxDuration or 12;
					local O = tick() - _G.__rlglTimerEndedAt;
					if O > Y then
						_G.__rlglTimerEndedAt = 0;
					elseif O >= q then
						local q = tick();
						if _G.__rlglLastFire == 0 or (q - _G.__rlglLastFire >= s) then
							_G.__rlglLastFire = q;
							task.spawn(_G.__rlgl_fireDodge);
						end;
					end;
				end;
			end;
		end);
		task.wait(.05);
	end;
end);
J(D.CharacterAdded:Connect(function(q)
	task.wait(.5);
	if o.unloaded then
		return;
	end;
	Z4();
	if c.RemoveHands then
		t4(true);
	end;
	if c.RemoveLegs then
		l4(true);
	end;
	if c.RemoveTorso then
		i4(true);
	end;
	if c.Headless then
		s9(true);
	end;
	if c.Korblox then
		a9(true);
	end;
end));
if D.Character then
	J(D.Character.DescendantAdded:Connect(function()
		if o.unloaded then
			return;
		end;
		if c.RemoveHands or c.RemoveLegs or c.RemoveTorso or c.Headless or c.Korblox then
			task.defer(function()
				Z4();
				if c.RemoveHands then
					t4(true);
				end;
				if c.RemoveLegs then
					l4(true);
				end;
				if c.RemoveTorso then
					i4(true);
				end;
				if c.Headless then
					s9(true);
				end;
				if c.Korblox then
					a9(true);
				end;
			end);
		end;
	end));
end;
q9();
do
	local function s(q)
		if not q or q == D then
			return;
		end;
		J((q:GetPropertyChangedSignal("Team")):Connect(function()
			if not o.unloaded and ((c.GuardESP or c.PlayerESP)) then
				task.defer(x4);
			end;
		end));
	end;
	for q, Y in ipairs(q:GetPlayers()) do
		s(Y);
	end;
	J(q.PlayerAdded:Connect(s));
end;
pcall(function()
	if o.FILE.isfile and o.FILE.isfile(f9("default")) then
		K9("default");
	end;
end);
if getgenv then
	(getgenv()).__ui_dodge = { shutdown = o.doFullUnload, config = c, H = v };
end;
if _G.__adStatusCb then
	_G.__adStatusCb("ready - N");
end;
print("[XD] LOADED", h, K);
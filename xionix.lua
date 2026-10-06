local u = game:GetService("Players");
local E = game:GetService("Workspace");
local W = game:GetService("UserInputService");
local U = game:GetService("ContextActionService");
local Q = game:GetService("RunService");
local A = game:GetService("HttpService");
local y = game:GetService("TweenService");
local K = game:GetService("SoundService");
local l = game:GetService("Stats");
local O = game:GetService("Lighting");
local q = game:GetService("ReplicatedStorage");
local x = nil;
pcall(function()
	x = game:GetService("ProximityPromptService");
end);
local k = u.LocalPlayer;
while not k do
	task.wait(.1);
	k = u.LocalPlayer;
end;
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
local f = "x1oni1x dew4mp 1NK (X/D)";
local Z = "v5.5";
local D = {};
D.FILE = ((function()
		local u = (getgenv and getgenv()) or _G;
		local function E(E)
			local W = _G[E] or rawget(_G, E);
			if W then
				return W;
			end;
			if u and u[E] then
				return u[E];
			end;
			return nil;
		end;
		return {
			writefile = E("writefile"),
			readfile = E("readfile"),
			isfile = E("isfile"),
			isfolder = E("isfolder"),
			makefolder = E("makefolder"),
			listfiles = E("listfiles"),
			delfile = E("delfile"),
		};
	end))();
D.running = true;
D.unloaded = false;
D.conns = {};
D.hooks = {};
D.added = {};
D.oneClickDalgona = false;
D.dalgonaConn = nil;
D.cachedSlot = "T";
D.cachedDodgeSlot = "1";
D.cachedUITool = nil;
D.cachedDodgeTool = nil;
D.lastDodgeUI = 0;
D.lastDodgeH = 0;
D.lastMenuToggle = 0;
D.gui = nil;
D.shadow = nil;
D.glow = nil;
D.panel = nil;
D.tracerGui = nil;
D.overlayGui = nil;
D.infoGui = nil;
D.wmFrame = nil;
D.wmLabel = nil;
D.kbFrame = nil;
D.kbLabel = nil;
D.menuAction = nil;
D.clickSound = nil;
D.combatHooked = false;
D.origFiredGun = nil;
D.origGetBuffs = nil;
D.gunMod = nil;
D.fovGui = nil;
D.fovFrame = nil;
D.fovStroke = nil;
D.colorPickerOpen = nil;
D.fovRainbowConn = nil;
D.panelRainbowConn = nil;
D.notifHolder = nil;
D.fbInst = nil;
D.fogBackup = nil;
D.bindingMenuKey = false;
D.currentConfigName = "default";
D.animEnabled = {};
D.hideConns = {};
D.handCache = {};
D.legCache = {};
D.torsoCache = {};
D.origTransparency = {};
D.handsConn = nil;
D.korbloxData = {};
D.lastBrewTick = 0;
D.brewLoopConn = nil;
D.activeNotifs = {};
D.btAnimConn = nil;
D.btLastIdTime = {};
D.btLastShot = 0;
D._nickLoop = nil;
D.menuOpen = true;
D.menuTweens = {};
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
	local u = {};
	if gethui then
		pcall(function()
			table.insert(u, gethui());
		end);
	end;
	pcall(function()
		table.insert(u, game:GetService("CoreGui"));
	end);
	if k then
		pcall(function()
			table.insert(u, k:FindFirstChildOfClass("PlayerGui"));
		end);
	end;
	for u, E in ipairs(u) do
		if E and typeof(E) == "Instance" then
			for u, E in ipairs(E:GetChildren()) do
				if E:IsA("ScreenGui") and (tostring(E.Name)):find("^XD_") then
					pcall(function()
						E:Destroy();
					end);
				end;
			end;
		end;
	end;
end;
local V = {
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
local X = {};
for u, E in pairs(V) do
	X[u] = E;
	local W = u:match("%d+");
	if W then
		X[W] = E;
	end;
end;
local function m(u, E, W, U, Q, A, y, K, l, O, q, x, k, f, Z, D)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(u, E, W)),
		ColorSequenceKeypoint.new(.25, Color3.fromRGB(U, Q, A)),
		ColorSequenceKeypoint.new(.5, Color3.fromRGB(y, K, l)),
		ColorSequenceKeypoint.new(.75, Color3.fromRGB(O, q, x)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(k, f, Z)),
	});
end;
local I = {
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
		GuardESP_HP_ChipBg = true,
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
		PlayerESP_HP_ChipBg = true,
		PlayerESP_CustomName = "",
		PlayerESP_NameRainbow = false,
		PlayerESP_NameRainbowSpeed = 1,
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
		AutoBrewDelayCollect = 0,
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
local n = {
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
local v = {
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
local function i()
	local u = math.clamp(I.ESP_FontIdx or 1, 1, #v);
	local E = Enum.Font[v[u]];
	if not E then
		E = Enum.Font.GothamBlack;
	end;
	return E;
end;
local function T(u)
	local E, W, U;
	if u > .75 then
		E, W, U = I.GuardESP_HP_State1_R or 74, I.GuardESP_HP_State1_G or 222, I.GuardESP_HP_State1_B or 74;
	elseif u > .5 then
		E, W, U = I.GuardESP_HP_State2_R or 255, I.GuardESP_HP_State2_G or 210, I.GuardESP_HP_State2_B or 60;
	elseif u > .25 then
		E, W, U = I.GuardESP_HP_State3_R or 255, I.GuardESP_HP_State3_G or 130, I.GuardESP_HP_State3_B or 40;
	else
		E, W, U = I.GuardESP_HP_State4_R or 255, I.GuardESP_HP_State4_G or 55, I.GuardESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(E, W, U);
end;
local function g(u)
	local E, W, U;
	if u > .75 then
		E, W, U = I.PlayerESP_HP_State1_R or 74, I.PlayerESP_HP_State1_G or 222, I.PlayerESP_HP_State1_B or 74;
	elseif u > .5 then
		E, W, U = I.PlayerESP_HP_State2_R or 255, I.PlayerESP_HP_State2_G or 210, I.PlayerESP_HP_State2_B or 60;
	elseif u > .25 then
		E, W, U = I.PlayerESP_HP_State3_R or 255, I.PlayerESP_HP_State3_G or 130, I.PlayerESP_HP_State3_B or 40;
	else
		E, W, U = I.PlayerESP_HP_State4_R or 255, I.PlayerESP_HP_State4_G or 55, I.PlayerESP_HP_State4_B or 55;
	end;
	return Color3.fromRGB(E, W, U);
end;
local function b(u)
	if not u then
		return u;
	end;
	if D.unloaded then
		pcall(function()
			u:Disconnect();
		end);
		return u;
	end;
	table.insert(D.conns, u);
	return u;
end;
local function r()
	return Color3.fromRGB(I.GuiR or 200, I.GuiG or 60, I.GuiB or 255);
end;
local function S()
	return Color3.fromRGB(I.GuiTextR or 235, I.GuiTextG or 225, I.GuiTextB or 250);
end;
local function o(u)
	return u:Lerp(Color3.new(0, 0, 0), .7);
end;
local function J()
	return Color3.fromRGB(I.RadiusR or 255, I.RadiusG or 70, I.RadiusB or 160);
end;
local function j()
	return Color3.fromRGB(n.RadiusR or 70, n.RadiusG or 210, n.RadiusB or 255);
end;
local function N()
	return Color3.fromRGB(I.CircleTextR or 255, I.CircleTextG or 255, I.CircleTextB or 255);
end;
local function c(u)
	local E = math.clamp(u, 1, 9);
	local W, U, Q = 255, 60, 60;
	if E == 1 then
		W, U, Q = I.FOVCustomR1 or 255, I.FOVCustomG1 or 60, I.FOVCustomB1 or 60;
	elseif E == 2 then
		W, U, Q = I.FOVCustomR2 or 60, I.FOVCustomG2 or 255, I.FOVCustomB2 or 60;
	elseif E == 3 then
		W, U, Q = I.FOVCustomR3 or 60, I.FOVCustomG3 or 140, I.FOVCustomB3 or 255;
	elseif E == 4 then
		W, U, Q = I.FOVCustomR4 or 255, I.FOVCustomG4 or 255, I.FOVCustomB4 or 60;
	elseif E == 5 then
		W, U, Q = I.FOVCustomR5 or 255, I.FOVCustomG5 or 60, I.FOVCustomB5 or 255;
	elseif E == 6 then
		W, U, Q = I.FOVCustomR6 or 60, I.FOVCustomG6 or 255, I.FOVCustomB6 or 255;
	elseif E == 7 then
		W, U, Q = I.FOVCustomR7 or 255, I.FOVCustomG7 or 180, I.FOVCustomB7 or 60;
	elseif E == 8 then
		W, U, Q = I.FOVCustomR8 or 255, I.FOVCustomG8 or 255, I.FOVCustomB8 or 255;
	elseif E == 9 then
		W, U, Q = I.FOVCustomR9 or 180, I.FOVCustomG9 or 60, I.FOVCustomB9 or 255;
	end;
	return Color3.fromRGB(W, U, Q);
end;
local function d()
	if I.FOVUseCustom then
		return c(I.FOVCustomIdx or 1);
	end;
	return Color3.fromRGB(I.RebelFOVR or 255, I.RebelFOVG or 60, I.RebelFOVB or 60);
end;
local function h()
	return Color3.fromRGB(I.RebelFOV_OutlineR or 0, I.RebelFOV_OutlineG or 0, I.RebelFOV_OutlineB or 0);
end;
local function L()
	return Color3.fromRGB(I.GuardESP_ColorR or 255, I.GuardESP_ColorG or 50, I.GuardESP_ColorB or 50);
end;
local function w()
	return Color3.fromRGB(I.PlayerESP_ColorR or 80, I.PlayerESP_ColorG or 255, I.PlayerESP_ColorB or 120);
end;
local function P()
	return Color3.fromRGB(I.GuardESP_TracerR or 255, I.GuardESP_TracerG or 50, I.GuardESP_TracerB or 50);
end;
local function e()
	return Color3.fromRGB(I.PlayerESP_TracerR or 80, I.PlayerESP_TracerG or 255, I.PlayerESP_TracerB or 120);
end;
local function a()
	return Color3.fromRGB(I.GuardESP_BoxR or 255, I.GuardESP_BoxG or 50, I.GuardESP_BoxB or 50);
end;
local function p()
	return Color3.fromRGB(I.PlayerESP_BoxR or 80, I.PlayerESP_BoxG or 255, I.PlayerESP_BoxB or 120);
end;
local function z()
	return Color3.fromRGB(I.GuardESP_SkeletonR or 255, I.GuardESP_SkeletonG or 50, I.GuardESP_SkeletonB or 50);
end;
local function M()
	return Color3.fromRGB(I.PlayerESP_SkeletonR or 80, I.PlayerESP_SkeletonG or 255, I.PlayerESP_SkeletonB or 120);
end;
local function F()
	return m(I.GuardESP_HP_TopR or 80, I.GuardESP_HP_TopG or 255, I.GuardESP_HP_TopB or 80, I.GuardESP_HP_M1R or 180, I.GuardESP_HP_M1G or 255, I.GuardESP_HP_M1B or 60, I.GuardESP_HP_M2R or 255, I.GuardESP_HP_M2G or 200, I.GuardESP_HP_M2B or 40, I.GuardESP_HP_M3R or 255, I.GuardESP_HP_M3G or 120, I.GuardESP_HP_M3B or 60, I.GuardESP_HP_BotR or 255, I.GuardESP_HP_BotG or 40, I.GuardESP_HP_BotB or 40);
end;
local function C()
	return m(I.PlayerESP_HP_TopR or 80, I.PlayerESP_HP_TopG or 255, I.PlayerESP_HP_TopB or 80, I.PlayerESP_HP_M1R or 180, I.PlayerESP_HP_M1G or 255, I.PlayerESP_HP_M1B or 60, I.PlayerESP_HP_M2R or 255, I.PlayerESP_HP_M2G or 200, I.PlayerESP_HP_M2B or 40, I.PlayerESP_HP_M3R or 255, I.PlayerESP_HP_M3G or 120, I.PlayerESP_HP_M3B or 60, I.PlayerESP_HP_BotR or 255, I.PlayerESP_HP_BotG or 40, I.PlayerESP_HP_BotB or 40);
end;
local function R()
	return Color3.fromRGB(I.GuardESP_HP_State1_R or 74, I.GuardESP_HP_State1_G or 222, I.GuardESP_HP_State1_B or 74);
end;
local function t()
	return Color3.fromRGB(I.GuardESP_HP_State2_R or 255, I.GuardESP_HP_State2_G or 210, I.GuardESP_HP_State2_B or 60);
end;
local function s()
	return Color3.fromRGB(I.GuardESP_HP_State3_R or 255, I.GuardESP_HP_State3_G or 130, I.GuardESP_HP_State3_B or 40);
end;
local function B()
	return Color3.fromRGB(I.GuardESP_HP_State4_R or 255, I.GuardESP_HP_State4_G or 55, I.GuardESP_HP_State4_B or 55);
end;
local function H()
	return Color3.fromRGB(I.PlayerESP_HP_State1_R or 74, I.PlayerESP_HP_State1_G or 222, I.PlayerESP_HP_State1_B or 74);
end;
local function Y()
	return Color3.fromRGB(I.PlayerESP_HP_State2_R or 255, I.PlayerESP_HP_State2_G or 210, I.PlayerESP_HP_State2_B or 60);
end;
local function G()
	return Color3.fromRGB(I.PlayerESP_HP_State3_R or 255, I.PlayerESP_HP_State3_G or 130, I.PlayerESP_HP_State3_B or 40);
end;
local function u_()
	return Color3.fromRGB(I.PlayerESP_HP_State4_R or 255, I.PlayerESP_HP_State4_G or 55, I.PlayerESP_HP_State4_B or 55);
end;
local function E_(u)
	local E = "";
	for u = 1, u, 1 do
		E = E .. string.char(math.random(97, 122));
	end;
	return E;
end;
local function W_(u, E)
	return u + ((math.random() * 2 - 1)) * ((E or .006));
end;
local U_ = {};
local function Q_(u)
	table.insert(U_, u);
end;
local function A_()
	for u = 1, #U_, 1 do
		pcall(U_[u]);
	end;
end;
local function y_()
	if D.unloaded then
		return;
	end;
	pcall(function()
		if not D.clickSound then
			D.clickSound = Instance.new("Sound");
			D.clickSound.SoundId = "rbxassetid://876939830";
			D.clickSound.Volume = .3;
			D.clickSound.Parent = K;
		end;
		D.clickSound.TimePosition = 0;
		D.clickSound:Play();
	end);
end;
local function K_(u, E)
	local W = Instance.new("UICorner");
	W.CornerRadius = UDim.new(0, E or 8);
	W.Parent = u;
	return W;
end;
local function l_(u, E, W, U)
	local Q = Instance.new("UIGradient");
	Q.Color = ColorSequence.new(E, W);
	Q.Rotation = U or 90;
	Q.Parent = u;
	return Q;
end;
local function O_(u, E, W, U)
	local Q = Instance.new("UIStroke");
	Q.Color = E or Color3.new(1, 1, 1);
	Q.Thickness = W or 1;
	Q.Transparency = U or 0;
	Q.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	Q.Parent = u;
	return Q;
end;
local function q_()
	if D.tracerGui and D.tracerGui.Parent then
		return;
	end;
	D.tracerGui = Instance.new("ScreenGui");
	D.tracerGui.Name = "XD_Tr_" .. E_(6);
	D.tracerGui.IgnoreGuiInset = true;
	D.tracerGui.ResetOnSpawn = false;
	D.tracerGui.DisplayOrder = 99990;
	local u = nil;
	if gethui then
		local E, W = pcall(gethui);
		if E and (W and typeof(W) == "Instance") then
			u = W;
		end;
	end;
	if not u then
		u = k:FindFirstChildOfClass("PlayerGui");
	end;
	if not u then
		u = game:GetService("CoreGui");
	end;
	pcall(function()
		D.tracerGui.Parent = u;
	end);
	if not D.tracerGui.Parent then
		pcall(function()
			D.tracerGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local function x_()
	if D.overlayGui and D.overlayGui.Parent then
		return;
	end;
	D.overlayGui = Instance.new("ScreenGui");
	D.overlayGui.Name = "XD_Ov_" .. E_(6);
	D.overlayGui.IgnoreGuiInset = true;
	D.overlayGui.ResetOnSpawn = false;
	D.overlayGui.DisplayOrder = 99985;
	local u = nil;
	if gethui then
		local E, W = pcall(gethui);
		if E and (W and typeof(W) == "Instance") then
			u = W;
		end;
	end;
	if not u then
		u = k:FindFirstChildOfClass("PlayerGui");
	end;
	if not u then
		u = game:GetService("CoreGui");
	end;
	pcall(function()
		D.overlayGui.Parent = u;
	end);
	if not D.overlayGui.Parent then
		pcall(function()
			D.overlayGui.Parent = game:GetService("CoreGui");
		end);
	end;
end;
local k_ = {
		{ "Head", "Torso" },
		{ "Torso", "Left Arm" },
		{ "Torso", "Right Arm" },
		{ "Torso", "Left Leg" },
		{ "Torso", "Right Leg" },
		{ "Head", "HumanoidRootPart" },
	};
local f_ = {
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
local function Z_(u)
	return (string.lower(tostring(u or ""))):gsub("[%s%-_%.]", "");
end;
local function D_(u, E)
	if not u or not E then
		return nil;
	end;
	local W = u:FindFirstChild(E);
	if W and W:IsA("BasePart") then
		return W;
	end;
	local U = Z_(E);
	for u, E in ipairs(u:GetChildren()) do
		if E:IsA("BasePart") and Z_(E.Name) == U then
			return E;
		end;
	end;
	for u, E in ipairs(u:GetDescendants()) do
		if E:IsA("BasePart") and (E.Parent ~= nil and Z_(E.Name) == U) then
			return E;
		end;
	end;
	return nil;
end;
local function V_(u, E)
	if not u or not E then
		return nil;
	end;
	local W, U = math.huge, math.huge;
	local Q, A = -math.huge, -math.huge;
	local y = false;
	for u, K in ipairs(u:GetDescendants()) do
		if K:IsA("BasePart") then
			local u, l = E:WorldToViewportPoint(K.Position);
			if l then
				y = true;
				if u.X < W then
					W = u.X;
				end;
				if u.Y < U then
					U = u.Y;
				end;
				if u.X > Q then
					Q = u.X;
				end;
				if u.Y > A then
					A = u.Y;
				end;
			end;
		end;
	end;
	if not y then
		return nil;
	end;
	return W, U, Q, A;
end;
local function X_()
	if D.infoGui and D.infoGui.Parent then
		return;
	end;
	D.infoGui = Instance.new("ScreenGui");
	D.infoGui.Name = "XD_I_" .. E_(6);
	D.infoGui.IgnoreGuiInset = true;
	D.infoGui.ResetOnSpawn = false;
	D.infoGui.DisplayOrder = 99995;
	local u = nil;
	if gethui then
		local E, W = pcall(gethui);
		if E and (W and typeof(W) == "Instance") then
			u = W;
		end;
	end;
	if not u then
		u = k:FindFirstChildOfClass("PlayerGui");
	end;
	if not u then
		u = game:GetService("CoreGui");
	end;
	pcall(function()
		D.infoGui.Parent = u;
	end);
	if not D.infoGui.Parent then
		pcall(function()
			D.infoGui.Parent = game:GetService("CoreGui");
		end);
	end;
	D.wmFrame = Instance.new("Frame");
	D.wmFrame.AnchorPoint = Vector2.new(1, 0);
	D.wmFrame.Position = UDim2.new(1, -12, 0, 12);
	D.wmFrame.Size = UDim2.fromOffset(210, 52);
	D.wmFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	D.wmFrame.BackgroundTransparency = .25;
	D.wmFrame.BorderSizePixel = 0;
	D.wmFrame.ZIndex = 10;
	D.wmFrame.Parent = D.infoGui;
	K_(D.wmFrame, 6);
	local E = Instance.new("UIStroke");
	E.Color = r();
	E.Thickness = 1.2;
	E.Transparency = .3;
	E.Parent = D.wmFrame;
	Q_(function()
		E.Color = r();
	end);
	D.wmLabel = Instance.new("TextLabel");
	D.wmLabel.Size = UDim2.new(1, -12, 1, -4);
	D.wmLabel.Position = UDim2.fromOffset(6, 2);
	D.wmLabel.BackgroundTransparency = 1;
	D.wmLabel.Font = Enum.Font.Code;
	D.wmLabel.TextSize = 11;
	D.wmLabel.TextXAlignment = Enum.TextXAlignment.Left;
	D.wmLabel.TextYAlignment = Enum.TextYAlignment.Top;
	D.wmLabel.TextColor3 = Color3.fromRGB(220, 220, 240);
	D.wmLabel.TextStrokeTransparency = .4;
	D.wmLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	D.wmLabel.Text = f;
	D.wmLabel.ZIndex = 11;
	D.wmLabel.Parent = D.wmFrame;
	D.kbFrame = Instance.new("Frame");
	D.kbFrame.AnchorPoint = Vector2.new(1, 0);
	D.kbFrame.Position = UDim2.new(1, -12, 0, 72);
	D.kbFrame.Size = UDim2.fromOffset(210, 100);
	D.kbFrame.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
	D.kbFrame.BackgroundTransparency = .25;
	D.kbFrame.BorderSizePixel = 0;
	D.kbFrame.ZIndex = 10;
	D.kbFrame.Parent = D.infoGui;
	K_(D.kbFrame, 6);
	local W = Instance.new("UIStroke");
	W.Color = r();
	W.Thickness = 1.2;
	W.Transparency = .3;
	W.Parent = D.kbFrame;
	Q_(function()
		W.Color = r();
	end);
	D.kbLabel = Instance.new("TextLabel");
	D.kbLabel.Size = UDim2.new(1, -12, 1, -4);
	D.kbLabel.Position = UDim2.fromOffset(6, 2);
	D.kbLabel.BackgroundTransparency = 1;
	D.kbLabel.Font = Enum.Font.Code;
	D.kbLabel.TextSize = 10;
	D.kbLabel.TextXAlignment = Enum.TextXAlignment.Left;
	D.kbLabel.TextYAlignment = Enum.TextYAlignment.Top;
	D.kbLabel.TextColor3 = Color3.fromRGB(200, 200, 220);
	D.kbLabel.TextStrokeTransparency = .5;
	D.kbLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
	D.kbLabel.Text = "[no features]";
	D.kbLabel.ZIndex = 11;
	D.kbLabel.Parent = D.kbFrame;
end;
local function m_()
	if not D.infoGui then
		return;
	end;
	if D.wmFrame then
		D.wmFrame.Visible = I.Watermark and true or false;
	end;
	if D.kbFrame then
		D.kbFrame.Visible = I.KeybindList and true or false;
	end;
end;
local I_ = {
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
local n_ = {
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
local v_ = {
		["131235569946744"] = .9,
		["114687917628569"] = 3.4,
		["115386570583557"] = .6,
		["70775136168849"] = .7,
		["132207921464999"] = .4,
	};
local i_, T_ = {}, {};
for u = 1, #I_, 1 do
	i_[I_[u]] = true;
	D.animEnabled[I_[u]] = true;
end;
for u = 1, #n_, 1 do
	T_[n_[u]] = true;
	D.animEnabled[n_[u]] = false;
end;
local g_ = {
		["power hold"] = true,
		powerhold = true,
		power_hold = true,
		["pocket sand"] = true,
		pocketsand = true,
		pocket_sand = true,
		sand = true,
	};
local function b_(u)
	if not u then
		return false;
	end;
	local E = (tostring(u)):match("%d+");
	if not E then
		return false;
	end;
	if T_[E] then
		return false;
	end;
	if i_[E] then
		return D.animEnabled[E] ~= false;
	end;
	for u in pairs(i_) do
		if D.animEnabled[u] ~= false and (not T_[u] and ((E:find(u, 1, true) or u:find(E, 1, true)))) then
			return true;
		end;
	end;
	return false;
end;
local function r_(u)
	if not u then
		return "";
	end;
	for u, E in ipairs(u:GetChildren()) do
		if E:IsA("Tool") then
			return E.Name;
		end;
	end;
	local E = u:FindFirstChildOfClass("Humanoid");
	if E then
		for u, E in ipairs(E:GetChildren()) do
			if E:IsA("Tool") then
				return E.Name;
			end;
		end;
	end;
	local W = u:GetAttribute("HoldingWeapon");
	if type(W) == "string" and W ~= "" then
		local E = u:FindFirstChild(W);
		if E then
			return E.Name;
		end;
		return W;
	end;
	return "";
end;
local function S_(u)
	if not u then
		return false;
	end;
	for u, E in ipairs(u:GetChildren()) do
		if E:IsA("Tool") then
			local u = string.lower(E.Name);
			for E in pairs(g_) do
				if u:find(E, 1, true) then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function o_(u)
	if not u then
		return false;
	end;
	for u, E in ipairs(u:GetDescendants()) do
		if E:IsA("ParticleEmitter") or E:IsA("Smoke") then
			local u = string.lower(E.Name);
			if u:find("sand", 1, true) or u:find("dust", 1, true) or u:find("dirt", 1, true) then
				if E.Enabled then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
local function J_(u)
	if not u or not u:IsA("Tool") then
		return false;
	end;
	local E = string.lower(u.Name);
	if E:find("ultra", 1, true) or E:find("instinct", 1, true) then
		return false;
	end;
	return E:find("dodge", 1, true) ~= nil;
end;
local j_ = {
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
local N_ = {
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
local c_ = (type(keypress) == "function" and type(keyrelease) == "function");
local function d_(u)
	if D.unloaded then
		return;
	end;
	u = string.lower(tostring(u or "t"));
	local E = j_[u];
	if not E then
		return;
	end;
	local W = Enum.KeyCode[string.upper(u)] or Enum.KeyCode.T;
	local U = pcall(function()
			local u = game:GetService("VirtualInputManager");
			u:SendKeyEvent(true, W, false, game);
			task.delay(W_(.006, .002), function()
				pcall(function()
					u:SendKeyEvent(false, W, false, game);
				end);
			end);
		end);
	if not U and c_ then
		pcall(function()
			keypress(E);
			task.delay(W_(.006, .002), function()
				pcall(function()
					keyrelease(E);
				end);
			end);
		end);
	end;
end;
local function h_()
	if D.unloaded then
		return;
	end;
	local u = E.CurrentCamera;
	local W = (u and u.ViewportSize) or Vector2.new(800, 600);
	local U = math.floor(W.X / 2);
	local Q = math.floor(W.Y / 2);
	local A = false;
	pcall(function()
		if mouse1click then
			mouse1click();
			A = true;
		end;
	end);
	if A then
		return;
	end;
	pcall(function()
		if mouse1press and mouse1release then
			mouse1press();
			task.wait(.03);
			mouse1release();
			A = true;
		end;
	end);
	if A then
		return;
	end;
	pcall(function()
		local u = game:GetService("VirtualInputManager");
		u:SendMouseButtonEvent(U, Q, 0, true, game, 1);
		task.wait(.03);
		u:SendMouseButtonEvent(U, Q, 0, false, game, 1);
	end);
end;
local function L_(u, E, W)
	if W and W ~= "" then
		local u = string.upper(tostring(W));
		if N_[u] then
			return u;
		end;
	end;
	return E;
end;
local function w_(u)
	local E = string.lower(tostring(u or ""));
	return E:find("ultra", 1, true) ~= nil or E:find("instinct", 1, true) ~= nil;
end;
local function P_()
	local function u(u)
		if not u then
			return nil;
		end;
		for u, E in ipairs(u:GetChildren()) do
			if E:IsA("Tool") and w_(E.Name) then
				return E;
			end;
		end;
		return nil;
	end;
	return u(k.Character) or u(k:FindFirstChild("Backpack"));
end;
local function e_()
	local function u(u)
		if not u then
			return nil;
		end;
		for u, E in ipairs(u:GetChildren()) do
			if J_(E) then
				return E;
			end;
		end;
		return nil;
	end;
	return u(k.Character) or u(k:FindFirstChild("Backpack"));
end;
local function a_()
	if D.unloaded or not I.Enabled then
		return;
	end;
	local u = tick();
	if u - D.lastDodgeUI < ((I.MinInterval or .02)) then
		return;
	end;
	D.lastDodgeUI = u;
	local E = D.cachedSlot or "T";
	local W = I.Delay or 0;
	if W > 0 then
		task.delay(W, function()
			if not D.unloaded and I.Enabled then
				d_(E);
			end;
		end);
	else
		d_(E);
	end;
end;
local function p_()
	if D.unloaded or not n.Enabled then
		return;
	end;
	local u = tick();
	if u - D.lastDodgeH < ((n.MinInterval or .02)) then
		return;
	end;
	D.lastDodgeH = u;
	local E = D.cachedDodgeTool or e_();
	local W = D.cachedDodgeSlot or "1";
	local U = n.Delay or 0;
	local function Q()
		if D.unloaded or not n.Enabled then
			return;
		end;
		local u = k.Character;
		local U = u and u:FindFirstChildOfClass("Humanoid");
		if E and U then
			d_(W);
			task.wait(.06);
			if E.Parent ~= u then
				pcall(function()
					U:EquipTool(E);
				end);
				task.wait(.06);
			end;
			pcall(function()
				E:Activate();
			end);
			task.wait(.02);
			h_();
			task.wait(.04);
			h_();
		else
			d_(W);
			task.wait(.05);
			h_();
		end;
	end;
	if U > 0 then
		task.delay(U, Q);
	else
		Q();
	end;
end;
local function z_(u, E, W, U)
	if not u or not E then
		return false;
	end;
	if E.Parent == k.Character then
		return false;
	end;
	local Q = u.Position.X - E.Position.X;
	local A = u.Position.Z - E.Position.Z;
	local y = u.Position.Y - E.Position.Y;
	if math.abs(y) > 7 then
		return false;
	end;
	local K = Q * Q + A * A;
	local l = ((W or 18)) + ((U or 0));
	if K > l * l then
		return false;
	end;
	return true, math.sqrt(K);
end;
local function M_()
	for u, E in pairs(D.hooks) do
		pcall(function()
			E:Disconnect();
		end);
	end;
	table.clear(D.hooks);
end;
local function F_()
	return I.Enabled or n.Enabled;
end;
local function C_(u, E, W)
	if D.unloaded or not F_() then
		return;
	end;
	if not E or not E.Parent then
		return;
	end;
	local U = _G.__adWatchers[E];
	if not U then
		U = { c = 0 };
		_G.__adWatchers[E] = U;
	end;
	if U.c >= 3 then
		return;
	end;
	U.c = U.c + 1;
	local A = W and 8 or 0;
	local y = false;
	local K = false;
	local l = false;
	if n.Enabled then
		if not n.HollyMode then
			l = true;
		elseif W then
			l = true;
		elseif u and (u.Animation and b_(u.Animation.AnimationId)) then
			l = true;
		end;
	end;
	local O = 0;
	if u and (u.Animation and not W) then
		local E = (tostring(u.Animation.AnimationId)):match("%d+");
		if E and v_[E] then
			O = v_[E];
		end;
	end;
	local q = 0;
	if u then
		local E, W = pcall(function()
				return u.Length;
			end);
		if E and (tonumber(W) and W > 0) then
			q = W;
		end;
	end;
	if not I.Enabled then
		y = true;
	end;
	if not n.Enabled or not l then
		K = true;
	end;
	if y and K then
		U.c = U.c - 1;
		if U.c <= 0 then
			_G.__adWatchers[E] = nil;
		end;
		return;
	end;
	local x = tick();
	local f = math.max(I.AnimWatch or .4, q + ((I.WatchAfter or .3)));
	local Z = math.max(n.AnimWatch or .4, q + ((n.WatchAfter or .3)));
	local V = math.max(f + O, Z + O);
	local X;
	local function m()
		if X then
			pcall(function()
				X:Disconnect();
			end);
			X = nil;
		end;
		U.c = U.c - 1;
		if U.c <= 0 then
			_G.__adWatchers[E] = nil;
		end;
	end;
	local function v()
		if D.unloaded or (y and K) then
			m();
			return;
		end;
		if tick() - x > V then
			m();
			return;
		end;
		local u = k.Character and k.Character:FindFirstChild("HumanoidRootPart");
		if not u or not E or not E.Parent then
			m();
			return;
		end;
		local W = tick() - x;
		local U = I.Distance or 18;
		local Q = n.Distance or 18;
		local q = E.AssemblyLinearVelocity;
		local f = math.sqrt(q.X * q.X + q.Z * q.Z);
		if f > 15 then
			local W = u.Position.X - E.Position.X;
			local A = u.Position.Z - E.Position.Z;
			local y = math.sqrt(W * W + A * A);
			if y > .5 then
				local u = ((q.X * W + q.Z * A)) / ((y * f));
				if u > .5 then
					local u = f * .2;
					U = U + u;
					Q = Q + u;
				end;
			end;
		end;
		if I.Enabled and (not y and W >= O) then
			if z_(u, E, U, A) then
				y = true;
				a_();
			end;
		end;
		if n.Enabled and (l and (not K and W >= O)) then
			if z_(u, E, Q, A) then
				K = true;
				p_();
			end;
		end;
		if y and K then
			m();
		end;
	end;
	X = Q.Heartbeat:Connect(v);
end;
local function R_(u, E)
	if not u or D.hooks[u] then
		return;
	end;
	D.hooks[u] = u.Activated:Connect(function()
			if D.unloaded or not F_() then
				return;
			end;
			if S_(E.Parent) then
				C_(nil, E, true);
			end;
		end);
end;
local function t_(u, E)
	if D.hooks[u] or D.unloaded then
		return;
	end;
	D.hooks[u] = u.AnimationPlayed:Connect(function(u)
			if D.unloaded or not F_() then
				return;
			end;
			if not u or not u.Animation then
				return;
			end;
			if E.Parent == k.Character then
				return;
			end;
			local W = (tostring(u.Animation.AnimationId)):match("%d+");
			if W and T_[W] then
				return;
			end;
			if b_(u.Animation.AnimationId) then
				C_(u, E, false);
				return;
			end;
			local U = E.Parent;
			if S_(U) and o_(U) then
				C_(u, E, true);
			end;
		end);
end;
local function s_(u)
	if D.unloaded or not u or u == k.Character then
		return;
	end;
	local E = u:FindFirstChildOfClass("Humanoid");
	local W = u:FindFirstChild("HumanoidRootPart");
	if not E or not W then
		return;
	end;
	local U = E:FindFirstChildOfClass("Animator");
	if U then
		t_(U, W);
	else
		local u;
		u = E.ChildAdded:Connect(function(E)
				if E:IsA("Animator") then
					t_(E, W);
					pcall(function()
						u:Disconnect();
					end);
				end;
			end);
		table.insert(D.hooks, u);
	end;
	for u, E in ipairs(u:GetChildren()) do
		if E:IsA("Tool") then
			R_(E, W);
		end;
	end;
	local Q;
	Q = u.ChildAdded:Connect(function(u)
			if u:IsA("Tool") then
				R_(u, W);
			end;
		end);
	table.insert(D.hooks, Q);
end;
local function B_()
	if D.unloaded then
		return;
	end;
	M_();
	for u, E in ipairs(u:GetPlayers()) do
		if E ~= k then
			if E.Character then
				s_(E.Character);
			end;
			if not D.added[E] then
				D.added[E] = E.CharacterAdded:Connect(function(u)
						if F_() and not D.unloaded then
							task.wait(.15);
							s_(u);
						end;
					end);
			end;
		end;
	end;
	if not D.added._j then
		D.added._j = u.PlayerAdded:Connect(function(u)
				if D.unloaded then
					return;
				end;
				D.added[u] = u.CharacterAdded:Connect(function(u)
						if F_() and not D.unloaded then
							task.wait(.15);
							s_(u);
						end;
					end);
			end);
	end;
	if not D.added._r then
		D.added._r = u.PlayerRemoving:Connect(function(u)
				if D.added[u] then
					pcall(function()
						D.added[u]:Disconnect();
					end);
					D.added[u] = nil;
				end;
			end);
	end;
end;
local function H_()
	if F_() then
		B_();
	else
		M_();
	end;
end;
local function Y_(u)
	if not u then
		return nil;
	end;
	local E = {};
	local function W(W)
		for W, U in ipairs(W) do
			local Q = D_(u, U);
			if Q then
				table.insert(E, Q);
				return;
			end;
		end;
	end;
	if I.RebelBodyHead then
		W({ "Head" });
	end;
	if I.RebelBodyTorso then
		W({ "Torso", "UpperTorso", "LowerTorso" });
	end;
	if I.RebelBodyHRP then
		W({ "HumanoidRootPart" });
	end;
	if I.RebelBodyLeftArm then
		W({ "Left Arm", "LeftUpperArm", "LeftLowerArm" });
	end;
	if I.RebelBodyRightArm then
		W({ "Right Arm", "RightUpperArm", "RightLowerArm" });
	end;
	if I.RebelBodyLeftLeg then
		W({ "Left Leg", "LeftUpperLeg", "LeftLowerLeg" });
	end;
	if I.RebelBodyRightLeg then
		W({ "Right Leg", "RightUpperLeg", "RightLowerLeg" });
	end;
	if #E == 0 then
		return u:FindFirstChild("Head") or u:FindFirstChild("HumanoidRootPart");
	end;
	return E[math.random(1, #E)];
end;
local function G_(u)
	if not u then
		return false;
	end;
	if ((I.RebelFOV or 0)) <= 0 then
		return true;
	end;
	local W = E.CurrentCamera;
	if not W then
		return false;
	end;
	local U, Q = W:WorldToViewportPoint(u.Position);
	if not Q then
		return false;
	end;
	local A = W.ViewportSize.X / 2;
	local y = W.ViewportSize.Y / 2;
	local K = U.X - A;
	local l = U.Y - y;
	return math.sqrt(K * K + l * l) <= I.RebelFOV;
end;
local function uL(E)
	if not E or E == k.Character or not E.Parent then
		return false;
	end;
	if not E:IsA("Model") then
		return false;
	end;
	local W = E:FindFirstChildOfClass("Humanoid");
	if not W or W.Health <= 0 then
		return false;
	end;
	local U = E:FindFirstChild("HumanoidRootPart");
	if not U then
		return false;
	end;
	local Q = k:GetAttribute("IsGuard") == true;
	local A = u:GetPlayerFromCharacter(E);
	if Q then
		local u = E:FindFirstChild("GuardCanKill") or U:FindFirstChild("GuardCanKillLockOn") or U:FindFirstChild("GuardCanKillLockOut");
		if u then
			return true;
		end;
		if I.RebelTargetPlayers and (A and (A ~= k and A:GetAttribute("IsGuard") ~= true)) then
			return true;
		end;
	else
		if I.RebelTargetPlayers and (A and (A ~= k and A:GetAttribute("IsGuard") == true)) then
			return true;
		end;
		if I.RebelTargetNPCs then
			if E.Name:match("Guard") then
				return true;
			end;
			if E:FindFirstChild("TypeOfGuard") then
				return true;
			end;
			local u = E:FindFirstChild("GuardCanKill") or U:FindFirstChild("GuardCanKillLockOut") or U:FindFirstChild("GuardCanKillLockOn");
			if u then
				return true;
			end;
		end;
	end;
	return false;
end;
local function EL(W)
	local U = E.CurrentCamera;
	if not U then
		return nil;
	end;
	local Q = U.ViewportSize.X / 2;
	local A = U.ViewportSize.Y / 2;
	local y, K = nil, math.huge;
	local l = {};
	local function O(u)
		if not u or l[u] then
			return;
		end;
		l[u] = true;
		if not uL(u) then
			return;
		end;
		local E = Y_(u);
		if not E or not G_(E) then
			return;
		end;
		local W, O = U:WorldToViewportPoint(E.Position);
		if not O then
			return;
		end;
		local q = W.X - Q;
		local x = W.Y - A;
		local k = math.sqrt(q * q + x * x);
		if k < K then
			K = k;
			y = E;
		end;
	end;
	local q = E:FindFirstChild("Live");
	if q then
		for u, E in ipairs(q:GetChildren()) do
			if E:IsA("Model") then
				O(E);
			end;
		end;
	end;
	local x = E:FindFirstChild("Characters");
	if x then
		for u, E in ipairs(x:GetChildren()) do
			if E:IsA("Model") then
				O(E);
			end;
		end;
	end;
	for u, E in ipairs(u:GetPlayers()) do
		if E ~= k and E.Character then
			O(E.Character);
		end;
	end;
	return y;
end;
local function WL()
	if D.combatHooked then
		return;
	end;
	local u = q;
	local E = u:FindFirstChild("Modules");
	if not E then
		pcall(function()
			E = u:WaitForChild("Modules", 2);
		end);
	end;
	if not E then
		return;
	end;
	local W = E:FindFirstChild("GunFunctions");
	if not W then
		pcall(function()
			W = E:WaitForChild("GunFunctions", 2);
		end);
	end;
	if not W then
		return;
	end;
	local U, Q = pcall(require, W);
	if not U or not Q or type(Q) ~= "table" then
		return;
	end;
	D.gunMod = Q;
	D.origFiredGun = Q.FiredGun;
	D.origGetBuffs = Q.GetBuffs;
	if type(D.origFiredGun) == "function" then
		Q.FiredGun = function(u, E, W, ...)
				if D.unloaded or not I.RebelSilentAim then
					return D.origFiredGun(u, E, W, ...);
				end;
				if u ~= k.Character then
					return D.origFiredGun(u, E, W, ...);
				end;
				W = W or {};
				local U = u and u:FindFirstChild("HumanoidRootPart");
				if not U then
					return D.origFiredGun(u, E, W, ...);
				end;
				local Q = U.Position;
				pcall(function()
					local E = u:GetAttribute("HoldingWeapon");
					if E then
						local W = u:FindFirstChild(E);
						if W then
							local u = W:FindFirstChild("FireFrom");
							if u then
								Q = u.Position;
							end;
						end;
					end;
				end);
				local A = EL(Q);
				if A then
					E = A.Position;
					W.CustomFireFrom = true;
					W.spread = 0;
				end;
				return D.origFiredGun(u, E, W, ...);
			end;
	end;
	if type(D.origGetBuffs) == "function" then
		Q.GetBuffs = function(...)
				local u = D.origGetBuffs(...);
				if type(u) ~= "table" then
					u = {};
				end;
				local E = {};
				for u, W in pairs(u) do
					E[u] = W;
				end;
				if I.RebelNoRecoil then
					E.RecoilDiv = 999999;
				end;
				if I.RebelRapidFire then
					E.FireRateMult = 9999;
				end;
				return E;
			end;
	end;
	D.combatHooked = true;
end;
local function UL()
	if not D.combatHooked or not D.gunMod then
		return;
	end;
	pcall(function()
		if D.origFiredGun then
			D.gunMod.FiredGun = D.origFiredGun;
		end;
		if D.origGetBuffs then
			D.gunMod.GetBuffs = D.origGetBuffs;
		end;
	end);
	D.combatHooked = false;
end;
local function QL()
	if D.fovGui then
		pcall(function()
			D.fovGui:Destroy();
		end);
	end;
	D.fovGui = nil;
	D.fovFrame = nil;
	D.fovStroke = nil;
end;
local function AL()
	if D.fovRainbowConn then
		pcall(function()
			D.fovRainbowConn:Disconnect();
		end);
		D.fovRainbowConn = nil;
	end;
end;
local function yL()
	if not D.fovFrame then
		return;
	end;
	for u, E in ipairs(D.fovFrame:GetChildren()) do
		if E:IsA("Frame") then
			for u, E in ipairs(E:GetChildren()) do
				if E:IsA("UIStroke") then
					local u = E:FindFirstChildOfClass("UIGradient");
					if u then
						u:Destroy();
					end;
				end;
			end;
		end;
	end;
	if D.fovStroke then
		local u = D.fovStroke:FindFirstChildOfClass("UIGradient");
		if u then
			u:Destroy();
		end;
	end;
end;
local function KL(u, E, W, U, Q, A)
	local y = c(1);
	local K = c(2);
	local l = c(3);
	local O = c(4);
	local q = ColorSequence.new({
			ColorSequenceKeypoint.new(0, u),
			ColorSequenceKeypoint.new(.11, E),
			ColorSequenceKeypoint.new(.22, W),
			ColorSequenceKeypoint.new(.33, U),
			ColorSequenceKeypoint.new(.44, Q),
			ColorSequenceKeypoint.new(.55, y),
			ColorSequenceKeypoint.new(.66, K),
			ColorSequenceKeypoint.new(.77, l),
			ColorSequenceKeypoint.new(.88, O),
			ColorSequenceKeypoint.new(1, u),
		});
	for u, E in ipairs(D.fovFrame:GetChildren()) do
		if E:IsA("Frame") and (E.Name ~= "BlackOuter" and E.Name ~= "BlackInner") then
			for u, E in ipairs(E:GetChildren()) do
				if E:IsA("UIStroke") and (E.Name ~= "BlackStrokeOuter" and (E.Name ~= "BlackStrokeInner" and E.Name ~= "InnerStroke")) then
					local u = E:FindFirstChildOfClass("UIGradient");
					if not u then
						u = Instance.new("UIGradient");
						u.Parent = E;
					end;
					u.Color = q;
					u.Rotation = A;
				end;
			end;
		end;
	end;
	if D.fovStroke then
		local u = D.fovStroke:FindFirstChildOfClass("UIGradient");
		if not u then
			u = Instance.new("UIGradient");
			u.Parent = D.fovStroke;
		end;
		u.Color = q;
		u.Rotation = A;
	end;
end;
local function lL()
	AL();
	D.fovRainbowConn = Q.RenderStepped:Connect(function()
			if D.unloaded or not I.FOVRainbow then
				return;
			end;
			if not D.fovFrame or not D.fovFrame.Parent then
				return;
			end;
			local u = tick();
			local E = I.FOVRainbowMode or 1;
			local W = I.FOVUseCustom;
			local U = tonumber(I.RebelFOVBlendSpeed) or .5;
			if E ~= 6 then
				yL();
			end;
			if E == 6 then
				local E = c(5);
				local W = c(6);
				local Q = c(7);
				local A = c(8);
				local y = c(9);
				KL(E, W, Q, A, y, (((u * U) * 60)) % 360);
				return;
			end;
			local Q;
			if E == 1 then
				if W then
					local E = c(1);
					local W = c(2);
					Q = E:Lerp(W, .5 + .5 * math.sin((u * U) * 2));
				else
					Q = Color3.fromHSV(((u * .35)) % 1, 1, 1);
				end;
			elseif E == 2 then
				if W then
					local E = c(1);
					local W = c(2);
					Q = E:Lerp(W, .5 + .5 * math.sin((u * U) * 3));
				else
					Q = Color3.fromHSV(((u * .2)) % 1, 1, .7 + .3 * math.sin(u * 3));
				end;
			elseif E == 3 then
				if W then
					local E = c(1);
					local W = c(2);
					local A = c(3);
					local y = .5 + .5 * math.sin((u * U) * 1.8);
					local K = .5 + .5 * math.sin((u * U) * 2.6 + 1.7);
					Q = (E:Lerp(W, y)):Lerp(A, K * .5);
				else
					local E = Color3.fromHSV(((u * .4)) % 1, 1, 1);
					local W = Color3.fromHSV(((u * .4 + .5)) % 1, 1, 1);
					Q = E:Lerp(W, .5 + .5 * math.sin(u * 2.2));
				end;
			elseif E == 4 then
				if W then
					local E = c(1);
					local W = c(2);
					Q = E:Lerp(W, .5 + .5 * math.sin((u * U) * 3.5));
				else
					Q = Color3.fromHSV(((u * .15)) % 1, .9, .55 + .45 * ((.5 + .5 * math.sin(u * 3.5))));
				end;
			elseif E == 5 then
				if W then
					local E = c(1);
					local W = c(2);
					local A = c(3);
					local y = c(4);
					local K = .5 + .5 * math.sin((u * U) * 1.6);
					local l = .5 + .5 * math.sin((u * U) * 2.3 + 1.7);
					Q = ((E:Lerp(W, K)):Lerp(A, l * .4)):Lerp(y, K * .3);
				else
					local E = Color3.fromHSV(((u * .25)) % 1, 1, 1);
					local W = Color3.fromHSV(((u * .25 + .5)) % 1, 1, 1);
					local U = Color3.fromHSV(((u * .25 + .75)) % 1, .9, 1);
					local A = .5 + .5 * math.sin(u * 1.6);
					local y = .5 + .5 * math.sin(u * 2.3 + 1.7);
					Q = (E:Lerp(W, A)):Lerp(U, y * .4);
				end;
			end;
			if Q then
				for u, E in ipairs(D.fovFrame:GetChildren()) do
					if E:IsA("Frame") then
						for u, E in ipairs(E:GetChildren()) do
							if E:IsA("UIStroke") and (E.Name ~= "BlackStrokeOuter" and E.Name ~= "BlackStrokeInner") then
								E.Color = Q;
							end;
						end;
					end;
				end;
				if D.fovStroke then
					D.fovStroke.Color = Q;
				end;
			end;
		end);
end;
local function OL()
	if D.panelRainbowConn then
		pcall(function()
			D.panelRainbowConn:Disconnect();
		end);
		D.panelRainbowConn = nil;
	end;
end;
local function qL()
	OL();
	D.panelRainbowConn = Q.RenderStepped:Connect(function()
			if D.unloaded or not I.PanelRainbow then
				return;
			end;
			if not D.panel or not D.panel.Parent then
				return;
			end;
			local u = Color3.fromHSV(((tick() * .15)) % 1, 1, 1);
			local E = D.panel:FindFirstChildOfClass("UIStroke");
			if E then
				E.Color = u;
			end;
		end);
end;
local function xL()
	QL();
	if not I.RebelFOVCircle then
		return;
	end;
	local u = nil;
	if gethui then
		local E, W = pcall(gethui);
		if E and (W and typeof(W) == "Instance") then
			u = W;
		end;
	end;
	if not u then
		u = k:FindFirstChildOfClass("PlayerGui");
	end;
	if not u then
		u = game:GetService("CoreGui");
	end;
	D.fovGui = Instance.new("ScreenGui");
	D.fovGui.Name = "XD_FOV_" .. E_(6);
	D.fovGui.IgnoreGuiInset = true;
	D.fovGui.ResetOnSpawn = false;
	D.fovGui.DisplayOrder = 99998;
	pcall(function()
		D.fovGui.Parent = u;
	end);
	if not D.fovGui.Parent then
		pcall(function()
			D.fovGui.Parent = game:GetService("CoreGui");
		end);
	end;
	local E = math.max(4, ((I.RebelFOV or 150)) * 2);
	local W = math.floor(E / 2);
	local U = I.RebelFOV_OutlineThickness or 5;
	D.fovFrame = Instance.new("Frame");
	D.fovFrame.BackgroundTransparency = 1;
	D.fovFrame.AnchorPoint = Vector2.new(.5, .5);
	D.fovFrame.Position = UDim2.new(.5, 0, .5, 0);
	D.fovFrame.Size = UDim2.fromOffset(E, E);
	D.fovFrame.ZIndex = 1000;
	D.fovFrame.Parent = D.fovGui;
	K_(D.fovFrame, W);
	if I.RebelFOVBlackOutline then
		local u = Instance.new("Frame");
		u.Name = "BlackOuter";
		u.BackgroundTransparency = 1;
		u.Size = UDim2.fromScale(1, 1);
		u.AnchorPoint = Vector2.new(.5, .5);
		u.Position = UDim2.fromScale(.5, .5);
		u.ZIndex = 996;
		u.Parent = D.fovFrame;
		K_(u, W);
		local E = Instance.new("UIStroke");
		E.Name = "BlackStrokeOuter";
		E.Color = h();
		E.Thickness = U;
		E.Transparency = 0;
		E.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		E.Parent = u;
		local Q = Instance.new("Frame");
		Q.Name = "BlackInner";
		Q.BackgroundTransparency = 1;
		Q.Size = UDim2.new(1, -((U + 3)), 1, -((U + 3)));
		Q.AnchorPoint = Vector2.new(.5, .5);
		Q.Position = UDim2.fromScale(.5, .5);
		Q.ZIndex = 996;
		Q.Parent = D.fovFrame;
		K_(Q, W);
		local A = Instance.new("UIStroke");
		A.Name = "BlackStrokeInner";
		A.Color = h();
		A.Thickness = math.max(1, U - 2);
		A.Transparency = 0;
		A.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		A.Parent = Q;
	end;
	if I.RebelFOVNeon then
		local u = Instance.new("Frame");
		u.Name = "Glow1";
		u.BackgroundTransparency = 1;
		u.Size = UDim2.fromScale(1, 1);
		u.AnchorPoint = Vector2.new(.5, .5);
		u.Position = UDim2.fromScale(.5, .5);
		u.ZIndex = 999;
		u.Parent = D.fovFrame;
		K_(u, W);
		local E = Instance.new("UIStroke");
		E.Color = d();
		E.Thickness = 14;
		E.Transparency = .82;
		E.Parent = u;
		local U = Instance.new("Frame");
		U.Name = "Glow2";
		U.BackgroundTransparency = 1;
		U.Size = UDim2.fromScale(1, 1);
		U.AnchorPoint = Vector2.new(.5, .5);
		U.Position = UDim2.fromScale(.5, .5);
		U.ZIndex = 999;
		U.Parent = D.fovFrame;
		K_(U, W);
		local Q = Instance.new("UIStroke");
		Q.Color = d();
		Q.Thickness = 6;
		Q.Transparency = .55;
		Q.Parent = U;
	end;
	D.fovStroke = Instance.new("UIStroke");
	D.fovStroke.Color = Color3.new(1, 1, 1);
	local Q = tonumber(I.RebelFOVCircleWidth) or 1.6;
	if I.FOVRainbow and ((I.FOVRainbowMode or 1)) == 6 then
		Q = Q * 2.5;
	end;
	D.fovStroke.Thickness = Q;
	D.fovStroke.Transparency = 0;
	D.fovStroke.Parent = D.fovFrame;
	local A = Instance.new("Frame");
	A.Name = "Inner";
	A.BackgroundTransparency = 1;
	A.Size = UDim2.fromScale(1, 1);
	A.AnchorPoint = Vector2.new(.5, .5);
	A.Position = UDim2.fromScale(.5, .5);
	A.ZIndex = 1001;
	A.Parent = D.fovFrame;
	K_(A, W);
	local y = Instance.new("UIStroke");
	y.Name = "InnerStroke";
	y.Color = d();
	y.Thickness = 1.2;
	y.Transparency = .15;
	y.Parent = A;
	if I.FOVRainbow then
		lL();
	end;
end;
local function kL()
	if not D.fovFrame then
		return;
	end;
	local u = math.max(4, ((I.RebelFOV or 150)) * 2);
	local E = math.floor(u / 2);
	local W = I.RebelFOV_OutlineThickness or 5;
	D.fovFrame.Size = UDim2.fromOffset(u, u);
	local U = D.fovFrame:FindFirstChildOfClass("UICorner");
	if U then
		U.CornerRadius = UDim.new(0, E);
	end;
	for u, U in ipairs(D.fovFrame:GetChildren()) do
		if U:IsA("Frame") then
			local u = U:FindFirstChildOfClass("UICorner");
			if u then
				u.CornerRadius = UDim.new(0, E);
			end;
			if U.Name == "BlackInner" then
				U.Size = UDim2.new(1, -((W + 3)), 1, -((W + 3)));
			end;
			for u, E in ipairs(U:GetChildren()) do
				if E:IsA("UIStroke") then
					if E.Name == "BlackStrokeOuter" then
						E.Color = h();
						E.Thickness = W;
						E.Transparency = 0;
					elseif E.Name == "BlackStrokeInner" then
						E.Color = h();
						E.Thickness = math.max(1, W - 2);
						E.Transparency = 0;
					elseif E.Parent and E.Parent.Name == "Glow1" then
						E.Color = d();
						E.Transparency = .82;
					elseif E.Parent and E.Parent.Name == "Glow2" then
						E.Color = d();
						E.Transparency = .55;
					elseif E.Name == "InnerStroke" then
						E.Color = d();
						E.Transparency = .15;
					end;
				end;
			end;
		end;
	end;
	if D.fovStroke then
		local u = tonumber(I.RebelFOVCircleWidth) or 1.6;
		if I.FOVRainbow and ((I.FOVRainbowMode or 1)) == 6 then
			u = u * 2.5;
		end;
		D.fovStroke.Thickness = u;
	end;
end;
local fL, ZL, DL;
local function VL()
	if DL then
		pcall(function()
			DL:Disconnect();
		end);
		DL = nil;
	end;
	if fL then
		pcall(function()
			fL:Destroy();
		end);
		fL = nil;
	end;
	if ZL then
		pcall(function()
			ZL:Destroy();
		end);
		ZL = nil;
	end;
end;
local function XL(u)
	local W = Instance.new("Part");
	W.Name = "UIRadiusDisc";
	W.Anchored = true;
	W.CanCollide = false;
	W.CanQuery = false;
	W.CanTouch = false;
	W.CastShadow = false;
	W.Massless = true;
	W.Locked = true;
	W.Material = Enum.Material.Plastic;
	W.Color = u;
	W.Shape = Enum.PartType.Cylinder;
	W.Size = Vector3.new(.08, 2, 2);
	W.Transparency = .55;
	pcall(function()
		W.Parent = E.CurrentCamera or E;
	end);
	return W;
end;
local function mL()
	if D.unloaded then
		return;
	end;
	VL();
	if not I.RadiusVis and not n.RadiusVis then
		return;
	end;
	if I.RadiusVis then
		fL = XL(J());
	end;
	if n.RadiusVis then
		ZL = XL(j());
	end;
	DL = Q.RenderStepped:Connect(function()
			if D.unloaded then
				return;
			end;
			local u = k.Character and k.Character:FindFirstChild("HumanoidRootPart");
			if not u then
				return;
			end;
			local E = u.Position - Vector3.new(0, 2.9, 0);
			if fL then
				local u = math.max(2, I.Distance or 16) * 2;
				fL.CFrame = CFrame.new(E) * CFrame.Angles(0, 0, math.rad(90));
				fL.Size = Vector3.new(.08, u, u);
				fL.Color = J();
				fL.Transparency = math.clamp(1 - ((I.RadiusTransparency or .55)), .1, .9);
			end;
			if ZL then
				local u = math.max(2, n.Distance or 16) * 2;
				local W = E + Vector3.new(0, .02, 0);
				ZL.CFrame = CFrame.new(W) * CFrame.Angles(0, 0, math.rad(90));
				ZL.Size = Vector3.new(.08, u, u);
				ZL.Color = j();
				ZL.Transparency = math.clamp(1 - ((n.RadiusTransparency or .55)), .1, .9);
			end;
		end);
end;
local function IL()
	VL();
end;
local nL = "rbxassetid://88400194373338";
_G.__rlgl_isRed = function()
		local u, E = pcall(function()
				local u = k:FindFirstChild("PlayerGui");
				if not u then
					return false;
				end;
				local E = u:FindFirstChild("ImpactFrames");
				if not E then
					return false;
				end;
				local W = E:FindFirstChild("TrafficLightEmpty");
				if not W or not W:IsA("ImageLabel") then
					return false;
				end;
				return W.Image == nL;
			end);
		if u and E then
			return true;
		end;
		local W, U = pcall(function()
				local u = O:FindFirstChildOfClass("ColorCorrectionEffect");
				if not u or not u.Enabled then
					return false;
				end;
				local E = u.TintColor;
				return E.R > .6 and (E.G < .4 and E.B < .4);
			end);
		if W and U then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inSafeZone = function()
		local u = k.Character;
		if not u then
			return false;
		end;
		local E = u:FindFirstChild("HumanoidRootPart");
		if not E then
			return false;
		end;
		local W = E.Position;
		if math.abs(W.Y - 1023) > 80 then
			return false;
		end;
		local function U(u, E, U, Q)
			return W.X >= u and (W.X <= E and (W.Z >= U and W.Z <= Q));
		end;
		if U(-219, 135, -656, -511) then
			return true;
		end;
		if U(-215, 115, 82, 168) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_inFinishZone = function()
		local u = k.Character;
		if not u then
			return false;
		end;
		local E = u:FindFirstChild("HumanoidRootPart");
		if not E then
			return false;
		end;
		local W = E.Position;
		if math.abs(W.Y - 1023) > 80 then
			return false;
		end;
		if W.X >= -215 and (W.X <= 115 and (W.Z >= 82 and W.Z <= 168)) then
			return true;
		end;
		return false;
	end;
_G.__rlgl_isMoving = function(u)
		local E = k.Character;
		if not E then
			return false;
		end;
		local W = E:FindFirstChildOfClass("Humanoid");
		local U = E:FindFirstChild("HumanoidRootPart");
		if not W or not U then
			return false;
		end;
		if W.MoveDirection.Magnitude > .1 then
			return true;
		end;
		local Q = U.AssemblyLinearVelocity;
		return math.sqrt(Q.X * Q.X + Q.Z * Q.Z) > ((u or .3));
	end;
_G.__rlgl_isOnMap = function()
		local u = workspace:FindFirstChild("Values");
		if u then
			local E = u:FindFirstChild("CurrentGame");
			if E and E.Value == "RedLightGreenLight" then
				return true;
			end;
		end;
		local E = k.Character;
		if not E then
			return false;
		end;
		local W = E:FindFirstChild("HumanoidRootPart");
		if not W then
			return false;
		end;
		return W.Position.Y > 1000 and W.Position.Y < 1050;
	end;
_G.__rlgl_timerSeconds = function()
		local u = workspace:GetAttribute("CurrentGameTime");
		if type(u) == "number" then
			return u, tostring(u);
		end;
		for u, E in ipairs({
			"TimeLeft",
			"Timer",
			"RoundTime",
			"TimeRemaining",
		}) do
			local W = workspace:GetAttribute(E);
			if type(W) == "number" then
				return W, tostring(W);
			end;
		end;
		local function E(u)
			if not u or u == "" then
				return nil;
			end;
			u = ((tostring(u)):gsub("^%s+", "")):gsub("%s+$", "");
			local E, W = u:match("^(%d+):(%d+)");
			if E then
				return tonumber(E) * 60 + tonumber(W), u;
			end;
			local U = u:match("^(%d+)");
			if U then
				return tonumber(U), u;
			end;
			return nil, u;
		end;
		if _G.__rlgl_timerLabel and _G.__rlgl_timerLabel.Parent then
			local u, W = E(_G.__rlgl_timerLabel.Text);
			if u ~= nil then
				return u, W;
			end;
		end;
		return nil, nil;
	end;
_G.__rlgl_fireDodge = function()
		if D.unloaded then
			return;
		end;
		local u = k.Character;
		if not u then
			return;
		end;
		local E = u:FindFirstChildOfClass("Humanoid");
		if not E or E.Health <= 0 then
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
				local u = game:GetService("VirtualInputManager");
				u:SendKeyEvent(true, Enum.KeyCode.T, false, game);
				task.delay(.012, function()
					pcall(function()
						u:SendKeyEvent(false, Enum.KeyCode.T, false, game);
					end);
				end);
			end);
		end;
	end;
local function vL(u)
	if u then
		if not D.fbInst then
			D.fbInst = Instance.new("ColorCorrectionEffect");
			D.fbInst.Name = "_XD_FB";
			D.fbInst.Brightness = .3;
			D.fbInst.Contrast = .15;
			D.fbInst.Saturation = .05;
			D.fbInst.Parent = O;
		end;
	else
		if D.fbInst then
			pcall(function()
				D.fbInst:Destroy();
			end);
			D.fbInst = nil;
		end;
	end;
end;
local function iL(u)
	if u then
		if not D.fogBackup then
			D.fogBackup = { FogEnd = O.FogEnd, FogStart = O.FogStart, FogColor = O.FogColor };
		end;
		O.FogEnd = 1000000;
		O.FogStart = 1000000;
	else
		if D.fogBackup then
			O.FogEnd = D.fogBackup.FogEnd;
			O.FogStart = D.fogBackup.FogStart;
			O.FogColor = D.fogBackup.FogColor;
			D.fogBackup = nil;
		end;
	end;
end;
local TL = {};
local function gL(u, E)
	if D.unloaded then
		return;
	end;
	pcall(function()
		if not D.notifHolder or not D.notifHolder.Parent then
			D.notifHolder = Instance.new("ScreenGui");
			D.notifHolder.Name = "XD_Nf_" .. E_(6);
			D.notifHolder.IgnoreGuiInset = true;
			D.notifHolder.ResetOnSpawn = false;
			D.notifHolder.DisplayOrder = 99999;
			local u = nil;
			if gethui then
				local E, W = pcall(gethui);
				if E and (W and typeof(W) == "Instance") then
					u = W;
				end;
			end;
			if not u then
				u = k:FindFirstChildOfClass("PlayerGui");
			end;
			if not u then
				u = game:GetService("CoreGui");
			end;
			pcall(function()
				D.notifHolder.Parent = u;
			end);
			if not D.notifHolder.Parent then
				pcall(function()
					D.notifHolder.Parent = game:GetService("CoreGui");
				end);
			end;
		end;
		local W = Instance.new("Frame");
		W.Size = UDim2.fromOffset(250, 36);
		W.AnchorPoint = Vector2.new(.5, 0);
		W.Position = UDim2.new(.5, 0, 0, -60);
		W.BackgroundColor3 = Color3.fromRGB(11, 9, 18);
		W.BackgroundTransparency = .12;
		W.BorderSizePixel = 0;
		W.ZIndex = 5;
		W.Parent = D.notifHolder;
		K_(W, 8);
		local U = Instance.new("UIStroke");
		U.Color = E or r();
		U.Thickness = 1.5;
		U.Transparency = .1;
		U.Parent = W;
		local Q = Instance.new("TextLabel");
		Q.Size = UDim2.new(1, -12, 1, 0);
		Q.Position = UDim2.fromOffset(6, 0);
		Q.BackgroundTransparency = 1;
		Q.Font = Enum.Font.GothamBold;
		Q.TextSize = 12;
		Q.TextColor3 = Color3.fromRGB(235, 225, 250);
		Q.Text = tostring(u or "");
		Q.ZIndex = 6;
		Q.Parent = W;
		table.insert(TL, 1, W);
		for u, E in ipairs(TL) do
			if E and E.Parent then
				local W = 20 + ((u - 1)) * 42;
				(y:Create(E, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, W) })):Play();
			end;
		end;
		(y:Create(W, TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, 20) })):Play();
		task.delay(2.2, function()
			if not W or not W.Parent then
				return;
			end;
			local u = TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
			(y:Create(W, u, { Position = UDim2.new(.5, 0, 0, -60), BackgroundTransparency = 1 })):Play();
			(y:Create(U, u, { Transparency = 1 })):Play();
			(y:Create(Q, u, { TextTransparency = 1 })):Play();
			task.delay(.35, function()
				for u = #TL, 1, -1 do
					if TL[u] == W then
						table.remove(TL, u);
						break;
					end;
				end;
				pcall(function()
					W:Destroy();
				end);
				for u, E in ipairs(TL) do
					if E and E.Parent then
						local W = 20 + ((u - 1)) * 42;
						(y:Create(E, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(.5, 0, 0, W) })):Play();
					end;
				end;
			end);
		end);
	end);
end;
_G.__adShowNotif = gL;
local function bL()
	if D.unloaded or not I.AutoBrew then
		return;
	end;
	local u = string.lower(tostring(I.AutoBrewSlot or "e"));
	d_(u);
	task.wait(.2);
	local E = tonumber(I.AutoBrewDelayCollect) or 0;
	if E > 0 then
		task.wait(E);
	end;
	local W = tonumber(I.AutoBrewCollectHold) or 2;
	local U = Enum.KeyCode[string.upper(u)] or Enum.KeyCode.E;
	local Q = pcall(function()
			local u = game:GetService("VirtualInputManager");
			u:SendKeyEvent(true, U, false, game);
			task.wait(W);
			u:SendKeyEvent(false, U, false, game);
		end);
	if not Q and c_ then
		local E = j_[u];
		if E then
			pcall(function()
				keypress(E);
				task.wait(W);
				keyrelease(E);
			end);
		end;
	end;
end;
local function rL()
	if D.brewLoopConn then
		return;
	end;
	D.lastBrewTick = tick();
	D.brewLoopConn = task.spawn(function()
			while not D.unloaded and I.AutoBrew do
				local u = tonumber(I.AutoBrewInterval) or 60;
				if tick() - D.lastBrewTick >= u then
					D.lastBrewTick = tick();
					pcall(bL);
				end;
				task.wait(.5);
			end;
		end);
end;
local function SL()
	if D.brewLoopConn then
		pcall(function()
			task.cancel(D.brewLoopConn);
		end);
		D.brewLoopConn = nil;
	end;
end;
local oL = {
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
local function JL()
	local u = k.Character;
	if not u then
		return nil;
	end;
	local E = u:FindFirstChild("HumanoidRootPart");
	if not E then
		return nil;
	end;
	local W = u:GetAttribute("HoldingWeapon");
	if type(W) == "string" and W ~= "" then
		local E = u:FindFirstChild(W);
		if E then
			local u = E:FindFirstChild("FireFrom");
			if u and u:IsA("BasePart") then
				return u.Position;
			end;
			local W = E:FindFirstChild("Handle");
			if W and W:IsA("BasePart") then
				return W.Position + W.CFrame.LookVector * .5;
			end;
		end;
	end;
	return (E.Position + E.CFrame.LookVector * 1.5) + Vector3.new(0, .8, 0);
end;
local function jL(u)
	local U = E.CurrentCamera;
	if not U then
		return nil;
	end;
	local Q, A;
	if W.TouchEnabled and not W.MouseEnabled then
		local u = W:GetMouseLocation();
		Q = u.X;
		A = u.Y;
		local E = U.ViewportSize;
		if Q < 1 and A < 1 then
			Q = E.X / 2;
			A = E.Y / 2;
		end;
	else
		local u = k:GetMouse();
		if not u then
			return nil;
		end;
		Q = u.X;
		A = u.Y;
	end;
	local y = U:ScreenPointToRay(Q, A);
	local K = RaycastParams.new();
	K.FilterType = Enum.RaycastFilterType.Exclude;
	K.FilterDescendantsInstances = { k.Character };
	local l = E:Raycast(u, y.Direction * I.BulletTracerRange, K);
	if l then
		return l.Position;
	end;
	return u + y.Direction * I.BulletTracerRange;
end;
local function NL(u, E)
	local W = E - u;
	local U = W.Magnitude;
	if U < 1 then
		return;
	end;
	local A = W.Unit;
	local K = u + A * I.BulletTracerStartOffset;
	local l = E - A * I.BulletTracerEndOffset;
	local O = ((l - K)).Magnitude;
	if O < .3 then
		return;
	end;
	local q = ((K + l)) / 2;
	local x = CFrame.lookAt(q, l);
	local k = Color3.fromRGB(I.BulletTracerR, I.BulletTracerG, I.BulletTracerB);
	local f = I.BulletTracerThickness;
	local Z = I.BulletTracerLifetime;
	local V = oL[I.BulletTracerFadeIdx or 1].style;
	local X = TweenInfo.new(Z, V, Enum.EasingDirection.Out);
	local m = math.max(50, tonumber(I.BulletTracerSpeed) or 800);
	local n = U / m;
	if n < .015 then
		n = .015;
	end;
	local function v(u, E, W)
		local U = Instance.new("Part");
		U.Name = "_XD_BTracer";
		U.Anchored = true;
		U.CanCollide = false;
		U.CanQuery = false;
		U.CanTouch = false;
		U.CastShadow = false;
		U.Material = Enum.Material.Neon;
		U.Color = E;
		U.Transparency = W;
		U.Size = u;
		U.CFrame = x;
		U.Parent = workspace;
		return U;
	end;
	local function i(u, E, W, U)
		task.spawn(function()
			local y = tick();
			while true do
				if D.unloaded or not u or not u.Parent then
					return;
				end;
				local O = ((tick() - y)) / n;
				if O >= 1 then
					O = 1;
				end;
				local q = U * O;
				if q < .01 then
					q = .01;
				end;
				u.Size = Vector3.new(E, W, q);
				u.CFrame = CFrame.lookAt(K + A * ((q / 2)), l);
				if O >= 1 then
					break;
				end;
				Q.Heartbeat:Wait();
			end;
		end);
	end;
	if I.BulletTracerGlow then
		local u = v(Vector3.new(f * 3, f * 3, .01), k, math.clamp(I.BulletTracerOpacity + .4, 0, 1));
		task.delay((Z + n) + .1, function()
			pcall(function()
				u:Destroy();
			end);
		end);
		i(u, f * 3, f * 3, O);
		task.delay(n, function()
			if u and u.Parent then
				(y:Create(u, X, { Transparency = 1, Size = Vector3.new(.01, .01, O) })):Play();
			end;
		end);
	end;
	local T = v(Vector3.new(f, f, .01), k, I.BulletTracerOpacity);
	if I.BulletTracerGlow then
		local u = Instance.new("PointLight");
		u.Color = k;
		u.Brightness = 3;
		u.Range = 8;
		u.Parent = T;
	end;
	task.delay((Z + n) + .1, function()
		pcall(function()
			T:Destroy();
		end);
	end);
	i(T, f, f, O);
	task.delay(n, function()
		if T and T.Parent then
			(y:Create(T, X, { Transparency = 1, Size = Vector3.new(.01, .01, O) })):Play();
		end;
	end);
	if I.BulletTracerWhiteCore then
		local u = v(Vector3.new(f * .3, f * .3, .01), Color3.new(1, 1, 1), math.clamp(I.BulletTracerOpacity + .1, 0, 1));
		task.delay((Z + n) + .1, function()
			pcall(function()
				u:Destroy();
			end);
		end);
		i(u, f * .3, f * .3, O);
		task.delay(n, function()
			if u and u.Parent then
				(y:Create(u, X, { Transparency = 1, Size = Vector3.new(.005, .005, O) })):Play();
			end;
		end);
	end;
end;
local function cL()
	if not I.BulletTracer then
		return;
	end;
	local u = tick();
	if u - D.btLastShot < I.BulletTracerCooldown then
		return;
	end;
	D.btLastShot = u;
	local E = JL();
	if not E then
		return;
	end;
	local W = jL(E);
	if not W then
		return;
	end;
	NL(E, W);
end;
local function dL(u)
	if not u then
		return;
	end;
	if D.btAnimConn then
		pcall(function()
			D.btAnimConn:Disconnect();
		end);
		D.btAnimConn = nil;
	end;
	D.btAnimConn = u.AnimationPlayed:Connect(function(u)
			local E = u.Animation;
			if not E then
				return;
			end;
			local W = E.AnimationId;
			if not X[W] then
				return;
			end;
			local U = tick();
			if U - ((D.btLastIdTime[W] or 0)) < I.BulletTracerCooldown then
				return;
			end;
			D.btLastIdTime[W] = U;
			cL();
		end);
end;
local function hL(u)
	if not u then
		return;
	end;
	local E = u:FindFirstChildOfClass("Humanoid");
	if not E then
		return;
	end;
	local W = E:FindFirstChildOfClass("Animator");
	if W then
		dL(W);
	else
		local u;
		u = E.ChildAdded:Connect(function(E)
				if E:IsA("Animator") then
					dL(E);
					pcall(function()
						u:Disconnect();
					end);
				end;
			end);
	end;
end;
if k.Character then
	hL(k.Character);
end;
b(k.CharacterAdded:Connect(function(u)
	task.wait(.5);
	hL(u);
end));
local LL = {};
local wL = {};
local function PL()
	for u, E in pairs(LL) do
		pcall(function()
			if E.hl then
				E.hl:Destroy();
			end;
		end);
		pcall(function()
			if E.nameBill then
				E.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if E.hpBar then
				E.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if E.distBill then
				E.distBill:Destroy();
			end;
		end);
		pcall(function()
			if E.toolBill then
				E.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if E.tracer then
				E.tracer:Destroy();
			end;
		end);
		pcall(function()
			if E.box then
				E.box:Destroy();
			end;
		end);
	end;
	table.clear(LL);
end;
local function eL()
	for u, E in pairs(wL) do
		pcall(function()
			if E.hl then
				E.hl:Destroy();
			end;
		end);
		pcall(function()
			if E.nameBill then
				E.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if E.hpBar then
				E.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if E.distBill then
				E.distBill:Destroy();
			end;
		end);
		pcall(function()
			if E.toolBill then
				E.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if E.tracer then
				E.tracer:Destroy();
			end;
		end);
		pcall(function()
			if E.box then
				E.box:Destroy();
			end;
		end);
	end;
	table.clear(wL);
end;
local function aL(u, E)
	if not u or not E then
		return false;
	end;
	if E:GetAttribute("IsGuard") == true then
		return true;
	end;
	if u:FindFirstChild("GuardPlayerOutift") then
		return true;
	end;
	if u:FindFirstChild("G3SG1") then
		return true;
	end;
	return false;
end;
local function pL(u)
	local E = u and u:FindFirstChild("HumanoidRootPart");
	if not E then
		return 5.5;
	end;
	local W, U = math.huge, -math.huge;
	for u, E in ipairs(u:GetDescendants()) do
		if E:IsA("BasePart") then
			local u = E.Position.Y;
			if u < W then
				W = u;
			end;
			if u > U then
				U = u;
			end;
		end;
	end;
	if W == math.huge then
		return 5.5;
	end;
	local Q = U - W;
	if Q < 3 then
		Q = 3;
	end;
	if Q > 10 then
		Q = 10;
	end;
	return Q;
end;
local function zL(u)
	if u > .6 then
		return Color3.fromRGB(74, 222, 74);
	elseif u > .3 then
		return Color3.fromRGB(255, 210, 60);
	else
		return Color3.fromRGB(255, 55, 55);
	end;
end;
local function ML(u, E, W, U, Q, A)
	local y = u:GetAttribute("IsGuard") and L() or w();
	local K = y:Lerp(Color3.new(0, 0, 0), .35);
	local l = pL(E);
	q_();
	x_();
	local O = Instance.new("Highlight");
	O.Name = "_XD_HL";
	O.FillTransparency = .4;
	O.OutlineTransparency = 0;
	O.FillColor = y;
	O.OutlineColor = K;
	O.Adornee = E;
	O.Parent = E;
	local q = Instance.new("BillboardGui");
	q.Name = "_XD_NAME";
	q.Size = UDim2.fromOffset(360, 26);
	q.StudsOffset = Vector3.new(0, l * .5 + .6, 0);
	q.AlwaysOnTop = true;
	q.LightInfluence = 0;
	q.Adornee = W;
	q.Parent = E;
	local x = Instance.new("Frame");
	x.BackgroundTransparency = 1;
	x.Size = UDim2.fromOffset(0, 24);
	x.AutomaticSize = Enum.AutomaticSize.X;
	x.AnchorPoint = Vector2.new(.5, .5);
	x.Position = UDim2.fromScale(.5, .5);
	x.Parent = q;
	local k = Instance.new("UIListLayout");
	k.FillDirection = Enum.FillDirection.Horizontal;
	k.SortOrder = Enum.SortOrder.LayoutOrder;
	k.VerticalAlignment = Enum.VerticalAlignment.Center;
	k.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	k.Padding = UDim.new(0, 6);
	k.Parent = x;
	local f = Instance.new("Frame");
	f.LayoutOrder = 1;
	f.Size = UDim2.fromOffset(42, 20);
	f.BackgroundColor3 = Color3.fromRGB(74, 222, 74);
	f.BorderSizePixel = 0;
	f.Parent = x;
	K_(f, 5);
	local Z = Instance.new("UIStroke");
	Z.Thickness = 1.5;
	Z.Transparency = 0;
	Z.Color = Color3.new(0, 0, 0);
	Z.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	Z.Parent = f;
	local V = Instance.new("TextLabel");
	V.Size = UDim2.fromScale(1, 1);
	V.BackgroundTransparency = 1;
	V.Font = Enum.Font.GothamBlack;
	V.TextSize = 13;
	V.TextColor3 = Color3.fromRGB(255, 255, 255);
	V.TextStrokeTransparency = 0;
	V.TextStrokeColor3 = Color3.new(0, 0, 0);
	V.Text = "[100]";
	V.Parent = f;
	local X = Instance.new("TextLabel");
	X.LayoutOrder = 2;
	X.BackgroundTransparency = 1;
	X.AutomaticSize = Enum.AutomaticSize.X;
	X.Size = UDim2.fromOffset(0, 24);
	X.Font = i();
	X.TextSize = Q or 17;
	X.TextColor3 = Color3.fromRGB(255, 255, 255);
	X.TextStrokeTransparency = 0;
	X.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	X.Text = u.Name;
	X.Parent = x;
	local I = Instance.new("BillboardGui");
	I.Size = UDim2.fromOffset(220, 20);
	I.StudsOffset = Vector3.new(0, -l * .5 - 1.2, 0);
	I.AlwaysOnTop = true;
	I.LightInfluence = 0;
	I.Adornee = W;
	I.Parent = E;
	local n = Instance.new("TextLabel");
	n.Size = UDim2.new(1, 0, 1, 0);
	n.BackgroundTransparency = 1;
	n.TextColor3 = y;
	n.TextStrokeTransparency = 0;
	n.TextStrokeColor3 = Color3.new(0, 0, 0);
	n.Font = i();
	n.TextSize = 13;
	n.Text = "";
	n.Parent = I;
	local v = Instance.new("BillboardGui");
	v.Size = UDim2.fromOffset(8, l * 24);
	v.StudsOffset = Vector3.new(-2.5, 0, 0);
	v.AlwaysOnTop = true;
	v.LightInfluence = 0;
	v.Adornee = W;
	v.Parent = E;
	local T = Instance.new("Frame");
	T.Size = UDim2.fromScale(1, 1);
	T.AnchorPoint = Vector2.new(.5, .5);
	T.Position = UDim2.fromScale(.5, .5);
	T.BackgroundColor3 = Color3.fromRGB(25, 8, 8);
	T.BackgroundTransparency = .2;
	T.BorderSizePixel = 0;
	T.Parent = v;
	local g = K_(T, 3);
	O_(T, Color3.new(0, 0, 0), 1, .3);
	local b = Instance.new("Frame");
	b.Size = UDim2.fromScale(1, 1);
	b.BackgroundColor3 = Color3.new(1, 1, 1);
	b.BorderSizePixel = 0;
	b.AnchorPoint = Vector2.new(0, 1);
	b.Position = UDim2.fromScale(0, 1);
	b.Parent = T;
	local r = K_(b, 3);
	local S = Instance.new("UIGradient");
	S.Color = A or m(80, 255, 80, 180, 255, 60, 255, 200, 40, 255, 120, 60, 255, 40, 40);
	S.Rotation = 90;
	S.Parent = b;
	local o = Instance.new("BillboardGui");
	o.Size = UDim2.fromOffset(160, 18);
	o.StudsOffset = Vector3.new(2.8, 0, 0);
	o.AlwaysOnTop = true;
	o.LightInfluence = 0;
	o.Adornee = W;
	o.Parent = E;
	local J = Instance.new("TextLabel");
	J.Size = UDim2.new(1, 0, 1, 0);
	J.BackgroundTransparency = 1;
	J.TextColor3 = y;
	J.TextStrokeTransparency = 0;
	J.TextStrokeColor3 = Color3.new(0, 0, 0);
	J.Font = Enum.Font.Code;
	J.TextSize = 13;
	J.Text = "";
	J.TextXAlignment = Enum.TextXAlignment.Left;
	J.Parent = o;
	local j = Instance.new("Frame");
	j.AnchorPoint = Vector2.new(.5, .5);
	j.BorderSizePixel = 0;
	j.ZIndex = 5;
	j.Visible = false;
	j.BackgroundColor3 = y;
	j.Parent = D.tracerGui;
	local N = Instance.new("Frame");
	N.BackgroundTransparency = 1;
	N.BorderSizePixel = 0;
	N.Visible = false;
	N.ZIndex = 4;
	N.Parent = D.overlayGui;
	local c = Instance.new("UIStroke");
	c.Thickness = 2;
	c.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	c.Parent = N;
	return {
		hl = O,
		nameBill = q,
		hpChip = f,
		hpChipStroke = Z,
		hpLbl = V,
		nameL = X,
		toolBill = I,
		toolL = n,
		hpBar = v,
		hpBg = T,
		hpFill = b,
		hpGradient = S,
		hpBgCorner = g,
		hpFillCorner = r,
		distBill = o,
		distL = J,
		tracer = j,
		box = N,
		boxStroke = c,
		char = E,
		color = y,
		charHeight = l,
	};
end;
local function FL(u)
	if not u then
		return;
	end;
	pcall(function()
		if u.hl then
			u.hl:Destroy();
		end;
	end);
	pcall(function()
		if u.nameBill then
			u.nameBill:Destroy();
		end;
	end);
	pcall(function()
		if u.hpBar then
			u.hpBar:Destroy();
		end;
	end);
	pcall(function()
		if u.distBill then
			u.distBill:Destroy();
		end;
	end);
	pcall(function()
		if u.toolBill then
			u.toolBill:Destroy();
		end;
	end);
	pcall(function()
		if u.tracer then
			u.tracer:Destroy();
		end;
	end);
	pcall(function()
		if u.box then
			u.box:Destroy();
		end;
	end);
end;
local function CL(u, E, W, U)
	if not u then
		return;
	end;
	local Q = E:Lerp(Color3.new(0, 0, 0), .35);
	u.color = E;
	pcall(function()
		u.hl.FillColor = E;
		u.hl.OutlineColor = Q;
	end);
	if u.nameL then
		pcall(function()
			local E = W or 17;
			u.nameL.TextSize = E;
			u.nameL.Font = i();
			if u.hpChip and u.hpLbl then
				local W = E / 17;
				u.hpChip.Size = UDim2.fromOffset(math.max(24, math.floor(42 * W + .5)), math.max(12, math.floor(20 * W + .5)));
				u.hpLbl.TextSize = math.max(8, math.floor(13 * W + .5));
			end;
		end);
	end;
	if u.distL then
		pcall(function()
			u.distL.TextColor3 = E;
		end);
	end;
	if u.toolL then
		pcall(function()
			u.toolL.TextColor3 = E;
			u.toolL.Font = i();
		end);
	end;
	if u.hpBg then
		local W = u.hpBg:FindFirstChildOfClass("UIStroke");
		if W then
			pcall(function()
				W.Color = E:Lerp(Color3.new(0, 0, 0), .4);
			end);
		end;
	end;
	if u.hpGradient and U then
		pcall(function()
			u.hpGradient.Color = U;
		end);
	end;
end;
local function RL()
	if D.unloaded then
		return;
	end;
	_G.__adEspDone = 0;
	_G.__adEspTotal = 0;
	local E = I.GuardESP;
	local W = I.PlayerESP;
	if not ((E or W)) then
		if next(LL) then
			PL();
		end;
		if next(wL) then
			eL();
		end;
		return;
	end;
	local U = k.Character and k.Character:FindFirstChild("HumanoidRootPart");
	for u, Q in ipairs(u:GetPlayers()) do
		if Q ~= k then
			_G.__adEspTotal = _G.__adEspTotal + 1;
			pcall(function()
				local u = Q.Character;
				local A = u and u:FindFirstChildOfClass("Humanoid");
				local y = u and u:FindFirstChild("HumanoidRootPart");
				local K = I.GuardESP_ForceAll or aL(u, Q);
				local l = E and K;
				local O = W and not K;
				if A and (y and (A.Health > 0 and ((l or O)))) then
					local E = l and ((I.GuardESP_MaxDist or 0)) or (I.PlayerESP_MaxDist or 0);
					local W = U and U.Position or Vector3.zero;
					local K = ((W - y.Position)).Magnitude;
					if E > 0 and K > E then
						if LL[Q] then
							FL(LL[Q]);
							LL[Q] = nil;
						end;
						if wL[Q] then
							FL(wL[Q]);
							wL[Q] = nil;
						end;
						return;
					end;
					_G.__adEspDone = _G.__adEspDone + 1;
					local q = l and L() or w();
					local x = l and ((I.GuardESP_NameSize or 17)) or (I.PlayerESP_NameSize or 17);
					local k = l and F() or C();
					local f = l and LL or wL;
					local Z = l and wL or LL;
					if Z[Q] then
						FL(Z[Q]);
						Z[Q] = nil;
					end;
					if not f[Q] or f[Q].char ~= u then
						if f[Q] then
							FL(f[Q]);
							f[Q] = nil;
						end;
						f[Q] = ML(Q, u, y, A, x, k);
					else
						CL(f[Q], q, x, k);
					end;
					local D = f[Q];
					if D then
						local E = l and I.GuardESP_HP or (O and I.PlayerESP_HP);
						local W = l and I.GuardESP_Name or (O and I.PlayerESP_Name);
						local q = l and I.GuardESP_Tool or (O and I.PlayerESP_Tool);
						local x = l and I.GuardESP_Distance or (O and I.PlayerESP_Distance);
						local k = l and I.GuardESP_Highlight or (O and I.PlayerESP_Highlight);
						local f = l and I.GuardESP_Tracer or (O and I.PlayerESP_Tracer);
						local Z = l and I.GuardESP_Box or (O and I.PlayerESP_Box);
						D.showHPBar = E;
						D.showTracer = f;
						D.showBox = Z;
						D.boxColor = l and a() or p();
						D.boxThick = l and ((I.GuardESP_BoxThickness or 2)) or (I.PlayerESP_BoxThickness or 2);
						D.hpBarThickness = l and ((I.GuardESP_HPBarThickness or 8)) or (I.PlayerESP_HPBarThickness or 8);
						D.hpBarLength = l and ((I.GuardESP_HPBarLength or 1.5)) or (I.PlayerESP_HPBarLength or 1.5);
						D.hpBarRoundness = l and ((I.GuardESP_HPBarRoundness or 3)) or (I.PlayerESP_HPBarRoundness or 3);
						D.tracerColor = l and P() or e();
						D.nameBill.Enabled = W and true or false;
						D.toolBill.Enabled = q and true or false;
						if D.hl then
							D.hl.Enabled = k and true or false;
						end;
						if q then
							local E = r_(u);
							if E == "" then
								E = "- none -";
							end;
							if D.toolL.Text ~= E then
								D.toolL.Text = E;
							end;
						end;
						local V = math.clamp(A.Health / math.max(A.MaxHealth, 1), 0, 1);
						D.hpFill.Size = UDim2.fromScale(1, V);
						if D.hpLbl then
							D.hpLbl.Text = "[" .. (tostring(math.floor(A.Health + .5)) .. "]");
						end;
						local X = l and I.GuardESP_HP_ChipBg or (O and I.PlayerESP_HP_ChipBg);
						local m = l and T(V) or g(V);
						if D.hpChip then
							D.hpChip.BackgroundColor3 = m;
							D.hpChip.BackgroundTransparency = X and 0 or 1;
						end;
						if D.hpLbl then
							D.hpLbl.TextColor3 = m;
						end;
						if D.hpChipStroke then
							local u = l and I.GuardESP_HP_Outline or (O and I.PlayerESP_HP_Outline);
							D.hpChipStroke.Enabled = ((u and X)) and true or false;
						end;
						if x then
							if U and y then
								D.distBill.Enabled = true;
								D.distL.Text = string.format("[%d studs]", math.floor(K + .5));
							else
								D.distBill.Enabled = false;
							end;
						else
							D.distBill.Enabled = false;
						end;
						if D.tracer then
							D.tracer.BackgroundColor3 = D.tracerColor;
						end;
						if not l and D.nameL then
							local u = Q.Name;
							if I.PlayerESP_CustomName and I.PlayerESP_CustomName ~= "" then
								u = I.PlayerESP_CustomName;
							end;
							if D.nameL.Text ~= u then
								D.nameL.Text = u;
							end;
							if not I.PlayerESP_NameRainbow then
								D.nameL.TextColor3 = Color3.fromRGB(255, 255, 255);
							end;
						end;
					end;
				else
					if LL[Q] then
						FL(LL[Q]);
						LL[Q] = nil;
					end;
					if wL[Q] then
						FL(wL[Q]);
						wL[Q] = nil;
					end;
				end;
			end);
		end;
	end;
end;
task.spawn(function()
	while D.running and not D.unloaded do
		pcall(function()
			if I.GuardESP or I.PlayerESP then
				local u = E.CurrentCamera;
				if u then
					local E = math.rad(u.FieldOfView);
					local W = u.ViewportSize;
					local U = W.Y;
					local Q = u.CFrame.Position;
					local A = W.X / 2;
					local y = W.Y / 2;
					local K = math.tan(E / 2);
					if K > .01 then
						local function E(E)
							if not E then
								return;
							end;
							local l = E.char and E.char:FindFirstChild("HumanoidRootPart");
							if E.hpBar then
								if E.showHPBar and l then
									local u = ((Q - l.Position)).Magnitude;
									if u < 1 then
										u = 1;
									end;
									local W = U / (((2 * u) * K));
									local A = E.hpBarThickness or 8;
									local y = E.hpBarLength or 1.5;
									local O = (((E.charHeight or 5.5)) * W) * y;
									if O > 3500 then
										O = 3500;
									end;
									if O < 20 then
										O = 20;
									end;
									E.hpBar.Enabled = true;
									E.hpBar.Size = UDim2.fromOffset(A, O);
									local q = E.hpBarRoundness or 3;
									pcall(function()
										if E.hpBgCorner then
											E.hpBgCorner.CornerRadius = UDim.new(0, q);
										end;
										if E.hpFillCorner then
											E.hpFillCorner.CornerRadius = UDim.new(0, q);
										end;
									end);
								else
									E.hpBar.Enabled = false;
								end;
							end;
							if E.tracer then
								if not E.showTracer or not l then
									if E.tracer.Visible then
										E.tracer.Visible = false;
									end;
								else
									local U, Q = u:WorldToViewportPoint(l.Position);
									local K = U.X - A;
									local O = U.Y - y;
									local q = (U.Z < 0);
									if q then
										K = -K;
										O = -O;
									end;
									local x = math.sqrt(K * K + O * O);
									local k, f;
									if x < .001 then
										k, f = 0, 1;
									else
										k = K / x;
										f = O / x;
									end;
									local Z = math.huge;
									if k > .0001 then
										Z = math.min(Z, ((W.X - A)) / k);
									end;
									if k < -0.0001 then
										Z = math.min(Z, -A / k);
									end;
									if f > .0001 then
										Z = math.min(Z, ((W.Y - y)) / f);
									end;
									if f < -0.0001 then
										Z = math.min(Z, -y / f);
									end;
									if Z == math.huge or Z < 1 then
										Z = 1;
									end;
									local D, V;
									if Q and not q then
										D = U.X;
										V = U.Y;
									else
										D = A + k * Z;
										V = y + f * Z;
									end;
									local X = D - A;
									local m = V - y;
									local I = math.sqrt(X * X + m * m);
									if I < 1 then
										I = 1;
									end;
									local n = math.deg(math.atan2(m, X));
									E.tracer.Visible = true;
									E.tracer.Position = UDim2.fromOffset(((A + D)) / 2, ((y + V)) / 2);
									E.tracer.Size = UDim2.fromOffset(I, 1.5);
									E.tracer.Rotation = n;
								end;
							end;
							if E.box and E.boxStroke then
								if not E.showBox then
									if E.box.Visible then
										E.box.Visible = false;
									end;
								else
									local W = E.char;
									if W and W.Parent then
										local U, Q, A, y = V_(W, u);
										if U then
											E.box.Visible = true;
											E.box.Position = UDim2.fromOffset(U - 4, Q - 4);
											E.box.Size = UDim2.fromOffset((A - U) + 8, (y - Q) + 8);
											E.boxStroke.Color = E.boxColor or Color3.new(1, 1, 1);
											E.boxStroke.Thickness = E.boxThick or 2;
										elseif E.box.Visible then
											E.box.Visible = false;
										end;
									elseif E.box.Visible then
										E.box.Visible = false;
									end;
								end;
							end;
						end;
						for u, W in pairs(LL) do
							E(W);
						end;
						for u, W in pairs(wL) do
							E(W);
						end;
					end;
				end;
			end;
		end);
		Q.RenderStepped:Wait();
	end;
end);
task.spawn(function()
	while D.running and not D.unloaded do
		pcall(function()
			if I.PlayerESP and I.PlayerESP_NameRainbow then
				local u = ((tick() * ((I.PlayerESP_NameRainbowSpeed or 1)))) % 1;
				local E = Color3.fromHSV(u, 1, 1);
				for u, W in pairs(wL) do
					if W.nameL and W.nameL.Parent then
						pcall(function()
							W.nameL.TextColor3 = E;
						end);
					end;
				end;
			end;
		end);
		Q.RenderStepped:Wait();
	end;
end);
local function tL(u)
	D.oneClickDalgona = u and true or false;
	if D.dalgonaConn then
		pcall(function()
			D.dalgonaConn:Disconnect();
		end);
		D.dalgonaConn = nil;
	end;
	if not D.oneClickDalgona then
		for u, E in pairs(_G.__dalgonaCache) do
			if u and u.Parent then
				pcall(function()
					u.Position = E.Position;
					u.Transparency = E.Transparency;
				end);
			end;
		end;
		table.clear(_G.__dalgonaCache);
		return;
	end;
	table.clear(_G.__dalgonaCache);
	D.dalgonaConn = Q.RenderStepped:Connect(function()
			if D.unloaded or not D.oneClickDalgona then
				return;
			end;
			pcall(function()
				local u = k:GetMouse();
				if not u or not u.Hit then
					return;
				end;
				local E = workspace:FindFirstChild("Effects");
				local W = nil;
				if E then
					for u, E in pairs(E:GetChildren()) do
						if E:IsA("Model") and string.match(E.Name, "Outline$") then
							W = E;
							break;
						end;
					end;
				end;
				if not W then
					return;
				end;
				local U = u.Hit.Position;
				for u, E in ipairs(W:GetChildren()) do
					if E:IsA("BasePart") then
						if not _G.__dalgonaCache[E] then
							_G.__dalgonaCache[E] = { Position = E.Position, Transparency = E.Transparency };
						end;
						E.Position = U;
						E.Transparency = 1;
					end;
				end;
			end);
		end);
end;
local function sL()
	table.clear(D.handCache);
	table.clear(D.legCache);
	table.clear(D.torsoCache);
	local u = k.Character;
	if not u then
		return;
	end;
	local E = {
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
	local W = {
			LeftUpperLeg = true,
			LeftLowerLeg = true,
			LeftFoot = true,
			["Left Leg"] = true,
			RightUpperLeg = true,
			RightLowerLeg = true,
			RightFoot = true,
			["Right Leg"] = true,
		};
	local U = { Torso = true, UpperTorso = true, LowerTorso = true };
	local Q = {
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
	local function A(u)
		if not u or not u:IsA("Accessory") then
			return false;
		end;
		local E = string.lower(u.Name);
		if E:find("glove") or E:find("hand") or E:find("wrist") or E:find("cuff") then
			return true;
		end;
		local W = u:FindFirstChild("Handle");
		if W then
			for u, E in ipairs(W:GetChildren()) do
				if E:IsA("Attachment") and Q[string.lower(E.Name)] then
					return true;
				end;
			end;
		end;
		return false;
	end;
	for u, Q in ipairs(u:GetDescendants()) do
		if Q:IsA("BasePart") then
			if E[Q.Name] then
				table.insert(D.handCache, Q);
			elseif W[Q.Name] then
				table.insert(D.legCache, Q);
			elseif U[Q.Name] then
				table.insert(D.torsoCache, Q);
			else
				local u = Q:FindFirstAncestorOfClass("Accessory");
				if u and A(u) then
					table.insert(D.handCache, Q);
				end;
			end;
		end;
	end;
end;
local function BL(u, E)
	for W = 1, #u, 1 do
		local U = u[W];
		if U and U.Parent then
			if E then
				if D.origTransparency[U] == nil then
					D.origTransparency[U] = U.Transparency;
				end;
				U.LocalTransparencyModifier = 1;
				U.Transparency = 1;
			else
				U.LocalTransparencyModifier = 0;
				U.Transparency = D.origTransparency[U] or 0;
			end;
		end;
	end;
end;
local function HL(u)
	I.RemoveHands = u and true or false;
	sL();
	BL(D.handCache, I.RemoveHands);
	return true;
end;
local function YL(u)
	I.RemoveLegs = u and true or false;
	sL();
	BL(D.legCache, I.RemoveLegs);
	return true;
end;
local function GL(u)
	I.RemoveTorso = u and true or false;
	sL();
	BL(D.torsoCache, I.RemoveTorso);
	return true;
end;
local function uS()
	if D.handsConn then
		return;
	end;
	D.handsConn = Q.Heartbeat:Connect(function()
			if D.unloaded then
				return;
			end;
			if I.RemoveHands then
				BL(D.handCache, true);
			end;
			if I.RemoveLegs then
				BL(D.legCache, true);
			end;
			if I.RemoveTorso then
				BL(D.torsoCache, true);
			end;
		end);
	table.insert(D.conns, D.handsConn);
end;
local function ES(u)
	local E = k.Character;
	if not E then
		return false;
	end;
	local W = E:FindFirstChild("Head");
	if not W then
		return false;
	end;
	if u == false then
		W.LocalTransparencyModifier = 0;
		W.Transparency = 0;
		for u, E in ipairs(W:GetChildren()) do
			if E:IsA("Decal") then
				E.Transparency = 0;
			end;
		end;
		return true;
	end;
	for u, E in ipairs(W:GetChildren()) do
		if E:IsA("Decal") then
			E.Transparency = 1;
		end;
	end;
	W.LocalTransparencyModifier = 1;
	W.Transparency = 1;
	return true;
end;
local WS = "rbxassetid://959831634";
local US = {
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot",
		"Left Leg",
	};
local function QS(u)
	local E = k.Character;
	if not E then
		return false;
	end;
	if u then
		for u, W in ipairs(US) do
			local U = E:FindFirstChild(W);
			if U and (U:IsA("BasePart") and not D.korbloxData[U]) then
				local u = U.Transparency;
				local W = U.LocalTransparencyModifier;
				U.LocalTransparencyModifier = 1;
				U.Transparency = 1;
				local Q = Instance.new("Part");
				Q.Name = "KorbloxDeco";
				Q.Size = U.Size;
				Q.CFrame = U.CFrame;
				Q.Color = Color3.fromRGB(0, 0, 0);
				Q.Material = Enum.Material.Plastic;
				Q.CanCollide = false;
				Q.CanQuery = false;
				Q.CanTouch = false;
				Q.CastShadow = false;
				Q.Massless = true;
				Q.Anchored = false;
				local A = Instance.new("SpecialMesh");
				A.MeshType = Enum.MeshType.FileMesh;
				A.MeshId = WS;
				A.Scale = Vector3.new(1, 1, 1);
				A.Parent = Q;
				Q.Parent = E;
				local y = Instance.new("WeldConstraint");
				y.Part0 = U;
				y.Part1 = Q;
				y.Parent = Q;
				Q.CFrame = U.CFrame;
				D.korbloxData[U] = { deco = Q, origTrans = u, origLTM = W };
			end;
		end;
	else
		for u, E in pairs(D.korbloxData) do
			if u and u.Parent then
				u.LocalTransparencyModifier = E.origLTM;
				u.Transparency = E.origTrans;
			end;
			if E.deco and E.deco.Parent then
				E.deco:Destroy();
			end;
		end;
		table.clear(D.korbloxData);
	end;
	return true;
end;
local function AS()
	for u, E in ipairs(D.hideConns) do
		pcall(function()
			E:Disconnect();
		end);
	end;
	table.clear(D.hideConns);
end;
local function yS()
	AS();
	if D.unloaded then
		return;
	end;
	local function E(u)
		if not u then
			return false;
		end;
		if not ((u:IsA("BillboardGui") or u:IsA("SurfaceGui"))) then
			return false;
		end;
		local E = string.lower(tostring(u.Name));
		if E:find("nick") or E:find("name") or E:find("tag") or E:find("title") or E:find("label") then
			return true;
		end;
		local W = u.Parent;
		if W and W.Name == "Head" then
			return true;
		end;
		return false;
	end;
	local function W(u)
		if not u or not u.Parent then
			return;
		end;
		pcall(function()
			u.Enabled = false;
		end);
		pcall(function()
			u.Visible = false;
		end);
		if not u:GetAttribute("_XD_nickHooked") then
			u:SetAttribute("_XD_nickHooked", true);
			table.insert(D.hideConns, (u:GetPropertyChangedSignal("Enabled")):Connect(function()
				if u.Enabled then
					pcall(function()
						u.Enabled = false;
					end);
				end;
			end));
			table.insert(D.hideConns, (u:GetPropertyChangedSignal("Visible")):Connect(function()
				if u.Visible then
					pcall(function()
						u.Visible = false;
					end);
				end;
			end));
		end;
	end;
	local function U(u)
		if not u then
			return;
		end;
		for u, U in ipairs(u:GetDescendants()) do
			if E(U) then
				W(U);
			end;
		end;
	end;
	local function A(u)
		if not u then
			return;
		end;
		U(u);
		table.insert(D.hideConns, u.DescendantAdded:Connect(function(u)
			if E(u) then
				task.defer(function()
					W(u);
				end);
			end;
		end));
	end;
	if k.Character then
		A(k.Character);
	end;
	table.insert(D.hideConns, k.CharacterAdded:Connect(function(u)
		task.wait(.3);
		A(u);
	end));
	table.insert(D.hideConns, u.PlayerAdded:Connect(function(u)
		u.CharacterAdded:Connect(function(u)
			if D.unloaded then
				return;
			end;
			task.wait(.3);
			A(u);
		end);
	end));
	for u, E in ipairs(u:GetPlayers()) do
		if E ~= k and E.Character then
			A(E.Character);
			table.insert(D.hideConns, E.CharacterAdded:Connect(function(u)
				if D.unloaded then
					return;
				end;
				task.wait(.3);
				A(u);
			end));
		end;
	end;
	if D._nickLoop then
		pcall(function()
			task.cancel(D._nickLoop);
		end);
	end;
	D._nickLoop = task.spawn(function()
			while not D.unloaded and I.HideNick do
				pcall(function()
					if k.Character then
						U(k.Character);
					end;
					for u, E in ipairs(u:GetPlayers()) do
						if E ~= k and E.Character then
							U(E.Character);
						end;
					end;
				end);
				Q.RenderStepped:Wait();
			end;
		end);
end;
local KS = "InkInstinct";
local function lS()
	if D.FILE.isfolder and D.FILE.makefolder then
		local u, E = pcall(D.FILE.isfolder, KS);
		if not u or not E then
			pcall(D.FILE.makefolder, KS);
		end;
	end;
end;
local function OS(u)
	return KS .. ("/" .. (tostring(u) .. ".json"));
end;
local function qS(u)
	local E = {};
	for u, W in pairs(u) do
		if typeof(W) == "Color3" then
			E[u] = { W.R, W.G, W.B };
		elseif typeof(W) == "EnumItem" then
			E[u] = W.Name;
		else
			E[u] = W;
		end;
	end;
	return E;
end;
local function xS(u, E)
	if type(E) ~= "table" then
		return;
	end;
	for E, W in pairs(E) do
		if E == "MenuKey" and type(W) == "string" then
			local U, Q = pcall(function()
					return Enum.KeyCode[W];
				end);
			if U and Q then
				u[E] = Q;
			end;
		elseif u[E] ~= nil and type(W) == type(u[E]) then
			u[E] = W;
		end;
	end;
end;
local function kS(u)
	if u.C or u.H or u.anim then
		xS(I, u.C or u.ui);
		xS(n, u.H or u.hns);
		if type(u.anim) == "table" then
			for u, E in pairs(u.anim) do
				if i_[tostring(u)] ~= nil and not T_[tostring(u)] then
					D.animEnabled[tostring(u)] = E and true or false;
				end;
			end;
		end;
	else
		xS(I, u);
	end;
	mL();
	H_();
	A_();
	RL();
	xL();
	m_();
end;
local function fS(u)
	u = u or D.currentConfigName;
	if not D.FILE.writefile then
		return false, "no writefile";
	end;
	lS();
	local E = (tostring(u)):gsub("[^%w%-%_]", "");
	if E == "" then
		E = "default";
	end;
	D.currentConfigName = E;
	local W = { C = qS(I), H = qS(n), anim = D.animEnabled };
	local U = pcall(function()
			D.FILE.writefile(OS(E), A:JSONEncode(W));
		end);
	if not U then
		return false, "writefile failed";
	end;
	return true, "ok";
end;
local function ZS(u)
	u = u or D.currentConfigName;
	if not D.FILE.readfile or not D.FILE.isfile then
		return false, "no readfile";
	end;
	local E = OS(u);
	local W, U = pcall(D.FILE.isfile, E);
	if not W or not U then
		return false, "not found";
	end;
	local Q, y = pcall(D.FILE.readfile, E);
	if not Q or not y then
		return false, "read failed";
	end;
	local K, l = pcall(function()
			return A:JSONDecode(y);
		end);
	if not K or type(l) ~= "table" then
		return false, "bad json";
	end;
	kS(l);
	D.currentConfigName = (tostring(u)):gsub("[^%w%-%_]", "");
	return true, "ok";
end;
local function DS()
	local u = {};
	if not D.FILE.listfiles or not D.FILE.isfolder then
		return u;
	end;
	local E, W = pcall(D.FILE.isfolder, KS);
	if not E or not W then
		return u;
	end;
	local U, Q = pcall(D.FILE.listfiles, KS);
	if not U or type(Q) ~= "table" then
		return u;
	end;
	for E, W in ipairs(Q) do
		local U = (tostring(W)):match("([^/\\]+)%.json$");
		if U and U ~= "" then
			table.insert(u, U);
		end;
	end;
	table.sort(u);
	return u;
end;
local function VS(u)
	if not D.FILE.delfile then
		return false, "no delfile";
	end;
	local E = pcall(D.FILE.delfile, OS(u));
	return E;
end;
D.ui = {};
D.ui.PANEL_W = 400;
D.ui.PANEL_H = 660;
D.ui.CONTENT_W = D.ui.PANEL_W - 16;
D.ui.CONTENT_H = D.ui.PANEL_H - 90;
D.ui.BTN_W = D.ui.CONTENT_W - 8;
D.ui.COL = {
		bg = Color3.fromRGB(11, 9, 18),
		bg2 = Color3.fromRGB(22, 15, 36),
		card = Color3.fromRGB(26, 20, 40),
		text = Color3.fromRGB(235, 225, 250),
		textDim = Color3.fromRGB(150, 135, 175),
		off = Color3.fromRGB(22, 17, 34),
	};
D.ui.tabFrames = {};
D.ui.activeTab = "Main";
D.ui.pickerOverlay = nil;
function D.ui.mkDivider(u, E, W)
	local U = Instance.new("Frame");
	U.Size = UDim2.new(1, -8, 0, 18);
	U.Position = UDim2.fromOffset(4, E);
	U.BackgroundTransparency = 1;
	U.ZIndex = 5;
	U.Parent = u;
	local Q = Instance.new("TextLabel");
	Q.Size = UDim2.fromOffset(180, 18);
	Q.BackgroundTransparency = 1;
	Q.Font = Enum.Font.GothamBold;
	Q.TextSize = 9;
	Q.Text = string.upper(W or "");
	Q.TextColor3 = r();
	Q.TextXAlignment = Enum.TextXAlignment.Left;
	Q.ZIndex = 6;
	Q.Parent = U;
	Q_(function()
		Q.TextColor3 = r();
	end);
	local A = Instance.new("Frame");
	A.Size = UDim2.new(1, -190, 0, 1);
	A.Position = UDim2.fromOffset(190, 9);
	A.BackgroundColor3 = r();
	A.BackgroundTransparency = .72;
	A.BorderSizePixel = 0;
	A.ZIndex = 6;
	A.Parent = U;
	Q_(function()
		A.BackgroundColor3 = r();
	end);
end;
function D.ui.makeToggle(u, E, W, U, Q, A, K)
	local l = D.ui.COL;
	local O = D.ui.BTN_W;
	K = K or I;
	local q = Instance.new("TextButton");
	q.Size = UDim2.fromOffset(O, 26);
	q.Position = UDim2.fromOffset(4, E);
	q.BorderSizePixel = 0;
	q.Font = Enum.Font.Gotham;
	q.TextSize = 12;
	q.TextXAlignment = Enum.TextXAlignment.Left;
	q.TextColor3 = S();
	q.AutoButtonColor = false;
	q.ZIndex = 6;
	q.Parent = u;
	K_(q, 7);
	local x = Instance.new("Frame");
	x.Size = UDim2.fromOffset(30, 16);
	x.Position = UDim2.new(1, -38, .5, -8);
	x.BorderSizePixel = 0;
	x.ZIndex = 7;
	x.Parent = q;
	K_(x, 8);
	local k = Instance.new("Frame");
	k.Size = UDim2.fromOffset(12, 12);
	k.Position = UDim2.fromOffset(2, 2);
	k.BackgroundColor3 = Color3.new(1, 1, 1);
	k.BorderSizePixel = 0;
	k.ZIndex = 8;
	k.Parent = x;
	K_(k, 6);
	local function f()
		if Q then
			return Q() and true or false;
		end;
		if U then
			return K[U] and true or false;
		end;
		return false;
	end;
	local function Z(u)
		local E = f();
		q.Text = "   " .. W;
		local U = E and o(r()) or l.off;
		local Q = E and r() or Color3.fromRGB(60, 50, 78);
		local A = E and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
		if u then
			local u = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			(y:Create(q, u, { BackgroundColor3 = U })):Play();
			(y:Create(x, u, { BackgroundColor3 = Q })):Play();
			(y:Create(k, u, { Position = A })):Play();
		else
			q.BackgroundColor3 = U;
			x.BackgroundColor3 = Q;
			k.Position = A;
		end;
		q.TextColor3 = S();
	end;
	Q_(function()
		local u = f();
		q.BackgroundColor3 = u and o(r()) or l.off;
		q.TextColor3 = S();
		x.BackgroundColor3 = u and r() or Color3.fromRGB(60, 50, 78);
		k.Position = u and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
	end);
	Z(false);
	q.MouseButton1Click:Connect(function()
		if D.unloaded then
			return;
		end;
		y_();
		local u = not f();
		if U then
			K[U] = u;
		end;
		if A then
			A(u);
		else
			if U == "Enabled" then
				H_();
			elseif U == "RadiusVis" then
				mL();
			elseif U == "RemoveLegs" then
				YL(K.RemoveLegs);
				uS();
			elseif U == "RemoveHands" then
				HL(K.RemoveHands);
				uS();
				sL();
			elseif U == "RemoveTorso" then
				GL(K.RemoveTorso);
				uS();
				sL();
			elseif U == "Headless" then
				ES(K.Headless);
			elseif U == "Korblox" then
				QS(K.Korblox);
			elseif U == "RebelFOVCircle" then
				xL();
			elseif U == "RebelFOVNeon" or U == "RebelFOVBlackOutline" then
				xL();
			elseif U == "Watermark" or U == "KeybindList" then
				m_();
			elseif U == "GuardESP" or U == "PlayerESP" then
				RL();
			elseif U == "HideNick" then
				yS();
			elseif U == "FullBright" then
				vL(K.FullBright);
			elseif U == "RemoveFog" then
				iL(K.RemoveFog);
			elseif U == "FOVRainbow" then
				if K.FOVRainbow then
					lL();
				else
					AL();
					xL();
				end;
			elseif U == "PanelRainbow" then
				if K.PanelRainbow then
					qL();
				else
					OL();
					if D.panel then
						local u = D.panel:FindFirstChildOfClass("UIStroke");
						if u then
							u.Color = r();
						end;
					end;
				end;
			elseif U == "BulletTracer" then
 
			elseif U == "FOVUseCustom" then
				xL();
				if K.FOVRainbow then
					lL();
				end;
			elseif U == "AutoBrew" then
				if K.AutoBrew then
					rL();
				else
					SL();
				end;
			elseif U == "CircleRainbowText" or U == "CircleRainbowOutline" then
				A_();
			elseif type(U) == "string" and ((U:sub(1, 9) == "GuardESP_" or U:sub(1, 10) == "PlayerESP_")) then
				RL();
			end;
		end;
		Z(true);
		if _G.__adShowNotif then
			_G.__adShowNotif(W .. (":  " .. ((u and "ON" or "OFF"))), u and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80));
		end;
	end);
	return Z;
end;
function D.ui.makeSlider(u, E, U, Q, A, y, K, l, O)
	local q = D.ui.COL;
	local x = D.ui.BTN_W;
	l = l or I;
	local k = Instance.new("Frame");
	k.Size = UDim2.fromOffset(x, 40);
	k.Position = UDim2.fromOffset(4, E);
	k.BackgroundTransparency = 1;
	k.ZIndex = 5;
	k.Parent = u;
	local f = Instance.new("TextLabel");
	f.Size = UDim2.fromOffset(x, 14);
	f.BackgroundTransparency = 1;
	f.Font = Enum.Font.Gotham;
	f.TextSize = 11;
	f.TextXAlignment = Enum.TextXAlignment.Left;
	f.TextColor3 = S();
	f.ZIndex = 6;
	f.Parent = k;
	Q_(function()
		f.TextColor3 = S();
	end);
	local function Z()
		f.Text = U .. ("   " .. tostring(l[Q]));
	end;
	Z();
	local V = Instance.new("TextButton");
	V.Size = UDim2.fromOffset(x, 14);
	V.Position = UDim2.fromOffset(0, 18);
	V.BackgroundColor3 = q.card;
	V.BorderSizePixel = 0;
	V.Text = "";
	V.AutoButtonColor = false;
	V.ZIndex = 6;
	V.Parent = k;
	K_(V, 7);
	local X = Instance.new("Frame");
	X.Size = UDim2.new(math.clamp(((((l[Q] or A)) - A)) / ((y - A)), 0, 1), 0, 1, 0);
	X.BorderSizePixel = 0;
	X.ZIndex = 7;
	X.Parent = V;
	K_(X, 7);
	X.BackgroundColor3 = r();
	Q_(function()
		X.BackgroundColor3 = r();
	end);
	local m = Instance.new("Frame");
	m.Size = UDim2.fromOffset(12, 12);
	m.BackgroundColor3 = Color3.new(1, 1, 1);
	m.BorderSizePixel = 0;
	m.ZIndex = 8;
	m.Parent = V;
	K_(m, 6);
	O_(m, Color3.new(0, 0, 0), 1, .5);
	local n = false;
	local function v()
		local u = ((((l[Q] or A)) - A)) / ((y - A));
		m.Position = UDim2.new(u, -6, .5, -6);
	end;
	v();
	local function i(u)
		local E = math.clamp(((u - V.AbsolutePosition.X)) / math.max(V.AbsoluteSize.X, 1), 0, 1);
		local W = A + E * ((y - A));
		W = math.floor(W / K + .5) * K;
		if K < 1 then
			W = math.floor(W * 100 + .5) / 100;
		end;
		l[Q] = math.clamp(W, A, y);
		X.Size = UDim2.new(((l[Q] - A)) / ((y - A)), 0, 1, 0);
		v();
		Z();
		if O then
			pcall(O);
		end;
	end;
	V.InputBegan:Connect(function(u)
		if u.UserInputType == Enum.UserInputType.MouseButton1 or u.UserInputType == Enum.UserInputType.Touch then
			n = true;
			i(u.Position.X);
		end;
	end);
	b(W.InputEnded:Connect(function(u)
		if u.UserInputType == Enum.UserInputType.MouseButton1 or u.UserInputType == Enum.UserInputType.Touch then
			n = false;
		end;
	end));
	b(W.InputChanged:Connect(function(u)
		if n and ((u.UserInputType == Enum.UserInputType.MouseMovement or u.UserInputType == Enum.UserInputType.Touch)) then
			i(u.Position.X);
		end;
	end));
	return Z;
end;
function D.ui.makeBtn(u, E, W, U)
	local Q = D.ui.COL;
	local A = D.ui.BTN_W;
	local y = Instance.new("TextButton");
	y.Size = UDim2.fromOffset(A, 28);
	y.Position = UDim2.fromOffset(4, E);
	y.BackgroundColor3 = Q.card;
	y.BorderSizePixel = 0;
	y.Font = Enum.Font.GothamBold;
	y.TextSize = 12;
	y.TextColor3 = S();
	y.Text = W;
	y.ZIndex = 6;
	y.Parent = u;
	K_(y, 7);
	Q_(function()
		y.TextColor3 = S();
	end);
	local K = O_(y, r(), 1, .55);
	Q_(function()
		K.Color = r();
	end);
	y.MouseButton1Click:Connect(function()
		if D.unloaded then
			return;
		end;
		y_();
		U();
	end);
	return y;
end;
function D.ui.makeInput(u, E, W)
	local U = D.ui.COL;
	local Q = D.ui.BTN_W;
	local A = Instance.new("TextBox");
	A.Size = UDim2.fromOffset(Q, 26);
	A.Position = UDim2.fromOffset(4, E);
	A.BackgroundColor3 = U.card;
	A.BorderSizePixel = 0;
	A.Font = Enum.Font.Gotham;
	A.TextSize = 12;
	A.TextColor3 = S();
	A.PlaceholderText = W;
	A.PlaceholderColor3 = U.textDim;
	A.Text = "";
	A.ClearTextOnFocus = false;
	A.ZIndex = 6;
	A.Parent = u;
	K_(A, 7);
	Q_(function()
		A.TextColor3 = S();
	end);
	local y = O_(A, U.off, 1, .4);
	Q_(function()
		y.Color = r();
	end);
	return A;
end;
function D.ui.colorRow(u, E, W, U, Q)
	local A = D.ui.COL;
	local y = D.ui.BTN_W;
	local K = Instance.new("Frame");
	K.Size = UDim2.fromOffset(y, 30);
	K.Position = UDim2.fromOffset(4, E);
	K.BackgroundTransparency = 1;
	K.ZIndex = 5;
	K.Parent = u;
	local l = Instance.new("TextLabel");
	l.Size = UDim2.fromOffset(120, 30);
	l.Position = UDim2.fromOffset(0, 0);
	l.BackgroundTransparency = 1;
	l.Font = Enum.Font.Gotham;
	l.TextSize = 11;
	l.TextXAlignment = Enum.TextXAlignment.Left;
	l.TextColor3 = S();
	l.Text = W or "";
	l.ZIndex = 6;
	l.Parent = K;
	Q_(function()
		l.TextColor3 = S();
	end);
	local O = Instance.new("Frame");
	O.Size = UDim2.fromOffset(28, 28);
	O.Position = UDim2.fromOffset(y - 148, 1);
	O.BorderSizePixel = 0;
	O.BackgroundColor3 = U();
	O.ZIndex = 6;
	O.Parent = K;
	K_(O, 8);
	local q = O_(O, r(), 1.5, .2);
	Q_(function()
		q.Color = r();
	end);
	local x = Instance.new("TextButton");
	x.Size = UDim2.fromOffset(114, 26);
	x.Position = UDim2.fromOffset(y - 116, 2);
	x.BackgroundColor3 = A.card;
	x.BorderSizePixel = 0;
	x.Font = Enum.Font.GothamBold;
	x.TextSize = 11;
	x.TextColor3 = S();
	x.Text = "Change color";
	x.AutoButtonColor = false;
	x.ZIndex = 6;
	x.Parent = K;
	Q_(function()
		x.TextColor3 = S();
	end);
	K_(x, 6);
	local k = O_(x, r(), 1, .5);
	Q_(function()
		k.Color = r();
	end);
	x.MouseButton1Click:Connect(function()
		if D.unloaded then
			return;
		end;
		y_();
		if D.colorPickerOpen then
			D.colorPickerOpen(U(), function(u)
				pcall(Q, u);
				O.BackgroundColor3 = u;
			end);
		end;
	end);
	Q_(function()
		O.BackgroundColor3 = U();
	end);
end;
function D.ui.buildPanel()
	local u = D.ui.COL;
	local E = D.ui.PANEL_W;
	local U = D.ui.PANEL_H;
	local A = nil;
	if gethui then
		local u, E = pcall(gethui);
		if u and (E and typeof(E) == "Instance") then
			A = E;
		end;
	end;
	if not A or typeof(A) ~= "Instance" then
		A = k:FindFirstChildOfClass("PlayerGui");
	end;
	if not A then
		A = k:WaitForChild("PlayerGui", 5);
	end;
	if not A then
		A = game:GetService("CoreGui");
	end;
	D.gui = Instance.new("ScreenGui");
	D.gui.Name = "XD_x1oni1x_" .. E_(6);
	D.gui.ResetOnSpawn = false;
	D.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	D.gui.DisplayOrder = 100000;
	D.gui.IgnoreGuiInset = true;
	D.gui.Enabled = true;
	pcall(function()
		D.gui.Parent = A;
	end);
	if not D.gui.Parent then
		pcall(function()
			D.gui.Parent = game:GetService("CoreGui");
		end);
	end;
	D.glow = Instance.new("Frame");
	D.glow.Size = UDim2.fromOffset(E + 40, U + 40);
	D.glow.Position = UDim2.new(.5, (-E / 2 - 20) - 800, .5, -U / 2 - 20);
	D.glow.BackgroundColor3 = r();
	D.glow.BackgroundTransparency = .86;
	D.glow.BorderSizePixel = 0;
	D.glow.ZIndex = 0;
	D.glow.Parent = D.gui;
	K_(D.glow, 22);
	Q_(function()
		D.glow.BackgroundColor3 = r();
	end);
	D.shadow = Instance.new("Frame");
	D.shadow.Size = UDim2.fromOffset(E + 12, U + 12);
	D.shadow.Position = UDim2.new(.5, (-E / 2 + 6) - 800, .5, -U / 2 + 6);
	D.shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	D.shadow.BackgroundTransparency = .65;
	D.shadow.BorderSizePixel = 0;
	D.shadow.ZIndex = 1;
	D.shadow.Parent = D.gui;
	K_(D.shadow, 18);
	D.panel = Instance.new("Frame");
	D.panel.Size = UDim2.fromOffset(E, U);
	D.panel.Position = UDim2.new(.5, -E / 2 - 800, .5, -U / 2);
	D.panel.BackgroundColor3 = u.bg;
	D.panel.BorderSizePixel = 0;
	D.panel.Active = true;
	D.panel.Visible = true;
	D.panel.ZIndex = 2;
	D.panel.Parent = D.gui;
	D.panel.ClipsDescendants = true;
	K_(D.panel, 14);
	l_(D.panel, u.bg2, u.bg, 90);
	local K = O_(D.panel, r(), 1.4, .35);
	Q_(function()
		if not I.PanelRainbow then
			K.Color = r();
		end;
	end);
	b((D.panel:GetPropertyChangedSignal("Position")):Connect(function()
		D.shadow.Position = UDim2.new(D.panel.Position.X.Scale, D.panel.Position.X.Offset + 6, D.panel.Position.Y.Scale, D.panel.Position.Y.Offset + 6);
		D.glow.Position = UDim2.new(D.panel.Position.X.Scale, D.panel.Position.X.Offset - 20, D.panel.Position.Y.Scale, D.panel.Position.Y.Offset - 20);
	end));
	task.spawn(function()
		task.wait(.05);
		if D.unloaded or not D.panel or not D.panel.Parent then
			return;
		end;
		local u = TweenInfo.new(.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
		(y:Create(D.panel, u, { Position = UDim2.new(.5, -E / 2, .5, -U / 2) })):Play();
		if D.shadow and D.shadow.Parent then
			(y:Create(D.shadow, u, { Position = UDim2.new(.5, -E / 2 + 6, .5, -U / 2 + 6) })):Play();
		end;
		if D.glow and D.glow.Parent then
			(y:Create(D.glow, u, { Position = UDim2.new(.5, -E / 2 - 20, .5, -U / 2 - 20) })):Play();
		end;
	end);
	do
		local u = false;
		local E = nil;
		local U = nil;
		b(D.panel.InputBegan:Connect(function(W)
			if W.UserInputType == Enum.UserInputType.MouseButton1 or W.UserInputType == Enum.UserInputType.Touch then
				u = true;
				E = W.Position;
				U = D.panel.Position;
				W.Changed:Connect(function()
					if W.UserInputState == Enum.UserInputState.End then
						u = false;
					end;
				end);
			end;
		end));
		b(W.InputChanged:Connect(function(W)
			if not u then
				return;
			end;
			if W.UserInputType == Enum.UserInputType.MouseMovement or W.UserInputType == Enum.UserInputType.Touch then
				local u = W.Position - E;
				D.panel.Position = UDim2.new(U.X.Scale, U.X.Offset + u.X, U.Y.Scale, U.Y.Offset + u.Y);
			end;
		end));
	end;
	local O = Instance.new("Frame");
	O.Size = UDim2.new(1, -28, 0, 2);
	O.Position = UDim2.fromOffset(14, 0);
	O.BackgroundColor3 = r();
	O.BorderSizePixel = 0;
	O.ZIndex = 3;
	O.Parent = D.panel;
	K_(O, 2);
	Q_(function()
		O.BackgroundColor3 = r();
	end);
	local q = Instance.new("TextLabel");
	q.Size = UDim2.fromOffset(240, 20);
	q.Position = UDim2.fromOffset(14, 12);
	q.BackgroundTransparency = 1;
	q.Font = Enum.Font.GothamBlack;
	q.TextSize = 13;
	q.TextXAlignment = Enum.TextXAlignment.Left;
	q.TextColor3 = r();
	q.Text = f;
	q.ZIndex = 3;
	q.Parent = D.panel;
	Q_(function()
		q.TextColor3 = r();
	end);
	local x = Instance.new("TextLabel");
	x.Size = UDim2.fromOffset(140, 40);
	x.Position = UDim2.new(1, -192, 0, 12);
	x.BackgroundTransparency = 1;
	x.Font = Enum.Font.Code;
	x.TextSize = 10;
	x.TextXAlignment = Enum.TextXAlignment.Right;
	x.TextYAlignment = Enum.TextYAlignment.Top;
	x.TextColor3 = u.textDim;
	x.Text = "fps ---\nping ---";
	x.ZIndex = 3;
	x.Parent = D.panel;
	local V = Instance.new("TextLabel");
	V.Size = UDim2.new(1, -20, 0, 12);
	V.Position = UDim2.fromOffset(14, 30);
	V.BackgroundTransparency = 1;
	V.Font = Enum.Font.Gotham;
	V.TextSize = 9;
	V.TextXAlignment = Enum.TextXAlignment.Left;
	V.TextColor3 = S();
	V.Text = "ink game - auto dodge";
	V.ZIndex = 3;
	V.Parent = D.panel;
	Q_(function()
		V.TextColor3 = S();
	end);
	local X = Instance.new("TextLabel");
	X.Size = UDim2.new(1, -20, 0, 12);
	X.Position = UDim2.fromOffset(14, 44);
	X.BackgroundTransparency = 1;
	X.Font = Enum.Font.Code;
	X.TextSize = 10;
	X.TextXAlignment = Enum.TextXAlignment.Left;
	X.TextColor3 = S();
	X.Text = "ready - N to close";
	X.ZIndex = 3;
	X.Parent = D.panel;
	Q_(function()
		X.TextColor3 = S();
	end);
	local m = Instance.new("TextButton");
	m.AnchorPoint = Vector2.new(1, 0);
	m.Size = UDim2.fromOffset(24, 24);
	m.Position = UDim2.new(1, -12, 0, 12);
	m.BackgroundColor3 = u.card;
	m.BorderSizePixel = 0;
	m.Font = Enum.Font.GothamBlack;
	m.TextSize = 18;
	m.TextColor3 = S();
	m.Text = "-";
	m.AutoButtonColor = false;
	m.ZIndex = 12;
	m.Parent = D.panel;
	Q_(function()
		m.TextColor3 = S();
	end);
	K_(m, 6);
	local v = O_(m, r(), 1.5, 0);
	Q_(function()
		v.Color = r();
	end);
	local function i(u)
		if not D.unloaded and (X and X.Parent) then
			X.Text = tostring(u or "");
		end;
	end;
	_G.__ad_statusCb = i;
	local T = 0;
	local g = tick();
	local o = 0;
	b(Q.RenderStepped:Connect(function()
		T = T + 1;
		local u = tick();
		if u - g >= 2 then
			o = math.floor(T / ((u - g)));
			T = 0;
			g = u;
		end;
	end));
	task.spawn(function()
		while not D.unloaded do
			local u = 0;
			pcall(function()
				local E = l.Network.ServerStatsItem["Data Ping"];
				if E then
					u = math.floor(E:GetValue());
				end;
			end);
			if not D.unloaded and (x and x.Parent) then
				local E = game.JobId or "";
				if #E > 8 then
					E = E:sub(1, 8);
				end;
				if E == "" then
					E = "studio";
				end;
				x.Text = string.format("fps %d\nping %d - srv %s", o, u, E);
			end;
			if not D.unloaded and (D.wmLabel and I.Watermark) then
				pcall(function()
					local E = tostring(k.Name or "?");
					if #E > 14 then
						E = E:sub(1, 14) .. "...";
					end;
					local W = (I.MenuKey and I.MenuKey.Name) or "N";
					D.wmLabel.Text = string.format("%s %s\n%s | %dms | [%s]", f, Z, E, u, W);
				end);
			end;
			if not D.unloaded and (D.kbLabel and I.KeybindList) then
				pcall(function()
					local u = {};
					if I.Enabled then
						table.insert(u, "AutoDodge:  ON");
					end;
					if n.Enabled then
						table.insert(u, "HnS Dodge:  ON");
					end;
					if I.RLGL_AutoDodge then
						table.insert(u, "RLGL:  ON");
					end;
					if I.RebelSilentAim then
						table.insert(u, "Silent Aim:  ON");
					end;
					if I.RebelNoRecoil then
						table.insert(u, "No Recoil:  ON");
					end;
					if I.RebelRapidFire then
						table.insert(u, "Rapid Fire:  ON");
					end;
					if I.BulletTracer then
						table.insert(u, "Bullet Tracer:  ON");
					end;
					if I.GuardESP then
						table.insert(u, "Guard ESP:  ON");
					end;
					if I.PlayerESP then
						table.insert(u, "Player ESP:  ON");
					end;
					if I.HideNick then
						table.insert(u, "HideNick:  ON");
					end;
					if I.FullBright then
						table.insert(u, "Full Bright:  ON");
					end;
					if I.RemoveFog then
						table.insert(u, "No Fog:  ON");
					end;
					if I.AutoBrew then
						table.insert(u, "Auto Brew:  ON");
					end;
					if I.AnimSpeed then
						table.insert(u, "Anim 2.5x:  ON");
					end;
					D.kbLabel.Text = (#u == 0) and "[no features]" or table.concat(u, "\n");
					if D.kbFrame then
						local E = math.max(1, #u);
						D.kbFrame.Size = UDim2.fromOffset(210, math.max(30, E * 12 + 8));
					end;
				end);
			end;
			task.wait(3);
		end;
	end);
	local J = Instance.new("Frame");
	J.Size = UDim2.new(1, -16, 0, 26);
	J.Position = UDim2.fromOffset(8, 58);
	J.BackgroundColor3 = u.off;
	J.BackgroundTransparency = .35;
	J.BorderSizePixel = 0;
	J.ZIndex = 3;
	J.Parent = D.panel;
	K_(J, 8);
	local j = {
			"Main",
			"HnS",
			"Rebel",
			"RLGL",
			"ESP",
			"Dalgona",
			"Extra",
			"Configs",
		};
	local N = Instance.new("Frame");
	N.Size = UDim2.fromOffset(D.ui.CONTENT_W, D.ui.CONTENT_H);
	N.Position = UDim2.fromOffset(8, 88);
	N.BackgroundTransparency = 1;
	N.ZIndex = 4;
	N.Parent = D.panel;
	for u, E in ipairs(j) do
		local W = Instance.new("ScrollingFrame");
		W.Size = UDim2.fromOffset(D.ui.CONTENT_W, D.ui.CONTENT_H);
		W.BackgroundTransparency = 1;
		W.BorderSizePixel = 0;
		W.ScrollBarThickness = 3;
		W.ScrollBarImageColor3 = r();
		W.ScrollingDirection = Enum.ScrollingDirection.Y;
		W.CanvasSize = UDim2.fromOffset(0, 5000);
		W.ElasticBehavior = Enum.ElasticBehavior.Never;
		W.Visible = E == "Main";
		W.ZIndex = 5;
		W.Parent = N;
		Q_(function()
			if W and W.Parent then
				W.ScrollBarImageColor3 = r();
			end;
		end);
		D.ui.tabFrames[E] = W;
	end;
	D.ui.showTab = function(u)
			D.ui.activeTab = u;
			for E, W in pairs(D.ui.tabFrames) do
				W.Visible = E == u;
			end;
			A_();
			if u == "Configs" and _G.__adRefreshConfigs then
				pcall(_G.__adRefreshConfigs);
			end;
		end;
	do
		local E = #j;
		local W = math.floor(((D.ui.CONTENT_W - 4)) / E);
		local U = 2;
		for E, Q in ipairs(j) do
			local A = Instance.new("TextButton");
			A.Size = UDim2.fromOffset(W, 22);
			A.Position = UDim2.fromOffset(U, 2);
			A.BorderSizePixel = 0;
			A.Font = Enum.Font.GothamBold;
			A.TextSize = 8;
			A.Text = Q;
			A.AutoButtonColor = false;
			A.ZIndex = 4;
			A.Parent = J;
			A.TextTruncate = Enum.TextTruncate.AtEnd;
			A.TextScaled = false;
			K_(A, 6);
			A.MouseButton1Click:Connect(function()
				y_();
				D.ui.showTab(Q);
			end);
			Q_(function()
				local E = D.ui.activeTab == Q;
				A.BackgroundColor3 = E and r() or u.off;
				A.BackgroundTransparency = E and 0 or 1;
				A.TextColor3 = E and Color3.new(1, 1, 1) or S();
			end);
			U = U + W;
		end;
	end;
	A_();
	D.ui.collapseBtn = m;
	D.ui.buildColorPicker();
end;
function D.ui.buildColorPicker()
	local u = D.ui.COL;
	local E = D.ui.PANEL_W;
	local U = D.ui.PANEL_H;
	local Q = Instance.new("Frame");
	Q.Size = UDim2.fromOffset(E, U);
	Q.Position = UDim2.fromOffset(0, 0);
	Q.BackgroundColor3 = u.bg;
	Q.BackgroundTransparency = .02;
	Q.Visible = false;
	Q.ZIndex = 60;
	Q.Parent = D.panel;
	K_(Q, 14);
	l_(Q, u.bg2, u.bg, 90);
	D.ui.pickerOverlay = Q;
	local A = Instance.new("TextLabel");
	A.Size = UDim2.new(1, -40, 0, 22);
	A.Position = UDim2.fromOffset(14, 14);
	A.BackgroundTransparency = 1;
	A.Font = Enum.Font.GothamBlack;
	A.TextSize = 14;
	A.TextXAlignment = Enum.TextXAlignment.Left;
	A.TextColor3 = r();
	A.Text = "COLOR PICKER";
	A.ZIndex = 61;
	A.Parent = Q;
	Q_(function()
		A.TextColor3 = r();
	end);
	local y = Instance.new("TextButton");
	y.Size = UDim2.fromOffset(60, 24);
	y.Position = UDim2.new(1, -74, 0, 12);
	y.BackgroundColor3 = u.card;
	y.BorderSizePixel = 0;
	y.Font = Enum.Font.GothamBold;
	y.TextSize = 11;
	y.TextColor3 = S();
	y.Text = "X close";
	y.ZIndex = 61;
	y.Parent = Q;
	Q_(function()
		y.TextColor3 = S();
	end);
	K_(y, 6);
	local K = O_(y, r(), 1, .5);
	Q_(function()
		K.Color = r();
	end);
	local l = Instance.new("Frame");
	l.Size = UDim2.fromOffset(150, 120);
	l.Position = UDim2.new(.5, -75, 0, 40);
	l.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	l.BorderSizePixel = 0;
	l.ZIndex = 61;
	l.Parent = Q;
	K_(l, 12);
	local O = O_(l, r(), 2, 0);
	Q_(function()
		O.Color = r();
	end);
	local q = Instance.new("TextLabel");
	q.Size = UDim2.new(1, 0, 0, 18);
	q.Position = UDim2.new(0, 0, 1, -22);
	q.BackgroundTransparency = 1;
	q.Font = Enum.Font.Code;
	q.TextSize = 11;
	q.TextColor3 = Color3.fromRGB(255, 255, 255);
	q.TextStrokeTransparency = .4;
	q.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	q.Text = "#FFFFFF";
	q.ZIndex = 62;
	q.Parent = l;
	local x = {
			R = 255,
			G = 255,
			B = 255,
			bright = 1,
			callback = nil,
		};
	local function k(u)
		return math.clamp(math.floor(u * x.bright + .5), 0, 255);
	end;
	local function f()
		local u = k(x.R);
		local E = k(x.G);
		local W = k(x.B);
		l.BackgroundColor3 = Color3.fromRGB(u, E, W);
		q.Text = string.format("RGB %d,%d,%d  x%.2f", u, E, W, x.bright);
	end;
	local function Z(E, U, A, y, K, l)
		local O = Instance.new("Frame");
		O.Size = UDim2.new(1, -28, 0, 46);
		O.Position = UDim2.fromOffset(14, E);
		O.BackgroundTransparency = 1;
		O.ZIndex = 61;
		O.Parent = Q;
		local q = Instance.new("TextLabel");
		q.Size = UDim2.new(1, -60, 0, 16);
		q.BackgroundTransparency = 1;
		q.Font = Enum.Font.GothamBold;
		q.TextSize = 11;
		q.TextXAlignment = Enum.TextXAlignment.Left;
		q.TextColor3 = S();
		q.Text = U;
		q.ZIndex = 62;
		q.Parent = O;
		local k = Instance.new("TextLabel");
		k.Size = UDim2.fromOffset(60, 16);
		k.Position = UDim2.new(1, -60, 0, 0);
		k.BackgroundTransparency = 1;
		k.Font = Enum.Font.Code;
		k.TextSize = 11;
		k.TextXAlignment = Enum.TextXAlignment.Right;
		k.TextColor3 = S();
		k.Text = "255";
		k.ZIndex = 62;
		k.Parent = O;
		local Z = Instance.new("TextButton");
		Z.Size = UDim2.new(1, 0, 0, 18);
		Z.Position = UDim2.fromOffset(0, 20);
		Z.BackgroundColor3 = u.card;
		Z.BorderSizePixel = 0;
		Z.Text = "";
		Z.AutoButtonColor = false;
		Z.ZIndex = 62;
		Z.Parent = O;
		K_(Z, 6);
		local D = Instance.new("Frame");
		D.Size = UDim2.new(1, 0, 1, 0);
		D.BorderSizePixel = 0;
		D.ZIndex = 63;
		D.Parent = Z;
		K_(D, 6);
		D.BackgroundColor3 = y;
		local V = Instance.new("Frame");
		V.Size = UDim2.fromOffset(14, 14);
		V.BackgroundColor3 = Color3.new(1, 1, 1);
		V.BorderSizePixel = 0;
		V.ZIndex = 64;
		V.Parent = Z;
		K_(V, 7);
		O_(V, Color3.new(0, 0, 0), 1, .4);
		local X = false;
		local function m()
			local u = x[A];
			local E = ((u - K)) / ((l - K));
			V.Position = UDim2.new(E, -7, .5, -7);
			if l <= 3 then
				k.Text = string.format("%.2f", u);
			else
				k.Text = tostring(math.floor(u + .5));
			end;
		end;
		m();
		local function I(u)
			local E = math.clamp(((u - Z.AbsolutePosition.X)) / math.max(Z.AbsoluteSize.X, 1), 0, 1);
			local W = K + E * ((l - K));
			if l <= 3 then
				x[A] = math.floor(W * 100 + .5) / 100;
			else
				x[A] = math.floor(W + .5);
			end;
			m();
			f();
		end;
		Z.InputBegan:Connect(function(u)
			if u.UserInputType == Enum.UserInputType.MouseButton1 or u.UserInputType == Enum.UserInputType.Touch then
				X = true;
				I(u.Position.X);
			end;
		end);
		b(W.InputEnded:Connect(function(u)
			if u.UserInputType == Enum.UserInputType.MouseButton1 or u.UserInputType == Enum.UserInputType.Touch then
				X = false;
			end;
		end));
		b(W.InputChanged:Connect(function(u)
			if X and ((u.UserInputType == Enum.UserInputType.MouseMovement or u.UserInputType == Enum.UserInputType.Touch)) then
				I(u.Position.X);
			end;
		end));
		return m;
	end;
	local V = Z(175, "Red", "R", Color3.fromRGB(255, 60, 60), 0, 255);
	local X = Z(228, "Green", "G", Color3.fromRGB(80, 255, 100), 0, 255);
	local m = Z(281, "Blue", "B", Color3.fromRGB(80, 140, 255), 0, 255);
	local I = Z(334, "Brightness x", "bright", Color3.fromRGB(255, 255, 255), 0, 2);
	local n = Instance.new("TextButton");
	n.Size = UDim2.fromOffset(140, 34);
	n.Position = UDim2.new(0, 14, 0, 400);
	n.BackgroundColor3 = r();
	n.BorderSizePixel = 0;
	n.Font = Enum.Font.GothamBlack;
	n.TextSize = 13;
	n.TextColor3 = Color3.fromRGB(255, 255, 255);
	n.Text = "APPLY";
	n.ZIndex = 61;
	n.Parent = Q;
	K_(n, 8);
	Q_(function()
		n.BackgroundColor3 = r();
	end);
	local v = Instance.new("TextButton");
	v.Size = UDim2.fromOffset(140, 34);
	v.Position = UDim2.new(1, -154, 0, 400);
	v.BackgroundColor3 = u.card;
	v.BorderSizePixel = 0;
	v.Font = Enum.Font.GothamBold;
	v.TextSize = 13;
	v.TextColor3 = S();
	v.Text = "Cancel";
	v.ZIndex = 61;
	v.Parent = Q;
	K_(v, 8);
	local i = O_(v, r(), 1, .5);
	Q_(function()
		i.Color = r();
	end);
	local function T()
		Q.Visible = false;
		x.callback = nil;
	end;
	y.MouseButton1Click:Connect(function()
		y_();
		T();
	end);
	v.MouseButton1Click:Connect(function()
		y_();
		T();
	end);
	n.MouseButton1Click:Connect(function()
		y_();
		if x.callback then
			local u = k(x.R);
			local E = k(x.G);
			local W = k(x.B);
			pcall(x.callback, Color3.fromRGB(u, E, W));
		end;
		T();
	end);
	D.colorPickerOpen = function(u, E)
			x.R = math.floor(u.R * 255 + .5);
			x.G = math.floor(u.G * 255 + .5);
			x.B = math.floor(u.B * 255 + .5);
			x.bright = 1;
			x.callback = E;
			V();
			X();
			m();
			I();
			f();
			Q.Visible = true;
		end;
	f();
end;
function D.ui.buildMain()
	local u = D.ui.tabFrames.Main;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	local Q = D.ui.makeInput;
	local A = D.ui.colorRow;
	E(u, 0, "Auto Dodge");
	W(u, 22, "Ultra Instinct", "Enabled", nil, nil, I);
	U(u, 52, "Radius (studs)", "Distance", 1, 95, 1, I, function()
		if I.RadiusVis or n.RadiusVis then
			mL();
		end;
	end);
	U(u, 96, "Delay (s)", "Delay", 0, .25, .01, I);
	U(u, 140, "Min interval (s)", "MinInterval", .02, 1, .01, I);
	U(u, 184, "Anim watch min (s)", "AnimWatch", .05, 2, .05, I);
	U(u, 228, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, I);
	E(u, 274, "Radius visualizer");
	W(u, 296, "Show radius", "RadiusVis", nil, nil, I);
	U(u, 326, "Visibility", "RadiusTransparency", .15, .95, .05, I, function()
		if I.RadiusVis or n.RadiusVis then
			mL();
		end;
	end);
	A(u, 370, "Radius color", J, function(u)
		I.RadiusR = math.floor(u.R * 255 + .5);
		I.RadiusG = math.floor(u.G * 255 + .5);
		I.RadiusB = math.floor(u.B * 255 + .5);
		if I.RadiusVis then
			mL();
		end;
	end);
	E(u, 410, "Slot (optional)");
	local y = Q(u, 430, "auto = leave empty");
	y.Text = I.ManualUISlot or "";
	(y:GetPropertyChangedSignal("Text")):Connect(function()
		if D.unloaded then
			return;
		end;
		I.ManualUISlot = string.upper(y.Text or "");
	end);
end;
function D.ui.buildHnS()
	local u = D.ui.tabFrames.HnS;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	local Q = D.ui.makeInput;
	local A = D.ui.colorRow;
	E(u, 0, "HnS Dodge");
	W(u, 22, "HnS Dodge", "Enabled", nil, nil, n);
	W(u, 52, "Strict mode", "HollyMode", nil, nil, n);
	U(u, 82, "Radius (studs)", "Distance", 1, 95, 1, n, function()
		if I.RadiusVis or n.RadiusVis then
			mL();
		end;
	end);
	U(u, 126, "Delay (s)", "Delay", 0, .25, .01, n);
	U(u, 170, "Min interval (s)", "MinInterval", .02, 1, .01, n);
	U(u, 214, "Anim watch min (s)", "AnimWatch", .05, 2, .05, n);
	U(u, 258, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, n);
	E(u, 304, "Radius visualizer");
	W(u, 326, "Show radius", "RadiusVis", nil, nil, n);
	U(u, 356, "Visibility", "RadiusTransparency", .15, .95, .05, n, function()
		if I.RadiusVis or n.RadiusVis then
			mL();
		end;
	end);
	A(u, 400, "HnS color", j, function(u)
		n.RadiusR = math.floor(u.R * 255 + .5);
		n.RadiusG = math.floor(u.G * 255 + .5);
		n.RadiusB = math.floor(u.B * 255 + .5);
		if n.RadiusVis then
			mL();
		end;
	end);
	E(u, 440, "Slot (optional)");
	local y = Q(u, 460, "auto = leave empty");
	y.Text = I.ManualHnSSlot or "";
	(y:GetPropertyChangedSignal("Text")):Connect(function()
		if D.unloaded then
			return;
		end;
		I.ManualHnSSlot = string.upper(y.Text or "");
	end);
end;
function D.ui.buildRebel()
	local u = D.ui.tabFrames.Rebel;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	local Q = D.ui.makeBtn;
	local A = D.ui.makeInput;
	local y = D.ui.colorRow;
	E(u, 0, "Silent Aim");
	W(u, 22, "Silent Aim", "RebelSilentAim", nil, function(u)
		I.RebelSilentAim = u;
		if u then
			WL();
		end;
	end, I);
	W(u, 52, "FOV Circle", "RebelFOVCircle", nil, function(u)
		I.RebelFOVCircle = u;
		xL();
	end, I);
	W(u, 82, "Neon glow", "RebelFOVNeon", nil, function(u)
		I.RebelFOVNeon = u;
		xL();
	end, I);
	W(u, 112, "Black outline", "RebelFOVBlackOutline", nil, function(u)
		I.RebelFOVBlackOutline = u;
		xL();
	end, I);
	U(u, 144, "Outline thickness", "RebelFOV_OutlineThickness", 1, 20, 1, I, kL);
	y(u, 188, "Outline color", h, function(u)
		I.RebelFOV_OutlineR = math.floor(u.R * 255 + .5);
		I.RebelFOV_OutlineG = math.floor(u.G * 255 + .5);
		I.RebelFOV_OutlineB = math.floor(u.B * 255 + .5);
		I.FOVRainbow = false;
		AL();
		xL();
	end);
	U(u, 230, "FOV radius (px)", "RebelFOV", 10, 1200, 5, I, kL);
	U(u, 274, "Circle line width", "RebelFOVCircleWidth", .5, 15, .1, I, kL);
	y(u, 318, "FOV color", d, function(u)
		I.RebelFOVR = math.floor(u.R * 255 + .5);
		I.RebelFOVG = math.floor(u.G * 255 + .5);
		I.RebelFOVB = math.floor(u.B * 255 + .5);
		I.FOVUseCustom = false;
		I.FOVRainbow = false;
		AL();
		xL();
	end);
	E(u, 358, "FOV Rainbow (6 modes)");
	local K = W(u, 380, "Rainbow FOV", "FOVRainbow", nil, function(u)
			if u then
				lL();
			else
				AL();
				xL();
			end;
		end, I);
	D.ui.fovRainbowPaint = K;
	U(u, 410, "Blend speed", "RebelFOVBlendSpeed", .1, 3, .05, I);
	local function l(u)
		I.FOVRainbowMode = u;
		I.FOVRainbow = true;
		if D.ui.fovRainbowPaint then
			pcall(D.ui.fovRainbowPaint);
		end;
		xL();
		lL();
	end;
	Q(u, 454, "Mode 1: Cycle hue", function()
		l(1);
	end);
	Q(u, 486, "Mode 2: Wave", function()
		l(2);
	end);
	Q(u, 518, "Mode 3: Gradient blend", function()
		l(3);
	end);
	Q(u, 550, "Mode 4: Breathing pulse", function()
		l(4);
	end);
	Q(u, 582, "Mode 5: Aurora", function()
		l(5);
	end);
	Q(u, 614, "Mode 6: FUSION", function()
		l(6);
	end);
	E(u, 656, "Custom FOV colors (1-9)");
	W(u, 678, "Use custom color", "FOVUseCustom", nil, function(u)
		xL();
		if I.FOVRainbow then
			lL();
		end;
	end, I);
	local function O(u)
		return function()
			local E, W, U = 60, 60, 255;
			if u == 1 then
				E, W, U = I.FOVCustomR1 or 255, I.FOVCustomG1 or 60, I.FOVCustomB1 or 60;
			elseif u == 2 then
				E, W, U = I.FOVCustomR2 or 60, I.FOVCustomG2 or 255, I.FOVCustomB2 or 60;
			elseif u == 3 then
				E, W, U = I.FOVCustomR3 or 60, I.FOVCustomG3 or 140, I.FOVCustomB3 or 255;
			elseif u == 4 then
				E, W, U = I.FOVCustomR4 or 255, I.FOVCustomG4 or 255, I.FOVCustomB4 or 60;
			elseif u == 5 then
				E, W, U = I.FOVCustomR5 or 255, I.FOVCustomG5 or 60, I.FOVCustomB5 or 255;
			elseif u == 6 then
				E, W, U = I.FOVCustomR6 or 60, I.FOVCustomG6 or 255, I.FOVCustomB6 or 255;
			elseif u == 7 then
				E, W, U = I.FOVCustomR7 or 255, I.FOVCustomG7 or 180, I.FOVCustomB7 or 60;
			elseif u == 8 then
				E, W, U = I.FOVCustomR8 or 255, I.FOVCustomG8 or 255, I.FOVCustomB8 or 255;
			elseif u == 9 then
				E, W, U = I.FOVCustomR9 or 180, I.FOVCustomG9 or 60, I.FOVCustomB9 or 255;
			end;
			return Color3.fromRGB(E, W, U);
		end;
	end;
	local function q(u)
		return function(E)
			local W, U, Q = math.floor(E.R * 255 + .5), math.floor(E.G * 255 + .5), math.floor(E.B * 255 + .5);
			if u == 1 then
				I.FOVCustomR1, I.FOVCustomG1, I.FOVCustomB1 = W, U, Q;
			elseif u == 2 then
				I.FOVCustomR2, I.FOVCustomG2, I.FOVCustomB2 = W, U, Q;
			elseif u == 3 then
				I.FOVCustomR3, I.FOVCustomG3, I.FOVCustomB3 = W, U, Q;
			elseif u == 4 then
				I.FOVCustomR4, I.FOVCustomG4, I.FOVCustomB4 = W, U, Q;
			elseif u == 5 then
				I.FOVCustomR5, I.FOVCustomG5, I.FOVCustomB5 = W, U, Q;
			elseif u == 6 then
				I.FOVCustomR6, I.FOVCustomG6, I.FOVCustomB6 = W, U, Q;
			elseif u == 7 then
				I.FOVCustomR7, I.FOVCustomG7, I.FOVCustomB7 = W, U, Q;
			elseif u == 8 then
				I.FOVCustomR8, I.FOVCustomG8, I.FOVCustomB8 = W, U, Q;
			elseif u == 9 then
				I.FOVCustomR9, I.FOVCustomG9, I.FOVCustomB9 = W, U, Q;
			end;
			if I.FOVUseCustom then
				xL();
				if I.FOVRainbow then
					lL();
				end;
			end;
		end;
	end;
	for E = 1, 9, 1 do
		local W = 710 + ((E - 1)) * 62;
		y(u, W, "Slot " .. E, O(E), q(E));
		Q(u, W + 32, "Use slot " .. E, function()
			I.FOVCustomIdx = E;
			I.FOVUseCustom = true;
			xL();
			if I.FOVRainbow then
				lL();
			end;
		end);
	end;
	E(u, 1278, "Target filter");
	W(u, 1300, "Target players", "RebelTargetPlayers", nil, nil, I);
	W(u, 1330, "Target game guards (NPC)", "RebelTargetNPCs", nil, nil, I);
	E(u, 1366, "Body parts (random)");
	W(u, 1388, "Head", "RebelBodyHead", nil, nil, I);
	W(u, 1418, "Torso", "RebelBodyTorso", nil, nil, I);
	W(u, 1448, "HumanoidRootPart", "RebelBodyHRP", nil, nil, I);
	W(u, 1478, "Left Arm", "RebelBodyLeftArm", nil, nil, I);
	W(u, 1508, "Right Arm", "RebelBodyRightArm", nil, nil, I);
	W(u, 1538, "Left Leg", "RebelBodyLeftLeg", nil, nil, I);
	W(u, 1568, "Right Leg", "RebelBodyRightLeg", nil, nil, I);
	E(u, 1604, "Gun mods");
	W(u, 1626, "No Recoil & Spread", "RebelNoRecoil", nil, function(u)
		I.RebelNoRecoil = u;
		if u then
			WL();
		end;
	end, I);
	W(u, 1656, "Rapid Fire", "RebelRapidFire", nil, function(u)
		I.RebelRapidFire = u;
		if u then
			WL();
		end;
	end, I);
	E(u, 1692, "Bullet tracer");
	W(u, 1714, "Enable Bullet Tracer", "BulletTracer", nil, nil, I);
	W(u, 1744, "Glow", "BulletTracerGlow", nil, nil, I);
	W(u, 1774, "White core", "BulletTracerWhiteCore", nil, nil, I);
	y(u, 1804, "Tracer color", function()
		return Color3.fromRGB(I.BulletTracerR, I.BulletTracerG, I.BulletTracerB);
	end, function(u)
		I.BulletTracerR = math.floor(u.R * 255 + .5);
		I.BulletTracerG = math.floor(u.G * 255 + .5);
		I.BulletTracerB = math.floor(u.B * 255 + .5);
	end);
	U(u, 1846, "Thickness", "BulletTracerThickness", .05, 1, .01, I);
	U(u, 1890, "Speed (studs/s)", "BulletTracerSpeed", 50, 5000, 50, I);
	U(u, 1934, "Lifetime (s)", "BulletTracerLifetime", .1, 5, .05, I);
	U(u, 1978, "Range (studs)", "BulletTracerRange", 50, 2000, 25, I);
	U(u, 2022, "Start offset", "BulletTracerStartOffset", 0, 5, .1, I);
	U(u, 2066, "End offset", "BulletTracerEndOffset", 0, 5, .1, I);
	U(u, 2110, "Opacity", "BulletTracerOpacity", 0, .5, .01, I);
	U(u, 2154, "Cooldown (s)", "BulletTracerCooldown", .01, .5, .01, I);
	local x = {
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
	Q(u, 2198, "Fade: " .. x[I.BulletTracerFadeIdx or 1], function()
		I.BulletTracerFadeIdx = ((I.BulletTracerFadeIdx or 1)) + 1;
		if I.BulletTracerFadeIdx > #x then
			I.BulletTracerFadeIdx = 1;
		end;
	end);
	E(u, 2240, "Auto Brew (Soda Fountain)");
	W(u, 2262, "Auto brew + collect", "AutoBrew", nil, function(u)
		if u then
			rL();
		else
			SL();
		end;
	end, I);
	local k = A(u, 2292, "brew key (E)");
	k.Text = I.AutoBrewSlot or "E";
	(k:GetPropertyChangedSignal("Text")):Connect(function()
		if D.unloaded then
			return;
		end;
		local u = string.upper(k.Text or "E");
		if u == "" then
			u = "E";
		end;
		I.AutoBrewSlot = u;
	end);
	U(u, 2324, "Brew cooldown (s)", "AutoBrewInterval", 5, 300, 5, I);
	U(u, 2368, "Delay collect after brew (s)", "AutoBrewDelayCollect", 0, 10, .1, I);
	U(u, 2412, "Collect hold (s)", "AutoBrewCollectHold", .5, 5, .1, I);
end;
function D.ui.buildRLGL()
	local u = D.ui.tabFrames.RLGL;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	E(u, 0, "RLGL Auto Dodge");
	W(u, 22, "RLGL Auto Dodge", "RLGL_AutoDodge");
	W(u, 52, "Only on red light", "RLGL_OnlyRedLight");
	W(u, 82, "Auto-dodge after timer 0", "RLGL_TimerEndDodge");
	E(u, 118, "Red light tuning");
	U(u, 140, "Delay after red (s)", "RLGL_RedDelay", .05, 2, .05, I);
	U(u, 184, "Interval (s)", "RLGL_MinInterval", .05, 2, .05, I);
	U(u, 228, "Velocity threshold", "RLGL_VelThreshold", .1, 8, .1, I);
	E(u, 274, "Timer-end tuning");
	U(u, 296, "Delay after 0 (s)", "RLGL_TimerEndDelay", 0, 3, .05, I);
	U(u, 340, "Interval between (s)", "RLGL_TimerEndInterval", .05, 2, .05, I);
	U(u, 384, "Max duration (s)", "RLGL_TimerEndMaxDuration", 3, 30, 1, I);
end;
function D.ui.buildESP()
	local u = D.ui.tabFrames.ESP;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	local Q = D.ui.makeBtn;
	local A = D.ui.makeInput;
	local y = D.ui.colorRow;
	E(u, 0, "Playable Guard ESP");
	W(u, 22, "Playable Guard ESP", "GuardESP");
	W(u, 52, "Show HP bar", "GuardESP_HP");
	W(u, 82, "Show Name", "GuardESP_Name");
	W(u, 112, "Show Highlight (chams)", "GuardESP_Highlight");
	W(u, 142, "Show Tracer", "GuardESP_Tracer");
	W(u, 172, "Show Box (2D)", "GuardESP_Box");
	W(u, 202, "HP chip colored BG", "GuardESP_HP_ChipBg", nil, nil, I);
	W(u, 232, "Show Tool (under feet)", "GuardESP_Tool");
	W(u, 262, "Show Distance (right)", "GuardESP_Distance");
	W(u, 292, "Force ALL as Guard (debug)", "GuardESP_ForceAll");
	U(u, 322, "Name size", "GuardESP_NameSize", 8, 32, 1, I);
	U(u, 366, "Max distance (studs)", "GuardESP_MaxDist", 0, 1000, 10, I, RL);
	U(u, 410, "Box thickness", "GuardESP_BoxThickness", 1, 6, .5, I);
	E(u, 454, "Guard accent color");
	y(u, 476, "Guard accent", L, function(u)
		I.GuardESP_ColorR = math.floor(u.R * 255 + .5);
		I.GuardESP_ColorG = math.floor(u.G * 255 + .5);
		I.GuardESP_ColorB = math.floor(u.B * 255 + .5);
		if I.GuardESP then
			RL();
		end;
	end);
	y(u, 508, "Guard tracer", P, function(u)
		I.GuardESP_TracerR = math.floor(u.R * 255 + .5);
		I.GuardESP_TracerG = math.floor(u.G * 255 + .5);
		I.GuardESP_TracerB = math.floor(u.B * 255 + .5);
	end);
	y(u, 540, "Guard box", a, function(u)
		I.GuardESP_BoxR = math.floor(u.R * 255 + .5);
		I.GuardESP_BoxG = math.floor(u.G * 255 + .5);
		I.GuardESP_BoxB = math.floor(u.B * 255 + .5);
	end);
	E(u, 582, "Guard HP chip (4 states)");
	W(u, 604, "Black outline (chip + number)", "GuardESP_HP_Outline", nil, nil, I);
	y(u, 636, "State 1 (>75%)", R, function(u)
		I.GuardESP_HP_State1_R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_State1_G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_State1_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 668, "State 2 (50-75%)", t, function(u)
		I.GuardESP_HP_State2_R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_State2_G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_State2_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 700, "State 3 (25-50%)", s, function(u)
		I.GuardESP_HP_State3_R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_State3_G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_State3_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 732, "State 4 (<25%)", B, function(u)
		I.GuardESP_HP_State4_R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_State4_G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_State4_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	E(u, 776, "Guard HP gradient (vertical bar)");
	local function K()
		return Color3.fromRGB(I.GuardESP_HP_TopR or 80, I.GuardESP_HP_TopG or 255, I.GuardESP_HP_TopB or 80);
	end;
	local function l()
		return Color3.fromRGB(I.GuardESP_HP_M1R or 180, I.GuardESP_HP_M1G or 255, I.GuardESP_HP_M1B or 60);
	end;
	local function O()
		return Color3.fromRGB(I.GuardESP_HP_M2R or 255, I.GuardESP_HP_M2G or 200, I.GuardESP_HP_M2B or 40);
	end;
	local function q()
		return Color3.fromRGB(I.GuardESP_HP_M3R or 255, I.GuardESP_HP_M3G or 120, I.GuardESP_HP_M3B or 60);
	end;
	local function x()
		return Color3.fromRGB(I.GuardESP_HP_BotR or 255, I.GuardESP_HP_BotG or 40, I.GuardESP_HP_BotB or 40);
	end;
	y(u, 798, "Top", K, function(u)
		I.GuardESP_HP_TopR = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_TopG = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_TopB = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 830, "Mid1", l, function(u)
		I.GuardESP_HP_M1R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_M1G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_M1B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 862, "Mid2", O, function(u)
		I.GuardESP_HP_M2R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_M2G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_M2B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 894, "Mid3", q, function(u)
		I.GuardESP_HP_M3R = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_M3G = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_M3B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 926, "Bottom", x, function(u)
		I.GuardESP_HP_BotR = math.floor(u.R * 255 + .5);
		I.GuardESP_HP_BotG = math.floor(u.G * 255 + .5);
		I.GuardESP_HP_BotB = math.floor(u.B * 255 + .5);
		RL();
	end);
	E(u, 970, "Player ESP");
	W(u, 992, "Player ESP", "PlayerESP");
	W(u, 1022, "Show HP bar", "PlayerESP_HP");
	W(u, 1052, "Show Name", "PlayerESP_Name");
	W(u, 1082, "Show Highlight (chams)", "PlayerESP_Highlight");
	W(u, 1112, "Show Tracer", "PlayerESP_Tracer");
	W(u, 1142, "Show Box (2D)", "PlayerESP_Box");
	W(u, 1172, "HP chip colored BG", "PlayerESP_HP_ChipBg", nil, nil, I);
	W(u, 1202, "Show Tool (under feet)", "PlayerESP_Tool");
	W(u, 1232, "Show Distance (right)", "PlayerESP_Distance");
	E(u, 1262, "Custom name");
	local k = A(u, 1284, "custom name (empty = real)");
	k.Text = I.PlayerESP_CustomName or "";
	(k:GetPropertyChangedSignal("Text")):Connect(function()
		if D.unloaded then
			return;
		end;
		I.PlayerESP_CustomName = k.Text or "";
		RL();
	end);
	W(u, 1318, "Rainbow name", "PlayerESP_NameRainbow", nil, nil, I);
	U(u, 1348, "Rainbow speed", "PlayerESP_NameRainbowSpeed", .1, 3, .05, I);
	U(u, 1392, "Name size", "PlayerESP_NameSize", 8, 32, 1, I);
	U(u, 1436, "Max distance (studs)", "PlayerESP_MaxDist", 0, 1000, 10, I, RL);
	U(u, 1480, "Box thickness", "PlayerESP_BoxThickness", 1, 6, .5, I);
	E(u, 1524, "Player accent color");
	y(u, 1546, "Player accent", w, function(u)
		I.PlayerESP_ColorR = math.floor(u.R * 255 + .5);
		I.PlayerESP_ColorG = math.floor(u.G * 255 + .5);
		I.PlayerESP_ColorB = math.floor(u.B * 255 + .5);
		if I.PlayerESP then
			RL();
		end;
	end);
	y(u, 1578, "Player tracer", e, function(u)
		I.PlayerESP_TracerR = math.floor(u.R * 255 + .5);
		I.PlayerESP_TracerG = math.floor(u.G * 255 + .5);
		I.PlayerESP_TracerB = math.floor(u.B * 255 + .5);
	end);
	y(u, 1610, "Player box", p, function(u)
		I.PlayerESP_BoxR = math.floor(u.R * 255 + .5);
		I.PlayerESP_BoxG = math.floor(u.G * 255 + .5);
		I.PlayerESP_BoxB = math.floor(u.B * 255 + .5);
	end);
	E(u, 1652, "Player HP chip (4 states)");
	W(u, 1674, "Black outline (chip + number)", "PlayerESP_HP_Outline", nil, nil, I);
	y(u, 1706, "State 1 (>75%)", H, function(u)
		I.PlayerESP_HP_State1_R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_State1_G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_State1_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1738, "State 2 (50-75%)", Y, function(u)
		I.PlayerESP_HP_State2_R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_State2_G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_State2_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1770, "State 3 (25-50%)", G, function(u)
		I.PlayerESP_HP_State3_R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_State3_G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_State3_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1802, "State 4 (<25%)", u_, function(u)
		I.PlayerESP_HP_State4_R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_State4_G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_State4_B = math.floor(u.B * 255 + .5);
		RL();
	end);
	E(u, 1846, "Player HP gradient (vertical bar)");
	local function f()
		return Color3.fromRGB(I.PlayerESP_HP_TopR or 80, I.PlayerESP_HP_TopG or 255, I.PlayerESP_HP_TopB or 80);
	end;
	local function Z()
		return Color3.fromRGB(I.PlayerESP_HP_M1R or 180, I.PlayerESP_HP_M1G or 255, I.PlayerESP_HP_M1B or 60);
	end;
	local function V()
		return Color3.fromRGB(I.PlayerESP_HP_M2R or 255, I.PlayerESP_HP_M2G or 200, I.PlayerESP_HP_M2B or 40);
	end;
	local function X()
		return Color3.fromRGB(I.PlayerESP_HP_M3R or 255, I.PlayerESP_HP_M3G or 120, I.PlayerESP_HP_M3B or 60);
	end;
	local function m()
		return Color3.fromRGB(I.PlayerESP_HP_BotR or 255, I.PlayerESP_HP_BotG or 40, I.PlayerESP_HP_BotB or 40);
	end;
	y(u, 1868, "Top", f, function(u)
		I.PlayerESP_HP_TopR = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_TopG = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_TopB = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1900, "Mid1", Z, function(u)
		I.PlayerESP_HP_M1R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_M1G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_M1B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1932, "Mid2", V, function(u)
		I.PlayerESP_HP_M2R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_M2G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_M2B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1964, "Mid3", X, function(u)
		I.PlayerESP_HP_M3R = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_M3G = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_M3B = math.floor(u.B * 255 + .5);
		RL();
	end);
	y(u, 1996, "Bottom", m, function(u)
		I.PlayerESP_HP_BotR = math.floor(u.R * 255 + .5);
		I.PlayerESP_HP_BotG = math.floor(u.G * 255 + .5);
		I.PlayerESP_HP_BotB = math.floor(u.B * 255 + .5);
		RL();
	end);
	E(u, 2040, "HP bar size");
	U(u, 2062, "Guard bar thickness", "GuardESP_HPBarThickness", 2, 30, 1, I);
	U(u, 2106, "Guard bar length", "GuardESP_HPBarLength", .3, 3, .1, I);
	U(u, 2150, "Guard bar roundness", "GuardESP_HPBarRoundness", 0, 20, 1, I);
	U(u, 2194, "Player bar thickness", "PlayerESP_HPBarThickness", 2, 30, 1, I);
	U(u, 2238, "Player bar length", "PlayerESP_HPBarLength", .3, 3, .1, I);
	U(u, 2282, "Player bar roundness", "PlayerESP_HPBarRoundness", 0, 20, 1, I);
	E(u, 2326, "ESP text");
	local n;
	local function T()
		if n then
			n.Text = "Next font: " .. ((v[I.ESP_FontIdx or 1] or "?"));
		end;
	end;
	n = Q(u, 2348, "Next font: " .. ((v[I.ESP_FontIdx or 1] or "?")), function()
			I.ESP_FontIdx = ((I.ESP_FontIdx or 1)) + 1;
			if I.ESP_FontIdx > #v then
				I.ESP_FontIdx = 1;
			end;
			T();
			for u, E in pairs(LL) do
				pcall(function()
					if E.nameL then
						E.nameL.Font = i();
					end;
					if E.toolL then
						E.toolL.Font = i();
					end;
				end);
			end;
			for u, E in pairs(wL) do
				pcall(function()
					if E.nameL then
						E.nameL.Font = i();
					end;
					if E.toolL then
						E.toolL.Font = i();
					end;
				end);
			end;
		end);
	Q(u, 2380, "Reset font (GothamBlack)", function()
		I.ESP_FontIdx = 1;
		T();
		for u, E in pairs(LL) do
			pcall(function()
				if E.nameL then
					E.nameL.Font = Enum.Font.GothamBlack;
					E.nameL.TextSize = (I.GuardESP_NameSize or 17);
				end;
				if E.toolL then
					E.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		for u, E in pairs(wL) do
			pcall(function()
				if E.nameL then
					E.nameL.Font = Enum.Font.GothamBlack;
					E.nameL.TextSize = (I.PlayerESP_NameSize or 17);
				end;
				if E.toolL then
					E.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("font reset - GothamBlack");
		end;
	end);
end;
function D.ui.buildDalgona()
	local u = D.ui.tabFrames.Dalgona;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.BTN_W;
	local Q = D.ui.COL;
	E(u, 0, "Cookie");
	W(u, 22, "One Click Complete", nil, function()
		return D.oneClickDalgona;
	end, function(u)
		tL(u);
	end);
	local A = Instance.new("TextLabel");
	A.Size = UDim2.fromOffset(U, 70);
	A.Position = UDim2.fromOffset(4, 56);
	A.BackgroundTransparency = 1;
	A.Font = Enum.Font.Gotham;
	A.TextSize = 9;
	A.TextWrapped = true;
	A.TextXAlignment = Enum.TextXAlignment.Left;
	A.TextYAlignment = Enum.TextYAlignment.Top;
	A.TextColor3 = S();
	A.Text = "Vklyuchi i vedi myshkoi po konturu pechenki.";
	A.ZIndex = 6;
	A.Parent = u;
	Q_(function()
		A.TextColor3 = S();
	end);
end;
function D.ui.buildExtra()
	local u = D.ui.tabFrames.Extra;
	local E = D.ui.mkDivider;
	local W = D.ui.makeToggle;
	local U = D.ui.makeSlider;
	local Q = D.ui.makeBtn;
	E(u, 0, "Instant Interact");
	W(u, 22, "Enable Instant Interact", "InstantInteract");
	W(u, 52, "Insta mode (0ms)", "InstantInteractInsta");
	U(u, 82, "Custom speed x", "InstantInteractMult", .5, 50, .5, I);
	E(u, 128, "Hide overhead");
	W(u, 150, "Hide nickname", "HideNick", nil, function()
		yS();
	end, I);
	E(u, 186, "Visual");
	W(u, 208, "Full Bright", "FullBright", nil, function(u)
		vL(u);
	end, I);
	W(u, 238, "Remove Fog", "RemoveFog", nil, function(u)
		iL(u);
	end, I);
	E(u, 274, "Overlay");
	W(u, 296, "Watermark", "Watermark", nil, function()
		m_();
	end, I);
	W(u, 326, "Keybind list", "KeybindList", nil, function()
		m_();
	end, I);
	E(u, 362, "Cosmetics");
	W(u, 384, "Headless", "Headless");
	W(u, 414, "Korblox Left Leg", "Korblox");
	W(u, 444, "Remove Legs", "RemoveLegs");
	W(u, 474, "Remove Hands", "RemoveHands");
	W(u, 504, "Remove Torso (client)", "RemoveTorso");
	E(u, 544, "Animation Speed");
	W(u, 566, "Speed 2.5x", "AnimSpeed");
	Q(u, 598, "Reset anim speed", function()
		local u = k.Character;
		local E = u and u:FindFirstChildOfClass("Humanoid");
		local W = E and E:FindFirstChildOfClass("Animator");
		if W then
			for u, E in ipairs(W:GetPlayingAnimationTracks()) do
				pcall(function()
					E:AdjustSpeed(1);
				end);
			end;
		end;
	end);
	E(u, 636, "Extra");
	Q(u, 658, "Open Infinite Yield", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local u, E = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(u and "Infinite Yield loaded" or ("IY fail: " .. tostring(E)));
		end;
	end);
	Q(u, 690, "Jerk off", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local u, E = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jerk-off-script-OG-245780")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(u and "Jerk off loaded" or ("fail: " .. tostring(E)));
		end;
	end);
end;
function D.ui.buildConfigs()
	local u = D.ui.tabFrames.Configs;
	local E = D.ui.mkDivider;
	local U = D.ui.makeToggle;
	local Q = D.ui.makeSlider;
	local y = D.ui.makeBtn;
	local K = D.ui.makeInput;
	local l = D.ui.colorRow;
	local O = D.ui.COL;
	E(u, 0, "Config");
	local q;
	local x = K(u, 22, "config name");
	x.Text = D.currentConfigName;
	y(u, 54, "Save", function()
		local u = x.Text;
		if u == "" then
			u = "default";
		end;
		local E, W = fS(u);
		if E then
			x.Text = D.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved - " .. D.currentConfigName);
			end;
			task.defer(function()
				if q then
					q();
				end;
			end);
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("save fail - " .. tostring(W));
			end;
		end;
	end);
	y(u, 86, "Load", function()
		local u = x.Text;
		if u == "" then
			u = "default";
		end;
		local E, W = ZS(u);
		if E then
			x.Text = D.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("loaded - " .. D.currentConfigName);
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("load fail - " .. tostring(W));
			end;
		end;
	end);
	E(u, 124, "Menu animation");
	Q(u, 146, "Open/close speed", "MenuAnimSpeed", .1, 1.5, .05, I);
	Q(u, 190, "Collapse anim speed", "MenuDodgeAnimSpeed", .1, 2, .05, I);
	E(u, 236, "Circle menu button");
	Q(u, 258, "Circle size", "CircleSize", 32, 120, 2, I);
	l(u, 300, "Circle text color", N, function(u)
		I.CircleTextR = math.floor(u.R * 255 + .5);
		I.CircleTextG = math.floor(u.G * 255 + .5);
		I.CircleTextB = math.floor(u.B * 255 + .5);
		A_();
	end);
	U(u, 334, "Rainbow text color", "CircleRainbowText", nil, function()
		A_();
	end, I);
	U(u, 364, "Rainbow outline", "CircleRainbowOutline", nil, function()
		A_();
	end, I);
	E(u, 400, "Text color (all GUI)");
	l(u, 422, "Text color", S, function(u)
		I.GuiTextR = math.floor(u.R * 255 + .5);
		I.GuiTextG = math.floor(u.G * 255 + .5);
		I.GuiTextB = math.floor(u.B * 255 + .5);
		A_();
	end);
	E(u, 462, "Panel border");
	U(u, 484, "Rainbow panel border", "PanelRainbow", nil, function(u)
		if u then
			qL();
		else
			OL();
			if D.panel then
				local u = D.panel:FindFirstChildOfClass("UIStroke");
				if u then
					u.Color = r();
				end;
			end;
		end;
	end, I);
	E(u, 520, "Accent color");
	l(u, 542, "GUI accent", r, function(u)
		I.GuiR = math.floor(u.R * 255 + .5);
		I.GuiG = math.floor(u.G * 255 + .5);
		I.GuiB = math.floor(u.B * 255 + .5);
		A_();
	end);
	Q(u, 584, "R", "GuiR", 0, 255, 1, I, A_);
	Q(u, 628, "G", "GuiG", 0, 255, 1, I, A_);
	Q(u, 672, "B", "GuiB", 0, 255, 1, I, A_);
	E(u, 716, "Saved");
	local k = Instance.new("ScrollingFrame");
	k.Size = UDim2.new(1, -8, 0, 90);
	k.Position = UDim2.fromOffset(4, 736);
	k.BackgroundColor3 = O.card;
	k.BorderSizePixel = 0;
	k.ScrollBarThickness = 3;
	k.CanvasSize = UDim2.fromOffset(0, 0);
	k.ZIndex = 6;
	k.Parent = u;
	K_(k, 7);
	local f = Instance.new("TextLabel");
	f.Size = UDim2.new(1, -8, 0, 20);
	f.Position = UDim2.fromOffset(4, 6);
	f.BackgroundTransparency = 1;
	f.Font = Enum.Font.Gotham;
	f.TextSize = 11;
	f.TextColor3 = S();
	f.TextXAlignment = Enum.TextXAlignment.Left;
	f.Text = "no configs saved yet";
	f.ZIndex = 7;
	f.Parent = k;
	Q_(function()
		f.TextColor3 = S();
	end);
	q = function()
			if D.unloaded or not k or not k.Parent then
				return;
			end;
			for u, E in ipairs(k:GetChildren()) do
				if E:IsA("TextButton") then
					E:Destroy();
				end;
			end;
			local u = DS();
			k.CanvasSize = UDim2.fromOffset(0, math.max(#u * 26 + 8, 26));
			f.Visible = (#u == 0);
			for u, E in ipairs(u) do
				local W = Instance.new("TextButton");
				W.Size = UDim2.new(1, -8, 0, 22);
				W.Position = UDim2.fromOffset(4, ((u - 1)) * 26 + 4);
				W.BackgroundColor3 = O.off;
				W.BorderSizePixel = 0;
				W.Font = Enum.Font.Gotham;
				W.TextSize = 12;
				W.TextColor3 = S();
				W.Text = "  " .. E;
				W.TextXAlignment = Enum.TextXAlignment.Left;
				W.ZIndex = 7;
				W.Parent = k;
				K_(W, 5);
				Q_(function()
					W.TextColor3 = S();
				end);
				W.MouseButton1Click:Connect(function()
					y_();
					x.Text = E;
					local u = ZS(E);
					if _G.__ad_statusCb then
						_G.__ad_statusCb(u and ("loaded - " .. E) or "load failed");
					end;
				end);
				local U = Instance.new("TextButton");
				U.Size = UDim2.fromOffset(20, 18);
				U.Position = UDim2.new(1, -24, .5, -9);
				U.BackgroundColor3 = Color3.fromRGB(120, 30, 30);
				U.BorderSizePixel = 0;
				U.Font = Enum.Font.GothamBold;
				U.TextSize = 11;
				U.TextColor3 = Color3.new(1, 1, 1);
				U.Text = "x";
				U.ZIndex = 8;
				U.Parent = W;
				K_(U, 4);
				U.MouseButton1Click:Connect(function()
					if D.unloaded then
						return;
					end;
					y_();
					local u, W = VS(E);
					if u then
						if _G.__ad_statusCb then
							_G.__ad_statusCb("deleted - " .. E);
						end;
						task.defer(function()
							if q then
								q();
							end;
						end);
					else
						if _G.__ad_statusCb then
							_G.__ad_statusCb("del fail - " .. tostring(W));
						end;
					end;
				end);
			end;
		end;
	q();
	_G.__adRefreshConfigs = q;
	y(u, 834, "Refresh List", function()
		q();
	end);
	y(u, 868, "Set Menu Key", function()
		D.bindingMenuKey = true;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("press a key...");
		end;
		local u;
		u = W.InputBegan:Connect(function(E)
				if E.UserInputType ~= Enum.UserInputType.Keyboard then
					return;
				end;
				I.MenuKey = E.KeyCode;
				if _G.__ad_statusCb then
					_G.__ad_statusCb("menu key = " .. E.KeyCode.Name);
				end;
				task.defer(function()
					D.bindingMenuKey = false;
				end);
				if u then
					u:Disconnect();
				end;
				if D.rebindMenu then
					D.rebindMenu();
				end;
			end);
	end);
	y(u, 902, "FULL UNLOAD", function()
		if D.doFullUnload then
			pcall(D.doFullUnload);
		end;
	end);
	E(u, 940, "Share config (JSON / TXT)");
	local Z = K(u, 962, "paste JSON here to import");
	Z.Text = "";
	y(u, 994, "Export (copy JSON to clipboard)", function()
		local u = { C = qS(I), H = qS(n), anim = D.animEnabled };
		local E = A:JSONEncode(u);
		local W = false;
		if setclipboard then
			pcall(function()
				setclipboard(E);
				W = true;
			end);
		end;
		if W then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("copied (" .. (#E .. " chars) - send to friend"));
			end;
		else
			Z.Text = E;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no setclipboard - JSON in box, copy manually");
			end;
		end;
	end);
	y(u, 1026, "Export to file (XD_config.txt)", function()
		if not D.FILE.writefile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no writefile in executor");
			end;
			return;
		end;
		local u = { C = qS(I), H = qS(n), anim = D.animEnabled };
		local E = A:JSONEncode(u);
		local W = pcall(function()
				D.FILE.writefile("XD_config.txt", E);
			end);
		if W then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved XD_config.txt (" .. (#E .. ")"));
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("writefile failed");
			end;
		end;
	end);
	y(u, 1058, "Load from file (XD_config.txt)", function()
		if not D.FILE.readfile or not D.FILE.isfile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no readfile");
			end;
			return;
		end;
		local u, E = pcall(D.FILE.isfile, "XD_config.txt");
		if not u or not E then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("XD_config.txt not found");
			end;
			return;
		end;
		local W, U = pcall(D.FILE.readfile, "XD_config.txt");
		if not W or not U then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("read failed");
			end;
			return;
		end;
		local Q, y = pcall(function()
				return A:JSONDecode(U);
			end);
		if not Q or type(y) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in file");
			end;
			return;
		end;
		kS(y);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("loaded from XD_config.txt");
		end;
	end);
	y(u, 1090, "Import from clipboard", function()
		local u = "";
		if getclipboard then
			pcall(function()
				u = getclipboard();
			end);
		end;
		if not u or u == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("clipboard empty or no getclipboard");
			end;
			return;
		end;
		local E, W = pcall(function()
				return A:JSONDecode(u);
			end);
		if not E or type(W) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in clipboard");
			end;
			return;
		end;
		kS(W);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from clipboard");
		end;
	end);
	y(u, 1122, "Import from box above", function()
		local u = Z.Text or "";
		if u == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("box empty");
			end;
			return;
		end;
		local E, W = pcall(function()
				return A:JSONDecode(u);
			end);
		if not E or type(W) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json");
			end;
			return;
		end;
		kS(W);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from box");
		end;
	end);
	E(u, 1158, "Circle rainbow glow");
	Q(u, 1180, "Glow speed", "CircleRainbowSpeed", .1, 5, .1, I);
end;
function D.ui.buildCollapseCircle()
	local u = D.ui.PANEL_W;
	local E = D.ui.PANEL_H;
	local U = Instance.new("TextButton");
	U.AnchorPoint = Vector2.new(1, 0);
	U.Position = UDim2.new(1, -16, 0, 90);
	U.Size = UDim2.fromOffset(0, 0);
	U.BackgroundColor3 = r();
	U.BorderSizePixel = 0;
	U.Text = "";
	U.AutoButtonColor = false;
	U.Visible = false;
	U.ZIndex = 50;
	U.Parent = D.gui;
	K_(U, 32);
	local A = O_(U, Color3.fromRGB(0, 0, 0), 3, 0);
	Q_(function()
		U.BackgroundColor3 = r();
	end);
	D.ui.expandCircle = U;
	local K = false;
	local l = false;
	local O = nil;
	local q = nil;
	U.InputBegan:Connect(function(u)
		if u.UserInputType == Enum.UserInputType.MouseButton1 or u.UserInputType == Enum.UserInputType.Touch then
			K = true;
			l = false;
			O = u.Position;
			q = U.Position;
			u.Changed:Connect(function()
				if u.UserInputState == Enum.UserInputState.End then
					K = false;
				end;
			end);
		end;
	end);
	b(W.InputChanged:Connect(function(u)
		if not K then
			return;
		end;
		if u.UserInputType == Enum.UserInputType.MouseMovement or u.UserInputType == Enum.UserInputType.Touch then
			local E = u.Position - O;
			if math.abs(E.X) > 3 or math.abs(E.Y) > 3 then
				l = true;
			end;
			U.Position = UDim2.new(q.X.Scale, q.X.Offset + E.X, q.Y.Scale, q.Y.Offset + E.Y);
		end;
	end));
	local x = Instance.new("TextLabel");
	x.AnchorPoint = Vector2.new(.5, .5);
	x.Size = UDim2.fromScale(.55, .55);
	x.Position = UDim2.fromScale(.34, .52);
	x.BackgroundTransparency = 1;
	x.Font = Enum.Font.GothamBlack;
	x.TextSize = 26;
	x.TextColor3 = N();
	x.TextStrokeTransparency = 0;
	x.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	x.Text = "X";
	x.Rotation = -8;
	x.ZIndex = 52;
	x.Parent = U;
	local k = Instance.new("TextLabel");
	k.AnchorPoint = Vector2.new(.5, .5);
	k.Size = UDim2.fromScale(.5, .55);
	k.Position = UDim2.fromScale(.68, .52);
	k.BackgroundTransparency = 1;
	k.Font = Enum.Font.GothamBlack;
	k.TextSize = 24;
	k.TextColor3 = N();
	k.TextStrokeTransparency = 0;
	k.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	k.Text = "D";
	k.Rotation = 6;
	k.ZIndex = 52;
	k.Parent = U;
	Q_(function()
		A.Color = Color3.fromRGB(0, 0, 0);
		if not I.CircleRainbowOutline then
			x.TextStrokeColor3 = N();
			k.TextStrokeColor3 = N();
		end;
		if not I.CircleRainbowText then
			x.TextColor3 = N();
			k.TextColor3 = N();
		end;
	end);
	task.spawn(function()
		local u = 0;
		while D.running and not D.unloaded do
			if I.CircleRainbowOutline then
				local E = Color3.fromHSV(u, 1, 1);
				pcall(function()
					x.TextStrokeColor3 = E;
					k.TextStrokeColor3 = E;
				end);
			end;
			if I.CircleRainbowText then
				local E = Color3.fromHSV(((u + .5)) % 1, 1, 1);
				pcall(function()
					x.TextColor3 = E;
					k.TextColor3 = E;
				end);
			end;
			u = ((u + .008 * ((I.CircleRainbowSpeed or 1)))) % 1;
			Q.RenderStepped:Wait();
		end;
	end);
	local f = false;
	local function Z(W)
		if D.unloaded or not D.panel or not D.panel.Parent then
			return;
		end;
		W = W and true or false;
		if W == f then
			return;
		end;
		f = W;
		local Q = tonumber(I.MenuAnimSpeed) or .35;
		local A = tonumber(I.MenuDodgeAnimSpeed) or .5;
		if W then
			local u = TweenInfo.new(Q, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			(y:Create(D.panel, u, { Position = UDim2.new(D.panel.Position.X.Scale, D.panel.Position.X.Offset - 800, D.panel.Position.Y.Scale, D.panel.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(y:Create(D.shadow, u, { Position = UDim2.new(D.shadow.Position.X.Scale, D.shadow.Position.X.Offset - 800, D.shadow.Position.Y.Scale, D.shadow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(y:Create(D.glow, u, { Position = UDim2.new(D.glow.Position.X.Scale, D.glow.Position.X.Offset - 800, D.glow.Position.Y.Scale, D.glow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			task.delay(Q + .02, function()
				if D.unloaded or not f then
					return;
				end;
				D.panel.Visible = false;
				D.shadow.Visible = false;
				D.glow.Visible = false;
				D.panel.BackgroundTransparency = 0;
				D.shadow.BackgroundTransparency = .65;
				D.glow.BackgroundTransparency = .86;
				U.Visible = true;
				U.Size = UDim2.fromOffset(0, 0);
				local u = tonumber(I.CircleSize) or 64;
				(y:Create(U, TweenInfo.new(A, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(u, u) })):Play();
			end);
		else
			U.Visible = false;
			U.Size = UDim2.fromOffset(0, 0);
			D.panel.Visible = true;
			D.shadow.Visible = true;
			D.glow.Visible = true;
			local W = -u / 2 - 800;
			local A = -E / 2;
			D.panel.Position = UDim2.new(.5, W, .5, A);
			D.shadow.Position = UDim2.new(.5, W + 6, .5, A + 6);
			D.glow.Position = UDim2.new(.5, W - 20, .5, A - 20);
			D.panel.BackgroundTransparency = 1;
			D.shadow.BackgroundTransparency = 1;
			D.glow.BackgroundTransparency = 1;
			local K = TweenInfo.new(Q, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			(y:Create(D.panel, K, { Position = UDim2.new(.5, -u / 2, .5, -E / 2), BackgroundTransparency = 0 })):Play();
			(y:Create(D.shadow, K, { Position = UDim2.new(.5, -u / 2 + 6, .5, -E / 2 + 6), BackgroundTransparency = .65 })):Play();
			(y:Create(D.glow, K, { Position = UDim2.new(.5, -u / 2 - 20, .5, -E / 2 - 20), BackgroundTransparency = .86 })):Play();
		end;
	end;
	_G.__adSetCollapsed = Z;
	_G.__adIsCollapsed = function()
			return f;
		end;
	if D.ui.collapseBtn then
		D.ui.collapseBtn.MouseButton1Click:Connect(function()
			if D.unloaded then
				return;
			end;
			y_();
			Z(true);
		end);
	end;
	U.MouseButton1Click:Connect(function()
		if D.unloaded then
			return;
		end;
		if l then
			l = false;
			return;
		end;
		y_();
		Z(false);
	end);
end;
local function XS(u, E)
	local W, U = pcall(E);
	if not W then
		print("[XD] BUILD ERROR in " .. (tostring(u) .. ":"), tostring(U));
		warn("[XD] BUILD ERROR in " .. (tostring(u) .. ":"), tostring(U));
	end;
end;
XS("buildPanel", D.ui.buildPanel);
XS("buildMain", D.ui.buildMain);
XS("buildHnS", D.ui.buildHnS);
XS("buildRebel", D.ui.buildRebel);
XS("buildRLGL", D.ui.buildRLGL);
XS("buildESP", D.ui.buildESP);
XS("buildDalgona", D.ui.buildDalgona);
XS("buildExtra", D.ui.buildExtra);
XS("buildConfigs", D.ui.buildConfigs);
XS("buildCollapseCircle", D.ui.buildCollapseCircle);
pcall(X_);
pcall(m_);
pcall(yS);
if I.PanelRainbow then
	qL();
end;
if I.FullBright then
	vL(true);
end;
if I.RemoveFog then
	iL(true);
end;
do
	if x then
		local u = nil;
		local function E()
			if u then
				u.cancelled = true;
				u = nil;
			end;
		end;
		pcall(function()
			x.PromptButtonHoldBegan:Connect(function(W, U)
				if D.unloaded or U ~= k or not I.InstantInteract then
					return;
				end;
				E();
				if I.InstantInteractInsta then
					pcall(fireproximityprompt, W);
					return;
				end;
				local Q = { cancelled = false };
				u = Q;
				task.spawn(function()
					local u = tonumber(I.InstantInteractMult) or 2;
					if u < .5 then
						u = .5;
					end;
					local E = 1 / u;
					while not Q.cancelled and (not D.unloaded and I.InstantInteract) do
						pcall(fireproximityprompt, W);
						task.wait(E);
					end;
				end);
			end);
		end);
		pcall(function()
			x.PromptButtonHoldEnded:Connect(function(u, W)
				if W ~= k then
					return;
				end;
				E();
			end);
		end);
	end;
end;
D.toggleMenu = function()
		if D.unloaded then
			return;
		end;
		if D.bindingMenuKey then
			return;
		end;
		if not D.panel or not D.panel.Parent then
			return;
		end;
		local u = tick();
		if u - D.lastMenuToggle < .15 then
			return;
		end;
		D.lastMenuToggle = u;
		y_();
		if _G.__adSetCollapsed and _G.__adIsCollapsed then
			local u = _G.__adIsCollapsed();
			_G.__adSetCollapsed(not u);
		else
			D.panel.Visible = not D.panel.Visible;
			if D.shadow then
				D.shadow.Visible = D.panel.Visible;
			end;
			if D.glow then
				D.glow.Visible = D.panel.Visible;
			end;
		end;
	end;
D.rebindMenu = function()
		if D.menuAction then
			pcall(function()
				U:UnbindAction(D.menuAction);
			end);
		end;
		D.menuAction = "XDMenu_" .. E_(6);
		pcall(function()
			U:BindAction(D.menuAction, function(u, E)
				if E ~= Enum.UserInputState.Begin then
					return;
				end;
				D.toggleMenu();
			end, false, I.MenuKey);
		end);
	end;
D.rebindMenu();
b(W.InputBegan:Connect(function(u)
	if D.unloaded or D.bindingMenuKey then
		return;
	end;
	if u.UserInputType ~= Enum.UserInputType.Keyboard then
		return;
	end;
	if u.KeyCode ~= I.MenuKey then
		return;
	end;
	D.toggleMenu();
end));
D.doFullUnload = function()
		if D.unloaded then
			return;
		end;
		if D.panel and (D.panel.Parent and D.panel.Visible) then
			local u = D.panel.Position.X.Scale;
			local E = D.panel.Position.Y.Scale;
			local W = D.panel.Position.X.Offset;
			local U = D.panel.Position.Y.Offset;
			local Q = TweenInfo.new(.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			pcall(function()
				(y:Create(D.panel, Q, { Position = UDim2.new(u, W - 800, E, U), BackgroundTransparency = 1 })):Play();
				(y:Create(D.shadow, Q, { Position = UDim2.new(u, (W - 800) + 6, E, U + 6), BackgroundTransparency = 1 })):Play();
				(y:Create(D.glow, Q, { Position = UDim2.new(u, (W - 800) - 20, E, U - 20), BackgroundTransparency = 1 })):Play();
			end);
			task.wait(.42);
		end;
		_G.__adUnloaded = true;
		D.running = false;
		pcall(UL);
		pcall(QL);
		pcall(AL);
		pcall(OL);
		pcall(SL);
		if D.btAnimConn then
			pcall(function()
				D.btAnimConn:Disconnect();
			end);
			D.btAnimConn = nil;
		end;
		if D._nickLoop then
			pcall(function()
				task.cancel(D._nickLoop);
			end);
			D._nickLoop = nil;
		end;
		pcall(function()
			vL(false);
		end);
		pcall(function()
			iL(false);
		end);
		if D.notifHolder then
			pcall(function()
				D.notifHolder:Destroy();
			end);
			D.notifHolder = nil;
		end;
		D.unloaded = true;
		pcall(function()
			I.Enabled = false;
			n.Enabled = false;
			I.RadiusVis = false;
			n.RadiusVis = false;
			I.AnimSpeed = false;
			I.GuardESP = false;
			I.PlayerESP = false;
			I.RemoveHands = false;
			I.RemoveLegs = false;
			I.RemoveTorso = false;
			I.Headless = false;
			I.Korblox = false;
			I.HideNick = false;
			I.FullBright = false;
			I.RemoveFog = false;
			I.AutoBrew = false;
			I.BulletTracer = false;
			D.oneClickDalgona = false;
			I.RLGL_AutoDodge = false;
			I.RLGL_TimerEndDodge = false;
			I.RebelSilentAim = false;
			I.RebelNoRecoil = false;
			I.RebelRapidFire = false;
			I.RebelFOVCircle = false;
		end);
		pcall(function()
			for u, E in pairs(_G.__dalgonaCache) do
				if u and u.Parent then
					pcall(function()
						u.Position = E.Position;
						u.Transparency = E.Transparency;
					end);
				end;
			end;
			table.clear(_G.__dalgonaCache);
		end);
		pcall(function()
			for u, E in pairs(D.origTransparency) do
				if u and u.Parent then
					pcall(function()
						u.LocalTransparencyModifier = 0;
						u.Transparency = E;
					end);
				end;
			end;
			table.clear(D.origTransparency);
			local function u(u)
				for E = 1, #u, 1 do
					local W = u[E];
					if W and W.Parent then
						pcall(function()
							W.LocalTransparencyModifier = 0;
						end);
					end;
				end;
			end;
			u(D.handCache);
			u(D.legCache);
			u(D.torsoCache);
			table.clear(D.handCache);
			table.clear(D.legCache);
			table.clear(D.torsoCache);
		end);
		pcall(function()
			QS(false);
		end);
		pcall(function()
			ES(false);
		end);
		pcall(M_);
		pcall(PL);
		pcall(eL);
		pcall(AS);
		pcall(IL);
		for u = 1, #D.conns, 1 do
			pcall(function()
				if D.conns[u] and D.conns[u].Disconnect then
					D.conns[u]:Disconnect();
				end;
			end);
		end;
		table.clear(D.conns);
		for u, E in pairs(D.added) do
			pcall(function()
				if E and E.Disconnect then
					E:Disconnect();
				end;
			end);
		end;
		table.clear(D.added);
		if D.handsConn then
			pcall(function()
				D.handsConn:Disconnect();
			end);
			D.handsConn = nil;
		end;
		if D.dalgonaConn then
			pcall(function()
				D.dalgonaConn:Disconnect();
			end);
			D.dalgonaConn = nil;
		end;
		if D.tracerGui then
			pcall(function()
				D.tracerGui:Destroy();
			end);
			D.tracerGui = nil;
		end;
		if D.overlayGui then
			pcall(function()
				D.overlayGui:Destroy();
			end);
			D.overlayGui = nil;
		end;
		if D.infoGui then
			pcall(function()
				D.infoGui:Destroy();
			end);
			D.infoGui = nil;
		end;
		if D.menuAction then
			pcall(function()
				U:UnbindAction(D.menuAction);
			end);
			D.menuAction = nil;
		end;
		if D.clickSound then
			pcall(function()
				D.clickSound:Destroy();
			end);
			D.clickSound = nil;
		end;
		pcall(function()
			if D.gui then
				D.gui.Enabled = false;
				for u, E in ipairs(D.gui:GetDescendants()) do
					pcall(function()
						if E and E.Destroy then
							E:Destroy();
						end;
					end);
				end;
				D.gui:Destroy();
			end;
		end);
		D.gui = nil;
		D.shadow = nil;
		D.glow = nil;
		D.panel = nil;
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
_G.__XD_UNLOAD = D.doFullUnload;
task.spawn(function()
	while D.running and not D.unloaded do
		pcall(function()
			if I.AnimSpeed then
				local u = k.Character;
				local E = u and u:FindFirstChildOfClass("Humanoid");
				local W = E and E:FindFirstChildOfClass("Animator");
				if W then
					local u = I.AnimSpeedValue or 2.5;
					for E, W in ipairs(W:GetPlayingAnimationTracks()) do
						pcall(function()
							if W.Speed ~= u then
								W:AdjustSpeed(u);
							end;
						end);
					end;
				end;
			end;
			if I.RemoveHands or I.RemoveLegs or I.RemoveTorso then
				sL();
			end;
			if I.Headless then
				ES(true);
			end;
			if I.Korblox then
				QS(true);
			end;
			if I.Enabled or n.Enabled then
				D.cachedUITool = P_();
				D.cachedDodgeTool = e_();
				D.cachedSlot = L_(D.cachedUITool, "T", I.ManualUISlot);
				D.cachedDodgeSlot = L_(D.cachedDodgeTool, "1", I.ManualHnSSlot);
			end;
			if ((I.RebelSilentAim or I.RebelNoRecoil or I.RebelRapidFire)) and not D.combatHooked then
				WL();
			end;
		end);
		task.wait(.1);
	end;
end);
task.spawn(function()
	while D.running and not D.unloaded do
		if I.GuardESP or I.PlayerESP then
			pcall(RL);
		end;
		task.wait(.5);
	end;
end);
task.spawn(function()
	while D.running and not D.unloaded do
		pcall(function()
			local u = {};
			if I.Enabled then
				table.insert(u, "ui " .. D.cachedSlot);
			end;
			if n.Enabled then
				table.insert(u, "hns " .. D.cachedDodgeSlot);
			end;
			if I.RebelSilentAim then
				table.insert(u, "aim");
			end;
			if I.RebelNoRecoil then
				table.insert(u, "norec");
			end;
			if I.RebelRapidFire then
				table.insert(u, "rapid");
			end;
			if I.BulletTracer then
				table.insert(u, "btracer");
			end;
			if I.RLGL_AutoDodge then
				table.insert(u, "rlgl");
			end;
			if I.RLGL_TimerEndDodge then
				table.insert(u, "timer-end");
			end;
			if I.HideNick then
				table.insert(u, "hide-nick");
			end;
			if I.AutoBrew then
				table.insert(u, "auto-brew");
			end;
			if D.oneClickDalgona then
				table.insert(u, "dalgona ON");
			end;
			if I.GuardESP or I.PlayerESP then
				table.insert(u, string.format("esp %d/%d", _G.__adEspDone or 0, _G.__adEspTotal or 0));
			end;
			if I.AnimSpeed then
				table.insert(u, "anim");
			end;
			if _G.__ad_statusCb then
				if #u == 0 then
					_G.__ad_statusCb("paused - N");
				else
					_G.__ad_statusCb(table.concat(u, " - "));
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
	while D.running and not D.unloaded do
		pcall(function()
			local u = _G.__rlgl_isOnMap();
			if not u then
				_G.__rlglLastSec = nil;
				_G.__rlglTimerEndedAt = 0;
				_G.__rlglWasRed = false;
				task.wait(.5);
				return;
			end;
			if I.RLGL_AutoDodge then
				local u = _G.__rlgl_isRed();
				local E = _G.__rlgl_isMoving(I.RLGL_VelThreshold or .3);
				local W = _G.__rlgl_inSafeZone();
				if u and not _G.__rlglWasRed then
					_G.__rlglRedStartAt = tick();
				end;
				_G.__rlglWasRed = u;
				local U = u and (tick() - _G.__rlglRedStartAt) or 0;
				local Q = I.RLGL_RedDelay or .1;
				local A = true;
				if W then
					A = false;
				end;
				if I.RLGL_OnlyRedLight and A then
					if not u then
						A = false;
					end;
					if U < Q then
						A = false;
					end;
				end;
				if A and not E then
					A = false;
				end;
				local y = tick();
				if A and (y - _G.__rlglLast) >= ((I.RLGL_MinInterval or .15)) then
					_G.__rlglLast = y;
					task.spawn(_G.__rlgl_fireDodge);
				end;
			end;
			if I.RLGL_TimerEndDodge then
				local u = _G.__rlgl_timerSeconds();
				local E = _G.__rlgl_inSafeZone();
				local W = _G.__rlgl_inFinishZone();
				if u ~= nil then
					_G.__rlglLastSec = u;
				end;
				if u ~= nil and u > 10 then
					_G.__rlglTimerEndedAt = 0;
				end;
				local U = false;
				if u ~= nil and u <= 0 then
					U = true;
				end;
				if u == nil and (_G.__rlglLastSec and _G.__rlglLastSec <= 3) then
					U = true;
				end;
				if U and _G.__rlglTimerEndedAt == 0 then
					_G.__rlglTimerEndedAt = tick();
					_G.__rlglLastFire = 0;
				end;
				if _G.__rlglTimerEndedAt > 0 and (not E and not W) then
					local u = I.RLGL_TimerEndDelay or 0;
					local E = I.RLGL_TimerEndInterval or .15;
					local W = I.RLGL_TimerEndMaxDuration or 12;
					local U = tick() - _G.__rlglTimerEndedAt;
					if U > W then
						_G.__rlglTimerEndedAt = 0;
					elseif U >= u then
						local u = tick();
						if _G.__rlglLastFire == 0 or (u - _G.__rlglLastFire >= E) then
							_G.__rlglLastFire = u;
							task.spawn(_G.__rlgl_fireDodge);
						end;
					end;
				end;
			end;
		end);
		task.wait(.05);
	end;
end);
b(k.CharacterAdded:Connect(function(u)
	task.wait(.5);
	if D.unloaded then
		return;
	end;
	sL();
	if I.RemoveHands then
		HL(true);
	end;
	if I.RemoveLegs then
		YL(true);
	end;
	if I.RemoveTorso then
		GL(true);
	end;
	if I.Headless then
		ES(true);
	end;
	if I.Korblox then
		QS(true);
	end;
end));
if k.Character then
	b(k.Character.DescendantAdded:Connect(function()
		if D.unloaded then
			return;
		end;
		if I.RemoveHands or I.RemoveLegs or I.RemoveTorso or I.Headless or I.Korblox then
			task.defer(function()
				sL();
				if I.RemoveHands then
					HL(true);
				end;
				if I.RemoveLegs then
					YL(true);
				end;
				if I.RemoveTorso then
					GL(true);
				end;
				if I.Headless then
					ES(true);
				end;
				if I.Korblox then
					QS(true);
				end;
			end);
		end;
	end));
end;
uS();
do
	local function E(u)
		if not u or u == k then
			return;
		end;
		b((u:GetPropertyChangedSignal("Team")):Connect(function()
			if not D.unloaded and ((I.GuardESP or I.PlayerESP)) then
				task.defer(RL);
			end;
		end));
	end;
	for u, W in ipairs(u:GetPlayers()) do
		E(W);
	end;
	b(u.PlayerAdded:Connect(E));
end;
pcall(function()
	if D.FILE.isfile and D.FILE.isfile(OS("default")) then
		ZS("default");
	end;
end);
if getgenv then
	(getgenv()).__ui_dodge = { shutdown = D.doFullUnload, config = I, H = n };
end;
if _G.__adStatusCb then
	_G.__adStatusCb("ready - N");
end;
print("[XD] LOADED", f, Z);

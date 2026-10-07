--[[
    x1oni1x dew4mp 1NK (X/D) v5.6.1
    + Auto Brew: native keypress first, Brew Delay slider
    + Hitbox Expander + Visualizer
    + Rapid Fire mult (1-50)
    + Aimbot + FOV circle shared
    + autoload configs
--]]

local Players=game:GetService("Players")
local Workspace=game:GetService("Workspace")
local UIS=game:GetService("UserInputService")
local CAS=game:GetService("ContextActionService")
local RunService=game:GetService("RunService")
local HttpService=game:GetService("HttpService")
local TweenService=game:GetService("TweenService")
local SoundService=game:GetService("SoundService")
local StatsService=game:GetService("Stats")
local Lighting=game:GetService("Lighting")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local ProximityPromptService=nil
pcall(function() ProximityPromptService=game:GetService("ProximityPromptService") end)
local LP=Players.LocalPlayer
while not LP do task.wait(0.1) LP=Players.LocalPlayer end
if not game:IsLoaded() then game.Loaded:Wait() end
local SCRIPT_NAME="x1oni1x dew4mp 1NK (X/D)"
local SCRIPT_VERSION="v5.6.1"
local S={}
S.FILE=(function()
	local env=(getgenv and getgenv()) or _G
	local function pick(n)
		local g=_G[n] or rawget(_G,n)
		if g then return g end
		if env and env[n] then return env[n] end
		return nil
	end
	return {writefile=pick("writefile"),readfile=pick("readfile"),isfile=pick("isfile"),isfolder=pick("isfolder"),makefolder=pick("makefolder"),listfiles=pick("listfiles"),delfile=pick("delfile")}
end)()
S.running=true S.unloaded=false S.conns={} S.hooks={} S.added={}
S.oneClickDalgona=false S.dalgonaConn=nil
S.cachedSlot="T" S.cachedDodgeSlot="1" S.cachedUITool=nil S.cachedDodgeTool=nil
S.lastDodgeUI=0 S.lastDodgeH=0 S.lastMenuToggle=0
S.gui=nil S.shadow=nil S.glow=nil S.panel=nil
S.tracerGui=nil S.overlayGui=nil S.infoGui=nil
S.wmFrame=nil S.wmLabel=nil S.kbFrame=nil S.kbLabel=nil
S.menuAction=nil S.clickSound=nil S.notifSound=nil
S.combatHooked=false S.origFiredGun=nil S.origGetBuffs=nil S.gunMod=nil
S.fovGui=nil S.fovFrame=nil S.fovStroke=nil
S.colorPickerOpen=nil
S.fovRainbowConn=nil S.panelRainbowConn=nil S.notifHolder=nil
S.fbInst=nil S.fogBackup=nil
S.bindingMenuKey=false
S.currentConfigName="default"
S.animEnabled={}
S.hideConns={}
S.handCache={} S.legCache={} S.torsoCache={} S.origTransparency={} S.handsConn=nil
S.korbloxData={}
S.lastBrewTick=0 S.brewLoopConn=nil
S.activeNotifs={}
S.btAnimConn=nil
S.btLastIdTime={}
S.btLastShot=0
S._nickLoop=nil
S.menuOpen=true
S.menuTweens={}
S.aimbotConn=nil
S.infiniteAmmoLoop=nil
_G.__adEspDone=0 _G.__adEspTotal=0 _G.__dalgonaCache={} _G.__adWatchers={}
_G.__rlglLast=0 _G.__rlglRedStartAt=0 _G.__rlglWasRed=false
_G.__rlglLastSec=nil _G.__rlglTimerEndedAt=0 _G.__rlglLastFire=0
_G.__adUnloaded=false
do
	if getgenv and getgenv().__ui_dodge and getgenv().__ui_dodge.shutdown then pcall(function() getgenv().__ui_dodge.shutdown() end) end
	local h={}
	if gethui then pcall(function() table.insert(h,gethui()) end) end
	pcall(function() table.insert(h,game:GetService("CoreGui")) end)
	if LP then pcall(function() table.insert(h,LP:FindFirstChildOfClass("PlayerGui")) end) end
	for _,hh in ipairs(h) do
		if hh and typeof(hh)=="Instance" then
			for _,ch in ipairs(hh:GetChildren()) do
				if ch:IsA("ScreenGui") and tostring(ch.Name):find("^XD_") then pcall(function() ch:Destroy() end) end
			end
		end
	end
end
local SHOT_ANIMS={
	["rbxassetid://124637626540536"]="HK416",
	["rbxassetid://138748957635848"]="G3SG1",
	["rbxassetid://96837363717592"]="Deagle",
	["rbxassetid://88111250846452"]="Glock 17",
	["rbxassetid://87593987526528"]="FN Fal",
	["rbxassetid://76674339459544"]="MP5K",
	["rbxassetid://122334383661670"]="M4A1",
	["rbxassetid://93906174064273"]="Five Seven",
	["rbxassetid://84089564531020"]="Thompson M1A1",
	["rbxassetid://78301729996106"]="P90",
	["rbxassetid://94523642657060"]="Uzi",
	["rbxassetid://83718615035368"]="Colt M1911",
	["rbxassetid://129874518877211"]="MP5",
}
local SHOT_IDS={}
for k,v in pairs(SHOT_ANIMS) do
	SHOT_IDS[k]=v
	local num=k:match("%d+")
	if num then SHOT_IDS[num]=v end
end
local function mkGrad5(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0,Color3.fromRGB(a,b,c)),
		ColorSequenceKeypoint.new(0.25,Color3.fromRGB(d,e,f)),
		ColorSequenceKeypoint.new(0.5,Color3.fromRGB(g,h,i)),
		ColorSequenceKeypoint.new(0.75,Color3.fromRGB(j,k,l)),
		ColorSequenceKeypoint.new(1,Color3.fromRGB(m,n,o)),
	})
end
local C={
	Enabled=false,Distance=18,Delay=0,MinInterval=0.02,AnimWatch=0.4,WatchAfter=0.3,
	RadiusVis=false,RadiusTransparency=0.55,RadiusR=255,RadiusG=70,RadiusB=160,
	GuardESP=false,GuardESP_HP=true,GuardESP_Name=true,GuardESP_Tool=true,GuardESP_ForceAll=false,
	GuardESP_Highlight=true,GuardESP_Tracer=false,GuardESP_Box=false,GuardESP_Skeleton=false,
	GuardESP_HPBarThickness=8,GuardESP_HPBarLength=1.5,GuardESP_HPBarRoundness=3,
	GuardESP_ColorR=255,GuardESP_ColorG=50,GuardESP_ColorB=50,
	GuardESP_TracerR=255,GuardESP_TracerG=50,GuardESP_TracerB=50,
	GuardESP_BoxR=255,GuardESP_BoxG=50,GuardESP_BoxB=50,
	GuardESP_SkeletonR=255,GuardESP_SkeletonG=50,GuardESP_SkeletonB=50,
	GuardESP_BoxThickness=2,GuardESP_SkeletonThickness=1.5,GuardESP_NameSize=17,
	GuardESP_Distance=false,GuardESP_MaxDist=500,
	GuardESP_HP_TopR=80,GuardESP_HP_TopG=255,GuardESP_HP_TopB=80,
	GuardESP_HP_M1R=180,GuardESP_HP_M1G=255,GuardESP_HP_M1B=60,
	GuardESP_HP_M2R=255,GuardESP_HP_M2G=200,GuardESP_HP_M2B=40,
	GuardESP_HP_M3R=255,GuardESP_HP_M3G=120,GuardESP_HP_M3B=60,
	GuardESP_HP_BotR=255,GuardESP_HP_BotG=40,GuardESP_HP_BotB=40,
	GuardESP_HP_State1_R=74,GuardESP_HP_State1_G=222,GuardESP_HP_State1_B=74,
	GuardESP_HP_State2_R=255,GuardESP_HP_State2_G=210,GuardESP_HP_State2_B=60,
	GuardESP_HP_State3_R=255,GuardESP_HP_State3_G=130,GuardESP_HP_State3_B=40,
	GuardESP_HP_State4_R=255,GuardESP_HP_State4_G=55,GuardESP_HP_State4_B=55,
	GuardESP_HP_Outline=false,
	GuardESP_HP_ChipBg=true,
	PlayerESP=false,PlayerESP_HP=true,PlayerESP_Name=true,PlayerESP_Tool=true,
	PlayerESP_Highlight=true,PlayerESP_Tracer=false,PlayerESP_Box=false,PlayerESP_Skeleton=false,
	PlayerESP_HPBarThickness=8,PlayerESP_HPBarLength=1.5,PlayerESP_HPBarRoundness=3,
	PlayerESP_ColorR=80,PlayerESP_ColorG=255,PlayerESP_ColorB=120,
	PlayerESP_TracerR=80,PlayerESP_TracerG=255,PlayerESP_TracerB=120,
	PlayerESP_BoxR=80,PlayerESP_BoxG=255,PlayerESP_BoxB=120,
	PlayerESP_SkeletonR=80,PlayerESP_SkeletonG=255,PlayerESP_SkeletonB=120,
	PlayerESP_BoxThickness=2,PlayerESP_SkeletonThickness=1.5,PlayerESP_NameSize=17,
	PlayerESP_Distance=false,PlayerESP_MaxDist=500,
	PlayerESP_HP_TopR=80,PlayerESP_HP_TopG=255,PlayerESP_HP_TopB=80,
	PlayerESP_HP_M1R=180,PlayerESP_HP_M1G=255,PlayerESP_HP_M1B=60,
	PlayerESP_HP_M2R=255,PlayerESP_HP_M2G=200,PlayerESP_HP_M2B=40,
	PlayerESP_HP_M3R=255,PlayerESP_HP_M3G=120,PlayerESP_HP_M3B=60,
	PlayerESP_HP_BotR=255,PlayerESP_HP_BotG=40,PlayerESP_HP_BotB=40,
	PlayerESP_HP_State1_R=74,PlayerESP_HP_State1_G=222,PlayerESP_HP_State1_B=74,
	PlayerESP_HP_State2_R=255,PlayerESP_HP_State2_G=210,PlayerESP_HP_State2_B=60,
	PlayerESP_HP_State3_R=255,PlayerESP_HP_State3_G=130,PlayerESP_HP_State3_B=40,
	PlayerESP_HP_State4_R=255,PlayerESP_HP_State4_G=55,PlayerESP_HP_State4_B=55,
	PlayerESP_HP_Outline=false,
	PlayerESP_HP_ChipBg=true,
	PlayerESP_CustomName="",
	PlayerESP_NameRainbow=false,
	PlayerESP_NameRainbowSpeed=1.0,
	Watermark=true,KeybindList=true,
	InstantInteract=false,InstantInteractInsta=false,InstantInteractMult=2,
	MenuKey=Enum.KeyCode.N,
	RemoveLegs=false,RemoveHands=false,RemoveTorso=false,Headless=false,Korblox=false,
	HideNick=false,FullBright=false,RemoveFog=false,
	ESP_FontIdx=1,
	PanelRainbow=true,
	FOVRainbow=false,FOVRainbowMode=1,FOVUseCustom=false,FOVCustomIdx=1,
	FOVCustomR1=255,FOVCustomG1=60,FOVCustomB1=60,
	FOVCustomR2=60,FOVCustomG2=255,FOVCustomB2=60,
	FOVCustomR3=60,FOVCustomG3=140,FOVCustomB3=255,
	FOVCustomR4=255,FOVCustomG4=255,FOVCustomB4=60,
	FOVCustomR5=255,FOVCustomG5=60,FOVCustomB5=255,
	FOVCustomR6=60,FOVCustomG6=255,FOVCustomB6=255,
	FOVCustomR7=255,FOVCustomG7=180,FOVCustomB7=60,
	FOVCustomR8=255,FOVCustomG8=255,FOVCustomB8=255,
	FOVCustomR9=180,FOVCustomG9=60,FOVCustomB9=255,
	AutoBrew=false,AutoBrewSlot="E",AutoBrewInterval=60,AutoBrewCollectHold=2.0,AutoBrewDelayCollect=0,AutoBrewBrewDelay=3.0,
	BulletTracer=false,
	BulletTracerR=255,BulletTracerG=147,BulletTracerB=255,
	BulletTracerThickness=0.20,
	BulletTracerSpeed=800,
	BulletTracerLifetime=2.00,
	BulletTracerRange=1050,
	BulletTracerStartOffset=0.30,
	BulletTracerEndOffset=0.00,
	BulletTracerOpacity=0.00,
	BulletTracerGlow=true,
	BulletTracerWhiteCore=true,
	BulletTracerFadeIdx=1,
	BulletTracerCooldown=0.03,
	ManualUISlot="",ManualHnSSlot="",
	GuiR=200,GuiG=60,GuiB=255,
	GuiTextR=235,GuiTextG=225,GuiTextB=250,
	AnimSpeed=false,AnimSpeedValue=2.5,
	MenuAnimSpeed=0.35,
	MenuDodgeAnimSpeed=0.5,
	CircleTextR=255,CircleTextG=255,CircleTextB=255,
	CircleRainbowText=false,CircleRainbowOutline=true,
	CircleSize=64,
	CircleRainbowSpeed=1.0,
	RLGL_AutoDodge=false,RLGL_OnlyRedLight=true,
	RLGL_MinInterval=0.75,RLGL_RedDelay=0.55,RLGL_VelThreshold=0.1,
	RLGL_TimerEndDodge=true,RLGL_TimerEndDelay=12,RLGL_TimerEndInterval=0.75,RLGL_TimerEndMaxDuration=9,
	RebelSilentAim=false,RebelNoRecoil=false,RebelRapidFire=false,RebelRapidFireMult=2,
	RebelAimbot=false,RebelAimbotHoldKey=false,RebelAimbotSmooth=1.0,RebelAimbotTargetGuards=true,
	HitboxExpander=false,HitboxSize=3,HitboxTargets="All",HitboxDistance=500,
	HitboxVisualize=false,HitboxColorR=255,HitboxColorG=80,HitboxColorB=80,HitboxTransparency=0.85,
	RebelFOV=250,RebelFOVCircle=false,RebelFOVNeon=true,RebelFOVBlackOutline=true,
	RebelFOV_OutlineThickness=5,RebelFOV_OutlineR=0,RebelFOV_OutlineG=0,RebelFOV_OutlineB=0,
	RebelFOVCircleWidth=1.6,
	RebelFOVBlendSpeed=0.5,
	RebelFOVR=255,RebelFOVG=60,RebelFOVB=60,
	RebelTargetPlayers=true,RebelTargetNPCs=true,
	RebelBodyHead=true,RebelBodyTorso=true,RebelBodyHRP=false,
	RebelBodyLeftArm=false,RebelBodyRightArm=false,RebelBodyLeftLeg=false,RebelBodyRightLeg=false,
	InfiniteAmmo=false,
	InfiniteAmmoValue=999,
}
local H={Enabled=false,Distance=18,Delay=0,MinInterval=0.02,AnimWatch=0.4,WatchAfter=0.3,
	RadiusVis=false,RadiusTransparency=0.55,RadiusR=70,RadiusG=210,RadiusB=255,HollyMode=true}
local ESP_FONT_NAMES={"GothamBlack","GothamBold","Gotham","Code","Arial","ArialBold","SourceSans","SourceSansBold","SciFi","Fantasy","Roboto","RobotoMono","Ubuntu","Oswald","Nunito","Bodoni","Cartoon","IndieFlower","PatrickHand","Antique","Garamond","Highway","Legacy","PermanentMarker","Sarpanch","SpecialElite","Michroma"}
local function espFont()
	local idx=math.clamp(C.ESP_FontIdx or 1,1,#ESP_FONT_NAMES)
	local f=Enum.Font[ESP_FONT_NAMES[idx]]
	if not f then f=Enum.Font.GothamBlack end
	return f
end
local function guardChipColor(ratio)
	local r,g,b
	if ratio>0.75 then r,g,b=C.GuardESP_HP_State1_R or 74,C.GuardESP_HP_State1_G or 222,C.GuardESP_HP_State1_B or 74
	elseif ratio>0.5 then r,g,b=C.GuardESP_HP_State2_R or 255,C.GuardESP_HP_State2_G or 210,C.GuardESP_HP_State2_B or 60
	elseif ratio>0.25 then r,g,b=C.GuardESP_HP_State3_R or 255,C.GuardESP_HP_State3_G or 130,C.GuardESP_HP_State3_B or 40
	else r,g,b=C.GuardESP_HP_State4_R or 255,C.GuardESP_HP_State4_G or 55,C.GuardESP_HP_State4_B or 55 end
	return Color3.fromRGB(r,g,b)
end
local function playerChipColor(ratio)
	local r,g,b
	if ratio>0.75 then r,g,b=C.PlayerESP_HP_State1_R or 74,C.PlayerESP_HP_State1_G or 222,C.PlayerESP_HP_State1_B or 74
	elseif ratio>0.5 then r,g,b=C.PlayerESP_HP_State2_R or 255,C.PlayerESP_HP_State2_G or 210,C.PlayerESP_HP_State2_B or 60
	elseif ratio>0.25 then r,g,b=C.PlayerESP_HP_State3_R or 255,C.PlayerESP_HP_State3_G or 130,C.PlayerESP_HP_State3_B or 40
	else r,g,b=C.PlayerESP_HP_State4_R or 255,C.PlayerESP_HP_State4_G or 55,C.PlayerESP_HP_State4_B or 55 end
	return Color3.fromRGB(r,g,b)
end
local function track(c)
	if not c then return c end
	if S.unloaded then pcall(function() c:Disconnect() end) return c end
	table.insert(S.conns,c) return c
end
local function guiAccent() return Color3.fromRGB(C.GuiR or 200,C.GuiG or 60,C.GuiB or 255) end
local function guiTextColor() return Color3.fromRGB(C.GuiTextR or 235,C.GuiTextG or 225,C.GuiTextB or 250) end
local function accentDark(c) return c:Lerp(Color3.new(0,0,0),0.7) end
local function uiRadiusColor() return Color3.fromRGB(C.RadiusR or 255,C.RadiusG or 70,C.RadiusB or 160) end
local function hnsRadiusColor() return Color3.fromRGB(H.RadiusR or 70,H.RadiusG or 210,H.RadiusB or 255) end
local function circleTextColor() return Color3.fromRGB(C.CircleTextR or 255,C.CircleTextG or 255,C.CircleTextB or 255) end
local function customFOVColor(idx)
	local i=math.clamp(idx,1,9)
	local r,g,b=255,60,60
	if i==1 then r,g,b=C.FOVCustomR1 or 255,C.FOVCustomG1 or 60,C.FOVCustomB1 or 60
	elseif i==2 then r,g,b=C.FOVCustomR2 or 60,C.FOVCustomG2 or 255,C.FOVCustomB2 or 60
	elseif i==3 then r,g,b=C.FOVCustomR3 or 60,C.FOVCustomG3 or 140,C.FOVCustomB3 or 255
	elseif i==4 then r,g,b=C.FOVCustomR4 or 255,C.FOVCustomG4 or 255,C.FOVCustomB4 or 60
	elseif i==5 then r,g,b=C.FOVCustomR5 or 255,C.FOVCustomG5 or 60,C.FOVCustomB5 or 255
	elseif i==6 then r,g,b=C.FOVCustomR6 or 60,C.FOVCustomG6 or 255,C.FOVCustomB6 or 255
	elseif i==7 then r,g,b=C.FOVCustomR7 or 255,C.FOVCustomG7 or 180,C.FOVCustomB7 or 60
	elseif i==8 then r,g,b=C.FOVCustomR8 or 255,C.FOVCustomG8 or 255,C.FOVCustomB8 or 255
	elseif i==9 then r,g,b=C.FOVCustomR9 or 180,C.FOVCustomG9 or 60,C.FOVCustomB9 or 255 end
	return Color3.fromRGB(r,g,b)
end
local function rebelFOVColor()
	if C.FOVUseCustom then return customFOVColor(C.FOVCustomIdx or 1) end
	return Color3.fromRGB(C.RebelFOVR or 255,C.RebelFOVG or 60,C.RebelFOVB or 60)
end
local function rebelOutlineColor() return Color3.fromRGB(C.RebelFOV_OutlineR or 0,C.RebelFOV_OutlineG or 0,C.RebelFOV_OutlineB or 0) end
local function guardESPColor() return Color3.fromRGB(C.GuardESP_ColorR or 255,C.GuardESP_ColorG or 50,C.GuardESP_ColorB or 50) end
local function playerESPColor() return Color3.fromRGB(C.PlayerESP_ColorR or 80,C.PlayerESP_ColorG or 255,C.PlayerESP_ColorB or 120) end
local function guardTracerColor() return Color3.fromRGB(C.GuardESP_TracerR or 255,C.GuardESP_TracerG or 50,C.GuardESP_TracerB or 50) end
local function playerTracerColor() return Color3.fromRGB(C.PlayerESP_TracerR or 80,C.PlayerESP_TracerG or 255,C.PlayerESP_TracerB or 120) end
local function guardBoxColor() return Color3.fromRGB(C.GuardESP_BoxR or 255,C.GuardESP_BoxG or 50,C.GuardESP_BoxB or 50) end
local function playerBoxColor() return Color3.fromRGB(C.PlayerESP_BoxR or 80,C.PlayerESP_BoxG or 255,C.PlayerESP_BoxB or 120) end
local function guardHPGrad() return mkGrad5(
	C.GuardESP_HP_TopR or 80,C.GuardESP_HP_TopG or 255,C.GuardESP_HP_TopB or 80,
	C.GuardESP_HP_M1R or 180,C.GuardESP_HP_M1G or 255,C.GuardESP_HP_M1B or 60,
	C.GuardESP_HP_M2R or 255,C.GuardESP_HP_M2G or 200,C.GuardESP_HP_M2B or 40,
	C.GuardESP_HP_M3R or 255,C.GuardESP_HP_M3G or 120,C.GuardESP_HP_M3B or 60,
	C.GuardESP_HP_BotR or 255,C.GuardESP_HP_BotG or 40,C.GuardESP_HP_BotB or 40) end
local function playerHPGrad() return mkGrad5(
	C.PlayerESP_HP_TopR or 80,C.PlayerESP_HP_TopG or 255,C.PlayerESP_HP_TopB or 80,
	C.PlayerESP_HP_M1R or 180,C.PlayerESP_HP_M1G or 255,C.PlayerESP_HP_M1B or 60,
	C.PlayerESP_HP_M2R or 255,C.PlayerESP_HP_M2G or 200,C.PlayerESP_HP_M2B or 40,
	C.PlayerESP_HP_M3R or 255,C.PlayerESP_HP_M3G or 120,C.PlayerESP_HP_M3B or 60,
	C.PlayerESP_HP_BotR or 255,C.PlayerESP_HP_BotG or 40,C.PlayerESP_HP_BotB or 40) end
local function guardChipState1() return Color3.fromRGB(C.GuardESP_HP_State1_R or 74,C.GuardESP_HP_State1_G or 222,C.GuardESP_HP_State1_B or 74) end
local function guardChipState2() return Color3.fromRGB(C.GuardESP_HP_State2_R or 255,C.GuardESP_HP_State2_G or 210,C.GuardESP_HP_State2_B or 60) end
local function guardChipState3() return Color3.fromRGB(C.GuardESP_HP_State3_R or 255,C.GuardESP_HP_State3_G or 130,C.GuardESP_HP_State3_B or 40) end
local function guardChipState4() return Color3.fromRGB(C.GuardESP_HP_State4_R or 255,C.GuardESP_HP_State4_G or 55,C.GuardESP_HP_State4_B or 55) end
local function playerChipState1() return Color3.fromRGB(C.PlayerESP_HP_State1_R or 74,C.PlayerESP_HP_State1_G or 222,C.PlayerESP_HP_State1_B or 74) end
local function playerChipState2() return Color3.fromRGB(C.PlayerESP_HP_State2_R or 255,C.PlayerESP_HP_State2_G or 210,C.PlayerESP_HP_State2_B or 60) end
local function playerChipState3() return Color3.fromRGB(C.PlayerESP_HP_State3_R or 255,C.PlayerESP_HP_State3_G or 130,C.PlayerESP_HP_State3_B or 40) end
local function playerChipState4() return Color3.fromRGB(C.PlayerESP_HP_State4_R or 255,C.PlayerESP_HP_State4_G or 55,C.PlayerESP_HP_State4_B or 55) end
local function randStr(n) local s="" for _=1,n do s=s..string.char(math.random(97,122)) end return s end
local function jitter(b,a) return b+(math.random()*2-1)*(a or 0.006) end
local repainters={}
local function registerRepaint(fn) table.insert(repainters,fn) end
local function repaintAll() for i=1,#repainters do pcall(repainters[i]) end end
local function playClick()
	if S.unloaded then return end
	pcall(function()
		if not S.clickSound then
			S.clickSound=Instance.new("Sound")
			S.clickSound.SoundId="rbxassetid://876939830"
			S.clickSound.Volume=0.3
			S.clickSound.Parent=SoundService
		end
		S.clickSound.TimePosition=0 S.clickSound:Play()
	end)
end
local function addCorner(o,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=o return c end
local function addGrad(o,a,b,rot) local g=Instance.new("UIGradient") g.Color=ColorSequence.new(a,b) g.Rotation=rot or 90 g.Parent=o return g end
local function addStroke(o,color,thick,trans)
	local s=Instance.new("UIStroke")
	s.Color=color or Color3.new(1,1,1) s.Thickness=thick or 1 s.Transparency=trans or 0
	s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=o return s
end
local function ensureTracerGui()
	if S.tracerGui and S.tracerGui.Parent then return end
	S.tracerGui=Instance.new("ScreenGui")
	S.tracerGui.Name="XD_Tr_"..randStr(6)
	S.tracerGui.IgnoreGuiInset=true S.tracerGui.ResetOnSpawn=false S.tracerGui.DisplayOrder=99990
	local ph=nil
	if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then ph=h end end
	if not ph then ph=LP:FindFirstChildOfClass("PlayerGui") end
	if not ph then ph=game:GetService("CoreGui") end
	pcall(function() S.tracerGui.Parent=ph end)
	if not S.tracerGui.Parent then pcall(function() S.tracerGui.Parent=game:GetService("CoreGui") end) end
end
local function ensureOverlayGui()
	if S.overlayGui and S.overlayGui.Parent then return end
	S.overlayGui=Instance.new("ScreenGui")
	S.overlayGui.Name="XD_Ov_"..randStr(6)
	S.overlayGui.IgnoreGuiInset=true S.overlayGui.ResetOnSpawn=false S.overlayGui.DisplayOrder=99985
	local ph=nil
	if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then ph=h end end
	if not ph then ph=LP:FindFirstChildOfClass("PlayerGui") end
	if not ph then ph=game:GetService("CoreGui") end
	pcall(function() S.overlayGui.Parent=ph end)
	if not S.overlayGui.Parent then pcall(function() S.overlayGui.Parent=game:GetService("CoreGui") end) end
end
local function normName(s) return string.lower(tostring(s or "")):gsub("[%s%-_%.]","") end
local function findBodyPart(model,name)
	if not model or not name then return nil end
	local d=model:FindFirstChild(name)
	if d and d:IsA("BasePart") then return d end
	local t=normName(name)
	for _,ch in ipairs(model:GetChildren()) do if ch:IsA("BasePart") and normName(ch.Name)==t then return ch end end
	for _,ch in ipairs(model:GetDescendants()) do if ch:IsA("BasePart") and ch.Parent~=nil and normName(ch.Name)==t then return ch end end
	return nil
end
local function getCharScreenBounds(char,cam)
	if not char or not cam then return nil end
	local a,b=math.huge,math.huge
	local c,d=-math.huge,-math.huge
	local any=false
	for _,p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") then
			local sp,onScreen=cam:WorldToViewportPoint(p.Position)
			if onScreen then
				any=true
				if sp.X<a then a=sp.X end
				if sp.Y<b then b=sp.Y end
				if sp.X>c then c=sp.X end
				if sp.Y>d then d=sp.Y end
			end
		end
	end
	if not any then return nil end
	return a,b,c,d
end
local function ensureInfoGui()
	if S.infoGui and S.infoGui.Parent then return end
	S.infoGui=Instance.new("ScreenGui")
	S.infoGui.Name="XD_I_"..randStr(6)
	S.infoGui.IgnoreGuiInset=true S.infoGui.ResetOnSpawn=false S.infoGui.DisplayOrder=99995
	local ph=nil
	if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then ph=h end end
	if not ph then ph=LP:FindFirstChildOfClass("PlayerGui") end
	if not ph then ph=game:GetService("CoreGui") end
	pcall(function() S.infoGui.Parent=ph end)
	if not S.infoGui.Parent then pcall(function() S.infoGui.Parent=game:GetService("CoreGui") end) end
	S.wmFrame=Instance.new("Frame")
	S.wmFrame.AnchorPoint=Vector2.new(1,0)
	S.wmFrame.Position=UDim2.new(1,-12,0,12)
	S.wmFrame.Size=UDim2.fromOffset(210,52)
	S.wmFrame.BackgroundColor3=Color3.fromRGB(11,9,18)
	S.wmFrame.BackgroundTransparency=0.25
	S.wmFrame.BorderSizePixel=0 S.wmFrame.ZIndex=10 S.wmFrame.Parent=S.infoGui
	addCorner(S.wmFrame,6)
	local w=Instance.new("UIStroke")
	w.Color=guiAccent() w.Thickness=1.2 w.Transparency=0.3 w.Parent=S.wmFrame
	registerRepaint(function() w.Color=guiAccent() end)
	S.wmLabel=Instance.new("TextLabel")
	S.wmLabel.Size=UDim2.new(1,-12,1,-4)
	S.wmLabel.Position=UDim2.fromOffset(6,2)
	S.wmLabel.BackgroundTransparency=1
	S.wmLabel.Font=Enum.Font.Code S.wmLabel.TextSize=11
	S.wmLabel.TextXAlignment=Enum.TextXAlignment.Left S.wmLabel.TextYAlignment=Enum.TextYAlignment.Top
	S.wmLabel.TextColor3=Color3.fromRGB(220,220,240)
	S.wmLabel.TextStrokeTransparency=0.4 S.wmLabel.TextStrokeColor3=Color3.new(0,0,0)
	S.wmLabel.Text=SCRIPT_NAME S.wmLabel.ZIndex=11 S.wmLabel.Parent=S.wmFrame
	S.kbFrame=Instance.new("Frame")
	S.kbFrame.AnchorPoint=Vector2.new(1,0)
	S.kbFrame.Position=UDim2.new(1,-12,0,72)
	S.kbFrame.Size=UDim2.fromOffset(210,100)
	S.kbFrame.BackgroundColor3=Color3.fromRGB(11,9,18)
	S.kbFrame.BackgroundTransparency=0.25
	S.kbFrame.BorderSizePixel=0 S.kbFrame.ZIndex=10 S.kbFrame.Parent=S.infoGui
	addCorner(S.kbFrame,6)
	local k=Instance.new("UIStroke")
	k.Color=guiAccent() k.Thickness=1.2 k.Transparency=0.3 k.Parent=S.kbFrame
	registerRepaint(function() k.Color=guiAccent() end)
	S.kbLabel=Instance.new("TextLabel")
	S.kbLabel.Size=UDim2.new(1,-12,1,-4)
	S.kbLabel.Position=UDim2.fromOffset(6,2)
	S.kbLabel.BackgroundTransparency=1
	S.kbLabel.Font=Enum.Font.Code S.kbLabel.TextSize=10
	S.kbLabel.TextXAlignment=Enum.TextXAlignment.Left S.kbLabel.TextYAlignment=Enum.TextYAlignment.Top
	S.kbLabel.TextColor3=Color3.fromRGB(200,200,220)
	S.kbLabel.TextStrokeTransparency=0.5 S.kbLabel.TextStrokeColor3=Color3.new(0,0,0)
	S.kbLabel.Text="[no features]" S.kbLabel.ZIndex=11 S.kbLabel.Parent=S.kbFrame
end
local function updateInfoVisibility()
	if not S.infoGui then return end
	if S.wmFrame then S.wmFrame.Visible=C.Watermark and true or false end
	if S.kbFrame then S.kbFrame.Visible=C.KeybindList and true or false end
end
local HIT_LIST={"76323709902827","132207921464999","72649558888714","84036894358514","103062305177426","79649041083405","73242877658272","121147456137931","105341857343164","116839849594540","96924216250322","85793691404836","86197206792061","104041807075625","114928327045353","135690448001690","103355259844069","128452090955120","71000246338579","125906547773381","107989020363293","85623602463927","87978085217719","112950478995075","94443309383954","81766558426599","90654171377736","72128148665361","94960826047243","114769224376981","92844369847738","106908462496291","109822392402606","119784367902126","89439896387299","132070051408308","131235569946744","123834203617100","98785078701251","103318207627541","99844967459345","101703309225906","97863204720378","137824029524579","87041753984253","81533666958052","79549040943367","81392013026663","77595339119545","75611037033634","123370871049938","106756593687295","128733894961951","137659772694747","93105538774923","129324788590686","134675465964672","85285032162865","125283605050829","93373403484012","108262048142532","106370995610424","114617637295467","115386570583557","70775136168849","72557176302052","94215646393565","73150160715773","7052329948932","9915750592076","85743982894847","82579449181823","114687917628569","9915750926076","99157505926076"}
local BAN_LIST={"84075526494569","112693580156198","116089915329773","123441836092792","76593886937703","71214385249268","91345240826151","107476375951001","97049872073368","73421886855742","140302976506103","108126144370302","115836393562566","102891247801142","73748962069265","88654124229687","12214474272195"}
local HIT_DELAY={["131235569946744"]=0.9,["114687917628569"]=3.4,["115386570583557"]=0.6,["70775136168849"]=0.7,["132207921464999"]=0.4}
local HIT,BAN={},{}
for i=1,#HIT_LIST do HIT[HIT_LIST[i]]=true S.animEnabled[HIT_LIST[i]]=true end
for i=1,#BAN_LIST do BAN[BAN_LIST[i]]=true S.animEnabled[BAN_LIST[i]]=false end
local SPECIAL_FORCE={["power hold"]=true,["powerhold"]=true,["power_hold"]=true,["pocket sand"]=true,["pocketsand"]=true,["pocket_sand"]=true,["sand"]=true}
local function isHit(id)
	if not id then return false end
	local n=tostring(id):match("%d+")
	if not n then return false end
	if BAN[n] then return false end
	if HIT[n] then return S.animEnabled[n]~=false end
	for k in pairs(HIT) do
		if S.animEnabled[k]~=false and not BAN[k] and (n:find(k,1,true) or k:find(n,1,true)) then return true end
	end
	return false
end
local function getToolRawName(char)
	if not char then return "" end
	for _,c in ipairs(char:GetChildren()) do if c:IsA("Tool") then return c.Name end end
	local hum=char:FindFirstChildOfClass("Humanoid")
	if hum then for _,c in ipairs(hum:GetChildren()) do if c:IsA("Tool") then return c.Name end end end
	local hw=char:GetAttribute("HoldingWeapon")
	if type(hw)=="string" and hw~="" then local t=char:FindFirstChild(hw) if t then return t.Name end return hw end
	return ""
end
local function isSpecialForce(char)
	if not char then return false end
	for _,c in ipairs(char:GetChildren()) do
		if c:IsA("Tool") then
			local n=string.lower(c.Name)
			for k in pairs(SPECIAL_FORCE) do if n:find(k,1,true) then return true end end
		end
	end
	return false
end
local function hasSandFx(char)
	if not char then return false end
	for _,d in ipairs(char:GetDescendants()) do
		if d:IsA("ParticleEmitter") or d:IsA("Smoke") then
			local n=string.lower(d.Name)
			if n:find("sand",1,true) or n:find("dust",1,true) or n:find("dirt",1,true) then
				if d.Enabled then return true end
			end
		end
	end
	return false
end
local function isDodgeTool(tool)
	if not tool or not tool:IsA("Tool") then return false end
	local n=string.lower(tool.Name)
	if n:find("ultra",1,true) or n:find("instinct",1,true) then return false end
	return n:find("dodge",1,true)~=nil
end
local KEYMAP={["1"]=0x31,["2"]=0x32,["3"]=0x33,["4"]=0x34,["5"]=0x35,["6"]=0x36,["7"]=0x37,["8"]=0x38,["9"]=0x39,["0"]=0x30,e=0x45,t=0x54,y=0x59,r=0x52,f=0x46,q=0x51,g=0x47,space=0x20}
local VALID={["1"]=1,["2"]=1,["3"]=1,["4"]=1,["5"]=1,["6"]=1,["7"]=1,["8"]=1,["9"]=1,["0"]=1,E=1,T=1,Y=1,Q=1,F=1,R=1,G=1}
local hasNativePress=(type(keypress)=="function" and type(keyrelease)=="function")
local function press(k)
	if S.unloaded then return end
	k=string.lower(tostring(k or "t"))
	local code=KEYMAP[k]
	if not code then return end
	local kc=Enum.KeyCode[string.upper(k)] or Enum.KeyCode.T
	local vimOK=pcall(function()
		local vim=game:GetService("VirtualInputManager")
		vim:SendKeyEvent(true,kc,false,game)
		task.delay(jitter(0.006,0.002),function() pcall(function() vim:SendKeyEvent(false,kc,false,game) end) end)
	end)
	if not vimOK and hasNativePress then
		pcall(function()
			keypress(code)
			task.delay(jitter(0.006,0.002),function() pcall(function() keyrelease(code) end) end)
		end)
	end
end
local function mouseClick()
	if S.unloaded then return end
	local cam=Workspace.CurrentCamera
	local vp=(cam and cam.ViewportSize) or Vector2.new(800,600)
	local cx=math.floor(vp.X/2)
	local cy=math.floor(vp.Y/2)
	local done=false
	pcall(function() if mouse1click then mouse1click() done=true end end)
	if done then return end
	pcall(function()
		if mouse1press and mouse1release then
			mouse1press() task.wait(0.03) mouse1release() done=true
		end
	end)
	if done then return end
	pcall(function()
		local vim=game:GetService("VirtualInputManager")
		vim:SendMouseButtonEvent(cx,cy,0,true,game,1)
		task.wait(0.03)
		vim:SendMouseButtonEvent(cx,cy,0,false,game,1)
	end)
end
local function inferSlotFor(toolObj,fallback,manual)
	if manual and manual~="" then
		local up=string.upper(tostring(manual))
		if VALID[up] then return up end
	end
	return fallback
end
local function isUIToolName(name)
	local n=string.lower(tostring(name or ""))
	return n:find("ultra",1,true)~=nil or n:find("instinct",1,true)~=nil
end
local function findUITool()
	local function scan(c)
		if not c then return nil end
		for _,cc in ipairs(c:GetChildren()) do if cc:IsA("Tool") and isUIToolName(cc.Name) then return cc end end
		return nil
	end
	return scan(LP.Character) or scan(LP:FindFirstChild("Backpack"))
end
local function findDodgeTool()
	local function scan(c)
		if not c then return nil end
		for _,cc in ipairs(c:GetChildren()) do if isDodgeTool(cc) then return cc end end
		return nil
	end
	return scan(LP.Character) or scan(LP:FindFirstChild("Backpack"))
end
local function fireUI()
	if S.unloaded or not C.Enabled then return end
	local now=tick()
	if now-S.lastDodgeUI<(C.MinInterval or 0.02) then return end
	S.lastDodgeUI=now
	local slot=S.cachedSlot or "T"
	local pre=C.Delay or 0
	if pre>0 then task.delay(pre,function() if not S.unloaded and C.Enabled then press(slot) end end)
	else press(slot) end
end
local function fireH()
	if S.unloaded or not H.Enabled then return end
	local now=tick()
	if now-S.lastDodgeH<(H.MinInterval or 0.02) then return end
	S.lastDodgeH=now
	local tool=S.cachedDodgeTool or findDodgeTool()
	local slot=S.cachedDodgeSlot or "1"
	local pre=H.Delay or 0
	local function doFire()
		if S.unloaded or not H.Enabled then return end
		local char=LP.Character
		local hum=char and char:FindFirstChildOfClass("Humanoid")
		if tool and hum then
			press(slot) task.wait(0.06)
			if tool.Parent~=char then pcall(function() hum:EquipTool(tool) end) task.wait(0.06) end
			pcall(function() tool:Activate() end)
			task.wait(0.02) mouseClick() task.wait(0.04) mouseClick()
		else
			press(slot) task.wait(0.05) mouseClick()
		end
	end
	if pre>0 then task.delay(pre,doFire) else doFire() end
end
local function inRange(my,hrp,distMax,extra)
	if not my or not hrp then return false end
	if hrp.Parent==LP.Character then return false end
	local dx=my.Position.X-hrp.Position.X
	local dz=my.Position.Z-hrp.Position.Z
	local dy=my.Position.Y-hrp.Position.Y
	if math.abs(dy)>7 then return false end
	local d2h=dx*dx+dz*dz
	local lim=(distMax or 18)+(extra or 0)
	if d2h>lim*lim then return false end
	return true,math.sqrt(d2h)
end
local function unhook()
	for _,c in pairs(S.hooks) do pcall(function() c:Disconnect() end) end
	table.clear(S.hooks)
end
local function anyOn() return C.Enabled or H.Enabled end
local function considerAttack(tr,hrp,force)
	if S.unloaded or not anyOn() then return end
	if not hrp or not hrp.Parent then return end
	local w=_G.__adWatchers[hrp]
	if not w then w={c=0} _G.__adWatchers[hrp]=w end
	if w.c>=3 then return end
	w.c=w.c+1
	local extra=force and 8 or 0
	local firedC=false
	local firedH=false
	local allowH=false
	if H.Enabled then
		if not H.HollyMode then allowH=true
		elseif force then allowH=true
		elseif tr and tr.Animation and isHit(tr.Animation.AnimationId) then allowH=true end
	end
	local animDelay=0
	if tr and tr.Animation and not force then
		local aid=tostring(tr.Animation.AnimationId):match("%d+")
		if aid and HIT_DELAY[aid] then animDelay=HIT_DELAY[aid] end
	end
	local animLen=0
	if tr then
		local ok,l=pcall(function() return tr.Length end)
		if ok and tonumber(l) and l>0 then animLen=l end
	end
	if not C.Enabled then firedC=true end
	if not H.Enabled or not allowH then firedH=true end
	if firedC and firedH then
		w.c=w.c-1
		if w.c<=0 then _G.__adWatchers[hrp]=nil end
		return
	end
	local t0=tick()
	local baseC=math.max(C.AnimWatch or 0.4,animLen+(C.WatchAfter or 0.3))
	local baseH=math.max(H.AnimWatch or 0.4,animLen+(H.WatchAfter or 0.3))
	local maxWatch=math.max(baseC+animDelay,baseH+animDelay)
	local conn
	local function finish()
		if conn then pcall(function() conn:Disconnect() end) conn=nil end
		w.c=w.c-1
		if w.c<=0 then _G.__adWatchers[hrp]=nil end
	end
	local function check()
		if S.unloaded or (firedC and firedH) then finish() return end
		if tick()-t0>maxWatch then finish() return end
		local my=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not my or not hrp or not hrp.Parent then finish() return end
		local el=tick()-t0
		local distC=C.Distance or 18
		local distH=H.Distance or 18
		local v=hrp.AssemblyLinearVelocity
		local spd=math.sqrt(v.X*v.X+v.Z*v.Z)
		if spd>15 then
			local dx=my.Position.X-hrp.Position.X
			local dz=my.Position.Z-hrp.Position.Z
			local dist=math.sqrt(dx*dx+dz*dz)
			if dist>0.5 then
				local dot=(v.X*dx+v.Z*dz)/(dist*spd)
				if dot>0.5 then
					local reach=spd*0.2
					distC=distC+reach
					distH=distH+reach
				end
			end
		end
		if C.Enabled and not firedC and el>=animDelay then
			if inRange(my,hrp,distC,extra) then firedC=true fireUI() end
		end
		if H.Enabled and allowH and not firedH and el>=animDelay then
			if inRange(my,hrp,distH,extra) then firedH=true fireH() end
		end
		if firedC and firedH then finish() end
	end
	conn=RunService.Heartbeat:Connect(check)
end
local function hookTool(tool,hrp)
	if not tool or S.hooks[tool] then return end
	S.hooks[tool]=tool.Activated:Connect(function()
		if S.unloaded or not anyOn() then return end
		if isSpecialForce(hrp.Parent) then considerAttack(nil,hrp,true) end
	end)
end
local function hookAnim(an,hrp)
	if S.hooks[an] or S.unloaded then return end
	S.hooks[an]=an.AnimationPlayed:Connect(function(tr)
		if S.unloaded or not anyOn() then return end
		if not tr or not tr.Animation then return end
		if hrp.Parent==LP.Character then return end
		local aid=tostring(tr.Animation.AnimationId):match("%d+")
		if aid and BAN[aid] then return end
		if isHit(tr.Animation.AnimationId) then considerAttack(tr,hrp,false) return end
		local char=hrp.Parent
		if isSpecialForce(char) and hasSandFx(char) then considerAttack(tr,hrp,true) end
	end)
end
local function hookChar(char)
	if S.unloaded or not char or char==LP.Character then return end
	local hum=char:FindFirstChildOfClass("Humanoid")
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return end
	local an=hum:FindFirstChildOfClass("Animator")
	if an then hookAnim(an,hrp)
	else
		local c
		c=hum.ChildAdded:Connect(function(ch)
			if ch:IsA("Animator") then hookAnim(ch,hrp) pcall(function() c:Disconnect() end) end
		end)
		table.insert(S.hooks,c)
	end
	for _,t in ipairs(char:GetChildren()) do if t:IsA("Tool") then hookTool(t,hrp) end end
	local ac
	ac=char.ChildAdded:Connect(function(ch) if ch:IsA("Tool") then hookTool(ch,hrp) end end)
	table.insert(S.hooks,ac)
end
local function startHooks()
	if S.unloaded then return end
	unhook()
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr~=LP then
			if plr.Character then hookChar(plr.Character) end
			if not S.added[plr] then
				S.added[plr]=plr.CharacterAdded:Connect(function(ch)
					if anyOn() and not S.unloaded then task.wait(0.15) hookChar(ch) end
				end)
			end
		end
	end
	if not S.added._j then
		S.added._j=Players.PlayerAdded:Connect(function(plr)
			if S.unloaded then return end
			S.added[plr]=plr.CharacterAdded:Connect(function(ch)
				if anyOn() and not S.unloaded then task.wait(0.15) hookChar(ch) end
			end)
		end)
	end
	if not S.added._r then
		S.added._r=Players.PlayerRemoving:Connect(function(plr)
			if S.added[plr] then pcall(function() S.added[plr]:Disconnect() end) S.added[plr]=nil end
		end)
	end
end
local function syncHooks() if anyOn() then startHooks() else unhook() end end
local function getRandomBodyPart(char)
	if not char then return nil end
	local parts={}
	local function tryAdd(list)
		for _,n in ipairs(list) do
			local p=findBodyPart(char,n)
			if p then table.insert(parts,p) return end
		end
	end
	if C.RebelBodyHead then tryAdd({"Head"}) end
	if C.RebelBodyTorso then tryAdd({"Torso","UpperTorso","LowerTorso"}) end
	if C.RebelBodyHRP then tryAdd({"HumanoidRootPart"}) end
	if C.RebelBodyLeftArm then tryAdd({"Left Arm","LeftUpperArm","LeftLowerArm"}) end
	if C.RebelBodyRightArm then tryAdd({"Right Arm","RightUpperArm","RightLowerArm"}) end
	if C.RebelBodyLeftLeg then tryAdd({"Left Leg","LeftUpperLeg","LeftLowerLeg"}) end
	if C.RebelBodyRightLeg then tryAdd({"Right Leg","RightUpperLeg","RightLowerLeg"}) end
	if #parts==0 then return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") end
	return parts[math.random(1,#parts)]
end
local function isPartInFOV(part)
	if not part then return false end
	if (C.RebelFOV or 0)<=0 then return true end
	local cam=Workspace.CurrentCamera
	if not cam then return false end
	local sp,onScreen=cam:WorldToViewportPoint(part.Position)
	if not onScreen then return false end
	local cx=cam.ViewportSize.X/2
	local cy=cam.ViewportSize.Y/2
	local dx=sp.X-cx
	local dy=sp.Y-cy
	return math.sqrt(dx*dx+dy*dy)<=C.RebelFOV
end
local function isCharValidTarget(char)
	if not char or char==LP.Character or not char.Parent then return false end
	if not char:IsA("Model") then return false end
	local hum=char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health<=0 then return false end
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	local iAmGuard=LP:GetAttribute("IsGuard")==true
	local targetPlayer=Players:GetPlayerFromCharacter(char)
	if iAmGuard then
		local ck=char:FindFirstChild("GuardCanKill") or hrp:FindFirstChild("GuardCanKillLockOn") or hrp:FindFirstChild("GuardCanKillLockOut")
		if ck then return true end
		if C.RebelTargetPlayers and targetPlayer and targetPlayer~=LP and targetPlayer:GetAttribute("IsGuard")~=true then return true end
	else
		if C.RebelTargetPlayers and targetPlayer and targetPlayer~=LP and targetPlayer:GetAttribute("IsGuard")==true then return true end
		if C.RebelTargetNPCs then
			if char.Name:match("Guard") then return true end
			if char:FindFirstChild("TypeOfGuard") then return true end
			local ck=char:FindFirstChild("GuardCanKill") or hrp:FindFirstChild("GuardCanKillLockOut") or hrp:FindFirstChild("GuardCanKillLockOn")
			if ck then return true end
		end
	end
	return false
end
local function findSilentAimTarget(_firePosition)
	local cam=Workspace.CurrentCamera
	if not cam then return nil end
	local cx=cam.ViewportSize.X/2
	local cy=cam.ViewportSize.Y/2
	local bestPart,bestDist=nil,math.huge
	local seen={}
	local function consider(char)
		if not char or seen[char] then return end
		seen[char]=true
		if not isCharValidTarget(char) then return end
		local part=getRandomBodyPart(char)
		if not part or not isPartInFOV(part) then return end
		local sp,onScreen=cam:WorldToViewportPoint(part.Position)
		if not onScreen then return end
		local dx=sp.X-cx
		local dy=sp.Y-cy
		local d=math.sqrt(dx*dx+dy*dy)
		if d<bestDist then bestDist=d bestPart=part end
	end
	local live=Workspace:FindFirstChild("Live")
	if live then for _,ch in ipairs(live:GetChildren()) do if ch:IsA("Model") then consider(ch) end end end
	local chars=Workspace:FindFirstChild("Characters")
	if chars then for _,ch in ipairs(chars:GetChildren()) do if ch:IsA("Model") then consider(ch) end end end
	for _,plr in ipairs(Players:GetPlayers()) do if plr~=LP and plr.Character then consider(plr.Character) end end
	return bestPart
end
local function hookCombat()
	if S.combatHooked then return end
	local rs=ReplicatedStorage
	local modules=rs:FindFirstChild("Modules")
	if not modules then pcall(function() modules=rs:WaitForChild("Modules",2) end) end
	if not modules then return end
	local gf=modules:FindFirstChild("GunFunctions")
	if not gf then pcall(function() gf=modules:WaitForChild("GunFunctions",2) end) end
	if not gf then return end
	local ok,mod=pcall(require,gf)
	if not ok or not mod or type(mod)~="table" then return end
	S.gunMod=mod
	S.origFiredGun=mod.FiredGun
	S.origGetBuffs=mod.GetBuffs
	if type(S.origFiredGun)=="function" then
		mod.FiredGun=function(arg,arg2,arg3,...)
			if S.unloaded or not C.RebelSilentAim then return S.origFiredGun(arg,arg2,arg3,...) end
			if arg~=LP.Character then return S.origFiredGun(arg,arg2,arg3,...) end
			arg3=arg3 or {}
			local h=arg and arg:FindFirstChild("HumanoidRootPart")
			if not h then return S.origFiredGun(arg,arg2,arg3,...) end
			local firePos=h.Position
			pcall(function()
				local attr=arg:GetAttribute("HoldingWeapon")
				if attr then
					local w=arg:FindFirstChild(attr)
					if w then
						local ff=w:FindFirstChild("FireFrom")
						if ff then firePos=ff.Position end
					end
				end
			end)
			local target=findSilentAimTarget(firePos)
			if target then
				arg2=target.Position
				arg3.CustomFireFrom=true
				arg3.spread=0
			end
			return S.origFiredGun(arg,arg2,arg3,...)
		end
	end
	if type(S.origGetBuffs)=="function" then
		mod.GetBuffs=function(...)
			local data=S.origGetBuffs(...)
			if type(data)~="table" then data={} end
			local cp={}
			for k,v in pairs(data) do cp[k]=v end
			if C.RebelNoRecoil then cp.RecoilDiv=999999 end
			if C.RebelRapidFire then cp.FireRateMult=tonumber(C.RebelRapidFireMult) or 2 end
			return cp
		end
	end
	S.combatHooked=true
end
local function unhookCombat()
	if not S.combatHooked or not S.gunMod then return end
	pcall(function()
		if S.origFiredGun then S.gunMod.FiredGun=S.origFiredGun end
		if S.origGetBuffs then S.gunMod.GetBuffs=S.origGetBuffs end
	end)
	S.combatHooked=false
end

-- ============== AIMBOT ==============
local function aimbotFindTarget()
	local cam=Workspace.CurrentCamera
	if not cam then return nil end
	local cx=cam.ViewportSize.X/2
	local cy=cam.ViewportSize.Y/2
	local fov=C.RebelFOV or 250
	local bestPart,bestDist=nil,math.huge
	local seen={}
	local function consider(char)
		if not char or seen[char] then return end
		seen[char]=true
		if not isCharValidTarget(char) then return end
		if not C.RebelAimbotTargetGuards then
			local hrp=char:FindFirstChild("HumanoidRootPart")
			local targetPlayer=Players:GetPlayerFromCharacter(char)
			local isGuardNpc=false
			if not targetPlayer then
				if char.Name:match("Guard") or char:FindFirstChild("TypeOfGuard") then isGuardNpc=true end
				if hrp and (hrp:FindFirstChild("GuardCanKillLockOut") or hrp:FindFirstChild("GuardCanKillLockOn")) then isGuardNpc=true end
			end
			if isGuardNpc then return end
		end
		local part=getRandomBodyPart(char)
		if not part then return end
		local sp,onScreen=cam:WorldToViewportPoint(part.Position)
		if not onScreen then return end
		local dx=sp.X-cx local dy=sp.Y-cy
		local d=math.sqrt(dx*dx+dy*dy)
		if d<=fov and d<bestDist then bestDist=d bestPart=part end
	end
	local live=Workspace:FindFirstChild("Live")
	if live then for _,ch in ipairs(live:GetChildren()) do if ch:IsA("Model") then consider(ch) end end end
	local chars=Workspace:FindFirstChild("Characters")
	if chars then for _,ch in ipairs(chars:GetChildren()) do if ch:IsA("Model") then consider(ch) end end end
	for _,plr in ipairs(Players:GetPlayers()) do if plr~=LP and plr.Character then consider(plr.Character) end end
	return bestPart
end
local function startAimbot()
	if S.aimbotConn then pcall(function() S.aimbotConn:Disconnect() end) S.aimbotConn=nil end
	S.aimbotConn=RunService.RenderStepped:Connect(function()
		if S.unloaded or not C.RebelAimbot then return end
		local cam=Workspace.CurrentCamera
		if not cam then return end
		if C.RebelAimbotHoldKey then
			if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
		end
		local part=aimbotFindTarget()
		if not part or not part.Parent then return end
		local camPos=cam.CFrame.Position
		local wantCF=CFrame.new(camPos,part.Position)
		local sm=tonumber(C.RebelAimbotSmooth) or 1.0
		if sm<=0.05 then
			cam.CFrame=wantCF
		else
			local alpha=math.clamp(1/sm*0.4,0.02,1)
			cam.CFrame=cam.CFrame:Lerp(wantCF,alpha)
		end
	end)
end
local function stopAimbot()
	if S.aimbotConn then pcall(function() S.aimbotConn:Disconnect() end) S.aimbotConn=nil end
end

-- ============== HITBOX EXPANDER ==============
local HB_expanded={}
local HB_visuals={}
local function HB_restore(char)
	local d=HB_expanded[char]
	if d then
		for part,orig in pairs(d.parts) do
			if part and part.Parent then
				pcall(function() part.Size=orig end)
			end
		end
		HB_expanded[char]=nil
	end
	local v=HB_visuals[char]
	if v then
		if v.box then pcall(function() v.box:Destroy() end) end
		HB_visuals[char]=nil
	end
end
local function HB_restoreAll()
	for char in pairs(HB_expanded) do HB_restore(char) end
	for char in pairs(HB_visuals) do HB_restore(char) end
end
local function HB_expand(char,mult)
	local d=HB_expanded[char]
	if not d then
		d={parts={}}
		HB_expanded[char]=d
	end
	for _,part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") and part.Name~="HumanoidRootPart" then
			if not d.parts[part] then
				d.parts[part]=part.Size
			end
			local o=d.parts[part]
			pcall(function()
				part.Size=Vector3.new(o.X*mult,o.Y*mult,o.Z*mult)
			end)
		end
	end
end
local function HB_makeVisual(char)
	if not HB_visuals[char] then
		HB_visuals[char]={}
	end
end

task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if not C.HitboxExpander then
				if next(HB_expanded) or next(HB_visuals) then HB_restoreAll() end
			else
				local myHrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
				local myPos=myHrp and myHrp.Position or Vector3.zero
				local maxD=tonumber(C.HitboxDistance) or 500
				local mult=tonumber(C.HitboxSize) or 3
				local mode=C.HitboxTargets or "All"
				local seen={}
				local function process(char)
					if seen[char] then return end
					seen[char]=true
					local hum=char:FindFirstChildOfClass("Humanoid")
					local hrp=char:FindFirstChild("HumanoidRootPart")
					if not hum or hum.Health<=0 or not hrp then
						HB_restore(char) return
					end
					local plr=Players:GetPlayerFromCharacter(char)
					local isGuard=plr and plr:GetAttribute("IsGuard")==true
					local ok=true
					if mode=="Guards" and not isGuard then ok=false end
					if mode=="Players" and isGuard then ok=false end
					if not ok then HB_restore(char) return end
					local d=(myPos-hrp.Position).Magnitude
					if maxD>0 and d>maxD then HB_restore(char) return end
					HB_expand(char,mult)
					HB_makeVisual(char)
				end
				for _,plr in ipairs(Players:GetPlayers()) do
					if plr~=LP and plr.Character then process(plr.Character) end
				end
				for _,fname in ipairs({"Live","Characters"}) do
					local f=Workspace:FindFirstChild(fname)
					if f then
						for _,ch in ipairs(f:GetChildren()) do
							if ch:IsA("Model") then process(ch) end
						end
					end
				end
				for char in pairs(HB_expanded) do
					if not seen[char] or not char.Parent then HB_restore(char) end
				end
				for char in pairs(HB_visuals) do
					if not seen[char] or not char.Parent then HB_restore(char) end
				end
			end
		end)
		task.wait(0.1)
	end
end)

task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.HitboxVisualize then
				for char,v in pairs(HB_visuals) do
					if char.Parent then
						local hrp=char:FindFirstChild("HumanoidRootPart")
						if hrp then
							local mn=Vector3.new(math.huge,math.huge,math.huge)
							local mx=Vector3.new(-math.huge,-math.huge,-math.huge)
							local any=false
							for _,part in ipairs(char:GetDescendants()) do
								if part:IsA("BasePart") then
									any=true
									local p=part.Position
									local s=part.Size*0.5
									mn=Vector3.new(math.min(mn.X,p.X-s.X),math.min(mn.Y,p.Y-s.Y),math.min(mn.Z,p.Z-s.Z))
									mx=Vector3.new(math.max(mx.X,p.X+s.X),math.max(mx.Y,p.Y+s.Y),math.max(mx.Z,p.Z+s.Z))
								end
							end
							if any then
								local center=(mn+mx)*0.5
								local size=mx-mn
								if not v.box or not v.box.Parent then
									local box=Instance.new("Part")
									box.Name="_XD_HB_Vis"
									box.Anchored=true
									box.CanCollide=false
									box.CanQuery=false
									box.CanTouch=false
									box.CastShadow=false
									box.Material=Enum.Material.ForceField
									box.Color=Color3.fromRGB(C.HitboxColorR or 255,C.HitboxColorG or 80,C.HitboxColorB or 80)
									box.Transparency=C.HitboxTransparency or 0.85
									box.Size=size
									box.CFrame=CFrame.new(center)
									box.Parent=workspace
									v.box=box
								else
									v.box.Size=size
									v.box.CFrame=CFrame.new(center)
									v.box.Color=Color3.fromRGB(C.HitboxColorR or 255,C.HitboxColorG or 80,C.HitboxColorB or 80)
									v.box.Transparency=C.HitboxTransparency or 0.85
								end
							end
						end
					else
						if v.box then pcall(function() v.box:Destroy() end) v.box=nil end
						HB_visuals[char]=nil
					end
				end
			else
				for char,v in pairs(HB_visuals) do
					if v.box then pcall(function() v.box:Destroy() end) v.box=nil end
					HB_visuals[char]=nil
				end
			end
		end)
		RunService.RenderStepped:Wait()
	end
end)

-- ============== AUTO BREW CYCLE (v5.3 native-first) ==============
local function doBrewCycle()
	if S.unloaded or not C.AutoBrew then return end
	local slot=string.lower(tostring(C.AutoBrewSlot or "e"))
	-- 1. старт варки
	press(slot)
	task.wait(0.2)
	-- 2. ждём brew delay (пока сбросится напиток)
	local brewDelay=tonumber(C.AutoBrewBrewDelay) or 3.0
	if brewDelay>0 then task.wait(brewDelay) end
	local dc=tonumber(C.AutoBrewDelayCollect) or 0
	if dc>0 then task.wait(dc) end
	-- 3. подбор — native keypress ПЕРВЫМ (не палится)
	local holdTime=tonumber(C.AutoBrewCollectHold) or 2.0
	local code=KEYMAP[slot]
	if hasNativePress and code then
		pcall(function()
			keypress(code)
			task.wait(holdTime)
			keyrelease(code)
		end)
	else
		pcall(function()
			local vim=game:GetService("VirtualInputManager")
			local kc=Enum.KeyCode[string.upper(slot)] or Enum.KeyCode.E
			vim:SendKeyEvent(true,kc,false,game)
			task.wait(holdTime)
			vim:SendKeyEvent(false,kc,false,game)
		end)
	end
end
local function startBrewLoop()
	if S.brewLoopConn then return end
	S.lastBrewTick=tick()
	S.brewLoopConn=task.spawn(function()
		while not S.unloaded and C.AutoBrew do
			local interval=tonumber(C.AutoBrewInterval) or 60
			if tick()-S.lastBrewTick>=interval then
				S.lastBrewTick=tick()
				pcall(doBrewCycle)
			end
			task.wait(0.5)
		end
	end)
end
local function stopBrewLoop()
	if S.brewLoopConn then
		pcall(function() task.cancel(S.brewLoopConn) end)
		S.brewLoopConn=nil
	end
end

-- ============== INFINITE AMMO ==============
local function applyInfiniteAmmo(st)
	C.InfiniteAmmo=st and true or false
	if not C.InfiniteAmmo then return end
	local function ammoHook()
		local char=LP.Character
		if not char then return end
		for _,tool in ipairs(char:GetChildren()) do
			if tool:IsA("Tool") then
				for _,child in ipairs(tool:GetDescendants()) do
					if child:IsA("NumberValue") or child:IsA("IntValue") then
						local n=child.Name:lower()
						if n:find("ammo") or n:find("clip") or n:find("mag") or n:find("bullet") then
							child.Value=C.InfiniteAmmoValue or 999
						end
					end
				end
				pcall(function()
					for k,v in pairs(tool:GetAttributes()) do
						local k2=tostring(k):lower()
						if type(v)=="number" and (k2:find("ammo") or k2:find("clip") or k2:find("mag")) then
							tool:SetAttribute(k,C.InfiniteAmmoValue or 999)
						end
					end
				end)
			end
		end
	end
	if S.infiniteAmmoLoop then pcall(function() task.cancel(S.infiniteAmmoLoop) end) end
	S.infiniteAmmoLoop=task.spawn(function()
		while not S.unloaded and C.InfiniteAmmo do
			pcall(ammoHook)
			RunService.Heartbeat:Wait()
		end
	end)
end
-- ============== FOV CIRCLE ==============
local function destroyFOVCircle()
	if S.fovGui then pcall(function() S.fovGui:Destroy() end) end
	S.fovGui=nil S.fovFrame=nil S.fovStroke=nil
end
local function stopFovRainbow() if S.fovRainbowConn then pcall(function() S.fovRainbowConn:Disconnect() end) S.fovRainbowConn=nil end end
local function clearFusionGradient()
	if not S.fovFrame then return end
	for _,ch in ipairs(S.fovFrame:GetChildren()) do
		if ch:IsA("Frame") then
			for _,st in ipairs(ch:GetChildren()) do
				if st:IsA("UIStroke") then
					local g=st:FindFirstChildOfClass("UIGradient")
					if g then g:Destroy() end
				end
			end
		end
	end
	if S.fovStroke then
		local g=S.fovStroke:FindFirstChildOfClass("UIGradient")
		if g then g:Destroy() end
	end
end
local function applyFusionGradient(c1,c2,c3,c4,c5,rot)
	local c6=customFOVColor(1)
	local c7=customFOVColor(2)
	local c8=customFOVColor(3)
	local c9=customFOVColor(4)
	local seq=ColorSequence.new({
		ColorSequenceKeypoint.new(0, c1),
		ColorSequenceKeypoint.new(0.11, c2),
		ColorSequenceKeypoint.new(0.22, c3),
		ColorSequenceKeypoint.new(0.33, c4),
		ColorSequenceKeypoint.new(0.44, c5),
		ColorSequenceKeypoint.new(0.55, c6),
		ColorSequenceKeypoint.new(0.66, c7),
		ColorSequenceKeypoint.new(0.77, c8),
		ColorSequenceKeypoint.new(0.88, c9),
		ColorSequenceKeypoint.new(1, c1),
	})
	for _,ch in ipairs(S.fovFrame:GetChildren()) do
		if ch:IsA("Frame") and ch.Name~="BlackOuter" and ch.Name~="BlackInner" then
			for _,st in ipairs(ch:GetChildren()) do
				if st:IsA("UIStroke") and st.Name~="BlackStrokeOuter" and st.Name~="BlackStrokeInner" and st.Name~="InnerStroke" then
					local g=st:FindFirstChildOfClass("UIGradient")
					if not g then g=Instance.new("UIGradient") g.Parent=st end
					g.Color=seq g.Rotation=rot
				end
			end
		end
	end
	if S.fovStroke then
		local g=S.fovStroke:FindFirstChildOfClass("UIGradient")
		if not g then g=Instance.new("UIGradient") g.Parent=S.fovStroke end
		g.Color=seq g.Rotation=rot
	end
end
local function startFovRainbow()
	stopFovRainbow()
	S.fovRainbowConn=RunService.RenderStepped:Connect(function()
		if S.unloaded or not C.FOVRainbow then return end
		if not S.fovFrame or not S.fovFrame.Parent then return end
		local t=tick()
		local m=C.FOVRainbowMode or 1
		local useCustom=C.FOVUseCustom
		local sp=tonumber(C.RebelFOVBlendSpeed) or 0.5
		if m~=6 then clearFusionGradient() end
		if m==6 then
			local c1=customFOVColor(5)
			local c2=customFOVColor(6)
			local c3=customFOVColor(7)
			local c4=customFOVColor(8)
			local c5=customFOVColor(9)
			applyFusionGradient(c1,c2,c3,c4,c5,(t*sp*60)%360)
			return
		end
		local col
		if m==1 then
			if useCustom then
				local a=customFOVColor(1) local b=customFOVColor(2)
				col=a:Lerp(b,0.5+0.5*math.sin(t*sp*2))
			else col=Color3.fromHSV((t*0.35)%1,1,1) end
		elseif m==2 then
			if useCustom then
				local a=customFOVColor(1) local b=customFOVColor(2)
				col=a:Lerp(b,0.5+0.5*math.sin(t*sp*3))
			else col=Color3.fromHSV((t*0.2)%1,1,0.7+0.3*math.sin(t*3)) end
		elseif m==3 then
			if useCustom then
				local a=customFOVColor(1) local b=customFOVColor(2) local c2=customFOVColor(3)
				local mix=0.5+0.5*math.sin(t*sp*1.8)
				local mix2=0.5+0.5*math.sin(t*sp*2.6+1.7)
				col=a:Lerp(b,mix):Lerp(c2,mix2*0.5)
			else
				local a=Color3.fromHSV((t*0.4)%1,1,1) local b=Color3.fromHSV((t*0.4+0.5)%1,1,1)
				col=a:Lerp(b,0.5+0.5*math.sin(t*2.2))
			end
		elseif m==4 then
			if useCustom then
				local a=customFOVColor(1) local b=customFOVColor(2)
				col=a:Lerp(b,0.5+0.5*math.sin(t*sp*3.5))
			else col=Color3.fromHSV((t*0.15)%1,0.9,0.55+0.45*(0.5+0.5*math.sin(t*3.5))) end
		elseif m==5 then
			if useCustom then
				local a=customFOVColor(1) local b=customFOVColor(2) local c2=customFOVColor(3) local d=customFOVColor(4)
				local mix=0.5+0.5*math.sin(t*sp*1.6)
				local mix2=0.5+0.5*math.sin(t*sp*2.3+1.7)
				col=a:Lerp(b,mix):Lerp(c2,mix2*0.4):Lerp(d,mix*0.3)
			else
				local a=Color3.fromHSV((t*0.25)%1,1,1) local b=Color3.fromHSV((t*0.25+0.5)%1,1,1) local c2=Color3.fromHSV((t*0.25+0.75)%1,0.9,1)
				local mix=0.5+0.5*math.sin(t*1.6)
				local mix2=0.5+0.5*math.sin(t*2.3+1.7)
				col=a:Lerp(b,mix):Lerp(c2,mix2*0.4)
			end
		end
		if col then
			for _,ch in ipairs(S.fovFrame:GetChildren()) do
				if ch:IsA("Frame") then
					for _,st in ipairs(ch:GetChildren()) do
						if st:IsA("UIStroke") and st.Name~="BlackStrokeOuter" and st.Name~="BlackStrokeInner" then
							st.Color=col
						end
					end
				end
			end
			if S.fovStroke then S.fovStroke.Color=col end
		end
	end)
end
local function stopPanelRainbow() if S.panelRainbowConn then pcall(function() S.panelRainbowConn:Disconnect() end) S.panelRainbowConn=nil end end
local function startPanelRainbow()
	stopPanelRainbow()
	S.panelRainbowConn=RunService.RenderStepped:Connect(function()
		if S.unloaded or not C.PanelRainbow then return end
		if not S.panel or not S.panel.Parent then return end
		local col=Color3.fromHSV((tick()*0.15)%1,1,1)
		local st=S.panel:FindFirstChildOfClass("UIStroke")
		if st then st.Color=col end
	end)
end
local function makeFOVCircle()
	destroyFOVCircle()
	if not C.RebelFOVCircle then return end
	local parent=nil
	if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then parent=h end end
	if not parent then parent=LP:FindFirstChildOfClass("PlayerGui") end
	if not parent then parent=game:GetService("CoreGui") end
	S.fovGui=Instance.new("ScreenGui")
	S.fovGui.Name="XD_FOV_"..randStr(6)
	S.fovGui.IgnoreGuiInset=true S.fovGui.ResetOnSpawn=false S.fovGui.DisplayOrder=99998
	pcall(function() S.fovGui.Parent=parent end)
	if not S.fovGui.Parent then pcall(function() S.fovGui.Parent=game:GetService("CoreGui") end) end
	local d=math.max(4,(C.RebelFOV or 150)*2)
	local radius=math.floor(d/2)
	local ot=C.RebelFOV_OutlineThickness or 5
	S.fovFrame=Instance.new("Frame")
	S.fovFrame.BackgroundTransparency=1
	S.fovFrame.AnchorPoint=Vector2.new(0.5,0.5)
	S.fovFrame.Position=UDim2.new(0.5,0,0.5,0)
	S.fovFrame.Size=UDim2.fromOffset(d,d)
	S.fovFrame.ZIndex=1000 S.fovFrame.Parent=S.fovGui
	addCorner(S.fovFrame,radius)
	if C.RebelFOVBlackOutline then
		local bo=Instance.new("Frame")
		bo.Name="BlackOuter" bo.BackgroundTransparency=1 bo.Size=UDim2.fromScale(1,1)
		bo.AnchorPoint=Vector2.new(0.5,0.5) bo.Position=UDim2.fromScale(0.5,0.5)
		bo.ZIndex=996 bo.Parent=S.fovFrame
		addCorner(bo,radius)
		local bs=Instance.new("UIStroke")
		bs.Name="BlackStrokeOuter" bs.Color=rebelOutlineColor() bs.Thickness=ot
		bs.Transparency=0 bs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border bs.Parent=bo
		local bi=Instance.new("Frame")
		bi.Name="BlackInner" bi.BackgroundTransparency=1
		bi.Size=UDim2.new(1,-(ot+3),1,-(ot+3))
		bi.AnchorPoint=Vector2.new(0.5,0.5) bi.Position=UDim2.fromScale(0.5,0.5)
		bi.ZIndex=996 bi.Parent=S.fovFrame
		addCorner(bi,radius)
		local bs2=Instance.new("UIStroke")
		bs2.Name="BlackStrokeInner" bs2.Color=rebelOutlineColor() bs2.Thickness=math.max(1,ot-2)
		bs2.Transparency=0 bs2.ApplyStrokeMode=Enum.ApplyStrokeMode.Border bs2.Parent=bi
	end
	if C.RebelFOVNeon then
		local g1=Instance.new("Frame")
		g1.Name="Glow1" g1.BackgroundTransparency=1 g1.Size=UDim2.fromScale(1,1)
		g1.AnchorPoint=Vector2.new(0.5,0.5) g1.Position=UDim2.fromScale(0.5,0.5)
		g1.ZIndex=999 g1.Parent=S.fovFrame
		addCorner(g1,radius)
		local g1s=Instance.new("UIStroke")
		g1s.Color=rebelFOVColor() g1s.Thickness=14 g1s.Transparency=0.82 g1s.Parent=g1
		local g2=Instance.new("Frame")
		g2.Name="Glow2" g2.BackgroundTransparency=1 g2.Size=UDim2.fromScale(1,1)
		g2.AnchorPoint=Vector2.new(0.5,0.5) g2.Position=UDim2.fromScale(0.5,0.5)
		g2.ZIndex=999 g2.Parent=S.fovFrame
		addCorner(g2,radius)
		local g2s=Instance.new("UIStroke")
		g2s.Color=rebelFOVColor() g2s.Thickness=6 g2s.Transparency=0.55 g2s.Parent=g2
	end
	S.fovStroke=Instance.new("UIStroke")
	S.fovStroke.Color=Color3.new(1,1,1)
	local baseW=tonumber(C.RebelFOVCircleWidth) or 1.6
	if C.FOVRainbow and (C.FOVRainbowMode or 1)==6 then baseW=baseW*2.5 end
	S.fovStroke.Thickness=baseW
	S.fovStroke.Transparency=0
	S.fovStroke.Parent=S.fovFrame
	local inr=Instance.new("Frame")
	inr.Name="Inner" inr.BackgroundTransparency=1 inr.Size=UDim2.fromScale(1,1)
	inr.AnchorPoint=Vector2.new(0.5,0.5) inr.Position=UDim2.fromScale(0.5,0.5)
	inr.ZIndex=1001 inr.Parent=S.fovFrame
	addCorner(inr,radius)
	local is=Instance.new("UIStroke")
	is.Name="InnerStroke" is.Color=rebelFOVColor() is.Thickness=1.2 is.Transparency=0.15 is.Parent=inr
	if C.FOVRainbow then startFovRainbow() end
end
local function refreshFOVCircle()
	if not S.fovFrame then return end
	local d=math.max(4,(C.RebelFOV or 150)*2)
	local radius=math.floor(d/2)
	local ot=C.RebelFOV_OutlineThickness or 5
	S.fovFrame.Size=UDim2.fromOffset(d,d)
	local c=S.fovFrame:FindFirstChildOfClass("UICorner")
	if c then c.CornerRadius=UDim.new(0,radius) end
	for _,ch in ipairs(S.fovFrame:GetChildren()) do
		if ch:IsA("Frame") then
			local cc=ch:FindFirstChildOfClass("UICorner")
			if cc then cc.CornerRadius=UDim.new(0,radius) end
			if ch.Name=="BlackInner" then ch.Size=UDim2.new(1,-(ot+3),1,-(ot+3)) end
			for _,st in ipairs(ch:GetChildren()) do
				if st:IsA("UIStroke") then
					if st.Name=="BlackStrokeOuter" then st.Color=rebelOutlineColor() st.Thickness=ot st.Transparency=0
					elseif st.Name=="BlackStrokeInner" then st.Color=rebelOutlineColor() st.Thickness=math.max(1,ot-2) st.Transparency=0
					elseif st.Parent and st.Parent.Name=="Glow1" then st.Color=rebelFOVColor() st.Transparency=0.82
					elseif st.Parent and st.Parent.Name=="Glow2" then st.Color=rebelFOVColor() st.Transparency=0.55
					elseif st.Name=="InnerStroke" then st.Color=rebelFOVColor() st.Transparency=0.15 end
				end
			end
		end
	end
	if S.fovStroke then
		local baseW=tonumber(C.RebelFOVCircleWidth) or 1.6
		if C.FOVRainbow and (C.FOVRainbowMode or 1)==6 then baseW=baseW*2.5 end
		S.fovStroke.Thickness=baseW
	end
end
local uiDisc,hnsDisc,vizConn
local function destroyViz()
	if vizConn then pcall(function() vizConn:Disconnect() end) vizConn=nil end
	if uiDisc then pcall(function() uiDisc:Destroy() end) uiDisc=nil end
	if hnsDisc then pcall(function() hnsDisc:Destroy() end) hnsDisc=nil end
end
local function buildDisc(color)
	local p=Instance.new("Part")
	p.Name="UIRadiusDisc" p.Anchored=true p.CanCollide=false
	p.CanQuery=false p.CanTouch=false p.CastShadow=false
	p.Massless=true p.Locked=true p.Material=Enum.Material.Plastic
	p.Color=color p.Shape=Enum.PartType.Cylinder
	p.Size=Vector3.new(0.08,2,2) p.Transparency=0.55
	pcall(function() p.Parent=Workspace.CurrentCamera or Workspace end)
	return p
end
local function makeViz()
	if S.unloaded then return end
	destroyViz()
	if not C.RadiusVis and not H.RadiusVis then return end
	if C.RadiusVis then uiDisc=buildDisc(uiRadiusColor()) end
	if H.RadiusVis then hnsDisc=buildDisc(hnsRadiusColor()) end
	vizConn=RunService.RenderStepped:Connect(function()
		if S.unloaded then return end
		local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local base=hrp.Position-Vector3.new(0,2.9,0)
		if uiDisc then
			local d=math.max(2,C.Distance or 16)*2
			uiDisc.CFrame=CFrame.new(base)*CFrame.Angles(0,0,math.rad(90))
			uiDisc.Size=Vector3.new(0.08,d,d)
			uiDisc.Color=uiRadiusColor()
			uiDisc.Transparency=math.clamp(1-(C.RadiusTransparency or 0.55),0.1,0.9)
		end
		if hnsDisc then
			local d=math.max(2,H.Distance or 16)*2
			local hb=base+Vector3.new(0,0.02,0)
			hnsDisc.CFrame=CFrame.new(hb)*CFrame.Angles(0,0,math.rad(90))
			hnsDisc.Size=Vector3.new(0.08,d,d)
			hnsDisc.Color=hnsRadiusColor()
			hnsDisc.Transparency=math.clamp(1-(H.RadiusTransparency or 0.55),0.1,0.9)
		end
	end)
end
local function killViz() destroyViz() end
local RLGL_RED_IMG="rbxassetid://88400194373338"
_G.__rlgl_isRed=function()
	local ok1,r1=pcall(function()
		local pg=LP:FindFirstChild("PlayerGui")
		if not pg then return false end
		local imp=pg:FindFirstChild("ImpactFrames")
		if not imp then return false end
		local tl=imp:FindFirstChild("TrafficLightEmpty")
		if not tl or not tl:IsA("ImageLabel") then return false end
		return tl.Image==RLGL_RED_IMG
	end)
	if ok1 and r1 then return true end
	local ok2,r2=pcall(function()
		local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
		if not cc or not cc.Enabled then return false end
		local t=cc.TintColor
		return t.R>0.6 and t.G<0.4 and t.B<0.4
	end)
	if ok2 and r2 then return true end
	return false
end
_G.__rlgl_inSafeZone=function()
	local char=LP.Character; if not char then return false end
	local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return false end
	local p=hrp.Position
	if math.abs(p.Y-1023)>80 then return false end
	local function inBox(a,b,c,d) return p.X>=a and p.X<=b and p.Z>=c and p.Z<=d end
	if inBox(-219,135,-656,-511) then return true end
	if inBox(-215,115,82,168) then return true end
	return false
end
_G.__rlgl_inFinishZone=function()
	local char=LP.Character; if not char then return false end
	local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return false end
	local p=hrp.Position
	if math.abs(p.Y-1023)>80 then return false end
	if p.X>=-215 and p.X<=115 and p.Z>=82 and p.Z<=168 then return true end
	return false
end
_G.__rlgl_isMoving=function(th)
	local char=LP.Character; if not char then return false end
	local hum=char:FindFirstChildOfClass("Humanoid")
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return false end
	if hum.MoveDirection.Magnitude>0.1 then return true end
	local v=hrp.AssemblyLinearVelocity
	return math.sqrt(v.X*v.X+v.Z*v.Z)>(th or 0.3)
end
_G.__rlgl_isOnMap=function()
	local values=workspace:FindFirstChild("Values")
	if values then
		local cg=values:FindFirstChild("CurrentGame")
		if cg and cg.Value=="RedLightGreenLight" then return true end
	end
	local char=LP.Character
	if not char then return false end
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	return hrp.Position.Y>1000 and hrp.Position.Y<1050
end
_G.__rlgl_timerSeconds=function()
	local attr=workspace:GetAttribute("CurrentGameTime")
	if type(attr)=="number" then return attr,tostring(attr) end
	for _,n in ipairs({"TimeLeft","Timer","RoundTime","TimeRemaining"}) do
		local v=workspace:GetAttribute(n)
		if type(v)=="number" then return v,tostring(v) end
	end
	local function parse(txt)
		if not txt or txt=="" then return nil end
		txt=tostring(txt):gsub("^%s+",""):gsub("%s+$","")
		local mm,ss=txt:match("^(%d+):(%d+)")
		if mm then return tonumber(mm)*60+tonumber(ss),txt end
		local n=txt:match("^(%d+)")
		if n then return tonumber(n),txt end
		return nil,txt
	end
	if _G.__rlgl_timerLabel and _G.__rlgl_timerLabel.Parent then
		local s,r=parse(_G.__rlgl_timerLabel.Text)
		if s~=nil then return s,r end
	end
	return nil,nil
end
_G.__rlgl_fireDodge=function()
	if S.unloaded then return end
	local char=LP.Character; if not char then return end
	local hum=char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health<=0 then return end
	if type(keypress)=="function" and type(keyrelease)=="function" then
		pcall(function()
			keypress(0x54)
			task.delay(0.012,function() pcall(function() keyrelease(0x54) end) end)
		end)
	else
		pcall(function()
			local vim=game:GetService("VirtualInputManager")
			vim:SendKeyEvent(true,Enum.KeyCode.T,false,game)
			task.delay(0.012,function() pcall(function() vim:SendKeyEvent(false,Enum.KeyCode.T,false,game) end) end)
		end)
	end
end
local function applyFullBright(st)
	if st then
		if not S.fbInst then
			S.fbInst=Instance.new("ColorCorrectionEffect")
			S.fbInst.Name="_XD_FB" S.fbInst.Brightness=0.3 S.fbInst.Contrast=0.15 S.fbInst.Saturation=0.05
			S.fbInst.Parent=Lighting
		end
	else
		if S.fbInst then pcall(function() S.fbInst:Destroy() end) S.fbInst=nil end
	end
end
local function applyRemoveFog(st)
	if st then
		if not S.fogBackup then
			S.fogBackup={FogEnd=Lighting.FogEnd,FogStart=Lighting.FogStart,FogColor=Lighting.FogColor}
		end
		Lighting.FogEnd=1000000
		Lighting.FogStart=1000000
	else
		if S.fogBackup then
			Lighting.FogEnd=S.fogBackup.FogEnd
			Lighting.FogStart=S.fogBackup.FogStart
			Lighting.FogColor=S.fogBackup.FogColor
			S.fogBackup=nil
		end
	end
end
local activeNotifs={}
local function showNotif(text,color)
	if S.unloaded then return end
	pcall(function()
		do
			local snd=Instance.new("Sound")
			snd.SoundId="rbxassetid://6042053626"
			snd.Volume=0.5
			snd.Parent=SoundService
			snd:Play()
			pcall(function() SoundService:PlayLocalSound(snd) end)
			task.delay(2,function() pcall(function() snd:Destroy() end) end)
		end
		if not S.notifHolder or not S.notifHolder.Parent then
			S.notifHolder=Instance.new("ScreenGui")
			S.notifHolder.Name="XD_Nf_"..randStr(6)
			S.notifHolder.IgnoreGuiInset=true S.notifHolder.ResetOnSpawn=false S.notifHolder.DisplayOrder=99999
			local ph=nil
			if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then ph=h end end
			if not ph then ph=LP:FindFirstChildOfClass("PlayerGui") end
			if not ph then ph=game:GetService("CoreGui") end
			pcall(function() S.notifHolder.Parent=ph end)
			if not S.notifHolder.Parent then pcall(function() S.notifHolder.Parent=game:GetService("CoreGui") end) end
		end
		local f=Instance.new("Frame")
		f.Size=UDim2.fromOffset(250,36) f.AnchorPoint=Vector2.new(0.5,0)
		f.Position=UDim2.new(0.5,0,0,-60)
		f.BackgroundColor3=Color3.fromRGB(11,9,18) f.BackgroundTransparency=0.12
		f.BorderSizePixel=0 f.ZIndex=5 f.Parent=S.notifHolder
		addCorner(f,8)
		local st=Instance.new("UIStroke")
		st.Color=color or guiAccent() st.Thickness=1.5 st.Transparency=0.1 st.Parent=f
		local lbl=Instance.new("TextLabel")
		lbl.Size=UDim2.new(1,-12,1,0) lbl.Position=UDim2.fromOffset(6,0)
		lbl.BackgroundTransparency=1 lbl.Font=Enum.Font.GothamBold lbl.TextSize=12
		lbl.TextColor3=color or Color3.fromRGB(235,225,250) lbl.Text=tostring(text or "")
		lbl.ZIndex=6 lbl.Parent=f
		table.insert(activeNotifs,1,f)
		for i,nf in ipairs(activeNotifs) do
			if nf and nf.Parent then
				local ty=20+(i-1)*42
				TweenService:Create(nf,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0,ty)}):Play()
			end
		end
		TweenService:Create(f,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0,20)}):Play()
		task.delay(2.2,function()
			if not f or not f.Parent then return end
			local TO=TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
			TweenService:Create(f,TO,{Position=UDim2.new(0.5,0,0,-60),BackgroundTransparency=1}):Play()
			TweenService:Create(st,TO,{Transparency=1}):Play()
			TweenService:Create(lbl,TO,{TextTransparency=1}):Play()
			task.delay(0.35,function()
				for i=#activeNotifs,1,-1 do
					if activeNotifs[i]==f then table.remove(activeNotifs,i) break end
				end
				pcall(function() f:Destroy() end)
				for i,nf in ipairs(activeNotifs) do
					if nf and nf.Parent then
						local ty=20+(i-1)*42
						TweenService:Create(nf,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0,ty)}):Play()
					end
				end
			end)
		end)
	end)
end
_G.__adShowNotif=showNotif
local btFadeStyles={
	{name="Quad",style=Enum.EasingStyle.Quad},
	{name="Linear",style=Enum.EasingStyle.Linear},
	{name="Expo",style=Enum.EasingStyle.Exponential},
	{name="Back",style=Enum.EasingStyle.Back},
	{name="Circ",style=Enum.EasingStyle.Circular},
	{name="Sine",style=Enum.EasingStyle.Sine},
	{name="Quint",style=Enum.EasingStyle.Quint},
	{name="Bounce",style=Enum.EasingStyle.Bounce},
	{name="Elastic",style=Enum.EasingStyle.Elastic},
}
local function btGetMuzzle()
	local char=LP.Character
	if not char then return nil end
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local attr=char:GetAttribute("HoldingWeapon")
	if type(attr)=="string" and attr~="" then
		local w=char:FindFirstChild(attr)
		if w then
			local ff=w:FindFirstChild("FireFrom")
			if ff and ff:IsA("BasePart") then return ff.Position end
			local hd=w:FindFirstChild("Handle")
			if hd and hd:IsA("BasePart") then
				return hd.Position+hd.CFrame.LookVector*0.5
			end
		end
	end
	return hrp.Position+hrp.CFrame.LookVector*1.5+Vector3.new(0,0.8,0)
end
local function btGetTarget(fromPos)
	local cam=Workspace.CurrentCamera
	if not cam then return nil end
	local dir
	if UIS.TouchEnabled and not UIS.MouseEnabled then
		dir=cam.CFrame.LookVector
	else
		local mouse=LP:GetMouse()
		if not mouse then return nil end
		dir=cam:ScreenPointToRay(mouse.X,mouse.Y).Direction
	end
	local rp=RaycastParams.new()
	rp.FilterType=Enum.RaycastFilterType.Exclude
	rp.FilterDescendantsInstances={LP.Character}
	local hit=Workspace:Raycast(fromPos,dir*C.BulletTracerRange,rp)
	if hit then return hit.Position end
	return fromPos+dir*C.BulletTracerRange
end
local function btSpawnLine(fromPos,toPos)
	local delta=toPos-fromPos
	local dist=delta.Magnitude
	if dist<1 then return end
	local dir=delta.Unit
	local a=fromPos+dir*C.BulletTracerStartOffset
	local b=toPos-dir*C.BulletTracerEndOffset
	local d2=(b-a).Magnitude
	if d2<0.3 then return end
	local mid=(a+b)/2
	local cf=CFrame.lookAt(mid,b)
	local col=Color3.fromRGB(C.BulletTracerR,C.BulletTracerG,C.BulletTracerB)
	local th=C.BulletTracerThickness
	local lt=C.BulletTracerLifetime
	local style=btFadeStyles[C.BulletTracerFadeIdx or 1].style
	local T=TweenInfo.new(lt,style,Enum.EasingDirection.Out)
	local spd=math.max(50,tonumber(C.BulletTracerSpeed) or 800)
	local travelTime=dist/spd
	if travelTime<0.015 then travelTime=0.015 end
	local function mkPart(partSize,color,trans)
		local p=Instance.new("Part")
		p.Name="_XD_BTracer"
		p.Anchored=true
		p.CanCollide=false
		p.CanQuery=false
		p.CanTouch=false
		p.CastShadow=false
		p.Material=Enum.Material.Neon
		p.Color=color
		p.Transparency=trans
		p.Size=partSize
		p.CFrame=cf
		p.Parent=workspace
		return p
	end
	local function animateGrow(p,w,h,fullLen)
		task.spawn(function()
			local t0=tick()
			while true do
				if S.unloaded or not p or not p.Parent then return end
				local t=(tick()-t0)/travelTime
				if t>=1 then t=1 end
				local sz=fullLen*t
				if sz<0.01 then sz=0.01 end
				p.Size=Vector3.new(w,h,sz)
				p.CFrame=CFrame.lookAt(a+dir*(sz/2),b)
				if t>=1 then break end
				RunService.Heartbeat:Wait()
			end
		end)
	end
	if C.BulletTracerGlow then
		local outer=mkPart(Vector3.new(th*3,th*3,0.01),col,math.clamp(C.BulletTracerOpacity+0.4,0,1))
		task.delay(lt+travelTime+0.1,function() pcall(function() outer:Destroy() end) end)
		animateGrow(outer,th*3,th*3,d2)
		task.delay(travelTime,function()
			if outer and outer.Parent then
				TweenService:Create(outer,T,{Transparency=1,Size=Vector3.new(0.01,0.01,d2)}):Play()
			end
		end)
	end
	local core=mkPart(Vector3.new(th,th,0.01),col,C.BulletTracerOpacity)
	if C.BulletTracerGlow then
		local l=Instance.new("PointLight")
		l.Color=col l.Brightness=3 l.Range=8 l.Parent=core
	end
	task.delay(lt+travelTime+0.1,function() pcall(function() core:Destroy() end) end)
	animateGrow(core,th,th,d2)
	task.delay(travelTime,function()
		if core and core.Parent then
			TweenService:Create(core,T,{Transparency=1,Size=Vector3.new(0.01,0.01,d2)}):Play()
		end
	end)
	if C.BulletTracerWhiteCore then
		local inner=mkPart(Vector3.new(th*0.3,th*0.3,0.01),Color3.new(1,1,1),math.clamp(C.BulletTracerOpacity+0.1,0,1))
		task.delay(lt+travelTime+0.1,function() pcall(function() inner:Destroy() end) end)
		animateGrow(inner,th*0.3,th*0.3,d2)
		task.delay(travelTime,function()
			if inner and inner.Parent then
				TweenService:Create(inner,T,{Transparency=1,Size=Vector3.new(0.005,0.005,d2)}):Play()
			end
		end)
	end
end
local function btOnShot()
	if not C.BulletTracer then return end
	local now=tick()
	if now-S.btLastShot<C.BulletTracerCooldown then return end
	S.btLastShot=now
	local fromPos=btGetMuzzle()
	if not fromPos then return end
	local toPos=btGetTarget(fromPos)
	if not toPos then return end
	btSpawnLine(fromPos,toPos)
end
local function btAttachAnimator(an)
	if not an then return end
	if S.btAnimConn then
		pcall(function() S.btAnimConn:Disconnect() end)
		S.btAnimConn=nil
	end
	S.btAnimConn=an.AnimationPlayed:Connect(function(tr)
		local a=tr.Animation
		if not a then return end
		local id=a.AnimationId
		if not SHOT_IDS[id] then return end
		local t=tick()
		if t-(S.btLastIdTime[id] or 0)<C.BulletTracerCooldown then return end
		S.btLastIdTime[id]=t
		btOnShot()
	end)
end
local function btWatchChar(char)
	if not char then return end
	local hum=char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	local an=hum:FindFirstChildOfClass("Animator")
	if an then btAttachAnimator(an)
	else
		local c
		c=hum.ChildAdded:Connect(function(ch)
			if ch:IsA("Animator") then
				btAttachAnimator(ch)
				pcall(function() c:Disconnect() end)
			end
		end)
	end
end
if LP.Character then btWatchChar(LP.Character) end
track(LP.CharacterAdded:Connect(function(ch)
	task.wait(0.5)
	btWatchChar(ch)
end))

-- ============== ESP ==============
local guardESPs={}
local playerESPs={}
local function clearAllGuardESP()
	for _,v in pairs(guardESPs) do
		pcall(function() if v.hl then v.hl:Destroy() end end)
		pcall(function() if v.nameBill then v.nameBill:Destroy() end end)
		pcall(function() if v.hpBar then v.hpBar:Destroy() end end)
		pcall(function() if v.distBill then v.distBill:Destroy() end end)
		pcall(function() if v.toolBill then v.toolBill:Destroy() end end)
		pcall(function() if v.tracer then v.tracer:Destroy() end end)
		pcall(function() if v.box then v.box:Destroy() end end)
	end
	table.clear(guardESPs)
end
local function clearAllPlayerESP()
	for _,v in pairs(playerESPs) do
		pcall(function() if v.hl then v.hl:Destroy() end end)
		pcall(function() if v.nameBill then v.nameBill:Destroy() end end)
		pcall(function() if v.hpBar then v.hpBar:Destroy() end end)
		pcall(function() if v.distBill then v.distBill:Destroy() end end)
		pcall(function() if v.toolBill then v.toolBill:Destroy() end end)
		pcall(function() if v.tracer then v.tracer:Destroy() end end)
		pcall(function() if v.box then v.box:Destroy() end end)
	end
	table.clear(playerESPs)
end
local function isGuardPlayer(char,plr)
	if not char or not plr then return false end
	if plr:GetAttribute("IsGuard")==true then return true end
	if char:FindFirstChild("GuardPlayerOutift") then return true end
	if char:FindFirstChild("G3SG1") then return true end
	return false
end
local function getCharHeightStuds(char)
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return 5.5 end
	local minY,maxY=math.huge,-math.huge
	for _,p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") then
			local y=p.Position.Y
			if y<minY then minY=y end
			if y>maxY then maxY=y end
		end
	end
	if minY==math.huge then return 5.5 end
	local h=maxY-minY
	if h<3 then h=3 end
	if h>10 then h=10 end
	return h
end
local function createESP(plr,char,hrp,hum,nameSize,hpGrad)
	local color=plr:GetAttribute("IsGuard") and guardESPColor() or playerESPColor()
	local darkColor=color:Lerp(Color3.new(0,0,0),0.35)
	local charHeight=getCharHeightStuds(char)
	ensureTracerGui() ensureOverlayGui()
	local hl=Instance.new("Highlight")
	hl.Name="_XD_HL" hl.FillTransparency=0.4 hl.OutlineTransparency=0
	hl.FillColor=color hl.OutlineColor=darkColor hl.Adornee=char hl.Parent=char
	local nameBill=Instance.new("BillboardGui")
	nameBill.Name="_XD_NAME" nameBill.Size=UDim2.fromOffset(360,26)
	nameBill.StudsOffset=Vector3.new(0,charHeight*0.5+0.6,0) nameBill.AlwaysOnTop=true
	nameBill.LightInfluence=0 nameBill.Adornee=hrp nameBill.Parent=char
	local container=Instance.new("Frame")
	container.BackgroundTransparency=1 container.Size=UDim2.fromOffset(0,24)
	container.AutomaticSize=Enum.AutomaticSize.X
	container.AnchorPoint=Vector2.new(0.5,0.5) container.Position=UDim2.fromScale(0.5,0.5)
	container.Parent=nameBill
	local layout=Instance.new("UIListLayout")
	layout.FillDirection=Enum.FillDirection.Horizontal
	layout.SortOrder=Enum.SortOrder.LayoutOrder
	layout.VerticalAlignment=Enum.VerticalAlignment.Center
	layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
	layout.Padding=UDim.new(0,6) layout.Parent=container
	local hpChip=Instance.new("Frame")
	hpChip.LayoutOrder=1 hpChip.Size=UDim2.fromOffset(42,20)
	hpChip.BackgroundColor3=Color3.fromRGB(74,222,74)
	hpChip.BorderSizePixel=0 hpChip.Parent=container
	addCorner(hpChip,5)
	local hpChipStroke=Instance.new("UIStroke")
	hpChipStroke.Thickness=1.5 hpChipStroke.Transparency=0 hpChipStroke.Color=Color3.new(0,0,0)
	hpChipStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border hpChipStroke.Parent=hpChip
	local hpLbl=Instance.new("TextLabel")
	hpLbl.Size=UDim2.fromScale(1,1) hpLbl.BackgroundTransparency=1
	hpLbl.Font=Enum.Font.GothamBlack hpLbl.TextSize=13
	hpLbl.TextColor3=Color3.fromRGB(255,255,255)
	hpLbl.TextStrokeTransparency=0 hpLbl.TextStrokeColor3=Color3.new(0,0,0)
	hpLbl.Text="[100]" hpLbl.Parent=hpChip
	local nl=Instance.new("TextLabel")
	nl.LayoutOrder=2 nl.BackgroundTransparency=1
	nl.AutomaticSize=Enum.AutomaticSize.X nl.Size=UDim2.fromOffset(0,24)
	nl.Font=espFont() nl.TextSize=nameSize or 17
	nl.TextColor3=Color3.fromRGB(255,255,255) nl.TextStrokeTransparency=0
	nl.TextStrokeColor3=Color3.fromRGB(0,0,0)
	nl.Text=plr.Name nl.Parent=container
	local toolBill=Instance.new("BillboardGui")
	toolBill.Size=UDim2.fromOffset(220,20)
	toolBill.StudsOffset=Vector3.new(0,-charHeight*0.5-1.2,0) toolBill.AlwaysOnTop=true
	toolBill.LightInfluence=0 toolBill.Adornee=hrp toolBill.Parent=char
	local tl=Instance.new("TextLabel")
	tl.Size=UDim2.new(1,0,1,0) tl.BackgroundTransparency=1
	tl.TextColor3=color tl.TextStrokeTransparency=0
	tl.TextStrokeColor3=Color3.new(0,0,0) tl.Font=espFont()
	tl.TextSize=13 tl.Text="" tl.Parent=toolBill
	local hpBar=Instance.new("BillboardGui")
	hpBar.Size=UDim2.fromOffset(8,charHeight*24)
	hpBar.StudsOffset=Vector3.new(-2.5,0,0)
	hpBar.AlwaysOnTop=true hpBar.LightInfluence=0
	hpBar.Adornee=hrp hpBar.Parent=char
	local hpBg=Instance.new("Frame")
	hpBg.Size=UDim2.fromScale(1,1) hpBg.AnchorPoint=Vector2.new(0.5,0.5)
	hpBg.Position=UDim2.fromScale(0.5,0.5)
	hpBg.BackgroundColor3=Color3.fromRGB(25,8,8) hpBg.BackgroundTransparency=0.2
	hpBg.BorderSizePixel=0 hpBg.Parent=hpBar
	local hpBgCorner=addCorner(hpBg,3)
	addStroke(hpBg,Color3.new(0,0,0),1,0.3)
	local hpFill=Instance.new("Frame")
	hpFill.Size=UDim2.fromScale(1,1) hpFill.BackgroundColor3=Color3.new(1,1,1)
	hpFill.BorderSizePixel=0 hpFill.AnchorPoint=Vector2.new(0,1)
	hpFill.Position=UDim2.fromScale(0,1) hpFill.Parent=hpBg
	local hpFillCorner=addCorner(hpFill,3)
	local hpGradient=Instance.new("UIGradient")
	hpGradient.Color=hpGrad or mkGrad5(80,255,80,180,255,60,255,200,40,255,120,60,255,40,40)
	hpGradient.Rotation=90 hpGradient.Parent=hpFill
	local distBill=Instance.new("BillboardGui")
	distBill.Size=UDim2.fromOffset(160,18)
	distBill.StudsOffset=Vector3.new(2.8,0,0) distBill.AlwaysOnTop=true
	distBill.LightInfluence=0 distBill.Adornee=hrp distBill.Parent=char
	local dl=Instance.new("TextLabel")
	dl.Size=UDim2.new(1,0,1,0) dl.BackgroundTransparency=1
	dl.TextColor3=color dl.TextStrokeTransparency=0
	dl.TextStrokeColor3=Color3.new(0,0,0) dl.Font=Enum.Font.Code
	dl.TextSize=13 dl.Text="" dl.TextXAlignment=Enum.TextXAlignment.Left dl.Parent=distBill
	local tracer=Instance.new("Frame")
	tracer.AnchorPoint=Vector2.new(0.5,0.5) tracer.BorderSizePixel=0
	tracer.ZIndex=5 tracer.Visible=false tracer.BackgroundColor3=color tracer.Parent=S.tracerGui
	local box=Instance.new("Frame")
	box.BackgroundTransparency=1 box.BorderSizePixel=0 box.Visible=false box.ZIndex=4 box.Parent=S.overlayGui
	local boxStroke=Instance.new("UIStroke")
	boxStroke.Thickness=2 boxStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border boxStroke.Parent=box
	return {hl=hl,nameBill=nameBill,hpChip=hpChip,hpChipStroke=hpChipStroke,hpLbl=hpLbl,nameL=nl,
		toolBill=toolBill,toolL=tl,
		hpBar=hpBar,hpBg=hpBg,hpFill=hpFill,hpGradient=hpGradient,
		hpBgCorner=hpBgCorner,hpFillCorner=hpFillCorner,
		distBill=distBill,distL=dl,tracer=tracer,
		box=box,boxStroke=boxStroke,
		char=char,color=color,charHeight=charHeight}
end
local function destroyESP(e)
	if not e then return end
	pcall(function() if e.hl then e.hl:Destroy() end end)
	pcall(function() if e.nameBill then e.nameBill:Destroy() end end)
	pcall(function() if e.hpBar then e.hpBar:Destroy() end end)
	pcall(function() if e.distBill then e.distBill:Destroy() end end)
	pcall(function() if e.toolBill then e.toolBill:Destroy() end end)
	pcall(function() if e.tracer then e.tracer:Destroy() end end)
	pcall(function() if e.box then e.box:Destroy() end end)
end
local function refreshESPTag(e,color,nameSize,hpGrad)
	if not e then return end
	local dc=color:Lerp(Color3.new(0,0,0),0.35)
	e.color=color
	pcall(function() e.hl.FillColor=color e.hl.OutlineColor=dc end)
	if e.nameL then
		pcall(function()
			local ns=nameSize or 17
			e.nameL.TextSize=ns
			e.nameL.Font=espFont()
			if e.hpChip and e.hpLbl then
				local sc=ns/17
				e.hpChip.Size=UDim2.fromOffset(math.max(24,math.floor(42*sc+0.5)),math.max(12,math.floor(20*sc+0.5)))
				e.hpLbl.TextSize=math.max(8,math.floor(13*sc+0.5))
			end
		end)
	end
	if e.distL then pcall(function() e.distL.TextColor3=color end) end
	if e.toolL then pcall(function() e.toolL.TextColor3=color e.toolL.Font=espFont() end) end
	if e.hpBg then
		local st=e.hpBg:FindFirstChildOfClass("UIStroke")
		if st then pcall(function() st.Color=color:Lerp(Color3.new(0,0,0),0.4) end) end
	end
	if e.hpGradient and hpGrad then pcall(function() e.hpGradient.Color=hpGrad end) end
end
local function updateESP()
	if S.unloaded then return end
	_G.__adEspDone=0 _G.__adEspTotal=0
	local guardOn=C.GuardESP
	local playerOn=C.PlayerESP
	if not (guardOn or playerOn) then
		if next(guardESPs) then clearAllGuardESP() end
		if next(playerESPs) then clearAllPlayerESP() end
		return
	end
	local myHrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr~=LP then
			_G.__adEspTotal=_G.__adEspTotal+1
			pcall(function()
				local char=plr.Character
				local hum=char and char:FindFirstChildOfClass("Humanoid")
				local hrp=char and char:FindFirstChild("HumanoidRootPart")
				local isGuard=C.GuardESP_ForceAll or isGuardPlayer(char,plr)
				local wG=guardOn and isGuard
				local wP=playerOn and not isGuard
				if hum and hrp and hum.Health>0 and (wG or wP) then
					local maxD=wG and (C.GuardESP_MaxDist or 0) or (C.PlayerESP_MaxDist or 0)
					local myP=myHrp and myHrp.Position or Vector3.zero
					local dist=(myP-hrp.Position).Magnitude
					if maxD>0 and dist>maxD then
						if guardESPs[plr] then destroyESP(guardESPs[plr]) guardESPs[plr]=nil end
						if playerESPs[plr] then destroyESP(playerESPs[plr]) playerESPs[plr]=nil end
						return
					end
					_G.__adEspDone=_G.__adEspDone+1
					local col=wG and guardESPColor() or playerESPColor()
					local nS=wG and (C.GuardESP_NameSize or 17) or (C.PlayerESP_NameSize or 17)
					local hG=wG and guardHPGrad() or playerHPGrad()
					local tbl=wG and guardESPs or playerESPs
					local oth=wG and playerESPs or guardESPs
					if oth[plr] then destroyESP(oth[plr]) oth[plr]=nil end
					if not tbl[plr] or tbl[plr].char~=char then
						if tbl[plr] then destroyESP(tbl[plr]) tbl[plr]=nil end
						tbl[plr]=createESP(plr,char,hrp,hum,nS,hG)
					else
						refreshESPTag(tbl[plr],col,nS,hG)
					end
					local e=tbl[plr]
					if e then
						local sH=wG and C.GuardESP_HP or (wP and C.PlayerESP_HP)
						local sN=wG and C.GuardESP_Name or (wP and C.PlayerESP_Name)
						local sT=wG and C.GuardESP_Tool or (wP and C.PlayerESP_Tool)
						local sD=wG and C.GuardESP_Distance or (wP and C.PlayerESP_Distance)
						local sHL=wG and C.GuardESP_Highlight or (wP and C.PlayerESP_Highlight)
						local sTr=wG and C.GuardESP_Tracer or (wP and C.PlayerESP_Tracer)
						local sBx=wG and C.GuardESP_Box or (wP and C.PlayerESP_Box)
						e.showHPBar=sH e.showTracer=sTr e.showBox=sBx
						e.boxColor=wG and guardBoxColor() or playerBoxColor()
						e.boxThick=wG and (C.GuardESP_BoxThickness or 2) or (C.PlayerESP_BoxThickness or 2)
						e.hpBarThickness=wG and (C.GuardESP_HPBarThickness or 8) or (C.PlayerESP_HPBarThickness or 8)
						e.hpBarLength=wG and (C.GuardESP_HPBarLength or 1.5) or (C.PlayerESP_HPBarLength or 1.5)
						e.hpBarRoundness=wG and (C.GuardESP_HPBarRoundness or 3) or (C.PlayerESP_HPBarRoundness or 3)
						e.tracerColor=wG and guardTracerColor() or playerTracerColor()
						e.nameBill.Enabled=sN and true or false
						e.toolBill.Enabled=sT and true or false
						if e.hl then e.hl.Enabled=sHL and true or false end
						if sT then
							local tn=getToolRawName(char)
							if tn=="" then tn="- none -" end
							if e.toolL.Text~=tn then e.toolL.Text=tn end
						end
						local ratio=math.clamp(hum.Health/math.max(hum.MaxHealth,1),0,1)
						e.hpFill.Size=UDim2.fromScale(1,ratio)
						if e.hpLbl then e.hpLbl.Text="["..tostring(math.floor(hum.Health+0.5)).."]" end
						local chipBg=wG and C.GuardESP_HP_ChipBg or (wP and C.PlayerESP_HP_ChipBg)
						local chipCol=wG and guardChipColor(ratio) or playerChipColor(ratio)
						if e.hpChip then
							e.hpChip.BackgroundColor3=chipCol
							e.hpChip.BackgroundTransparency=chipBg and 0 or 1
						end
						if e.hpLbl then
							e.hpLbl.TextColor3=chipCol
						end
						if e.hpChipStroke then
							local outlineOn=wG and C.GuardESP_HP_Outline or (wP and C.PlayerESP_HP_Outline)
							e.hpChipStroke.Enabled=(outlineOn and chipBg) and true or false
						end
						if sD then
							if myHrp and hrp then
								e.distBill.Enabled=true
								e.distL.Text=string.format("[%d studs]",math.floor(dist+0.5))
							else e.distBill.Enabled=false end
						else e.distBill.Enabled=false end
						if e.tracer then e.tracer.BackgroundColor3=e.tracerColor end
						if not wG and e.nameL then
							local dn=plr.Name
							if C.PlayerESP_CustomName and C.PlayerESP_CustomName~="" then dn=C.PlayerESP_CustomName end
							if e.nameL.Text~=dn then e.nameL.Text=dn end
							if not C.PlayerESP_NameRainbow then
								e.nameL.TextColor3=Color3.fromRGB(255,255,255)
							end
						end
					end
				else
					if guardESPs[plr] then destroyESP(guardESPs[plr]) guardESPs[plr]=nil end
					if playerESPs[plr] then destroyESP(playerESPs[plr]) playerESPs[plr]=nil end
				end
			end)
		end
	end
end
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.GuardESP or C.PlayerESP then
				local cam=Workspace.CurrentCamera
				if cam then
					local fov=math.rad(cam.FieldOfView)
					local vp=cam.ViewportSize
					local vpY=vp.Y
					local camPos=cam.CFrame.Position
					local oX=vp.X/2
					local oY=vp.Y/2
					local tH=math.tan(fov/2)
					if tH>0.01 then
						local function upd(e)
							if not e then return end
							local hrp=e.char and e.char:FindFirstChild("HumanoidRootPart")
							if e.hpBar then
								if e.showHPBar and hrp then
									local d=(camPos-hrp.Position).Magnitude
									if d<1 then d=1 end
									local pps=vpY/(2*d*tH)
									local bw=e.hpBarThickness or 8
									local bm=e.hpBarLength or 1.5
									local hPx=(e.charHeight or 5.5)*pps*bm
									if hPx>3500 then hPx=3500 end
									if hPx<20 then hPx=20 end
									e.hpBar.Enabled=true
									e.hpBar.Size=UDim2.fromOffset(bw,hPx)
									local rn=e.hpBarRoundness or 3
									pcall(function()
										if e.hpBgCorner then e.hpBgCorner.CornerRadius=UDim.new(0,rn) end
										if e.hpFillCorner then e.hpFillCorner.CornerRadius=UDim.new(0,rn) end
									end)
								else e.hpBar.Enabled=false end
							end
							if e.tracer then
								if not e.showTracer or not hrp then
									if e.tracer.Visible then e.tracer.Visible=false end
								else
									local sp,onScreen=cam:WorldToViewportPoint(hrp.Position)
									local dx=sp.X-oX
									local dy=sp.Y-oY
									local bh=(sp.Z<0)
									if bh then dx=-dx dy=-dy end
									local rl=math.sqrt(dx*dx+dy*dy)
									local ux,uy
									if rl<0.001 then ux,uy=0,1 else ux=dx/rl uy=dy/rl end
									local tL=math.huge
									if ux>0.0001 then tL=math.min(tL,(vp.X-oX)/ux) end
									if ux<-0.0001 then tL=math.min(tL,-oX/ux) end
									if uy>0.0001 then tL=math.min(tL,(vp.Y-oY)/uy) end
									if uy<-0.0001 then tL=math.min(tL,-oY/uy) end
									if tL==math.huge or tL<1 then tL=1 end
									local tx,ty
									if onScreen and not bh then tx=sp.X ty=sp.Y
									else tx=oX+ux*tL ty=oY+uy*tL end
									local fdx=tx-oX
									local fdy=ty-oY
									local fl=math.sqrt(fdx*fdx+fdy*fdy)
									if fl<1 then fl=1 end
									local ang=math.deg(math.atan2(fdy,fdx))
									e.tracer.Visible=true
									e.tracer.Position=UDim2.fromOffset((oX+tx)/2,(oY+ty)/2)
									e.tracer.Size=UDim2.fromOffset(fl,1.5)
									e.tracer.Rotation=ang
								end
							end
							if e.box and e.boxStroke then
								if not e.showBox then
									if e.box.Visible then e.box.Visible=false end
								else
									local char=e.char
									if char and char.Parent then
										local mnX,mnY,mxX,mxY=getCharScreenBounds(char,cam)
										if mnX then
											e.box.Visible=true
											e.box.Position=UDim2.fromOffset(mnX-4,mnY-4)
											e.box.Size=UDim2.fromOffset(mxX-mnX+8,mxY-mnY+8)
											e.boxStroke.Color=e.boxColor or Color3.new(1,1,1)
											e.boxStroke.Thickness=e.boxThick or 2
										elseif e.box.Visible then e.box.Visible=false end
									elseif e.box.Visible then e.box.Visible=false end
								end
							end
						end
						for _,e in pairs(guardESPs) do upd(e) end
						for _,e in pairs(playerESPs) do upd(e) end
					end
				end
			end
		end)
		RunService.RenderStepped:Wait()
	end
end)
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.PlayerESP and C.PlayerESP_NameRainbow then
				local h=(tick()*(C.PlayerESP_NameRainbowSpeed or 1.0))%1
				local col=Color3.fromHSV(h,1,1)
				for _,e in pairs(playerESPs) do
					if e.nameL and e.nameL.Parent then
						pcall(function() e.nameL.TextColor3=col end)
					end
				end
			end
		end)
		RunService.RenderStepped:Wait()
	end
end)
local function setOneClickDalgona(v)
	S.oneClickDalgona=v and true or false
	if S.dalgonaConn then pcall(function() S.dalgonaConn:Disconnect() end) S.dalgonaConn=nil end
	if not S.oneClickDalgona then
		for part,data in pairs(_G.__dalgonaCache) do
			if part and part.Parent then pcall(function() part.Position=data.Position part.Transparency=data.Transparency end) end
		end
		table.clear(_G.__dalgonaCache)
		return
	end
	table.clear(_G.__dalgonaCache)
	S.dalgonaConn=RunService.RenderStepped:Connect(function()
		if S.unloaded or not S.oneClickDalgona then return end
		pcall(function()
			local mouse=LP:GetMouse()
			if not mouse or not mouse.Hit then return end
			local effects=workspace:FindFirstChild("Effects")
			local outline=nil
			if effects then
				for _,c in pairs(effects:GetChildren()) do
					if c:IsA("Model") and string.match(c.Name,"Outline$") then outline=c break end
				end
			end
			if not outline then return end
			local pos=mouse.Hit.Position
			for _,child in ipairs(outline:GetChildren()) do
				if child:IsA("BasePart") then
					if not _G.__dalgonaCache[child] then
						_G.__dalgonaCache[child]={Position=child.Position,Transparency=child.Transparency}
					end
					child.Position=pos child.Transparency=1
				end
			end
		end)
	end)
end
local function rebuildLimbCache()
	table.clear(S.handCache) table.clear(S.legCache) table.clear(S.torsoCache)
	local char=LP.Character
	if not char then return end
	local HN={LeftArm=true,RightArm=true,["Left Arm"]=true,["Right Arm"]=true,LeftUpperArm=true,RightUpperArm=true,LeftLowerArm=true,RightLowerArm=true,LeftHand=true,RightHand=true}
	local LN={LeftUpperLeg=true,LeftLowerLeg=true,LeftFoot=true,["Left Leg"]=true,RightUpperLeg=true,RightLowerLeg=true,RightFoot=true,["Right Leg"]=true}
	local TN={Torso=true,UpperTorso=true,LowerTorso=true}
	local HA={lefthand=true,righthand=true,leftgrip=true,rightgrip=true,leftwrist=true,rightwrist=true,leftcuff=true,rightcuff=true,leftglove=true,rightglove=true,leftarm=true,rightarm=true}
	local function isHA(acc)
		if not acc or not acc:IsA("Accessory") then return false end
		local n=string.lower(acc.Name)
		if n:find("glove") or n:find("hand") or n:find("wrist") or n:find("cuff") then return true end
		local h=acc:FindFirstChild("Handle")
		if h then
			for _,d in ipairs(h:GetChildren()) do
				if d:IsA("Attachment") and HA[string.lower(d.Name)] then return true end
			end
		end
		return false
	end
	for _,p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") then
			if HN[p.Name] then table.insert(S.handCache,p)
			elseif LN[p.Name] then table.insert(S.legCache,p)
			elseif TN[p.Name] then table.insert(S.torsoCache,p)
			else
				local acc=p:FindFirstAncestorOfClass("Accessory")
				if acc and isHA(acc) then table.insert(S.handCache,p) end
			end
		end
	end
end
local function setCacheHidden(cache,hide)
	for i=1,#cache do
		local p=cache[i]
		if p and p.Parent then
			if hide then
				if S.origTransparency[p]==nil then S.origTransparency[p]=p.Transparency end
				p.LocalTransparencyModifier=1 p.Transparency=1
			else
				p.LocalTransparencyModifier=0
				p.Transparency=S.origTransparency[p] or 0
			end
		end
	end
end
local function applyRemoveHands(st)
	C.RemoveHands=st and true or false
	rebuildLimbCache() setCacheHidden(S.handCache,C.RemoveHands) return true
end
local function applyRemoveLegs(st)
	C.RemoveLegs=st and true or false
	rebuildLimbCache() setCacheHidden(S.legCache,C.RemoveLegs) return true
end
local function applyRemoveTorso(st)
	C.RemoveTorso=st and true or false
	rebuildLimbCache() setCacheHidden(S.torsoCache,C.RemoveTorso) return true
end
local function ensureHandsLoop()
	if S.handsConn then return end
	S.handsConn=RunService.Heartbeat:Connect(function()
		if S.unloaded then return end
		if C.RemoveHands then setCacheHidden(S.handCache,true) end
		if C.RemoveLegs then setCacheHidden(S.legCache,true) end
		if C.RemoveTorso then setCacheHidden(S.torsoCache,true) end
	end)
	table.insert(S.conns,S.handsConn)
end
local function applyHeadless(st)
	local char=LP.Character
	if not char then return false end
	local head=char:FindFirstChild("Head")
	if not head then return false end
	if st==false then
		head.LocalTransparencyModifier=0 head.Transparency=0
		for _,c in ipairs(head:GetChildren()) do if c:IsA("Decal") then c.Transparency=0 end end
		return true
	end
	for _,c in ipairs(head:GetChildren()) do if c:IsA("Decal") then c.Transparency=1 end end
	head.LocalTransparencyModifier=1 head.Transparency=1 return true
end
local KORBLOX_MESH_ID="rbxassetid://959831634"
local KORBLOX_LEFT_PARTS={"LeftUpperLeg","LeftLowerLeg","LeftFoot","Left Leg"}
local function applyKorblox(st)
	local char=LP.Character
	if not char then return false end
	if st then
		for _,name in ipairs(KORBLOX_LEFT_PARTS) do
			local p=char:FindFirstChild(name)
			if p and p:IsA("BasePart") and not S.korbloxData[p] then
				local oT=p.Transparency
				local oL=p.LocalTransparencyModifier
				p.LocalTransparencyModifier=1 p.Transparency=1
				local deco=Instance.new("Part")
				deco.Name="KorbloxDeco" deco.Size=p.Size deco.CFrame=p.CFrame
				deco.Color=Color3.fromRGB(0,0,0) deco.Material=Enum.Material.Plastic
				deco.CanCollide=false deco.CanQuery=false deco.CanTouch=false
				deco.CastShadow=false deco.Massless=true deco.Anchored=false
				local sm=Instance.new("SpecialMesh")
				sm.MeshType=Enum.MeshType.FileMesh sm.MeshId=KORBLOX_MESH_ID
				sm.Scale=Vector3.new(1,1,1) sm.Parent=deco
				deco.Parent=char
				local w=Instance.new("WeldConstraint")
				w.Part0=p w.Part1=deco w.Parent=deco
				deco.CFrame=p.CFrame
				S.korbloxData[p]={deco=deco,origTrans=oT,origLTM=oL}
			end
		end
	else
		for p,data in pairs(S.korbloxData) do
			if p and p.Parent then
				p.LocalTransparencyModifier=data.origLTM p.Transparency=data.origTrans
			end
			if data.deco and data.deco.Parent then data.deco:Destroy() end
		end
		table.clear(S.korbloxData)
	end
	return true
end
local function clearHideConns()
	for _,c in ipairs(S.hideConns) do pcall(function() c:Disconnect() end) end
	table.clear(S.hideConns)
end
local function applyHideNick()
	clearHideConns()
	if S.unloaded then return end
	local function isNick(obj)
		if not obj then return false end
		if not (obj:IsA("BillboardGui") or obj:IsA("SurfaceGui")) then return false end
		local n=string.lower(tostring(obj.Name))
		if n:find("nick") or n:find("name") or n:find("tag") or n:find("title") or n:find("label") then return true end
		local par=obj.Parent
		if par and par.Name=="Head" then return true end
		return false
	end
	local function hideOne(d)
		if not d or not d.Parent then return end
		pcall(function() d.Enabled=false end)
		pcall(function() d.Visible=false end)
		if not d:GetAttribute("_XD_nickHooked") then
			d:SetAttribute("_XD_nickHooked",true)
			table.insert(S.hideConns,d:GetPropertyChangedSignal("Enabled"):Connect(function()
				if d.Enabled then pcall(function() d.Enabled=false end) end
			end))
			table.insert(S.hideConns,d:GetPropertyChangedSignal("Visible"):Connect(function()
				if d.Visible then pcall(function() d.Visible=false end) end
			end))
		end
	end
	local function scanChar(char)
		if not char then return end
		for _,d in ipairs(char:GetDescendants()) do
			if isNick(d) then hideOne(d) end
		end
	end
	local function hookChar(char)
		if not char then return end
		scanChar(char)
		table.insert(S.hideConns,char.DescendantAdded:Connect(function(d)
			if isNick(d) then task.defer(function() hideOne(d) end) end
		end))
	end
	if LP.Character then hookChar(LP.Character) end
	table.insert(S.hideConns,LP.CharacterAdded:Connect(function(ch) task.wait(0.3) hookChar(ch) end))
	table.insert(S.hideConns,Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function(ch) if S.unloaded then return end task.wait(0.3) hookChar(ch) end)
	end))
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr~=LP and plr.Character then
			hookChar(plr.Character)
			table.insert(S.hideConns,plr.CharacterAdded:Connect(function(ch)
				if S.unloaded then return end task.wait(0.3) hookChar(ch)
			end))
		end
	end
	if S._nickLoop then pcall(function() task.cancel(S._nickLoop) end) end
	S._nickLoop=task.spawn(function()
		while not S.unloaded and C.HideNick do
			pcall(function()
				if LP.Character then scanChar(LP.Character) end
				for _,plr in ipairs(Players:GetPlayers()) do
					if plr~=LP and plr.Character then scanChar(plr.Character) end
				end
			end)
			RunService.RenderStepped:Wait()
		end
	end)
end
local CONFIG_FOLDER="InkInstinct"
local AUTOLOAD_FILE=CONFIG_FOLDER.."/_autoload.txt"
local function ensureFolder()
	if S.FILE.isfolder and S.FILE.makefolder then
		local ok,e=pcall(S.FILE.isfolder,CONFIG_FOLDER)
		if not ok or not e then pcall(S.FILE.makefolder,CONFIG_FOLDER) end
	end
end
local function configPath(name) return CONFIG_FOLDER.."/"..tostring(name)..".json" end
local function saveAutoloadName(name)
	if not S.FILE.writefile then return false end
	ensureFolder()
	local ok=pcall(function() S.FILE.writefile(AUTOLOAD_FILE,tostring(name or "")) end)
	return ok
end
local function loadAutoloadName()
	if not S.FILE.readfile or not S.FILE.isfile then return "" end
	local ok,e=pcall(S.FILE.isfile,AUTOLOAD_FILE)
	if not ok or not e then return "" end
	local ok2,raw=pcall(S.FILE.readfile,AUTOLOAD_FILE)
	if not ok2 or not raw then return "" end
	return tostring(raw):gsub("%s","")
end
local function clearAutoloadName()
	if not S.FILE.delfile then return false end
	local ok=pcall(S.FILE.delfile,AUTOLOAD_FILE)
	return ok
end
local function packStore(store)
	local t={}
	for k,v in pairs(store) do
		if typeof(v)=="Color3" then t[k]={v.R,v.G,v.B}
		elseif typeof(v)=="EnumItem" then t[k]=v.Name
		else t[k]=v end
	end
	return t
end
local function unpackStore(store,data)
	if type(data)~="table" then return end
	for k,v in pairs(data) do
		if k=="MenuKey" and type(v)=="string" then
			local ok,en=pcall(function() return Enum.KeyCode[v] end)
			if ok and en then store[k]=en end
		elseif store[k]~=nil and type(v)==type(store[k]) then store[k]=v end
	end
end
local function applyData(data)
	if data.C or data.H or data.anim then
		unpackStore(C,data.C or data.ui) unpackStore(H,data.H or data.hns)
		if type(data.anim)=="table" then
			for k,v in pairs(data.anim) do
				if HIT[tostring(k)]~=nil and not BAN[tostring(k)] then S.animEnabled[tostring(k)]=v and true or false end
			end
		end
	else unpackStore(C,data) end
	makeViz() syncHooks() repaintAll() updateESP() makeFOVCircle() updateInfoVisibility()
end
local function saveConfig(name)
	name=name or S.currentConfigName
	if not S.FILE.writefile then return false,"no writefile" end
	ensureFolder()
	local cn=tostring(name):gsub("[^%w%-%_]","")
	if cn=="" then cn="default" end
	S.currentConfigName=cn
	local pl={C=packStore(C),H=packStore(H),anim=S.animEnabled}
	local ok=pcall(function() S.FILE.writefile(configPath(cn),HttpService:JSONEncode(pl)) end)
	if not ok then return false,"writefile failed" end
	return true,"ok"
end
local function loadConfig(name)
	name=name or S.currentConfigName
	if not S.FILE.readfile or not S.FILE.isfile then return false,"no readfile" end
	local path=configPath(name)
	local ok,e=pcall(S.FILE.isfile,path)
	if not ok or not e then return false,"not found" end
	local ok2,raw=pcall(S.FILE.readfile,path)
	if not ok2 or not raw then return false,"read failed" end
	local ok3,data=pcall(function() return HttpService:JSONDecode(raw) end)
	if not ok3 or type(data)~="table" then return false,"bad json" end
	applyData(data)
	S.currentConfigName=tostring(name):gsub("[^%w%-%_]","")
	return true,"ok"
end
local function listConfigs()
	local list={}
	if not S.FILE.listfiles or not S.FILE.isfolder then return list end
	local ok,e=pcall(S.FILE.isfolder,CONFIG_FOLDER)
	if not ok or not e then return list end
	local ok2,files=pcall(S.FILE.listfiles,CONFIG_FOLDER)
	if not ok2 or type(files)~="table" then return list end
	for _,f in ipairs(files) do
		local n=tostring(f):match("([^/\\]+)%.json$")
		if n and n~="" then table.insert(list,n) end
	end
	table.sort(list)
	return list
end
local function deleteConfig(name)
	if not S.FILE.delfile then return false,"no delfile" end
	local ok=pcall(S.FILE.delfile,configPath(name))
	return ok
end

-- ============== GUI ==============
S.ui={}
S.ui.PANEL_W=400
S.ui.PANEL_H=660
S.ui.CONTENT_W=S.ui.PANEL_W-16
S.ui.CONTENT_H=S.ui.PANEL_H-90
S.ui.BTN_W=S.ui.CONTENT_W-8
S.ui.COL={bg=Color3.fromRGB(11,9,18),bg2=Color3.fromRGB(22,15,36),card=Color3.fromRGB(26,20,40),text=Color3.fromRGB(235,225,250),textDim=Color3.fromRGB(150,135,175),off=Color3.fromRGB(22,17,34)}
S.ui.tabFrames={}
S.ui.activeTab="Main"
S.ui.pickerOverlay=nil
function S.ui.mkDivider(parent,y,text)
	local holder=Instance.new("Frame")
	holder.Size=UDim2.new(1,-8,0,18) holder.Position=UDim2.fromOffset(4,y)
	holder.BackgroundTransparency=1 holder.ZIndex=5 holder.Parent=parent
	local lbl=Instance.new("TextLabel")
	lbl.Size=UDim2.fromOffset(180,18) lbl.BackgroundTransparency=1
	lbl.Font=Enum.Font.GothamBold lbl.TextSize=9
	lbl.Text=string.upper(text or "") lbl.TextColor3=guiAccent()
	lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.ZIndex=6 lbl.Parent=holder
	registerRepaint(function() lbl.TextColor3=guiAccent() end)
	local line=Instance.new("Frame")
	line.Size=UDim2.new(1,-190,0,1) line.Position=UDim2.fromOffset(190,9)
	line.BackgroundColor3=guiAccent() line.BackgroundTransparency=0.72
	line.BorderSizePixel=0 line.ZIndex=6 line.Parent=holder
	registerRepaint(function() line.BackgroundColor3=guiAccent() end)
end
function S.ui.makeToggle(parent,y,label,key,customGet,customSet,store)
	local COL=S.ui.COL
	local BTN_W=S.ui.BTN_W
	store=store or C
	local btn=Instance.new("TextButton")
	btn.Size=UDim2.fromOffset(BTN_W,26) btn.Position=UDim2.fromOffset(4,y)
	btn.BorderSizePixel=0 btn.Font=Enum.Font.Gotham btn.TextSize=12
	btn.TextXAlignment=Enum.TextXAlignment.Left btn.TextColor3=guiTextColor()
	btn.AutoButtonColor=false btn.ZIndex=6 btn.Parent=parent
	addCorner(btn,7)
	local tr=Instance.new("Frame")
	tr.Size=UDim2.fromOffset(30,16) tr.Position=UDim2.new(1,-38,0.5,-8)
	tr.BorderSizePixel=0 tr.ZIndex=7 tr.Parent=btn
	addCorner(tr,8)
	local knob=Instance.new("Frame")
	knob.Size=UDim2.fromOffset(12,12) knob.Position=UDim2.fromOffset(2,2)
	knob.BackgroundColor3=Color3.new(1,1,1) knob.BorderSizePixel=0
	knob.ZIndex=8 knob.Parent=tr
	addCorner(knob,6)
	local function getCur()
		if customGet then return customGet() and true or false end
		if key then return store[key] and true or false end
		return false
	end
	local function paint(animate)
		local on=getCur()
		btn.Text="   "..label
		local bgTarget=on and accentDark(guiAccent()) or COL.off
		local trTarget=on and guiAccent() or Color3.fromRGB(60,50,78)
		local knobTarget=on and UDim2.fromOffset(16,2) or UDim2.fromOffset(2,2)
		if animate then
			local T=TweenInfo.new(0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
			TweenService:Create(btn,T,{BackgroundColor3=bgTarget}):Play()
			TweenService:Create(tr,T,{BackgroundColor3=trTarget}):Play()
			TweenService:Create(knob,T,{Position=knobTarget}):Play()
		else
			btn.BackgroundColor3=bgTarget
			tr.BackgroundColor3=trTarget
			knob.Position=knobTarget
		end
		btn.TextColor3=guiTextColor()
	end
	registerRepaint(function()
		local on=getCur()
		btn.BackgroundColor3=on and accentDark(guiAccent()) or COL.off
		btn.TextColor3=guiTextColor()
		tr.BackgroundColor3=on and guiAccent() or Color3.fromRGB(60,50,78)
		knob.Position=on and UDim2.fromOffset(16,2) or UDim2.fromOffset(2,2)
	end)
	paint(false)
	btn.MouseButton1Click:Connect(function()
		if S.unloaded then return end
		playClick()
		local nv=not getCur()
		if key then store[key]=nv end
		if customSet then customSet(nv)
		else
			if key=="Enabled" then syncHooks()
			elseif key=="RadiusVis" then makeViz()
			elseif key=="RemoveLegs" then applyRemoveLegs(store.RemoveLegs) ensureHandsLoop()
			elseif key=="RemoveHands" then applyRemoveHands(store.RemoveHands) ensureHandsLoop() rebuildLimbCache()
			elseif key=="RemoveTorso" then applyRemoveTorso(store.RemoveTorso) ensureHandsLoop() rebuildLimbCache()
			elseif key=="Headless" then applyHeadless(store.Headless)
			elseif key=="Korblox" then applyKorblox(store.Korblox)
			elseif key=="RebelFOVCircle" then makeFOVCircle()
			elseif key=="RebelFOVNeon" or key=="RebelFOVBlackOutline" then makeFOVCircle()
			elseif key=="Watermark" or key=="KeybindList" then updateInfoVisibility()
			elseif key=="GuardESP" or key=="PlayerESP" then updateESP()
			elseif key=="HideNick" then applyHideNick()
			elseif key=="FullBright" then applyFullBright(store.FullBright)
			elseif key=="RemoveFog" then applyRemoveFog(store.RemoveFog)
			elseif key=="FOVRainbow" then if store.FOVRainbow then startFovRainbow() else stopFovRainbow() makeFOVCircle() end
			elseif key=="PanelRainbow" then if store.PanelRainbow then startPanelRainbow() else stopPanelRainbow() if S.panel then local st=S.panel:FindFirstChildOfClass("UIStroke") if st then st.Color=guiAccent() end end end
			elseif key=="BulletTracer" then
			elseif key=="FOVUseCustom" then makeFOVCircle() if store.FOVRainbow then startFovRainbow() end
			elseif key=="AutoBrew" then if store.AutoBrew then startBrewLoop() else stopBrewLoop() end
			elseif key=="InfiniteAmmo" then applyInfiniteAmmo(store.InfiniteAmmo)
			elseif key=="RebelAimbot" then if store.RebelAimbot then startAimbot() else stopAimbot() end
			elseif key=="HitboxExpander" then if not store.HitboxExpander then HB_restoreAll() end
			elseif key=="HitboxVisualize" then if not store.HitboxVisualize then
				for char,v in pairs(HB_visuals) do
					if v.box then pcall(function() v.box:Destroy() end) v.box=nil end
				end
			end
			elseif key=="CircleRainbowText" or key=="CircleRainbowOutline" then repaintAll()
			elseif type(key)=="string" and (key:sub(1,9)=="GuardESP_" or key:sub(1,10)=="PlayerESP_") then updateESP()
			end
		end
		paint(true)
		if _G.__adShowNotif then
			local acc=guiAccent()
			local col
			if nv then
				col=acc
			else
				local h,s,v=Color3.toHSV(acc)
				col=Color3.fromHSV((h+0.5)%1,s,v)
			end
			_G.__adShowNotif(label..":  "..(nv and "ON" or "OFF"),col)
		end
	end)
	return paint
end
function S.ui.makeSlider(parent,y,label,key,minV,maxV,step,store,onChanged)
	local COL=S.ui.COL
	local BTN_W=S.ui.BTN_W
	store=store or C
	local row=Instance.new("Frame")
	row.Size=UDim2.fromOffset(BTN_W,40) row.Position=UDim2.fromOffset(4,y)
	row.BackgroundTransparency=1 row.ZIndex=5 row.Parent=parent
	local lab=Instance.new("TextLabel")
	lab.Size=UDim2.fromOffset(BTN_W,14) lab.BackgroundTransparency=1
	lab.Font=Enum.Font.Gotham lab.TextSize=11
	lab.TextXAlignment=Enum.TextXAlignment.Left lab.TextColor3=guiTextColor()
	lab.ZIndex=6 lab.Parent=row
	registerRepaint(function() lab.TextColor3=guiTextColor() end)
	local function refresh() lab.Text=label.."   "..tostring(store[key]) end
	refresh()
	local bar=Instance.new("TextButton")
	bar.Size=UDim2.fromOffset(BTN_W,14) bar.Position=UDim2.fromOffset(0,18)
	bar.BackgroundColor3=COL.card bar.BorderSizePixel=0
	bar.Text="" bar.AutoButtonColor=false bar.ZIndex=6 bar.Parent=row
	addCorner(bar,7)
	local fill=Instance.new("Frame")
	fill.Size=UDim2.new(math.clamp(((store[key] or minV)-minV)/(maxV-minV),0,1),0,1,0)
	fill.BorderSizePixel=0 fill.ZIndex=7 fill.Parent=bar
	addCorner(fill,7) fill.BackgroundColor3=guiAccent()
	registerRepaint(function() fill.BackgroundColor3=guiAccent() end)
	local thumb=Instance.new("Frame")
	thumb.Size=UDim2.fromOffset(12,12) thumb.BackgroundColor3=Color3.new(1,1,1)
	thumb.BorderSizePixel=0 thumb.ZIndex=8 thumb.Parent=bar
	addCorner(thumb,6)
	addStroke(thumb,Color3.new(0,0,0),1,0.5)
	local dragging=false
	local function updTh()
		local rel=((store[key] or minV)-minV)/(maxV-minV)
		thumb.Position=UDim2.new(rel,-6,0.5,-6)
	end
	updTh()
	local function setFromX(x)
		local rel=math.clamp((x-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1)
		local raw=minV+rel*(maxV-minV)
		raw=math.floor(raw/step+0.5)*step
		if step<1 then raw=math.floor(raw*100+0.5)/100 end
		store[key]=math.clamp(raw,minV,maxV)
		fill.Size=UDim2.new((store[key]-minV)/(maxV-minV),0,1,0)
		updTh() refresh()
		if onChanged then pcall(onChanged) end
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true setFromX(input.Position.X)
		end
	end)
	track(UIS.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
	end))
	track(UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then setFromX(input.Position.X) end
	end))
	return refresh
end
function S.ui.makeBtn(parent,y,text,cb,bgColor,textColor)
	local COL=S.ui.COL
	local BTN_W=S.ui.BTN_W
	local b=Instance.new("TextButton")
	b.Size=UDim2.fromOffset(BTN_W,28) b.Position=UDim2.fromOffset(4,y)
	b.BackgroundColor3=bgColor or COL.card b.BorderSizePixel=0
	b.Font=Enum.Font.GothamBold b.TextSize=12
	b.TextColor3=textColor or guiTextColor() b.Text=text b.ZIndex=6 b.Parent=parent
	addCorner(b,7)
	if not bgColor and not textColor then
		registerRepaint(function() b.TextColor3=guiTextColor() end)
	end
	local st=addStroke(b,bgColor or guiAccent(),1,0.55)
	if not bgColor then
		registerRepaint(function() st.Color=guiAccent() end)
	end
	b.MouseButton1Click:Connect(function() if S.unloaded then return end playClick() cb() end)
	return b
end
function S.ui.makeInput(parent,y,placeholder)
	local COL=S.ui.COL
	local BTN_W=S.ui.BTN_W
	local box=Instance.new("TextBox")
	box.Size=UDim2.fromOffset(BTN_W,26) box.Position=UDim2.fromOffset(4,y)
	box.BackgroundColor3=COL.card box.BorderSizePixel=0
	box.Font=Enum.Font.Gotham box.TextSize=12 box.TextColor3=guiTextColor()
	box.PlaceholderText=placeholder box.PlaceholderColor3=COL.textDim
	box.Text="" box.ClearTextOnFocus=false box.ZIndex=6 box.Parent=parent
	addCorner(box,7)
	registerRepaint(function() box.TextColor3=guiTextColor() end)
	local st=addStroke(box,COL.off,1,0.4)
	registerRepaint(function() st.Color=guiAccent() end)
	return box
end
function S.ui.colorRow(parent,y,label,getColor,setColorFn)
	local COL=S.ui.COL
	local BTN_W=S.ui.BTN_W
	local row=Instance.new("Frame")
	row.Size=UDim2.fromOffset(BTN_W,30) row.Position=UDim2.fromOffset(4,y)
	row.BackgroundTransparency=1 row.ZIndex=5 row.Parent=parent
	local lab=Instance.new("TextLabel")
	lab.Size=UDim2.fromOffset(120,30) lab.Position=UDim2.fromOffset(0,0)
	lab.BackgroundTransparency=1 lab.Font=Enum.Font.Gotham
	lab.TextSize=11 lab.TextXAlignment=Enum.TextXAlignment.Left
	lab.TextColor3=guiTextColor() lab.Text=label or "" lab.ZIndex=6 lab.Parent=row
	registerRepaint(function() lab.TextColor3=guiTextColor() end)
	local sw=Instance.new("Frame")
	sw.Size=UDim2.fromOffset(28,28) sw.Position=UDim2.fromOffset(BTN_W-148,1)
	sw.BorderSizePixel=0 sw.BackgroundColor3=getColor() sw.ZIndex=6 sw.Parent=row
	addCorner(sw,8)
	local sws=addStroke(sw,guiAccent(),1.5,0.2)
	registerRepaint(function() sws.Color=guiAccent() end)
	local cb=Instance.new("TextButton")
	cb.Size=UDim2.fromOffset(114,26) cb.Position=UDim2.fromOffset(BTN_W-116,2)
	cb.BackgroundColor3=COL.card cb.BorderSizePixel=0
	cb.Font=Enum.Font.GothamBold cb.TextSize=11
	cb.TextColor3=guiTextColor() cb.Text="Change color" cb.AutoButtonColor=false
	cb.ZIndex=6 cb.Parent=row
	registerRepaint(function() cb.TextColor3=guiTextColor() end)
	addCorner(cb,6)
	local cbs=addStroke(cb,guiAccent(),1,0.5)
	registerRepaint(function() cbs.Color=guiAccent() end)
	cb.MouseButton1Click:Connect(function()
		if S.unloaded then return end
		playClick()
		if S.colorPickerOpen then
			S.colorPickerOpen(getColor(),function(col)
				pcall(setColorFn,col)
				sw.BackgroundColor3=col
			end)
		end
	end)
	registerRepaint(function() sw.BackgroundColor3=getColor() end)
end
function S.ui.buildPanel()
	local COL=S.ui.COL
	local PANEL_W=S.ui.PANEL_W
	local PANEL_H=S.ui.PANEL_H
	local parentHolder=nil
	if gethui then local ok,h=pcall(gethui); if ok and h and typeof(h)=="Instance" then parentHolder=h end end
	if not parentHolder or typeof(parentHolder)~="Instance" then parentHolder=LP:FindFirstChildOfClass("PlayerGui") end
	if not parentHolder then parentHolder=LP:WaitForChild("PlayerGui",5) end
	if not parentHolder then parentHolder=game:GetService("CoreGui") end
	S.gui=Instance.new("ScreenGui")
	S.gui.Name="XD_x1oni1x_"..randStr(6)
	S.gui.ResetOnSpawn=false S.gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	S.gui.DisplayOrder=100000 S.gui.IgnoreGuiInset=true S.gui.Enabled=true
	pcall(function() S.gui.Parent=parentHolder end)
	if not S.gui.Parent then pcall(function() S.gui.Parent=game:GetService("CoreGui") end) end
	S.glow=Instance.new("Frame")
	S.glow.Size=UDim2.fromOffset(PANEL_W+40,PANEL_H+40)
	S.glow.Position=UDim2.new(0.5,-PANEL_W/2-20-800,0.5,-PANEL_H/2-20)
	S.glow.BackgroundColor3=guiAccent() S.glow.BackgroundTransparency=0.86
	S.glow.BorderSizePixel=0 S.glow.ZIndex=0 S.glow.Parent=S.gui
	addCorner(S.glow,22)
	registerRepaint(function() S.glow.BackgroundColor3=guiAccent() end)
	S.shadow=Instance.new("Frame")
	S.shadow.Size=UDim2.fromOffset(PANEL_W+12,PANEL_H+12)
	S.shadow.Position=UDim2.new(0.5,-PANEL_W/2+6-800,0.5,-PANEL_H/2+6)
	S.shadow.BackgroundColor3=Color3.fromRGB(0,0,0) S.shadow.BackgroundTransparency=0.65
	S.shadow.BorderSizePixel=0 S.shadow.ZIndex=1 S.shadow.Parent=S.gui
	addCorner(S.shadow,18)
	S.panel=Instance.new("Frame")
	S.panel.Size=UDim2.fromOffset(PANEL_W,PANEL_H)
	S.panel.Position=UDim2.new(0.5,-PANEL_W/2-800,0.5,-PANEL_H/2)
	S.panel.BackgroundColor3=COL.bg S.panel.BorderSizePixel=0
	S.panel.Active=true S.panel.Visible=true S.panel.ZIndex=2 S.panel.Parent=S.gui
	S.panel.ClipsDescendants=true
	addCorner(S.panel,14)
	addGrad(S.panel,COL.bg2,COL.bg,90)
	local pS=addStroke(S.panel,guiAccent(),1.4,0.35)
	registerRepaint(function() if not C.PanelRainbow then pS.Color=guiAccent() end end)
	track(S.panel:GetPropertyChangedSignal("Position"):Connect(function()
		S.shadow.Position=UDim2.new(S.panel.Position.X.Scale,S.panel.Position.X.Offset+6,S.panel.Position.Y.Scale,S.panel.Position.Y.Offset+6)
		S.glow.Position=UDim2.new(S.panel.Position.X.Scale,S.panel.Position.X.Offset-20,S.panel.Position.Y.Scale,S.panel.Position.Y.Offset-20)
	end))
	task.spawn(function()
		task.wait(0.05)
		if S.unloaded or not S.panel or not S.panel.Parent then return end
		local T=TweenInfo.new(0.9,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
		TweenService:Create(S.panel,T,{Position=UDim2.new(0.5,-PANEL_W/2,0.5,-PANEL_H/2)}):Play()
		if S.shadow and S.shadow.Parent then TweenService:Create(S.shadow,T,{Position=UDim2.new(0.5,-PANEL_W/2+6,0.5,-PANEL_H/2+6)}):Play() end
		if S.glow and S.glow.Parent then TweenService:Create(S.glow,T,{Position=UDim2.new(0.5,-PANEL_W/2-20,0.5,-PANEL_H/2-20)}):Play() end
	end)
	do
		local dragging=false
		local dragStart=nil
		local startPos=nil
		track(S.panel.InputBegan:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
				dragging=true dragStart=input.Position startPos=S.panel.Position
				input.Changed:Connect(function()
					if input.UserInputState==Enum.UserInputState.End then dragging=false end
				end)
			end
		end))
		track(UIS.InputChanged:Connect(function(input)
			if not dragging then return end
			if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
				local delta=input.Position-dragStart
				S.panel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
			end
		end))
	end
	local topGlow=Instance.new("Frame")
	topGlow.Size=UDim2.new(1,-28,0,2) topGlow.Position=UDim2.fromOffset(14,0)
	topGlow.BackgroundColor3=guiAccent() topGlow.BorderSizePixel=0
	topGlow.ZIndex=3 topGlow.Parent=S.panel
	addCorner(topGlow,2)
	registerRepaint(function() topGlow.BackgroundColor3=guiAccent() end)
	local title=Instance.new("TextLabel")
	title.Size=UDim2.fromOffset(240,20) title.Position=UDim2.fromOffset(14,12)
	title.BackgroundTransparency=1 title.Font=Enum.Font.GothamBlack
	title.TextSize=13 title.TextXAlignment=Enum.TextXAlignment.Left
	title.TextColor3=guiAccent() title.Text=SCRIPT_NAME title.ZIndex=3 title.Parent=S.panel
	registerRepaint(function() title.TextColor3=guiAccent() end)
	local statsLbl=Instance.new("TextLabel")
	statsLbl.Size=UDim2.fromOffset(140,40) statsLbl.Position=UDim2.new(1,-192,0,12)
	statsLbl.BackgroundTransparency=1 statsLbl.Font=Enum.Font.Code statsLbl.TextSize=10
	statsLbl.TextXAlignment=Enum.TextXAlignment.Right statsLbl.TextYAlignment=Enum.TextYAlignment.Top
	statsLbl.TextColor3=COL.textDim statsLbl.Text="fps ---\nping ---" statsLbl.ZIndex=3 statsLbl.Parent=S.panel
	local subtitle=Instance.new("TextLabel")
	subtitle.Size=UDim2.new(1,-20,0,12) subtitle.Position=UDim2.fromOffset(14,30)
	subtitle.BackgroundTransparency=1 subtitle.Font=Enum.Font.Gotham subtitle.TextSize=9
	subtitle.TextXAlignment=Enum.TextXAlignment.Left subtitle.TextColor3=guiTextColor()
	subtitle.Text="ink game - auto dodge" subtitle.ZIndex=3 subtitle.Parent=S.panel
	registerRepaint(function() subtitle.TextColor3=guiTextColor() end)
	local status=Instance.new("TextLabel")
	status.Size=UDim2.new(1,-20,0,12) status.Position=UDim2.fromOffset(14,44)
	status.BackgroundTransparency=1 status.Font=Enum.Font.Code status.TextSize=10
	status.TextXAlignment=Enum.TextXAlignment.Left status.TextColor3=guiTextColor()
	status.Text="ready - N to close" status.ZIndex=3 status.Parent=S.panel
	registerRepaint(function() status.TextColor3=guiTextColor() end)
	local collapseBtn=Instance.new("TextButton")
	collapseBtn.AnchorPoint=Vector2.new(1,0)
	collapseBtn.Size=UDim2.fromOffset(24,24) collapseBtn.Position=UDim2.new(1,-12,0,12)
	collapseBtn.BackgroundColor3=COL.card collapseBtn.BorderSizePixel=0
	collapseBtn.Font=Enum.Font.GothamBlack collapseBtn.TextSize=18
	collapseBtn.TextColor3=guiTextColor() collapseBtn.Text="-" collapseBtn.AutoButtonColor=false
	collapseBtn.ZIndex=12 collapseBtn.Parent=S.panel
	registerRepaint(function() collapseBtn.TextColor3=guiTextColor() end)
	addCorner(collapseBtn,6)
	local collapseStroke=addStroke(collapseBtn,guiAccent(),1.5,0)
	registerRepaint(function() collapseStroke.Color=guiAccent() end)
	local function statusCb(m) if not S.unloaded and status and status.Parent then status.Text=tostring(m or "") end end
	_G.__ad_statusCb=statusCb
	local fpsFrames=0
	local fpsAcc=tick()
	local currentFps=0
	track(RunService.RenderStepped:Connect(function()
		fpsFrames=fpsFrames+1
		local now=tick()
		if now-fpsAcc>=2 then
			currentFps=math.floor(fpsFrames/(now-fpsAcc))
			fpsFrames=0 fpsAcc=now
		end
	end))
	task.spawn(function()
		while not S.unloaded do
			local ping=0
			pcall(function()
				local item=StatsService.Network.ServerStatsItem["Data Ping"]
				if item then ping=math.floor(item:GetValue()) end
			end)
			if not S.unloaded and statsLbl and statsLbl.Parent then
				local jid=game.JobId or "" if #jid>8 then jid=jid:sub(1,8) end
				if jid=="" then jid="studio" end
				statsLbl.Text=string.format("fps %d\nping %d - srv %s",currentFps,ping,jid)
			end
			if not S.unloaded and S.wmLabel and C.Watermark then
				pcall(function()
					local name=tostring(LP.Name or "?")
					if #name>14 then name=name:sub(1,14).."..." end
					local key=(C.MenuKey and C.MenuKey.Name) or "N"
					S.wmLabel.Text=string.format("%s %s\n%s | %dms | [%s]",SCRIPT_NAME,SCRIPT_VERSION,name,ping,key)
				end)
			end
			if not S.unloaded and S.kbLabel and C.KeybindList then
				pcall(function()
					local kb={}
					if C.Enabled then table.insert(kb,"AutoDodge:  ON") end
					if H.Enabled then table.insert(kb,"HnS Dodge:  ON") end
					if C.RLGL_AutoDodge then table.insert(kb,"RLGL:  ON") end
					if C.RebelSilentAim then table.insert(kb,"Silent Aim:  ON") end
					if C.RebelNoRecoil then table.insert(kb,"No Recoil:  ON") end
					if C.RebelRapidFire then table.insert(kb,"Rapid Fire:  ON (x"..tostring(C.RebelRapidFireMult or 2)..")") end
					if C.RebelAimbot then table.insert(kb,"Aimbot:  ON") end
					if C.HitboxExpander then table.insert(kb,"Hitbox:  x"..tostring(C.HitboxSize or 3)) end
					if C.BulletTracer then table.insert(kb,"Bullet Tracer:  ON") end
					if C.InfiniteAmmo then table.insert(kb,"Inf Ammo:  ON") end
					if C.GuardESP then table.insert(kb,"Guard ESP:  ON") end
					if C.PlayerESP then table.insert(kb,"Player ESP:  ON") end
					if C.HideNick then table.insert(kb,"HideNick:  ON") end
					if C.FullBright then table.insert(kb,"Full Bright:  ON") end
					if C.RemoveFog then table.insert(kb,"No Fog:  ON") end
					if C.AutoBrew then table.insert(kb,"Auto Brew:  ON") end
					if C.AnimSpeed then table.insert(kb,"Anim 2.5x:  ON") end
					S.kbLabel.Text=(#kb==0) and "[no features]" or table.concat(kb,"\n")
					if S.kbFrame then
						local lines=math.max(1,#kb)
						S.kbFrame.Size=UDim2.fromOffset(210,math.max(30,lines*12+8))
					end
				end)
			end
			task.wait(3)
		end
	end)
	local tabBar=Instance.new("Frame")
	tabBar.Size=UDim2.new(1,-16,0,26) tabBar.Position=UDim2.fromOffset(8,58)
	tabBar.BackgroundColor3=COL.off tabBar.BackgroundTransparency=0.35
	tabBar.BorderSizePixel=0 tabBar.ZIndex=3 tabBar.Parent=S.panel
	addCorner(tabBar,8)
	local tabNames={"Main","HnS","Rebel","RLGL","ESP","Dalgona","Extra","Configs"}
	local content=Instance.new("Frame")
	content.Size=UDim2.fromOffset(S.ui.CONTENT_W,S.ui.CONTENT_H) content.Position=UDim2.fromOffset(8,88)
	content.BackgroundTransparency=1 content.ZIndex=4 content.Parent=S.panel
	for _,name in ipairs(tabNames) do
		local fr=Instance.new("ScrollingFrame")
		fr.Size=UDim2.fromOffset(S.ui.CONTENT_W,S.ui.CONTENT_H)
		fr.BackgroundTransparency=1 fr.BorderSizePixel=0
		fr.ScrollBarThickness=3 fr.ScrollBarImageColor3=guiAccent()
		fr.ScrollingDirection=Enum.ScrollingDirection.Y
		fr.CanvasSize=UDim2.fromOffset(0,5000)
		fr.ElasticBehavior=Enum.ElasticBehavior.Never
		fr.Visible=name=="Main" fr.ZIndex=5 fr.Parent=content
		registerRepaint(function() if fr and fr.Parent then fr.ScrollBarImageColor3=guiAccent() end end)
		S.ui.tabFrames[name]=fr
	end
	S.ui.showTab=function(name)
		S.ui.activeTab=name
		for n,fr in pairs(S.ui.tabFrames) do fr.Visible=n==name end
		repaintAll()
		if name=="Configs" and _G.__adRefreshConfigs then pcall(_G.__adRefreshConfigs) end
	end
	do
		local total=#tabNames
		local tabW=math.floor((S.ui.CONTENT_W-4)/total)
		local x=2
		for _,name in ipairs(tabNames) do
			local b=Instance.new("TextButton")
			b.Size=UDim2.fromOffset(tabW,22) b.Position=UDim2.fromOffset(x,2)
			b.BorderSizePixel=0 b.Font=Enum.Font.GothamBold b.TextSize=8
			b.Text=name b.AutoButtonColor=false b.ZIndex=4 b.Parent=tabBar
			b.TextTruncate=Enum.TextTruncate.AtEnd
			b.TextScaled=false
			addCorner(b,6)
			b.MouseButton1Click:Connect(function() playClick() S.ui.showTab(name) end)
			registerRepaint(function()
				local on=S.ui.activeTab==name
				b.BackgroundColor3=on and guiAccent() or COL.off
				b.BackgroundTransparency=on and 0 or 1
				b.TextColor3=on and Color3.new(1,1,1) or guiTextColor()
			end)
			x=x+tabW
		end
	end
	repaintAll()
	S.ui.collapseBtn=collapseBtn
	S.ui.buildColorPicker()
end
function S.ui.buildColorPicker()
	local COL=S.ui.COL
	local PANEL_W=S.ui.PANEL_W
	local PANEL_H=S.ui.PANEL_H
	local overlay=Instance.new("Frame")
	overlay.Size=UDim2.fromOffset(PANEL_W,PANEL_H)
	overlay.Position=UDim2.fromOffset(0,0)
	overlay.BackgroundColor3=COL.bg overlay.BackgroundTransparency=0.02
	overlay.Visible=false overlay.ZIndex=60 overlay.Parent=S.panel
	addCorner(overlay,14)
	addGrad(overlay,COL.bg2,COL.bg,90)
	S.ui.pickerOverlay=overlay
	local pickerTitle=Instance.new("TextLabel")
	pickerTitle.Size=UDim2.new(1,-40,0,22) pickerTitle.Position=UDim2.fromOffset(14,14)
	pickerTitle.BackgroundTransparency=1 pickerTitle.Font=Enum.Font.GothamBlack
	pickerTitle.TextSize=14 pickerTitle.TextXAlignment=Enum.TextXAlignment.Left
	pickerTitle.TextColor3=guiAccent() pickerTitle.Text="COLOR PICKER"
	pickerTitle.ZIndex=61 pickerTitle.Parent=overlay
	registerRepaint(function() pickerTitle.TextColor3=guiAccent() end)
	local pickerClose=Instance.new("TextButton")
	pickerClose.Size=UDim2.fromOffset(60,24) pickerClose.Position=UDim2.new(1,-74,0,12)
	pickerClose.BackgroundColor3=COL.card pickerClose.BorderSizePixel=0
	pickerClose.Font=Enum.Font.GothamBold pickerClose.TextSize=11
	pickerClose.TextColor3=guiTextColor() pickerClose.Text="X close"
	pickerClose.ZIndex=61 pickerClose.Parent=overlay
	registerRepaint(function() pickerClose.TextColor3=guiTextColor() end)
	addCorner(pickerClose,6)
	local pcS=addStroke(pickerClose,guiAccent(),1,0.5)
	registerRepaint(function() pcS.Color=guiAccent() end)
	local preview=Instance.new("Frame")
	preview.Size=UDim2.fromOffset(150,110) preview.Position=UDim2.new(0.5,-75,0,40)
	preview.BackgroundColor3=Color3.fromRGB(255,255,255) preview.BorderSizePixel=0
	preview.ZIndex=61 preview.Parent=overlay
	addCorner(preview,12)
	local pvS=addStroke(preview,guiAccent(),2,0)
	registerRepaint(function() pvS.Color=guiAccent() end)
	local hexLbl=Instance.new("TextLabel")
	hexLbl.Size=UDim2.new(1,0,0,18) hexLbl.Position=UDim2.new(0,0,1,-22)
	hexLbl.BackgroundTransparency=1 hexLbl.Font=Enum.Font.Code
	hexLbl.TextSize=11 hexLbl.TextColor3=Color3.fromRGB(255,255,255)
	hexLbl.TextStrokeTransparency=0.4 hexLbl.TextStrokeColor3=Color3.fromRGB(0,0,0)
	hexLbl.Text="#FFFFFF" hexLbl.ZIndex=62 hexLbl.Parent=preview

	local inputRow=Instance.new("Frame")
	inputRow.Size=UDim2.new(1,-28,0,32) inputRow.Position=UDim2.fromOffset(14,156)
	inputRow.BackgroundTransparency=1 inputRow.ZIndex=61 inputRow.Parent=overlay

	local inputBox=Instance.new("TextBox")
	inputBox.Size=UDim2.new(1,-70,1,0) inputBox.Position=UDim2.fromOffset(0,0)
	inputBox.BackgroundColor3=COL.card inputBox.BorderSizePixel=0
	inputBox.Font=Enum.Font.Code inputBox.TextSize=12
	inputBox.TextColor3=guiTextColor()
	inputBox.PlaceholderText="#RRGGBB or 255,0,128"
	inputBox.PlaceholderColor3=COL.textDim
	inputBox.Text="" inputBox.ClearTextOnFocus=false
	inputBox.ZIndex=62 inputBox.Parent=inputRow
	addCorner(inputBox,6)
	registerRepaint(function() inputBox.TextColor3=guiTextColor() end)
	addStroke(inputBox,guiAccent(),1,0.4)

	local applyBtn=Instance.new("TextButton")
	applyBtn.Size=UDim2.fromOffset(64,32) applyBtn.Position=UDim2.new(1,-64,0,0)
	applyBtn.BackgroundColor3=guiAccent() applyBtn.BorderSizePixel=0
	applyBtn.Font=Enum.Font.GothamBold applyBtn.TextSize=11
	applyBtn.TextColor3=Color3.fromRGB(255,255,255) applyBtn.Text="Set"
	applyBtn.ZIndex=62 applyBtn.Parent=inputRow
	addCorner(applyBtn,6)
	registerRepaint(function() applyBtn.BackgroundColor3=guiAccent() end)

	local st={R=255,G=255,B=255,bright=1,callback=nil}
	local function apply(v) return math.clamp(math.floor(v*st.bright+0.5),0,255) end
	local rS,gS,bS,brS
	local function updPrev()
		local r=apply(st.R) local g=apply(st.G) local b=apply(st.B)
		preview.BackgroundColor3=Color3.fromRGB(r,g,b)
		hexLbl.Text=string.format("#%02X%02X%02X  x%.2f",r,g,b,st.bright)
	end
	local function setFromInput()
		local txt=tostring(inputBox.Text or ""):gsub("%s","")
		if txt=="" then return end
		local r,g,b
		local hex=txt:gsub("^#","")
		if #hex==6 and hex:match("^%x+$") then
			r=tonumber(hex:sub(1,2),16)
			g=tonumber(hex:sub(3,4),16)
			b=tonumber(hex:sub(5,6),16)
		else
			local rr,gg,bb=txt:match("^(%d+)[,;:]+(%d+)[,;:]+(%d+)$")
			if rr then
				r=tonumber(rr) g=tonumber(gg) b=tonumber(bb)
			end
		end
		if r and g and b then
			r=math.clamp(r,0,255) g=math.clamp(g,0,255) b=math.clamp(b,0,255)
			st.R=r st.G=g st.B=b st.bright=1
			if rS then rS() end
			if gS then gS() end
			if bS then bS() end
			if brS then brS() end
			updPrev()
		else
			inputBox.Text=""
			inputBox.PlaceholderText="wrong format"
		end
	end
	inputBox.FocusLost:Connect(setFromInput)
	inputBox:GetPropertyChangedSignal("Text"):Connect(function()
		local t=tostring(inputBox.Text or ""):gsub("%s","")
		local hex=t:gsub("^#","")
		if #hex==6 and hex:match("^%x+$") then setFromInput() end
	end)
	applyBtn.MouseButton1Click:Connect(function()
		playClick()
		setFromInput()
	end)

	local function buildSlider(y,label,field,tintColor,minV,maxV)
		local row=Instance.new("Frame")
		row.Size=UDim2.new(1,-28,0,46) row.Position=UDim2.fromOffset(14,y)
		row.BackgroundTransparency=1 row.ZIndex=61 row.Parent=overlay
		local lab=Instance.new("TextLabel")
		lab.Size=UDim2.new(1,-60,0,16) lab.BackgroundTransparency=1
		lab.Font=Enum.Font.GothamBold lab.TextSize=11
		lab.TextXAlignment=Enum.TextXAlignment.Left lab.TextColor3=guiTextColor()
		lab.Text=label lab.ZIndex=62 lab.Parent=row
		local valLbl=Instance.new("TextLabel")
		valLbl.Size=UDim2.fromOffset(60,16) valLbl.Position=UDim2.new(1,-60,0,0)
		valLbl.BackgroundTransparency=1 valLbl.Font=Enum.Font.Code
		valLbl.TextSize=11 valLbl.TextXAlignment=Enum.TextXAlignment.Right
		valLbl.TextColor3=guiTextColor() valLbl.Text="255" valLbl.ZIndex=62 valLbl.Parent=row
		local bar=Instance.new("TextButton")
		bar.Size=UDim2.new(1,0,0,18) bar.Position=UDim2.fromOffset(0,20)
		bar.BackgroundColor3=COL.card bar.BorderSizePixel=0
		bar.Text="" bar.AutoButtonColor=false bar.ZIndex=62 bar.Parent=row
		addCorner(bar,6)
		local fill=Instance.new("Frame")
		fill.Size=UDim2.new(1,0,1,0) fill.BorderSizePixel=0 fill.ZIndex=63 fill.Parent=bar
		addCorner(fill,6)
		fill.BackgroundColor3=tintColor
		local thumb=Instance.new("Frame")
		thumb.Size=UDim2.fromOffset(14,14) thumb.BackgroundColor3=Color3.new(1,1,1)
		thumb.BorderSizePixel=0 thumb.ZIndex=64 thumb.Parent=bar
		addCorner(thumb,7)
		addStroke(thumb,Color3.new(0,0,0),1,0.4)
		local dragging=false
		local function upd()
			local v=st[field]
			local rel=(v-minV)/(maxV-minV)
			thumb.Position=UDim2.new(rel,-7,0.5,-7)
			if maxV<=3 then valLbl.Text=string.format("%.2f",v)
			else valLbl.Text=tostring(math.floor(v+0.5)) end
		end
		upd()
		local function setFromX(x)
			local rel=math.clamp((x-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1)
			local raw=minV+rel*(maxV-minV)
			if maxV<=3 then st[field]=math.floor(raw*100+0.5)/100
			else st[field]=math.floor(raw+0.5) end
			upd() updPrev()
		end
		bar.InputBegan:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
				dragging=true setFromX(input.Position.X)
			end
		end)
		track(UIS.InputEnded:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
		end))
		track(UIS.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then setFromX(input.Position.X) end
		end))
		return upd
	end
	rS=buildSlider(196,"Red","R",Color3.fromRGB(255,60,60),0,255)
	gS=buildSlider(248,"Green","G",Color3.fromRGB(80,255,100),0,255)
	bS=buildSlider(300,"Blue","B",Color3.fromRGB(80,140,255),0,255)
	brS=buildSlider(352,"Brightness x","bright",Color3.fromRGB(255,255,255),0,2)
	local okBtn=Instance.new("TextButton")
	okBtn.Size=UDim2.fromOffset(140,34) okBtn.Position=UDim2.new(0,14,0,410)
	okBtn.BackgroundColor3=guiAccent() okBtn.BorderSizePixel=0
	okBtn.Font=Enum.Font.GothamBlack okBtn.TextSize=13
	okBtn.TextColor3=Color3.fromRGB(255,255,255) okBtn.Text="APPLY"
	okBtn.ZIndex=61 okBtn.Parent=overlay
	addCorner(okBtn,8)
	registerRepaint(function() okBtn.BackgroundColor3=guiAccent() end)
	local cancelBtn=Instance.new("TextButton")
	cancelBtn.Size=UDim2.fromOffset(140,34) cancelBtn.Position=UDim2.new(1,-154,0,410)
	cancelBtn.BackgroundColor3=COL.card cancelBtn.BorderSizePixel=0
	cancelBtn.Font=Enum.Font.GothamBold cancelBtn.TextSize=13
	cancelBtn.TextColor3=guiTextColor() cancelBtn.Text="Cancel"
	cancelBtn.ZIndex=61 cancelBtn.Parent=overlay
	addCorner(cancelBtn,8)
	local cnS=addStroke(cancelBtn,guiAccent(),1,0.5)
	registerRepaint(function() cnS.Color=guiAccent() end)
	local function close() overlay.Visible=false st.callback=nil end
	pickerClose.MouseButton1Click:Connect(function() playClick() close() end)
	cancelBtn.MouseButton1Click:Connect(function() playClick() close() end)
	okBtn.MouseButton1Click:Connect(function()
		playClick()
		if st.callback then
			local r=apply(st.R) local g=apply(st.G) local b=apply(st.B)
			pcall(st.callback,Color3.fromRGB(r,g,b))
		end
		close()
	end)
	S.colorPickerOpen=function(initialColor,onApply)
		st.R=math.floor(initialColor.R*255+0.5)
		st.G=math.floor(initialColor.G*255+0.5)
		st.B=math.floor(initialColor.B*255+0.5)
		st.bright=1 st.callback=onApply
		rS() gS() bS() brS()
		updPrev()
		inputBox.Text=""
		inputBox.PlaceholderText="#RRGGBB or 255,0,128"
		overlay.Visible=true
	end
	updPrev()
end
function S.ui.buildMain()
	local M=S.ui.tabFrames.Main
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeInput=S.ui.makeInput
	local colorRow=S.ui.colorRow
	mkDivider(M,0,"Auto Dodge")
	makeToggle(M,22,"Ultra Instinct","Enabled",nil,nil,C)
	makeSlider(M,52,"Radius (studs)","Distance",1,95,1,C,function()
		if C.RadiusVis or H.RadiusVis then makeViz() end
	end)
	makeSlider(M,96,"Delay (s)","Delay",0,0.25,0.01,C)
	makeSlider(M,140,"Min interval (s)","MinInterval",0.02,1.0,0.01,C)
	makeSlider(M,184,"Anim watch min (s)","AnimWatch",0.05,2.0,0.05,C)
	makeSlider(M,228,"Watch after anim (s)","WatchAfter",0,1.5,0.05,C)
	mkDivider(M,274,"Radius visualizer")
	makeToggle(M,296,"Show radius","RadiusVis",nil,nil,C)
	makeSlider(M,326,"Visibility","RadiusTransparency",0.15,0.95,0.05,C,function()
		if C.RadiusVis or H.RadiusVis then makeViz() end
	end)
	colorRow(M,370,"Radius color",uiRadiusColor,function(col)
		C.RadiusR=math.floor(col.R*255+0.5)
		C.RadiusG=math.floor(col.G*255+0.5)
		C.RadiusB=math.floor(col.B*255+0.5)
		if C.RadiusVis then makeViz() end
	end)
	mkDivider(M,410,"Slot (optional)")
	local uiSlotBox=makeInput(M,430,"auto = leave empty")
	uiSlotBox.Text=C.ManualUISlot or ""
	uiSlotBox:GetPropertyChangedSignal("Text"):Connect(function()
		if S.unloaded then return end
		C.ManualUISlot=string.upper(uiSlotBox.Text or "")
	end)
end
function S.ui.buildHnS()
	local Hs=S.ui.tabFrames.HnS
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeInput=S.ui.makeInput
	local colorRow=S.ui.colorRow
	mkDivider(Hs,0,"HnS Dodge")
	makeToggle(Hs,22,"HnS Dodge","Enabled",nil,nil,H)
	makeToggle(Hs,52,"Strict mode","HollyMode",nil,nil,H)
	makeSlider(Hs,82,"Radius (studs)","Distance",1,95,1,H,function()
		if C.RadiusVis or H.RadiusVis then makeViz() end
	end)
	makeSlider(Hs,126,"Delay (s)","Delay",0,0.25,0.01,H)
	makeSlider(Hs,170,"Min interval (s)","MinInterval",0.02,1.0,0.01,H)
	makeSlider(Hs,214,"Anim watch min (s)","AnimWatch",0.05,2.0,0.05,H)
	makeSlider(Hs,258,"Watch after anim (s)","WatchAfter",0,1.5,0.05,H)
	mkDivider(Hs,304,"Radius visualizer")
	makeToggle(Hs,326,"Show radius","RadiusVis",nil,nil,H)
	makeSlider(Hs,356,"Visibility","RadiusTransparency",0.15,0.95,0.05,H,function()
		if C.RadiusVis or H.RadiusVis then makeViz() end
	end)
	colorRow(Hs,400,"HnS color",hnsRadiusColor,function(col)
		H.RadiusR=math.floor(col.R*255+0.5)
		H.RadiusG=math.floor(col.G*255+0.5)
		H.RadiusB=math.floor(col.B*255+0.5)
		if H.RadiusVis then makeViz() end
	end)
	mkDivider(Hs,440,"Slot (optional)")
	local hnsSlotBox=makeInput(Hs,460,"auto = leave empty")
	hnsSlotBox.Text=C.ManualHnSSlot or ""
	hnsSlotBox:GetPropertyChangedSignal("Text"):Connect(function()
		if S.unloaded then return end
		C.ManualHnSSlot=string.upper(hnsSlotBox.Text or "")
	end)
end
function S.ui.buildRebel()
	local Rb=S.ui.tabFrames.Rebel
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeBtn=S.ui.makeBtn
	local makeInput=S.ui.makeInput
	local colorRow=S.ui.colorRow
	mkDivider(Rb,0,"Silent Aim")
	makeToggle(Rb,22,"Silent Aim","RebelSilentAim",nil,function(v) C.RebelSilentAim=v if v then hookCombat() end end,C)
	makeToggle(Rb,52,"FOV Circle","RebelFOVCircle",nil,function(v) C.RebelFOVCircle=v makeFOVCircle() end,C)
	makeToggle(Rb,82,"Neon glow","RebelFOVNeon",nil,function(v) C.RebelFOVNeon=v makeFOVCircle() end,C)
	makeToggle(Rb,112,"Black outline","RebelFOVBlackOutline",nil,function(v) C.RebelFOVBlackOutline=v makeFOVCircle() end,C)
	makeSlider(Rb,144,"Outline thickness","RebelFOV_OutlineThickness",1,20,1,C,refreshFOVCircle)
	colorRow(Rb,188,"Outline color",rebelOutlineColor,function(col)
		C.RebelFOV_OutlineR=math.floor(col.R*255+0.5)
		C.RebelFOV_OutlineG=math.floor(col.G*255+0.5)
		C.RebelFOV_OutlineB=math.floor(col.B*255+0.5)
		C.FOVRainbow=false stopFovRainbow() makeFOVCircle()
	end)
	makeSlider(Rb,230,"FOV radius (px)","RebelFOV",10,1200,5,C,refreshFOVCircle)
	makeSlider(Rb,274,"Circle line width","RebelFOVCircleWidth",0.5,15,0.1,C,refreshFOVCircle)
	colorRow(Rb,318,"FOV color",rebelFOVColor,function(col)
		C.RebelFOVR=math.floor(col.R*255+0.5)
		C.RebelFOVG=math.floor(col.G*255+0.5)
		C.RebelFOVB=math.floor(col.B*255+0.5)
		C.FOVUseCustom=false C.FOVRainbow=false stopFovRainbow() makeFOVCircle()
	end)
	mkDivider(Rb,358,"FOV Rainbow (6 modes)")
	local fovRainbowPaint=makeToggle(Rb,380,"Rainbow FOV","FOVRainbow",nil,function(v) if v then startFovRainbow() else stopFovRainbow() makeFOVCircle() end end,C)
	S.ui.fovRainbowPaint=fovRainbowPaint
	makeSlider(Rb,410,"Blend speed","RebelFOVBlendSpeed",0.1,3.0,0.05,C)
	local function setFovMode(modeNum)
		C.FOVRainbowMode=modeNum
		C.FOVRainbow=true
		if S.ui.fovRainbowPaint then pcall(S.ui.fovRainbowPaint) end
		makeFOVCircle()
		startFovRainbow()
	end
	makeBtn(Rb,454,"Mode 1: Cycle hue",function() setFovMode(1) end)
	makeBtn(Rb,486,"Mode 2: Wave",function() setFovMode(2) end)
	makeBtn(Rb,518,"Mode 3: Gradient blend",function() setFovMode(3) end)
	makeBtn(Rb,550,"Mode 4: Breathing pulse",function() setFovMode(4) end)
	makeBtn(Rb,582,"Mode 5: Aurora",function() setFovMode(5) end)
	makeBtn(Rb,614,"Mode 6: FUSION",function() setFovMode(6) end)
	mkDivider(Rb,656,"Custom FOV colors (1-9)")
	makeToggle(Rb,678,"Use custom color","FOVUseCustom",nil,function(v) makeFOVCircle() if C.FOVRainbow then startFovRainbow() end end,C)
	local function cg(idx)
		return function()
			local r,g,b=60,60,255
			if idx==1 then r,g,b=C.FOVCustomR1 or 255,C.FOVCustomG1 or 60,C.FOVCustomB1 or 60
			elseif idx==2 then r,g,b=C.FOVCustomR2 or 60,C.FOVCustomG2 or 255,C.FOVCustomB2 or 60
			elseif idx==3 then r,g,b=C.FOVCustomR3 or 60,C.FOVCustomG3 or 140,C.FOVCustomB3 or 255
			elseif idx==4 then r,g,b=C.FOVCustomR4 or 255,C.FOVCustomG4 or 255,C.FOVCustomB4 or 60
			elseif idx==5 then r,g,b=C.FOVCustomR5 or 255,C.FOVCustomG5 or 60,C.FOVCustomB5 or 255
			elseif idx==6 then r,g,b=C.FOVCustomR6 or 60,C.FOVCustomG6 or 255,C.FOVCustomB6 or 255
			elseif idx==7 then r,g,b=C.FOVCustomR7 or 255,C.FOVCustomG7 or 180,C.FOVCustomB7 or 60
			elseif idx==8 then r,g,b=C.FOVCustomR8 or 255,C.FOVCustomG8 or 255,C.FOVCustomB8 or 255
			elseif idx==9 then r,g,b=C.FOVCustomR9 or 180,C.FOVCustomG9 or 60,C.FOVCustomB9 or 255 end
			return Color3.fromRGB(r,g,b)
		end
	end
	local function cs(idx)
		return function(col)
			local r,g,b=math.floor(col.R*255+0.5),math.floor(col.G*255+0.5),math.floor(col.B*255+0.5)
			if idx==1 then C.FOVCustomR1,C.FOVCustomG1,C.FOVCustomB1=r,g,b
			elseif idx==2 then C.FOVCustomR2,C.FOVCustomG2,C.FOVCustomB2=r,g,b
			elseif idx==3 then C.FOVCustomR3,C.FOVCustomG3,C.FOVCustomB3=r,g,b
			elseif idx==4 then C.FOVCustomR4,C.FOVCustomG4,C.FOVCustomB4=r,g,b
			elseif idx==5 then C.FOVCustomR5,C.FOVCustomG5,C.FOVCustomB5=r,g,b
			elseif idx==6 then C.FOVCustomR6,C.FOVCustomG6,C.FOVCustomB6=r,g,b
			elseif idx==7 then C.FOVCustomR7,C.FOVCustomG7,C.FOVCustomB7=r,g,b
			elseif idx==8 then C.FOVCustomR8,C.FOVCustomG8,C.FOVCustomB8=r,g,b
			elseif idx==9 then C.FOVCustomR9,C.FOVCustomG9,C.FOVCustomB9=r,g,b end
			if C.FOVUseCustom then makeFOVCircle() if C.FOVRainbow then startFovRainbow() end end
		end
	end
	for i=1,9 do
		local yy=710+(i-1)*62
		colorRow(Rb,yy,"Slot "..i,cg(i),cs(i))
		makeBtn(Rb,yy+32,"Use slot "..i,function() C.FOVCustomIdx=i C.FOVUseCustom=true makeFOVCircle() if C.FOVRainbow then startFovRainbow() end end)
	end
	mkDivider(Rb,1278,"Target filter")
	makeToggle(Rb,1300,"Target players","RebelTargetPlayers",nil,nil,C)
	makeToggle(Rb,1330,"Target game guards (NPC)","RebelTargetNPCs",nil,nil,C)
	mkDivider(Rb,1366,"Body parts (random)")
	makeToggle(Rb,1388,"Head","RebelBodyHead",nil,nil,C)
	makeToggle(Rb,1418,"Torso","RebelBodyTorso",nil,nil,C)
	makeToggle(Rb,1448,"HumanoidRootPart","RebelBodyHRP",nil,nil,C)
	makeToggle(Rb,1478,"Left Arm","RebelBodyLeftArm",nil,nil,C)
	makeToggle(Rb,1508,"Right Arm","RebelBodyRightArm",nil,nil,C)
	makeToggle(Rb,1538,"Left Leg","RebelBodyLeftLeg",nil,nil,C)
	makeToggle(Rb,1568,"Right Leg","RebelBodyRightLeg",nil,nil,C)
	mkDivider(Rb,1604,"Aimbot")
	makeToggle(Rb,1626,"Enable Aimbot","RebelAimbot",nil,function(v) C.RebelAimbot=v if v then startAimbot() else stopAimbot() end end,C)
	makeToggle(Rb,1656,"Hold RMB to aim (off=always)","RebelAimbotHoldKey",nil,nil,C)
	makeToggle(Rb,1686,"Target game guards (NPC)","RebelAimbotTargetGuards",nil,nil,C)
	makeSlider(Rb,1716,"Aimbot smooth (0=instant, 5=slow)","RebelAimbotSmooth",0.05,5.0,0.05,C)
	mkDivider(Rb,1760,"Gun mods")
	makeToggle(Rb,1782,"No Recoil & Spread","RebelNoRecoil",nil,function(v) C.RebelNoRecoil=v if v then hookCombat() end end,C)
	makeToggle(Rb,1812,"Rapid Fire","RebelRapidFire",nil,function(v) C.RebelRapidFire=v if v then hookCombat() end end,C)
	makeSlider(Rb,1842,"Rapid mult (1-50)","RebelRapidFireMult",1,50,1,C)
	mkDivider(Rb,1888,"Infinite Ammo")
	makeToggle(Rb,1910,"Infinite Ammo","InfiniteAmmo",nil,nil,C)
	makeSlider(Rb,1940,"Ammo value","InfiniteAmmoValue",10,9999,1,C)
	mkDivider(Rb,1986,"Hitbox Expander")
	makeToggle(Rb,2008,"Enable Hitbox Expander","HitboxExpander",nil,nil,C)
	makeToggle(Rb,2038,"Visualize hitbox","HitboxVisualize",nil,nil,C)
	makeSlider(Rb,2068,"Hitbox size (x mult)","HitboxSize",1,10,0.5,C)
	makeSlider(Rb,2112,"Max distance (studs, 0=all)","HitboxDistance",0,2000,50,C)
	colorRow(Rb,2156,"Hitbox color",function()
		return Color3.fromRGB(C.HitboxColorR or 255,C.HitboxColorG or 80,C.HitboxColorB or 80)
	end,function(col)
		C.HitboxColorR=math.floor(col.R*255+0.5)
		C.HitboxColorG=math.floor(col.G*255+0.5)
		C.HitboxColorB=math.floor(col.B*255+0.5)
	end)
	makeSlider(Rb,2198,"Visual transparency","HitboxTransparency",0.3,0.98,0.02,C)
	local hbTargetBtn
	hbTargetBtn=makeBtn(Rb,2242,"Targets: "..tostring(C.HitboxTargets or "All"),function()
		local cycle={All="Guards",Guards="Players",Players="All"}
		C.HitboxTargets=cycle[C.HitboxTargets or "All"] or "All"
		if hbTargetBtn then hbTargetBtn.Text="Targets: "..tostring(C.HitboxTargets) end
		HB_restoreAll()
	end)
	mkDivider(Rb,2284,"Bullet tracer")
	makeToggle(Rb,2306,"Enable Bullet Tracer","BulletTracer",nil,nil,C)
	makeToggle(Rb,2336,"Glow","BulletTracerGlow",nil,nil,C)
	makeToggle(Rb,2366,"White core","BulletTracerWhiteCore",nil,nil,C)
	colorRow(Rb,2396,"Tracer color",function()
		return Color3.fromRGB(C.BulletTracerR,C.BulletTracerG,C.BulletTracerB)
	end,function(col)
		C.BulletTracerR=math.floor(col.R*255+0.5)
		C.BulletTracerG=math.floor(col.G*255+0.5)
		C.BulletTracerB=math.floor(col.B*255+0.5)
	end)
	makeSlider(Rb,2438,"Thickness","BulletTracerThickness",0.05,1.0,0.01,C)
	makeSlider(Rb,2482,"Speed (studs/s)","BulletTracerSpeed",50,5000,50,C)
	makeSlider(Rb,2526,"Lifetime (s)","BulletTracerLifetime",0.1,5.0,0.05,C)
	makeSlider(Rb,2570,"Range (studs)","BulletTracerRange",50,2000,25,C)
	makeSlider(Rb,2614,"Start offset","BulletTracerStartOffset",0,5,0.1,C)
	makeSlider(Rb,2658,"End offset","BulletTracerEndOffset",0,5,0.1,C)
	makeSlider(Rb,2702,"Opacity","BulletTracerOpacity",0,0.5,0.01,C)
	makeSlider(Rb,2746,"Cooldown (s)","BulletTracerCooldown",0.01,0.5,0.01,C)
	local btFadeLabels={"Quad","Linear","Expo","Back","Circ","Sine","Quint","Bounce","Elastic"}
	makeBtn(Rb,2790,"Fade: "..btFadeLabels[C.BulletTracerFadeIdx or 1],function()
		C.BulletTracerFadeIdx=(C.BulletTracerFadeIdx or 1)+1
		if C.BulletTracerFadeIdx>#btFadeLabels then C.BulletTracerFadeIdx=1 end
	end)
	mkDivider(Rb,2832,"Auto Brew (Soda Fountain)")
	makeToggle(Rb,2854,"Auto brew + collect","AutoBrew",nil,function(v) if v then startBrewLoop() else stopBrewLoop() end end,C)
	local brewSlotBox=makeInput(Rb,2884,"brew key (E)")
	brewSlotBox.Text=C.AutoBrewSlot or "E"
	brewSlotBox:GetPropertyChangedSignal("Text"):Connect(function()
		if S.unloaded then return end
		local v=string.upper(brewSlotBox.Text or "E")
		if v=="" then v="E" end
		C.AutoBrewSlot=v
	end)
	makeSlider(Rb,2916,"Brew cooldown (s)","AutoBrewInterval",5,300,5,C)
	makeSlider(Rb,2960,"Brew delay (wait after reset)","AutoBrewBrewDelay",0,15,0.5,C)
	makeSlider(Rb,3004,"Extra delay before collect","AutoBrewDelayCollect",0,10,0.1,C)
	makeSlider(Rb,3048,"Collect hold (s)","AutoBrewCollectHold",0.5,5,0.1,C)
end
function S.ui.buildRLGL()
	local R=S.ui.tabFrames.RLGL
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	mkDivider(R,0,"RLGL Auto Dodge")
	makeToggle(R,22,"RLGL Auto Dodge","RLGL_AutoDodge")
	makeToggle(R,52,"Only on red light","RLGL_OnlyRedLight")
	makeToggle(R,82,"Auto-dodge after timer 0","RLGL_TimerEndDodge")
	mkDivider(R,118,"Red light tuning")
	makeSlider(R,140,"Delay after red (s)","RLGL_RedDelay",0.05,2.0,0.05,C)
	makeSlider(R,184,"Interval (s)","RLGL_MinInterval",0.05,2.0,0.05,C)
	makeSlider(R,228,"Velocity threshold","RLGL_VelThreshold",0.1,8.0,0.1,C)
	mkDivider(R,274,"Timer-end tuning")
	makeSlider(R,296,"Delay after 0 (s)","RLGL_TimerEndDelay",0,3.0,0.05,C)
	makeSlider(R,340,"Interval between (s)","RLGL_TimerEndInterval",0.05,2.0,0.05,C)
	makeSlider(R,384,"Max duration (s)","RLGL_TimerEndMaxDuration",3,30,1,C)
end
function S.ui.buildESP()
	local St=S.ui.tabFrames.ESP
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeBtn=S.ui.makeBtn
	local makeInput=S.ui.makeInput
	local colorRow=S.ui.colorRow
	mkDivider(St,0,"Playable Guard ESP")
	makeToggle(St,22,"Playable Guard ESP","GuardESP")
	makeToggle(St,52,"Show HP bar","GuardESP_HP")
	makeToggle(St,82,"Show Name","GuardESP_Name")
	makeToggle(St,112,"Show Highlight (chams)","GuardESP_Highlight")
	makeToggle(St,142,"Show Tracer","GuardESP_Tracer")
	makeToggle(St,172,"Show Box (2D)","GuardESP_Box")
	makeToggle(St,202,"HP chip colored BG","GuardESP_HP_ChipBg",nil,nil,C)
	makeToggle(St,232,"Show Tool (under feet)","GuardESP_Tool")
	makeToggle(St,262,"Show Distance (right)","GuardESP_Distance")
	makeToggle(St,292,"Force ALL as Guard (debug)","GuardESP_ForceAll")
	makeSlider(St,322,"Name size","GuardESP_NameSize",8,32,1,C)
	makeSlider(St,366,"Max distance (studs)","GuardESP_MaxDist",0,1000,10,C,updateESP)
	makeSlider(St,410,"Box thickness","GuardESP_BoxThickness",1,6,0.5,C)
	mkDivider(St,454,"Guard accent color")
	colorRow(St,476,"Guard accent",guardESPColor,function(col)
		C.GuardESP_ColorR=math.floor(col.R*255+0.5)
		C.GuardESP_ColorG=math.floor(col.G*255+0.5)
		C.GuardESP_ColorB=math.floor(col.B*255+0.5)
		if C.GuardESP then updateESP() end
	end)
	colorRow(St,508,"Guard tracer",guardTracerColor,function(col)
		C.GuardESP_TracerR=math.floor(col.R*255+0.5)
		C.GuardESP_TracerG=math.floor(col.G*255+0.5)
		C.GuardESP_TracerB=math.floor(col.B*255+0.5)
	end)
	colorRow(St,540,"Guard box",guardBoxColor,function(col)
		C.GuardESP_BoxR=math.floor(col.R*255+0.5)
		C.GuardESP_BoxG=math.floor(col.G*255+0.5)
		C.GuardESP_BoxB=math.floor(col.B*255+0.5)
	end)
	mkDivider(St,582,"Guard HP chip (4 states)")
	makeToggle(St,604,"Black outline (chip + number)","GuardESP_HP_Outline",nil,nil,C)
	colorRow(St,636,"State 1 (>75%)",guardChipState1,function(c) C.GuardESP_HP_State1_R=math.floor(c.R*255+0.5) C.GuardESP_HP_State1_G=math.floor(c.G*255+0.5) C.GuardESP_HP_State1_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,668,"State 2 (50-75%)",guardChipState2,function(c) C.GuardESP_HP_State2_R=math.floor(c.R*255+0.5) C.GuardESP_HP_State2_G=math.floor(c.G*255+0.5) C.GuardESP_HP_State2_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,700,"State 3 (25-50%)",guardChipState3,function(c) C.GuardESP_HP_State3_R=math.floor(c.R*255+0.5) C.GuardESP_HP_State3_G=math.floor(c.G*255+0.5) C.GuardESP_HP_State3_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,732,"State 4 (<25%)",guardChipState4,function(c) C.GuardESP_HP_State4_R=math.floor(c.R*255+0.5) C.GuardESP_HP_State4_G=math.floor(c.G*255+0.5) C.GuardESP_HP_State4_B=math.floor(c.B*255+0.5) updateESP() end)
	mkDivider(St,776,"Guard HP gradient (vertical bar)")
	local function ghR() return Color3.fromRGB(C.GuardESP_HP_TopR or 80,C.GuardESP_HP_TopG or 255,C.GuardESP_HP_TopB or 80) end
	local function ghM1() return Color3.fromRGB(C.GuardESP_HP_M1R or 180,C.GuardESP_HP_M1G or 255,C.GuardESP_HP_M1B or 60) end
	local function ghM2() return Color3.fromRGB(C.GuardESP_HP_M2R or 255,C.GuardESP_HP_M2G or 200,C.GuardESP_HP_M2B or 40) end
	local function ghM3() return Color3.fromRGB(C.GuardESP_HP_M3R or 255,C.GuardESP_HP_M3G or 120,C.GuardESP_HP_M3B or 60) end
	local function ghRB() return Color3.fromRGB(C.GuardESP_HP_BotR or 255,C.GuardESP_HP_BotG or 40,C.GuardESP_HP_BotB or 40) end
	colorRow(St,798,"Top",ghR,function(c) C.GuardESP_HP_TopR=math.floor(c.R*255+0.5) C.GuardESP_HP_TopG=math.floor(c.G*255+0.5) C.GuardESP_HP_TopB=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,830,"Mid1",ghM1,function(c) C.GuardESP_HP_M1R=math.floor(c.R*255+0.5) C.GuardESP_HP_M1G=math.floor(c.G*255+0.5) C.GuardESP_HP_M1B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,862,"Mid2",ghM2,function(c) C.GuardESP_HP_M2R=math.floor(c.R*255+0.5) C.GuardESP_HP_M2G=math.floor(c.G*255+0.5) C.GuardESP_HP_M2B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,894,"Mid3",ghM3,function(c) C.GuardESP_HP_M3R=math.floor(c.R*255+0.5) C.GuardESP_HP_M3G=math.floor(c.G*255+0.5) C.GuardESP_HP_M3B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,926,"Bottom",ghRB,function(c) C.GuardESP_HP_BotR=math.floor(c.R*255+0.5) C.GuardESP_HP_BotG=math.floor(c.G*255+0.5) C.GuardESP_HP_BotB=math.floor(c.B*255+0.5) updateESP() end)
	mkDivider(St,970,"Player ESP")
	makeToggle(St,992,"Player ESP","PlayerESP")
	makeToggle(St,1022,"Show HP bar","PlayerESP_HP")
	makeToggle(St,1052,"Show Name","PlayerESP_Name")
	makeToggle(St,1082,"Show Highlight (chams)","PlayerESP_Highlight")
	makeToggle(St,1112,"Show Tracer","PlayerESP_Tracer")
	makeToggle(St,1142,"Show Box (2D)","PlayerESP_Box")
	makeToggle(St,1172,"HP chip colored BG","PlayerESP_HP_ChipBg",nil,nil,C)
	makeToggle(St,1202,"Show Tool (under feet)","PlayerESP_Tool")
	makeToggle(St,1232,"Show Distance (right)","PlayerESP_Distance")
	mkDivider(St,1262,"Custom name")
	local customNameBox=makeInput(St,1284,"custom name (empty = real)")
	customNameBox.Text=C.PlayerESP_CustomName or ""
	customNameBox:GetPropertyChangedSignal("Text"):Connect(function()
		if S.unloaded then return end
		C.PlayerESP_CustomName=customNameBox.Text or ""
		updateESP()
	end)
	makeToggle(St,1318,"Rainbow name","PlayerESP_NameRainbow",nil,nil,C)
	makeSlider(St,1348,"Rainbow speed","PlayerESP_NameRainbowSpeed",0.1,3.0,0.05,C)
	makeSlider(St,1392,"Name size","PlayerESP_NameSize",8,32,1,C)
	makeSlider(St,1436,"Max distance (studs)","PlayerESP_MaxDist",0,1000,10,C,updateESP)
	makeSlider(St,1480,"Box thickness","PlayerESP_BoxThickness",1,6,0.5,C)
	mkDivider(St,1524,"Player accent color")
	colorRow(St,1546,"Player accent",playerESPColor,function(col)
		C.PlayerESP_ColorR=math.floor(col.R*255+0.5)
		C.PlayerESP_ColorG=math.floor(col.G*255+0.5)
		C.PlayerESP_ColorB=math.floor(col.B*255+0.5)
		if C.PlayerESP then updateESP() end
	end)
	colorRow(St,1578,"Player tracer",playerTracerColor,function(col)
		C.PlayerESP_TracerR=math.floor(col.R*255+0.5)
		C.PlayerESP_TracerG=math.floor(col.G*255+0.5)
		C.PlayerESP_TracerB=math.floor(col.B*255+0.5)
	end)
	colorRow(St,1610,"Player box",playerBoxColor,function(col)
		C.PlayerESP_BoxR=math.floor(col.R*255+0.5)
		C.PlayerESP_BoxG=math.floor(col.G*255+0.5)
		C.PlayerESP_BoxB=math.floor(col.B*255+0.5)
	end)
	mkDivider(St,1652,"Player HP chip (4 states)")
	makeToggle(St,1674,"Black outline (chip + number)","PlayerESP_HP_Outline",nil,nil,C)
	colorRow(St,1706,"State 1 (>75%)",playerChipState1,function(c) C.PlayerESP_HP_State1_R=math.floor(c.R*255+0.5) C.PlayerESP_HP_State1_G=math.floor(c.G*255+0.5) C.PlayerESP_HP_State1_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1738,"State 2 (50-75%)",playerChipState2,function(c) C.PlayerESP_HP_State2_R=math.floor(c.R*255+0.5) C.PlayerESP_HP_State2_G=math.floor(c.G*255+0.5) C.PlayerESP_HP_State2_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1770,"State 3 (25-50%)",playerChipState3,function(c) C.PlayerESP_HP_State3_R=math.floor(c.R*255+0.5) C.PlayerESP_HP_State3_G=math.floor(c.G*255+0.5) C.PlayerESP_HP_State3_B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1802,"State 4 (<25%)",playerChipState4,function(c) C.PlayerESP_HP_State4_R=math.floor(c.R*255+0.5) C.PlayerESP_HP_State4_G=math.floor(c.G*255+0.5) C.PlayerESP_HP_State4_B=math.floor(c.B*255+0.5) updateESP() end)
	mkDivider(St,1846,"Player HP gradient (vertical bar)")
	local function phR() return Color3.fromRGB(C.PlayerESP_HP_TopR or 80,C.PlayerESP_HP_TopG or 255,C.PlayerESP_HP_TopB or 80) end
	local function phM1() return Color3.fromRGB(C.PlayerESP_HP_M1R or 180,C.PlayerESP_HP_M1G or 255,C.PlayerESP_HP_M1B or 60) end
	local function phM2() return Color3.fromRGB(C.PlayerESP_HP_M2R or 255,C.PlayerESP_HP_M2G or 200,C.PlayerESP_HP_M2B or 40) end
	local function phM3() return Color3.fromRGB(C.PlayerESP_HP_M3R or 255,C.PlayerESP_HP_M3G or 120,C.PlayerESP_HP_M3B or 60) end
	local function phRB() return Color3.fromRGB(C.PlayerESP_HP_BotR or 255,C.PlayerESP_HP_BotG or 40,C.PlayerESP_HP_BotB or 40) end
	colorRow(St,1868,"Top",phR,function(c) C.PlayerESP_HP_TopR=math.floor(c.R*255+0.5) C.PlayerESP_HP_TopG=math.floor(c.G*255+0.5) C.PlayerESP_HP_TopB=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1900,"Mid1",phM1,function(c) C.PlayerESP_HP_M1R=math.floor(c.R*255+0.5) C.PlayerESP_HP_M1G=math.floor(c.G*255+0.5) C.PlayerESP_HP_M1B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1932,"Mid2",phM2,function(c) C.PlayerESP_HP_M2R=math.floor(c.R*255+0.5) C.PlayerESP_HP_M2G=math.floor(c.G*255+0.5) C.PlayerESP_HP_M2B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1964,"Mid3",phM3,function(c) C.PlayerESP_HP_M3R=math.floor(c.R*255+0.5) C.PlayerESP_HP_M3G=math.floor(c.G*255+0.5) C.PlayerESP_HP_M3B=math.floor(c.B*255+0.5) updateESP() end)
	colorRow(St,1996,"Bottom",phRB,function(c) C.PlayerESP_HP_BotR=math.floor(c.R*255+0.5) C.PlayerESP_HP_BotG=math.floor(c.G*255+0.5) C.PlayerESP_HP_BotB=math.floor(c.B*255+0.5) updateESP() end)
	mkDivider(St,2040,"HP bar size")
	makeSlider(St,2062,"Guard bar thickness","GuardESP_HPBarThickness",2,30,1,C)
	makeSlider(St,2106,"Guard bar length","GuardESP_HPBarLength",0.3,3.0,0.1,C)
	makeSlider(St,2150,"Guard bar roundness","GuardESP_HPBarRoundness",0,20,1,C)
	makeSlider(St,2194,"Player bar thickness","PlayerESP_HPBarThickness",2,30,1,C)
	makeSlider(St,2238,"Player bar length","PlayerESP_HPBarLength",0.3,3.0,0.1,C)
	makeSlider(St,2282,"Player bar roundness","PlayerESP_HPBarRoundness",0,20,1,C)
	mkDivider(St,2326,"ESP text")
	local fontBtn
	local function refreshFontBtn()
		if fontBtn then fontBtn.Text="Next font: "..(ESP_FONT_NAMES[C.ESP_FontIdx or 1] or "?") end
	end
	fontBtn=makeBtn(St,2348,"Next font: "..(ESP_FONT_NAMES[C.ESP_FontIdx or 1] or "?"),function()
		C.ESP_FontIdx=(C.ESP_FontIdx or 1)+1
		if C.ESP_FontIdx>#ESP_FONT_NAMES then C.ESP_FontIdx=1 end
		refreshFontBtn()
		for _,e in pairs(guardESPs) do
			pcall(function()
				if e.nameL then e.nameL.Font=espFont() end
				if e.toolL then e.toolL.Font=espFont() end
			end)
		end
		for _,e in pairs(playerESPs) do
			pcall(function()
				if e.nameL then e.nameL.Font=espFont() end
				if e.toolL then e.toolL.Font=espFont() end
			end)
		end
	end)
	makeBtn(St,2380,"Reset font (GothamBlack)",function()
		C.ESP_FontIdx=1
		refreshFontBtn()
		for _,e in pairs(guardESPs) do
			pcall(function()
				if e.nameL then e.nameL.Font=Enum.Font.GothamBlack e.nameL.TextSize=(C.GuardESP_NameSize or 17) end
				if e.toolL then e.toolL.Font=Enum.Font.GothamBlack end
			end)
		end
		for _,e in pairs(playerESPs) do
			pcall(function()
				if e.nameL then e.nameL.Font=Enum.Font.GothamBlack e.nameL.TextSize=(C.PlayerESP_NameSize or 17) end
				if e.toolL then e.toolL.Font=Enum.Font.GothamBlack end
			end)
		end
		if _G.__ad_statusCb then _G.__ad_statusCb("font reset - GothamBlack") end
	end)
end
function S.ui.buildDalgona()
	local Dg=S.ui.tabFrames.Dalgona
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local BTN_W=S.ui.BTN_W
	local COL=S.ui.COL
	mkDivider(Dg,0,"Cookie")
	makeToggle(Dg,22,"One Click Complete",nil,function() return S.oneClickDalgona end,function(v) setOneClickDalgona(v) end)
	local dgHint=Instance.new("TextLabel")
	dgHint.Size=UDim2.fromOffset(BTN_W,70) dgHint.Position=UDim2.fromOffset(4,56)
	dgHint.BackgroundTransparency=1 dgHint.Font=Enum.Font.Gotham dgHint.TextSize=9
	dgHint.TextWrapped=true dgHint.TextXAlignment=Enum.TextXAlignment.Left
	dgHint.TextYAlignment=Enum.TextYAlignment.Top dgHint.TextColor3=guiTextColor()
	dgHint.Text="Vklyuchi i vedi myshkoi po konturu pechenki."
	dgHint.ZIndex=6 dgHint.Parent=Dg
	registerRepaint(function() dgHint.TextColor3=guiTextColor() end)
end
function S.ui.buildExtra()
	local E=S.ui.tabFrames.Extra
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeBtn=S.ui.makeBtn
	mkDivider(E,0,"Instant Interact")
	makeToggle(E,22,"Enable Instant Interact","InstantInteract")
	makeToggle(E,52,"Insta mode (0ms)","InstantInteractInsta")
	makeSlider(E,82,"Custom speed x","InstantInteractMult",0.5,50,0.5,C)
	mkDivider(E,128,"Hide overhead")
	makeToggle(E,150,"Hide nickname","HideNick",nil,function() applyHideNick() end,C)
	mkDivider(E,186,"Visual")
	makeToggle(E,208,"Full Bright","FullBright",nil,function(v) applyFullBright(v) end,C)
	makeToggle(E,238,"Remove Fog","RemoveFog",nil,function(v) applyRemoveFog(v) end,C)
	mkDivider(E,274,"Overlay")
	makeToggle(E,296,"Watermark","Watermark",nil,function() updateInfoVisibility() end,C)
	makeToggle(E,326,"Keybind list","KeybindList",nil,function() updateInfoVisibility() end,C)
	mkDivider(E,362,"Cosmetics")
	makeToggle(E,384,"Headless","Headless")
	makeToggle(E,414,"Korblox Left Leg","Korblox")
	makeToggle(E,444,"Remove Legs","RemoveLegs")
	makeToggle(E,474,"Remove Hands","RemoveHands")
	makeToggle(E,504,"Remove Torso (client)","RemoveTorso")
	mkDivider(E,544,"Animation Speed")
	makeToggle(E,566,"Speed 2.5x","AnimSpeed")
	makeBtn(E,598,"Reset anim speed",function()
		local char=LP.Character
		local hum=char and char:FindFirstChildOfClass("Humanoid")
		local anim=hum and hum:FindFirstChildOfClass("Animator")
		if anim then
			for _,tr in ipairs(anim:GetPlayingAnimationTracks()) do pcall(function() tr:AdjustSpeed(1) end) end
		end
	end)
	mkDivider(E,636,"Extra")
	makeBtn(E,658,"Open Infinite Yield",function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then _G.__ad_statusCb("no loadstring/HttpGet") end
			return
		end
		local ok,err=pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978"))()
		end)
		if _G.__ad_statusCb then
			_G.__ad_statusCb(ok and "Infinite Yield loaded" or ("IY fail: "..tostring(err)))
		end
	end)
end
function S.ui.buildConfigs()
	local G=S.ui.tabFrames.Configs
	local mkDivider=S.ui.mkDivider
	local makeToggle=S.ui.makeToggle
	local makeSlider=S.ui.makeSlider
	local makeBtn=S.ui.makeBtn
	local makeInput=S.ui.makeInput
	local colorRow=S.ui.colorRow
	local COL=S.ui.COL
	mkDivider(G,0,"Config")
	local refreshConfigList
	local nameBox=makeInput(G,22,"config name")
	nameBox.Text=S.currentConfigName
	makeBtn(G,54,"Save",function()
		local n=nameBox.Text if n=="" then n="default" end
		local ok,msg=saveConfig(n)
		if ok then
			nameBox.Text=S.currentConfigName
			if _G.__ad_statusCb then _G.__ad_statusCb("saved - "..S.currentConfigName) end
			task.defer(function() if refreshConfigList then refreshConfigList() end end)
		else
			if _G.__ad_statusCb then _G.__ad_statusCb("save fail - "..tostring(msg)) end
		end
	end)
	makeBtn(G,86,"Load",function()
		local n=nameBox.Text if n=="" then n="default" end
		local ok,msg=loadConfig(n)
		if ok then
			nameBox.Text=S.currentConfigName
			if _G.__ad_statusCb then _G.__ad_statusCb("loaded - "..S.currentConfigName) end
		else
			if _G.__ad_statusCb then _G.__ad_statusCb("load fail - "..tostring(msg)) end
		end
	end)
	mkDivider(G,124,"Auto-Load")
	local autoloadInfo=Instance.new("TextLabel")
	autoloadInfo.Size=UDim2.fromOffset(S.ui.BTN_W,20) autoloadInfo.Position=UDim2.fromOffset(4,146)
	autoloadInfo.BackgroundTransparency=1 autoloadInfo.Font=Enum.Font.Code
	autoloadInfo.TextSize=11 autoloadInfo.TextXAlignment=Enum.TextXAlignment.Left
	autoloadInfo.TextColor3=Color3.fromRGB(255,220,120)
	autoloadInfo.ZIndex=6 autoloadInfo.Parent=G
	registerRepaint(function() end)
	local function refreshAutoloadInfo()
		local al=loadAutoloadName()
		if al=="" then
			autoloadInfo.Text="Auto-load: OFF"
		else
			autoloadInfo.Text="Auto-load: "..al
		end
	end
	refreshAutoloadInfo()
	makeBtn(G,170,"Set as autoload (name from box)",function()
		local n=nameBox.Text if n=="" then n="default" end
		n=tostring(n):gsub("[^%w%-%_]","")
		if n=="" then n="default" end
		if saveAutoloadName(n) then
			refreshAutoloadInfo()
			if _G.__ad_statusCb then _G.__ad_statusCb("autoload set: "..n) end
		else
			if _G.__ad_statusCb then _G.__ad_statusCb("autoload fail (no writefile)") end
		end
	end)
	makeBtn(G,202,"Reset auto-load",function()
		if clearAutoloadName() then
			refreshAutoloadInfo()
			if _G.__ad_statusCb then _G.__ad_statusCb("autoload reset") end
		else
			refreshAutoloadInfo()
			if _G.__ad_statusCb then _G.__ad_statusCb("autoload already off") end
		end
	end)
	mkDivider(G,238,"Menu animation")
	makeSlider(G,260,"Open/close speed","MenuAnimSpeed",0.1,1.5,0.05,C)
	makeSlider(G,304,"Collapse anim speed","MenuDodgeAnimSpeed",0.1,2.0,0.05,C)
	mkDivider(G,350,"Circle menu button")
	makeSlider(G,372,"Circle size","CircleSize",32,120,2,C)
	colorRow(G,414,"Circle text color",circleTextColor,function(col)
		C.CircleTextR=math.floor(col.R*255+0.5)
		C.CircleTextG=math.floor(col.G*255+0.5)
		C.CircleTextB=math.floor(col.B*255+0.5)
		repaintAll()
	end)
	makeToggle(G,448,"Rainbow text color","CircleRainbowText",nil,function() repaintAll() end,C)
	makeToggle(G,478,"Rainbow outline","CircleRainbowOutline",nil,function() repaintAll() end,C)
	mkDivider(G,514,"Text color (all GUI)")
	colorRow(G,536,"Text color",guiTextColor,function(col)
		C.GuiTextR=math.floor(col.R*255+0.5)
		C.GuiTextG=math.floor(col.G*255+0.5)
		C.GuiTextB=math.floor(col.B*255+0.5)
		repaintAll()
	end)
	mkDivider(G,576,"Panel border")
	makeToggle(G,598,"Rainbow panel border","PanelRainbow",nil,function(v)
		if v then startPanelRainbow()
		else
			stopPanelRainbow()
			if S.panel then local st=S.panel:FindFirstChildOfClass("UIStroke") if st then st.Color=guiAccent() end end
		end
	end,C)
	mkDivider(G,634,"Accent color")
	colorRow(G,656,"GUI accent",guiAccent,function(col)
		C.GuiR=math.floor(col.R*255+0.5)
		C.GuiG=math.floor(col.G*255+0.5)
		C.GuiB=math.floor(col.B*255+0.5)
		repaintAll()
	end)
	makeSlider(G,698,"R","GuiR",0,255,1,C,repaintAll)
	makeSlider(G,742,"G","GuiG",0,255,1,C,repaintAll)
	makeSlider(G,786,"B","GuiB",0,255,1,C,repaintAll)
	mkDivider(G,830,"Saved configs")
	local listFrame=Instance.new("ScrollingFrame")
	listFrame.Size=UDim2.new(1,-8,0,120) listFrame.Position=UDim2.fromOffset(4,850)
	listFrame.BackgroundColor3=COL.card listFrame.BorderSizePixel=0
	listFrame.ScrollBarThickness=3 listFrame.CanvasSize=UDim2.fromOffset(0,0)
	listFrame.ZIndex=6 listFrame.Parent=G
	addCorner(listFrame,7)
	local emptyLbl=Instance.new("TextLabel")
	emptyLbl.Size=UDim2.new(1,-8,0,20) emptyLbl.Position=UDim2.fromOffset(4,6)
	emptyLbl.BackgroundTransparency=1 emptyLbl.Font=Enum.Font.Gotham
	emptyLbl.TextSize=11 emptyLbl.TextColor3=guiTextColor()
	emptyLbl.TextXAlignment=Enum.TextXAlignment.Left
	emptyLbl.Text="no configs saved yet" emptyLbl.ZIndex=7 emptyLbl.Parent=listFrame
	registerRepaint(function() emptyLbl.TextColor3=guiTextColor() end)
	refreshConfigList=function()
		if S.unloaded or not listFrame or not listFrame.Parent then return end
		for _,ch in ipairs(listFrame:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
		local list=listConfigs()
		listFrame.CanvasSize=UDim2.fromOffset(0,math.max(#list*26+8,26))
		emptyLbl.Visible=(#list==0)
		for i,n in ipairs(list) do
			local b=Instance.new("TextButton")
			b.Size=UDim2.new(1,-8,0,22) b.Position=UDim2.fromOffset(4,(i-1)*26+4)
			b.BackgroundColor3=COL.off b.BorderSizePixel=0
			b.Font=Enum.Font.Gotham b.TextSize=12 b.TextColor3=guiTextColor()
			b.Text="  "..n b.TextXAlignment=Enum.TextXAlignment.Left
			b.ZIndex=7 b.Parent=listFrame
			addCorner(b,5)
			registerRepaint(function() b.TextColor3=guiTextColor() end)
			b.MouseButton1Click:Connect(function()
				playClick() nameBox.Text=n
				local ok=loadConfig(n)
				if _G.__ad_statusCb then _G.__ad_statusCb(ok and ("loaded - "..n) or "load failed") end
			end)
			local x=Instance.new("TextButton")
			x.Size=UDim2.fromOffset(20,18) x.Position=UDim2.new(1,-24,0.5,-9)
			x.BackgroundColor3=Color3.fromRGB(120,30,30) x.BorderSizePixel=0
			x.Font=Enum.Font.GothamBold x.TextSize=11
			x.TextColor3=Color3.new(1,1,1) x.Text="x" x.ZIndex=8 x.Parent=b
			addCorner(x,4)
			x.MouseButton1Click:Connect(function()
				if S.unloaded then return end
				playClick()
				local ok,err=deleteConfig(n)
				if ok then
					if _G.__ad_statusCb then _G.__ad_statusCb("deleted - "..n) end
					task.defer(function() if refreshConfigList then refreshConfigList() end end)
				else
					if _G.__ad_statusCb then _G.__ad_statusCb("del fail - "..tostring(err)) end
				end
			end)
		end
	end
	refreshConfigList()
	_G.__adRefreshConfigs=refreshConfigList
	makeBtn(G,984,"Refresh List",function() refreshConfigList() end)
	makeBtn(G,1018,"Set Menu Key",function()
		S.bindingMenuKey=true
		if _G.__ad_statusCb then _G.__ad_statusCb("press a key...") end
		local conn
		conn=UIS.InputBegan:Connect(function(input)
			if input.UserInputType~=Enum.UserInputType.Keyboard then return end
			C.MenuKey=input.KeyCode
			if _G.__ad_statusCb then _G.__ad_statusCb("menu key = "..input.KeyCode.Name) end
			task.defer(function() S.bindingMenuKey=false end)
			if conn then conn:Disconnect() end
			if S.rebindMenu then S.rebindMenu() end
		end)
	end)
	makeBtn(G,1052,"FULL UNLOAD",function() if S.doFullUnload then pcall(S.doFullUnload) end end,Color3.fromRGB(180,40,40),Color3.fromRGB(255,255,255))
	mkDivider(G,1090,"Share config (JSON / TXT)")
	local shareBox=makeInput(G,1112,"paste JSON here to import")
	shareBox.Text=""
	makeBtn(G,1144,"Export (copy JSON to clipboard)",function()
		local pl={C=packStore(C),H=packStore(H),anim=S.animEnabled}
		local json=HttpService:JSONEncode(pl)
		local copied=false
		if setclipboard then
			pcall(function() setclipboard(json) copied=true end)
		end
		if copied then
			if _G.__ad_statusCb then _G.__ad_statusCb("copied ("..#json.." chars)") end
		else
			shareBox.Text=json
			if _G.__ad_statusCb then _G.__ad_statusCb("no setclipboard - JSON in box") end
		end
	end)
	makeBtn(G,1176,"Export to file (XD_config.txt)",function()
		if not S.FILE.writefile then
			if _G.__ad_statusCb then _G.__ad_statusCb("no writefile in executor") end
			return
		end
		local pl={C=packStore(C),H=packStore(H),anim=S.animEnabled}
		local json=HttpService:JSONEncode(pl)
		local ok=pcall(function() S.FILE.writefile("XD_config.txt",json) end)
		if ok then
			if _G.__ad_statusCb then _G.__ad_statusCb("saved XD_config.txt") end
		else
			if _G.__ad_statusCb then _G.__ad_statusCb("writefile failed") end
		end
	end)
	makeBtn(G,1208,"Load from file (XD_config.txt)",function()
		if not S.FILE.readfile or not S.FILE.isfile then
			if _G.__ad_statusCb then _G.__ad_statusCb("no readfile") end
			return
		end
		local okf,e=pcall(S.FILE.isfile,"XD_config.txt")
		if not okf or not e then
			if _G.__ad_statusCb then _G.__ad_statusCb("XD_config.txt not found") end
			return
		end
		local ok,raw=pcall(S.FILE.readfile,"XD_config.txt")
		if not ok or not raw then
			if _G.__ad_statusCb then _G.__ad_statusCb("read failed") end
			return
		end
		local ok2,data=pcall(function() return HttpService:JSONDecode(raw) end)
		if not ok2 or type(data)~="table" then
			if _G.__ad_statusCb then _G.__ad_statusCb("bad json in file") end
			return
		end
		applyData(data)
		if _G.__ad_statusCb then _G.__ad_statusCb("loaded from XD_config.txt") end
	end)
	makeBtn(G,1240,"Import from clipboard",function()
		local s=""
		if getclipboard then pcall(function() s=getclipboard() end) end
		if not s or s=="" then
			if _G.__ad_statusCb then _G.__ad_statusCb("clipboard empty") end
			return
		end
		local ok,data=pcall(function() return HttpService:JSONDecode(s) end)
		if not ok or type(data)~="table" then
			if _G.__ad_statusCb then _G.__ad_statusCb("bad json") end
			return
		end
		applyData(data)
		if _G.__ad_statusCb then _G.__ad_statusCb("imported from clipboard") end
	end)
	makeBtn(G,1272,"Import from box above",function()
		local s=shareBox.Text or ""
		if s=="" then
			if _G.__ad_statusCb then _G.__ad_statusCb("box empty") end
			return
		end
		local ok,data=pcall(function() return HttpService:JSONDecode(s) end)
		if not ok or type(data)~="table" then
			if _G.__ad_statusCb then _G.__ad_statusCb("bad json") end
			return
		end
		applyData(data)
		if _G.__ad_statusCb then _G.__ad_statusCb("imported from box") end
	end)
	mkDivider(G,1308,"Circle rainbow glow")
	makeSlider(G,1330,"Glow speed","CircleRainbowSpeed",0.1,5.0,0.1,C)
end
function S.ui.buildCollapseCircle()
	local PANEL_W=S.ui.PANEL_W
	local PANEL_H=S.ui.PANEL_H
	local expandCircle=Instance.new("TextButton")
	expandCircle.AnchorPoint=Vector2.new(1,0)
	expandCircle.Position=UDim2.new(1,-16,0,90)
	expandCircle.Size=UDim2.fromOffset(0,0)
	expandCircle.BackgroundColor3=guiAccent() expandCircle.BorderSizePixel=0
	expandCircle.Text="" expandCircle.AutoButtonColor=false
	expandCircle.Visible=false expandCircle.ZIndex=50 expandCircle.Parent=S.gui
	addCorner(expandCircle,32)
	local circOutline=addStroke(expandCircle,Color3.fromRGB(0,0,0),3,0)
	registerRepaint(function() expandCircle.BackgroundColor3=guiAccent() end)
	S.ui.expandCircle=expandCircle
	local circleDragging=false
	local circleWasDragged=false
	local circleDragStart=nil
	local circleStartPos=nil
	expandCircle.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			circleDragging=true circleWasDragged=false
			circleDragStart=input.Position
			circleStartPos=expandCircle.Position
			input.Changed:Connect(function()
				if input.UserInputState==Enum.UserInputState.End then circleDragging=false end
			end)
		end
	end)
	track(UIS.InputChanged:Connect(function(input)
		if not circleDragging then return end
		if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
			local delta=input.Position-circleDragStart
			if math.abs(delta.X)>3 or math.abs(delta.Y)>3 then circleWasDragged=true end
			expandCircle.Position=UDim2.new(circleStartPos.X.Scale,circleStartPos.X.Offset+delta.X,circleStartPos.Y.Scale,circleStartPos.Y.Offset+delta.Y)
		end
	end))
	local xLbl=Instance.new("TextLabel")
	xLbl.AnchorPoint=Vector2.new(0.5,0.5) xLbl.Size=UDim2.fromScale(0.55,0.55)
	xLbl.Position=UDim2.fromScale(0.34,0.52) xLbl.BackgroundTransparency=1
	xLbl.Font=Enum.Font.GothamBlack xLbl.TextSize=26
	xLbl.TextColor3=circleTextColor()
	xLbl.TextStrokeTransparency=0 xLbl.TextStrokeColor3=Color3.fromRGB(255,0,0)
	xLbl.Text="X" xLbl.Rotation=-8 xLbl.ZIndex=52 xLbl.Parent=expandCircle
	local dLbl=Instance.new("TextLabel")
	dLbl.AnchorPoint=Vector2.new(0.5,0.5) dLbl.Size=UDim2.fromScale(0.5,0.55)
	dLbl.Position=UDim2.fromScale(0.68,0.52) dLbl.BackgroundTransparency=1
	dLbl.Font=Enum.Font.GothamBlack dLbl.TextSize=24
	dLbl.TextColor3=circleTextColor()
	dLbl.TextStrokeTransparency=0 dLbl.TextStrokeColor3=Color3.fromRGB(255,0,0)
	dLbl.Text="D" dLbl.Rotation=6 dLbl.ZIndex=52 dLbl.Parent=expandCircle
	registerRepaint(function()
		circOutline.Color=Color3.fromRGB(0,0,0)
		if not C.CircleRainbowOutline then
			xLbl.TextStrokeColor3=circleTextColor()
			dLbl.TextStrokeColor3=circleTextColor()
		end
		if not C.CircleRainbowText then
			xLbl.TextColor3=circleTextColor()
			dLbl.TextColor3=circleTextColor()
		end
	end)
	task.spawn(function()
		local h=0
		while S.running and not S.unloaded do
			if C.CircleRainbowOutline then
				local col=Color3.fromHSV(h,1,1)
				pcall(function() xLbl.TextStrokeColor3=col dLbl.TextStrokeColor3=col end)
			end
			if C.CircleRainbowText then
				local col2=Color3.fromHSV((h+0.5)%1,1,1)
				pcall(function() xLbl.TextColor3=col2 dLbl.TextColor3=col2 end)
			end
			h=(h+0.008*(C.CircleRainbowSpeed or 1.0))%1
			RunService.RenderStepped:Wait()
		end
	end)
	local collapsed=false
	local function setCollapsed(state)
		if S.unloaded or not S.panel or not S.panel.Parent then return end
		state=state and true or false
		if state==collapsed then return end
		collapsed=state
		local dur=tonumber(C.MenuAnimSpeed) or 0.35
		local ddur=tonumber(C.MenuDodgeAnimSpeed) or 0.5
		if state then
			local T=TweenInfo.new(dur,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
			TweenService:Create(S.panel,T,{Position=UDim2.new(S.panel.Position.X.Scale,S.panel.Position.X.Offset-800,S.panel.Position.Y.Scale,S.panel.Position.Y.Offset),BackgroundTransparency=1}):Play()
			TweenService:Create(S.shadow,T,{Position=UDim2.new(S.shadow.Position.X.Scale,S.shadow.Position.X.Offset-800,S.shadow.Position.Y.Scale,S.shadow.Position.Y.Offset),BackgroundTransparency=1}):Play()
			TweenService:Create(S.glow,T,{Position=UDim2.new(S.glow.Position.X.Scale,S.glow.Position.X.Offset-800,S.glow.Position.Y.Scale,S.glow.Position.Y.Offset),BackgroundTransparency=1}):Play()
			task.delay(dur+0.02,function()
				if S.unloaded or not collapsed then return end
				S.panel.Visible=false S.shadow.Visible=false S.glow.Visible=false
				S.panel.BackgroundTransparency=0 S.shadow.BackgroundTransparency=0.65 S.glow.BackgroundTransparency=0.86
				expandCircle.Visible=true expandCircle.Size=UDim2.fromOffset(0,0)
				local sz=tonumber(C.CircleSize) or 64
				TweenService:Create(expandCircle,TweenInfo.new(ddur,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.fromOffset(sz,sz)}):Play()
			end)
		else
			expandCircle.Visible=false expandCircle.Size=UDim2.fromOffset(0,0)
			S.panel.Visible=true S.shadow.Visible=true S.glow.Visible=true
			local tx=-PANEL_W/2-800
			local ty=-PANEL_H/2
			S.panel.Position=UDim2.new(0.5,tx,0.5,ty)
			S.shadow.Position=UDim2.new(0.5,tx+6,0.5,ty+6)
			S.glow.Position=UDim2.new(0.5,tx-20,0.5,ty-20)
			S.panel.BackgroundTransparency=1 S.shadow.BackgroundTransparency=1 S.glow.BackgroundTransparency=1
			local T=TweenInfo.new(dur,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
			TweenService:Create(S.panel,T,{Position=UDim2.new(0.5,-PANEL_W/2,0.5,-PANEL_H/2),BackgroundTransparency=0}):Play()
			TweenService:Create(S.shadow,T,{Position=UDim2.new(0.5,-PANEL_W/2+6,0.5,-PANEL_H/2+6),BackgroundTransparency=0.65}):Play()
			TweenService:Create(S.glow,T,{Position=UDim2.new(0.5,-PANEL_W/2-20,0.5,-PANEL_H/2-20),BackgroundTransparency=0.86}):Play()
		end
	end
	_G.__adSetCollapsed=setCollapsed
	_G.__adIsCollapsed=function() return collapsed end
	if S.ui.collapseBtn then
		S.ui.collapseBtn.MouseButton1Click:Connect(function()
			if S.unloaded then return end
			playClick() setCollapsed(true)
		end)
	end
	expandCircle.MouseButton1Click:Connect(function()
		if S.unloaded then return end
		if circleWasDragged then circleWasDragged=false return end
		playClick() setCollapsed(false)
	end)
end
local function safeBuild(name,fn)
	local ok,err=pcall(fn)
	if not ok then
		print("[XD] BUILD ERROR in "..tostring(name)..":",tostring(err))
		warn("[XD] BUILD ERROR in "..tostring(name)..":",tostring(err))
	end
end
safeBuild("buildPanel",S.ui.buildPanel)
safeBuild("buildMain",S.ui.buildMain)
safeBuild("buildHnS",S.ui.buildHnS)
safeBuild("buildRebel",S.ui.buildRebel)
safeBuild("buildRLGL",S.ui.buildRLGL)
safeBuild("buildESP",S.ui.buildESP)
safeBuild("buildDalgona",S.ui.buildDalgona)
safeBuild("buildExtra",S.ui.buildExtra)
safeBuild("buildConfigs",S.ui.buildConfigs)
safeBuild("buildCollapseCircle",S.ui.buildCollapseCircle)
pcall(ensureInfoGui)
pcall(updateInfoVisibility)
pcall(applyHideNick)
if C.PanelRainbow then startPanelRainbow() end
if C.FullBright then applyFullBright(true) end
if C.RemoveFog then applyRemoveFog(true) end
do
	if ProximityPromptService then
		local activeHold=nil
		local function stopHold()
			if activeHold then activeHold.cancelled=true activeHold=nil end
		end
		pcall(function()
			ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt,player)
				if S.unloaded or player~=LP or not C.InstantInteract then return end
				stopHold()
				if C.InstantInteractInsta then
					pcall(fireproximityprompt,prompt)
					return
				end
				local tok={cancelled=false}
				activeHold=tok
				task.spawn(function()
					local mult=tonumber(C.InstantInteractMult) or 2
					if mult<0.5 then mult=0.5 end
					local iv=1/mult
					while not tok.cancelled and not S.unloaded and C.InstantInteract do
						pcall(fireproximityprompt,prompt)
						task.wait(iv)
					end
				end)
			end)
		end)
		pcall(function()
			ProximityPromptService.PromptButtonHoldEnded:Connect(function(prompt,player)
				if player~=LP then return end
				stopHold()
			end)
		end)
	end
end
S.toggleMenu=function()
	if S.unloaded then return end
	if S.bindingMenuKey then return end
	if not S.panel or not S.panel.Parent then return end
	local now=tick()
	if now-S.lastMenuToggle<0.15 then return end
	S.lastMenuToggle=now
	playClick()
	if _G.__adSetCollapsed and _G.__adIsCollapsed then
		local isCol=_G.__adIsCollapsed()
		_G.__adSetCollapsed(not isCol)
	else
		S.panel.Visible=not S.panel.Visible
		if S.shadow then S.shadow.Visible=S.panel.Visible end
		if S.glow then S.glow.Visible=S.panel.Visible end
	end
end
S.rebindMenu=function()
	if S.menuAction then pcall(function() CAS:UnbindAction(S.menuAction) end) end
	S.menuAction="XDMenu_"..randStr(6)
	pcall(function()
		CAS:BindAction(S.menuAction,function(_,state)
			if state~=Enum.UserInputState.Begin then return end
			S.toggleMenu()
		end,false,C.MenuKey)
	end)
end
S.rebindMenu()
track(UIS.InputBegan:Connect(function(input)
	if S.unloaded or S.bindingMenuKey then return end
	if input.UserInputType~=Enum.UserInputType.Keyboard then return end
	if input.KeyCode~=C.MenuKey then return end
	S.toggleMenu()
end))
S.doFullUnload=function()
	if S.unloaded then return end
	if S.panel and S.panel.Parent and S.panel.Visible then
		local curSX=S.panel.Position.X.Scale
		local curSY=S.panel.Position.Y.Scale
		local curX=S.panel.Position.X.Offset
		local curY=S.panel.Position.Y.Offset
		local T=TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
		pcall(function()
			TweenService:Create(S.panel,T,{Position=UDim2.new(curSX,curX-800,curSY,curY),BackgroundTransparency=1}):Play()
			TweenService:Create(S.shadow,T,{Position=UDim2.new(curSX,curX-800+6,curSY,curY+6),BackgroundTransparency=1}):Play()
			TweenService:Create(S.glow,T,{Position=UDim2.new(curSX,curX-800-20,curSY,curY-20),BackgroundTransparency=1}):Play()
		end)
		task.wait(0.42)
	end
	_G.__adUnloaded=true S.running=false
	pcall(unhookCombat)
	pcall(stopAimbot)
	pcall(destroyFOVCircle)
	pcall(stopFovRainbow)
	pcall(stopPanelRainbow)
	pcall(stopBrewLoop)
	pcall(HB_restoreAll)
	if S.infiniteAmmoLoop then pcall(function() task.cancel(S.infiniteAmmoLoop) end) S.infiniteAmmoLoop=nil end
	if S.btAnimConn then pcall(function() S.btAnimConn:Disconnect() end) S.btAnimConn=nil end
	if S._nickLoop then pcall(function() task.cancel(S._nickLoop) end) S._nickLoop=nil end
	pcall(function() applyFullBright(false) end)
	pcall(function() applyRemoveFog(false) end)
	if S.notifHolder then pcall(function() S.notifHolder:Destroy() end) S.notifHolder=nil end
	S.unloaded=true
	pcall(function()
		C.Enabled=false H.Enabled=false
		C.RadiusVis=false H.RadiusVis=false
		C.AnimSpeed=false C.GuardESP=false C.PlayerESP=false
		C.RemoveHands=false C.RemoveLegs=false C.RemoveTorso=false
		C.Headless=false C.Korblox=false C.HideNick=false
		C.FullBright=false C.RemoveFog=false C.AutoBrew=false
		C.BulletTracer=false C.InfiniteAmmo=false
		S.oneClickDalgona=false
		C.RLGL_AutoDodge=false C.RLGL_TimerEndDodge=false
		C.RebelSilentAim=false C.RebelNoRecoil=false C.RebelRapidFire=false
		C.RebelAimbot=false
		C.RebelFOVCircle=false
		C.HitboxExpander=false
		C.HitboxVisualize=false
	end)
	pcall(function()
		for part,data in pairs(_G.__dalgonaCache) do
			if part and part.Parent then pcall(function() part.Position=data.Position part.Transparency=data.Transparency end) end
		end
		table.clear(_G.__dalgonaCache)
	end)
	pcall(function()
		for p,t in pairs(S.origTransparency) do
			if p and p.Parent then pcall(function() p.LocalTransparencyModifier=0 p.Transparency=t end) end
		end
		table.clear(S.origTransparency)
		local function unhide(cache)
			for i=1,#cache do
				local p=cache[i]
				if p and p.Parent then pcall(function() p.LocalTransparencyModifier=0 end) end
			end
		end
		unhide(S.handCache) unhide(S.legCache) unhide(S.torsoCache)
		table.clear(S.handCache) table.clear(S.legCache) table.clear(S.torsoCache)
	end)
	pcall(function() applyKorblox(false) end)
	pcall(function() applyHeadless(false) end)
	pcall(unhook)
	pcall(clearAllGuardESP)
	pcall(clearAllPlayerESP)
	pcall(clearHideConns)
	pcall(killViz)
	for i=1,#S.conns do pcall(function() if S.conns[i] and S.conns[i].Disconnect then S.conns[i]:Disconnect() end end) end
	table.clear(S.conns)
	for _,c in pairs(S.added) do pcall(function() if c and c.Disconnect then c:Disconnect() end end) end
	table.clear(S.added)
	if S.handsConn then pcall(function() S.handsConn:Disconnect() end) S.handsConn=nil end
	if S.dalgonaConn then pcall(function() S.dalgonaConn:Disconnect() end) S.dalgonaConn=nil end
	if S.aimbotConn then pcall(function() S.aimbotConn:Disconnect() end) S.aimbotConn=nil end
	if S.tracerGui then pcall(function() S.tracerGui:Destroy() end) S.tracerGui=nil end
	if S.overlayGui then pcall(function() S.overlayGui:Destroy() end) S.overlayGui=nil end
	if S.infoGui then pcall(function() S.infoGui:Destroy() end) S.infoGui=nil end
	if S.menuAction then pcall(function() CAS:UnbindAction(S.menuAction) end) S.menuAction=nil end
	if S.clickSound then pcall(function() S.clickSound:Destroy() end) S.clickSound=nil end
	pcall(function()
		if S.gui then
			S.gui.Enabled=false
			for _,ch in ipairs(S.gui:GetDescendants()) do pcall(function() if ch and ch.Destroy then ch:Destroy() end end) end
			S.gui:Destroy()
		end
	end)
	S.gui=nil S.shadow=nil S.glow=nil S.panel=nil
	if getgenv then pcall(function() if getgenv().__ui_dodge then getgenv().__ui_dodge=nil end end) end
	_G.__XD_UNLOAD=nil _G.__ad_statusCb=nil _G.__adShowNotif=nil
	_G.__adSetCollapsed=nil _G.__adIsCollapsed=nil
end
_G.__XD_UNLOAD=S.doFullUnload
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.AnimSpeed then
				local char=LP.Character
				local hum=char and char:FindFirstChildOfClass("Humanoid")
				local anim=hum and hum:FindFirstChildOfClass("Animator")
				if anim then
					local tg=C.AnimSpeedValue or 2.5
					for _,tr in ipairs(anim:GetPlayingAnimationTracks()) do
						pcall(function() if tr.Speed~=tg then tr:AdjustSpeed(tg) end end)
					end
				end
			end
			if C.RemoveHands or C.RemoveLegs or C.RemoveTorso then rebuildLimbCache() end
			if C.Headless then applyHeadless(true) end
			if C.Korblox then applyKorblox(true) end
			if C.Enabled or H.Enabled then
				S.cachedUITool=findUITool()
				S.cachedDodgeTool=findDodgeTool()
				S.cachedSlot=inferSlotFor(S.cachedUITool,"T",C.ManualUISlot)
				S.cachedDodgeSlot=inferSlotFor(S.cachedDodgeTool,"1",C.ManualHnSSlot)
			end
			if (C.RebelSilentAim or C.RebelNoRecoil or C.RebelRapidFire) and not S.combatHooked then hookCombat() end
			if C.RebelAimbot and not S.aimbotConn then startAimbot() end
			if not C.RebelAimbot and S.aimbotConn then stopAimbot() end
		end)
		task.wait(0.1)
	end
end)
task.spawn(function()
	while S.running and not S.unloaded do
		if C.GuardESP or C.PlayerESP then pcall(updateESP) end
		task.wait(0.5)
	end
end)
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			local bits={}
			if C.Enabled then table.insert(bits,"ui "..S.cachedSlot) end
			if H.Enabled then table.insert(bits,"hns "..S.cachedDodgeSlot) end
			if C.RebelSilentAim then table.insert(bits,"aim") end
			if C.RebelNoRecoil then table.insert(bits,"norec") end
			if C.RebelRapidFire then table.insert(bits,"rapid x"..tostring(C.RebelRapidFireMult or 2)) end
			if C.RebelAimbot then table.insert(bits,"aimbot") end
			if C.HitboxExpander then table.insert(bits,"hitbox x"..tostring(C.HitboxSize or 3)) end
			if C.BulletTracer then table.insert(bits,"btracer") end
			if C.InfiniteAmmo then table.insert(bits,"inf-ammo") end
			if C.RLGL_AutoDodge then table.insert(bits,"rlgl") end
			if C.RLGL_TimerEndDodge then table.insert(bits,"timer-end") end
			if C.HideNick then table.insert(bits,"hide-nick") end
			if C.AutoBrew then table.insert(bits,"auto-brew") end
			if S.oneClickDalgona then table.insert(bits,"dalgona ON") end
			if C.GuardESP or C.PlayerESP then table.insert(bits,string.format("esp %d/%d",_G.__adEspDone or 0,_G.__adEspTotal or 0)) end
			if C.AnimSpeed then table.insert(bits,"anim") end
			if _G.__ad_statusCb then
				if #bits==0 then _G.__ad_statusCb("paused - N")
				else _G.__ad_statusCb(table.concat(bits," - ")) end
			end
		end)
		task.wait(1)
	end
end)
task.spawn(function()
	_G.__rlglLastSec=nil
	_G.__rlglTimerEndedAt=0
	_G.__rlglLastFire=0
	while S.running and not S.unloaded do
		pcall(function()
			local onMap=_G.__rlgl_isOnMap()
			if not onMap then
				_G.__rlglLastSec=nil _G.__rlglTimerEndedAt=0 _G.__rlglWasRed=false
				task.wait(0.5)
				return
			end
			if C.RLGL_AutoDodge then
				local red=_G.__rlgl_isRed()
				local moving=_G.__rlgl_isMoving(C.RLGL_VelThreshold or 0.3)
				local safe=_G.__rlgl_inSafeZone()
				if red and not _G.__rlglWasRed then _G.__rlglRedStartAt=tick() end
				_G.__rlglWasRed=red
				local redElapsed=red and (tick()-_G.__rlglRedStartAt) or 0
				local minDelay=C.RLGL_RedDelay or 0.1
				local ok=true
				if safe then ok=false end
				if C.RLGL_OnlyRedLight and ok then
					if not red then ok=false end
					if redElapsed<minDelay then ok=false end
				end
				if ok and not moving then ok=false end
				local now=tick()
				if ok and (now-_G.__rlglLast)>=(C.RLGL_MinInterval or 0.15) then
					_G.__rlglLast=now
					task.spawn(_G.__rlgl_fireDodge)
				end
			end
			if C.RLGL_TimerEndDodge then
				local sec=_G.__rlgl_timerSeconds()
				local safe=_G.__rlgl_inSafeZone()
				local finish=_G.__rlgl_inFinishZone()
				if sec~=nil then _G.__rlglLastSec=sec end
				if sec~=nil and sec>10 then _G.__rlglTimerEndedAt=0 end
				local justEnded=false
				if sec~=nil and sec<=0 then justEnded=true end
				if sec==nil and _G.__rlglLastSec and _G.__rlglLastSec<=3 then justEnded=true end
				if justEnded and _G.__rlglTimerEndedAt==0 then
					_G.__rlglTimerEndedAt=tick()
					_G.__rlglLastFire=0
				end
				if _G.__rlglTimerEndedAt>0 and not safe and not finish then
					local delay=C.RLGL_TimerEndDelay or 0
					local interval=C.RLGL_TimerEndInterval or 0.15
					local maxDur=C.RLGL_TimerEndMaxDuration or 12
					local sinceEnd=tick()-_G.__rlglTimerEndedAt
					if sinceEnd>maxDur then _G.__rlglTimerEndedAt=0
					elseif sinceEnd>=delay then
						local now=tick()
						if _G.__rlglLastFire==0 or (now-_G.__rlglLastFire>=interval) then
							_G.__rlglLastFire=now
							task.spawn(_G.__rlgl_fireDodge)
						end
					end
				end
			end
		end)
		task.wait(0.05)
	end
end)
track(LP.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	if S.unloaded then return end
	rebuildLimbCache()
	if C.RemoveHands then applyRemoveHands(true) end
	if C.RemoveLegs then applyRemoveLegs(true) end
	if C.RemoveTorso then applyRemoveTorso(true) end
	if C.Headless then applyHeadless(true) end
	if C.Korblox then applyKorblox(true) end
end))
if LP.Character then
	track(LP.Character.DescendantAdded:Connect(function()
		if S.unloaded then return end
		if C.RemoveHands or C.RemoveLegs or C.RemoveTorso or C.Headless or C.Korblox then
			task.defer(function()
				rebuildLimbCache()
				if C.RemoveHands then applyRemoveHands(true) end
				if C.RemoveLegs then applyRemoveLegs(true) end
				if C.RemoveTorso then applyRemoveTorso(true) end
				if C.Headless then applyHeadless(true) end
				if C.Korblox then applyKorblox(true) end
			end)
		end
	end))
end
ensureHandsLoop()
do
	local function bindTeamWatch(plr)
		if not plr or plr==LP then return end
		track(plr:GetPropertyChangedSignal("Team"):Connect(function()
			if not S.unloaded and (C.GuardESP or C.PlayerESP) then task.defer(updateESP) end
		end))
	end
	for _,plr in ipairs(Players:GetPlayers()) do bindTeamWatch(plr) end
	track(Players.PlayerAdded:Connect(bindTeamWatch))
end

-- AUTOLOAD
do
	local al=loadAutoloadName()
	if al~="" then
		local ok,msg=loadConfig(al)
		if ok then
			print("[XD] Auto-loaded config:",al)
		else
			print("[XD] Auto-load failed:",al,tostring(msg))
		end
	else
		pcall(function()
			if S.FILE.isfile and S.FILE.isfile(configPath("default")) then loadConfig("default") end
		end)
	end
end

if getgenv then
	getgenv().__ui_dodge={shutdown=S.doFullUnload,config=C,H=H}
end
if _G.__adStatusCb then _G.__adStatusCb("ready - N") end
print("[XD] LOADED", SCRIPT_NAME, SCRIPT_VERSION)

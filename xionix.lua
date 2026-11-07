--[[
    Xionix_Dewamp v 1.1
    Added: Halloween tab (cryptid ESP), Inf Jump, advanced Noclip (floor-safe).
    Removed: Rapid Fire, Infinite Ammo, Hitbox Expander.
    Instant Interact: single Enable toggle.
--]]

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players=game:GetService("Players")
local Workspace=game:GetService("Workspace")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local HttpService=game:GetService("HttpService")
local TweenService=game:GetService("TweenService")
local SoundService=game:GetService("SoundService")
local Lighting=game:GetService("Lighting")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local InsertService=game:GetService("InsertService")
local ProximityPromptService=game:GetService("ProximityPromptService")

local LP=Players.LocalPlayer
while not LP do task.wait(0.1) LP=Players.LocalPlayer end
if not game:IsLoaded() then game.Loaded:Wait() end
local Camera=Workspace.CurrentCamera

local SCRIPT_NAME="Xionix_Dewamp"
local SCRIPT_VERSION="v 1.1"

local S={}
S.FILE=(function()
    local env=(getgenv and getgenv()) or _G
    local function pick(n)
        local g=_G[n] or rawget(_G,n)
        if g then return g end
        if env and env[n] then return env[n] end
        return nil
    end
    return {writefile=pick("writefile"),readfile=pick("readfile"),isfile=pick("isfile"),
        isfolder=pick("isfolder"),makefolder=pick("makefolder"),
        listfiles=pick("listfiles"),delfile=pick("delfile")}
end)()

S.running=true S.unloaded=false
S.conns={} S.hooks={} S.added={}
S.oneClickDalgona=false S.dalgonaConn=nil
S.cachedSlot="T" S.cachedDodgeSlot="1" S.cachedUITool=nil S.cachedDodgeTool=nil
S.lastDodgeUI=0 S.lastDodgeH=0
S.combatHooked=false S.origFiredGun=nil S.origGetBuffs=nil S.gunMod=nil
S.fovGui=nil S.fovFrame=nil S.fovStroke=nil S.fovRainbowConn=nil
S.fbInst=nil S.fogBackup=nil
S.currentConfigName="default"
S.animEnabled={}
S.handCache={} S.legCache={} S.torsoCache={} S.origTransparency={} S.handsConn=nil
S.brewLoopConn=nil
S.btAnimConn=nil S.btLastIdTime={} S.btLastShot=0
S.aimbotConn=nil S.aimbotTarget=nil S.aimbotTargetTime=0
S.morphRate={lastMorph=0,session=0,nickTimes={}}
S.morphCache={userId={},models={},modelOrder={}}
S.morph={
    korbloxSaved={},headSaved=nil,activeKorblox=false,activeHeadless=false,
    korbloxManual=false,headlessManual=false,
    savedMorph={shirt=0,pants=0,graphic=0,headMesh=nil},
    active=false,_busy=false,_lastNick="",_watchConn=nil,_watchDebounce=false
}
S.hiddenNicks={} S.nickNameCache={} S.perCharConns={} S.watchedKeys={}
S._halloween={active=false, objects={}}

_G.__adEspDone=0 _G.__adEspTotal=0
_G.__dalgonaCache={} _G.__adWatchers={}
_G.__rlglLast=0 _G.__rlglRedStartAt=0 _G.__rlglWasRed=false
_G.__rlglLastSec=nil _G.__rlglTimerEndedAt=0 _G.__rlglLastFire=0
_G.__adUnloaded=false

do
    if getgenv and getgenv().__ui_dodge and getgenv().__ui_dodge.shutdown then
        pcall(function() getgenv().__ui_dodge.shutdown() end)
    end
    local h={}
    if gethui then pcall(function() table.insert(h,gethui()) end) end
    pcall(function() table.insert(h,game:GetService("CoreGui")) end)
    if LP then pcall(function() table.insert(h,LP:FindFirstChildOfClass("PlayerGui")) end) end
    for _,hh in ipairs(h) do
        if hh and typeof(hh)=="Instance" then
            for _,ch in ipairs(hh:GetChildren()) do
                if ch:IsA("ScreenGui") and (tostring(ch.Name):find("^XD_") or tostring(ch.Name):find("^Xionix_")) then
                    pcall(function() ch:Destroy() end)
                end
            end
        end
    end
end

local SHOT_ANIMS={
    ["rbxassetid://124637626540536"]="HK416",["rbxassetid://138748957635848"]="G3SG1",
    ["rbxassetid://96837363717592"]="Deagle",["rbxassetid://88111250846452"]="Glock 17",
    ["rbxassetid://87593987526528"]="FN Fal",["rbxassetid://76674339459544"]="MP5K",
    ["rbxassetid://122334383661670"]="M4A1",["rbxassetid://93906174064273"]="Five Seven",
    ["rbxassetid://84089564531020"]="Thompson M1A1",["rbxassetid://78301729996106"]="P90",
    ["rbxassetid://94523642657060"]="Uzi",["rbxassetid://83718615035368"]="Colt M1911",
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
    GuardESP_Highlight=true,GuardESP_Tracer=false,GuardESP_Box=false,
    GuardESP_HPBarThickness=8,GuardESP_HPBarLength=1.5,GuardESP_HPBarRoundness=3,
    GuardESP_ColorR=255,GuardESP_ColorG=50,GuardESP_ColorB=50,
    GuardESP_TracerR=255,GuardESP_TracerG=50,GuardESP_TracerB=50,
    GuardESP_BoxR=255,GuardESP_BoxG=50,GuardESP_BoxB=50,
    GuardESP_BoxThickness=2,GuardESP_NameSize=17,
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
    GuardESP_HP_Outline=false,GuardESP_HP_ChipBg=true,
    PlayerESP=false,PlayerESP_HP=true,PlayerESP_Name=true,PlayerESP_Tool=true,
    PlayerESP_Highlight=true,PlayerESP_Tracer=false,PlayerESP_Box=false,
    PlayerESP_HPBarThickness=8,PlayerESP_HPBarLength=1.5,PlayerESP_HPBarRoundness=3,
    PlayerESP_ColorR=80,PlayerESP_ColorG=255,PlayerESP_ColorB=120,
    PlayerESP_TracerR=80,PlayerESP_TracerG=255,PlayerESP_TracerB=120,
    PlayerESP_BoxR=80,PlayerESP_BoxG=255,PlayerESP_BoxB=120,
    PlayerESP_BoxThickness=2,PlayerESP_NameSize=17,
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
    PlayerESP_HP_Outline=false,PlayerESP_HP_ChipBg=true,
    PlayerESP_CustomName="",PlayerESP_NameRainbow=false,PlayerESP_NameRainbowSpeed=1.0,
    InstantInteract=false,
    MenuKey=Enum.KeyCode.N,
    RemoveLegs=false,RemoveHands=false,RemoveTorso=false,Headless=false,Korblox=false,
    HideNick=false,HideOtherNames=false,FullBright=false,FullBrightIntensity=0.3,RemoveFog=false,
    ESP_FontIdx=1,
    FOVRainbow=false,FOVRainbowMode=1,FOVUseCustom=false,FOVCustomIdx=1,
    FOVCustomR1=255,FOVCustomG1=60,FOVCustomB1=60,FOVCustomR2=60,FOVCustomG2=255,FOVCustomB2=60,
    FOVCustomR3=60,FOVCustomG3=140,FOVCustomB3=255,FOVCustomR4=255,FOVCustomG4=255,FOVCustomB4=60,
    FOVCustomR5=255,FOVCustomG5=60,FOVCustomB5=255,FOVCustomR6=60,FOVCustomG6=255,FOVCustomB6=255,
    FOVCustomR7=255,FOVCustomG7=180,FOVCustomB7=60,FOVCustomR8=255,FOVCustomG8=255,FOVCustomB8=255,
    FOVCustomR9=180,FOVCustomG9=60,FOVCustomB9=255,
    AutoBrew=false,AutoBrewSlot="E",AutoBrewInterval=1,AutoBrewBrewDelay=1.8,
    BulletTracer=false,
    BulletTracerR=255,BulletTracerG=147,BulletTracerB=255,
    BulletTracerThickness=0.20,BulletTracerSpeed=800,BulletTracerLifetime=2.00,
    BulletTracerRange=1050,BulletTracerStartOffset=0.30,BulletTracerEndOffset=0.00,
    BulletTracerOpacity=0.00,BulletTracerGlow=true,BulletTracerWhiteCore=true,
    BulletTracerFadeIdx=1,BulletTracerCooldown=0.03,
    ManualUISlot="",ManualHnSSlot="",
    GuiR=200,GuiG=60,GuiB=255,
    AnimSpeed=false,AnimSpeedValue=2.5,
    RLGL_AutoDodge=false,RLGL_OnlyRedLight=true,
    RLGL_MinInterval=0.75,RLGL_RedDelay=0.55,RLGL_VelThreshold=0.1,
    RLGL_TimerEndDodge=true,RLGL_TimerEndDelay=12,RLGL_TimerEndInterval=0.75,RLGL_TimerEndMaxDuration=9,
    RebelSilentAim=false,RebelSilentAimVisibleCheck=false,
    RebelNoRecoil=false,
    RebelAimbot=false,RebelAimbotHoldKey=false,RebelAimbotSmooth=1.0,RebelAimbotTargetGuards=true,
    RebelAimbotVisibleCheck=false,
    RebelFOV=250,RebelFOVCircle=false,RebelFOVNeon=true,RebelFOVBlackOutline=true,
    RebelFOV_OutlineThickness=5,RebelFOV_OutlineR=0,RebelFOV_OutlineG=0,RebelFOV_OutlineB=0,
    RebelFOVCircleWidth=1.6,RebelFOVBlendSpeed=0.5,
    RebelFOVR=255,RebelFOVG=60,RebelFOVB=60,
    RebelTargetPlayers=true,RebelTargetNPCs=true,
    RebelBodyHead=true,RebelBodyTorso=true,RebelBodyHRP=false,
    RebelBodyLeftArm=false,RebelBodyRightArm=false,RebelBodyLeftLeg=false,RebelBodyRightLeg=false,
    InfJump=false,Noclip=false,
    Halloween_Chams=false,Halloween_Tracers=false,Halloween_Boxes=false,Halloween_Names=false,Halloween_Dist=false,
    Halloween_ChamsR=170,Halloween_ChamsG=0,Halloween_ChamsB=255,
    Halloween_ChamsOutlineR=255,Halloween_ChamsOutlineG=255,Halloween_ChamsOutlineB=255,
    Halloween_ChamsOutlineTransparency=0,
    Halloween_TracerR=170,Halloween_TracerG=0,Halloween_TracerB=255,
    Halloween_BoxR=170,Halloween_BoxG=0,Halloween_BoxB=255,
    Halloween_TextR=220,Halloween_TextG=150,Halloween_TextB=255,
    Halloween_TracerThick=1,Halloween_BoxThick=1,Halloween_TextSize=14,Halloween_BoxScale=1,
    Halloween_RainbowChams=false,Halloween_RainbowTracers=false,
    Halloween_RainbowBoxes=false,Halloween_RainbowText=false,
    Halloween_MinD=0,Halloween_MaxD=5000,
}

local H={Enabled=false,Distance=18,Delay=0,MinInterval=0.02,AnimWatch=0.4,WatchAfter=0.3,
    RadiusVis=false,RadiusTransparency=0.55,RadiusR=70,RadiusG=210,RadiusB=255,HollyMode=true}

local ESP_FONT_NAMES={"GothamBlack","GothamBold","Gotham","Code","Arial","ArialBold",
    "SourceSans","SourceSansBold","SciFi","Fantasy","Roboto","RobotoMono","Ubuntu","Oswald",
    "Nunito","Bodoni","Cartoon","IndieFlower","PatrickHand","Antique","Garamond","Highway",
    "Legacy","PermanentMarker","Sarpanch","SpecialElite","Michroma"}

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
    table.insert(S.conns,c)
    return c
end

local function uiRadiusColor() return Color3.fromRGB(C.RadiusR or 255,C.RadiusG or 70,C.RadiusB or 160) end
local function hnsRadiusColor() return Color3.fromRGB(H.RadiusR or 70,H.RadiusG or 210,H.RadiusB or 255) end

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

local function guardHPGrad()
    return mkGrad5(
        C.GuardESP_HP_TopR or 80,C.GuardESP_HP_TopG or 255,C.GuardESP_HP_TopB or 80,
        C.GuardESP_HP_M1R or 180,C.GuardESP_HP_M1G or 255,C.GuardESP_HP_M1B or 60,
        C.GuardESP_HP_M2R or 255,C.GuardESP_HP_M2G or 200,C.GuardESP_HP_M2B or 40,
        C.GuardESP_HP_M3R or 255,C.GuardESP_HP_M3G or 120,C.GuardESP_HP_M3B or 60,
        C.GuardESP_HP_BotR or 255,C.GuardESP_HP_BotG or 40,C.GuardESP_HP_BotB or 40)
end
local function playerHPGrad()
    return mkGrad5(
        C.PlayerESP_HP_TopR or 80,C.PlayerESP_HP_TopG or 255,C.PlayerESP_HP_TopB or 80,
        C.PlayerESP_HP_M1R or 180,C.PlayerESP_HP_M1G or 255,C.PlayerESP_HP_M1B or 60,
        C.PlayerESP_HP_M2R or 255,C.PlayerESP_HP_M2G or 200,C.PlayerESP_HP_M2B or 40,
        C.PlayerESP_HP_M3R or 255,C.PlayerESP_HP_M3G or 120,C.PlayerESP_HP_M3B or 60,
        C.PlayerESP_HP_BotR or 255,C.PlayerESP_HP_BotG or 40,C.PlayerESP_HP_BotB or 40)
end

local function randStr(n) local s="" for _=1,n do s=s..string.char(math.random(97,122)) end return s end

local function addCorner(o,r)
    local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=o return c
end

local function ensureTracerGui()
    if S.tracerGui and S.tracerGui.Parent then return end
    S.tracerGui=Instance.new("ScreenGui")
    S.tracerGui.Name="Xionix_Tr_"..randStr(6)
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
    S.overlayGui.Name="Xionix_Ov_"..randStr(6)
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
    for _,ch in ipairs(model:GetChildren()) do
        if ch:IsA("BasePart") and normName(ch.Name)==t then return ch end
    end
    for _,ch in ipairs(model:GetDescendants()) do
        if ch:IsA("BasePart") and ch.Parent~=nil and normName(ch.Name)==t then return ch end
    end
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

local function getPlayerFireOrigin()
    local char=LP.Character
    if not char then local cam=Workspace.CurrentCamera return cam and cam.CFrame.Position or Vector3.zero end
    local attr=char:GetAttribute("HoldingWeapon")
    if type(attr)=="string" and attr~="" then
        local w=char:FindFirstChild(attr)
        if w then
            local ff=w:FindFirstChild("FireFrom")
            if ff and ff:IsA("BasePart") then return ff.Position end
            local hd=w:FindFirstChild("Handle")
            if hd and hd:IsA("BasePart") then return hd.Position end
        end
    end
    for _,c in ipairs(char:GetChildren()) do
        if c:IsA("Tool") then
            local ff=c:FindFirstChild("FireFrom")
            if ff and ff:IsA("BasePart") then return ff.Position end
            local hd=c:FindFirstChild("Handle")
            if hd and hd:IsA("BasePart") then return hd.Position end
        end
    end
    local head=char:FindFirstChild("Head")
    if head then return head.Position end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    if hrp then return hrp.Position end
    for _,c in ipairs(char:GetDescendants()) do if c:IsA("BasePart") then return c.Position end end
    return Vector3.zero
end

local function isTargetVisible(targetChar)
    if not targetChar or not targetChar.Parent then return false end
    local fromPos=getPlayerFireOrigin()
    if not fromPos then return false end
    local parts={}
    local head=targetChar:FindFirstChild("Head")
    if head then table.insert(parts,head) end
    local torso=targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso")
    if torso then table.insert(parts,torso) end
    local hrp=targetChar:FindFirstChild("HumanoidRootPart")
    if hrp then table.insert(parts,hrp) end
    if #parts==0 then return false end
    local rp=RaycastParams.new()
    rp.FilterType=Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances={LP.Character}
    for _,part in ipairs(parts) do
        if part.Position then
            local dir=part.Position-fromPos
            if dir.Magnitude>0.01 then
                local hit=Workspace:Raycast(fromPos,dir,rp)
                if hit then
                    local hInst=hit.Instance
                    if hInst==part or hInst:IsDescendantOf(targetChar) then return true end
                end
            end
        end
    end
    return false
end

local function findBrewInInventory()
    local function scan(c)
        if not c then return nil end
        for _,cc in ipairs(c:GetChildren()) do
            if cc:IsA("Tool") and string.lower(cc.Name):find("brew") then return cc end
        end
        return nil
    end
    return scan(LP.Character) or scan(LP:FindFirstChild("Backpack"))
end

local DRINK_WORDS={"drink","iron brew","rush soda","twin shot","rapid reload","focus tonic","brew","soda","tonic","shot","reload"}
local function isDrinkPrompt(p)
    if not p or not p:IsA("ProximityPrompt") then return false end
    local ok1,at=pcall(function() return string.lower(tostring(p.ActionText or "")) end)
    local ok2,ot=pcall(function() return string.lower(tostring(p.ObjectText or "")) end)
    if not ok1 or not ok2 then return false end
    for _,kw in ipairs(DRINK_WORDS) do
        if at:find(kw,1,true) or ot:find(kw,1,true) then return true end
    end
    return false
end

local function press(k)
    if S.unloaded then return end
    k=string.lower(tostring(k or "t"))
    local code=KEYMAP[k]
    if not code then return end
    local kc=Enum.KeyCode[string.upper(k)] or Enum.KeyCode.T
    if hasNativePress then
        local ok=pcall(function()
            keypress(code)
            task.delay(math.random(40,90)/1000,function() pcall(function() keyrelease(code) end) end)
        end)
        if ok then return end
    end
    pcall(function()
        local vim=game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true,kc,false,game)
        task.delay(math.random(40,90)/1000,function() pcall(function() vim:SendKeyEvent(false,kc,false,game) end) end)
    end)
end

local function mouseClick()
    if S.unloaded then return end
    local cam=Workspace.CurrentCamera
    local vp=(cam and cam.ViewportSize) or Vector2.new(800,600)
    local cx=math.floor(vp.X/2) local cy=math.floor(vp.Y/2)
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
        for _,cc in ipairs(c:GetChildren()) do
            if cc:IsA("Tool") and isUIToolName(cc.Name) then return cc end
        end
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
    local firedC=false local firedH=false local allowH=false
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
        w.c=w.c-1 if w.c<=0 then _G.__adWatchers[hrp]=nil end return
    end
    local t0=tick()
    local baseC=math.max(C.AnimWatch or 0.4,animLen+(C.WatchAfter or 0.3))
    local baseH=math.max(H.AnimWatch or 0.4,animLen+(H.WatchAfter or 0.3))
    local maxWatch=math.max(baseC+animDelay,baseH+animDelay)
    local conn
    local function finish()
        if conn then pcall(function() conn:Disconnect() end) conn=nil end
        w.c=w.c-1 if w.c<=0 then _G.__adWatchers[hrp]=nil end
    end
    local function check()
        if S.unloaded or (firedC and firedH) then finish() return end
        if tick()-t0>maxWatch then finish() return end
        local my=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not my or not hrp or not hrp.Parent then finish() return end
        local el=tick()-t0
        local distC=C.Distance or 18 local distH=H.Distance or 18
        local v=hrp.AssemblyLinearVelocity local spd=math.sqrt(v.X*v.X+v.Z*v.Z)
        if spd>15 then
            local dx=my.Position.X-hrp.Position.X
            local dz=my.Position.Z-hrp.Position.Z
            local dist=math.sqrt(dx*dx+dz*dz)
            if dist>0.5 then
                local dot=(v.X*dx+v.Z*dz)/(dist*spd)
                if dot>0.5 then local reach=spd*0.2 distC=distC+reach distH=distH+reach end
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
    local cx=cam.ViewportSize.X/2 local cy=cam.ViewportSize.Y/2
    local dx=sp.X-cx local dy=sp.Y-cy
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

local function findSilentAimTarget(_fp)
    local cam=Workspace.CurrentCamera
    if not cam then return nil end
    local cx=cam.ViewportSize.X/2 local cy=cam.ViewportSize.Y/2
    local bestPart,bestDist=nil,math.huge
    local seen={}
    local function consider(char)
        if not char or seen[char] then return end
        seen[char]=true
        if not isCharValidTarget(char) then return end
        if C.RebelSilentAimVisibleCheck and not isTargetVisible(char) then return end
        local part=getRandomBodyPart(char)
        if not part or not isPartInFOV(part) then return end
        local sp,onScreen=cam:WorldToViewportPoint(part.Position)
        if not onScreen then return end
        local dx=sp.X-cx local dy=sp.Y-cy
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
    if S.combatHooked then if S.gunMod and S.gunMod.FiredGun~=S.origFiredGun then return end end
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
    if not S.origFiredGun then S.origFiredGun=mod.FiredGun end
    if not S.origGetBuffs then S.origGetBuffs=mod.GetBuffs end
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
    S.combatHooked=false S.origFiredGun=nil S.origGetBuffs=nil
end

local function aimbotFindTarget()
    local cam=Workspace.CurrentCamera
    if not cam then return nil end
    local cx=cam.ViewportSize.X/2 local cy=cam.ViewportSize.Y/2
    local fov=C.RebelFOV or 250
    local bestPart,bestDist=nil,math.huge
    local seen={}
    local sticky=S.aimbotTarget
    if sticky and sticky.Parent and sticky:IsDescendantOf(Workspace) then
        local stickyChar=sticky:FindFirstAncestorOfClass("Model")
        if stickyChar and stickyChar.Parent then
            local sHum=stickyChar:FindFirstChildOfClass("Humanoid")
            if sHum and sHum.Health>0 then
                local part=getRandomBodyPart(stickyChar)
                if part then
                    local sp,onScreen=cam:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dx=sp.X-cx local dy=sp.Y-cy
                        local d=math.sqrt(dx*dx+dy*dy)
                        if d<=fov*1.5 then
                            local visible=true
                            if C.RebelAimbotVisibleCheck then visible=isTargetVisible(stickyChar) end
                            if visible then return part end
                        end
                    end
                end
            end
        end
    end
    S.aimbotTarget=nil
    local function consider(char)
        if not char or seen[char] then return end
        seen[char]=true
        if not isCharValidTarget(char) then return end
        if C.RebelAimbotVisibleCheck and not isTargetVisible(char) then return end
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
    if bestPart then S.aimbotTarget=bestPart S.aimbotTargetTime=tick() end
    return bestPart
end

local function startAimbot()
    if S.aimbotConn then return end
    S.aimbotConn=RunService.RenderStepped:Connect(function()
        if S.unloaded or not C.RebelAimbot then return end
        local cam=Workspace.CurrentCamera
        if not cam then return end
        if C.RebelAimbotHoldKey then
            if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                S.aimbotTarget=nil return
            end
        end
        local part=aimbotFindTarget()
        if not part or not part.Parent then return end
        local camPos=cam.CFrame.Position
        local wantCF=CFrame.new(camPos,part.Position)
        local sm=tonumber(C.RebelAimbotSmooth) or 1.0
        if sm<=0.05 then cam.CFrame=wantCF
        else
            local alpha=math.clamp(1/sm*0.4,0.02,1)
            cam.CFrame=cam.CFrame:Lerp(wantCF,alpha)
        end
    end)
end
local function stopAimbot()
    S.aimbotTarget=nil
    if S.aimbotConn then pcall(function() S.aimbotConn:Disconnect() end) S.aimbotConn=nil end
end

local function doBrewUse()
    if S.unloaded or not C.AutoBrew then return false end
    local invBrew=findBrewInInventory()
    if not invBrew then return false end
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if invBrew.Parent~=char then
        pcall(function() hum:EquipTool(invBrew) end)
        task.wait(0.15)
    end
    press(string.lower(tostring(C.AutoBrewSlot or "e")))
    return true
end

local function scanDrinks()
    if not fireproximityprompt then return 0 end
    local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local fired=0
    local roots={workspace}
    local live=workspace:FindFirstChild("Live")
    if live then table.insert(roots,live) end
    local effects=workspace:FindFirstChild("Effects")
    if effects then table.insert(roots,effects) end
    for _,root in ipairs(roots) do
        for _,obj in ipairs(root:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local parent=obj.Parent local pos
                if parent then
                    if parent:IsA("BasePart") then pos=parent.Position
                    else local p=parent:FindFirstChildWhichIsA("BasePart") if p then pos=p.Position end end
                end
                if pos and (hrp.Position-pos).Magnitude<=20 then
                    if isDrinkPrompt(obj) then pcall(fireproximityprompt,obj) fired=fired+1 end
                end
            end
        end
    end
    return fired
end

local function startBrewLoop()
    if S.brewLoopConn then return end
    S.lastBrewTick=0
    S.brewLoopConn=task.spawn(function()
        while not S.unloaded and C.AutoBrew do
            local now=tick()
            pcall(scanDrinks)
            local invBrew=findBrewInInventory()
            local interval=tonumber(C.AutoBrewInterval) or 1
            if invBrew and (now-S.lastBrewTick)>=interval then
                S.lastBrewTick=now
                local used=doBrewUse()
                if used then
                    local bd=tonumber(C.AutoBrewBrewDelay) or 1.8
                    task.wait(bd)
                    for i=1,8 do
                        if S.unloaded or not C.AutoBrew then return end
                        local n=scanDrinks()
                        if n>0 then task.wait(0.2) else task.wait(0.3) end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end
local function stopBrewLoop()
    if S.brewLoopConn then pcall(function() task.cancel(S.brewLoopConn) end) S.brewLoopConn=nil end
    S.lastBrewTick=0
end

local function destroyFOVCircle()
    if S.fovGui then pcall(function() S.fovGui:Destroy() end) end
    S.fovGui=nil S.fovFrame=nil S.fovStroke=nil
end
local function stopFovRainbow() if S.fovRainbowConn then pcall(function() S.fovRainbowConn:Disconnect() end) S.fovRainbowConn=nil end end
local function startFovRainbow()
    stopFovRainbow()
    S.fovRainbowConn=RunService.RenderStepped:Connect(function()
        if S.unloaded or not C.FOVRainbow then return end
        if not S.fovFrame or not S.fovFrame.Parent then return end
        local t=tick()
        local col=Color3.fromHSV((t*0.35)%1,1,1)
        for _,ch in ipairs(S.fovFrame:GetChildren()) do
            if ch:IsA("Frame") then
                for _,st in ipairs(ch:GetChildren()) do
                    if st:IsA("UIStroke") and st.Name~="BlackStrokeOuter" and st.Name~="BlackStrokeInner" then st.Color=col end
                end
            end
        end
        if S.fovStroke then S.fovStroke.Color=col end
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
    S.fovGui.Name="Xionix_FOV_"..randStr(6)
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
    end
    if C.RebelFOVNeon then
        local g1=Instance.new("Frame") g1.Name="Glow1" g1.BackgroundTransparency=1 g1.Size=UDim2.fromScale(1,1)
        g1.AnchorPoint=Vector2.new(0.5,0.5) g1.Position=UDim2.fromScale(0.5,0.5)
        g1.ZIndex=999 g1.Parent=S.fovFrame addCorner(g1,radius)
        local g1s=Instance.new("UIStroke") g1s.Color=rebelFOVColor() g1s.Thickness=14 g1s.Transparency=0.82 g1s.Parent=g1
    end
    S.fovStroke=Instance.new("UIStroke")
    S.fovStroke.Color=rebelFOVColor()
    S.fovStroke.Thickness=tonumber(C.RebelFOVCircleWidth) or 1.6
    S.fovStroke.Transparency=0
    S.fovStroke.Parent=S.fovFrame
    local inr=Instance.new("Frame")
    inr.Name="Inner" inr.BackgroundTransparency=1 inr.Size=UDim2.fromScale(1,1)
    inr.AnchorPoint=Vector2.new(0.5,0.5) inr.Position=UDim2.fromScale(0.5,0.5)
    inr.ZIndex=1001 inr.Parent=S.fovFrame addCorner(inr,radius)
    local is=Instance.new("UIStroke")
    is.Name="InnerStroke" is.Color=rebelFOVColor() is.Thickness=1.2 is.Transparency=0.15 is.Parent=inr
    if C.FOVRainbow then startFovRainbow() end
end
local function refreshFOVCircle()
    if not S.fovFrame then return end
    local d=math.max(4,(C.RebelFOV or 150)*2)
    local radius=math.floor(d/2)
    S.fovFrame.Size=UDim2.fromOffset(d,d)
    local c=S.fovFrame:FindFirstChildOfClass("UICorner")
    if c then c.CornerRadius=UDim.new(0,radius) end
end

local uiDisc,hnsDisc,vizConn
local lastVizKey=""
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
    local key=tostring(C.RadiusVis).."|"..tostring(H.RadiusVis).."|"..tostring(C.Distance).."|"..tostring(H.Distance)
    if key==lastVizKey then return end
    lastVizKey=key
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
            hnsDisc.CFrame=CFrame.new(base+Vector3.new(0,0.02,0))*CFrame.Angles(0,0,math.rad(90))
            hnsDisc.Size=Vector3.new(0.08,d,d)
            hnsDisc.Color=hnsRadiusColor()
            hnsDisc.Transparency=math.clamp(1-(H.RadiusTransparency or 0.55),0.1,0.9)
        end
    end)
end

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
            S.fbInst.Name="Xionix_FB"
            S.fbInst.Contrast=0.15 S.fbInst.Saturation=0.05
            S.fbInst.Parent=Lighting
        end
        S.fbInst.Brightness=tonumber(C.FullBrightIntensity) or 0.3
    else
        if S.fbInst then pcall(function() S.fbInst:Destroy() end) S.fbInst=nil end
    end
end
local function applyRemoveFog(st)
    if st then
        if not S.fogBackup then
            S.fogBackup={FogEnd=Lighting.FogEnd,FogStart=Lighting.FogStart,FogColor=Lighting.FogColor}
        end
        Lighting.FogEnd=1000000 Lighting.FogStart=1000000
    else
        if S.fogBackup then
            Lighting.FogEnd=S.fogBackup.FogEnd
            Lighting.FogStart=S.fogBackup.FogStart
            Lighting.FogColor=S.fogBackup.FogColor
            S.fogBackup=nil
        end
    end
end

-- ===== FULL BULLET TRACER =====
local btFadeStyles={
    {name="Quad",style=Enum.EasingStyle.Quad},{name="Linear",style=Enum.EasingStyle.Linear},
    {name="Expo",style=Enum.EasingStyle.Exponential},{name="Back",style=Enum.EasingStyle.Back},
    {name="Circ",style=Enum.EasingStyle.Circular},{name="Sine",style=Enum.EasingStyle.Sine},
    {name="Quint",style=Enum.EasingStyle.Quint},{name="Bounce",style=Enum.EasingStyle.Bounce},
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
            if hd and hd:IsA("BasePart") then return hd.Position+hd.CFrame.LookVector*0.5 end
        end
    end
    return hrp.Position+hrp.CFrame.LookVector*1.5+Vector3.new(0,0.8,0)
end
local function btGetTarget(fromPos)
    local cam=Workspace.CurrentCamera
    if not cam then return nil end
    local vp=cam.ViewportSize
    local dir=cam:ViewportPointToRay(vp.X/2,vp.Y/2).Direction
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
        p.Name="Xionix_BTracer" p.Anchored=true p.CanCollide=false
        p.CanQuery=false p.CanTouch=false p.CastShadow=false
        p.Material=Enum.Material.Neon p.Color=color p.Transparency=trans
        p.Size=partSize p.CFrame=cf p.Parent=workspace
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
    if S.btAnimConn then pcall(function() S.btAnimConn:Disconnect() end) S.btAnimConn=nil end
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
        c=hum.ChildAdded:Connect(function(ch) if ch:IsA("Animator") then btAttachAnimator(ch) pcall(function() c:Disconnect() end) end end)
    end
end
if LP.Character then btWatchChar(LP.Character) end
track(LP.CharacterAdded:Connect(function(ch) task.wait(0.5) btWatchChar(ch) end))

-- ===== FULL ESP =====
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
    hl.Name="Xionix_HL" hl.FillTransparency=0.4 hl.OutlineTransparency=0
    hl.FillColor=color hl.OutlineColor=darkColor hl.Adornee=char hl.Parent=char
    local nameBill=Instance.new("BillboardGui")
    nameBill.Name="Xionix_NAME" nameBill.Size=UDim2.fromOffset(360,26)
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
    hpChip.BorderSizePixel=0 hpChip.Parent=container addCorner(hpChip,5)
    local hpChipStroke=Instance.new("UIStroke")
    hpChipStroke.Thickness=1.5 hpChipStroke.Transparency=0 hpChipStroke.Color=Color3.new(0,0,0)
    hpChipStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border hpChipStroke.Parent=hpChip
    local hpLbl=Instance.new("TextLabel")
    hpLbl.Size=UDim2.fromScale(1,1) hpLbl.BackgroundTransparency=1
    hpLbl.Font=Enum.Font.GothamBlack hpLbl.TextSize=13
    hpLbl.TextColor3=Color3.new(1,1,1)
    hpLbl.TextStrokeTransparency=0 hpLbl.TextStrokeColor3=Color3.new(0,0,0)
    hpLbl.Text="[100]" hpLbl.Parent=hpChip
    local nl=Instance.new("TextLabel")
    nl.LayoutOrder=2 nl.BackgroundTransparency=1
    nl.AutomaticSize=Enum.AutomaticSize.X nl.Size=UDim2.fromOffset(0,24)
    nl.Font=espFont() nl.TextSize=nameSize or 17
    nl.TextColor3=Color3.new(1,1,1) nl.TextStrokeTransparency=0
    nl.TextStrokeColor3=Color3.new(0,0,0)
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
        toolBill=toolBill,toolL=tl,hpBar=hpBar,hpBg=hpBg,hpFill=hpFill,hpGradient=hpGradient,
        hpBgCorner=hpBgCorner,hpFillCorner=hpFillCorner,distBill=distBill,distL=dl,
        tracer=tracer,box=box,boxStroke=boxStroke,
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
                        if e.hpLbl then e.hpLbl.TextColor3=chipCol end
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
                            if not C.PlayerESP_NameRainbow then e.nameL.TextColor3=Color3.new(1,1,1) end
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
                    local oX=vp.X/2 local oY=vp.Y/2
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
                                    local dx=sp.X-oX local dy=sp.Y-oY
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
                                    local fdx=tx-oX local fdy=ty-oY
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
                    if e.nameL and e.nameL.Parent then pcall(function() e.nameL.TextColor3=col end) end
                end
            end
        end)
        RunService.RenderStepped:Wait()
    end
end)

-- ===== HALLOWEEN =====
local function _hlwCheck(n) return string.find(string.lower(tostring(n or "")),"cryptid",1,true)~=nil end
local function _hlwIsTarget(v)
    if not (v:IsA("Model") or v:IsA("BasePart")) then return false end
    if not _hlwCheck(v.Name) then return false end
    if v:IsA("BasePart") then
        local p=v.Parent
        if p and p:IsA("Model") and _hlwCheck(p.Name) then return false end
    end
    return true
end
local function _hlwModel(obj)
    if obj:IsA("Model") then return obj end
    return obj:FindFirstAncestorOfClass("Model") or obj
end
local function _hlwSetup(obj)
    if S._halloween.objects[obj] then return end
    local model=_hlwModel(obj)
    local root=model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart or (model:IsA("BasePart") and model)
    if not root then return end
    local hl=Instance.new("Highlight")
    hl.Name="xionix_c_hl" hl.Parent=Camera hl.Adornee=model
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor=Color3.fromRGB(C.Halloween_ChamsR,C.Halloween_ChamsG,C.Halloween_ChamsB)
    hl.FillTransparency=0.5
    hl.OutlineColor=Color3.fromRGB(C.Halloween_ChamsOutlineR,C.Halloween_ChamsOutlineG,C.Halloween_ChamsOutlineB)
    hl.OutlineTransparency=C.Halloween_ChamsOutlineTransparency
    hl.Enabled=false
    local bb=Instance.new("BillboardGui")
    bb.Name="xionix_c_bb" bb.Size=UDim2.fromOffset(200,40)
    bb.StudsOffset=Vector3.new(0,3,0) bb.AlwaysOnTop=true
    bb.MaxDistance=math.huge bb.Adornee=root bb.Enabled=false
    bb.Parent=model
    local txt=Instance.new("TextLabel")
    txt.Size=UDim2.fromScale(1,1) txt.BackgroundTransparency=1
    txt.Font=Enum.Font.GothamBold txt.TextSize=C.Halloween_TextSize
    txt.TextColor3=Color3.fromRGB(C.Halloween_TextR,C.Halloween_TextG,C.Halloween_TextB)
    txt.TextStrokeTransparency=0.4 txt.TextStrokeColor3=Color3.new(0,0,0)
    txt.Parent=bb
    local tr,bx
    if Drawing then
        tr=Drawing.new("Line")
        tr.Color=Color3.fromRGB(C.Halloween_TracerR,C.Halloween_TracerG,C.Halloween_TracerB)
        tr.Thickness=C.Halloween_TracerThick
        tr.Transparency=1 tr.Visible=false
        bx=Drawing.new("Square")
        bx.Color=Color3.fromRGB(C.Halloween_BoxR,C.Halloween_BoxG,C.Halloween_BoxB)
        bx.Thickness=C.Halloween_BoxThick
        bx.Filled=false bx.Transparency=1 bx.Visible=false
    end
    S._halloween.objects[obj]={hl=hl,bb=bb,txt=txt,tr=tr,bx=bx,root=root,model=model}
end
local function _hlwCleanup(obj)
    local d=S._halloween.objects[obj]
    if not d then return end
    if d.hl then pcall(function() d.hl:Destroy() end) end
    if d.bb then pcall(function() d.bb:Destroy() end) end
    if d.tr then pcall(function() d.tr:Remove() end) end
    if d.bx then pcall(function() d.bx:Remove() end) end
    S._halloween.objects[obj]=nil
end
local function _hlwScan()
    if S._halloween.active then return end
    S._halloween.active=true
    task.spawn(function()
        local queue={Workspace} local i=1 local count=0
        while i<=#queue and not S.unloaded and S._halloween.active do
            local cur=queue[i] i=i+1
            for _,ch in ipairs(cur:GetChildren()) do
                if _hlwIsTarget(ch) then pcall(_hlwSetup,ch) end
                table.insert(queue,ch)
                count=count+1
                if count%500==0 then task.wait() end
            end
        end
    end)
end
local function _hlwClear()
    S._halloween.active=false
    for obj in pairs(S._halloween.objects) do _hlwCleanup(obj) end
    table.clear(S._halloween.objects)
end
track(Workspace.DescendantAdded:Connect(function(v)
    if S.unloaded or not S._halloween.active then return end
    if _hlwIsTarget(v) then task.defer(function() if v and v.Parent and not S.unloaded then pcall(_hlwSetup,v) end end) end
end))
task.spawn(function()
    while S.running and not S.unloaded do
        RunService.RenderStepped:Wait()
        if not S.unloaded and (C.Halloween_Chams or C.Halloween_Tracers or C.Halloween_Boxes or C.Halloween_Names or C.Halloween_Dist) then
            pcall(function()
                local char=LP.Character
                local hrp=char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local rbw=Color3.fromHSV((tick()*0.5)%1,1,1)
                local vp=Camera.ViewportSize
                local oX=vp.X/2 local oY=vp.Y/2
                for obj,d in pairs(S._halloween.objects) do
                    local root=d.root
                    if not root or not root.Parent or not obj.Parent then
                        _hlwCleanup(obj)
                    else
                        local sp,onScr=Camera:WorldToViewportPoint(root.Position)
                        local dist=math.max(1,math.floor((hrp.Position-root.Position).Magnitude))
                        local inRange=dist>=C.Halloween_MinD and dist<=C.Halloween_MaxD
                        if C.Halloween_Chams and inRange then
                            d.hl.Enabled=true
                            d.hl.FillColor=C.Halloween_RainbowChams and rbw or Color3.fromRGB(C.Halloween_ChamsR,C.Halloween_ChamsG,C.Halloween_ChamsB)
                            d.hl.OutlineColor=C.Halloween_RainbowChams and rbw or Color3.fromRGB(C.Halloween_ChamsOutlineR,C.Halloween_ChamsOutlineG,C.Halloween_ChamsOutlineB)
                            d.hl.OutlineTransparency=C.Halloween_ChamsOutlineTransparency
                        else
                            d.hl.Enabled=false
                        end
                        if (C.Halloween_Names or C.Halloween_Dist) and inRange then
                            local tStr=""
                            if C.Halloween_Names then tStr=obj.Name end
                            if C.Halloween_Dist then
                                if tStr~="" then tStr=tStr.." " end
                                tStr=tStr.."["..dist.."m]"
                            end
                            if tStr~="" then
                                d.bb.Enabled=true
                                d.txt.Text=tStr
                                d.txt.TextColor3=C.Halloween_RainbowText and rbw or Color3.fromRGB(C.Halloween_TextR,C.Halloween_TextG,C.Halloween_TextB)
                                d.txt.TextSize=C.Halloween_TextSize
                            else d.bb.Enabled=false end
                        else d.bb.Enabled=false end
                        if d.bx then
                            if C.Halloween_Boxes and inRange and onScr and sp.Z>0 then
                                local baseH=(vp.Y/dist)*3
                                local h=baseH*C.Halloween_BoxScale
                                local w=h/2
                                d.bx.Size=Vector2.new(w,h)
                                d.bx.Position=Vector2.new(sp.X-w/2,sp.Y-h/2)
                                d.bx.Color=C.Halloween_RainbowBoxes and rbw or Color3.fromRGB(C.Halloween_BoxR,C.Halloween_BoxG,C.Halloween_BoxB)
                                d.bx.Thickness=C.Halloween_BoxThick
                                d.bx.Visible=true
                            else d.bx.Visible=false end
                        end
                        if d.tr then
                            if C.Halloween_Tracers and inRange then
                                local dx=sp.X-oX local dy=sp.Y-oY
                                local bh=(sp.Z<0)
                                if bh then dx=-dx dy=-dy end
                                local tx,ty
                                if onScr and not bh then tx=sp.X ty=sp.Y
                                else
                                    local rl=math.sqrt(dx*dx+dy*dy)
                                    local ux,uy=0,1
                                    if rl>0.01 then ux=dx/rl uy=dy/rl end
                                    local tL=math.huge
                                    if ux>0 then tL=math.min(tL,(vp.X-oX)/ux) elseif ux<0 then tL=math.min(tL,-oX/ux) end
                                    if uy>0 then tL=math.min(tL,(vp.Y-oY)/uy) elseif uy<0 then tL=math.min(tL,-oY/uy) end
                                    if tL==math.huge or tL<1 then tL=1 end
                                    tx=oX+ux*tL ty=oY+uy*tL
                                end
                                if tx~=tx then tx=oX end
                                if ty~=ty then ty=oY+100 end
                                tx=math.clamp(tx,0,vp.X) ty=math.clamp(ty,0,vp.Y)
                                d.tr.From=Vector2.new(oX,oY) d.tr.To=Vector2.new(tx,ty)
                                d.tr.Color=C.Halloween_RainbowTracers and rbw or Color3.fromRGB(C.Halloween_TracerR,C.Halloween_TracerG,C.Halloween_TracerB)
                                d.tr.Thickness=math.max(1,C.Halloween_TracerThick)
                                d.tr.Visible=true
                            else d.tr.Visible=false end
                        end
                    end
                end
            end)
        end
    end
end)

-- ===== ONE CLICK DALGONA =====
local function setOneClickDalgona(v)
    local state=v and true or false
    if state==S.oneClickDalgona then return end
    S.oneClickDalgona=state
    if S.dalgonaConn then pcall(function() S.dalgonaConn:Disconnect() end) S.dalgonaConn=nil end
    if not state then
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

-- ===== LIMB REMOVE =====
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
        if h then for _,d in ipairs(h:GetChildren()) do if d:IsA("Attachment") and HA[string.lower(d.Name)] then return true end end end
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

-- ===== MORPH =====
local MORPH_KRB_R15_MESH="rbxassetid://902942096"
local MORPH_KRB_R15_TEXTURE="rbxassetid://902843398"
local MORPH_KRB_R6_MESH="rbxassetid://101851696"
local MORPH_KRB_R6_TEXTURE="rbxassetid://101851254"
local MORPH_KRB_COLOR=Color3.fromRGB(64,64,64)
local MORPH_DEFAULT_FACE="rbxasset://textures/face.png"
local MORPH_COOLDOWN=13
local MORPH_NICK_COOLDOWN=120
local MORPH_SESSION_MAX=15

local function morphCheckRate(nick)
    local now=tick()
    if S.morphRate.session>=MORPH_SESSION_MAX then return false,"Session limit" end
    if now-S.morphRate.lastMorph<MORPH_COOLDOWN then return false,"Wait" end
    if nick and S.morphRate.nickTimes[nick] and now-S.morphRate.nickTimes[nick]<MORPH_NICK_COOLDOWN then return false,"Same nick wait" end
    return true,"ok"
end
local function morphMarkRate(nick)
    local now=tick()
    S.morphRate.lastMorph=now
    S.morphRate.session=S.morphRate.session+1
    if nick then S.morphRate.nickTimes[nick]=now end
end
local function morphGetCachedUserId(nick)
    if S.morphCache.userId[nick] then return S.morphCache.userId[nick] end
    local ok,uid=pcall(function() return Players:GetUserIdFromNameAsync(nick) end)
    if ok and uid then S.morphCache.userId[nick]=uid return uid end
    return nil
end
local function morphCacheModel(id,model)
    S.morphCache.models[id]=model
    table.insert(S.morphCache.modelOrder,id)
    while #S.morphCache.modelOrder>15 do
        local old=table.remove(S.morphCache.modelOrder,1)
        if old~=id and S.morphCache.models[old] then
            pcall(function() S.morphCache.models[old]:Destroy() end)
            S.morphCache.models[old]=nil
        end
    end
end
local function morphLoadModel(id)
    if S.morphCache.models[id] and S.morphCache.models[id].Parent then return S.morphCache.models[id]:Clone() end
    local done=false local result=nil
    task.spawn(function()
        local ok,objs=pcall(function() return game:GetObjects("rbxassetid://"..tostring(id)) end)
        if ok and objs and #objs>0 then result=objs[1] end
        if not result then
            local ok2,m=pcall(function() return InsertService:LoadAsset(id) end)
            if ok2 and m then result=m end
        end
        done=true
    end)
    local t0=tick()
    while not done and (tick()-t0)<3 do task.wait(0.05) end
    if result then
        local cacheCopy=result:Clone()
        morphCacheModel(id,cacheCopy)
    end
    return result
end
local function morphApplyKorblox(char)
    if not char then return false end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if hum.RigType==Enum.HumanoidRigType.R15 then
        local ru=char:FindFirstChild("RightUpperLeg")
        local rl=char:FindFirstChild("RightLowerLeg")
        local rf=char:FindFirstChild("RightFoot")
        if not (ru and rl and rf) then return false end
        if not S.morph.korbloxSaved.ru then
            S.morph.korbloxSaved.ru={meshId=ru.MeshId,textureId=ru.TextureID,color=ru.Color,tRL=rl.Transparency,tRF=rf.Transparency}
        end
        if ru.MeshId~=MORPH_KRB_R15_MESH then pcall(function() ru.MeshId=MORPH_KRB_R15_MESH ru.TextureID=MORPH_KRB_R15_TEXTURE end) end
        if rl.Transparency~=1 then rl.Transparency=1 end
        if rf.Transparency~=1 then rf.Transparency=1 end
        if ru.Color~=Color3.new(1,1,1) then ru.Color=Color3.new(1,1,1) end
        if ru.Transparency~=0 then ru.Transparency=0 end
        return true
    else
        local rightLeg=char:FindFirstChild("Right Leg")
        if not rightLeg then return false end
        if not S.morph.korbloxSaved.r6 then
            local savedMesh=nil
            for _,v in ipairs(rightLeg:GetChildren()) do
                if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then savedMesh=v:Clone() break end
            end
            S.morph.korbloxSaved.r6={color=rightLeg.Color,transparency=rightLeg.Transparency,mesh=savedMesh}
        end
        local existing=rightLeg:FindFirstChildOfClass("SpecialMesh")
        if not existing or existing.MeshId~=MORPH_KRB_R6_MESH then
            for _,v in ipairs(rightLeg:GetChildren()) do
                if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
            end
            local mesh=Instance.new("SpecialMesh")
            mesh.MeshType=Enum.MeshType.FileMesh
            mesh.MeshId=MORPH_KRB_R6_MESH
            mesh.TextureId=MORPH_KRB_R6_TEXTURE
            mesh.Parent=rightLeg
        end
        if rightLeg.Color~=MORPH_KRB_COLOR then rightLeg.Color=MORPH_KRB_COLOR end
        if rightLeg.Transparency~=0 then rightLeg.Transparency=0 end
        return true
    end
end
local function morphRemoveKorblox(char)
    if not char then return false end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if hum.RigType==Enum.HumanoidRigType.R15 then
        local ru=char:FindFirstChild("RightUpperLeg")
        local rl=char:FindFirstChild("RightLowerLeg")
        local rf=char:FindFirstChild("RightFoot")
        if ru and rl and rf and S.morph.korbloxSaved.ru then
            pcall(function() ru.MeshId=S.morph.korbloxSaved.ru.meshId or "" ru.TextureID=S.morph.korbloxSaved.ru.textureId or "" end)
            ru.Color=S.morph.korbloxSaved.ru.color or ru.Color
            rl.Transparency=S.morph.korbloxSaved.ru.tRL or 0
            rf.Transparency=S.morph.korbloxSaved.ru.tRF or 0
            S.morph.korbloxSaved.ru=nil
        end
    else
        local rightLeg=char:FindFirstChild("Right Leg")
        if rightLeg and S.morph.korbloxSaved.r6 then
            for _,v in ipairs(rightLeg:GetChildren()) do
                if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
            end
            rightLeg.Color=S.morph.korbloxSaved.r6.color or rightLeg.Color
            rightLeg.Transparency=S.morph.korbloxSaved.r6.transparency or 0
            if S.morph.korbloxSaved.r6.mesh then S.morph.korbloxSaved.r6.mesh:Clone().Parent=rightLeg end
            S.morph.korbloxSaved.r6=nil
        end
    end
    return true
end
local function morphSaveHeadState(char)
    local head=char:FindFirstChild("Head")
    if not head then return end
    if S.morph.headSaved and S.morph.headSaved.char==char then return end
    local decals={}
    for _,c in ipairs(head:GetChildren()) do
        if c:IsA("Decal") then table.insert(decals,{name=c.Name,face=c.Face,texture=c.Texture}) end
    end
    local meshes={}
    for _,c in ipairs(head:GetChildren()) do
        if c:IsA("SpecialMesh") then table.insert(meshes,c:Clone()) end
    end
    S.morph.headSaved={char=char,transparency=head.Transparency,canCollide=head.CanCollide,decals=decals,meshes=meshes}
end
local function morphApplyHeadless(char)
    if not char then return false end
    local head=char:FindFirstChild("Head")
    if not head then return false end
    morphSaveHeadState(char)
    for _,c in ipairs(head:GetChildren()) do
        if c:IsA("Decal") then c:Destroy() end
        if c:IsA("SpecialMesh") then c:Destroy() end
    end
    if head.Transparency~=1 then head.Transparency=1 end
    if head.CanCollide~=false then head.CanCollide=false end
    if head:IsA("MeshPart") then pcall(function() head.MeshId="" head.TextureID="" end) end
    return true
end
local function morphRemoveHeadless(char)
    if not char then return false end
    local head=char:FindFirstChild("Head")
    if not head then return false end
    if S.morph.headSaved and S.morph.headSaved.char==char then
        head.Transparency=S.morph.headSaved.transparency or 0
        head.CanCollide=S.morph.headSaved.canCollide or true
        for _,c in ipairs(head:GetChildren()) do
            if c:IsA("Decal") then c:Destroy() end
            if c:IsA("SpecialMesh") then c:Destroy() end
        end
        for _,d in ipairs(S.morph.headSaved.decals) do
            local nd=Instance.new("Decal")
            nd.Name=d.name nd.Face=d.face nd.Texture=d.texture nd.Parent=head
        end
        for _,m in ipairs(S.morph.headSaved.meshes) do m:Clone().Parent=head end
        S.morph.headSaved=nil
    else head.Transparency=0 end
    return true
end
local function applyKorblox(st)
    local char=LP.Character
    if not char then return end
    if st then morphApplyKorblox(char) else morphRemoveKorblox(char) end
end
local function applyHeadless(st)
    local char=LP.Character
    if not char then return end
    if st then morphApplyHeadless(char) else morphRemoveHeadless(char) end
end

-- ===== HIDE NICK =====
local function isNickName(n)
    local cached=S.nickNameCache[n]
    if cached~=nil then return cached end
    local lower=string.lower(n)
    local result
    if lower:sub(1,4)=="_xd_" or lower:find("xd_",1,true) or lower:find("xionix",1,true) then result=false
    elseif lower:find("nametag") or lower:find("nick") or lower:find("displayname") or lower=="name" or lower:find("^name_") or lower:find("_name") then result=true
    else result=false end
    S.nickNameCache[n]=result
    return result
end
local function isNickByAdornee(obj)
    local ad=obj.Adornee
    if not ad then return false end
    local an=ad.Name
    return an=="Head" or an=="HumanoidRootPart" or an=="Torso" or an=="UpperTorso" or an=="LowerTorso"
end
local function isNickFast(obj)
    if not obj then return false end
    if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        if isNickName(obj.Name) then return true end
        if isNickByAdornee(obj) then return true end
    end
    return false
end
local NICK_PARTS={"Head","HumanoidRootPart","Torso","UpperTorso","LowerTorso"}
local function setHumanoidTag(hum,hide)
    if not hum then return end
    if hide then
        if hum.DisplayDistanceType~=Enum.HumanoidDisplayDistanceType.None then hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end
        if hum.NameDisplayDistance~=0 then hum.NameDisplayDistance=0 end
        if hum.HealthDisplayDistance~=0 then hum.HealthDisplayDistance=0 end
    else
        hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Viewer
        hum.NameDisplayDistance=100 hum.HealthDisplayDistance=100
    end
end
local function applyToChar(char,shouldHide)
    if not char or not char.Parent then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then setHumanoidTag(hum,shouldHide) end
    for i=1,#NICK_PARTS do
        local part=char:FindFirstChild(NICK_PARTS[i])
        if part then
            for _,d in ipairs(part:GetChildren()) do
                if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
                    if shouldHide then
                        if d.Enabled and isNickFast(d) then
                            if not S.hiddenNicks[d] then S.hiddenNicks[d]={enabled=true} end
                            d.Enabled=false
                        end
                    elseif S.hiddenNicks[d] then
                        d.Enabled=S.hiddenNicks[d].enabled
                        S.hiddenNicks[d]=nil
                    end
                end
            end
        end
    end
end
local function watchPart(char,partName,shouldHideGetter)
    local part=char:FindFirstChild(partName)
    if not part then return end
    local key=tostring(char).."|"..partName.."|"..tostring(part)
    if S.watchedKeys[key] then return end
    S.watchedKeys[key]=true
    local c=part.ChildAdded:Connect(function(d)
        if S.unloaded then return end
        if not shouldHideGetter() then return end
        if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
            if d.Enabled and isNickFast(d) then
                if not S.hiddenNicks[d] then S.hiddenNicks[d]={enabled=true} end
                d.Enabled=false
            end
        end
    end)
    table.insert(S.perCharConns,c)
end
local function setupChar(char,isMe)
    if not char then return end
    local shouldHideGetter=isMe and function() return C.HideNick end or function() return C.HideOtherNames end
    applyToChar(char,shouldHideGetter())
    for _,pn in ipairs(NICK_PARTS) do watchPart(char,pn,shouldHideGetter) end
    local c=char.ChildAdded:Connect(function(d)
        if S.unloaded then return end
        if d.Name=="Head" or d.Name=="HumanoidRootPart" then
            if not d.Parent then return end
            applyToChar(char,shouldHideGetter())
            watchPart(char,d.Name,shouldHideGetter)
        end
    end)
    table.insert(S.perCharConns,c)
end
local function refreshNicks()
    if LP.Character then setupChar(LP.Character,true) end
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and plr.Character then setupChar(plr.Character,false) end
    end
end
local function bindPlayer(plr)
    local isMe=(plr==LP)
    if plr.Character then setupChar(plr.Character,isMe) end
    local c=plr.CharacterAdded:Connect(function(ch) if S.unloaded then return end setupChar(ch,isMe) end)
    table.insert(S.perCharConns,c)
end
for _,plr in ipairs(Players:GetPlayers()) do bindPlayer(plr) end
local _pc=Players.PlayerAdded:Connect(bindPlayer)
table.insert(S.perCharConns,_pc)
RunService.RenderStepped:Connect(function()
    if S.unloaded then return end
    if not (C.HideNick or C.HideOtherNames) then return end
    if C.HideNick then
        local char=LP.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then
                if hum.DisplayDistanceType~=Enum.HumanoidDisplayDistanceType.None then hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end
                if hum.NameDisplayDistance~=0 then hum.NameDisplayDistance=0 end
                if hum.HealthDisplayDistance~=0 then hum.HealthDisplayDistance=0 end
            end
        end
    end
    if C.HideOtherNames then
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr~=LP then
                local char=plr.Character
                if char then
                    local hum=char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        if hum.DisplayDistanceType~=Enum.HumanoidDisplayDistanceType.None then hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end
                        if hum.NameDisplayDistance~=0 then hum.NameDisplayDistance=0 end
                        if hum.HealthDisplayDistance~=0 then hum.HealthDisplayDistance=0 end
                    end
                end
            end
        end
    end
end)

-- ===== NOCLIP (advanced) + INF JUMP =====
local _noclipActive = false
local _noclipDisabled = {}
local _noclipFloorParts = setmetatable({}, {__mode = "k"})
local _noclipLastSafePos = nil
local _noclipLastSafeUpdate = 0
local _noclipFrame = 0

local _noclipScanParams = OverlapParams.new()
_noclipScanParams.FilterType = Enum.RaycastFilterType.Exclude
_noclipScanParams.MaxParts = 500
_noclipScanParams.RespectCanCollide = true

local _noclipOverlapAll = OverlapParams.new()
_noclipOverlapAll.FilterType = Enum.RaycastFilterType.Exclude
_noclipOverlapAll.MaxParts = 200
_noclipOverlapAll.RespectCanCollide = false

local _noclipRayDown = RaycastParams.new()
_noclipRayDown.FilterType = Enum.RaycastFilterType.Exclude
_noclipRayDown.IgnoreWater = true

local function _noclipDetectFloor(pos, char)
    local set = {}
    _noclipRayDown.FilterDescendantsInstances = {char}
    local feetPos = Vector3.new(pos.X, pos.Y - 2, pos.Z)
    for dx = -6, 6, 6 do
        for dz = -6, 6, 6 do
            local origin = feetPos + Vector3.new(dx, 0, dz)
            local hit = workspace:Raycast(origin, Vector3.new(0, -200, 0), _noclipRayDown)
            if hit and hit.Instance then
                set[hit.Instance] = true
            end
        end
    end
    return set
end

local function _noclipDisableAbove(pos, char)
    _noclipRayDown.FilterDescendantsInstances = {char}
    local origin = Vector3.new(pos.X, pos.Y + 3, pos.Z)
    local remaining = 30
    for _ = 1, 6 do
        local hit = workspace:Raycast(origin, Vector3.new(0, remaining, 0), _noclipRayDown)
        if not hit or not hit.Instance then break end
        if hit.Instance:IsA("BasePart") and hit.Instance.CanCollide and not _noclipFloorParts[hit.Instance] then
            hit.Instance.CanCollide = false
            _noclipDisabled[hit.Instance] = true
        end
        local adv = (hit.Position - origin).Magnitude + 0.5
        if adv >= remaining then break end
        origin = origin + Vector3.new(0, adv, 0)
        remaining = remaining - adv
    end
end

local function _noclipUpdate()
    if not _noclipActive or S.unloaded then return end
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local pos = hrp.Position
    local vel = hrp.AssemblyLinearVelocity
    local feetY = pos.Y - 3

    if vel.Y < -30 then return end

    _noclipScanParams.FilterDescendantsInstances = {char}
    _noclipOverlapAll.FilterDescendantsInstances = {char}

    local newFloor = _noclipDetectFloor(pos, char)
    for p in pairs(newFloor) do _noclipFloorParts[p] = true end

    if math.abs(vel.Y) < 5 and hum.FloorMaterial ~= Enum.Material.Air then
        if _noclipLastSafePos == nil or (tick() - _noclipLastSafeUpdate) > 0.3 then
            _noclipLastSafePos = pos
            _noclipLastSafeUpdate = tick()
        end
    end

    if _noclipLastSafePos and pos.Y < _noclipLastSafePos.Y - 25 then
        pcall(function()
            hrp.CFrame = CFrame.new(_noclipLastSafePos + Vector3.new(0, 4, 0))
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end)
        return
    end

    local parts = workspace:GetPartBoundsInRadius(pos, 35, _noclipScanParams)
    for _, p in ipairs(parts) do
        if p:IsA("BasePart") and not _noclipFloorParts[p] then
            local partTopY = p.Position.Y + p.Size.Y * 0.5
            local horizDist = math.sqrt((p.Position.X - pos.X)^2 + (p.Position.Z - pos.Z)^2)
            local isUnderMe = (horizDist < 15) and (partTopY <= feetY + 2)
            if not isUnderMe then
                p.CanCollide = false
                _noclipDisabled[p] = true
            end
        end
    end

    local climbCheck = workspace:GetPartBoundsInRadius(pos, 12, _noclipOverlapAll)
    local insideWall = false
    for _, p in ipairs(climbCheck) do
        if p:IsA("BasePart") and _noclipDisabled[p] and not _noclipFloorParts[p] then
            insideWall = true
            break
        end
    end
    if insideWall then
        _noclipDisableAbove(pos, char)
    end

    for p in pairs(_noclipFloorParts) do
        if p.Parent and not p.CanCollide then
            p.CanCollide = true
            _noclipDisabled[p] = nil
        end
    end

    if _noclipFrame % 120 == 0 then
        for p in pairs(_noclipDisabled) do
            if not p.Parent then
                _noclipDisabled[p] = nil
            elseif (p.Position - pos).Magnitude > 200 then
                pcall(function() p.CanCollide = true end)
                _noclipDisabled[p] = nil
            end
        end
        for p in pairs(_noclipFloorParts) do
            if not p.Parent or (p.Position - pos).Magnitude > 400 then
                _noclipFloorParts[p] = nil
            end
        end
    end
end

local function _startNoclip()
    if _noclipActive then return end
    _noclipActive = true
    _noclipLastSafePos = nil
    _noclipLastSafeUpdate = 0
end

local function _stopNoclip()
    _noclipActive = false
    for p in pairs(_noclipDisabled) do
        if p.Parent then pcall(function() p.CanCollide = true end) end
    end
    table.clear(_noclipDisabled)
    table.clear(_noclipFloorParts)
    _noclipLastSafePos = nil
end

track(RunService.RenderStepped:Connect(function()
    if not _noclipActive or S.unloaded then return end
    _noclipFrame = _noclipFrame + 1
    if _noclipFrame % 3 ~= 0 then return end
    pcall(_noclipUpdate)
end))

track(UIS.JumpRequest:Connect(function()
    if S.unloaded or not C.InfJump then return end
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end))

-- ===== CONFIG =====
local CONFIG_FOLDER="XionixConfig"
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
    return pcall(function() S.FILE.writefile(AUTOLOAD_FILE,tostring(name or "")) end)
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
    return pcall(S.FILE.delfile,AUTOLOAD_FILE)
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
    if C.FullBright and S.fbInst then S.fbInst.Brightness=tonumber(C.FullBrightIntensity) or 0.3 end
    makeViz() syncHooks() updateESP() makeFOVCircle()
end
local function saveConfig(name)
    name=name or S.currentConfigName
    if not S.FILE.writefile then return false end
    ensureFolder()
    local cn=tostring(name):gsub("[^%w%-%_]","")
    if cn=="" then cn="default" end
    S.currentConfigName=cn
    local pl={C=packStore(C),H=packStore(H),anim=S.animEnabled}
    return pcall(function() S.FILE.writefile(configPath(cn),HttpService:JSONEncode(pl)) end)
end
local function loadConfig(name)
    name=name or S.currentConfigName
    if not S.FILE.readfile or not S.FILE.isfile then return false end
    local path=configPath(name)
    local ok,e=pcall(S.FILE.isfile,path)
    if not ok or not e then return false end
    local ok2,raw=pcall(S.FILE.readfile,path)
    if not ok2 or not raw then return false end
    local ok3,data=pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok3 or type(data)~="table" then return false end
    applyData(data)
    S.currentConfigName=tostring(name):gsub("[^%w%-%_]","")
    return true
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
    if not S.FILE.delfile then return false end
    return pcall(S.FILE.delfile,configPath(name))
end

-- ===== TOGGLE WRAPPER =====
local _polls={}
local function T(tab,cfg,setter)
    local initial=cfg.Default or false
    local last=initial
    local obj=tab:Toggle({
        Title=cfg.Title,
        Desc=cfg.Desc or "",
        Default=initial,
        Callback=function(s)
            local state
            if s==true then state=true
            elseif s==false then state=false
            elseif s==nil then state=not last
            else
                local ok,v=pcall(function() return s.Value end)
                if ok and type(v)=="boolean" then state=v
                else state=not last end
            end
            if state~=last then last=state setter(state) end
        end
    })
    table.insert(_polls,{obj=obj,setter=setter,getLast=function() return last end,setLast=function(v) last=v end})
    return obj
end
task.spawn(function()
    while not S.unloaded do
        task.wait(0.15)
        for _,p in ipairs(_polls) do
            pcall(function()
                local v=p.obj.Value
                if type(v)=="boolean" and v~=p.getLast() then p.setLast(v) p.setter(v) end
            end)
        end
    end
end)

-- ===== WINDOW =====
local Window=WindUI:CreateWindow({
    Title=SCRIPT_NAME.." "..SCRIPT_VERSION,
    Author="Xionix",
    Folder="Xionix_Dewamp",
    Size=UDim2.fromOffset(580,460),
    Transparent=true,
    Theme="Dark",
    User={Enabled=true,Anonymous=true},
})

local _menuOpen=true
local function _doMenuToggle()
    if _menuOpen then pcall(function() Window:Close() end) _menuOpen=false
    else pcall(function() Window:Open() end) _menuOpen=true end
end
pcall(function() Window:SetToggleKey(nil) end)
local _lastMenuToggle=0
track(UIS.InputBegan:Connect(function(input,processed)
    if S.unloaded then return end
    if input.UserInputType~=Enum.UserInputType.Keyboard then return end
    if input.KeyCode~=C.MenuKey then return end
    if UIS:GetFocusedTextBox() then return end
    local now=tick()
    if now-_lastMenuToggle<0.2 then return end
    _lastMenuToggle=now
    _doMenuToggle()
end))

-- ===== EXTRA TAB =====
local TabExtra=Window:Tab({Title="Extra",Icon="settings"})

TabExtra:Section({Title="Auto Dodge"})
T(TabExtra,{Title="Ultra Instinct",Desc="Auto dodge everything",Default=false},
    function(v) C.Enabled=v syncHooks() end)
TabExtra:Slider({Title="Radius (studs)",Step=1,Value={Min=1,Max=95,Default=C.Distance},
    Callback=function(v) C.Distance=v makeViz() end})
TabExtra:Slider({Title="Delay (s)",Step=0.01,Value={Min=0,Max=0.25,Default=C.Delay},
    Callback=function(v) C.Delay=v end})
TabExtra:Slider({Title="Min interval (s)",Step=0.01,Value={Min=0.02,Max=1.0,Default=C.MinInterval},
    Callback=function(v) C.MinInterval=v end})
TabExtra:Slider({Title="Anim watch min (s)",Step=0.05,Value={Min=0.05,Max=2.0,Default=C.AnimWatch},
    Callback=function(v) C.AnimWatch=v end})
TabExtra:Slider({Title="Watch after anim (s)",Step=0.05,Value={Min=0,Max=1.5,Default=C.WatchAfter},
    Callback=function(v) C.WatchAfter=v end})
T(TabExtra,{Title="Show radius",Desc="Visual circle",Default=false},
    function(v) C.RadiusVis=v makeViz() end)
TabExtra:Slider({Title="Radius visibility",Step=0.05,Value={Min=0.15,Max=0.95,Default=C.RadiusTransparency},
    Callback=function(v) C.RadiusTransparency=v end})
TabExtra:Colorpicker({Title="Radius Color",Default=uiRadiusColor(),
    Callback=function(col)
        C.RadiusR=math.floor(col.R*255+0.5) C.RadiusG=math.floor(col.G*255+0.5) C.RadiusB=math.floor(col.B*255+0.5)
    end})
TabExtra:Input({Title="UI Slot",Value="",Placeholder="auto = empty",
    Callback=function(v) C.ManualUISlot=string.upper(v or "") end})

TabExtra:Section({Title="RLGL Auto Dodge"})
T(TabExtra,{Title="RLGL Auto Dodge",Default=false},function(v) C.RLGL_AutoDodge=v end)
T(TabExtra,{Title="Only on red light",Default=true},function(v) C.RLGL_OnlyRedLight=v end)
T(TabExtra,{Title="Auto-dodge after timer 0",Default=true},function(v) C.RLGL_TimerEndDodge=v end)
TabExtra:Slider({Title="Delay after red (s)",Step=0.05,Value={Min=0.05,Max=2.0,Default=0.55},
    Callback=function(v) C.RLGL_RedDelay=v end})
TabExtra:Slider({Title="Interval (s)",Step=0.05,Value={Min=0.05,Max=2.0,Default=0.75},
    Callback=function(v) C.RLGL_MinInterval=v end})
TabExtra:Slider({Title="Velocity threshold",Step=0.1,Value={Min=0.1,Max=8.0,Default=0.1},
    Callback=function(v) C.RLGL_VelThreshold=v end})
TabExtra:Slider({Title="Delay after 0 (s)",Step=0.05,Value={Min=0,Max=3.0,Default=12},
    Callback=function(v) C.RLGL_TimerEndDelay=v end})
TabExtra:Slider({Title="Timer end interval (s)",Step=0.05,Value={Min=0.05,Max=2.0,Default=0.75},
    Callback=function(v) C.RLGL_TimerEndInterval=v end})
TabExtra:Slider({Title="Timer end max duration (s)",Step=1,Value={Min=3,Max=30,Default=9},
    Callback=function(v) C.RLGL_TimerEndMaxDuration=v end})

TabExtra:Section({Title="Movement"})
T(TabExtra,{Title="Infinite Jump",Default=false},function(v) C.InfJump=v end)
T(TabExtra,{Title="Noclip",Desc="Walk through walls",Default=false},
    function(v)
        C.Noclip=v
        if v then _startNoclip() else _stopNoclip() end
    end)

TabExtra:Section({Title="Morph"})
local morphNick=""
TabExtra:Input({Title="Nickname",Value="",Placeholder="type nick",
    Callback=function(v) morphNick=v or "" end})
TabExtra:Button({Title="Morph",Icon="user-check",Callback=function()
    if morphNick=="" then return end
    if not morphCheckRate(morphNick) then return end
    S.morph._busy=true
    task.spawn(function()
        task.wait(0.4)
        local uid=morphGetCachedUserId(morphNick)
        if not uid then S.morph._busy=false return end
        local ok2,desc=pcall(function() return Players:GetHumanoidDescriptionFromUserIdAsync(uid) end)
        if not ok2 or not desc then S.morph._busy=false return end
        local bcColors,shirt,pants,graphic={},0,0,0
        local faceId=0
        pcall(function() bcColors.head=desc.HeadColor end)
        pcall(function() bcColors.torso=desc.TorsoColor end)
        pcall(function() bcColors.leftArm=desc.LeftArmColor end)
        pcall(function() bcColors.rightArm=desc.RightArmColor end)
        pcall(function() bcColors.leftLeg=desc.LeftLegColor end)
        pcall(function() bcColors.rightLeg=desc.RightLegColor end)
        pcall(function() shirt=tonumber(desc.Shirt) or 0 end)
        pcall(function() pants=tonumber(desc.Pants) or 0 end)
        pcall(function() graphic=tonumber(desc.GraphicTShirt) or 0 end)
        pcall(function() faceId=tonumber(desc.Face) or 0 end)
        pcall(function() desc:Destroy() end)
        local oldChar=LP.Character
        if not oldChar then S.morph._busy=false return end
        S.morph.active=true S.morph._lastNick=morphNick
        local toDestroy={}
        for _,c in ipairs(oldChar:GetChildren()) do
            if c:IsA("Accessory") or c:IsA("Hat") or c:IsA("Shirt") or c:IsA("Pants")
            or c:IsA("ShirtGraphic") or c:IsA("BodyColors") or c:IsA("CharacterMesh") then
                table.insert(toDestroy,c)
            end
        end
        for _,c in ipairs(toDestroy) do pcall(function() c:Destroy() end) end
        task.wait(0.15)
        local newBC=Instance.new("BodyColors")
        if bcColors.head then pcall(function() newBC.HeadColor3=bcColors.head end) end
        if bcColors.torso then pcall(function() newBC.TorsoColor3=bcColors.torso end) end
        if bcColors.leftArm then pcall(function() newBC.LeftArmColor3=bcColors.leftArm end) end
        if bcColors.rightArm then pcall(function() newBC.RightArmColor3=bcColors.rightArm end) end
        if bcColors.leftLeg then pcall(function() newBC.LeftLegColor3=bcColors.leftLeg end) end
        if bcColors.rightLeg then pcall(function() newBC.RightLegColor3=bcColors.rightLeg end) end
        newBC.Parent=oldChar
        if shirt>0 then local s=Instance.new("Shirt") s.ShirtTemplate="rbxassetid://"..shirt s.Parent=oldChar end
        if pants>0 then local p=Instance.new("Pants") p.PantsTemplate="rbxassetid://"..pants p.Parent=oldChar end
        if graphic>0 then local g=Instance.new("ShirtGraphic") g.Graphic="rbxassetid://"..graphic g.Parent=oldChar end
        task.wait(0.1)
        local head=oldChar:FindFirstChild("Head")
        if head then
            for _,c in ipairs(head:GetChildren()) do
                if c:IsA("Decal") and c.Name=="face" then c:Destroy() end
            end
            local fd=Instance.new("Decal")
            fd.Name="face" fd.Face=Enum.NormalId.Front
            fd.Texture=faceId>0 and ("rbxassetid://"..faceId) or MORPH_DEFAULT_FACE
            fd.Parent=head
        end
        S.morph.activeKorblox=S.morph.korbloxManual or false
        if S.morph.activeKorblox then pcall(function() morphApplyKorblox(oldChar) end) end
        S.morph.activeHeadless=S.morph.headlessManual or false
        if S.morph.activeHeadless then pcall(function() morphApplyHeadless(oldChar) end) end
        morphMarkRate(morphNick)
        S.morph._busy=false
    end)
end})
TabExtra:Button({Title="Reset to my skin",Icon="rotate-ccw",Callback=function()
    S.morph.activeKorblox=false S.morph.activeHeadless=false
    S.morph.korbloxManual=false S.morph.headlessManual=false
    local char=LP.Character
    if char then
        pcall(function() morphRemoveKorblox(char) end)
        pcall(function() morphRemoveHeadless(char) end)
    end
end})

TabExtra:Section({Title="Cosmetics"})
T(TabExtra,{Title="Headless",Default=false},
    function(v) S.morph.headlessManual=v S.morph.activeHeadless=v if LP.Character then applyHeadless(v) end end)
T(TabExtra,{Title="Korblox Right Leg",Default=false},
    function(v) S.morph.korbloxManual=v S.morph.activeKorblox=v if LP.Character then applyKorblox(v) end end)

TabExtra:Section({Title="Instant Interact"})
T(TabExtra,{Title="Enable Instant Interact",Desc="Auto-fire all proximity prompts",Default=false},
    function(v) C.InstantInteract=v end)

TabExtra:Section({Title="Hide Overhead"})
T(TabExtra,{Title="Hide my nickname",Default=false},function(v) C.HideNick=v refreshNicks() end)
T(TabExtra,{Title="Hide other players names",Default=false},function(v) C.HideOtherNames=v refreshNicks() end)

TabExtra:Section({Title="Visual"})
T(TabExtra,{Title="Full Bright",Default=false},function(v) applyFullBright(v) end)
TabExtra:Slider({Title="FullBright intensity",Step=0.05,Value={Min=0.1,Max=3.0,Default=0.3},
    Callback=function(v) C.FullBrightIntensity=v if S.fbInst then S.fbInst.Brightness=v end end})
T(TabExtra,{Title="Remove Fog",Default=false},function(v) applyRemoveFog(v) end)

TabExtra:Section({Title="Remove Parts (client)"})
T(TabExtra,{Title="Remove Legs",Default=false},function(v) applyRemoveLegs(v) ensureHandsLoop() end)
T(TabExtra,{Title="Remove Hands",Default=false},function(v) applyRemoveHands(v) ensureHandsLoop() rebuildLimbCache() end)
T(TabExtra,{Title="Remove Torso",Default=false},function(v) applyRemoveTorso(v) ensureHandsLoop() rebuildLimbCache() end)

TabExtra:Section({Title="Extra"})
TabExtra:Button({Title="Open Infinite Yield",Icon="terminal",Callback=function()
    if not loadstring or not game.HttpGet then return end
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978"))() end)
end})
TabExtra:Button({Title="Force Open Menu",Icon="maximize",Callback=function()
    pcall(function() Window:Open() end) _menuOpen=true
end})
TabExtra:Button({Title="FULL UNLOAD",Icon="trash-2",Callback=function()
    if S.doFullUnload then pcall(S.doFullUnload) end
end})

-- ===== HNS TAB =====
local TabHnS=Window:Tab({Title="HnS",Icon="users"})
TabHnS:Section({Title="HnS Dodge"})
T(TabHnS,{Title="HnS Dodge",Default=false},function(v) H.Enabled=v syncHooks() end)
T(TabHnS,{Title="Strict mode",Default=H.HollyMode},function(v) H.HollyMode=v end)
TabHnS:Slider({Title="Radius (studs)",Step=1,Value={Min=1,Max=95,Default=H.Distance},
    Callback=function(v) H.Distance=v makeViz() end})
TabHnS:Slider({Title="Delay (s)",Step=0.01,Value={Min=0,Max=0.25,Default=H.Delay},
    Callback=function(v) H.Delay=v end})
TabHnS:Slider({Title="Min interval (s)",Step=0.01,Value={Min=0.02,Max=1.0,Default=H.MinInterval},
    Callback=function(v) H.MinInterval=v end})
TabHnS:Section({Title="Radius Visualizer"})
T(TabHnS,{Title="Show radius",Default=false},function(v) H.RadiusVis=v makeViz() end)
TabHnS:Colorpicker({Title="HnS Radius Color",Default=hnsRadiusColor(),
    Callback=function(col)
        H.RadiusR=math.floor(col.R*255+0.5) H.RadiusG=math.floor(col.G*255+0.5) H.RadiusB=math.floor(col.B*255+0.5)
    end})
TabHnS:Section({Title="Slot"})
TabHnS:Input({Title="HnS Slot",Value="",Placeholder="auto = empty",
    Callback=function(v) C.ManualHnSSlot=string.upper(v or "") end})

-- ===== REBEL TAB =====
local TabRebel=Window:Tab({Title="Rebel",Icon="crosshair"})
TabRebel:Section({Title="Silent Aim"})
T(TabRebel,{Title="Silent Aim",Default=false},
    function(v) C.RebelSilentAim=v if v then hookCombat() end end)
T(TabRebel,{Title="Only visible",Default=false},function(v) C.RebelSilentAimVisibleCheck=v end)
TabRebel:Slider({Title="FOV Radius (px)",Step=5,Value={Min=10,Max=1200,Default=C.RebelFOV},
    Callback=function(v) C.RebelFOV=v refreshFOVCircle() end})

TabRebel:Section({Title="FOV Circle"})
T(TabRebel,{Title="Enable FOV Circle",Default=false},function(v) C.RebelFOVCircle=v makeFOVCircle() end)
T(TabRebel,{Title="Neon glow",Default=true},function(v) C.RebelFOVNeon=v makeFOVCircle() end)
T(TabRebel,{Title="Black outline",Default=true},function(v) C.RebelFOVBlackOutline=v makeFOVCircle() end)
TabRebel:Slider({Title="Outline thickness",Step=1,Value={Min=1,Max=20,Default=5},
    Callback=function(v) C.RebelFOV_OutlineThickness=v refreshFOVCircle() end})
TabRebel:Slider({Title="Circle line width",Step=0.1,Value={Min=0.5,Max=15,Default=1.6},
    Callback=function(v) C.RebelFOVCircleWidth=v end})
TabRebel:Colorpicker({Title="FOV Color",Default=rebelFOVColor(),
    Callback=function(col)
        C.RebelFOVR=math.floor(col.R*255+0.5) C.RebelFOVG=math.floor(col.G*255+0.5) C.RebelFOVB=math.floor(col.B*255+0.5)
        C.FOVUseCustom=false C.FOVRainbow=false stopFovRainbow() makeFOVCircle()
    end})
TabRebel:Colorpicker({Title="Outline Color",Default=rebelOutlineColor(),
    Callback=function(col)
        C.RebelFOV_OutlineR=math.floor(col.R*255+0.5) C.RebelFOV_OutlineG=math.floor(col.G*255+0.5) C.RebelFOV_OutlineB=math.floor(col.B*255+0.5)
        C.FOVRainbow=false stopFovRainbow() makeFOVCircle()
    end})

TabRebel:Section({Title="FOV Rainbow"})
T(TabRebel,{Title="Rainbow FOV",Default=false},
    function(v)
        C.FOVRainbow=v
        if v then startFovRainbow() else stopFovRainbow() makeFOVCircle() end
    end)
TabRebel:Slider({Title="Blend speed",Step=0.05,Value={Min=0.1,Max=3.0,Default=0.5},
    Callback=function(v) C.RebelFOVBlendSpeed=v end})
TabRebel:Button({Title="Mode 1: Cycle hue",Icon="palette",Callback=function()
    C.FOVRainbowMode=1 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})
TabRebel:Button({Title="Mode 2: Wave",Icon="palette",Callback=function()
    C.FOVRainbowMode=2 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})
TabRebel:Button({Title="Mode 3: Gradient blend",Icon="palette",Callback=function()
    C.FOVRainbowMode=3 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})
TabRebel:Button({Title="Mode 4: Breathing pulse",Icon="palette",Callback=function()
    C.FOVRainbowMode=4 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})
TabRebel:Button({Title="Mode 5: Aurora",Icon="palette",Callback=function()
    C.FOVRainbowMode=5 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})
TabRebel:Button({Title="Mode 6: FUSION",Icon="palette",Callback=function()
    C.FOVRainbowMode=6 C.FOVRainbow=true makeFOVCircle() startFovRainbow() end})

TabRebel:Section({Title="Custom FOV Colors (1-9)"})
T(TabRebel,{Title="Use custom color",Default=false},
        function(v) C.FOVUseCustom=v makeFOVCircle() if C.FOVRainbow then startFovRainbow() end end)

local function _setFovSlot(idx,col)
    local r=math.floor(col.R*255+0.5) local g=math.floor(col.G*255+0.5) local b=math.floor(col.B*255+0.5)
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
for _i=1,9 do
    local _idx=_i
    TabRebel:Colorpicker({Title="Slot ".._idx,Default=customFOVColor(_idx),
        Callback=function(col) _setFovSlot(_idx,col) end})
    TabRebel:Button({Title="Use slot ".._idx,Icon="check",Callback=function()
        C.FOVCustomIdx=_idx
        C.FOVUseCustom=true
        makeFOVCircle()
        if C.FOVRainbow then startFovRainbow() end
    end})
end

TabRebel:Section({Title="Target Filter"})
T(TabRebel,{Title="Target players",Default=true},function(v) C.RebelTargetPlayers=v end)
T(TabRebel,{Title="Target NPC guards",Default=true},function(v) C.RebelTargetNPCs=v end)

TabRebel:Section({Title="Body Parts"})
T(TabRebel,{Title="Head",Default=true},function(v) C.RebelBodyHead=v end)
T(TabRebel,{Title="Torso",Default=true},function(v) C.RebelBodyTorso=v end)
T(TabRebel,{Title="HumanoidRootPart",Default=false},function(v) C.RebelBodyHRP=v end)
T(TabRebel,{Title="Left Arm",Default=false},function(v) C.RebelBodyLeftArm=v end)
T(TabRebel,{Title="Right Arm",Default=false},function(v) C.RebelBodyRightArm=v end)
T(TabRebel,{Title="Left Leg",Default=false},function(v) C.RebelBodyLeftLeg=v end)
T(TabRebel,{Title="Right Leg",Default=false},function(v) C.RebelBodyRightLeg=v end)

TabRebel:Section({Title="Aimbot"})
T(TabRebel,{Title="Enable Aimbot",Default=false},
    function(v) C.RebelAimbot=v if v then startAimbot() else stopAimbot() end end)
T(TabRebel,{Title="Only visible",Default=false},function(v) C.RebelAimbotVisibleCheck=v end)
T(TabRebel,{Title="Hold RMB",Default=false},function(v) C.RebelAimbotHoldKey=v end)
TabRebel:Slider({Title="Smooth",Step=0.05,Value={Min=0.05,Max=5.0,Default=1.0},
    Callback=function(v) C.RebelAimbotSmooth=v end})

TabRebel:Section({Title="Gun Mods"})
T(TabRebel,{Title="No Recoil & Spread",Default=false},
    function(v) C.RebelNoRecoil=v if v then hookCombat() end end)

TabRebel:Section({Title="Bullet Tracer"})
T(TabRebel,{Title="Enable Bullet Tracer",Default=false},function(v) C.BulletTracer=v end)
T(TabRebel,{Title="Glow",Default=true},function(v) C.BulletTracerGlow=v end)
T(TabRebel,{Title="White core",Default=true},function(v) C.BulletTracerWhiteCore=v end)
TabRebel:Colorpicker({Title="Tracer Color",Default=Color3.fromRGB(C.BulletTracerR,C.BulletTracerG,C.BulletTracerB),
    Callback=function(col)
        C.BulletTracerR=math.floor(col.R*255+0.5) C.BulletTracerG=math.floor(col.G*255+0.5) C.BulletTracerB=math.floor(col.B*255+0.5)
    end})
TabRebel:Slider({Title="Thickness",Step=0.01,Value={Min=0.05,Max=1.0,Default=0.20},
    Callback=function(v) C.BulletTracerThickness=v end})
TabRebel:Slider({Title="Speed (studs/s)",Step=50,Value={Min=50,Max=5000,Default=800},
    Callback=function(v) C.BulletTracerSpeed=v end})
TabRebel:Slider({Title="Lifetime (s)",Step=0.05,Value={Min=0.1,Max=5.0,Default=2.00},
    Callback=function(v) C.BulletTracerLifetime=v end})
TabRebel:Slider({Title="Range (studs)",Step=25,Value={Min=50,Max=2000,Default=1050},
    Callback=function(v) C.BulletTracerRange=v end})
TabRebel:Slider({Title="Start offset",Step=0.1,Value={Min=0,Max=5,Default=0.30},
    Callback=function(v) C.BulletTracerStartOffset=v end})
TabRebel:Slider({Title="End offset",Step=0.1,Value={Min=0,Max=5,Default=0.00},
    Callback=function(v) C.BulletTracerEndOffset=v end})
TabRebel:Slider({Title="Opacity",Step=0.01,Value={Min=0,Max=0.5,Default=0.00},
    Callback=function(v) C.BulletTracerOpacity=v end})
TabRebel:Slider({Title="Cooldown (s)",Step=0.01,Value={Min=0.01,Max=0.5,Default=0.03},
    Callback=function(v) C.BulletTracerCooldown=v end})
local btFadeLabels={"Quad","Linear","Expo","Back","Circ","Sine","Quint","Bounce","Elastic"}
TabRebel:Button({Title="Fade: "..btFadeLabels[C.BulletTracerFadeIdx or 1],Icon="sparkles",Callback=function()
    C.BulletTracerFadeIdx=(C.BulletTracerFadeIdx or 1)+1
    if C.BulletTracerFadeIdx>#btFadeLabels then C.BulletTracerFadeIdx=1 end
end})

TabRebel:Section({Title="Auto Brew"})
T(TabRebel,{Title="Auto brew + collect",Default=false},
    function(v) C.AutoBrew=v if v then startBrewLoop() else stopBrewLoop() end end)
TabRebel:Input({Title="Brew key",Value="E",Placeholder="E",
    Callback=function(v) local u=string.upper(v or "E") if u=="" then u="E" end C.AutoBrewSlot=u end})
TabRebel:Slider({Title="Cycle cooldown (s)",Step=0.5,Value={Min=0.5,Max=30,Default=1},
    Callback=function(v) C.AutoBrewInterval=v end})

-- ===== HALLOWEEN TAB =====
local TabHallow=Window:Tab({Title="Halloween",Icon="ghost"})
TabHallow:Section({Title="Cryptid ESP"})
TabHallow:Paragraph({Title="Scans for objects with 'cryptid' in name."})

T(TabHallow,{Title="Chams (Highlight)",Default=false},function(v) C.Halloween_Chams=v if v then _hlwScan() end end)
T(TabHallow,{Title="Tracers (Lines)",Default=false},function(v) C.Halloween_Tracers=v if v then _hlwScan() end end)
T(TabHallow,{Title="2D Boxes",Default=false},function(v) C.Halloween_Boxes=v if v then _hlwScan() end end)
T(TabHallow,{Title="Show Name",Default=false},function(v) C.Halloween_Names=v if v then _hlwScan() end end)
T(TabHallow,{Title="Show Distance",Default=false},function(v) C.Halloween_Dist=v if v then _hlwScan() end end)

TabHallow:Section({Title="Distance Filter"})
TabHallow:Slider({Title="Min Distance (studs)",Step=10,Value={Min=0,Max=5000,Default=0},
    Callback=function(v) C.Halloween_MinD=v end})
TabHallow:Slider({Title="Max Distance (studs)",Step=10,Value={Min=0,Max=5000,Default=5000},
    Callback=function(v) C.Halloween_MaxD=v end})

TabHallow:Section({Title="Colors & Sizes"})
TabHallow:Colorpicker({Title="Chams Fill Color",Default=Color3.fromRGB(C.Halloween_ChamsR,C.Halloween_ChamsG,C.Halloween_ChamsB),
    Callback=function(col)
        C.Halloween_ChamsR=math.floor(col.R*255+0.5) C.Halloween_ChamsG=math.floor(col.G*255+0.5) C.Halloween_ChamsB=math.floor(col.B*255+0.5)
    end})
TabHallow:Colorpicker({Title="Chams Outline Color",Default=Color3.fromRGB(C.Halloween_ChamsOutlineR,C.Halloween_ChamsOutlineG,C.Halloween_ChamsOutlineB),
    Callback=function(col)
        C.Halloween_ChamsOutlineR=math.floor(col.R*255+0.5) C.Halloween_ChamsOutlineG=math.floor(col.G*255+0.5) C.Halloween_ChamsOutlineB=math.floor(col.B*255+0.5)
    end})
TabHallow:Slider({Title="Chams Outline Transparency",Step=0.05,Value={Min=0,Max=1,Default=0},
    Callback=function(v) C.Halloween_ChamsOutlineTransparency=v end})
TabHallow:Colorpicker({Title="Tracer Color",Default=Color3.fromRGB(C.Halloween_TracerR,C.Halloween_TracerG,C.Halloween_TracerB),
    Callback=function(col)
        C.Halloween_TracerR=math.floor(col.R*255+0.5) C.Halloween_TracerG=math.floor(col.G*255+0.5) C.Halloween_TracerB=math.floor(col.B*255+0.5)
    end})
TabHallow:Colorpicker({Title="Box Color",Default=Color3.fromRGB(C.Halloween_BoxR,C.Halloween_BoxG,C.Halloween_BoxB),
    Callback=function(col)
        C.Halloween_BoxR=math.floor(col.R*255+0.5) C.Halloween_BoxG=math.floor(col.G*255+0.5) C.Halloween_BoxB=math.floor(col.B*255+0.5)
    end})
TabHallow:Colorpicker({Title="Text Color",Default=Color3.fromRGB(C.Halloween_TextR,C.Halloween_TextG,C.Halloween_TextB),
    Callback=function(col)
        C.Halloween_TextR=math.floor(col.R*255+0.5) C.Halloween_TextG=math.floor(col.G*255+0.5) C.Halloween_TextB=math.floor(col.B*255+0.5)
    end})
TabHallow:Slider({Title="Tracer Thickness",Step=1,Value={Min=1,Max=10,Default=1},
    Callback=function(v) C.Halloween_TracerThick=v end})
TabHallow:Slider({Title="Box Thickness",Step=1,Value={Min=1,Max=10,Default=1},
    Callback=function(v) C.Halloween_BoxThick=v end})
TabHallow:Slider({Title="Text Size",Step=1,Value={Min=1,Max=50,Default=14},
    Callback=function(v) C.Halloween_TextSize=v end})
TabHallow:Slider({Title="Box Scale",Step=0.1,Value={Min=0.1,Max=5,Default=1},
    Callback=function(v) C.Halloween_BoxScale=v end})

TabHallow:Section({Title="Rainbow Effects"})
T(TabHallow,{Title="Rainbow Chams",Default=false},function(v) C.Halloween_RainbowChams=v end)
T(TabHallow,{Title="Rainbow Tracers",Default=false},function(v) C.Halloween_RainbowTracers=v end)
T(TabHallow,{Title="Rainbow Boxes",Default=false},function(v) C.Halloween_RainbowBoxes=v end)
T(TabHallow,{Title="Rainbow Text",Default=false},function(v) C.Halloween_RainbowText=v end)

TabHallow:Section({Title="Actions"})
TabHallow:Button({Title="Force Rescan",Icon="refresh-cw",Callback=function()
    _hlwClear()
    task.wait(0.1)
    _hlwScan()
end})
TabHallow:Button({Title="Clear All Cryptid ESP",Icon="x",Callback=function() _hlwClear() end})

-- ===== ESP TAB =====
local TabESP=Window:Tab({Title="ESP",Icon="eye"})

TabESP:Paragraph({Title="Guard ESP shows guards only. Player ESP shows regular players."})

TabESP:Section({Title="Guard ESP"})
T(TabESP,{Title="Enable Guard ESP",Default=false},function(v) C.GuardESP=v updateESP() end)
T(TabESP,{Title="Show HP bar",Default=true},function(v) C.GuardESP_HP=v end)
T(TabESP,{Title="Show Name",Default=true},function(v) C.GuardESP_Name=v end)
T(TabESP,{Title="Show Highlight",Default=true},function(v) C.GuardESP_Highlight=v end)
T(TabESP,{Title="Show Tracer",Default=false},function(v) C.GuardESP_Tracer=v end)
T(TabESP,{Title="Show Box",Default=false},function(v) C.GuardESP_Box=v end)
T(TabESP,{Title="Show Tool",Default=true},function(v) C.GuardESP_Tool=v end)
T(TabESP,{Title="Show Distance",Default=false},function(v) C.GuardESP_Distance=v end)
T(TabESP,{Title="Force ALL as Guard (debug)",Default=false},function(v) C.GuardESP_ForceAll=v updateESP() end)
T(TabESP,{Title="HP chip colored BG",Default=true},function(v) C.GuardESP_HP_ChipBg=v end)
T(TabESP,{Title="HP chip outline",Default=false},function(v) C.GuardESP_HP_Outline=v end)
TabESP:Slider({Title="Name size",Step=1,Value={Min=8,Max=32,Default=17},
    Callback=function(v) C.GuardESP_NameSize=v end})
TabESP:Slider({Title="Max distance",Step=10,Value={Min=0,Max=1000,Default=500},
    Callback=function(v) C.GuardESP_MaxDist=v updateESP() end})
TabESP:Slider({Title="Box thickness",Step=0.5,Value={Min=1,Max=6,Default=2},
    Callback=function(v) C.GuardESP_BoxThickness=v end})
TabESP:Slider({Title="HP bar thickness",Step=1,Value={Min=2,Max=30,Default=8},
    Callback=function(v) C.GuardESP_HPBarThickness=v end})
TabESP:Slider({Title="HP bar length",Step=0.1,Value={Min=0.3,Max=3.0,Default=1.5},
    Callback=function(v) C.GuardESP_HPBarLength=v end})
TabESP:Slider({Title="HP bar roundness",Step=1,Value={Min=0,Max=20,Default=3},
    Callback=function(v) C.GuardESP_HPBarRoundness=v end})
TabESP:Colorpicker({Title="Guard accent",Default=guardESPColor(),
    Callback=function(col)
        C.GuardESP_ColorR=math.floor(col.R*255+0.5) C.GuardESP_ColorG=math.floor(col.G*255+0.5) C.GuardESP_ColorB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Guard Tracer",Default=guardTracerColor(),
    Callback=function(col)
        C.GuardESP_TracerR=math.floor(col.R*255+0.5) C.GuardESP_TracerG=math.floor(col.G*255+0.5) C.GuardESP_TracerB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Guard Box",Default=guardBoxColor(),
    Callback=function(col)
        C.GuardESP_BoxR=math.floor(col.R*255+0.5) C.GuardESP_BoxG=math.floor(col.G*255+0.5) C.GuardESP_BoxB=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Guard HP Chip States"})
TabESP:Colorpicker({Title="State 1 (>75%)",Default=Color3.fromRGB(C.GuardESP_HP_State1_R,C.GuardESP_HP_State1_G,C.GuardESP_HP_State1_B),
    Callback=function(col)
        C.GuardESP_HP_State1_R=math.floor(col.R*255+0.5) C.GuardESP_HP_State1_G=math.floor(col.G*255+0.5) C.GuardESP_HP_State1_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 2 (50-75%)",Default=Color3.fromRGB(C.GuardESP_HP_State2_R,C.GuardESP_HP_State2_G,C.GuardESP_HP_State2_B),
    Callback=function(col)
        C.GuardESP_HP_State2_R=math.floor(col.R*255+0.5) C.GuardESP_HP_State2_G=math.floor(col.G*255+0.5) C.GuardESP_HP_State2_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 3 (25-50%)",Default=Color3.fromRGB(C.GuardESP_HP_State3_R,C.GuardESP_HP_State3_G,C.GuardESP_HP_State3_B),
    Callback=function(col)
        C.GuardESP_HP_State3_R=math.floor(col.R*255+0.5) C.GuardESP_HP_State3_G=math.floor(col.G*255+0.5) C.GuardESP_HP_State3_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 4 (<25%)",Default=Color3.fromRGB(C.GuardESP_HP_State4_R,C.GuardESP_HP_State4_G,C.GuardESP_HP_State4_B),
    Callback=function(col)
        C.GuardESP_HP_State4_R=math.floor(col.R*255+0.5) C.GuardESP_HP_State4_G=math.floor(col.G*255+0.5) C.GuardESP_HP_State4_B=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Guard HP Gradient (bar)"})
TabESP:Colorpicker({Title="Top",Default=Color3.fromRGB(C.GuardESP_HP_TopR,C.GuardESP_HP_TopG,C.GuardESP_HP_TopB),
    Callback=function(col)
        C.GuardESP_HP_TopR=math.floor(col.R*255+0.5) C.GuardESP_HP_TopG=math.floor(col.G*255+0.5) C.GuardESP_HP_TopB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid1",Default=Color3.fromRGB(C.GuardESP_HP_M1R,C.GuardESP_HP_M1G,C.GuardESP_HP_M1B),
    Callback=function(col)
        C.GuardESP_HP_M1R=math.floor(col.R*255+0.5) C.GuardESP_HP_M1G=math.floor(col.G*255+0.5) C.GuardESP_HP_M1B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid2",Default=Color3.fromRGB(C.GuardESP_HP_M2R,C.GuardESP_HP_M2G,C.GuardESP_HP_M2B),
    Callback=function(col)
        C.GuardESP_HP_M2R=math.floor(col.R*255+0.5) C.GuardESP_HP_M2G=math.floor(col.G*255+0.5) C.GuardESP_HP_M2B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid3",Default=Color3.fromRGB(C.GuardESP_HP_M3R,C.GuardESP_HP_M3G,C.GuardESP_HP_M3B),
    Callback=function(col)
        C.GuardESP_HP_M3R=math.floor(col.R*255+0.5) C.GuardESP_HP_M3G=math.floor(col.G*255+0.5) C.GuardESP_HP_M3B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Bottom",Default=Color3.fromRGB(C.GuardESP_HP_BotR,C.GuardESP_HP_BotG,C.GuardESP_HP_BotB),
    Callback=function(col)
        C.GuardESP_HP_BotR=math.floor(col.R*255+0.5) C.GuardESP_HP_BotG=math.floor(col.G*255+0.5) C.GuardESP_HP_BotB=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Player ESP"})
T(TabESP,{Title="Enable Player ESP",Default=false},function(v) C.PlayerESP=v updateESP() end)
T(TabESP,{Title="Show HP bar",Default=true},function(v) C.PlayerESP_HP=v end)
T(TabESP,{Title="Show Name",Default=true},function(v) C.PlayerESP_Name=v end)
T(TabESP,{Title="Show Highlight",Default=true},function(v) C.PlayerESP_Highlight=v end)
T(TabESP,{Title="Show Tracer",Default=false},function(v) C.PlayerESP_Tracer=v end)
T(TabESP,{Title="Show Box",Default=false},function(v) C.PlayerESP_Box=v end)
T(TabESP,{Title="Show Tool",Default=true},function(v) C.PlayerESP_Tool=v end)
T(TabESP,{Title="Show Distance",Default=false},function(v) C.PlayerESP_Distance=v end)
T(TabESP,{Title="HP chip colored BG",Default=true},function(v) C.PlayerESP_HP_ChipBg=v end)
T(TabESP,{Title="HP chip outline",Default=false},function(v) C.PlayerESP_HP_Outline=v end)
TabESP:Input({Title="Custom Name",Value="",Placeholder="empty = real",
    Callback=function(v) C.PlayerESP_CustomName=v or "" updateESP() end})
T(TabESP,{Title="Rainbow name",Default=false},function(v) C.PlayerESP_NameRainbow=v end)
TabESP:Slider({Title="Rainbow speed",Step=0.05,Value={Min=0.1,Max=3.0,Default=1.0},
    Callback=function(v) C.PlayerESP_NameRainbowSpeed=v end})
TabESP:Slider({Title="Name size",Step=1,Value={Min=8,Max=32,Default=17},
    Callback=function(v) C.PlayerESP_NameSize=v end})
TabESP:Slider({Title="Max distance",Step=10,Value={Min=0,Max=1000,Default=500},
    Callback=function(v) C.PlayerESP_MaxDist=v updateESP() end})
TabESP:Slider({Title="Box thickness",Step=0.5,Value={Min=1,Max=6,Default=2},
    Callback=function(v) C.PlayerESP_BoxThickness=v end})
TabESP:Slider({Title="HP bar thickness",Step=1,Value={Min=2,Max=30,Default=8},
    Callback=function(v) C.PlayerESP_HPBarThickness=v end})
TabESP:Slider({Title="HP bar length",Step=0.1,Value={Min=0.3,Max=3.0,Default=1.5},
    Callback=function(v) C.PlayerESP_HPBarLength=v end})
TabESP:Slider({Title="HP bar roundness",Step=1,Value={Min=0,Max=20,Default=3},
    Callback=function(v) C.PlayerESP_HPBarRoundness=v end})
TabESP:Colorpicker({Title="Player accent",Default=playerESPColor(),
    Callback=function(col)
        C.PlayerESP_ColorR=math.floor(col.R*255+0.5) C.PlayerESP_ColorG=math.floor(col.G*255+0.5) C.PlayerESP_ColorB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Player Tracer",Default=playerTracerColor(),
    Callback=function(col)
        C.PlayerESP_TracerR=math.floor(col.R*255+0.5) C.PlayerESP_TracerG=math.floor(col.G*255+0.5) C.PlayerESP_TracerB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Player Box",Default=playerBoxColor(),
    Callback=function(col)
        C.PlayerESP_BoxR=math.floor(col.R*255+0.5) C.PlayerESP_BoxG=math.floor(col.G*255+0.5) C.PlayerESP_BoxB=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Player HP Chip States"})
TabESP:Colorpicker({Title="State 1 (>75%)",Default=Color3.fromRGB(C.PlayerESP_HP_State1_R,C.PlayerESP_HP_State1_G,C.PlayerESP_HP_State1_B),
    Callback=function(col)
        C.PlayerESP_HP_State1_R=math.floor(col.R*255+0.5) C.PlayerESP_HP_State1_G=math.floor(col.G*255+0.5) C.PlayerESP_HP_State1_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 2 (50-75%)",Default=Color3.fromRGB(C.PlayerESP_HP_State2_R,C.PlayerESP_HP_State2_G,C.PlayerESP_HP_State2_B),
    Callback=function(col)
        C.PlayerESP_HP_State2_R=math.floor(col.R*255+0.5) C.PlayerESP_HP_State2_G=math.floor(col.G*255+0.5) C.PlayerESP_HP_State2_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 3 (25-50%)",Default=Color3.fromRGB(C.PlayerESP_HP_State3_R,C.PlayerESP_HP_State3_G,C.PlayerESP_HP_State3_B),
    Callback=function(col)
        C.PlayerESP_HP_State3_R=math.floor(col.R*255+0.5) C.PlayerESP_HP_State3_G=math.floor(col.G*255+0.5) C.PlayerESP_HP_State3_B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="State 4 (<25%)",Default=Color3.fromRGB(C.PlayerESP_HP_State4_R,C.PlayerESP_HP_State4_G,C.PlayerESP_HP_State4_B),
    Callback=function(col)
        C.PlayerESP_HP_State4_R=math.floor(col.R*255+0.5) C.PlayerESP_HP_State4_G=math.floor(col.G*255+0.5) C.PlayerESP_HP_State4_B=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Player HP Gradient (bar)"})
TabESP:Colorpicker({Title="Top",Default=Color3.fromRGB(C.PlayerESP_HP_TopR,C.PlayerESP_HP_TopG,C.PlayerESP_HP_TopB),
    Callback=function(col)
        C.PlayerESP_HP_TopR=math.floor(col.R*255+0.5) C.PlayerESP_HP_TopG=math.floor(col.G*255+0.5) C.PlayerESP_HP_TopB=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid1",Default=Color3.fromRGB(C.PlayerESP_HP_M1R,C.PlayerESP_HP_M1G,C.PlayerESP_HP_M1B),
    Callback=function(col)
        C.PlayerESP_HP_M1R=math.floor(col.R*255+0.5) C.PlayerESP_HP_M1G=math.floor(col.G*255+0.5) C.PlayerESP_HP_M1B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid2",Default=Color3.fromRGB(C.PlayerESP_HP_M2R,C.PlayerESP_HP_M2G,C.PlayerESP_HP_M2B),
    Callback=function(col)
        C.PlayerESP_HP_M2R=math.floor(col.R*255+0.5) C.PlayerESP_HP_M2G=math.floor(col.G*255+0.5) C.PlayerESP_HP_M2B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Mid3",Default=Color3.fromRGB(C.PlayerESP_HP_M3R,C.PlayerESP_HP_M3G,C.PlayerESP_HP_M3B),
    Callback=function(col)
        C.PlayerESP_HP_M3R=math.floor(col.R*255+0.5) C.PlayerESP_HP_M3G=math.floor(col.G*255+0.5) C.PlayerESP_HP_M3B=math.floor(col.B*255+0.5)
    end})
TabESP:Colorpicker({Title="Bottom",Default=Color3.fromRGB(C.PlayerESP_HP_BotR,C.PlayerESP_HP_BotG,C.PlayerESP_HP_BotB),
    Callback=function(col)
        C.PlayerESP_HP_BotR=math.floor(col.R*255+0.5) C.PlayerESP_HP_BotG=math.floor(col.G*255+0.5) C.PlayerESP_HP_BotB=math.floor(col.B*255+0.5)
    end})

TabESP:Section({Title="Text"})
local fontLabel=ESP_FONT_NAMES[C.ESP_FontIdx or 1] or "GothamBlack"
TabESP:Button({Title="Next font (now: "..fontLabel..")",Icon="type",Callback=function()
    C.ESP_FontIdx=(C.ESP_FontIdx or 1)+1
    if C.ESP_FontIdx>#ESP_FONT_NAMES then C.ESP_FontIdx=1 end
end})
TabESP:Button({Title="Reset font",Icon="rotate-ccw",Callback=function() C.ESP_FontIdx=1 end})

-- ===== DALGONA TAB =====
local TabDalgona=Window:Tab({Title="Dalgona",Icon="cookie"})
TabDalgona:Section({Title="Cookie"})
T(TabDalgona,{Title="One Click Complete",Desc="Mouse-guided outline carve",Default=false},
    function(v) setOneClickDalgona(v) end)

-- ===== CONFIGS TAB =====
local TabConfigs=Window:Tab({Title="Configs",Icon="save"})
TabConfigs:Section({Title="Save / Load"})
local configNameInput="default"
TabConfigs:Input({Title="Config Name",Value="default",Placeholder="default",
    Callback=function(v) configNameInput=v or "default" end})
TabConfigs:Button({Title="Save",Icon="save",Callback=function() saveConfig(configNameInput) end})
TabConfigs:Button({Title="Load",Icon="folder-open",Callback=function() loadConfig(configNameInput) end})

TabConfigs:Section({Title="Auto-Load"})
TabConfigs:Button({Title="Set as autoload",Icon="pin",Callback=function()
    local n=tostring(configNameInput):gsub("[^%w%-%_]","")
    if n=="" then n="default" end
    saveAutoloadName(n)
end})
TabConfigs:Button({Title="Reset auto-load",Icon="x",Callback=function() clearAutoloadName() end})

TabConfigs:Section({Title="Menu Key"})
TabConfigs:Paragraph({Title="Current: "..tostring(C.MenuKey)})
TabConfigs:Button({Title="Set Menu Key",Icon="keyboard",Callback=function()
    local conn
    conn=UIS.InputBegan:Connect(function(input)
        if input.UserInputType~=Enum.UserInputType.Keyboard then return end
        C.MenuKey=input.KeyCode
        if conn then conn:Disconnect() end
    end)
end})
TabConfigs:Button({Title="Force Open Menu",Icon="maximize",Callback=function()
    pcall(function() Window:Open() end) _menuOpen=true
end})

TabConfigs:Section({Title="Share"})
local shareBoxText=""
TabConfigs:Input({Title="Paste JSON to import",Value="",Placeholder="paste here",
    Callback=function(v) shareBoxText=v or "" end})
TabConfigs:Button({Title="Export to clipboard",Icon="copy",Callback=function()
    local pl={C=packStore(C),H=packStore(H),anim=S.animEnabled}
    local json=HttpService:JSONEncode(pl)
    if setclipboard then pcall(function() setclipboard(json) end) end
end})
TabConfigs:Button({Title="Import from box",Icon="download",Callback=function()
    if shareBoxText=="" then return end
    local ok,data=pcall(function() return HttpService:JSONDecode(shareBoxText) end)
    if ok and type(data)=="table" then applyData(data) end
end})

TabConfigs:Section({Title="Unload"})
TabConfigs:Button({Title="FULL UNLOAD",Icon="trash-2",Callback=function()
    if S.doFullUnload then pcall(S.doFullUnload) end
end})

-- ===== UNLOAD =====
S.doFullUnload=function()
    if S.unloaded then return end
    S.running=false
    pcall(unhookCombat) pcall(stopAimbot)
    pcall(destroyFOVCircle) pcall(stopFovRainbow)
    pcall(stopBrewLoop)
    pcall(_hlwClear)
    pcall(_stopNoclip)
    for obj,state in pairs(S.hiddenNicks) do
        if obj and obj.Parent then pcall(function() obj.Enabled=state.enabled end) end
    end
    table.clear(S.hiddenNicks)
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local h=plr.Character:FindFirstChildOfClass("Humanoid")
            if h then
                pcall(function()
                    h.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Viewer
                    h.NameDisplayDistance=100 h.HealthDisplayDistance=100
                end)
            end
        end
    end
    for _,c in ipairs(S.perCharConns) do pcall(function() c:Disconnect() end) end
    table.clear(S.perCharConns) table.clear(S.watchedKeys) table.clear(S.nickNameCache)
    if S.btAnimConn then pcall(function() S.btAnimConn:Disconnect() end) S.btAnimConn=nil end
    if S.morph._watchConn then pcall(function() S.morph._watchConn:Disconnect() end) S.morph._watchConn=nil end
    pcall(function() applyFullBright(false) end)
    pcall(function() applyRemoveFog(false) end)
    S.unloaded=true
    pcall(function()
        C.Enabled=false H.Enabled=false
        C.RadiusVis=false H.RadiusVis=false
        C.GuardESP=false C.PlayerESP=false
        C.RemoveHands=false C.RemoveLegs=false C.RemoveTorso=false
        C.Headless=false C.Korblox=false C.HideNick=false C.HideOtherNames=false
        C.FullBright=false C.RemoveFog=false C.AutoBrew=false
        C.BulletTracer=false S.oneClickDalgona=false
        C.RLGL_AutoDodge=false C.RLGL_TimerEndDodge=false
        C.RebelSilentAim=false C.RebelNoRecoil=false
        C.RebelAimbot=false C.RebelFOVCircle=false
        C.Halloween_Chams=false C.Halloween_Tracers=false C.Halloween_Boxes=false
        C.Halloween_Names=false C.Halloween_Dist=false
        C.InfJump=false C.Noclip=false
    end)
    pcall(function()
        for part,data in pairs(_G.__dalgonaCache) do
            if part and part.Parent then pcall(function() part.Position=data.Position part.Transparency=data.Transparency end) end
        end
        table.clear(_G.__dalgonaCache)
    end)
    pcall(unhook)
    pcall(clearAllGuardESP) pcall(clearAllPlayerESP)
    if vizConn then pcall(function() vizConn:Disconnect() end) end
    if uiDisc then pcall(function() uiDisc:Destroy() end) end
    if hnsDisc then pcall(function() hnsDisc:Destroy() end) end
    for i=1,#S.conns do pcall(function() if S.conns[i] and S.conns[i].Disconnect then S.conns[i]:Disconnect() end end) end
    table.clear(S.conns)
    for _,c in pairs(S.added) do pcall(function() if c and c.Disconnect then c:Disconnect() end end) end
    table.clear(S.added)
    if S.tracerGui then pcall(function() S.tracerGui:Destroy() end) S.tracerGui=nil end
    if S.overlayGui then pcall(function() S.overlayGui:Destroy() end) S.overlayGui=nil end
    pcall(function() if Window and Window.Destroy then Window:Destroy() end end)
    if getgenv then pcall(function() getgenv().__ui_dodge=nil end) end
end
_G.__XD_UNLOAD=S.doFullUnload

-- ===== MAIN LOOPS =====
task.spawn(function()
    while S.running and not S.unloaded do
        pcall(function()
            if C.RemoveHands or C.RemoveLegs or C.RemoveTorso then rebuildLimbCache() end
            if C.Enabled or H.Enabled then
                S.cachedUITool=findUITool() S.cachedDodgeTool=findDodgeTool()
                S.cachedSlot=inferSlotFor(S.cachedUITool,"T",C.ManualUISlot)
                S.cachedDodgeSlot=inferSlotFor(S.cachedDodgeTool,"1",C.ManualHnSSlot)
            end
            if (C.RebelSilentAim or C.RebelNoRecoil) and not S.combatHooked then hookCombat() end
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
    _G.__rlglLastSec=nil _G.__rlglTimerEndedAt=0 _G.__rlglLastFire=0
    while S.running and not S.unloaded do
        pcall(function()
            local onMap=_G.__rlgl_isOnMap()
            if not onMap then
                _G.__rlglLastSec=nil _G.__rlglTimerEndedAt=0 _G.__rlglWasRed=false
                task.wait(0.5)
                return
            end
            if C.RLGL_AutoDodge then
                local red=_G.__rlgl_isRed() local moving=_G.__rlgl_isMoving(C.RLGL_VelThreshold or 0.3) local safe=_G.__rlgl_inSafeZone()
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

do
    if ProximityPromptService then
        pcall(function()
            ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt,player)
                if S.unloaded or player~=LP or not C.InstantInteract then return end
                pcall(fireproximityprompt,prompt)
            end)
        end)
    end
end

track(LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if S.unloaded then return end
    rebuildLimbCache()
    if C.RemoveHands then applyRemoveHands(true) end
    if C.RemoveLegs then applyRemoveLegs(true) end
    if C.RemoveTorso then applyRemoveTorso(true) end
    if C.Headless then applyHeadless(true) end
    if C.Korblox then applyKorblox(true) end
    if C.RebelSilentAim or C.RebelNoRecoil then
        S.combatHooked=false
        task.defer(function() pcall(hookCombat) end)
    end
    if C.Noclip then pcall(_startNoclip) end
    S.aimbotTarget=nil
end))

ensureHandsLoop()

do
    local al=loadAutoloadName()
    if al~="" then
        local ok=loadConfig(al)
        if ok then print("[Xionix] Auto-loaded:",al) end
    else
        pcall(function()
            if S.FILE.isfile and S.FILE.isfile(configPath("default")) then
                loadConfig("default")
            end
        end)
    end
end

if getgenv then
    getgenv().__ui_dodge={shutdown=S.doFullUnload,config=C,H=H}
end

print("[Xionix_Dewamp v 1.1] LOADED")

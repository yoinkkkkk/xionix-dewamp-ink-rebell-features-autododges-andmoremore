--[[ XD Auto Brew Mobile Tester v2 ]]
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local LP=Players.LocalPlayer

local BREW_KEY="E"
local DELAY_COLLECT=0.5
local COLLECT_HOLD=2.0

local function isTouch() return UIS.TouchEnabled and not UIS.MouseEnabled end

-- === GUI ===
local sg=Instance.new("ScreenGui")
sg.Name="XD_BrewTest_"..tostring(math.random(1000,9999))
sg.IgnoreGuiInset=true
sg.ResetOnSpawn=false
sg.DisplayOrder=999999
local parent=nil
pcall(function() if gethui then parent=gethui() end end)
if not parent then parent=LP:FindFirstChildOfClass("PlayerGui") end
if not parent then parent=game:GetService("CoreGui") end
pcall(function() sg.Parent=parent end)
if not sg.Parent then pcall(function() sg.Parent=game:GetService("CoreGui") end) end

local main=Instance.new("Frame")
main.Size=UDim2.fromOffset(340,500)
main.Position=UDim2.new(0,10,0,60)
main.BackgroundColor3=Color3.fromRGB(15,10,25)
main.BorderSizePixel=0
main.Active=true
main.Parent=sg
local mc=Instance.new("UICorner") mc.CornerRadius=UDim.new(0,12) mc.Parent=main
local ms=Instance.new("UIStroke") ms.Color=Color3.fromRGB(200,60,255) ms.Thickness=1.5 ms.Parent=main

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-40,0,24)
title.Position=UDim2.fromOffset(10,8)
title.BackgroundTransparency=1
title.Text="Auto Brew Tester"
title.TextColor3=Color3.fromRGB(200,60,255)
title.Font=Enum.Font.GothamBlack
title.TextSize=14
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=main

local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.fromOffset(24,24)
closeBtn.Position=UDim2.new(1,-32,0,8)
closeBtn.BackgroundColor3=Color3.fromRGB(120,30,30)
closeBtn.BorderSizePixel=0
closeBtn.Font=Enum.Font.GothamBlack
closeBtn.TextSize=14
closeBtn.TextColor3=Color3.new(1,1,1)
closeBtn.Text="X"
closeBtn.Parent=main
local cc=Instance.new("UICorner") cc.CornerRadius=UDim.new(0,6) cc.Parent=closeBtn
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local out=Instance.new("ScrollingFrame")
out.Size=UDim2.new(1,-20,0,310)
out.Position=UDim2.fromOffset(10,38)
out.BackgroundColor3=Color3.fromRGB(25,18,40)
out.BorderSizePixel=0
out.CanvasSize=UDim2.fromOffset(0,0)
out.AutomaticCanvasSize=Enum.AutomaticSize.Y
out.ScrollBarThickness=3
out.Parent=main
local oc=Instance.new("UICorner") oc.CornerRadius=UDim.new(0,8) oc.Parent=out

local outLbl=Instance.new("TextLabel")
outLbl.Size=UDim2.new(1,-12,0,0)
outLbl.Position=UDim2.fromOffset(6,6)
outLbl.BackgroundTransparency=1
outLbl.Font=Enum.Font.Code
outLbl.TextSize=10
outLbl.TextColor3=Color3.fromRGB(220,220,240)
outLbl.TextXAlignment=Enum.TextXAlignment.Left
outLbl.TextYAlignment=Enum.TextYAlignment.Top
outLbl.TextWrapped=true
outLbl.AutomaticSize=Enum.AutomaticSize.Y
outLbl.Text=""
outLbl.Parent=out

local lines={}
local function log(s)
	table.insert(lines,"["..os.date("%H:%M:%S").."] "..tostring(s))
	if #lines>60 then table.remove(lines,1) end
	outLbl.Text=table.concat(lines,"\n")
	pcall(function() out.CanvasPosition=Vector2.new(0,out.AbsoluteCanvasSize.Y) end)
	print("[BREW] "..tostring(s))
end

local function mkBtn(y,text,color,cb)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1,-20,0,32)
	b.Position=UDim2.fromOffset(10,y)
	b.BackgroundColor3=color
	b.BorderSizePixel=0
	b.Font=Enum.Font.GothamBold
	b.TextSize=11
	b.TextColor3=Color3.new(1,1,1)
	b.Text=text
	b.Parent=main
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,8) c.Parent=b
	b.MouseButton1Click:Connect(cb)
	return b
end

-- === логика ===
local KEYMAP={["1"]=0x31,["2"]=0x32,["3"]=0x33,["4"]=0x34,["5"]=0x35,["6"]=0x36,["7"]=0x37,["8"]=0x38,["9"]=0x39,["0"]=0x30,e=0x45,t=0x54,y=0x59,r=0x52,f=0x46,q=0x51,g=0x47}

local function pressKey(k)
	k=string.lower(tostring(k))
	local kc=Enum.KeyCode[string.upper(k)] or Enum.KeyCode.E
	local ok,err=pcall(function()
		local vim=game:GetService("VirtualInputManager")
		vim:SendKeyEvent(true,kc,false,game)
		task.wait(0.08)
		vim:SendKeyEvent(false,kc,false,game)
	end)
	if ok then return "vim" end
	log("VIM fail: "..tostring(err))
	if type(keypress)=="function" then
		local code=KEYMAP[k]
		if code then
			local ok2,err2=pcall(function()
				keypress(code)
				task.wait(0.08)
				keyrelease(code)
			end)
			if ok2 then return "kp" end
			log("keypress fail: "..tostring(err2))
		end
	end
	return "fail"
end

local function scanAll()
	local pg=LP:FindFirstChild("PlayerGui")
	if not pg then return {} end
	local list={}
	for _,d in ipairs(pg:GetDescendants()) do
		if d:IsA("GuiButton") and d.Visible and d.AbsoluteSize.X>5 and d.AbsoluteSize.Y>5 then
			local n=string.lower(tostring(d.Name or ""))
			local txt=""
			pcall(function() if d:IsA("TextButton") then txt=string.lower(d.Text or "") end end)
			local score=0
			if n:find("collect") or txt:find("collect") then score=10 end
			if n:find("grab") or txt:find("grab") then score=9 end
			if n:find("pick") or txt:find("pick") then score=8 end
			if n:find("interact") or txt:find("interact") then score=7 end
			if n:find("собрать") or txt:find("собрать") then score=10 end
			if n:find("action") then score=5 end
			table.insert(list,{btn=d,score=score,name=n,text=txt,size=d.AbsoluteSize,pos=d.AbsolutePosition,cls=d.ClassName})
		end
	end
	return list
end

local function findCollect()
	local list=scanAll()
	local best=nil
	local bestScore=4
	for _,c in ipairs(list) do
		if c.score>bestScore then best=c bestScore=c.score end
	end
	return best
end

local function tapButton(btn)
	if not btn then return false end
	local px=btn.AbsolutePosition.X + btn.AbsoluteSize.X/2
	local py=btn.AbsolutePosition.Y + btn.AbsoluteSize.Y/2
	local ok,err=pcall(function()
		local vim=game:GetService("VirtualInputManager")
		vim:SendMouseButtonEvent(px,py,0,true,game,1)
		task.wait(0.06)
		vim:SendMouseButtonEvent(px,py,0,false,game,1)
	end)
	if not ok then log("tap fail: "..tostring(err)) end
	return ok
end

-- === кнопки ===
mkBtn(356,"1. Test E press",Color3.fromRGB(60,130,255),function()
	log("=== press E ===")
	local r=pressKey(BREW_KEY)
	log("result: "..tostring(r))
	log("brew started? watch game")
end)

mkBtn(392,"2. List all buttons",Color3.fromRGB(60,200,120),function()
	log("=== scan buttons ===")
	local list=scanAll()
	if #list==0 then log("no buttons")
	else
		for i,c in ipairs(list) do
			log(string.format("#%d [%s] %s | txt:%s | pos:%.0f,%.0f | score:%d",i,c.cls,c.name,c.text,c.pos.X,c.pos.Y,c.score))
		end
	end
end)

mkBtn(428,"3. Full Auto Brew test",Color3.fromRGB(255,160,60),function()
	task.spawn(function()
		log("=== FULL CYCLE ===")
		log("step1: press E")
		pressKey(BREW_KEY)
		task.wait(DELAY_COLLECT)
		log("step2: tap collect for "..COLLECT_HOLD.."s")
		local endT=tick()+COLLECT_HOLD
		local taps=0
		while tick()<endT do
			local c=findCollect()
			if c then
				if tapButton(c.btn) then
					taps=taps+1
					if taps<=3 then log("tapped: "..c.name.." @ "..math.floor(c.pos.X)..","..math.floor(c.pos.Y)) end
				end
			else
				log("no collect button")
			end
			task.wait(0.15+math.random()*0.2)
		end
		log("done. total taps: "..taps)
	end)
end)

mkBtn(464,"CLEAR",Color3.fromRGB(120,40,40),function()
	table.clear(lines) outLbl.Text="" log("cleared")
end)

-- drag
local drag=false ds sp
main.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		drag=true ds=i.Position sp=main.Position
	end
end)
UIS.InputChanged:Connect(function(i)
	if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
		local d=i.Position-ds
		main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		drag=false
	end
end)

log("Brew tester loaded")
log("Touch device: "..tostring(isTouch()))
log("---")
log("1=test E, 2=list buttons, 3=full cycle")
print("[XD] Brew tester loaded. gui parent:",sg.Parent)

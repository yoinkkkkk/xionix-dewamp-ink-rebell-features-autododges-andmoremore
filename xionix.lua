local z = {};
local R = {};
local function V()
	for z, R in pairs(z) do
		pcall(function()
			if R.hl then
				R.hl:Destroy();
			end;
		end);
		pcall(function()
			if R.nameBill then
				R.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if R.hpBar then
				R.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if R.distBill then
				R.distBill:Destroy();
			end;
		end);
		pcall(function()
			if R.toolBill then
				R.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if R.tracer then
				R.tracer:Destroy();
			end;
		end);
		pcall(function()
			if R.box then
				R.box:Destroy();
			end;
		end);
	end;
	table.clear(z);
end;
local function w()
	for z, R in pairs(R) do
		pcall(function()
			if R.hl then
				R.hl:Destroy();
			end;
		end);
		pcall(function()
			if R.nameBill then
				R.nameBill:Destroy();
			end;
		end);
		pcall(function()
			if R.hpBar then
				R.hpBar:Destroy();
			end;
		end);
		pcall(function()
			if R.distBill then
				R.distBill:Destroy();
			end;
		end);
		pcall(function()
			if R.toolBill then
				R.toolBill:Destroy();
			end;
		end);
		pcall(function()
			if R.tracer then
				R.tracer:Destroy();
			end;
		end);
		pcall(function()
			if R.box then
				R.box:Destroy();
			end;
		end);
	end;
	table.clear(R);
end;
local function K(z, R)
	if not z or not R then
		return false;
	end;
	if R:GetAttribute("IsGuard") == true then
		return true;
	end;
	if z:FindFirstChild("GuardPlayerOutift") then
		return true;
	end;
	if z:FindFirstChild("G3SG1") then
		return true;
	end;
	return false;
end;
local function g(z)
	local R = z and z:FindFirstChild("HumanoidRootPart");
	if not R then
		return 5.5;
	end;
	local V, w = math.huge, -math.huge;
	for z, R in ipairs(z:GetDescendants()) do
		if R:IsA("BasePart") then
			local z = R.Position.Y;
			if z < V then
				V = z;
			end;
			if z > w then
				w = z;
			end;
		end;
	end;
	if V == math.huge then
		return 5.5;
	end;
	local K = w - V;
	if K < 3 then
		K = 3;
	end;
	if K > 10 then
		K = 10;
	end;
	return K;
end;
local function l(z)
	if z > .6 then
		return Color3.fromRGB(74, 222, 74);
	elseif z > .3 then
		return Color3.fromRGB(255, 210, 60);
	else
		return Color3.fromRGB(255, 55, 55);
	end;
end;
local function Z(z, R, V, w, K, l)
	local Z = z:GetAttribute("IsGuard") and guardESPColor() or playerESPColor();
	local Y = Z:Lerp(Color3.new(0, 0, 0), .35);
	local p = g(R);
	ensureTracerGui();
	ensureOverlayGui();
	local D = Instance.new("Highlight");
	D.Name = "_XD_HL";
	D.FillTransparency = .4;
	D.OutlineTransparency = 0;
	D.FillColor = Z;
	D.OutlineColor = Y;
	D.Adornee = R;
	D.Parent = R;
	local a = Instance.new("BillboardGui");
	a.Name = "_XD_NAME";
	a.Size = UDim2.fromOffset(360, 26);
	a.StudsOffset = Vector3.new(0, p * .5 + .6, 0);
	a.AlwaysOnTop = true;
	a.LightInfluence = 0;
	a.Adornee = V;
	a.Parent = R;
	local E = Instance.new("Frame");
	E.BackgroundTransparency = 1;
	E.Size = UDim2.fromOffset(0, 24);
	E.AutomaticSize = Enum.AutomaticSize.X;
	E.AnchorPoint = Vector2.new(.5, .5);
	E.Position = UDim2.fromScale(.5, .5);
	E.Parent = a;
	local e = Instance.new("UIListLayout");
	e.FillDirection = Enum.FillDirection.Horizontal;
	e.SortOrder = Enum.SortOrder.LayoutOrder;
	e.VerticalAlignment = Enum.VerticalAlignment.Center;
	e.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	e.Padding = UDim.new(0, 6);
	e.Parent = E;
	local I = Instance.new("Frame");
	I.LayoutOrder = 1;
	I.Size = UDim2.fromOffset(42, 20);
	I.BackgroundColor3 = Color3.fromRGB(74, 222, 74);
	I.BorderSizePixel = 0;
	I.Parent = E;
	addCorner(I, 5);
	local U = Instance.new("UIStroke");
	U.Thickness = 1.5;
	U.Transparency = 0;
	U.Color = Color3.new(0, 0, 0);
	U.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	U.Parent = I;
	local W = Instance.new("TextLabel");
	W.Size = UDim2.fromScale(1, 1);
	W.BackgroundTransparency = 1;
	W.Font = Enum.Font.GothamBlack;
	W.TextSize = 13;
	W.TextColor3 = Color3.fromRGB(255, 255, 255);
	W.TextStrokeTransparency = 0;
	W.TextStrokeColor3 = Color3.new(0, 0, 0);
	W.Text = "[100]";
	W.Parent = I;
	local L = Instance.new("TextLabel");
	L.LayoutOrder = 2;
	L.BackgroundTransparency = 1;
	L.AutomaticSize = Enum.AutomaticSize.X;
	L.Size = UDim2.fromOffset(0, 24);
	L.Font = espFont();
	L.TextSize = K or 17;
	L.TextColor3 = Color3.fromRGB(255, 255, 255);
	L.TextStrokeTransparency = 0;
	L.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	L.Text = z.Name;
	L.Parent = E;
	local b = Instance.new("BillboardGui");
	b.Size = UDim2.fromOffset(220, 20);
	b.StudsOffset = Vector3.new(0, -p * .5 - 1.2, 0);
	b.AlwaysOnTop = true;
	b.LightInfluence = 0;
	b.Adornee = V;
	b.Parent = R;
	local t = Instance.new("TextLabel");
	t.Size = UDim2.new(1, 0, 1, 0);
	t.BackgroundTransparency = 1;
	t.TextColor3 = Z;
	t.TextStrokeTransparency = 0;
	t.TextStrokeColor3 = Color3.new(0, 0, 0);
	t.Font = espFont();
	t.TextSize = 13;
	t.Text = "";
	t.Parent = b;
	local F = Instance.new("BillboardGui");
	F.Size = UDim2.fromOffset(8, p * 24);
	F.StudsOffset = Vector3.new(-2.5, 0, 0);
	F.AlwaysOnTop = true;
	F.LightInfluence = 0;
	F.Adornee = V;
	F.Parent = R;
	local T = Instance.new("Frame");
	T.Size = UDim2.fromScale(1, 1);
	T.AnchorPoint = Vector2.new(.5, .5);
	T.Position = UDim2.fromScale(.5, .5);
	T.BackgroundColor3 = Color3.fromRGB(25, 8, 8);
	T.BackgroundTransparency = .2;
	T.BorderSizePixel = 0;
	T.Parent = F;
	local n = addCorner(T, 3);
	addStroke(T, Color3.new(0, 0, 0), 1, .3);
	local i = Instance.new("Frame");
	i.Size = UDim2.fromScale(1, 1);
	i.BackgroundColor3 = Color3.new(1, 1, 1);
	i.BorderSizePixel = 0;
	i.AnchorPoint = Vector2.new(0, 1);
	i.Position = UDim2.fromScale(0, 1);
	i.Parent = T;
	local h = addCorner(i, 3);
	local M = Instance.new("UIGradient");
	M.Color = l or mkGrad5(80, 255, 80, 180, 255, 60, 255, 200, 40, 255, 120, 60, 255, 40, 40);
	M.Rotation = 90;
	M.Parent = i;
	local k = Instance.new("BillboardGui");
	k.Size = UDim2.fromOffset(160, 18);
	k.StudsOffset = Vector3.new(2.8, 0, 0);
	k.AlwaysOnTop = true;
	k.LightInfluence = 0;
	k.Adornee = V;
	k.Parent = R;
	local s = Instance.new("TextLabel");
	s.Size = UDim2.new(1, 0, 1, 0);
	s.BackgroundTransparency = 1;
	s.TextColor3 = Z;
	s.TextStrokeTransparency = 0;
	s.TextStrokeColor3 = Color3.new(0, 0, 0);
	s.Font = Enum.Font.Code;
	s.TextSize = 13;
	s.Text = "";
	s.TextXAlignment = Enum.TextXAlignment.Left;
	s.Parent = k;
	local A = Instance.new("Frame");
	A.AnchorPoint = Vector2.new(.5, .5);
	A.BorderSizePixel = 0;
	A.ZIndex = 5;
	A.Visible = false;
	A.BackgroundColor3 = Z;
	A.Parent = S.tracerGui;
	local y = Instance.new("Frame");
	y.BackgroundTransparency = 1;
	y.BorderSizePixel = 0;
	y.Visible = false;
	y.ZIndex = 4;
	y.Parent = S.overlayGui;
	local N = Instance.new("UIStroke");
	N.Thickness = 2;
	N.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	N.Parent = y;
	return {
		hl = D,
		nameBill = a,
		hpChip = I,
		hpChipStroke = U,
		hpLbl = W,
		nameL = L,
		toolBill = b,
		toolL = t,
		hpBar = F,
		hpBg = T,
		hpFill = i,
		hpGradient = M,
		hpBgCorner = n,
		hpFillCorner = h,
		distBill = k,
		distL = s,
		tracer = A,
		box = y,
		boxStroke = N,
		char = R,
		color = Z,
		charHeight = p,
	};
end;
local function Y(z)
	if not z then
		return;
	end;
	pcall(function()
		if z.hl then
			z.hl:Destroy();
		end;
	end);
	pcall(function()
		if z.nameBill then
			z.nameBill:Destroy();
		end;
	end);
	pcall(function()
		if z.hpBar then
			z.hpBar:Destroy();
		end;
	end);
	pcall(function()
		if z.distBill then
			z.distBill:Destroy();
		end;
	end);
	pcall(function()
		if z.toolBill then
			z.toolBill:Destroy();
		end;
	end);
	pcall(function()
		if z.tracer then
			z.tracer:Destroy();
		end;
	end);
	pcall(function()
		if z.box then
			z.box:Destroy();
		end;
	end);
end;
local function p(z, R, V, w)
	if not z then
		return;
	end;
	local K = R:Lerp(Color3.new(0, 0, 0), .35);
	z.color = R;
	pcall(function()
		z.hl.FillColor = R;
		z.hl.OutlineColor = K;
	end);
	if z.nameL then
		pcall(function()
			local R = V or 17;
			z.nameL.TextSize = R;
			z.nameL.Font = espFont();
			if z.hpChip and z.hpLbl then
				local V = R / 17;
				z.hpChip.Size = UDim2.fromOffset(math.max(24, math.floor(42 * V + .5)), math.max(12, math.floor(20 * V + .5)));
				z.hpLbl.TextSize = math.max(8, math.floor(13 * V + .5));
			end;
		end);
	end;
	if z.distL then
		pcall(function()
			z.distL.TextColor3 = R;
		end);
	end;
	if z.toolL then
		pcall(function()
			z.toolL.TextColor3 = R;
			z.toolL.Font = espFont();
		end);
	end;
	if z.hpBg then
		local V = z.hpBg:FindFirstChildOfClass("UIStroke");
		if V then
			pcall(function()
				V.Color = R:Lerp(Color3.new(0, 0, 0), .4);
			end);
		end;
	end;
	if z.hpGradient and w then
		pcall(function()
			z.hpGradient.Color = w;
		end);
	end;
end;
local function D()
	if S.unloaded then
		return;
	end;
	_G.__adEspDone = 0;
	_G.__adEspTotal = 0;
	local g = C.GuardESP;
	local l = C.PlayerESP;
	if not ((g or l)) then
		if next(z) then
			V();
		end;
		if next(R) then
			w();
		end;
		return;
	end;
	local D = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart");
	for V, w in ipairs(Players:GetPlayers()) do
		if w ~= LP then
			_G.__adEspTotal = _G.__adEspTotal + 1;
			pcall(function()
				local V = w.Character;
				local a = V and V:FindFirstChildOfClass("Humanoid");
				local E = V and V:FindFirstChild("HumanoidRootPart");
				local e = C.GuardESP_ForceAll or K(V, w);
				local I = g and e;
				local U = l and not e;
				if a and (E and (a.Health > 0 and ((I or U)))) then
					local K = I and ((C.GuardESP_MaxDist or 0)) or (C.PlayerESP_MaxDist or 0);
					local g = D and D.Position or Vector3.zero;
					local l = ((g - E.Position)).Magnitude;
					if K > 0 and l > K then
						if z[w] then
							Y(z[w]);
							z[w] = nil;
						end;
						if R[w] then
							Y(R[w]);
							R[w] = nil;
						end;
						return;
					end;
					_G.__adEspDone = _G.__adEspDone + 1;
					local e = I and guardESPColor() or playerESPColor();
					local W = I and ((C.GuardESP_NameSize or 17)) or (C.PlayerESP_NameSize or 17);
					local L = I and guardHPGrad() or playerHPGrad();
					local b = I and z or R;
					local t = I and R or z;
					if t[w] then
						Y(t[w]);
						t[w] = nil;
					end;
					if not b[w] or b[w].char ~= V then
						if b[w] then
							Y(b[w]);
							b[w] = nil;
						end;
						b[w] = Z(w, V, E, a, W, L);
					else
						p(b[w], e, W, L);
					end;
					local F = b[w];
					if F then
						local z = I and C.GuardESP_HP or (U and C.PlayerESP_HP);
						local R = I and C.GuardESP_Name or (U and C.PlayerESP_Name);
						local K = I and C.GuardESP_Tool or (U and C.PlayerESP_Tool);
						local g = I and C.GuardESP_Distance or (U and C.PlayerESP_Distance);
						local Z = I and C.GuardESP_Highlight or (U and C.PlayerESP_Highlight);
						local Y = I and C.GuardESP_Tracer or (U and C.PlayerESP_Tracer);
						local p = I and C.GuardESP_Box or (U and C.PlayerESP_Box);
						F.showHPBar = z;
						F.showTracer = Y;
						F.showBox = p;
						F.boxColor = I and guardBoxColor() or playerBoxColor();
						F.boxThick = I and ((C.GuardESP_BoxThickness or 2)) or (C.PlayerESP_BoxThickness or 2);
						F.hpBarThickness = I and ((C.GuardESP_HPBarThickness or 8)) or (C.PlayerESP_HPBarThickness or 8);
						F.hpBarLength = I and ((C.GuardESP_HPBarLength or 1.5)) or (C.PlayerESP_HPBarLength or 1.5);
						F.hpBarRoundness = I and ((C.GuardESP_HPBarRoundness or 3)) or (C.PlayerESP_HPBarRoundness or 3);
						F.tracerColor = I and guardTracerColor() or playerTracerColor();
						F.nameBill.Enabled = R and true or false;
						F.toolBill.Enabled = K and true or false;
						if F.hl then
							F.hl.Enabled = Z and true or false;
						end;
						if K then
							local z = getToolRawName(V);
							if z == "" then
								z = "- none -";
							end;
							if F.toolL.Text ~= z then
								F.toolL.Text = z;
							end;
						end;
						local e = math.clamp(a.Health / math.max(a.MaxHealth, 1), 0, 1);
						F.hpFill.Size = UDim2.fromScale(1, e);
						if F.hpLbl then
							F.hpLbl.Text = "[" .. (tostring(math.floor(a.Health + .5)) .. "]");
						end;
						local W = I and C.GuardESP_HP_ChipBg or (U and C.PlayerESP_HP_ChipBg);
						local L = I and guardChipColor(e) or playerChipColor(e);
						if F.hpChip then
							F.hpChip.BackgroundColor3 = L;
							F.hpChip.BackgroundTransparency = W and 0 or 1;
						end;
						if F.hpLbl then
							F.hpLbl.TextColor3 = L;
						end;
						if F.hpChipStroke then
							local z = I and C.GuardESP_HP_Outline or (U and C.PlayerESP_HP_Outline);
							F.hpChipStroke.Enabled = ((z and W)) and true or false;
						end;
						if g then
							if D and E then
								F.distBill.Enabled = true;
								F.distL.Text = string.format("[%d studs]", math.floor(l + .5));
							else
								F.distBill.Enabled = false;
							end;
						else
							F.distBill.Enabled = false;
						end;
						if F.tracer then
							F.tracer.BackgroundColor3 = F.tracerColor;
						end;
						if not I and F.nameL then
							local z = w.Name;
							if C.PlayerESP_CustomName and C.PlayerESP_CustomName ~= "" then
								z = C.PlayerESP_CustomName;
							end;
							if F.nameL.Text ~= z then
								F.nameL.Text = z;
							end;
							if not C.PlayerESP_NameRainbow then
								F.nameL.TextColor3 = Color3.fromRGB(255, 255, 255);
							end;
						end;
					end;
				else
					if z[w] then
						Y(z[w]);
						z[w] = nil;
					end;
					if R[w] then
						Y(R[w]);
						R[w] = nil;
					end;
				end;
			end);
		end;
	end;
end;
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.GuardESP or C.PlayerESP then
				local V = Workspace.CurrentCamera;
				if V then
					local w = math.rad(V.FieldOfView);
					local K = V.ViewportSize;
					local g = K.Y;
					local l = V.CFrame.Position;
					local Z = K.X / 2;
					local Y = K.Y / 2;
					local p = math.tan(w / 2);
					if p > .01 then
						local function w(z)
							if not z then
								return;
							end;
							local R = z.char and z.char:FindFirstChild("HumanoidRootPart");
							if z.hpBar then
								if z.showHPBar and R then
									local V = ((l - R.Position)).Magnitude;
									if V < 1 then
										V = 1;
									end;
									local w = g / (((2 * V) * p));
									local K = z.hpBarThickness or 8;
									local Z = z.hpBarLength or 1.5;
									local Y = (((z.charHeight or 5.5)) * w) * Z;
									if Y > 3500 then
										Y = 3500;
									end;
									if Y < 20 then
										Y = 20;
									end;
									z.hpBar.Enabled = true;
									z.hpBar.Size = UDim2.fromOffset(K, Y);
									local D = z.hpBarRoundness or 3;
									pcall(function()
										if z.hpBgCorner then
											z.hpBgCorner.CornerRadius = UDim.new(0, D);
										end;
										if z.hpFillCorner then
											z.hpFillCorner.CornerRadius = UDim.new(0, D);
										end;
									end);
								else
									z.hpBar.Enabled = false;
								end;
							end;
							if z.tracer then
								if not z.showTracer or not R then
									if z.tracer.Visible then
										z.tracer.Visible = false;
									end;
								else
									local w, g = V:WorldToViewportPoint(R.Position);
									local l = w.X - Z;
									local p = w.Y - Y;
									local D = (w.Z < 0);
									if D then
										l = -l;
										p = -p;
									end;
									local a = math.sqrt(l * l + p * p);
									local E, e;
									if a < .001 then
										E, e = 0, 1;
									else
										E = l / a;
										e = p / a;
									end;
									local I = math.huge;
									if E > .0001 then
										I = math.min(I, ((K.X - Z)) / E);
									end;
									if E < -0.0001 then
										I = math.min(I, -Z / E);
									end;
									if e > .0001 then
										I = math.min(I, ((K.Y - Y)) / e);
									end;
									if e < -0.0001 then
										I = math.min(I, -Y / e);
									end;
									if I == math.huge or I < 1 then
										I = 1;
									end;
									local U, W;
									if g and not D then
										U = w.X;
										W = w.Y;
									else
										U = Z + E * I;
										W = Y + e * I;
									end;
									local L = U - Z;
									local b = W - Y;
									local t = math.sqrt(L * L + b * b);
									if t < 1 then
										t = 1;
									end;
									local F = math.deg(math.atan2(b, L));
									z.tracer.Visible = true;
									z.tracer.Position = UDim2.fromOffset(((Z + U)) / 2, ((Y + W)) / 2);
									z.tracer.Size = UDim2.fromOffset(t, 1.5);
									z.tracer.Rotation = F;
								end;
							end;
							if z.box and z.boxStroke then
								if not z.showBox then
									if z.box.Visible then
										z.box.Visible = false;
									end;
								else
									local R = z.char;
									if R and R.Parent then
										local w, K, g, l = getCharScreenBounds(R, V);
										if w then
											z.box.Visible = true;
											z.box.Position = UDim2.fromOffset(w - 4, K - 4);
											z.box.Size = UDim2.fromOffset((g - w) + 8, (l - K) + 8);
											z.boxStroke.Color = z.boxColor or Color3.new(1, 1, 1);
											z.boxStroke.Thickness = z.boxThick or 2;
										elseif z.box.Visible then
											z.box.Visible = false;
										end;
									elseif z.box.Visible then
										z.box.Visible = false;
									end;
								end;
							end;
						end;
						for z, R in pairs(z) do
							w(R);
						end;
						for z, R in pairs(R) do
							w(R);
						end;
					end;
				end;
			end;
		end);
		RunService.RenderStepped:Wait();
	end;
end);
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.PlayerESP and C.PlayerESP_NameRainbow then
				local z = ((tick() * ((C.PlayerESP_NameRainbowSpeed or 1)))) % 1;
				local V = Color3.fromHSV(z, 1, 1);
				for z, R in pairs(R) do
					if R.nameL and R.nameL.Parent then
						pcall(function()
							R.nameL.TextColor3 = V;
						end);
					end;
				end;
			end;
		end);
		RunService.RenderStepped:Wait();
	end;
end);
local function a(z)
	S.oneClickDalgona = z and true or false;
	if S.dalgonaConn then
		pcall(function()
			S.dalgonaConn:Disconnect();
		end);
		S.dalgonaConn = nil;
	end;
	if not S.oneClickDalgona then
		for z, R in pairs(_G.__dalgonaCache) do
			if z and z.Parent then
				pcall(function()
					z.Position = R.Position;
					z.Transparency = R.Transparency;
				end);
			end;
		end;
		table.clear(_G.__dalgonaCache);
		return;
	end;
	table.clear(_G.__dalgonaCache);
	S.dalgonaConn = RunService.RenderStepped:Connect(function()
			if S.unloaded or not S.oneClickDalgona then
				return;
			end;
			pcall(function()
				local z = LP:GetMouse();
				if not z or not z.Hit then
					return;
				end;
				local R = workspace:FindFirstChild("Effects");
				local V = nil;
				if R then
					for z, R in pairs(R:GetChildren()) do
						if R:IsA("Model") and string.match(R.Name, "Outline$") then
							V = R;
							break;
						end;
					end;
				end;
				if not V then
					return;
				end;
				local w = z.Hit.Position;
				for z, R in ipairs(V:GetChildren()) do
					if R:IsA("BasePart") then
						if not _G.__dalgonaCache[R] then
							_G.__dalgonaCache[R] = { Position = R.Position, Transparency = R.Transparency };
						end;
						R.Position = w;
						R.Transparency = 1;
					end;
				end;
			end);
		end);
end;
local function E()
	table.clear(S.handCache);
	table.clear(S.legCache);
	table.clear(S.torsoCache);
	local z = LP.Character;
	if not z then
		return;
	end;
	local R = {
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
	local w = { Torso = true, UpperTorso = true, LowerTorso = true };
	local K = {
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
	local function g(z)
		if not z or not z:IsA("Accessory") then
			return false;
		end;
		local R = string.lower(z.Name);
		if R:find("glove") or R:find("hand") or R:find("wrist") or R:find("cuff") then
			return true;
		end;
		local V = z:FindFirstChild("Handle");
		if V then
			for z, R in ipairs(V:GetChildren()) do
				if R:IsA("Attachment") and K[string.lower(R.Name)] then
					return true;
				end;
			end;
		end;
		return false;
	end;
	for z, K in ipairs(z:GetDescendants()) do
		if K:IsA("BasePart") then
			if R[K.Name] then
				table.insert(S.handCache, K);
			elseif V[K.Name] then
				table.insert(S.legCache, K);
			elseif w[K.Name] then
				table.insert(S.torsoCache, K);
			else
				local z = K:FindFirstAncestorOfClass("Accessory");
				if z and g(z) then
					table.insert(S.handCache, K);
				end;
			end;
		end;
	end;
end;
local function e(z, R)
	for V = 1, #z, 1 do
		local w = z[V];
		if w and w.Parent then
			if R then
				if S.origTransparency[w] == nil then
					S.origTransparency[w] = w.Transparency;
				end;
				w.LocalTransparencyModifier = 1;
				w.Transparency = 1;
			else
				w.LocalTransparencyModifier = 0;
				w.Transparency = S.origTransparency[w] or 0;
			end;
		end;
	end;
end;
local function I(z)
	C.RemoveHands = z and true or false;
	E();
	e(S.handCache, C.RemoveHands);
	return true;
end;
local function U(z)
	C.RemoveLegs = z and true or false;
	E();
	e(S.legCache, C.RemoveLegs);
	return true;
end;
local function W(z)
	C.RemoveTorso = z and true or false;
	E();
	e(S.torsoCache, C.RemoveTorso);
	return true;
end;
local function L()
	if S.handsConn then
		return;
	end;
	S.handsConn = RunService.Heartbeat:Connect(function()
			if S.unloaded then
				return;
			end;
			if C.RemoveHands then
				e(S.handCache, true);
			end;
			if C.RemoveLegs then
				e(S.legCache, true);
			end;
			if C.RemoveTorso then
				e(S.torsoCache, true);
			end;
		end);
	table.insert(S.conns, S.handsConn);
end;
local function b(z)
	local R = LP.Character;
	if not R then
		return false;
	end;
	local V = R:FindFirstChild("Head");
	if not V then
		return false;
	end;
	if z == false then
		V.LocalTransparencyModifier = 0;
		V.Transparency = 0;
		for z, R in ipairs(V:GetChildren()) do
			if R:IsA("Decal") then
				R.Transparency = 0;
			end;
		end;
		return true;
	end;
	for z, R in ipairs(V:GetChildren()) do
		if R:IsA("Decal") then
			R.Transparency = 1;
		end;
	end;
	V.LocalTransparencyModifier = 1;
	V.Transparency = 1;
	return true;
end;
local t = "rbxassetid://959831634";
local F = {
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot",
		"Left Leg",
	};
local function T(z)
	local R = LP.Character;
	if not R then
		return false;
	end;
	if z then
		for z, V in ipairs(F) do
			local w = R:FindFirstChild(V);
			if w and (w:IsA("BasePart") and not S.korbloxData[w]) then
				local z = w.Transparency;
				local V = w.LocalTransparencyModifier;
				w.LocalTransparencyModifier = 1;
				w.Transparency = 1;
				local K = Instance.new("Part");
				K.Name = "KorbloxDeco";
				K.Size = w.Size;
				K.CFrame = w.CFrame;
				K.Color = Color3.fromRGB(0, 0, 0);
				K.Material = Enum.Material.Plastic;
				K.CanCollide = false;
				K.CanQuery = false;
				K.CanTouch = false;
				K.CastShadow = false;
				K.Massless = true;
				K.Anchored = false;
				local g = Instance.new("SpecialMesh");
				g.MeshType = Enum.MeshType.FileMesh;
				g.MeshId = t;
				g.Scale = Vector3.new(1, 1, 1);
				g.Parent = K;
				K.Parent = R;
				local l = Instance.new("WeldConstraint");
				l.Part0 = w;
				l.Part1 = K;
				l.Parent = K;
				K.CFrame = w.CFrame;
				S.korbloxData[w] = { deco = K, origTrans = z, origLTM = V };
			end;
		end;
	else
		for z, R in pairs(S.korbloxData) do
			if z and z.Parent then
				z.LocalTransparencyModifier = R.origLTM;
				z.Transparency = R.origTrans;
			end;
			if R.deco and R.deco.Parent then
				R.deco:Destroy();
			end;
		end;
		table.clear(S.korbloxData);
	end;
	return true;
end;
local function n()
	for z, R in ipairs(S.hideConns) do
		pcall(function()
			R:Disconnect();
		end);
	end;
	table.clear(S.hideConns);
end;
local function i()
	n();
	if S.unloaded then
		return;
	end;
	local function z(z)
		if not z then
			return false;
		end;
		if not ((z:IsA("BillboardGui") or z:IsA("SurfaceGui"))) then
			return false;
		end;
		local R = string.lower(tostring(z.Name));
		if R:find("nick") or R:find("name") or R:find("tag") or R:find("title") or R:find("label") then
			return true;
		end;
		local V = z.Parent;
		if V and V.Name == "Head" then
			return true;
		end;
		return false;
	end;
	local function R(z)
		if not z or not z.Parent then
			return;
		end;
		pcall(function()
			z.Enabled = false;
		end);
		pcall(function()
			z.Visible = false;
		end);
		if not z:GetAttribute("_XD_nickHooked") then
			z:SetAttribute("_XD_nickHooked", true);
			table.insert(S.hideConns, (z:GetPropertyChangedSignal("Enabled")):Connect(function()
				if z.Enabled then
					pcall(function()
						z.Enabled = false;
					end);
				end;
			end));
			table.insert(S.hideConns, (z:GetPropertyChangedSignal("Visible")):Connect(function()
				if z.Visible then
					pcall(function()
						z.Visible = false;
					end);
				end;
			end));
		end;
	end;
	local function V(V)
		if not V then
			return;
		end;
		for V, w in ipairs(V:GetDescendants()) do
			if z(w) then
				R(w);
			end;
		end;
	end;
	local function w(w)
		if not w then
			return;
		end;
		V(w);
		table.insert(S.hideConns, w.DescendantAdded:Connect(function(V)
			if z(V) then
				task.defer(function()
					R(V);
				end);
			end;
		end));
	end;
	if LP.Character then
		w(LP.Character);
	end;
	table.insert(S.hideConns, LP.CharacterAdded:Connect(function(z)
		task.wait(.3);
		w(z);
	end));
	table.insert(S.hideConns, Players.PlayerAdded:Connect(function(z)
		z.CharacterAdded:Connect(function(z)
			if S.unloaded then
				return;
			end;
			task.wait(.3);
			w(z);
		end);
	end));
	for z, R in ipairs(Players:GetPlayers()) do
		if R ~= LP and R.Character then
			w(R.Character);
			table.insert(S.hideConns, R.CharacterAdded:Connect(function(z)
				if S.unloaded then
					return;
				end;
				task.wait(.3);
				w(z);
			end));
		end;
	end;
	if S._nickLoop then
		pcall(function()
			task.cancel(S._nickLoop);
		end);
	end;
	S._nickLoop = task.spawn(function()
			while not S.unloaded and C.HideNick do
				pcall(function()
					if LP.Character then
						V(LP.Character);
					end;
					for z, R in ipairs(Players:GetPlayers()) do
						if R ~= LP and R.Character then
							V(R.Character);
						end;
					end;
				end);
				RunService.RenderStepped:Wait();
			end;
		end);
end;
local h = "InkInstinct";
local function M()
	if S.FILE.isfolder and S.FILE.makefolder then
		local z, R = pcall(S.FILE.isfolder, h);
		if not z or not R then
			pcall(S.FILE.makefolder, h);
		end;
	end;
end;
local function k(z)
	return h .. ("/" .. (tostring(z) .. ".json"));
end;
local function s(z)
	local R = {};
	for z, V in pairs(z) do
		if typeof(V) == "Color3" then
			R[z] = { V.R, V.G, V.B };
		elseif typeof(V) == "EnumItem" then
			R[z] = V.Name;
		else
			R[z] = V;
		end;
	end;
	return R;
end;
local function A(z, R)
	if type(R) ~= "table" then
		return;
	end;
	for R, V in pairs(R) do
		if R == "MenuKey" and type(V) == "string" then
			local w, K = pcall(function()
					return Enum.KeyCode[V];
				end);
			if w and K then
				z[R] = K;
			end;
		elseif z[R] ~= nil and type(V) == type(z[R]) then
			z[R] = V;
		end;
	end;
end;
local function y(z)
	if z.C or z.H or z.anim then
		A(C, z.C or z.ui);
		A(H, z.H or z.hns);
		if type(z.anim) == "table" then
			for z, R in pairs(z.anim) do
				if HIT[tostring(z)] ~= nil and not BAN[tostring(z)] then
					S.animEnabled[tostring(z)] = R and true or false;
				end;
			end;
		end;
	else
		A(C, z);
	end;
	makeViz();
	syncHooks();
	repaintAll();
	D();
	makeFOVCircle();
	updateInfoVisibility();
end;
local function N(z)
	z = z or S.currentConfigName;
	if not S.FILE.writefile then
		return false, "no writefile";
	end;
	M();
	local R = (tostring(z)):gsub("[^%w%-%_]", "");
	if R == "" then
		R = "default";
	end;
	S.currentConfigName = R;
	local V = { C = s(C), H = s(H), anim = S.animEnabled };
	local w = pcall(function()
			S.FILE.writefile(k(R), HttpService:JSONEncode(V));
		end);
	if not w then
		return false, "writefile failed";
	end;
	return true, "ok";
end;
local function x(z)
	z = z or S.currentConfigName;
	if not S.FILE.readfile or not S.FILE.isfile then
		return false, "no readfile";
	end;
	local R = k(z);
	local V, w = pcall(S.FILE.isfile, R);
	if not V or not w then
		return false, "not found";
	end;
	local K, g = pcall(S.FILE.readfile, R);
	if not K or not g then
		return false, "read failed";
	end;
	local l, Z = pcall(function()
			return HttpService:JSONDecode(g);
		end);
	if not l or type(Z) ~= "table" then
		return false, "bad json";
	end;
	y(Z);
	S.currentConfigName = (tostring(z)):gsub("[^%w%-%_]", "");
	return true, "ok";
end;
local function B()
	local z = {};
	if not S.FILE.listfiles or not S.FILE.isfolder then
		return z;
	end;
	local R, V = pcall(S.FILE.isfolder, h);
	if not R or not V then
		return z;
	end;
	local w, K = pcall(S.FILE.listfiles, h);
	if not w or type(K) ~= "table" then
		return z;
	end;
	for R, V in ipairs(K) do
		local w = (tostring(V)):match("([^/\\]+)%.json$");
		if w and w ~= "" then
			table.insert(z, w);
		end;
	end;
	table.sort(z);
	return z;
end;
local function o(z)
	if not S.FILE.delfile then
		return false, "no delfile";
	end;
	local R = pcall(S.FILE.delfile, k(z));
	return R;
end;
S.ui = {};
S.ui.PANEL_W = 400;
S.ui.PANEL_H = 660;
S.ui.CONTENT_W = S.ui.PANEL_W - 16;
S.ui.CONTENT_H = S.ui.PANEL_H - 90;
S.ui.BTN_W = S.ui.CONTENT_W - 8;
S.ui.COL = {
		bg = Color3.fromRGB(11, 9, 18),
		bg2 = Color3.fromRGB(22, 15, 36),
		card = Color3.fromRGB(26, 20, 40),
		text = Color3.fromRGB(235, 225, 250),
		textDim = Color3.fromRGB(150, 135, 175),
		off = Color3.fromRGB(22, 17, 34),
	};
S.ui.tabFrames = {};
S.ui.activeTab = "Main";
S.ui.pickerOverlay = nil;
function S.ui.mkDivider(z, R, V)
	local w = Instance.new("Frame");
	w.Size = UDim2.new(1, -8, 0, 18);
	w.Position = UDim2.fromOffset(4, R);
	w.BackgroundTransparency = 1;
	w.ZIndex = 5;
	w.Parent = z;
	local K = Instance.new("TextLabel");
	K.Size = UDim2.fromOffset(180, 18);
	K.BackgroundTransparency = 1;
	K.Font = Enum.Font.GothamBold;
	K.TextSize = 9;
	K.Text = string.upper(V or "");
	K.TextColor3 = guiAccent();
	K.TextXAlignment = Enum.TextXAlignment.Left;
	K.ZIndex = 6;
	K.Parent = w;
	registerRepaint(function()
		K.TextColor3 = guiAccent();
	end);
	local g = Instance.new("Frame");
	g.Size = UDim2.new(1, -190, 0, 1);
	g.Position = UDim2.fromOffset(190, 9);
	g.BackgroundColor3 = guiAccent();
	g.BackgroundTransparency = .72;
	g.BorderSizePixel = 0;
	g.ZIndex = 6;
	g.Parent = w;
	registerRepaint(function()
		g.BackgroundColor3 = guiAccent();
	end);
end;
function S.ui.makeToggle(z, R, V, w, K, g, l)
	local Z = S.ui.COL;
	local Y = S.ui.BTN_W;
	l = l or C;
	local p = Instance.new("TextButton");
	p.Size = UDim2.fromOffset(Y, 26);
	p.Position = UDim2.fromOffset(4, R);
	p.BorderSizePixel = 0;
	p.Font = Enum.Font.Gotham;
	p.TextSize = 12;
	p.TextXAlignment = Enum.TextXAlignment.Left;
	p.TextColor3 = guiTextColor();
	p.AutoButtonColor = false;
	p.ZIndex = 6;
	p.Parent = z;
	addCorner(p, 7);
	local a = Instance.new("Frame");
	a.Size = UDim2.fromOffset(30, 16);
	a.Position = UDim2.new(1, -38, .5, -8);
	a.BorderSizePixel = 0;
	a.ZIndex = 7;
	a.Parent = p;
	addCorner(a, 8);
	local e = Instance.new("Frame");
	e.Size = UDim2.fromOffset(12, 12);
	e.Position = UDim2.fromOffset(2, 2);
	e.BackgroundColor3 = Color3.new(1, 1, 1);
	e.BorderSizePixel = 0;
	e.ZIndex = 8;
	e.Parent = a;
	addCorner(e, 6);
	local function t()
		if K then
			return K() and true or false;
		end;
		if w then
			return l[w] and true or false;
		end;
		return false;
	end;
	local function F(z)
		local R = t();
		p.Text = "   " .. V;
		local w = R and accentDark(guiAccent()) or Z.off;
		local K = R and guiAccent() or Color3.fromRGB(60, 50, 78);
		local g = R and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
		if z then
			local z = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			(TweenService:Create(p, z, { BackgroundColor3 = w })):Play();
			(TweenService:Create(a, z, { BackgroundColor3 = K })):Play();
			(TweenService:Create(e, z, { Position = g })):Play();
		else
			p.BackgroundColor3 = w;
			a.BackgroundColor3 = K;
			e.Position = g;
		end;
		p.TextColor3 = guiTextColor();
	end;
	registerRepaint(function()
		local z = t();
		p.BackgroundColor3 = z and accentDark(guiAccent()) or Z.off;
		p.TextColor3 = guiTextColor();
		a.BackgroundColor3 = z and guiAccent() or Color3.fromRGB(60, 50, 78);
		e.Position = z and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2);
	end);
	F(false);
	p.MouseButton1Click:Connect(function()
		if S.unloaded then
			return;
		end;
		playClick();
		local z = not t();
		if w then
			l[w] = z;
		end;
		if g then
			g(z);
		else
			if w == "Enabled" then
				syncHooks();
			elseif w == "RadiusVis" then
				makeViz();
			elseif w == "RemoveLegs" then
				U(l.RemoveLegs);
				L();
			elseif w == "RemoveHands" then
				I(l.RemoveHands);
				L();
				E();
			elseif w == "RemoveTorso" then
				W(l.RemoveTorso);
				L();
				E();
			elseif w == "Headless" then
				b(l.Headless);
			elseif w == "Korblox" then
				T(l.Korblox);
			elseif w == "RebelFOVCircle" then
				makeFOVCircle();
			elseif w == "RebelFOVNeon" or w == "RebelFOVBlackOutline" then
				makeFOVCircle();
			elseif w == "Watermark" or w == "KeybindList" then
				updateInfoVisibility();
			elseif w == "GuardESP" or w == "PlayerESP" then
				D();
			elseif w == "HideNick" then
				i();
			elseif w == "FullBright" then
				applyFullBright(l.FullBright);
			elseif w == "RemoveFog" then
				applyRemoveFog(l.RemoveFog);
			elseif w == "FOVRainbow" then
				if l.FOVRainbow then
					startFovRainbow();
				else
					stopFovRainbow();
					makeFOVCircle();
				end;
			elseif w == "PanelRainbow" then
				if l.PanelRainbow then
					startPanelRainbow();
				else
					stopPanelRainbow();
					if S.panel then
						local z = S.panel:FindFirstChildOfClass("UIStroke");
						if z then
							z.Color = guiAccent();
						end;
					end;
				end;
			elseif w == "BulletTracer" then
 
			elseif w == "FOVUseCustom" then
				makeFOVCircle();
				if l.FOVRainbow then
					startFovRainbow();
				end;
			elseif w == "AutoBrew" then
				if l.AutoBrew then
					startBrewLoop();
				else
					stopBrewLoop();
				end;
			elseif w == "CircleRainbowText" or w == "CircleRainbowOutline" then
				repaintAll();
			elseif type(w) == "string" and ((w:sub(1, 9) == "GuardESP_" or w:sub(1, 10) == "PlayerESP_")) then
				D();
			end;
		end;
		F(true);
		if _G.__adShowNotif then
			_G.__adShowNotif(V .. (":  " .. ((z and "ON" or "OFF"))), z and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80));
		end;
	end);
	return F;
end;
function S.ui.makeSlider(z, R, V, w, K, g, l, Z, Y)
	local p = S.ui.COL;
	local D = S.ui.BTN_W;
	Z = Z or C;
	local a = Instance.new("Frame");
	a.Size = UDim2.fromOffset(D, 40);
	a.Position = UDim2.fromOffset(4, R);
	a.BackgroundTransparency = 1;
	a.ZIndex = 5;
	a.Parent = z;
	local E = Instance.new("TextLabel");
	E.Size = UDim2.fromOffset(D, 14);
	E.BackgroundTransparency = 1;
	E.Font = Enum.Font.Gotham;
	E.TextSize = 11;
	E.TextXAlignment = Enum.TextXAlignment.Left;
	E.TextColor3 = guiTextColor();
	E.ZIndex = 6;
	E.Parent = a;
	registerRepaint(function()
		E.TextColor3 = guiTextColor();
	end);
	local function e()
		E.Text = V .. ("   " .. tostring(Z[w]));
	end;
	e();
	local I = Instance.new("TextButton");
	I.Size = UDim2.fromOffset(D, 14);
	I.Position = UDim2.fromOffset(0, 18);
	I.BackgroundColor3 = p.card;
	I.BorderSizePixel = 0;
	I.Text = "";
	I.AutoButtonColor = false;
	I.ZIndex = 6;
	I.Parent = a;
	addCorner(I, 7);
	local U = Instance.new("Frame");
	U.Size = UDim2.new(math.clamp(((((Z[w] or K)) - K)) / ((g - K)), 0, 1), 0, 1, 0);
	U.BorderSizePixel = 0;
	U.ZIndex = 7;
	U.Parent = I;
	addCorner(U, 7);
	U.BackgroundColor3 = guiAccent();
	registerRepaint(function()
		U.BackgroundColor3 = guiAccent();
	end);
	local W = Instance.new("Frame");
	W.Size = UDim2.fromOffset(12, 12);
	W.BackgroundColor3 = Color3.new(1, 1, 1);
	W.BorderSizePixel = 0;
	W.ZIndex = 8;
	W.Parent = I;
	addCorner(W, 6);
	addStroke(W, Color3.new(0, 0, 0), 1, .5);
	local L = false;
	local function b()
		local z = ((((Z[w] or K)) - K)) / ((g - K));
		W.Position = UDim2.new(z, -6, .5, -6);
	end;
	b();
	local function t(z)
		local R = math.clamp(((z - I.AbsolutePosition.X)) / math.max(I.AbsoluteSize.X, 1), 0, 1);
		local V = K + R * ((g - K));
		V = math.floor(V / l + .5) * l;
		if l < 1 then
			V = math.floor(V * 100 + .5) / 100;
		end;
		Z[w] = math.clamp(V, K, g);
		U.Size = UDim2.new(((Z[w] - K)) / ((g - K)), 0, 1, 0);
		b();
		e();
		if Y then
			pcall(Y);
		end;
	end;
	I.InputBegan:Connect(function(z)
		if z.UserInputType == Enum.UserInputType.MouseButton1 or z.UserInputType == Enum.UserInputType.Touch then
			L = true;
			t(z.Position.X);
		end;
	end);
	track(UIS.InputEnded:Connect(function(z)
		if z.UserInputType == Enum.UserInputType.MouseButton1 or z.UserInputType == Enum.UserInputType.Touch then
			L = false;
		end;
	end));
	track(UIS.InputChanged:Connect(function(z)
		if L and ((z.UserInputType == Enum.UserInputType.MouseMovement or z.UserInputType == Enum.UserInputType.Touch)) then
			t(z.Position.X);
		end;
	end));
	return e;
end;
function S.ui.makeBtn(z, R, V, w)
	local K = S.ui.COL;
	local g = S.ui.BTN_W;
	local l = Instance.new("TextButton");
	l.Size = UDim2.fromOffset(g, 28);
	l.Position = UDim2.fromOffset(4, R);
	l.BackgroundColor3 = K.card;
	l.BorderSizePixel = 0;
	l.Font = Enum.Font.GothamBold;
	l.TextSize = 12;
	l.TextColor3 = guiTextColor();
	l.Text = V;
	l.ZIndex = 6;
	l.Parent = z;
	addCorner(l, 7);
	registerRepaint(function()
		l.TextColor3 = guiTextColor();
	end);
	local Z = addStroke(l, guiAccent(), 1, .55);
	registerRepaint(function()
		Z.Color = guiAccent();
	end);
	l.MouseButton1Click:Connect(function()
		if S.unloaded then
			return;
		end;
		playClick();
		w();
	end);
	return l;
end;
function S.ui.makeInput(z, R, V)
	local w = S.ui.COL;
	local K = S.ui.BTN_W;
	local g = Instance.new("TextBox");
	g.Size = UDim2.fromOffset(K, 26);
	g.Position = UDim2.fromOffset(4, R);
	g.BackgroundColor3 = w.card;
	g.BorderSizePixel = 0;
	g.Font = Enum.Font.Gotham;
	g.TextSize = 12;
	g.TextColor3 = guiTextColor();
	g.PlaceholderText = V;
	g.PlaceholderColor3 = w.textDim;
	g.Text = "";
	g.ClearTextOnFocus = false;
	g.ZIndex = 6;
	g.Parent = z;
	addCorner(g, 7);
	registerRepaint(function()
		g.TextColor3 = guiTextColor();
	end);
	local l = addStroke(g, w.off, 1, .4);
	registerRepaint(function()
		l.Color = guiAccent();
	end);
	return g;
end;
function S.ui.colorRow(z, R, V, w, K)
	local g = S.ui.COL;
	local l = S.ui.BTN_W;
	local Z = Instance.new("Frame");
	Z.Size = UDim2.fromOffset(l, 30);
	Z.Position = UDim2.fromOffset(4, R);
	Z.BackgroundTransparency = 1;
	Z.ZIndex = 5;
	Z.Parent = z;
	local Y = Instance.new("TextLabel");
	Y.Size = UDim2.fromOffset(120, 30);
	Y.Position = UDim2.fromOffset(0, 0);
	Y.BackgroundTransparency = 1;
	Y.Font = Enum.Font.Gotham;
	Y.TextSize = 11;
	Y.TextXAlignment = Enum.TextXAlignment.Left;
	Y.TextColor3 = guiTextColor();
	Y.Text = V or "";
	Y.ZIndex = 6;
	Y.Parent = Z;
	registerRepaint(function()
		Y.TextColor3 = guiTextColor();
	end);
	local p = Instance.new("Frame");
	p.Size = UDim2.fromOffset(28, 28);
	p.Position = UDim2.fromOffset(l - 148, 1);
	p.BorderSizePixel = 0;
	p.BackgroundColor3 = w();
	p.ZIndex = 6;
	p.Parent = Z;
	addCorner(p, 8);
	local D = addStroke(p, guiAccent(), 1.5, .2);
	registerRepaint(function()
		D.Color = guiAccent();
	end);
	local a = Instance.new("TextButton");
	a.Size = UDim2.fromOffset(114, 26);
	a.Position = UDim2.fromOffset(l - 116, 2);
	a.BackgroundColor3 = g.card;
	a.BorderSizePixel = 0;
	a.Font = Enum.Font.GothamBold;
	a.TextSize = 11;
	a.TextColor3 = guiTextColor();
	a.Text = "Change color";
	a.AutoButtonColor = false;
	a.ZIndex = 6;
	a.Parent = Z;
	registerRepaint(function()
		a.TextColor3 = guiTextColor();
	end);
	addCorner(a, 6);
	local E = addStroke(a, guiAccent(), 1, .5);
	registerRepaint(function()
		E.Color = guiAccent();
	end);
	a.MouseButton1Click:Connect(function()
		if S.unloaded then
			return;
		end;
		playClick();
		if S.colorPickerOpen then
			S.colorPickerOpen(w(), function(z)
				pcall(K, z);
				p.BackgroundColor3 = z;
			end);
		end;
	end);
	registerRepaint(function()
		p.BackgroundColor3 = w();
	end);
end;
function S.ui.buildPanel()
	local z = S.ui.COL;
	local R = S.ui.PANEL_W;
	local V = S.ui.PANEL_H;
	local w = nil;
	if gethui then
		local z, R = pcall(gethui);
		if z and (R and typeof(R) == "Instance") then
			w = R;
		end;
	end;
	if not w or typeof(w) ~= "Instance" then
		w = LP:FindFirstChildOfClass("PlayerGui");
	end;
	if not w then
		w = LP:WaitForChild("PlayerGui", 5);
	end;
	if not w then
		w = game:GetService("CoreGui");
	end;
	S.gui = Instance.new("ScreenGui");
	S.gui.Name = "XD_x1oni1x_" .. randStr(6);
	S.gui.ResetOnSpawn = false;
	S.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	S.gui.DisplayOrder = 100000;
	S.gui.IgnoreGuiInset = true;
	S.gui.Enabled = true;
	pcall(function()
		S.gui.Parent = w;
	end);
	if not S.gui.Parent then
		pcall(function()
			S.gui.Parent = game:GetService("CoreGui");
		end);
	end;
	S.glow = Instance.new("Frame");
	S.glow.Size = UDim2.fromOffset(R + 40, V + 40);
	S.glow.Position = UDim2.new(.5, (-R / 2 - 20) - 800, .5, -V / 2 - 20);
	S.glow.BackgroundColor3 = guiAccent();
	S.glow.BackgroundTransparency = .86;
	S.glow.BorderSizePixel = 0;
	S.glow.ZIndex = 0;
	S.glow.Parent = S.gui;
	addCorner(S.glow, 22);
	registerRepaint(function()
		S.glow.BackgroundColor3 = guiAccent();
	end);
	S.shadow = Instance.new("Frame");
	S.shadow.Size = UDim2.fromOffset(R + 12, V + 12);
	S.shadow.Position = UDim2.new(.5, (-R / 2 + 6) - 800, .5, -V / 2 + 6);
	S.shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	S.shadow.BackgroundTransparency = .65;
	S.shadow.BorderSizePixel = 0;
	S.shadow.ZIndex = 1;
	S.shadow.Parent = S.gui;
	addCorner(S.shadow, 18);
	S.panel = Instance.new("Frame");
	S.panel.Size = UDim2.fromOffset(R, V);
	S.panel.Position = UDim2.new(.5, -R / 2 - 800, .5, -V / 2);
	S.panel.BackgroundColor3 = z.bg;
	S.panel.BorderSizePixel = 0;
	S.panel.Active = true;
	S.panel.Visible = true;
	S.panel.ZIndex = 2;
	S.panel.Parent = S.gui;
	S.panel.ClipsDescendants = true;
	addCorner(S.panel, 14);
	addGrad(S.panel, z.bg2, z.bg, 90);
	local K = addStroke(S.panel, guiAccent(), 1.4, .35);
	registerRepaint(function()
		if not C.PanelRainbow then
			K.Color = guiAccent();
		end;
	end);
	track((S.panel:GetPropertyChangedSignal("Position")):Connect(function()
		S.shadow.Position = UDim2.new(S.panel.Position.X.Scale, S.panel.Position.X.Offset + 6, S.panel.Position.Y.Scale, S.panel.Position.Y.Offset + 6);
		S.glow.Position = UDim2.new(S.panel.Position.X.Scale, S.panel.Position.X.Offset - 20, S.panel.Position.Y.Scale, S.panel.Position.Y.Offset - 20);
	end));
	task.spawn(function()
		task.wait(.05);
		if S.unloaded or not S.panel or not S.panel.Parent then
			return;
		end;
		local z = TweenInfo.new(.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
		(TweenService:Create(S.panel, z, { Position = UDim2.new(.5, -R / 2, .5, -V / 2) })):Play();
		if S.shadow and S.shadow.Parent then
			(TweenService:Create(S.shadow, z, { Position = UDim2.new(.5, -R / 2 + 6, .5, -V / 2 + 6) })):Play();
		end;
		if S.glow and S.glow.Parent then
			(TweenService:Create(S.glow, z, { Position = UDim2.new(.5, -R / 2 - 20, .5, -V / 2 - 20) })):Play();
		end;
	end);
	do
		local z = false;
		local R = nil;
		local V = nil;
		track(S.panel.InputBegan:Connect(function(w)
			if w.UserInputType == Enum.UserInputType.MouseButton1 or w.UserInputType == Enum.UserInputType.Touch then
				z = true;
				R = w.Position;
				V = S.panel.Position;
				w.Changed:Connect(function()
					if w.UserInputState == Enum.UserInputState.End then
						z = false;
					end;
				end);
			end;
		end));
		track(UIS.InputChanged:Connect(function(w)
			if not z then
				return;
			end;
			if w.UserInputType == Enum.UserInputType.MouseMovement or w.UserInputType == Enum.UserInputType.Touch then
				local z = w.Position - R;
				S.panel.Position = UDim2.new(V.X.Scale, V.X.Offset + z.X, V.Y.Scale, V.Y.Offset + z.Y);
			end;
		end));
	end;
	local g = Instance.new("Frame");
	g.Size = UDim2.new(1, -28, 0, 2);
	g.Position = UDim2.fromOffset(14, 0);
	g.BackgroundColor3 = guiAccent();
	g.BorderSizePixel = 0;
	g.ZIndex = 3;
	g.Parent = S.panel;
	addCorner(g, 2);
	registerRepaint(function()
		g.BackgroundColor3 = guiAccent();
	end);
	local l = Instance.new("TextLabel");
	l.Size = UDim2.fromOffset(240, 20);
	l.Position = UDim2.fromOffset(14, 12);
	l.BackgroundTransparency = 1;
	l.Font = Enum.Font.GothamBlack;
	l.TextSize = 13;
	l.TextXAlignment = Enum.TextXAlignment.Left;
	l.TextColor3 = guiAccent();
	l.Text = SCRIPT_NAME;
	l.ZIndex = 3;
	l.Parent = S.panel;
	registerRepaint(function()
		l.TextColor3 = guiAccent();
	end);
	local Z = Instance.new("TextLabel");
	Z.Size = UDim2.fromOffset(140, 40);
	Z.Position = UDim2.new(1, -192, 0, 12);
	Z.BackgroundTransparency = 1;
	Z.Font = Enum.Font.Code;
	Z.TextSize = 10;
	Z.TextXAlignment = Enum.TextXAlignment.Right;
	Z.TextYAlignment = Enum.TextYAlignment.Top;
	Z.TextColor3 = z.textDim;
	Z.Text = "fps ---\nping ---";
	Z.ZIndex = 3;
	Z.Parent = S.panel;
	local Y = Instance.new("TextLabel");
	Y.Size = UDim2.new(1, -20, 0, 12);
	Y.Position = UDim2.fromOffset(14, 30);
	Y.BackgroundTransparency = 1;
	Y.Font = Enum.Font.Gotham;
	Y.TextSize = 9;
	Y.TextXAlignment = Enum.TextXAlignment.Left;
	Y.TextColor3 = guiTextColor();
	Y.Text = "ink game - auto dodge";
	Y.ZIndex = 3;
	Y.Parent = S.panel;
	registerRepaint(function()
		Y.TextColor3 = guiTextColor();
	end);
	local p = Instance.new("TextLabel");
	p.Size = UDim2.new(1, -20, 0, 12);
	p.Position = UDim2.fromOffset(14, 44);
	p.BackgroundTransparency = 1;
	p.Font = Enum.Font.Code;
	p.TextSize = 10;
	p.TextXAlignment = Enum.TextXAlignment.Left;
	p.TextColor3 = guiTextColor();
	p.Text = "ready - N to close";
	p.ZIndex = 3;
	p.Parent = S.panel;
	registerRepaint(function()
		p.TextColor3 = guiTextColor();
	end);
	local D = Instance.new("TextButton");
	D.AnchorPoint = Vector2.new(1, 0);
	D.Size = UDim2.fromOffset(24, 24);
	D.Position = UDim2.new(1, -12, 0, 12);
	D.BackgroundColor3 = z.card;
	D.BorderSizePixel = 0;
	D.Font = Enum.Font.GothamBlack;
	D.TextSize = 18;
	D.TextColor3 = guiTextColor();
	D.Text = "-";
	D.AutoButtonColor = false;
	D.ZIndex = 12;
	D.Parent = S.panel;
	registerRepaint(function()
		D.TextColor3 = guiTextColor();
	end);
	addCorner(D, 6);
	local a = addStroke(D, guiAccent(), 1.5, 0);
	registerRepaint(function()
		a.Color = guiAccent();
	end);
	local function E(z)
		if not S.unloaded and (p and p.Parent) then
			p.Text = tostring(z or "");
		end;
	end;
	_G.__ad_statusCb = E;
	local e = 0;
	local I = tick();
	local U = 0;
	track(RunService.RenderStepped:Connect(function()
		e = e + 1;
		local z = tick();
		if z - I >= 2 then
			U = math.floor(e / ((z - I)));
			e = 0;
			I = z;
		end;
	end));
	task.spawn(function()
		while not S.unloaded do
			local z = 0;
			pcall(function()
				local R = StatsService.Network.ServerStatsItem["Data Ping"];
				if R then
					z = math.floor(R:GetValue());
				end;
			end);
			if not S.unloaded and (Z and Z.Parent) then
				local R = game.JobId or "";
				if #R > 8 then
					R = R:sub(1, 8);
				end;
				if R == "" then
					R = "studio";
				end;
				Z.Text = string.format("fps %d\nping %d - srv %s", U, z, R);
			end;
			if not S.unloaded and (S.wmLabel and C.Watermark) then
				pcall(function()
					local R = tostring(LP.Name or "?");
					if #R > 14 then
						R = R:sub(1, 14) .. "...";
					end;
					local V = (C.MenuKey and C.MenuKey.Name) or "N";
					S.wmLabel.Text = string.format("%s %s\n%s | %dms | [%s]", SCRIPT_NAME, SCRIPT_VERSION, R, z, V);
				end);
			end;
			if not S.unloaded and (S.kbLabel and C.KeybindList) then
				pcall(function()
					local z = {};
					if C.Enabled then
						table.insert(z, "AutoDodge:  ON");
					end;
					if H.Enabled then
						table.insert(z, "HnS Dodge:  ON");
					end;
					if C.RLGL_AutoDodge then
						table.insert(z, "RLGL:  ON");
					end;
					if C.RebelSilentAim then
						table.insert(z, "Silent Aim:  ON");
					end;
					if C.RebelNoRecoil then
						table.insert(z, "No Recoil:  ON");
					end;
					if C.RebelRapidFire then
						table.insert(z, "Rapid Fire:  ON");
					end;
					if C.BulletTracer then
						table.insert(z, "Bullet Tracer:  ON");
					end;
					if C.GuardESP then
						table.insert(z, "Guard ESP:  ON");
					end;
					if C.PlayerESP then
						table.insert(z, "Player ESP:  ON");
					end;
					if C.HideNick then
						table.insert(z, "HideNick:  ON");
					end;
					if C.FullBright then
						table.insert(z, "Full Bright:  ON");
					end;
					if C.RemoveFog then
						table.insert(z, "No Fog:  ON");
					end;
					if C.AutoBrew then
						table.insert(z, "Auto Brew:  ON");
					end;
					if C.AnimSpeed then
						table.insert(z, "Anim 2.5x:  ON");
					end;
					S.kbLabel.Text = (#z == 0) and "[no features]" or table.concat(z, "\n");
					if S.kbFrame then
						local R = math.max(1, #z);
						S.kbFrame.Size = UDim2.fromOffset(210, math.max(30, R * 12 + 8));
					end;
				end);
			end;
			task.wait(3);
		end;
	end);
	local W = Instance.new("Frame");
	W.Size = UDim2.new(1, -16, 0, 26);
	W.Position = UDim2.fromOffset(8, 58);
	W.BackgroundColor3 = z.off;
	W.BackgroundTransparency = .35;
	W.BorderSizePixel = 0;
	W.ZIndex = 3;
	W.Parent = S.panel;
	addCorner(W, 8);
	local L = {
			"Main",
			"HnS",
			"Rebel",
			"RLGL",
			"ESP",
			"Dalgona",
			"Extra",
			"Configs",
		};
	local b = Instance.new("Frame");
	b.Size = UDim2.fromOffset(S.ui.CONTENT_W, S.ui.CONTENT_H);
	b.Position = UDim2.fromOffset(8, 88);
	b.BackgroundTransparency = 1;
	b.ZIndex = 4;
	b.Parent = S.panel;
	for z, R in ipairs(L) do
		local V = Instance.new("ScrollingFrame");
		V.Size = UDim2.fromOffset(S.ui.CONTENT_W, S.ui.CONTENT_H);
		V.BackgroundTransparency = 1;
		V.BorderSizePixel = 0;
		V.ScrollBarThickness = 3;
		V.ScrollBarImageColor3 = guiAccent();
		V.ScrollingDirection = Enum.ScrollingDirection.Y;
		V.CanvasSize = UDim2.fromOffset(0, 5000);
		V.ElasticBehavior = Enum.ElasticBehavior.Never;
		V.Visible = R == "Main";
		V.ZIndex = 5;
		V.Parent = b;
		registerRepaint(function()
			if V and V.Parent then
				V.ScrollBarImageColor3 = guiAccent();
			end;
		end);
		S.ui.tabFrames[R] = V;
	end;
	S.ui.showTab = function(z)
			S.ui.activeTab = z;
			for R, V in pairs(S.ui.tabFrames) do
				V.Visible = R == z;
			end;
			repaintAll();
			if z == "Configs" and _G.__adRefreshConfigs then
				pcall(_G.__adRefreshConfigs);
			end;
		end;
	do
		local R = #L;
		local V = math.floor(((S.ui.CONTENT_W - 4)) / R);
		local w = 2;
		for R, K in ipairs(L) do
			local g = Instance.new("TextButton");
			g.Size = UDim2.fromOffset(V, 22);
			g.Position = UDim2.fromOffset(w, 2);
			g.BorderSizePixel = 0;
			g.Font = Enum.Font.GothamBold;
			g.TextSize = 8;
			g.Text = K;
			g.AutoButtonColor = false;
			g.ZIndex = 4;
			g.Parent = W;
			g.TextTruncate = Enum.TextTruncate.AtEnd;
			g.TextScaled = false;
			addCorner(g, 6);
			g.MouseButton1Click:Connect(function()
				playClick();
				S.ui.showTab(K);
			end);
			registerRepaint(function()
				local R = S.ui.activeTab == K;
				g.BackgroundColor3 = R and guiAccent() or z.off;
				g.BackgroundTransparency = R and 0 or 1;
				g.TextColor3 = R and Color3.new(1, 1, 1) or guiTextColor();
			end);
			w = w + V;
		end;
	end;
	repaintAll();
	S.ui.collapseBtn = D;
	S.ui.buildColorPicker();
end;
function S.ui.buildColorPicker()
	local z = S.ui.COL;
	local R = S.ui.PANEL_W;
	local V = S.ui.PANEL_H;
	local w = Instance.new("Frame");
	w.Size = UDim2.fromOffset(R, V);
	w.Position = UDim2.fromOffset(0, 0);
	w.BackgroundColor3 = z.bg;
	w.BackgroundTransparency = .02;
	w.Visible = false;
	w.ZIndex = 60;
	w.Parent = S.panel;
	addCorner(w, 14);
	addGrad(w, z.bg2, z.bg, 90);
	S.ui.pickerOverlay = w;
	local K = Instance.new("TextLabel");
	K.Size = UDim2.new(1, -40, 0, 22);
	K.Position = UDim2.fromOffset(14, 14);
	K.BackgroundTransparency = 1;
	K.Font = Enum.Font.GothamBlack;
	K.TextSize = 14;
	K.TextXAlignment = Enum.TextXAlignment.Left;
	K.TextColor3 = guiAccent();
	K.Text = "COLOR PICKER";
	K.ZIndex = 61;
	K.Parent = w;
	registerRepaint(function()
		K.TextColor3 = guiAccent();
	end);
	local g = Instance.new("TextButton");
	g.Size = UDim2.fromOffset(60, 24);
	g.Position = UDim2.new(1, -74, 0, 12);
	g.BackgroundColor3 = z.card;
	g.BorderSizePixel = 0;
	g.Font = Enum.Font.GothamBold;
	g.TextSize = 11;
	g.TextColor3 = guiTextColor();
	g.Text = "X close";
	g.ZIndex = 61;
	g.Parent = w;
	registerRepaint(function()
		g.TextColor3 = guiTextColor();
	end);
	addCorner(g, 6);
	local l = addStroke(g, guiAccent(), 1, .5);
	registerRepaint(function()
		l.Color = guiAccent();
	end);
	local Z = Instance.new("Frame");
	Z.Size = UDim2.fromOffset(150, 120);
	Z.Position = UDim2.new(.5, -75, 0, 40);
	Z.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Z.BorderSizePixel = 0;
	Z.ZIndex = 61;
	Z.Parent = w;
	addCorner(Z, 12);
	local Y = addStroke(Z, guiAccent(), 2, 0);
	registerRepaint(function()
		Y.Color = guiAccent();
	end);
	local p = Instance.new("TextLabel");
	p.Size = UDim2.new(1, 0, 0, 18);
	p.Position = UDim2.new(0, 0, 1, -22);
	p.BackgroundTransparency = 1;
	p.Font = Enum.Font.Code;
	p.TextSize = 11;
	p.TextColor3 = Color3.fromRGB(255, 255, 255);
	p.TextStrokeTransparency = .4;
	p.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
	p.Text = "#FFFFFF";
	p.ZIndex = 62;
	p.Parent = Z;
	local D = {
			R = 255,
			G = 255,
			B = 255,
			bright = 1,
			callback = nil,
		};
	local function a(z)
		return math.clamp(math.floor(z * D.bright + .5), 0, 255);
	end;
	local function E()
		local z = a(D.R);
		local R = a(D.G);
		local V = a(D.B);
		Z.BackgroundColor3 = Color3.fromRGB(z, R, V);
		p.Text = string.format("RGB %d,%d,%d  x%.2f", z, R, V, D.bright);
	end;
	local function e(R, V, K, g, l, Z)
		local Y = Instance.new("Frame");
		Y.Size = UDim2.new(1, -28, 0, 46);
		Y.Position = UDim2.fromOffset(14, R);
		Y.BackgroundTransparency = 1;
		Y.ZIndex = 61;
		Y.Parent = w;
		local p = Instance.new("TextLabel");
		p.Size = UDim2.new(1, -60, 0, 16);
		p.BackgroundTransparency = 1;
		p.Font = Enum.Font.GothamBold;
		p.TextSize = 11;
		p.TextXAlignment = Enum.TextXAlignment.Left;
		p.TextColor3 = guiTextColor();
		p.Text = V;
		p.ZIndex = 62;
		p.Parent = Y;
		local a = Instance.new("TextLabel");
		a.Size = UDim2.fromOffset(60, 16);
		a.Position = UDim2.new(1, -60, 0, 0);
		a.BackgroundTransparency = 1;
		a.Font = Enum.Font.Code;
		a.TextSize = 11;
		a.TextXAlignment = Enum.TextXAlignment.Right;
		a.TextColor3 = guiTextColor();
		a.Text = "255";
		a.ZIndex = 62;
		a.Parent = Y;
		local e = Instance.new("TextButton");
		e.Size = UDim2.new(1, 0, 0, 18);
		e.Position = UDim2.fromOffset(0, 20);
		e.BackgroundColor3 = z.card;
		e.BorderSizePixel = 0;
		e.Text = "";
		e.AutoButtonColor = false;
		e.ZIndex = 62;
		e.Parent = Y;
		addCorner(e, 6);
		local I = Instance.new("Frame");
		I.Size = UDim2.new(1, 0, 1, 0);
		I.BorderSizePixel = 0;
		I.ZIndex = 63;
		I.Parent = e;
		addCorner(I, 6);
		I.BackgroundColor3 = g;
		local U = Instance.new("Frame");
		U.Size = UDim2.fromOffset(14, 14);
		U.BackgroundColor3 = Color3.new(1, 1, 1);
		U.BorderSizePixel = 0;
		U.ZIndex = 64;
		U.Parent = e;
		addCorner(U, 7);
		addStroke(U, Color3.new(0, 0, 0), 1, .4);
		local W = false;
		local function L()
			local z = D[K];
			local R = ((z - l)) / ((Z - l));
			U.Position = UDim2.new(R, -7, .5, -7);
			if Z <= 3 then
				a.Text = string.format("%.2f", z);
			else
				a.Text = tostring(math.floor(z + .5));
			end;
		end;
		L();
		local function b(z)
			local R = math.clamp(((z - e.AbsolutePosition.X)) / math.max(e.AbsoluteSize.X, 1), 0, 1);
			local V = l + R * ((Z - l));
			if Z <= 3 then
				D[K] = math.floor(V * 100 + .5) / 100;
			else
				D[K] = math.floor(V + .5);
			end;
			L();
			E();
		end;
		e.InputBegan:Connect(function(z)
			if z.UserInputType == Enum.UserInputType.MouseButton1 or z.UserInputType == Enum.UserInputType.Touch then
				W = true;
				b(z.Position.X);
			end;
		end);
		track(UIS.InputEnded:Connect(function(z)
			if z.UserInputType == Enum.UserInputType.MouseButton1 or z.UserInputType == Enum.UserInputType.Touch then
				W = false;
			end;
		end));
		track(UIS.InputChanged:Connect(function(z)
			if W and ((z.UserInputType == Enum.UserInputType.MouseMovement or z.UserInputType == Enum.UserInputType.Touch)) then
				b(z.Position.X);
			end;
		end));
		return L;
	end;
	local I = e(175, "Red", "R", Color3.fromRGB(255, 60, 60), 0, 255);
	local U = e(228, "Green", "G", Color3.fromRGB(80, 255, 100), 0, 255);
	local W = e(281, "Blue", "B", Color3.fromRGB(80, 140, 255), 0, 255);
	local L = e(334, "Brightness x", "bright", Color3.fromRGB(255, 255, 255), 0, 2);
	local b = Instance.new("TextButton");
	b.Size = UDim2.fromOffset(140, 34);
	b.Position = UDim2.new(0, 14, 0, 400);
	b.BackgroundColor3 = guiAccent();
	b.BorderSizePixel = 0;
	b.Font = Enum.Font.GothamBlack;
	b.TextSize = 13;
	b.TextColor3 = Color3.fromRGB(255, 255, 255);
	b.Text = "APPLY";
	b.ZIndex = 61;
	b.Parent = w;
	addCorner(b, 8);
	registerRepaint(function()
		b.BackgroundColor3 = guiAccent();
	end);
	local t = Instance.new("TextButton");
	t.Size = UDim2.fromOffset(140, 34);
	t.Position = UDim2.new(1, -154, 0, 400);
	t.BackgroundColor3 = z.card;
	t.BorderSizePixel = 0;
	t.Font = Enum.Font.GothamBold;
	t.TextSize = 13;
	t.TextColor3 = guiTextColor();
	t.Text = "Cancel";
	t.ZIndex = 61;
	t.Parent = w;
	addCorner(t, 8);
	local F = addStroke(t, guiAccent(), 1, .5);
	registerRepaint(function()
		F.Color = guiAccent();
	end);
	local function T()
		w.Visible = false;
		D.callback = nil;
	end;
	g.MouseButton1Click:Connect(function()
		playClick();
		T();
	end);
	t.MouseButton1Click:Connect(function()
		playClick();
		T();
	end);
	b.MouseButton1Click:Connect(function()
		playClick();
		if D.callback then
			local z = a(D.R);
			local R = a(D.G);
			local V = a(D.B);
			pcall(D.callback, Color3.fromRGB(z, R, V));
		end;
		T();
	end);
	S.colorPickerOpen = function(z, R)
			D.R = math.floor(z.R * 255 + .5);
			D.G = math.floor(z.G * 255 + .5);
			D.B = math.floor(z.B * 255 + .5);
			D.bright = 1;
			D.callback = R;
			I();
			U();
			W();
			L();
			E();
			w.Visible = true;
		end;
	E();
end;
function S.ui.buildMain()
	local z = S.ui.tabFrames.Main;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	local K = S.ui.makeInput;
	local g = S.ui.colorRow;
	R(z, 0, "Auto Dodge");
	V(z, 22, "Ultra Instinct", "Enabled", nil, nil, C);
	w(z, 52, "Radius (studs)", "Distance", 1, 95, 1, C, function()
		if C.RadiusVis or H.RadiusVis then
			makeViz();
		end;
	end);
	w(z, 96, "Delay (s)", "Delay", 0, .25, .01, C);
	w(z, 140, "Min interval (s)", "MinInterval", .02, 1, .01, C);
	w(z, 184, "Anim watch min (s)", "AnimWatch", .05, 2, .05, C);
	w(z, 228, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, C);
	R(z, 274, "Radius visualizer");
	V(z, 296, "Show radius", "RadiusVis", nil, nil, C);
	w(z, 326, "Visibility", "RadiusTransparency", .15, .95, .05, C, function()
		if C.RadiusVis or H.RadiusVis then
			makeViz();
		end;
	end);
	g(z, 370, "Radius color", uiRadiusColor, function(z)
		C.RadiusR = math.floor(z.R * 255 + .5);
		C.RadiusG = math.floor(z.G * 255 + .5);
		C.RadiusB = math.floor(z.B * 255 + .5);
		if C.RadiusVis then
			makeViz();
		end;
	end);
	R(z, 410, "Slot (optional)");
	local l = K(z, 430, "auto = leave empty");
	l.Text = C.ManualUISlot or "";
	(l:GetPropertyChangedSignal("Text")):Connect(function()
		if S.unloaded then
			return;
		end;
		C.ManualUISlot = string.upper(l.Text or "");
	end);
end;
function S.ui.buildHnS()
	local z = S.ui.tabFrames.HnS;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	local K = S.ui.makeInput;
	local g = S.ui.colorRow;
	R(z, 0, "HnS Dodge");
	V(z, 22, "HnS Dodge", "Enabled", nil, nil, H);
	V(z, 52, "Strict mode", "HollyMode", nil, nil, H);
	w(z, 82, "Radius (studs)", "Distance", 1, 95, 1, H, function()
		if C.RadiusVis or H.RadiusVis then
			makeViz();
		end;
	end);
	w(z, 126, "Delay (s)", "Delay", 0, .25, .01, H);
	w(z, 170, "Min interval (s)", "MinInterval", .02, 1, .01, H);
	w(z, 214, "Anim watch min (s)", "AnimWatch", .05, 2, .05, H);
	w(z, 258, "Watch after anim (s)", "WatchAfter", 0, 1.5, .05, H);
	R(z, 304, "Radius visualizer");
	V(z, 326, "Show radius", "RadiusVis", nil, nil, H);
	w(z, 356, "Visibility", "RadiusTransparency", .15, .95, .05, H, function()
		if C.RadiusVis or H.RadiusVis then
			makeViz();
		end;
	end);
	g(z, 400, "HnS color", hnsRadiusColor, function(z)
		H.RadiusR = math.floor(z.R * 255 + .5);
		H.RadiusG = math.floor(z.G * 255 + .5);
		H.RadiusB = math.floor(z.B * 255 + .5);
		if H.RadiusVis then
			makeViz();
		end;
	end);
	R(z, 440, "Slot (optional)");
	local l = K(z, 460, "auto = leave empty");
	l.Text = C.ManualHnSSlot or "";
	(l:GetPropertyChangedSignal("Text")):Connect(function()
		if S.unloaded then
			return;
		end;
		C.ManualHnSSlot = string.upper(l.Text or "");
	end);
end;
function S.ui.buildRebel()
	local z = S.ui.tabFrames.Rebel;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	local K = S.ui.makeBtn;
	local g = S.ui.makeInput;
	local l = S.ui.colorRow;
	R(z, 0, "Silent Aim");
	V(z, 22, "Silent Aim", "RebelSilentAim", nil, function(z)
		C.RebelSilentAim = z;
		if z then
			hookCombat();
		end;
	end, C);
	V(z, 52, "FOV Circle", "RebelFOVCircle", nil, function(z)
		C.RebelFOVCircle = z;
		makeFOVCircle();
	end, C);
	V(z, 82, "Neon glow", "RebelFOVNeon", nil, function(z)
		C.RebelFOVNeon = z;
		makeFOVCircle();
	end, C);
	V(z, 112, "Black outline", "RebelFOVBlackOutline", nil, function(z)
		C.RebelFOVBlackOutline = z;
		makeFOVCircle();
	end, C);
	w(z, 144, "Outline thickness", "RebelFOV_OutlineThickness", 1, 20, 1, C, refreshFOVCircle);
	l(z, 188, "Outline color", rebelOutlineColor, function(z)
		C.RebelFOV_OutlineR = math.floor(z.R * 255 + .5);
		C.RebelFOV_OutlineG = math.floor(z.G * 255 + .5);
		C.RebelFOV_OutlineB = math.floor(z.B * 255 + .5);
		C.FOVRainbow = false;
		stopFovRainbow();
		makeFOVCircle();
	end);
	w(z, 230, "FOV radius (px)", "RebelFOV", 10, 1200, 5, C, refreshFOVCircle);
	w(z, 274, "Circle line width", "RebelFOVCircleWidth", .5, 15, .1, C, refreshFOVCircle);
	l(z, 318, "FOV color", rebelFOVColor, function(z)
		C.RebelFOVR = math.floor(z.R * 255 + .5);
		C.RebelFOVG = math.floor(z.G * 255 + .5);
		C.RebelFOVB = math.floor(z.B * 255 + .5);
		C.FOVUseCustom = false;
		C.FOVRainbow = false;
		stopFovRainbow();
		makeFOVCircle();
	end);
	R(z, 358, "FOV Rainbow (6 modes)");
	local Z = V(z, 380, "Rainbow FOV", "FOVRainbow", nil, function(z)
			if z then
				startFovRainbow();
			else
				stopFovRainbow();
				makeFOVCircle();
			end;
		end, C);
	S.ui.fovRainbowPaint = Z;
	w(z, 410, "Blend speed", "RebelFOVBlendSpeed", .1, 3, .05, C);
	local function Y(z)
		C.FOVRainbowMode = z;
		C.FOVRainbow = true;
		if S.ui.fovRainbowPaint then
			pcall(S.ui.fovRainbowPaint);
		end;
		makeFOVCircle();
		startFovRainbow();
	end;
	K(z, 454, "Mode 1: Cycle hue", function()
		Y(1);
	end);
	K(z, 486, "Mode 2: Wave", function()
		Y(2);
	end);
	K(z, 518, "Mode 3: Gradient blend", function()
		Y(3);
	end);
	K(z, 550, "Mode 4: Breathing pulse", function()
		Y(4);
	end);
	K(z, 582, "Mode 5: Aurora", function()
		Y(5);
	end);
	K(z, 614, "Mode 6: FUSION", function()
		Y(6);
	end);
	R(z, 656, "Custom FOV colors (1-9)");
	V(z, 678, "Use custom color", "FOVUseCustom", nil, function(z)
		makeFOVCircle();
		if C.FOVRainbow then
			startFovRainbow();
		end;
	end, C);
	local function p(z)
		return function()
			local R, V, w = 60, 60, 255;
			if z == 1 then
				R, V, w = C.FOVCustomR1 or 255, C.FOVCustomG1 or 60, C.FOVCustomB1 or 60;
			elseif z == 2 then
				R, V, w = C.FOVCustomR2 or 60, C.FOVCustomG2 or 255, C.FOVCustomB2 or 60;
			elseif z == 3 then
				R, V, w = C.FOVCustomR3 or 60, C.FOVCustomG3 or 140, C.FOVCustomB3 or 255;
			elseif z == 4 then
				R, V, w = C.FOVCustomR4 or 255, C.FOVCustomG4 or 255, C.FOVCustomB4 or 60;
			elseif z == 5 then
				R, V, w = C.FOVCustomR5 or 255, C.FOVCustomG5 or 60, C.FOVCustomB5 or 255;
			elseif z == 6 then
				R, V, w = C.FOVCustomR6 or 60, C.FOVCustomG6 or 255, C.FOVCustomB6 or 255;
			elseif z == 7 then
				R, V, w = C.FOVCustomR7 or 255, C.FOVCustomG7 or 180, C.FOVCustomB7 or 60;
			elseif z == 8 then
				R, V, w = C.FOVCustomR8 or 255, C.FOVCustomG8 or 255, C.FOVCustomB8 or 255;
			elseif z == 9 then
				R, V, w = C.FOVCustomR9 or 180, C.FOVCustomG9 or 60, C.FOVCustomB9 or 255;
			end;
			return Color3.fromRGB(R, V, w);
		end;
	end;
	local function D(z)
		return function(R)
			local V, w, K = math.floor(R.R * 255 + .5), math.floor(R.G * 255 + .5), math.floor(R.B * 255 + .5);
			if z == 1 then
				C.FOVCustomR1, C.FOVCustomG1, C.FOVCustomB1 = V, w, K;
			elseif z == 2 then
				C.FOVCustomR2, C.FOVCustomG2, C.FOVCustomB2 = V, w, K;
			elseif z == 3 then
				C.FOVCustomR3, C.FOVCustomG3, C.FOVCustomB3 = V, w, K;
			elseif z == 4 then
				C.FOVCustomR4, C.FOVCustomG4, C.FOVCustomB4 = V, w, K;
			elseif z == 5 then
				C.FOVCustomR5, C.FOVCustomG5, C.FOVCustomB5 = V, w, K;
			elseif z == 6 then
				C.FOVCustomR6, C.FOVCustomG6, C.FOVCustomB6 = V, w, K;
			elseif z == 7 then
				C.FOVCustomR7, C.FOVCustomG7, C.FOVCustomB7 = V, w, K;
			elseif z == 8 then
				C.FOVCustomR8, C.FOVCustomG8, C.FOVCustomB8 = V, w, K;
			elseif z == 9 then
				C.FOVCustomR9, C.FOVCustomG9, C.FOVCustomB9 = V, w, K;
			end;
			if C.FOVUseCustom then
				makeFOVCircle();
				if C.FOVRainbow then
					startFovRainbow();
				end;
			end;
		end;
	end;
	for R = 1, 9, 1 do
		local V = 710 + ((R - 1)) * 62;
		l(z, V, "Slot " .. R, p(R), D(R));
		K(z, V + 32, "Use slot " .. R, function()
			C.FOVCustomIdx = R;
			C.FOVUseCustom = true;
			makeFOVCircle();
			if C.FOVRainbow then
				startFovRainbow();
			end;
		end);
	end;
	R(z, 1278, "Target filter");
	V(z, 1300, "Target players", "RebelTargetPlayers", nil, nil, C);
	V(z, 1330, "Target game guards (NPC)", "RebelTargetNPCs", nil, nil, C);
	R(z, 1366, "Body parts (random)");
	V(z, 1388, "Head", "RebelBodyHead", nil, nil, C);
	V(z, 1418, "Torso", "RebelBodyTorso", nil, nil, C);
	V(z, 1448, "HumanoidRootPart", "RebelBodyHRP", nil, nil, C);
	V(z, 1478, "Left Arm", "RebelBodyLeftArm", nil, nil, C);
	V(z, 1508, "Right Arm", "RebelBodyRightArm", nil, nil, C);
	V(z, 1538, "Left Leg", "RebelBodyLeftLeg", nil, nil, C);
	V(z, 1568, "Right Leg", "RebelBodyRightLeg", nil, nil, C);
	R(z, 1604, "Gun mods");
	V(z, 1626, "No Recoil & Spread", "RebelNoRecoil", nil, function(z)
		C.RebelNoRecoil = z;
		if z then
			hookCombat();
		end;
	end, C);
	V(z, 1656, "Rapid Fire", "RebelRapidFire", nil, function(z)
		C.RebelRapidFire = z;
		if z then
			hookCombat();
		end;
	end, C);
	R(z, 1692, "Bullet tracer");
	V(z, 1714, "Enable Bullet Tracer", "BulletTracer", nil, nil, C);
	V(z, 1744, "Glow", "BulletTracerGlow", nil, nil, C);
	V(z, 1774, "White core", "BulletTracerWhiteCore", nil, nil, C);
	l(z, 1804, "Tracer color", function()
		return Color3.fromRGB(C.BulletTracerR, C.BulletTracerG, C.BulletTracerB);
	end, function(z)
		C.BulletTracerR = math.floor(z.R * 255 + .5);
		C.BulletTracerG = math.floor(z.G * 255 + .5);
		C.BulletTracerB = math.floor(z.B * 255 + .5);
	end);
	w(z, 1846, "Thickness", "BulletTracerThickness", .05, 1, .01, C);
	w(z, 1890, "Speed (studs/s)", "BulletTracerSpeed", 50, 5000, 50, C);
	w(z, 1934, "Lifetime (s)", "BulletTracerLifetime", .1, 5, .05, C);
	w(z, 1978, "Range (studs)", "BulletTracerRange", 50, 2000, 25, C);
	w(z, 2022, "Start offset", "BulletTracerStartOffset", 0, 5, .1, C);
	w(z, 2066, "End offset", "BulletTracerEndOffset", 0, 5, .1, C);
	w(z, 2110, "Opacity", "BulletTracerOpacity", 0, .5, .01, C);
	w(z, 2154, "Cooldown (s)", "BulletTracerCooldown", .01, .5, .01, C);
	local a = {
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
	K(z, 2198, "Fade: " .. a[C.BulletTracerFadeIdx or 1], function()
		C.BulletTracerFadeIdx = ((C.BulletTracerFadeIdx or 1)) + 1;
		if C.BulletTracerFadeIdx > #a then
			C.BulletTracerFadeIdx = 1;
		end;
	end);
	R(z, 2240, "Auto Brew (Soda Fountain)");
	V(z, 2262, "Auto brew + collect", "AutoBrew", nil, function(z)
		if z then
			startBrewLoop();
		else
			stopBrewLoop();
		end;
	end, C);
	local E = g(z, 2292, "brew key (E)");
	E.Text = C.AutoBrewSlot or "E";
	(E:GetPropertyChangedSignal("Text")):Connect(function()
		if S.unloaded then
			return;
		end;
		local z = string.upper(E.Text or "E");
		if z == "" then
			z = "E";
		end;
		C.AutoBrewSlot = z;
	end);
	w(z, 2324, "Brew cooldown (s)", "AutoBrewInterval", 5, 300, 5, C);
	w(z, 2368, "Delay collect after brew (s)", "AutoBrewDelayCollect", 0, 10, .1, C);
	w(z, 2412, "Collect hold (s)", "AutoBrewCollectHold", .5, 5, .1, C);
end;
function S.ui.buildRLGL()
	local z = S.ui.tabFrames.RLGL;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	R(z, 0, "RLGL Auto Dodge");
	V(z, 22, "RLGL Auto Dodge", "RLGL_AutoDodge");
	V(z, 52, "Only on red light", "RLGL_OnlyRedLight");
	V(z, 82, "Auto-dodge after timer 0", "RLGL_TimerEndDodge");
	R(z, 118, "Red light tuning");
	w(z, 140, "Delay after red (s)", "RLGL_RedDelay", .05, 2, .05, C);
	w(z, 184, "Interval (s)", "RLGL_MinInterval", .05, 2, .05, C);
	w(z, 228, "Velocity threshold", "RLGL_VelThreshold", .1, 8, .1, C);
	R(z, 274, "Timer-end tuning");
	w(z, 296, "Delay after 0 (s)", "RLGL_TimerEndDelay", 0, 3, .05, C);
	w(z, 340, "Interval between (s)", "RLGL_TimerEndInterval", .05, 2, .05, C);
	w(z, 384, "Max duration (s)", "RLGL_TimerEndMaxDuration", 3, 30, 1, C);
end;
function S.ui.buildESP()
	local V = S.ui.tabFrames.ESP;
	local w = S.ui.mkDivider;
	local K = S.ui.makeToggle;
	local g = S.ui.makeSlider;
	local l = S.ui.makeBtn;
	local Z = S.ui.makeInput;
	local Y = S.ui.colorRow;
	w(V, 0, "Playable Guard ESP");
	K(V, 22, "Playable Guard ESP", "GuardESP");
	K(V, 52, "Show HP bar", "GuardESP_HP");
	K(V, 82, "Show Name", "GuardESP_Name");
	K(V, 112, "Show Highlight (chams)", "GuardESP_Highlight");
	K(V, 142, "Show Tracer", "GuardESP_Tracer");
	K(V, 172, "Show Box (2D)", "GuardESP_Box");
	K(V, 202, "HP chip colored BG", "GuardESP_HP_ChipBg", nil, nil, C);
	K(V, 232, "Show Tool (under feet)", "GuardESP_Tool");
	K(V, 262, "Show Distance (right)", "GuardESP_Distance");
	K(V, 292, "Force ALL as Guard (debug)", "GuardESP_ForceAll");
	g(V, 322, "Name size", "GuardESP_NameSize", 8, 32, 1, C);
	g(V, 366, "Max distance (studs)", "GuardESP_MaxDist", 0, 1000, 10, C, D);
	g(V, 410, "Box thickness", "GuardESP_BoxThickness", 1, 6, .5, C);
	w(V, 454, "Guard accent color");
	Y(V, 476, "Guard accent", guardESPColor, function(z)
		C.GuardESP_ColorR = math.floor(z.R * 255 + .5);
		C.GuardESP_ColorG = math.floor(z.G * 255 + .5);
		C.GuardESP_ColorB = math.floor(z.B * 255 + .5);
		if C.GuardESP then
			D();
		end;
	end);
	Y(V, 508, "Guard tracer", guardTracerColor, function(z)
		C.GuardESP_TracerR = math.floor(z.R * 255 + .5);
		C.GuardESP_TracerG = math.floor(z.G * 255 + .5);
		C.GuardESP_TracerB = math.floor(z.B * 255 + .5);
	end);
	Y(V, 540, "Guard box", guardBoxColor, function(z)
		C.GuardESP_BoxR = math.floor(z.R * 255 + .5);
		C.GuardESP_BoxG = math.floor(z.G * 255 + .5);
		C.GuardESP_BoxB = math.floor(z.B * 255 + .5);
	end);
	w(V, 582, "Guard HP chip (4 states)");
	K(V, 604, "Black outline (chip + number)", "GuardESP_HP_Outline", nil, nil, C);
	Y(V, 636, "State 1 (>75%)", guardChipState1, function(z)
		C.GuardESP_HP_State1_R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_State1_G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_State1_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 668, "State 2 (50-75%)", guardChipState2, function(z)
		C.GuardESP_HP_State2_R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_State2_G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_State2_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 700, "State 3 (25-50%)", guardChipState3, function(z)
		C.GuardESP_HP_State3_R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_State3_G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_State3_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 732, "State 4 (<25%)", guardChipState4, function(z)
		C.GuardESP_HP_State4_R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_State4_G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_State4_B = math.floor(z.B * 255 + .5);
		D();
	end);
	w(V, 776, "Guard HP gradient (vertical bar)");
	local function p()
		return Color3.fromRGB(C.GuardESP_HP_TopR or 80, C.GuardESP_HP_TopG or 255, C.GuardESP_HP_TopB or 80);
	end;
	local function a()
		return Color3.fromRGB(C.GuardESP_HP_M1R or 180, C.GuardESP_HP_M1G or 255, C.GuardESP_HP_M1B or 60);
	end;
	local function E()
		return Color3.fromRGB(C.GuardESP_HP_M2R or 255, C.GuardESP_HP_M2G or 200, C.GuardESP_HP_M2B or 40);
	end;
	local function e()
		return Color3.fromRGB(C.GuardESP_HP_M3R or 255, C.GuardESP_HP_M3G or 120, C.GuardESP_HP_M3B or 60);
	end;
	local function I()
		return Color3.fromRGB(C.GuardESP_HP_BotR or 255, C.GuardESP_HP_BotG or 40, C.GuardESP_HP_BotB or 40);
	end;
	Y(V, 798, "Top", p, function(z)
		C.GuardESP_HP_TopR = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_TopG = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_TopB = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 830, "Mid1", a, function(z)
		C.GuardESP_HP_M1R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_M1G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_M1B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 862, "Mid2", E, function(z)
		C.GuardESP_HP_M2R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_M2G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_M2B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 894, "Mid3", e, function(z)
		C.GuardESP_HP_M3R = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_M3G = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_M3B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 926, "Bottom", I, function(z)
		C.GuardESP_HP_BotR = math.floor(z.R * 255 + .5);
		C.GuardESP_HP_BotG = math.floor(z.G * 255 + .5);
		C.GuardESP_HP_BotB = math.floor(z.B * 255 + .5);
		D();
	end);
	w(V, 970, "Player ESP");
	K(V, 992, "Player ESP", "PlayerESP");
	K(V, 1022, "Show HP bar", "PlayerESP_HP");
	K(V, 1052, "Show Name", "PlayerESP_Name");
	K(V, 1082, "Show Highlight (chams)", "PlayerESP_Highlight");
	K(V, 1112, "Show Tracer", "PlayerESP_Tracer");
	K(V, 1142, "Show Box (2D)", "PlayerESP_Box");
	K(V, 1172, "HP chip colored BG", "PlayerESP_HP_ChipBg", nil, nil, C);
	K(V, 1202, "Show Tool (under feet)", "PlayerESP_Tool");
	K(V, 1232, "Show Distance (right)", "PlayerESP_Distance");
	w(V, 1262, "Custom name");
	local U = Z(V, 1284, "custom name (empty = real)");
	U.Text = C.PlayerESP_CustomName or "";
	(U:GetPropertyChangedSignal("Text")):Connect(function()
		if S.unloaded then
			return;
		end;
		C.PlayerESP_CustomName = U.Text or "";
		D();
	end);
	K(V, 1318, "Rainbow name", "PlayerESP_NameRainbow", nil, nil, C);
	g(V, 1348, "Rainbow speed", "PlayerESP_NameRainbowSpeed", .1, 3, .05, C);
	g(V, 1392, "Name size", "PlayerESP_NameSize", 8, 32, 1, C);
	g(V, 1436, "Max distance (studs)", "PlayerESP_MaxDist", 0, 1000, 10, C, D);
	g(V, 1480, "Box thickness", "PlayerESP_BoxThickness", 1, 6, .5, C);
	w(V, 1524, "Player accent color");
	Y(V, 1546, "Player accent", playerESPColor, function(z)
		C.PlayerESP_ColorR = math.floor(z.R * 255 + .5);
		C.PlayerESP_ColorG = math.floor(z.G * 255 + .5);
		C.PlayerESP_ColorB = math.floor(z.B * 255 + .5);
		if C.PlayerESP then
			D();
		end;
	end);
	Y(V, 1578, "Player tracer", playerTracerColor, function(z)
		C.PlayerESP_TracerR = math.floor(z.R * 255 + .5);
		C.PlayerESP_TracerG = math.floor(z.G * 255 + .5);
		C.PlayerESP_TracerB = math.floor(z.B * 255 + .5);
	end);
	Y(V, 1610, "Player box", playerBoxColor, function(z)
		C.PlayerESP_BoxR = math.floor(z.R * 255 + .5);
		C.PlayerESP_BoxG = math.floor(z.G * 255 + .5);
		C.PlayerESP_BoxB = math.floor(z.B * 255 + .5);
	end);
	w(V, 1652, "Player HP chip (4 states)");
	K(V, 1674, "Black outline (chip + number)", "PlayerESP_HP_Outline", nil, nil, C);
	Y(V, 1706, "State 1 (>75%)", playerChipState1, function(z)
		C.PlayerESP_HP_State1_R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_State1_G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_State1_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1738, "State 2 (50-75%)", playerChipState2, function(z)
		C.PlayerESP_HP_State2_R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_State2_G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_State2_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1770, "State 3 (25-50%)", playerChipState3, function(z)
		C.PlayerESP_HP_State3_R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_State3_G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_State3_B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1802, "State 4 (<25%)", playerChipState4, function(z)
		C.PlayerESP_HP_State4_R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_State4_G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_State4_B = math.floor(z.B * 255 + .5);
		D();
	end);
	w(V, 1846, "Player HP gradient (vertical bar)");
	local function W()
		return Color3.fromRGB(C.PlayerESP_HP_TopR or 80, C.PlayerESP_HP_TopG or 255, C.PlayerESP_HP_TopB or 80);
	end;
	local function L()
		return Color3.fromRGB(C.PlayerESP_HP_M1R or 180, C.PlayerESP_HP_M1G or 255, C.PlayerESP_HP_M1B or 60);
	end;
	local function b()
		return Color3.fromRGB(C.PlayerESP_HP_M2R or 255, C.PlayerESP_HP_M2G or 200, C.PlayerESP_HP_M2B or 40);
	end;
	local function t()
		return Color3.fromRGB(C.PlayerESP_HP_M3R or 255, C.PlayerESP_HP_M3G or 120, C.PlayerESP_HP_M3B or 60);
	end;
	local function F()
		return Color3.fromRGB(C.PlayerESP_HP_BotR or 255, C.PlayerESP_HP_BotG or 40, C.PlayerESP_HP_BotB or 40);
	end;
	Y(V, 1868, "Top", W, function(z)
		C.PlayerESP_HP_TopR = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_TopG = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_TopB = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1900, "Mid1", L, function(z)
		C.PlayerESP_HP_M1R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_M1G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_M1B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1932, "Mid2", b, function(z)
		C.PlayerESP_HP_M2R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_M2G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_M2B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1964, "Mid3", t, function(z)
		C.PlayerESP_HP_M3R = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_M3G = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_M3B = math.floor(z.B * 255 + .5);
		D();
	end);
	Y(V, 1996, "Bottom", F, function(z)
		C.PlayerESP_HP_BotR = math.floor(z.R * 255 + .5);
		C.PlayerESP_HP_BotG = math.floor(z.G * 255 + .5);
		C.PlayerESP_HP_BotB = math.floor(z.B * 255 + .5);
		D();
	end);
	w(V, 2040, "HP bar size");
	g(V, 2062, "Guard bar thickness", "GuardESP_HPBarThickness", 2, 30, 1, C);
	g(V, 2106, "Guard bar length", "GuardESP_HPBarLength", .3, 3, .1, C);
	g(V, 2150, "Guard bar roundness", "GuardESP_HPBarRoundness", 0, 20, 1, C);
	g(V, 2194, "Player bar thickness", "PlayerESP_HPBarThickness", 2, 30, 1, C);
	g(V, 2238, "Player bar length", "PlayerESP_HPBarLength", .3, 3, .1, C);
	g(V, 2282, "Player bar roundness", "PlayerESP_HPBarRoundness", 0, 20, 1, C);
	w(V, 2326, "ESP text");
	local T;
	local function n()
		if T then
			T.Text = "Next font: " .. ((ESP_FONT_NAMES[C.ESP_FontIdx or 1] or "?"));
		end;
	end;
	T = l(V, 2348, "Next font: " .. ((ESP_FONT_NAMES[C.ESP_FontIdx or 1] or "?")), function()
			C.ESP_FontIdx = ((C.ESP_FontIdx or 1)) + 1;
			if C.ESP_FontIdx > #ESP_FONT_NAMES then
				C.ESP_FontIdx = 1;
			end;
			n();
			for z, R in pairs(z) do
				pcall(function()
					if R.nameL then
						R.nameL.Font = espFont();
					end;
					if R.toolL then
						R.toolL.Font = espFont();
					end;
				end);
			end;
			for z, R in pairs(R) do
				pcall(function()
					if R.nameL then
						R.nameL.Font = espFont();
					end;
					if R.toolL then
						R.toolL.Font = espFont();
					end;
				end);
			end;
		end);
	l(V, 2380, "Reset font (GothamBlack)", function()
		C.ESP_FontIdx = 1;
		n();
		for z, R in pairs(z) do
			pcall(function()
				if R.nameL then
					R.nameL.Font = Enum.Font.GothamBlack;
					R.nameL.TextSize = (C.GuardESP_NameSize or 17);
				end;
				if R.toolL then
					R.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		for z, R in pairs(R) do
			pcall(function()
				if R.nameL then
					R.nameL.Font = Enum.Font.GothamBlack;
					R.nameL.TextSize = (C.PlayerESP_NameSize or 17);
				end;
				if R.toolL then
					R.toolL.Font = Enum.Font.GothamBlack;
				end;
			end);
		end;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("font reset - GothamBlack");
		end;
	end);
end;
function S.ui.buildDalgona()
	local z = S.ui.tabFrames.Dalgona;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.BTN_W;
	local K = S.ui.COL;
	R(z, 0, "Cookie");
	V(z, 22, "One Click Complete", nil, function()
		return S.oneClickDalgona;
	end, function(z)
		a(z);
	end);
	local g = Instance.new("TextLabel");
	g.Size = UDim2.fromOffset(w, 70);
	g.Position = UDim2.fromOffset(4, 56);
	g.BackgroundTransparency = 1;
	g.Font = Enum.Font.Gotham;
	g.TextSize = 9;
	g.TextWrapped = true;
	g.TextXAlignment = Enum.TextXAlignment.Left;
	g.TextYAlignment = Enum.TextYAlignment.Top;
	g.TextColor3 = guiTextColor();
	g.Text = "Vklyuchi i vedi myshkoi po konturu pechenki.";
	g.ZIndex = 6;
	g.Parent = z;
	registerRepaint(function()
		g.TextColor3 = guiTextColor();
	end);
end;
function S.ui.buildExtra()
	local z = S.ui.tabFrames.Extra;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	local K = S.ui.makeBtn;
	R(z, 0, "Instant Interact");
	V(z, 22, "Enable Instant Interact", "InstantInteract");
	V(z, 52, "Insta mode (0ms)", "InstantInteractInsta");
	w(z, 82, "Custom speed x", "InstantInteractMult", .5, 50, .5, C);
	R(z, 128, "Hide overhead");
	V(z, 150, "Hide nickname", "HideNick", nil, function()
		i();
	end, C);
	R(z, 186, "Visual");
	V(z, 208, "Full Bright", "FullBright", nil, function(z)
		applyFullBright(z);
	end, C);
	V(z, 238, "Remove Fog", "RemoveFog", nil, function(z)
		applyRemoveFog(z);
	end, C);
	R(z, 274, "Overlay");
	V(z, 296, "Watermark", "Watermark", nil, function()
		updateInfoVisibility();
	end, C);
	V(z, 326, "Keybind list", "KeybindList", nil, function()
		updateInfoVisibility();
	end, C);
	R(z, 362, "Cosmetics");
	V(z, 384, "Headless", "Headless");
	V(z, 414, "Korblox Left Leg", "Korblox");
	V(z, 444, "Remove Legs", "RemoveLegs");
	V(z, 474, "Remove Hands", "RemoveHands");
	V(z, 504, "Remove Torso (client)", "RemoveTorso");
	R(z, 544, "Animation Speed");
	V(z, 566, "Speed 2.5x", "AnimSpeed");
	K(z, 598, "Reset anim speed", function()
		local z = LP.Character;
		local R = z and z:FindFirstChildOfClass("Humanoid");
		local V = R and R:FindFirstChildOfClass("Animator");
		if V then
			for z, R in ipairs(V:GetPlayingAnimationTracks()) do
				pcall(function()
					R:AdjustSpeed(1);
				end);
			end;
		end;
	end);
	R(z, 636, "Extra");
	K(z, 658, "Open Infinite Yield", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local z, R = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-95978")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(z and "Infinite Yield loaded" or ("IY fail: " .. tostring(R)));
		end;
	end);
	K(z, 690, "Jerk off", function()
		if not loadstring or not game.HttpGet then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no loadstring/HttpGet");
			end;
			return;
		end;
		local z, R = pcall(function()
				(loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jerk-off-script-OG-245780")))();
			end);
		if _G.__ad_statusCb then
			_G.__ad_statusCb(z and "Jerk off loaded" or ("fail: " .. tostring(R)));
		end;
	end);
end;
function S.ui.buildConfigs()
	local z = S.ui.tabFrames.Configs;
	local R = S.ui.mkDivider;
	local V = S.ui.makeToggle;
	local w = S.ui.makeSlider;
	local K = S.ui.makeBtn;
	local g = S.ui.makeInput;
	local l = S.ui.colorRow;
	local Z = S.ui.COL;
	R(z, 0, "Config");
	local Y;
	local p = g(z, 22, "config name");
	p.Text = S.currentConfigName;
	K(z, 54, "Save", function()
		local z = p.Text;
		if z == "" then
			z = "default";
		end;
		local R, V = N(z);
		if R then
			p.Text = S.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved - " .. S.currentConfigName);
			end;
			task.defer(function()
				if Y then
					Y();
				end;
			end);
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("save fail - " .. tostring(V));
			end;
		end;
	end);
	K(z, 86, "Load", function()
		local z = p.Text;
		if z == "" then
			z = "default";
		end;
		local R, V = x(z);
		if R then
			p.Text = S.currentConfigName;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("loaded - " .. S.currentConfigName);
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("load fail - " .. tostring(V));
			end;
		end;
	end);
	R(z, 124, "Menu animation");
	w(z, 146, "Open/close speed", "MenuAnimSpeed", .1, 1.5, .05, C);
	w(z, 190, "Collapse anim speed", "MenuDodgeAnimSpeed", .1, 2, .05, C);
	R(z, 236, "Circle menu button");
	w(z, 258, "Circle size", "CircleSize", 32, 120, 2, C);
	l(z, 300, "Circle text color", circleTextColor, function(z)
		C.CircleTextR = math.floor(z.R * 255 + .5);
		C.CircleTextG = math.floor(z.G * 255 + .5);
		C.CircleTextB = math.floor(z.B * 255 + .5);
		repaintAll();
	end);
	V(z, 334, "Rainbow text color", "CircleRainbowText", nil, function()
		repaintAll();
	end, C);
	V(z, 364, "Rainbow outline", "CircleRainbowOutline", nil, function()
		repaintAll();
	end, C);
	R(z, 400, "Text color (all GUI)");
	l(z, 422, "Text color", guiTextColor, function(z)
		C.GuiTextR = math.floor(z.R * 255 + .5);
		C.GuiTextG = math.floor(z.G * 255 + .5);
		C.GuiTextB = math.floor(z.B * 255 + .5);
		repaintAll();
	end);
	R(z, 462, "Panel border");
	V(z, 484, "Rainbow panel border", "PanelRainbow", nil, function(z)
		if z then
			startPanelRainbow();
		else
			stopPanelRainbow();
			if S.panel then
				local z = S.panel:FindFirstChildOfClass("UIStroke");
				if z then
					z.Color = guiAccent();
				end;
			end;
		end;
	end, C);
	R(z, 520, "Accent color");
	l(z, 542, "GUI accent", guiAccent, function(z)
		C.GuiR = math.floor(z.R * 255 + .5);
		C.GuiG = math.floor(z.G * 255 + .5);
		C.GuiB = math.floor(z.B * 255 + .5);
		repaintAll();
	end);
	w(z, 584, "R", "GuiR", 0, 255, 1, C, repaintAll);
	w(z, 628, "G", "GuiG", 0, 255, 1, C, repaintAll);
	w(z, 672, "B", "GuiB", 0, 255, 1, C, repaintAll);
	R(z, 716, "Saved");
	local D = Instance.new("ScrollingFrame");
	D.Size = UDim2.new(1, -8, 0, 90);
	D.Position = UDim2.fromOffset(4, 736);
	D.BackgroundColor3 = Z.card;
	D.BorderSizePixel = 0;
	D.ScrollBarThickness = 3;
	D.CanvasSize = UDim2.fromOffset(0, 0);
	D.ZIndex = 6;
	D.Parent = z;
	addCorner(D, 7);
	local a = Instance.new("TextLabel");
	a.Size = UDim2.new(1, -8, 0, 20);
	a.Position = UDim2.fromOffset(4, 6);
	a.BackgroundTransparency = 1;
	a.Font = Enum.Font.Gotham;
	a.TextSize = 11;
	a.TextColor3 = guiTextColor();
	a.TextXAlignment = Enum.TextXAlignment.Left;
	a.Text = "no configs saved yet";
	a.ZIndex = 7;
	a.Parent = D;
	registerRepaint(function()
		a.TextColor3 = guiTextColor();
	end);
	Y = function()
			if S.unloaded or not D or not D.Parent then
				return;
			end;
			for z, R in ipairs(D:GetChildren()) do
				if R:IsA("TextButton") then
					R:Destroy();
				end;
			end;
			local z = B();
			D.CanvasSize = UDim2.fromOffset(0, math.max(#z * 26 + 8, 26));
			a.Visible = (#z == 0);
			for z, R in ipairs(z) do
				local V = Instance.new("TextButton");
				V.Size = UDim2.new(1, -8, 0, 22);
				V.Position = UDim2.fromOffset(4, ((z - 1)) * 26 + 4);
				V.BackgroundColor3 = Z.off;
				V.BorderSizePixel = 0;
				V.Font = Enum.Font.Gotham;
				V.TextSize = 12;
				V.TextColor3 = guiTextColor();
				V.Text = "  " .. R;
				V.TextXAlignment = Enum.TextXAlignment.Left;
				V.ZIndex = 7;
				V.Parent = D;
				addCorner(V, 5);
				registerRepaint(function()
					V.TextColor3 = guiTextColor();
				end);
				V.MouseButton1Click:Connect(function()
					playClick();
					p.Text = R;
					local z = x(R);
					if _G.__ad_statusCb then
						_G.__ad_statusCb(z and ("loaded - " .. R) or "load failed");
					end;
				end);
				local w = Instance.new("TextButton");
				w.Size = UDim2.fromOffset(20, 18);
				w.Position = UDim2.new(1, -24, .5, -9);
				w.BackgroundColor3 = Color3.fromRGB(120, 30, 30);
				w.BorderSizePixel = 0;
				w.Font = Enum.Font.GothamBold;
				w.TextSize = 11;
				w.TextColor3 = Color3.new(1, 1, 1);
				w.Text = "x";
				w.ZIndex = 8;
				w.Parent = V;
				addCorner(w, 4);
				w.MouseButton1Click:Connect(function()
					if S.unloaded then
						return;
					end;
					playClick();
					local z, V = o(R);
					if z then
						if _G.__ad_statusCb then
							_G.__ad_statusCb("deleted - " .. R);
						end;
						task.defer(function()
							if Y then
								Y();
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
	Y();
	_G.__adRefreshConfigs = Y;
	K(z, 834, "Refresh List", function()
		Y();
	end);
	K(z, 868, "Set Menu Key", function()
		S.bindingMenuKey = true;
		if _G.__ad_statusCb then
			_G.__ad_statusCb("press a key...");
		end;
		local z;
		z = UIS.InputBegan:Connect(function(R)
				if R.UserInputType ~= Enum.UserInputType.Keyboard then
					return;
				end;
				C.MenuKey = R.KeyCode;
				if _G.__ad_statusCb then
					_G.__ad_statusCb("menu key = " .. R.KeyCode.Name);
				end;
				task.defer(function()
					S.bindingMenuKey = false;
				end);
				if z then
					z:Disconnect();
				end;
				if S.rebindMenu then
					S.rebindMenu();
				end;
			end);
	end);
	K(z, 902, "FULL UNLOAD", function()
		if S.doFullUnload then
			pcall(S.doFullUnload);
		end;
	end);
	R(z, 940, "Share config (JSON / TXT)");
	local E = g(z, 962, "paste JSON here to import");
	E.Text = "";
	K(z, 994, "Export (copy JSON to clipboard)", function()
		local z = { C = s(C), H = s(H), anim = S.animEnabled };
		local R = HttpService:JSONEncode(z);
		local V = false;
		if setclipboard then
			pcall(function()
				setclipboard(R);
				V = true;
			end);
		end;
		if V then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("copied (" .. (#R .. " chars) - send to friend"));
			end;
		else
			E.Text = R;
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no setclipboard - JSON in box, copy manually");
			end;
		end;
	end);
	K(z, 1026, "Export to file (XD_config.txt)", function()
		if not S.FILE.writefile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no writefile in executor");
			end;
			return;
		end;
		local z = { C = s(C), H = s(H), anim = S.animEnabled };
		local R = HttpService:JSONEncode(z);
		local V = pcall(function()
				S.FILE.writefile("XD_config.txt", R);
			end);
		if V then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("saved XD_config.txt (" .. (#R .. ")"));
			end;
		else
			if _G.__ad_statusCb then
				_G.__ad_statusCb("writefile failed");
			end;
		end;
	end);
	K(z, 1058, "Load from file (XD_config.txt)", function()
		if not S.FILE.readfile or not S.FILE.isfile then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("no readfile");
			end;
			return;
		end;
		local z, R = pcall(S.FILE.isfile, "XD_config.txt");
		if not z or not R then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("XD_config.txt not found");
			end;
			return;
		end;
		local V, w = pcall(S.FILE.readfile, "XD_config.txt");
		if not V or not w then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("read failed");
			end;
			return;
		end;
		local K, g = pcall(function()
				return HttpService:JSONDecode(w);
			end);
		if not K or type(g) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in file");
			end;
			return;
		end;
		y(g);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("loaded from XD_config.txt");
		end;
	end);
	K(z, 1090, "Import from clipboard", function()
		local z = "";
		if getclipboard then
			pcall(function()
				z = getclipboard();
			end);
		end;
		if not z or z == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("clipboard empty or no getclipboard");
			end;
			return;
		end;
		local R, V = pcall(function()
				return HttpService:JSONDecode(z);
			end);
		if not R or type(V) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json in clipboard");
			end;
			return;
		end;
		y(V);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from clipboard");
		end;
	end);
	K(z, 1122, "Import from box above", function()
		local z = E.Text or "";
		if z == "" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("box empty");
			end;
			return;
		end;
		local R, V = pcall(function()
				return HttpService:JSONDecode(z);
			end);
		if not R or type(V) ~= "table" then
			if _G.__ad_statusCb then
				_G.__ad_statusCb("bad json");
			end;
			return;
		end;
		y(V);
		if _G.__ad_statusCb then
			_G.__ad_statusCb("imported from box");
		end;
	end);
	R(z, 1158, "Circle rainbow glow");
	w(z, 1180, "Glow speed", "CircleRainbowSpeed", .1, 5, .1, C);
end;
function S.ui.buildCollapseCircle()
	local z = S.ui.PANEL_W;
	local R = S.ui.PANEL_H;
	local V = Instance.new("TextButton");
	V.AnchorPoint = Vector2.new(1, 0);
	V.Position = UDim2.new(1, -16, 0, 90);
	V.Size = UDim2.fromOffset(0, 0);
	V.BackgroundColor3 = guiAccent();
	V.BorderSizePixel = 0;
	V.Text = "";
	V.AutoButtonColor = false;
	V.Visible = false;
	V.ZIndex = 50;
	V.Parent = S.gui;
	addCorner(V, 32);
	local w = addStroke(V, Color3.fromRGB(0, 0, 0), 3, 0);
	registerRepaint(function()
		V.BackgroundColor3 = guiAccent();
	end);
	S.ui.expandCircle = V;
	local K = false;
	local g = false;
	local l = nil;
	local Z = nil;
	V.InputBegan:Connect(function(z)
		if z.UserInputType == Enum.UserInputType.MouseButton1 or z.UserInputType == Enum.UserInputType.Touch then
			K = true;
			g = false;
			l = z.Position;
			Z = V.Position;
			z.Changed:Connect(function()
				if z.UserInputState == Enum.UserInputState.End then
					K = false;
				end;
			end);
		end;
	end);
	track(UIS.InputChanged:Connect(function(z)
		if not K then
			return;
		end;
		if z.UserInputType == Enum.UserInputType.MouseMovement or z.UserInputType == Enum.UserInputType.Touch then
			local R = z.Position - l;
			if math.abs(R.X) > 3 or math.abs(R.Y) > 3 then
				g = true;
			end;
			V.Position = UDim2.new(Z.X.Scale, Z.X.Offset + R.X, Z.Y.Scale, Z.Y.Offset + R.Y);
		end;
	end));
	local Y = Instance.new("TextLabel");
	Y.AnchorPoint = Vector2.new(.5, .5);
	Y.Size = UDim2.fromScale(.55, .55);
	Y.Position = UDim2.fromScale(.34, .52);
	Y.BackgroundTransparency = 1;
	Y.Font = Enum.Font.GothamBlack;
	Y.TextSize = 26;
	Y.TextColor3 = circleTextColor();
	Y.TextStrokeTransparency = 0;
	Y.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	Y.Text = "X";
	Y.Rotation = -8;
	Y.ZIndex = 52;
	Y.Parent = V;
	local p = Instance.new("TextLabel");
	p.AnchorPoint = Vector2.new(.5, .5);
	p.Size = UDim2.fromScale(.5, .55);
	p.Position = UDim2.fromScale(.68, .52);
	p.BackgroundTransparency = 1;
	p.Font = Enum.Font.GothamBlack;
	p.TextSize = 24;
	p.TextColor3 = circleTextColor();
	p.TextStrokeTransparency = 0;
	p.TextStrokeColor3 = Color3.fromRGB(255, 0, 0);
	p.Text = "D";
	p.Rotation = 6;
	p.ZIndex = 52;
	p.Parent = V;
	registerRepaint(function()
		w.Color = Color3.fromRGB(0, 0, 0);
		if not C.CircleRainbowOutline then
			Y.TextStrokeColor3 = circleTextColor();
			p.TextStrokeColor3 = circleTextColor();
		end;
		if not C.CircleRainbowText then
			Y.TextColor3 = circleTextColor();
			p.TextColor3 = circleTextColor();
		end;
	end);
	task.spawn(function()
		local z = 0;
		while S.running and not S.unloaded do
			if C.CircleRainbowOutline then
				local R = Color3.fromHSV(z, 1, 1);
				pcall(function()
					Y.TextStrokeColor3 = R;
					p.TextStrokeColor3 = R;
				end);
			end;
			if C.CircleRainbowText then
				local R = Color3.fromHSV(((z + .5)) % 1, 1, 1);
				pcall(function()
					Y.TextColor3 = R;
					p.TextColor3 = R;
				end);
			end;
			z = ((z + .008 * ((C.CircleRainbowSpeed or 1)))) % 1;
			RunService.RenderStepped:Wait();
		end;
	end);
	local D = false;
	local function a(w)
		if S.unloaded or not S.panel or not S.panel.Parent then
			return;
		end;
		w = w and true or false;
		if w == D then
			return;
		end;
		D = w;
		local K = tonumber(C.MenuAnimSpeed) or .35;
		local g = tonumber(C.MenuDodgeAnimSpeed) or .5;
		if w then
			local z = TweenInfo.new(K, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			(TweenService:Create(S.panel, z, { Position = UDim2.new(S.panel.Position.X.Scale, S.panel.Position.X.Offset - 800, S.panel.Position.Y.Scale, S.panel.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(TweenService:Create(S.shadow, z, { Position = UDim2.new(S.shadow.Position.X.Scale, S.shadow.Position.X.Offset - 800, S.shadow.Position.Y.Scale, S.shadow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			(TweenService:Create(S.glow, z, { Position = UDim2.new(S.glow.Position.X.Scale, S.glow.Position.X.Offset - 800, S.glow.Position.Y.Scale, S.glow.Position.Y.Offset), BackgroundTransparency = 1 })):Play();
			task.delay(K + .02, function()
				if S.unloaded or not D then
					return;
				end;
				S.panel.Visible = false;
				S.shadow.Visible = false;
				S.glow.Visible = false;
				S.panel.BackgroundTransparency = 0;
				S.shadow.BackgroundTransparency = .65;
				S.glow.BackgroundTransparency = .86;
				V.Visible = true;
				V.Size = UDim2.fromOffset(0, 0);
				local z = tonumber(C.CircleSize) or 64;
				(TweenService:Create(V, TweenInfo.new(g, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(z, z) })):Play();
			end);
		else
			V.Visible = false;
			V.Size = UDim2.fromOffset(0, 0);
			S.panel.Visible = true;
			S.shadow.Visible = true;
			S.glow.Visible = true;
			local w = -z / 2 - 800;
			local g = -R / 2;
			S.panel.Position = UDim2.new(.5, w, .5, g);
			S.shadow.Position = UDim2.new(.5, w + 6, .5, g + 6);
			S.glow.Position = UDim2.new(.5, w - 20, .5, g - 20);
			S.panel.BackgroundTransparency = 1;
			S.shadow.BackgroundTransparency = 1;
			S.glow.BackgroundTransparency = 1;
			local l = TweenInfo.new(K, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			(TweenService:Create(S.panel, l, { Position = UDim2.new(.5, -z / 2, .5, -R / 2), BackgroundTransparency = 0 })):Play();
			(TweenService:Create(S.shadow, l, { Position = UDim2.new(.5, -z / 2 + 6, .5, -R / 2 + 6), BackgroundTransparency = .65 })):Play();
			(TweenService:Create(S.glow, l, { Position = UDim2.new(.5, -z / 2 - 20, .5, -R / 2 - 20), BackgroundTransparency = .86 })):Play();
		end;
	end;
	_G.__adSetCollapsed = a;
	_G.__adIsCollapsed = function()
			return D;
		end;
	if S.ui.collapseBtn then
		S.ui.collapseBtn.MouseButton1Click:Connect(function()
			if S.unloaded then
				return;
			end;
			playClick();
			a(true);
		end);
	end;
	V.MouseButton1Click:Connect(function()
		if S.unloaded then
			return;
		end;
		if g then
			g = false;
			return;
		end;
		playClick();
		a(false);
	end);
end;
local function r(z, R)
	local V, w = pcall(R);
	if not V then
		print("[XD] BUILD ERROR in " .. (tostring(z) .. ":"), tostring(w));
		warn("[XD] BUILD ERROR in " .. (tostring(z) .. ":"), tostring(w));
	end;
end;
r("buildPanel", S.ui.buildPanel);
r("buildMain", S.ui.buildMain);
r("buildHnS", S.ui.buildHnS);
r("buildRebel", S.ui.buildRebel);
r("buildRLGL", S.ui.buildRLGL);
r("buildESP", S.ui.buildESP);
r("buildDalgona", S.ui.buildDalgona);
r("buildExtra", S.ui.buildExtra);
r("buildConfigs", S.ui.buildConfigs);
r("buildCollapseCircle", S.ui.buildCollapseCircle);
pcall(ensureInfoGui);
pcall(updateInfoVisibility);
pcall(i);
if C.PanelRainbow then
	startPanelRainbow();
end;
if C.FullBright then
	applyFullBright(true);
end;
if C.RemoveFog then
	applyRemoveFog(true);
end;
do
	if ProximityPromptService then
		local z = nil;
		local function R()
			if z then
				z.cancelled = true;
				z = nil;
			end;
		end;
		pcall(function()
			ProximityPromptService.PromptButtonHoldBegan:Connect(function(V, w)
				if S.unloaded or w ~= LP or not C.InstantInteract then
					return;
				end;
				R();
				if C.InstantInteractInsta then
					pcall(fireproximityprompt, V);
					return;
				end;
				local K = { cancelled = false };
				z = K;
				task.spawn(function()
					local z = tonumber(C.InstantInteractMult) or 2;
					if z < .5 then
						z = .5;
					end;
					local R = 1 / z;
					while not K.cancelled and (not S.unloaded and C.InstantInteract) do
						pcall(fireproximityprompt, V);
						task.wait(R);
					end;
				end);
			end);
		end);
		pcall(function()
			ProximityPromptService.PromptButtonHoldEnded:Connect(function(z, V)
				if V ~= LP then
					return;
				end;
				R();
			end);
		end);
	end;
end;
S.toggleMenu = function()
		if S.unloaded then
			return;
		end;
		if S.bindingMenuKey then
			return;
		end;
		if not S.panel or not S.panel.Parent then
			return;
		end;
		local z = tick();
		if z - S.lastMenuToggle < .15 then
			return;
		end;
		S.lastMenuToggle = z;
		playClick();
		if _G.__adSetCollapsed and _G.__adIsCollapsed then
			local z = _G.__adIsCollapsed();
			_G.__adSetCollapsed(not z);
		else
			S.panel.Visible = not S.panel.Visible;
			if S.shadow then
				S.shadow.Visible = S.panel.Visible;
			end;
			if S.glow then
				S.glow.Visible = S.panel.Visible;
			end;
		end;
	end;
S.rebindMenu = function()
		if S.menuAction then
			pcall(function()
				CAS:UnbindAction(S.menuAction);
			end);
		end;
		S.menuAction = "XDMenu_" .. randStr(6);
		pcall(function()
			CAS:BindAction(S.menuAction, function(z, R)
				if R ~= Enum.UserInputState.Begin then
					return;
				end;
				S.toggleMenu();
			end, false, C.MenuKey);
		end);
	end;
S.rebindMenu();
track(UIS.InputBegan:Connect(function(z)
	if S.unloaded or S.bindingMenuKey then
		return;
	end;
	if z.UserInputType ~= Enum.UserInputType.Keyboard then
		return;
	end;
	if z.KeyCode ~= C.MenuKey then
		return;
	end;
	S.toggleMenu();
end));
S.doFullUnload = function()
		if S.unloaded then
			return;
		end;
		if S.panel and (S.panel.Parent and S.panel.Visible) then
			local z = S.panel.Position.X.Scale;
			local R = S.panel.Position.Y.Scale;
			local V = S.panel.Position.X.Offset;
			local w = S.panel.Position.Y.Offset;
			local K = TweenInfo.new(.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
			pcall(function()
				(TweenService:Create(S.panel, K, { Position = UDim2.new(z, V - 800, R, w), BackgroundTransparency = 1 })):Play();
				(TweenService:Create(S.shadow, K, { Position = UDim2.new(z, (V - 800) + 6, R, w + 6), BackgroundTransparency = 1 })):Play();
				(TweenService:Create(S.glow, K, { Position = UDim2.new(z, (V - 800) - 20, R, w - 20), BackgroundTransparency = 1 })):Play();
			end);
			task.wait(.42);
		end;
		_G.__adUnloaded = true;
		S.running = false;
		pcall(unhookCombat);
		pcall(destroyFOVCircle);
		pcall(stopFovRainbow);
		pcall(stopPanelRainbow);
		pcall(stopBrewLoop);
		if S.btAnimConn then
			pcall(function()
				S.btAnimConn:Disconnect();
			end);
			S.btAnimConn = nil;
		end;
		if S._nickLoop then
			pcall(function()
				task.cancel(S._nickLoop);
			end);
			S._nickLoop = nil;
		end;
		pcall(function()
			applyFullBright(false);
		end);
		pcall(function()
			applyRemoveFog(false);
		end);
		if S.notifHolder then
			pcall(function()
				S.notifHolder:Destroy();
			end);
			S.notifHolder = nil;
		end;
		S.unloaded = true;
		pcall(function()
			C.Enabled = false;
			H.Enabled = false;
			C.RadiusVis = false;
			H.RadiusVis = false;
			C.AnimSpeed = false;
			C.GuardESP = false;
			C.PlayerESP = false;
			C.RemoveHands = false;
			C.RemoveLegs = false;
			C.RemoveTorso = false;
			C.Headless = false;
			C.Korblox = false;
			C.HideNick = false;
			C.FullBright = false;
			C.RemoveFog = false;
			C.AutoBrew = false;
			C.BulletTracer = false;
			S.oneClickDalgona = false;
			C.RLGL_AutoDodge = false;
			C.RLGL_TimerEndDodge = false;
			C.RebelSilentAim = false;
			C.RebelNoRecoil = false;
			C.RebelRapidFire = false;
			C.RebelFOVCircle = false;
		end);
		pcall(function()
			for z, R in pairs(_G.__dalgonaCache) do
				if z and z.Parent then
					pcall(function()
						z.Position = R.Position;
						z.Transparency = R.Transparency;
					end);
				end;
			end;
			table.clear(_G.__dalgonaCache);
		end);
		pcall(function()
			for z, R in pairs(S.origTransparency) do
				if z and z.Parent then
					pcall(function()
						z.LocalTransparencyModifier = 0;
						z.Transparency = R;
					end);
				end;
			end;
			table.clear(S.origTransparency);
			local function z(z)
				for R = 1, #z, 1 do
					local V = z[R];
					if V and V.Parent then
						pcall(function()
							V.LocalTransparencyModifier = 0;
						end);
					end;
				end;
			end;
			z(S.handCache);
			z(S.legCache);
			z(S.torsoCache);
			table.clear(S.handCache);
			table.clear(S.legCache);
			table.clear(S.torsoCache);
		end);
		pcall(function()
			T(false);
		end);
		pcall(function()
			b(false);
		end);
		pcall(unhook);
		pcall(V);
		pcall(w);
		pcall(n);
		pcall(killViz);
		for z = 1, #S.conns, 1 do
			pcall(function()
				if S.conns[z] and S.conns[z].Disconnect then
					S.conns[z]:Disconnect();
				end;
			end);
		end;
		table.clear(S.conns);
		for z, R in pairs(S.added) do
			pcall(function()
				if R and R.Disconnect then
					R:Disconnect();
				end;
			end);
		end;
		table.clear(S.added);
		if S.handsConn then
			pcall(function()
				S.handsConn:Disconnect();
			end);
			S.handsConn = nil;
		end;
		if S.dalgonaConn then
			pcall(function()
				S.dalgonaConn:Disconnect();
			end);
			S.dalgonaConn = nil;
		end;
		if S.tracerGui then
			pcall(function()
				S.tracerGui:Destroy();
			end);
			S.tracerGui = nil;
		end;
		if S.overlayGui then
			pcall(function()
				S.overlayGui:Destroy();
			end);
			S.overlayGui = nil;
		end;
		if S.infoGui then
			pcall(function()
				S.infoGui:Destroy();
			end);
			S.infoGui = nil;
		end;
		if S.menuAction then
			pcall(function()
				CAS:UnbindAction(S.menuAction);
			end);
			S.menuAction = nil;
		end;
		if S.clickSound then
			pcall(function()
				S.clickSound:Destroy();
			end);
			S.clickSound = nil;
		end;
		pcall(function()
			if S.gui then
				S.gui.Enabled = false;
				for z, R in ipairs(S.gui:GetDescendants()) do
					pcall(function()
						if R and R.Destroy then
							R:Destroy();
						end;
					end);
				end;
				S.gui:Destroy();
			end;
		end);
		S.gui = nil;
		S.shadow = nil;
		S.glow = nil;
		S.panel = nil;
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
_G.__XD_UNLOAD = S.doFullUnload;
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			if C.AnimSpeed then
				local z = LP.Character;
				local R = z and z:FindFirstChildOfClass("Humanoid");
				local V = R and R:FindFirstChildOfClass("Animator");
				if V then
					local z = C.AnimSpeedValue or 2.5;
					for R, V in ipairs(V:GetPlayingAnimationTracks()) do
						pcall(function()
							if V.Speed ~= z then
								V:AdjustSpeed(z);
							end;
						end);
					end;
				end;
			end;
			if C.RemoveHands or C.RemoveLegs or C.RemoveTorso then
				E();
			end;
			if C.Headless then
				b(true);
			end;
			if C.Korblox then
				T(true);
			end;
			if C.Enabled or H.Enabled then
				S.cachedUITool = findUITool();
				S.cachedDodgeTool = findDodgeTool();
				S.cachedSlot = inferSlotFor(S.cachedUITool, "T", C.ManualUISlot);
				S.cachedDodgeSlot = inferSlotFor(S.cachedDodgeTool, "1", C.ManualHnSSlot);
			end;
			if ((C.RebelSilentAim or C.RebelNoRecoil or C.RebelRapidFire)) and not S.combatHooked then
				hookCombat();
			end;
		end);
		task.wait(.1);
	end;
end);
task.spawn(function()
	while S.running and not S.unloaded do
		if C.GuardESP or C.PlayerESP then
			pcall(D);
		end;
		task.wait(.5);
	end;
end);
task.spawn(function()
	while S.running and not S.unloaded do
		pcall(function()
			local z = {};
			if C.Enabled then
				table.insert(z, "ui " .. S.cachedSlot);
			end;
			if H.Enabled then
				table.insert(z, "hns " .. S.cachedDodgeSlot);
			end;
			if C.RebelSilentAim then
				table.insert(z, "aim");
			end;
			if C.RebelNoRecoil then
				table.insert(z, "norec");
			end;
			if C.RebelRapidFire then
				table.insert(z, "rapid");
			end;
			if C.BulletTracer then
				table.insert(z, "btracer");
			end;
			if C.RLGL_AutoDodge then
				table.insert(z, "rlgl");
			end;
			if C.RLGL_TimerEndDodge then
				table.insert(z, "timer-end");
			end;
			if C.HideNick then
				table.insert(z, "hide-nick");
			end;
			if C.AutoBrew then
				table.insert(z, "auto-brew");
			end;
			if S.oneClickDalgona then
				table.insert(z, "dalgona ON");
			end;
			if C.GuardESP or C.PlayerESP then
				table.insert(z, string.format("esp %d/%d", _G.__adEspDone or 0, _G.__adEspTotal or 0));
			end;
			if C.AnimSpeed then
				table.insert(z, "anim");
			end;
			if _G.__ad_statusCb then
				if #z == 0 then
					_G.__ad_statusCb("paused - N");
				else
					_G.__ad_statusCb(table.concat(z, " - "));
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
	while S.running and not S.unloaded do
		pcall(function()
			local z = _G.__rlgl_isOnMap();
			if not z then
				_G.__rlglLastSec = nil;
				_G.__rlglTimerEndedAt = 0;
				_G.__rlglWasRed = false;
				task.wait(.5);
				return;
			end;
			if C.RLGL_AutoDodge then
				local z = _G.__rlgl_isRed();
				local R = _G.__rlgl_isMoving(C.RLGL_VelThreshold or .3);
				local V = _G.__rlgl_inSafeZone();
				if z and not _G.__rlglWasRed then
					_G.__rlglRedStartAt = tick();
				end;
				_G.__rlglWasRed = z;
				local w = z and (tick() - _G.__rlglRedStartAt) or 0;
				local K = C.RLGL_RedDelay or .1;
				local g = true;
				if V then
					g = false;
				end;
				if C.RLGL_OnlyRedLight and g then
					if not z then
						g = false;
					end;
					if w < K then
						g = false;
					end;
				end;
				if g and not R then
					g = false;
				end;
				local l = tick();
				if g and (l - _G.__rlglLast) >= ((C.RLGL_MinInterval or .15)) then
					_G.__rlglLast = l;
					task.spawn(_G.__rlgl_fireDodge);
				end;
			end;
			if C.RLGL_TimerEndDodge then
				local z = _G.__rlgl_timerSeconds();
				local R = _G.__rlgl_inSafeZone();
				local V = _G.__rlgl_inFinishZone();
				if z ~= nil then
					_G.__rlglLastSec = z;
				end;
				if z ~= nil and z > 10 then
					_G.__rlglTimerEndedAt = 0;
				end;
				local w = false;
				if z ~= nil and z <= 0 then
					w = true;
				end;
				if z == nil and (_G.__rlglLastSec and _G.__rlglLastSec <= 3) then
					w = true;
				end;
				if w and _G.__rlglTimerEndedAt == 0 then
					_G.__rlglTimerEndedAt = tick();
					_G.__rlglLastFire = 0;
				end;
				if _G.__rlglTimerEndedAt > 0 and (not R and not V) then
					local z = C.RLGL_TimerEndDelay or 0;
					local R = C.RLGL_TimerEndInterval or .15;
					local V = C.RLGL_TimerEndMaxDuration or 12;
					local w = tick() - _G.__rlglTimerEndedAt;
					if w > V then
						_G.__rlglTimerEndedAt = 0;
					elseif w >= z then
						local z = tick();
						if _G.__rlglLastFire == 0 or (z - _G.__rlglLastFire >= R) then
							_G.__rlglLastFire = z;
							task.spawn(_G.__rlgl_fireDodge);
						end;
					end;
				end;
			end;
		end);
		task.wait(.05);
	end;
end);
track(LP.CharacterAdded:Connect(function(z)
	task.wait(.5);
	if S.unloaded then
		return;
	end;
	E();
	if C.RemoveHands then
		I(true);
	end;
	if C.RemoveLegs then
		U(true);
	end;
	if C.RemoveTorso then
		W(true);
	end;
	if C.Headless then
		b(true);
	end;
	if C.Korblox then
		T(true);
	end;
end));
if LP.Character then
	track(LP.Character.DescendantAdded:Connect(function()
		if S.unloaded then
			return;
		end;
		if C.RemoveHands or C.RemoveLegs or C.RemoveTorso or C.Headless or C.Korblox then
			task.defer(function()
				E();
				if C.RemoveHands then
					I(true);
				end;
				if C.RemoveLegs then
					U(true);
				end;
				if C.RemoveTorso then
					W(true);
				end;
				if C.Headless then
					b(true);
				end;
				if C.Korblox then
					T(true);
				end;
			end);
		end;
	end));
end;
L();
do
	local function z(z)
		if not z or z == LP then
			return;
		end;
		track((z:GetPropertyChangedSignal("Team")):Connect(function()
			if not S.unloaded and ((C.GuardESP or C.PlayerESP)) then
				task.defer(D);
			end;
		end));
	end;
	for R, V in ipairs(Players:GetPlayers()) do
		z(V);
	end;
	track(Players.PlayerAdded:Connect(z));
end;
pcall(function()
	if S.FILE.isfile and S.FILE.isfile(k("default")) then
		x("default");
	end;
end);
if getgenv then
	(getgenv()).__ui_dodge = { shutdown = S.doFullUnload, config = C, H = H };
end;
if _G.__adStatusCb then
	_G.__adStatusCb("ready - N");
end;
print("[XD] LOADED", SCRIPT_NAME, SCRIPT_VERSION);

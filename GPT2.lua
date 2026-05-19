local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer.PlayerGui

------------------------------------------------
-- KÉO GUI
------------------------------------------------
local function dragify(obj)

	local dragging = false
	local dragInput
	local dragStart
	local startPos

	obj.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

			dragging = true
			dragStart = input.Position
			startPos = obj.Position
			dragInput = input

			input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end

			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)

		if dragging and input == dragInput then

			local delta = input.Position - dragStart

			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

------------------------------------------------
-- NÚT VÀNG
------------------------------------------------
local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0,60,0,60)
OpenButton.Position = UDim2.new(0.05,0,0.5,0)
OpenButton.Text = "⚡"
OpenButton.TextSize = 26
OpenButton.BackgroundColor3 = Color3.fromRGB(255,215,0)
OpenButton.TextColor3 = Color3.new(0,0,0)

Instance.new("UICorner",OpenButton).CornerRadius = UDim.new(1,0)

dragify(OpenButton)

------------------------------------------------
-- FRAME
------------------------------------------------
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,420,0,430)
Frame.Position = UDim2.new(0.1,0,0.1,0)
Frame.Visible = false
Frame.BackgroundColor3 = Color3.fromRGB(35,35,35)

Instance.new("UICorner",Frame)

dragify(Frame)

------------------------------------------------
-- TITLE
------------------------------------------------
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,-40,0,35)
Title.BackgroundTransparency = 1
Title.Text = "ADMIN GUI"
Title.TextSize = 18
Title.TextColor3 = Color3.new(1,1,1)

------------------------------------------------
-- X
------------------------------------------------
local Close = Instance.new("TextButton")
Close.Parent = Frame
Close.Size = UDim2.new(0,35,0,35)
Close.Position = UDim2.new(1,-35,0,0)
Close.Text = "X"
Close.TextSize = 18

------------------------------------------------
-- SCROLL
------------------------------------------------
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = Frame
Scroll.Size = UDim2.new(1,0,1,-40)
Scroll.Position = UDim2.new(0,0,0,40)
Scroll.CanvasSize = UDim2.new(0,0,0,1300)
Scroll.ScrollBarThickness = 6
Scroll.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0,10)

------------------------------------------------
-- SEARCH
------------------------------------------------
local SearchBox = Instance.new("TextBox")
SearchBox.Parent = Scroll
SearchBox.Size = UDim2.new(0.9,0,0,40)
SearchBox.PlaceholderText = "Chọn người chơi..."
SearchBox.Text = ""
SearchBox.TextSize = 16

------------------------------------------------
-- PLAYER LIST
------------------------------------------------
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = Scroll
PlayerList.Size = UDim2.new(0.9,0,0,150)
PlayerList.CanvasSize = UDim2.new(0,0,0,0)
PlayerList.ScrollBarThickness = 5

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = PlayerList

local SelectedPlayer = nil

local function refreshPlayers()

	for _,v in pairs(PlayerList:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	local count = 0

	for _,plr in pairs(Players:GetPlayers()) do

		local btn = Instance.new("TextButton")
		btn.Parent = PlayerList
		btn.Size = UDim2.new(1,0,0,35)
		btn.Text = plr.Name
		btn.TextSize = 16

		btn.MouseButton1Click:Connect(function()

			SelectedPlayer = plr
			SearchBox.Text = plr.Name
			PlayerList.Visible = false

		end)

		count += 1
	end

	PlayerList.CanvasSize = UDim2.new(0,0,0,count*35)
end

SearchBox.Focused:Connect(function()

	refreshPlayers()
	PlayerList.Visible = true

end)

------------------------------------------------
-- TP
------------------------------------------------
local TPButton = Instance.new("TextButton")
TPButton.Parent = Scroll
TPButton.Size = UDim2.new(0.9,0,0,40)
TPButton.Text = "XÁC NHẬN DỊCH CHUYỂN"
TPButton.TextSize = 16

TPButton.MouseButton1Click:Connect(function()

	if SelectedPlayer
	and SelectedPlayer.Character
	and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then

		LocalPlayer.Character.HumanoidRootPart.CFrame =
		SelectedPlayer.Character.HumanoidRootPart.CFrame

	end
end)

------------------------------------------------
-- NHẢY VÔ TẬN
------------------------------------------------
local InfiniteJump = false

local JumpButton = Instance.new("TextButton")
JumpButton.Parent = Scroll
JumpButton.Size = UDim2.new(0.9,0,0,40)
JumpButton.Text = "NHẢY VÔ TẬN : OFF"
JumpButton.TextSize = 16

JumpButton.MouseButton1Click:Connect(function()

	InfiniteJump = not InfiniteJump

	if InfiniteJump then
		JumpButton.Text = "NHẢY VÔ TẬN : ON"
	else
		JumpButton.Text = "NHẢY VÔ TẬN : OFF"
	end

end)

UIS.JumpRequest:Connect(function()

	if InfiniteJump then

		local hum =
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if hum then
			hum:ChangeState("Jumping")
		end
	end
end)

------------------------------------------------
-- GOD MODE
------------------------------------------------
local GodMode = false

local GodButton = Instance.new("TextButton")
GodButton.Parent = Scroll
GodButton.Size = UDim2.new(0.9,0,0,40)
GodButton.Text = "VÔ HẠN MÁU : OFF"
GodButton.TextSize = 16

GodButton.MouseButton1Click:Connect(function()

	GodMode = not GodMode

	local hum = LocalPlayer.Character and
	LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	if hum then

		if GodMode then

			GodButton.Text = "VÔ HẠN MÁU : ON"

			hum.MaxHealth = math.huge
			hum.Health = math.huge

		else

			GodButton.Text = "VÔ HẠN MÁU : OFF"

			hum.MaxHealth = 100
			hum.Health = 100

		end
	end
end)

------------------------------------------------
-- SPEED
------------------------------------------------
local SpeedEnabled = false
local CurrentSpeed = 16

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Parent = Scroll
SpeedTitle.Size = UDim2.new(0.9,0,0,30)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "TỐC ĐỘ"
SpeedTitle.TextSize = 18
SpeedTitle.TextColor3 = Color3.new(1,1,1)

local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Parent = Scroll
SpeedToggle.Size = UDim2.new(0.9,0,0,40)
SpeedToggle.Text = "TỐC ĐỘ : OFF"
SpeedToggle.TextSize = 16

local Speed1 = Instance.new("TextButton")
Speed1.Parent = Scroll
Speed1.Size = UDim2.new(0.9,0,0,40)
Speed1.Text = "+100 TỐC ĐỘ"
Speed1.TextSize = 16

local Speed2 = Instance.new("TextButton")
Speed2.Parent = Scroll
Speed2.Size = UDim2.new(0.9,0,0,40)
Speed2.Text = "+500 TỐC ĐỘ"
Speed2.TextSize = 16

local Speed3 = Instance.new("TextButton")
Speed3.Parent = Scroll
Speed3.Size = UDim2.new(0.9,0,0,40)
Speed3.Text = "+1000 TỐC ĐỘ"
Speed3.TextSize = 16

local function applySpeed()

	local hum =
	LocalPlayer.Character and
	LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	if hum then

		if SpeedEnabled then
			hum.WalkSpeed = CurrentSpeed
		else
			hum.WalkSpeed = 16
		end
	end
end

SpeedToggle.MouseButton1Click:Connect(function()

	SpeedEnabled = not SpeedEnabled

	if SpeedEnabled then
		SpeedToggle.Text = "TỐC ĐỘ : ON"
	else
		SpeedToggle.Text = "TỐC ĐỘ : OFF"
	end

	applySpeed()

end)

Speed1.MouseButton1Click:Connect(function()
	CurrentSpeed = 100
	applySpeed()
end)

Speed2.MouseButton1Click:Connect(function()
	CurrentSpeed = 500
	applySpeed()
end)

Speed3.MouseButton1Click:Connect(function()
	CurrentSpeed = 1000
	applySpeed()
end)

------------------------------------------------
-- ESP VIỀN ĐỎ
------------------------------------------------
local ESPEnabled = false

local ESPButton = Instance.new("TextButton")
ESPButton.Parent = Scroll
ESPButton.Size = UDim2.new(0.9,0,0,40)
ESPButton.Text = "VIỀN ĐỎ : OFF"
ESPButton.TextSize = 16

local function createESP(plr)

	if plr == LocalPlayer then
		return
	end

	local function add()

		if plr.Character
		and not plr.Character:FindFirstChild("Highlight") then

			local h = Instance.new("Highlight")
			h.Parent = plr.Character
			h.FillTransparency = 1
			h.OutlineColor = Color3.fromRGB(255,0,0)
			h.OutlineTransparency = 0
		end
	end

	add()

	plr.CharacterAdded:Connect(function()
		task.wait(1)
		add()
	end)
end

local function removeESP(plr)

	if plr.Character
	and plr.Character:FindFirstChild("Highlight") then

		plr.Character.Highlight:Destroy()

	end
end

ESPButton.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled

	if ESPEnabled then

		ESPButton.Text = "VIỀN ĐỎ : ON"

		for _,plr in pairs(Players:GetPlayers()) do
			createESP(plr)
		end

	else

		ESPButton.Text = "VIỀN ĐỎ : OFF"

		for _,plr in pairs(Players:GetPlayers()) do
			removeESP(plr)
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)

	if ESPEnabled then
		createESP(plr)
	end
end)

------------------------------------------------
-- OPEN CLOSE
------------------------------------------------
OpenButton.MouseButton1Click:Connect(function()

	Frame.Visible = true
	OpenButton.Visible = false

end)

Close.MouseButton1Click:Connect(function()

	Frame.Visible = false
	OpenButton.Visible = true

end)

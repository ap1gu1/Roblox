local TweenService = game:GetService("TweenService")

local player = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui")

gui.Name = "CodexYonitGUI"

gui.ResetOnSpawn = false

gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

gui.Parent = player:WaitForChild("PlayerGui")

-- Container

local container = Instance.new("Frame")

container.Size = UDim2.new(0, 200, 0, 160)

container.Position = UDim2.new(0.5, -100, 0.3, 0)

container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

container.BorderSizePixel = 0

container.Parent = gui

container.Active = true

container.Draggable = true

-- Top Bar

local topBar = Instance.new("TextButton")

topBar.Size = UDim2.new(1, 0, 0, 30)

topBar.Position = UDim2.new(0, 0, 0, 0)

topBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

topBar.TextColor3 = Color3.fromRGB(255, 255, 255)

topBar.Font = Enum.Font.SourceSansBold

topBar.TextSize = 16

topBar.Text = "[ - ] Menu"

topBar.BorderSizePixel = 1

topBar.BorderColor3 = Color3.fromRGB(80, 80, 80)

topBar.Parent = container

-- Content Frame

local content = Instance.new("Frame")

content.Position = UDim2.new(0, 0, 0, 30)

content.Size = UDim2.new(1, 0, 1, -30)

content.BackgroundTransparency = 1

content.Name = "Content"

content.Parent = container

-- Main Button

local mainBtn = Instance.new("TextButton")

mainBtn.Size = UDim2.new(1, 0, 0, 30)

mainBtn.Position = UDim2.new(0, 0, 0, 0)

mainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

mainBtn.Font = Enum.Font.SourceSansBold

mainBtn.TextSize = 16

mainBtn.Text = "Main"

mainBtn.BorderSizePixel = 1

mainBtn.BorderColor3 = Color3.fromRGB(80, 80, 80)

mainBtn.Parent = content

-- Dropdown

local mainDrop = Instance.new("Frame")

mainDrop.Size = UDim2.new(1, 0, 0, 0)

mainDrop.Position = UDim2.new(0, 0, 0, 30)

mainDrop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

mainDrop.ClipsDescendants = true

mainDrop.BorderSizePixel = 1

mainDrop.BorderColor3 = Color3.fromRGB(80, 80, 80)

mainDrop.Parent = content

-- Goto Carrot Button

local gotoCarrotBtn = Instance.new("TextButton")

gotoCarrotBtn.Size = UDim2.new(1, 0, 0, 30)

gotoCarrotBtn.Position = UDim2.new(0, 0, 0, 0)

gotoCarrotBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

gotoCarrotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

gotoCarrotBtn.Font = Enum.Font.SourceSansBold

gotoCarrotBtn.TextSize = 16

gotoCarrotBtn.Text = "Goto Carrot"

gotoCarrotBtn.BorderSizePixel = 1

gotoCarrotBtn.BorderColor3 = Color3.fromRGB(80, 80, 80)

gotoCarrotBtn.Parent = mainDrop

-- Goto Carrot Teleport Logic

gotoCarrotBtn.MouseButton1Click:Connect(function()

	local carrot = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Carrot")	if carrot then

		local char = player.Character or player.CharacterAdded:Wait()

		local hrp = char:FindFirstChild("HumanoidRootPart")

		if hrp then

			hrp.CFrame = carrot.CFrame + Vector3.new(0, 5, 0)

		end

	else

		warn("Carrot not found at workspace.Map.Carrot")

	end

end)

-- Credits

local creditLabel = Instance.new("TextLabel")

creditLabel.Size = UDim2.new(1, 0, 0, 30)

creditLabel.Position = UDim2.new(0, 0, 0, 60)

creditLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

creditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

creditLabel.Font = Enum.Font.SourceSansBold

creditLabel.TextSize = 16

creditLabel.Text = "credits:@YntScripts"

creditLabel.BorderSizePixel = 1

creditLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)

creditLabel.Parent = content

-- Toggle Logic

local isMainOpen = false

local isMinimized = false

local function toggleDropdown(open)

	local size = open and UDim2.new(1, 0, 0, 30) or UDim2.new(1, 0, 0, 0)

	TweenService:Create(mainDrop, TweenInfo.new(0.3), {Size = size}):Play()

end

mainBtn.MouseButton1Click:Connect(function()

	isMainOpen = not isMainOpen

	toggleDropdown(isMainOpen)

end)

topBar.MouseButton1Click:Connect(function()

	isMinimized = not isMinimized

	content.Visible = not isMinimized

	topBar.Text = isMinimized and "[ + ] Menu" or "[ - ] Menu"

end)


-- Anti Death / Anti Sit / Anti RagDoll System
local function protectCharacter()
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")

	for _, state in pairs(Enum.HumanoidStateType:GetEnumItems()) do
		if state == Enum.HumanoidStateType.FallingDown or
		   state == Enum.HumanoidStateType.Ragdoll or
		   state == Enum.HumanoidStateType.Swimming or
		   state == Enum.HumanoidStateType.Seated then
			hum:SetStateEnabled(state, false)
		end
	end

	hum.Died:Connect(function()
		task.wait()
		char:BreakJoints()
		player:LoadCharacter()
	end)

	char.ChildAdded:Connect(function(child)
		if child:IsA("Seat") or child:IsA("VehicleSeat") then
			child:Destroy()
		end
	end)

	hum:GetPropertyChangedSignal("Sit"):Connect(function()
		if hum.Sit then
			hum.Sit = false
		end
	end)

	player.CharacterAdded:Connect(function()
		task.wait(1)
		protectCharacter()
	end)
end

protectCharacter()

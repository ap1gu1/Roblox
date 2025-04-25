
-- Xeno Friendly Egg Teleport GUI

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 280)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local uilist = Instance.new("UIListLayout", frame)
uilist.Padding = UDim.new(0, 5)
uilist.FillDirection = Enum.FillDirection.Vertical
uilist.HorizontalAlignment = Enum.HorizontalAlignment.Center
uilist.VerticalAlignment = Enum.VerticalAlignment.Top

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -10, 0, 30)
title.Text = "Egg Teleport GUI"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local function stabilize()
    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    humanoid.Sit = false
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
end

local function teleport(folderName, prefix, count)
    local folder = workspace:FindFirstChild(folderName)
    if folder then
        for i = 1, count do
            local part = folder:FindFirstChild(prefix .. i)
            if part then
                hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                stabilize()
                wait(1)
            end
        end
        local sound = Instance.new("Sound", hrp)
        sound.SoundId = "rbxassetid://6026984224"
        sound.Volume = 1
        sound:Play()
        game.Debris:AddItem(sound, 2)
    end
end

local eggs = {
    {Name = "Baby Eggs", Folder = "EggHunt_Baby", Prefix = "Baby_", Count = 10},
    {Name = "Easy Eggs", Folder = "EggHunt_Easy", Prefix = "Easy_", Count = 15},
    {Name = "Medium Eggs", Folder = "EggHunt_Medium", Prefix = "Medium_", Count = 20},
    {Name = "Hard Eggs", Folder = "EggHunt_Hard", Prefix = "Hard_", Count = 25},
    {Name = "Extreme Eggs", Folder = "EggHunt_Extreme", Prefix = "Extreme_", Count = 35},
}

for _, egg in ipairs(eggs) do
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Text = egg.Name

    button.MouseButton1Click:Connect(function()
        teleport(egg.Folder, egg.Prefix, egg.Count)
    end)
end

-- Credit
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, -10, 0, 25)
credit.Text = "Credit: xhak."
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.SourceSansItalic
credit.TextSize = 14


-- Basic UI + Noclip Teleport Script for Brookhaven Egg Hunt
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0, 20, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Brookhaven Eggs"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.BorderSizePixel = 0
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local function createButton(text, order, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, 50 + (order * 35))
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
end

-- Noclip teleport
local function safeTeleport(part)
    if not part then return end
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    humanoid.Sit = false

    local particle = Instance.new("ParticleEmitter", hrp)
    particle.Rate = 50
    particle.Lifetime = NumberRange.new(0.5)
    particle.Speed = NumberRange.new(5)
    particle:Emit(30)
    game.Debris:AddItem(particle, 1)

    local sound = Instance.new("Sound", hrp)
    sound.SoundId = "rbxassetid://6026984224"
    sound.Volume = 1
    sound:Play()
    game.Debris:AddItem(sound, 2)
end

local function teleportEggs(folderName, prefix, count)
    local folder = workspace:FindFirstChild(folderName)
    if folder then
        for i = 1, count do
            local part = folder:FindFirstChild(prefix .. i)
            if part then
                safeTeleport(part)
                wait(1)
            end
        end
    end
end

-- Buttons
createButton("Baby Eggs", 0, function()
    teleportEggs("EggHunt_Baby", "Baby_", 10)
end)

createButton("Easy Eggs", 1, function()
    teleportEggs("EggHunt_Easy", "Easy_", 15)
end)

createButton("Medium Eggs", 2, function()
    teleportEggs("EggHunt_Medium", "Medium_", 20)
end)

createButton("Hard Eggs", 3, function()
    teleportEggs("EggHunt_Hard", "Hard_", 25)
end)

createButton("Extreme Eggs", 4, function()
    teleportEggs("EggHunt_Extreme", "Extreme_", 35)
end)

createButton("Credit: xhak", 5, function() end)

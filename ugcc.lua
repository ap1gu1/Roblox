local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GUI oluştur
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CheckpointGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0, 20, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 5)
uiList.SortOrder = Enum.SortOrder.LayoutOrder

-- Başlık
local title = Instance.new("TextLabel", frame)
title.Text = "Checkpoint Teleport"
title.Size = UDim2.new(1, -10, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Checkpoint'leri topla (isimleri aynı "Checkpoint" olan)
local checkpoints = {}
for _, part in pairs(workspace:GetChildren()) do
    if part:IsA("BasePart") and part.Name == "checkpoint" then
        table.insert(checkpoints, part)
    end
end

-- Z eksenine göre sırala (ileri gitme yönü)
table.sort(checkpoints, function(a, b)
    return a.Position.Z < b.Position.Z
end)

-- Otomatik Işınlama Sistemi
local auto = false

local function teleportTo(part)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
    end
end

local function startAutoTeleport()
    auto = true
    for _, checkpoint in ipairs(checkpoints) do
        if not auto then break end
        teleportTo(checkpoint)
        wait(2) -- Her checkpoint arası bekleme süresi
    end
end

-- Manuel butonlar
for index, part in ipairs(checkpoints) do
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Text = "Checkpoint " .. index
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextScaled = true

    button.MouseButton1Click:Connect(function()
        teleportTo(part)
    end)
end

-- Başlat butonu
local startButton = Instance.new("TextButton", frame)
startButton.Size = UDim2.new(1, -10, 0, 40)
startButton.Text = "🚀 Otomatik Başlat"
startButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.Font = Enum.Font.GothamBold
startButton.TextScaled = true

startButton.MouseButton1Click:Connect(function()
    if not auto then
        startAutoTeleport()
    end
end)

-- Durdur butonu
local stopButton = Instance.new("TextButton", frame)
stopButton.Size = UDim2.new(1, -10, 0, 30)
stopButton.Text = "⛔ Durdur"
stopButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextScaled = true

stopButton.MouseButton1Click:Connect(function()
    auto = false
end)

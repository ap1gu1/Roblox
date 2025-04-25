
local running = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Basic UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local StartButton = Instance.new("TextButton", Frame)
local StopButton = Instance.new("TextButton", Frame)

ScreenGui.Name = "EggCollectorGui"
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

StartButton.Size = UDim2.new(1, -20, 0, 40)
StartButton.Position = UDim2.new(0, 10, 0, 10)
StartButton.Text = "Start"
StartButton.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
StartButton.TextColor3 = Color3.new(1, 1, 1)
StartButton.Font = Enum.Font.GothamBold
StartButton.TextSize = 18

StopButton.Size = UDim2.new(1, -20, 0, 40)
StopButton.Position = UDim2.new(0, 10, 0, 55)
StopButton.Text = "Stop"
StopButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.GothamBold
StopButton.TextSize = 18

-- Noclip fonksiyonu
local function noclip()
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then
            v.CanCollide = false
        end
    end
end

-- Tıklama simulasyonu (1.5 saniye uzun)
local function click()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:Button1Down(Vector2.new(0, 0))
    task.wait(1.5)
    VirtualUser:Button1Up(Vector2.new(0, 0))
end

-- Safe place oluşturucu
local function createSafePlatform(position)
    local safePart = Instance.new("Part")
    safePart.Size = Vector3.new(8, 1, 8)
    safePart.Position = position - Vector3.new(0, 5, 0)
    safePart.Anchored = true
    safePart.CanCollide = true
    safePart.Transparency = 0.5
    safePart.Name = "SafePlatform"
    safePart.Parent = workspace
end

-- Altında boşluk var mı kontrol
local function isVoidBelow(position)
    local ray = Ray.new(position, Vector3.new(0, -50, 0))
    local part, _ = workspace:FindPartOnRay(ray)
    return not part
end

-- Asıl ışınlanma işlemi
local function teleportToEggs()
    while running do
        for _, eggPart in pairs(workspace.Eggs:GetChildren()) do
            if not running then break end

            if eggPart:IsA("Part") then
                noclip()

                -- Parta bakarak yakınına ışınla
                humanoidRootPart.CFrame = CFrame.new(eggPart.Position + Vector3.new(0, 3, -5), eggPart.Position)

                if isVoidBelow(humanoidRootPart.Position) then
                    createSafePlatform(humanoidRootPart.Position)
                end

                task.wait(0.5)
                click()
                task.wait(1)
            end
        end
        task.wait(1)
    end
end

-- Butonlar
StartButton.MouseButton1Click:Connect(function()
    if not running then
        running = true
        teleportToEggs()
    end
end)

StopButton.MouseButton1Click:Connect(function()
    running = false
end)

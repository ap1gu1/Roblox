
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ESP_UI"
gui.ResetOnSpawn = false

-- Aktif ESP'ler listesi
local activeESPs = {}

-- Ana GUI Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Üst bar
local topLabel = Instance.new("TextLabel", mainFrame)
topLabel.Size = UDim2.new(1, 0, 0, 25)
topLabel.Position = UDim2.new(0, 0, 0, 0)
topLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topLabel.Text = "🥚 Egg Finder  "
topLabel.Font = Enum.Font.GothamBold
topLabel.TextSize = 14
topLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
topLabel.BorderSizePixel = 0
topLabel.TextXAlignment = Enum.TextXAlignment.Left

-- xhak. label
local creditLabel = Instance.new("TextLabel", topLabel)
creditLabel.Size = UDim2.new(0, 60, 1, 0)
creditLabel.Position = UDim2.new(1, -65, 0, 0)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "xhak."
creditLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
creditLabel.Font = Enum.Font.Gotham
creditLabel.TextSize = 12
creditLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Sol menü
local tabList = Instance.new("Frame", mainFrame)
tabList.Size = UDim2.new(0, 100, 1, -25)
tabList.Position = UDim2.new(0, 0, 0, 25)
tabList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", tabList).CornerRadius = UDim.new(0, 6)

-- ESP Sekmesi Butonu
local espTabButton = Instance.new("TextButton", tabList)
espTabButton.Size = UDim2.new(1, 0, 0, 40)
espTabButton.Position = UDim2.new(0, 0, 0, 10)
espTabButton.Text = "ESP"
espTabButton.Font = Enum.Font.Gotham
espTabButton.TextSize = 14
espTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", espTabButton).CornerRadius = UDim.new(0, 8)

-- Kullanıcı Bilgisi
local userLabel = Instance.new("TextLabel", tabList)
userLabel.Size = UDim2.new(1, -10, 0, 30)
userLabel.Position = UDim2.new(0, 5, 1, -35)
userLabel.Text = LocalPlayer.Name .. " #" .. LocalPlayer.UserId
userLabel.Font = Enum.Font.Gotham
userLabel.TextSize = 12
userLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
userLabel.BackgroundTransparency = 1
userLabel.TextWrapped = true
userLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Credits Sekmesi Butonu
local creditTabButton = Instance.new("TextButton", tabList)
creditTabButton.Size = UDim2.new(1, 0, 0, 40)
creditTabButton.Position = UDim2.new(0, 0, 0, 60)
creditTabButton.Text = "Credits"
creditTabButton.Font = Enum.Font.Gotham
creditTabButton.TextSize = 14
creditTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
creditTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", creditTabButton).CornerRadius = UDim.new(0, 8)

-- ESP İçeriği
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -110, 1, -35)
contentFrame.Position = UDim2.new(0, 110, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

local label = Instance.new("TextLabel", contentFrame)
label.Size = UDim2.new(1, -20, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.Text = "ESP System"
label.Font = Enum.Font.GothamBold
label.TextSize = 16
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Left

-- Start ESP Butonu
local startButton = Instance.new("TextButton", contentFrame)
startButton.Size = UDim2.new(1, -20, 0, 40)
startButton.Position = UDim2.new(0, 10, 0, 60)
startButton.Text = "Start ESP"
startButton.Font = Enum.Font.Gotham
startButton.TextSize = 14
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", startButton).CornerRadius = UDim.new(0, 8)

-- Stop ESP Butonu
local stopButton = Instance.new("TextButton", contentFrame)
stopButton.Size = UDim2.new(1, -20, 0, 40)
stopButton.Position = UDim2.new(0, 10, 0, 110)
stopButton.Text = "Stop ESP"
stopButton.Font = Enum.Font.Gotham
stopButton.TextSize = 14
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0, 8)

-- Credits İçeriği
local creditFrame = Instance.new("Frame", mainFrame)
creditFrame.Size = contentFrame.Size
creditFrame.Position = contentFrame.Position
creditFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
creditFrame.Visible = false
Instance.new("UICorner", creditFrame).CornerRadius = UDim.new(0, 8)

local discordLabel = Instance.new("TextLabel", creditFrame)
discordLabel.Size = UDim2.new(1, 0, 1, 0)
discordLabel.Text = "👤 Discord: xhak."
discordLabel.Font = Enum.Font.GothamBold
discordLabel.TextSize = 16
discordLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
discordLabel.BackgroundTransparency = 1
discordLabel.TextWrapped = true
discordLabel.TextXAlignment = Enum.TextXAlignment.Center
discordLabel.TextYAlignment = Enum.TextYAlignment.Center

-- ESP Fonksiyonu
local function createESP(part)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = part.Size + Vector3.new(0.25, 0.25, 0.25)
    box.Adornee = part
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.4
    box.Color3 = Color3.fromRGB(0, 255, 120)
    box.Name = "CustomESP"
    box.Parent = part

    local billboard = Instance.new("BillboardGui", part)
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.Adornee = part
    billboard.AlwaysOnTop = true
    billboard.Name = "CustomESPLabel"

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.Text = ""

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if part and part.Parent then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - part.Position).Magnitude
                textLabel.Text = part.Name .. " [" .. math.floor(dist) .. "m]"
            end
        else
            conn:Disconnect()
            if billboard then billboard:Destroy() end
            if box then box:Destroy() end
        end
    end)

    table.insert(activeESPs, box)
    table.insert(activeESPs, billboard)
end

-- ESP Başlat
local function startESP()
    for _, esp in ipairs(activeESPs) do
        if esp and esp.Parent then esp:Destroy() end
    end
    activeESPs = {}

    local targetPartName = "egg" -- <<<<< BURAYA İSTEDİĞİN PART ADINI YAZ
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == targetPartName then
            createESP(obj)
        end
    end
end

-- ESP Durdur
local function stopESP()
    for _, esp in ipairs(activeESPs) do
        if esp and esp.Parent then esp:Destroy() end
    end
    activeESPs = {}
end

-- Sekme geçişleri
espTabButton.MouseButton1Click:Connect(function()
    contentFrame.Visible = true
    creditFrame.Visible = false
end)

creditTabButton.MouseButton1Click:Connect(function()
    contentFrame.Visible = false
    creditFrame.Visible = true
end)

-- Butonlar
startButton.MouseButton1Click:Connect(startESP)
stopButton.MouseButton1Click:Connect(stopESP)

-- GUI Oluşturuluyor
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local CompleteButton = Instance.new("TextButton")
local InviteButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")
local CreditLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Size = UDim2.new(0, 250, 0, 210)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true -- GUI Taşınabilir
Frame.Parent = ScreenGui

UICorner.Parent = Frame

CompleteButton.Size = UDim2.new(0, 230, 0, 40)
CompleteButton.Position = UDim2.new(0, 10, 0, 10)
CompleteButton.Text = "🌀 Complete All Levels"
CompleteButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
CompleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CompleteButton.Font = Enum.Font.GothamBold
CompleteButton.TextSize = 14
CompleteButton.Parent = Frame

InviteButton.Size = UDim2.new(0, 230, 0, 40)
InviteButton.Position = UDim2.new(0, 10, 0, 60)
InviteButton.Text = "🎉 Invite All Friends"
InviteButton.BackgroundColor3 = Color3.fromRGB(70, 180, 130)
InviteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InviteButton.Font = Enum.Font.GothamBold
InviteButton.TextSize = 14
InviteButton.Parent = Frame

ToggleButton.Size = UDim2.new(0, 230, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 110)
ToggleButton.Text = "👁 Toggle GUI"
ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Parent = Frame

CreditLabel.Size = UDim2.new(0, 230, 0, 20)
CreditLabel.Position = UDim2.new(0, 10, 0, 160)
CreditLabel.Text = "credit : xhak. / Ap1Gu1"
CreditLabel.BackgroundTransparency = 1
CreditLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreditLabel.Font = Enum.Font.GothamSemibold
CreditLabel.TextSize = 12
CreditLabel.TextTransparency = 0.2
CreditLabel.Parent = Frame

-- Mini Bildirim Fonksiyonu
local function notify(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Notification",
        Text = text,
        Duration = 2
    })
end

-- Teleport Fonksiyonu
local function teleportToPart(part)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = part.CFrame
    end
end

-- Map Listesi
local maps = {
    "Tutorial", "Balance", "Gravity", "Rainbow", "Push", "Ascend", "Lava", "Split", "Matrix", "Drop",
    "Paths", "Conveyors", "Wipeout", "Colors", "Scramble", "Avoid", "Maze", "Heights", "Portals",
    "Sliced", "3-Steps", "3-Lasers", "3-Jumps", "3-Ladders", "3-Climb", "3-Multi", "Vents",
    "4-Fall", "4-Teamwork", "4-Phases", "4-Pyramid"
}

-- Level Folderı Bul
local function findLevelFolder(mapName)
    local playerFolder

    if mapName == "Vents" then
        playerFolder = workspace:FindFirstChild("3 Player:")
    elseif mapName:match("^3%-") then
        playerFolder = workspace:FindFirstChild("3 Player:")
    elseif mapName:match("^4%-") then
        playerFolder = workspace:FindFirstChild("4 Player:")
    else
        playerFolder = workspace:FindFirstChild("2 Player:")
    end

    if playerFolder then
        local cleanName = mapName:gsub("^3%-", ""):gsub("^4%-", "")

        for _, levelFolder in pairs(playerFolder:GetChildren()) do
            if levelFolder:IsA("Folder") and levelFolder.Name:find("Level") and levelFolder.Name:find(cleanName) then
                return levelFolder
            end
        end
    end

    return nil
end

-- Tüm Levelleri Bitirme Fonksiyonu
local function completeLevels()
    for _, mapName in ipairs(maps) do
        local portalFolder = workspace:FindFirstChild("PortalTPS")
        if portalFolder then
            local portalPart = portalFolder:FindFirstChild(mapName)
            if portalPart then
                teleportToPart(portalPart)
                task.wait(1.5)
            end
        end

        local levelFolder = findLevelFolder(mapName)
        if levelFolder then
            for _, subFolder in pairs(levelFolder:GetChildren()) do
                if subFolder:IsA("Folder") then
                    local toLobby = subFolder:FindFirstChild("ToLobby")
                    if toLobby then
                        teleportToPart(toLobby)
                        notify(mapName .. " completed!")
                        task.wait(1.5)
                    end
                end
            end
        end
    end
end

-- Arkadaşlara Davet Fonksiyonu
local function inviteAllFriends()
    local userIds = {
        5424190739, 4051222410, 7553607796, 3332960815, 8037186793, 8208035495,
        7008308372, 8196164750, 8220106357, 8131962764, 7232625801, 8018652156,
        984978298, 4963432489, 1829610354, 5241987771
    }

    local inviteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("InviteFriend")

    for _, userId in ipairs(userIds) do
        inviteEvent:FireServer(userId)
        task.wait(0.1)
    end

    notify("All friends invited!")
end

-- Buton Bağlantıları
CompleteButton.MouseButton1Click:Connect(function()
    completeLevels()
end)

InviteButton.MouseButton1Click:Connect(function()
    inviteAllFriends()
end)

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Finity UI Tabanlı Brookhaven Egg Teleport GUI
local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/finitiyui"))()
local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.RightControl)

local EggsCategory = FinityWindow:Category("Brookhaven Egg Teleport")
local TeleportSector = EggsCategory:Sector("Teleport Options")

local player = game.Players.LocalPlayer
local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

local function teleport(folderName, prefix, count)
    local folder = workspace:FindFirstChild(folderName)
    if folder and hrp then
        for i = 1, count do
            local part = folder:FindFirstChild(prefix .. i)
            if part then
                hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
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

TeleportSector:Cheat("Button", "Baby Eggs", function()
    teleport("EggHunt_Baby", "Baby_", 10)
end)

TeleportSector:Cheat("Button", "Easy Eggs", function()
    teleport("EggHunt_Easy", "Easy_", 15)
end)

TeleportSector:Cheat("Button", "Medium Eggs", function()
    teleport("EggHunt_Medium", "Medium_", 20)
end)

TeleportSector:Cheat("Button", "Hard Eggs", function()
    teleport("EggHunt_Hard", "Hard_", 25)
end)

TeleportSector:Cheat("Button", "Extreme Eggs", function()
    teleport("EggHunt_Extreme", "Extreme_", 35)
end)


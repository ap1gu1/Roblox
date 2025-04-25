
-- Wally UI v3 Tabanlı Brookhaven Egg Teleport GUI (Xeno uyumlu)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/Wally-UI/main/source.lua"))()

local window = library:CreateWindow("Brookhaven Egg Teleport", Vector2.new(500, 400), Enum.KeyCode.RightControl)
local eggsTab = window:CreateTab("Egg Teleports")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

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

local eggList = {
    {Name = "Baby Eggs", Folder = "EggHunt_Baby", Prefix = "Baby_", Count = 10},
    {Name = "Easy Eggs", Folder = "EggHunt_Easy", Prefix = "Easy_", Count = 15},
    {Name = "Medium Eggs", Folder = "EggHunt_Medium", Prefix = "Medium_", Count = 20},
    {Name = "Hard Eggs", Folder = "EggHunt_Hard", Prefix = "Hard_", Count = 25},
    {Name = "Extreme Eggs", Folder = "EggHunt_Extreme", Prefix = "Extreme_", Count = 35},
}

for _, egg in ipairs(eggList) do
    eggsTab:CreateButton(egg.Name, function()
        teleport(egg.Folder, egg.Prefix, egg.Count)
    end)
end

window:CreateTab("Credits"):CreateLabel("Script by xhak / ap1gu1")

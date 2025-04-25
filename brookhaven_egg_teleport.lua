
--// UI Library Kullanımı
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/UI-Libs/main/Verl%20Lib"))()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local window = library:AddWindow("Egg Teleport Script", {
    main_color = Color3.fromRGB(50, 50, 50),
    min_size = Vector2.new(300, 250),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true,
})

-- Stabilize (ayakta tutma) fonksiyonu
local function stabilizeCharacter()
    if character and hrp then
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        humanoid.Sit = false
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(0), 0)
    end
end

-- Particle Efekti Oluştur
local function createTeleportParticle()
    local particle = Instance.new("ParticleEmitter")
    particle.Texture = "rbxassetid://243660364" -- Basit sparkle efekti
    particle.Color = ColorSequence.new(Color3.new(1, 1, 1))
    particle.Size = NumberSequence.new(1)
    particle.Lifetime = NumberRange.new(1)
    particle.Rate = 100
    particle.Speed = NumberRange.new(3)
    particle.Parent = hrp
    task.delay(1, function()
        particle:Destroy()
    end)
end

-- Success Sound
local function playSuccessSound()
    local sound = Instance.new("Sound", hrp)
    sound.SoundId = "rbxassetid://6026984224" -- Basit success ding sesi
    sound.Volume = 1
    sound:Play()
    task.delay(2, function()
        sound:Destroy()
    end)
end

-- Işınlama fonksiyonu
local function teleportToEggs(folderName, prefix, count)
    local folder = workspace:FindFirstChild(folderName)

    if folder then
        for i = 1, count do
            local partName = prefix .. i
            local part = folder:FindFirstChild(partName)

            if part then
                createTeleportParticle()
                hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                stabilizeCharacter()
                wait(1)
            end
        end
        playSuccessSound()
    else
        warn("Folder not found: " .. folderName)
    end
end

-- Ana Tab
local mainTab = window:AddTab("Main")

mainTab:AddButton("Baby Eggs", function()
    teleportToEggs("EggHunt_Baby", "Baby_", 10)
end)

mainTab:AddButton("Easy Eggs", function()
    teleportToEggs("EggHunt_Easy", "Easy_", 15)
end)

mainTab:AddButton("Medium Eggs", function()
    teleportToEggs("EggHunt_Medium", "Medium_", 20)
end)

mainTab:AddButton("Hard Eggs", function()
    teleportToEggs("EggHunt_Hard", "Hard_", 25)
end)

mainTab:AddButton("Extreme Eggs", function()
    teleportToEggs("EggHunt_Extreme", "Extreme_", 35)
end)

-- Credit Tab
local creditTab = window:AddTab("Credit Owner")
creditTab:AddLabel("xhak.")

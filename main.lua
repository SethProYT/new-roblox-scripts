-- initializers
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Advanced Ragdoll Fighting GUI", "DarkTheme")
local Blatant = Window:NewTab("Blatant")
local Legit = Window:NewTab("Legit")
local Fun = Window:NewTab("Fun")
local ClientSide = Window:NewTab("Client Side")
local HBE = Window:NewTab("Hitbox")
local BlatantSection = Blatant:NewSection("Blatant")
local LegitSection = Legit:NewSection("Legit")
local ClientSideSection = ClientSide:NewSection("Client Side")
local FunSection = Fun:NewSection("Fun")
local HBSection = HBE:NewSection("Hitbox")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local hb = true
local thefov = 120
local fovv = false
local stopFOV = false
local plrname = Character.Name
local size
local hit_head
local hit_torso
local change_fov


local function HitboxExpander() 
    if hb == true then 
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                local head = v.Character:FindFirstChild("Head")
                local humanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                
                if head and hit_head then
                    head.Transparency = 0.5
                    head.CanCollide = false
                    head.Size = size
                end
                
                if humanoidRootPart and hit_torso then
                    humanoidRootPart.Transparency = 0.5  
                    humanoidRootPart.CanCollide = false
                    humanoidRootPart.Size = size
                end
            end
        end
    else
        print("Hitbox expander is off")
    end
end

local function spam_landmines()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SethProYT/NewNewRobloxScripts/refs/heads/main/Mines%20spammer.lua"))()
end

local function show_landmines() 
    local mines = game:GetService("Workspace").Map.Obstacles.Minefield.Mines

    while wait() do
        for i,v in pairs(mines:GetDescendants()) do
            if v.Name == "Base" and "Button" then
                v.Transparency = 0
            end
        end
    end
end

local function grabsoda()
    local soda_location = workspace.Map.Buildings.Shop.VendingMachine.att.ProximityPrompt
    local lastplrlocation = Character.HumanoidRootPart.CFrame.Position
    local lastcampos = game:GetService("Workspace").CurrentCamera.CFrame.Position

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(219.191772, 4.17729282, -208.28801, 0.0169080757, 3.34219585e-08, -0.999857068, -4.17683843e-08, 1, 3.27204148e-08, 0.999857068, 4.1209173e-08, 0.0169080757)
    game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(211.488846, 6.48912764, -208.205566, 0.0116090048, 0.157975465, -0.987374783, -1.16415322e-10, 0.987441361, 0.157986104, 0.999932647, -0.00183406135, 0.0114632109)
    soda_location.HoldDuration = 0

    repeat fireproximityprompt(soda_location, 5) until LocalPlayer.Backpack:FindFirstChild("Soda")

    Character.HumanoidRootPart.CFrame = CFrame.new(lastplrlocation)
    game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(lastcampos)

    lastplrlocation = nil
    lastcampos = nil
end

local function teleportPlayer(coordinates)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(
        Character.HumanoidRootPart, 
        tweenInfo, 
        {CFrame = CFrame.new(coordinates)}
    )

    tween:Play()
end

local function makePlayerRainbow()
    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    local connection
    connection = RunService.Heartbeat:Connect(function(deltaTime)
        local hue = (tick() * 0.1) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Color = color
            end
        end
    end)

    character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            connection:Disconnect()
        end
    end)
end

local function changeMaterial() 
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.ForceField
        end
    end
end

local function stopFOVChange()
    stopFOV = true
    if fovConnection then
        fovConnection:Disconnect()
        fovConnection = nil
    end
end

local function fov() 
    local Cam = game.Workspace.CurrentCamera
    stopFOV = false
    
    fovConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if stopFOV then
            fovConnection:Disconnect()
            fovConnection = nil
            return
        end

        if Character and Character:FindFirstChild("Humanoid") then
            if Character.Humanoid.Health <= 0 then
                stopFOVChange()
                return
            end
        end

        if fovv then
            Cam.FieldOfView = thefov
        end
    end)
end


HBSection:NewToggle("Hit head (for hitbox expander)", "this enables the ability to always hit head (ragdoll hits)", function(state)
    if state then
        hit_head = true
    else
        hit_head = false
    end
end)

HBSection:NewButton("HB expander", "increase hitbox size", function()
    HitboxExpander()
end)

HBSection:NewSlider("HB Size", "Changes the hitbox size", 10, 0, function(s)
    size = Vector3.new(s, s, s)
end)

HBSection:NewToggle("Hit torso", "this enables the ability to always hit the torso", function(state)
    if state then
        hit_torso = true
    else
        hit_torso = false
    end
end)


BlatantSection:NewButton("Grab Soda", "grab the soda from the vending machine", function()
    grabsoda()
end)

-- 205.41488647460938, 3.7984275817871094, -200.4371337890625 shop coords
-- 302.3089904785156, 1013.99853515625, -54.178001403808594 tower coords

BlatantSection:NewDropdown("Teleports", "Teleport with PVP on", {"Shop", "Tower"}, function(currentOption)
    if currentOption == "Shop" then
        teleportPlayer(Vector3.new(205.41488647460938, 3.7984275817871094, -200.4371337890625))
    elseif currentOption == "Tower" then
        teleportPlayer(Vector3.new(302.3089904785156, 1013.99853515625, -54.178001403808594))
    end
end)

BlatantSection:NewToggle("Spinbot", "spin your character", function(state)
    if state then
        Character.HumanoidRootPart:FindFirstChild("aoshfajkhfsjkdhfjkshdkjf hiuerywe8rubwiuerbyweuibryweiubry(#*$B^(*$&B@(*#B&$*(@#&$(*@#&$(*@#$)")
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "aoshfajkhfsjkdhfjkshdkjf hiuerywe8rubwiuerbyweuibryweiubry(#*$B^(*$&B@(*#B&$*(@#&$(*@#&$(*@#&$(*@#$"
        Spin.Parent = Character.HumanoidRootPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0,50,0)
    else
        Character.HumanoidRootPart:FindFirstChild("aoshfajkhfsjkdhfjkshdkjf hiuerywe8rubwiuerbyweuibryweiubry(#*$B^(*$&B@(*#B&$*(@#&$(*@#&$(*@#$"):Destroy()
    end
end)


FunSection:NewButton("Spam Landmines (unstable!)", "spam landmines", function()
    spam_landmines()
end)

FunSection:NewButton("Show Landmines", "show landmines", function()
    show_landmines()
end)


ClientSideSection:NewButton("Change material", "Change character material", function()
    changeMaterial()
end)

ClientSideSection:NewToggle("120 FOV", "Increase FOV", function(state)
    if state then
        fovv = true
        fov()
    else
        fovv = false
        stopFOVChange()
    end
end)

ClientSideSection:NewToggle("Rainbow Player", "Makes your character cycle through rainbow colors", function(state)
    if state then
        makePlayerRainbow()
    else
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.new(1, 1, 1)
                end
            end
        end
    end
end)



Players.PlayerAdded:Connect(function(plr)
    HitboxExpander()
end)


while wait(60) do
    if hb == true then
        HitboxExpander()
    else
        return "nothing"
    end
end


Character.Humanoid.Died:Connect(function()
    Character.HumanoidRootPart["aoshfajkhfsjkdhfjkshdkjf hiuerywe8rubwiuerbyweuibryweiubry(#*$B^(*$&B@(*#B&$*(@#&$(*@#&$(*@#$)"]:Destroy()
    repeat wait() until game:GetService("Players")[plrname].Character:FindFirstChild("HumanoidRootPart")

    Library:Destroy()
    Window:Destroy()
end)

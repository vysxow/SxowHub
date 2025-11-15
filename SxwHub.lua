--========================================================--
--                 SxwHub UI (CLEAN VERSION)              --
--========================================================--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- GUI SÛR ET COMPATIBLE
local gui = Instance.new("ScreenGui")
gui.Name = "SxwHubUI"
gui.ResetOnSpawn = false

if syn and syn.protect_gui then 
    syn.protect_gui(gui)
    gui.Parent = game.CoreGui
elseif gethui then
    gui.Parent = gethui()
else
    gui.Parent = game.CoreGui
end

------------------------------------------------------------
--                DRAGGING (PARFAITEMENT FLUIDE)          
------------------------------------------------------------
local function MakeDraggable(frame, drag)
    local dragging, dragStart, startPos = false, nil, nil

    drag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    drag.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

------------------------------------------------------------
--                      UI PRINCIPAL                       
------------------------------------------------------------
local holder = Instance.new("Frame")
holder.Size = UDim2.new(0, 210, 0, 50)
holder.Position = UDim2.new(0, 10, 0, 10) -- coin supérieur gauche
holder.BackgroundTransparency = 1
holder.Parent = gui

local main = Instance.new("TextButton")
main.Parent = holder
main.Size = UDim2.new(0, 200, 0, 45)
main.Position = UDim2.new(0, 0, 0, 0)
main.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
main.TextColor3 = Color3.fromRGB(255, 255, 255)
main.Font = Enum.Font.GothamBold
main.TextSize = 22
main.Text = "SxwHub"

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local panel = Instance.new("Frame")
panel.Parent = holder
panel.Size = UDim2.new(0, 200, 0, 0)
panel.Position = UDim2.new(0, 0, 0, 50)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
panel.ClipsDescendants = true

Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 6)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center

------------------------------------------------------------
--                        NOTIFS                           
------------------------------------------------------------
local function Notify(msg)
    local n = Instance.new("TextLabel")
    n.Parent = gui
    n.Size = UDim2.new(0, 260, 0, 40)
    n.Position = UDim2.new(1, -280, 1, -80)
    n.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.Font = Enum.Font.GothamBold
    n.TextSize = 18
    n.Text = msg

    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 10)

    TweenService:Create(n, TweenInfo.new(0.4), {
        Position = UDim2.new(1, -280, 1, -130)
    }):Play()

    task.wait(2)
    TweenService:Create(n, TweenInfo.new(0.4), {
        Position = UDim2.new(1, -280, 1, -50)
    }):Play()

    task.wait(0.3)
    n:Destroy()
end

------------------------------------------------------------
--                ÉCRAN ANTIHIT (UI ONLY)                  
------------------------------------------------------------
local function AntiHitScreen(active)
    local blackScreen = Instance.new("Frame")
    blackScreen.Parent = gui
    blackScreen.Size = UDim2.new(1,0,1,0)
    blackScreen.BackgroundColor3 = Color3.fromRGB(0,0,0)
    blackScreen.ZIndex = 10
    blackScreen.BackgroundTransparency = 1

    local fadeIn = TweenService:Create(blackScreen, TweenInfo.new(0.4), {BackgroundTransparency = 0})
    fadeIn:Play()

    local text = Instance.new("TextLabel")
    text.Parent = blackScreen
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255,255,255)
    text.Font = Enum.Font.GothamBlack
    text.TextScaled = true
    text.Text = "Sxw Desync"
    text.ZIndex = 11
    text.TextTransparency = 1

    TweenService:Create(text, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    task.wait(2)

    TweenService:Create(blackScreen, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(text, TweenInfo.new(0.4), {TextTransparency = 1}):Play()

    task.wait(0.5)
    blackScreen:Destroy()
end

------------------------------------------------------------
--                BOOST FPS FUNCTION                       
------------------------------------------------------------
local function BoostFPS(active)
    local settings = UserSettings():GetService("UserGameSettings")
    if active then
        settings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        game.Lighting.GlobalShadows = false
        game.Lighting.EnvironmentDiffuseScale = 0
        game.Lighting.EnvironmentSpecularScale = 0

        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
        Notify("FPS Boost Activated")
    else
        settings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel5
        game.Lighting.GlobalShadows = true
        game.Lighting.EnvironmentDiffuseScale = 1
        game.Lighting.EnvironmentSpecularScale = 1

        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = true
            end
        end
        Notify("FPS Boost Deactivated")
    end
end

------------------------------------------------------------
--                    BOUTON GENERATOR                     
------------------------------------------------------------
local function AddToggleButton(text, color, callback)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = panel
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)

    btn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
    end)
end

------------------------------------------------------------
--                     AJOUT DES OPTIONS                   
------------------------------------------------------------
AddToggleButton("Auto Steal", Color3.fromRGB(50,150,50), function(active)
    Notify("Auto Steal " .. (active and "ON" or "OFF"))
end)

AddToggleButton("Tp Base", Color3.fromRGB(50,150,200), function(active)
    Notify("Tp Base " .. (active and "ON" or "OFF"))
end)

AddToggleButton("AntiHit", Color3.fromRGB(255,140,0), function(active)
    if active then
        AntiHitScreen(true)
    else
        Notify("AntiHit OFF")
    end
end)

AddToggleButton("TikTok: Sxxow700", Color3.fromRGB(255,0,0), function(active)
    Notify("TikTok: Sxxow700")
end)

AddToggleButton("Brainrot Locations", Color3.fromRGB(0,170,255), function(active)
    local bestBrainrot = "Golden Brainrot"
    Notify("Best value Brainrot: " .. bestBrainrot)
end)

AddToggleButton("Boost FPS", Color3.fromRGB(0,255,0), BoostFPS)

------------------------------------------------------------
--                     OUVERTURE PANEL                     
------------------------------------------------------------
local opened = false
main.MouseButton1Click:Connect(function()
    opened = not opened
    TweenService:Create(
        panel,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad),
        {Size = opened and UDim2.new(0, 200, 0, 300) or UDim2.new(0, 200, 0, 0)}
    ):Play()
end)

------------------------------------------------------------
--                   DRAG DU MENU COMPLET                  
------------------------------------------------------------
MakeDraggable(holder, main)

print("SxwHub UI Loaded (Clean Version with Toggle Buttons)")


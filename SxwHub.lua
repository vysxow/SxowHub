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

-- Bouton principal
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

-- Panel
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
--                    BOUTON GENERATOR                    
------------------------------------------------------------
local function AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = panel
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)

    btn.MouseButton1Click:Connect(function()
        if callback then
            callback()
        else
            Notify(text .. " exécuté ✔")
        end
    end)
end

------------------------------------------------------------
--                     AJOUT DES OPTIONS                  
------------------------------------------------------------
AddButton("Auto Steal")
AddButton("Tp Base")
AddButton("AntiHit")

-- Nouveau bouton TikTok
AddButton("TikTok: Sxxow700", function()
    Notify("TikTok: Sxxow700")
end)

------------------------------------------------------------
--                     OUVERTURE PANEL                    
------------------------------------------------------------
local opened = false
main.MouseButton1Click:Connect(function()
    opened = not opened
    TweenService:Create(
        panel,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad),
        {Size = opened and UDim2.new(0, 200, 0, 190) or UDim2.new(0, 200, 0, 0)}
    ):Play()
end)

------------------------------------------------------------
--                   DRAG DU MENU COMPLET                 
------------------------------------------------------------
MakeDraggable(holder, main)

print("SxwHub UI Loaded (Clean Version)")

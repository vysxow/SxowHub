--== SxwHub - Interface inspirée de ton image (vert + jaune) ==--

local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "SxwHub_UI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

if syn and syn.protect_gui then
    syn.protect_gui(gui)
end


--------------------------------------
-- STYLE DES BOUTONS (GROS + ARRONDIS)
--------------------------------------
local function MakeBigButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -30, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(25, 100, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 22
    btn.Text = text
    btn.BorderSizePixel = 0

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 3
    stroke.Color = Color3.fromRGB(255, 210, 50)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(35, 140, 45)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(25, 100, 35)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(callback)
end


------------------------------
-- TOGGLES TYPE ON / OFF
------------------------------
local function MakeToggle(parent, text, callback)
    local toggle = Instance.new("TextButton", parent)
    toggle.Size = UDim2.new(1, -30, 0, 50)
    toggle.BackgroundColor3 = Color3.fromRGB(25, 100, 35)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 20
    toggle.Text = text .. ": OFF"
    toggle.BorderSizePixel = 0

    local corner = Instance.new("UICorner", toggle)
    corner.CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", toggle)
    stroke.Thickness = 3
    stroke.Color = Color3.fromRGB(255, 210, 50)

    local state = false

    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text .. ": " .. (state and "ON" or "OFF")

        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Color3.fromRGB(255, 210, 50)
                or Color3.fromRGB(25, 100, 35)
        }):Play()

        callback(state)
    end)
end


---------------------------------
-- CADRE PRINCIPAL (STYLE IMAGE)
---------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.05, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 100, 35)

local fcorner = Instance.new("UICorner", frame)
fcorner.CornerRadius = UDim.new(0, 22)

local fstroke = Instance.new("UIStroke", frame)
fstroke.Thickness = 4
fstroke.Color = Color3.fromRGB(255, 210, 50)


---------------------------
-- TITRE (SxwHub)
---------------------------
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.Text = "SxwHub"
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(255, 210, 50)


-----------------------------
-- LISTE ORDONNÉE DES BOUTONS
-----------------------------
local list = Instance.new("UIListLayout", frame)
list.Padding = UDim.new(0, 12)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder


------------------------
-- BOUTONS / FONCTIONS
------------------------

MakeToggle(frame, "Stealer", function(state)
    print("Stealer:", state)
end)

MakeToggle(frame, "Instant TP", function(state)
    print("Instant TP:", state)
end)

MakeToggle(frame, "Anti Hit", function(state)
    print("Anti Hit:", state)
end)

MakeBigButton(frame, "AUTRE OPTION", function()
    print("Bouton custom")
end)

MakeBigButton(frame, "DISCORD", function()
    setclipboard("discord.gg/tonserveur")
    print("Discord copied!")
end)

print("SxwHub  Loaded!")

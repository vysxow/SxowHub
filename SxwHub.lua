--== SxwHub - Menu déroulant + bouton logo GhostFace draggable ==--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Création ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(gui)
end

---------------------------------------------------------------------
--  BOUTON LOGO (GHOSTFACE) DRAGGABLE
---------------------------------------------------------------------
local logoBtn = Instance.new("ImageButton")
logoBtn.Parent = gui
logoBtn.Size = UDim2.new(0, 70, 0, 70)
logoBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
logoBtn.BackgroundTransparency = 1
logoBtn.Image = "rbxassetid://0"  -- je remplace après avec ton image
logoBtn.AutoButtonColor = false

-- IMPORT DE TON IMAGE
-- je convertis ton image en ID (tu devras juste l'upload sur Roblox)
-- mets l’ID ici :
logoBtn.Image = "rbxassetid://YOUR_IMAGE_ID_HERE"



---------------------------------------------------------------------
--  DRAG SYSTEM
---------------------------------------------------------------------
local dragging = false
local dragStart, startPos

logoBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = logoBtn.Position
    end
end)

logoBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        logoBtn.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)



---------------------------------------------------------------------
--  PANEL DU MENU (BLEU FONCÉ + STROKE BLEU CLAIR)
---------------------------------------------------------------------
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 300, 0, 0) -- fermé au début
panel.Position = UDim2.new(0.05, 80, 0.4, 0)
panel.BackgroundColor3 = Color3.fromRGB(20, 40, 100) -- bleu foncé doux
panel.BorderSizePixel = 0

local corner = Instance.new("UICorner", panel)
corner.CornerRadius = UDim.new(0, 20)

local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(80, 140, 255) -- bleu clair
stroke.Thickness = 3

local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 10)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder
list.VerticalAlignment = Enum.VerticalAlignment.Top

panel.Visible = true



---------------------------------------------------------------------
--  FUNCTION BOUTONS STYLE LISSE
---------------------------------------------------------------------
local function MakeButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 70, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.Parent = panel
    btn.BorderSizePixel = 0

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 12)

    btn.MouseButton1Click:Connect(callback)
end



---------------------------------------------------------------------
--  MENU DÉROULANT
---------------------------------------------------------------------
local opened = false

local function toggleMenu()
    opened = not opened

    TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        Size = opened and UDim2.new(0, 300, 0, 250) or UDim2.new(0, 300, 0, 0)
    }):Play()
end

logoBtn.MouseButton1Click:Connect(toggleMenu)



---------------------------------------------------------------------
--  TES BOUTONS DEDANS
---------------------------------------------------------------------
MakeButton("Stealer", function() print("Stealer") end)
MakeButton("Instant TP", function() print("Instant TP") end)
MakeButton("Anti Hit", function() print("Anti Hit") end)

print("SxwHub Menu Loaded!")

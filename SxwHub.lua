--========================================================--
--                SxwHub – Modern Draggable UI            --
--========================================================--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Root
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
gui.Name = "SxwHubUI"

if syn and syn.protect_gui then syn.protect_gui(gui) end


------------------------------------------------------------
--                DRAG SYSTEM (MOBILE MENU)               --
------------------------------------------------------------
local function MakeDraggable(frame, dragButton)
    local dragging = false
    local dragStart, startPos

    dragButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            startPos = frame.Position
        end
    end)

    dragButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart

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
--                      ROOT HOLDER                       --
------------------------------------------------------------
local holder = Instance.new("Frame")
holder.Parent = gui
holder.Size = UDim2.new(0, 200, 0, 50)
holder.Position = UDim2.new(0.05, 0, 0.3, 0)
holder.BackgroundTransparency = 1


------------------------------------------------------------
--                  BOUTON PRINCIPAL SxwHub                --
------------------------------------------------------------
local mainBtn = Instance.new("TextButton")
mainBtn.Parent = holder
mainBtn.Size = UDim2.new(0, 150, 0, 45)
mainBtn.Position = UDim2.new(0, 0, 0, 0)
mainBtn.BackgroundColor3 = Color3.fromRGB(13, 27, 42)
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.Text = "SxwHub"
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextSize = 20
mainBtn.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner", mainBtn)
mainCorner.CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainBtn)
mainStroke.Color = Color3.fromRGB(80, 150, 255)
mainStroke.Thickness = 2


------------------------------------------------------------
--                     PANEL DÉROULANT                     --
------------------------------------------------------------
local panel = Instance.new("Frame")
panel.Parent = holder
panel.Size = UDim2.new(0, 150, 0, 0)
panel.Position = UDim2.new(0, 0, 0, 50)
panel.BackgroundColor3 = Color3.fromRGB(13, 27, 42)
panel.BorderSizePixel = 0
panel.ClipsDescendants = true

local pCorner = Instance.new("UICorner", panel)
pCorner.CornerRadius = UDim.new(0, 12)

local pStroke = Instance.new("UIStroke", panel)
pStroke.Color = Color3.fromRGB(80, 150, 255)
pStroke.Thickness = 2

local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 8)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.VerticalAlignment = Enum.VerticalAlignment.Top
list.SortOrder = Enum.SortOrder.LayoutOrder


------------------------------------------------------------
--                BOUTON CRÉATEUR D'OPTIONS                --
------------------------------------------------------------
local function AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = panel
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 65, 120)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.BorderSizePixel = 0

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(callback)
end


------------------------------------------------------------
--                     OPTIONS DU MENU                     --
------------------------------------------------------------
AddButton("Auto Steal", function() print("Auto Steal") end)
AddButton("Tp Base", function() print("Tp Base") end)
AddButton("AntiHit", function() print("AntiHit") end)


------------------------------------------------------------
--             ANIMATION DU MENU (OUVERT/FERME)            --
------------------------------------------------------------
local opened = false

local function ToggleMenu()
    opened = not opened

    TweenService:Create(
        panel,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad),
        { Size = opened and UDim2.new(0, 150, 0, 140) or UDim2.new(0, 150, 0, 0) }
    ):Play()
end

mainBtn.MouseButton1Click:Connect(ToggleMenu)


------------------------------------------------------------
--                 RENDRE LE MENU MOBILE                   --
------------------------------------------------------------
MakeDraggable(holder, mainBtn)

print("SxwHub UI Loaded ✔")

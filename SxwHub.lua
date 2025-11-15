--========================================================--
--              GHOSTFACE UI - WINDOWS BLUE               --
--========================================================--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI root
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
gui.Name = "GhostFaceUI"

if syn and syn.protect_gui then syn.protect_gui(gui) end


------------------------------------------------------------
--                    DRAGGING FUNCTION                    --
------------------------------------------------------------
local function MakeDraggable(frame, dragbutton)
    local dragging = false
    local dragStart
    local startPos

    dragbutton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    dragbutton.InputEnded:Connect(function(input)
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
--                    GHOSTFACE BUTTON                     --
------------------------------------------------------------
local logo = Instance.new("ImageButton")
logo.Parent = gui
logo.Size = UDim2.new(0, 70, 0, 70)
logo.Position = UDim2.new(0.05, 0, 0.4, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://PUT_YOUR_IMAGE_ID_HERE"  -- MET TON ID ICI
logo.AutoButtonColor = false

local logoCorner = Instance.new("UICorner", logo)
logoCorner.CornerRadius = UDim.new(1, 0)


------------------------------------------------------------
--                    MAIN PANEL (CARRE ARRONDI)          --
------------------------------------------------------------
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 280, 0, 0)   -- fermé au début
panel.Position = UDim2.new(0.05, 80, 0.4, 0)
panel.BackgroundColor3 = Color3.fromRGB(13, 27, 42) -- Bleu foncé Windows
panel.BorderSizePixel = 0
panel.ClipsDescendants = true

local pCorner = Instance.new("UICorner", panel)
pCorner.CornerRadius = UDim.new(0, 22)

local pStroke = Instance.new("UIStroke", panel)
pStroke.Thickness = 3
pStroke.Color = Color3.fromRGB(80, 150, 255) -- Bleu clair moderne


------------------------------------------------------------
--                        MENU LIST                       --
------------------------------------------------------------
local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 10)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder
list.VerticalAlignment = Enum.VerticalAlignment.Top


------------------------------------------------------------
--                   BOUTONS DU PANEL                     --
------------------------------------------------------------
local function CreateButton(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = panel
    btn.Size = UDim2.new(1, -30, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(25, 65, 120)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = txt
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 12)

    btn.MouseButton1Click:Connect(callback)
end


CreateButton("Option 1", function() print("Clicked 1") end)
CreateButton("Option 2", function() print("Clicked 2") end)
CreateButton("Option 3", function() print("Clicked 3") end)


------------------------------------------------------------
--              MENU OPEN / CLOSE ANIMATION               --
------------------------------------------------------------
local opened = false

local function ToggleMenu()
    opened = not opened

    TweenService:Create(
        panel,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad),
        { Size = opened and UDim2.new(0, 280, 0, 220) or UDim2.new(0, 280, 0, 0) }
    ):Play()
end

logo.MouseButton1Click:Connect(ToggleMenu)


------------------------------------------------------------
--             MAKE MENU + LOGO DRAGGABLE TOGETHER        --
------------------------------------------------------------
local holder = Instance.new("Frame", gui)
holder.Size = UDim2.new(0, 1, 0, 1)
holder.BackgroundTransparency = 1

logo.Parent = holder
panel.Parent = holder

MakeDraggable(holder, logo)


------------------------------------------------------------
print("SxwHub Loaded successfully.")

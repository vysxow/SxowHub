--========================================================--
--             SxwHub – Modern UI + Notifications         --
--========================================================--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
gui.Name = "SxwHubUI"
if syn and syn.protect_gui then syn.protect_gui(gui) end


------------------------------------------------------------
--                     DRAGGING SYSTEM                     --
------------------------------------------------------------
local function MakeDraggable(frame, dragButton)
    local dragging, dragStart, startPos = false, nil, nil

    dragButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
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
--                        HOLDER                           --
------------------------------------------------------------
local holder = Instance.new("Frame")
holder.Parent = gui
holder.Size = UDim2.new(0, 200, 0, 50)
holder.Position = UDim2.new(0.5, -100, 0.2, 0)  -- placé proprement au centre
holder.BackgroundTransparency = 1


------------------------------------------------------------
--                     MAIN BUTTON                         --
------------------------------------------------------------
local mainBtn = Instance.new("TextButton")
mainBtn.Parent = holder
mainBtn.Size = UDim2.new(0, 180, 0, 45)
mainBtn.Position = UDim2.new(0.5, -90, 0, 0)
mainBtn.BackgroundColor3 = Color3.fromRGB(13, 27, 42)
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.Text = "SxwHub"
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextSize = 20
mainBtn.BorderSizePixel = 0

Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", mainBtn)
mainStroke.Color = Color3.fromRGB(80, 150, 255)
mainStroke.Thickness = 2


------------------------------------------------------------
--                     DROP-DOWN PANEL                     --
------------------------------------------------------------
local panel = Instance.new("Frame")
panel.Parent = holder
panel.Size = UDim2.new(0, 180, 0, 0)
panel.Position = UDim2.new(0.5, -90, 0, 55)
panel.BackgroundColor3 = Color3.fromRGB(13, 27, 42)
panel.BorderSizePixel = 0
panel.ClipsDescendants = true

Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
local pStroke = Instance.new("UIStroke", panel)
pStroke.Color = Color3.fromRGB(80, 150, 255)
pStroke.Thickness = 2

local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 8)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.VerticalAlignment = Enum.VerticalAlignment.Top
list.SortOrder = Enum.SortOrder.LayoutOrder


------------------------------------------------------------
--                    NOTIFICATION SYSTEM                  --
------------------------------------------------------------
local function Notify(msg)
    local notif = Instance.new("TextLabel")
    notif.Parent = gui
    notif.Size = UDim2.new(0, 260, 0, 40)
    notif.Position = UDim2.new(0.5, -130, 1, -80)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.Text = msg
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 18
    notif.BorderSizePixel = 0

    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)

    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 1, -120)}):Play()
    task.wait(1.8)
    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -130, 1, -60)}):Play()
    task.wait(0.2)
    notif:Destroy()
end


------------------------------------------------------------
--                     MENU BUTTON CREATOR                 --
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

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        Notify(text .. " activé ✔")
        callback()
    end)
end


------------------------------------------------------------
--                     MENU OPTIONS                        --
------------------------------------------------------------
AddButton("Auto Steal", function() print("Auto Steal") end)
AddButton("Tp Base", function() print("Tp Base") end)
AddButton("AntiHit", function() print("AntiHit") end)


------------------------------------------------------------
--                  MENU OPEN / CLOSE                     --
------------------------------------------------------------
local opened = false

local function ToggleMenu()
    opened = not opened

    TweenService:Create(
        panel,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad),
        {Size = opened and UDim2.new(0, 180, 0, 150) or UDim2.new(0, 180, 0, 0)}
    ):Play()
end

mainBtn.MouseButton1Click:Connect(ToggleMenu)


------------------------------------------------------------
--                      MAKE DRAGGABLE                    --
------------------------------------------------------------
MakeDraggable(holder, mainBtn)

print("SxwHub UI Loaded ✔")

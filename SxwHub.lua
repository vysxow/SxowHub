--// Sxw Hub Menu Amélioré
local gui = Instance.new("ScreenGui")
gui.Name = "SxwMenu"
gui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(gui) end
gui.Parent = game:GetService("CoreGui")

-- Main Toggle Button
local button = Instance.new("TextButton")
button.Parent = gui
button.Size = UDim2.new(0, 70, 0, 40)
button.Position = UDim2.new(0.05, 0, 0.4, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Sxw"
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.BorderSizePixel = 0

-- Menu Frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 220, 0, 180)
frame.Position = UDim2.new(0.05, 0, 0.48, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false
frame.BorderSizePixel = 0
frame.ClipsDescendants = true

-- Function to create menu buttons
local function MakeBtn(name, y)
    local b = Instance.new("TextButton")
    b.Parent = frame
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Position = UDim2.new(0, 5, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.Text = name
    b.BorderSizePixel = 0

    local active = false
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = active and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    end)
    b.MouseButton1Click:Connect(function()
        active = not active
        b.Text = active and name .. " ✓" or name
        b.BackgroundColor3 = active and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    end)
end

MakeBtn("Stealer", 5)
MakeBtn("Instant TP", 50)
MakeBtn("Anti Hit", 95)

-- Toggle Menu
button.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

print("Sxw Hub Menu Loaded")


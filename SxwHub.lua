--// Universal Visual Script "Sxw Menu"
--// Works on any Roblox Executor (Delta, Hydrogen, Arceus X, Vega X, Synapse, etc.)

local gui = Instance.new("ScreenGui")
gui.Name = "SxwMenu"
gui.ResetOnSpawn = false
if syn and syn.protect_gui then
    syn.protect_gui(gui)
end
gui.Parent = game:GetService("CoreGui")

-- Main Toggle Button
local button = Instance.new("TextButton")
button.Parent = gui
button.Size = UDim2.new(0, 65, 0, 40)
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
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0.05, 0, 0.48, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.BorderSizePixel = 0

-- Function to create menu options
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
    b.MouseButton1Click:Connect(function()
        b.Text = name .. " ✓ "
    end)
end

MakeBtn("Stealer ", 5)
MakeBtn("Instant TP ", 50)
MakeBtn("Anti Hit ", 95)

-- Toggle Menu
button.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

print("Sxw Hub Menu Loaded ")

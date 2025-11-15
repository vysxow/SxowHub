-- Sxw Hub Menu Modern UI
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui")
gui.Name = "SxwHubModern"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Protection pour Synapse / autres exploiters
if syn and syn.protect_gui then
    syn.protect_gui(gui)
end

-- Fonction utilitaire pour créer des boutons stylés
local function MakeBtn(name, y, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = name
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false

    -- Coin arrondi
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    -- Hover animation
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    -- Click event
    btn.MouseButton1Click:Connect(callback)
end

-- Cadre principal
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Bouton principal
local mainBtn = Instance.new("TextButton")
mainBtn.Parent = gui
mainBtn.Size = UDim2.new(0, 70, 0, 40)
mainBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
mainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextSize = 20
mainBtn.Text = "Sxw"
mainBtn.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainBtn

-- Toggle menu
mainBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Ajouter les boutons d’options
MakeBtn("Stealer", 10, frame, function()
    print("Stealer clicked")
end)
MakeBtn("Instant TP", 60, frame, function()
    print("Instant TP clicked")
end)
MakeBtn("Anti Hit", 110, frame, function()
    print("Anti Hit clicked")
end)

print("Sxw Hub Modern UI Loaded")


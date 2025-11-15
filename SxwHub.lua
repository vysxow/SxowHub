-- Universal Visual Script "Sxw Menu"
-- Fonctionne sur plusieurs exploiters (Delta, Hydrogen, …)

local gui = Instance.new("ScreenGui")
gui.Name = "SxwMenu"
gui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(gui)
end

gui.Parent = game:GetService("CoreGui")

-- Bouton principal pour ouvrir/fermer le menu
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

-- Cadre du menu
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0.05, 0, 0.48, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = false

-- Fonction pour créer un bouton d’option dans le menu
local function MakeBtn(name, y)
    local btnOption = Instance.new("TextButton")
    btnOption.Parent = frame
    btnOption.Size = UDim2.new(1, -10, 0, 40)
    btnOption.Position = UDim2.new(0, 5, 0, y)
    btnOption.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btnOption.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnOption.Font = Enum.Font.GothamBold
    btnOption.TextSize = 16
    btnOption.Text = name
    btnOption.BorderSizePixel = 0

    btnOption.MouseButton1Click:Connect(function()
        btnOption.Text = name .. " ✓"
        -- Ici tu peux ajouter la logique quand on clique sur ce bouton
    end)
end

-- Création des options du menu
MakeBtn("Stealer", 5)
MakeBtn("Instant TP", 50)
MakeBtn("Anti Hit", 95)

-- Toggle du menu via le bouton principal
button.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

print("Sxw Hub Menu Loaded")


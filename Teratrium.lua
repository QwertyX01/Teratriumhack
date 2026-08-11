-- Teratrium Hub Menu (как на скриншоте)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Toggle-кнопка
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 25)
toggleBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BackgroundTransparency = 0
toggleBtn.BorderSizePixel = 1
toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "Toggle"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextWrapped = true
toggleBtn.Parent = screenGui

-- ОСНОВНОЕ МЕНЮ (как на скриншоте)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 400) -- пропорции как на скрине
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22) -- ТЕМНО-СЕРЫЙ/ЧЕРНЫЙ как на скрине
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- СКРУГЛЕНИЕ УГЛОВ (радиус 8px как на скрине)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- ХЕДЕР (фиолетово-розовая полоска как на скрине)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(180, 50, 255) -- ФИОЛЕТОВО-РОЗОВЫЙ (#b432ff)
header.BackgroundTransparency = 0
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Название "Teratrium" в хедере (как на скрине)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
titleLabel.Position = UDim2.new(0.5, -90, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teratrium"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = header

-- СКРУГЛЕНИЕ ДЛЯ ХЕДЕРА (только верхние углы)
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Отрезаем нижние углы у хедера (чтобы не скруглялись внизу)
local headerClip = Instance.new("Frame")
headerClip.Size = UDim2.new(1, 0, 0.5, 0)
headerClip.Position = UDim2.new(0, 0, 0.5, 0)
headerClip.BackgroundTransparency = 1
headerClip.ClipsDescendants = true
headerClip.Parent = header

-- Перемещаем titleLabel внутрь clip
titleLabel.Parent = headerClip

-- Toggle открыть/закрыть
local menuVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
end)

-- Перетаскивание Toggle-кнопки
local draggingToggle = false
local dragToggleStart, toggleStartPos

local function onToggleInputBegan(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = true
        dragToggleStart = input.Position
        toggleStartPos = toggleBtn.Position
    end
end

local function onToggleInputChanged(input)
    if draggingToggle and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragToggleStart
        toggleBtn.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
    end
end

local function onToggleInputEnded(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = false
    end
end

UserInputService.InputBegan:Connect(onToggleInputBegan)
UserInputService.InputChanged:Connect(onToggleInputChanged)
UserInputService.InputEnded:Connect(onToggleInputEnded)

-- Перетаскивание меню (только за хедер)
local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

header.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ Teratrium Hub загружен! Нажми Toggle для открытия меню.")

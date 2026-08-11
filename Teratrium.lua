-- Teratrium Hub Menu (с Toggle-кнопкой)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Toggle-кнопка (маленькая, темная, с белой обводкой)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 25)
toggleBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40) -- темный
toggleBtn.BackgroundTransparency = 0
toggleBtn.BorderSizePixel = 1
toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255) -- белая обводка
toggleBtn.Text = "Toggle"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.SourceSans -- НЕ ЖИРНЫЙ
toggleBtn.TextWrapped = true
toggleBtn.Parent = screenGui

-- Основное окно (СКРЫТО по умолчанию)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 640, 0, 470)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -235)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 40) -- ТЕМНЫЙ, НО НЕ ПОЛНОСТЬЮ (#141628)
mainFrame.BackgroundTransparency = 0 -- БЕЗ ПРОЗРАЧНОСТИ
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(120, 120, 120)
mainFrame.ClipsDescendants = true
mainFrame.Visible = false -- Скрыто
mainFrame.Parent = screenGui

-- Хедер (СЕРАЯ ПОЛОСКА)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Teratrium в правом углу
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 120, 0, 20)
titleLabel.Position = UDim2.new(1, -130, 0.5, -10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teratrium"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.SourceSans
titleLabel.TextXAlignment = Enum.TextXAlignment.Right
titleLabel.Parent = header

-- Toggle (открыть/закрыть меню)
local menuVisible = false

toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
end)

-- Перетаскивание Toggle-кнопки пальцем
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

-- Перетаскивание самого меню (только за хедер)
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

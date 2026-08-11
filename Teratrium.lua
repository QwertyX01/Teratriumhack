-- Teratrium Hub Menu (чистый, без анимаций)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 640, 0, 470)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -235)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 50) -- темно-синий, но не полностью
mainFrame.BackgroundTransparency = 0.15 -- прозрачный
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(120, 120, 120)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Хедер (СЕРАЯ ПОЛОСКА, НЕ ЦВЕТ!)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(169, 169, 169) -- серый
header.BackgroundTransparency = 0.3 -- полупрозрачный
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Teratrium в правом углу (маленький, не жирный)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 120, 0, 20)
titleLabel.Position = UDim2.new(1, -130, 0.5, -10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teratrium"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.SourceSans -- НЕ ЖИРНЫЙ
titleLabel.TextXAlignment = Enum.TextXAlignment.Right
titleLabel.Parent = header

-- КНОПКА ЗАКРЫТИЯ УБРАНА (красная хуйня в левом углу)

-- Перетаскивание пальцем (мобилка)
local dragging = false
local dragStart, startPos

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end

local function onInputChanged(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end

UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputChanged:Connect(onInputChanged)
UserInputService.InputEnded:Connect(onInputEnded)

print("✅ Teratrium Hub загружен!")

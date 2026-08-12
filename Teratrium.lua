-- Teratrium Hub - МИНИМАЛЬНАЯ ВЕРСИЯ (для проверки открытия)
local player = game:GetService("Players").LocalPlayer

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Кнопка Toggle
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 30)
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

-- СКРУГЛЕНИЕ УГЛОВ КНОПКИ
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleBtn

-- Меню (простое, без вкладок)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 4)
mainCorner.Parent = mainFrame

-- Простой текст в меню
local testLabel = Instance.new("TextLabel")
testLabel.Size = UDim2.new(1, 0, 1, 0)
testLabel.BackgroundTransparency = 1
testLabel.Text = "МЕНЮ ОТКРЫЛОСЬ!"
testLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
testLabel.TextSize = 24
testLabel.Font = Enum.Font.GothamBold
testLabel.TextXAlignment = Enum.TextXAlignment.Center
testLabel.TextYAlignment = Enum.TextYAlignment.Center
testLabel.Parent = mainFrame

-- ============================================================
--  ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ ПО НАЖАТИЮ НА TOGGLE
-- ============================================================
local menuVisible = false

toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
    print("Меню открыто: " .. tostring(menuVisible))
    if menuVisible then
        testLabel.Text = "✅ МЕНЮ ОТКРЫЛОСЬ! (Нажми Toggle ещё раз, чтобы закрыть)"
    else
        testLabel.Text = "❌ МЕНЮ ЗАКРЫЛОСЬ!"
    end
end)

-- ============================================================
--  ПЕРЕТАСКИВАНИЕ Toggle КНОПКИ (для удобства)
-- ============================================================
local draggingToggle = false
local dragToggleStart, toggleStartPos

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = true
        dragToggleStart = input.Position
        toggleStartPos = toggleBtn.Position
    end
end)

toggleBtn.InputChanged:Connect(function(input)
    if draggingToggle and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragToggleStart
        if delta.Magnitude > 5 then
            toggleBtn.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
        end
    end
end)

toggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = false
    end
end)

print("✅ ТЕСТОВАЯ ВЕРСИЯ загружена! Нажми Toggle для открытия меню.")

-- Teratrium Hub Menu
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Основное окно (скрыто до анимации)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 640, 0, 470)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -235)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 45) -- темно-синий
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(120, 120, 120)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Хедер (серая полоска)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Логотип в хедере (БЕЗ RICHTEXT - два отдельных TextLabel)
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(0.5, 0, 1, 0)
titleContainer.Position = UDim2.new(0.25, 0, 0, 0)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = header

-- Terarium (белый)
local part1 = Instance.new("TextLabel")
part1.Size = UDim2.new(0.65, 0, 1, 0)
part1.Position = UDim2.new(0, 0, 0, 0)
part1.BackgroundTransparency = 1
part1.Text = "Terarium"
part1.TextColor3 = Color3.fromRGB(255, 255, 255)
part1.TextScaled = true
part1.Font = Enum.Font.GothamBold
part1.TextWrapped = true
part1.Parent = titleContainer

-- Hub (розовый)
local part2 = Instance.new("TextLabel")
part2.Size = UDim2.new(0.35, 0, 1, 0)
part2.Position = UDim2.new(0.65, 0, 0, 0)
part2.BackgroundTransparency = 1
part2.Text = "Hub"
part2.TextColor3 = Color3.fromRGB(255, 107, 157) -- #ff6b9d
part2.TextScaled = true
part2.Font = Enum.Font.GothamBold
part2.TextWrapped = true
part2.Parent = titleContainer

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BackgroundTransparency = 0.5
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

closeBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
    wait(0.3)
    mainFrame.Visible = false
end)

-- Текст "hello, by sxripter" (появляется по середине)
local helloLabel = Instance.new("TextLabel")
helloLabel.Size = UDim2.new(1, 0, 1, 0)
helloLabel.Position = UDim2.new(0, 0, 0, 0)
helloLabel.BackgroundTransparency = 1
helloLabel.Text = "hello, by sxripter"
helloLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
helloLabel.TextSize = 30
helloLabel.Font = Enum.Font.GothamBold
helloLabel.TextStrokeTransparency = 0.5
helloLabel.TextWrapped = true
helloLabel.ZIndex = 10
helloLabel.Parent = mainFrame

-- Анимация приветствия
helloLabel.TextTransparency = 1
local fadeInHello = TweenService:Create(helloLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
fadeInHello:Play()

-- После приветствия плавно появляется меню
wait(1.5)

-- Исчезновение hello
local fadeOutHello = TweenService:Create(helloLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
    TextTransparency = 1
})
fadeOutHello:Play()

-- Появление меню
wait(0.3)
local showMenu = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0
})
showMenu:Play()

-- Перетаскивание меню
local dragging = false
local dragInput, dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("✅ Teratrium Hub загружен!")

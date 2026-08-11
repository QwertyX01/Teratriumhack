-- Teratrium Hub Menu (полностью черный хедер и меню)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ============================================================
--  ЗАГРУЗКА ЛОГОТИПА
-- ============================================================
local imageUrl = "https://i.ibb.co/nNMK31JC/Chat-GPT-Image-11-2026-15-15-20.png"
local fileName = "teratrium_logo.png"
local filePath = fileName

local function fileExists(path)
    local success, result = pcall(function() return loadfile(path) end)
    return success and result ~= nil
end

if not fileExists(filePath) then
    print("📥 Скачиваем логотип Teratrium...")
    local success, content = pcall(function() return game:HttpGet(imageUrl, true) end)
    if success and content then
        local writeSuccess, err = pcall(function() writefile(filePath, content) end)
        if writeSuccess then
            print("✅ Логотип сохранён: " .. filePath)
        else
            warn("⚠️ Не удалось сохранить файл: " .. tostring(err))
        end
    else
        warn("⚠️ Не удалось скачать картинку")
    end
else
    print("✅ Логотип уже есть на диске.")
end

local logoPath = nil
if getcustomasset then
    logoPath = getcustomasset(filePath)
elseif getgenv().getcustomasset then
    logoPath = getgenv().getcustomasset(filePath)
end

-- ============================================================
--  GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeratriumHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- КОНТЕЙНЕР ДЛЯ TOGGLE
local toggleContainer = Instance.new("Frame")
toggleContainer.Size = UDim2.new(0, 60, 0, 25)
toggleContainer.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleContainer.BackgroundTransparency = 1
toggleContainer.Parent = screenGui

-- Toggle-кнопка
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, 0, 1, 0)
toggleBtn.Position = UDim2.new(0, 0, 0, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BackgroundTransparency = 0
toggleBtn.BorderSizePixel = 1
toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "Toggle"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextWrapped = true
toggleBtn.Parent = toggleContainer

-- ОСНОВНОЕ МЕНЮ (ЧЕРНОЕ)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- ПОЛНОСТЬЮ ЧЕРНЫЙ
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- ХЕДЕР (ЧЕРНЫЙ)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- ПОЛНОСТЬЮ ЧЕРНЫЙ
header.BackgroundTransparency = 0 -- УБРАЛ ПРОЗРАЧНОСТЬ
header.BorderSizePixel = 0
header.Parent = mainFrame

-- ЛОГОТИП (ЗАГРУЖЕННЫЙ)
if logoPath then
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 24, 0, 24)
    logo.Position = UDim2.new(0, 4, 0.5, -12)
    logo.BackgroundTransparency = 1
    logo.Image = logoPath
    logo.ZIndex = 15
    logo.Parent = header
    local lc = Instance.new("UICorner")
    lc.CornerRadius = UDim.new(0, 4)
    lc.Parent = logo
else
    -- Заглушка "T" если логотип не загрузился
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 24, 0, 24)
    iconFrame.Position = UDim2.new(0, 4, 0.5, -12)
    iconFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    iconFrame.BackgroundTransparency = 0
    iconFrame.BorderSizePixel = 1
    iconFrame.BorderColor3 = Color3.fromRGB(255, 50, 150)
    iconFrame.Parent = header

    local iconText = Instance.new("TextLabel")
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.Position = UDim2.new(0, 0, 0, 0)
    iconText.BackgroundTransparency = 1
    iconText.Text = "T"
    iconText.TextColor3 = Color3.fromRGB(255, 50, 150)
    iconText.TextSize = 16
    iconText.Font = Enum.Font.GothamBold
    iconText.TextWrapped = true
    iconText.Parent = iconFrame
end

-- КОНТЕЙНЕР ДЛЯ НАЗВАНИЯ
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(0, 200, 1, 0)
titleContainer.Position = UDim2.new(0, 34, 0, 0)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = header

-- Tetrarium (белый)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 95, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Tetrarium"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = titleContainer

-- . (точка) - РОЗОВАЯ
local dotLabel = Instance.new("TextLabel")
dotLabel.Size = UDim2.new(0, 10, 1, 0)
dotLabel.Position = UDim2.new(0, 95, 0, 0)
dotLabel.BackgroundTransparency = 1
dotLabel.Text = "."
dotLabel.TextColor3 = Color3.fromRGB(255, 50, 150)
dotLabel.TextSize = 14
dotLabel.Font = Enum.Font.Gotham
dotLabel.TextXAlignment = Enum.TextXAlignment.Center
dotLabel.TextYAlignment = Enum.TextYAlignment.Center
dotLabel.Parent = titleContainer

-- hub (РОЗОВЫЙ)
local hubLabel = Instance.new("TextLabel")
hubLabel.Size = UDim2.new(0, 40, 1, 0)
hubLabel.Position = UDim2.new(0, 105, 0, 0)
hubLabel.BackgroundTransparency = 1
hubLabel.Text = "hub"
hubLabel.TextColor3 = Color3.fromRGB(255, 50, 150)
hubLabel.TextSize = 14
hubLabel.Font = Enum.Font.Gotham
hubLabel.TextXAlignment = Enum.TextXAlignment.Left
hubLabel.TextYAlignment = Enum.TextYAlignment.Center
hubLabel.Parent = titleContainer

-- РАЗДЕЛИТЕЛЬНАЯ ПОЛОСКА (РОЗОВАЯ, 1px)
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 1)
separator.Position = UDim2.new(0, 0, 1, 0)
separator.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
separator.BackgroundTransparency = 0
separator.BorderSizePixel = 0
separator.Parent = header

-- ПЕРЕТАСКИВАНИЕ TOGGLE
local draggingToggle = false
local dragToggleStart, toggleStartPos

toggleContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = true
        dragToggleStart = input.Position
        toggleStartPos = toggleContainer.Position
    end
end)

toggleContainer.InputChanged:Connect(function(input)
    if draggingToggle and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragToggleStart
        toggleContainer.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
    end
end)

toggleContainer.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = false
    end
end)

-- Toggle открыть/закрыть
local menuVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
    print("Меню: " .. tostring(menuVisible))
end)

-- Перетаскивание меню
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

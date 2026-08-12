-- Teratrium Hub (ЧИСТАЯ ВЕРСИЯ - без ошибок Canvas)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ============================================================
--  ЗАГРУЗКА ЛОГОТИПА
-- ============================================================
local logoUrl = "https://i.ibb.co/nNMK31JC/Chat-GPT-Image-11-2026-15-15-20.png"
local logoFileName = "teratrium_logo.png"
local logoFilePath = logoFileName

local function fileExists(path)
    local success, result = pcall(function() return loadfile(path) end)
    return success and result ~= nil
end

if not fileExists(logoFilePath) then
    print("📥 Скачиваем логотип Teratrium...")
    local success, content = pcall(function() return game:HttpGet(logoUrl, true) end)
    if success and content then
        local writeSuccess, err = pcall(function() writefile(logoFilePath, content) end)
        if writeSuccess then
            print("✅ Логотип сохранён: " .. logoFilePath)
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
    logoPath = getcustomasset(logoFilePath)
elseif getgenv().getcustomasset then
    logoPath = getgenv().getcustomasset(logoFilePath)
end

-- ============================================================
--  ЗАГРУЗКА ИКОНКИ ДЛЯ VIS
-- ============================================================
local visIconUrl = "https://i.ibb.co/mr3sFCgr/12786.png"
local visIconFileName = "vis_icon.png"
local visIconFilePath = visIconFileName

if not fileExists(visIconFilePath) then
    print("📥 Скачиваем иконку для VIS...")
    local success, content = pcall(function() return game:HttpGet(visIconUrl, true) end)
    if success and content then
        local writeSuccess, err = pcall(function() writefile(visIconFilePath, content) end)
        if writeSuccess then
            print("✅ Иконка VIS сохранена: " .. visIconFilePath)
        else
            warn("⚠️ Не удалось сохранить иконку VIS: " .. tostring(err))
        end
    else
        warn("⚠️ Не удалось скачать иконку VIS")
    end
else
    print("✅ Иконка VIS уже есть на диске.")
end

local visIconPath = nil
if getcustomasset then
    visIconPath = getcustomasset(visIconFilePath)
elseif getgenv().getcustomasset then
    visIconPath = getgenv().getcustomasset(visIconFilePath)
end

-- ============================================================
--  ЗАГРУЗКА ИКОНКИ ДЛЯ COM
-- ============================================================
local comIconUrl = "https://i.ibb.co/WvKshzS7/crosshair-2.jpg"
local comIconFileName = "com_icon.jpg"
local comIconFilePath = comIconFileName

if not fileExists(comIconFilePath) then
    print("📥 Скачиваем иконку для COM...")
    local success, content = pcall(function() return game:HttpGet(comIconUrl, true) end)
    if success and content then
        local writeSuccess, err = pcall(function() writefile(comIconFilePath, content) end)
        if writeSuccess then
            print("✅ Иконка COM сохранена: " .. comIconFilePath)
        else
            warn("⚠️ Не удалось сохранить иконку COM: " .. tostring(err))
        end
    else
        warn("⚠️ Не удалось скачать иконку COM")
    end
else
    print("✅ Иконка COM уже есть на диске.")
end

local comIconPath = nil
if getcustomasset then
    comIconPath = getcustomasset(comIconFilePath)
elseif getgenv().getcustomasset then
    comIconPath = getgenv().getcustomasset(comIconFilePath)
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

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleBtn

-- ОСНОВНОЕ МЕНЮ
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

-- ХЕДЕР
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
header.BackgroundTransparency = 0
header.BorderSizePixel = 0
header.Parent = mainFrame

-- ЛОГОТИП
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
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 24, 0, 24)
    iconFrame.Position = UDim2.new(0, 4, 0.5, -12)
    iconFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    iconFrame.BackgroundTransparency = 0
    iconFrame.BorderSizePixel = 1
    iconFrame.BorderColor3 = Color3.fromRGB(255, 50, 150)
    iconFrame.Parent = header
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 4)
    iconCorner.Parent = iconFrame

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

-- НАЗВАНИЕ
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 34, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teratrium.Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Parent = header

-- РАЗДЕЛИТЕЛЬНАЯ ПОЛОСКА
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 1)
separator.Position = UDim2.new(0, 0, 1, 0)
separator.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
separator.BackgroundTransparency = 0
separator.BorderSizePixel = 0
separator.Parent = header

-- ============================================================
--  ВКЛАДКИ
-- ============================================================
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(0, 60, 0, 200)
tabsContainer.Position = UDim2.new(0, 10, 0, 45)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = mainFrame

local tabNames = {"VIS", "COM", "MISC"}
local tabButtons = {}
local tabContents = {}

local function animateTab(btn, isActive)
    local targetSize = isActive and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 44, 0, 44)
    local targetColor = isActive and Color3.fromRGB(40, 40, 45) or Color3.fromRGB(20, 20, 25)
    local targetBorder = isActive and Color3.fromRGB(255, 50, 150) or Color3.fromRGB(80, 80, 80)
    
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(btn, tweenInfo, {Size = targetSize}):Play()
    TweenService:Create(btn, tweenInfo, {BackgroundColor3 = targetColor}):Play()
    TweenService:Create(btn, tweenInfo, {BorderColor3 = targetBorder}):Play()
end

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 44)
    btn.Position = UDim2.new(0, 0, 0, (i-1) * 55)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    btn.Text = ""
    btn.Parent = tabsContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    if name == "VIS" and visIconPath then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 28, 0, 28)
        icon.Position = UDim2.new(0.5, -14, 0.5, -14)
        icon.BackgroundTransparency = 1
        icon.Image = visIconPath
        icon.ScaleType = Enum.ScaleType.Fit
        icon.Parent = btn
    elseif name == "COM" and comIconPath then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 28, 0, 28)
        icon.Position = UDim2.new(0.5, -14, 0.5, -14)
        icon.BackgroundTransparency = 1
        icon.Image = comIconPath
        icon.ScaleType = Enum.ScaleType.Fit
        icon.Parent = btn
    else
        btn.Text = name
    end
    
    -- КОНТЕНТ ВКЛАДКИ (простой Frame, без ScrollingFrame)
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -80, 1, -55)
    content.Position = UDim2.new(0, 75, 0, 45)
    content.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    content.BackgroundTransparency = 0
    content.BorderSizePixel = 1
    content.BorderColor3 = Color3.fromRGB(30, 30, 30)
    content.Visible = (i == 1)
    content.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 4)
    contentCorner.Parent = content
    
    -- Если вкладка VIS - добавляем элементы
    if name == "VIS" then
        -- Розовый разделитель сверху
        local topSeparator = Instance.new("Frame")
        topSeparator.Size = UDim2.new(0.9, 0, 0, 1)
        topSeparator.Position = UDim2.new(0.05, 0, 0.02, 0)
        topSeparator.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
        topSeparator.BackgroundTransparency = 0
        topSeparator.BorderSizePixel = 0
        topSeparator.Parent = content
        
        -- Белый глаз в левом углу
        local eyeIcon = Instance.new("ImageLabel")
        eyeIcon.Size = UDim2.new(0, 28, 0, 28)
        eyeIcon.Position = UDim2.new(0.02, 0, 0.08, 0)
        eyeIcon.BackgroundTransparency = 1
        eyeIcon.Image = "rbxassetid://6031091139"
        eyeIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        eyeIcon.ScaleType = Enum.ScaleType.Fit
        eyeIcon.Parent = content
        
        -- Розовый разделитель по середине
        local midSeparator = Instance.new("Frame")
        midSeparator.Size = UDim2.new(0.9, 0, 0, 1)
        midSeparator.Position = UDim2.new(0.05, 0, 0.3, 0)
        midSeparator.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
        midSeparator.BackgroundTransparency = 0
        midSeparator.BorderSizePixel = 0
        midSeparator.Parent = content
    end
    
    tabContents[name] = content
    tabButtons[name] = btn
    
    btn.MouseButton1Click:Connect(function()
        for n, b in pairs(tabButtons) do
            animateTab(b, n == name)
            tabContents[n].Visible = (n == name)
        end
    end)
end

animateTab(tabButtons["VIS"], true)

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

local menuVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
    print("Меню: " .. tostring(menuVisible))
end)

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

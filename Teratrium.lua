local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Функция для безопасного выполнения кода
local function safeExecute(func)
    local success, err = pcall(func)
    if not success then
        warn("Ошибка: " .. tostring(err))
    end
    return success
end

safeExecute(function()
    -- Создаём ScreenGui для загрузки
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MenuGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- ЭКРАН ЗАГРУЗКИ
    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Name = "LoadingLabel"
    loadingLabel.Size = UDim2.new(1, 0, 1, 0)
    loadingLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Чёрный фон
    loadingLabel.BackgroundTransparency = 0.3
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
    loadingLabel.TextSize = 72
    loadingLabel.Font = Enum.Font.GothamBold
    loadingLabel.Text = "Teratrium"
    loadingLabel.TextTransparency = 1 -- Изначально невидимо
    loadingLabel.Parent = screenGui

    -- Анимация появления текста (fade in)
    local tweenInfo = TweenInfo.new(
        2, -- Длительность 2 секунды
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.InOut
    )
    local tween = TweenService:Create(loadingLabel, tweenInfo, {TextTransparency = 0})
    tween:Play()

    -- Ждём завершения анимации появления
    tween.Completed:Connect(function()
        wait(1) -- Держим текст видимым 1 секунду

        -- Анимация исчезновения текста (fade out)
        local tweenOut = TweenService:Create(loadingLabel, tweenInfo, {TextTransparency = 1})
        tweenOut:Play()

        tweenOut.Completed:Connect(function()
            loadingLabel:Destroy() -- Удаляем экран загрузки

            -- СОЗДАНИЕ ОСНОВНОГО МЕНЮ
            local menu = Instance.new("Frame")
            menu.Name = "Menu"
            menu.Size = UDim2.new(0, 670, 0, 420)
            menu.Position = UDim2.new(0.5, -335, 0.5, -210)
            menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            menu.BorderColor3 = Color3.fromRGB(200, 200, 200)
            menu.BorderSizePixel = 1
            menu.BackgroundTransparency = 1 -- Невидимо перед анимацией
            menu.Parent = screenGui

            -- Скругленные углы меню
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 15)
            corner.Parent = menu

            -- ХЕДЕР
            local header = Instance.new("Frame")
            header.Name = "Header"
            header.Size = UDim2.new(1, 0, 0, 60)
            header.Position = UDim2.new(0, 0, 0, 0)
            header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            header.BorderSizePixel = 0
            header.Parent = menu

            local headerCorner = Instance.new("UICorner")
            headerCorner.CornerRadius = UDim.new(0, 15)
            headerCorner.Parent = header

            -- Название в хедере
            local title = Instance.new("TextLabel")
            title.Name = "Title"
            title.Size = UDim2.new(1, -20, 1, 0)
            title.Position = UDim2.new(0, 10, 0, 0)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextSize = 28
            title.Font = Enum.Font.GothamBold
            title.Text = "Teratrium Hack"
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = header

            -- Кнопка закрытия
            local closeButton = Instance.new("TextButton")
            closeButton.Name = "CloseButton"
            closeButton.Size = UDim2.new(0, 50, 0, 50)
            closeButton.Position = UDim2.new(1, -55, 0, 5)
            closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.TextSize = 24
            closeButton.Font = Enum.Font.GothamBold
            closeButton.Text = "✕"
            closeButton.BorderSizePixel = 0
            closeButton.Parent = header

            local closeCorner = Instance.new("UICorner")
            closeCorner.CornerRadius = UDim.new(0, 8)
            closeCorner.Parent = closeButton

            -- Функционал кнопки закрытия
            safeExecute(function()
                closeButton.MouseButton1Click:Connect(function()
                    screenGui:Destroy()
                end)
            end)

            -- Эффект при наведении
            safeExecute(function()
                closeButton.MouseEnter:Connect(function()
                    closeButton.BackgroundColor3 = Color3.fromRGB(250, 80, 80)
                end)

                closeButton.MouseLeave:Connect(function()
                    closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                end)
            end)

            -- Анимация появления меню (fade in)
            local menuTween = TweenService:Create(
                menu,
                TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            )
            menuTween:Play()

            print("Меню Teratrium Hack создано!")
        end)
    end)
end)

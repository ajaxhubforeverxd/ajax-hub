local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local plr = Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")

-- Crear GUI raíz
local gui = Instance.new("ScreenGui")
gui.Name = "SabScriptGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- ALERTA INICIAL
local alertFrame = Instance.new("Frame", gui)
alertFrame.Size = UDim2.new(0, 450, 0, 180)
alertFrame.AnchorPoint = Vector2.new(0.5, 0.5)
alertFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
alertFrame.BackgroundColor3 = Color3.new(0, 0, 0)
alertFrame.BorderSizePixel = 0
alertFrame.Visible = true
Instance.new("UICorner", alertFrame).CornerRadius = UDim.new(0, 20)

local alertText = Instance.new("TextLabel", alertFrame)
alertText.Size = UDim2.new(0.9, 0, 0, 80)
alertText.Position = UDim2.new(0.05, 0, 0, 20)
alertText.BackgroundTransparency = 1
alertText.Text = "Bienvenido a AJAX-Hub.\n⚠ Estas usando el modo gratis del script."
alertText.TextColor3 = Color3.new(1, 1, 1)
alertText.TextScaled = true
alertText.Font = Enum.Font.GothamBold
alertText.TextWrapped = true

local continueBtn = Instance.new("TextButton", alertFrame)
continueBtn.Size = UDim2.new(0, 150, 0, 40)
continueBtn.Position = UDim2.new(0.5, 0, 1, -60)
continueBtn.AnchorPoint = Vector2.new(0.5, 0.5)
continueBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
continueBtn.TextColor3 = Color3.new(1, 1, 1)
continueBtn.Font = Enum.Font.GothamBold
continueBtn.Text = "Continuar"
continueBtn.TextScaled = true
Instance.new("UICorner", continueBtn).CornerRadius = UDim.new(0, 10)

local clickSound = Instance.new("Sound", alertFrame)
clickSound.SoundId = "rbxassetid://15666462"
clickSound.Volume = 0.7

-- PANTALLA DE CARGA
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(0, 350, 0, 200)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
loadingFrame.BorderSizePixel = 0
loadingFrame.Visible = false
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 15)

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.Size = UDim2.new(1, -40, 0, 40)
loadingLabel.Position = UDim2.new(0.5, 0, 0.5, -15)
loadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLabel.BackgroundTransparency = 1
loadingLabel.TextColor3 = Color3.new(1, 1, 1)
loadingLabel.TextScaled = true
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.Text = "Cargando script"

local footerText = Instance.new("TextLabel", loadingFrame)
footerText.Size = UDim2.new(1, -40, 0, 20)
footerText.Position = UDim2.new(0.5, 0, 0.9, 0)
footerText.AnchorPoint = Vector2.new(0.5, 0.5)
footerText.BackgroundTransparency = 1
footerText.TextColor3 = Color3.new(1, 1, 1)
footerText.TextScaled = false
footerText.TextSize = 14
footerText.Font = Enum.Font.Gotham
footerText.Text = "Tarda unos segundos!"

-- Animación puntos suspensivos en loadingLabel
local dots = 0
local maxDots = 3
local runDots = true
spawn(function()
    while runDots do
        dots = (dots + 1) % (maxDots + 1)
        loadingLabel.Text = "Cargando script" .. string.rep(".", dots)
        wait(0.5)
    end
end)

-- Texto cargado
local loadedText = Instance.new("TextLabel", loadingFrame)
loadedText.Size = UDim2.new(1, -40, 0, 50)
loadedText.Position = UDim2.new(0.5, 0, 0.5, 0)
loadedText.AnchorPoint = Vector2.new(0.5, 0.5)
loadedText.BackgroundTransparency = 1
loadedText.Text = ""
loadedText.TextColor3 = Color3.new(1, 1, 1)
loadedText.TextScaled = true
loadedText.Font = Enum.Font.GothamBold
loadedText.Visible = false
loadedText.TextTransparency = 1

local madeByText = Instance.new("TextLabel", loadingFrame)
madeByText.Size = UDim2.new(1, -40, 0, 30)
madeByText.Position = UDim2.new(0.5, 0, 0.75, 0)
madeByText.AnchorPoint = Vector2.new(0.5, 0.5)
madeByText.BackgroundTransparency = 1
madeByText.Text = ""
madeByText.TextColor3 = Color3.new(1, 1, 1)
madeByText.TextScaled = true
madeByText.Font = Enum.Font.Gotham
madeByText.Visible = false
madeByText.TextTransparency = 1

-- AJAX HUB (creado antes de usarlo)
local ajaxHub = Instance.new("Frame", gui)
ajaxHub.Size = UDim2.new(0, 400, 0, 350)
ajaxHub.AnchorPoint = Vector2.new(0.5, 0.5)
ajaxHub.Position = UDim2.new(0.5, 0, 0.5, 0)
ajaxHub.BackgroundColor3 = Color3.new(0, 0, 0)
ajaxHub.BorderSizePixel = 0
ajaxHub.Visible = false
ajaxHub.Active = true
Instance.new("UICorner", ajaxHub).CornerRadius = UDim.new(0, 20)

-- Funcionalidad para arrastrar AJAX Hub
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    ajaxHub.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ajaxHub.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ajaxHub.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ajaxHub.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- TÍTULO AJAX HUB
local ajaxTitle = Instance.new("TextLabel", ajaxHub)
ajaxTitle.Size = UDim2.new(1, 0, 0, 50)
ajaxTitle.Position = UDim2.new(0, 0, 0, 10)
ajaxTitle.BackgroundTransparency = 1
ajaxTitle.Text = "AJAX Hub"
ajaxTitle.TextColor3 = Color3.new(1, 1, 1)
ajaxTitle.TextScaled = true
ajaxTitle.Font = Enum.Font.GothamBold

-- BOTONES CERRAR Y MINIMIZAR
local closeButton = Instance.new("TextButton", ajaxHub)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 10)

local minimizeButton = Instance.new("TextButton", ajaxHub)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -80, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 10)

local minimizedBox = Instance.new("TextButton", gui)
minimizedBox.Size = UDim2.new(0, 40, 0, 40)
minimizedBox.Position = UDim2.new(0, 20, 0.5, 0)
minimizedBox.BackgroundColor3 = Color3.new(0, 0, 0)
minimizedBox.TextColor3 = Color3.new(1, 1, 1)
minimizedBox.Text = "A"
minimizedBox.Font = Enum.Font.GothamBold
minimizedBox.TextScaled = true
minimizedBox.Visible = false
Instance.new("UICorner", minimizedBox).CornerRadius = UDim.new(0, 10)

-- CUADRO DE CONFIRMACIÓN - NEGRO
local confirmBox = Instance.new("Frame", gui)
confirmBox.Size = UDim2.new(0, 300, 0, 150)
confirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
confirmBox.Position = UDim2.new(0.5, 0, 0.5, 0)
confirmBox.BackgroundColor3 = Color3.new(0, 0, 0)
confirmBox.Visible = false
Instance.new("UICorner", confirmBox).CornerRadius = UDim.new(0, 12)

local confirmLabel = Instance.new("TextLabel", confirmBox)
confirmLabel.Size = UDim2.new(1, -20, 0.6, 0)
confirmLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
confirmLabel.AnchorPoint = Vector2.new(0.5, 0)
confirmLabel.Text = "¿Estás seguro de que quieres cerrar?"
confirmLabel.TextColor3 = Color3.new(1, 1, 1)
confirmLabel.Font = Enum.Font.Gotham
confirmLabel.TextScaled = true
confirmLabel.BackgroundTransparency = 1

local yesBtn = Instance.new("TextButton", confirmBox)
yesBtn.Size = UDim2.new(0.4, 0, 0.25, 0)
yesBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
yesBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
yesBtn.Text = "Sí"
yesBtn.TextColor3 = Color3.new(1, 1, 1)
yesBtn.Font = Enum.Font.GothamBold
yesBtn.TextScaled = true
Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 8)

local noBtn = Instance.new("TextButton", confirmBox)
noBtn.Size = UDim2.new(0.4, 0, 0.25, 0)
noBtn.Position = UDim2.new(0.5, 0, 0.7, 0)
noBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
noBtn.Text = "No"
noBtn.TextColor3 = Color3.new(1, 1, 1)
noBtn.Font = Enum.Font.GothamBold
noBtn.TextScaled = true
Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 8)

-- Funciones para botones del cuadro de confirmación
closeButton.MouseButton1Click:Connect(function()
    ajaxHub.Visible = false
    confirmBox.Visible = true
end)

yesBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

noBtn.MouseButton1Click:Connect(function()
    confirmBox.Visible = false
    ajaxHub.Visible = true
end)

minimizeButton.MouseButton1Click:Connect(function()
    ajaxHub.Visible = false
    minimizedBox.Visible = true
end)

minimizedBox.MouseButton1Click:Connect(function()
    ajaxHub.Visible = true
    minimizedBox.Visible = false
end)

-- BOTÓN ESP
local espBtn = Instance.new("TextButton", ajaxHub)
espBtn.Size = UDim2.new(0, 200, 0, 40)
espBtn.Position = UDim2.new(0, 20, 0, 80)
espBtn.Text = "ESP Usuarios"
espBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextScaled = true
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 10)

local espStatus = Instance.new("TextLabel", ajaxHub)
espStatus.Size = UDim2.new(0, 20, 0, 40)
espStatus.Position = UDim2.new(0, 230, 0, 80)
espStatus.BackgroundTransparency = 1
espStatus.Text = "🔴"
espStatus.TextScaled = true
espStatus.Font = Enum.Font.GothamBold

local espEnabled = false
local espObjects = {}
local nameTags = {}

local function toggleESP(state)
    for _, adorn in pairs(espObjects) do adorn:Destroy() end
    for _, tag in pairs(nameTags) do tag:Destroy() end
    table.clear(espObjects)
    table.clear(nameTags)
    if state then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local box = Instance.new("BoxHandleAdornment")
                box.Size = Vector3.new(4, 6, 2)
                box.Adornee = hrp
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Color3 = Color3.new(0, 1, 0)
                box.Transparency = 0.3
                box.Parent = hrp
                table.insert(espObjects, box)

                local tag = Instance.new("BillboardGui", player.Character)
                tag.Size = UDim2.new(0, 100, 0, 30)
                tag.Adornee = hrp
                tag.AlwaysOnTop = true
                local nameLabel = Instance.new("TextLabel", tag)
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = player.Name
                nameLabel.TextColor3 = Color3.new(0, 1, 0)
                nameLabel.TextScaled = true
                nameLabel.Font = Enum.Font.GothamBold
                table.insert(nameTags, tag)
            end
        end
    end
    espStatus.Text = state and "🟢" or "🔴"
end

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    toggleESP(espEnabled)
end)

-- BOTÓN DE SPEED BOOST (carga script externo)
local speedBtn = Instance.new("TextButton", ajaxHub)
speedBtn.Size = UDim2.new(0, 200, 0, 40)
speedBtn.Position = UDim2.new(0, 20, 0, 140)
speedBtn.Text = "Script Speed Boost"
speedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBtn.TextColor3 = Color3.new(1, 1, 1)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextScaled = true
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 10)

speedBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-cframe-speed-31062"))()
    end)
    if not success then
        warn("Falló el script de Speed Boost: ", err)
    end
end)

-- BOTÓN SERVER HOP
local serverHopBtn = Instance.new("TextButton", ajaxHub)
serverHopBtn.Size = UDim2.new(0, 200, 0, 40)
serverHopBtn.Position = UDim2.new(0, 20, 0, 200)
serverHopBtn.Text = "Server Hop 🔄"
serverHopBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
serverHopBtn.TextColor3 = Color3.new(1, 1, 1)
serverHopBtn.Font = Enum.Font.GothamBold
serverHopBtn.TextScaled = true
Instance.new("UICorner", serverHopBtn).CornerRadius = UDim.new(0, 10)

serverHopBtn.MouseButton1Click:Connect(function()
    local TeleportService = game:GetService("TeleportService")
    local placeId = game.PlaceId
    local servers = {}

    local function hop()
        local success, response = pcall(function()
            return game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and response and response.data then
            for _, server in pairs(response.data) do
                if server.playing < server.maxPlayers then
                    if not servers[server.id] then
                        servers[server.id] = true
                        TeleportService:TeleportToPlaceInstance(placeId, server.id)
                        break
                    end
                end
            end
        else
            warn("No se pudo obtener servidores para Server Hop.")
        end
    end

    hop()
end)

-- CLICK DEL BOTÓN CONTINUAR EN ALERTA INICIAL
continueBtn.MouseButton1Click:Connect(function()
    clickSound:Play()
    alertFrame.Visible = false
    loadingFrame.Visible = true

    wait(5)
    runDots = false

    loadingLabel.Visible = false
    footerText.Visible = false

    loadedText.Text = "Cargado!"
    loadedText.Visible = true

    madeByText.Text = "Hecho por: top | imademyselfapromise"
    madeByText.Visible = true

    for i = 1, 20 do
        local transparency = 1 - i * 0.05
        loadedText.TextTransparency = transparency
        madeByText.TextTransparency = transparency
        wait(0.05)
    end

    wait(1)
    loadingFrame.Visible = false
    ajaxHub.Visible = true
end)

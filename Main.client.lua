
--==================================================
-- PHANTOM UI | MAIN V3
-- LocalScript: Main.client.lua
--==================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- MODULOS
local modules = ReplicatedStorage:WaitForChild("PhantomModules")
local Config = require(modules:WaitForChild("Config"))
local FloatingButton = require(modules:WaitForChild("FloatingButton"))

local Colors = Config.Colors

-- REMOVER VERSAO ANTERIOR
local oldGui = playerGui:FindFirstChild(Config.Window.Name)
if oldGui then
    oldGui:Destroy()
end

-- FUNCOES DE INTERFACE
local function make(class, props, parent)
    local obj = Instance.new(class)

    for key, value in pairs(props) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function border(obj, color)
    make("UIStroke", {
        Color = color or Colors.Purple,
        Thickness = 1.5
    }, obj)
end

local function text(parent, value, size, position, dimensions, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = value,
        TextSize = size,
        TextColor3 = color or Colors.White,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = position,
        Size = dimensions,
    }, parent)
end

-- SCREEN GUI
local gui = make("ScreenGui", {
    Name = Config.Window.Name,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 100,
}, playerGui)

-- JANELA PRINCIPAL
local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(
        Config.Window.Width,
        Config.Window.Height
    ),
    BackgroundColor3 = Colors.Dark,
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
}, gui)

round(main, 14)
border(main, Colors.Purple)

-- ESCALA RESPONSIVA
local scale = make("UIScale", {
    Scale = 1
}, main)

local function resize()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local viewport = camera.ViewportSize

    scale.Scale = math.min(
        1,
        viewport.X / 620,
        viewport.Y / 440
    )
end

resize()

local cameraConnection

local function connectCamera()
    if cameraConnection then
        cameraConnection:Disconnect()
    end

    local camera = workspace.CurrentCamera
    if camera then
        cameraConnection =
            camera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
        resize()
    end
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(connectCamera)

-- CABECALHO
local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 68),
    BackgroundColor3 = Colors.Panel,
    BorderSizePixel = 0,
}, main)

round(header, 14)

text(
    header, "◉", 34,
    UDim2.fromOffset(14, 10),
    UDim2.fromOffset(48, 45),
    Colors.Purple
)

text(
    header, "PHANTOM", 22,
    UDim2.fromOffset(68, 10),
    UDim2.fromOffset(210, 29),
    Colors.White
)

text(
    header, "V3 | NEON INTERFACE", 10,
    UDim2.fromOffset(70, 38),
    UDim2.fromOffset(220, 18),
    Colors.Purple
)

local close = make("TextButton", {
    Name = "Close",
    Text = "×",
    TextSize = 27,
    TextColor3 = Colors.White,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -40, 0, 13),
    Size = UDim2.fromOffset(30, 35),
    Font = Enum.Font.Gotham,
}, header)

-- BARRA LATERAL
local sidebar = make("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(10, 78),
    Size = UDim2.new(0, 145, 1, -88),
    BackgroundColor3 = Colors.Panel,
    BorderSizePixel = 0,
}, main)

round(sidebar, 10)

text(
    sidebar, "NAVEGACAO", 10,
    UDim2.fromOffset(12, 10),
    UDim2.new(1, -20, 0, 22),
    Colors.Gray
)

local nav = make("Frame", {
    Name = "Navigation",
    Position = UDim2.fromOffset(7, 40),
    Size = UDim2.new(1, -14, 0, 190),
    BackgroundTransparency = 1,
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)

-- AREA DE CONTEUDO
local content = make("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(165, 80),
    Size = UDim2.new(1, -175, 1, -90),
    BackgroundTransparency = 1,
}, main)

local pageTitle = text(
    content, "PRINCIPAL", 20,
    UDim2.fromOffset(5, 0),
    UDim2.new(1, -10, 0, 28),
    Colors.White
)

local description = text(
    content, "Visao geral do menu", 11,
    UDim2.fromOffset(5, 29),
    UDim2.new(1, -10, 0, 20),
    Colors.Gray
)

local list = make("ScrollingFrame", {
    Name = "PageList",
    Position = UDim2.fromOffset(0, 54),
    Size = UDim2.new(1, 0, 1, -54),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Colors.Purple,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, list)

make("UIPadding", {
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 8),
}, list)

-- COMPONENTES DAS PAGINAS
local function clear()
    for _, obj in ipairs(list:GetChildren()) do
        if not obj:IsA("UIListLayout")
            and not obj:IsA("UIPadding") then
            obj:Destroy()
        end
    end
end

local function section(value)
    text(
        list, value, 11,
        UDim2.new(),
        UDim2.new(1, 0, 0, 23),
        Colors.Purple
    )
end

local function card(titleValue, subtitle)
    local frame = make("Frame", {
        Size = UDim2.new(1, 0, 0, 53),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
    }, list)

    round(frame, 9)
    border(frame, Colors.Border)

    text(
        frame, titleValue, 12,
        UDim2.fromOffset(12, 5),
        UDim2.new(1, -24, 0, 21),
        Colors.White
    )

    text(
        frame, subtitle, 10,
        UDim2.fromOffset(12, 27),
        UDim2.new(1, -24, 0, 18),
        Colors.Gray
    )

    return frame
end

local function toggle(titleValue, subtitle, initial)
    local frame = make("Frame", {
        Size = UDim2.new(1, 0, 0, 53),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
    }, list)

    round(frame, 9)
    border(frame, Colors.Border)

    text(
        frame, titleValue, 12,
        UDim2.fromOffset(12, 5),
        UDim2.new(1, -75, 0, 21),
        Colors.White
    )

    text(
        frame, subtitle, 9,
        UDim2.fromOffset(12, 27),
        UDim2.new(1, -75, 0, 17),
        Colors.Gray
    )

    local enabled = initial

    local button = make("TextButton", {
        Position = UDim2.new(1, -49, 0.5, -11),
        Size = UDim2.fromOffset(38, 22),
        BackgroundColor3 = enabled and Colors.Purple
            or Colors.Inactive,
        Text = "",
        AutoButtonColor = false,
    }, frame)

    round(button, 20)

    local dot = make("Frame", {
        Position = enabled
            and UDim2.new(1, -19, 0, 3)
            or UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = Colors.White,
    }, button)

    round(dot, 20)

    button.Activated:Connect(function()
        enabled = not enabled

        button.BackgroundColor3 = enabled
            and Colors.Purple or Colors.Inactive

        dot.Position = enabled
            and UDim2.new(1, -19, 0, 3)
            or UDim2.fromOffset(3, 3)
    end)
end

local function slider(titleValue, value)
    card(titleValue .. "     " .. value,
        "Controle demonstrativo")
end

local function selector(titleValue, value)
    card(titleValue, "◇   " .. value)
end

-- PAGINAS VISUAIS
local pages = {
    Principal = function()
        section("PAINEL PRINCIPAL")
        card("Bem-vindo ao PHANTOM", "Interface visual V3")
        card("Jogador", player.Name)
        card("Status", "Interface carregada")
        section("ACESSO RAPIDO")
        toggle("Menu visivel", "Exibicao demonstrativa", true)
        toggle("Animacoes", "Opcao visual", true)
    end,

    Aimbot = function()
        section("CONFIGURACOES DE MIRA")
        card("Aimbot", "Demonstracao visual")
        toggle("Assistencia de mira", "Apenas visual", false)
        slider("Campo de visao (FOV)", "120")
        slider("Suavizacao", "0.15")
        selector("Tecla de ativacao", "Mouse 2")
        selector("Ponto de referencia", "Centro")
    end,

    ESP = function()
        section("INDICADORES VISUAIS")
        card("ESP", "Demonstracao visual")
        toggle("ESP", "Alternancia demonstrativa", true)
        toggle("Nome", "Opcao demonstrativa", true)
        toggle("Distancia", "Opcao demonstrativa", true)
        toggle("Caixa (Box)", "Opcao demonstrativa", true)
        toggle("Linha", "Opcao demonstrativa", true)
        selector("Cor dos indicadores", "Roxo")
        slider("Transparencia", "50%")
    end,

    Configuracoes = function()
        section("PERSONALIZACAO")
        selector("Tema", "Roxo neon")
        slider("Transparencia do menu", "70%")
        selector("Tamanho do menu", "Padrao")
        toggle("Animacoes", "Opcao visual", true)
        toggle("Notificacoes", "Opcao visual", true)
        toggle("Botao flutuante", "Atalho de reabertura", true)
        section("INFORMACOES")
        card("PHANTOM V3", "Interface demonstrativa")
    end,
}

-- NAVEGACAO
local navButtons = {}

local function showPage(name)
    clear()

    for pageName, button in pairs(navButtons) do
        local active = pageName == name

        button.BackgroundColor3 = active
            and Color3.fromRGB(65, 25, 135)
            or Colors.Panel

        button.TextColor3 = active and Colors.White
            or Colors.Gray
    end

    pageTitle.Text = string.upper(name)

    description.Text = name == "Principal"
        and "Visao geral do menu"
        or "Personalizacao visual: " .. name

    pages[name]()
end

local items = {
    {"Principal", "⌂"},
    {"Aimbot", "⌖"},
    {"ESP", "◎"},
    {"Configuracoes", "⚙"},
}

for index, item in ipairs(items) do
    local name = item[1]

    local button = make("TextButton", {
        Name = name,
        LayoutOrder = index,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Colors.Panel,
        Text = "  " .. item[2] .. "   "
            .. (name == "Configuracoes"
                and "Configuracoes" or name),
        TextColor3 = Colors.Gray,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
    }, nav)

    round(button, 8)
    navButtons[name] = button

    button.Activated:Connect(function()
        showPage(name)
    end)
end

-- BOTAO FLUTUANTE: MODULO EXTERNO
FloatingButton.Create(gui, main, close, Config)

-- PAGINA INICIAL
showPage("Principal")

print("PHANTOM: interface carregada")

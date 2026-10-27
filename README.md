
-- PHANTOM UI | TESTE DE EXIBICAO
-- LocalScript em StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("PhantomDesign")
if old then old:Destroy() end

local purple = Color3.fromRGB(140, 55, 255)
local dark = Color3.fromRGB(12, 10, 25)
local panel = Color3.fromRGB(23, 19, 43)
local white = Color3.fromRGB(245, 240, 255)
local gray = Color3.fromRGB(170, 158, 195)

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
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
        Color = color or purple,
        Thickness = 1.5
    }, obj)
end

local function text(parent, value, size, position, dimensions, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = value,
        TextSize = size,
        TextColor3 = color or white,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = position,
        Size = dimensions,
    }, parent)
end

local gui = make("ScreenGui", {
    Name = "PhantomDesign",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 100,
}, playerGui)

-- Janela
local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(600, 420),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
}, gui)

round(main, 14)
border(main, purple)

-- Escala vinculada corretamente à janela
local scale = make("UIScale", {
    Scale = 1
}, main)

local function resize()
    local camera = workspace.CurrentCamera
    if camera then
        local v = camera.ViewportSize
        scale.Scale = math.min(1, v.X / 620, v.Y / 440)
    end
end

resize()

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
end

-- Cabecalho
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 68),
    BackgroundColor3 = panel,
    BorderSizePixel = 0,
}, main)

round(header, 14)

text(header, "◉", 34, UDim2.fromOffset(14, 10),
    UDim2.fromOffset(48, 45), purple)

text(header, "PHANTOM", 22, UDim2.fromOffset(68, 10),
    UDim2.fromOffset(210, 29), white)

text(header, "V3  |  NEON INTERFACE", 10,
    UDim2.fromOffset(70, 38), UDim2.fromOffset(220, 18), purple)

local close = make("TextButton", {
    Text = "×",
    TextSize = 27,
    TextColor3 = white,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -40, 0, 13),
    Size = UDim2.fromOffset(30, 35),
}, header)

-- Navegacao
local sidebar = make("Frame", {
    Position = UDim2.fromOffset(10, 78),
    Size = UDim2.new(0, 145, 1, -88),
    BackgroundColor3 = panel,
    BorderSizePixel = 0,
}, main)

round(sidebar, 10)

text(sidebar, "NAVEGACAO", 10, UDim2.fromOffset(12, 10),
    UDim2.new(1, -20, 0, 22), gray)

local nav = make("Frame", {
    Position = UDim2.fromOffset(7, 40),
    Size = UDim2.new(1, -14, 0, 190),
    BackgroundTransparency = 1,
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)

-- Conteudo
local content = make("Frame", {
    Position = UDim2.fromOffset(165, 80),
    Size = UDim2.new(1, -175, 1, -90),
    BackgroundTransparency = 1,
}, main)

local pageTitle = text(content, "PRINCIPAL", 20,
    UDim2.fromOffset(5, 0), UDim2.new(1, -10, 0, 28), white)

local description = text(content, "Visao geral do menu",
    11, UDim2.fromOffset(5, 29),
    UDim2.new(1, -10, 0, 20), gray)

local list = make("ScrollingFrame", {
    Position = UDim2.fromOffset(0, 54),
    Size = UDim2.new(1, 0, 1, -54),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = purple,
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

local function clear()
    for _, obj in ipairs(list:GetChildren()) do
        if not obj:IsA("UIListLayout")
            and not obj:IsA("UIPadding") then
            obj:Destroy()
        end
    end
end

local function section(value)
    text(list, value, 11, UDim2.new(),
        UDim2.new(1, 0, 0, 23), purple)
end

local function card(title, subtitle)
    local f = make("Frame", {
        Size = UDim2.new(1, 0, 0, 53),
        BackgroundColor3 = panel,
        BorderSizePixel = 0,
    }, list)

    round(f, 9)
    border(f, Color3.fromRGB(65, 39, 110))

    text(f, title, 12, UDim2.fromOffset(12, 5),
        UDim2.new(1, -24, 0, 21), white)

    text(f, subtitle, 10, UDim2.fromOffset(12, 27),
        UDim2.new(1, -24, 0, 18), gray)
end

local function toggle(title, subtitle, initial)
    local f = make("Frame", {
        Size = UDim2.new(1, 0, 0, 53),
        BackgroundColor3 = panel,
        BorderSizePixel = 0,
    }, list)

    round(f, 9)
    border(f, Color3.fromRGB(65, 39, 110))

    text(f, title, 12, UDim2.fromOffset(12, 5),
        UDim2.new(1, -75, 0, 21), white)

    text(f, subtitle, 9, UDim2.fromOffset(12, 27),
        UDim2.new(1, -75, 0, 17), gray)

    local on = initial

    local button = make("TextButton", {
        Position = UDim2.new(1, -49, 0.5, -11),
        Size = UDim2.fromOffset(38, 22),
        BackgroundColor3 = on and purple or Color3.fromRGB(65, 60, 80),
        Text = "",
    }, f)

    round(button, 20)

    local dot = make("Frame", {
        Position = on and UDim2.new(1, -19, 0, 3)
            or UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = white,
    }, button)

    round(dot, 20)

    button.Activated:Connect(function()
        on = not on
        button.BackgroundColor3 = on and purple
            or Color3.fromRGB(65, 60, 80)
        dot.Position = on and UDim2.new(1, -19, 0, 3)
            or UDim2.fromOffset(3, 3)
    end)
end

local function slider(title, value)
    card(title .. "     " .. value, "Controle deslizante demonstrativo")
end

local function selector(title, value)
    card(title, "◇   " .. value)
end

-- Paginas
local pages = {
    ["Principal"] = function()
        section("PAINEL PRINCIPAL")
        card("Bem-vindo ao PHANTOM", "Interface visual V3")
        card("Jogador", player.Name)
        card("Status", "Interface carregada")
        section("ACESSO RAPIDO")
        toggle("Menu visivel", "Exibicao da interface", true)
        toggle("Animacoes", "Efeitos visuais", true)
    end,

    ["Aimbot"] = function()
        section("CONFIGURACOES DE MIRA")
        card("Aimbot", "Previa visual demonstrativa")
        toggle("Assistencia de mira", "Apenas visual", false)
        slider("Campo de visao (FOV)", "120")
        slider("Suavizacao", "0.15")
        selector("Tecla de ativacao", "Mouse 2")
        selector("Ponto de referencia", "Centro")
        slider("Distancia demonstrativa", "300")
    end,

    ["ESP"] = function()
        section("INDICADORES VISUAIS")
        card("ESP", "Previa de opcoes visuais")
        toggle("ESP", "Alternancia demonstrativa", true)
        toggle("Nome", "Rotulo visual de exemplo", true)
        toggle("Distancia", "Texto de exemplo", true)
        toggle("Caixa (Box)", "Contorno demonstrativo", true)
        toggle("Linha", "Linha demonstrativa", true)
        selector("Cor dos indicadores", "Roxo")
        slider("Transparencia", "50%")
    end,

    ["Configuracoes"] = function()
        section("PERSONALIZACAO")
        selector("Tema", "Roxo neon")
        slider("Transparencia do menu", "70%")
        selector("Tamanho do menu", "Padrao")
        toggle("Animacoes", "Transicoes suaves", true)
        toggle("Notificacoes", "Mensagens visuais", true)
        toggle("Botao flutuante", "Atalho de reabertura", true)
        section("INFORMACOES")
        card("PHANTOM V3", "Interface demonstrativa")
    end,
}

local buttons = {}

local function showPage(name)
    clear()

    for pageName, button in pairs(buttons) do
        local active = pageName == name
        button.BackgroundColor3 = active
            and Color3.fromRGB(65, 25, 135) or panel
        button.TextColor3 = active and white or gray
    end

    pageTitle.Text = string.upper(name)
    description.Text = name == "Principal" and "Visao geral do menu"
        or "Personalizacao visual: " .. name

    pages[name]()
end

local items = {
    {"Principal", "⌂"},
    {"Aimbot", "⌖"},
    {"ESP", "◎"},
    {"Configuracoes", "⚙"},
}

for i, item in ipairs(items) do
    local name = item[1]

    local button = make("TextButton", {
        Name = name,
        LayoutOrder = i,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = panel,
        Text = "  " .. item[2] .. "   " ..
            (name == "Configuracoes" and "Configuracoes" or name),
        TextColor3 = gray,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
    }, nav)

    round(button, 8)
    buttons[name] = button

    button.Activated:Connect(function()
        showPage(name)
    end)
end

-- Botao flutuante de reabertura
local floating = make("TextButton", {
    Name = "PhantomFloating",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -15, 1, -15),
    Size = UDim2.fromOffset(50, 50),
    BackgroundColor3 = dark,
    Text = "✦",
    TextColor3 = Color3.fromRGB(195, 145, 255),
    TextSize = 28,
    Visible = false,
}, gui)

round(floating, 50)
border(floating, purple)

close.Activated:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

floating.Activated:Connect(function()
    main.Visible = true
    floating.Visible = false
end)

showPage("Principal")

print("PHANTOM: GUI criada em " .. playerGui:GetFullName())

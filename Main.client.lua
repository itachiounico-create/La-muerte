
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("LaMuerteUI")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "LaMuerteUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local window = Instance.new("Frame")
window.Name = "MainWindow"
window.Size = UDim2.fromOffset(320, 340)
window.Position = UDim2.new(0.5, -160, 0.5, -170)
window.BackgroundColor3 = Color3.fromRGB(15, 13, 23)
window.BackgroundTransparency = 0.12
window.BorderSizePixel = 0
window.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = window

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(157, 91, 255)
stroke.Thickness = 1.5
stroke.Parent = window

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 48)
title.Position = UDim2.fromOffset(14, 0)
title.BackgroundTransparency = 1
title.Text = "LA MUERTE"
title.TextColor3 = Color3.fromRGB(194, 151, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = window

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -42, 0, 7)
close.BackgroundColor3 = Color3.fromRGB(37, 32, 51)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(242, 239, 250)
close.TextSize = 24
close.Font = Enum.Font.Gotham
close.Parent = window

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -28, 0, 45)
status.Position = UDim2.fromOffset(14, 65)
status.BackgroundColor3 = Color3.fromRGB(25, 22, 36)
status.Text = "LA MUERTE • INTERFACE"
status.TextColor3 = Color3.fromRGB(242, 239, 250)
status.TextSize = 13
status.Font = Enum.Font.GothamMedium
status.Parent = window

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = status

close.Activated:Connect(function()
    gui:Destroy()
end)

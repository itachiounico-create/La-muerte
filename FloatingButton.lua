
-- PHANTOM | FLOATING BUTTON
-- Modulo visual de fechar e reabrir

local FloatingButton = {}

function FloatingButton.Create(gui, main, close, config)
    local colors = config.Colors

    local button = Instance.new("TextButton")
    button.Name = "PhantomFloating"
    button.AnchorPoint = Vector2.new(1, 1)
    button.Position = UDim2.new(1, -15, 1, -15)
    button.Size = UDim2.fromOffset(50, 50)
    button.BackgroundColor3 = colors.Dark
    button.Text = "✦"
    button.TextColor3 = Color3.fromRGB(195, 145, 255)
    button.TextSize = 28
    button.Visible = false
    button.AutoButtonColor = true
    button.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = colors.Purple
    stroke.Thickness = 1.5
    stroke.Parent = button

    close.Activated:Connect(function()
        main.Visible = false
        button.Visible = true
    end)

    button.Activated:Connect(function()
        main.Visible = true
        button.Visible = false
    end)

    return button
end

return FloatingButton

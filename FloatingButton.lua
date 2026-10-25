
local FloatingButton = {}

function FloatingButton.Create(parent, onClick)
    local button = Instance.new("TextButton")
    button.Name = "FloatingButton"
    button.Size = UDim2.fromOffset(54, 54)
    button.Position = UDim2.new(0, 18, 0.5, -27)
    button.BackgroundColor3 = Color3.fromRGB(15, 13, 23)
    button.Text = "LM"
    button.TextColor3 = Color3.fromRGB(194, 151, 255)
    button.TextSize = 17
    button.Font = Enum.Font.GothamBold
    button.Visible = false
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(157, 91, 255)
    stroke.Thickness = 2
    stroke.Parent = button

    button.Activated:Connect(function()
        if onClick then
            onClick()
        end
    end)

    return button
end

return FloatingButton

-- player saat ini (gui + copy)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "CoordinateCaptureGui"
gui.Parent = playerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 190)
frame.Position = UDim2.new(0.5, -150, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Capture Player Coordinate"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0

local btnCapture = Instance.new("TextButton", frame)
btnCapture.Size = UDim2.new(0.8, 0, 0, 40)
btnCapture.Position = UDim2.new(0.1, 0, 0, 45)
btnCapture.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
btnCapture.TextColor3 = Color3.new(1, 1, 1)
btnCapture.Text = "Capture Coordinate"
btnCapture.Font = Enum.Font.GothamBold
btnCapture.TextScaled = true
btnCapture.BorderSizePixel = 0
Instance.new("UICorner", btnCapture).CornerRadius = UDim.new(0, 10)

local lblCoordinate = Instance.new("TextLabel", frame)
lblCoordinate.Size = UDim2.new(1, -20, 0, 40)
lblCoordinate.Position = UDim2.new(0, 10, 0, 100)
lblCoordinate.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
lblCoordinate.TextColor3 = Color3.new(1, 1, 1)
lblCoordinate.Text = "Coordinate: -"
lblCoordinate.Font = Enum.Font.Gotham
lblCoordinate.TextScaled = true
lblCoordinate.BorderSizePixel = 0
Instance.new("UICorner", lblCoordinate).CornerRadius = UDim.new(0, 8)

local btnCopy = Instance.new("TextButton", frame)
btnCopy.Size = UDim2.new(0.8, 0, 0, 30)
btnCopy.Position = UDim2.new(0.1, 0, 0, 145)
btnCopy.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
btnCopy.TextColor3 = Color3.new(1, 1, 1)
btnCopy.Text = "Copy to Clipboard"
btnCopy.Font = Enum.Font.GothamBold
btnCopy.TextScaled = true
btnCopy.BorderSizePixel = 0
Instance.new("UICorner", btnCopy).CornerRadius = UDim.new(0, 10)

btnCapture.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        lblCoordinate.Text = string.format("%.3f, %.3f, %.3f", pos.X, pos.Y, pos.Z)
    else
        lblCoordinate.Text = "HumanoidRootPart not found!"
    end
end)

btnCopy.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(lblCoordinate.Text)
    elseif (syn and syn.set_clipboard) then
        syn.set_clipboard(lblCoordinate.Text)
    else
        warn("Copy clipboard tidak didukung di executor ini.")
    end
end)

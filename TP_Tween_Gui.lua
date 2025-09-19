-- LocalScript | Teleport Executor FINAL
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local hrp = nil

-- Helper: HRP
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart", 5)
end
hrp = getHRP()

-- GUI utama
local gui = Instance.new("ScreenGui")
gui.Name = "TeleportExecutor"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 280)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", mainFrame).Transparency = 0.85

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -80, 0, 28)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Teleport Executor"
title.TextColor3 = Color3.fromRGB(230, 230, 230)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 8)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(190,40,40)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- MINIMIZE
local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -68, 0, 8)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,8)

-- Floating minimized button
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0,120,0,36)
miniBtn.Position = UDim2.new(0.5,-60,0.9,0)
miniBtn.AnchorPoint = Vector2.new(0.5,0.5)
miniBtn.Text = "Teleport"
miniBtn.Font = Enum.Font.SourceSansBold
miniBtn.TextSize = 16
miniBtn.TextColor3 = Color3.fromRGB(240,240,240)
miniBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
miniBtn.Visible = false
miniBtn.Parent = gui
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0,10)

-- Minimize toggle
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniBtn.Visible = true
end)
miniBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniBtn.Visible = false
end)

-- Input boxes
local function createBox(pos, placeholder, default)
    local box = Instance.new("TextBox", mainFrame)
    box.Size = UDim2.new(0, 240, 0, 36)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = default or ""
    box.ClearTextOnFocus = false
    box.BackgroundColor3 = Color3.fromRGB(52,52,52)
    box.TextColor3 = Color3.fromRGB(235,235,235)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
    return box
end

local speedBox = createBox(UDim2.new(0,12,0,48), "Speed (stud/s)", "300")
local coordBox = createBox(UDim2.new(0,12,0,96), "X, Y, Z")

-- Buttons GO/STOP
local goBtn = Instance.new("TextButton", mainFrame)
goBtn.Size = UDim2.new(0, 170, 0, 44)
goBtn.Position = UDim2.new(0, 12, 0, 190)
goBtn.Text = "▶ GO"
goBtn.Font = Enum.Font.SourceSansBold
goBtn.TextSize = 18
goBtn.TextColor3 = Color3.fromRGB(250,250,250)
goBtn.BackgroundColor3 = Color3.fromRGB(25,150,75)
Instance.new("UICorner", goBtn).CornerRadius = UDim.new(0,10)

local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(0, 170, 0, 44)
stopBtn.Position = UDim2.new(0, 178, 0, 190)
stopBtn.Text = "■ STOP"
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 18
stopBtn.TextColor3 = Color3.fromRGB(250,250,250)
stopBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0,10)

-- Checkbox Floating
local checkFloating = Instance.new("TextButton", mainFrame)
checkFloating.Size = UDim2.new(0, 280, 0, 30)
checkFloating.Position = UDim2.new(0, 12, 0, 145)
checkFloating.Text = "[ ] Floating Button (Go & Stop)"
checkFloating.Font = Enum.Font.SourceSansBold
checkFloating.TextSize = 14
checkFloating.TextColor3 = Color3.fromRGB(230,230,230)
checkFloating.BackgroundColor3 = Color3.fromRGB(52,52,52)
Instance.new("UICorner", checkFloating).CornerRadius = UDim.new(0,8)

-- Floating GUI
local floatingGui = Instance.new("ScreenGui")
floatingGui.Name = "FloatingGoStop"
floatingGui.ResetOnSpawn = false
floatingGui.Parent = player:WaitForChild("PlayerGui")
floatingGui.Enabled = false

local floatFrame = Instance.new("Frame", floatingGui)
floatFrame.Size = UDim2.new(0, 160, 0, 100)
floatFrame.Position = UDim2.new(0.7,0,0.7,0)
floatFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
floatFrame.BorderSizePixel = 0
Instance.new("UICorner", floatFrame).CornerRadius = UDim.new(0,10)

local statusLabel = Instance.new("TextLabel", floatFrame)
statusLabel.Size = UDim2.new(1, -10, 0, 24)
statusLabel.Position = UDim2.new(0,5,0,5)
statusLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
statusLabel.TextColor3 = Color3.fromRGB(230,230,230)
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.TextSize = 14
statusLabel.Text = "Status: Idle"
Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0,6)

local floatGo = Instance.new("TextButton", floatFrame)
floatGo.Size = UDim2.new(0.5, -6, 0, 40)
floatGo.Position = UDim2.new(0,4,0,40)
floatGo.Text = "▶ GO"
floatGo.Font = Enum.Font.SourceSansBold
floatGo.TextSize = 16
floatGo.TextColor3 = Color3.new(1,1,1)
floatGo.BackgroundColor3 = Color3.fromRGB(25,150,75)
Instance.new("UICorner", floatGo).CornerRadius = UDim.new(0,8)

local floatStop = Instance.new("TextButton", floatFrame)
floatStop.Size = UDim2.new(0.5, -6, 0, 40)
floatStop.Position = UDim2.new(0.5,2,0,40)
floatStop.Text = "■ STOP"
floatStop.Font = Enum.Font.SourceSansBold
floatStop.TextSize = 16
floatStop.TextColor3 = Color3.new(1,1,1)
floatStop.BackgroundColor3 = Color3.fromRGB(180,40,40)
Instance.new("UICorner", floatStop).CornerRadius = UDim.new(0,8)

-- Toggle floating
local floatingEnabled = false
checkFloating.MouseButton1Click:Connect(function()
    floatingEnabled = not floatingEnabled
    checkFloating.Text = floatingEnabled and "[✔] Floating Button (Go & Stop)" or "[ ] Floating Button (Go & Stop)"
    floatingGui.Enabled = floatingEnabled
end)

-- DRAG function
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(mainFrame)
makeDraggable(miniBtn)
makeDraggable(floatFrame)

-- TELEPORT SYSTEM
local running, currentTween = false, nil
local useTween = true

local function parseVector3(text)
    if not text then return nil end
    local s = text:gsub("%s+", "")
    local x,y,z = s:match("(-?%d+%.?%d*),(-?%d+%.?%d*),(-?%d+%.?%d*)")
    if not (x and y and z) then return nil end
    return Vector3.new(tonumber(x), tonumber(y), tonumber(z))
end

local function teleport(target, speed)
    if not target or not hrp then return end
    running = true
    if floatingGui.Enabled then statusLabel.Text = "Status: Running..." end
    if useTween then
        local distance = (target - hrp.Position).Magnitude
        local time = distance / math.max(1, speed)
        currentTween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(target)})
        currentTween:Play()
        currentTween.Completed:Wait()
    else
        hrp.CFrame = CFrame.new(target)
    end
    running = false
    if floatingGui.Enabled then statusLabel.Text = "Status: Idle" end
end

-- Main GO
goBtn.MouseButton1Click:Connect(function()
    if running then return end
    local pos = parseVector3(coordBox.Text)
    if not pos then warn("❌ Format salah! Gunakan X, Y, Z") return end
    local spd = tonumber(speedBox.Text) or 300
    task.spawn(function() teleport(pos, spd) end)
end)

-- Main STOP
stopBtn.MouseButton1Click:Connect(function()
    running = false
    if currentTween then currentTween:Cancel() end
    if floatingGui.Enabled then statusLabel.Text = "Status: Stopped" end
end)

-- Floating GO
floatGo.MouseButton1Click:Connect(function()
    if running then return end
    local pos = parseVector3(coordBox.Text)
    if not pos then warn("❌ Format salah! Gunakan X, Y, Z") return end
    local spd = tonumber(speedBox.Text) or 300
    if floatingGui.Enabled then statusLabel.Text = "Status: Starting..." end
    task.spawn(function() teleport(pos, spd) end)
end)

-- Floating STOP
floatStop.MouseButton1Click:Connect(function()
    running = false
    if currentTween then currentTween:Cancel() end
    if floatingGui.Enabled then statusLabel.Text = "Status: Stopped" end
end)

-- Respawn HRP
player.CharacterAdded:Connect(function(char)
    hrp = char:WaitForChild("HumanoidRootPart", 5)
end)

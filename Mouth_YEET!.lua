-- Place check
if game.PlaceId ~= 110975441996007 then  
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = "❌ Error",  
        Text = "Only Work In Map NEW! Mount YEET! (110975441996007)",  
        Duration = 5  
    })  
    return  
end  

local player = game.Players.LocalPlayer  
local TweenService = game:GetService("TweenService")  
local StarterGui = game:GetService("StarterGui")  
local playerGui = player:WaitForChild("PlayerGui")  

-- Anti-execute 2 kali
if playerGui:FindFirstChild("MouthYEET_Gui") then
    playerGui:FindFirstChild("MouthYEET_Gui"):Destroy()
end
if _G.MouthYEETCleanup and type(_G.MouthYEETCleanup) == "function" then
    pcall(_G.MouthYEETCleanup)
    _G.MouthYEETCleanup = nil
end

local gui = Instance.new("ScreenGui")
gui.Name = "MouthYEET_Gui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local coords = {
    checkpoints = {
        Vector3.new(-219.587, 22.000, -311.532),
        Vector3.new(-380.065, 71.703, 296.544),
        Vector3.new(559.111, 216.046, 848.945),
        Vector3.new(673.634, 368.893, 1302.253),
        Vector3.new(965.269, 705.921, 2411.339),
        Vector3.new(2008.787, 899.643, 2058.659)
    },
    lobby = Vector3.new(-30.053, 24.900, -17.861)
}

local function teleport(target)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(target)
end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 240)
frame.Position = UDim2.new(0.5, -130, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextButton", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Mouth YEET!"
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.BorderSizePixel = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local function createButton(text, pos, action)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -40, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    btn.MouseButton1Click:Connect(action)
    return btn
end

-- Button 1: TP All Checkpoints
local btn1 = createButton("TP All Checkpoint", UDim2.new(0, 20, 0, 60), function()
    StarterGui:SetCore("SendNotification", {
        Title = "Information",
        Text = "Teleporting through all checkpoints...",
        Icon = "rbxassetid://4871684504",
        Duration = 8
    })
    task.spawn(function()
        for _, pos in ipairs(coords.checkpoints) do
            teleport(pos)
            task.wait(1.5)
        end
        StarterGui:SetCore("SendNotification", {
            Title = "Information",
            Text = "All checkpoints completed.",
            Icon = "rbxassetid://4871684504",
            Duration = 5
        })
    end)
end)

-- Button 2: TP To Lobby
local btn2 = createButton("TP To Lobby", UDim2.new(0, 20, 0, 110), function()
    teleport(coords.lobby)
    StarterGui:SetCore("SendNotification", {
        Title = "Information",
        Text = "Teleported to Lobby.",
        Icon = "rbxassetid://4871684504",
        Duration = 5
    })
end)

local madeby = Instance.new("TextLabel", frame)
madeby.Size = UDim2.new(0.6, 0, 0, 30)
madeby.Position = UDim2.new(0, 20, 1, -35)
madeby.BackgroundTransparency = 1
madeby.Text = "MADE BY : SCRIPT_TEST1230"
madeby.Font = Enum.Font.Arcade
madeby.TextScaled = true
madeby.TextColor3 = Color3.new(1, 1, 1)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -40, 1, -40)
close.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
close.Text = "X"
close.TextScaled = true
close.Font = Enum.Font.GothamBlack
close.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
    _G.MouthYEETCleanup = nil
end)

local isOpen = true
title.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    local targetSize = isOpen and UDim2.new(0, 260, 0, 240) or UDim2.new(0, 260, 0, 40)
    title.Text = isOpen and "Mouth YEET! ⌄" or "Mouth YEET! ⌃"
    TweenService:Create(frame, TweenInfo.new(0.25), {Size = targetSize}):Play()
    btn1.Visible = isOpen
    btn2.Visible = isOpen
    madeby.Visible = isOpen
    close.Visible = isOpen
end)

-- Cleanup global function
_G.MouthYEETCleanup = function()
    pcall(function() if gui and gui.Parent then gui:Destroy() end end)
    _G.MouthYEETCleanup = nil
endlocal CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag Function (PC + Mobile)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Tempat Button
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -10, 1, -40)
ButtonHolder.Position = UDim2.new(0, 5, 0, 35)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

-- Fungsi buat bikin button
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = name
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Daftar tombol (ganti link dengan raw github/pastebin kamu)
local buttons = {
    {name = "Steal A Brainrot (V0.8)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua"},
    {name = "Natural Disaster (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua"},
    {name = "Pull A Friend! (V0.9)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Pull-A-Friend!/World1.lua"},
    {name = "TP/Tween Gui (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/TP_Tween_Gui/TP_Tween_Gui.lua"},
    -- tambah lagi disini
}

-- Scroll mode jika lebih dari 7 button
local container
if #buttons > 7 then
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #buttons * 35)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Parent = ButtonHolder
    container = ScrollingFrame
else
    container = ButtonHolder
end

-- Generate tombol
for i, btnData in ipairs(buttons) do
    local newBtn = createButton(btnData.name, function()
        loadstring(game:HttpGet(btnData.url))()
    end)
    newBtn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
    newBtn.Parent = container
endlocal CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag Function (PC + Mobile)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Tempat Button
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -10, 1, -40)
ButtonHolder.Position = UDim2.new(0, 5, 0, 35)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

-- Fungsi buat bikin button
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = name
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Daftar tombol (ganti link dengan raw github/pastebin kamu)
local buttons = {
    {name = "Steal A Brainrot (V0.8)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua"},
    {name = "Natural Disaster (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua"},
    {name = "Pull A Friend! (V0.9)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Pull-A-Friend!/World1.lua"},
    {name = "TP/Tween Gui (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/TP_Tween_Gui/TP_Tween_Gui.lua"},
    -- tambah lagi disini
}

-- Scroll mode jika lebih dari 7 button
local container
if #buttons > 7 then
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #buttons * 35)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Parent = ButtonHolder
    container = ScrollingFrame
else
    container = ButtonHolder
end

-- Generate tombol
for i, btnData in ipairs(buttons) do
    local newBtn = createButton(btnData.name, function()
        loadstring(game:HttpGet(btnData.url))()
    end)
    newBtn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
    newBtn.Parent = container
endlocal CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag Function (PC + Mobile)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Tempat Button
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -10, 1, -40)
ButtonHolder.Position = UDim2.new(0, 5, 0, 35)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

-- Fungsi buat bikin button
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = name
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Daftar tombol (ganti link dengan raw github/pastebin kamu)
local buttons = {
    {name = "Steal A Brainrot (V0.8)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua"},
    {name = "Natural Disaster (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua"},
    {name = "Pull A Friend! (V0.9)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Pull-A-Friend!/World1.lua"},
    {name = "TP/Tween Gui (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/TP_Tween_Gui/TP_Tween_Gui.lua"},
    -- tambah lagi disini
}

-- Scroll mode jika lebih dari 7 button
local container
if #buttons > 7 then
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #buttons * 35)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Parent = ButtonHolder
    container = ScrollingFrame
else
    container = ButtonHolder
end

-- Generate tombol
for i, btnData in ipairs(buttons) do
    local newBtn = createButton(btnData.name, function()
        loadstring(game:HttpGet(btnData.url))()
    end)
    newBtn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
    newBtn.Parent = container
endlocal CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag Function (PC + Mobile)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Tempat Button
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -10, 1, -40)
ButtonHolder.Position = UDim2.new(0, 5, 0, 35)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

-- Fungsi buat bikin button
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = name
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Daftar tombol (ganti link dengan raw github/pastebin kamu)
local buttons = {
    {name = "Steal A Brainrot (V0.8)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua"},
    {name = "Natural Disaster (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua"},
    {name = "Pull A Friend! (V0.9)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Pull-A-Friend!/World1.lua"},
    {name = "TP/Tween Gui (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/TP_Tween_Gui/TP_Tween_Gui.lua"},
    {name = "Mouth YEET! (V0.5)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/refs/heads/Mouth-YEET!/Mouth_YEET!.lua"},
    -- tambah lagi disini
}

-- Scroll mode jika lebih dari 7 button
local container
if #buttons > 7 then
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #buttons * 35)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Parent = ButtonHolder
    container = ScrollingFrame
else
    container = ButtonHolder
end

-- Generate tombol
for i, btnData in ipairs(buttons) do
    local newBtn = createButton(btnData.name, function()
        loadstring(game:HttpGet(btnData.url))()
    end)
    newBtn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
    newBtn.Parent = container
end

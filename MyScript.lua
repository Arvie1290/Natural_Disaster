-- ArvieHub GUI
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Anti double execute
if CoreGui:FindFirstChild("ArvieHub_Gui") then
    CoreGui:FindFirstChild("ArvieHub_Gui"):Destroy()
end

-- GUI Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArvieHub_Gui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- TitleBar
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, -30, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
TitleBar.Text = "ArvieHub"
TitleBar.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 18
TitleBar.Parent = MainFrame

-- Close Button
local CloseBtn = Instance.new("TextButton")
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

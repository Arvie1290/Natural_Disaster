-- the website official by me
-- https://github.com/Arvie1290/Natural_Disaster/tree/main

-- ArvieHub GUI
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
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
TitleBar.Text = "ArvieHub (V1.0)"
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

-- Beta Button
local BetaBtn = Instance.new("TextButton")
BetaBtn.Size = UDim2.new(0, 30, 0, 30)
BetaBtn.Position = UDim2.new(1, -60, 0, 0)
BetaBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
BetaBtn.Text = "¡"
BetaBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
BetaBtn.Font = Enum.Font.SourceSansBold
BetaBtn.TextSize = 18
BetaBtn.Parent = MainFrame
BetaBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Beta-Feature/ScriptNotMine.lua"))()
end)

-- Drag Function
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

-- Button Holder
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, -10, 1, -40)
ButtonHolder.Position = UDim2.new(0, 5, 0, 35)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

-- Daftar tombol
local buttons = {
    {name = "Steal A Brainrot Modded Only (V0.8)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua"},
    {name = "Natural Disaster (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua"},
    {name = "Pull A Friend! (V0.9)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Pull-A-Friend!/World1.lua"},
    {name = "TP/Tween Gui (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/TP_Tween_Gui/TP_Tween_Gui.lua"},
    {name = "Mouth YEET! (V0.5)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Mouth-YEET!/Mouth_YEET!.lua"},
    {name = "Currently Position Player (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Currently-Position-Player/RPP.lua"},
    {name = "Infinite Giga Jump Troll Tower (V1.0)", url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Infinite-Giga-Jump-Troll-Tower/IGJTT.lua"},
}

-- Container scrolling
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

-- Fungsi tombol dengan copy & tooltip
local function createButtonWithCopy(name, url, index)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 30)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Position = UDim2.new(0, 0, 0, (index-1) * 35)
    btnFrame.Parent = container

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.7, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Text = name
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(url))()
    end)
    btn.Parent = btnFrame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0.3, 0, 1, 0)
    copyBtn.Position = UDim2.new(0.7, 0, 0, 0)
    copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
    copyBtn.Font = Enum.Font.SourceSans
    copyBtn.TextSize = 16
    copyBtn.Text = "Copy Loadstring"
    copyBtn.AutoButtonColor = true
    copyBtn.Parent = btnFrame

    -- Tooltip “Copied!”
    local tooltip = Instance.new("TextLabel")
    tooltip.Size = UDim2.new(1, 0, 1, 0)
    tooltip.Position = UDim2.new(0, 0, 0, 0)
    tooltip.BackgroundTransparency = 0.7
    tooltip.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tooltip.TextColor3 = Color3.fromRGB(0, 255, 0)
    tooltip.Font = Enum.Font.SourceSansBold
    tooltip.TextSize = 16
    tooltip.Text = "Copied!"
    tooltip.Visible = false
    tooltip.Parent = btnFrame

    copyBtn.MouseButton1Click:Connect(function()
        setclipboard('loadstring(game:HttpGet("'..url..'"))()')
        tooltip.Visible = true
        delay(3, function()
            tooltip.Visible = false
        end)
    end)
end

-- Generate semua tombol
for i, btnData in ipairs(buttons) do
    createButtonWithCopy(btnData.name, btnData.url, i)
end

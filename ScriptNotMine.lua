-- ArvieHub But The Script Belongs To Someone Else
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Anti double execute
if CoreGui:FindFirstChild("ArvieHub_BTSBTSE_Gui") then
    CoreGui.ArvieHub_BTSBTSE_Gui:Destroy()
end

-- GUI Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArvieHub_BTSBTSE_Gui"
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
TitleBar.Text = "ArvieHub But The Script Not Mine (V1.0)"
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

-- Daftar tombol
local buttons = {
    {name = "NullFire", url = "https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"},
    {name = "Cheat Hub", url = "https://rawscripts.net/raw/Universal-Script-Cheat-hub-21957"},
    {name = "Bring Parts", url = "https://rawscripts.net/raw/Universal-Script-Bring-Parts-27586"},
    {name = "Fake Wallhop", url = "https://rawscripts.net/raw/Universal-Script-Fake-WallHop-33268"},
    {name = "Nameless Admin", url = "https://rawscripts.net/raw/Universal-Script-Nameless-Admin-35212"},
    {name = "Fire Parts", url = "https://raw.githubusercontent.com/EnesXVC/FireParts/main/Script"},
    {name = "Infinite Yield", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {name = "Sander X", url = "https://raw.githubusercontent.com/kigredns/SanderXV4.2.2/refs/heads/main/NormalSS.lua"},
    {name = "Invisible", url = "https://pastebin.com/raw/3Rnd9rHf"},
    {name = "Pizza At The Work!", url = "https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/Work%20at%20a%20pizza%20place"},
    {name = "H3X Script", url = "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua"},
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

-- Generate tombol dengan tombol salin & tooltip (final)
for i, btnData in ipairs(buttons) do
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 30)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Position = UDim2.new(0, 0, 0, (i-1) * 35)
    btnFrame.Parent = container

    -- Tombol utama (tetap)
    local mainBtn = createButton(btnData.name, function()
        loadstring(game:HttpGet(btnData.url))()
    end)
    mainBtn.Size = UDim2.new(0.7, 0, 1, 0) -- 70% lebar
    mainBtn.Position = UDim2.new(0, 0, 0, 0)
    mainBtn.Parent = btnFrame

    -- Tombol Salin
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0.3, 0, 1, 0) -- 30% lebar
    copyBtn.Position = UDim2.new(0.7, 0, 0, 0)
    copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
    copyBtn.Font = Enum.Font.SourceSans
    copyBtn.TextSize = 16
    copyBtn.Text = "Copy"
    copyBtn.AutoButtonColor = true
    copyBtn.Parent = btnFrame

    -- Tooltip "Copied!" dengan fade
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
        setclipboard('loadstring(game:HttpGet("'..btnData.url..'"))()')
        tooltip.Visible = true
        tooltip.TextTransparency = 1
        tooltip.TextTransparency = 1
        tooltip.BackgroundTransparency = 1
        -- fade-in
        for i = 1, 10 do
            tooltip.TextTransparency = tooltip.TextTransparency - 0.1
            tooltip.BackgroundTransparency = tooltip.BackgroundTransparency - 0.07
            wait(0.03)
        end
        -- delay sebelum fade-out
        delay(1.5, function()
            for i = 1, 10 do
                tooltip.TextTransparency = tooltip.TextTransparency + 0.1
                tooltip.BackgroundTransparency = tooltip.BackgroundTransparency + 0.07
                wait(0.03)
            end
            tooltip.Visible = false
        end)
    end)
end

-- Official ArvieHub GUI (Full Version + Script Detail Viewer) - Final (FIXED Version)
-- by Arvie1290
-- FIXED by ARVIE-X1290: Removed duplicate Language button and fixed panel stacking bug.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ============================================================================
-- SETTINGS MANAGEMENT
-- ============================================================================
local Settings = {
    language = "EN",
    theme = "dark",
    autoLoad = false
}

local function saveSettings()
    pcall(function()
        writefile("ArvieHub_Settings.json", HttpService:JSONEncode(Settings))
    end)
end

local function loadSettings()
    pcall(function()
        if isfile("ArvieHub_Settings.json") then
            local data = readfile("ArvieHub_Settings.json")
            local loaded = HttpService:JSONDecode(data)
            if loaded then
                for key, value in pairs(loaded) do
                    Settings[key] = value
                end
            end
        end
    end)
end

loadSettings()

-- ============================================================================
-- GUI CREATION
-- ============================================================================
if CoreGui:FindFirstChild("ArvieHub_Gui") then
    CoreGui:FindFirstChild("ArvieHub_Gui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArvieHub_Gui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, -150, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
TitleBar.Parent = MainFrame

local TitlePhotoFrame = Instance.new("ImageLabel")
TitlePhotoFrame.Size = UDim2.new(0, 28, 0, 28)
TitlePhotoFrame.Position = UDim2.new(0, 3, 0.5, -14)
TitlePhotoFrame.BackgroundTransparency = 1
TitlePhotoFrame.Image = "rbxassetid://123833064817810"
TitlePhotoFrame.ScaleType = Enum.ScaleType.Fit
TitlePhotoFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
TitlePhotoFrame.BorderSizePixel = 1
TitlePhotoFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
TitlePhotoFrame.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -35, 1, 0)
TitleText.Position = UDim2.new(0, 35, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "ArvieHub V1.2"
TitleText.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Control Buttons
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -90, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = MainFrame

local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 30, 0, 30)
SettingsBtn.Position = UDim2.new(1, -60, 0, 0)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
SettingsBtn.Text = "⚙️"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
SettingsBtn.Font = Enum.Font.SourceSansBold
SettingsBtn.TextSize = 18
SettingsBtn.Parent = MainFrame

local BetaBtn = Instance.new("TextButton")
BetaBtn.Size = UDim2.new(0, 30, 0, 30)
BetaBtn.Position = UDim2.new(1, -120, 0, 0)
BetaBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
BetaBtn.Text = "¡"
BetaBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
BetaBtn.Font = Enum.Font.SourceSansBold
BetaBtn.TextSize = 18
BetaBtn.Parent = MainFrame
BetaBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Beta-Feature/ScriptNotMine.lua"))()
    end)
end)

local UpdateLogBtn = Instance.new("TextButton")
UpdateLogBtn.Size = UDim2.new(0, 30, 0, 30)
UpdateLogBtn.Position = UDim2.new(1, -150, 0, 0)
UpdateLogBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
UpdateLogBtn.Text = "📋"
UpdateLogBtn.TextColor3 = Color3.fromRGB(255, 0, 255)
UpdateLogBtn.Font = Enum.Font.SourceSansBold
UpdateLogBtn.TextSize = 18
UpdateLogBtn.Parent = MainFrame

local AboutBtn = Instance.new("TextButton")
AboutBtn.Size = UDim2.new(0, 30, 0, 30)
AboutBtn.Position = UDim2.new(1, -180, 0, 0)
AboutBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 40)
AboutBtn.Text = "ℹ️"
AboutBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
AboutBtn.Font = Enum.Font.SourceSansBold
AboutBtn.TextSize = 18
AboutBtn.Parent = MainFrame

-- ============================================================================
-- MINIMIZE FUNCTION
-- ============================================================================
local isMinimized = false
local function toggleMinimize()
    isMinimized = not isMinimized
    for _, v in pairs(MainFrame:GetChildren()) do
        if v ~= TitleBar and v ~= CloseBtn and v ~= MinimizeBtn and v ~= SettingsBtn and v ~= BetaBtn and v ~= UpdateLogBtn and v ~= AboutBtn then
            v.Visible = not isMinimized
        end
    end
    MainFrame.Size = isMinimized and UDim2.new(0, 600, 0, 30) or UDim2.new(0, 600, 0, 350)
    MinimizeBtn.Text = isMinimized and "+" or "-"
    if isMinimized then
        PanelManager:hideAllPanels()
    else
        PanelManager:showPanel("detail")
    end
end
MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)

-- ============================================================================
-- DRAGGING FUNCTION
-- ============================================================================
local dragging = false
local dragStart, startPos
local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

-- ============================================================================
-- PANEL MANAGER SYSTEM (FIX FOR BUG #2)
-- ============================================================================
local PanelManager = {
    panels = {},
    currentPanel = "detail"
}

function PanelManager:registerPanel(name, frame)
    self.panels[name] = frame
end

function PanelManager:hideAllPanels()
    for _, panel in pairs(self.panels) do
        panel.Visible = false
    end
end

function PanelManager:showPanel(panelName)
    if not self.panels[panelName] then return end
    self:hideAllPanels()
    self.panels[panelName].Visible = true
    self.currentPanel = panelName
end

function PanelManager:getCurrentPanel()
    return self.currentPanel
end

-- ============================================================================
-- MAIN CONTENT PANELS
-- ============================================================================
-- Script List (Left)
local ScriptList = Instance.new("ScrollingFrame")
ScriptList.Size = UDim2.new(0.45, -5, 1, -40)
ScriptList.Position = UDim2.new(0, 5, 0, 35)
ScriptList.BackgroundTransparency = 1
ScriptList.ScrollBarThickness = 6
ScriptList.Parent = MainFrame

-- Detail Frame (Default Panel)
local DetailFrame = Instance.new("Frame")
DetailFrame.Size = UDim2.new(0.55, -10, 1, -40)
DetailFrame.Position = UDim2.new(0.45, 5, 0, 35)
DetailFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
DetailFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
DetailFrame.BorderSizePixel = 2
DetailFrame.Visible = true
DetailFrame.Parent = MainFrame

PanelManager:registerPanel("detail", DetailFrame)

-- Detail Content
local TitleScript = Instance.new("TextLabel")
TitleScript.Size = UDim2.new(1, -10, 0, 30)
TitleScript.Position = UDim2.new(0, 5, 0, 5)
TitleScript.BackgroundTransparency = 1
TitleScript.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleScript.Font = Enum.Font.SourceSansBold
TitleScript.TextSize = 20
TitleScript.Parent = DetailFrame

local GameInfo = Instance.new("TextLabel")
GameInfo.Size = UDim2.new(1, -10, 0, 20)
GameInfo.Position = UDim2.new(0, 5, 0, 40)
GameInfo.BackgroundTransparency = 1
GameInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
GameInfo.Font = Enum.Font.SourceSans
GameInfo.TextSize = 14
GameInfo.Parent = DetailFrame

local DescScroll = Instance.new("ScrollingFrame")
DescScroll.Size = UDim2.new(1, -10, 0, 100)
DescScroll.Position = UDim2.new(0, 5, 0, 65)
DescScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DescScroll.BackgroundTransparency = 0.3
DescScroll.ScrollBarThickness = 6
DescScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
DescScroll.Parent = DetailFrame

local DescriptionBox = Instance.new("TextLabel")
DescriptionBox.Size = UDim2.new(1, -10, 0, 100)
DescriptionBox.Position = UDim2.new(0, 5, 0, 0)
DescriptionBox.BackgroundTransparency = 1
DescriptionBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DescriptionBox.TextWrapped = true
DescriptionBox.TextYAlignment = Enum.TextYAlignment.Top
DescriptionBox.Font = Enum.Font.SourceSans
DescriptionBox.TextSize = 14
DescriptionBox.Parent = DescScroll

local Photo = Instance.new("ImageLabel")
Photo.Size = UDim2.new(1, -10, 0, 100)
Photo.Position = UDim2.new(0, 5, 0, 170)
Photo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Photo.ScaleType = Enum.ScaleType.Fit
Photo.Parent = DetailFrame

local CopyGameLink = Instance.new("TextButton")
CopyGameLink.Size = UDim2.new(0.3, 0, 0, 30)
CopyGameLink.Position = UDim2.new(0, 5, 1, -35)
CopyGameLink.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CopyGameLink.Text = "COPY GAME LINK"
CopyGameLink.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyGameLink.Font = Enum.Font.SourceSansBold
CopyGameLink.TextSize = 14
CopyGameLink.Parent = DetailFrame

local CopyLoad = Instance.new("TextButton")
CopyLoad.Size = UDim2.new(0.3, 0, 0, 30)
CopyLoad.Position = UDim2.new(0.35, 0, 1, -35)
CopyLoad.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CopyLoad.Text = "COPY LOADSTRING"
CopyLoad.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyLoad.Font = Enum.Font.SourceSansBold
CopyLoad.TextSize = 14
CopyLoad.Parent = DetailFrame

local RunBtn = Instance.new("TextButton")
RunBtn.Size = UDim2.new(0.3, 0, 0, 30)
RunBtn.Position = UDim2.new(0.7, -5, 1, -35)
RunBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RunBtn.Text = "RUN"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 16
RunBtn.Parent = DetailFrame

-- Update Log Frame
local UpdateLogFrame = Instance.new("Frame")
UpdateLogFrame.Size = UDim2.new(0.55, -10, 1, -40)
UpdateLogFrame.Position = UDim2.new(0.45, 5, 0, 35)
UpdateLogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
UpdateLogFrame.BorderColor3 = Color3.fromRGB(255, 0, 255)
UpdateLogFrame.BorderSizePixel = 2
UpdateLogFrame.Visible = false
UpdateLogFrame.Parent = MainFrame

PanelManager:registerPanel("update", UpdateLogFrame)

local UpdateLogScroll = Instance.new("ScrollingFrame")
UpdateLogScroll.Size = UDim2.new(1, -10, 1, -10)
UpdateLogScroll.Position = UDim2.new(0, 5, 0, 5)
UpdateLogScroll.BackgroundTransparency = 1
UpdateLogScroll.ScrollBarThickness = 6
UpdateLogScroll.CanvasSize = UDim2.new(0, 0, 0, 800)
UpdateLogScroll.Parent = UpdateLogFrame

local UpdateLogTitle = Instance.new("TextLabel")
UpdateLogTitle.Size = UDim2.new(1, -10, 0, 40)
UpdateLogTitle.Position = UDim2.new(0, 5, 0, 5)
UpdateLogTitle.BackgroundTransparency = 1
UpdateLogTitle.Text = "Update Log"
UpdateLogTitle.TextColor3 = Color3.fromRGB(255, 0, 255)
UpdateLogTitle.Font = Enum.Font.SourceSansBold
UpdateLogTitle.TextSize = 24
UpdateLogTitle.TextXAlignment = Enum.TextXAlignment.Center
UpdateLogTitle.Parent = UpdateLogScroll

local VersionSubtitle = Instance.new("TextLabel")
VersionSubtitle.Size = UDim2.new(1, -10, 0, 30)
VersionSubtitle.Position = UDim2.new(0, 5, 0, 50)
VersionSubtitle.BackgroundTransparency = 1
VersionSubtitle.Text = "THIS VERSION : V1.2"
VersionSubtitle.TextColor3 = Color3.fromRGB(255, 150, 255)
VersionSubtitle.Font = Enum.Font.SourceSansBold
VersionSubtitle.TextSize = 20
VersionSubtitle.TextXAlignment = Enum.TextXAlignment.Center
VersionSubtitle.Parent = UpdateLogScroll

local UpdateLogContent = Instance.new("TextLabel")
UpdateLogContent.Size = UDim2.new(1, -10, 0, 700)
UpdateLogContent.Position = UDim2.new(0, 5, 0, 90)
UpdateLogContent.BackgroundTransparency = 1
UpdateLogContent.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateLogContent.Font = Enum.Font.SourceSans
UpdateLogContent.TextSize = 14
UpdateLogContent.TextXAlignment = Enum.TextXAlignment.Left
UpdateLogContent.TextYAlignment = Enum.TextYAlignment.Top
UpdateLogContent.TextWrapped = true
UpdateLogContent.Text = [[UPDATE LOG

V1.0
- Noises
- Add Menu
- Created first My Own Script "Natural Disaster"
- Simple Menu (Before it's Left Side)

V1.1
- Add Right Side Menu
- Add Button Like "Copy Game Link"; Copy Loadstring; And "Run"
- Add Text Like "Title Script"; "Name: Game"; Description; And "Image Script"

V1.2
- Add Language Indonesian
- Add Menu And Button Like "Setting: Language"; Update Log; And "About This"
- Update The Text Title Bar To Left Side And Add Usage

[End Of Update Log].]]
UpdateLogContent.Parent = UpdateLogScroll

local CloseUpdateLogBtn = Instance.new("TextButton")
CloseUpdateLogBtn.Size = UDim2.new(0.6, 0, 0, 35)
CloseUpdateLogBtn.Position = UDim2.new(0.2, 0, 0, 5)
CloseUpdateLogBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 60)
CloseUpdateLogBtn.Text = "CLOSE UPDATE LOG"
CloseUpdateLogBtn.TextColor3 = Color3.fromRGB(255, 0, 255)
CloseUpdateLogBtn.Font = Enum.Font.SourceSansBold
CloseUpdateLogBtn.TextSize = 16
CloseUpdateLogBtn.Parent = UpdateLogFrame

-- About Frame (FIXED: Language button removed)
local AboutFrame = Instance.new("Frame")
AboutFrame.Size = UDim2.new(0.55, -10, 1, -40)
AboutFrame.Position = UDim2.new(0.45, 5, 0, 35)
AboutFrame.BackgroundColor3 = Color3.fromRGB(10, 30, 30)
AboutFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
AboutFrame.BorderSizePixel = 2
AboutFrame.Visible = false
AboutFrame.Parent = MainFrame

PanelManager:registerPanel("about", AboutFrame)

local CloseAboutBtn = Instance.new("TextButton")
CloseAboutBtn.Size = UDim2.new(0.6, 0, 0, 35)
CloseAboutBtn.Position = UDim2.new(0.2, 0, 0, 5)
CloseAboutBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 60)
CloseAboutBtn.Text = "CLOSE ABOUT"
CloseAboutBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
CloseAboutBtn.Font = Enum.Font.SourceSansBold
CloseAboutBtn.TextSize = 16
CloseAboutBtn.Parent = AboutFrame

local AboutLogo = Instance.new("ImageLabel")
AboutLogo.Size = UDim2.new(0, 110, 0, 110)
AboutLogo.Position = UDim2.new(0.5, -55, 0, 50)
AboutLogo.BackgroundTransparency = 1
AboutLogo.Image = "rbxassetid://123833064817810"
AboutLogo.ScaleType = Enum.ScaleType.Fit
AboutLogo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AboutLogo.BorderSizePixel = 2
AboutLogo.BorderColor3 = Color3.fromRGB(0, 200, 255)
AboutLogo.Parent = AboutFrame

local AboutTitle = Instance.new("TextLabel")
AboutTitle.Size = UDim2.new(1, -20, 0, 35)
AboutTitle.Position = UDim2.new(0, 10, 0, 170)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Text = "ArvieHub"
AboutTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AboutTitle.Font = Enum.Font.SourceSansBold
AboutTitle.TextSize = 24
AboutTitle.TextXAlignment = Enum.TextXAlignment.Center
AboutTitle.Parent = AboutFrame

local AboutDescription = Instance.new("TextLabel")
AboutDescription.Size = UDim2.new(1, -30, 0, 100)
AboutDescription.Position = UDim2.new(0, 15, 0, 210)
AboutDescription.BackgroundTransparency = 1
AboutDescription.TextColor3 = Color3.fromRGB(200, 200, 200)
AboutDescription.Font = Enum.Font.SourceSans
AboutDescription.TextSize = 16
AboutDescription.TextXAlignment = Enum.TextXAlignment.Center
AboutDescription.TextYAlignment = Enum.TextYAlignment.Top
AboutDescription.TextWrapped = true
AboutDescription.Text = "I made this for fun and at first wanted to keep it on myself.\nBut since I didn't have much to do, I decided to release it.\nHope you enjoy it!"
AboutDescription.Parent = AboutFrame

local CopyrightText = Instance.new("TextLabel")
CopyrightText.Size = UDim2.new(1, -20, 0, 25)
CopyrightText.Position = UDim2.new(0, 10, 1, -35)
CopyrightText.BackgroundTransparency = 1
CopyrightText.TextColor3 = Color3.fromRGB(150, 150, 150)
CopyrightText.Font = Enum.Font.SourceSans
CopyrightText.TextSize = 12
CopyrightText.TextXAlignment = Enum.TextXAlignment.Center
CopyrightText.Text = "© 2023 ArvieHub | All rights reserved"
CopyrightText.Parent = AboutFrame

-- Settings Frame
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(0.55, -10, 1, -40)
SettingsFrame.Position = UDim2.new(0.45, 5, 0, 35)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 10)
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 255, 0)
SettingsFrame.BorderSizePixel = 2
SettingsFrame.Visible = false
SettingsFrame.Parent = MainFrame

PanelManager:registerPanel("settings", SettingsFrame)

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -10, 0, 40)
SettingsTitle.Position = UDim2.new(0, 5, 0, 5)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "SETTINGS"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 0)
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextSize = 24
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Center
SettingsTitle.Parent = SettingsFrame

local CloseSettingsBtn = Instance.new("TextButton")
CloseSettingsBtn.Size = UDim2.new(0.6, 0, 0, 35)
CloseSettingsBtn.Position = UDim2.new(0.2, 0, 1, -45)
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 0)
CloseSettingsBtn.Text = "CLOSE SETTINGS"
CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
CloseSettingsBtn.Font = Enum.Font.SourceSansBold
CloseSettingsBtn.TextSize = 16
CloseSettingsBtn.Parent = SettingsFrame

local LangOption = Instance.new("TextButton")
LangOption.Size = UDim2.new(0.8, 0, 0, 40)
LangOption.Position = UDim2.new(0.1, 0, 0.2, 0)
LangOption.BackgroundColor3 = Settings.language == "ID" and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(60, 60, 0)
LangOption.Text = Settings.language == "ID" and "Language: INDONESIA" or "Language: ENGLISH"
LangOption.TextColor3 = Settings.language == "ID" and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 0)
LangOption.Font = Enum.Font.SourceSansBold
LangOption.TextSize = 16
LangOption.Parent = SettingsFrame

local ThemeOption = Instance.new("TextButton")
ThemeOption.Size = UDim2.new(0.8, 0, 0, 40)
ThemeOption.Position = UDim2.new(0.1, 0, 0.4, 0)
ThemeOption.BackgroundColor3 = Color3.fromRGB(60, 0, 60)
ThemeOption.Text = "Theme: DARK (Coming Soon)"
ThemeOption.TextColor3 = Color3.fromRGB(255, 0, 255)
ThemeOption.Font = Enum.Font.SourceSansBold
ThemeOption.TextSize = 16
ThemeOption.Parent = SettingsFrame

local AutoLoadOption = Instance.new("TextButton")
AutoLoadOption.Size = UDim2.new(0.8, 0, 0, 40)
AutoLoadOption.Position = UDim2.new(0.1, 0, 0.6, 0)
AutoLoadOption.BackgroundColor3 = Settings.autoLoad and Color3.fromRGB(0, 60, 0) or Color3.fromRGB(60, 0, 0)
AutoLoadOption.Text = Settings.autoLoad and "Auto Load: ON" or "Auto Load: OFF"
AutoLoadOption.TextColor3 = Settings.autoLoad and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
AutoLoadOption.Font = Enum.Font.SourceSansBold
AutoLoadOption.TextSize = 16
AutoLoadOption.Parent = SettingsFrame

-- ============================================================================
-- DATA & FUNCTIONS
-- ============================================================================
local scripts = {
    {
        name = "Natural Disaster",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Natural-Disaster/Natural_Disaster.lua",
        gamelink = "https://www.roblox.com/games/189707",
        namegame = "Natural Disaster Survival",
        descriptionEN = "This Script Have : \n - Loop TP Lobby \n - TP To Lobby \n - TP To Game \n Version This Script : V1.0 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Teleport Loop ke Lobi \n - Teleport ke Lobi \n - Teleport ke Game \n Versi Script : V1.0 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://75756933857153",
        placeid = "189707"
    },
    {
        name = "Pull A Friend! (V0.9)",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Pull-A-Friend!/World1.lua",
        gamelink = "https://www.roblox.com/games/9581059807",
        namegame = "Pull A Friend!",
        descriptionEN = "This Script Have : \n World 1 \n - CheckPoint TP/Tween 1-6 \n - TP To Lobby \n For Another World Is Coming (Maybe?) \n Version This Script : V0.9 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n World 1 \n - Teleport CheckPoint 1-6 \n - Teleport ke Lobi \n Untuk World Lain Akan Datang (Mungkin?) \n Versi Script : V0.9 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "9581059807"
    },
    {
        name = "Steal A Brainrot Modded Only",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Steal-A-Brainrot-Modded-Only/SAB_Modded.lua",
        gamelink = "",
        namegame = "Steal A Brainrot Modded",
        descriptionEN = "This Script Have :  \n - Set TP/Tween Lock Base \n - Set TP/Tween To Base \n - Leave (Kick) \n - TP/Tween To Front The Character \n Version This Script : V0.8 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Atur Teleport/Lock Base \n - Teleport ke Base \n - Keluar (Kick) \n - Teleport ke Depan Karakter \n Versi Script : V0.8 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://122109896601945",
        placeid = "Universal"
    },
    {
        name = "TP/Tween Gui",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/TP_Tween_Gui/TP_Tween_Gui.lua",
        gamelink = "",
        namegame = "Universal (All Game)",
        descriptionEN = "This Script Have : \n - TP/Tween To Coordinat \n Version This Script : V1.0 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Teleport ke Koordinat \n Versi Script : V1.0 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "Universal"
    },
    {
        name = "Mouth YEET!",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Mouth-YEET!/Mouth_YEET!.lua",
        gamelink = "https://www.roblox.com/games/110975441996007/",
        namegame = "Mouth YEET!",
        descriptionEN = "This Script Have : \n - TP To All CheckPoint 1-6 \n - TP To Lobby \n Version This Script : V0.5 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Teleport ke Semua CheckPoint 1-6 \n - Teleport ke Lobi \n Versi Script : V0.5 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "110975441996007"
    },
    {
        name = "Currently Position Player",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Currently-Position-Player/RPP.lua",
        gamelink = "",
        namegame = "Universal (All Game)",
        descriptionEN = "This Script Have : \n - Copy Your Position Character \n Version This Script : V1.0 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Salin Posisi Karakter Anda \n Versi Script : V1.0 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "Universal"
    },
    {
        name = "Infinite Giga Jump Troll Tower",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Infinite-Giga-Jump-Troll-Tower/IGJTT.lua",
        gamelink = "https://www.roblox.com/games/109259215974512/",
        namegame = "Universal (All Game)",
        descriptionEN = "This Script Have : \n - Loop Win \n - TP To Lobby \n - TP To Winning Place \n Version This Script : V1.0 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Kemenangan Loop \n - Teleport ke Lobi \n - Teleport ke Tempat Menang \n Versi Script : V1.0 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "109259215974512"
    },
    {
        name = "Funk Tower",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/Funk-Tower/FT.lua",
        gamelink = "https://www.roblox.com/games/96963101162715/",
        namegame = "Funk Tower",
        descriptionEN = "This Script Have : \n - Get All Tools And Mod \n - TP To Lobby \n - TP To Winning Place \n - Drop All Tools \n - Drop You Use Tools \n - Troll Part \n \n Unfinished \n Troll Part \n Version This Script : V0.5 \n Created By : Script_Test1290 & 12dyydu12",
        descriptionID = "Script Ini Mempunyai : \n - Dapatkan Semua Alat dan Mod \n - Teleport ke Lobi \n - Teleport ke Tempat Menang \n - Jatuhkan Semua Alat \n - Jatuhkan Alat yang Digunakan \n - Bagian Troll \n \n Belum Selesai \n Bagian Troll \n Versi Script : V0.5 \n Dibuat oleh : Script_Test1290 & 12dyydu12",
        photo = "rbxassetid://0",
        placeid = "96963101162715"
    },
    {
        name = "[New!] Evade",
        url = "https://raw.githubusercontent.com/Arvie1290/Natural_Disaster/evade/evadegui.lua",
        gamelink = "https://www.roblox.com/games/9872472334",
        namegame = "Evade (Can Universal)",
        descriptionEN = "This Script Have : \n - Auto Jump Toggle \n - No Gravity Toggle \n - Lag Switch Toggle \n - Part Float Toggle \n \n Version This Script : V0.9 \n Created By : @Script_Test1290",
        descriptionID = "Script Ini Mempunyai : \n - Lompat Otomatis \n - Tidak Ada Gravitasi \n - Lag Sementara \n - Blok Melayang \n \n Versi Script : V1.0 \n Dibuat oleh : @Script_Test1290",
        photo = "rbxassetid://11425766633",
        placeid = "9872472334"
    },
}

local debounceRun, debounceCopy = false, false
local currentScriptData = nil

function updateDetails(scriptData)
    currentScriptData = scriptData
    TitleScript.Text = scriptData.name or "{Title Script}"
    GameInfo.Text = scriptData.namegame or "{Game Name}"
    
    if Settings.language == "ID" and scriptData.descriptionID then  
        DescriptionBox.Text = "Deskripsi:\n"..(scriptData.descriptionID or "")  
        CopyGameLink.Text = "SALIN LINK GAME"  
        CopyLoad.Text = "SALIN LOADSTRING"  
        RunBtn.Text = "JALANKAN"  
    else  
        DescriptionBox.Text = "Description:\n"..(scriptData.descriptionEN or "")  
        CopyGameLink.Text = "COPY GAME LINK"  
        CopyLoad.Text = "COPY LOADSTRING"  
        RunBtn.Text = "RUN"  
    end
    
    Photo.Image = scriptData.photo or ""    
    task.wait(0.1)    
    local textSize = TextService:GetTextSize(DescriptionBox.Text, DescriptionBox.TextSize, DescriptionBox.Font, Vector2.new(math.max(DescriptionBox.AbsoluteSize.X,1), math.huge))    
    DescriptionBox.Size = UDim2.new(1, -10, 0, textSize.Y + 10)    
    DescScroll.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 20)
end

-- ============================================================================
-- PANEL NAVIGATION (FIXED CONNECTIONS)
-- ============================================================================
-- Menu Button Connections
UpdateLogBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("update")
end)

AboutBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("about")
end)

SettingsBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("settings")
end)

-- Close Button Connections (All return to Detail panel)
CloseUpdateLogBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("detail")
end)

CloseAboutBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("detail")
end)

CloseSettingsBtn.MouseButton1Click:Connect(function()
    PanelManager:showPanel("detail")
end)

-- Language Settings
LangOption.MouseButton1Click:Connect(function()
    Settings.language = Settings.language == "EN" and "ID" or "EN"
    LangOption.Text = Settings.language == "ID" and "Language: INDONESIA" or "Language: ENGLISH"
    LangOption.BackgroundColor3 = Settings.language == "ID" and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(60, 60, 0)
    LangOption.TextColor3 = Settings.language == "ID" and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 0)
    
    TitleText.Text = Settings.language == "ID" and "ArvieHub V1.2 - Bahasa Indonesia" or "ArvieHub V1.2"
    if currentScriptData then updateDetails(currentScriptData) end
    saveSettings()
end)

-- Auto Load Settings
AutoLoadOption.MouseButton1Click:Connect(function()
    Settings.autoLoad = not Settings.autoLoad
    AutoLoadOption.Text = Settings.autoLoad and "Auto Load: ON" or "Auto Load: OFF"
    AutoLoadOption.BackgroundColor3 = Settings.autoLoad and Color3.fromRGB(0, 60, 0) or Color3.fromRGB(60, 0, 0)
    AutoLoadOption.TextColor3 = Settings.autoLoad and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    saveSettings()
end)

-- ============================================================================
-- SCRIPT LIST
-- ============================================================================
local function updateScriptList()
    ScriptList:ClearAllChildren()
    local buttonHeight, spacing, totalHeight = 40, 5, 0
    
    for i, scriptData in ipairs(scripts) do
        local isCurrentGame = false
        if scriptData.placeid ~= "Universal" then
            if tostring(game.PlaceId) == scriptData.placeid then
                isCurrentGame = true
            end
        end
        
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -10, 0, buttonHeight)
        Button.Position = UDim2.new(0, 5, 0, totalHeight)
        Button.BackgroundColor3 = isCurrentGame and Color3.fromRGB(0, 60, 0) or Color3.fromRGB(40, 40, 40)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 16
        Button.Text = scriptData.name .. (isCurrentGame and " (CURRENT GAME)" or "")
        Button.TextXAlignment = Enum.TextXAlignment.Left
        Button.TextTruncate = Enum.TextTruncate.AtEnd
        Button.Parent = ScriptList
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(0, 20, 1, 0)
        IconLabel.Position = UDim2.new(1, -25, 0, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.TextColor3 = isCurrentGame and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(180, 180, 180)
        IconLabel.Font = Enum.Font.SourceSansBold
        IconLabel.TextSize = 14
        IconLabel.Text = isCurrentGame and "✓" or "›"
        IconLabel.TextXAlignment = Enum.TextXAlignment.Right
        IconLabel.Parent = Button
        
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.Parent = Button
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            updateDetails(scriptData)
        end)
        
        totalHeight = totalHeight + buttonHeight + spacing
    end
    
    ScriptList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    if #scripts > 0 then updateDetails(scripts[1]) end
end

updateScriptList()

-- ============================================================================
-- ACTION BUTTONS
-- ============================================================================
local function setclipboard(text)
    pcall(function()
        LocalPlayer:SetAttribute("Clipboard", text)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ArvieHub",
            Text = "Copied to clipboard!",
            Duration = 2
        })
    end)
end

CopyGameLink.MouseButton1Click:Connect(function()
    if not debounceCopy and currentScriptData and currentScriptData.gamelink ~= "" then
        debounceCopy = true
        setclipboard(currentScriptData.gamelink)
        task.wait(0.5)
        debounceCopy = false
    elseif currentScriptData and currentScriptData.gamelink == "" then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ArvieHub",
            Text = "No game link available",
            Duration = 2
        })
    end
end)

CopyLoad.MouseButton1Click:Connect(function()
    if not debounceCopy and currentScriptData then
        debounceCopy = true
        setclipboard(currentScriptData.url)
        task.wait(0.5)
        debounceCopy = false
    end
end)

RunBtn.MouseButton1Click:Connect(function()
    if not debounceRun and currentScriptData then
        debounceRun = true
        local notification = game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ArvieHub",
            Text = "Loading script...",
            Duration = 3
        })
        
        local success, errorMsg = pcall(function()
            loadstring(game:HttpGet(currentScriptData.url))()
        end)
        
        if not success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "ArvieHub - Error",
                Text = "Failed to load script: " .. tostring(errorMsg),
                Duration = 5
            })
        end
        
        task.wait(0.5)
        debounceRun = false
    end
end)

-- ============================================================================
-- FINAL INITIALIZATION
-- ============================================================================
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        ScreenGui.Enabled = not ScreenGui.Enabled
    elseif input.KeyCode == Enum.KeyCode.F2 then
        ScreenGui:Destroy()
    elseif input.KeyCode == Enum.KeyCode.F3 then
        PanelManager:showPanel("settings")
    end
end)

-- Initial setup
TitleText.Text = Settings.language == "ID" and "ArvieHub V1.2 - Bahasa Indonesia" or "ArvieHub V1.2"

local function autoSelectCurrentGame()
    for i, scriptData in ipairs(scripts) do
        if scriptData.placeid ~= "Universal" and tostring(game.PlaceId) == scriptData.placeid then
            updateDetails(scriptData)
            return true
        end
    end
    return false
end

if not autoSelectCurrentGame() then
    for i, scriptData in ipairs(scripts) do
        if scriptData.placeid == "Universal" then
            updateDetails(scriptData)
            break
        end
    end
end

task.spawn(function()
    wait(1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ArvieHub V1.2",
        Text = Settings.language == "ID" and "Berhasil dimuat! Tekan F1 untuk menyembunyikan." or "Successfully loaded! Press F1 to hide.",
        Duration = 5,
        Icon = "rbxassetid://123833064817810"
    })
end)

ScreenGui.Destroying:Connect(function()
    saveSettings()
    scripts = nil
    currentScriptData = nil
    Settings = nil
end)

print("[[ ARVIEHUB V1.2 (FIXED) LOADED SUCCESSFULLY ]]")
print("Game ID: " .. game.PlaceId)
print("Language: " .. Settings.language)
print("Scripts Loaded: " .. #scripts)

-- END OF FIXED SCRIPT

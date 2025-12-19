-- Official ArvieHub GUI (Full Version + Script Detail Viewer) - Final  
-- by Arvie1290  
  
local Players = game:GetService("Players")  
local CoreGui = game:GetService("CoreGui")  
local UserInputService = game:GetService("UserInputService")  
local TextService = game:GetService("TextService")  
local HttpService = game:GetService("HttpService")  
local LocalPlayer = Players.LocalPlayer  

-- Coba load settings dari file atau buat default
local Settings = {
    language = "EN", -- EN atau ID
    theme = "dark",  -- dark atau light (untuk masa depan)
    autoLoad = false -- untuk fitur masa depan
}

-- Fungsi untuk menyimpan settings
local function saveSettings()
    pcall(function()
        writefile("ArvieHub_Settings.json", HttpService:JSONEncode(Settings))
    end)
end

-- Fungsi untuk load settings
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

-- Load settings saat start
loadSettings()

-- Anti double execute  
if CoreGui:FindFirstChild("ArvieHub_Gui") then  
    CoreGui:FindFirstChild("ArvieHub_Gui"):Destroy()  
end  
  
-- GUI utama  
local ScreenGui = Instance.new("ScreenGui")  
ScreenGui.Name = "ArvieHub_Gui"  
ScreenGui.Parent = CoreGui  
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  
  
-- Frame utama  
local MainFrame = Instance.new("Frame")  
MainFrame.Size = UDim2.new(0, 600, 0, 350)  
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)  
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  
MainFrame.BorderSizePixel = 2  
MainFrame.Active = true  
MainFrame.Draggable = false  
MainFrame.Parent = ScreenGui  
  
-- Title bar  
local TitleBar = Instance.new("Frame")  
TitleBar.Size = UDim2.new(1, -120, 0, 30)  -- Diperlebar untuk tombol settings
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)  
TitleBar.Parent = MainFrame  

-- Photo frame di title bar (MENGGUNAKAN TEXTURE ID YANG DIBERIKAN)
local TitlePhotoFrame = Instance.new("ImageLabel")
TitlePhotoFrame.Size = UDim2.new(0, 28, 0, 28) -- Sedikit lebih besar
TitlePhotoFrame.Position = UDim2.new(0, 3, 0.5, -14) -- Posisi kiri tengah
TitlePhotoFrame.BackgroundTransparency = 1
TitlePhotoFrame.Image = "rbxassetid://123833064817810" -- TEXTURE ID YANG DIBERIKAN
TitlePhotoFrame.ScaleType = Enum.ScaleType.Fit
TitlePhotoFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
TitlePhotoFrame.BorderSizePixel = 1
TitlePhotoFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
TitlePhotoFrame.Parent = TitleBar

-- Text label untuk judul di samping kanan photo
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
  
-- Tombol close  
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
  
-- Tombol minimize  
local MinimizeBtn = Instance.new("TextButton")  
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)  
MinimizeBtn.Position = UDim2.new(1, -90, 0, 0)  
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)  
MinimizeBtn.Text = "-"  
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)  
MinimizeBtn.Font = Enum.Font.SourceSansBold  
MinimizeBtn.TextSize = 18  
MinimizeBtn.Parent = MainFrame  
  
-- Tombol Settings 💾
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 30, 0, 30)
SettingsBtn.Position = UDim2.new(1, -60, 0, 0)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
SettingsBtn.Text = "💾"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
SettingsBtn.Font = Enum.Font.SourceSansBold
SettingsBtn.TextSize = 18
SettingsBtn.Parent = MainFrame

-- Tombol Beta  
local BetaBtn = Instance.new("TextButton")  
BetaBtn.Size = UDim2.new(0, 30, 0, 30)  
BetaBtn.Position = UDim2.new(1, -120, 0, 0)  -- Posisi digeser karena ada tombol settings
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

local isMinimized = false  
MinimizeBtn.MouseButton1Click:Connect(function()  
    isMinimized = not isMinimized  
    for _, v in pairs(MainFrame:GetChildren()) do  
        if v ~= TitleBar and v ~= CloseBtn and v ~= MinimizeBtn and v ~= SettingsBtn and v ~= BetaBtn then  
            v.Visible = not isMinimized  
        end  
    end  
    MainFrame.Size = isMinimized and UDim2.new(0, 600, 0, 30) or UDim2.new(0, 600, 0, 350)  
    MinimizeBtn.Text = isMinimized and "+" or "-"  
end)  
  
-- Dragging  
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

TitlePhotoFrame.InputBegan:Connect(function(input)  
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

TitleText.InputBegan:Connect(function(input)  
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
  
-- Frame kiri (Script List)  
local ScriptList = Instance.new("ScrollingFrame")  
ScriptList.Size = UDim2.new(0.45, -5, 1, -40)  
ScriptList.Position = UDim2.new(0, 5, 0, 35)  
ScriptList.BackgroundTransparency = 1  
ScriptList.ScrollBarThickness = 6  
ScriptList.Parent = MainFrame  
  
-- Frame kanan (Detail)  
local DetailFrame = Instance.new("Frame")  
DetailFrame.Size = UDim2.new(0.55, -10, 1, -40)  
DetailFrame.Position = UDim2.new(0.45, 5, 0, 35)  
DetailFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  
DetailFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  
DetailFrame.BorderSizePixel = 2  
DetailFrame.Parent = MainFrame  
  
-- Detail isi  
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
  
-- Tombol bawah  
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
  
-- Data scripts        
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
  
-- Variabel debounce  
local debounceRun = false  
local debounceCopy = false  
local currentScriptData = nil  

-- Fungsi update detail dengan bahasa
function updateDetails(scriptData)  
    currentScriptData = scriptData  
    TitleScript.Text = scriptData.name or "{Title Script}"  
    GameInfo.Text = scriptData.namegame or "{Game Name}"  
    
    -- Pilih deskripsi berdasarkan bahasa
    if Settings.language == "ID" and scriptData.descriptionID then
        DescriptionBox.Text = "Deskripsi:\n"..(scriptData.descriptionID or "")
        -- Update teks tombol
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
-- SETTINGS MENU
-- ============================================================================

-- Frame settings (hidden by default)
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(0, 300, 0, 200)
SettingsFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
SettingsFrame.BorderSizePixel = 2
SettingsFrame.Visible = false
SettingsFrame.ZIndex = 100
SettingsFrame.Parent = ScreenGui

-- Title settings
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, 0, 0, 40)
SettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
SettingsTitle.Text = "⚙️ Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 0)
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextSize = 20
SettingsTitle.Parent = SettingsFrame

-- Close settings button
local CloseSettingsBtn = Instance.new("TextButton")
CloseSettingsBtn.Size = UDim2.new(0, 30, 0, 30)
CloseSettingsBtn.Position = UDim2.new(1, -30, 0, 5)
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseSettingsBtn.Text = "X"
CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseSettingsBtn.Font = Enum.Font.SourceSansBold
CloseSettingsBtn.TextSize = 16
CloseSettingsBtn.Parent = SettingsFrame

CloseSettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

-- Language selection
local LanguageLabel = Instance.new("TextLabel")
LanguageLabel.Size = UDim2.new(1, -20, 0, 30)
LanguageLabel.Position = UDim2.new(0, 10, 0, 50)
LanguageLabel.BackgroundTransparency = 1
LanguageLabel.Text = "Language / Bahasa:"
LanguageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LanguageLabel.Font = Enum.Font.SourceSansBold
LanguageLabel.TextSize = 16
LanguageLabel.Parent = SettingsFrame

-- English button
local EnglishBtn = Instance.new("TextButton")
EnglishBtn.Size = UDim2.new(0.45, 0, 0, 35)
EnglishBtn.Position = UDim2.new(0, 10, 0, 85)
EnglishBtn.BackgroundColor3 = Settings.language == "EN" and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
EnglishBtn.Text = "🇬🇧 English"
EnglishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnglishBtn.Font = Enum.Font.SourceSansBold
EnglishBtn.TextSize = 14
EnglishBtn.Parent = SettingsFrame

-- Indonesian button
local IndonesianBtn = Instance.new("TextButton")
IndonesianBtn.Size = UDim2.new(0.45, 0, 0, 35)
IndonesianBtn.Position = UDim2.new(0.55, -10, 0, 85)
IndonesianBtn.BackgroundColor3 = Settings.language == "ID" and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
IndonesianBtn.Text = "🇮🇩 Indonesia"
IndonesianBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
IndonesianBtn.Font = Enum.Font.SourceSansBold
IndonesianBtn.TextSize = 14
IndonesianBtn.Parent = SettingsFrame

-- Apply button
local ApplyBtn = Instance.new("TextButton")
ApplyBtn.Size = UDim2.new(0.8, 0, 0, 40)
ApplyBtn.Position = UDim2.new(0.1, 0, 1, -50)
ApplyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
ApplyBtn.Text = "Apply Changes"
ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyBtn.Font = Enum.Font.SourceSansBold
ApplyBtn.TextSize = 16
ApplyBtn.Parent = SettingsFrame

-- Status text
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 20)
StatusText.Position = UDim2.new(0, 10, 1, -25)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Settings saved to ArvieHub_Settings.json"
StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusText.Font = Enum.Font.SourceSans
StatusText.TextSize = 12
StatusText.Visible = false
StatusText.Parent = SettingsFrame

-- Fungsi untuk update tampilan language buttons
local function updateLanguageButtons()
    if Settings.language == "EN" then
        EnglishBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        IndonesianBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ApplyBtn.Text = "Apply Changes"
        LanguageLabel.Text = "Language / Bahasa:"
    else
        EnglishBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        IndonesianBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        ApplyBtn.Text = "Terapkan Perubahan"
        LanguageLabel.Text = "Bahasa / Language:"
    end
end

-- Event handlers untuk tombol bahasa
EnglishBtn.MouseButton1Click:Connect(function()
    Settings.language = "EN"
    updateLanguageButtons()
end)

IndonesianBtn.MouseButton1Click:Connect(function()
    Settings.language = "ID"
    updateLanguageButtons()
end)

-- Event handler untuk tombol apply
ApplyBtn.MouseButton1Click:Connect(function()
    -- Simpan settings ke file
    saveSettings()
    
    -- Update deskripsi script yang sedang aktif
    if currentScriptData then
        updateDetails(currentScriptData)
    end
    
    -- Tampilkan status
    if Settings.language == "ID" then
        StatusText.Text = "Pengaturan disimpan ke ArvieHub_Settings.json"
    else
        StatusText.Text = "Settings saved to ArvieHub_Settings.json"
    end
    
    StatusText.Visible = true
    task.wait(2)
    StatusText.Visible = false
    
    -- Tutup settings
    SettingsFrame.Visible = false
end)

-- Event handler untuk tombol settings
SettingsBtn.MouseButton1Click:Connect(function()
    updateLanguageButtons()
    SettingsFrame.Visible = not SettingsFrame.Visible
end)

-- ============================================================================
-- MAIN FUNCTIONS
-- ============================================================================

-- Tombol copy Game Link  
CopyGameLink.MouseButton1Click:Connect(function()  
    if currentScriptData and setclipboard and not debounceCopy then  
        debounceCopy = true  
        setclipboard(currentScriptData.gamelink or "")  
        task.delay(0.3, function()  
            debounceCopy = false  
        end)  
    end  
end)  
  
-- Tombol copy Loadstring  
CopyLoad.MouseButton1Click:Connect(function()  
    if currentScriptData and setclipboard and not debounceCopy then  
        debounceCopy = true  
        setclipboard(currentScriptData.url and 'loadstring(game:HttpGet("'..currentScriptData.url..'"))()' or "")  
        task.delay(0.3, function()  
            debounceCopy = false  
        end)  
    end  
end)  
  
-- Tombol Run  
RunBtn.MouseButton1Click:Connect(function()  
    if currentScriptData and currentScriptData.url and not debounceRun then  
        debounceRun = true  
        pcall(function()  
            loadstring(game:HttpGet(currentScriptData.url))()  
        end)  
        task.delay(0.5, function()  
            debounceRun = false  
        end)  
    end  
end)  
  
-- Membuat tombol list script  
local selectedButton = nil  
local function createScriptButton(scriptData, index)  
    local btn = Instance.new("TextButton")  
    btn.Size = UDim2.new(1, -10, 0, 35)  
    btn.Position = UDim2.new(0, 5, 0, (index-1)*40)  
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)  
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)  
    btn.Font = Enum.Font.SourceSansBold  
    btn.TextSize = 16  
    btn.Text = scriptData.name or "Script"  
    btn.Parent = ScriptList  
  
    btn.MouseButton1Click:Connect(function()  
        if selectedButton then  
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 0, 0)  
        end  
        selectedButton = btn  
        btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)  
        updateDetails(scriptData)  
    end)  
end  
  
-- Buat semua tombol list  
for i, s in ipairs(scripts) do  
    createScriptButton(s, i)  
end  
  
-- Auto pilih script pertama  
if #scripts > 0 then  
    updateDetails(scripts[1])  
    ScriptList:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(60,0,0)  
    selectedButton = ScriptList:FindFirstChildOfClass("TextButton")  
end  

-- Update language buttons saat pertama kali load
updateLanguageButtons()

-- Dragging untuk settings frame
local draggingSettings = false
local dragStartSettings, startPosSettings

local function updateDragSettings(input)
    local delta = input.Position - dragStartSettings
    SettingsFrame.Position = UDim2.new(startPosSettings.X.Scale, startPosSettings.X.Offset + delta.X, startPosSettings.Y.Scale, startPosSettings.Y.Offset + delta.Y)
end

SettingsTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSettings = true
        dragStartSettings = input.Position
        startPosSettings = SettingsFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingSettings = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingSettings and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDragSettings(input)
    end
end)

-- Update ScriptList size
ScriptList.CanvasSize = UDim2.new(0, 0, 0, #scripts * 40)

-- ============================================================================
-- OPTIONAL: TOOLTIP DAN EFEK UNTUK PHOTO FRAME
-- ============================================================================

-- Tooltip untuk photo frame
local Tooltip = Instance.new("TextLabel")
Tooltip.Size = UDim2.new(0, 150, 0, 30)
Tooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
Tooltip.Text = "ArvieHub Logo - Version 1.2"
Tooltip.Font = Enum.Font.SourceSans
Tooltip.TextSize = 12
Tooltip.Visible = false
Tooltip.Parent = ScreenGui
Tooltip.ZIndex = 1000

TitlePhotoFrame.MouseEnter:Connect(function()
    Tooltip.Visible = true
    Tooltip.Position = UDim2.new(0, TitlePhotoFrame.AbsolutePosition.X, 0, TitlePhotoFrame.AbsolutePosition.Y - 35)
end)

TitlePhotoFrame.MouseLeave:Connect(function()
    Tooltip.Visible = false
end)

TitlePhotoFrame.MouseMoved:Connect(function()
    if Tooltip.Visible then
        Tooltip.Position = UDim2.new(0, TitlePhotoFrame.AbsolutePosition.X, 0, TitlePhotoFrame.AbsolutePosition.Y - 35)
    end
end)

-- Efek hover untuk photo frame
TitlePhotoFrame.MouseEnter:Connect(function()
    TitlePhotoFrame.ImageColor3 = Color3.fromRGB(255, 200, 200)
    TitlePhotoFrame.BorderColor3 = Color3.fromRGB(255, 255, 0)
end)

TitlePhotoFrame.MouseLeave:Connect(function()
    TitlePhotoFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
    TitlePhotoFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
end)

-- ============================================================================
-- FUNGSI BACKUP JIKA TEXTURE ID TIDAK BEKERJA
-- ============================================================================

-- Cek apakah texture ID valid
task.spawn(function()
    wait(2) -- Tunggu sedikit
    
    -- Jika gambar tidak muncul, coba format lain
    if TitlePhotoFrame.ImageTransparency == 1 or TitlePhotoFrame.Image == "" then
        print("Texture ID tidak bekerja, mencoba format alternatif...")
        
        -- Coba format lain
        TitlePhotoFrame.Image = "http://www.roblox.com/asset/?id=123833064817810"
        
        -- Jika masih tidak bekerja, gunakan backup image
        wait(1)
        if TitlePhotoFrame.ImageTransparency == 1 then
            print("Menggunakan backup image...")
            TitlePhotoFrame.Image = "rbxassetid://75756933857153" -- Backup ID yang sudah terbukti bekerja
        end
    end
end)

if game.PlaceId ~= 109259215974512 then
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "❌ Error",
Text = "Only Work In Map Infinite Giga Troll Jump Tower! (109259215974512)",
Duration = 5
})
return
end

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local playerGui = player:WaitForChild("PlayerGui")

-- Anti execute 2 kali
if playerGui:FindFirstChild("IGJTTGui") then
    playerGui:FindFirstChild("IGJTTGui"):Destroy()
end
if _G.IGJTTGuiCleanup and type(_G.IGJTTGuiCleanup) == "function" then
    pcall(_G.IGJTTGuiCleanup)
    _G.IGJTTGuiCleanup = nil
end

-- Buat GUI
local gui = Instance.new("ScreenGui")
gui.Name = "IGJTTGui" -- konsisten
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Koordinat
local coords = {
win = Vector3.new(755.524, 1136.049, 1193.198),
tower = Vector3.new(802.487, 231.259, 685.611), -- isi sendiri
winningPlace = Vector3.new(753.765, 1138.061, 1165.221) -- isi sendiri
}

-- Fungsi teleport
local function teleport(target)
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
hrp.CFrame = CFrame.new(target)
end

-- Frame utama
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 240)
frame.Position = UDim2.new(0.5, -130, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

-- Title
local title = Instance.new("TextButton", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Infinite Giga Jump Troll Tower ⌄"
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.BorderSizePixel = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Fungsi buat tombol
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

-- Button 1 (Loop Win)
local loopTpEnabled = false
local btn1 = createButton("Loop Win", UDim2.new(0, 20, 0, 60), function()
loopTpEnabled = not loopTpEnabled
if loopTpEnabled then
-- TP sekali dulu
teleport(coords.win)
StarterGui:SetCore("SendNotification", {
Title = "Information!",
Text = "To disable loop teleport, press button 1 again!",
Duration = 5
})
-- Loop teleport
task.spawn(function()
while loopTpEnabled do
teleport(coords.win)
task.wait(0.1)
end
end)
else
StarterGui:SetCore("SendNotification", {
Title = "Status",
Text = "Your Status Has Been Updated To Unloop Teleport!",
Duration = 5
})
end
end)

-- Button 2 (TP To Tower)
local btn2 = createButton("TP To Tower", UDim2.new(0, 20, 0, 110), function()
teleport(coords.tower)
StarterGui:SetCore("SendNotification", {
Title = "Information",
Text = "Teleported to Tower! (edit coords if wrong)",
Duration = 5
})
end)

-- Button 3 (TP To The Winning Place)
local btn3 = createButton("TP To The Winning Place", UDim2.new(0, 20, 0, 160), function()
teleport(coords.winningPlace)
StarterGui:SetCore("SendNotification", {
Title = "Information",
Text = "Teleported to Winning Place! (edit coords if wrong)",
Duration = 5
})
end)

-- Label made by
local madeby = Instance.new("TextLabel", frame)
madeby.Size = UDim2.new(0.6, 0, 0, 30)
madeby.Position = UDim2.new(0, 20, 1, -35)
madeby.BackgroundTransparency = 1
madeby.Text = "MADE BY : SCRIPT_TEST1230"
madeby.Font = Enum.Font.Arcade
madeby.TextScaled = true
madeby.TextColor3 = Color3.new(1, 1, 1)

-- Tombol close
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
loopTpEnabled = false
gui:Destroy()
_G.IGJTTGuiCleanup = nil
end)

-- Expand/Collapse
local isOpen = true
title.MouseButton1Click:Connect(function()
isOpen = not isOpen
local targetSize = isOpen and UDim2.new(0, 260, 0, 240) or UDim2.new(0, 260, 0, 40)
title.Text = isOpen and "Infinite Giga Jump Troll Tower ⌄" or "Infinite Giga Jump Troll Tower ⌃"
TweenService:Create(frame, TweenInfo.new(0.25), {Size = targetSize}):Play()
btn1.Visible = isOpen
btn2.Visible = isOpen
btn3.Visible = isOpen
madeby.Visible = isOpen
close.Visible = isOpen
end)

-- Cleanup function
_G.IGJTTGuiCleanup = function()
pcall(function() if gui and gui.Parent then gui:Destroy() end end)
loopTpEnabled = false
_G.IGJTTGuiCleanup = nil
end

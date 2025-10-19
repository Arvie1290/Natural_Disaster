if game.PlaceId ~= 96963101162715 then          
    game:GetService("StarterGui"):SetCore("SendNotification", {          
        Title = "❌ Error",          
        Text = "Only Work In Map Funk Tower! (96963101162715)",          
        Duration = 5          
    })          
    return          
end          

local player = game.Players.LocalPlayer          
local TweenService = game:GetService("TweenService")          
local playerGui = player:WaitForChild("PlayerGui")          

if playerGui:FindFirstChild("FunkTowerGUI") then        
    playerGui:FindFirstChild("FunkTowerGUI"):Destroy()        
end        
if _G.SlapTowerCleanup and type(_G.SlapTowerCleanup) == "function" then        
    pcall(_G.SlapTowerCleanup)        
    _G.SlapTowerCleanup = nil        
end        

local gui = Instance.new("ScreenGui")        
gui.Name = "FunkTowerGUI"        
gui.ResetOnSpawn = false        
gui.Parent = playerGui        

local coords = {        
    lobby = Vector3.new(182.385, -53.365, -10.717),        
    mainGame = Vector3.new(279.357, 467.453, -6.240)        
}        

local coordsMod = {        
    Vector3.new(172.192, -53.482, 383.197),        
    Vector3.new(162.812, -53.484, 383.955),        
    Vector3.new(77.350, -53.538, 21.580),        
    Vector3.new(77.560, -53.535, -3.177),        
    Vector3.new(77.562, -53.537, -28.106),  
    Vector3.new(135.078, -53.556, -273.497),  
    Vector3.new(203.745, -53.384, -59.912),  
    Vector3.new(197.793, -52.484, -60.370),  
    Vector3.new(210.574, -52.482, -60.102),  
    Vector3.new(-213.600, 6.144, 49.285),  
    Vector3.new(152.103, 146.195, 27.999),  
    Vector3.new(280.382, 467.454, -119.939),  
    Vector3.new(386.301, 467.631, -6.307),  
    Vector3.new(179.658, -53.367, 20.154),  
}        

local trollCoords = {        
    Vector3.new(267.563, 464.535, -6.112),        
    Vector3.new(255.341, 466.413, -7.238),        
    Vector3.new(245.297, 464.523, -5.710),        
    Vector3.new(234.688, 464.664, -3.817),  
    Vector3.new(156.220, 46.936, -5.384),  
    Vector3.new(153.173, 47.478, -9.403),  
    Vector3.new(155.317, 47.337, -13.499),  
    Vector3.new(154.300, 47.308, -17.322),  
    Vector3.new(152.433, 47.219, -21.457),  
    Vector3.new(153.001, 47.027, -25.374),  
    Vector3.new(155.891, 47.433, -29.311),  
    Vector3.new(152.450, -24.866, -1.440),  
    Vector3.new(153.417, -24.900, -9.288),  
    Vector3.new(153.417, -24.900, -9.288),  
    Vector3.new(150.942, -24.826, -17.162),  
    Vector3.new(132.465, -4.814, 50.201),  
    Vector3.new(136.020, -5.807, 17.326),  
    Vector3.new(134.667, -6.566, 3.556),  
    Vector3.new(137.722, -5.976, -7.103),  
    Vector3.new(130.232, -4.591, -40.353),  
    Vector3.new(1.721, -4.886, 48.432),  
    Vector3.new(-1.298, -4.827, 47.885),  
    Vector3.new(-3.979, -4.821, 48.431),  
    Vector3.new(-10.393, -4.574, 49.882),  
    Vector3.new(-13.278, -5.210, 49.615),  
    Vector3.new(-16.238, -5.075, 51.507),  
}        

local function teleport(target)  
    local char = player.Character or player.CharacterAdded:Wait()  
    local hrp = char:WaitForChild("HumanoidRootPart")  
    hrp.CFrame = CFrame.new(target)  
end  

-- Buat GUI frame
local frame = Instance.new("Frame", gui)  
frame.Size = UDim2.new(0, 260, 0, 400)  
frame.Position = UDim2.new(0.5, -130, 0.4, 0)  
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)  
frame.BorderSizePixel = 0  
frame.Active = true  
frame.Draggable = true  
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)  

local title = Instance.new("TextButton", frame)  
title.Size = UDim2.new(1, 0, 0, 40)  
title.Text = "Funk Tower >"  
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

-- Buttons 1-5 (sama seperti sebelumnya)
local btn1 = createButton("Get All Tools And Mod!", UDim2.new(0, 20, 0, 60), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local initialPos = hrp.Position
    task.spawn(function()
        teleport(coordsMod[1])
        task.wait(0.01)
        for _, pos in ipairs(coordsMod) do
            teleport(pos)
            task.wait(0.01)
        end
        teleport(initialPos)
    end)
end)

local btn2 = createButton("TP To Lobby", UDim2.new(0, 20, 0, 110), function()
    teleport(coords.lobby)
end)

local btn3 = createButton("TP To Winning Place", UDim2.new(0, 20, 0, 160), function()
    teleport(coords.mainGame)
end)

local btn4 = createButton("Drop All Tools!", UDim2.new(0, 20, 0, 210), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = workspace
            if tool:FindFirstChild("Handle") then
                tool.Handle.CFrame = hrp.CFrame + Vector3.new(0,2,0)
            end
        end
    end
end)

local btn5 = createButton("Drop You Use Tools!", UDim2.new(0, 20, 0, 260), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = workspace
            if tool:FindFirstChild("Handle") then
                tool.Handle.CFrame = hrp.CFrame + Vector3.new(0,2,0)
            end
        end
    end
end)

-- Button 6: Troll Part teleport sekali dengan delay 0.5 detik
local btn6 = createButton("Troll Part", UDim2.new(0, 20, 0, 310), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local initialPos = hrp.Position

    task.spawn(function()
        for _, pos in ipairs(trollCoords) do
            hrp.CFrame = CFrame.new(pos)
            task.wait(0.001)
        end
        hrp.CFrame = CFrame.new(initialPos)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Information",
            Text = "Troll teleport finished!",
            Duration = 5
        })
    end)
end)

-- Made by label
local madeby = Instance.new("TextLabel", frame)  
madeby.Size = UDim2.new(0.6, 0, 0, 30)  
madeby.Position = UDim2.new(0, 20, 1, -35)  
madeby.BackgroundTransparency = 1  
madeby.Text = "MADE BY : SCRIPT_TEST1230"  
madeby.Font = Enum.Font.Arcade  
madeby.TextScaled = true  
madeby.TextColor3 = Color3.new(1, 1, 1)  

-- Close button
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
    _G.SlapTowerCleanup = nil  
    _G.IsTrollLooping = false
end)  

-- Toggle minimize
local isOpen = true  
title.MouseButton1Click:Connect(function()  
    isOpen = not isOpen  
    local targetSize = isOpen and UDim2.new(0, 260, 0, 400) or UDim2.new(0, 260, 0, 40)  
    title.Text = isOpen and "Funk Tower >" or "Funk Tower <"  
    TweenService:Create(frame, TweenInfo.new(0.25), {Size = targetSize}):Play()  
    btn1.Visible = isOpen  
    btn2.Visible = isOpen  
    btn3.Visible = isOpen  
    btn4.Visible = isOpen  
    btn5.Visible = isOpen  
    btn6.Visible = isOpen  
    madeby.Visible = isOpen  
    close.Visible = isOpen  
end)  

-- Cleanup
_G.SlapTowerCleanup = function()  
    pcall(function() if gui and gui.Parent then gui:Destroy() end end)  
    _G.SlapTowerCleanup = nil  
    _G.IsTrollLooping = false
end

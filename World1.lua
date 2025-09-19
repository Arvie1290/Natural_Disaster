-- GUI TELEPORT SCRIPT | Pull A Friend
if game.PlaceId ~= 16590754220 then  
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = "❌ Error",  
        Text = "Only Work In Pull A Friend! (16590754220)",  
        Duration = 5  
    })  
    return  
end  

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local playerGui = player:WaitForChild("PlayerGui")

-- Cek GUI agar tidak dieksekusi dua kali
if playerGui:FindFirstChild("PullAFriend_2Player") then return end

-- Buat GUI utama
local gui = Instance.new("ScreenGui")
gui.Name = "PullAFriend_2Player"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Checkpoints
local checkpoints = {
    Vector3.new(-64.120, 196.981, -24.221),
    Vector3.new(108.007, 186.959, -784.562),
    Vector3.new(909.017, 207.393, -698.746),
    Vector3.new(2111.972, 658.729, -887.631),
    Vector3.new(2111.972, 658.729, -887.631)
}

-- Lobby position
local lobbyPos = Vector3.new(301.155, 484.841, 31.534)

-- Fungsi teleport dan tween
local function teleport(target)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(target)
end

local function tweenTo(target)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local tween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame=CFrame.new(target)})
    tween:Play()
    tween.Completed:Wait()
end

-- Frame utama (dilebarin)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,280)
frame.Position = UDim2.new(0.5,-150,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- Title utama
local title = Instance.new("TextButton", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Pull A Friend ⌄"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.BorderSizePixel = 0
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- Fungsi tombol
local function createButton(parent,text,pos,action)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-20,0,40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.TextColor3 = Color3.new(0,0,0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    btn.MouseButton1Click:Connect(action)
    return btn
end

-- Button1: TP All Checkpoints (Tween)
local btn1 = createButton(frame,"TP All Checkpoints (Tween)\nSelect your team before pressing!",UDim2.new(0,10,0,60),function()
    task.spawn(function()
        for _,pos in ipairs(checkpoints) do
            tweenTo(pos)
            task.wait(3)
        end
    end)
end)

-- Button2: Select Checkpoint
local btn2 = createButton(frame,"Select Checkpoint",UDim2.new(0,10,0,120),function()
    local existing = gui:FindFirstChild("CheckpointFrame")
    if existing then
        existing.Visible = not existing.Visible
        return
    end

    -- Frame select checkpoint
    local cpFrame = Instance.new("Frame", gui)
    cpFrame.Name = "CheckpointFrame"
    cpFrame.Size = UDim2.new(0,260,0,360)
    cpFrame.Position = UDim2.new(0.5,-130,0.2,0)
    cpFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    cpFrame.Active = true
    cpFrame.Draggable = true
    Instance.new("UICorner", cpFrame).CornerRadius = UDim.new(0,12)

    -- Title
    local cpTitle = Instance.new("TextLabel", cpFrame)
    cpTitle.Size = UDim2.new(1,0,0,30)
    cpTitle.Position = UDim2.new(0,0,0,0)
    cpTitle.BackgroundColor3 = Color3.fromRGB(0,0,0)
    cpTitle.TextColor3 = Color3.new(1,1,1)
    cpTitle.Text = "Select Checkpoint"
    cpTitle.Font = Enum.Font.GothamBold
    cpTitle.TextScaled = true
    Instance.new("UICorner", cpTitle).CornerRadius = UDim.new(0,12)

    -- Close button
    local closeCP = createButton(cpFrame,"X",UDim2.new(1,-35,0,5),function()
        cpFrame:Destroy()
    end)
    closeCP.Size = UDim2.new(0,30,0,30)

    -- Scroll frame
    local scroll = Instance.new("ScrollingFrame", cpFrame)
    scroll.Size = UDim2.new(1,-20,1,-140)
    scroll.Position = UDim2.new(0,10,0,40)
    scroll.CanvasSize = UDim2.new(0,0,#checkpoints*50)
    scroll.ScrollBarThickness = 8
    scroll.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Mode selection
    local selectedMode = "Tween"
    local tweenCheck = Instance.new("TextButton", cpFrame)
    tweenCheck.Size = UDim2.new(0,100,0,30)
    tweenCheck.Position = UDim2.new(0,10,1,-80)
    tweenCheck.Text = "Tween [X]"
    tweenCheck.Font = Enum.Font.GothamBold
    tweenCheck.TextScaled = true
    tweenCheck.BackgroundColor3 = Color3.fromRGB(200,200,200)

    local tpCheck = Instance.new("TextButton", cpFrame)
    tpCheck.Size = UDim2.new(0,100,0,30)
    tpCheck.Position = UDim2.new(0,130,1,-80)
    tpCheck.Text = "TP [ ]"
    tpCheck.Font = Enum.Font.GothamBold
    tpCheck.TextScaled = true
    tpCheck.BackgroundColor3 = Color3.fromRGB(200,200,200)

    local function updateChecks()
        if selectedMode == "Tween" then
            tweenCheck.Text = "Tween [X]"
            tpCheck.Text = "TP [ ]"
        else
            tweenCheck.Text = "Tween [ ]"
            tpCheck.Text = "TP [X]"
        end
    end

    tweenCheck.MouseButton1Click:Connect(function()
        selectedMode = "Tween"
        updateChecks()
    end)
    tpCheck.MouseButton1Click:Connect(function()
        selectedMode = "TP"
        updateChecks()
    end)
    updateChecks()

    -- Tombol checkpoint
    local selectedCheckpoint = nil
    for i,pos in ipairs(checkpoints) do
        createButton(scroll,"Checkpoint "..i,UDim2.new(0,0,0,(i-1)*50),function()
            selectedCheckpoint = pos
        end)
    end

    -- Tombol Go
    local goBtn = createButton(cpFrame,"Go",UDim2.new(0,70,1,-40),function()
        if selectedCheckpoint then
            if selectedMode=="Tween" then
                tweenTo(selectedCheckpoint)
            else
                teleport(selectedCheckpoint)
            end
        end
    end)
    goBtn.Size = UDim2.new(0,70,0,30)
end)

-- Button3: TP to Lobby (Tween)
local btn3 = createButton(frame,"TP to Lobby (Tween)",UDim2.new(0,10,0,180),function()
    tweenTo(lobbyPos)
end)

-- Label pembuat
local madeby = Instance.new("TextLabel", frame)
madeby.Size = UDim2.new(0.7,0,0,30)
madeby.Position = UDim2.new(0,20,1,-50)
madeby.BackgroundTransparency = 1
madeby.Text = "MADE BY : SCRIPT_TEST1230"
madeby.Font = Enum.Font.Arcade
madeby.TextScaled = true
madeby.TextColor3 = Color3.new(1,1,1)

-- Label tambahan bawah pembuat
local comingSoon = Instance.new("TextLabel", frame)
comingSoon.Size = UDim2.new(0.9,0,0,20)
comingSoon.Position = UDim2.new(0,20,1,-25)
comingSoon.BackgroundTransparency = 1
comingSoon.Text = "Other Worlds Coming Soon!"
comingSoon.Font = Enum.Font.Arcade
comingSoon.TextScaled = true
comingSoon.TextColor3 = Color3.new(1,1,1)
comingSoon.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol close utama
local close = createButton(frame,"X",UDim2.new(1,-40,1,-40),function()
    local cp = gui:FindFirstChild("CheckpointFrame")
    if cp then cp:Destroy() end
    gui:Destroy()
end)
close.Size = UDim2.new(0,30,0,30)

-- Toggle / Minimize GUI
local isOpen = true
title.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    title.Text = isOpen and "Pull A Friend ⌄" or "Pull A Friend ⌃"
    local targetSize = isOpen and UDim2.new(0,300,0,280) or UDim2.new(0,300,0,40)
    TweenService:Create(frame, TweenInfo.new(0.25), {Size = targetSize}):Play()
    btn1.Visible = isOpen
    btn2.Visible = isOpen
    btn3.Visible = isOpen
    madeby.Visible = isOpen
    comingSoon.Visible = isOpen
    close.Visible = isOpen
end)

-- Cleanup global
_G.SlapTowerCleanup = function()
    pcall(function() 
        if gui and gui.Parent then 
            local cp = gui:FindFirstChild("CheckpointFrame")
            if cp then cp:Destroy() end
            gui:Destroy() 
        end
    end)
    _G.SlapTowerCleanup = nil
end

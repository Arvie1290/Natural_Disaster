-- SAB Modded GUI Final (Stable)
-- Executor-ready

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- cleanup old
if playerGui:FindFirstChild("SAB_Mod_Fixed") then
pcall(function() playerGui:FindFirstChild("SAB_Mod_Fixed"):Destroy() end)
end

local function notify(title, text, dur)
pcall(function()
StarterGui:SetCore("SendNotification",{Title=title,Text=text,Duration=dur or 4})
end)
end

local function getHRP()
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
if not char then return nil end
return char:FindFirstChild("HumanoidRootPart")
end

local function tpTo(pos)
local hrp = getHRP()
if not hrp then return end
hrp.CFrame = CFrame.new(pos)
end

local function tweenTo(hrp,pos,speed)
if not hrp then return end
local dist = (hrp.Position-pos).Magnitude
local duration = math.max(0.01,dist/math.max(speed,0.0001))
local tw = TweenService:Create(hrp,TweenInfo.new(duration,Enum.EasingStyle.Linear),{CFrame=CFrame.new(pos)})
local done=false
tw.Completed:Connect(function() done=true end)
tw:Play()
while not done do task.wait() end
end

-- state
local coords = {Base=nil,Lock=nil}
local modes = {B1="TP",B2="TP",B3="TP"}
local busy = {B1=false,B2=false,B3=false}
local originalPos_B1=nil

-- GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name="SAB_Mod_Fixed"
screenGui.ResetOnSpawn=false
screenGui.Parent=playerGui

local FRAME_W,FRAME_H = 260,260
local MIN_H=40
local openSize=UDim2.new(0,FRAME_W,0,FRAME_H)
local minSize=UDim2.new(0,FRAME_W,0,MIN_H)

local frame=Instance.new("Frame",screenGui)
frame.Size=openSize
frame.Position=UDim2.new(0.35,0,0.28,0)
frame.BackgroundColor3=Color3.fromRGB(40,40,40)
frame.BorderSizePixel=0
frame.Active=true
frame.Draggable=true
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,12)

local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,-80,0,30)
title.Position=UDim2.new(0,10,0,5)
title.BackgroundTransparency=1
title.Text="SAB Modded"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.GothamBold
title.TextScaled=true
title.TextXAlignment=Enum.TextXAlignment.Left

local closeBtn=Instance.new("TextButton",frame)
closeBtn.Size=UDim2.new(0,28,0,24)
closeBtn.Position=UDim2.new(1,-36,0,6)
closeBtn.BackgroundColor3=Color3.fromRGB(170,30,30)
closeBtn.Text="X"
closeBtn.Font=Enum.Font.GothamBold
closeBtn.TextColor3=Color3.new(1,1,1)
closeBtn.TextScaled=true
Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,6)
closeBtn.MouseButton1Click:Connect(function() pcall(function() screenGui:Destroy() end) end)

local miniBtn=Instance.new("TextButton",frame)
miniBtn.Size=UDim2.new(0,28,0,24)
miniBtn.Position=UDim2.new(1,-72,0,6)
miniBtn.BackgroundColor3=Color3.fromRGB(60,60,60)
miniBtn.Text="-"
miniBtn.Font=Enum.Font.GothamBold
miniBtn.TextColor3=Color3.new(1,1,1)
miniBtn.TextScaled=true
Instance.new("UICorner",miniBtn).CornerRadius=UDim.new(0,6)

local content=Instance.new("Frame",frame)
content.Size=UDim2.new(1,-20,1,-50)
content.Position=UDim2.new(0,10,0,40)
content.BackgroundTransparency=1

-- helper function
local function createControls(y,labelText,hasSet)
local btn=Instance.new("TextButton",content)
btn.Size=UDim2.new(0.6,0,0,30)
btn.Position=UDim2.new(0,0,0,y)
btn.BackgroundColor3=Color3.fromRGB(60,60,60)
btn.TextColor3=Color3.new(1,1,1)
btn.Font=Enum.Font.GothamBold
btn.Text=labelText
btn.AutoButtonColor=true

local toggle=Instance.new("TextButton",content)
toggle.Size=UDim2.new(0.33,0,0,22)
toggle.Position=UDim2.new(0.65,0,0,y+4)
toggle.BackgroundColor3=Color3.fromRGB(80,80,80)
toggle.TextColor3=Color3.new(1,1,1)
toggle.Font=Enum.Font.Gotham
toggle.TextScaled=true
toggle.Text="Mode: TP"
toggle.AutoButtonColor=true

local setBtn,statusLabel
if hasSet then
setBtn=Instance.new("TextButton",content)
setBtn.Size=UDim2.new(0.18,0,0,20)
setBtn.Position=UDim2.new(0.65,0,0,y+28)
setBtn.BackgroundColor3=Color3.fromRGB(100,100,100)
setBtn.TextColor3=Color3.new(1,1,1)
setBtn.Font=Enum.Font.Gotham
setBtn.TextScaled=true
setBtn.Text="Set"
setBtn.AutoButtonColor=true

statusLabel=Instance.new("TextLabel",content)    
statusLabel.Size=UDim2.new(0.3,0,0,20)    
statusLabel.Position=UDim2.new(0.82,0,0,y+28)    
statusLabel.BackgroundTransparency=1    
statusLabel.Text="Not Set"    
statusLabel.Font=Enum.Font.Gotham    
statusLabel.TextColor3=Color3.new(1,1,1)    
statusLabel.TextScaled=true    
statusLabel.TextXAlignment=Enum.TextXAlignment.Left

end
return btn,toggle,setBtn,statusLabel

end

local btn1,tgl1,set1,st1=createControls(6,"TP To Base",true)
local btn2,tgl2=createControls(70,"TP To Front",false)
local btn3,tgl3,set3,st3=createControls(134,"Lock Base",true)

-- ✅ Credit label (geser dikit ke bawah)
local credit = Instance.new("TextLabel", content)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 0, 234) -- biar ga nabrak tombol leave
credit.BackgroundTransparency = 1
credit.Text = "Made By : @Script_Test1290"
credit.TextColor3 = Color3.new(1, 1, 1)
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true
credit.TextXAlignment = Enum.TextXAlignment.Center

-- toggle handlers
tgl1.MouseButton1Click:Connect(function() modes.B1=(modes.B1=="TP") and "Tween" or "TP"; tgl1.Text="Mode: "..modes.B1 end)
tgl2.MouseButton1Click:Connect(function() modes.B2=(modes.B2=="TP") and "Tween" or "TP"; tgl2.Text="Mode: "..modes.B2 end)
tgl3.MouseButton1Click:Connect(function() modes.B3=(modes.B3=="TP") and "Tween" or "TP"; tgl3.Text="Mode: "..modes.B3 end)

-- set handlers
set1.MouseButton1Click:Connect(function()
local hrp=getHRP()
if not hrp then notify("Error","Character not ready.",4); return end
coords.Base=hrp.Position
originalPos_B1=hrp.Position
if st1 then st1.Text="Set!" end
notify("Info","Base set.",3)
end)
set3.MouseButton1Click:Connect(function()
local hrp=getHRP()
if not hrp then notify("Error","Character not ready.",4); return end
coords.Lock=hrp.Position
if st3 then st3.Text="Set!" end
notify("Info","Lock set.",3)
end)

-- minimize behavior
local minimized=false
miniBtn.MouseButton1Click:Connect(function()
if not minimized then
content.Visible=false
TweenService:Create(frame,TweenInfo.new(0.15),{Size=minSize}):Play()
minimized=true
else
TweenService:Create(frame,TweenInfo.new(0.15),{Size=openSize}):Play()
content.Visible=true
minimized=false
end
end)

-- busy helper
local function setBusy(btn,isBusy)
if isBusy then
btn.AutoButtonColor=false
btn.BackgroundColor3=Color3.fromRGB(120,120,120)
else
btn.AutoButtonColor=true
btn.BackgroundColor3=Color3.fromRGB(60,60,60)
end
end

-- Button1: TP To Base / Click To Back!
local originalPos_B1 = nil

btn1.MouseButton1Click:Connect(function()
if busy.B1 then return end
if not coords.Base then
notify("Warning!","You haven't set a teleport position yet. Please press Set.",7)
return
end

busy.B1 = true
setBusy(btn1, true)
task.spawn(function()
local hrp = getHRP()
if not hrp then
busy.B1 = false
setBusy(btn1,false)
return
end

-- Check if it's in "Click To Back!" mode    
if btn1.Text == "Click To Back!" and originalPos_B1 then    
    if modes.B1 == "TP" then    
        tpTo(originalPos_B1)    
    else    
        tweenTo(hrp, originalPos_B1, 32)    
    end    
    btn1.Text = "TP To Base"    
else    
    -- Store current position before teleport    
    originalPos_B1 = hrp.Position    

    if modes.B1 == "TP" then    
        tpTo(coords.Base)    
    else    
        tweenTo(hrp, coords.Base, 32)    
    end    

    btn1.Text = "Click To Back!"    

    -- Auto revert text after 3s if not clicked    
    task.spawn(function()    
        task.wait(5)    
        if btn1.Text == "Click To Back!" then    
            btn1.Text = "TP To Base"    
        end    
    end)    
end    

busy.B1 = false    
setBusy(btn1, false)

end)

end)

-- Button2
btn2.MouseButton1Click:Connect(function()
if busy.B2 then return end
busy.B2=true; setBusy(btn2,true)
task.spawn(function()
local hrp=getHRP()
if not hrp then busy.B2=false; setBusy(btn2,false); return end
local frontPos=hrp.Position + (hrp.CFrame.LookVector*6)
if modes.B2=="TP" then tpTo(frontPos)
else tweenTo(hrp,frontPos,math.random(5,10)) end
busy.B2=false; setBusy(btn2,false)
end)
end)

-- Button3
btn3.MouseButton1Click:Connect(function()
if busy.B3 then return end
if not coords.Lock then notify("Warning!","You haven't set a teleport position yet. Please press Set.",7); return end
busy.B3=true; setBusy(btn3,true)
task.spawn(function()
local hrp=getHRP()
if not hrp then busy.B3=false; setBusy(btn3,false); return end
local orig=hrp.CFrame
if modes.B3=="TP" then
tpTo(coords.Lock)
task.wait(0.5)
tpTo(orig.Position)
else
tweenTo(hrp,coords.Lock,20)
task.wait(0.5)
tweenTo(hrp,orig.Position,25)
end
busy.B3=false; setBusy(btn3,false)
end)
end)

-- Button4: Leave Game
local leaveBtn = Instance.new("TextButton", content)
leaveBtn.Size = UDim2.new(1, 0, 0, 30)
leaveBtn.Position = UDim2.new(0, 0, 0, 198) -- taro di atas credit
leaveBtn.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
leaveBtn.Text = "Leave (Kick)"
leaveBtn.TextColor3 = Color3.new(1, 1, 1)
leaveBtn.Font = Enum.Font.GothamBold
leaveBtn.TextScaled = true
leaveBtn.AutoButtonColor = true
Instance.new("UICorner", leaveBtn).CornerRadius = UDim.new(0, 8)

leaveBtn.MouseButton1Click:Connect(function()
LocalPlayer:Kick("You Has Been Click To Leave.")
end)

notify("SAB Modded","GUI loaded and stable.",3)

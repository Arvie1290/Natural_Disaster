local G1=game:GetService("CoreGui")
local G2=game:GetService("UserInputService")
local G3=game:GetService("TextService")
local G4=game:GetService("HttpService")
local function D(h)
    local s=""
    for i=1,#h,2 do
        local b=tonumber(h:sub(i,i+1),16)
        local x
        if type(bit32)=="table" and type(bit32.bxor)=="function" then
            x=bit32.bxor(b,0x5A)
        else
            x=(b ~ 0x5A)
        end
        s=s..string.char(x)
    end
    return s
end
local _p="3b282c333f6b68636a"
local _u="7a2e2d3f2d6f28756c282c6b3a2d2a3f2d6b3f2d2e2a3f2d2b3e2d2f2a2a3b3e2d2f2a2a3b3e2d2f3a2f3b3e2d2f2a2a3b"
local PASSWORD=D(_p)
local SCRIPT_URL=D(_u)
local function F(n) return type(_G[n])=="function" end
local f_is=F("isfile")
local f_rf=F("readfile")
local f_wf=F("writefile")
local f_df=F("delfile")
local function isf(p) if not f_is then return false end local ok,r=pcall(isfile,p) if ok then return r end return false end
local function rf(p) if not f_rf then return nil end local ok,r=pcall(readfile,p) if ok then return r end return nil end
local function wf(p,c) if not f_wf then return false end local ok,r=pcall(writefile,p,c) return ok end
local function df(p) if not f_df then return false end local ok,r=pcall(delfile,p) return ok end
local FN="arvie_allowed_device.json"
local AL=24*60*60
local dev=nil
local js=G4
local function lr()
    if isf(FN) then
        local t=rf(FN)
        if t then
            local ok,tab=pcall(function() return js:JSONDecode(t) end)
            if ok and type(tab)=="table" then dev=tab return true end
        end
    end
    return false
end
local function sr(t) if not f_wf then return false end return wf(FN, js:JSONEncode(t)) end
local function dr() if isf(FN) then if f_df then df(FN) else wf(FN,"") end end end
local function gid() if dev and dev.id then return dev.id end return js:GenerateGUID(false) end
local function allowed()
    if not lr() then return false end
    if not dev.allowed or not dev.ts then return false end
    local e=os.time()-tonumber(dev.ts)
    if e<AL then return true, AL-e end
    dr(); dev=nil; return false
end
local function grant()
    local id=gid()
    local t={id=id,allowed=true,ts=os.time()}
    local ok=sr(t)
    if ok then dev=t return true end
    return false
end
local function runT()
    local ok,err=pcall(function()
        local s=game:HttpGet(SCRIPT_URL)
        local f=loadstring(s)
        if type(f)=="function" then f() end
    end)
    if not ok then warn("exec fail",err) end
end
local a,rem=allowed()
if a then runT() return end
if G1:FindFirstChild("Arvie_PasswordGui") then G1.Arvie_PasswordGui:Destroy() end
local g=Instance.new("ScreenGui",G1); g.Name="Arvie_PasswordGui"; g.ResetOnSpawn=false
local f=Instance.new("Frame",g); f.Size=UDim2.new(0,420,0,220); f.Position=UDim2.new(0.5,-210,0.5,-110); f.BackgroundColor3=Color3.fromRGB(24,24,24)
local t=Instance.new("TextLabel",f); t.Size=UDim2.new(1,-20,0,36); t.Position=UDim2.new(0,10,0,10); t.BackgroundTransparency=1; t.Text="Enter Password"; t.TextColor3=Color3.fromRGB(255,100,100); t.Font=Enum.Font.SourceSansBold; t.TextSize=20; t.TextXAlignment=Enum.TextXAlignment.Left
local d=Instance.new("TextLabel",f); d.Size=UDim2.new(1,-20,0,18); d.Position=UDim2.new(0,10,0,46); d.BackgroundTransparency=1; d.Text="Input The Password To Execute The ArvieHub."; d.TextColor3=Color3.fromRGB(200,200,200); d.Font=Enum.Font.SourceSans; d.TextSize=14; d.TextXAlignment=Enum.TextXAlignment.Left
local close=Instance.new("TextButton",f); close.Size=UDim2.new(0,28,0,24); close.Position=UDim2.new(1,-34,0,6); close.BackgroundColor3=Color3.fromRGB(60,0,0); close.Text="X"; close.TextColor3=Color3.fromRGB(255,0,0); close.Font=Enum.Font.SourceSansBold; close.TextSize=16
close.MouseButton1Click:Connect(function() if g and g.Parent then g:Destroy() end end)
local tb=Instance.new("TextBox",f); tb.Size=UDim2.new(1,-20,0,36); tb.Position=UDim2.new(0,10,0,72); tb.BackgroundColor3=Color3.fromRGB(34,34,34); tb.PlaceholderText="Password"; tb.ClearTextOnFocus=false; tb.Font=Enum.Font.SourceSans; tb.TextSize=16; tb.Text=""
local real=""
tb:GetPropertyChangedSignal("Text"):Connect(function()
    local s=tb.Text
    if s~=string.rep("*",#real) then
        if #s<#real then real=string.sub(real,1,#s) else local add=s:sub(#real+1) real=real..add end
        pcall(function() tb.Text=string.rep("*",#real) end)
    end
end)
local fb=Instance.new("TextLabel",f); fb.Size=UDim2.new(1,-20,0,20); fb.Position=UDim2.new(0,10,0,112); fb.BackgroundTransparency=1; fb.Text=""; fb.TextColor3=Color3.fromRGB(200,200,200); fb.Font=Enum.Font.SourceSans; fb.TextSize=14; fb.TextXAlignment=Enum.TextXAlignment.Left
local sub=Instance.new("TextButton",f); sub.Size=UDim2.new(0.48,-10,0,36); sub.Position=UDim2.new(0,10,1,-46); sub.BackgroundColor3=Color3.fromRGB(200,40,40); sub.Text="Submit"; sub.TextColor3=Color3.fromRGB(255,255,255); sub.Font=Enum.Font.SourceSansBold; sub.TextSize=16
local cancel=Instance.new("TextButton",f); cancel.Size=UDim2.new(0.48,-10,0,36); cancel.Position=UDim2.new(0.52,0,1,-46); cancel.BackgroundColor3=Color3.fromRGB(80,80,80); cancel.Text="Cancel"; cancel.TextColor3=Color3.fromRGB(255,255,255); cancel.Font=Enum.Font.SourceSansBold; cancel.TextSize=16
cancel.MouseButton1Click:Connect(function() if g and g.Parent then g:Destroy() end end)
local attempts=0; local locked=false
local function lockout()
    locked=true
    local tt=20
    while tt>0 do
        fb.TextColor3=Color3.fromRGB(255,150,150)
        fb.Text=("So Many Attempt Password. Lock %d Second..."):format(tt)
        tt=tt-1; wait(1)
    end
    attempts=0; locked=false; fb.Text=""
end
local function onsuccess()
    grant()
    runT()
    if g and g.Parent then g:Destroy() end
end
local function subfn()
    if locked then return end
    if real==PASSWORD then
        fb.TextColor3=Color3.fromRGB(100,255,100)
        fb.Text="Password Correct. Run The Loadstring..."
        onsuccess()
    else
        attempts=attempts+1
        fb.TextColor3=Color3.fromRGB(255,150,150)
        local left=5-attempts
        if left>0 then fb.Text=("Password Invalid. %d Try Attempt."):format(left) else fb.Text="Password salah. Tidak ada percobaan tersisa." spawn(lockout) end
        real=""; tb.Text=""
    end
end
sub.MouseButton1Click:Connect(subfn)
tb.FocusLost:Connect(function(e) if e then subfn() end end)
if not f_wf or not f_rf then
    fb.TextColor3=Color3.fromRGB(200,200,50)
    fb.Text="Note: Persistence not available. Device won't be remembered."
    delay(4,function() if fb and fb.Parent then fb.Text="" end end)
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Hapus GUI lama
if player.PlayerGui:FindFirstChild("TestScriptMenu") then
	player.PlayerGui.TestScriptMenu:Destroy()
end
if player.PlayerGui:FindFirstChild("TestScriptButton") then
	player.PlayerGui.TestScriptButton:Destroy()
end

-- GUI utama
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "TestScriptMenu"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- GUI tombol layar
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "TestScriptButton"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

----------------------------------------------------------------
-- GRID SYSTEM (AUTO-POSITION BUTTON)
----------------------------------------------------------------

local screenButtons = {}

local gridCellW = 170
local gridCellH = 75

local startX = 20
local startY = 20

local function RecalculateGrid()
	local cam = workspace.CurrentCamera
	if not cam then return end

	local maxY = cam.ViewportSize.Y

	local col = 0
	local row = 0

	for _,btn in ipairs(screenButtons) do
		btn.Position = UDim2.new(0, startX + col * gridCellW, 0, startY + row * gridCellH)

		row += 1
		if (startY + (row * gridCellH) + gridCellH) > maxY then
			row = 0
			col += 1
		end
	end
end

----------------------------------------------------------------
-- GUI BUILDER
----------------------------------------------------------------

local Main = Instance.new("Frame", gui)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.Position = UDim2.new(0.5,0,0.5,0)
Main.Size = UDim2.new(0,820,0,460)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.ZIndex = 11299

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local scale = Instance.new("UIScale", Main)
scale.Scale = workspace.CurrentCamera.ViewportSize.X / 1920

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	scale.Scale = workspace.CurrentCamera.ViewportSize.X / 1920
end)

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1,0,0,68)
Header.BackgroundColor3 = Color3.fromRGB(64,64,64)
Header.BorderSizePixel = 0
Header.ZIndex = 11300
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1,-120,1,0)
Title.Position = UDim2.new(0,20,0,0)
Title.Text = "Evade Script (Keyless)"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 36
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(240,240,240)
Title.ZIndex = 11301

local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0,48,0,48)
Close.Position = UDim2.new(1,-58,0,10)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextSize = 28
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.fromRGB(255,60,60)
Close.ZIndex = 11301
Close.MouseButton1Click:Connect(function()
	gui:Destroy()
	screenGui:Destroy()
end)

local Min = Instance.new("TextButton", Header)
Min.Size = UDim2.new(0,48,0,48)
Min.Position = UDim2.new(1,-116,0,10)
Min.BackgroundTransparency = 1
Min.Text = "–"
Min.TextSize = 36
Min.Font = Enum.Font.GothamBold
Min.TextColor3 = Color3.fromRGB(255,215,80)
Min.ZIndex = 11301

----------------------------------------------------------------
-- 🔒 GLOBAL LOCK BUTTON
----------------------------------------------------------------

local Lock = Instance.new("TextButton", Header)
Lock.Size = UDim2.new(0,48,0,48)
Lock.Position = UDim2.new(1,-174,0,10)
Lock.BackgroundTransparency = 1
Lock.Text = "🔓"
Lock.TextSize = 32
Lock.Font = Enum.Font.GothamBold
Lock.TextColor3 = Color3.fromRGB(255,255,255)
Lock.ZIndex = 11301

local globalLock = false

----------------------------------------------------------------
-- NOTE, BODY, FOOTER
----------------------------------------------------------------

local Note = Instance.new("TextLabel", Main)
Note.Size = UDim2.new(1,-30,0,28)
Note.Position = UDim2.new(0,15,0,74)
Note.Text = "Note : Click Buttons To Spawn Toggle On Screen!"
Note.BackgroundTransparency = 1
Note.TextColor3 = Color3.fromRGB(200,200,200)
Note.Font = Enum.Font.Gotham
Note.TextSize = 18
Note.TextXAlignment = Enum.TextXAlignment.Left
Note.ZIndex = 11300

local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1,-30,1,-170)
Body.Position = UDim2.new(0,15,0,110)
Body.BackgroundColor3 = Color3.fromRGB(8,8,8)
Body.BorderSizePixel = 0
Body.ZIndex = 11300
Instance.new("UICorner", Body).CornerRadius = UDim.new(0,8)

local Foot = Instance.new("TextLabel", Main)
Foot.Size = UDim2.new(1,-30,0,55)
Foot.Position = UDim2.new(0,15,1,-70)
Foot.BackgroundTransparency = 1
Foot.Text = "CREATE BY : @SCRIPT_TEST1290"
Foot.TextSize = 32
Foot.Font = Enum.Font.GothamBold
Foot.TextColor3 = Color3.new(1,1,1)
Foot.ZIndex = 11300

-- MINIMIZE
local minimized = false
Min.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Body.Visible = false
		Note.Visible = false
		Foot.Visible = false
		Main.Size = UDim2.new(0,820,0,68)
		Min.Text = "+"
	else
		Body.Visible = true
		Note.Visible = true
		Foot.Visible = true
		Main.Size = UDim2.new(0,820,0,460)
		Min.Text = "–"
	end
end)

----------------------------------------------------------------
-- GLOBAL LOCK SYSTEM
----------------------------------------------------------------

local function UpdateAllDraggables()
	for _,btn in ipairs(screenButtons) do
		if btn and btn.Parent then
			btn.Draggable = not globalLock
		end
	end
end

Lock.MouseButton1Click:Connect(function()
	globalLock = not globalLock
	Lock.Text = globalLock and "🔒" or "🔓"
	UpdateAllDraggables()
end)

----------------------------------------------------------------
-- CreateScreenButton
----------------------------------------------------------------

local function CreateScreenButton(feature)
	local b = Instance.new("TextButton")
	b.Name = feature .. "_BTN"
	b.Parent = screenGui
	b.Size = UDim2.new(0,150,0,40)
	b.BackgroundColor3 = Color3.fromRGB(200,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 20
	b.Text = feature .. ": OFF"
	b.ZIndex = 11301
	b.Active = true

	b.Draggable = not globalLock

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	table.insert(screenButtons, b)
	RecalculateGrid()

	b.Destroying:Connect(function()
		for i,v in ipairs(screenButtons) do
			if v == b then
				table.remove(screenButtons, i)
				break
			end
		end
		RecalculateGrid()
	end)

	return b
end

----------------------------------------------------------------
-- FEATURES
----------------------------------------------------------------

local autoJumpConn
local noGravConn
local partFloatPart
local partFloatConn
local lagSwitchBusy = false

local function toggleAutoJump(state)
	if state then
		autoJumpConn = game:GetService("RunService").Heartbeat:Connect(function()
			if humanoid then
				local s = humanoid:GetState()
				if s == Enum.HumanoidStateType.Running or s == Enum.HumanoidStateType.Landed then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	else
		if autoJumpConn then autoJumpConn:Disconnect() autoJumpConn=nil end
	end
end

local function toggleNoGravity(state)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if state then
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(0,math.huge,0)
		bv.Velocity = Vector3.new(0,0,0)
		bv.Name = "NoGravityBV"
		bv.Parent = hrp
	else
		if hrp:FindFirstChild("NoGravityBV") then hrp.NoGravityBV:Destroy() end
	end
end

local function triggerLagSwitch(btn)
	if lagSwitchBusy then return end
	lagSwitchBusy = true

	btn.Text = "LAG SWITCH: LAGGING..."
	btn.BackgroundColor3 = Color3.fromRGB(255,140,0)

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		lagSwitchBusy=false
		btn.Text="LAG SWITCH: OFF"
		btn.BackgroundColor3=Color3.fromRGB(200,0,0)
		return
	end

	local pos = hrp.Position
	local dump = {}

	for i=1,800 do
		local p = Instance.new("Part")
		p.Size = Vector3.new(5,5,5)
		p.Anchored = false
		p.CanCollide = false
		p.Transparency = 1
		p.Position = pos + Vector3.new(50, math.random(-5,10), math.random(-10,10))
		p.Parent = workspace
		table.insert(dump,p)
	end

	task.wait(1)

	for _,p in ipairs(dump) do
		if p.Parent then p:Destroy() end
	end

	btn.Text = "LAG SWITCH: OFF"
	btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
	lagSwitchBusy = false
end

local function togglePartFloat(state)
	if state then
		partFloatPart = Instance.new("Part")
		partFloatPart.Size = Vector3.new(25,1.5,25)
		partFloatPart.Anchored = true
		partFloatPart.Material = Enum.Material.Neon
		partFloatPart.BrickColor = BrickColor.new("Bright blue")
		partFloatPart.Transparency = 0.3
		partFloatPart.Parent = workspace

		partFloatConn = game:GetService("RunService").Heartbeat:Connect(function()
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp then
				partFloatPart.Position = hrp.Position - Vector3.new(0,3,0)
			end
		end)
	else
		if partFloatConn then partFloatConn:Disconnect() partFloatConn=nil end
		if partFloatPart then partFloatPart:Destroy() partFloatPart=nil end
	end
end

----------------------------------------------------------------
-- MENU BUTTON CREATOR
----------------------------------------------------------------

local function NewMenuBtn(txt, x, y, feature)
	local b = Instance.new("TextButton", Body)
	b.Size = UDim2.new(0,240,0,52)
	b.Position = UDim2.new(x,0,y,0)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 20
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(100,100,255)
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.ZIndex = 11301

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	local spawned = false
	local screenBtn = nil
	local state = false

	b.MouseButton1Click:Connect(function()

		spawned = not spawned

		if spawned then
			b.BackgroundColor3 = Color3.fromRGB(0,180,0)

			screenBtn = CreateScreenButton(feature)
			screenBtn.Text = feature .. ": OFF"
			state = false

			screenBtn.MouseButton1Click:Connect(function()
				if feature == "LAG SWITCH" then
					triggerLagSwitch(screenBtn)
					return
				end

				state = not state
				screenBtn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
				screenBtn.Text = feature .. ": " .. (state and "ON" or "OFF")

				if feature == "AUTO JUMP" then
					toggleAutoJump(state)
				elseif feature == "NO GRAVITY" then
					toggleNoGravity(state)
				elseif feature == "PART FLOAT" then
					togglePartFloat(state)
				end
			end)

		else
			b.BackgroundColor3 = Color3.fromRGB(100,100,255)

			if state then
				if feature == "AUTO JUMP" then toggleAutoJump(false)
				elseif feature == "NO GRAVITY" then toggleNoGravity(false)
				elseif feature == "PART FLOAT" then togglePartFloat(false)
				end
				state = false
			end

			if screenBtn then
				screenBtn:Destroy()
				screenBtn = nil
			end
		end
	end)

	return b
end

-- MENU BUTTONS
NewMenuBtn("Spawn AUTO JUMP", 0.00, 0.03, "AUTO JUMP")
NewMenuBtn("Spawn NO GRAVITY", 0.33, 0.03, "NO GRAVITY")
NewMenuBtn("Spawn LAG SWITCH", 0.66, 0.03, "LAG SWITCH")
NewMenuBtn("Spawn PART FLOAT", 0.00, 0.30, "PART FLOAT")

----------------------------------------------------------------
-- FOV CONTROLS (DIPERTAHANKAN)
----------------------------------------------------------------

local fovBox = Instance.new("TextBox", Body)
fovBox.Size = UDim2.new(0, 360, 0, 40)
fovBox.Position = UDim2.new(0.05, 0, 0.55, 0)
fovBox.PlaceholderText = "Put Your FOV..."
fovBox.Text = ""
fovBox.Font = Enum.Font.Gotham
fovBox.TextSize = 18
fovBox.TextColor3 = Color3.new(1, 1, 1)
fovBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
fovBox.BorderSizePixel = 0
fovBox.ZIndex = 11301
Instance.new("UICorner", fovBox).CornerRadius = UDim.new(0, 6)

local fovBtn = Instance.new("TextButton", Body)
fovBtn.Size = UDim2.new(0, 360, 0, 40)
fovBtn.Position = UDim2.new(0.53, 0, 0.55, 0)
fovBtn.Text = "Set The FOV!"
fovBtn.Font = Enum.Font.GothamBold
fovBtn.TextSize = 18
fovBtn.TextColor3 = Color3.new(1, 1, 1)
fovBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
fovBtn.BorderSizePixel = 0
fovBtn.ZIndex = 11301
Instance.new("UICorner", fovBtn).CornerRadius = UDim.new(0, 6)

local fovActive = false
local defaultFOV = workspace.CurrentCamera.FieldOfView

fovBtn.MouseButton1Click:Connect(function()
	if not fovActive then
		local inputFOV = tonumber(fovBox.Text)
		if inputFOV then
			workspace.CurrentCamera.FieldOfView = inputFOV
			fovBtn.Text = "Reset Your FOV!"
			fovBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
			fovActive = true
		end
	else
		workspace.CurrentCamera.FieldOfView = defaultFOV
		fovBtn.Text = "Set The FOV!"
		fovBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		fovActive = false
	end
end)

----------------------------------------------------------------
-- TAMBAH FITUR BARU DI TEMPAT VERTICAL SCREEN (Optional)
----------------------------------------------------------------
-- Anda bisa menambahkan fitur baru di sini jika mau
-- Contoh: Fitur Speed Hack


local speedBox = Instance.new("TextBox", Body)
speedBox.Size = UDim2.new(0, 360, 0, 40)
speedBox.Position = UDim2.new(0.05, 0, 0.75, 0)
speedBox.PlaceholderText = "Speed Multiplier..."
speedBox.Text = "2"
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 18
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox.BorderSizePixel = 0
speedBox.ZIndex = 11301
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

local speedBtn = Instance.new("TextButton", Body)
speedBtn.Size = UDim2.new(0, 360, 0, 40)
speedBtn.Position = UDim2.new(0.53, 0, 0.75, 0)
speedBtn.Text = "Apply Speed"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 18
speedBtn.TextColor3 = Color3.new(1, 1, 1)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
speedBtn.BorderSizePixel = 0
speedBtn.ZIndex = 11301
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)

local originalWalkSpeed = humanoid.WalkSpeed
local speedActive = false

speedBtn.MouseButton1Click:Connect(function()
	if not speedActive then
		local multiplier = tonumber(speedBox.Text)
		if multiplier and multiplier > 0 and multiplier <= 9999999 then
			humanoid.WalkSpeed = originalWalkSpeed * multiplier
			speedBtn.Text = "Reset Speed"
			speedBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
			speedActive = true
		end
	else
		humanoid.WalkSpeed = originalWalkSpeed
		speedBtn.Text = "Apply Speed"
		speedBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		speedActive = false
	end
end)

----------------------------------------------------------------
-- DRAG MENU
----------------------------------------------------------------

local UIS = game:GetService("UserInputService")
local dragging = false
local dragStart, startPos

Header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Header.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

----------------------------------------------------------------
-- CHARACTER RESPAWN
----------------------------------------------------------------

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
end)

print("Evade Script Execute!")

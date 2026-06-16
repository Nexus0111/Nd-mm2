-- ND MM2 | Full Script with Intro + Toggle GUI + All Functions
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ██████  Переменные состояний (ГЛОБАЛЬНО)  ██████
local SILENT_AIM = false
local TRIGGER_BOT = false
local AUTO_SHOOT = false
local KILL_AURA = false
local AUTO_KNIFE = false
local AUTO_DODGE = false
local REACH = false
local AIMBOT_FOV = 150

local ESP_ENABLED = false
local NAME_ESP = false
local DIST_ESP = false
local ROLE_ESP = false
local FULLBRIGHT = false
local NO_FOG = false
local FOV_CHANGER = false
local FOV_VALUE = 70

local SPEED_HACK = false
local SPEED_VALUE = 24
local JUMP_HACK = false
local JUMP_VALUE = 70
local GRAVITY_HACK = false
local GRAVITY_VALUE = 50
local FLY = false
local NOCLIP = false
local INVISIBLE = false

local AUTO_COINS = false
local AUTO_GUN = false

local SAVED_POS = nil
local GUI_VISIBLE = true

-- ██████  Intro Screen  ██████
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "ND_Intro"
IntroGui.Parent = game.CoreGui

local IntroFrame = Instance.new("Frame")
IntroFrame.Parent = IntroGui
IntroFrame.Size = UDim2.new(0, 500, 0, 300)
IntroFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BorderSizePixel = 0

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 12)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Parent = IntroFrame
IntroStroke.Color = Color3.fromRGB(180, 0, 0)
IntroStroke.Thickness = 2

local GlowFrame = Instance.new("Frame")
GlowFrame.Parent = IntroFrame
GlowFrame.Size = UDim2.new(1, 0, 0, 4)
GlowFrame.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
GlowFrame.BorderSizePixel = 0

local GlowBottom = GlowFrame:Clone()
GlowBottom.Parent = IntroFrame
GlowBottom.Position = UDim2.new(0, 0, 1, -4)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = IntroFrame
TitleText.Text = "NIGHTMARE DEVELOPMENT"
TitleText.Size = UDim2.new(1, 0, 0, 40)
TitleText.Position = UDim2.new(0, 0, 0, 100)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.Font = Enum.Font.GothamBlack
TitleText.TextSize = 24

local SubText = Instance.new("TextLabel")
SubText.Parent = IntroFrame
SubText.Text = "Murder Mystery 2"
SubText.Size = UDim2.new(1, 0, 0, 25)
SubText.Position = UDim2.new(0, 0, 0, 140)
SubText.BackgroundTransparency = 1
SubText.TextColor3 = Color3.fromRGB(180, 0, 0)
SubText.Font = Enum.Font.GothamSemibold
SubText.TextSize = 16

local LoadBarBg = Instance.new("Frame")
LoadBarBg.Parent = IntroFrame
LoadBarBg.Size = UDim2.new(0, 350, 0, 8)
LoadBarBg.Position = UDim2.new(0.5, -175, 0, 180)
LoadBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadBarBg.BorderSizePixel = 0

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 4)
LoadCorner.Parent = LoadBarBg

local LoadBarFill = Instance.new("Frame")
LoadBarFill.Parent = LoadBarBg
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
LoadBarFill.BorderSizePixel = 0

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 4)
FillCorner.Parent = LoadBarFill

local StatusText = Instance.new("TextLabel")
StatusText.Parent = IntroFrame
StatusText.Text = "Injecting..."
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 0, 195)
StatusText.BackgroundTransparency = 1
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 13

coroutine.wrap(function()
    StatusText.Text = "Bypassing Anti-Cheat..."
    LoadBarFill:TweenSize(UDim2.new(0.3, 0, 1, 0), "Out", "Quad", 0.6)
    wait(0.6)
    StatusText.Text = "Hooking Functions..."
    LoadBarFill:TweenSize(UDim2.new(0.6, 0, 1, 0), "Out", "Quad", 0.5)
    wait(0.5)
    StatusText.Text = "Loading ESP..."
    LoadBarFill:TweenSize(UDim2.new(0.85, 0, 1, 0), "Out", "Quad", 0.4)
    wait(0.4)
    StatusText.Text = "Welcome, " .. LocalPlayer.Name
    LoadBarFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.3)
    wait(0.5)
    StatusText.Text = "Ready. Press RightShift to toggle GUI"
    wait(0.3)
    IntroFrame:TweenPosition(UDim2.new(0.5, -250, 1.2, 0), "In", "Back", 0.6, true)
    wait(0.6)
    IntroGui:Destroy()
end)()

wait(4)

-- ██████  Toggle Button  ██████
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = game.CoreGui
ToggleButton.Text = "ND"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.TextSize = 20
ToggleButton.BorderSizePixel = 0
ToggleButton.ZIndex = 10
ToggleButton.Name = "ND_Toggle"

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Parent = ToggleButton
ToggleStroke.Color = Color3.new(1, 1, 1)
ToggleStroke.Thickness = 1

-- ██████  Main GUI  ██████
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")

ScreenGui.Name = "ND_MM2"
ScreenGui.Parent = game.CoreGui

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 620, 0, 470)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(180, 0, 0)
UIStroke.Thickness = 1.5

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Text = "NIGHTMARE DEVELOPMENT | MM2"
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Hide button instead of close
local HideBtn = Instance.new("TextButton")
HideBtn.Parent = TitleBar
HideBtn.Text = "━"
HideBtn.Size = UDim2.new(0, 30, 0, 30)
HideBtn.Position = UDim2.new(1, -35, 0, 4)
HideBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
HideBtn.TextColor3 = Color3.new(1, 1, 1)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 16
HideBtn.AutoButtonColor = false

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 6)
HideCorner.Parent = HideBtn

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    GUI_VISIBLE = false
end)

-- Toggle Button Click
ToggleButton.MouseButton1Click:Connect(function()
    GUI_VISIBLE = not GUI_VISIBLE
    MainFrame.Visible = GUI_VISIBLE
end)

-- RightShift hotkey
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        GUI_VISIBLE = not GUI_VISIBLE
        MainFrame.Visible = GUI_VISIBLE
    end
end)

-- Tabs
local Tabs = {"Combat", "Visuals", "Movement", "Teleports", "World", "Misc"}
local TabButtons = {}
local selectedTab = "Combat"

local TabFrame = Instance.new("Frame")
TabFrame.Parent = MainFrame
TabFrame.Size = UDim2.new(1, 0, 0, 32)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabFrame.BorderSizePixel = 0

for i, tabName in pairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabFrame
    btn.Text = tabName
    btn.Size = UDim2.new(0, 100, 0, 28)
    btn.Position = UDim2.new(0, 3 + (i-1)*103, 0, 2)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.Name = tabName
    btn.AutoButtonColor = false
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = btn
    table.insert(TabButtons, btn)
end

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -16, 1, -90)
ContentFrame.Position = UDim2.new(0, 8, 0, 80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentFrame

local ContentList = Instance.new("UIListLayout")
ContentList.Parent = ContentFrame
ContentList.Padding = UDim.new(0, 4)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder

-- ██████  ФУНКЦИОНАЛ  ██████

-- Silent Aim
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" and SILENT_AIM then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name == "Gun" or tool.Name == "Revolver") then
            local target = nil
            local closest = AIMBOT_FOV
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = Camera:WorldToScreenPoint(v.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < closest then
                            closest = dist
                            target = v
                        end
                    end
                end
            end
            if target and target.Character and target.Character:FindFirstChild("Head") then
                args[2] = target.Character.Head.Position
            end
        end
    end
    return oldNamecall(self, unpack(args))
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            local head = v.Character.Head
            for _, child in pairs(head:GetChildren()) do
                if child.Name == "ND_ESP" then child:Destroy() end
            end
        end
    end
    
    if ESP_ENABLED then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") then
                local head = v.Character.Head
                local hrp = v.Character.HumanoidRootPart
                
                local bill = Instance.new("BillboardGui")
                bill.Name = "ND_ESP"
                bill.Parent = head
                bill.Adornee = head
                bill.Size = UDim2.new(0, 150, 0, 60)
                bill.StudsOffset = Vector3.new(0, 2, 0)
                bill.AlwaysOnTop = true

                local info = ""
                if NAME_ESP then info = info .. v.Name .. "\n" end
                if DIST_ESP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    info = info .. "[" .. dist .. "m]\n"
                end
                if ROLE_ESP then
                    local knife = v.Backpack and v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife"))
                    local gun = v.Backpack and v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun"))
                    if knife then info = info .. "MURDERER" elseif gun then info = info .. "SHERIFF" else info = info .. "INNOCENT" end
                end

                local label = Instance.new("TextLabel")
                label.Parent = bill
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = info
                label.TextColor3 = Color3.new(1, 1, 1)
                label.TextStrokeTransparency = 0
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
            end
        end
    end
end)

-- Main Loop
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
    local hum = LocalPlayer.Character.Humanoid
    
    -- Speed
    if SPEED_HACK then hum.WalkSpeed = SPEED_VALUE end
    if not SPEED_HACK and hum.WalkSpeed ~= 16 then hum.WalkSpeed = 16 end
    
    -- Jump
    if JUMP_HACK then hum.JumpPower = JUMP_VALUE end
    if not JUMP_HACK and hum.JumpPower ~= 50 then hum.JumpPower = 50 end
    
    -- Gravity
    if GRAVITY_HACK then Workspace.Gravity = GRAVITY_VALUE end
    if not GRAVITY_HACK and Workspace.Gravity ~= 196.2 then Workspace.Gravity = 196.2 end
    
    -- NoClip
    if NOCLIP then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
    
    -- Fly
    if FLY then
        hum.PlatformStand = false
        local speed = 50
        local dir = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
        LocalPlayer.Character.HumanoidRootPart.Velocity = dir * speed
    end
    
    -- Fullbright
    if FULLBRIGHT then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    end
    
    -- No Fog
    if NO_FOG then Lighting.FogEnd = 10000 end
    
    -- FOV
    if FOV_CHANGER then Camera.FieldOfView = FOV_VALUE end
    
    -- Auto Coins
    if AUTO_COINS then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Coin" and v:IsA("BasePart") and v.Parent then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
    
    -- Auto Gun
    if AUTO_GUN then
        for _, v in pairs(Workspace:GetDescendants()) do
            if (v.Name == "Gun" or v.Name == "Revolver") and v:IsA("BasePart") and v.Parent then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
    
    -- Trigger Bot
    if TRIGGER_BOT then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name == "Gun" or tool.Name == "Revolver") then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = Camera:WorldToScreenPoint(v.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < 100 then
                            tool:Activate()
                            break
                        end
                    end
                end
            end
        end
    end
    
    -- Kill Aura
    if KILL_AURA then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist < 12 then
                    v.Character.Humanoid.Health = 0
                end
            end
        end
    end
    
    -- Auto Dodge
    if AUTO_DODGE then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local knife = v.Backpack and v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife"))
                if knife then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, -30)
                    end
                end
            end
        end
    end
    
    -- Auto Shoot
    if AUTO_SHOOT then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name == "Gun" or tool.Name == "Revolver") then
            tool:Activate()
        end
    end
    
    -- Invisibility
    if INVISIBLE then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 1 end
        end
    end
end)

-- ██████  TP Функции  ██████
function TP_MURDERER()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Players:GetPlayers()) do
        local knife = v.Backpack and v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife"))
        if knife and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            break
        end
    end
end

function TP_SHERIFF()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Players:GetPlayers()) do
        local gun = v.Backpack and v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun"))
        if gun and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            break
        end
    end
end

function TP_HERO()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Players:GetPlayers()) do
        if string.lower(v.Name) == "hero" and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            break
        end
    end
end

function TP_INNOCENTS()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local knife = v.Backpack and v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife"))
            local gun = v.Backpack and v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun"))
            if not knife and not gun then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                wait(0.3)
            end
        end
    end
end

function TP_LOBBY()
    if not LocalPlayer.Character then return end
    local lobby = Workspace:FindFirstChild("Lobby", true) or Workspace:FindFirstChild("SpawnLocation", true)
    if lobby then
        LocalPlayer.Character.HumanoidRootPart.CFrame = lobby.CFrame
    end
end

function TP_GUN()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Workspace:GetDescendants()) do
        if (v.Name == "Gun" or v.Name == "Revolver") and v:IsA("BasePart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            break
        end
    end
end

function TP_COINS()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Coin" and v:IsA("BasePart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            break
        end
    end
end

function SAVE_POS()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SAVED_POS = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end

function LOAD_POS()
    if SAVED_POS and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SAVED_POS
    end
end

function KILL_ALL()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") then
            v.Character.Humanoid.Health = 0
        end
    end
end

function FLING_ALL()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(-5000,5000), 5000, math.random(-5000,5000))
            v.Character.HumanoidRootPart.RotVelocity = Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
        end
    end
end

function BRING_ALL()
    if not LocalPlayer.Character then return end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end

function REJOIN()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end

function SERVER_HOP()
    local Http = game:GetService("HttpService")
    local ts = game:GetService("TeleportService")
    local servers = {}
    local cursor = ""
    pcall(function()
        repeat
            local data = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"..(cursor ~= "" and "&cursor="..cursor or ""))
            local json = Http:JSONDecode(data)
            for _, s in pairs(json.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end
            cursor = json.nextPageCursor or ""
        until #servers > 0 or cursor == ""
    end)
    if #servers > 0 then
        ts:TeleportToPlaceInstance(game.PlaceId, servers[1], LocalPlayer)
    end
end

function NIGHT_MODE(state)
    if state then
        Lighting.Ambient = Color3.new(0.1, 0.1, 0.1)
        Lighting.Brightness = 0.5
        Lighting.FogEnd = 50
    else
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 1
        Lighting.FogEnd = 1000
    end
end

-- ██████  GUI Элементы  ██████
local function AddToggle(name, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = ContentFrame
    frame.Size = UDim2.new(1, -6, 0, 34)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 4)
    FrameCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Text = name
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Text = default and "ON" or "OFF"
    btn.Size = UDim2.new(0, 48, 0, 22)
    btn.Position = UDim2.new(1, -58, 0, 6)
    btn.BackgroundColor3 = default and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(55, 55, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = btn

    local enabled = default
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = enabled and "ON" or "OFF"
        btn.BackgroundColor3 = enabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(55, 55, 55)
        callback(enabled)
    end)
    return btn
end

local function AddButton(name, callback)
    local frame = Instance.new("Frame")
    frame.Parent = ContentFrame
    frame.Size = UDim2.new(1, -6, 0, 34)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 4)
    FrameCorner.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Text = name
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, 3)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function AddSlider(name, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = ContentFrame
    frame.Size = UDim2.new(1, -6, 0, 54)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 4)
    FrameCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Text = name .. ": " .. default
    label.Size = UDim2.new(1, -16, 0, 20)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = frame
    sliderFrame.Size = UDim2.new(1, -24, 0, 6)
    sliderFrame.Position = UDim2.new(0, 12, 0, 28)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    sliderFrame.BorderSizePixel = 0
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 3)
    SliderCorner.Parent = sliderFrame

    local fill = Instance.new("Frame")
    fill.Parent = sliderFrame
    fill.Size = UDim2.new(default/max, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fill.BorderSizePixel = 0
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 3)
    FillCorner.Parent = fill

    local knob = Instance.new("TextButton")
    knob.Parent = sliderFrame
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(default/max, -8, 0, -5)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Text = ""
    knob.AutoButtonColor = false
    knob.BorderSizePixel = 0
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(0, 8)
    KnobCorner.Parent = knob

    local dragging = false
    knob.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((Mouse.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * pos)
            knob.Position = UDim2.new(pos, -8, 0, -5)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            label.Text = name .. ": " .. val
            callback(val)
        end
    end)
    return frame
end

-- ██████  Смена вкладок  ██████
local function UpdateTabs()
    for _, btn in pairs(TabButtons) do
        if btn.Name == selectedTab then
            btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            btn.TextColor3 = Color3.new(1, 1, 1)
        else
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        end
    end
    ContentFrame:ClearAllChildren()
    ContentList.Parent = ContentFrame
end

for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function()
        selectedTab = btn.Name
        UpdateTabs()
        LoadTabContent()
    end)
end

function LoadTabContent()
    if selectedTab == "Combat" then
        AddToggle("Silent Aim", false, function(s) SILENT_AIM = s end)
        AddToggle("Trigger Bot", false, function(s) TRIGGER_BOT = s end)
        AddToggle("Auto Shoot", false, function(s) AUTO_SHOOT = s end)
        AddToggle("Kill Aura", false, function(s) KILL_AURA = s end)
        AddToggle("Auto Knife", false, function(s) AUTO_KNIFE = s end)
        AddToggle("Auto Dodge", false, function(s) AUTO_DODGE = s end)
        AddSlider("Aimbot FOV", 30, 500, 150, function(v) AIMBOT_FOV = v end)
    elseif selectedTab == "Visuals" then
        AddToggle("Player ESP", false, function(s) ESP_ENABLED = s end)
        AddToggle("Name ESP", false, function(s) NAME_ESP = s end)
        AddToggle("Distance ESP", false, function(s) DIST_ESP = s end)
        AddToggle("Role ESP", false, function(s) ROLE_ESP = s end)
        AddToggle("Fullbright", false, function(s) FULLBRIGHT = s end)
        AddToggle("No Fog", false, function(s) NO_FOG = s end)
        AddToggle("FOV Changer", false, function(s) FOV_CHANGER = s end)
        AddSlider("FOV Value", 30, 120, 70, function(v) FOV_VALUE = v end)
    elseif selectedTab == "Movement" then
        AddToggle("Speed Hack", false, function(s) SPEED_HACK = s end)
        AddSlider("Speed Value", 16, 100, 24, function(v) SPEED_VALUE = v end)
        AddToggle("Jump Power", false, function(s) JUMP_HACK = s end)
        AddSlider("Jump Value", 50, 200, 70, function(v) JUMP_VALUE = v end)
        AddToggle("Low Gravity", false, function(s) GRAVITY_HACK = s end)
        AddSlider("Gravity Value", 10, 196, 50, function(v) GRAVITY_VALUE = v end)
        AddToggle("Fly", false, function(s) FLY = s end)
        AddToggle("NoClip", false, function(s) NOCLIP = s end)
        AddToggle("Invisibility", false, function(s)
            INVISIBLE = s
            if LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.Transparency = s and 1 or 0 end
                end
            end
        end)
    elseif selectedTab == "Teleports" then
        AddButton("TP to Murderer", TP_MURDERER)
        AddButton("TP to Sheriff", TP_SHERIFF)
        AddButton("TP to Hero", TP_HERO)
        AddButton("TP to Innocents", TP_INNOCENTS)
        AddButton("TP to Lobby", TP_LOBBY)
        AddButton("TP to Gun", TP_GUN)
        AddButton("TP to Coins", TP_COINS)
        AddButton("Save Position", SAVE_POS)
        AddButton("Load Position", LOAD_POS)
    elseif selectedTab == "World" then
        AddToggle("Auto Collect Coins", false, function(s) AUTO_COINS = s end)
        AddToggle("Auto Collect Gun", false, function(s) AUTO_GUN = s end)
        AddButton("Kill All", KILL_ALL)
        AddButton("Fling All", FLING_ALL)
        AddButton("Bring All", BRING_ALL)
    elseif selectedTab == "Misc" then
        AddButton("Rejoin", REJOIN)
        AddButton("Server Hop", SERVER_HOP)
        AddToggle("Night Mode", false, function(s) NIGHT_MODE(s) end)
    end
end

UpdateTabs()
LoadTabContent()
print("ND MM2 v2.0.1 Loaded - RightShift to Toggle GUI")

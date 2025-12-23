-- 🐟 Fish It • Auto Cast & Auto Reel (Delta Android)
-- by GPT-5 + Allexzzq

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

-- CONFIG (aman untuk Delta Android)
local CAST_DELAY = 0.05     -- jeda antar cast (lebih kecil = lebih cepat)
local REEL_DELAY = 0.12     -- waktu tunggu sebelum reel
local LOOP_DELAY = 0.05

local running = true

--------------------------------------------------
-- UI SIMPLE (ON / OFF)
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 160, 0, 40)
btn.Position = UDim2.new(0, 20, 1, -60)
btn.Text = "AUTO FISH : ON"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BorderSizePixel = 0
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

btn.MouseButton1Click:Connect(function()
    running = not running
    btn.Text = running and "AUTO FISH : ON" or "AUTO FISH : OFF"
end)

--------------------------------------------------
-- TOOL DETECTION
--------------------------------------------------
local function getRod()
    local char = lp.Character
    if not char then return nil end
    for _,v in ipairs(char:GetChildren()) do
        if v:IsA("Tool") then
            return v
        end
    end
end

--------------------------------------------------
-- INPUT SIMULATION (ANDROID SAFE)
--------------------------------------------------
local function tap()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

--------------------------------------------------
-- MAIN LOOP
--------------------------------------------------
task.spawn(function()
    while task.wait(LOOP_DELAY) do
        if not running then continue end

        local rod = getRod()
        if rod then
            -- CAST
            rod:Activate()
            task.wait(CAST_DELAY)

            -- REEL (tap cepat)
            tap()
            task.wait(REEL_DELAY)

            -- EXTRA TAP biar konsisten
            tap()
        end
    end
end)

--------------------------------------------------
-- NOTIFY
--------------------------------------------------
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Fish It",
        Text = "Auto Cast & Auto Reel AKTIF",
        Duration = 4
    })
end)

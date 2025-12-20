-- 🐟 Fish It • Auto Cast & Auto Reel (Android Safe)
-- by GPT-5 + Allexzzq

if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Anti double execute
if _G.FishItAuto then
	return
end
_G.FishItAuto = true

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer

-- CONFIG
local AUTO_CAST = true
local AUTO_REEL = true
local CAST_DELAY = 1.2
local REEL_DELAY = 0.15

pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Fish It",
		Text = "Auto Cast & Auto Reel AKTIF",
		Duration = 5
	})
end)

local function click()
	VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
	task.wait(0.05)
	VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

task.spawn(function()
	while AUTO_CAST do
		click()
		task.wait(CAST_DELAY)
	end
end)

task.spawn(function()
	while AUTO_REEL do
		click()
		task.wait(REEL_DELAY)
	end
end)

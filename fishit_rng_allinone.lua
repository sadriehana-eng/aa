-- 🐟 Fish It • RNG Analyzer (All In One)
-- by GPT-5 + Allexzzq

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "FishItRNG"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 170)
frame.Position = UDim2.new(0, 20, 1, -190)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 36)
title.BackgroundTransparency = 1
title.Text = "🎣 Fish It • RNG Analyzer"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255,255,255)

local label = Instance.new("TextLabel", frame)
label.Position = UDim2.new(0, 10, 0, 42)
label.Size = UDim2.new(1, -20, 1, -52)
label.BackgroundTransparency = 1
label.TextWrapped = true
label.TextYAlignment = Top
label.TextXAlignment = Left
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.TextColor3 = Color3.fromRGB(200,200,200)

-- Data
local MAX_CAST = 15
local CastTimes = {}
local TotalCast = 0

local function analyze()
	if #CastTimes < 5 then
		return "UNKNOWN", "?", "Menunggu data cast..."
	end

	local variance = 0
	for i = 2, #CastTimes do
		variance += math.abs(CastTimes[i] - CastTimes[i-1])
	end
	variance /= (#CastTimes - 1)

	if variance < 0.4 then
		return "LOW", "RENDAH (relatif)", "RNG stagnan → pindah pulau"
	elseif variance < 1 then
		return "MEDIUM", "SEDANG (relatif)", "RNG normal"
	else
		return "HIGH", "TINGGI (relatif)", "RNG hidup → lanjut"
	end
end

local function updateUI()
	local status, chance, advice = analyze()
	label.Text =
		"Status Pulau : "..status..
		"\nPeluang Secret : "..chance..
		"\nTotal Cast : "..TotalCast..
		"\n\n"..advice
end

local function hookCharacter(char)
	char.ChildAdded:Connect(function(obj)
		if obj:IsA("Tool") then
			obj.Activated:Connect(function()
				TotalCast += 1
				table.insert(CastTimes, os.clock())
				if #CastTimes > MAX_CAST then
					table.remove(CastTimes, 1)
				end
				updateUI()
			end)
		end
	end)
end

if lp.Character then
	hookCharacter(lp.Character)
end
lp.CharacterAdded:Connect(hookCharacter)

label.Text =
	"Status Pulau : UNKNOWN"..
	"\nPeluang Secret : ?"..
	"\nTotal Cast : 0"..
	"\n\nRNG Analyzer aktif\nLempar pancing..."

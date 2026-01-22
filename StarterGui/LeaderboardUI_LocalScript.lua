local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LeaderboardUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Size = UDim2.new(0, 350, 0, 450)
Frame.Position = UDim2.new(0.5, -175, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Visible = false
Frame.Parent = ScreenGui

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = ScrollingFrame

local function createEntry()
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1, 0, 0, 40)
	f.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	f.BorderSizePixel = 0
	
	local nameLab = Instance.new("TextLabel")
	nameLab.Name = "PlayerName"
	nameLab.Size = UDim2.new(0.7, 0, 1, 0)
	nameLab.BackgroundTransparency = 1
	nameLab.TextColor3 = Color3.new(1, 1, 1)
	nameLab.TextXAlignment = Enum.TextXAlignment.Left
	nameLab.Parent = f
	
	local valLab = Instance.new("TextLabel")
	valLab.Name = "StatValue"
	valLab.Size = UDim2.new(0.3, 0, 1, 0)
	valLab.Position = UDim2.new(0.7, 0, 0, 0)
	valLab.BackgroundTransparency = 1
	valLab.TextColor3 = Color3.new(1, 1, 1)
	valLab.Parent = f
	
	return f
end

local function updateLeaderboard()
	for _, child in ipairs(ScrollingFrame:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	
	local sortedPlayers = Players:GetPlayers()
	table.sort(sortedPlayers, function(a, b)
		local aWins = a:FindFirstChild("leaderstats") and a.leaderstats:FindFirstChild("Wins") and a.leaderstats.Wins.Value or 0
		local bWins = b:FindFirstChild("leaderstats") and b.leaderstats:FindFirstChild("Wins") and b.leaderstats.Wins.Value or 0
		return aWins > bWins
	end)
	
	for _, p in ipairs(sortedPlayers) do
		local entry = createEntry()
		entry.PlayerName.Text = "  " .. (p.DisplayName or p.Name)
		local wins = p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Wins") and p.leaderstats.Wins.Value or 0
		entry.StatValue.Text = tostring(wins)
		entry.Parent = ScrollingFrame
	end
end

while true do
	updateLeaderboard()
	task.wait(10)
end

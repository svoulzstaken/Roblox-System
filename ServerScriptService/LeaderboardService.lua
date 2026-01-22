local Players = game:GetService("Players")

local function setupLeaderstats(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local wins = Instance.new("IntValue")
	wins.Name = "Wins"
	wins.Value = 0
	wins.Parent = leaderstats
	
	local votes = Instance.new("IntValue")
	votes.Name = "Votes"
	votes.Value = 0
	votes.Parent = leaderstats
end

Players.PlayerAdded:Connect(setupLeaderstats)

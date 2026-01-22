local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local VotingEvent = Instance.new("RemoteEvent")
VotingEvent.Name = "VotingEvent"
VotingEvent.Parent = ReplicatedStorage

local votes = {}
local hasVoted = {}

VotingEvent.OnServerEvent:Connect(function(player, targetPlayer)
	if player == targetPlayer then return end
	if hasVoted[player.UserId] then return end
	
	hasVoted[player.UserId] = true
	votes[targetPlayer.UserId] = (votes[targetPlayer.UserId] or 0) + 1
	
	local leaderstats = targetPlayer:FindFirstChild("leaderstats")
	if leaderstats then
		local voteStat = leaderstats:FindFirstChild("Votes")
		if voteStat then
			voteStat.Value = votes[targetPlayer.UserId]
		end
	end
	
	VotingEvent:FireClient(player, "Success")
end)

local function resetVotes()
	votes = {}
	hasVoted = {}
end

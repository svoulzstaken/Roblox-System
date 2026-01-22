local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BadgeConfig = require(ServerScriptService:WaitForChild("BadgeConfig"))

local function awardBadge(player, badgeId)
	local success, result = pcall(function()
		return BadgeService:UserHasBadgeAsync(player.UserId, badgeId)
	end)
	
	if success and not result then
		pcall(function()
			BadgeService:AwardBadge(player.UserId, badgeId)
		end)
	end
end

Players.PlayerAdded:Connect(function(player)
	local startTime = os.time()
	
	player.CharacterAdded:Connect(function(character)
		for _, otherPlayer in ipairs(Players:GetPlayers()) do
			if otherPlayer.UserId == game.CreatorId then
				awardBadge(player, BadgeConfig.MeetOwner)
			end
		end
	end)
	
	task.spawn(function()
		while player.Parent do
			task.wait(60)
			local elapsed = os.time() - startTime
			if elapsed >= 3600 then
				awardBadge(player, BadgeConfig.PlayTimeX)
			end
		end
	end)
end)

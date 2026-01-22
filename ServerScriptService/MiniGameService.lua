local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local QuestionData = require(ReplicatedStorage:WaitForChild("QuestionData"))

local MiniGameEvent = Instance.new("RemoteEvent")
MiniGameEvent.Name = "MiniGameEvent"
MiniGameEvent.Parent = ReplicatedStorage

local MiniGameResponse = Instance.new("RemoteFunction")
MiniGameResponse.Name = "MiniGameResponse"
MiniGameResponse.Parent = ReplicatedStorage

local winsStore = {}

local function startRound()
	local questions = QuestionData.Questions
	local randomQuestion = questions[math.random(1, #questions)]
	
	MiniGameEvent:FireAllClients("StartRound", randomQuestion)
	
	task.delay(10, function()
		MiniGameEvent:FireAllClients("EndRound")
	end)
end

MiniGameEvent.OnServerEvent:Connect(function(player, action, data)
	if action == "SubmitChoice" then
		winsStore[player.UserId] = (winsStore[player.UserId] or 0) + 1
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local wins = leaderstats:FindFirstChild("Wins")
			if wins then
				wins.Value = winsStore[player.UserId]
			end
		end
	end
end)

while true do
	task.wait(30)
	startRound()
end

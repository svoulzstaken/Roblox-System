local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local FeedbackEvent = ReplicatedStorage:WaitForChild("FeedbackEvent")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FeedbackUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local ToastFrame = Instance.new("Frame")
ToastFrame.Name = "ToastFrame"
ToastFrame.Size = UDim2.new(0, 300, 0, 60)
ToastFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
ToastFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToastFrame.BackgroundTransparency = 0.5
ToastFrame.Visible = false
ToastFrame.Parent = ScreenGui

local MessageLabel = Instance.new("TextLabel")
MessageLabel.Name = "MessageLabel"
MessageLabel.Size = UDim2.new(1, 0, 1, 0)
MessageLabel.BackgroundTransparency = 1
MessageLabel.TextColor3 = Color3.new(1, 1, 1)
MessageLabel.Font = Enum.Font.SourceSansBold
MessageLabel.TextSize = 20
MessageLabel.Parent = ToastFrame

local function showToast(message)
	MessageLabel.Text = message
	ToastFrame.Visible = true
	task.delay(3, function() ToastFrame.Visible = false end)
end

FeedbackEvent.OnClientEvent:Connect(showToast)

local function connectEvents()
	local names = {"VotingEvent", "TryOnEvent", "MiniGameEvent"}
	for _, name in ipairs(names) do
		local event = ReplicatedStorage:WaitForChild(name, 5)
		if event then
			event.OnClientEvent:Connect(function(action)
				if action == "Success" or action == "StartRound" then
					showToast("Action Successful!")
				end
			end)
		end
	end
end

connectEvents()

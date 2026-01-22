local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local MiniGameEvent = ReplicatedStorage:WaitForChild("MiniGameEvent")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniGameUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Size = UDim2.new(0, 400, 0, 200)
Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = false
Frame.Parent = ScreenGui

local QuestionLabel = Instance.new("TextLabel")
QuestionLabel.Name = "QuestionLabel"
QuestionLabel.Size = UDim2.new(1, 0, 0, 60)
QuestionLabel.BackgroundTransparency = 1
QuestionLabel.TextColor3 = Color3.new(1, 1, 1)
QuestionLabel.Font = Enum.Font.SourceSansBold
QuestionLabel.TextSize = 24
QuestionLabel.TextWrapped = true
QuestionLabel.Parent = Frame

local OptionA = Instance.new("TextButton")
OptionA.Name = "OptionA"
OptionA.Size = UDim2.new(0.45, 0, 0, 50)
OptionA.Position = UDim2.new(0.025, 0, 0.6, 0)
OptionA.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
OptionA.TextColor3 = Color3.new(1, 1, 1)
OptionA.Font = Enum.Font.SourceSans
OptionA.TextSize = 20
OptionA.Parent = Frame

local OptionB = Instance.new("TextButton")
OptionB.Name = "OptionB"
OptionB.Size = UDim2.new(0.45, 0, 0, 50)
OptionB.Position = UDim2.new(0.525, 0, 0.6, 0)
OptionB.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OptionB.TextColor3 = Color3.new(1, 1, 1)
OptionB.Font = Enum.Font.SourceSans
OptionB.TextSize = 20
OptionB.Parent = Frame

MiniGameEvent.OnClientEvent:Connect(function(action, data)
	if action == "StartRound" then
		Frame.Visible = true
		QuestionLabel.Text = data.Question
		OptionA.Text = data.OptionA
		OptionB.Text = data.OptionB
		OptionA.Interactable = true
		OptionB.Interactable = true
	elseif action == "EndRound" then
		Frame.Visible = false
	end
end)

OptionA.MouseButton1Click:Connect(function()
	OptionA.Interactable = false
	OptionB.Interactable = false
	MiniGameEvent:FireServer("SubmitChoice", {Choice = "A"})
end)

OptionB.MouseButton1Click:Connect(function()
	OptionA.Interactable = false
	OptionB.Interactable = false
	MiniGameEvent:FireServer("SubmitChoice", {Choice = "B"})
end)

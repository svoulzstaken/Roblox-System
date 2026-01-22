local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local VotingEvent = ReplicatedStorage:WaitForChild("VotingEvent")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VotingUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = false
Frame.Parent = ScreenGui

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "PlayerList"
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

local VoteButton = Instance.new("TextButton")
VoteButton.Name = "VoteButton"
VoteButton.Size = UDim2.new(0.9, 0, 0, 50)
VoteButton.Position = UDim2.new(0.05, 0, 0.8, 0)
VoteButton.Text = "Select a Player"
VoteButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
VoteButton.TextColor3 = Color3.new(1, 1, 1)
VoteButton.Parent = Frame

local selectedPlayer = nil

local function updateList()
	for _, child in ipairs(ScrollingFrame:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= Player then
			local btn = Instance.new("TextButton")
			btn.Text = p.DisplayName or p.Name
			btn.Size = UDim2.new(1, 0, 0, 40)
			btn.Parent = ScrollingFrame
			btn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				VoteButton.Text = "Vote for " .. btn.Text
				VoteButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			end)
		end
	end
end

VoteButton.MouseButton1Click:Connect(function()
	if selectedPlayer then
		VotingEvent:FireServer(selectedPlayer)
	end
end)

VotingEvent.OnClientEvent:Connect(function(status)
	if status == "Success" then
		VoteButton.Text = "Voted!"
		VoteButton.Active = false
		VoteButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end
end)

updateList()
Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

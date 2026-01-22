local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 200, 0, 300)
MenuFrame.Position = UDim2.new(0, 10, 0.5, -150)
MenuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MenuFrame.BorderSizePixel = 0
MenuFrame.Parent = ScreenGui

local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "Buttons"
ButtonsContainer.Size = UDim2.new(1, 0, 1, 0)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ButtonsContainer

local function createMenuButton(name, text)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 18
	button.Parent = ButtonsContainer
	
	button.MouseButton1Click:Connect(function()
		local targetGui = PlayerGui:FindFirstChild(name .. "UI")
		if targetGui then
			local frame = targetGui:FindFirstChildOfClass("Frame")
			if frame then
				frame.Visible = not frame.Visible
			end
		end
	end)
end

createMenuButton("MiniGame", "Mini-Game")
createMenuButton("TryOn", "Try-On")
createMenuButton("Voting", "Voting")
createMenuButton("Leaderboard", "Leaderboard")
createMenuButton("Nametag", "Nametag")

return nil

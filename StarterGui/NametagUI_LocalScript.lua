local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local NametagEvent = ReplicatedStorage:WaitForChild("NametagEvent")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NametagUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = false
Frame.Parent = ScreenGui

local PrefixInput = Instance.new("TextBox")
PrefixInput.Name = "PrefixInput"
PrefixInput.Size = UDim2.new(0.9, 0, 0, 40)
PrefixInput.Position = UDim2.new(0.05, 0, 0.1, 0)
PrefixInput.PlaceholderText = "Enter Prefix..."
PrefixInput.Text = ""
PrefixInput.Parent = Frame

local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(0.9, 0, 0, 40)
ApplyButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ApplyButton.Text = "Apply Prefix"
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ApplyButton.TextColor3 = Color3.new(1, 1, 1)
ApplyButton.Parent = Frame

local ColorButton = Instance.new("TextButton")
ColorButton.Name = "ColorButton"
ColorButton.Size = UDim2.new(0.9, 0, 0, 40)
ColorButton.Position = UDim2.new(0.05, 0, 0.7, 0)
ColorButton.Text = "Random Color"
ColorButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ColorButton.TextColor3 = Color3.new(1, 1, 1)
ColorButton.Parent = Frame

ApplyButton.MouseButton1Click:Connect(function()
	local prefix = PrefixInput.Text
	NametagEvent:FireServer("UpdatePrefix", {Prefix = prefix})
end)

ColorButton.MouseButton1Click:Connect(function()
	local randomColor = Color3.new(math.random(), math.random(), math.random())
	NametagEvent:FireServer("UpdateColor", {Color = randomColor})
end)

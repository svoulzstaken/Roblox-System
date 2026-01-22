local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local TryOnEvent = ReplicatedStorage:WaitForChild("TryOnEvent")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TryOnUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = false
Frame.Parent = ScreenGui

local AssetIdInput = Instance.new("TextBox")
AssetIdInput.Name = "AssetIdInput"
AssetIdInput.Size = UDim2.new(0.9, 0, 0, 40)
AssetIdInput.Position = UDim2.new(0.05, 0, 0.1, 0)
AssetIdInput.PlaceholderText = "Enter Asset ID..."
AssetIdInput.Text = ""
AssetIdInput.Parent = Frame

local TryOnBtn = Instance.new("TextButton")
TryOnBtn.Name = "TryOnButton"
TryOnBtn.Size = UDim2.new(0.9, 0, 0, 40)
TryOnBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
TryOnBtn.Text = "Try On"
TryOnBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
TryOnBtn.TextColor3 = Color3.new(1, 1, 1)
TryOnBtn.Parent = Frame

local PurchaseBtn = Instance.new("TextButton")
PurchaseBtn.Name = "PurchaseButton"
PurchaseBtn.Size = UDim2.new(0.9, 0, 0, 40)
PurchaseBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
PurchaseBtn.Text = "Purchase"
PurchaseBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
PurchaseBtn.TextColor3 = Color3.new(1, 1, 1)
PurchaseBtn.Parent = Frame

local ResetBtn = Instance.new("TextButton")
ResetBtn.Name = "ResetButton"
ResetBtn.Size = UDim2.new(0.9, 0, 0, 40)
ResetBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
ResetBtn.Text = "Reset Avatar"
ResetBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ResetBtn.TextColor3 = Color3.new(1, 1, 1)
ResetBtn.Parent = Frame

TryOnBtn.MouseButton1Click:Connect(function()
	local assetId = tonumber(AssetIdInput.Text)
	if assetId then TryOnEvent:FireServer("TryOn", assetId) end
end)

PurchaseBtn.MouseButton1Click:Connect(function()
	local assetId = tonumber(AssetIdInput.Text)
	if assetId then TryOnEvent:FireServer("Purchase", assetId) end
end)

ResetBtn.MouseButton1Click:Connect(function()
	TryOnEvent:FireServer("Reset")
end)

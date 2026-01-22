local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local NametagEvent = ReplicatedStorage:FindFirstChild("NametagEvent") or Instance.new("RemoteEvent")
NametagEvent.Name = "NametagEvent"
NametagEvent.Parent = ReplicatedStorage

local function createNametagTemplate()
	local tag = Instance.new("BillboardGui")
	tag.Name = "Nametag"
	tag.Size = UDim2.new(0, 200, 0, 50)
	tag.StudsOffset = Vector3.new(0, 3, 0)
	
	local label = Instance.new("TextLabel")
	label.Name = "TextLabel"
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 20
	label.TextStrokeTransparency = 0
	label.Parent = tag
	
	return tag
end

local function applyNametag(player, character)
	local head = character:WaitForChild("Head")
	local nametag = head:FindFirstChild("Nametag")
	if not nametag then
		nametag = createNametagTemplate()
		nametag.Parent = head
		nametag.Adornee = head
	end
	nametag.TextLabel.Text = player.DisplayName or player.Name
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		applyNametag(player, character)
	end)
end)

NametagEvent.OnServerEvent:Connect(function(player, action, data)
	local character = player.Character
	if not character then return end
	local head = character:FindFirstChild("Head")
	local nametag = head and head:FindFirstChild("Nametag")
	if nametag then
		if action == "UpdateColor" then
			nametag.TextLabel.TextColor3 = data.Color
		elseif action == "UpdatePrefix" then
			nametag.TextLabel.Text = "[" .. data.Prefix .. "] " .. (player.DisplayName or player.Name)
		end
	end
end)

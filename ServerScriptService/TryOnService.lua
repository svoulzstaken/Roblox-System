local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local TryOnEvent = Instance.new("RemoteEvent")
TryOnEvent.Name = "TryOnEvent"
TryOnEvent.Parent = ReplicatedStorage

local originalOutfits = {}

TryOnEvent.OnServerEvent:Connect(function(player, action, assetId)
	if action == "TryOn" then
		local character = player.Character
		if character then
			if not originalOutfits[player.UserId] then
				originalOutfits[player.UserId] = {}
				for _, item in ipairs(character:GetChildren()) do
					if item:IsA("Clothing") or item:IsA("Accessory") or item:IsA("ShirtGraphic") then
						table.insert(originalOutfits[player.UserId], item:Clone())
					end
				end
			end
			
			local assetInfo = MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
			if assetInfo then
				local item = game:GetService("InsertService"):LoadAsset(assetId):GetChildren()[1]
				if item then
					if item:IsA("Accessory") then
						character.Humanoid:AddAccessory(item)
					elseif item:IsA("Clothing") then
						local existing = character:FindFirstChildOfClass(item.ClassName)
						if existing then existing:Destroy() end
						item.Parent = character
					end
				end
			end
		end
	elseif action == "Reset" then
		local character = player.Character
		if character and originalOutfits[player.UserId] then
			for _, item in ipairs(character:GetChildren()) do
				if item:IsA("Clothing") or item:IsA("Accessory") or item:IsA("ShirtGraphic") then
					item:Destroy()
				end
			end
			for _, item in ipairs(originalOutfits[player.UserId]) do
				item:Clone().Parent = character
			end
			originalOutfits[player.UserId] = nil
		end
	elseif action == "Purchase" then
		MarketplaceService:PromptPurchase(player, assetId)
	end
end)

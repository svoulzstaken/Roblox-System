local DataStoreService = game:GetService("DataStoreService")
local SongDataStore = DataStoreService:GetDataStore("PlayerSongs_v1")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SongRemote = Instance.new("RemoteFunction")
SongRemote.Name = "SongRemote"
SongRemote.Parent = ReplicatedStorage

SongRemote.OnServerInvoke = function(player, action, data)
	local userId = player.UserId
	
	if action == "GetSavedSongs" then
		local success, result = pcall(function()
			return SongDataStore:GetAsync(tostring(userId))
		end)
		if success then
			return result or {}
		else
			warn("Failed to get songs for player " .. player.Name .. ": " .. tostring(result))
			return {}
		end
		
	elseif action == "SaveSong" then
		if not data or not data.Name or not data.Id then return false end
		
		local success, result = pcall(function()
			local currentSongs = SongDataStore:GetAsync(tostring(userId)) or {}
			table.insert(currentSongs, {Name = data.Name, Id = data.Id})
			SongDataStore:SetAsync(tostring(userId), currentSongs)
		end)
		
		if not success then
			warn("Failed to save song for player " .. player.Name .. ": " .. tostring(result))
		end
		return success
		
	elseif action == "RemoveSong" then
		if not data or not data.Id then return false end
		
		local success, result = pcall(function()
			local currentSongs = SongDataStore:GetAsync(tostring(userId)) or {}
			for i, song in ipairs(currentSongs) do
				if song.Id == data.Id then
					table.remove(currentSongs, i)
					break
				end
			end
			SongDataStore:SetAsync(tostring(userId), currentSongs)
		end)
		
		if not success then
			warn("Failed to remove song for player " .. player.Name .. ": " .. tostring(result))
		end
		return success
	end
end

local Tool = script.Parent
Tool.RequiresHandle = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local PresetSongs = require(Tool:WaitForChild("PresetSongs"))
local SongRemote = ReplicatedStorage:WaitForChild("SongRemote")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MusicUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 480)
MainFrame.Position = UDim2.new(1, 100, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Text = "MP3 PLAYER"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleLabel

local Controls = Instance.new("Frame")
Controls.Size = UDim2.new(1, -20, 0, 140)
Controls.Position = UDim2.new(0, 10, 0, 60)
Controls.BackgroundTransparency = 1
Controls.Parent = MainFrame

local CustomIdInput = Instance.new("TextBox")
CustomIdInput.Size = UDim2.new(0.65, -5, 0, 35)
CustomIdInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CustomIdInput.TextColor3 = Color3.new(1, 1, 1)
CustomIdInput.PlaceholderText = "Audio ID..."
CustomIdInput.Text = ""
CustomIdInput.Font = Enum.Font.Gotham
CustomIdInput.Parent = Controls

local CustomNameInput = Instance.new("TextBox")
CustomNameInput.Size = UDim2.new(0.35, -5, 0, 35)
CustomNameInput.Position = UDim2.new(0.65, 5, 0, 0)
CustomNameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CustomNameInput.TextColor3 = Color3.new(1, 1, 1)
CustomNameInput.PlaceholderText = "Name..."
CustomNameInput.Text = ""
CustomNameInput.Font = Enum.Font.Gotham
CustomNameInput.Parent = Controls

local PlayButton = Instance.new("TextButton")
PlayButton.Size = UDim2.new(0.48, 0, 0, 40)
PlayButton.Position = UDim2.new(0, 0, 0, 45)
PlayButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
PlayButton.Text = "PLAY"
PlayButton.TextColor3 = Color3.new(1,1,1)
PlayButton.Font = Enum.Font.GothamBold
PlayButton.Parent = Controls

local SaveButton = Instance.new("TextButton")
SaveButton.Size = UDim2.new(0.48, 0, 0, 40)
SaveButton.Position = UDim2.new(0.52, 0, 0, 45)
SaveButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SaveButton.Text = "SAVE"
SaveButton.TextColor3 = Color3.new(1,1,1)
SaveButton.Font = Enum.Font.GothamBold
SaveButton.Parent = Controls

local PauseButton = Instance.new("TextButton")
PauseButton.Size = UDim2.new(0.48, 0, 0, 40)
PauseButton.Position = UDim2.new(0, 0, 0, 95)
PauseButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
PauseButton.Text = "PAUSE"
PauseButton.TextColor3 = Color3.new(1,1,1)
PauseButton.Font = Enum.Font.GothamBold
PauseButton.Parent = Controls

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0.48, 0, 0, 40)
StopButton.Position = UDim2.new(0.52, 0, 0, 95)
StopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
StopButton.Text = "STOP"
StopButton.TextColor3 = Color3.new(1,1,1)
StopButton.Font = Enum.Font.GothamBold
StopButton.Parent = Controls

local VolumeFrame = Instance.new("Frame")
VolumeFrame.Size = UDim2.new(1, -20, 0, 30)
VolumeFrame.Position = UDim2.new(0, 10, 0, 210)
VolumeFrame.BackgroundTransparency = 1
VolumeFrame.Parent = MainFrame

local VolumeLabel = Instance.new("TextLabel")
VolumeLabel.Size = UDim2.new(0.2, 0, 1, 0)
VolumeLabel.BackgroundTransparency = 1
VolumeLabel.TextColor3 = Color3.new(1, 1, 1)
VolumeLabel.Text = "Vol: 50%"
VolumeLabel.Font = Enum.Font.Gotham
VolumeLabel.TextSize = 12
VolumeLabel.Parent = VolumeFrame

local VolumeSlider = Instance.new("Frame")
VolumeSlider.Size = UDim2.new(0.75, 0, 0, 6)
VolumeSlider.Position = UDim2.new(0.25, 0, 0.5, -3)
VolumeSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
VolumeSlider.Parent = VolumeFrame

local VolumeFill = Instance.new("Frame")
VolumeFill.Size = UDim2.new(0.5, 0, 1, 0)
VolumeFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
VolumeFill.BorderSizePixel = 0
VolumeFill.Parent = VolumeSlider

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0.45, 0)
TabFrame.Position = UDim2.new(0, 10, 0, 250)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local ListHeader = Instance.new("TextLabel")
ListHeader.Size = UDim2.new(1, 0, 0, 30)
ListHeader.Text = "SONG LIST"
ListHeader.TextColor3 = Color3.new(0.8, 0.8, 0.8)
ListHeader.Font = Enum.Font.GothamBold
ListHeader.BackgroundTransparency = 1
ListHeader.Parent = TabFrame

local SongList = Instance.new("ScrollingFrame")
SongList.Size = UDim2.new(1, 0, 1, -35)
SongList.Position = UDim2.new(0, 0, 0, 35)
SongList.BackgroundTransparency = 1
SongList.ScrollBarThickness = 4
SongList.Parent = TabFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = SongList

local currentSound = nil
local isPaused = false

local function updateVolume(percent)
	percent = math.clamp(percent, 0, 1)
	VolumeFill.Size = UDim2.new(percent, 0, 1, 0)
	VolumeLabel.Text = "Vol: " .. math.floor(percent * 100) .. "%"
	if currentSound then
		currentSound.Volume = percent
	end
end

local function playMusic(id, name)
	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
	end
	
	currentSound = Instance.new("Sound")
	currentSound.SoundId = id:find("rbxassetid://") and id or "rbxassetid://" .. id
	currentSound.Volume = VolumeFill.Size.X.Scale
	currentSound.Looped = true
	currentSound.Parent = game:GetService("SoundService")
	currentSound:Play()
	
	TitleLabel.Text = name:upper()
	PauseButton.Text = "PAUSE"
	isPaused = false
end

local function togglePause()
	if not currentSound then return end
	if isPaused then
		currentSound:Resume()
		PauseButton.Text = "PAUSE"
		isPaused = false
	else
		currentSound:Pause()
		PauseButton.Text = "RESUME"
		isPaused = true
	end
end

local function stopMusic()
	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
		currentSound = nil
	end
	TitleLabel.Text = "MP3 PLAYER"
	PauseButton.Text = "PAUSE"
	isPaused = false
end

local function createSongButton(song, isCustom)
	local btn = Instance.new("TextButton")
	btn.Text = "  " .. song.Name
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Parent = SongList
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,6)
	corner.Parent = btn
	
	if isCustom then
		local del = Instance.new("TextButton")
		del.Size = UDim2.new(0, 30, 0, 30)
		del.Position = UDim2.new(1, -35, 0.5, -15)
		del.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		del.Text = "X"
		del.TextColor3 = Color3.new(1, 1, 1)
		del.Font = Enum.Font.GothamBold
		del.Parent = btn
		del.MouseButton1Click:Connect(function()
			SongRemote:InvokeServer("RemoveSong", {Id = song.Id})
			btn:Destroy()
		end)
	end
	
	btn.MouseButton1Click:Connect(function()
		playMusic(song.Id, song.Name)
	end)
end

local function refreshSavedSongs()
	for _, child in ipairs(SongList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	for _, song in ipairs(PresetSongs) do
		createSongButton(song, false)
	end
	
	local saved = SongRemote:InvokeServer("GetSavedSongs")
	if saved then
		for _, song in ipairs(saved) do
			createSongButton(song, true)
		end
	end
end

PlayButton.MouseButton1Click:Connect(function()
	local id = CustomIdInput.Text
	if id ~= "" then
		playMusic(id, CustomNameInput.Text ~= "" and CustomNameInput.Text or "Custom Audio")
	end
end)

SaveButton.MouseButton1Click:Connect(function()
	local id = CustomIdInput.Text
	local name = CustomNameInput.Text
	if id ~= "" and name ~= "" then
		local success = SongRemote:InvokeServer("SaveSong", {Id = id, Name = name})
		if success then
			refreshSavedSongs()
			CustomIdInput.Text = ""
			CustomNameInput.Text = ""
		end
	end
end)

PauseButton.MouseButton1Click:Connect(togglePause)
StopButton.MouseButton1Click:Connect(stopMusic)

local isDraggingVolume = false
VolumeSlider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDraggingVolume = true
		local pos = math.clamp((input.Position.X - VolumeSlider.AbsolutePosition.X) / VolumeSlider.AbsoluteSize.X, 0, 1)
		updateVolume(pos)
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if isDraggingVolume and input.UserInputType == Enum.UserInputType.MouseMovement then
		local pos = math.clamp((input.Position.X - VolumeSlider.AbsolutePosition.X) / VolumeSlider.AbsoluteSize.X, 0, 1)
		updateVolume(pos)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDraggingVolume = false
	end
end)

Tool.Equipped:Connect(function()
	ScreenGui.Parent = PlayerGui
	refreshSavedSongs()
	MainFrame:TweenPosition(UDim2.new(1, -330, 0.5, -240), "Out", "Back", 0.5, true)
end)

Tool.Unequipped:Connect(function()
	MainFrame:TweenPosition(UDim2.new(1, 100, 0.5, -240), "In", "Quad", 0.3, true, function()
		if not Tool.Parent:IsA("Model") then
		end
	end)
end)

local Workspace = game:GetService("Workspace")

local function getLights()
	local lights = {}
	local mapRoot = Workspace:FindFirstChild("Map")
	local buildings = mapRoot and mapRoot:FindFirstChild("Buildings")
	
	if buildings then
		for _, building in ipairs(buildings:GetDescendants()) do
			if building:IsA("Light") then
				table.insert(lights, building)
			end
		end
	end
	return lights
end

local function animateLights()
	local lights = getLights()
	if #lights == 0 then return end
	
	while true do
		for _, light in ipairs(lights) do
			light.Brightness = math.random(1, 10) / 5
			light.Color = Color3.fromHSV(math.random(), 1, 1)
		end
		task.wait(math.random(5, 15))
	end
end

task.spawn(animateLights)

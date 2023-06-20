local module = {}

local UserInputService = game:GetService("UserInputService")

local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local currentHeight = 11

local maxZoom = 14
local minZoom = 12

local xBound = 74
local zBound = 100

local xPos = 0
local yPos = 0

local mouseEscape = false

local pressedW = false
local pressedA = false
local pressedS = false
local pressedD = false
local pressedE = false
local pressedQ = false

function module.SetCameraType(t)
	repeat
		camera.CameraType = t
		task.wait(.1)
	until
	camera.CameraType == t	
end

camera.CFrame = camera.CFrame + Vector3.new(0,11,0)

module.SetCameraType(Enum.CameraType.Scriptable)

function module.EngageControls(useKeyboard, useMouse)
	
	camera.CFrame = CFrame.new(camera.CFrame.Position, Vector3.new(camera.CFrame.Position.X, 1.5, camera.CFrame.Position.Z+9))
	
	if useKeyboard == true then
	
		UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if gameProcessedEvent then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.A and (camera.CFrame.Position.X + .06*currentHeight) < xBound then
					pressedA = true
					repeat
						camera.CFrame = camera.CFrame + Vector3.new(.06*currentHeight,0,0)
						task.wait()
					until
					pressedA == false or camera.CFrame.Position.X >= xBound
				elseif input.KeyCode == Enum.KeyCode.S and (camera.CFrame.Position.Z+-.06*currentHeight) > -zBound-85  then
					pressedS = true
					repeat
						camera.CFrame = camera.CFrame + Vector3.new(0,0,-0.06*currentHeight)
						task.wait()
					until
					pressedS == false or camera.CFrame.Position.Z <= -zBound-85
				elseif input.KeyCode == Enum.KeyCode.D and camera.CFrame.Position.X+-0.06*currentHeight > -xBound then
					pressedD = true
					repeat
						camera.CFrame = camera.CFrame + Vector3.new(-0.06*currentHeight,0,0)
						task.wait()
					until
					pressedD == false or camera.CFrame.Position.X <= -xBound
				elseif input.KeyCode == Enum.KeyCode.W and camera.CFrame.Position.Z+.06*currentHeight < zBound then
					pressedW = true
					repeat
						camera.CFrame = camera.CFrame + Vector3.new(0,0,0.06*currentHeight)
						task.wait()
					until
					pressedW == false or camera.CFrame.Position.Z >= zBound
				elseif input.KeyCode == Enum.KeyCode.E and currentHeight <= maxZoom then
					pressedE = true
					repeat					
						currentHeight+=.06
						camera.CFrame = camera.CFrame + Vector3.new(0,0.06*currentHeight,-0.05*currentHeight)
						task.wait()
					until
					pressedE == false or currentHeight >= maxZoom
				elseif input.KeyCode == Enum.KeyCode.Q and currentHeight >= minZoom then
					pressedQ = true
					repeat					
						currentHeight-=.06
						camera.CFrame = camera.CFrame + Vector3.new(0,-0.06*currentHeight,0.05*currentHeight)
						task.wait()
					until
					pressedQ == false or currentHeight <= minZoom
				end
			end
		end)
		
		UserInputService.InputEnded:Connect(function(input, gameprocessed)
			if gameprocessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.A then
					pressedA = false
				elseif input.KeyCode == Enum.KeyCode.S then
					pressedS = false
				elseif input.KeyCode == Enum.KeyCode.D then
					pressedD = false
				elseif input.KeyCode == Enum.KeyCode.W then
					pressedW = false
				elseif input.KeyCode == Enum.KeyCode.E then
					pressedE = false
				elseif input.KeyCode == Enum.KeyCode.Q then
					pressedQ = false
				end
			end
		end)
		
	end
	
	if useMouse == true then
		
		local x
		local y
		
		mouse.Button1Up:Connect(function()
			mouseEscape = true
		end)
		
		-- don't question the optimization i'm already questioning my sanity 
		mouse.Button1Down:Connect(function()
			mouseEscape = false
			repeat
				xPos = mouse.X
				yPos = mouse.Y
				task.wait()
				x = (mouse.X-xPos)/150*currentHeight
				y = (mouse.Y-yPos)/150*currentHeight
				if x+camera.CFrame.Position.X > xBound or x+camera.CFrame.Position.X < -xBound then
					if x > 0 and x+camera.CFrame.Position.X < -xBound then
					elseif x < 0 and x+camera.CFrame.Position.X > xBound then 
					else
						x = 0
					end
				end
				
				if y+camera.CFrame.Position.Z > zBound or y+camera.CFrame.Position.Z < -zBound-85 then
					if y > 0 and y+camera.CFrame.Position.Z < -zBound-85 then
					elseif y < 0 and y+camera.CFrame.Position.Z > zBound then 
					else
						y = 0
					end
				end
				camera.CFrame = camera.CFrame + Vector3.new(x,0,y)
			until
			mouseEscape == true
		end)
		
		mouse.WheelBackward:Connect(function()
			if currentHeight <= maxZoom then
				currentHeight+=.2
				camera.CFrame = camera.CFrame + Vector3.new(0,0.2*currentHeight,-0.25*currentHeight)
			end
		end)
		
		mouse.WheelForward:Connect(function()
			if currentHeight >= minZoom then
				currentHeight-=.2
				camera.CFrame = camera.CFrame + Vector3.new(0,-0.2*currentHeight,0.25*currentHeight)
			end
		end)
		
	end
end

return module

local module = {}

local ts = game:GetService("TweenService")
local pos = require(script.Parent.Parent.ClientPositioning)

local mvmtP = workspace:WaitForChild("MovementParts")
local mP = workspace:WaitForChild("MainParts")

local highlightedParts = {}
local highlightedPartsFull = {}
local highlightedTroop

local selectedParts = {}

local mainColor = Color3.fromRGB(248, 255, 229)

local gradTable = {
	Color3.fromRGB(125, 222, 146),
	Color3.fromRGB(46, 191, 165),
	Color3.fromRGB(48, 131, 220),
	Color3.fromRGB(78, 65, 135),
	Color3.fromRGB(248, 255, 229),
}

local active = false

local function tweenObject(obj, len, style, properties)
	ts:Create(obj, TweenInfo.new(len,style,Enum.EasingDirection.InOut,0,false,0),properties):Play()
end

function module.EngageMouse()

	local mouse = game.Players.LocalPlayer:GetMouse()

	mouse.Move:Connect(function()		
		if mouse.Target.Parent then
			if mouse.Target.Parent.Parent and tonumber(mouse.Target.Name) and tonumber(mouse.Target.Parent.Name) then
				if table.find(highlightedPartsFull, Vector2.new(tonumber(mouse.Target.Name), tonumber(mouse.Target.Parent.Name))) then
					if mvmtP[mouse.Target.Parent.Name][mouse.Target.Name]["Union"]:GetAttribute("MColor") then
						if mvmtP[mouse.Target.Parent.Name][mouse.Target.Name]["Union"].Transparency <= .4 then
							
							if selectedParts[1] then
								
								for i = 1,#selectedParts do
									if selectedParts[i].Transparency < 1 then
										tweenObject(selectedParts[i], .135, Enum.EasingStyle.Sine, {Transparency = .4, Color = selectedParts[i]:GetAttribute("MColor")})
									end		
								end
								selectedParts = {}
							end
							
							local a = mvmtP[mouse.Target.Parent.Name][mouse.Target.Name]:GetChildren()
							for i = 1,#a do
								table.insert(selectedParts, a[i])
								tweenObject(a[i], .135, Enum.EasingStyle.Sine, {Transparency = 0, Color = mainColor})
							end
							
						elseif selectedParts ~= {} then
							for i = 1,#selectedParts do
								if selectedParts[i].Transparency <= .4 then
									tweenObject(selectedParts[i], .135, Enum.EasingStyle.Sine, {Transparency = .4, Color = selectedParts[i]:GetAttribute("MColor")})
								end		
							end
							selectedParts = {}
						end
					elseif selectedParts ~= {} then
						for i = 1,#selectedParts do
							if selectedParts[i].Transparency <= .4 then
								tweenObject(selectedParts[i], .135, Enum.EasingStyle.Sine, {Transparency = .4, Color = selectedParts[i]:GetAttribute("MColor")})
							end		
						end
						selectedParts = {}
					end
				elseif selectedParts ~= {} then
					for i = 1,#selectedParts do
						if selectedParts[i].Transparency < 1 then
							tweenObject(selectedParts[i], .135, Enum.EasingStyle.Sine, {Transparency = .4, Color = selectedParts[i]:GetAttribute("MColor")})
						end		
					end
					selectedParts = {}
				end	
			end
		end
	end)
	--[[
	local selectedMainPart
	
	mouse.Move:Connect(function()
		
		if not mouse.Target then 
			if selectedMainPart then
				tweenObject(selectedMainPart, .2, Enum.EasingStyle.Sine, {Color = selectedMainPart:GetAttribute("OrigColor")})
				selectedMainPart = nil
			end	
			return 
		end
		if not mouse.Target.Parent then 
			if selectedMainPart then
				tweenObject(selectedMainPart, .2, Enum.EasingStyle.Sine, {Color = selectedMainPart:GetAttribute("OrigColor")})
				selectedMainPart = nil
			end	
			return 
		end
		if not tonumber(mouse.Target.Name) and not tonumber(mouse.Target.Parent.Name) then
			if selectedMainPart then
				tweenObject(selectedMainPart, .2, Enum.EasingStyle.Sine, {Color = selectedMainPart:GetAttribute("OrigColor")})
				selectedMainPart = nil
			end	
			return 
		end
		
		if mP[mouse.Target.Parent.Name][mouse.Target.Name] then
			if selectedMainPart then
				tweenObject(selectedMainPart, .2, Enum.EasingStyle.Sine, {Color = selectedMainPart:GetAttribute("OrigColor")})
				selectedMainPart = nil
			end	
				
			local c = mP[mouse.Target.Parent.Name][mouse.Target.Name]:GetAttribute("OrigColor")
			tweenObject(mP[mouse.Target.Parent.Name][mouse.Target.Name], .25, Enum.EasingStyle.Sine, {Color = Color3.new(c.R*1.1, c.G*1.1, c.B*1.1)})
			selectedMainPart = mP[mouse.Target.Parent.Name][mouse.Target.Name]
		end
		
	end)
	]]--
end

function module.CreatePopup(part)

	if not game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Troops") then
		local troops = Instance.new("Folder", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
		troops.Name = "Troops"
	end

	local basePopup = script:WaitForChild("Popup"):Clone()
	basePopup.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Troops")
	basePopup.Adornee = part

	return basePopup

end

function module.BindObject(popupObj, initColor, initBackColor)
	if not popupObj:WaitForChild("Foreground",2) then return "Bad popup." end
	if not popupObj:WaitForChild("Background",2) then return "Bad popup." end

	local fore = popupObj:WaitForChild("Foreground")
	local back = popupObj:WaitForChild("Background")

	tweenObject(fore,.25,Enum.EasingStyle.Sine,{ImageColor3 = Color3.new(initColor.R*.86, initColor.G*.86, initColor.B*.86), ImageTransparency = 0.4})
	tweenObject(back,.25,Enum.EasingStyle.Sine,{ImageColor3 = Color3.new(initBackColor.R*.86, initBackColor.G*.86, initBackColor.B*.86), ImageTransparency = 0.8})

	fore.MouseEnter:Connect(function()
		tweenObject(fore,.35,Enum.EasingStyle.Sine,{ImageColor3 = initColor, ImageTransparency = 0})
		tweenObject(back,.35,Enum.EasingStyle.Sine,{ImageColor3 = initBackColor, ImageTransparency = 0})
	end)

	fore.MouseLeave:Connect(function()
		tweenObject(fore,.25,Enum.EasingStyle.Sine,{ImageColor3 = Color3.new(initColor.R*.86, initColor.G*.86, initColor.B*.86), ImageTransparency = 0.4})
		tweenObject(back,.25,Enum.EasingStyle.Sine,{ImageColor3 = Color3.new(initBackColor.R*.86, initBackColor.G*.86, initBackColor.B*.86), ImageTransparency = 0.8})
	end)

	fore.MouseButton1Click:Connect(function()
		if active == false then
			local cord = pos.ConvertXYZToCord(popupObj.Adornee.Position)
			local layers = pos.ReturnNearby(cord, 3)

			local x = mvmtP[cord.Y][cord.X]:GetChildren()
			for z = 1,#x do
				x[z].Color = mainColor
				x[z]:SetAttribute("MColor", mainColor)
				tweenObject(x[z], .5, Enum.EasingStyle.Sine, {Transparency = 0.4})
			end

			for i = 1,#layers do 

				for j = 1,#layers[i] do
					local x = mvmtP[layers[i][j].Y][layers[i][j].X]:GetChildren()
					for z = 1,#x do
						x[z].Color = gradTable[i]
						x[z]:SetAttribute("MColor", gradTable[i])
						tweenObject(x[z], .5, Enum.EasingStyle.Sine, {Transparency = 0.4})
					end
					table.insert(highlightedPartsFull, layers[i][j])
				end

				task.wait(.1)

			end

			highlightedParts = layers
			table.insert(highlightedParts, {cord})
			highlightedTroop = popupObj
			active = true

		else

			for i = 1,#highlightedParts do

				for j = 1,#highlightedParts[i] do
					local x = mvmtP[highlightedParts[i][j].Y][highlightedParts[i][j].X]:GetChildren()
					for z = 1,#x do
						tweenObject(x[z], .5, Enum.EasingStyle.Sine, {Transparency = 1})
					end
				end
				task.wait(.1)

			end

			active = false

			if highlightedTroop ~= popupObj then

				local cord = pos.ConvertXYZToCord(popupObj.Adornee.Position)
				local layers = pos.ReturnNearby(cord, 3)

				local x = mvmtP[cord.Y][cord.X]:GetChildren()
				table.insert(highlightedPartsFull, cord)

				for z = 1,#x do
					x[z].Color = mainColor
					x[z]:SetAttribute("MColor", mainColor)
					tweenObject(x[z], .5, Enum.EasingStyle.Sine, {Transparency = 0.4})
				end

				for i = 1,#layers do 

					for j = 1,#layers[i] do
						local x = mvmtP[layers[i][j].Y][layers[i][j].X]:GetChildren()
						for z = 1,#x do
							x[z].Color = gradTable[i]
							x[z]:SetAttribute("MColor", gradTable[i])
							tweenObject(x[z], .5, Enum.EasingStyle.Sine, {Transparency = 0.4})
						end
						table.insert(highlightedPartsFull, layers[i][j])
					end

					task.wait(.1)

				end

				highlightedParts = layers
				table.insert(highlightedParts, {cord})
				highlightedTroop = popupObj
				active = true

			else

				highlightedTroop = nil
				highlightedParts = {}
				highlightedPartsFull = {}

			end

		end
	end)

end

return module

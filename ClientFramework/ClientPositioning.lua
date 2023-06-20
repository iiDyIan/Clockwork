local module = {}

local zeroX = 1.218
local zeroY = -1.36
local incX = 8.235
local incY = 7.323

function module.ConvertXYZToCord(Position)
	
	local x = math.round((Position.X-zeroX)/incX)
	local y = math.round((Position.Z-zeroY)/incY)
	x = -x
	if x == -0 then 
		x=0
	end
	if y == -0 then
		y=0
	end
	return Vector2.new(x,y)

end

function module.ConvertCordToXYZ(Coordinates)
	
	local x = zeroX + (Coordinates.X*incX)
	local z = zeroY + (Coordinates.Y*incY)
	local y = 3.142

	return Vector3.new(x,y,z)
	
end

function module.ReturnNearby(Coordinate, Range)
	
	if Range < 1 or Range > 4 then return "Invalid range." end
	
	if Coordinate.X < -11 then return "Invalid X coordinate" end
	if Coordinate.X > 11 then return "Invalid X coordinate." end
	if Coordinate.Y < -23 then return "Invali Y coordinate." end
	if Coordinate.Y > 23 then return "Invalid Y coordinate." end
	
	local preTable = {}
	local sanTable = {}
	
	preTable = {
		{
		Vector2.new(Coordinate.X+1, Coordinate.Y),
		Vector2.new(Coordinate.X-1, Coordinate.Y),
		Vector2.new(Coordinate.X, Coordinate.Y+1),
		Vector2.new(Coordinate.X-1, Coordinate.Y+1),
		Vector2.new(Coordinate.X, Coordinate.Y-1),
		Vector2.new(Coordinate.X-1, Coordinate.Y-1),
		}
	}
	
	if Range >= 2 then
		
		table.insert(preTable, {
			
			Vector2.new(Coordinate.X+2, Coordinate.Y),
			Vector2.new(Coordinate.X-2, Coordinate.Y),
			
			Vector2.new(Coordinate.X+1, Coordinate.Y+1),
			Vector2.new(Coordinate.X-2, Coordinate.Y+1),
			
			Vector2.new(Coordinate.X+1, Coordinate.Y-1),
			Vector2.new(Coordinate.X-2, Coordinate.Y-1),
			
			Vector2.new(Coordinate.X, Coordinate.Y+2),
			Vector2.new(Coordinate.X-1, Coordinate.Y+2),
			Vector2.new(Coordinate.X+1, Coordinate.Y+2),
			
			Vector2.new(Coordinate.X, Coordinate.Y-2),
			Vector2.new(Coordinate.X-1, Coordinate.Y-2),
			Vector2.new(Coordinate.X+1, Coordinate.Y-2),
		})
		
	end
		
	if Range >= 3 then
		
		table.insert(preTable, {
				
			Vector2.new(Coordinate.X+3, Coordinate.Y),
			Vector2.new(Coordinate.X-3, Coordinate.Y),
				
			Vector2.new(Coordinate.X+2, Coordinate.Y+1),
			Vector2.new(Coordinate.X-3, Coordinate.Y+1),
				
			Vector2.new(Coordinate.X+2, Coordinate.Y-1),
			Vector2.new(Coordinate.X-3, Coordinate.Y-1),
				
			Vector2.new(Coordinate.X+2, Coordinate.Y+2),
			Vector2.new(Coordinate.X-2, Coordinate.Y+2),

			Vector2.new(Coordinate.X+2, Coordinate.Y-2),
			Vector2.new(Coordinate.X-2, Coordinate.Y-2),
			
			Vector2.new(Coordinate.X, Coordinate.Y-3),
			Vector2.new(Coordinate.X+1, Coordinate.Y-3),
			Vector2.new(Coordinate.X-1, Coordinate.Y-3),
			Vector2.new(Coordinate.X-2, Coordinate.Y-3),
				
			Vector2.new(Coordinate.X, Coordinate.Y+3),
			Vector2.new(Coordinate.X+1, Coordinate.Y+3),
			Vector2.new(Coordinate.X-1, Coordinate.Y+3),
			Vector2.new(Coordinate.X-2, Coordinate.Y+3),
				
		})
		
	end
	
	if Range == 4 then
		
		table.insert(preTable, {
			
			Vector2.new(Coordinate.X+4, Coordinate.Y),
			Vector2.new(Coordinate.X-4, Coordinate.Y),
			
			Vector2.new(Coordinate.X+3, Coordinate.Y+1),
			Vector2.new(Coordinate.X-4, Coordinate.Y+1),
			
			Vector2.new(Coordinate.X+3, Coordinate.Y-1),
			Vector2.new(Coordinate.X-4, Coordinate.Y-1),
			
			Vector2.new(Coordinate.X+3, Coordinate.Y+2),
			Vector2.new(Coordinate.X-3, Coordinate.Y+2),
			
			Vector2.new(Coordinate.X+3, Coordinate.Y-2),
			Vector2.new(Coordinate.X-3, Coordinate.Y-2),
			
			Vector2.new(Coordinate.X+2, Coordinate.Y+3),
			Vector2.new(Coordinate.X-3, Coordinate.Y+3),
			
			Vector2.new(Coordinate.X+2, Coordinate.Y-3),
			Vector2.new(Coordinate.X-3, Coordinate.Y-3),
			
			Vector2.new(Coordinate.X, Coordinate.Y-4),
			Vector2.new(Coordinate.X+1, Coordinate.Y-4),
			Vector2.new(Coordinate.X+2, Coordinate.Y-4),
			Vector2.new(Coordinate.X-1, Coordinate.Y-4),
			Vector2.new(Coordinate.X-2, Coordinate.Y-4),
			
			Vector2.new(Coordinate.X, Coordinate.Y+4),
			Vector2.new(Coordinate.X+1, Coordinate.Y+4),
			Vector2.new(Coordinate.X+2, Coordinate.Y+4),
			Vector2.new(Coordinate.X-1, Coordinate.Y+4),
			Vector2.new(Coordinate.X-2, Coordinate.Y+4),
		})
		
	end
		
	for i = 1,#preTable do 
		
		table.insert(sanTable, {})
		
		for j = 1,#preTable[i] do
		
			if preTable[i][j].X < -10 and preTable[i][j].Y%2 == 0 then continue end
			if preTable[i][j].X < -11 and preTable[i][j].Y%2 ~= 0 then continue end
			if preTable[i][j].X > 10 then continue end
			if preTable[i][j].Y < -21 then continue end
			if preTable[i][j].Y > 22 then continue end
			
			if preTable[i][j].X == -0 then preTable[i][j] = Vector2.new(0, preTable[i][j].Y) end
			if preTable[i][j].Y == -0 then preTable[i][j] = Vector2.new(preTable[i][j].X, 0) end
			
			table.insert(sanTable[i], preTable[i][j])
			
		end		
	end
		
	return sanTable
	
end

function module.ReturnBorders(tileTable)
	
	local showParts = {}
	local hideParts = {}
	
	for i = 1,#tileTable do
		
		if table.find(tileTable, Vector2.new(tileTable[i].X-1, tileTable[i].Y)) then
			table.insert(hideParts, {tileTable[i], "Left"})
		else
			table.insert(showParts, {tileTable[i], "Left"})
		end
		
		if table.find(tileTable, Vector2.new(tileTable[i].X+1, tileTable[i].Y)) then
			table.insert(hideParts, {tileTable[i], "Right"})
		else
			table.insert(showParts, {tileTable[i], "Right"})
		end
		
		if tileTable[i].Y%2 == 0 then
			
			if table.find(tileTable, Vector2.new(tileTable[i].X-1, tileTable[i].Y-1)) then
				table.insert(hideParts, {tileTable[i], "BotLeft"})
			else
				table.insert(showParts, {tileTable[i], "BotLeft"})
			end
			
			if table.find(tileTable, Vector2.new(tileTable[i].X, tileTable[i].Y-1)) then
				table.insert(hideParts, {tileTable[i], "BotRight"})
			else
				table.insert(showParts, {tileTable[i], "BotRight"})
			end
			
			if table.find(tileTable, Vector2.new(tileTable[i].X-1, tileTable[i].Y+1)) then
				table.insert(hideParts, {tileTable[i], "TopLeft"})
			else
				table.insert(showParts, {tileTable[i], "TopLeft"})
			end

			if table.find(tileTable, Vector2.new(tileTable[i].X, tileTable[i].Y+1)) then
				table.insert(hideParts, {tileTable[i], "TopRight"})
			else
				table.insert(showParts, {tileTable[i], "TopRight"})
			end
			
		else
			
			if table.find(tileTable, Vector2.new(tileTable[i].X, tileTable[i].Y-1)) then
				table.insert(hideParts, {tileTable[i], "BotLeft"})
			else
				table.insert(showParts, {tileTable[i], "BotLeft"})
			end

			if table.find(tileTable, Vector2.new(tileTable[i].X+1, tileTable[i].Y-1)) then
				table.insert(hideParts, {tileTable[i], "BotRight"})
			else
				table.insert(showParts, {tileTable[i], "BotRight"})
			end

			if table.find(tileTable, Vector2.new(tileTable[i].X, tileTable[i].Y+1)) then
				table.insert(hideParts, {tileTable[i], "TopLeft"})
			else
				table.insert(showParts, {tileTable[i], "TopLeft"})
			end

			if table.find(tileTable, Vector2.new(tileTable[i].X+1, tileTable[i].Y+1)) then
				table.insert(hideParts, {tileTable[i], "TopRight"})
			else
				table.insert(showParts, {tileTable[i], "TopRight"})
			end
			
		end

	end
	
	return showParts, hideParts
	
end

return module

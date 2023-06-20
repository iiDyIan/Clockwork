local module = {}

local events = game:GetService("ReplicatedStorage"):WaitForChild("Movement")
local interface = require(script:WaitForChild("Interface"))

interface.EngageMouse()

local scout = events:WaitForChild("RequestMove"):InvokeServer("Scout", Vector2.new(0,4))
local archer = events:WaitForChild("RequestMove"):InvokeServer("Archer", Vector2.new(-10,4))

local archerPopup = interface.CreatePopup(archer)
interface.BindObject(archerPopup, Color3.fromRGB(151,0,0), Color3.fromRGB(67,0,0))

local scoutPopup = interface.CreatePopup(scout)
interface.BindObject(scoutPopup, Color3.fromRGB(0,16,176), Color3.fromRGB(0,8,81))

return module

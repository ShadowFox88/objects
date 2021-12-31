local RS = game:GetService("ReplicatedStorage")

local Mapping = require(RS.Objects.Mapping)
local Utils = require(RS.Utils)

local Dictionary = {}
	  Dictionary.__index = Dictionary


function Dictionary.new(mapping)
	mapping = if mapping ~= nil then mapping else {}

	local count = 0

	for _, _ in pairs(mapping) do
		count += 1
	end

	local self = Mapping.new(mapping)

	rawset(self, "Count", count)

	return setmetatable(self, Dictionary)
end


function Dictionary:__newindex(key, value)
	if self.Internal[key] then return end

	self.Count += 1
	self.Internal[key] = value
end


function Dictionary:__len()
	return self.Count
end


return Dictionary

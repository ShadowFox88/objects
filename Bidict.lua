--[[
    This is a prototype for a bi-directional dictionary whereby keys or values
    can be indexed via values or keys respectively
]]
local Bidict = {}
      Bidict.__index = Bidict


function Bidict.new(dict, resolveValuesFirst)
    dict = if dict ~= nil then dict else {}
    resolveValuesFirst = if resolveValuesFirst ~= nil then resolveValuesFirst else false
    local self = {
        _ResolveValuesFirst = resolveValuesFirst,
        CreateEntry = nil,
        Keys = {},
        Values = {},
    }

    setmetatable(self, Bidict)

    for key, value in pairs(dict) do
        self:Set(key, value)
    end

    return self
end


function Bidict:Set(key, value)
    local entry;

    if self.CreateEntry then
        entry = self:CreateEntry(key, value)
    else
        entry = {
            Key = key,
            Value = value
        }
    end

    self.Keys[key] = entry
    self.Values[value] = entry
end


function Bidict:Get(data, resolveValuesFirst)
    resolveValuesFirst = if resolveValuesFirst ~= nil then resolveValuesFirst else self._ResolveValuesFirst

    if resolveValuesFirst then
        return self.Values[data] or self.Keys[data]
    end

    return self.Keys[data] or self.Values[data]
end


function Bidict:__newindex(key, value)
    self:Set(key, value)
end


function Bidict:__index(data)
    if typeof(data) == "string" then
        local attributeFound = rawget(self, data) or Bidict[data]

        if attributeFound then
            return attributeFound
        end
    end

    return self:Get(data)
end


return Bidict

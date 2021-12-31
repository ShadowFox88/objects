local _InternalEnum = {}
	  _InternalEnum.__index = _InternalEnum
local _EnumAuto = {}
	  _EnumAuto.__index = _EnumAuto
local Enums = {}
	  Enums.__index = Enums


function _InternalEnum.new(name, value)
	local self = {
		Name = name,
		Value = value
	}

	return setmetatable(self, _InternalEnum)
end


function _InternalEnum:__eq(value)
	return self.Value == value
end


function _InternalEnum:__newindex(...)
	error("Cannot perform operation on Enum")
end


function Enums.new(attrs)
	local counter = 0
	local self = {
		Enums = {}
	}

	for key, value in pairs(attrs) do
		if typeof(key) ~= "string" then
			local message = string.format('"attrs" cannot contain non-string keys (%s)', key)

			error(message)
		elseif typeof(value) == "table" and value == _EnumAuto then
			counter += 1
			value = counter
		end

		self.Enums[key] = _InternalEnum.new(key, value)
	end

	return setmetatable(self, Enums)
end


function Enums.auto()
	return _EnumAuto
end


return Enums

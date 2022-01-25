local Set = {}
      Set.__index = Set


function Set.new(...)
    local self = {
        Mapping = {}
    }

    for _, v in ipairs({...}) do
        self:Add(v)
    end

    return setmetatable(self, Set)
end


function Set:Add(element)
    self.Mapping[element] = self.Mapping[element] or element
end


function Set:Remove(element)
    self.Mapping[element] = nil
end


function Set:Pop(element)
    local ret = self.Mapping[element]

    self:Remove(element)

    return ret
end


return Set

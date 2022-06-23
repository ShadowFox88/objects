local Set = {}
      Set.__index = Set


function Set.new(...: any)
    local self = setmetatable({}, Set)
          self.Ordered = {}
          self.Mapping = {}

          self.Pop = self.Discard
          self.Remove = self.Discard

    for _, value in ipairs({...}) do
        self:Add(value)
    end

    return self
end


function Set:__index(key)
    return Set[key] or self.Ordered[key]
end


function Set:Add(value)
    if self.Mapping[value] then return end

    self.Mapping[value] = {
        value
    }

    table.insert(self.Ordered, value)
end


function Set:Clear()
    self.Mapping = {}
    self.Ordered = {}
end


function Set:Copy()
    return Set.new(table.unpack(self.Ordered))
end


function Set:Difference(...)
    local difference = {}

    for _, set in ipairs({...}) do
        for key, _ in ipairs(set.Ordered) do
            if self.Mapping[key] then continue end

            table.insert(difference, key)
        end
    end

    return Set.new(table.unpack(difference))
end


function Set:Discard(value)
    if not self.Mapping[value] then return end

    self.Mapping[value] = nil

    return table.remove(self.Ordered, table.find(self.Ordered, value))
end


function Set:Intersection(...)
    local intersection = {}

    for key, _ in ipairs(self.Ordered) do
        for _, set in ipairs({...}) do
            if not set[key] then continue end

            table.insert(intersection, key)
        end
    end

    return Set.new(table.unpack(intersection))
end


function Set:IsADisjoint(set)
    for key, _ in ipairs(set.Ordered) do
        if self.Mapping[key] then
            return true
        end
    end

    return false
end


function Set:IsASubset(set)
    for key, _ in ipairs(self.Ordered) do
        if not set[key] then
            return false
        end
    end

    return true
end


function Set:IsASuperset(set)
    for key, _ in ipairs(set.Ordered) do
        if not self.Mapping[key] then return false end
    end

    return true
end


function Set:Union(...)
    local union = {}

    for _, set in ipairs({...}) do
        for key, _ in ipairs(set.Ordered) do
            table.insert(union, key)
        end
    end

    return Set.new(table.unpack(union))
end


function Set:Update(...)
    for _, set in ipairs({...}) do
        for key, _ in ipairs(set.Ordered) do
            self:Add(key)
        end
    end
end


return Set

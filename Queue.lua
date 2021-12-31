local Mapping = require(script.Parent.Mapping)

local Queue = {}
      Queue.__index = Queue


function Queue.new(array, limit)
    assert(typeof(array) == "table")
    assert(typeof(limit) == "number")

    local count = 0
    local self = {
        Limit = limit,
        Queue = array
    }

    for _, value in ipairs(array) do
        count += 1

        table.insert(self.Queue, value)

        if #self.Queue == limit then
            break
        end
    end

    return setmetatable(self, Queue)
end


function Queue:HasOverextended()
    if #self.Queue <= self.Limit then return end

    table.remove(self.Queue, 1)
end


function Queue:__newindex(index, value)
    assert(typeof(index) == "number")

    table.insert(self.Queue, index, value)
    self:HasOverextended()
end


function Queue:__index(index)
    return self.Queue[index]
end


function Queue:Insert(value, index)
    assert(typeof(index) == "number")

    table.insert(self.Queue, value, index)
    self:HasOverextended()
end


function Queue:Remove(index)
    assert(#self.Queue > 0)

    table.remove(self.Queue, index)
end


function Queue:Clear()
    if #self.Queue == 0 then return end

    self.Queue = {}
end


return Queue

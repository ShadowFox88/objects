local Deque = {}
      Deque.__index = Deque


local function copy(container)
    local copied = {}

    for _, value in ipairs(container) do
        table.insert(copied, value)
    end

    return copied
end


-- FILO by default
function Deque.new(elements, limit, lifo)
    lifo = if lifo then lifo else false

    local self = setmetatable({}, Deque)
          self.Limit = limit
          self.LIFO = lifo
          self.Elements = {}

    if #elements > limit then
        for i = 1, limit do
            table.insert(self.Elements, elements[i])
        end
    else
        self.Elements = elements
    end

    return self
end


function Deque:__len()
    return #self.Elements
end


function Deque:_AddElement(element)
    local elements = copy(self.Elements)

    if self.LIFO then
        table.insert(elements, element)
    else
        table.insert(elements, 1, element)
    end

    if #elements > self.Limit then
        table.remove(elements, 1)
    end

    self.Elements = elements
end


function Deque:Add(...)
    local elements = {...}
    local internalElements = self.Elements
    local limit = self.Limit

    for _, element in ipairs(elements) do
        if #internalElements == limit then
            self:_AddElement(element)
        else
            table.insert(internalElements, element)
        end
    end
end


return Deque

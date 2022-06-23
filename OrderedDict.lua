local OrderedDict = {}
      OrderedDict.__index = OrderedDict


function OrderedDict.new(dict)
    dict = if dict ~= nil then dict else {}

    local self = {
        _Ordered = {}
    }

    setmetatable(self, OrderedDict)

    for k, v in pairs(dict) do
        self[k] = v
    end

    return self
end


function OrderedDict:__newindex(key, value)
    if value == nil then return end

    table.insert(self._Ordered, key)
    rawset(self, key, value)
end


-- bad but lazy
function OrderedDict:__tostring()
    return tostring(self._Ordered)
end


function OrderedDict:Keys()
    local index = 0

    return function()
        index += 1

        return self._Ordered[index]
    end
end


function OrderedDict:Values()
    local index = 0

    return function()
        index += 1
        local key = self._Ordered[index]

        return self[key]
    end
end


function OrderedDict:Entries()
    local index = 0

    return function()
        index += 1
        local key = self._Ordered[index]

        return key, self[key]
    end
end


function OrderedDict:Pop(key)
    if #self._Ordered > 0 then
        key = key or select(-1, table.unpack(self._Ordered))

        local value = self[key]
        self[key] = nil

        if value then
            table.remove(self._Ordered, #self._Ordered)

            return value
        end
    end

    return nil
end


function OrderedDict:Popitem(FIFO)
    FIFO = if FIFO ~= nil then FIFO else true

    local key;
    local index = 1

    if FIFO then
        key = self._Ordered[1]
    else
        index = #self._Ordered
        key = select(-1, table.unpack(self._Ordered))
    end

    local value = self[key]
    self[key] = nil

    table.remove(self._Ordered, index)

    return {key, value}
end


return OrderedDict

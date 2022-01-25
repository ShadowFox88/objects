local LazyLoader = {}
      LazyLoader.__index = LazyLoader


function LazyLoader.new()
    return setmetatable({Elements = {}}, LazyLoader)
end


function LazyLoader:__index(key)
    return self:Get(key)
end


function LazyLoader:Get(key)
    return self.Elements[key]
end


return LazyLoader

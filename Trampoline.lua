local Trampoline = {}


function Trampoline.new(parent, depth)
    depth = depth or 1
    local actualModule = {}

    for _, module in ipairs(parent:GetChildren()) do
        actualModule[module.Name] = require(module)

        if depth > 1 then
            for key, submodule in pairs(Trampoline.new(module, depth - 1)) do
                actualModule[key] = submodule
            end
        end
    end

    return actualModule
end


return Trampoline

local Trampoline = {}

function Trampoline.new(parent: Instance, depth: number)
	depth = depth or 1
	local actualModule = {}

	for _, module in parent:GetChildren() do
		actualModule[module.Name] = require(module)

		if depth > 1 then
			for key: string, submodule: {} in Trampoline.new(module, depth - 1) do
				actualModule[key] = submodule
			end
		end
	end

	return actualModule
end

return Trampoline

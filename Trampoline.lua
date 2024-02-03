local Trampoline = {}

function Trampoline.new(parent: Instance, depth: number?)
	local realDepth = depth or 1
	local actualModule = {}

	for _, module in parent:GetChildren() do
		if not module:IsA("ModuleScript") then
			continue
		end

		actualModule[module.Name] = require(module)

		if realDepth > 1 then
			for key: string, submodule: {} in Trampoline.new(module, realDepth - 1) do
				actualModule[key] = submodule
			end
		end
	end

	return actualModule
end

return Trampoline

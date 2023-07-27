--[=[
    @class Utilities

    A class that provides some helpful utilities used elsewhere in the project.
]=]
local Utilities = {}

--[=[
    A function that updates the given source table with the properties of the update table. One assumption being made here, is that updates are going be sent as tables.
    For example, if a character's unlocked upgrade nodes is updated, it's going to send the entire nodes table, instead of just the new value.
    
    @param Source { any } -- The source table that is going to have its data changed or updated.
    @param Update { any } -- The table containing any updates to the source table.
]=]
function Utilities.CompileUpdatedTable(Source: { any }, Update: { any })
	for key, value in pairs(Update) do
		if not Source[key] or not (type(value) == "table") then
			Source[key] = value
		else
			Utilities.CompileUpdatedTable(Source[key], Update[key])
		end
	end
end

return Utilities

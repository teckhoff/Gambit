local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TileLibrary = require(ReplicatedStorage.Shared.Libraries.TileLibrary)
--local Map = require(ReplicatedStorage.Shared.Objects.Map) :: any
--local MapNode = require(ReplicatedStorage.Shared.Objects.MapNode)

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
--[[
--[=[
	Generates a map of the given width and height.

	@param Width number -- The number of columns (the width) of the array.
	@param Height number -- The number of rows (the height) needed in the array.
	@return CustomTypes.Map -- The generated map.
]=]
function Utilities.CreateMap(Width: number, Height: number): MapNode.MapNode
	local NewMap = Map.new(Width, Height)

	for i = 1, Width, 1 do
		Map.Map[i] = {}
		for j = 1, Height, 1 do
			Map.Map[i][j] = MapNode.new(TileLibrary.Grass, i, j)
		end
	end

	return Map
end]]

return Utilities

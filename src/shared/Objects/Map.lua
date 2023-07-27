local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TileLibrary = require(ReplicatedStorage.Shared.Libraries.TileLibrary)
local MapNode = require(ReplicatedStorage.Shared.Objects.MapNode)

--[=[
	@class Map
]=]
local Map = {}
Map.__index = Map

--[=[
	@type MapBase { Width: number, Height: number, Map: { { MapNode } }, Instance: Model }
	@within Map

	The base type for the Map object.
]=]
type MapBase = {
	Width: number,
	Height: number,
	Map: { { MapNode.MapNode } },
	Instance: Model,
}

--[=[
	@type Map typeof(setmetatable({} :: MapDefault, Map))
	@within Map

	The type of an actual map object. There is currently no better way to typecheck classes, so this is what we're stuck with.
]=]
export type Map = typeof(setmetatable({} :: MapBase, Map))

function Map.new(Width: number, Height: number): Map
	local NewMap = {} :: MapBase
	setmetatable(NewMap, Map)

	NewMap.Width = Width
	NewMap.Height = Height
	NewMap.Map = {}
	NewMap.Instance = Instance.new("Model")
	NewMap.Instance.Name = "Map"

	for i = 1, Width, 1 do
		NewMap.Map[i] = {}
		for j = 1, Height, 1 do
			NewMap.Map[i][j] = MapNode.new(TileLibrary.Grass, i, j, NewMap.Instance)
		end
	end

	NewMap.Instance.Parent = workspace

	return NewMap
end

return Map

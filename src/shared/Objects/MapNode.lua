local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TileLibrary = require(ReplicatedStorage.Shared.Libraries.TileLibrary)

--[=[
	@class MapNode

	A map node represents an instance of a tile on the map. It keeps track of it's model, position, and it's neighbors.
]=]
local Node = {}
Node.__index = Node

--[=[
	@type MapNodeBase { Instance: model, PosX: number, PosY: number, Neighbors: { MapNode } }
	@within MapNode

	A type that represents the required data for a map node. Having to set it this way makes me really, very sad.
]=]
type MapNodeBase = {
	Instance: Model,
	PosX: number,
	PosY: number,
	Neighbors: { MapNode },
}

--[=[
	@type MapNode typeof(setmetatable({} :: MapNodeBase, Node))
	@within MapNode

	The type of the actual map object. :(
]=]
export type MapNode = typeof(setmetatable({} :: MapNodeBase, Node))

function Node.new(Tile: TileLibrary.Tile, PosX: number, PosY: number, ParentInstance: Model?): MapNode
	local NewNode = {} :: MapNodeBase
	setmetatable(NewNode, Node)

	NewNode.Instance = Tile.Model:Clone()
	NewNode.Instance:PivotTo(CFrame.new(6.1 * PosX, 0, 6.1 * PosY))

	if ParentInstance then
		NewNode.Instance.Parent = ParentInstance
	end

	NewNode.PosX = PosX
	NewNode.PosY = PosY
	NewNode.Neighbors = {}

	return NewNode
end

function Node:SetNeighbors(Neighbors: { MapNode })
	self.Neighbors = Neighbors
end

return Node

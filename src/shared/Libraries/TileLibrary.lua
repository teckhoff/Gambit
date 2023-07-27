local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tiles = ReplicatedStorage.Models.Tiles

--[=[
	@class TileLibrary

	A class containing tile definitions for the project.
]=]
local TileLibrary = {}

--[=[
	@type Tile { Model: Model }
	@within TileLibrary
]=]
export type Tile = {
	Model: Model,
}

TileLibrary.Grass = {
	Model = Tiles.Grass,
}

return TileLibrary

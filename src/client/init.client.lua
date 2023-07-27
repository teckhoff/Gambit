local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Loader = require(Packages:WaitForChild("Loader"))
local Map = require(ReplicatedStorage.Shared.Objects.Map)

Loader.SpawnAll(Loader.LoadDescendants(script, Loader.MatchesName("Controller$")), "Start")

Map.new(10, 10)

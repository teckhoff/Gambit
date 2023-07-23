local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Loader = require(Packages:WaitForChild("Loader"))

Loader.SpawnAll(Loader.LoadDescendants(script, Loader.MatchesName("Controller$")), "Start")

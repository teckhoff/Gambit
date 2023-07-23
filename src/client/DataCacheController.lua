local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Shared
local SharedPackages = ReplicatedStorage.Packages

local Utilities = require(SharedModules.Utilities)
local Net = require(SharedPackages.Net)

local CacheUpdateEvent = Instance.new("BindableEvent")
CacheUpdateEvent.Parent = script

--[=[
    @class DataCacheController

    The handler for caching player data on the client.
]=]
local DataCacheController = {
	DataCache = {},
}

--[=[
    Calls when the controller is started. Connects the remote event that sends data updates to the UpdateData function.
]=]
function DataCacheController:Start()
	Net:Connect("CacheData", DataCacheController.UpdateData)
end

--[=[
    Handles updating the cache with the data being received from the server.

    @param UpdatedData { any } -- A table containing all of the values that have been updated.
]=]
function DataCacheController.UpdateData(UpdatedData: { any })
	Utilities.CompileUpdatedTable(DataCacheController.DataCache, UpdatedData)
	CacheUpdateEvent:Fire()
end

--[=[
    Handles updating the cache with the data being received from the server.

    @param handler function -- The function to run when the cache is updated.
    @return RBXScriptConnection -- Returns the connection between the function and the event.
]=]
function DataCacheController:ConnectToCacheUpdate(handler: (...any) -> ()): RBXScriptConnection
	return CacheUpdateEvent.Event:Connect(handler)
end

return DataCacheController

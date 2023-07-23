local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local SharedPackages = ReplicatedStorage.Packages
local PrivatePackages = ServerScriptService.Packages

local Net = require(SharedPackages.Net)
local ProfileService = require(PrivatePackages.ProfileService)
local DataTemplates = require(script.DataTemplates)

-- Profiles are stored outside of the modulescript table, as it should not be changed except by this script.
local Profiles = {}
local ProfileStore = ProfileService.GetProfileStore("PlayerData", DataTemplates.PlayerProfile)

--[=[
    @class DataService

    A wrapper for ProfileService. Also provides functions to interface with the user's data.
]=]
local DataService = {}

--[=[
	A function to be called when the service is starting up. Creates the remote event that is going to send data to the client to cache.
	Also connects the player joining to the correct functions.
]=]
function DataService:Start()
	DataService.CacheDataRemote = Net:RemoteEvent("CacheData")

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(DataService.PlayerJoined(player))
	end

	Players.PlayerAdded:Connect(DataService.PlayerJoined)
end

--[=[
	Handles the ProfileService data loading, as well as sending over the first cache of the user's data.

	@param player Player -- The player that joined the game.
]=]
function DataService.PlayerJoined(player: Player)
	if player:GetAttribute("DataLoaded") then
		return
	end

	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile:ListenToRelease(function()
			Profiles[player] = nil
			player:Kick("Your data has been released.")
		end)

		if player:IsDescendantOf(Players) then
			Profiles[player] = profile
			player:SetAttribute("DataLoaded", true)
			DataService.CacheDataRemote:FireClient(player, profile.Data)
		else
			profile:Release()
		end
	else
		player:Kick("Your data could not be loaded. Please try again later.")
	end
end

--[=[
	Releases the player's profile when they leave the game.

	@param player Player -- The player that is leaving the game.
]=]
function DataService.PlayerLeft(player: Player)
	local profile = Profiles[player]
	if profile ~= nil then
		profile:Release()
	end
end

return DataService

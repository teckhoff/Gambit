--[=[
    @class DataTemplates
	
    A class holding any templates for default data in the datastore. 
]=]
local DataTemplates = {}

DataTemplates.PlayerProfile = {
	Level = 1,
	Experience = 0,
	Currencies = {
		Gold = 0,
	},
	Materials = {},
	Characters = {
		Dante = {
			Rarity = 4,
			Level = 1,
			Exp = 0,
			Attack = 100,
			AttackBoost = 0,
			Defense = 100,
			DefenseBoost = 0,
			HP = 100,
			HPBoost = 0,
			Nodes = {},
			Skills = {},
			Abilities = {},
			Skins = {},
			GetTime = 0,
		},
	},
	Crests = {},
	Parties = {},
	Milestones = {},
}

return DataTemplates

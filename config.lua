
Config = {}

Config.Debug = false

Config.Locations = {
    {
		id = "LavenderFieldsPublishing",
        coords = vector4(2861.607421875, -1395.837890625, 52.65999984741211, 61.15), -- GrandKorrigan
    },
	{
		id = "BoldBirdPrinting",
		coords = vector4(-340.4800109863281, -120.12000274658203, 50.40999984741211, 355.03), -- LimpanyHouse
    },
	{
		id = "Petite&BreedableRhodes",
		coords = vector4(1293.3, -1145.47, 82.16, 20.01), -- RhodesYellowCaravan
	}
}

Config.Jobs = {
	{
		job = "publisher",
		jobGrade = {
			{grade = 1, abilities = { "print", }},
			{grade = 2, abilities = { "create", "print", }},
		},
	},
}

Config.Crafting = {
	Locations = {
		{
			name = "St. Denis Publisher",
			id = "LavenderFieldsPublishing",
			Job = { "publisher" },
			x = 2863.663330078125,
			y = -1400.9664306640625,
			z = 52.61999893188476,
			Categories = { "items" },
			ShowOnlyLocationCraftables = true,
			Blip = {
				enable = true,
				Hash = 587827268
			},
		},
		{
			name = "Limpany Publisher",
			id = "BoldBirdPrinting",
			Job = { "publisher" },
			x = -336.9800109863281,
			y = -121.87999725341797,
			z = 50.36000061035156,
			Categories = { "items" },
			ShowOnlyLocationCraftables = true,
			Blip = {
				enable = true,
				Hash = 587827268
			},
		},
		{
			name = "Rhodes Publisher",
			id = "Petite&BreedableRhodes",
			Job = { "publisher" },
			x = 1292.71,
			y = -1149.54,
			z = 81.8,
			Categories = { "items" },
			ShowOnlyLocationCraftables = true,
			Blip = {
				enable = true,
				Hash = 587827268
			},
		},
	},
	Recipes = {
		{
			UID = "Paper",
			Text = "Paper",
			SubText = "InvMax = 50",
			Desc = "Recipe: 2x Pulp, 1x Water",
			Items = {
				{
					name = "pulp",
					count = 2
				},
				{
					name = "water",
					count = 1
				}
			},
			Reward = {
				{
					name = "paper",
					count = 2
				}
			},
			Type = "item",
			JobList = 0, 
			Location = { "LavenderFieldsPublishing", "BoldBirdPrinting", "Petite&BreedableRhodes" },
			UseCurrencyMode = false,
			CurrencyType = 0, 
			Category = "items",
			Animation = "craft",
		},
		{
			UID = "Ink-7VSZ",
			Text = "Ink",
			SubText = "InvMax = 50",
			Desc = "Recipe: 2x Coal, 1x Vodka",
			Items = {
				{
					name = "coal",
					count = 2
				},
				{
					name = "vodka",
					count = 1
				}
			},
			Reward = {
				{
					name = "ink",
					count = 5
				}
			},
			Type = "item",
			JobList = 0, 
			Location = { "LavenderFieldsPublishing", "BoldBirdPrinting", "Petite&BreedableRhodes" },
			UseCurrencyMode = false,
			CurrencyType = 0, 
			Category = "items",
			Animation = "craft",
		},
		{
			UID = "Ink-3ZD3",
			Text = "Ink",
			SubText = "InvMax = 50",
			Desc = "Recipe: 2x Coal, 1x Moonshine",
			Items = {
				{
					name = "coal",
					count = 2
				},
				{
					name = "moonshine",
					count = 1
				}
			},
			Reward = {
				{
					name = "ink",
					count = 5
				}
			},
			Type = "item",
			JobList = 0, 
			Location = { "LavenderFieldsPublishing", "BoldBirdPrinting", "Petite&BreedableRhodes" },
			UseCurrencyMode = false,
			CurrencyType = 0, 
			Category = "items",
			Animation = "craft",
		},
		{
			UID = "Ink-GM3B",
			Text = "Ink",
			SubText = "InvMax = 50",
			Desc = "Recipe: 2x Coal, 1x Pig Fat",
			Items = {
				{
					name = "coal",
					count = 2
				},
				{
					name = "porkfat",
					count = 1
				}
			},
			Reward = {
				{
					name = "ink",
					count = 5
				}
			},
			Type = "item",
			JobList = 0, 
			Location = { "LavenderFieldsPublishing", "BoldBirdPrinting", "Petite&BreedableRhodes" },
			UseCurrencyMode = false,
			CurrencyType = 0, 
			Category = "items",
			Animation = "craft",
		},
	}
}

Config.PrintingRequirements = {
	["book"] = {
		Label = "Book",
		RecipeText = "Recipe: 1x Small Leather, 2x Paper, 2x Ink",
		Items = {
			{
				name = "Small_Leather",
				count = 1
			},
			{
				name = "paper",
				count = 2
			},
			{
				name = "ink",
				count = 2
			},
		},
		MaxPages = 20,
	},
	["newspaper"] = {
		Label = "Newspaper",
		RecipeText = "Recipe: 2x Paper, 2x Ink",
		Items = {
			{
				name = "paper",
				count = 2
			},
			{
				name = "ink",
				count = 2
			},
		},
		MaxPages = 12,
	},
	["card"] = {
		Label = "Card",
		RecipeText = "Recipe: 1x Paper, 1x Ink",
		Items = {
			{
				name = "paper",
				count = 1
			},
			{
				name = "ink",
				count = 1
			},
		},
		MaxPages = 1,
	},
}

-- item images: `book`, `newspaper`, `paper` (biz card), `folder_recipe_pamphlets` (2 recipe slips), 


Config.Webhook = "https://discord.com/api/webhooks/..."
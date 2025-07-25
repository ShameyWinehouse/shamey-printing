VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
	print = VORPutils.Print:initialize(print)
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()



-- Register the crafting
Citizen.CreateThread(function()

    for _, location in pairs(Config.Crafting.Locations) do
        TriggerEvent("vorp:AddCraftLocation", location)
    end

    for _, recipe in pairs(Config.Crafting.Recipes) do
        TriggerEvent("vorp:AddRecipes", recipe)
    end

end)





RegisterServerEvent("rainbow_printing:GetExistingPrintables", function(locationId)
	local _source = source

    if Config.Debug then print("rainbow_printing:GetExistingPrintables", locationId) end

    local results = MySQL.query.await('SELECT p.*,CONCAT(c.firstname, " ", c.lastname) AS publisherFullName FROM `printables` p JOIN characters c ON c.charidentifier=p.publisher WHERE p.press_id = ?', {
        locationId
    })

    
    if results and results[1] then

        if Config.Debug then print("rainbow_printing:GetExistingPrintables - results", results) end

        local existingPrintables = {}
        for k,result in pairs(results) do
            local existingPrintable = Printable:New({
                id = result.id,
                type = result.type,
                pressId = locationId,
                title = result.title,
                description = result.description,
                countPrinted = result.count_printed,
                dateCreated = result.date_created,
                publisher = result.publisherFullName,
            })
            table.insert(existingPrintables, existingPrintable)
        end

        TriggerClientEvent("rainbow_printing:ReturnGetExistingPrintables", _source, existingPrintables, locationId)
    end



end)


RegisterServerEvent("rainbow_printing:Print", function(printableId, copies, locationId)
	local _source = source

    if Config.Debug then print("rainbow_printing:Print", printableId, copies, locationId) end

    -- Get the printable from the DB
    local printableDbRecord = fetchPrintableFromDbById(printableId)

    if not printableDbRecord or not printableDbRecord.type then
        print("ERROR: Couldn't retrieve printable with id: "..printableId)
        return
    end

    local typePrintable = printableDbRecord.type


    -- Check that they can carry another of this item
    local canCarry = VorpInv.canCarryItem(_source, typePrintable, copies)
    if not canCarry then
        VORPcore.NotifyRightTip(_source, "You can't carry this number of copies.", 10 * 1000)
        return
    end


    -- Get the recipe for this printable type
    local recipe = Config.PrintingRequirements[typePrintable]

    -- Check that they have the needed items
    local hasAllItemsNeededAndTheirQuantities = true
    for k,recipeItem in pairs(recipe.Items) do
        local amountInPockets = VorpInv.getItemCount(_source, recipeItem.name)
        if amountInPockets < (recipeItem.count * copies) then
            hasAllItemsNeededAndTheirQuantities = false
            break
        end
    end

    if not hasAllItemsNeededAndTheirQuantities then
        VORPcore.NotifyRightTip(_source, "You don't have all the needed materials to print these copies.", 10 * 1000)
        return
    end


    -- Collect (sub) the items
    for k,recipeItem in pairs(recipe.Items) do
        VorpInv.subItem(_source, recipeItem.name, (recipeItem.count * copies))
    end
    VORPcore.NotifyRightTip(_source, "Materials have been used to print.", 10 * 1000)


    -- Create the special metadata for the item
    local itemDescription = generateItemDescriptionFromPrintable(printableDbRecord)

    if Config.Debug then print("rainbow_printing:Print - dbMetadataTable", dbMetadataTable) end
    local metadata = {
        itemTitleOverride = printableDbRecord.title,
        description = printableDbRecord.description,
        printableId = printableDbRecord.id,
    }
    if Config.Debug then print("rainbow_printing:Print - metadata", metadata) end


    -- Add the final item to their inventory
    VorpInv.addItem(_source, typePrintable, copies, json.encode(metadata), nil)


    -- Log to Discord
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local charFullName = string.format("%s %s", Character.firstname, Character.lastname)
    VORPcore.AddWebhook("Printable Printed", Config.Webhook, string.format(
        "**Character:** %s (CharId %s) \n**Title:** %s \n**Description:** %s \n**Printable ID:** %s \n**Type:** %s \n**Location:** %s \n**Copies:** %s", 
        charFullName, Character.charIdentifier, printableDbRecord.title, printableDbRecord.description, printableDbRecord.id, typePrintable, locationId, copies))

    MySQL.single.await('UPDATE `printables` SET `count_printed` = `count_printed` + 1 WHERE `id` = ?', {
        printableId
    })
end)

function fetchPrintableFromDbById(printableId)
    local row = MySQL.single.await('SELECT * FROM `printables` WHERE `id` = ? LIMIT 1', {
        printableId
    })
    if not row then return false end
    return row
end

function generateItemDescriptionFromPrintable(printableDbRecord)
    return string.format("%s", printableDbRecord.description)
end

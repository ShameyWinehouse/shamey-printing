


RegisterServerEvent("rainbow_printing:Publish", function(printableType, title, description, arrangement, pages, locationId)
	local _source = source

    if Config.Debug then print("rainbow_printing:Publish", printableType, title, description, arrangement, pages, locationId) end


    -- Sanitize the title & description
    title = sanitizeTitle(title)
    description = sanitizeDescription(description)


    -- Create the printable record in the `printables` table
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local printablesId = MySQL.insert.await('INSERT INTO `printables` (`type`, `press_id`, `title`, `description`, `publisher`, `data`) VALUES(?, ?, ?, ?, ?, ?)', {
        printableType,
        locationId,
        title, 
        description,
        Character.charIdentifier,
        json.encode({
            ["arrangement"] = arrangement,
            ["pages"] = pages,
        })
    })


    -- Notify the user
    VORPcore.NotifyRightTip(_source, "The plates for the new printable have been successfully created. You can now print it.", 10 * 1000)


    -- Log to Discord
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local charFullName = string.format("%s %s", Character.firstname, Character.lastname)
    VORPcore.AddWebhook("Printable Created", Config.Webhook, string.format(
        "**Character:** %s (CharId %s) \n**Title:** %s \n**Description:** %s \n**Type:** %s \n**Location:** %s", 
        charFullName, Character.charIdentifier, title, description, printableType, locationId))
    

    if Config.Debug then print("rainbow_printing:Publish - DONE!") end

end)

function sanitizeTitle(title)
    local sanitized = title:gsub("[^a-zA-Z ]", "") -- Remove non-alphabetical
    return sanitized
end

function sanitizeDescription(description)
    local sanitized = description:gsub("[^a-zA-Z ]", "") -- Remove non-alphabetical
    return sanitized
end
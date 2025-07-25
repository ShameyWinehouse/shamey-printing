UI = {}

function OpenCreate(locationId)

    SendNUIMessage({
        type = "view",
        screen = "create",
        config = Config,
        locationId = locationId,
    })
    SetNuiFocus(true, true)
    isOpen = true

end

function UI:OpenPrintExisting(existingPrintables, locationId)

    SendNUIMessage({
        type = "view",
        screen = "printExisting",
        existingPrintables = existingPrintables,
        config = Config,
        locationId = locationId,
    })
    SetNuiFocus(true, true)
    isOpen = true

end


RegisterNUICallback("closeAll", function(args, cb)
	if Config.Debug then print("closeAll") end
	
    closeAll()

	cb("ok")
end)


RegisterNUICallback("publish", function(args, cb)
	if Config.Debug then print("publish", args) end
	
    TriggerServerEvent("rainbow_printing:Publish", args.type, args.title, args.description, args.arrangement, args.pages, args.locationId)

    closeAll()

	cb("ok")
end)

RegisterNUICallback("print", function(args, cb)
	if Config.Debug then print("print", args) end


    closeAll()


    -- Get how many copies they want
    local myInput = {
        type = "enableinput", -- dont touch
        inputType = "input", -- or text area for sending messages
        button = "confirm", -- button name
        placeholder = "1", --placeholdername
        style = "block", --- dont touch
        attributes = {
            inputHeader = "Number of copies", -- header
            type = "number", -- inputype text, number,date.etc if number comment out the pattern
            pattern = "[0-9]{1,2}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
            title = "Must be only numbers and not too big.", -- if input doesnt match show this message
            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
        }
    }
    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
        local quantity = tonumber(result)
        if quantity ~= "" and quantity ~= 0 and quantity > 0 then
            TriggerServerEvent("rainbow_printing:Print", args.printableId, quantity, args.locationId)
        end
    end)


	cb("ok")
end)

function closeAll()
    SendNUIMessage({
        type = "close",
    })
    SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
    isOpen = false
end
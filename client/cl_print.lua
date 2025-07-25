


function OpenPrintExisting(locationId)

    if Config.Debug then print("OpenPrintExisting", locationId) end

    -- Get the existing printables
    TriggerServerEvent("rainbow_printing:GetExistingPrintables", locationId)

end


RegisterNetEvent("rainbow_printing:ReturnGetExistingPrintables")
AddEventHandler("rainbow_printing:ReturnGetExistingPrintables", function(_existingPrintables, locationId)
    if Config.Debug then print("ReturnGetExistingPrintables", _existingPrintables, locationId) end

    if _existingPrintables then
        UI:OpenPrintExisting(_existingPrintables, locationId)
    end
end)
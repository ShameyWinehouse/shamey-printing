

Citizen.CreateThread(function()
	local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	local CreatePrompt = PromptGroup:RegisterPrompt("Create New Readable", 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
    local PrintPrompt = PromptGroup:RegisterPrompt("Print Existing", 0xE30CD707, 1, 1, true, 'hold', {timedeventhash = "SHORT_TIMED_EVENT"}) --Register your first prompt


    while true do

        local sleep = 1000

        if jo.meCoords then

            if hasStaffJob() then

                -- if Config.Debug then print("hasjob") end

                for k,v in pairs(Config.Locations) do

                    if #(jo.meCoords - vector3(v.coords.x, v.coords.y, v.coords.z)) < 2.0 and not isOpen then

                        -- if Config.Debug then print("close") end

                        sleep = 0

                        -- Allow creating new
                        if hasAbility("create") then
                            CreatePrompt:TogglePrompt(true)
                        else
                            CreatePrompt:TogglePrompt(false)
                        end

                        -- Show the prompt group
                        PromptGroup:ShowGroup("Printing Press")
                        
                        if CreatePrompt:HasCompleted() then
                            OpenCreate(v.id)
                        end
                        if PrintPrompt:HasCompleted() then
                            OpenPrintExisting(v.id)
                        end
                    end

                end

            end

        end

        

        Citizen.Wait(sleep)
    end
end)
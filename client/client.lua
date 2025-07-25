VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
	print = VORPutils.Print:initialize(print)
end)
RainbowCore = exports["rainbow-core"]:initiate()

isOpen = false



-------- FUNCTIONS
function hasStaffJob()
    return RainbowCore.AbsolutelyHasJobInJoblistClient(getJobList())
end

-- Check if the player has the ability based on their job grade
function hasAbility(ability)
    for k,v in pairs(Config.Jobs) do
        for k2,v2 in pairs(v.jobGrade) do
			
			local hasJobAndGrade = RainbowCore.AbsolutelyHasJobAndGradeClient(v.job, v2.grade)

            if hasJobAndGrade then
                for k3,v3 in pairs(v2.abilities) do
                    -- if Config.Debug then print("v3", v3) end
                    if v3 == ability then
                        -- if Config.Debug then print("has ability: ", ability) end
                        return true
                    end
                end
            end
        end
    end
    -- if Config.Debug then print("doesn't have ability: ", ability) end
    return false
end

function getJobList()
	local jobList = {}
	for k,v in pairs(Config.Jobs) do
		jobList[#jobList+1] = v.job
	end
	return jobList
end









--- FILE UPLOAD

-- Citizen.CreateThread(function()
--     Wait(2000)
--     SetNuiFocus(true, true)
--     SetNuiFocusKeepInput(true)
-- end)


-- RegisterNUICallback("upload", function(args, cb)
-- 	print("upload", args)
--     -- sendFileToCloudStorage(args.uploadedFile)
--     TriggerLatentServerEvent("rainbow_printing:Upload", 500000, args.uploadedFile, args.jwt)
-- 	cb('ok')
-- end)




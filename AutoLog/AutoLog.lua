local GetInstanceInfo, LoggingCombat = GetInstanceInfo, LoggingCombat
local GetCVar, SetCVar = C_CVar.GetCVar, C_CVar.SetCVar
local expirationTime

local function autoLog()
	-- Force enable advance combat logs
	local cvar = GetCVar("advancedCombatLogging")
	if cvar ~= 1 then
		SetCVar("advancedCombatLogging", 1)
	end
	
	-- Enable combat logs
	local _, instanceType, difficultyID = GetInstanceInfo()
	local loggingStatus = LoggingCombat()
	if (instanceType == "raid" or difficultyID == 8 or difficultyID == 23) then
		if loggingStatus == false then
			LoggingCombat(true)
			print("|cff00FF00"..COMBATLOGENABLED.."|r")
		end
	else
		if loggingStatus == true then
			LoggingCombat(false)
			print("|cffFF0000"..COMBATLOGDISABLED.."|r")
		end
	end
end

local AL = CreateFrame("Frame")
	AL:RegisterEvent("PLAYER_ENTERING_WORLD")
	AL:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	AL:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	AL:RegisterEvent("CHALLENGE_MODE_START")
	AL:SetScript("OnEvent", function()
		if GetTime() - (expirationTime or 0) > 0 then
			local loggingStatus = LoggingCombat()
			if loggingStatus == nil then
				expirationTime = GetTime() + 2
				C_Timer.After(10, autoLog)
			else
				autoLog()
			end
		end
	end)
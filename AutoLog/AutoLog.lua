local IsInInstance, GetInstanceInfo, GetBuildInfo = IsInInstance, GetInstanceInfo, GetBuildInfo
local ILoggingCombat = LoggingCombat
local GetCVar, SetCVar = GetCVar, SetCVar
local cvar = GetCVar("advancedCombatLogging")

local function autoLog()
	local instanceType = select(2, IsInInstance())
	local difficulty = select(3, GetInstanceInfo())

	-- Force enable advance combat logs
	if cvar ~= 1 then
		SetCVar("advancedCombatLogging", 1)
	end
	
	if instanceType == "raid" or difficulty == 8 then
		if not LoggingCombat() then
			LoggingCombat(true)
			print("|cff00FF00"..COMBATLOGENABLED.."|r")
		end
	else
		if LoggingCombat() then
			LoggingCombat(false)
			print("|cffFF0000"..COMBATLOGDISABLED.."|r")
		end
	end
end

local AL = CreateFrame("Frame")
	AL:RegisterEvent("PLAYER_ENTERING_WORLD")
	AL:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	AL:RegisterEvent("CHALLENGE_MODE_START")
	AL:SetScript("OnEvent", autoLog)

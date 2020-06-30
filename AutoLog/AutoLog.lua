local IsInInstance, GetInstanceInfo, LoggingCombat = IsInInstance, GetInstanceInfo, LoggingCombat
local COMBATLOGENABLED, COMBATLOGDISABLE = COMBATLOGENABLED, COMBATLOGDISABLE

local function autoLog()
	local instanceType = select(2, IsInInstance())
	local difficulty = select(3, GetInstanceInfo())
	
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

local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	frame:RegisterEvent("CHALLENGE_MODE_START")
	frame:SetScript("OnEvent", autoLog)
local require = GLOBAL.require
local G = GLOBAL

if GetModConfigData("devmode") then
	GLOBAL.CHEATS_ENABLED = true
	GLOBAL.require( 'debugkeys' )
end

-- Import constants and data.

modimport "main/assets"
modimport "main/recipes"
modimport "main/strings"
GLOBAL.KLEIGROUND_CONFIG = {
	-- Some of these may be treated as client-side, as indicated by the bool
	locale = GetModConfigData("locale", true),
}

-- This is for rezecib's status announcements mod.
--We should probably move it to a better place. Why is he not using the characters speech table, anyways? >.<  -M
if not GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS then GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS = {} end
GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS.WOBERT = {
	HUNGER = {
		FULL  = "I'll skip a couple meals.", -- >75%
		HIGH  = "Don't worry about me.", -- >55%
		MID   = "Maybe a little jerky to hold me over?", -- >35%
		LOW   = "It's starting to hurt...", -- >15%
		EMPTY = "No... energy...", -- <15%
	},
	SANITY = {
		FULL  = "I'm fine.", -- >75%
		HIGH  = "Probably just a little drunk.", -- >55%
		MID   = "Did you hear that voice?", -- >35%
		LOW   = "Good god!", -- >15%
		EMPTY = "Eva?! Is that you?! Don't run!", -- <15%
	},
	HEALTH = {
		FULL  = "Nice and strong.", -- >75%
		HIGH  = "I got a little banged up.", -- >55%
		MID   = "Might've broke a bone.", -- >35%
		LOW   = "Actually, I might need attention...", -- >15%
		EMPTY = "This is the end...", -- <15%
	},
	WETNESS = {
		FULL  = "This is ridiculous.", -- >75%
		HIGH  = "My hand wraps are falling off.", -- >55%
		MID   = "Now it's a bit uncomfortable.", -- >35%
		LOW   = "Maybe it'll wash out my bandanna.", -- >15%
		EMPTY = "Not a single bead of water.", -- <15%
	},
}


-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, PLURAL, and APACHE_ATTACK_HELICOPTER.
AddModCharacter("wobert", "MALE")
AddModCharacter("waria", "FEMALE")

--Make his arms do the pokey thing
ExcludeClothingSymbolForModCharacter("wobert", "arm_upper" )
ExcludeClothingSymbolForModCharacter("wobert", "arm_upper_skin" )
ExcludeClothingSymbolForModCharacter("wobert", "arm_lower" )

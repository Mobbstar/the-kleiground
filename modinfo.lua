name = "The Kleiground"
author = "Not Wilson, Rhodey"

version = "0.0.1"
version_title = "Secret Early Version"

-- Mod Description
description = "This mod is a tribute to all Klei Entertainment games!\n\nShould you encounter a problem, please tell us everything about the problem so we can repair things!"

description = description .. "\n\nVersion: " .. version .. "\n\"" .. version_title .. "\""

-- In-game link to a thread or file download on the Klei Entertainment Forums
forumthread = "/topic/95080-island-adventures-the-shipwrecked-port/" --Used a sample link for the time being. -M


folder_name = folder_name or "workshop-"
if not folder_name:find("workshop-") then
	name = " " .. name .. " - GitHub Ver."
	description = description .. "\n\nRemember to manually update! The version number does NOT increase with every github update."
end


-- Don't Starve API version
-- Note: We set this to 10 so that it's incompatible with single player.
api_version = 10
api_version_dst = 10

-- Engine/DLC Compatibility
-- Don't Starve (Vanilla, no DLCs)
dont_starve_compatible = false
-- Don't Starve: Reign of Giants
reign_of_giants_compatible = false
-- Don't Starve: Shipwrecked
shipwrecked_compatible = false
-- Don't Starve Together
dst_compatible = true

-- Client-only mods don't affect other players or the server.
client_only_mod = false
-- Mods which add new objects are required by all clients.
all_clients_require_mod = true 

-- Forces user to reboot game upon enabling the mod
restart_required = false

-- Priority of which our mod will be loaded
-- Below 0 means other mods will override our mod by default.
-- Above 0 means our mod will override other mods by default.
--priority = 0

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
	"character",
    "invisible inc",
}

menu_assets = {
	characters = {
		wobert = { gender = "MALE", nopuppet = false }
	},
}


local emptyoptions = {{description="", data=false}}
local function Breaker(title, hover)
	return {
		name=title,
		hover=hover, --hover does not work
		options=emptyoptions,
		default=false,
	}
end

local options_enable = {
	{description = "Disabled", data = false},
	{description = "Enabled", data = true},
}
configuration_options =
{
	Breaker("Tweaks & Changes", "Enable these to permit several small changes to how the game works."),
	--Empty as of yet
	Breaker("Misc."),
    {
        name = "locale",
        label = "Force Translation",
        hover = "Select a translation to enable it regardless of language packs. Warning: As of now, this is set by the server host.",
        options = 
		{
			{description = "None", data = false},
			-- {description = "Deutsch", data = "de"},
			-- {description = "Español", data = "es"},
			-- {description = "Français", data = "fr"},
			-- {description = "Italiano", data = "it"},
			-- {description = "한국어", data = "ko"},
			-- {description = "Polski", data = "pl"},
			-- {description = "Português", data = "pt"},
			-- {description = "Русский", data = "ru"},
			-- {description = "中文 (simplified)", data = "sc"},
			-- {description = "中文 (traditional)", data = "tc"},
		},
        default = false,
    },
	{
		name = "devmode",
		label   = "Dev Mode",
        hover	= "Enable this to turn your keyboard into a minefield of crazy debug hotkeys. (Only use if you know what you are doing!)",
		options = options_enable,
		default = false,
	},
	-- {
		-- name = "codename",
		-- label   = "Fancy Name",
        -- hover	= "This sentence explains the option in greater detail.",
		-- options =
		-- {
			-- {description = "Disabled", data = false},
			-- {description = "Enabled", data = true},
		-- },
		-- default = false,
	-- },
}
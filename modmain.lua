local G = GLOBAL
PrefabFiles = {
	"wobert",
	"wobert_none",
	"flintshank",
	"rockshank",
	"throwingknifeflint",
	"shankskull",
	"cesarshank",
	"cesarshank_classified",
	"molotov",
	"healthbottle",
	"waria",
	"waria_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/wobert.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wobert.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/wobert.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wobert.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/wobert_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wobert_silho.xml" ),

    Asset( "IMAGE", "bigportraits/wobert.tex" ),
    Asset( "ATLAS", "bigportraits/wobert.xml" ),
	
	Asset( "IMAGE", "images/map_icons/wobert.tex" ),
	Asset( "ATLAS", "images/map_icons/wobert.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_wobert.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_wobert.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_wobert.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_wobert.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_wobert.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_wobert.xml" ),
	
	Asset( "IMAGE", "images/names_wobert.tex" ),
    Asset( "ATLAS", "images/names_wobert.xml" ),
	
    Asset( "IMAGE", "bigportraits/wobert_none.tex" ),
    Asset( "ATLAS", "bigportraits/wobert_none.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/flintshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/flintshank.xml" ),

	Asset( "IMAGE", "images/inventoryimages/rockshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/rockshank.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/throwingknifeflint.tex" ),
    Asset( "ATLAS", "images/inventoryimages/throwingknifeflint.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/molotov.tex" ),
    Asset( "ATLAS", "images/inventoryimages/molotov.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/shankskull.tex" ),
    Asset( "ATLAS", "images/inventoryimages/shankskull.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/cesarshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/cesarshank.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/healthbottle.tex" ),
    Asset( "ATLAS", "images/inventoryimages/healthbottle.xml" ),
	
	Asset("ATLAS", "images/shanktab.xml"),
    Asset("IMAGE", "images/shanktab.tex"),
	
	Asset("SOUNDPACKAGE", "sound/molotov.fev"),
    Asset("SOUND", "sound/molotov.fsb"),

	Asset("SOUNDPACKAGE", "sound/healthbottle.fev"),
    Asset("SOUND", "sound/healthbottle.fsb"),
	
	Asset( "IMAGE", "images/saveslot_portraits/waria.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/waria.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/waria.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/waria.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/waria_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/waria_silho.xml" ),

    Asset( "IMAGE", "bigportraits/waria.tex" ),
    Asset( "ATLAS", "bigportraits/waria.xml" ),
	
	Asset( "IMAGE", "images/map_icons/waria.tex" ),
	Asset( "ATLAS", "images/map_icons/waria.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_waria.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_waria.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_waria.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_waria.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_waria.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_waria.xml" ),
	
	Asset( "IMAGE", "images/names_waria.tex" ),
    Asset( "ATLAS", "images/names_waria.xml" ),
	
    Asset( "IMAGE", "bigportraits/waria_none.tex" ),
    Asset( "ATLAS", "bigportraits/waria_none.xml" ),
	
	Asset("SOUNDPACKAGE", "sound/waria.fev"),
    Asset("SOUND", "sound/waria.fsb"),

}

RemapSoundEvent( "dontstarve/characters/waria/death_voice", "waria/sound/death_voice" )
RemapSoundEvent( "dontstarve/characters/waria/hurt", "waria/sound/hurt" )
RemapSoundEvent( "dontstarve/characters/waria/talk_LP", "waria/sound/talk_LP" )
RemapSoundEvent( "dontstarve/characters/waria/ghost_LP", "waria/sound/ghost_LP" )
RemapSoundEvent( "dontstarve/characters/waria/emote", "waria/sound/emote" )
RemapSoundEvent( "dontstarve/characters/waria/pose", "waria/sound/pose" )
RemapSoundEvent( "dontstarve/characters/waria/yawn", "waria/sound/yawn" )

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS




-- The character select screen lines
STRINGS.CHARACTER_TITLES.wobert = "The Forever Fighter"
STRINGS.CHARACTER_NAMES.wobert = "Robert \"Shank\" Torres"
STRINGS.CHARACTER_DESCRIPTIONS.wobert = "*Stoic Mercenary\n*Cynophobic\n*Comes with his own weapon"
STRINGS.CHARACTER_QUOTES.wobert = "\"I don't do causes.\""
STRINGS.CHARACTER_TITLES.waria = "The Freedom Fighter"
STRINGS.CHARACTER_NAMES.waria = "Maria Internationale Valdez"
STRINGS.CHARACTER_DESCRIPTIONS.waria = "*perk1\n*perk2\n*perk3"
STRINGS.CHARACTER_QUOTES.waria = "\"Quote\""

-- Custom speech strings
STRINGS.CHARACTERS.WOBERT = require "speech_wobert"
STRINGS.CHARACTERS.WARIA = require "speech_waria"

--Custom recipes
	local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT
	local AllRecipes = GLOBAL.AllRecipes
	local Ingredient = GLOBAL.Ingredient
	local RECIPETABS = GLOBAL.RECIPETABS
	local TECH = GLOBAL.TECH
	local STRINGS = GLOBAL.STRINGS
	local shank_tab = AddRecipeTab("Weapons", 1, "images/shanktab.xml", "shanktab.tex", "shank")

	--MOD IMPORTS
modimport("scripts/announcestrings.lua")
modimport("scripts/NPC_stringskg.lua")
	
--SHANK SPECIFIC RECIPES--
	
	AddRecipe("flintshank", 
{
Ingredient("flint", 2)
},
shank_tab, 
TECH.NONE, 
nil, 
nil, 
nil, 
4,
"shank",
"images/inventoryimages/flintshank.xml", 
"flintshank.tex")
AddRecipe("throwingknifeflint", 
{
Ingredient("flint", 1)
},
shank_tab,
TECH.NONE, 
nil, 
nil, 
nil, 
3,
"shank",
"images/inventoryimages/throwingknifeflint.xml", 
"throwingknifeflint.tex")
AddRecipe("cesarshank", --Update once this weapon is working.
{Ingredient("minotaurhorn", 1),
Ingredient("nightmarefuel", 7),
Ingredient("goldnugget", 10)},
shank_tab, 
TECH.MAGIC_THREE, 
nil, 
nil, 
nil, 
nil,
"shank",
"images/inventoryimages/cesarshank.xml", 
"cesarshank.tex")

AddRecipe("molotov", 
{Ingredient("glommerfuel", 2),
Ingredient("nitre", 5),
Ingredient("gunpowder", 2)},
shank_tab, 
TECH.SCIENCE_TWO, 
nil, 
nil, 
nil, 
nil, 
"shank", 
"images/inventoryimages/molotov.xml", 
"molotov.tex")

AddRecipe("healthbottle", 
{Ingredient("honey", 3),
Ingredient("ice", 2),
Ingredient("spoiled_food", 1)},
shank_tab, 
TECH.SCIENCE_ONE, 
nil, 
nil, 
nil, 
nil, 
"shank", 
"images/inventoryimages/healthbottle.xml", 
"healthbottle.tex")

    GLOBAL.STRINGS.NAMES.FLINTSHANK = "Flint Shank"
    STRINGS.RECIPE_DESC.FLINTSHANK = "Bang some rocks together!"
	
    GLOBAL.STRINGS.NAMES.ROCKSHANK = "Candy Cane Shank"
    STRINGS.RECIPE_DESC.ROCKSHANK = "What a way to celebrate the holidays!"
	
    GLOBAL.STRINGS.NAMES.THROWINGKNIFEFLINT = "Flint Shard"
    STRINGS.RECIPE_DESC.THROWINGKNIFEFLINT = "Don't expect it to hurt."

	GLOBAL.STRINGS.NAMES.CESARSHANK = "Haunted Knife"
    STRINGS.RECIPE_DESC.CESARSHANK = "The cycle endlessly repeats."
	
	GLOBAL.STRINGS.NAMES.MOLOTOV = "Molotov"
    STRINGS.RECIPE_DESC.MOLOTOV = "Kill it with fire!"
	
	GLOBAL.STRINGS.NAMES.HEALTHBOTTLE = "Applejack"
    STRINGS.RECIPE_DESC.HEALTHBOTTLE = "Drink to feel better."
	
	GLOBAL.STRINGS.NAMES.SHANKSKULL = "Shank's Skull"
	
-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WOBERT = 
{
	GENERIC = "Hello, Shank!",
	ATTACKER = "Shank looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Shank, friend of ghosts.",
	GHOST = "Shank could use a heart.",
}

	
-- The character's name as appears in-game 
STRINGS.NAMES.WOBERT = "Shank"
STRINGS.NAMES.WARIA = "Maria"

AddMinimapAtlas("images/map_icons/wobert.xml")
AddMinimapAtlas("images/map_icons/waria.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("wobert", "MALE")
AddModCharacter("waria", "FEMALE")

--Make his arms do the pokey thing
ExcludeClothingSymbolForModCharacter("wobert", "arm_upper" )
ExcludeClothingSymbolForModCharacter("wobert", "arm_upper_skin" )
ExcludeClothingSymbolForModCharacter("wobert", "arm_lower" )


--IT IS GOING IN MOD MAIN. I NO LONGER CARE. I DON'T GIVE A DAMN ABOUT HOW BIG THIS GETS.
STRINGS.HOUNDNAMES=
{
--Canon Shank names
	"Atlas",
	"Thrasher",
	"Dover",
	"Tank",
	"Maxwell",
	"Diablo",
	"Calvin",
	"Nate",
	"Dre",
}


--CESAR'S LINES--
--Add more later?
G.STRINGS.EQUIPPED =
    {
        "You've come back after all these years.",
        "It's a shame you never truly were loyal.",
        "What's your plan? Do you plan to kill everyone here too?",
        "After pulling you from the dirt, you did this.",
		"I wonder what you'll be doing to Angelo and The Butcher next...",
		"Your final choice was to never know peace.",
		"Something tells me you're going to kill yourself saving everyone here.",
		"You always did care too much, Shank.",
		"\"Here lies Robert Torres. Killed many to save a few.\"",
		"I tried to teach you. I did.",
    }

 GLOBAL.STRINGS.ON_GROUND =
    {
        "You'll be back. Even if I have to wait 7 years.",
        "I can wait.",
        "I will always find you.",
		"If you think I can't predict you, you're wrong.",
    }
	
 GLOBAL.STRINGS.ON_HAUNT = 
    {
    	"Stop that.", 
    	"And WHO are you?", 
    	"That was rather rude.",
    	"There's other things you can haunt.",
    	"There's only room for one ghost.",
	}

   GLOBAL.STRINGS.IN_CONTAINER =
    {
        "You locked me away. Do you think that solves it?",
        "You're stuck here, regardless.",
        "Get me out of here, Shank. I know you can hear me.",
        "Is this a metaphor, Shank?",
        "It's as dark in here as your future will be.",
        "I can't believe you think this is the answer, Robert.",
    }

    GLOBAL.STRINGS.OTHER_OWNER =
    {
        "This burden is not yours to carry.",
        "You aren't Shank.",
        "Do not touch me.",
    }

    GLOBAL.STRINGS.ON_PICKEDUP =
    {
        "I knew you would return.",
        "The cycle repeats.",
        "This was your choice. Shank.",
    }

	GLOBAL.STRINGS.ON_WOBERT_PICKEDUP_OTHER =
    {
        "You duplicated me?!",
        "What is this witchcraft, Shank?!",
        "There was only one of me!",
        "You're not holding that.",
		"Who's that? Angelo?",
		"Who's that? The Butcher?", --Does this guy have a name?
		"Who's that? Cassandra?",
		
	}
	
    GLOBAL.STRINGS.ON_DROPPED =
    {
        "You're still stuck with me.",
        "That's not the answer, Shank.",
        "It doesn't matter. /nYou're still going to be fighting forever.",
        "It doesn't end here.",
    }
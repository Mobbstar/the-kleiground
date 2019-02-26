local assets =
{
	Asset( "ANIM", "anim/waria.zip" ),
	Asset( "ANIM", "anim/ghost_waria_build.zip" ),
}

local skins =
{
	normal_skin = "waria",
	ghost_skin = "ghost_waria_build",
}

local base_prefab = "waria"

local tags = {"WARIA", "CHARACTER"}

return CreatePrefabSkin("waria_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})
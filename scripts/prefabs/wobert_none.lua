local assets =
{
	Asset( "ANIM", "anim/wobert.zip" ),
	Asset( "ANIM", "anim/ghost_wobert_build.zip" ),
}

local skins =
{
	normal_skin = "wobert",
	ghost_skin = "ghost_wobert_build",
}

local base_prefab = "wobert"

local tags = {"WOBERT", "CHARACTER"}

return CreatePrefabSkin("wobert_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})
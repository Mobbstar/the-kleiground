--[[
AddRecipe("recipename", {Ingredient("name", numrequired, "images/inventoryimages.xml")}, GLOBAL.RECIPETABS.LIGHT, GLOBAL.TECH.NONE, "placer", min_spacing, b_nounlock, numtogive, "builder_required_tag", "images/kleiground_inventoryimages.xml", "image.tex", testfn)

GLOBAL.AllRecipes.recipename.testfn = function(pt, rot)
    return true, false
end

]]

local shank_tab = AddRecipeTab("SHANK", 999, "images/shanktab.xml", "shanktab.tex", "shank")

--Shank unique recipes
AddRecipe("flintshank", 
	{
		Ingredient("flint", 2),
	},
	shank_tab, 
	GLOBAL.TECH.NONE, 
	nil, 
	nil, 
	nil, 
	4,
	"shank",
	"images/inventoryimages/flintshank.xml", 
	"flintshank.tex")

AddRecipe("throwingknifeflint", 
	{
		Ingredient("flint", 1),
	},
	shank_tab,
	GLOBAL.TECH.NONE, 
	nil, 
	nil, 
	nil, 
	3,
	"shank",
	"images/inventoryimages/throwingknifeflint.xml", 
	"throwingknifeflint.tex")

AddRecipe("cesarshank", --Update once this weapon is working.
	{
		Ingredient("minotaurhorn", 1),
		Ingredient("nightmarefuel", 7),
		Ingredient("goldnugget", 10),
	},
	shank_tab, 
	GLOBAL.TECH.MAGIC_THREE, 
	nil, 
	nil, 
	nil, 
	nil,
	"shank",
	"images/inventoryimages/cesarshank.xml", 
	"cesarshank.tex")

AddRecipe("molotov", 
	{
		Ingredient("glommerfuel", 2),
		Ingredient("nitre", 5),
		Ingredient("gunpowder", 2),
	},
	shank_tab, 
	GLOBAL.TECH.SCIENCE_TWO, 
	nil, 
	nil, 
	nil, 
	nil, 
	"shank", 
	"images/inventoryimages/molotov.xml", 
	"molotov.tex")

AddRecipe("healthbottle", 
	{
		Ingredient("honey", 3),
		Ingredient("ice", 2),
		Ingredient("spoiled_food", 1),
	},
	shank_tab, 
	GLOBAL.TECH.SCIENCE_ONE, 
	nil, 
	nil, 
	nil, 
	nil, 
	"shank", 
	"images/inventoryimages/healthbottle.xml", 
	"healthbottle.tex")

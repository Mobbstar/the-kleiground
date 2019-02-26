local Assets =
{
	Asset("ANIM", "anim/healthbottle.zip"),
    Asset("IMAGE", "images/inventoryimages/healthbottle.tex"),
    Asset("ATLAS", "images/inventoryimages/healthbottle.xml"),
}

local prefabs = 
{
	"spoiled_food",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	if TheSim:GetGameID() =="DST" then inst.entity:AddNetwork() end

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	inst.AnimState:SetBank("healthbottle")
	inst.AnimState:SetBuild("healthbottle")
	inst.AnimState:PlayAnimation("idle", false)

    
	if TheSim:GetGameID()=="DST" then
		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.entity:SetPristine()
	end

	inst:AddTag("beverage")
	
	inst:AddComponent("edible")
	inst.components.edible.healthvalue = 40
	inst.components.edible.hungervalue = 10
	inst.components.edible.sanityvalue = -15
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP / 2
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_AVERAGE

	
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "healthbottle"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/healthbottle.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED * 2)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
		
	return inst
end

STRINGS.NAMES.HEALTHBOTTLE = "Applejack"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.HEALTHBOTTLE = "Probably shouldn't let the kids drink it."
STRINGS.CHARACTERS.WENDY.DESCRIBE.HEALTHBOTTLE =  "That's a numbing solution I'm not allowed to use."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.HEALTHBOTTLE = "But it sounds so innocent!"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.HEALTHBOTTLE = "Oooh! That'd burn nicely!"
return Prefab( "common/inventory/healthbottle", fn, Assets )
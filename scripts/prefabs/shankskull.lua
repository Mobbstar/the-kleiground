local assets =
{
    Asset("ANIM", "anim/shankskull.zip"),
	Asset( "IMAGE", "images/inventoryimages/shankskull.tex" ),
    Asset( "ATLAS", "images/inventoryimages/shankskull.xml" ),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("shankskull")
    inst.AnimState:SetBuild("shankskull")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------


    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "shankskull"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/shankskull.xml"
	--Inventory image and atlas wasn't here, I added them.

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 20
	
    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.CHARACTERS.GENERIC.DESCRIBE.shankskull = {
	"Poor guy. I don't think I can bury this.",
	"Wonder what he was wanted for?", 
	"This story ended sadly.", 
	"There's a note!",
	
}
STRINGS.CHARACTERS.WOBERT.DESCRIBE.shankskull = { --Might add more.
	"Get in line. Lots of people want this.",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.shankskull = {"THE HEAD WAS DETACHED FROM THE MEATBAG'S BODY. HA HA.",}
STRINGS.CHARACTERS.WENDY.DESCRIBE.shankskull = {"They wanted his head on a silver platter.",}

return Prefab("shankskull", fn, assets)
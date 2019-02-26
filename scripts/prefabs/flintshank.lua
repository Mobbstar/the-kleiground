local assets =
{
    Asset("ANIM", "anim/flintshank.zip"),
    Asset("ANIM", "anim/swap_flintshank.zip"),
	Asset( "IMAGE", "images/inventoryimages/flintshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/flintshank.xml" ),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_flintshank", "swap_flintshank")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("flintshank")
    inst.AnimState:SetBuild("flintshank")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(24)

    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(50)
    inst.components.finiteuses:SetUses(50)

    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "flintshank"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/flintshank.xml"
	--Inventory image and atlas wasn't here, I added them.

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.CHARACTERS.GENERIC.DESCRIBE.FLINTSHANK = {
	"I can't handle long stories, so let's cut to the chase.",
	"It's not very knife to shank people!", 
	"What's the point of all this violence?", 
	
}

STRINGS.CHARACTERS.WENDY.DESCRIBE.FLINTSHANK = {"How unnecessarily violent.",}

return Prefab("flintshank", fn, assets)
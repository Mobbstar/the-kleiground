local assets =
{
    Asset("ANIM", "anim/rockshank.zip"),
    Asset("ANIM", "anim/swap_rockshank.zip"),
	Asset( "IMAGE", "images/inventoryimages/rockshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/rockshank.xml" ),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_rockshank", "swap_rockshank")
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

    inst.AnimState:SetBank("rockshank")
    inst.AnimState:SetBuild("rockshank")
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
	inst.components.inventoryitem.imagename = "rockshank"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/rockshank.xml"
	--Inventory image and atlas wasn't here, I added them.

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ROCKSHANK = {
	"Minty!", 
	
}

STRINGS.CHARACTERS.WENDY.DESCRIBE.ROCKSHANK = {"Using it is a metaphor for how life has treated me.",}

return Prefab("rockshank", fn, assets)
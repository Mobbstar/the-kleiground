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
	-- inst.components.inventoryitem.imagename = "shankskull"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/shankskull.xml"

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 20
	
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("shankskull", fn, assets)
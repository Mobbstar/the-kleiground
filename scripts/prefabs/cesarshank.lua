local HauntedKnife = require "NPC_stringskg"
local assets =
{
    Asset("ANIM", "anim/cesarshank.zip"),
    Asset("ANIM", "anim/swap_cesarshank.zip"),
	Asset( "IMAGE", "images/inventoryimages/cesarshank.tex" ),
    Asset( "ATLAS", "images/inventoryimages/cesarshank.xml" ),
}
-------
local function AttachClassified(inst, classified)
    inst.cesarshank_classified = classified
    inst.ondetachclassified = function() inst:DetachClassified() end
    inst:ListenForEvent("onremove", inst.ondetachclassified, classified)
end

local function DetachClassified(inst)
    inst.cesarshank_classified = nil
    inst.ondetachclassified = nil
end



local function OnRemoveEntity(inst)
    if inst.cesarshank_classified ~= nil then
        if TheWorld.ismastersim then
            inst.cesarshank_classified:Remove()
            inst.cesarshank_classified = nil
        else
            inst.cesarshank_classified._parent = nil
            inst:RemoveEventCallback("onremove", inst.ondetachclassified, inst.cesarshank_classified)
            inst:DetachClassified()
        end
    end
end

local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("onremove", inst._oncontainerremoved, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("onremove", inst._oncontainerremoved, inst._container)
        inst._container = nil
    end
end

local function topocket(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
    inst.cesarshank_classified:SetTarget(owner.components.inventoryitem ~= nil and owner.components.inventoryitem.owner or owner)
end

local function toground(inst)
    unstore(inst)
    --No target means everyone receives it
    inst.cesarshank_classified:SetTarget(nil)
end
------
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_cesarshank", "swap_cesarshank")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end
local function ondonetalking(inst)
    inst.localsounds.SoundEmitter:KillSound("talk")
end

local function ontalk(inst)
    local sound = inst.cesarshank_classified ~= nil and inst.cesarshank_classified:GetTalkSound() or nil
    if sound ~= nil then
        inst.localsounds.SoundEmitter:KillSound("talk")
        inst.localsounds.SoundEmitter:PlaySound(sound)
    elseif not inst.localsounds.SoundEmitter:PlayingSound("talk") then
        inst.localsounds.SoundEmitter:PlaySound("dontstarve/characters/maxwell/talk_LP_world6", "talk")
    end
end

local function CustomOnHaunt(inst)
    if inst.components.hauntedknife ~= nil then
        inst.components.talker:Say(GetString(inst, "ON_HAUNT"))
        return true
    end
    return false
end
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
	inst.soundsname = "maxwell"

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("cesarshank")
    inst.AnimState:SetBuild("cesarshank")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")
	
	inst.AttachClassified = AttachClassified
    inst.DetachClassified = DetachClassified
    inst.OnRemoveEntity = OnRemoveEntity

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(75)

    -------


    inst:AddComponent("inspectable")

    inst:AddComponent("hauntedknife")

    inst.cesarshank_classified = SpawnPrefab("cesarshank_classified")
    inst.cesarshank_classified.entity:SetParent(inst.entity)
    inst.cesarshank_classified._parent = inst
    inst.cesarshank_classified:SetTarget(nil)

    inst._container = nil

    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end

    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "cesarshank"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/cesarshank.xml"
	--Inventory image and atlas wasn't here, I added them.

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.dapperness = TUNING.CRAZINESS_MED * 3

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 28
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(.9, .4, .4)
    inst.components.talker.offset = Vector3(0, 0, 0)
	
	    --Dedicated server does not need to spawn the local sound fx
    if not TheNet:IsDedicated() then
        inst.localsounds = CreateEntity()
        inst.localsounds:AddTag("FX")
        --[[Non-networked entity]]
        inst.localsounds.entity:AddTransform()
        inst.localsounds.entity:AddSoundEmitter()
        inst.localsounds.entity:SetParent(inst.entity)
        inst.localsounds:Hide()
        inst.localsounds.persists = false
        inst:ListenForEvent("ontalk", ontalk)
        inst:ListenForEvent("donetalking", ondonetalking)
    end
	
    MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, CustomOnHaunt, true, false, true)

    return inst
end

return Prefab("cesarshank", fn, assets)
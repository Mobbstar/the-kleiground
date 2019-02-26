
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
	Asset( "ANIM", "anim/wobert.zip" ),
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {"flintshank","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint"
}

local function onkillplayers(inst, data)
	if data and data.victim:HasTag("player") and data.victim:HasTag("character") and data.victim.hasKilledPlayer then --Justified kills will restore sanity
		inst.components.sanity:DoDelta(40)
		inst.components.talker:Say(GetString(inst, "ANNOUNCE_JUSTICE_BLOOD"))
	elseif data and data.victim:HasTag("player") and data.victim:HasTag("character") then --Killing players will lower your sanity
		inst.components.sanity:DoDelta(-50)
	end
end



local function DoPain(inst)
	if not inst:HasTag("playerghost") then
	inst.AnimState:SetMultColour(1,.25,0,1)
    inst:DoTaskInTime((1/2 *.5), function(inst) inst.AnimState:SetMultColour(1,1,1,1) end)
	end
end

local function OnHealthDelta(inst, data)
    local health = inst.components.health:GetPercent()
    if health <= .25 and not inst:HasTag("hascurrentpain") then 

    inst.task = inst:DoPeriodicTask(1/2, DoPain)
    inst:AddTag("hascurrentpain")

    elseif health >= .25 then
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst:RemoveTag("hascurrentpain")
    inst.AnimState:SetMultColour(1,1,1,1)
        end
end

local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wobert_speed_mod", .9)
	inst:ListenForEvent("healthdelta", OnHealthDelta)
	inst:ListenForEvent("killed", onkillplayers)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
	inst.components.talker:Say(GetString(inst, "ANNOUNCE_DEATH"))
	inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wobert_speed_mod")
	inst:RemoveEventCallback("healthdelta", OnHealthDelta)
	inst:RemoveEventCallback("killed", onkillplayers)
	inst.AnimState:SetMultColour(1,1,1,1)
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


local function onkilltarget(inst, data)
	--inst is the player, data.victim is the target
	if data.victim:HasTag("monster") then--if the target is a monster
	--if data shows the victim is a murder (hasKilledPlayer = true). Maybe override player_common to add murderer, attacker and reviver tags?
		inst.components.sanity:DoDelta(15)
		inst.components.talker:Say(GetString(inst, "ANNOUNCE_JUSTICE_BLOOD"))
	else -- if the target isnt a largecreature
		inst.components.sanity:DoDelta(-6)
	end
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "wobert.tex" )
	inst:AddTag("shank")
end
 
-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	inst.soundsname = "webber"
    inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	inst:ListenForEvent("onkill", onkilltarget)
	
	inst:ListenForEvent("unlockrecipe", function(inst, data)
	if data and data.recipe == "healthbottle" then
		inst.components.talker:Say(GetString(inst, "ANNOUNCE_PROTOTYPE_HEALTH"))
	end
end)
	inst:ListenForEvent("unlockrecipe", function(inst, data)
	if data and data.recipe == "cesarshank" then
		inst.components.talker:Say(GetString(inst, "ANNOUNCE_PROTOTYPE_CESAR"))
	end
end)
	
	inst.AnimState:SetBuild("wobert")
	inst.components.health:SetMaxHealth(220)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(100)
	--Shank very easily freezes, but almost never overheats.
	inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_LARGE * 1.5
	inst.components.temperature.inherentinsulation = -TUNING.INSULATION_MED * 1.5
    inst.components.combat.damagemultiplier = 1.5
    inst.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD * 2)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	inst.Transform:SetScale(1.25,1.25,1.25)
    inst.components.sanity.night_drain_mult = .75
    inst.components.sanity.neg_aura_mult = .5	
	inst:ListenForEvent("healthdelta", OnHealthDelta)
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end
return MakePlayerCharacter("wobert", prefabs, assets, common_postinit, master_postinit, start_inv)

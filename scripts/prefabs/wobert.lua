local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
	"flintshank",
	"throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint","throwingknifeflint",
}



local function DoPain(inst)
	if not inst:HasTag("playerghost") then
		inst.AnimState:SetMultColour(1,.25,0,1)
		inst:DoTaskInTime((1/2 *.5), function(inst) inst.AnimState:SetMultColour(1,1,1,1) end)
	end
end
--Note by Mobb: This "pain" stuff seems silly, and I am not a fan of Applejack to begin with either.
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

local function onkillother(inst, data)
	--inst is the player, data.victim is the target
	if data.victim then
		if data.victim:HasTag("player") and data.victim:HasTag("character") then
			if data.victim.hasKilledPlayer then --brought a murderer to justice
				inst.components.sanity:DoDelta(40)
				inst.components.talker:Say(GetString(inst, "ANNOUNCE_JUSTICE_BLOOD"))
			else --murdered an innocent
				inst.components.sanity:DoDelta(-50)
			end
		elseif data.victim:HasTag("monster") then
			inst.components.sanity:DoDelta(15)
			inst.components.talker:Say(GetString(inst, "ANNOUNCE_JUSTICE_BLOOD"))
		-- else -- if the target isnt a largecreature
			-- inst.components.sanity:DoDelta(-6)
		end
	end
end

local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wobert_speed_mod", .9)
	inst:ListenForEvent("healthdelta", OnHealthDelta)
	inst:ListenForEvent("killed", onkillother)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
	inst.components.talker:Say(GetString(inst, "ANNOUNCE_DEATH"))
	inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wobert_speed_mod")
	inst:RemoveEventCallback("healthdelta", OnHealthDelta)
	inst:RemoveEventCallback("killed", onkillother)
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
	
	-- inst.AnimState:SetBuild("wobert")
	inst.Transform:SetScale(1.25,1.25,1.25)
	
	inst:ListenForEvent("unlockrecipe", function(inst, data)
		if data and data.recipe == "healthbottle" then
			inst.components.talker:Say(GetString(inst, "ANNOUNCE_PROTOTYPE_HEALTH"))
		elseif data and  data.recipe == "cesarshank" then
			inst.components.talker:Say(GetString(inst, "ANNOUNCE_PROTOTYPE_CESAR"))
		end
	end)
	
	inst.components.health:SetMaxHealth(220)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(100)
	
	--Shank very easily freezes, but almost never overheats.
	inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_LARGE * 1.5
	inst.components.temperature.inherentinsulation = -TUNING.INSULATION_MED * 1.5
	
    inst.components.combat.damagemultiplier = 1.5
    inst.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD * 2)
	
	-- inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
    inst.components.sanity.night_drain_mult = .75
    inst.components.sanity.neg_aura_mult = .5	
	
	-- inst:ListenForEvent("healthdelta", OnHealthDelta)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

--"wobert" is an uncreative character name. Conflicts with other char mods are likely. -M
return MakePlayerCharacter("wobert", prefabs, assets, common_postinit, master_postinit, start_inv)

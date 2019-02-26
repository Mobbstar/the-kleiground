local HauntedKnife = require "NPC_stringskg"

local TALK_TO_OWNER_DISTANCE = 15

local function IsValidOwner(inst, owner)
    return owner:HasTag("shank")
end
local function OnCheckOwner(inst, self)
    self.checkownertask = nil
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner == nil or owner.components.inventory == nil then
        return
    elseif not IsValidOwner(inst, owner) then
        self:Drop()
        inst:PushEvent("axerejectedowner", owner)
    else
        local other = OwnerAlreadyHasPossessedKnife(inst, owner)
        if other ~= nil then
            self:Drop()
            other:PushEvent("axerejectedotheraxe", inst)
        elseif owner:HasTag("player") then
            self:LinkToPlayer(owner)
        end
    end
end

local function OnChangeOwner(inst, owner)
    local self = inst.components.possessedaxe
    if self.currentowner == owner then
        return
    elseif self.currentowner ~= nil and self.oncontainerpickedup ~= nil then
        inst:RemoveEventCallback("onputininventory", self.oncontainerpickedup, self.currentowner)
        self.oncontainerpickedup = nil
    end

    if self.checkownertask ~= nil then
        self.checkownertask:Cancel()
        self.checkownertask = nil
    end

    self.currentowner = owner

    if owner == nil then
        return
    elseif owner.components.inventoryitem ~= nil then
        self.oncontainerpickedup = function()
            if self.checkownertask ~= nil then
                self.checkownertask:Cancel()
            end
            self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
        end
        inst:ListenForEvent("onputininventory", self.oncontainerpickedup, owner)
    end
    self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
end
local function OnKnifePossessedByPlayer(inst, player)
    inst.components.hauntedknife:SetOwner(player)
end

local function OnKnifeRejectedOwner(inst, owner)
	inst.components.talker:Say(GetString(inst, "OTHER_OWNER"))
end

local function OnKnifeRejectedOtherKnife(inst, other)
	other.components.talker:Say(GetString(other, "ON_WOBERT_PICKEDUP_OTHER"))
    if other.components.hauntedknife.say_task ~= nil then
        other.components.hauntedknife.say_task:Cancel()
        other.components.hauntedknife.say_task = nil
    end
end

local HauntedKnife = Class(function(self, inst)
    self.inst = inst
    self.owner = nil
    self.convo_task = nil
    self.say_task = nil
    self.warnlevel = 0
    self.waslow = false

    inst:ListenForEvent("knifepossessedbyplayer", OnKnifePossessedByPlayer)
    inst:ListenForEvent("kniferejectedowner", OnKnifeRejectedOwner)
    inst:ListenForEvent("kniferejectedotherknife", OnKnifeRejectedOtherKnife)
end)

local function toground(inst)
    inst.components.talker:Say(GetString(inst, "ON_DROPPED", nil, 2 * FRAMES))
end

local function onequipped(inst, data)
    local self = inst.components.hauntedknife
    if self.owner ~= nil and self.owner == data.owner then
        inst.components.talker:Say(GetString(inst, "ON_PICKEDUP"))
    end
end

function HauntedKnife:SetOwner(owner)
    if self.owner ~= owner then
        if self.say_task ~= nil then
            self.say_task:Cancel()
            self.say_task = nil
        end
        if self.convo_task ~= nil then
            self.convo_task:Cancel()
            self.convo_task = nil
        end
        if self.owner ~= nil then
            self.inst:RemoveEventCallback("ondropped", toground)
            self.inst:RemoveEventCallback("equipped", onequipped)
        end
        self.owner = owner
        self.warnlevel = 0
        self.waslow = false
        if owner ~= nil then
            self.inst:ListenForEvent("ondropped", toground)
            self.inst:ListenForEvent("equipped", onequipped)
            if self.inst.components.equippable:IsEquipped() then
				inst.components.talker:Say(GetString( inst,"ON_PICKEDUP"))
				
            end
            self:ScheduleConversation()
        end
    end
end



local function Onprint(inst, self, list, sound_override)
    self.say_task = nil
    --Use ShouldMakeConversation check for delayed speech
    if self:ShouldMakeConversation() then
        self:print(list, sound_override)
    end
end

function HauntedKnife:print(list, sound_override, delay)
    if self.say_task ~= nil then
        self.say_task:Cancel()
        self.say_task = nil
    end
    if delay ~= nil then
        self.say_task = self.inst:DoTaskInTime(delay, Onprint, self, list, sound_override)
        return
    end

    if self.inst.cesarshank_classified ~= nil then
        self.inst.cesarshank_classified:print(list, math.random(#list), sound_override)
    end
    if self.owner ~= nil then
        self:ScheduleConversation(60 + math.random() * 60)
    end
end

local function OnMakeConvo(inst, self)
    self.convo_task = nil
    self:MakeConversation()
end

function HauntedKnife:ShouldMakeConversation()
    return self.owner ~= nil
        and not (self.owner.components.health ~= nil and
                self.owner.components.health:IsDead())
        and not (self.owner.sg:HasStateTag("transform") or
                self.owner:HasTag("playerghost"))
end

function HauntedKnife:ScheduleConversation(delay)
    if self.convo_task ~= nil then
        self.convo_task:Cancel()
    end
    self.convo_task = self.inst:DoTaskInTime(delay or 10 + math.random() * 5, OnMakeConvo, self)
end

function HauntedKnife:MakeConversation()
    if self.owner == nil then
        return
    elseif not self:ShouldMakeConversation() then
        self:ScheduleConversation()
        return
    end

    local owner = self.inst.components.inventoryitem.owner
    if owner == nil then
        --on the ground
        if self.owner:IsNear(self.inst, TALK_TO_OWNER_DISTANCE) then
		inst.components.talker:Say(GetString(inst, "ON_GROUND"))
        end
    elseif self.inst.components.equippable:IsEquipped() then
        --equipped
        inst.components.talker:Say(GetString(inst, "EQUIPPED"))
    elseif owner.components.inventoryitem ~= nil and owner.components.inventoryitem.owner == self.owner then
        --in backpack
		inst.components.talker:Say(GetString( inst, "IN_CONTAINER"))
    end

    self:ScheduleConversation()
end

return HauntedKnife
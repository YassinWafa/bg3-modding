
Ext.Utils.Print("Shadow Sorcerer - Registering Hooks")


local function cleanShadowSorcererCmd(cmd)
    local character = GetHostCharacter()
	CleanShadowSorcerer(character)
end
Ext.RegisterConsoleCommand("cleanshadowsorcerer", cleanShadowSorcererCmd);

--event CastSpell((GUIDSTRING)_Caster, (STRING)_Spell, (STRING)_SpellType, (STRING)_SpellElement, (INTEGER)_StoryActionID)
Ext.Osiris.RegisterListener("CastSpell", 5, "after", function (_Caster, _Spell, _SpellType, _SpellElement, _StoryActionID)

	-- TBH - This stuff is handled by the passives - not needed for the time being.
	--local isOneOfTheSpells = _Spell == "baa_Target_Darkness_Cloud_EyesOfTheDark" or _Spell == "baa_Target_Darkness_Item_EyesOfTheDark" or _Spell == "baa_Wall_WallOfDarkness_eyesofthedark"
	--local hasActiveSight = HasActiveStatus(_Caster, "BAA_DARKNESS_SIGHT")
	
	--Ext.Utils.Print("Casting spell:".. _Spell)
	--Ext.Utils.Print("Is one of the spells  = ".. isOneOfTheSpells)
	--Ext.Utils.Print("Active sight = ".. hasActiveSight)
	--if (_Spell == "baa_Target_Darkness_Cloud_EyesOfTheDark" or _Spell == "baa_Target_Darkness_Item_EyesOfTheDark" or _Spell == "baa_Wall_WallOfDarkness_eyesofthedark") and not hasActiveSight then
		--Ext.Utils.Print("Applying darkness sight for 100 turns")
		--ApplyStatus(_Caster, "BAA_DARKNESS_SIGHT", 100, 1)
	--end
	
end)






function CleanShadowSorcerer(characterGuid)

	--if PersistentVars['ShadowSorcererCleanMode'] ~= 1 then
	--	return
	--end
	--PersistentVars['ShadowSorcererCleanMode'] = 0
	if HasPassive(characterGuid,"EyesOfTheDark") then
		Ext.Utils.Print("Attempting to remove all passives from shadow sorcerer character")
		RemovePassive(characterGuid,"EyesOfTheDark")
		RemovePassive(characterGuid,"EyesOfTheDark_DarknessSpell_Desc")
		RemovePassive(characterGuid,"EyesOfTheDark_DarknessSpell_Spell")
		RemovePassive(characterGuid,"EyesOfTheDark_DarknessSpell")
		RemovePassive(characterGuid,"baa_DarknessSpell")
		RemovePassive(characterGuid,"StrengthOfTheGrave")
		RemovePassive(characterGuid,"HoundOfIllOmen")
		RemovePassive(characterGuid,"HoundOfIllOmen_Tracking")
		RemovePassive(characterGuid,"AttackOfOpportunity_HoundOfIllOmen")
		RemovePassive(characterGuid,"ShadowSorcerer_ResistShadowCurse")
		RemovePassive(characterGuid,"ShadowSorcerer_ImmuneShadowCurse")
		
		Ext.Utils.Print("Passive removal might have worked... Attempting spells")
		
		Ext.Utils.Print("Removing EyesOfTheDark passive and associated spells")
		RemoveSpell(characterGuid, "baa_Target_Darkness_EyesOfTheDark", 1)
		RemoveSpell(characterGuid, "baa_Target_Darkness", 1)
		
		
		Ext.Utils.Print("Removing other spells")
		RemoveSpell(characterGuid, "baa_Target_Endarken", 1)
		RemoveSpell(characterGuid, "baa_Shout_ShadowBlade", 1)
		RemoveSpell(characterGuid, "baa_Target_ShadowWalk",1)
		RemoveSpell(characterGuid, "baa_Shout_UmbralForm",1)
		
		Ext.Utils.Print("Removing Statuses")
		RemoveStatus(characterGuid, "EYESOFTHEDARK_DARKNESS")
		RemoveStatus(characterGuid, "BAA_SHADOW_ARMOR_1")
		RemoveStatus(characterGuid, "BAA_SHADOW_ARMOR_2")
		RemoveStatus(characterGuid, "BAA_BLINDED_DARKNESS")
		RemoveStatus(characterGuid, "BAA_DARKNESS_ENCHANTMENT")
		RemoveStatus(characterGuid, "BAA_DARKNESS")
		RemoveStatus(characterGuid, "BAA_DARKNESS_EQUIPPED")
		RemoveStatus(characterGuid, "BAA_DARKNESS_VISUAL")
		RemoveStatus(characterGuid, "BAA_DARKNESS_EFFECT")
		
		RemoveStatus(characterGuid, "SCL_AREA")
		RemoveStatus(characterGuid, "SCL_SHADOW_CURSE_1")
		RemoveStatus(characterGuid, "BAA_DARKNESS_SIGHT")
		RemoveStatus(characterGuid, "STRENGTH_OF_THE_GRAVE")
		
		RemoveStatus(characterGuid, "STRENGTH_OF_THE_GRAVE_BLOCK")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN_TARGET")
		RemoveStatus(characterGuid, "HOUNDOFILLOMEN")
		RemoveStatus(characterGuid, "HOUNDOFILLOMEN_SPELL")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN_2")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN_3")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN_CASTER")
		RemoveStatus(characterGuid, "HOUND_OF_ILL_OMEN_DISADVANTAGE")
		RemoveStatus(characterGuid, "TEMPHP5")
		RemoveStatus(characterGuid, "TEMPHP4")
		RemoveStatus(characterGuid, "TEMPHP3")
		Ext.Utils.Print("All possible statuses have been removed!")
		
		Ext.Utils.Print("Try to clear tag")
		ClearTag(characterGuid,"6a323e9c-d398-419c-adfd-24b5337c1c9e")
		ClearTag(characterGuid,"SORCERER_SHADOW")
		Ext.Utils.Print("Cleared Shadow Sorc tag")
		
		local item = GetItemByTemplateInPartyInventory("7e956b8f-5674-4ade-ae6e-64164439a6b9", characterGuid)
		if item ~= nil then
			Ext.Utils.Print("Shadow Blade found")
			RequestDelete(item)
			Ext.Utils.Print("Shadow Blade should be deleted now")
		end
		
		item = GetItemByTemplateInPartyInventory("61f3a6e3-e552-40bb-83a4-1a9e2117694b", characterGuid)
		if item ~= nil then
			Ext.Utils.Print("Shadow Sorcerer armor found 1")
			RequestDelete(item)
			Ext.Utils.Print("Shadow Sorcerer armor Should be deleted now")
		end
		
	end

end

--	RemovePassive((GUIDSTRING)_Entity, (STRING)_PassiveID)
--Ext.Osiris.RegisterListener("RespecCompleted", 1, "after", function (characterGuid)

--	CleanShadowSorcerer(characterGuid)
	
--end)


Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (characterGuid, str1, characterGuid2, integer1)
    --Ext.Utils.Print("Shadow Sorc : Status Applied - " .. characterGuid .. " - " .. str1 .. " - " .. characterGuid2 .. " - " .. integer1)
	
	if str1 == "EYESOFTHEDARK_DARKNESS" then
		Ext.Utils.Print("EYESOFTHEDARK_DARKNESS toggled on")
		--RemoveSpell(characterGuid, "baa_Target_Darkness", 1)
		--AddSpell(characterGuid, "baa_Target_Darkness_EyesOfTheDark", 0, 1)
	end
	
end)

--event StatusRemoved((GUIDSTRING)_Object, (STRING)_Status, (GUIDSTRING)_Causee, (INTEGER)_ApplyStoryActionID) (3,0,1053,1)
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (_Object, _Status, _Causee, _ApplyStoryActionID)
    --Ext.Utils.Print("Shadow Sorc : Status Removed - " .. characterGuid .. " - " .. str1 .. " - " .. characterGuid2 .. " - " .. integer1)
	
	local isEyesOfTheDark = _Status == "EYESOFTHEDARK_DARKNESS"
	if isEyesOfTheDark then
		Ext.Utils.Print("EYESOFTHEDARK_DARKNESS toggled off")
		--RemoveSpell(_Object, "baa_Target_Darkness_EyesOfTheDark", 1)
		--AddSpell(_Object, "baa_Target_Darkness", 0, 1)
	end
	
	local isEnchantment = _Status == "BAA_DARKNESS_ENCHANTMENT"
	if isEnchantment then
		Ext.Utils.Print("[Shadow Sorc : Enchantment Removed] :".. _Object .. " - ".. _Status .. " - " .. _Causee .. " - " .. _ApplyStoryActionID)
		RemoveStatus(_Object, "BAA_DARKNESS")
		RemoveStatus(_Object, "BAA_DARKNESS_EQUIPPED")
		RemoveStatus(_Object, "BAA_DARKNESS_EFFECT")
		RemoveStatus(_Object, "BAA_DARKNESS_VISUAL")
		
		local holder = GetInventoryOwner(_Object)
		
		if holder ~= nil then
			RemoveStatus(holder, "BAA_DARKNESS_EQUIPPED")
			RemoveStatus(holder, "BAA_DARKNESS_EFFECT")
			RemoveStatus(holder, "BAA_DARKNESS_VISUAL")
			RemoveStatus(holder, "BAA_DARKNESS")
		end
	else
		--Ext.Utils.Print("[Shadow Sorc : Some status removed ] :".. _Object .. " - ".. _Status .. " - " .. _Causee .. " - " .. _ApplyStoryActionID)
	end
	
end)

--event AddedTo((GUIDSTRING)_Object, (GUIDSTRING)_InventoryHolder, (STRING)_AddType) (3,0,1156,1)
--call Pickup((CHARACTER)_Character, (ITEM)_Item, (STRING)_Event, (INTEGER)_ForcePickUpOnFailure) (1,0,43,1)
--When we pick up an item - we want to remove its normal darkness effect so we stop blinding people with this item in our inventory
--event OnStartCarrying((GUIDSTRING)_CarriedObject, (ROOT)_CarriedObjectTemplate, (GUIDSTRING)_Carrier, (INTEGER)_StoryActionID, (REAL)_pickupPosX, (REAL)_pickupPosY, (REAL)_pickupPosZ) (3,0,1116,1)
Ext.Osiris.RegisterListener("AddedTo", 3, "after", function (_Object, _InventoryHolder, _AddType)
	--Ext.Utils.Print("Shadow Sorc : AddedTo - " .. _Object .. " - " .. _InventoryHolder .. " - " .. _AddType )
	local cHasDarknessSpell = HasActiveStatus(_Object, "BAA_DARKNESS") -- the item had darkness spell cast on it on the ground
	if cHasDarknessSpell == 1 then
		Ext.Utils.Print("[Shadow Sorc : Pickup - Removing main darkness effect]")
		RemoveStatus(_Object, "BAA_DARKNESS")
	end


end)

--call Drop((ITEM)_Item -- When we drop the item, we want to convert its enchantment effect into the normal darkness aura effect
Ext.Osiris.RegisterListener("DroppedBy", 2, "after", function ( item, character)
	--Ext.Utils.Print("Shadow Sorc : DroppedBy - " .. item .. " - " .. character)
	local cHasDarknessSpell = HasActiveStatus(item, "BAA_DARKNESS") -- the item had darkness spell cast on it on the ground
	local cHasDarknessEnchantment = HasActiveStatus(item, "BAA_DARKNESS_ENCHANTMENT")
	if HasActiveStatus(character, "BAA_DARKNESS_EQUIPPED") == 1 then
		Ext.Utils.Print("[Shadow Sorc : Drop - Player has equipped effect, removing it]")
		RemoveStatus(character, "BAA_DARKNESS_EQUIPPED")
	end
	
	if cHasDarknessSpell == 0 and cHasDarknessEnchantment == 1 then
		Ext.Utils.Print("Shadow Sorc : Drop - Apply the normal darkness effect")
		ApplyStatus(item, "BAA_DARKNESS", -1, 1)
		ApplyStatus(item, "BAA_DARKNESS_EFFECT", -1, 1)
		ApplyStatus(item, "BAA_DARKNESS_VISUAL", -1, 1)
	end
	
	

end)


Ext.Osiris.RegisterListener("Equipped", 2, "after", function (item, character)
    --Ext.Utils.Print("Shadow Sorc : Equipped - " .. item .. " - " .. character)
	
	
	
	local cHasEnchantment = HasActiveStatus(item, "BAA_DARKNESS_ENCHANTMENT")
	
	
	if cHasEnchantment == 1 then
		Ext.Utils.Print("Shadow Sorc : Equipped - This item has the darkness enchantment")
		ApplyStatus(character, "BAA_DARKNESS_EQUIPPED", -1, 1)
		local cHasDarknessSpell = HasActiveStatus(item, "BAA_DARKNESS") -- the item had darkness spell cast on it on the ground
		if cHasDarknessSpell == 1 then
			Ext.Utils.Print("[Shadow Sorc : Equipped - Removing main darkness effect]")
			RemoveStatus(item, "BAA_DARKNESS")
		end
	end
	
	
	--Darkness Item equipped
	--if HasActiveStatus(item, "BAA_DARKNESS_EQUIPPED") then
	--	Ext.Utils.Print("Shadow Sorc : Equipped - Adding darkness visual and effect")
	--	ApplyStatus(character, "BAA_DARKNESS_EFFECT", -1, 1,character)
	--elseif HasActiveStatus(item, "BAA_DARKNESS") == 1 and not HasActiveStatus(item, "BAA_DARKNESS_EQUIPPED") ==1 then
	--	ApplyStatus(item, "BAA_DARKNESS_EQUIPPED", -1, 1,character)
	--	ApplyStatus(character, "BAA_DARKNESS_EFFECT", -1, 1,character)
	--end
	
	
	
end)

Ext.Osiris.RegisterListener("Unequipped", 2, "after", function (item, character)
    --Ext.Utils.Print("Shadow Sorc : Unequipped - " .. item .. " - " .. character)
	
	local c1 = HasActiveStatus(item, "BAA_DARKNESS_ENCHANTMENT")
	
	if c1 == 1  then
		Ext.Utils.Print("[Shadow Sorc : Unequipped darkness enchantment item]")
		local c2 = HasActiveStatus(character, "BAA_DARKNESS_EQUIPPED")
		local c3 = HasActiveStatus(item, "BAA_DARKNESS_EQUIPPED")
		if c2 == 1 then
			Ext.Utils.Print("[Shadow Sorc : Removing statuses from character")
			RemoveStatus(character, "BAA_DARKNESS_EQUIPPED")
			RemoveStatus(character, "BAA_DARKNESS_EFFECT")
			RemoveStatus(character, "BAA_DARKNESS_VISUAL")
		end
		if c3 == 1 then
			Ext.Utils.Print("[Shadow Sorc : Removing statuses from item")
			RemoveStatus(item, "BAA_DARKNESS_EQUIPPED")
			RemoveStatus(item, "BAA_DARKNESS_EFFECT")
			RemoveStatus(item, "BAA_DARKNESS_VISUAL")		
		end
		
		
	end
	
	
	
end)
--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Function Helper file for Hysteria Profiles
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
]]
-- Initialize tables
if not hysteria then hysteria = {} end
if not mindFlay then mindFlay = {} end
if not insanity then insanity = {} end
if not hysteria.dot_tracker then hysteria.dot_tracker = {} end

-- Custom Buttons
ProbablyEngine.toggle.create(
	'bossDotting',
	'Interface\\ICONS\\inv_jewelry_orgrimmarraid_trinket_13',
	'Boss-dotting',
	"Enable/Disable automatic dotting\n of all boss units in range!")

-- Convert Spell ID to Spell Name
function UnitBuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitBuff(unit, spell, nil, filter) else return UnitBuff(unit, spell) end
end
function UnitDebuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitDebuff(unit, spell, nil, filter) else return UnitDebuff(unit, spell) end
end

-- Round numbers
function hysteria.PowerRound(num) return math.floor(num+.5) end
function hysteria.Round(number, decimal)
	local multiplier = 10^(decimal or 0)
	return math.floor(number * multiplier + 0.5) / multiplier
end

-- Check for a raid buff
function hysteria.checkRaidBuff(index)
	if not GetRaidBuffTrayAuraInfo(index) then return true end
	return false
end

-- Calculate DOT power returns
function hysteria.dotPower(spellID)
	-- Fetch our current stats.
	local mastery, haste, crit, spd, sorbs = GetMastery(), UnitSpellHaste("player"), GetSpellCritChance(6), GetSpellBonusDamage(6), UnitPower("player",13)
	
	-- Calculate potential damage buffs.
	dmg_buff = 1
	local fluidity, tricks, fearless, nutriment, shadowform, pi, tof, skullbanner, invo = UnitBuffID("player",138002), UnitBuffID("player",57934), UnitBuffID("player",118977), UnitBuffID("player",140741), UnitBuffID("player",15473), UnitBuffID("player",10060), UnitBuffID("player",123254), UnitBuffID("player",114207), UnitBuffID("player",116257)
	if fluidity		then dmg_buff = dmg_buff * 1.4		end
	if fearless		then dmg_buff = dmg_buff * 1.6		end
	if tricks		then dmg_buff = dmg_buff * 1.15		end
	if nutriment	then dmg_buff = 2+(nutriment-1)*0.1	end
	if shadowform	then dmg_buff = dmg_buff * 1.25		end
	if pi			then dmg_buff = dmg_buff * 1.05		end
	if tof			then dmg_buff = dmg_buff * 1.15		end
	if invo			then dmg_buff = dmg_buff * 1.15		end
	if skullbanner	then dmg_buff = dmg_buff * 1.20		end
	
	-- If Unerring proceed, take it into account.
	if crit > 100 then crit = 100 end
	
	-- Class/spec detection
	if select(2,UnitClass("player")) == "PRIEST" then
		if GetSpecialization() == 3 then
			damage_bonus 		= (1+crit/100)*(1+(mastery*1.8)/100)
			tick_every 			= 3/(1+(haste/100))
			
			-- Shadow Word: Pain
			if spellID == 589 then
				ticks		= hysteria.PowerRound(18/tick_every)
				duration	= ticks*tick_every
				damage		= ticks*(623+spd*0.293)*damage_bonus*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end
			
			-- Vampiric Touch
			if spellID == 34914 then
				ticks		= hysteria.PowerRound(15/tick_every)
				duration	= ticks*tick_every
				damage		= ticks*(62+spd*0.346)*damage_bonus*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end		
			
			-- Devouring Plague
			if spellID == 2944 then
				tick_every	= 1/(1+(haste/100))
				ticks		= hysteria.PowerRound(5/tick_every)
				duration	= ticks*tick_every
				damage		= ticks*(9+spd*0.131)*sorbs*damage_bonus*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end
			
			-- Fail-safe
			return 0
		else return 0 end
	elseif select(2,UnitClass("player")) == "MAGE" then
		if GetSpecialization() == 1 or GetSpecialization() == 2 or GetSpecialization() == 3 then
			damage_bonus	= (1+crit/100)
			
			-- Living Bomb
			if spellID == 44457 then
				tick_every	= 4/(1+(haste/100))
				ticks		= hysteria.PowerRound(12/tick_every)
				duration	= ticks * tick_every
				damage		= (1072+spd*0.8036)*damage_bonus*ticks*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end
			
			-- Nether Tempest
			if spellID == 114923 then
				tick_every	= 12/(1+(haste/100))
				ticks		= hysteria.PowerRound(12/tick_every)
				duration	= ticks * tick_every
				damage		= (325+spd*0.2436)*damage_bonus*ticks*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end
		else return 0 end
	elseif select(2,UnitClass("player")) == "WARLOCK" then
		if GetSpecialization() == 2 then
			-- Doom
			if spellID == 603 then
				bonus		= (1+crit/100)*(1+(mastery*3)/100)
				tick_every	= 15/(1+(haste/100))
				ticks		= hysteria.PowerRound(60/tick_every)
				duration	= ticks * tick_every
				damage		= (5340/ticks+spd*1.25)*bonus*ticks*dmg_buff
				dps			= hysteria.PowerRound(damage/duration)
				dot_power	= hysteria.PowerRound(dps/100)/10
				return dot_power
			end
			
			-- Fail-safe
			return 0
		else return 0 end
	else return 0 end
end

function hysteria.tempBuffs(threshold)
	local temp_buffs = {104509,104510,128985,33702,126577,126478,125487,136082,126605,126734,126476,138898,139133,138786,138703,104993,105702,148897,148906,146184,146046,137590}
	local timer = threshold or 3
	for i=1,#temp_buffs do
		if UnitBuff("player",GetSpellInfo(temp_buffs[i])) then
			if select(7,UnitBuff("player",GetSpellInfo(temp_buffs[i]))) - GetTime() <= timer then return true end
		end
	end
	return false
end

function hysteria.calculateDot(spell, unit)
	local id = UnitGUID(unit)
	local tracker = hysteria.dot_tracker
	local power = hysteria.dotPower(spell)
	
	-- Shadow Word: Pain
	if spell == 589 then
		local shadowWordPain = select(7,UnitDebuffID(unit,SWP,"PLAYER"))
		local tick_every = hysteria.Round(3/(1+(UnitSpellHaste("player")/100)),2)
		local max_timer = hysteria.Round(hysteria.PowerRound(18/(3/(1+(UnitSpellHaste("player")/100))))*(3/(1+(UnitSpellHaste("player")/100))),2)
		
		if shadowWordPain then
			for i=1,#tracker do
				if tracker[i].guid == id and tracker[i].spellID == spell then
					local added_ticks = (max_timer/tick_every - (shadowWordPain - GetTime()) / tracker[i].swp_tick_every)
					local remaining_ticks = ((shadowWordPain - GetTime()) / tracker[i].swp_tick_every)
					
					if UnitBuffID("player",138963) then
						if tracker[i].crit == true then if shadowWordPain - GetTime() < max_timer/2 then return true end end
						if tracker[i].crit == false then if shadowWordPain - GetTime() < max_timer-1 then return true end end
						return false
					else
						if power > tracker[i].swpPower then
							if (added_ticks >= remaining_ticks) or hysteria.tempBuffs(tick_every+2) then return true else return false end
						end
						if shadowWordPain - GetTime() < tick_every+1 then return true else return false end
					end
				end
			end
		else return true end
	end
	
	-- Vampiric Touch
	if spell == 34914 then
		local vampiricTouch = select(7,UnitDebuffID(unit,VT,"PLAYER"))
		local GCD = hysteria.Round(1.5/((UnitSpellHaste("player")/100)+1),2)
		local tick_every = hysteria.Round(3/(1+(UnitSpellHaste("player")/100)),2)
		local max_timer = hysteria.Round(hysteria.PowerRound(15/(3/(1+(UnitSpellHaste("player")/100))))*(3/(1+(UnitSpellHaste("player")/100))),2)
		
		if vampiricTouch then
			for i=1,#tracker do
				if tracker[i].guid == id and tracker[i].spellID == spell then
					local added_ticks = (max_timer/tick_every - (vampiricTouch - GetTime()) / tracker[i].vt_tick_every)
					local remaining_ticks = ((vampiricTouch - GetTime()) / tracker[i].vt_tick_every)
					
					if UnitBuffID("player",138963) then
						if tracker[i].crit == true then if vampiricTouch - GetTime() < max_timer/2 then return true end end
						if tracker[i].crit == false then if vampiricTouch - GetTime() < max_timer-1 then return true end end
						return false
					else
						if power > tracker[i].vtPower then
							if (added_ticks >= remaining_ticks) or hysteria.tempBuffs(GCD+tick_every+1) then return true else return false end
						end
						if vampiricTouch - GetTime() <= GCD+tick_every+1 then return true else return false end
					end
				end
			end
		else return true end
	end
	
	-- Devouring Plague
	if spell == 2944 then
		local tick_every = hysteria.Round(1/(1+(UnitSpellHaste("player")/100)),2)
		local devouringPlague = select(7,UnitDebuffID(unit,DP,"PLAYER"))
		
		if devouringPlague then
			if devouringPlague - GetTime() <= tick_every then return true else return false end
		else return true end
	end
end

function hysteria.validate(spell, unit)
	local unitCasting = UnitCastingInfo(unit)
	local playerChannel = UnitChannelInfo("player")
	local playerCasting = UnitCastingInfo("player")
	local castingTime = (select(7,GetSpellInfo(spell)))
	local exists = ProbablyEngine.dsl.get("spell.exists")("player",spell)
	local MultiUnits = {"mouseover","focus","boss1","boss2","boss3","boss4","boss5"}
	
    for i=1,#MultiUnits do
		if unit == "Multi" then unit = MultiUnits[i] end
		
		-- Sanity checks
		if not spell then return false end
		if not exists then return false end
		if not unit then return false end
		if not UnitExists(unit) then return false end
		if not IsSpellInRange(GetSpellName(spell), unit) or IsSpellInRange(GetSpellName(spell), unit) == 0 then return false end
		if UnitIsUnit("player", unit) then return false end
		if not UnitCanAttack("player", unit) then return false end
		
		-- Detect enemy immunities
		if UnitBuffID(unit, 116994)
			or UnitBuffID(unit, 122540)
			or UnitBuffID(unit, 123250)
			or UnitBuffID(unit, 106062)
			or UnitBuffID(unit, 110945)
			or UnitBuffID(unit, 143593)
			or UnitBuffID(unit, 143574)
		then return false end
		
		-- Detect interrupt/spell-lock
		if unitCasting and (unitCasting == GetSpellInfo(138763) or unitCasting == GetSpellInfo(137457) or unitCasting == GetSpellInfo(143343)) then
			if playerChannel or playerCasting then
				RunMacroText("/stopcasting")
				return false
			end
			return false
		end
		
		-- Priests are a royal pain in the ass...
		if select(2,UnitClass("player")) == "PRIEST" then
			-- Don't cancel Mind Sear
			if UnitChannelInfo("player") == GetSpellInfo(MSear) then
				if spell == MSear then CastSpellByName(GetSpellInfo(MSear)) return true
				else return false end
			end
			
			-- Some spells have a higher priority, cancel right away
			if spell == MB or spell == SWD or spell == MDisp or spell == Disp then CastSpellByName(GetSpellInfo(spell)) return true end
			
			-- Otherwise, interrupt channels after a tick
			if playerChannel then
				if playerChannel == GetSpellInfo(MF) then
					if mindFlay.curTicks >= mindFlay.maxTicks - 1 then CastSpellByName(GetSpellInfo(spell)) return true end
				end
				if playerChannel == GetSpellInfo(MFI) then
					if insanity.curTicks >= insanity.maxTicks - 1 then CastSpellByName(GetSpellInfo(spell)) return true end
				end
				return false
			else return true end
		else return true end
	end
end

-- Register library
ProbablyEngine.library.register("hysteria", hysteria)

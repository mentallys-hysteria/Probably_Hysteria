--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Function Helper file for Hysteria Profiles
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
	Updated: 23:23 03.11.2013
]]
-- Initialize tables
if not hysteria then hysteria = {} end
if not mindFlay then mindFlay = {} end
if not insanity then insanity = {} end

-- Convert Spell ID to Spell Name
function UnitBuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitBuff(unit, spell, filter) else return UnitBuff(unit, spell) end
end
function UnitDebuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then return false end
	if spell then spell = GetSpellInfo(spell) else return false end
	
	if filter then return UnitDebuff(unit, spell, filter) else return UnitDebuff(unit, spell) end
end

-- Boss Events
function unitImmunity(unit)
	-- Detect immunity events
	if UnitBuffID(unit, 116994)
		or UnitBuffID(unit, 122540)
		or UnitBuffID(unit, 123250)
		or UnitBuffID(unit, 106062)
		or UnitBuffID(unit, 110945)
		or UnitBuffID(unit, 143593)
		or UnitBuffID(unit, 143574)
	then return false end
end

function unitInterrupt(unit)
	-- Default current target
	if not unit then unit = "boss1" else unit = unit end
	
	-- Track Channels/Casts
	if UnitCastingInfo(unit) then spell = UnitCastingInfo(unit) end
	if UnitChannelInfo(unit) then spell = UnitChannelInfo(unit) end

	-- Detect interrupt events
	if spell and (spell == GetSpellInfo(138763)
		or spell == GetSpellInfo(137457)
		or spell == GetSpellInfo(143343)) then
			if UnitCastingInfo("player") or UnitChannelInfo("player") then
				RunMacroText("/stopcasting")
				return false
			end
	end
	return true
end

-- Cancel a Channeled Spell
function cancelChannel(spell)
	local unitChannel = UnitChannelInfo("player")
	
	if unitChannel and (unitChannel == GetSpellInfo(MF) or unitChannel == GetSpellInfo(MFI)) then
		if mindFlay.curTicks < mindFlay.maxTicks - 1 or insanity.curTicks < insanity.maxTicks - 1 then
			CastSpellByName(GetSpellInfo(spell))
			return false
		end
	end
	return true
end
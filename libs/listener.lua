--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Listener Helper file for Hysteria Profiles
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
	Updated: 23:23 03.11.2013
]]
-- Initialize tables
if not hysteria then hysteria = {} end
if not mindFlay then mindFlay = {} end
if not insanity then insanity = {} end

-- Hysteria Event Listener
ProbablyEngine.listener.register("hysteria", "COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event			= select(2, ...)
	local source		= select(5, ...)
	local destGUID		= select(8, ...)
	local destination	= select(9, ...)
	local spellID		= select(12, ...)
	local spell			= select(13, ...)
	local damage		= select(15, ...)
	local critical		= select(21, ...)
	
	-- Capture DOT damage events
	if event == "SPELL_PERIODIC_DAMAGE" then
		if source == UnitName("player") then
			if spellID == MF then
				mindFlay.curTicks = mindFlay.curTicks + 1
			elseif spellID == MFI then
				insanity.curTicks = insanity.curTicks + 1
			end
		end
	end
	
	-- Capture Buff/Debuff application events
	if event == "SPELL_AURA_APPLIED" then
		if source == UnitName("player") then
			-- Nothing here yet
		end
	end
	
	-- Capture Buff/Debuff update events
	if event == "SPELL_AURA_REFRESH" then
		if source == UnitName("player") then
			if spellID == MF then
				mindFlay.curTicks = 0
				mindFlay.maxTicks = 4
			elseif spellID == MFI then
				insanity.curTicks = 0
				insanity.maxTicks = 4
			end
		end
	end
	
	-- Capture Buff/Debuff fading events
	if event == "SPELL_AURA_REMOVED" then
		if source == UnitName("player") then
			if spellID == MF then
				mindFlay.curTicks = 0
				mindFlay.maxTicks = 3
			elseif spellID == MFI then
				insanity.curTicks = 0
				insanity.maxTicks = 3
			end
		end
	end
end)

-- Listen to channel_start events
ProbablyEngine.listener.register("hysteria", "UNIT_SPELLCAST_CHANNEL_START", function(...)
	local unitID, spell, rank, lineID, spellID = ...
	
	if unitID == "player" then
		if spellID == MF then
			mindFlay.curTicks = 0
			mindFlay.maxTicks = 3
		elseif spellID == MFI then
			insanity.curTicks = 0
			insanity.maxTicks = 3
		end
	end
end)

-- Listen to channel_stop events
ProbablyEngine.listener.register("hysteria", "UNIT_SPELLCAST_CHANNEL_STOP", function(...)
	local unitID, spell, rank, lineID, spellID = ...
	if unitID == "player" then
		if spellID == MF then
			mindFlay.curTicks = 0
			mindFlay.maxTicks = 3
		elseif spellID == MFI then
			insanity.curTicks = 0
			insanity.maxTicks = 3
		end
	end
end)
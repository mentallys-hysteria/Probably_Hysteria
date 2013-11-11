--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Listener Helper file for Hysteria Profiles
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
]]
-- Initialize tables
if not hysteria then hysteria = {} end
if not mindFlay then mindFlay = {} end
if not insanity then insanity = {} end

-- Player Entering Combat
ProbablyEngine.listener.register("hysteria", "PLAYER_REGEN_DISABLED", function(...)
	if #hysteria.dot_tracker > 0 then hysteria.dot_tracker = {} end
end)

-- Player Leaving Combat
ProbablyEngine.listener.register("hysteria", "PLAYER_REGEN_ENABLED", function(...)
	if #hysteria.dot_tracker > 0 then hysteria.dot_tracker = {} end
end)

-- Combatlog Events
ProbablyEngine.listener.register("hysteria", "COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event			= select(2, ...)
	local source		= select(5, ...)
	local destGUID		= select(8, ...)
	local destination	= select(9, ...)
	local spellID		= select(12, ...)
	local spell			= select(13, ...)
	local damage		= select(15, ...)
	local critical		= select(21, ...)
	
	-- Spell Ticks
	local tick_every = hysteria.Round(3/(1+(UnitSpellHaste("player")/100)),2)
	
	-- Death Events
	if event == "UNIT_DIED" then
		if #hysteria.dot_tracker > 0 then
			for i=1,#hysteria.dot_tracker do
				if hysteria.dot_tracker[i].guid == destGUID then
					tremove(hysteria.dot_tracker, i)
					return true
				end
			end
		end
	end
	
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
			-- Shadow Word: Pain
			if spellID == SWP then
				for i=1,#hysteria.dot_tracker do if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then return false end end
				
				if UnitBuffID("player",138963) then
					table.insert(hysteria.dot_tracker, {guid = destGUID, swpPower = hysteria.dotPower(589), swp_tick_every = tick_every, spellID = spellID, crit = true})
				else
					table.insert(hysteria.dot_tracker, {guid = destGUID, swpPower = hysteria.dotPower(589), swp_tick_every = tick_every, spellID = spellID, crit = false})
				end
			end
			
			-- Vampiric Touch
			if spellID == VT then
				for i=1,#hysteria.dot_tracker do if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then return false end end
				
				if UnitBuffID("player",138963) then
					table.insert(hysteria.dot_tracker, {guid = destGUID, vtPower = hysteria.dotPower(34914), vt_tick_every = tick_every, spellID = spellID, crit = true})
				else
					table.insert(hysteria.dot_tracker, {guid = destGUID, vtPower = hysteria.dotPower(34914), vt_tick_every = tick_every, spellID = spellID, crit = false})
				end
			end
		end
	end
	
	-- Capture Buff/Debuff update events
	if event == "SPELL_AURA_REFRESH" then
		if source == UnitName("player") then
			-- Shadow Word: Pain
			if spellID == SWP then
				if #hysteria.dot_tracker > 0 then
					for i=1,#hysteria.dot_tracker do
						if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then
							hysteria.dot_tracker[i].swpPower = hysteria.dotPower(589)
							hysteria.dot_tracker[i].swp_tick_every = tick_every
							hysteria.dot_tracker[i].spellID = spellID
							if UnitBuffID("player",138963) then hysteria.dot_tracker[i].crit = true else hysteria.dot_tracker[i].crit = false end
						end
					end
				end
			end
			
			-- Vampiric Touch
			if spellID == VT then
				if #hysteria.dot_tracker > 0 then
					for i=1,#hysteria.dot_tracker do
						if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then
							hysteria.dot_tracker[i].vtPower = hysteria.dotPower(34914)
							hysteria.dot_tracker[i].vt_tick_every = tick_every
							hysteria.dot_tracker[i].spellID = spellID
							if UnitBuffID("player",138963) then hysteria.dot_tracker[i].crit = true else hysteria.dot_tracker[i].crit = false end
						end
					end
				end
			end
			
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
			-- Shadow Word: Pain
			if spellID == SWP then
				if #hysteria.dot_tracker > 0 then
					for i=1,#hysteria.dot_tracker do
						if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then
							tremove(hysteria.dot_tracker, i) return true end
					end
				end
			end
			
			-- Vampiric Touch
			if spellID == VT then
				if #hysteria.dot_tracker > 0 then
					for i=1,#hysteria.dot_tracker do
						if hysteria.dot_tracker[i].guid == destGUID and hysteria.dot_tracker[i].spellID == spellID then
							tremove(hysteria.dot_tracker, i) return true end
					end
				end
			end
				
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
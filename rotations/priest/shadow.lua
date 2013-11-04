--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Hysteria Shadow Priest PvE Profile
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
	Updated: 23:23 03.11.2013
]]
ProbablyEngine.rotation.register_custom(258, "Hysteria Priest", {
	-- Support Abilities
	{ "Inner Fire", "!player.buff(Inner Fire)" },
	{ "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
	{ "Shadowform", "!player.buff(Shadowform)" },
	{ "Power Word: Shield", {
		(function() if IsPlayerSpell(64129) then return true else return false end end),
		"player.moving"
	}},
	
	-- Priority List
	{ "Shadow Word: Death", {
		"player.spell(Shadow Word: Death).casted < 1",
		(function()return cancelChannel(SWD) end),
		"player.spell.cooldown(Mind Blast) > 0",
		"player.shadoworbs < 3",
		"target.health <= 20"
	}},
	{ "Devouring Plague", "player.shadoworbs = 3" },
	{ "Mind Blast", {
		(function()return cancelChannel(MB) end),
		"player.buff(Divine Insight)"
	}},
	{ "Mind Blast", (function()return cancelChannel(MB) end) },
	{ "Shadow Word: Death", {
		"player.spell(Shadow Word: Death).casted > 0",
		(function()return cancelChannel(SWD) end),
		"!target.debuff(Devouring Plague)",
		"target.health <= 20"
	}},
	{ "Mind Flay", {
		"target.debuff(Devouring Plague)",
		(function()return cancelChannel(MF) end)
	}},
	{ "Mind Spike", "player.buff(Surge of Darkness).count > 1" },
	{ "Mind Flay", (function()return cancelChannel(MF) end) },
}, {
	-- Always keep these buffs active
	{ "Inner Fire", "!player.buff(Inner Fire)" },
	{ "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
	{ "Shadowform", "!player.buff(Shadowform)" }
})
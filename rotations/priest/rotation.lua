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
	-- At any point during combat, should we die and get ressurected, rebuff!
	{ "Inner Fire", "!player.buff(Inner Fire)" },
	{ "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
	{ "Shadowform", "!player.buff(Shadowform)" },
	
	-- Priority List
	{ "Mind Blast" },
	{ "Mind Blast", "player.buff(Divine Insight)" },
	{ "Devouring Plague", "player.shadoworbs = 3" },
	{ "Mind Flay", "target.debuff(Devouring Plague)" },
	{ "Mind Flay" },
}, {
	-- Always keep these buffs active
	{ "Inner Fire", "!player.buff(Inner Fire)" },
	{ "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
	{ "Shadowform", "!player.buff(Shadowform)" }
})
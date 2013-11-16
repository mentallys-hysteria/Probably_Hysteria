--[[
	==============================================================
	Mentally's Hysteria - A ProbablyEngine Custom Rotation Package
	- Based upon Mentally's Hysteria PQR Rotations
	
	:: Hysteria Shadow Priest PvE Profile
	
	Help, suggestions and discussion thread:
	https://probablyengine.com/forum/viewtopic.php?id=107
	==============================================================
]]
ProbablyEngine.rotation.register_custom(258, "Hysteria Priest", {
	-- In-combat rebuffing
	{"588", "!player.buff(588)" },
	{"21562", "@hysteria.checkRaidBuff(2)"},
	{"15473", "!player.buff(15473)" },
	
	-- Available Cooldowns
	{{
		{"34433", "@hysteria.cancelChannel(123040)"},
		{"121279", {"player.spell(121279).exists", "@hysteria.cancelChannel(121279)"}},
		{"26297", {"player.spell(26297).exists", "@hysteria.cancelChannel(26297)"}},
		{"10060", {"player.spell(10060).exists", "@hysteria.cancelChannel(10060)"}},
		{"#gloves"}
	},{
		"modifier.cooldowns",
		"@hysteria.immunities"
	}},
	
	-- Single target rotation
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		"@hysteria.cancelChannel(SWD)"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(32379).cooldown < 1.5",
		"@hysteria.cancelChannel(DP)"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(8092).cooldown < 1.5",
		"@hysteria.cancelChannel(DP)"
	}},
	{"8092", {
		"!player.moving",
		"@hysteria.cancelChannel(MB)"
	}},
	{"8092", {
		"player.buff(124430)",
		"@hysteria.cancelChannel(MB)"
	}},
	--{"pause", "player.spell(8092).cooldown < 0.5"},
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.cancelChannel(SWD)"
	}},
	{"15407", {
		"!player.moving",
		"target.debuff(2944)",
		"player.spell(139139).exists",
		"@hysteria.cancelChannel(MF)"
	}},
	{"589", {
		"!target.debuff(589)",
		"@hysteria.cancelChannel(SWP)"
	}},
	{"34914", {
		"!player.moving",
		"!target.debuff(34914)",
		"!modifier.last(34914)",
		"@hysteria.cancelChannel(VT)"
	}},
	{"589", {
		(function()return hysteria.calculateDot(SWP, "target") end),
		"@hysteria.cancelChannel(SWP)"
	}},
	{"34914", {
		"!player.moving",
		"!modifier.last(34914)",
		(function()return hysteria.calculateDot(VT, "target") end),
		"@hysteria.cancelChannel(VT)"
	}},
	{"2944", {
		"player.shadoworbs = 3",
		(function()return hysteria.calculateDot(DP, "target") end),
		"@hysteria.cancelChannel(DP)"
	}},
	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 2",
		"@hysteria.cancelChannel(MS)"
	}},
	{"120644", {
		"player.spell(120517).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.cancelChannel(Halo)"
	}},
	{"121135", {
		"player.spell(121135).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.cancelChannel(Cascade)"
	}},
	{"110744", {
		"player.spell(110744).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.cancelChannel(Star)"
	}},
	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 1",
		"@hysteria.cancelChannel(MS)"
	}},
	{"15407", "@hysteria.cancelChannel(MF)"}
}, {
	-- Out of Combat buffing
	{"588", "!player.buff(588)" },
	{"21562", "@hysteria.checkRaidBuff(2)"},
	{"15473", "!player.buff(15473)" },
})
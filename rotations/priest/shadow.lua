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
	{"588", {"player.spell(588).exists", "!player.buff(588)"}},
	{"21562", {"player.spell(21562).exists", "@hysteria.checkRaidBuff(2)"}},
	{"15473", {"player.spell(15473).exists", "!player.buff(15473)"}},
	
	-- Movement speed increase, only when talented!
	{"17", {
		"player.moving",
		"player.spell(64129).exists"
	}},
	
	-- Defensive abilities
	--{"#Healthstone", "player.health <= 40"},
	{"15286", {
		"player.health <= 40",
		"player.shadoworbs = 3",
		"player.spell(15286).cooldown = 0",
		"@hysteria.validate('player', Embrace)"
	}},
	{"586", {
		"player.threat > 95",
		"player.spell(586).cooldown = 0",
		"@hysteria.validate('player', Fade)"
	}},
	{"19236", {
		"player.health <= 40",
		"player.spell(19236).cooldown = 0",
		"@hysteria.validate('player', DPrayer)"
	}},
	{"47585", {
		"modifier.rshift",
		"player.spell(47585).cooldown = 0",
		"@hysteria.validate('player', Disp)"
	}},
	{"32375",{
		"modifier.ralt",
		"player.spell(32375).cooldown = 0",
		"@hysteria.validate('player', MDisp)"
	}, "ground"},
	
	-- Available Cooldowns
	{{
		{"34433", "@hysteria.validate('target', 34433)"},
		{"121279", {"player.spell(121279).exists", "@hysteria.validate('target', 121279)"}},
		{"26297", {"player.spell(26297).exists", "@hysteria.validate('target', 26297)"}},
		{"10060", {"player.spell(10060).exists", "@hysteria.validate('target', 10060)"}},
		{"#gloves"}
	}, "modifier.cooldowns"},
	
	-- Aoe Rotation
	{"48045", {"modifier.lshift", "@hysteria.validate('target', MSear)"}},
	
	-- Single target rotation
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		"@hysteria.validate('target', SWD)"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(32379).cooldown < 1.5",
		"@hysteria.validate('target', DP)"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(8092).cooldown < 1.5",
		"@hysteria.validate('target', DP)"
	}},
	{"2944", {
		"player.shadoworbs = 3",
		"@hysteria.calculateDot('target', DP)",
		"@hysteria.validate('target', DP)"
	}},
	{"8092", {
		"!player.moving",
		"@hysteria.validate('target', MB)"
	}},
	{"8092", {
		"player.buff(124430)",
		"@hysteria.validate('target', MB)"
	}},
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate('target', SWD)"
	}},
	{"15407", {
		"!player.moving",
		"target.debuff(2944)",
		"player.spell(139139).exists",
		"@hysteria.validate('target', MF)"
	}},

	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 2",
		"@hysteria.validate('target', MS)"
	}},
	{"120644", {
		"player.spell(120517).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate('target', Halo)"
	}},
	{"121135", {
		"player.spell(121135).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate('target', Cascade)"
	}},
	{"110744", {
		"player.spell(110744).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate('target', Star)"
	}},
	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 1",
		"@hysteria.validate('target', MS)"
	}},
	{"15407", "@hysteria.validate('target', MF)"}
}, {
	-- Out of Combat buffing
	{"588", {"player.spell(588).exists", "!player.buff(588)"}},
	{"21562", {"player.spell(21562).exists", "@hysteria.checkRaidBuff(2)"}},
	{"15473", {"player.spell(15473).exists", "!player.buff(15473)"}},
	
	-- Test
	{"48045", {"modifier.lshift", "@hysteria.validate(MSear, 'target')"}}
	
})

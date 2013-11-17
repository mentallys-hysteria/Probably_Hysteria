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
		"@hysteria.validate(Embrace, 'player')"
	}},
	{"586", {
		"player.threat > 95",
		"player.spell(586).cooldown = 0",
		"@hysteria.validate(Fade, 'player')"
	}},
	{"19236", {
		"player.health <= 40",
		"player.spell(19236).cooldown = 0",
		"@hysteria.validate(DPrayer, 'player')"
	}},
	{"47585", {
		"modifier.rshift",
		"player.spell(47585).cooldown = 0",
		"@hysteria.validate(Disp, 'player')"
	}},
	{"32375",{
		"modifier.ralt",
		"player.spell(32375).cooldown = 0",
		"@hysteria.validate(MDisp, 'player')"
	}, "ground"},
	
	-- Available Cooldowns
	{{
		{"34433", "@hysteria.validate(34433, 'target')"},
		{"121279", {"player.spell(121279).exists", "@hysteria.validate(121279, 'target')"}},
		{"26297", {"player.spell(26297).exists", "@hysteria.validate(26297, 'target')"}},
		{"10060", {"player.spell(10060).exists", "@hysteria.validate(10060, 'target')"}},
		{"#gloves"}
	}, "modifier.cooldowns"},
	
	-- Aoe Rotation
	{"48045", {"modifier.lshift", "@hysteria.validate(MSear, 'target')"}},
	
	-- Single target rotation
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		"@hysteria.validate(SWD, 'target')"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(32379).cooldown < 1.5",
		"@hysteria.validate(DP, 'target')"
	}},
	{"2944", {
		"target.health <= 20",
		"player.shadoworbs = 3",
		"player.spell(8092).cooldown < 1.5",
		"@hysteria.validate(DP, 'target')"
	}},
	{"2944", {
		"player.shadoworbs = 3",
		"@hysteria.calculateDot(DP, 'target')",
		"@hysteria.validate(DP, 'target')"
	}},
	{"8092", {
		"!player.moving",
		"@hysteria.validate(MB, 'target')"
	}},
	{"8092", {
		"player.buff(124430)",
		"@hysteria.validate(MB, 'target')"
	}},
	{"32379", {
		"target.health <= 20",
		"!modifier.last(32379)",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate(SWD, 'target')"
	}},
	{"15407", {
		"!player.moving",
		"target.debuff(2944)",
		"player.spell(139139).exists",
		"@hysteria.validate(MF, 'target')"
	}},
	{"589", {
		"!target.debuff(589)",
		"@hysteria.validate(SWP, 'target')"
	}},
	{"34914", {
		"!player.moving",
		"!target.debuff(34914)",
		"!modifier.last(34914)",
		"@hysteria.validate(VT, 'target')"
	}},
	{{
		{"589", {"!modifier.last(589)", "@hysteria.calculateDot(589, 'target')"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(34914, 'target')"}},
	},{ 
		"@hysteria.validate(VT, 'target')",
		"!player.moving"
	}},
	-------------------- BOSS DOTTING --------------------
	{{
		{"589", {"!modifier.last(589)", "@hysteria.calculateDot(SWP, 'boss1')", "boss1"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(VT, 'boss1')", "boss1"}},
		{"589", {"!modifier.last(589)", "@hysteria.calculateDot(SWP, 'boss2')", "boss2"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(VT, 'boss2')", "boss2"}},
		{"589", {"!modifier.last(589)", "@hysteria.calculateDot(SWP, 'boss3')", "boss3"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(VT, 'boss3')", "boss3"}},
		{"589", {"!modifier.last(589)", "@hysteria.calculateDot(SWP, 'boss4')", "boss4"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(VT, 'boss4')", "boss4"}},
		{"589", {"!modifier.last(589)","@hysteria.calculateDot(SWP, 'boss5')", "boss5"}},
		{"34914", {"!modifier.last(34914)", "@hysteria.calculateDot(VT, 'boss5')", "boss5"}},
	},{
		"@hysteria.validate(VT, 'Multi')",
		"!player.moving",
		"toggle.bossDotting"
	}},
	-------------------- BOSS DOTTING --------------------
	-------------------- MULTIDOTTING --------------------
	{{
		{"589",{"!modifier.last(589)", "@hysteria.calculateDot(589, 'mouseover')", "mouseover"}},
		{"34914",{"!modifier.last(34914)", "@hysteria.calculateDot(34914, 'mouseover')", "mouseover"}},
		{"589",{"!modifier.last(589)", "@hysteria.calculateDot(589, 'focus')", "focus"}},
		{"34914",{"!modifier.last(34914)", "@hysteria.calculateDot(34914, 'focus')", "focus"}},
	},{ 
		"@hysteria.validate(VT, 'Multi')",
		"!player.moving",
		"modifier.multitarget"
	}},
	-------------------- MULTIDOTTING --------------------
	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 2",
		"@hysteria.validate(MS, 'target')"
	}},
	{"120644", {
		"player.spell(120517).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate(Halo, 'target')"
	}},
	{"121135", {
		"player.spell(121135).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate(Cascade, 'target')"
	}},
	{"110744", {
		"player.spell(110744).exists",
		(function()
			if IsPlayerSpell(139139) then
				if UnitDebuff("target",GetSpellInfo(DP),"PLAYER") then return false else return true end
			else return true end end),
		"@hysteria.validate(Star, 'target')"
	}},
	{"73510", {
		"player.spell(109186).exists",
		"player.buff(87160).count = 1",
		"@hysteria.validate(MS, 'target')"
	}},
	{"15407", "@hysteria.validate(MF, 'target')"}
}, {
	-- Out of Combat buffing
	{"588", {"player.spell(588).exists", "!player.buff(588)"}},
	{"21562", {"player.spell(21562).exists", "@hysteria.checkRaidBuff(2)"}},
	{"15473", {"player.spell(15473).exists", "!player.buff(15473)"}},
	
	-- Test
	{"48045", {"modifier.lshift", "@hysteria.validate(MSear, 'target')"}}
	
})

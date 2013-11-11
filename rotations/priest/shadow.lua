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
	-- In-combat buffing
	{"Inner Fire", "!player.buff(Inner Fire)" },
	{"Power Word: Fortitude", "@hysteria.checkRaidBuff(2)"},
	{"Shadowform", "!player.buff(Shadowform)" },
	{"Power Word: Shield", {
		(function()if IsPlayerSpell(64129) then return true else return false end end),
		"player.moving",
	}},
	
	-- Support Abilities
	{"Vampiric Embrace", {
		"player.health <= 40",
		"@hysteria.immunities",
		"player.shadoworbs = 3"
	}},
	{"!/use Healthstone", "player.health <= 40"},
	{"Desperate Prayer", {
		"player.health <= 40",
		"player.spell(19236).exists"
	}},
	
	-- Defensive Abilities
	{"Dispersion", {
		"modifier.rshift",
		"!spell.cooldown(Dispersion)",
		"@hysteria.cancelChannel(Disp)"
	}},
	{"Mass Dispel", {
		"modifier.ralt",
		"!player.moving",
		"!spell.cooldown(Mass Dispel)",
		"@hysteria.cancelChannel(MDisp)"
	},"ground"},
	{"Fade", "player.threat > 95"},
	
	-- Cooldowns
	{{
		{"Mindbender",{
			"player.spell(123040).exists",
			"@hysteria.cancelChannel(123040)"}},
		{"Shadowfiend",{
			"player.spell(34433).exists",
			"@hysteria.cancelChannel(34433)"}},
		{"Lifeblood",{
			"player.spell(121279).exists",
			"@hysteria.cancelChannel(121279)"}},
		{"Berserking",{
			"player.spell(26297).exists",
			"@hysteria.cancelChannel(26297)"}},
		{"Power Infusion",{
			"player.spell(10060).exists",
			"@hysteria.cancelChannel(10060)"}},
		{"#gloves"},
	},{
		"modifier.cooldowns",
		"@hysteria.immunities"
	}},
	
	-- Priority List
	{"Shadow Word: Death", {
		"target.health <= 20",
		"player.spell(Shadow Word: Death).casted < 1",
		"@hysteria.cancelChannel(SWD)"
	}},
	{"Devouring Plague", {
		"target.health <= 20",
		"player.shadoworbs < 3",
		"player.spell.cooldown(Shadow Word: Death) < 1.5",
		"@hysteria.cancelChannel(DP)"
	}},
	{"Devouring Plague", {
		"target.health <= 20",
		"player.shadoworbs < 3",
		"player.spell.cooldown(Mind Blast) < 1.5",
		"@hysteria.cancelChannel(DP)"
	}},
	{"Mind Blast", {"@hysteria.cancelChannel(MB)","!player.moving"}},
	{"Mind Blast", {"player.buff(Divine Insight)","@hysteria.cancelChannel(MB)"}},
	{"Shadow Word: Death", {
		"target.health <= 20",
		"!target.debuff(Devouring Plague)",
		"player.spell(Shadow Word: Death).casted < 1",
		"@hysteria.cancelChannel(SWD)"
	}},
	{"Mind Flay", {
		"!player.moving",
		"player.spell(139139).exists",
		"target.debuff(Devouring Plague)",
		"@hysteria.cancelChannel(MF)"
	}},
	{"Shadow Word: Pain", {
		"!target.debuff(Shadow Word: Pain)",
		"@hysteria.cancelChannel(SWP)"
	}},
	{"Vampiric Touch", {
		"!player.moving",
		"player.spell(Vampiric Touch).casted < 1",
		"!target.debuff(Vampiric Touch)",
		"@hysteria.cancelChannel(VT)"
	}},
	{"Shadow Word: Pain", {
		(function()return hysteria.calculateDot(SWP, "target") end),
		"@hysteria.cancelChannel(SWP)"
	}},
	{"Vampiric Touch", {
		"!player.moving",
		"player.spell(Vampiric Touch).casted < 1",
		(function()return hysteria.calculateDot(VT, "target") end),
		"@hysteria.cancelChannel(VT)"
	}},
	{"Devouring Plague", {
		"player.shadoworbs = 3",
		(function()return hysteria.calculateDot(DP, "target") end),
		"@hysteria.cancelChannel(DP)"
	}},
	{"Mind Spike", {
		"player.spell(109186).exists",
		"player.buff(Surge of Darkness).count = 2",
		"@hysteria.cancelChannel(MS)"
	}},
	{"Halo", {
		"player.spell(120517).exists",
		(function()return hysteria.talentCheck(139139, "target") end),
		"@hysteria.cancelChannel(DarkHalo)"
	}},
	{"Cascade", {
		"player.spell(121135).exists",
		(function()return hysteria.talentCheck(139139, "target") end),
		"@hysteria.cancelChannel(DCascade)"
	}},
	{"Divine Star", {
		"player.spell(110744).exists",
		(function()return hysteria.talentCheck(139139, "target") end),
		"@hysteria.cancelChannel(DStar)"
	}},
	{"Mind Spike", {
		"player.spell(109186).exists",
		"player.buff(Surge of Darkness).count = 1",
		"@hysteria.cancelChannel(MS)"
	}},
	{"Mind Flay", {"!player.moving","@hysteria.cancelChannel(MF)"}},
	
	-- Movement
	{"Shadow Word: Death", {
		"player.moving",
		"target.health <= 20",
		"!spell.cooldown(Shadow Word: Death)"
	}},
	{"Mind Blast", {"player.moving", "player.buff(Divine Insight)"}},
	{"Shadow Word: Pain", {"player.moving", "player.mana > 75"}}
}, {
	-- Out of Combat buffing
	{"Inner Fire", "!player.buff(Inner Fire)" },
	{"Power Word: Fortitude", "@hysteria.checkRaidBuff(2)"},
	{"Shadowform", "!player.buff(Shadowform)" },
})
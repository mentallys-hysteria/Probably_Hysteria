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
	-- In-combat buffing. Just in case we die.
	{"588", {"player.spell(588).exists","!player.buff(588)"}, "player"},
	{"21562", {"player.spell(21562).exists","@hysteria.checkRaidBuff(2)"}, "player"},
	{"15473", {"player.spell(15473).exists","!player.buff(15473)"}, "player"},
	
	-- Body and Soul; Activate on movement when talented
	{"17", {"player.moving","player.spell(64129).exists"}, "player"},
	
	-- Defensive Abilities, just for when things go Oh-shit!
	{"#5512", "player.health <= 40", "player"},
	{"15286", {"player.health <= 40","player.shadoworbs = 3","player.spell(15286).cooldown = 0","@hysteria.clip(Embrace)"}, "player"},
	{"586", {"player.threat >= 95","player.spell(586).cooldown = 0","@hysteria.clip(Fade)"}, "player"},
	--{"19236", {"player.health <= 40","player.spell(19236).cooldown = 0","@hysteria.clip(DPrayer)"}, "player"},
	{"47585", {"modifier.rshift","player.spell(47585).cooldown = 0","@hysteria.clip(Disp)"}, "player"},
	{"32375", {"modifier.ralt","player.spell(32375).cooldown = 0","@hysteria.clip(MDisp)"}, "ground"},
	
	-- Available Cooldowns
	{{
		{"34433", "@hysteria.clip(34433)", "target"},
		{"121279", {"player.spell(121279).exists","@hysteria.clip(121279)"}, "player"},
		{"26297", {"player.spell(26297).exists","@hysteria.clip(26297)"}, "player"},
		{"10060", {"player.spell(10060).exists","@hysteria.clip(10060)"}, "player"},
		{"#gloves"}
	}, {"modifier.cooldowns"}},
	
	-- Shadow AoE; Mind Sear it.
	{"48045", {"modifier.lshift","@hysteria.clip(MSear)"}, "target"},
	
	-- Automated Level 90 Talent abilities can be...bad.. Toggle it!
	{"120644", {
		"modifier.lalt",
		"player.spell(120517).exists",
		"@hysteria.clip(Halo)"
	}},
	{"121135", {
		"modifier.lalt",
		"player.spell(121135).exists",
		"@hysteria.clip(Cascade)"
	}},
	{"110744", {
		"modifier.lalt",
		"player.spell(110744).exists",
		"@hysteria.clip(Star)"
	}},
	
	-- Shadow Priest Standard Rotation
	-- Should we..? Yes we should..
	{{
		{"32379", {"target.health <= 20","!modifier.last(32379)","@hysteria.clip(SWD)"}, "target"},
		
		-- Only invoke when we're starting with Orbs
		{"589", {"!target.debuff(589)","player.shadoworbs = 3","@hysteria.clip(589)"}, "target"},
		{"34914", {"!player.moving","!modifier.last(34914)","!target.debuff(34914)","player.shadoworbs = 3","@hysteria.interrupts('target')","@hysteria.clip(34914)"}, "target"},
		
		{"2944", {"player.shadoworbs = 3","@hysteria.calculateDot('target', DP)","@hysteria.clip(DP)"}, "target"},
		{"8092", {"!player.moving","@hysteria.interrupts('target')","@hysteria.clip(MB)"}, "target"},
		{"8092", {"player.buff(124430)","@hysteria.interrupts('target')","@hysteria.clip(MB)"}, "target"},
		{"32379", {
			"target.health <= 20",
			"!modifier.last(32379)",
			(function()
				if IsPlayerSpell(139139) then
					if UnitDebuffID("target",PD,"PLAYER") then return false else return true end
				else return true end end),
			"@hysteria.clip(SWD)"
		}, "target"},
		{"15407", {"!player.moving","target.debuff(2944)","player.spell(139139).exists","@hysteria.interrupts('target')","@hysteria.clip(MF)"}, "target"},
		
		-- Boss Dotting
		{{
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('Boss1')","@hysteria.calculateDot('Boss1',34914)","@hysteria.clip(34914,'Boss1')","spell(34914).range"},"Boss1"},
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('Boss2')","@hysteria.calculateDot('Boss2',34914)","@hysteria.clip(34914,'Boss2')","spell(34914).range"},"Boss2"},
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('Boss3')","@hysteria.calculateDot('Boss3',34914)","@hysteria.clip(34914,'Boss3')","spell(34914).range"},"Boss3"},
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('Boss4')","@hysteria.calculateDot('Boss4',34914)","@hysteria.clip(34914,'Boss4')","spell(34914).range"},"Boss4"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('Boss1',589)","@hysteria.clip(589,'Boss1')","spell(589).range"},"Boss1"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('Boss2',589)","@hysteria.clip(589,'Boss2')","spell(589).range"},"Boss2"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('Boss3',589)","@hysteria.clip(589,'Boss3')","spell(589).range"},"Boss3"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('Boss4',589)","@hysteria.clip(589,'Boss4')","spell(589).range"},"Boss4"},
		}, "toggle.bossDotting"},
		
		-- Dotting
		{"589", {"@hysteria.calculateDot('target',589)","@hysteria.clip(589)"}, "target"},
		{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.calculateDot('target',34914)","@hysteria.interrupts('target')","@hysteria.clip(34914)"}, "target"},
		
		-- Multidotting
		{{
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('focus')","@hysteria.calculateDot('focus',34914)","@hysteria.clip(34914,'focus')"},"focus"},
			{"34914", {"!player.moving","!modifier.last(34914)","@hysteria.interrupts('mouseover')","@hysteria.calculateDot('mouseover',34914)","@hysteria.clip(34914,'mouseover')"},"mouseover"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('focus',589)","@hysteria.clip(589,'focus')"},"focus"},
			{"589", {"player.spell(589).exists","@hysteria.calculateDot('mouseover',589)","@hysteria.clip(589,'mouseover')"},"mouseover"},
		}, "modifier.multitarget"},
		
		{"73510", {"player.spell(109186).exists","player.buff(87160).count = 2","@hysteria.clip(MS)"}, "target"},
		{"73510", {"player.spell(109186).exists","player.buff(87160).count = 1","@hysteria.clip(MS)"}, "target"},
		{"15407", {"@hysteria.interrupts('target')","@hysteria.clip(MF)"}, "target"}		
	}, {"player.buff(15473)", "@hysteria.immunities('target')"}}
}, {
	-- Out of Combat buffing
	{"588", {"player.spell(588).exists", "!player.buff(588)"}, "player"},
	{"21562", {"player.spell(21562).exists", "@hysteria.checkRaidBuff(2)"}, "player"},
	{"15473", {"player.spell(15473).exists", "!player.buff(15473)"}, "player"}
}, function()
	-- Boss Dotting
	ProbablyEngine.toggle.create(
		'bossDotting',
		'Interface\\ICONS\\inv_jewelry_orgrimmarraid_trinket_13',
		'Boss-dotting',
	"Enable/Disable automatic dotting\n of all boss units in range!")
end)
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
-- Load the Hysteria array
if not hysteria then hysteria = {} end

-- Set Priest abilities
if select(2,UnitClass("player")) == "PRIEST" then
	-- Skill IDs
	DP			= 2944			-- Devouring Plague
	SWD			= 32379			-- Shadow Word: Death
	MB			= 8092			-- Mind Blast
	SWP			= 589			-- Shadow Word: Pain
	VT			= 34914			-- Vampiric Touch
	MS			= 73510			-- Mind Spike
	MF			= 15407			-- Mind Flay
	MFI			= 129197		-- Mind Flay (Insanity)
	MSear		= 48045			-- Mind Sear
	
	-- Defensive Abilities
	MDisp		= 32375			-- Mass Dispel
	
	-- Cooldowns
	SF			= 34433			-- Shadowfiend
	Disp		= 47585			-- Dispersion
	DPrayer		= 19236			-- Desperate Prayer
	Fade		= 586			-- Fade
	Silence		= 15487			-- Silence
	Spectral	= 112833		-- Spectral Guise
	Scream		= 8122			-- Psychic Scream
	Embrace		= 15286			-- Vampiric Embrace
	Symbiosis	= 113277			-- Symbiosis: Tranquility
	
	-- Buffs
	IF			= 588			-- Inner Fire
	SForm		= 15473			-- Shadow Form
	PWF			= 21562			-- Power Word: Fortitude
	GMS			= 81292			-- Glyph of Mind Spike
	Shield		= 17			-- Power Word: Shield
	POM			= 33076			-- Prayer of Mending
	Renew		= 139			-- Renew
	Phan		= 108942		-- Phantasm
	Fear		= 6346			-- Fear Ward
	
	-- Procs
	SOD			= 87160 		-- Surge of Darkness
	DI			= 124430		-- Divine Insight
	
	-- Talents
	PI			= 10060			-- Power Infusion
	FDCL		= 109186		-- From Darkness, Comes Light
	Solace		= 129250		-- Power Word: Solace
	SnI			= 139139		-- Shadow Word: Insanity
	MBen		= 123040		-- Mindbender
	Halo		= 120517		-- Halo
	DarkHalo	= 120644		-- Dark Halo
	Cascade		= 121135		-- Cascade
	DCascade 	= 127632		-- Dark Cascade
	Star		= 110744		-- Divine Star
	DStar		= 122121		-- Dark Star
end
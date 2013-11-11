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

if not hysteria then hysteria = {} end
-- Set Priest abilities

if select(2,UnitClass("player")) == "PRIEST" then

        -- Skill IDs
        DP = 2944               -- Devouring Plague
        SWD = 32379             -- Shadow Word: Death
        MB = 8092               -- Mind Blast
        SWP = 589               -- Shadow Word: Pain
        VT = 34914              -- Vampiric Touch
        MS = 73510              -- Mind Spike
        MF = 15407              -- Mind Flay
        MFI = 129197            -- Mind Flay (Insanity)
        MSear = 48045           -- Mind Sear
        
        -- Defensive Abilities
        MDisp = 32375           -- Mass Dispel
        
        -- Cooldowns
        SF = 34433              -- Shadowfiend
        Disp = 47585            -- Dispersion
        DPrayer = 19236         -- Desperate Prayer
        Fade = 586              -- Fade
        Silence = 15487         -- Silence
        Spectral = 112833       -- Spectral Guise
        Scream = 8122           -- Psychic Scream
        Embrace = 15286         -- Vampiric Embrace
        Symbiosis = 113277          -- Symbiosis: Tranquility
        
        -- Buffs
        IF = 588                -- Inner Fire
        SForm = 15473           -- Shadow Form
        PWF = 21562             -- Power Word: Fortitude
        GMS = 81292             -- Glyph of Mind Spike
        Shield = 17             -- Power Word: Shield
        POM = 33076             -- Prayer of Mending
        Renew = 139             -- Renew
        Phan = 108942           -- Phantasm
        Fear = 6346             -- Fear Ward
        
        -- Procs
        SOD = 87160             -- Surge of Darkness
        DI = 124430             -- Divine Insight
        
        -- Talents
        PI = 10060              -- Power Infusion
        FDCL = 109186           -- From Darkness, Comes Light
        Solace = 129250         -- Power Word: Solace
        SnI = 139139            -- Shadow Word: Insanity
        MBen = 123040           -- Mindbender
        Halo = 120517           -- Halo
        DarkHalo = 120644       -- Dark Halo
        Cascade = 121135        -- Cascade
        DCascade = 127632       -- Dark Cascade
        Star = 110744           -- Divine Star
        DStar = 122121          -- Dark Star
		
elseif select(2,UnitClass("player")) == "WARLOCK" then

        -- Abilities
        -- Affliction Specific
        Cor = 172               -- Corruption
        AG = 980                -- Agony
        DS = 1120               -- Drain Soul
        UA = 30108              -- Unstable Affliction
        Haunt = 48181           -- Haunt
        SB = 74434              -- Soulburn
        SS = 86121              -- Soul Swap
        SSE = 86213             -- Soul Swap: Exhale
        MG = 103103             -- Malefic Grasp

        -- Demonology Specific
        Doom = 603              -- Metamorphosis: Doom
        ShadowBolt = 686        -- Shadow Bolt
        Hellfire = 1949         -- Hellfire
        SoulFire = 6353         -- Soul Fire
        Meta = 103958           -- Metamorphosis
        ToC = 103964            -- Metamorphosis: Touch of Chaos
        Swarm = 103967          -- Carrion Swarm
        ImmoAura = 104025       -- Metamorphosis: Immolation Aura
        GulDan = 105174         -- Hand of Gul'dan
        ChaosWave = 124916      -- Chaos Wave
        TW = 6229               -- Twilight Ward
        
		-- Destruction
        Shadowburn = 17877      -- Shadowburn
        IN = 29722              -- Incinerate
        Conflag = 17962         -- Conflagrate
        Havoc = 80240           -- Take a wild guess...
        RF = 104232             -- Rain of Fire
        FB = 108683             -- Fire and Brimstone
        CB = 116858             -- Chaos Bolt
        if UnitBuffID("player",108683) then Immolate = 108686 else Immolate = 348 end -- Immolate		
        -- Available to all Specs
        DL = 689                -- Drain Life
        HF = 755                -- Health Funnel
        Soulstone = 20707       -- Soulstone
        Shatter = 29858         -- Soulshatter
        FelFlame = 77799        -- Fel Flame
        Symbiosis = 113295      -- Symbiosis: Rejuvenation
     
        -- Spec Cooldowns
        SIF = 1122              -- Summon Infernal
        SDM = 18540             -- Summon Doomguard
        UR = 104773             -- Unending Resolve
        DSI = 113858            -- Dark Soul: Instability
        DSM = 113860            -- Dark Soul: Misery
        DSK = 113861            -- Dark Soul: Knowledge
        SAY = 112921            -- Summon Abyssal
        STG = 112927            -- Summon Terrorguard
        
        -- Buffs
        ST = 17941              -- Shadow Trance
        SSE2 = 86211            -- Soul Swap: Exhale
        DI = 109773             -- Dark Intent
        MCore = 122351          -- Molten Core
        BD = 117896             -- Backdraft
        
        -- Hand of Gul'dan DoT component
        SFlame = 47960          -- Shadowflame
        
        -- Magic Vulnerability Debuffs
        COTE = 1490             -- Curse of the Elements
        MP = 58410              -- Master Poisoner
        FB = 34889              -- Fire Breath
        LB = 24844              -- Lightning Breath
        AOTE = 116202           -- Aura of the Elements
        
        -- Talents
        DR = 108359             -- Dark Regeneration
        SL = 108370             -- Soul Leech
        HL = 108371             -- Harvest Life
        HOT = 5484              -- Howl of Terror
        DBreath = 47897         -- Demonic Breath
        MC = 6789               -- Mortal Coil
        SF = 30283              -- Shadowfury
        Soul = 108415           -- Soul Link
        SP = 108416             -- Sacrificial Pact
        DB = 110913             -- Dark Bargain
        DBD = 110913            -- Dark Bargain DOT
        BF = 111397             -- Blood Fear
        BR = 111400             -- Burning Rush
        UW = 108482             -- Unbound Will
        Supremacy = 108499      -- Grimoire of Supremacy
        Service = 108501        -- Grimoire of Service
        Sacrifice = 108503      -- Grimoire of Sacrifice
        AV = 108505             -- Archimonde's Vengeance
        KC = 137587             -- Kil'jaeden's Cunning
        MF = 108508             -- Mannoroth's Fury
        
        -- Pets
        Imp = 688               -- Summon Imp
        Voidwalker = 697        -- Summon Voidwalker
        Succubus = 712          -- Summon Succubus
        Felhunter = 691         -- Summon Felhunter
        Felguard = 30146        -- Summon Felguard
        
        -- Grimoire of Service Summons
        GImp = 111859           -- Grimoire: Imp
        GVoidwalker = 111895    -- Grimoire: Voidwalker
        GSuccubus = 111896      -- Grimoire: Succubus
        GFelhunter = 111897     -- Grimoire: Felhunter
        GFelguard = 111898      -- Grimoire: Felguard

elseif select(2, UnitClass("player")) == "SHAMAN" then

        -- Abilities
        EQ = 61882              -- EarthQuake
		LavaB = 61882           -- Lava Burst
		SRage = 30823           -- Shamanistic Rage
		LBolt = 403             -- Lightning Bolt
		PStrike = 73899         -- Primal Strike
		EShock = 8042           -- Earth Shock
		HSurge = 8004           -- Healing Surge
		LShield = 324           -- Lightning Shield
		FWeapon = 8024          -- Flametongue Weapon
		FShock = 8050           -- Flame Shock
		Purge = 370             -- Purge
		ASpirit = 2008          -- Ancestral Spirit
		GWolf = 2645            -- Ghost Wolf
		CSpirit = 51886         -- Cleanse Spirit
		WShear = 57994          -- Wind Shear
		WShield = 52127         -- Water Shield
		CHeal = 1064            -- Chain Heal
		FWeapon = 8033          -- Frostbrand Weapon
		Reincar = 20608         -- Reincarnation
		FSight = 6196           -- Far Sight
		FShock = 8056           -- Frost Shock
		WWalking = 546          -- Water Walking
		FAttack = 8034          -- Frostbrand Attack
		CLightning = 421        -- Chain Lightning
		TRecall = 36936         -- Totemic Recall
		HRain = 73920           -- Healing Rain
		Bloodlust = 2825        -- Bloodlust(Horde)
		Heroism = 32182         -- Heroism(Alliance)
	
		-- Totems
		STotem = 3599           -- Searing Totem
		ETotem = 2484           -- Earthbind Totem
		MTotem = 8190           -- Magma Totem
        GTotem = 8177     		-- Grounding Totem
		TTotem = 8143           -- Tremor Totem
		HTTotem = 108280        -- Healing Tide Totem
		EETotem = 2062          -- Earth Elemental Totem
		FETotem = 2894          -- Fire Elemental Totem
		StormTotem = 120668     -- Stormlash Totem
		
elseif select(2, UnitClass("player")) == "MAGE" then

        -- Skills IDs
        Frostbolt = 116         -- Frostbolt
        FFB = 44614             -- Frostfire Bolt
        IL = 30455              -- Ice Lance
        FO = 84714              -- Frozen Orb
        CoC = 120               -- Cone of Cold
        Pyro = 11366            -- Pyroblast
        IBlast = 108853         -- Inferno Blast
        FBlast = 2136           -- Fire Blast
        FS = 2120                   -- Flamestrike
        Fireball = 133          -- Fireball
        Blizzard = 10           -- Blizzard
        Freeze = 33395          -- Pet: Freeze
        Explosion = 1449        -- Arcane Explosion
        
        -- Cooldowns
        IB = 45438              -- Ice Block
        MI = 55342              -- Mirror Image
        IV = 12472              -- Icy Veins (Unglyphed)
        Evo = 12051             -- Evocation
        Comb = 11129            -- Combustion
        Decurse = 475           -- Remove Curse
        Counterspell = 2139     -- Counterspell
        
        -- Buffs
        WElm = 31687            -- Summon: Water Elemental
        MA = 30482              -- Molten Armor
        MAA        = 6117       -- Mage Armor
        ABril = 1459            -- Arcane Brilliance
        DBril = 61316           -- Dalaran Brilliance
        FA = 7302               -- Frost Armor
        InvoBuff = 116257       -- Invocation Buff
        AT = 108978             -- Alter Time
        ATB        = 110909     -- Alter Time Buff
        
        -- Procs
        BrainF = 57761          -- Brain Freeze
        FoF = 44544             -- Fingers of Frost
        HU = 48107              -- Heating Up
        PY = 48108              -- Pyroblast!
        
        -- Talents
        POM = 12043             -- Presence of Mind
        Scorch = 2948           -- Scorch
        RoF = 113724            -- Ring of Frost
        
        Temporal = 115610       -- Temporal Shield
        Barrier = 11426         -- Ice Barrier
        
        IW = 111264             -- Ice Ward
        FJ = 102051             -- Frost Jaw
        GI = 110959             -- Greater Invisibility
        
        CS = 11958              -- Cold Snap
        NT = 114923             -- Nether Tempest
        LB = 44457              -- Living Bomb
        FrostBomb = 112948      -- Frost Bomb
        Invo = 114003           -- Invocation
        RoP = 116011            -- Rune of Power
        Ward = 1463             -- Incanter's Ward
		
end
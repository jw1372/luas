function get_sets()
	
	
	send_command('bind f9 gs c toggle TP set')
	send_command('bind f10 gs c toggle DT set')
	send_command('bind f11 gs c toggle Attack set')
	send_command('bind ^f11 gs c toggle Shield set')
	send_command('bind ^f10 gs c toggle OhShit')
	send_command('bind f12 gs c toggle Idle set')

	lockstyleset=8
	select_default_macro_book()
	set_lockstyle()
	
	default_right_ring = "Apeile ring +1"
	
	function file_unload()
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        --send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
	
	end	

--Idle Sets--

	sets.Idle = {}
	
	sets.Idle.index = {'Normal','Run', 'Warp'}
	Idle_ind = 1
	
	sets.Idle.Normal = {
		right_ring = default_right_ring
	}
	
	sets.Idle.Run = set_combine(sets.Idle.Normal, {
		right_ring="Shneddick ring",
	})
	
	sets.Idle.Warp = set_combine(sets.Idle.Normal, {
		right_ring="Warp ring",
	})

--DT Sets-- 

	sets.DT = {}
	sets.DT.index = {'Tank', 'TankMagical'}
	DT_ind = 1
	
	sets.DT.Tank = {
		ammo="Staunch tathlum +1",
		head={name="Chevalier's armet +3", priority=40},
		body="Sakpata's Plate",
		hands="Sakpata's gauntlets",
		legs={name="Chevalier's cuisses +3", priority=6},
		feet={name="Rev. Leggings +3", priority=85},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=105},
		waist={name="Creed baudrier", priority=20},
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=90},
		right_ear={name="Tuisto Earring", priority=80},
		right_ring={name="Apeile ring +1"},
		left_ring={name="Moonlight Ring", bag='wardrobe6', priority=100},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.DT.TankMagical = {
		ammo="Staunch tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's charm +1",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear={name="Tuisto Earring", priority = 4},
		left_ring="Moonlight ring",
		right_ring="Shadow ring",
		back={name="Moonlight Cape", priority=6},
	}
	


--Hyrid Sets-- 

	sets.OhShit = {}
	
	sets.OhShit.index = {'Off', 'On'}
	OhShit_ind = 1
	
	sets.OhShit.Off = sets.OhShit
	
	sets.OhShit.On = {
		ammo="Staunch tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving collar +1",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear={name="Tuisto Earring", priority = 4},
		left_ring={name="Moonlight Ring", bag='wardrobe5', priority=1},
		right_ring="Apeile ring+1",
		back={name="Moonlight Cape", priority=6},
	}
		
--Weapon Sets--

	sets.Attack = {}
	sets.Attack.index = { "Sakpata", "Nixxer", "Brilliance", "Naegling", "Cleave"}
	Attack_ind = 1
	
	sets.Attack.Sakpata = {
		main="Sakpata's Sword",
	}
	
	sets.Attack.Naegling = {
		main="Naegling",
	}
	
	sets.Attack.Brilliance = {
		main="Brilliance",
	}
	
	sets.Attack.Nixxer = {
		main="Nixxer",
	}
	
	sets.Attack.Cleave = {
		main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+8','"Fast Cast"+5',}},
	}
	
--Shield Sets--

	sets.Shield = {}
	sets.Shield.index = {"Aegis", 'Duban','Priwen', 'Blurred', 'DW'}
	Shield_ind = 1
	
	sets.Shield.Priwen = {
		sub="Priwen",
	}
	
	sets.Shield.Aegis = {
		sub="Aegis",
	}
	
	sets.Shield.DW = {
		sub={ name="Malevolence", augments={'INT+6','Mag. Acc.+7','"Mag.Atk.Bns."+4','"Fast Cast"+3',}},
	}
	
	sets.Shield.Blurred = {
		sub="Blurred Shield +1",
	}
	
	sets.Shield.Duban = {
		sub="Duban",
	}

--TP Sets--

	sets.TP = {}
	
	sets.TP.index = {'TankSet', 'MagicTankSet', 'Hybrid', 'DW', 'TPTrash'}
	TP_ind = 1	
	
	sets.TP.TankSet = {
		ammo="Staunch tathlum +1",
		head={name="Chevalier's armet +3", priority=40},
		body="Sakpata's Plate",
		hands="Sakpata's gauntlets",
		legs={name="Chevalier's cuisses +3", priority=6},
		feet={name="Rev. Leggings +3", priority=85},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=105},
		waist={name="Creed baudrier", priority=20},
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=90},
		right_ear={name="Tuisto Earring", priority=80},
		right_ring={name="Apeile ring +1"},
		left_ring={name="Moonlight Ring", priority=100},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},

	}
	
	sets.TP.MagicTankSet = {
		ammo="Staunch tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving collar +1",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear={name="Tuisto Earring", priority = 4},
		left_ring={name="Moonlight Ring", priority=1},
		right_ring="Apeile ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.TP.TPTrash = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Valorous mail",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Lissome Necklace",
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich ring +1",
		right_ring="Chirich ring +1",
		back="Sokolski mantle",
	}
	
	sets.TP.Hybrid = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Sakpata's helm",
		body="Valorous mail",
		hands="Sakpata's gauntlets",
		legs="Sakpata's cuisses",
		feet="Flam. Gambieras +2",
		neck="Lissome Necklace",
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Moonlight ring",
		right_ring="Chirich ring +1",
		back="Sokolski mantle",
	}
	

	sets.TP.DW = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Sakpata's helm",
		body="Valorous mail",
		hands="Sakpata's gauntlets",
		legs="Sakpata's cuisses",
		feet="Flam. Gambieras +2",
		neck="Lissome Necklace",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich ring +1",
		right_ring="Chirich ring +1",
		back="Sokolski mantle",
	}
	
--Precast Sets--
	
	sets.precast = {}
	
	sets.precast.FC = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Rev. Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Rev. Breeches +1",
		feet="Chev. Sabatons +3",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Creed Baudrier",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Tuisto Earring",
		left_ring="Moonlight Ring",
		right_ring="Kishar Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	
--Midcast Sets--
	
	sets.midcast = {}
	
-- This set is good --

	sets.midcast.Phalanx = {
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
		ammo="Staunch tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Moonlight Necklace",
		waist="Asklepian Belt",
		left_ear="Knightly Earring",
		right_ear="Tuisto Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evanescence Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	
-- This set is good -- 

	sets.midcast.SIRD = {
		main="Sakpata's Sword",
		ammo="Staunch tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Chev. Cuirass +3",
		hands="Regal Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','"Cure" potency +4%','STR+5',}},
		neck="Moonlight necklace",
		waist="Audumbla Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}

-- This set is good -- 

	sets.midcast.Cure = {
		main="Sakpata's Sword",
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Macabre Gaunt. +1", augments={'Path: A',}},
		legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+3','Breath dmg. taken -2%',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','"Cure" potency +4%','STR+5',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Nourish. Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%','Spell interruption rate down-10%',}},
	}
	
-- This set is good. -- 

	sets.midcast.Reprisal = {
		sub="Priwen",
		main="Sakpata's sword",
		ammo="Staunch tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=5},
		body={ name="Shab. Cuirass +1", priority=1},
		hands={ name="Regal Gauntlets", priority=3},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=4},
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear={name="Odnowa Earring +1", augments={'Path: A',}, priority=2},
		right_ear="Tuisto Earring",
		right_ring="Apeile Ring +1",
		left_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.ProShell = set_combine(sets.SIRD, {
		sub="Duban",
		right_ring="Sheltered ring",
	})

-- This set is good -- 

	sets.midcast.Enlight = set_combine(sets.midcast.SIRD, {
		head="Jumalik helm",
		body="Reverence surcoat +3",
		waist="Asklepian belt",
		left_ring="Moonlight ring",
		right_ring="Stikini ring +1",
		neck="Incanter's torque",
	})
	
-- This set is good --

	sets.midcast.Flash = {
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +3",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Chev. Earring +2",
		left_ring="Kishar Ring",
		right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}

--Job Abilities--

	sets.JA = {
		main={ name="Brilliance", augments={'Divine magic skill +1','DMG:+10',}},
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +3",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic earring",
		right_ear="Tuisto earring",
		left_ring="Supershear Ring",
		right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
-- Need enmity earring from vagary -- 

	sets.JA.MaxEnmity = sets.JA
	
	sets.JA.Sentinel = set_combine(sets.JA.MaxEnmity, {
		feet="Caballarius leggings +1"
	})
	
	sets.JA.Emblem = set_combine(sets.JA.MaxEnmity, {
		feet="Chevalier's sabatons +2"
	})
	
	sets.JA.Rampart = set_combine(sets.JA.MaxEnmity, {
		head="Caballarius coronet +1"
	})
	
	sets.JA.Fealty = set_combine(sets.JA.MaxEnmity, {
		body="Caballarius surcoat +1"
	})
	
	sets.JA.Invincible = set_combine(sets.JA.MaxEnmity, {
		legs="Caballarius breeches"
	})
	
	sets.JA.ShieldBash = set_combine(sets.JA.MaxEnmity, {
		hands="Caballarius gauntlets +3",
		left_ear="Knightly earring"
	})
	
	sets.JA.Chivalry = set_combine(sets.JA.MaxEnmity, {
		hands="Caballarius gauntlets +1"
	})
	
	sets.JA.Circle = set_combine(sets.JA.MaxEnmity, {
		hands="Rev. Leggings +3"
	})

	
-- WeaponSkill Sets --

	sets.WS = {
		ammo="Oshasha's treatise",
		head="Nyame helm",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back="Sokolski mantle",
	
	}
	
	sets.WS.Savage = set_combine(sets.WS, {
		
	})
	
	sets.WS.MaxEnmity = {
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Souveran schuhs +1",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Chev. Earring +2",
		left_ring="Supershear Ring",
		right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.WS.Torcleaver = set_combine(sets.WS, {
		
	})
	
	sets.WS.Shockwave = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Tuisto Earring",
		left_ring="Moonlight Ring",
		right_ring="Epaminondas's Ring",
		back="Moonbeam Cape",
	}
	
	sets.WS.Edge = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Tuisto Earring",
		left_ring="Moonlight Ring",
		right_ring="Epaminondas's Ring",
		back="Moonbeam Cape",
	}
	
	sets.doom = {
        neck="Nicander's Necklace",
        left_ring="Blenmot's ring +1",
        right_ring="Purity ring",
        waist="Gishdubar Sash", 
	}
	
	sets.wakesleep = {
		neck="Vim Torque +1",
	}  
	
--Aftercast Sets--

	sets.aftercast = {}
	
end

function precast(spell)
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC)
	elseif spell.english == 'Atonement' then 
		equip(sets.WS.MaxEnmity)
	elseif  spell.english == 'Savage Blade' then
		equip(sets.WS.Savage)
	elseif spell.english == 'Torcleaver' then
		equip(sets.WS.Torcleaver)
	elseif spell.english == 'Shockwave' then
		equip(sets.WS.Shockwave)
	elseif spell.english == 'Aeolian Edge' then
		equip(sets.WS.Edge)
	elseif spell.type == "Weapon Skill" then
		equip(sets.WS)
	elseif spell.english == 'Sentinel' then
		equip(sets.JA.Sentinel)
	elseif spell.english == 'Divine Emblem' then
		equip(sets.JA.Emblem)
	elseif spell.english == 'Holy Circle' then
		equip(sets.JA.Circle)
	elseif spell.english == 'Rampart' then
		equip(sets.JA.Rampart)
	elseif  spell.english == 'Fealty' or
		spell.english == 'Cover' then
			equip(sets.JA.Fealty)
	elseif spell.english == 'Shield Bash' then
		equip(sets.JA.ShieldBash) 
	elseif spell.english == 'Chivalry' then
		equip(sets.JA.Chivalry)
	elseif spell.english == 'Invincible' then
		equip(sets.JA.Invincible)
	-- elseif spell.action_type == "Ability" then
		-- equip(sets.JA.MaxEnmity)
	end
end
	
function midcast(spell,act)
	if spell.english == 'Phalanx' then
		equip(sets.midcast.Phalanx)
	elseif spell.name:match('Cure') then	
		equip(sets.midcast.Cure)
	elseif  spell.english == 'Reprisal' or
			spell.english == "Cocoon" or
			spell.english == 'Crusade' then
		equip(sets.midcast.Reprisal)
	elseif 	spell.english == "Protect V" or
			spell.english == "Shell IV" then
		equip(sets.midcast.ProShell)
	elseif spell.english == 'Flash' then
		equip(sets.midcast.Flash) 
	elseif  spell.english == 'Enlight' or
		spell.english == "Enlight II" then
			equip(sets.midcast.Enlight)
	elseif  spell.english == "Geist Wall" or
			spell.english == "Sheep Song" or
			spell.english == "Soporific" or
			spell.english == "Blank Gaze" or
			spell.english == "Jettatura" or
			spell.english == 'Raise' or
			spell.name:match('Banish') then
		equip(sets.midcast.SIRD)
	-- else
		-- equip(sets.midcast.SIRD)
	end
end 

function aftercast(spell)
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Rampart" then -- Rampart Timer/Countdown --
			timer_rampart()
			send_command('wait 50;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Rampart";input /echo '..spell.name..': [OFF]')
			send_command('wait 150; input /echo RAMPART UP IN 10 --;wait 10; input /echo RAMPART UP --')
		elseif spell.english == "Sentinel" then -- Sentinel Countdown --
			timer_sentinel()
			send_command('wait 30;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Sentinel";input /echo '..spell.name..': [OFF]')
			send_command('wait 240; input /echo SENTINEL UP IN 10 --;wait 10;input /echo SENTINEL UP --')
		elseif spell.english == "Palisade" then -- Palisade Countdown --
			timer_palisade()
			send_command('wait 50;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Palisade";input /echo '..spell.name..': [OFF]')
			send_command('wait 290; input /echo PALISADE UP IN 10 --;wait 10;input /echo PALISADE UP --')
		elseif spell.english == "Majesty" then -- Majesty Countdown --
			timer_majesty()
			send_command('wait 170;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Majesty";input /echo '..spell.name..': [OFF]')
			send_command('wait 50; input /echo MAJESTY UP IN 10 --;wait 10;input /echo MAJESTY UP --')
		elseif spell.english == "Shield Bash" then -- Shield Bash Countdown --
			send_command('wait 50; input /echo SHIELD BASH UP IN 10 --;wait 10;input /echo SHIELD BASH UP --')
		elseif spell.english == "Holy Circle" then -- Holy Circle Countdown --
			timer_holy_circle()
			send_command('wait 170;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "HolyCircle";input /echo '..spell.name..': [OFF]')
			send_command('wait 290; input /echo HOLY CIRCLE UP IN 10 --;wait 10;input /echo HOLY CIRCLE UP --')
		elseif spell.english == "Divine Emblem" then -- Divine Emblem Countdown --
			send_command('wait 170; input /echo DIVINE EMBLEM UP IN 10 --;wait 10;input /echo DIVINE EMBLEM UP --')
		elseif spell.english == "Fealty" then -- Fealty Countdown --
			timer_fealty()
			send_command('wait 63;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Fealty";input /echo '..spell.name..': [OFF]')
			send_command('wait 590; input /echo FEALTY UP IN 10 --;wait 10;input /echo FEALTY UP --')
		elseif spell.english == "Reprisal" then -- Reprisal Countdown --
			timer_reprisal()
			send_command('wait 69;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Reprisal";input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Crusade" then -- Crusade Countdown --
			timer_crusade()
			send_command('wait 380;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Crusade";input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Cocoon" then -- Cocoon Countdown --
			timer_cocoon()
			send_command('wait 80;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Cocoon";input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Phalanx" then -- Phalanx Countdown --
			timer_phalanx()
			send_command('wait 189;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Phalanx";input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Enlight II" then -- Enlight Countdown --
			timer_enlight()
			send_command('wait 170;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Enlight";input /echo '..spell.name..': [OFF]')
		end
	end
	idle ()
end

-- Individual Timer functions

function timer_rampart()
	local duration = 60
	send_command('timers create "Rampart" '..tostring(duration)..' down')
end

function timer_sentinel()
	local duration = 40
	send_command('timers create "Sentinel" '..tostring(duration)..' down')
end

function timer_palisade()
	local duration = 60
	send_command('timers create "Palisade" '..tostring(duration)..' down')
end

function timer_majesty()
	local duration = 180
	send_command('timers create "Palisade" '..tostring(duration)..' down')
end

function timer_holy_circle()
	local duration = 180
	send_command('timers create "HolyCircle" '..tostring(duration)..' down')
end

function timer_fealty()
	local duration = 73
	send_command('timers create "Fealty" '..tostring(duration)..' down')
end

function timer_reprisal()
	local duration = 79
	send_command('timers create "Reprisal" '..tostring(duration)..' down')
end

function timer_crusade()
	local duration = 390
	send_command('timers create "Crusade" '..tostring(duration)..' down')
end

function timer_cocoon()
	local duration = 90
	send_command('timers create "Cocoon" '..tostring(duration)..' down')
end

function timer_phalanx()
	local duration = 189
	send_command('timers create "Phalanx" '..tostring(duration)..' down')
end

function timer_enlight()
	local duration = 180
	send_command('timers create "Enlight II" '..tostring(duration)..' down')
end

-------

function status_change(new,old)
	idle ()
end

function idle()
	if player.status == 'Engaged' then
		equip(
			set_combine(
				sets.TP[sets.TP.index[TP_ind]],
				sets.Attack[sets.Attack.index[Attack_ind]],
				sets.Shield[sets.Shield.index[Shield_ind]]))	
	else
		equip(
			set_combine(
				sets.DT[sets.DT.index[DT_ind]],
				sets.Attack[sets.Attack.index[Attack_ind]],
				sets.Shield[sets.Shield.index[Shield_ind]]))
	end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then 
			TP_ind = 1 
		end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		if player.status == 'Engaged' then
			equip(sets.TP[sets.TP.index[TP_ind]])
		end
	elseif command == 'toggle Attack set' then
		Attack_ind = Attack_ind +1
		if Attack_ind > #sets.Attack.index then Attack_ind = 1 end
		send_command('@input /echo <----- Weapon changed to '..sets.Attack.index[Attack_ind]..' ----->')
		equip(sets.Attack[sets.Attack.index[Attack_ind]])
	elseif command == 'toggle Shield set' then
			Shield_ind = Shield_ind +1
		if Shield_ind > #sets.Shield.index then 
			Shield_ind = 1 
		end
		send_command('@input /echo <----- Shield changed to '..sets.Shield.index[Shield_ind]..' ----->')
		equip(sets.Shield[sets.Shield.index[Shield_ind]])
	elseif command == 'toggle OhShit' then
		OhShit_ind = OhShit_ind +1
		
		if OhShit_ind > #sets.OhShit.index then 
			OhShit_ind = 1 
		end
		if OhShit_ind == 1 then 
			idle()
		end
		send_command('@input /echo <----- Ohshit Set changed to '..sets.OhShit.index[OhShit_ind]..' ----->') 
		equip(sets.OhShit[sets.OhShit.index[OhShit_ind]])
	elseif command == 'toggle Idle set' then
			Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then 
			Idle_ind = 1 
		end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle DT set' then
			DT_ind = DT_ind +1
		if DT_ind > #sets.DT.index then 
			DT_ind = 1 
		end
		
		send_command('@input /echo <----- DT Set changed to '..sets.DT.index[DT_ind]..' ----->')
		equip(sets.DT[sets.DT.index[DT_ind]])
	end
end

function set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end
	
	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		send_command('@input /macro set '..tostring(set))
	end
end

function job_buff_change(status,gain_or_loss)
    if buffactive.sleep then
		equip(sets.wakesleep)
    end
    if playerStatus == 'Idle' then
        equip(sets.DT.Tank)  
   end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "doom" then
        if gain then
            equip(sets.doom)
            --send_command('@input /p Doomed.')
            disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            --handle_equipping_gear(player.status)
        end
    end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(1, 8)
	else
		set_macro_page(1, 8)
	end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
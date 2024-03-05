--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, TP sets: TP--
--Resolution sets: Res, Requiescat sets: Req--

function get_sets()
	send_command("bind f9 gs c toggle TP set")
	send_command("bind f10 gs c toggle Idle set")
	send_command("bind f11 gs c toggle Weapons")
	send_command("bind ^f9 gs c equip TP set")
	send_command("bind ^f10 gs c equip DT set")
	send_command("bind f11 gs c equip TP set")
	send_command("bind f12 gs c equip DT set")
	
	lockstyleset=12
	select_default_macro_book()
	set_lockstyle()
	
	
	AMBU_SIRD = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	
	function file_unload()
		send_command("unbind ^f9")
		send_command("unbind ^f10")
		send_command("unbind ^f11")

		send_command("unbind !f9")
		send_command("unbind !f10")
		send_command("unbind !f11")

		send_command("unbind f9")
		send_command("unbind f10")
		send_command("unbind f11")
	end

	--Idle Sets--
	sets.Idle = {}

	sets.Idle.index = {"Standard", "DT", "Cleave"}

	Idle_ind = 1

	sets.Idle.Standard = {
		ammo="Staunch tathlum +1",
		head="Nyame helm",
		body="Erilaz surcoat +3",
		hands="Nyame gauntlets",
		legs="Erilaz leg guards +3",
		feet="Erilaz greaves +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Cryptic Earring",
		right_ear="Odnowa earring +1",
		left_ring="Moonlight Ring",
		right_ring="Shneddick Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.Idle.DT = {

	}

	sets.Idle.Cleave = {

	}

	--Weapons--

	sets.Weapons = {}

	sets.Weapons.Index = {"Aettir", "Lycurgos", "Sword"}
	Weapons_ind = 1

	sets.Weapons.Aettir = {
		main = {name = "Aettir", augments = {"Accuracy+70", "Mag. Evasion+50", "System: 2 ID: 114 Val: 9"}},
		sub = "Refined Grip +1"
	}

	sets.Weapons.Lycurgos = {main = "Lycurgos", sub = "Utu Grip"}

	sets.Weapons.Sword = {main = "Naegling", sub="Twinned Shield"}

	--TP Sets--
	sets.TP = {}

	sets.TP.index = {"TankTP", "MDTank", "Ongo","Standard",}
	--1=Standard,2=DT, 3=MDTtank, 4=Ongo --
	TP_ind = 1
	sets.TP.Standard = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+25 Attack+25','"Triple Atk."+3','AGI+6','Accuracy+13',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+17 Attack+17','"Triple Atk."+3','DEX+8','Attack+14',}},
		neck="Anu Torque",
		waist="Carrier's Sash",
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		right_ring="Niqmaddu Ring",
		left_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.TP.TankTP = {
		ammo="Staunch tathlum +1",
		head="Erilaz Galea +3",
		body="Nyame mail",
		hands="Turms Mittens +1",
		legs="Erilaz leg guards +3",
		feet="Erilaz greaves +3",
		neck="Loricate torque +1",
		waist="Carrier's Sash",
		left_ear="Cryptic Earring",
		right_ear="Odnowa earring +1",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.TP.MDTank = {
		ammo="Staunch tathlum +1",
		head="Nyame helm",
		body="Erilaz surcoat +3",
		hands="Nyame gauntlets",
		legs="Erilaz leg guards +3",
		feet="Erilaz greaves +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Cryptic Earring",
		right_ear="Odnowa earring +1",
		left_ring="Moonlight Ring",
		right_ring="Shadow Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}
	
	sets.TP.Ongo = {

	}

	--Weaponskill Sets--
	sets.WS = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		back="Sokolski Mantle",
	}

	sets.Resolution = {}

	sets.Resolution.index = {"Attack"}
	Resolution_ind = 1

	sets.Resolution.Attack = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Sokolski Mantle",
	}

	sets.Dimidiation = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Kentarch belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Sokolski Mantle",
	}

	sets.Dimidiation.index = {"Attack"}
	Dimidiation_ind = 1

	sets.Dimidiation.Attack = {

	}

	sets.Requiescat = {}

	sets.Requiescat.index = {"Attack"}
	Requiescat_ind = 1

	sets.Requiescat.Attack = {

	}

	sets.FellCleave = {}

	sets.FellCleave.index = {"Attack"}
	FellCleave_ind = 1

	sets.FellCleave.Attack = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Sokolski Mantle",
	}

	sets.SavageBlade = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Sokolski Mantle",
	}

	sets.SavageBlade.index = {"Attack"}
	SavageBlade_ind = 1

	sets.SavageBlade.Attack = {

	}

	--Utility Sets--
	sets.Utility = {}

	sets.Utility.Phalanx = {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Runeist Mitons",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back=AMBU_SIRD,	
	}

	sets.Utility.Regen = {
		ammo="Staunch Tathlum +1",
		head="Runeist Bandeau",
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Regal gauntlets",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck="Sacro gorget",
		waist="Sroda Belt",
		left_ear="Erilaz earring +1",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back=AMBU_SIRD,
	}

	sets.Utility.SIRD = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body="Erilaz Surcoat +3",
		hands="Regal Gauntlets",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Halasz Earring",
		right_ear="Magnetic earring",
		left_ring="Moonlight Ring",
		right_ring="Evanescence Ring",
		back=AMBU_SIRD,
	}

	sets.Utility.Enmity = {
		ammo="Sapience Orb",
		head="Halitus helm",
		body="Emet Harness +1",
		hands="Kurys gloves",
		legs={name = "Eri. Leg Guards +3", priority=3,},
		feet="Erilaz Greaves +3",
		neck={name="Unmoving Collar +1", priority=2, augments={'Path: A',}},
		waist="Trance Belt",
		left_ear={name="Cryptic Earring", priority=7},
		right_ear={ name="Odnowa Earring +1", priority=1, augments={'Path: A',}},
		left_ring={name="Supershear Ring", priority=4},
		right_ring={name="Vexer Ring +1", priority=6},
		back={ name="Ogma's Cape", priority=5,augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.Utility.Enhancing = {
		head="Erilaz galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Runeist Mitons",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back=AMBU_SIRD,
	}

	sets.Utility.EnhancingSkill = {
		head="Erilaz galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Runeist Mitons",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back=AMBU_SIRD,	
	}

	sets.Utility.Refresh = {
		ammo="Sapience Orb",
		head="Erilaz Galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Regal Gauntlets",
		legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
		feet="Erilaz Greaves +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back=AMBU_SIRD,
	}
	
	sets.Utility.FrightfulRoar = {
		ammo="Sapience Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Emet Harness +1",
		hands={ name="Futhark Mitons +1", augments={'Enhances "Sleight of Sword" effect',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Sroda Belt",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Supershear Ring",
		right_ring="Vexer Ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.Utility.Doomed = {
		waist = "Gishdubar Sash", 
		neck="Nicander's necklace",
		left_ring= "Purity Ring",
		right_ring="Blentmot's ring +1",
	}

	--Job Ability Sets--
	sets.JA = sets.Utility.Enmity
	
	sets.JA.VP = {
		head="Erilaz galea +3",
		
	}

	sets.JA.Liement = {
		body="Futhark coat +1",
	}

	sets.JA.Embolen = {
	
	}

	sets.JA.Lunge = {
		ammo="Ghastly tathlum +1",
		head="Agwu's hat",
		body="Agwu's robe"
		hands="Agwu's gages",
		legs="Agwu slops",
		feet="Agwu pigaches",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Moonlight Ring",
		right_ring="Supershear Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
	}

	sets.JA.Battuta = {
		head="Futhark bandeau +1",
	}

	sets.JA.BattutaActive = {}

	sets.JA.Gambit = {
		hands="Runeist mitons",
	}

	sets.JA.Pflug = {
		feet="Runeist bottes",
	}

	sets.JA.Rayke = {
		"Futhark boots +1",
	}

	sets.JA.Steps = {

	}

	--Precast Sets--
	sets.precast = {}

	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Erilaz Surcoat +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Voltsurge Torque",
		waist="Trance Belt",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Kishar Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back=AMBU_SIRD,
	}

	sets.precast.FC.Standard = sets.precast.FC

	sets.precast.FC.Enhancing = sets.precast.FC

	sets.precast.FC.Enmity = sets.precast.FC
end

function precast(spell)
	if spell.action_type =="Magic" then
		equip(sets.precast.FC.Standard)
	elseif spell.skill == "Enhancing Magic" then
		equip(sets.precast.FC.Standard)
	elseif spell.skill == "Ninjutsu" then
		equip(sets.precast.FC.Standard)
	elseif spell.english == "Vivacious Pulse" then
		equip(set_combine(sets.Utility.Enmity, sets.JA.VP))
	elseif spell.english == "Lunge" or spell.english == "Swipe" or spell.english == "Herculean Slash" then
		equip(sets.JA.Lunge)
	elseif spell.english == "Vallation" or spell.english == "Valiance" then
		equip(set_combine(sets.Utility.Enmity, sets.JA.Vallation))
	elseif	spell.english == "Flash" or spell.skill == "Enfeebling Magic" or spell.english == "Foil" or spell.skill == "Dark Magic" or spell.skill == "Blue Magic" then
		equip(sets.precast.FC.Enmity)
	elseif
		spell.english == "Tellus" or spell.english == "Lux" or spell.english == "Gelus" or spell.english == "Tenebrae" or
			spell.english == "Sulpor" or
			spell.english == "Ignis" or
			spell.english == "Unda" or
			spell.english == "Flabra" or
			spell.english == "Weapon Bash" or
			spell.english == "Last Resort" or
			spell.english == "Souleater"
	 then
		equip(sets.Utility.Enmity)
	elseif spell.english == "Battuta" then
		equip(set_combine(sets.Utility.Enmity, sets.JA.Battuta))
	elseif spell.english == "Liement" then
		equip(set_combine(sets.Utility.Enmity, sets.JA.Liement))
	elseif spell.english == "Elemental Sforzo" then
		equip(set_combine(sets.Utility.Enmity, {body="Futhark coat +1"}))
	elseif spell.english == "Valiance" or spell.english == "Vallation" then
		equip(set_combine(sets.Utility.Enmity, {body="Runeist coat"}))
	elseif spell.english == "Pflug" then
		equip(set_combine(sets.Utility.Enmity, sets.JA.Pflug))
	elseif spell.english == "Gambit" then
		send_command('timers delete "Gambit"')
		send_command(
			'timers create "Gambit" 96 down;wait 60;input /echo Gambit [WEARING OFF IN 30 SEC.];wait 30;input /echo Gambit [OFF];timers delete "Gambit"'
		)
		equip(set_combine(sets.Utility.Enmity, sets.JA.Gambit))
	elseif spell.english == "Rayke" then
		send_command('timers delete "Rayke"')
		send_command(
			'timers create "Rayke" 49 down;wait 34;input /echo Rayke [WEARING OFF IN 15 SEC.];wait 15;input /echo Rayke [OFF];timers delete "Rayke"'
		)
		equip(set_combine(sets.Utility.Enmity, sets.JA.Rayke))
	elseif spell.english == "Resolution" or spell.english == "Shockwave" then
		equip(sets.Resolution[sets.Resolution.index[Resolution_ind]])
	elseif spell.english == "Dimidiation" then
		equip(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_ind]])
	elseif spell.english == "Requiescat" then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
	elseif spell.english == "Fell Cleave" then
		equip(sets.FellCleave[sets.FellCleave.index[FellCleave_ind]])
	elseif spell.english == "Savage Blade" or spell.english == "Ground Strike" then
		equip(sets.SavageBlade[sets.SavageBlade.index[SavageBlade_ind]])
	elseif spell.type == "WeaponSkill" then
		equip(sets.SavageBlade[sets.SavageBlade.index[SavageBlade_ind]])
	elseif spell.english == "Box Step" or spell.english == "Quickstep" or spell.english == "Stutter Step" then
		equip(sets.Utility.Enmity)
	end
end

function midcast(spell, act)
	if spell.skill == "Enhancing Magic" then
		equip(sets.Utility.Enhancing)
		if buffactive["Embolden"] then
			equip(set_combine(sets.Utility.Enhancing, sets.JA.Embolen))
		end
		if string.find(spell.name, "Bar") or spell.name == "Temper" then
			equip(sets.Utility.EnhancingSkill)
			if buffactive["Embolden"] then
				equip(set_combine(sets.Utility.EnhancingSkill, sets.JA.Embolen))
			end
		end	
		if spell.english == "Stoneskin" then
			equip(sets.Utility.SIRD)
			if buffactive["Stoneskin"] then
				send_command("@wait 0.7; input //cancel Stoneskin; input /echo Refreshing Stoneskin.")
			end
		end
		if spell.english == "Refresh" then
			equip(sets.Utility.Refresh)
		end
		if spell.english == "Phalanx" then
			equip(sets.Utility.Phalanx)
			if buffactive["Embolden"] then
				equip(set_combine(sets.Utility.Phalanx, sets.JA.Embolen))
			end
		end
		if
		spell.english == "Regen" or spell.english == "Regen II" or spell.english == "Regen III" or spell.english == "Regen IV"
		then
			equip(sets.Utility.Regen)
		end
	end
	if spell.english == "Utsusemi: Ichi" then
		equip(sets.Utility.SID)
		if buffactive["Copy Image (3)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image (2)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image (1)"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
		if buffactive["Copy Image"] then
			send_command("@wait 0.3; input //cancel Copy Image*")
		end
	end
	if spell.english == "Utsusemi: Ni" then
		equip(sets.Utility.SIRD)
	end
	if spell.english == "Flash" or spell.english == "Crusade" or spell.english == "Foil" or spell.skill == "Enfeebling Magic" or spell.skill == "Dark Magic" then
		equip(sets.Utility.Enmity)
	end
	if spell.skill == "Blue Magic" then
		equip(sets.Utility.SIRD)
		if spell.english == "Frightful Roar" then
			equip(sets.Utility.FrightfulRoar)
		end
	end
end

function aftercast(spell)
	if player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buffactive["battuta"] then
			equip(set_combine(sets.TP[sets.TP.index[TP_ind]], sets.JA.BattutaActive))
		end
		if buffactive["doom"] or buffactive["curse"] then
			equip(sets.Utility.Doomed)
		end
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
		if buffactive["doom"] or buffactive["curse"] then
			equip(sets.Utility.Doomed)
		end
	end
end

function status_change(new, old)
	if new == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buff == "doom" or buff == "curse" then
			equip(sets.Utility.Doomed)
		end
	elseif new == "Idle" then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
		if buffactive["terror"] or buffactive["stun"] or (buffactive["sleep"] or buffactive["lullaby"]) then
			equip(sets.TP.DT)
		end
		if buff == "doom" or buff == "curse" then
			equip(sets.Utility.Doomed)
		end
	end
end

function buff_change(buff, gain)
	if (buff == "terror" or buff == "stun" or (buff == "sleep" or buff == "lullaby")) then
		if gain then
			if player.status == "Engaged" then
				equip(sets.TP.DT)
			elseif player.status == "Idle" then
				equip(sets.TP.DT)
			end
		else
			if player.status == "Engaged" then
				equip(sets.TP[sets.TP.index[TP_ind]])
			elseif player.status == "Idle" then
				equip(sets.Idle[sets.Idle.index[Idle_ind]])
			end
		end
	end
	if buff == "doom" or buff == "curse" then
		if gain then
			equip(sets.Utility.Doomed)
		else
			if player.status == "Engaged" then
				equip(sets.TP[sets.TP.index[TP_ind]])
			elseif player.status == "Idle" then
				equip(sets.Idle[sets.Idle.index[Idle_ind]])
			end
		end
	end
end

function self_command(command)
	if command == "toggle TP set" then
		TP_ind = TP_ind + 1
		if TP_ind > #sets.TP.index then
			TP_ind = 1
		end
		send_command("@input /echo <----- TP Set changed to " .. sets.TP.index[TP_ind] .. " ----->")
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == "toggle Idle set" then
		Idle_ind = Idle_ind + 1
		if Idle_ind > #sets.Idle.index then
			Idle_ind = 1
		end
		send_command("@input /echo <----- Idle Set changed to " .. sets.Idle.index[Idle_ind] .. " ----->")
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == "toggle Weapons" then
		Weapons_ind = Weapons_ind + 1
		if Weapons_ind > #sets.Weapons.Index then
			Weapons_ind = 1
		end
		send_command("@input /echo <----- Weapons Set changed to " .. sets.Weapons.Index[Weapons_ind] .. " ----->")
		equip(sets.Weapons[sets.Weapons.Index[Weapons_ind]])
	elseif command == "toggle Res set" then
		Resolution_ind = Resolution_ind + 1
		if Resolution_ind > #sets.Resolution.index then
			Resolution_ind = 1
		end
		send_command("@input /echo <----- Resolution set changed to " .. sets.Resolution.index[Resolution_ind] .. " ----->")
	elseif command == "toggle Req set" then
		Requiescat_ind = Requiescat_ind + 1
		if Requiescat_ind > #sets.Requiescat.index then
			Requiescat_ind = 1
		end
		send_command("@input /echo <----- Requiescat Set changed to " .. sets.Requiescat.index[Requiescat_ind] .. " ----->")
	elseif command == "equip TP set" then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == "equip TP set" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		send_command("@input /echo  <--- Equipped TP Set ----->")
	elseif command =="equip DT set" then
		equip (sets.TP.MDTank)
		send_command("@input /echo  <--- Equipped DT Set ----->")
	elseif command == "equip Idle set" then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(1, 12)
	else
		set_macro_page(1, 12)
	end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
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
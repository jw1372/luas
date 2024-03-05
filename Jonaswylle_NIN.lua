-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Crit', 'GK')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('DT', 'Evasion', 'DualWield', 'DualWieldMeva')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Ninja Kyahan"
    
    select_movement_feet("Danzo Sune-ate")
	lockstyleset=3
	select_default_macro_book()
	set_lockstyle()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

	AmbuDEXSTP = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	AmbuDEXDW = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	AmbuSTRWSD = { name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	AmbuINTMAB = { name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	AmbuDA = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	AmbuFC = { name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Hattori tekko +3"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail +3"}
	sets.precast.JA['Innin'] = {head="Mochizuki hatsuburi +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	
	}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {
	
	}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
	
	}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {    
		ammo="Impatiens",
		head="Nyame helm",
		body="Nyame mail",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Gyve Trousers",
		feet="Nyame sollerets",
		neck="Voltsurge torque",
		waist="Tempus Fugit",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back= AmbuFC,
	}
    
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		body="Mochizuki chainmail +3",
		feet="Hattori Kyahan +3",
		neck="Magoraga Beads",
		waist="Audumbla sash",
	})

    -- Snapshot for ranged
    sets.precast.RA = {
	
	}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    
	sets.precast.WS = {   
		ammo="Coiste bodhar",
		head="Mpaca's cap",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Hattori kyahan +3",
		neck="Ninja nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back=AmbuSTRWSD,
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	
	})
	
	sets.precast.WS.mod = set_combine(sets.precast.WS, {
		legs="Mpaca's hose",
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,{
	
	})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,{
		ammo="Yetshila +1",
	})

    sets.precast.WS['Blade: Shun'] = {
		ammo="Coiste bodhar",
		head="Mpaca's cap",
		body="Mpaca's doublet",
		hands="Mpaca's gloves",
		legs="Mpaca's hose",
		feet="Kendatsuba sune-ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Lugra earring +1",
		right_ear="Moonshade earring",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back=AmbuDA,
	}
	
    sets.precast.WS['Blade: Kamu'] = {
		ammo="Coiste bodhar",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Hattori kyahan +3",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Ishavara earring",
		right_ear="Lugra earring +1",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back=AmbuSTRWSD,
	}


	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS['Blade: Shun'],{
		head="Nyame helm",
		right_ear="Brutal earring",
	})
	
    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Sibyl scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back=AmbuINTMAB,
	}

	sets.precast.WS['Blade: Chi'] = {
		ammo="Seeth. Bomblet +1",
		head="Mochizuki hatsuburi +3",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back=AmbuSTRWSD,
	}
	
	sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
	
	sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Tachi: Kagero'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Tachi: Goten'] = sets.precast.WS['Blade: Chi']

	sets.precast.WS['Blade: Ei'] = {
		ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring= "Archon Ring",
		right_ring="Epaminondas's Ring",
		back=AmbuSTRWSD,
	}
	
    sets.precast.WS['Evisceration'] = {
		ammo="Yetshila +1",
		head="Blistering sallet +1",
		body="Mpaca's doublet",
		hands="Mpaca's gloves",
		legs="Mpaca's hose",
		feet="Kendatsuba sune-ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Lugra earring +1",
		right_ear="Odr earring",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back=AmbuDA,
	}
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
	
	}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

    sets.midcast.ElementalNinjutsu = {
		ammo="Ghastly tathlum +1",
		head="Mochizuki hatsuburi +3",
		body="Nyame mail",
		hands="Hattori tekko +3",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Sibyl scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Dignitary's Earring",
		left_ring="Metamorph ring +1",
		right_ring="Dingir Ring",
		back=AmbuINTMAB,
	}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {
	
	})

    sets.midcast.NinjutsuDebuff = {
		ammo="Yamarang",
		head="Mpaca's cap",
		body="Malignance tabard",
		hands="Hattori tekko +3",
		legs="Malignance tights",
		feet="Hattori kyahan +3",
		neck="Moonlight necklace",
		waist="Orpheus's sash",
		left_ear="Hnoss earring",
		right_ear="Dignitary's Earring",
		left_ring="Stikini ring +1",
		right_ring="Metamorph Ring +1",
		back=AmbuINTMAB,
	}

    sets.midcast.NinjutsuBuff = {
	
	}

    sets.midcast.RA = {
	
	}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
	
	}
    
    -- Idle sets
    sets.idle = {
		ammo="Seki shuriken",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Rep. Plat. Medal",
		waist="Carrier's sash",
		left_ear="Etiolation Earring",
		right_ear="Eabani earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back=AmbuDEXSTP,
	}

    sets.idle.Town = {
		ammo="Seki Shuriken",
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Shneddick Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
    sets.idle.Weak = {
		ammo="Staunch tathlum +1",
		head="Nyame helm",
		body="Adamantite Armor",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Rep. Plat. Medal",
		waist="Carrier's sash",
		left_ear="Etiolation Earring",
		right_ear="Mujin Stud",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}
    -- Defense sets
	
    sets.defense.Evasion = {
		ammo="Staunch tathlum +1",
		head="Nyame helm",
		body="Adamantite Armor",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Warder's charm +1",
		waist="Carrier's sash",
		right_ear="Eabani Earring",
		left_ear="Hearty Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Shadow Ring",
		back=AmbuFC,
	}

    sets.defense.DT = {
		ammo="Staunch tathlum +1",
		head="Nyame helm",
		body="Adamantite Armor",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Warder's charm +1",
		waist="Carrier's sash",
		right_ear="Eabani Earring",
		left_ear="Hearty Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Shadow Ring",
		back=AmbuFC,
	}
	
	
    sets.defense.DualWield = {
		ammo="Staunch Tathlum +1",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body={ name="Mochi. Chainmail +3", augments={'Enhances "Sange" effect',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.defense.DualWieldMeva = {
		ammo="Staunch Tathlum +1",
		head="Hattori zukin +3",
		body={ name="Mochi. Chainmail +3", augments={'Enhances "Sange" effect',}},
		hands="Nyame gauntlets",
		legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

    sets.Kiting = {
	
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {  
		ammo="Seki shuriken",
		head="Ryuo Somen +1",
		body="Mochizuki chainmail +3",
		hands="Malignance gloves",
		legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		feet="Tatenashi sune-ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Gere ring",
		back=AmbuDEXDW,
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {

	})
	
	sets.engaged.Crit = set_combine(sets.engaged, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		right_ear="Odr Earring",
		feet="Kendatsuba sune-ate +1",
	})
	
	sets.engaged.GK = {
		ammo="Seki Shuriken",
		head="Mpaca's cap",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Sweordfaetels +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back=AmbuDEXSTP,
	}
	
    sets.engaged.Evasion = set_combine(sets.engaged, {

	})
	
    sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {

	})
	
	sets.engaged.Crit.Evasion = set_combine(sets.engaged.Evasion, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		right_ear="Odr Earring",
	})
	
	sets.engaged.GK.Evasion = set_combine(sets.engaged.GK, {

	})
	
    sets.engaged.PDT = set_combine(sets.engaged, {
		head="Mpaca's cap",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Gere Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {

	})
	
	sets.engaged.Crit.PDT = set_combine(sets.engaged.PDT, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.PDT = set_combine(sets.engaged.GK, {
		left_ring = "Defending ring",
	})
	
    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {
		ammo="Seki shuriken",
		head="Mpaca's cap",
		body="Mpaca's doublet",
		hands="Malignance gloves",
		legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		feet="Tatenashi sune-ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Gere ring",
		back=AmbuDEXSTP,
	}
    sets.engaged.Acc.HighHaste = set_combine(sets.engaged.HighHaste, {

	})
	
	sets.engaged.Crit.HighHaste = set_combine(sets.engaged.HighHaste, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.HighHaste = set_combine(sets.engaged.GK, {

	})
	
    sets.engaged.Evasion.HighHaste = set_combine(sets.engaged.HighHaste, {

	})
	
    sets.engaged.Acc.Evasion.HighHaste = set_combine(sets.engaged.Evasion.HighHaste, {

	})

	sets.engaged.Crit.Evasion.HighHaste = set_combine(sets.engaged.Evasion.HighHaste, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.Evasion.HighHaste = set_combine(sets.engaged.GK.HighHaste, {

	})
	
	-- Same as no/low haste
    sets.engaged.PDT.HighHaste = set_combine(sets.engaged.PDT, {

	})
	
    sets.engaged.Acc.PDT.HighHaste = set_combine(sets.engaged.PDT.HighHaste, {

	})

	sets.engaged.Crit.PDT.HighHaste = set_combine(sets.engaged.PDT.HighHaste, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.PDT.HighHaste = set_combine(sets.engaged.GK.PDT, {

	})
    -- Custom melee group: Max Haste (0% DW)
	
    sets.engaged.MaxHaste = {
		ammo="Seki shuriken",
		head="Mpaca's cap",
		body="Mpaca's doublet",
		hands="Malignance gloves",
		legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		feet="Tatenashi sune-ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Gere ring",
		back=AmbuDEXSTP,
	}
	
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.MaxHaste, {

	})
	
	sets.engaged.Crit.MaxHaste = set_combine(sets.engaged.MaxHaste, {
		head="Mummu bonnet +2",
		body="Mummu jacket +2",
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})
	
	-- sets.engaged.Crit.MaxHaste = set_combine(sets.engaged.MaxHaste, {
		-- hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		-- legs={ name="Mpaca's Hose", augments={'Path: A',}},
		-- feet="Kendatsuba sune-ate +1",
		-- right_ear="Odr Earring",
	-- })
	
	sets.engaged.GK.MaxHaste = set_combine(sets.engaged.GK, {

	})
	
    sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged.MaxHaste, {

	})
	
    sets.engaged.Acc.Evasion.MaxHaste = set_combine(sets.engaged.Evasion.MaxHaste, {

	})
	
	sets.engaged.Crit.Evasion.MaxHaste = set_combine(sets.engaged.Evasion.MaxHaste, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.Evasion.MaxHaste = set_combine(sets.engaged.GK, {

	})
	
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {
		ammo="Seki shuriken",
		head="Mpaca's cap",
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Malignance tights",
		feet="Malignance boots",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Gere ring",
		back=AmbuDEXSTP,
	})
	
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.PDT.MaxHaste, {

	})
	
	sets.engaged.Crit.PDT.MaxHaste = set_combine(sets.engaged.PDT.MaxHaste, {
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Kendatsuba sune-ate +1",
		right_ear="Odr Earring",
	})

	sets.engaged.GK.PDT.MaxHaste = set_combine(sets.engaged.GK.PDT, {

	})

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.haste or buffactive.march == 1 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
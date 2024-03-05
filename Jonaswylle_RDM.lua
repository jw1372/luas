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
	lockstyleset=5
	macrobook=5
	set_lockstyle()
	select_default_macro_book()
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent. 

function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Ongo', 'Enspell', 'EnspellDT','Single')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Burst', 'Enmity')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
    gear.default.obi_waist = "Hachirin-no-obi"
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	AMBU_TP = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	AMBU_Haste = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Haste+10','Phys. dmg. taken-10%',}}
	AMBU_MNDWSD = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	AMBU_INTWSD = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	AMBU_DW = { name="Sucellos's Cape", augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	AMBU_SWEnspell = { name="Sucellos's Cape", augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	AMBU_ENM = { name="Sucellos's Cape", augments={'Enmity+10',}}
	AMBU_FC = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy chapeau +2",
        body="Atrophy tabard +3",

	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
		head="Atro. Chapeau +2",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Carmine Cuisses", augments={'Accuracy+15','Attack+10','"Dual Wield"+5',}},
		feet="Carmine greaves +1",
		neck="Loricate torque +1",
		waist="Tempus Fugit",
		left_ear="Loquac. Earring",
		right_ear="Lethargy earring +1",
		left_ring="Defending Ring",
		right_ring="Kishar ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body={name="Crepuscular cloak", priority=100},
	})
	

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Oshasha's treatise",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Leth. houseaux +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
	})
	
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
		body="Bunzi's robe",
		ammo="Crepuscular pebble",
	})
	
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Blistering sallet +1",
		body="Ayanmo corazza +2",
		left_ear="Sherida earring",
		right_ear="Brutal earring",
		left_ring="petrov ring",
		waist="Kentarch Belt +1",
		ammo="Coiste bodhar",
		back=AMBU_TP,
	})
	

    sets.precast.WS['Sanguine Blade'] = {
		ammo="Ghastly tathlum +1",
		head="Pixie hairpin +1",
		body="Lethargy Sayon +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Leth. houseaux +3",
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Ishvara Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back=AMBU_MNDWSD,
	}
	
	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
		ammo="Ghastly tathlum +1",
		head="Leth. Chappel +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Leth. Houseaux +3",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back=AMBU_MNDWSD,
	})
	
	sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
		head="Nyame helm",
		waist="Orpheus's sash",
		left_ring="Metamorph ring +1",
		left_ear="Moonshade earring",
		back= AMBU_INTWSD,		
	})
	
	sets.precast.WS['Shining Blade'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Burning Blade']
	
	sets.precast.WS['Black Halo'] = {
		ammo="Coiste bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's ring",
		feet="Leth. houseaux +3",
	}
    
	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS, {
		neck="Duelist's torque +2",
		waist="Kentarch Belt +1",
	})
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
		main="Bunzi's rod",
		sub="Sacro bulwark",
		ammo="Ombre Tathlum +1",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Lethargy Sayon +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Austerity Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Magnetic Earring",
		right_ring="Stikini Ring +1",
		left_ring="Haoma's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure
	sets.midcast.Cure.Enmity = set_combine(sets.midcast.Cure, {
		legs="Atrophy tights +2",
	})
	sets.midcast.CureSelf.Enmity = sets.midcast.Cure.Enmity
	sets.midcast.Curaga.Enmity = sets.midcast.Cure.Enmity

    sets.midcast['Enhancing Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
		legs="Lethargy Fuseau +3",
		feet="Leth. houseaux +3",
		neck="Duelist's torque +2",
		waist="Siegel Sash",
		left_ear="Mimir earring",
		right_ear="Lethargy earring +1",
		left_ring="Kishar ring",
		right_ring="Stikini ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
	
	sets.midcast.EnSpell = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
		legs="Atrophy tights +2",
		feet="Leth. Houseaux +3",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear="Lethargy Earring +1",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
	
    sets.midcast['Temper II'] = set_combine(sets.midcast.EnSpell, {

	})

    sets.midcast.Refresh = {
	    main="Bunzi's rod",
		sub="Ammurapi shield",
		ammo="Hydrocera",
		head="Amalric coif +1",
		body="Atrophy Tabard +3",
		hands="Atrophy gloves +3",
		legs="Leth. fuseau +3",
		feet="Leth. houseaux +3",
		neck="Duelist's torque +2",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Lethargy earring +1",
		left_ring="Kishar Ring",
		right_ring="Stikini ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose rod",
		head="Amalric coif +1",
		hands="Regal cuffs",
	})
	
    sets.midcast.Stoneskin = {neck="Nodens gorget", waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = { 
	    main={name="Contemplator +1", priority=90},
		sub={name="Enki strap", priority=1},
		range={name="Ullr", priority=70},
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy sayon +3",
		hands="Leth. Ganth. +3",
		legs="Chironic hose",
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Duelist's torque +2",
		waist="Obstinate Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring="Metamorph Ring +1",
		back="Aurist's cape +1",
	}
	
    sets.midcast['Enfeebling Magic'].Enmity = set_combine(sets.midcast['Enfeebling Magic'], {
		main={ name="Contemplator +1", augments={'Path: A',}},
		sub="Alber Strap",
		ammo="Sapience Orb",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Chironic Slippers", augments={'"Fast Cast"+1','"Occult Acumen"+9','"Refresh"+1','Accuracy+5 Attack+5','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Trance Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Cryptic Earring",
		left_ring="Supershear Ring",
		right_ring="Vexer Ring +1",
		back=AMBU_ENM,
	
	})

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
	    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})
	
	sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})
	
	sets.midcast['Gravity'] = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	})
	
	sets.midcast['Gravity II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	})
	
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini ring +1",
		legs="Lethargy fuseau +3",
	})
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		range="",
		ring1="Stikini ring +1",
		legs="Lethargy fuseau +3",
		ammo="Regal gem",
	})
    sets.midcast['Elemental Magic'] =  {   
		main="Bunzi's rod",
		sub="Ammurapi Shield",
		ammo="Ghastly tathlum +1",
		head="Lethargy chappel +3",
		body="Lethargy Sayon +3",
		hands="Lethargy gantherots +3",
		legs="Leth. fuseau +3",
		feet="Leth. houseaux +3",
		neck="Sibyl scarf",
		waist="Acuity belt +1",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Metamorph Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
    sets.midcast['Elemental Magic'].Burst =  {   
		main="Bunzi's rod",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Ea hat +1",
		body="Ea houppelande +1",
		hands="Bunzi's gloves",
		legs="Leth. fuseau +3",
		feet="Leth. houseaux +3",
		neck="Sibyl scarf",
		waist="Sacro cord",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Metamorph Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
        
    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
		main={ name="Contemplator +1", augments={'Path: A',}},
		sub={name="Enki strap", priority=1},
		range="Ullr",
		head=empty,
		body={name="Crepuscular cloak", priority=100},
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Acuity belt +1",
		left_ear="Digni. Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	})

    sets.midcast['Dark Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		range="Ullr",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy sayon +3",
		hands="Vitiation gloves +3",
		legs="Leth. fuseau +3",
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Duelist's torque +2",
		waist="Obstinate sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Stikini Ring +1",
		back="Aurist's cape +1",
	}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Archon Ring", waist="Austerity belt +1"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bunzi's rod",
		sub="Ammurapi Shield",
		head="Telchine cap",
		neck="Duelist's torque +2",
		body="Vitiation tabard +3",
		hands="Atrophy gloves +3",
		waist="Embla sash",
		legs="Telchine braconi",
		feet="Leth. houseaux +3",
		right_ear="Lethargy earring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})
        
    sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bunzi's rod",
		sub="Ammurapi Shield",
		head="Lethargy Chappel +3",
		neck="Duelist's torque +2",
		body="Lethargy Sayon +3",
		waist="Embla sash",
		hands="Atrophy gloves +3",
		legs="Leth. fuseau +3",
		feet="Leth. houseaux +3",
		right_ear="Lethargy earring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	})

    sets.buff.Saboteur = {hands="Lethargy Gantherots +3"}
    

	sets.doom = {
        neck="Nicander's Necklace", --20
        ring1="Blenmot's ring +1",
        ring2="Purity ring",
        waist="Gishdubar Sash", --10
	}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Bolelabunga",
		sub="Sacro bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Nyame gauntlets",
		legs={ name="Carmine Cuisses", augments={'Accuracy+15','Attack+10','"Dual Wield"+5',}},
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Flume belt",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Moonbeam Cape",
	}
    

    -- Idle sets
    sets.idle = {
		main={name="Contemplator +1", priority=100},
		sub={name="Alber strap", priority=1},
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Bunzi's gloves",
		legs="Nyame flanchard",
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Carrier's sash",
		left_ear="Odnowa Earring +1",
		right_ear="Hearty Earring",
		right_ring="Stikini ring +1",
		left_ring="Shneddick Ring",
		back=AMBU_TP, 
		ammo="Homiliary",
	}

    sets.idle.Town = {
		main={name="Contemplator +1", priority=100},
		sub={name="Alber strap", priority=1},
		range="",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Bunzi's gloves",
		legs="Nyame flanchard",
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Carrier's sash",
		left_ear="Odnowa Earring +1",
		right_ear="Hearty Earring",
		right_ring="Stikini ring +1",
		left_ring="Shneddick Ring",
		back= AMBU_TP,
		ammo="Homiliary",
	}
    
    sets.idle.Weak = {
		main="Daybreak",
		sub="Sacro bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Platinum moogle belt",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		right_ring="Stikini ring +1",
		left_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}

    sets.idle.PDT = {		
		main="Daybreak",
		sub="Sacro bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Carrier's sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		right_ring="Stikini ring +1",
		left_ring="Shneddick Ring",
		back=AMBU_TP,
	}

    sets.idle.MDT = {
		main="Daybreak",
		sub="Sacro bulwark",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Chironic slippers",
		neck="Loricate Torque +1",
		waist="Carrier's sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		right_ring="Stikini ring +1",
		left_ring="Shneddick Ring",
		back=AMBU_TP,
	}
    
    
    -- Defense sets
	sets.defense.PDT = {
        ammo="Coiste bodhar",
		head="Malignance chapeau",
		body="Malignance tabard",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Malignance boots",
		neck="Anu Torque",
		--waist="Sailfi belt +1",
		waist="Orpheus's sash",
		left_ear="Sherida Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Petrov Ring",
		right_ring="Hetairoi Ring",
		back=AMBU_TP,		
	}

    sets.defense.MDT = {
		ammo="Staunch tathlum +1",
		head="Nyame Helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Loricate Torque +1",
		--waist="Flume Belt",
		waist="Orpheus's sash",
		left_ear="Etiolation Earring",
		right_ear="Shadow ring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=AMBU_TP,
	}

    sets.Kiting = {right_ring="Shneddick ring"}

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- sets.engaged = {
		-- ammo="Coiste bodhar",
		-- head="Bunzi's hat",
		-- body="Malignance tabard",
		-- hands="Bunzi's gloves",
		-- legs="Nyame flanchard",
		-- feet="Malignance boots",
		-- neck="Anu Torque",
		-- --waist="Reiki yotai",
		-- waist="Sailfi belt +1",
		-- --waist="Orpheus's sash",
		-- left_ear="Sherida Earring",
		-- right_ear="Eabani earring",
		-- --right_ear="Telos Earring",
		-- left_ring="Petrov Ring",
		-- right_ring="Hetairoi Ring",
		-- back=AMBU_TP,		
	-- }
	
	sets.engaged={
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Bunzi's Hat", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Lissome Necklace",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Eabani Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back=AMBU_TP,
	}

    sets.engaged.Enspell = {
		range=empty,
		head="Bunzi's hat",
		body="Lethargy sayon +3",
		hands="Aya. Manopolas +2",
		legs="Lethargy fuseau +3",
		legs="Malignance tights",
		feet="Lethargy houseaux +3",
		neck="Duelist's torque +2",
		waist="Orpheus's sash",
		left_ear="Dignitary's Earring",
		right_ear="Lethargy Earring +1",
		left_ring="Metamorph ring +1",
		right_ring="Hetairoi Ring",
		back=AMBU_DW,	
		ammo="Regal gem",
	}
	
	sets.engaged.EnspellDT = {
		range=empty,
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Bunzi's Hat", augments={'Path: A',}},
		body="Nyame mail",
		hands="Aya. Manopolas +2",
		legs="Malignance Tights",
		feet="Nyame sollerets",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Orpheus's sash",
		left_ear={ name="Leth. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Dbl.Atk."+3',}},
		right_ear="Sherida Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Hetairoi ring",
		back=AMBU_SWEnspell,
	}
    sets.engaged.Ongo = {
		range=empty,
		head="Bunzi's hat",
		body="Ayanmo corazza +2",
		hands="Aya. Manopolas +2",
		legs="Lethargy fuseau +3",
		legs="Vitiation tights +3",
		feet="Nyame sollerets",
		neck="Asperity necklace",
		waist="Orpheus's sash",
		left_ear="Sherida Earring",
		right_ear="Lethargy Earring +1",
		left_ring="Metamorph ring +1",
		right_ring="Hetairoi Ring",
		back=AMBU_TP,	
		ammo="Coiste bodhar",
	}
	
	sets.engaged.Single = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Bunzi's Hat", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Lissome Necklace",
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back=AMBU_TP,
	}

    sets.engaged.PhysicalDef = {
        ammo="Coiste bodhar",
		head="Bunzi's hat",
		body="Malignance tabard",
		hands="Nyame gauntlets",
		legs="Malignance tights",
		feet="Nyame sollerets",
		neck="Anu Torque",
		waist="Sailfi belt +1",
		--waist="Orpheus's sash",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Chirich ring +1",
		right_ring="Chirich ring +1",
		back=AMBU_TP, 
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
		elseif spellMap == 'Refresh' then
			equip(sets.midcast.Refresh)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
	if spell.name == "Enthunder" or spell.name == " Enthunder II" 
	or spell.name == "Enblizzard" or spell.name == "Enblizzard II"
	or spell.name == "Enfire" or spell.name == "Enfire II"
	or spell.name == "Enwater" or spell.name == "Enwater II"
	or spell.name == "Enaero" or spell.name == "Enaero II"
	or spell.name == "Enstone" or spell.name == "Enstone II" 
	or spell.name == "Gain-STR" or spell.name == "Gain-MND" 
	or spell.name == "Gain-DEX" or spell.name == "Gain-VIT" 
	or spell.name == "Gain-INT" or spell.name == "Gain-AGI" 
	or spell.name == "Temper II" or spell.name == "Temper" then
		equip(sets.midcast.EnSpell)
	end
end


--------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, macrobook)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, macrobook)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, macrobook)
    else
        set_macro_page(1, macrobook)
    end
end

function job_buff_change(buff,gain)
    if buff == "doom" then
        if gain then
            equip(sets.doom)
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            --handle_equipping_gear(player.status)
        end
    end

end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
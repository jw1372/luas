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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.PhysicalDefenseMode:options('PDT')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	lockstyleset=14
	select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {back="Smertrios's mantle",hands="Sakonji Kote +3",head="Wakido Kabuto +3"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	sets.JA = {}
    sets.JA["Jump"] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs="Kasuga Haidate +3",
		feet="Flam. Gambieras +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.JA["High Jump"] = sets.JA["Jump"]
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {    
		ammo="Knobkierrie",
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Kasuga Kote +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		left_ring="Ephramad's ring",
		waist="Kentarch Belt +1",
		left_ear="Schere earring",
		
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
	
	})
	
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {
	
	})
	
    sets.precast.WS['Tachi: Fudo'].PDL = set_combine(sets.precast.WS['Tachi: Fudo'], {
		feet="Kasuga sune-ate +3",
	})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		right_ring="Ephramad's Ring",
	})
	
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {
		right_ear="Schere earring",
		left_ring="Ephramad's ring",
		right_ring="Niqmaddu ring",
	})
	
    sets.precast.WS['Tachi: Shoha'].PDL = set_combine(sets.precast.WS['Tachi: Shoha'], {
		feet="Kasuga sune-ate +3",
	})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
		right_ear="Schere earring",
		left_ring="Ephramad's ring",
		right_ring="Niqmaddu ring",
		head="Nyame helm",
	})
	
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
	
	})
	
    sets.precast.WS['Tachi: Rana'].PDL = set_combine(sets.precast.WS['Tachi: Rana'], {
		feet="Kasuga sune-ate +3",
	})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {
	
	})

	sets.precast.WS['Tachi: Kasha'].PDL = set_combine(sets.precast.WS['Tachi: Kasha'], {
		feet="Kasuga sune-ate +3",
	})
	
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {
	
	})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {
	
	})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity necklace",
		waist="Eschan stone",
		left_ear="Mache earring +1",
		right_ear="Dignitary's earring",
		left_ring="Metamorph Ring",
		right_ring="Ephramad's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

	sets.precast.WS['Tachi: Kagero'] = sets.precast.WS['Tachi: Jinpu']
    
	sets.precast.WS['Tachi: Goten'] = sets.precast.WS['Tachi: Jinpu']
	sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Tachi: Jinpu']
	
	-- Midcast Sets
    sets.midcast.FastRecast = {
		left_ear="Loquacious earring",
		right_ear="Enchanter's earring +1",
		left_ring="Prolix ring",
		right_ring="Naji's loop",
		hands="Leyline gloves",
		ammo="Sapience orb",
		neck="Voltsurge torque",
		
	}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
	
	}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Tatenashi gote +1",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sweordfaetels +1",
		left_ear="Dedition Earring",
		right_ear="Kasuga earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Shneddick ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
    sets.idle.Field = {
		ammo="Staunch Tathlum +1",
		head="Wakido Kabuto +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Republican Platinum Medal",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.idle.Weak = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Tuisto Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Shneddick Ring",
		back="Moonbeam Cape",
	}
    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}


    sets.defense.MDT = set_combine(sets.defense.PDT, {
	
	})

    sets.Kiting = {

	}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Tatenashi gote +1",
		legs="Kasuga Haidate +3",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sweordfaetels +1",
		left_ear="Dedition Earring",
		right_ear="Kasuga earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {
		left_ear="Dignitary's earring",
	})
	
    sets.engaged.PDT = set_combine(sets.engaged, {
		left_ear="Dignitary's earring",
	})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
		left_ear="Dignitary's earring",
	}) 

    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
	
	-- MAX TP DEFINITION
	
	local maxTP=2750
	local currentWeapon = windower.ffxi.get_items('inventory').main

	if player.equipment.main =="Dojikiri Yasutsuna" then
		maxTP = maxTP -500
	end
	
	--add_to_chat(122, 'Current maxTP: ' .. maxTP)
	-- MAX TP SWAPS 
	
	if player.tp >= maxTP or buffactive.Sekkanoki then
		windower.add_to_chat(207, 'MAX TP Swap')
		if spell.english == "Tachi: Fudo" or spell.english == "Tachi: Kasha"
			or spell.english == "Tachi: Yukikaze" or spell.english == "Tachi: Gekko" 
			or spell.english == "Impulse Drive"  
		then 
			equip({right_ear="Ishvara earring", head="Nyame helm"})
		elseif spell.english == "Tachi: Shoha" or spell.english == "Tachi: Rana"
			or spell.english == "Stardiver" 
		then  
			equip({right_ear="Schere earring", head="Nyame helm"})
		elseif spell.english == "Tachi: Jinpu" or spell.english == "Tachi: Kagero" 
			or spell.english == "Tachi: Goten" or spell.english == "Tachi: Koki"  
		then 
			equip({right_ear="Thrud earring"})
		end
	end
	
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
        state.CombatForm:reset()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
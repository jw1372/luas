-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
	

end
 
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
 
    lockstyleset = 20
	select_default_macro_book()
	set_lockstyle()
    state.WeaponSet = M{['description']='Weapon Set', 'Vere', 'GH', 'Pole'}
 
 
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
 
    --state.FootworkWS = M(false, 'Footwork on WS')
 
    --info.impetus_hit_count = 0
    --windower.raw_register_event('action', on_action_for_impetus)
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','DEF','Staff')
    state.WeaponskillMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT','Hybrid')
 
    state.WeaponLock = M(false, 'Weapon Lock')
 
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ` tc nearest')
     
    update_combat_form()
    state.Auto_Kite = M(false, 'Auto_Kite')
    --update_melee_groups()
 
end
 
function user_unload()
    send_command('unbind `')
    send_command('unbind @r')
    send_command('unbind @e')
    send_command('unbind @w')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.CritBack = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
    gear.DABack = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	
    -- Precast Sets
     
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +3"}
    sets.precast.JA['Boost'] = {hands="Anchor. Gloves +3"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = {feet="Hes. Gaiters +3"}
    sets.precast.JA['Footwork'] = {feet="Bhikku gaiters +3"}
    sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +3"}
    sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3"}
 
    sets.precast.JA['Chi Blast'] = {head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}}}
 
    sets.precast.JA['Chakra'] = {
        ammo="Aurgelmir Orb",
        head="Genmei Kabuto",
        neck="Unmoving Collar +1",
        body="Tatena. Harama. +1",      
        hands="Tatena. Gote +1",
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
        waist="Caudata Belt",
        legs="Tatena. Haidate +1",
        feet="Tatena. Sune. +1"
        }
     
    sets.precast.JA['Provoke'] = {      
    ammo="Per. Lucky Egg",
    head="Emet harness +1",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Mag. Acc.+10','AGI+8','"Treasure Hunter"+2','Accuracy+13 Attack+13','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    waist="Chaac Belt",
 
    }
     
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo="Staunch Tathlum +1",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",
        body="Passion Jacket",hands=gear.WaltzHands,ring1="Valseur's Ring",ring2="Asklepian Ring",
        back="Moonbeam Cape",waist="Chaac Belt",legs=gear.WaltzLegs,feet=gear.WaltzFeet}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}
 
 
    -- Fast cast sets for spells
     
    sets.precast.FC = {
    ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Mag. Acc.+25','"Fast Cast"+5','MND+4','"Mag.Atk.Bns."+15',}},
    body={ name="Taeon Tabard", augments={'"Fast Cast"+4','Phalanx +3',}},
    hands="Leyline Gloves",
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+13','"Fast Cast"+4','INT+9','"Mag.Atk.Bns."+4',}},
    feet={ name="Herculean Boots", augments={'AGI+2','"Fast Cast"+6','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    neck="Baetyl Pendant",
    waist="Black Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Weather. Ring",
    --back="",
        }
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",neck="Magoraga Beads"})
 
        
    -- Weaponskill sets
 
    sets.precast.WS    = { 
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Bhikku cyclas +3",
    hands="Mpaca's gloves",
    legs="Mpaca's Hose",
    feet="Ken. Sune-Ate +1",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
    }
 
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",    
    body="Bhikku cyclas +3",
    })
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {
	    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
	

	sets.precast.WS['Spinning Attack']    = set_combine(sets.precast.WS, {
		
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Bhikku Cyclas +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
    })
     
    sets.precast.WS['Victory Smite']    = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body="Bhikku Cyclas +3",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Mpaca's boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
     
    sets.precast.WS['Ascetic\'s Fury'] = sets.precast.WS['Victory Smite']
     
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
     
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
 
    sets.precast.WS['Dragon Kick']    = sets.precast.WS['Tornado Kick']
     
    sets.precast.WS['Shell Crusher']   = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Eschan stone",
		left_ear="Digni. Earring",
		right_ear="Enchanter's earring +1",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Sacro Mantle",
    })
     
    sets.precast.WS['Cataclysm']   = set_combine(sets.precast.WS, {
		ammo="Perfect lucky egg",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Herculean boots",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back="Izdubar Mantle",
    })
    --weaponsets
    sets.Vere = {}
    sets.GH = {}
    sets.Pole = {}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience Orb",
        head=gear.FCHead,neck="Orunmila's Torque",
        body="Adhemar Jacket +1",hands="Leyline Gloves",ring1="Weather. Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Black Belt",legs="Rawhide Trousers",feet=gear.FCFeet}
     
    -- Idle sets
    sets.idle = {
    --range="Trollbane",
		ammo="Coiste bodhar",
		head="Mpaca's cap",
		body="Bhikku Cyclas +3",
		hands="Malignance Gloves",
		legs="Bhikku Hose +3",
		feet="Malignance Boots",
		neck="Rep. Plat. Medal",
		waist="Moonbow belt +1",
		left_ear="Sherida earring",
		right_ear="Sherida earring",
		left_ring="Warp Ring",
		right_ring="Shneddick Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
     
    -- Defense sets
    sets.defense.PDT = {
        }
 
    sets.defense.Hybrid = sets.defense.PDT
 
    sets.defense.MDT = sets.defense.PDT
 
    sets.Kiting = {feet="Hermes' Sandals"}
 
    -- engaged sets
     
    -- Normal melee sets -Subtle blow base 35%
    -- sets.engaged = {
		-- ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		-- head="Mpaca's cap",
		-- body="Mpaca's doublet",
		-- hands="Malignance gloves",
		-- legs="Bhikku Hose +3",
		-- feet="Ken. Sune-Ate +1",
		-- neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		-- waist="Moonbow Belt +1",
		-- left_ear={ name="Schere Earring", augments={'Path: A',}},
		-- right_ear="Sherida Earring",
		-- left_ring="Gere Ring",
		-- right_ring="Niqmaddu Ring",
		-- back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    -- }
	
    sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Bhikku crown +3",
		body="Malignance Tabard",
		hands="Nyame gauntlets",
		legs="Bhikku Hose +3",
		feet="Nyame sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
                 
    sets.engaged.DEF= set_combine(sets.engaged, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Bhikku crown +3",
		body="Malignance Tabard",
		hands="Nyame gauntlets",
		legs="Bhikku Hose +3",
		feet="Nyame sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    -- sets.engaged.DEF= set_combine(sets.engaged, {
		-- right_ring="Gelatinous Ring +1",
		-- body="Nyame mail",
		-- head="Nyame helm",
		-- feet="Nyame sollerets",
		
    -- })
	sets.engaged.Staff= set_combine(sets.engaged, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Bhikku Hose +3",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})
     
         
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.engaged.MA =   set_combine(sets.engaged, {right_ear="Mache Earring +1",})
    sets.engaged.MA.Tank =  set_combine(sets.engaged.Tank, {right_ear="Mache Earring +1",})
    --sets.footwork_kick_feet = {feet="Anch. Gaiters +3"}
    sets.footwork_kick_feet = {}
    --sets.impetus_body = {ammo="Coiste Bodhar", body="Bhikku Cyclas +3", right_ear="Schere Earring", back=gear.DABack}   
    sets.impetus_tp = {body="Bhikku Cyclas +3"}
    --sets.impetus_tp = {}
    sets.YourAskSashSetname  =  {waist="Ask Sash"}
     
    sets.buff.Doom = { 
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }
     
     
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
--function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    --if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        --eventArgs.handled = true
    --end
--end
 
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
          equip(sets.impetus_body)
          -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
        elseif state.Buff.Footwork and (spell.english == "Dragon Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
    end
end
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.WeaponLock.value == false then
        check_weaponset()
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
 
    return idleSet
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --ask sash
    if buff == 'Boost' then
        if gain then
            equip(sets.YourAskSashSetname)
            disable('waist')
        else
            enable('waist')
            handle_equipping_gear(player.status)
        end
    end
     
    if buffactive['Impetus'] then
            equip(sets.impetus_tp)
            disable('body')
        else
            enable('body')
            handle_equipping_gear(player.status)     
    end
     
    if buffactive['Footwork'] then
            equip(sets.footwork_kick_feet)
            disable('feet')
        else
            enable('feet')
            handle_equipping_gear(player.status)
    end
     
    if buff == "doom" then
                if gain then           
                        equip(sets.buff.Doom)
                        send_command('@input /p Doomed, please Cursna.')
                        send_command('@input /item "Holy Water" <me>')                    
                        disable('ring1','ring2','waist')
                elseif not gain and not player.status == "Dead" and not player.status == "Engaged Dead" then
                        enable('ring1','ring2','waist')
                        send_command('input /p Doom removed, Thank you.')
                        handle_equipping_gear(player.status)
                else
                        enable('ring1','ring2','waist')
                        send_command('input /p '..player.name..' is no longer Doom Thank you !')
                end
    end
 
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    --if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        --state.CombatForm:set('Footwork')
    --elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        --state.CombatForm:set('Footwork')
    --else
        --state.CombatForm:reset()
    --end
     
    -- Hundred Fists and Impetus modify the custom melee groups
    --if buff == "Hundred Fists" or buff == "Impetus" then
        --classes.CustomMeleeGroups:clear()
         
        --if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            --classes.CustomMeleeGroups:append('HF')
        --end
         
        --if (buff == "Impetus" and gain) or buffactive.impetus then
            --classes.CustomMeleeGroups:append('Impetus')
        --end
    --end
 
    -- Update gear if any of the above changed
 
    --if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Boost" then
        --handle_equipping_gear(player.status)
    --end
    --if not buffactive['Boost'] then
        --handle_equipping_gear(player.status)
    --end
     
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
--function customize_idle_set(idleSet)
    --if player.hpp < 75 then
        --idleSet = set_combine(idleSet, sets.ExtraRegen)
    --end
     
    --return idleSet
--end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end
 
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    --update_melee_groups()
end
 
function update_combat_form()
    if state.WeaponSet.value == 'GH' then
        state.CombatForm:set('MA')
    else 
        state.CombatForm:reset()  
    end
end
 
--function update_melee_groups()
    --classes.CustomMeleeGroups:clear()
     
    --if buffactive['hundred fists'] then
        --classes.CustomMeleeGroups:append('HF')
    --end
     
    --if buffactive.impetus then
        --classes.CustomMeleeGroups:append('Impetus')
    --end
--end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------
 
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
    check_weaponset()
end
 
function check_weaponset()
    equip(sets[state.WeaponSet.current])
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 15)
    else
        set_macro_page(1, 15)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
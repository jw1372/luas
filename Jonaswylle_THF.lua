-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
	lockstyleset=2
	set_lockstyle()
	
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
		ammo="Sapience Orb",
		head="Halitus Helm",
		body="Adamantite armor",
		hands="Kurys Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Skulk. Poulaines",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Trance Belt",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Supershear Ring",
		right_ring="Vexer Ring +1",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Phys. dmg. taken-10%',}},	
	}
    sets.ExtraRegen = {
	
	}
    sets.Kiting = {
		ring="Schneddick ring"
	}

    sets.buff['Sneak Attack'] = {
		ammo="Qirmiz Tathlum",
		legs="Darraigner's brais"
	}

    sets.buff['Trick Attack'] = {
		ammo="Qirmiz Tathlum", 
		legs="Darraigner's brais"
	}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


	--- AMBU CAPES ---
	AMBU_STP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	AMBU_DEXWSD = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	AMBU_DW = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}
	AMBU_EVA = { name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Phys. dmg. taken-10%',}}
	AMBU_INT = { name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {
		head="Skulker's bonnet +3",
	}
    sets.precast.JA['Accomplice'] = {
		head="Skulker's bonnet +3",
	}
    sets.precast.JA['Flee'] = {
	
	}
    sets.precast.JA['Hide'] = {
	
	}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"}
    sets.precast.JA['Steal'] = {
	
	}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Yamarang",
		head="Mummu Bonnet +2",
		body="Gleti's cuirass",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Dashing Subligar",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		waist="Carrier's Sash",
		left_ear="Sjofn earring",
		right_ear={ name="Handler's Earring +1", augments={'Path: A',}},
		left_ring="Asklepian Ring",
		right_ring="Defending Ring",
	}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {
	
	}


    -- Fast cast sets for spells
    sets.precast.FC = {
		hands="Leyline gloves",
		legs="Enif Cosciales",
		ear1="Etiolation earring",
		ear2="Loquacious Earring",
		left_ring="Prolix ring",
		right_ring="Lebeche ring",
		waist="Tempus fugit",
		ammo="Sapiens orb",	
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {
	
	}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head="Nyame helm",
		body="Skulker's vest +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi belt +1",
		left_ear="Skulker's earring +2",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back=AMBU_DEXWSD,
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ammo="Honed Tathlum", 
		back="Letalis Mantle"
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	
	})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
	
	})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {
	
	})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {
	
	})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {
	
	})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {
	
	})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {
	
	})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {
	
	})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {
	
	})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {
	
	})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {
	
	})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Coiste bodhar",
		head="Blistering sallet +1",
		body="Gleti's cuirass",
		hands="Nyame Gauntlets",
		legs="Samnuha tights",
		feet="Nyame Sollerets",
		neck="Fotia gorget",
		waist="Fotia Belt",
		right_ear="Skulker's Earring +2",
		left_ear="Odr earring",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back=AMBU_DEXWSD,
	})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
	
	})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {
	
	})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {
	
	})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {
	
	})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {
	
	})

    sets.precast.WS["Rudra's Storm"] = {
		ammo="Coiste bodhar",
		head="Nyame mail",
		body="Skulker's vest +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Asassin's gorget +2",
		waist="Kentarch belt +1",
		right_ear="Skulker's Earring +2",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back=AMBU_DEXWSD,
	}
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
	
	})
	
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {
	
	})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
	
	})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
	
	})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {
	
	})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
	
	})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {
	
	})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {
	
	})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {
	
	})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {
	
	})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {
	
	})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {
	
	})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {
	
	})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {
	
	})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {
	
	})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {
	
	})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {
	
	})

    sets.precast.WS['Aeolian Edge'] = {    
		ammo="Perfect lucky egg",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Herculean boots",
		neck="Sibyl Scarf",
		waist="Orpheus's sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back=AMBU_INT,
	}
	
	sets.precast.WS['Savage Blade'] = {    
		ammo="Seeth. Bomblet +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's Ring",
		back=AMBU_DEXWSD,
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		hands="Leyline gloves",
		legs="Enif Cosciales",
		ear1="Enchanter's earring +1",
		ear2="Loquacious Earring",
		left_ring="Prolix ring",
		right_ring="Lebeche ring",
		waist="Tempus fugit",
		ammo="Sapiens orb",	
	}

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {
		neck="Magoraga beads",
	})

    -- Ranged gear
    sets.midcast.RA = {

	}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
	
	})


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
	
	}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Adamantite armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets", 
		neck="Rep. Plat. Medal",
		waist="Carrier's sash",
		left_ear="Eabani Earring",
		right_ear="Hearty earring",
		left_ring="Warp ring",
		right_ring="Shneddick Ring",
		back=AMBU_EVA,
	}

    sets.idle.Weak = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame sollerets",
		neck="Anu Torque",
		waist="Carrier's sash",
		left_ear="Sherida Earring",
		right_ear="Skulk. earring +2",
		left_ring="Defending ring",
		right_ring="Shneddick Ring",
		back=AMBU_EVA,
	}

    sets.idle.Town = {
		ammo="Coiste bodhar",
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Malignance gloves",
		legs="Gleti's breeches",
		feet="Malignance boots",
		neck="Asn. Gorget +2",
		waist="Reiki yotai",
		left_ear="Sherida Earring",
		right_ear="Skulker's earring +2",
		left_ring="Warp Ring",
		right_ring="Shneddick Ring",
		back=AMBU_EVA,
	}


    -- Defense sets

    sets.defense.Evasion = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Malignance gloves",
		legs="Gleti's breeches",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki yotai",
		left_ear="Sherida Earring",
		right_ear="Skulker's earring +2",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back=AMBU_STP,	
		}

    sets.defense.PDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Nyame Gauntlets",
		legs="Gleti's breeches",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki yotai",
		left_ear="Sherida Earring",
		right_ear="Skulker's earring +2",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back=AMBU_STP,	
	}

    sets.defense.MDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Nyame Flanchard",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki yotai",
		left_ear="Sherida Earring",
		right_ear="Skulker's earring +2",
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back=AMBU,	
	}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Coiste bodhar",
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Malignance gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki yotai",
		left_ear="Sherida Earring",
		right_ear="Skulker's earring +2",
		left_ring="Gere Ring",
		right_ring="Petrov Ring",
		back=AMBU_STP,	
	}
    sets.engaged.Acc = set_combine(sets.engaged, {
	
	})
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = set_combine(sets.engaged, {
	
	})
    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = set_combine(sets.engaged, {
	
	})

    sets.engaged.Evasion = set_combine(sets.engaged, {
	
	})
	
    sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
	
	})

    sets.engaged.PDT = set_combine(sets.engaged, {
		body="Adamantite armor",
	})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
	
	})

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'Tag' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end

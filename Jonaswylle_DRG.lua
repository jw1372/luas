
-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

    lockstyleset = 9
	

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'PDL', 'SB')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')
    state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	-- send_command('bind ^f9 gs c cycle AttackMode') -- Att level
    send_command('bind ^` input /ja "Call Wyvern" <me>')
    send_command('bind !` input /ja "Spirit Link" <me>')
    send_command('bind @` input /ja "Dismiss" <me>')
    send_command('bind ^f10 gs c cycle AttackMode')
    -- send_command('bind @c gs c toggle CP')
	
	ambuSTRWSD = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	ambuSTP = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	ambuSTRDA = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

    if player.sub_job == 'WAR' then
        send_command('bind !w input /ja "Defender" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind !w input /ja "Hasso" <me>')
    end

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end

    send_command('bind ^numpad7 input /ws "Camlann\'s Torment" <t>')
    send_command('bind ^numpad8 input /ws "Drakesbane" <t>')
    send_command('bind ^numpad4 input /ws "Stardiver" <t>')
    send_command('bind ^numpad5 input /ws "Geirskogul" <t>')
    send_command('bind ^numpad6 input /ws "Impulse Drive" <t>')
    send_command('bind ^numpad1 input /ws "Sonic Thrust" <t>')
    send_command('bind ^numpad2 input /ws "Leg Sweep" <t>')

    send_command('bind ^numpad0 input /ja "Jump" <t>')
    send_command('bind ^numpad. input /ja "High Jump" <t>')
    send_command('bind ^numpad+ input /ja "Spirit Jump" <t>')
    send_command('bind ^numpadenter input /ja "Soul Jump" <t>')
    send_command('bind ^numlock input /ja "Super Jump" <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind @`')
    send_command('unbind @a')
    -- send_command('unbind @c')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpadenter')
    send_command('unbind ^numlock')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail"}
    sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail"}
    sets.precast.JA['Ancient Circle'] = {legs="Drachen brais"}

    sets.precast.JA['Spirit Link'] = {
		hands="Peltast's vambraces +3",
		feet="Pteroslaver greaves"
	}

    sets.precast.JA['Steady Wing'] = {

	}

    sets.precast.JA['Provoke'] = {
		ammo="Sapience orb",
		head="Halitus helm",
		body="Emet harness +1",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Unmoving collar +1",
		waist="Trance belt",
		left_ear="Cryptic Earring",
		right_ear="Odnowa earring +1",
		left_ring="Vexer Ring +1",
		right_ring="Supershear ring",
		back=ambuSTP,
	}
	-- NORMAL JUMPS FRICK
	
    sets.precast.JA['Jump'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi helm",
		body="Vishap Mail +3",
		hands="Vishap finger gauntlets +3",
		legs="Pteroslaver brais +3",
		feet="Ostro greaves",
		neck="Vim torque +1",
		waist="Kentarch belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight ring",
		back=ambuSTP,
	}
	

	--ODY JUMPS 
	
	-- sets.precast.JA['Jump'] = {
		-- ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		-- head="Hjarrandi helm",
		-- body="Nyame mail",
		-- hands="Nyame gauntlets",
		-- legs="Nyame flanchard",
		-- feet="Nyame sollerets",
		-- neck="Vim torque +1",
		-- waist="Kentarch belt +1",
		-- left_ear="Sherida Earring",
		-- right_ear="Telos Earring",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Moonlight ring",
		-- back=ambuSTP,
	-- }
	
    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {
		legs="Pteroslaver brais +3"
	})
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {
		feet="Peltast's schynbalds +3"
	})
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
	
	})
    sets.precast.JA['Super Jump'] = {}

    sets.precast.JA['Angon'] = {ammo="Angon", hands="Ptero. Fin. G. +1"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1", --14
        hands="Leyline Gloves", --8
        legs="Enif Cosciales", --6
        feet="Carmine Greaves +1", --8
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Prolix ring", --6(4)
		ring1="Naji's loop",
	}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- ODY DT WS Set
	
	-- sets.precast.WS = {
        -- ammo="Knobkierrie",
        -- head="Nyame helm",
        -- body="Nyame mail",
        -- hands="Nyame gauntlets",
        -- legs="Nyame flanchard",
        -- feet="Nyame sollerets",
        -- neck="Dragoon's collar +2",
        -- ear1="Thrud Earring",
        -- ear2="Moonshade Earring",
        -- ring1="Epaminondas's Ring",
        -- ring2="Ephramad's Ring",
        -- back=ambuSTRWSD,
        -- waist="Sailfi belt +1",
	-- }
	
	-- NORMAL ASS WS SET FRICK
	
	sets.precast.WS = {
        ammo="Knobkierrie",
        head="Peltast's mezail +3",
        body="Nyame mail",
        hands="Nyame gauntlets",
        legs="Nyame flanchard",
        feet="Nyame sollerets",
        neck="Dragoon's collar +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ephramad's Ring",
        back=ambuSTRWSD,
        waist="Sailfi belt +1",
	}
	

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		body="Peltast's plackart +3",
		ear1="Telos earring",
		ring2="Regal Ring",
		ammo="Voluspa tathlum",
		waist="Kentarch belt +1"
		
	})
	
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		body="Peltast's plackart +3",
		ear1="Peltast's earring +1",
	})
	
    sets.precast.WS['Camlann\'s Torment'] = set_combine(sets.precast.WS, {

	})

    sets.precast.WS['Camlann\'s Torment'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})

    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {

	})

    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {

	})

    sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {

	})

    sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		legs="Peltast's cuissots +3",
		ring2="Ephramad's ring",
	})

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
	})

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {

	})

    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Camlann\'s Torment']
    sets.precast.WS['Sonic Thrust'].Acc = sets.precast.WS['Camlann\'s Torment'].Acc

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		neck="Fotia gorget",
		body="Gleti's Cuirass",
		waist="Fotia gorget",
		ear1="Sherida earring",
		hands="Peltast's vambraces +3",
		ring1="Niqmaddu ring",
		ring2="Ephramad's ring",
		ammo="Coiste bodhar",
		back=ambuSTRDA,
	})

    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {

	})

    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {
        neck="Sibyl scarf",
		head="Nyame helm",
        ring2="Metamor. Ring +1",
		ear1="Friomisi earring",
		waist="Orpheus's sash",
	})

    sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']

    sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
        ammo="Hydrocera",
        ear1="Enchanter's earring +1",
        ring1="Metamor. Ring +1",
        ring2="Stikini ring +1",
		waist="Eschan stone",
	})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        neck="Sibyl scarf",
		head="Nyame helm",
        ring2="Metamor. Ring +1",
		ear1="Friomisi earring",
		waist="Orpheus's sash",
	})
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Aeolian Edge'], {
		ammo="Ghastly tathlum +1",
		head="Pixie hairpin +1",
		ring2="Archon ring",
		
	})
	
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {
		ring2="Metamor. Ring +1",
		
	})
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
	    ammo="Knobkierrie",
        head="Peltast's mezail +3",
        body="Peltast's plackart +3",
        hands="Peltast's vambraces +3",
        legs="Nyame flanchard",
        feet="Nyame sollerets",
        neck="Dragoon's collar +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Ephramad's Ring",
        back=ambuSTRWSD,
        waist="Kentarch belt +1",	
	})
	
	sets.precast.WS['Judgment'].Acc = set_combine(sets.precast.WS['Judgment'], {
		--feet="Peltast's schynbalds +3",
		--ammo="Voluspa tathlum",
		--ear1="Telos earring",
	})

    sets.WSDayBonus = {head="Gavialis Helm"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.HealingBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +2",
        ear1="Lancer's Earring",
        ear2="Anastasi Earring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        }

    sets.midcast.ElementalBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        neck="Lancer's Torque",
        ear1="Enmerkar Earring",
        ear2="Dragoon's Earring",
        ring1="C. Palug Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1", --3/3
        head="Valorous mask",
        body="Gleti's cuirass",
        hands="Gleti's gauntlets",
        legs="Gleti's breeches",
        feet="Gleti's boots",
        neck="Republican platinum medal",
        ear1="Etiolation Earring",
        ear2="Hearty Earring",
        ring1="Defending ring",
        ring2="Shneddick ring",
        back=ambuSTP,
        waist="Carrier's sash", --4/0
	}

    sets.idle.DT = set_combine(sets.idle, {

	})

    sets.idle.Pet = set_combine(sets.idle, {

	})

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {

	})

    sets.idle.Town = set_combine(sets.idle, {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi helm",
		body="Peltast's plackart +3",
		hands="Peltast's vambraces +3",
		legs="Pteroslaver brais +3",
		feet="Nyame sollerets",
		neck="Vim torque +1",
		waist="Sailfi belt +1",
		left_ear="Sherida Earring",
		right_ear="Sroda Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Shneddick ring",
		back=ambuSTP,
    })

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {ring="Shneddick ring"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi helm",
		body="Peltast's plackart +3",
		hands="Peltast's vambraces +3",
		legs="Pteroslaver brais +3",
		feet="Flam. Gambieras +2",
		neck="Vim torque +1",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Sroda Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight ring",
		back=ambuSTP,
	}

    sets.engaged.MidAcc = set_combine(sets.engaged, {
		right_ear="Telos earring"

    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		waist="Ioskeha belt +1",
		ring1="Chirich ring +1",
		ammo="Voluspa tathlum",
		neck="Dragoon's collar +2",
		head="Gleti's mask",
		feet="Peltast's schynbalds +3"
    })
	
	sets.engaged.PDL = set_combine(sets.engaged, {
		
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

	-- NORMAL HYBRID FRICK
	
    sets.engaged.Hybrid = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi helm",
		body="Peltast's plackart +3",
		hands="Peltast's vambraces +3",
		legs="Gleti's Breeches",
		feet="Nyame sollerets",
		neck="Vim torque +1",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Sroda Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight ring",
		back=ambuSTP,
	}
	
	-- SUBTLE BLOW HYBRID
	
    sets.engaged.SB= {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Hjarrandi helm",
		body="Dagon breastplate",
		hands="Peltast's vambraces +3",
		legs="Gleti's Breeches",
		feet="Peltast's schynbalds +3",
		neck="Vim torque +1",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Sroda Earring",
		left_ring="Niqmaddu ring",
		right_ring="Chirich ring +1",
		back=ambuSTP,
	}
	
	-- ODY HYBRID 
	
	-- sets.engaged.Hybrid = {
		-- ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		-- head="Hjarrandi helm",
		-- body="Gleti's cuirass",
		-- hands="Gleti's gauntlets",
		-- legs="Gleti's breeches",
		-- feet="Nyame sollerets",
		-- neck="Dragoon's collar +2",
		-- waist="Sailfi Belt +1",
		-- left_ear="Sherida Earring",
		-- right_ear="Dedition Earring",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Moonlight ring",
		-- back=ambuSTP,
	-- }
	
	
	sets.engaged.Hybrid.MidAcc = set_combine(sets.engaged.Hybrid, {
		right_ear="Telos earring",
		neck="Dragoon's collar +2",
		left_ring="Chirich ring +1"
	})
	
	sets.engaged.Hybrid.HighAcc = set_combine(sets.engaged.Hybrid.MidAcc, {
		waist="Ioskeha belt +1",
		left_ear="Mache earring +1",
		feet="Peltast's schynbalds +3",
		ammo="Voluspa tathlum",
		ring1="Chirich ring +1",
		head="Gleti's mask",
		
	})

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
	sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Blenmot's ring +1", --20
        ring2="Purity ring", --20
        waist="Gishdubar Sash", --10
	}

    -- sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
    elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
        equip(sets.precast.HealingBreath)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Stardiver' and state.WeaponskillMode.current == 'Normal' then
            if world.day_element == 'Earth' or world.day_element == 'Light' or world.day_element == 'Dark' then
                equip(sets.WSDayBonus)
           end
        elseif spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.midcast.HealingBreath)
    elseif wyv_elem_breath:contains(spell.english) then
        equip(sets.midcast.ElementalBreath)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
   -- If we gain or lose any haste buffs, adjust which gear set we target.
   if buffactive['Reive Mark'] then
       if gain then
           equip(sets.Reive)
           disable('neck')
       else
           enable('neck')
       end
   end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
    end

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
	elseif state.OffenseMode.value == 'PDL' then
        add_to_chat(50, 'In PDL MODE!')
		wsmode = 'PDL'
	else
		wsmode = 'Normal'
    end
    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)

    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value
    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
		equip({neck="Vim Torque +1"})
	else
		if not midaction() then
			status_change(player.status)
		end
	end
	if buff == "doom" then
        if gain then
            equip(sets.Doom)
            --send_command('@input /p Doomed.')
            disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            --handle_equipping_gear(player.status)
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    --if player.sub_job == 'SAM' then
        set_macro_page(1, 9)
    --else
        --set_macro_page(2, 8)
    --end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
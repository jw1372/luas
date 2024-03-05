-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


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
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
    elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire"}
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    define_roll_values()

    lockstyleset = 4
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'STP')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.WeaponSet = M{['description']='Weapon Set', 'DeathPenalty_M', 'DeathPenalty_R', 'Armageddon_M', 'Armageddon_R', 'Fomalhaut_M', 'Fomalhaut_R', 'Ataktos'}
    -- state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    --gear.RAbullet = "Chrono Bullet"
    --gear.RAccbullet = "Devastating Bullet"
    --gear.WSbullet = ""
    --gear.MAbullet = ""
    --gear.QDbullet = ""
    options.ammo_warning_limit = 10

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind ^c input /ja "Crooked Cards" <me>')
    send_command('bind ^s input /ja "Snake Eye" <me>')
    send_command('bind ^f input /ja "Fold" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command ('bind @` gs c toggle LuzafRing')

    send_command('bind ^insert gs c cycleback mainqd')
    send_command('bind ^delete gs c cycle mainqd')
    send_command('bind ^home gs c cycle altqd')
    send_command('bind ^end gs c cycleback altqd')
    send_command('bind ^pageup gs c toggle selectqdtarget')
    send_command('bind ^pagedown gs c toggle usealtqd')

    -- send_command('bind @c gs c toggle CP')
    send_command('bind @q gs c cycle QDMode')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numlock input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    end

    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    send_command('bind ^numpad4 input /ws "Leaden Salute" <t>')
    send_command('bind ^numpad5 input /ws "Requiescat" <t>')
    send_command('bind ^numpad6 input /ws "Wildfire" <t>')
    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')
    send_command('bind ^numpad2 input /ws "Evisceration" <t>')

    send_command('bind %numpad0 input /ra <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^c')
    send_command('unbind ^s')
    send_command('unbind ^f')
    send_command('unbind !`')
    send_command('unbind @t')
    send_command('unbind @`')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^,')
    -- send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind numpad0')

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

	rostam = {}
	rostam.Roll = {name="Rostam",bag="Wardrobe3"}
	rostam.STP = {name="Rostam",bag="Wardrobe2"}
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    sets.precast.CorsairRoll = {
		neck="Regal necklace",
		head="Lanun tricorne +1",
		hands="Chasseur's gants+3",
    }

    sets.precast.CorsairRoll.Duration = {main=rostam.Roll, range="Compensator",neck="Regal necklace", hands="Chasseur's gants +3", head="Lanun tricorne +1"}
    sets.precast.CorsairRoll.LowerDelay = {back="Gunslinger's Cape"}
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's gants +3"})

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		left_ring="Asklepian Ring",
	}

    sets.precast.Waltz['Healing Waltz'] = {
		head="Mummu Bonnet +2",
		left_ring="Asklepian Ring",
	}

    sets.precast.FC = {
		head="Carmine mask +1",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		neck="Voltsurge Torque",
		waist="Tempus Fugit",
		feet="Carmine greaves +1",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		right_ring="Kishar Ring",
		
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
	})

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
		head="Chass. Tricorne +3",
		body="Oshosi Vest",
		hands="Lanun gants +3",
		legs="Adhemar kecks +1",
		feet="Meg. Jam. +2",
		neck={ name="Comm. Charm +1", augments={'Path: A',}},
		waist="Impulse belt",
		back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}},
	} 

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +3", --0/20
		hands="Carmine Fin. Ga. +1", --8/11
	
	})
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        waist="Yemaya belt",
	})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo="Chrono Bullet",
		head="Nyame helm",
		body="Ikenga's vest",
		hands="Chasseur's gants +3",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Fotia Gorget",
		waist="Fotia belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
    }

    sets.precast.WS.Acc = {
		ammo="Chrono Bullet",
		head="Chass. Tricorne +3",
		body="Ikenga's vest",
		hands="Chasseur's gants +3",
		legs="Nyame flanchard",
		feet="Lanun bottes +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Ephramad's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	
-- NORMIE ACC FRICK

    sets.precast.WS['Last Stand'] = {
		ammo="Chrono Bullet",
		head="Nyame helm",
		body="Ikenga's vest",
		hands="Chasseur's gants +3",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Fotia Gorget",
		waist="Fotia belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

-- SORTIE ACC

	-- sets.precast.WS['Last Stand'] = {
		-- ammo="Chrono Bullet",
		-- head="Chass. Tricorne +3",
		-- body="Laksa. Frac +3",
		-- hands="Chasseur's gants +3",
		-- legs="Chasseur's culottes +3",
		-- feet="Malignance boots",
		-- neck="Iskur Gorget",
		-- waist="Yemaya Belt",
		-- left_ear="Beyla earring",
		-- right_ear="Telos Earring",
		-- left_ring="Ephramad's Ring",
		-- right_ring="Cacoethic Ring +1",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	-- }
	
    sets.precast.WS['Last Stand'].Acc = sets.precast.WS.acc

    sets.precast.WS['Wildfire'] = {
		ammo="Devastating Bullet",
		head="Nyame helm",
		body="Lanun Frac +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet={ name="Lanun bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Ishvara Earring",
		right_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Leaden Salute'] = {
		ammo="Devastating Bullet",
		head="Pixie Hairpin +1",
		body="Lanun Frac +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet={ name="Lanun bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Commodore charm +1",
		--waist="Orpheus's sash",
		waist="Eschan stone",
		left_ear="Moonshade earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},		
	}
	
	sets.precast.WS['Hot Shot'] = {
		ammo="Chrono Bullet",
		head="Nyame helm",
		body="Nyame mail",
		hands="Chasseur's gants +3",
		legs="Nyame flanchard",
		feet={ name="Lanun bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia gorget",
		waist="Orpheus's sash",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		right_ring="Epaminondas's Ring",
		right_ring="Ephramad's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},		
	}

    sets.precast.WS['Savage Blade'] = {
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
	    legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS['Circle Blade']= set_combine(sets.precast.WS['Savage Blade'], {
        ear2="Telos Earring",
	})
	
	sets.precast.WS['Sniper Shot'] = {
		ammo="Chrono Bullet",
		head="Chass. Tricorne +3",
		body="Laksa. Frac +3",
		hands="Chasseur's gants +3",
		legs="Chasseur's culottes +3",
		feet="Malignance boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Beyla earring",
		right_ear="Telos Earring",
		left_ring="Ephramad's Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        ear2="Telos Earring",
	})

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {

	})

    sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {
   
   
	})

    sets.precast.WS['Requiescat'] = {
		head="Nyame helm",
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs="Nyame flanchard",
		feet={ name="Lanun bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ephramad's Ring",
		right_ring="Rufescent Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},

	} --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {


	})

    sets.precast.WS['Aeolian Edge'] = {
 		ammo="Hauksbok Bullet",
		head="Nyame helm",
		body="Lanun Frac +3",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet={ name="Lanun bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sibyl Scarf",
		waist="Orpheus's sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        
		
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Cure = {


    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head="Ikenga's hat",
		body={ name="Mirke Wardecors", augments={'"Mag.Atk.Bns."+4','"Quick Draw" ability delay -5',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame flanchard",
		feet="Chasseur's bottes +3",
		neck="Sanctity necklace",
		waist="Orpheus's sash",
		left_ear="Friomisi earring",
		right_ear="Novio Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},		
	}

    sets.midcast.CorsairShot.STP = {
		ammo="Hauksbok Bullet",
		head="Ikenga's hat",
		body={ name="Mirke Wardecors", augments={'"Mag.Atk.Bns."+4','"Quick Draw" ability delay -5',}},
		hands="Schutzen Mittens",
		legs="Chasseur's culottes +3",
		feet="Chasseur's bottes +3",
		neck="Iskur Gorget",
		waist="Yemaya belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

    --sets.midcast.CorsairShot['Light Shot'] = {

	--}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
    sets.midcast.CorsairShot.Enhance = {body="Mirke Wardecors", feet="Chass. Bottes +1"}

	-- SORTIE ACC FRICK
	-- sets.midcast.RA = {
		-- ammo="Chrono Bullet",
		-- head="Chass. Tricorne +3",
		-- body="Chasseur's frac +3",
		-- hands="Chasseur's gants +3",
		-- legs="Chasseur's culottes +3",
		-- feet="Malignance boots",
		-- neck="Iskur Gorget",
		-- waist="Yemaya Belt",
		-- left_ear="Beyla earring",
		-- right_ear="Telos Earring",
		-- left_ring="Hajduk Ring",
		-- right_ring="Cacoethic Ring +1",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	-- }
	
	-- TEST
	-- sets.midcast.RA = {
		-- ammo="Chrono Bullet",
		-- head="Malignance chapeau",
		-- body="Malignance tabard",
		-- hands="Chasseur's gants +3",
		-- legs="Chasseur's culottes +3",
		-- feet="Malignance boots",
		-- neck="Iskur Gorget",
		-- waist="Yemaya Belt",
		-- left_ear="Beyla earring",
		-- right_ear="Telos Earring",
		-- left_ring="Hajduk Ring",
		-- right_ring="Cacoethic Ring +1",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	-- }
	
	
	-- LESS ACC
	sets.midcast.RA = {
		ammo="Chrono Bullet",
		head="Ikenga's hat",
		body="Ikenga's vest",
		hands="Ikenga's gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Beyla earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, { 
		left_ear="Beyla earring",
		right_ear="Telos earring",
		body="Laksa. Frac +3",
		left_ring="Regal ring",
		head="Chasseur's tricorne +3"
		
	})

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {

	})

	-- SORTIE AM3 FRICK
	-- sets.midcast.RA.Critical = sets.midcast.RA
	
	-- NORMAL AM3
	
    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
		ammo="Chrono bullet",
		head="Meghanada visor +2",
		body="Ikenga's vest",
		hands="Chasseur's gants +3",
		legs="Darraigner's brais",
		feet="Oshosi leggings +1",
		neck="Iskur gorget",
		left_ear="Odr earring",
		right_ear="Chasseur's earring +1",
		left_ring="Ephramad's ring",
		right_ring="Dingir ring",
		waist="Kwahu kachina belt +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}},
	})

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {


	})

	-- NORMIE ACC FRICK
    sets.TripleShot = {
		head="Oshosi Mask",
		body="Chasseur's frac +3",
		hands="Lanun gants +3",
		legs="Chasseur's culottes +3",
		feet="Oshosi leggings +1",
		neck="Iskur Gorget",
		waist="Yemaya belt",
		right_ear="Dedition Earring",
		left_ear="Beyla Earring",
		left_ring="Chirich ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},

	} 

	-- SORTIE ACC
	
    -- sets.TripleShot = {
		-- ammo="Chrono Bullet",
		-- head="Chass. Tricorne +3",
		-- body="Chasseur's frac +3",
		-- hands="Lanun gants +3",
		-- legs="Chasseur's culottes +3",
		-- feet="Oshosi leggings +1",
		-- neck="Iskur Gorget",
		-- waist="Yemaya belt",
		-- right_ear="Telos Earring",
		-- left_ear="Beyla Earring",
		-- left_ring="Cacoethic ring +1",
		-- right_ring="Hajduk Ring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	-- } 
	
	-- TEST
	-- sets.TripleShot = {
		-- ammo="Chrono Bullet",
		-- head="Oshosi mask",
		-- body="Chasseur's frac +3",
		-- hands="Lanun gants +3",
		-- legs="Chasseur's culottes +3",
		-- feet="Oshosi leggings +1",
		-- neck="Iskur Gorget",
		-- waist="Yemaya belt",
		-- right_ear="Telos Earring",
		-- left_ear="Beyla Earring",
		-- left_ring="Cacoethic ring +1",
		-- right_ring="Hajduk Ring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	-- } 
	
    sets.TripleShot.Acc= set_combine(sets.TripleShot, {
		feet="Malignance boots",
		left_ear="Telos earring",
		right_ring="Hajduk ring",
		legs="Chasseur's culottes +3",
	})
	
	sets.TripleShot.HighAcc= set_combine(sets.TripleShot.Acc, { 
		body="Laksamana's frac +3",
		left_ring="Regal ring",
	})
	
	sets.TripleShotCritical = set_combine(sets.TripleShot, { 
		head="Meghanada visor +2",
		left_ring="Ephramad's ring",
		right_ring="Ilabrat ring",
		left_ear="Odr earring",
		right_ear="Chasseur's earring +1",
		legs="Darraigner's brais",
		waist="Kwahu kachina belt +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}},
	})
    sets.TrueShot = {


	}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
		ammo="Chrono bullet",
		head="Malignance chapeau",
		body="Malignance tabard",
		hands="Malignance gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance boots",
		neck="Rep. Plat. Medal",
		waist="Carrier's sash",
		left_ear="Eabani earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

    sets.idle.DT = {
		ammo="Chrono bullet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Chasseur's culottes +3",
		feet={ name="Herculean Boots", augments={'Accuracy+17 Attack+17','"Triple Atk."+3','DEX+8','Attack+14',}},
		neck="Iskur Gorget",
		waist="Carrier's sash",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},

	}

    sets.idle.Refresh = set_combine(sets.idle, {


	})

    sets.idle.Town = {
		ammo="Chrono Bullet",
		head="Chass. Tricorne +3",
		body="Chasseur's Frac +3",
		hands="Chasseur's gants +3",
		legs="Chasseur's culottes +3",
		feet="Chasseur's bottes +3",
		neck="Iskur Gorget",
		waist="Yemaya belt",
		left_ear="Beyla Earring",
		right_ear="Dedition Earring",
		left_ring="Ilabrat Ring",
		right_ring="Shneddick Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},

	}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- sets.defense.PDT = {
		-- ammo="Chrono bullet",
	    -- head="Malignance Chapeau",
		-- body="Nyame Mail",
		-- hands="Nyame Gauntlets",
		-- legs="Nyame Flanchard",
		-- feet="Malignance Boots",
		-- neck="Loricate torque +1",
		-- waist="Reiki Yotai",
		-- left_ear="Cessance earring",
		-- right_ear="Odnowa earring +1",
		-- left_ring="Chirich ring +1",
		-- right_ring="Chirich ring +1",
		-- back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	-- }

    sets.defense.PDT = {
		ammo="Chrono bullet",
	    head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance Boots",
		neck="Loricate torque +1",
		waist="Sailfi belt +1",
		left_ear="Telos earring",
		right_ear="Dignitary's earring",
		left_ring="Chirich ring +1",
		right_ring="Chirich ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}


    sets.defense.MDT = {


	}

    sets.Kiting = {right_ring="Shneddick ring"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
		ammo="Chrono bullet",
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Malignance gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Sailfi belt +1",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}


    sets.engaged.MidAcc = set_combine(sets.engaged, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"
 
	})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {


	})

    sets.engaged.STP = set_combine(sets.engaged, {
	
    })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
		ammo="Chrono bullet",
		head="Malignance Chapeau",
		body="Adhemar Jacket",
		hands="Malignance gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Sailfi belt +1",
		left_ear="Dedition Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
     }

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"

	})

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {

	})

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {

	})

    -- 15% Magic Haste (67% DW to cap)
	sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {

	})

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"
	})

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {


	})

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {


	})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.LowHaste, {

	})

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"
	})

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {

	})

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

	})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW.MidHaste, {

	})

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DWHighHaste, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"
	})

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {

	})

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

	})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste =  set_combine(sets.engaged.DW.HighHaste, {

	})

    sets.engaged.DW.MidAcc.MaxHaste =  set_combine(sets.engaged.DW.HighHaste, {
		right_ring="Chirich ring +1",
		right_ear="Mache earring +1"
	})
	
    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {

	})

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {

	})

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=gear.COR_DW_Cape})
    sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=gear.COR_DW_Cape})
    sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=gear.COR_DW_Cape})
    sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=gear.COR_DW_Cape})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		ammo="Chrono bullet",
		head="Malignance Chapeau",
		body="Malignance tabard",
		hands="Malignance gloves",
		legs="Chasseur's culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Sailfi belt +1",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Blenmot's ring +1",
        ring2="Purity ring",
        waist="Gishdubar Sash", --10
	}

    sets.FullTP = {ear1="Moonshade Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Aptitude Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.TreasureHunter = {head="Volte Cap", hands=gear.Herc_TH_hands, feet="Volte Boots", waist="Chaac Belt"}

    -- sets.DeathPenalty_M = {main={name="Rostam", bag="wardrobe3"}, sub="Tauret", ranged="Death Penalty"}
    -- sets.DeathPenalty_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    -- sets.DeathPenalty_R = {main="Lanun Knife", sub="Tauret", ranged="Death Penalty"}
    -- sets.DeathPenalty_R.Acc = {main="Lanun Knife", sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    -- sets.Armageddon_M = {main="Naegling", sub="Tauret", ranged="Armageddon"}
    -- sets.Armageddon_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub={name="Rostam", bag="wardrobe4"}, ranged="Armageddon"}
    -- sets.Armageddon_R = {main="Lanun Knife", sub="Kustawi +1", ranged="Armageddon"}
    -- sets.Armageddon_R.Acc = sets.Armageddon_R
    -- sets.Fomalhaut_M = {main={name="Rostam", bag="wardrobe3"}, sub="Blurred Knife +1", ranged="Fomalhaut"}
    -- sets.Fomalhaut_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub="Kustawi +1", ranged="Fomalhaut"}
    -- sets.Fomalhaut_R = {main="Lanun Knife", sub="Kustawi +1", ranged="Fomalhaut"}
    -- sets.Fomalhaut_R.Acc = sets.Fomalhaut_R
    -- sets.Ataktos = {main="Naegling", sub="Blurred Knife +1", ranged="Ataktos"}
    -- sets.Ataktos.Acc = {main="Naegling", sub="Demers. Degen +1", ranged="Ataktos"}

    -- sets.DefaultShield = {sub="Nusku Shield"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    --if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
      --  do_bullet_checks(spell, spellMap, eventArgs)
    --end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false then
            equip(sets.precast.CorsairRoll.Duration)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    end
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
        end
        -- Replace TP-bonus gear if not needed.
        if spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
        end
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            --elseif spell.target.distance < (1.7 + spell.target.model_size) then
              --  equip({waist="Eschan Stone"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            --elseif spell.target.distance < (8 + spell.target.model_size) then
                --equip({waist="Eschan Stone"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
            if state.QDMode.value == 'Enhance' then
                equip(sets.midcast.CorsairShot.Enhance)
            elseif state.QDMode.value == 'TH' then
                equip(sets.midcast.CorsairShot)
                equip(sets.TreasureHunter)
            elseif state.QDMode.value == 'STP' then
                equip(sets.midcast.CorsairShot.STP)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        --check_weaponset()
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end

    --check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    --update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if spell.skill == 'Marksmanship' then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    else
        if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'

    local e_msg = state.Mainqd.current
    if state.UseAltqd.value == true then
        e_msg = e_msg .. '/'..state.Altqd.current
    end

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
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end

    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
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

function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

    if rollinfo then
        add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
            ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
            '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
            ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
            '  ' ..rollsize)
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
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
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

--function check_weaponset()
 --  if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
 --       equip(sets[state.WeaponSet.current].Acc)
 --   else
 --       equip(sets[state.WeaponSet.current])
 --   end
 --   if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
 --        equip(sets.DefaultShield)
 --    end
 --end

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
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
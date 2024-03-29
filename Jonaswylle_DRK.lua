include('organizer-lib')
-- include('Include/AugmentedGear.lua') -- my personal augs file, remove

--[[
Things I need to add/ could use help adding are....

1.) line ~1280 : how to get holy waters to equip rings
2.) Add a rule that when doomed - will auto matically use holy waters w/ rings
3.) a Toggle to lock weapon/sub for when I was to use sword/shield/gax manuallly for armor break etc
4.) rule that when arcane circle is up, locks founder's body for tp and ws gear w/ added stp for difference
5.) a check to make sure sams roll is lucky or not, so only use .STP sets when lucky rolls and not-unlucky
6.) figure out weapon customized PDT sets, hybrid works currently, PDT does not and idk why.
7.) when using a ws, will let me know self sc options through chat

]]--


function get_sets()

	lockstyleset=1
	set_lockstyle()
	
	send_command('bind ^f10 gs c C7')--pdt
	send_command('bind ^f2 gs c C15')
	send_command('bind f11 gs c C15')--mdt
	send_command('bind ^f3 gs c C16')
	send_command('bind f10 gs c C16')--Hybrid
	--send_command('bind ^f10 gs c C9')--ATT	
	--send_command('bind !f9 gs c C2')--Weapon
	send_command('bind !f1 gs c C2')--zerk/etc buffs
	send_command('bind !f2 gs c C1')
	
	send_command('bind f12 gs c C5')--f12 gear
	send_command('bind f9 gs c C1')--Acc level
	send_command('bind ^f9 gs c C3') -- Att level
	--send_command('bind !f3 gs c C4')--twilight
	send_command('bind ^f12 gs c IdleMode')--Idle sets
	
	
-- 3 Levels Of Accuracy Sets For TP/WS/Hybrid/Stun. First Set Is LowACC. 
--Add More ACC Sets If Needed Then Create Your New ACC Below. 
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC"}
	AttIndex = 1
	AttArray = {"NoPDL", "PDL"}
	MaccIndex = 1
	MaccArray = {"Potency","Resist","Duration"} 
--Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
	WeaponIndex = 1
	WeaponArray = {"Caladbolg"} --"Liberator"
	IdleIndex = 1
	IdleArray = {"Movement","Regen","Refresh","Regain"} -- Default Idle Set Is Movement --
	DarkSealIndex = 0 --Index for Dark Seal headpiece Potency(0) vs Duration(1)
	--add_to_chat(158,'DarkSeal Potency: [On]')
	Armor = 'None'
	Twilight = 'None'
	Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
	target_distance = 5 -- Set Default Distance Here --
	select_default_macro_book() -- Change Default Macro Book At The End --

	Ankou={}
	Ankou.WSDSTR=	{ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	Ankou.DA= 		{ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Ankou.WSDVIT=	{ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Ankou.ACC= 		{ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Ankou.FC=		{ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
    Ankou.STP=      { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	Ankou.INTDA=	{ name="Ankou's Mantle", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10',}}
	Ankou.MEVA= 	{ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	
	sets.Idle = {			
		ammo="Staunch tathlum +1",
		head="Valorous mask",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's cuisses",
		feet="Sakpata's Leggings",
		neck="Rep. Plat. Medal",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring",
		back=Ankou.DA
	}

		-- Regen Set --
	--sets.Idle.Regen = set_combine(sets.Idle,{ring2="Chirich Ring"})
	--sets.Idle.Regen.Liberator = set_combine(sets.Idle.Regen,{main="Liberator"})
	--sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen,{main="Ragnarok"})
	--sets.Idle.Regen.Caladbolg = set_combine(sets.Idle.Regen,{main="Caladbolg"})
	--sets.Idle.Regen.Apocalypse = set_combine(sets.Idle.Regen,{main="Apocalypse"})
	--sets.Idle.Regen.Anguta = set_combine(sets.Idle.Regen,{main="Anguta"})

		-- Movement Sets --
	sets.Idle.Movement = set_combine(sets.Idle,{})
	--sets.Idle.Movement.Liberator = set_combine(sets.Idle.Movement,{main="Liberator"})
	--sets.Idle.Movement.Ragnarok = set_combine(sets.Idle.Movement,{main="Ragnarok"})
	--sets.Idle.Movement.Caladbolg = set_combine(sets.Idle.Movement,{main="Caladbolg"})
	--sets.Idle.Movement.Apocalypse = set_combine(sets.Idle.Movement,{main="Apocalypse"})
	--sets.Idle.Movement.Anguta = set_combine(sets.Idle.Movement,{main="Anguta"})

		-- Refresh Sets --
	--sets.Idle.Refresh = set_combine(sets.Idle,{neck="Vim Torque +1",body="Lugra Cloak +1"})
	--sets.Idle.Refresh.Liberator = set_combine(sets.Idle.Refresh,{main="Liberator"})
	--sets.Idle.Refresh.Ragnarok = set_combine(sets.Idle.Refresh,{main="Ragnarok"})
	--sets.Idle.Refresh.Caladbolg = set_combine(sets.Idle.Refresh,{main="Caladbolg"})
	--sets.Idle.Refresh.Apocalypse = set_combine(sets.Idle.Refresh,{main="Apocalypse"})
	--sets.Idle.Refresh.Anguta = set_combine(sets.Idle.Refresh,{main="Anguta"})

		-- Regain Sets --
	--sets.Idle.Regain = set_combine(sets.Idle)
	--sets.Idle.Regain.Liberator = set_combine(sets.Idle.Regain,{main="Liberator"})
	--sets.Idle.Regain.Ragnarok = set_combine(sets.Idle.Regain,{main="Ragnarok"})
	--sets.Idle.Regain.Caladbolg = set_combine(sets.Idle.Regain,{main="Caladbolg"})
	--sets.Idle.Regain.Apocalypse = set_combine(sets.Idle.Regain,{main="Apocalypse"})
	--sets.Idle.Regain.Anguta = set_combine(sets.Idle.Regain,{main="Anguta"})

	sets.Twilight = set_combine(sets.Idle.Regen,{head="Twilight Helm",body="Twilight Mail"})

	-- JA Sets --
	sets.JA = {}
	sets.JA['Diabolic Eye'] = {hands="Fallen's finger gauntlets +1"}
	sets.JA['Arcane Circle'] = {feet="Ignominy Sollerets +3"}
	sets.JA['Nether Void'] = {legs="Bale Flanchard +2"}
	sets.JA['Souleater'] = {head="Ignominy Burgonet +2"}
	sets.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +2"}
	sets.JA['Last Resort'] = {back="Ankou's Mantle",feet="Fallen's Sollerets"}
	sets.JA['Dark Seal'] = {head="Fallen's Burgeonet +1"}
	sets.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}

	sets.Precast = {}
	-- Fastcast Set --
	sets.Precast.FastCast = {
		ammo="Sapience Orb",
		head="Sakpata's Helm",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
		feet="Carmine greaves +1",
		neck="Voltsurge Torque",
		waist="Tempus Fugit",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
	}
	

	-- Precast Dark Magic --
	sets.Precast['Dark Magic'] = set_combine(sets.Precast.FastCast,{})

	-- Midcast Base Set --
	sets.Midcast = {}
	
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})

	-- Dark Magic Set --
	sets.Midcast['Dark Magic'] = {
		ammo="Staunch tathlum +1",
		head="Ig. Burgeonet +2",
		body="Carmine scale mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
		feet="Ratri Sollerets",
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}
	
	-- Absorb Set --
    sets.Midcast.Absorb = {
		ammo="Hydrocera",
		head="Ig. Burgeonet +2",
		body="Carmine scale mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs="Ig. Flanchard +3",
		feet="Ratri Sollerets",
		neck="Baetyl pendant",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Kishar Ring",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}
	
	sets.Midcast.Absorb.Resist = set_combine(sets.Midcast.Absorb,{
		head="Carmine Mask +1", 
		hands="Leyline Gloves",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		waist="Eschan Stone", 
		feet="Ignominy Sollerets +3",
		back=Ankou.FC
	})
	
	sets.Midcast.Absorb.Duration = set_combine(sets.Midcast.Absorb,{hands="Onyx Gadlings", legs="Black Cuisses"})
			
	-- Absorb-TP Set --
    sets.Midcast['Absorb-TP'] = set_combine(sets.Midcast.Absorb,{hands="Heathen's Gauntlets +1"})

	-- Stun Sets --
	sets.Midcast.Stun = set_combine(sets.Midcast['Dark Magic'],{
		head="Carmine Mask +1",
		hands="Leyline Gloves",
		left_ring="Fallen finger gauntlets +3",
		waist="Eschan Stone",
		legs="Eschite cuisses",
		feet="Ignominy Sollerets +3",
		back=Ankou.FC
	})
	
	sets.Midcast.Stun.Resist = set_combine(sets.Midcast.Stun,{})
	sets.Midcast.Stun.Duration = set_combine(sets.Midcast.Stun,{left_ring="Stikini Ring",feet="Ratri Sollerets",})

	-- Endark Set --
	sets.Midcast['Endark II'] = {
		ammo="Staunch tathlum +1",
		head="Ig. Burgeonet +2",
		body="Nyame mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
		feet="Ratri Sollerets",
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}
		
		-- Enfeebling Magic Set --
	sets.Midcast['Enfeebling Magic'] = {
		ammo="Hydrocera",
		head="Ig. Burgeonet +2",
		body="Nyame mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs="Ig. Flanchard +3",
		feet="Ratri Sollerets",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Metamorph ring +1",
		right_ring="Kishar Ring",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}

	-- Elemental Magic Set --
	sets.Midcast['Elemental Magic'] = {
		ammo="Hydrocera",
		head="Ig. Burgeonet +2",
		body="Nyame mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs="Ig. Flanchard +3",
		feet="Ratri Sollerets",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Metamorph ring +1",
		right_ring="Kishar Ring",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}

	-- Dread Spikes Set --
	sets.Midcast['Dread Spikes'] = {
		ammo="Staunch tathlum +1",
		head="Hjarrandi helm",
		body="Heathen's cuirass +3",
		hands="Sakpata's gauntlets",
		legs="Sakpata's cuisses",
		feet="Ratri sollerets",
		neck="Unmoving collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Tuisto Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Moonlight Ring",
		back="Moonbeam Cape",
	}
		
	sets.Midcast.Drain = {
		ammo="Hydrocera",
		head="Pixie hairpin +1",
		body="Nyame mail",
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs="Ig. Flanchard +3",
		feet="Ratri Sollerets",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back={ name="Niht Mantle", augments={'Attack+13','Dark magic skill +8','"Drain" and "Aspir" potency +12',}}
	}

	sets.Midcast.Aspir = set_combine(sets.Midcast.Drain, {})
	
	sets.MAXDrain = {main="Misanthropy",}
	
		-- TP Base Set --
	sets.TP = {
		ammo="Coiste bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Ganesha's Mala",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Hetairoi Ring",
		back=Ankou.DA
	}

	-- sets.TP = {
	    -- ammo="Coiste bodhar",
		-- head="Sakpata's helm",
		-- body="Sakpata's Plate",
		-- hands="Sakpata's gauntlets",
		-- legs="Sakpata's cuisses",
		-- feet="Sakpata's leggings",
		-- neck="Abyssal bead necklace +2",
		-- waist="Sailfi belt +1",
		-- left_ear="Schere Earring",
		-- right_ear="Telos Earring",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Chirich Ring +1",
		-- back=Ankou.DA,
	-- }



-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- CALADBOLG SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	-- Caladbolg(AM Down) TP Sets --
	sets.TP.Caladbolg = {
		ammo="Coiste bodhar",
		head="Flam. Zucchetto +2",
		body="Valorous mail",
		hands="Sakpata's Gauntlets",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Ganesha's Mala",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Hetairoi Ring",
		back=Ankou.DA
	}
	
	-- sets.TP.Caladbolg = {
	    -- ammo="Coiste bodhar",
		-- head="Sakpata's helm",
		-- body="Sakpata's Plate",
		-- hands="Sakpata's gauntlets",
		-- legs="Sakpata's cuisses",
		-- feet="Sakpata's leggings",
		-- neck="Abyssal bead necklace +2",
		-- waist="Sailfi belt +1",
		-- left_ear="Schere Earring",
		-- right_ear="Telos Earring",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Chirich Ring +1",
		-- back=Ankou.DA,
	-- }


	sets.TP.Caladbolg.MidACC = set_combine(sets.TP.Caladbolg,{

	}) 
		
	sets.TP.Caladbolg.HighACC = set_combine(sets.TP.Caladbolg.MidACC,{
	
	})
		
	-- Caladbolg(AM Down: High Haste) TP Sets --
	sets.TP.Caladbolg.HighHaste = set_combine(sets.TP.Caladbolg,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.MidACC,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.HighACC,{ammo="Seething Bomblet",waist="Kentarch Belt +1",})

	-- Caladbolg(AM Down: SAM Roll) TP Sets --
	sets.TP.Caladbolg.STP = set_combine(sets.TP.Caladbolg,{left_ear="Cessance earring",})
	sets.TP.Caladbolg.MidACC.STP = set_combine(sets.TP.Caladbolg.MidACC,{})
	sets.TP.Caladbolg.HighACC.STP = set_combine(sets.TP.Caladbolg.HighACC,{
	
	})

	-- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.HighHaste.STP = set_combine(sets.TP.Caladbolg.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{waist="Windbuffet Belt +1",})
	
	-- Caladbolg(AM Up) TP Sets --
	sets.TP.Caladbolg.AM = set_combine(sets.TP.Caladbolg,{
		ammo="Coiste bodhar",
		head="Flam. Zucchetto +2",
		body="Valorous mail",
		hands="Sakpata's Gauntlets",
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Ganesha's Mala",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Hetairoi Ring",
		back=Ankou.DA
	})
	
	-- sets.TP.Caladbolg.AM = {
	    -- ammo="Coiste bodhar",
		-- head="Sakpata's helm",
		-- body="Sakpata's Plate",
		-- hands="Sakpata's gauntlets",
		-- legs="Sakpata's cuisses",
		-- feet="Sakpata's leggings",
		-- neck="Abyssal bead necklace +2",
		-- waist="Sailfi belt +1",
		-- left_ear="Schere Earring",
		-- right_ear="Telos Earring",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Chirich Ring +1",
		-- back=Ankou.DA,
	-- }


	sets.TP.Caladbolg.MidACC.AM = set_combine(sets.TP.Caladbolg.AM,{

		left_ear="Cessance earring",
		left_ring="Chirich Ring +1",
	}) 
		
	sets.TP.Caladbolg.HighACC.AM = set_combine(sets.TP.Caladbolg.MidACC.AM,{
		neck="Lissome Necklace",
		left_ring="Regal Ring",
	})

	-- Caladbolg(AM Up: High Haste) TP Sets --
	sets.TP.Caladbolg.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM.MidACC,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.HighACC.AM,{ammo="Seething Bomblet",waist="Kentarch Belt +1",})

	-- Caladbolg(AM Up: SAM Roll) TP Sets --
	sets.TP.Caladbolg.AM.STP = set_combine(sets.TP.Caladbolg.STP,{left_ear="Cessance earring",})
	sets.TP.Caladbolg.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.MidACC.AM,{})
	sets.TP.Caladbolg.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.HighACC.AM,{
		ammo="Seething Bomblet",
		neck="Lissome Necklace",
		ear1="Mache Earring +1",
		feet="Flamma Gambieras +1"
	})

	-- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighHaste.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{waist="Windbuffet Belt +1",})
	
	
	-- Caladbolg /SAM TP Sets -------------------------------------------------------------------

	-- Caladbolg(AM Down) TP Sets --  /SAM
	--[ACC: 1150 STP: 61]--
	sets.TP.Caladbolg.SAM = set_combine(sets.TP.Caladbolg,{
	
	}) 
		
	--[ACC: 1184 STP: 63]--	
	sets.TP.Caladbolg.SAM.MidACC = set_combine(sets.TP.Caladbolg.SAM,{
	
	}) 
		
	--[ACC: 1264 STP: 27]--		
	sets.TP.Caladbolg.SAM.HighACC = set_combine(sets.TP.Caladbolg.SAM.MidACC,{
	
	})

	-- Caladbolg(AM Down: High Haste) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.HighHaste = set_combine(sets.TP.Caladbolg.SAM,{})
	sets.TP.Caladbolg.SAM.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC,{})
	sets.TP.Caladbolg.SAM.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighACC,{})
	
	-- Caladbolg(AM Down: SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.STP = set_combine(sets.TP.Caladbolg.SAM,{})
	sets.TP.Caladbolg.SAM.MidACC.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC,{})
	sets.TP.Caladbolg.SAM.HighACC.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC,{
		ammo="Seething Bomblet",
		neck="Lissome Necklace",
		ear1="Mache Earring",
		feet="Flamma Gambieras +2"
	})

	-- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Caladbolg.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.STP,{waist="Windbuffet Belt +1",})
	
	-- Caladbolg(AM Up) TP Sets -- /SAM
	--[ACC: 1150 STP: 61]--
	sets.TP.Caladbolg.SAM.AM = set_combine(sets.TP.Caladbolg.AM,{
	
	})
		
	--[ACC: 1184 STP: 63]--		
	sets.TP.Caladbolg.SAM.MidACC.AM = set_combine(sets.TP.Caladbolg.SAM.AM,{
	
	}) 
	
	--[ACC: 1264 STP: 27]--		
	sets.TP.Caladbolg.SAM.HighACC.AM = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{
	
	})
	
	-- Caladbolg(AM Up: High Haste) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.AM,{})
	sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{})
	sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighACC.AM,{})

	-- Caladbolg(AM Up: SAM Roll) TP Sets -- /SAM
	sets.TP.Caladbolg.SAM.AM.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{})
	sets.TP.Caladbolg.SAM.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{})
	sets.TP.Caladbolg.SAM.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.AM,{})

	-- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
	sets.TP.Caladbolg.SAM.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighHaste.STP,{})
	sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.STP,{})
	sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.STP,{})

-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------- ANGUTA SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------		

	-- Anguta TP Sets --
	sets.TP.Anguta = {main="Anguta",}
	sets.TP.Anguta.MidACC = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.HighACC = set_combine(sets.TP.Anguta.MidACC,{})

	-- Anguta(High Haste) TP Sets --
	sets.TP.Anguta.HighHaste = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.MidACC.HighHaste = set_combine(sets.TP.Anguta.MidACC,{})
	sets.TP.Anguta.HighACC.HighHaste = set_combine(sets.TP.Anguta.HighACC,{})

	-- Anguta(SAM Roll) TP Sets --
	sets.TP.Anguta.STP = set_combine(sets.TP.Anguta,{})
	sets.TP.Anguta.MidACC.STP = set_combine(sets.TP.Anguta.MidACC,{})
	sets.TP.Anguta.HighACC.STP = set_combine(sets.TP.Anguta.HighACC,{})

	-- Anguta(High Haste + SAM Roll) TP Sets --
	sets.TP.Anguta.HighHaste.STP = set_combine(sets.TP.Anguta.STP,{})
	sets.TP.Anguta.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.MidACC.STP,{})
	sets.TP.Anguta.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.HighACC.STP,{})

	----------------- /sam sets -----------------------------
	
	-- Anguta /SAM TP Sets --
	sets.TP.Anguta.SAM = {
	
	}
	
	sets.TP.Anguta.SAM.MidACC = set_combine(sets.TP.Anguta.SAM,{
	
	})
	sets.TP.Anguta.SAM.HighACC = set_combine(sets.TP.Anguta.SAM.MidACC,{
		
	})

	-- Anguta(High Haste) /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste = set_combine(sets.TP.Anguta.SAM,{})
	sets.TP.Anguta.SAM.MidACC.HighHaste = set_combine(sets.TP.Anguta.SAM.MidACC,{})
	sets.TP.Anguta.SAM.HighACC.HighHaste = set_combine(sets.TP.Anguta.SAM.HighACC,{})

	-- Anguta(SAM Roll) /SAM TP Sets --
	sets.TP.Anguta.SAM.STP = set_combine(sets.TP.Anguta.SAM,{
	
	})
	sets.TP.Anguta.SAM.MidACC.STP = set_combine(sets.TP.Anguta.SAM.MidACC,{
	})
	
	sets.TP.Anguta.SAM.HighACC.STP = set_combine(sets.TP.Anguta.SAM.HighACC,{
	
	})

	-- Anguta(High Haste + SAM Roll) /SAM TP Sets --
	sets.TP.Anguta.SAM.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.STP,{waist="Windbuffet Belt +1",})
	sets.TP.Anguta.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.MidACC.STP,{})
	sets.TP.Anguta.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.HighACC.STP,{})
	
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

	-- PDT/MDT Sets --
	sets.PDT = {
	    ammo="Coiste bodhar",
		head="Sakpata's helm",
		body="Sakpata's Plate",
		hands="Sakpata's gauntlets",
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings",
		neck="Abyssal bead necklace +2",
		waist="Sailfi belt +1",
		left_ear="Schere Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back=Ankou.DA,
	}
	
	-- sets.PDT = {
	    -- ammo="Coiste bodhar",
		-- head="Sakpata's helm",
		-- body="Sakpata's Plate",
		-- hands="Sakpata's gauntlets",
		-- legs="Sakpata's cuisses",
		-- feet="Sakpata's leggings",
		-- neck="Unmoving collar +1",
		-- waist="Plat. Mog. Belt",
		-- left_ear="Odnowa Earring +1",
		-- right_ear="Tuisto Earring",
		-- left_ring="Moonlight Ring",
		-- right_ring="Gelatinous Ring +1",
		-- back="Moonbeam cape",
	-- }
		
		
	sets.MDT = set_combine(sets.PDT,{right_ring="Shadow Ring",})
							
	sets.Scarlet = set_combine(sets.PDT,{})

	-- Hybrid Set --
	sets.TP.Hybrid = {
		ammo="Coiste Bodhar",
		head="Hjarrandi helm",
		body="Sakpata's breastplate",
		hands="Sakpata's Gauntlets",
		legs="Ignominy flanchard +3",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight ring",
		back=Ankou.DA,
	}
	
	-- sets.TP.Hybrid = {
		-- ammo="Coiste Bodhar",
		-- head="Hjarrandi helm",
		-- body="Dagon breastplate",
		-- hands="Sakpata's Gauntlets",
		-- legs="Sakpata's cuisses",
		-- feet="Sakpata's Leggings",
		-- neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		-- waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		-- left_ear="Telos Earring",
		-- right_ear="Odnowa earring +1",
		-- left_ring="Niqmaddu Ring",
		-- right_ring="Moonlight ring",
		-- back=Ankou.DA,
	-- }
	
		
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{
		ammo="Seeth. Bomblet +1",
		head="Sakpata's helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos earring",
		right_ear="Mache earring +1",
		left_ring="Chirich ring +1",
		right_ring="Chirich Ring +1",
		back=Ankou.Acc,
	})
		
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{
		
		})

--[[ Scythe Light:
    Insurgency > Vorpal Scythe > Entropy > Guillotine > Entropy > Insurgency
    Vorpal Scythe > Entropy > Guillotine > Entropy > Insurgency
    Entropy > Guillotine > Entropy > Insurgency
    Guillotine > Entropy > Insurgency
   
-- Scythe Darkness:
    Insurgency (M) > Vorpal Scythe > Vorpal Scythe > Insurgency (M) > Entropy (MM) > Cross Reaper
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM)
    Cross Reaper > Insurgency (M) > Entropy (MM) > Cross Reaper
    Insurgency (M) > Entropy (MM) > Cross Reaper
    Cross Reaper > Entropy (MM)
    Entropy (MM) > Cross Reaper
 
-- Apoc Darkness
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM) > Catastrophe (R)
    Entropy (MM) > Guillotine > Entropy (MM) > Cross Reaper > Entropy (MM)
    Insurgency (M) > Entropy (MM) > Cross Reaper > Catastrophe (R)
    Insurgency (M) > Catastrophe (R) > Cross Reaper > Catastrophe (R)
    Cross Reaper > Insurgency (M) > Catastrophe (R) > Cross Reaper
    Catastrophe (R) > Cross Reaper > Catastrophe (R)
    Insurgency (M) > Catastrophe (R) > Cross Reaper
    Cross Reaper > Catastrophe (R) > Catastrophe (R)
    Cross Reaper > Entropy (MM) > Catastrophe (R)
    Entropy (MM) > Cross Reaper > Catastrophe (R)
    Catastrophe (R) > Catastrophe (R)
    Catastrophe (R) > Cross Reaper
    Cross Reaper > Catastrophe (R)
 
-- Other Light
    Catastrophe (R) > Savage Blade (Q) > Insurgency (M)
    Entropy (MM) > Savage Blade (Q) > Insurgency (M)
    Savage Blade (Q) > Insurgency (M)
    Chant du Cygne (E) > Torcleaver (E)
 
-- Other Dark
    Atonement (M) > Entropy (MM) > Cross Reaper
    Savage Blade (Q) > Cross Reaper > Entropy (MM)
    Chant du Cygne (E) > Catastrophe (R)
    Chant du Cygne (E) > Entropy (MM)
    Requiescat (MM) > Cross Reaper
    Requiescat (MM) > Torcleaver (E)
 
-- GreatSword
    Resolution (MM) > Torcleaver (E) > Scourge (R) > Resolution (MM) > Torcleaver (E)
    Resolution (MM) > Torcleaver (E) > Scourge (R) > Resolution (MM)
    Resolution (MM) > Scourge (R) > Torcleaver (E)
    Scourge (R) > Resolution (MM) > Torcleaver (E)
    Torcleaver (E) > Torcleaver (E)
    Scourge (R) > Resolution (MM)
--]]

	-- WS Base Set --
	sets.WS = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back=Ankou.WSDSTR 
	}

	-- Resolution Sets --
	--Description:	Delivers a fivefold attack. Damage varies with TP.
	--Stat Modifier:	73~85% STR fTP:	0.71875	1.5	2.25
	sets.WS.Resolution = {		
		ammo="Seeth. Bomblet +1",
		head="Heathen's burgeonet +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings",
		neck="Fotia Gorget",
		waist="Fotia belt",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.DA
	}
	
	sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution,{
		hands="Ignominy Gauntlets +3",
		back=Ankou.DA})
		
	sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC,{})
	
	-- Torcleaver Sets --
	-- Description:	Deals triple damage. Damage varies with TP.
	-- Stat Modifier:	80% VIT fTP:	4.75	7.5	10
    sets.WS.Torcleaver = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ear="Thrud earring",
		--left_ear="Schere earring",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Ephramad's Ring",
		right_ring="Epaminondas's Ring",
		back=Ankou.WSDVIT
	}
		
    sets.WS.Torcleaver.MidACC = set_combine(sets.WS.Torcleaver,{})
		
    sets.WS.Torcleaver.HighACC = set_combine(sets.WS.Torcleaver.MidACC,{})
	
	sets.WS.Torcleaver.PDL = set_combine(sets.WS.Torcleaver,{
		head="Heathen's burgeonet +3",
		hands="Sakpata's gauntlets",
		body="Sakpata's breastplate",
		legs="Sakpata's cuisses",
		ammo="Crepuscular pebble",
		right_ear="Heathen's Earring +1",
	})

	-- Scourge Sets --
	--Relic Aftermath: +5% Critical Hit Rate 15 acc
	--Stat Modifier:	40% STR / 40% VIT	fTP:	3.0
    sets.WS.Scourge = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.WSDVIT}
		
    sets.WS.Scourge.MidACC = set_combine(sets.WS.Scourge,{
		left_ear="Cessance earring",
		right_ear="Telos Earring",})
		
	sets.WS.Scourge.HighACC = set_combine(sets.WS.Scourge.MidACC,{})	

    sets.WS.Shockwave = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame mail",
		hands="Nyame Gauntlets",
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Malignance Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Regal Ring",
		right_ring="Metamorph ring +1",
		back=Ankou.WSDSTR,
	}	

	-- Catastrophe Sets --
	--Stat Modifier:	40% STR / 40% INT	fTP:	2.75
	--Relic Aftermath: 10% Equipment Haste (+102/1024) AG 10% Ability
	sets.WS.Catastrophe = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Ankou.WSDSTR}
		
	sets.WS.Catastrophe.MidACC = set_combine(sets.WS.Catastrophe,{
		right_ear="Telos Earring",})
		
	sets.WS.Catastrophe.HighACC = set_combine(sets.WS.Catastrophe.MidACC,{})

	-- Entropy Sets --
	--Delivers a fourfold attack. Converts some of the damage into MP. Damage varies with TP.
	--Stat Modifier:	73~85% INT fTP:	0.75	1.25	2.0
	sets.WS.Entropy = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.WSDSTR 
	}
		
	sets.WS.Entropy.MidACC = set_combine(sets.WS.Entropy,{
		right_ear="Telos earring",})
		
	sets.WS.Entropy.HighACC = set_combine(sets.WS.Entropy.MidACC,{
		ammo="Seething Bomblet",
		body="Nyame mail",})
							
	-- CrossReaper Sets --
	--Delivers a two-hit attack. Damage varies with TP.
	--Stat Modifier:	60% STR / 60% MND fTP:	2.0	4.0	7.0
	sets.WS['Cross Reaper'] = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.WSDSTR 
	}
		
	sets.WS['Cross Reaper'].MidACC = set_combine(sets.WS['Cross Reaper'],{
		legs="Ignominy Flanchard +3",
		hands="Ignominy Gauntlets +3",})
		
	sets.WS['Cross Reaper'].HighACC = set_combine(sets.WS['Cross Reaper'].MidACC,{
		head="Ignominy Burgonet +3",
		right_ear="Telos earring",})							

	-- Insurgency Sets --
	--Delivers a fourfold attack. Damage varies with TP.
	--Stat Modifier:	20% STR / 20% INT fTP:	0.5	3.25	6.0
	sets.WS.Insurgency = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.WSDSTR 
	}
		
	sets.WS.Insurgency.MidACC = set_combine(sets.WS.Insurgency,{
		hands="Ignominy Gauntlets +3",
		feet="Ratri Sollerets",})
		
	sets.WS.Insurgency.HighACC = set_combine(sets.WS.Insurgency.MidACC,{
		head="Ignominy Burgonet +3",
		right_ear="Telos earring",})
	
	-- Quietus Sets --
	--Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP.
	--Stat Modifier:	60% STR / 60% MND Defense ignored:	10%	30%	50% fTP:	3.0
	sets.WS.Quietus = {
		ammo="Knobkierrie",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Heathen's sollerets +3",
		neck={ name="Abyssal bead necklace +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=Ankou.WSDSTR 
	}
	
	sets.WS['Armor Break'] = {
		ammo="Seething bomblet +1",
		head="Nyame helm",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Dignitary's Earring",
		right_ear="Enchanter's earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Metamorph ring +1",
		back=Ankou.WSDSTR 
	}

	sets.WS.Quietus.MidACC = set_combine(sets.WS.Quietus, {
		right_ear="Telos Earring",})
		
	sets.WS.Quietus.HighACC = set_combine(sets.WS.Quietus.MidACC, {})

	-----------------------------------------------------------------------------------------------------------------
	-- works in motes based, not sure how to get it to work here
	sets.Item = {HolyWater}
	sets.Item['Holy Water'] = {ring1="Blenmot's Ring", ring2="Blenmot's Ring"}
	
	sets.doom = {
        neck="Nicander's Necklace",
        ring1="Blenmot's ring +1",
        ring2="Blenmot's ring +1",
        waist="Gishdubar Sash", 
	}
	
	--react sets
	sets.Meva = {
		ammo="Staunch tathlum +1",
		head="Ratri Sallet",
		neck="Warder's Charm +1",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		legs="Ratri Cuisses",
		feet="Ratri Sollerets",
		hands="Ratri Gadlings",
		waist="Asklepian Belt",
		back=Ankou.MEVA,
	}
	
	sets.CurePotencyRecieved = {waist="Gishdubar sash", neck="Phalaina Locket", ring1="Kunaji Ring", hands="Buremte Gloves",}
	sets.PhalanxRecieved = {}
	sets.RefreshRecieved = {waist="Gishdubar sash",} --feet="Inspirited boots"
	sets.CursnaRecieved = {waist="Gishdubar sash", legs="Shabti Cuisses +1", ring1="Eshmun's Ring", ring2="Eshmun's Ring"}
	sets.ResistStun = set_combine(sets.Meva, {right_ear="Arete del Luna", left_ear="Hearty Earring", body="Onca Suit", })
	sets.ProShellRecieved = {ring1="Sheltered Ring",}
	sets.ResistTerror = set_combine(sets.Meva,{feet="Founder's Greaves",})
	
	-- sets.wakesleep = {
		-- neck="Vim Torque +1",
	-- }  
	
end

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
	elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		return
	end
end

function precast(spell,action)
	if spell.type == "WeaponSkill" then
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if equipSet[AttArray[AttIndex]] then
				equipSet = equipSet[AttArray[AttIndex]]
			end
			if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
				equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
			end
			if (spell.english == "Entropy" or spell.english == "Resolution" or spell.english == "Insurgency") and (player.tp > 2990 or buffactive.Sekkanoki) then
				if world.time <= (7*60) or world.time >= (17*60) then 
					equipSet = set_combine(equipSet,{ear1="Lugra Earring +1"})
				else
					equipSet = set_combine(equipSet,{ear1="Ishvara Earring"})
				end
			end
			equip(equipSet)
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.action_type == 'Magic' then
		if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
			return
		else
			if spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.FastCast)
				end
			elseif sets.Precast[spell.skill] then
				equip(sets.Precast[spell.skill])
			else
				equip(sets.Precast.FastCast)
			end
		end
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
end

function midcast(spell,action)
	equipSet = {}
	if spell.action_type == 'Magic' then
		equipSet = sets.Midcast
		if spell.english:startswith('Absorb') and spell.english ~= "Absorb-TP" then
			equipSet = sets.Midcast.Absorb
			if equipSet[MaccArray[MaccIndex]] then
				equipSet = equipSet[MaccArray[MaccIndex]]
			end
		elseif spell.english:startswith('Drain') or spell.english:startswith('Aspir') or spell.english:startswith('Bio') then
			if world.day == "Darksday" or world.weather_element == "Dark" then -- Equip Hachirin-no-Obi On Darksday or Dark Weather --
				equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
			end
			equipSet = 	sets.Midcast.Drain
		elseif spell.english == "Stoneskin" then
			if buffactive.Stoneskin then
				send_command('@wait 1.7;cancel stoneskin')
			end
			equipSet = equipSet.Stoneskin
		elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
				send_command('cancel sneak')
			end
			equipSet = equipSet.Haste
		elseif spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equipSet = equipSet.Haste
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equipSet = equipSet.Haste
		else
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if equipSet[MaccArray[MaccIndex]] then
				equipSet = equipSet[MaccArray[MaccIndex]]
			end
			if equipSet[spell.skill] then
				equipSet = equipSet[spell.skill]
			end
			if equipSet[spell.type] then
				equipSet = equipSet[spell.type]
			end
		end
	elseif equipSet[spell.english] then
		equipSet = equipSet[spell.english]
	end
	if buffactive["Dark Seal"] and DarkSealIndex==0 then -- Equip Aug'd Fall. Burgeonet +1 When You Have Dark Seal Up --
        equipSet = set_combine(equipSet,{head="Fall. Burgeonet +1",})
    end
	if buffactive['Dark Seal'] and buffactive['Nether Void'] and S{"Drain II","Drain III"}:contains(spell.english) and player.tp<600 then
		equipSet = set_combine(equipSet,(sets.MAXDrain))
		add_to_chat(100,'WARNING: Misanthropy is on now *****')
	end
	equip(equipSet)
end

function aftercast(spell,action)

		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		elseif spell.english == "Arcane Circle" then -- Arcane Circle Countdown --
			send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
		elseif spell.english == "Sleep II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" then -- Sleep Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		end
		status_change(player.status)
	end
	

function status_change(new,old)
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif Armor == 'Scarlet' then
		equip(sets.Scarlet)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' and equipSet["Hybrid"] then
			equipSet = equipSet["Hybrid"]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
	    if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
    			if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste) or (buffactive.March and buffactive['Mighty Guard']) or (buffactive['Mighty Guard'] and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava or buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
    				equipSet = equipSet["AM3_HighHaste"]
    			else 
    				equipSet = equipSet["AM3"]
    			end
    	end	
		if buffactive.Aftermath and equipSet["AM"] then
			equipSet = equipSet["AM"]
		end
		if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste) or (buffactive.March and buffactive['Mighty Guard']) or (buffactive['Mighty Guard'] and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava or buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
			equipSet = equipSet["HighHaste"]
		end
		if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
			equipSet = equipSet["STP"]
		end
		equip(equipSet)
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		if equipSet[WeaponArray[WeaponIndex]] then
			equipSet = equipSet[WeaponArray[WeaponIndex]]
		end
		if equipSet[player.sub_job] then
			equipSet = equipSet[player.sub_job]
		end
		if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
			equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
		end
		if world.area:endswith('Adoulin') then
			equipSet = set_combine(equipSet,{body="Councilor's Garb"})
		end
		equip(equipSet)
	end
	if Twilight == 'Twilight' then
		equip(sets.Twilight)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
	elseif buff == 'weakness' then -- Weakness Timer --
		if gain then
			send_command('timers create "Weakness" 300 up')
		else
			send_command('timers delete "Weakness"')
		end
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
		equip({neck="Vim Torque +1"})
	else
		if not midaction() then
			status_change(player.status)
		end
	end
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

-- function job_buff_change(status,gain_or_loss)
    -- if buffactive.sleep then
		-- equip(sets.wakesleep)
    -- end
    -- if playerStatus == 'Idle' then
        -- equip(sets.Idle)  
   -- end
-- end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Level Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		status_change(player.status)
		add_to_chat(158,'Accuracy Level: '..AccArray[AccIndex])
	elseif command == 'C3' then -- Attack Toggle --
		AttIndex = (AttIndex % #AttArray) + 1
		add_to_chat(158,'PDL Level: ' .. AttArray[AttIndex])
		status_change(player.status)
	elseif command == 'C17' then -- Main Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'C14' then -- Macc Toggle --
		MaccIndex = (MaccIndex % #MaccArray) + 1
		add_to_chat(158,'Macc Level: '..MaccArray[MaccIndex])
		status_change(player.status)
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C2' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
		elseif command == 'C10' then -- DarkSeal Toggle --
        if DarkSealIndex == 1 then
                        DarkSealIndex = 0
                        add_to_chat(158,'DarkSeal Duration: [On]')
        else
                        DarkSealIndex = 1
                        add_to_chat(158,'DarkSeal Potency: [On]')
        end
        status_change(player.status)
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C9' then -- Scarlet Toggle --
		if Armor == 'Scarlet' then
			Armor = 'None'
			add_to_chat(123,'Scarlet Set: [Unlocked]')
		else
			Armor = 'Scarlet'
			add_to_chat(158,'Scarlet Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C9' then -- Twilight Toggle --
		if Twilight == 'Twilight' then
			Twilight = 'None'
			add_to_chat(123,'Twilight Set: [Unlocked]')
		else
			Twilight = 'Twilight'
			add_to_chat(158,'Twilight Set: [locked]')
		end
		status_change(player.status)
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		status_change(player.status)
		add_to_chat(158,'Idle Set: '..IdleArray[IdleIndex])
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
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

function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end

function set_lockstyle()
    send_command('wait 5; input /lockstyleset ' .. lockstyleset)
end
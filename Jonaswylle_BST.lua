function get_sets()

	send_command('bind f9 gs c toggle TP set')
	send_command('bind !f9 gs c toggle Shoha set')
	send_command('bind ^f9 gs c toggle Fudo set')
	send_command('bind f10 gs c toggle DT set')
	send_command('bind f11 gs c toggle Attack set')
	send_command('bind ^f11 gs c toggle Ranged set')
	send_command('bind ^f10 gs c toggle Hybrid set')
	send_command('bind f12 gs c toggle Idle set')

	
	--mote_include_version = 2
	lockstyleset = 13
	set_lockstyle()
	select_default_macro_book()

    -- Load and initialize the include file.
    --include('Mote-Include.lua')
	
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
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
	end	
	
--DT Sets-- 

	sets.DT = {}
	sets.DT.index = {'FullDT'}
	DT_ind = 1
	
	sets.DT.FullDT = {
		ammo="Dire Broth",
		right_ear="Reraise Earring",
	}
		
--Hyrid Sets-- 

	sets.Hybrid = {}
	
	sets.Hybrid.index = {'Hybrid'}
	Hybrid_ind = 1
	
	sets.Hybrid.Hybrid = {
		ammo="Aurgelmir Orb",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Ninja Nodowa", augments={'Path: A',}},
		waist="Sarissapho. Belt",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Epona's Ring",
		right_ring="Warp Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
	
--Weapon Sets--

	sets.Attack = {}
	sets.Attack.index = {'Trial', 'Pet'}
	Attack_ind = 1
	
	sets.Attack.Trial = {
		main="Naegling",
		sub={ name="Fernagu", augments={'TP Bonus +1000',}},
	}
	
	sets.Attack.Pet = {
		main="Agwu's Axe",
		sub="Wyvern Targe",
	}
	
--Ranged Sets--

	sets.Ranged = {}
	
	sets.Ranged.index = {'Pull'}
	Ranged_ind = 1
	
	sets.Ranged.Pull = {
	    range="Kaja Bow",
		ammo="Stone Arrow",
	}
	
--Idle Sets--

	sets.Idle = {}
	
	sets.Idle.index = {'PetMacc', 'Warp'}
	Idle_ind = 1
	
	sets.Idle.Warp = {

	}

	sets.Idle.PetMAcc = {
		ammo="Voluspa Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Kyrene's Earring",
		right_ear="Enmerkar Earring",
		left_ring="Tali'ah Ring",
		right_ring="Moonlight Ring",
		back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Mag. Acc.+10',}},
	}

--TP Sets--

	sets.TP = {}
	
	sets.TP.index = {'FullDT'}
	TP_ind = 1	

	sets.TP.FullDT = {

	}
	
--Precast Sets--
	
	sets.precast = {}
	
	sets.precast.FC = {}
	
--Midcast Sets--
	
	sets.midcast = {}
	
--Job Abilities--

	sets.JA = {}
	
	sets.JA['Call Beast'] = {hands="Ankusa gloves"}

-- WeaponSkill Sets --

	sets.WS = {}
	
	sets.WS['Blade: Metsu'] = {

	}
	
	sets.WS['Savage Blade'] = {

	}
	
--Aftercast Sets--

	sets.aftercast = {}
	
end

function precast(spell)
	
	if sets.WS[spell.name] then
		equip(sets.WS[spell.name])
	end
end
	
function midcast(spell,act)
end 


function aftercast(spell)
	idle ()
end

function status_change(new,old)
	idle ()
end

function idle()
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'toggle Attack set' then
		Attack_ind = Attack_ind +1
		if Attack_ind > #sets.Attack.index then Attack_ind = 1 end
		send_command('@input /echo <----- Attack Set changed to '..sets.Attack.index[Attack_ind]..' ----->')
		equip(sets.Attack[sets.Attack.index[Attack_ind]])
	elseif command == 'toggle Hybrid set' then
		Hybrid_ind = Hybrid_ind +1
		if Hybrid_ind > #sets.Hybrid.index then Hybrid_ind = 1 end
		send_command('@input /echo <----- HybridSet changed to '..sets.Hybrid.index[Hybrid_ind]..' ----->') 
		equip(sets.Hybrid[sets.Hybrid.index[Hybrid_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle DT set' then
		DT_ind = DT_ind +1
		if DT_ind > #sets.DT.index then DT_ind = 1 end
		send_command('@input /echo <----- DT Set changed to '..sets.DT.index[DT_ind]..' ----->')
		equip(sets.DT[sets.DT.index[DT_ind]])
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 11)
    else
        set_macro_page(1, 11)
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

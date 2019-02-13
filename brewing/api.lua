local modpath, S = ...

brewing = {
	engine= {}, --it defined in engine.lua
	craftlist = {}, -- for potions
	entities = {
		lily = nil
	},
	settings = {
		ignitor = {["name"] = "brewing:magic_dust", ["image"] = "brewing_ignitor_dust_gray.png"},
		water_name = {"bucket:bucket_water", "bucket:bucket_river_water"},
		-- Amulets
		heart_amulet_hp_inc_by = 5,
		health_amulet_power_level = 15,
		health_amulet_heal_points = 3,
		-- Herbalism
		generate_cortinarius_violaceus = true,
		generate_fire_flower = true,
		generate_gerbera_daisy = true,
		generate_lucky_club  = true,
		generate_magic_rose = true,
		generate_orange_mycena  = true,
		generate_saffron_crocus = true,
		generate_yellow_bell = true,
		generate_sugarcane = true,
		generate_mandragora = true,
		generate_calla = true,
		generate_lavender = true,
		generate_creosote_bush = true,
		generate_gliophorus_viridis = true,
		generate_azalea = true,
		-- end herbalism
		-- Aquatic
		generate_pearl_oyster = true,
		--end aquatic
		freeze_time = 3.0,
		freeze_hit_points = 5,
		donut_eat_hp = 7,
		lily_hp = 30,
		flask_name = "vessels:glass_bottle",
		filled_flasks = 5,
		star_blue_amulet_speedup = 1.05,
		-- Mana
		-- Add
		mana_magic_donut = 20,
		mana_fay_cake = 30,
		mana_nymph_salad = 15,
		mana_siren_soup = 15,
		-- Subtract
		mana_magic_wand = 30,
		mana_magic_blue_tear_wand = 50,
		-- Mobs Damage
		bp_anemon_damage = 5,
		-- Weapons
		fury_sun_sword_wait_time = 7.0,
	},
	isvalidwater= function(water_name_to_check)
		local isvalid = false
		for water_name in brewing.arrayvalues(brewing.settings.water_name) do
			if  water_name == water_name_to_check then
				isvalid = true
				break
			end
		end
		return isvalid
	end,
	posfrontplayer = function(user)
		local d = user:get_look_dir()
		local pos = user:get_pos()
		local player_eye_pos = 1.5
		local posinfront ={
			x = pos.x + (d.x*2),
			y = pos.y + player_eye_pos+(d.y*2),
			z = pos.z + (d.z*2)
		}
		return posinfront
	end,
	pos_above = function(pos)
		local posabove = {x = pos.x, y = pos.y + 1, z = pos.z}	
		return posabove
	end,
	pos_below = function(pos)
		local posbelow = {x = pos.x, y = pos.y - 1, z = pos.z}	
		return posbelow
	end,			
	-- Function to register the potions
	register_potioncraft = function(potioncraft)
		brewing.craftlist[#brewing.craftlist+1] = {potioncraft.output	, potioncraft.recipe}
	end,
	--custom function to get only array values of tables, not keys
	arrayvalues = function(arr)
		local i = 0
		return function() i = i + 1; return arr[i] end
	end,
	set_filledflasks = function(num)
		brewing.settings.filled_flasks= num
	end,
	set_ignitor = function(name, image)
		brewing.settings.ignitor["name"]= name
		brewing.settings.ignitor["image"]= image
	end,
	get_craft_result = function(itemlist)
		--recipes are 2x3
		local match = false
		local output
		--To get the output of the first potion: minetest.chat_send_player("singleplayer", brewing.craftlist[1][1])
		--To get the first ingredient of the first potion: minetest.chat_send_player("singleplayer", brewing.craftlist[1][2][1][1])
		--for key, potioncraft in pairs(brewing.craftlist) do
		for potioncraft in brewing.arrayvalues(brewing.craftlist) do
			--To get the output of the potion: minetest.chat_send_player("singleplayer", potioncraft[1])
			--To get the first ingredient of the 1st row of the potion: minetest.chat_send_player("singleplayer", potioncraft[2][1][1])
			--To get the first ingredient of the 2nd row of the potion: minetest.chat_send_player("singleplayer", potioncraft[2][2][1])
			--To get the second ingredient of the 2nd row of the potion: minetest.chat_send_player("singleplayer", potioncraft[2][2][2])
			--check recipe concordance
			--firstly in the 2 rows
			for i= 1, 2, 1 do
				--then in the 3 items of the row
				for j= 1, 3, 1 do
					if potioncraft[2][i][j] ~= itemlist.items[i][j] then
						match = false
						break
					else
						match = true
					end
				end
				--if no coincidence, do not search in the second row
				if match == false then
					break
				end
			end
			--if coincidence with a potioncraft
			if match == true then
				output = potioncraft[1]
				break
			end
		end
		local item
		if match == true then
			item = ItemStack(output)
			--minetest.chat_send_player("singleplayer", "match")
		else
			item = nil
			--minetest.chat_send_player("singleplayer", "unmatched")
		end
		return item
	end,
	magic_aura = function(obj, pos, emitter, magic)
		local minpos = pos
		local maxpos
		if emitter == "player" then
			maxpos = brewing.posfrontplayer(obj)
		elseif emitter == "node" or emitter == "entity" then
			maxpos = {
				x = minpos.x,
				y = minpos.y + 0.5,
				z = minpos.z
			}
		end
		local texture_name
		if magic == "default" then
			texture_name = "brewing_magic_particle.png"
		elseif magic == "freeze" then
			texture_name = "brewing_freeze_particle.png"
		else
			texture_name = "brewing_magic_particle.png"
		end
		minetest.add_particlespawner({
			amount = 20,
			time = 1.5,
			minpos = minpos,
			maxpos = maxpos,
			minvel = {x=1, y=1, z=0},
			maxvel = {x=1, y=1, z=0},
			minacc = {x=1, y=1, z=1},
			maxacc = {x=1, y=1, z=1},
			minexptime = 1,
			maxexptime = 1,
			minsize = 0.2,
			maxsize = 0.4,
			collisiondetection = false,
			vertical = false,
			texture = texture_name,
			playername = "singleplayer"
		})
	end,
	magic_sound = function(dest, dest_name, soundfile)
		minetest.sound_play(soundfile, {dest = dest_name, gain = 0.4})
	end,
	is_night = function()
		local timeofday = minetest.get_timeofday() * 24000
		if (timeofday < 4500) or (timeofday > 19500) then
			return true
		else
			return false
		end 
	end;
}
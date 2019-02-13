local modpath, S = ...

--The Engine (Potions/Effects) Part!!!
brewing.engine = {
	players = {},
	effects = {
		phys_override = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					brewing.magic_sound("to_player", user, "brewing_magic_sound")
					brewing.magic_aura(user, user:get_pos(), "player", "default")
					brewing.engine.grant(time, user:get_player_name(), fname.."_"..flags.type..sdata.type, name, flags)
					itemstack:take_item()
					return itemstack
				end,
				potions = {
					speed = 0,
					jump = 0,
					gravity = 0,
					tnt = 0,
					air = 0,
				},
			}
			return def
		end,
		fixhp = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					brewing.magic_sound("to_player", user, "brewing_magic_sound")
					brewing.magic_aura(user, user:get_pos(), "player", "default")
					for i=0, (sdata.time or 0) do
						minetest.after(i, function()
							local hp = user:get_hp()
							if flags.inv==true then
								hp = hp - (sdata.hp or 3)
							else
								hp = hp + (sdata.hp or 3)
							end
							hp = math.min(20, hp)
							hp = math.max(0, hp)
							user:set_hp(hp)
						end)
					end
					itemstack:take_item()
					return itemstack
				end,
			}
			def.mobs = {
				on_near = def.on_use,
			}
			return def
		end,
		air = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					brewing.magic_sound("to_player", user, "brewing_magic_sound")
					brewing.magic_aura(user, user:get_pos(), "player", "default")
					local potions_e = brewing.engine.players[user:get_player_name()]
					potions_e.air = potions_e.air + (sdata.time or 0)
					for i=0, (sdata.time or 0) do
						minetest.after(i, function()
							local br = user:get_breath()
							if flags.inv==true then
								br = br - (sdata.br or 3)
							else
								br = br + (sdata.br or 3)
							end
							br = math.min(11, br)
							br = math.max(0, br)
							user:set_breath(br)

							if i==(sdata.time or 0) then
								potions_e.air = potions_e.air - (sdata.time or 0)
							end
						end)
					end
					itemstack:take_item()
					return itemstack
				end,
			}
			return def
		end,
		blowup = function(sname, name, fname, time, sdata, flags)
			local def = {
				on_use = function(itemstack, user, pointed_thing)
					brewing.magic_sound("to_player", user, "brewing_magic_sound")
					brewing.magic_aura(user, user:get_pos(), "player", "default")
					brewing.engine.grant(time, user:get_player_name(), fname.."_"..flags.type..sdata.type, name, flags)
					itemstack:take_item()
					return itemstack
				end,
				potions = {
					speed = 0,
					jump = 0,
					gravity = 0,
					tnt = 0,
				},
			}
			def.mobs = {
				on_near = function(itemstack, user, pointed_thing)
					local str = user:get_luaentity().brewing.engine.exploding
					if flags.inv==true then
						str = math.max(0, str - sdata.power)
					else
						str = math.min(str + sdata.power, 250)
					end
					user:get_luaentity().brewing.engine.exploding = str
					itemstack:take_item()
					return itemstack
				end,
			}
			return def
		end,
		set_invisibility = function(player)
			-- hide player and name tag
			prop = {
				visual_size = {x = 0, y = 0},
				--collisionbox = {0, 0, 0, 0, 0, 0}
			}
			player:set_nametag_attributes({
				color = {a = 0, r = 255, g = 255, b = 255}
			})
			player:set_properties(prop)
		end,
		set_visibility = function(player)
			-- show player and tag
			prop = {
				visual_size = {x = 1, y = 1},
				--collisionbox = {-0.35, -1, -0.35, 0.35, 1, 0.35}
			}
			player:set_nametag_attributes({
				color = {a = 255, r = 255, g = 255, b = 255}
			})
			player:set_properties(prop)
		end,
		freeze = function(pointed_thing, user, emitter)			
			local entity_to_freeze = pointed_thing.ref
			local is_freeze_entity = false
			if not(entity_to_freeze:is_player()) then
				local entity_to_freeze_lua = entity_to_freeze:get_luaentity()
				if entity_to_freeze_lua.name == "brewing:freeze_entity" then
					is_freeze_entity = true
				end
			end
			if not(is_freeze_entity) then --do not freeze over a already freeze entity
				local pos = entity_to_freeze:get_pos()										
				freeze_entity = minetest.add_entity(pos, "brewing:freeze_entity")		
				--freeze_entity:set_armor_groups({immortal = 1})
				local user_pos = user:get_pos()
				local dest = ""
				if (user:is_player()) then					
					dest = "to_player"
				else
					dest = "entity"
				end
				brewing.magic_aura(user, user_pos, emitter, "freeze")
				entity_to_freeze:set_attach(freeze_entity, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
				brewing.magic_sound(dest, pointed_thing, "brewing_freeze")		
				minetest.after(brewing.settings.freeze_time, function() --Unfreeze after x seconds
					freeze_entity:remove()
					brewing.magic_sound(dest, pointed_thing, "brewing_locksbreak")
					if entity_to_freeze then
						entity_to_freeze:set_detach()
						local entity_hp = entity_to_freeze:get_hp()
						local new_hp = entity_hp - brewing.settings.freeze_hit_points
						entity_to_freeze:set_hp(new_hp)
					end
				end)
				if minetest.get_modpath("mana") ~= nil then
					mana.subtract_up_to(user, brewing.settings.mana_magic_blue_tear_wand)
				end
			end
		end,
		aqua = function(pointed_thing, user, emitter)
			local pos = pointed_thing:get_pos()															
			local user_pos = user:get_pos()
			brewing.magic_aura(user, user_pos, emitter, "freeze")
			local dest = ""
			if pointed_thing:is_player() then
				dest = "to_player"
			else
				dest = "object"
			end
			brewing.magic_sound(dest, pointed_thing, "brewing_splash")					
			local entity_hp = pointed_thing:get_hp()
			local new_hp = entity_hp - brewing.settings.freeze_hit_points
			pointed_thing:set_hp(new_hp)			
		end,
		ps = {},
		ttl = 1,
		revertsky = function()
			if brewing.engine.effects.ttl == 0 then
				return
			end
			brewing.engine.effects.ttl = brewing.engine.effects.ttl - 1
			if brewing.engine.effects.ttl > 0 then
				return
			end
			for key, entry in pairs(brewing.engine.effects.ps) do
				local sky = entry.sky
				entry.p:set_sky(sky.bgcolor, sky.type, sky.textures)
			end
			brewing.engine.effects.ps = {}
		end,
		light_strike = function(user, enemy)
			local lightning_size = 100
			local rng = PcgRandom(32321123312123)
			local enemy_entity = enemy.ref
			local pos = enemy_entity:get_pos()
			minetest.add_particlespawner({
				amount = 1,
				time = 0.2,
				-- make it hit the top of a block exactly with the bottom
				minpos = {x = pos.x, y = pos.y + (lightning_size / 2) + 1/2, z = pos.z },
				maxpos = {x = pos.x, y = pos.y + (lightning_size / 2) + 1/2, z = pos.z },
				minvel = {x = 0, y = 0, z = 0},
				maxvel = {x = 0, y = 0, z = 0},
				minacc = {x = 0, y = 0, z = 0},
				maxacc = {x = 0, y = 0, z = 0},
				minexptime = 0.2,
				maxexptime = 0.2,
				minsize = lightning_size * 10,
				maxsize = lightning_size * 10,
				collisiondetection = true,
				vertical = true,
				-- to make it appear hitting the node that will get set on fire, make sure
				-- to make the texture lightning bolt hit exactly in the middle of the
				-- texture (e.g. 127/128 on a 256x wide texture)
				texture = "brewing_sun_ray.png",
				-- 0.4.15+
				glow = 14,
			})
			minetest.sound_play({ pos = pos, name = "brewing_thunder", gain = 10, max_hear_distance = 100 })
			-- damage enemy object
			local enemy_isdead = false
			enemy_entity:punch(enemy_entity, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy=8}}, nil)						
			if enemy_entity:get_hp() <= 0 then
				enemy_isdead = true
			end
			local players = {}
			if (user:is_player()) then
				table.insert(players, user)
			end
			if enemy_entity:is_player() then
				table.insert(players, enemy_entity)
			end
			for player_ in brewing.arrayvalues(players) do
				local name = player_:get_player_name()
				local sky = {}
				sky.bgcolor, sky.type, sky.textures = player_:get_sky()
				if brewing.engine.effects.ps[name] == nil then
					brewing.engine.effects.ps[name] = {p = player_, sky = sky}
					player_:set_sky(0xffffff, "plain", {})
				end			
			end
			-- trigger revert of skybox
			brewing.engine.effects.ttl = 5
			-- set the air node above it on fire
			if not enemy_isdead then
				local pos_y = pos.y
				pos.y = pos.y - 1
				local n = minetest.get_node(pos)
				if minetest.get_item_group(n.name, "tree") > 0 then
					minetest.set_node(pos, { name = "default:coalblock"})
				elseif minetest.get_item_group(n.name, "sand") > 0 then
					minetest.set_node(pos, { name = "default:glass"})
				elseif minetest.get_item_group(n.name, "soil") > 0 then
					minetest.set_node(pos, { name = "default:gravel"})
				end
				pos.y = pos_y 
				if minetest.get_item_group(minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name, "liquid") < 1 then
					if minetest.get_node(pos).name == "air" then
						minetest.set_node(pos, {name = "fire:basic_flame"})
				end
			end
			end							
		end,
	},		
	grant = function(time, playername, potion_name, type, flags)
		local rootdef = minetest.registered_items[potion_name]
		if rootdef == nil then
			return
		end
		if rootdef.potions == nil then
			return
		end
		local def = {}
		for name, val in pairs(rootdef.potions) do
			def[name] = val
		end
		if flags.inv==true then
			def.gravity = 0 - def.gravity
			def.speed = 0 - def.speed
			def.jump = 0 - def.jump
			def.tnt = 0 - def.tnt
		end
		brewing.engine.addPrefs(playername, def.speed, def.jump, def.gravity, def.tnt)
		brewing.engine.refresh(playername)
		minetest.chat_send_player(playername, "You are under the effects of the "..type.." potion.")
		minetest.after(time, function()
			brewing.engine.addPrefs(playername, 0-def.speed, 0-def.jump, 0-def.gravity, 0-def.tnt)
			brewing.engine.refresh(playername)
			minetest.chat_send_player(playername, "The effects of the "..type.." potion have worn off.")
		end)
	end,
	addPrefs = function(playername, speed, jump, gravity, tnt)
		local prefs = brewing.engine.players[playername]
		prefs.speed = prefs.speed + speed
		prefs.jump = prefs.jump + jump
		prefs.gravity = prefs.gravity + gravity
		prefs.tnt = prefs.tnt + tnt
	end,
	refresh = function(playername)
		if minetest.get_player_by_name(playername)~=nil then
			local prefs = brewing.engine.players[playername]
			minetest.get_player_by_name(playername):set_physics_override(prefs.speed, prefs.jump, prefs.gravity)
		end
	end,
	register_potion = function(sname, name, fname, time, def)
		local tps = {"add", "sub"}
		for t=1, #tps do
			for i=1, #def.types do
				local sdata = def.types[i]
				local item_def = {
					description = name.." "..S("Potion").." ("..S("type")..":".." "..tps[t]..sdata.type..")",
					inventory_image = "potions_bottle.png^potions_"..(def.texture or sname)..".png^potions_"..tps[t]..sdata.type..".png",
					drawtype = "plantlike",
					paramtype = "light",
					walkable = false,
					groups = {dig_immediate=3,attached_node=1},
					--sounds = default.node_sound_glass_defaults(),
				}
				item_def.tiles = {item_def.inventory_image}
				local flags = {
					inv = false,
					type = tps[t],
				}
				if t == 2 then
					flags.inv = true
				end
				for name, val in pairs(brewing.engine.effects[def.effect](sname, name, fname, time, sdata, flags)) do
					item_def[name] = val
				end
				for name, val in pairs(sdata.set) do
					item_def[name] = val
				end
				for name, val in pairs(sdata.effects) do
					item_def.potions[name] = val
				end
				minetest.register_node(fname.."_"..tps[t]..sdata.type, item_def)
				--potions.register_liquid(i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use)
				if minetest.get_modpath("throwing")~=nil then
					brewing.engine.register_arrow(fname.."_"..tps[t]..sdata.type, i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use,
							item_def.description, item_def.inventory_image)
				end
			end
		end
	end,
	register_liquid = function(name, hname, funct)
		minetest.register_node("brewing:"..name.."_flowing", {
			description = S("Potion").."("..hname..") (".."flowing"..")",
			inventory_image = minetest.inventorycube("oil_oil.png"),
			drawtype = "flowingliquid",
			tile_images = {"oil_oil.png"},
			paramtype = "light",
			walkable = false,
			pointable = false,
			diggable = false,
			buildable_to = true,
			liquidtype = "flowing",
			liquid_alternative_flowing = "oil:oil_flowing",
			liquid_alternative_source = "oil:oil_source",
			liquid_viscosity = OIL_VISC,
			post_effect_color = {a=40, r=0, g=0, b=0},
			special_materials = {
				{image="oil_oil.png", backface_culling=false},
				{image="oil_oil.png", backface_culling=true},
			},
			potionWalk = funct,
		})

		minetest.register_node("brewing:"..name.."_source", {
			description = S("Potion").."("..hname..")",
			inventory_image = minetest.inventorycube("oil_oil.png"),
			drawtype = "liquid",
			tile_images = {"oil_oil.png"},
			paramtype = "light",
			walkable = false,
			pointable = false,
			diggable = false,
			buildable_to = true,
			liquidtype = "source",
			liquid_alternative_flowing = "oil:oil_flowing",
			liquid_alternative_source = "oil:oil_source",
			liquid_viscosity = OIL_VISC,
			post_effect_color = {a=40, r=0, g=0, b=0},
			special_materials = {
				{image="oil_oil.png", backface_culling=false},
			},
			potionWalk = funct,
		})
	end,
}

dofile(modpath.."/arrows.lua")

brewing.engine.register_potion("speed", S("Speed"), "brewing:speed", 300, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
				speed = 1,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
				speed = 2,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
				speed = 3,
			},
		},
	}
})
brewing.engine.register_potion("antigrav", S("Anti-Gravity"), "brewing:antigravity", 300, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
				gravity = -0.1,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
				gravity = -0.2,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
				gravity = -0.3,
			},
		},
	}
})

brewing.engine.register_potion("jump", S("Jumping"), "brewing:jumping", 300, {
	effect = "phys_override",
	types = {
		{
			type = 1,
			set = {},
			effects = {
				jump = 0.5,
			},
		},
		{
			type = 2,
			set = {},
			effects = {
				jump = 1,
			},
		},
		{
			type = 3,
			set = {},
			effects = {
				jump = 1.5,
			},
		},
	}
})

brewing.engine.register_potion("ouhealth", S("One Use Health"), "brewing:ouhealth", 300, {
	effect = "fixhp",
	types = {
		{
			type = 1,
			hp = 20,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			hp = 40,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			hp = 60,
			set = {},
			effects = {
			},
		},
	}
})

brewing.engine.register_potion("health", S("Health"), "brewing:health", 300, {
	effect = "fixhp",
	types = {
		{
			type = 1,
			time = 60,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			time = 120,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			time = 180,
			set = {},
			effects = {
			},
		},
	}
})

brewing.engine.register_potion("ouair", S("One Use Air"), "brewing:ouair", 300, {
	effect = "air",
	types = {
		{
			type = 1,
			br = 2,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			br = 5,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			br = 10,
			set = {},
			effects = {
			},
		},
	}
})

brewing.engine.register_potion("air", S("Air"), "brewing:air", 300, {
	effect = "air",
	types = {
		{
			type = 1,
			time = 60,
			set = {},
			effects = {
			},
		},
		{
			type = 2,
			time = 120,
			set = {},
			effects = {
			},
		},
		{
			type = 3,
			time = 180,
			set = {},
			effects = {
			},
		},
	}
})

minetest.register_on_joinplayer(function(player)
	brewing.engine.players[player:get_player_name()] = {
		antigravity = 1,
		jump = 1,
		gravity = 1,
		tnt = 0,
		air = 0,
	}
end)

minetest.register_on_joinplayer(function(player)
	brewing.engine.players[player:get_player_name()] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		tnt = 0,
		air = 0,
	}
end)

minetest.register_chatcommand("effect", {
	params = "none",
	description = "get effect info",
	func = function(name, param)
		minetest.chat_send_player(name, "effects:")
		local potions_e = brewing.engine.players[name]
		if potions_e~=nil then
			for potion_name, val in pairs(potions_e) do
				minetest.chat_send_player(name, potion_name .. "=" .. val)
			end
		end
	end,
})

-- Freeze Entity

minetest.register_entity("brewing:freeze_entity", {
	physical = true,	
	sounds = default.node_sound_glass_defaults(),
	visual = "sprite",
	visual_size = {x=2.5, y=2.5},
	textures = {"brewing_freeze_entity.png"},
	is_visible = true,
	makes_footstep_sound = false,
})

minetest.register_globalstep(brewing.engine.effects.revertsky)
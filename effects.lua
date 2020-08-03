local S = ...

--The Engine (Potions/Effects) Part!!!

brewing.effects = {}

brewing.effects.phys_override = function(effect_name, description_name, potion_name, time, sdata, flags)
	local def = {
		on_use = function(itemstack, user, pointed_thing)
			brewing.make_sound("player", user, "brewing_magic_sound")
			--brewing.magic_aura(user, user:get_pos(), "player", "default")
			brewing.grant(time, user, effect_name, potion_name.."_"..flags.type..sdata.type, description_name, flags)
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
end

brewing.effects.fixhp = function(sname, name, fname, time, sdata, flags)
	local def = {
		on_use = function(itemstack, user, pointed_thing)
			brewing.make_sound("player", user, "brewing_magic_sound")
			--brewing.magic_aura(user, user:get_pos(), "player", "default")
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
end

brewing.effects.air = function(sname, name, fname, time, sdata, flags)
	local def = {
		on_use = function(itemstack, user, pointed_thing)
			brewing.make_sound("player", user, "brewing_magic_sound")
			--brewing.magic_aura(user, user:get_pos(), "player", "default")
			local potions_e = brewing.players[user:get_player_name()]
			potions_e.air = potions_e.air + (sdata.time or 0)
			for i=0, (sdata.time or 0) do
				minetest.after(i, function(user, sdata)
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
				end, user, sdata)
			end
			itemstack:take_item()
			return itemstack
		end,
	}
	return def
end

brewing.effects.blowup = function(sname, name, fname, time, sdata, flags)
	local def = {
		on_use = function(itemstack, user, pointed_thing)
			brewing.make_sound("player", user, "brewing_magic_sound")
			--brewing.magic_aura(user, user:get_pos(), "player", "default")
			brewing.grant(time, user, sname, fname.."_"..flags.type..sdata.type, name, flags)
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
			local str = user:get_luaentity().brewing.exploding
			if flags.inv==true then
				str = math.max(0, str - sdata.power)
			else
				str = math.min(str + sdata.power, 250)
			end
			user:get_luaentity().brewing.exploding = str
			itemstack:take_item()
			return itemstack
		end,
	}
	return def
end

brewing.effects.set_invisibility = function(player) -- hide player and name tag
	local prop = {
		visual_size = {x = 0, y = 0},
	}
	player:set_nametag_attributes({
		color = {a = 0, r = 255, g = 255, b = 255}
	})
	player:set_properties(prop)
end

brewing.effects.set_visibility = function(player) -- show player and tag
	local prop = {
		visual_size = {x = 1, y = 1},
	}
	player:set_nametag_attributes({
		color = {a = 255, r = 255, g = 255, b = 255}
	})
	player:set_properties(prop)
end

brewing.grant = function(time, player, effect_name, potion_name, description_name, flags)
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
	local player_name = player:get_player_name()
	playerphysics.add_physics_factor(player, effect_name, potion_name, def[effect_name])
	minetest.chat_send_player(player_name, S("You are under the effects of the").." "..description_name.." "..S("potion."))
	minetest.after(time, function()
		if minetest.get_player_by_name(player_name)~=nil then
			playerphysics.remove_physics_factor(player, effect_name, potion_name)
			minetest.chat_send_player(player_name, S("The effects of the").." "..description_name.." "..S("potion have worn off."))
		end
	end)
end

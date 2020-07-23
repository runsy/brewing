local S = ...

--The Engine (Potions/Effects) Part!!!

brewing.effects = {}

brewing.effects.phys_override = function(sname, name, fname, time, sdata, flags)
	local def = {
		on_use = function(itemstack, user, pointed_thing)
			brewing.make_sound("player", user, "brewing_magic_sound")
			--brewing.magic_aura(user, user:get_pos(), "player", "default")
			brewing.grant(time, user:get_player_name(), fname.."_"..flags.type..sdata.type, name, flags)
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
			brewing.grant(time, user:get_player_name(), fname.."_"..flags.type..sdata.type, name, flags)
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

brewing.grant = function(time, playername, potion_name, type, flags)
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
	brewing.addPrefs(playername, def.speed, def.jump, def.gravity, def.tnt)
	brewing.refresh(playername)
	minetest.chat_send_player(playername, S("You are under the effects of the").." "..type.." "..S("potion."))
	minetest.after(time, function()
		brewing.addPrefs(playername, 0-def.speed, 0-def.jump, 0-def.gravity, 0-def.tnt)
		brewing.refresh(playername)
		minetest.chat_send_player(playername, S("The effects of the").." "..type.." "..S("potion have worn off."))
	end)
end

brewing.addPrefs = function(playername, speed, jump, gravity, tnt)
	local prefs = brewing.players[playername]
	prefs.speed = prefs.speed + speed
	prefs.jump = prefs.jump + jump
	prefs.gravity = prefs.gravity + gravity
	prefs.tnt = prefs.tnt + tnt
end

brewing.refresh = function(playername)
	if minetest.get_player_by_name(playername)~=nil then
		local prefs = brewing.players[playername]
		minetest.get_player_by_name(playername):set_physics_override(prefs.speed, prefs.jump, prefs.gravity)
	end
end

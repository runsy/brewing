local modpath, S = ...

-- Magic Sword
minetest.register_tool("brewing:fury_sun_sword", {
	description = S("Fury of Sun Sword"),
	inventory_image = "brewing_fury_sun_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.8, [2]=0.8, [3]=0.25}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
	on_use = function (itemstack, user, pointed_thing)
		-- Light Strike Effect
		if pointed_thing.type == "object" then
			if brewing.is_night() == false then
				brewing.engine.effects.light_strike(user, pointed_thing)
			else
				pointed_thing.ref:punch(pointed_thing.ref, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy=4}}, nil)	
			end
		end
	end,
})

minetest.register_craft({
	output = '"brewing:fury_sun_sword" 1',
	recipe = {
		{'', 'brewing:magic_crystal', ''},
		{'', 'brewing:magic_crystal', ''},
		{'', 'default:gold_sword', ''}
	}
})
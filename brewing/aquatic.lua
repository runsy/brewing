local modpath, S, mg_name = ...


minetest.register_craftitem("brewing:pearl", {
	description = S("Pearl"),
	inventory_image = "brewing_pearl.png",
})

minetest.register_craftitem("brewing:anemon", {
	description = S("Anemon"),
	inventory_image = "brewing_anemon.png",
	on_use = minetest.item_eat(-3),
	groups = {flammable = 2, food = 1},
})

minetest.register_craftitem("brewing:turtle_shell", {
	description = S("Turtle Shell"),
	inventory_image = "brewing_turtle_shell.png",
	groups = {flammable = 1, food = 1},
})

-- Pearl Oyster

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_pearl_oyster == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:sand",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"savanna_ocean", "rainforest_ocean", "desert_ocean", "sandstone_desert_ocean"},
			decoration = "brewing:pearl_oyster",
			height = 1,
		})
end

minetest.register_node("brewing:pearl_oyster", {
	description = S("Pearl Oyster"),
	tiles = {
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png"
	},
	special_tiles = {"brewing_pearl_oyster.png"},
	inventory_image = "brewing_pearl_oyster.png",
	wield_image = "brewing_pearl_oyster.png",
	drawtype = "plantlike_rooted",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {oddly_breakable_by_hand = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end
		local player_name = placer:get_player_name()
		local pos_above = pointed_thing.above
		local pos_under = pointed_thing.under
		if minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end
		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end
		minetest.set_node(pos_under, {name = "brewing:pearl_oyster"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end
		return itemstack
	end,
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end,
})

minetest.register_craft( {
	output = "brewing:pearl",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"", "brewing:pearl_oyster", ""}
	}
})

-- Anemon

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.generate_anemon == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:sand",
			sidelen = 16,
			fill_ratio = 0.001,
			biomes = {"savanna_ocean", "rainforest_ocean", "desert_ocean", "sandstone_desert_ocean"},
			decoration = "brewing:anemon",
			height = 1,
		})
end

minetest.register_node("brewing:anemon", {
	description = S("Anemon"),
	tiles = {
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png",
		"default_sand.png"
	},
	special_tiles = {"brewing_anemon.png"},
	inventory_image = "brewing_anemon.png",
	wield_image = "brewing_anemon.png",
	drawtype = "plantlike_rooted",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {choppy = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end
		local player_name = placer:get_player_name()
		local pos_above = pointed_thing.above
		local pos_under = pointed_thing.under
		if minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end
		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end
		minetest.set_node(pos_under, {name = "brewing:anemon"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end
		return itemstack
	end,
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end,
})
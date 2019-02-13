local modpath, S = ...

--Magic Crystal Ball

minetest.register_node("brewing:magic_crystal_ball", {
	description = S("Magic Crystal Ball"),
	drawtype = "plantlike",
	tiles = {"magic_crystal_ball.png"},
	walkable = false,
	groups = {snappy = 2, attached_node = 1},
	drop = "default:gold_ingot",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX - 1,
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "magic_crystal_ball.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 },
	},
	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "brewing:magic_crystal_ball", param2 = 1})
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if minetest.get_modpath("mobs") == nil or not player or not player:is_player() then -- make sure player is clicking and fairy was not invoket yet
			return
		end
		local meta = minetest.get_meta(pos)
		local player_name = player:get_player_name()
		if (brewing.entities.lily == nil) then
			local spawn_pos = brewing.pos_above(pos) --it cannot be assigned like: spawn_pos = pos !!!
			if minetest.get_node(spawn_pos).name == "air" then
				minetest.add_entity(spawn_pos, "brewing:fairy_lily")
				brewing.entities.lily.owner = player_name
				brewing.entities.lily.crystalball_pos = pos --save the crystal ball pos, useful when lily dies (to reset the ownership)
				meta:set_string("owner", player_name)
				meta:set_string("infotext", S("Lily lives here"))
				brewing.magic_aura(node, pos, "node", "default")
				brewing.magic_sound("object", pointed_thing, "brewing_magic_sound")
			else
				brewing.magic_sound("object", pointed_thing, "brewing_magic_failure")
			end

		else
			if (meta:get_string("owner") == player_name) and (brewing.entities.lily.owner == player_name) then
				brewing.entities.lily.object:remove()
				brewing.entities.lily = nil
				meta:set_string("owner", "")
				meta:set_string("infotext", "")
				minetest.chat_send_player(player_name, S("Lily has returned to her Magic Crystal Ball."))
				brewing.magic_aura(node, pos, "node", "default")
				brewing.magic_sound("object", pointed_thing, "brewing_magic_sound")
			else
				brewing.magic_sound("object", pointed_thing, "brewing_magic_failure")
			end
		end
	end,
	on_destruct = function(pos)
		if minetest.get_modpath("mobs") == nil  then
			return
		end
		local meta = minetest.get_meta(pos)
		if (meta:get_string("owner") ~= "") then
			if (brewing.entities.lily ~= nil) then
				brewing.entities.lily.object:remove()
				brewing.entities.lily = nil
				local inv = minetest.get_inventory({ type="detached", name="lily_inventory" })
				inv:set_list("main", {})
			end
		end
	end
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_crystal_ball",
	recipe = {
		{"", "brewing:magic_crystal", ""},
		{"brewing:magic_crystal", "brewing:magic_crystal", "brewing:magic_crystal"},
		{"default:gold_ingot", "brewing:magic_crystal", "default:gold_ingot"},
	}
})
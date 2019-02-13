local modpath, S = ...

-- Brewing Cauldron
minetest.register_craft({
	output = '"brewing:magic_cauldron" 1',
	recipe = {
		{'brewing:magic_crystal', '', 'brewing:magic_crystal'},
		{'brewing:magic_crystal', '', 'brewing:magic_crystal'},
		{'brewing:magic_crystal', 'brewing:magic_crystal', 'brewing:magic_crystal'}
	}
})

--Magic Ore/Gem/Crystal...

--  Magic Ore
minetest.register_node("brewing:magic_ore", {
	description = S("Magic Ore"),
	tiles = {"default_stone.png^magic_ore.png"},
	groups = {cracky=3, stone=1},
	drop = 'brewing:magic_crystal',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "brewing:magic_ore",
	wherein = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 5,
	clust_size = 5,
	y_min = -31000,
	y_max = -1000,
})

--  Magic Crystal
minetest.register_craftitem("brewing:magic_crystal", {
	description = S("Magic Crystal"),
	inventory_image = "magic_crystal_full.png",
})

minetest.register_craftitem("brewing:magic_crystal_piece", {
	description = S("Magic Crystal Piece"),
	inventory_image = "magic_crystal_piece.png",
})

--Magic Dust
minetest.register_craftitem("brewing:magic_dust", {
	description = S("Magic Dust"),
	inventory_image = "magic_dust.png",
	wield_image = "magic_dust.png"
})

-- Magic Block
minetest.register_node("brewing:magic_block", {
	description = S("Magic Block"),
	tiles = {"brewing_magic_block.png"},
	groups = {cracky = 1, level = 2},
	is_ground_content = false,
	sounds = default.node_sound_glass_defaults(),
})

--Crafting Magic

-- Magic Crystal Piece
minetest.register_craft({
	output = '"brewing:magic_crystal_piece" 3',
	recipe = {
		{'brewing:magic_crystal'}
	}
})

-- Magic Dust
minetest.register_craft({
	output = 'brewing:magic_dust',
	recipe = {
		{'brewing:magic_crystal_piece'}
	}
})

-- Magic Block
minetest.register_craft({
	output = '"brewing:magic_block" 4',
	recipe = {
		{'brewing:magic_crystal', 'brewing:magic_crystal', ''},
		{'brewing:magic_crystal', 'brewing:magic_crystal', ''},
		{'', '', ''}
	}
})

--Magic Cross
minetest.register_craftitem("brewing:magic_cross", {
	description = S("Magic Cross"),
	inventory_image = "magic_cross.png",
	wield_image = "magic_cross.png"
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_cross",
	recipe = {
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "brewing:magic_crystal", "default:gold_ingot"},
		{"", "default:gold_ingot", ""},
	}
})

--Magic Heart
minetest.register_craftitem("brewing:magic_heart", {
	description = S("Magic Heart"),
	inventory_image = "brewing_magic_heart.png",
	wield_image = "brewing_magic_heart.png"
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_heart",
	recipe = {
		{"brewing:magic_crystal_piece", "default:gold_ingot", "brewing:magic_crystal_piece"},
		{"brewing:magic_crystal_piece", "brewing:magic_crystal_piece", "brewing:magic_crystal_piece"},
		{"", "brewing:magic_crystal_piece", ""},
	}
})

--Magic Apple

minetest.register_node("brewing:magic_apple", {
	description = S("Magic Apple"),
	drawtype = "plantlike",
	tiles = {"magic_apple.png"},
	inventory_image = "magic_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "brewing:magic_apple", param2 = 1})
	end,
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_apple",
	recipe = {
		{"brewing:magic_crystal_piece", "brewing:magic_crystal_piece", "brewing:magic_crystal_piece"},
		{"brewing:magic_crystal_piece", "default:apple", "brewing:magic_crystal_piece"},
		{"brewing:magic_crystal_piece", "brewing:magic_crystal_piece", "brewing:magic_crystal_piece"},
	}
})

-- Blue Tear Crystal

minetest.register_craftitem("brewing:magic_blue_tear_crystal", {
	description = S("Magic Blue Tear Crystal"),
	inventory_image = "brewing_magic_blue_tear_crystal.png",
})

minetest.register_craft({
	type = "cooking",
	output = "brewing:magic_blue_tear_crystal",
	recipe = "brewing:magic_blue_dust",
	cooktime = 5,
})

-- Blue Tear Gem

minetest.register_craftitem("brewing:magic_blue_tear_gem", {
	description = S("Magic Blue Tear Gem"),
	inventory_image = "brewing_magic_blue_tear_gem.png",
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_blue_tear_gem",
	recipe = {
		{"", "brewing:magic_blue_tear_crystal", ""},
		{"brewing:magic_blue_tear_crystal", "brewing:magic_blue_tear_crystal", "brewing:magic_blue_tear_crystal"},
		{"", "brewing:magic_blue_tear_crystal", ""},
	}
})

-- Blue Star

minetest.register_craftitem("brewing:magic_blue_star", {
	description = S("Magic Blue Star"),
	inventory_image = "brewing_magic_blue_star.png",
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_blue_star",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "brewing:magic_blue_tear_gem", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})
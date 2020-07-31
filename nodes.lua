local S = ...

--Brewing Cauldron
minetest.register_craft({
	output = '"brewing:magic_cauldron" 1',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'brewing:magic_crystal', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
	}
})

--Magic Ore/Gem...

--Magic Ore
minetest.register_node("brewing:magic_ore", {
	description = S("Magic Ore"),
	tiles = {"default_stone.png^brewing_magic_gem.png"},
	groups = {cracky=3, stone=1},
    drop = {
		max_items = 6,
		items = {
			{
				items = {"brewing:magic_gem"},
				rarity = 6,
				inherit_color = true,
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "brewing:magic_ore",
	wherein = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 5,
	clust_size = 5,
	y_max = -256,
	y_min = -512,
})

-- Magic Gem
minetest.register_craftitem("brewing:magic_gem", {
	description = S("Magic Gem"),
	inventory_image = "brewing_magic_gem.png",
})

minetest.register_craftitem("brewing:magic_crystal", {
	description = S("Magic Crystal"),
	inventory_image = "brewing_magic_crystal.png",
})

-- Magic Crystal
minetest.register_craft({
	output = '"brewing:magic_crystal" 6',
	recipe = {
		{'brewing:magic_gem'}
	}
})

--Magic Dust
minetest.register_craftitem("brewing:magic_dust", {
	description = S("Magic Dust"),
	inventory_image = "brewing_magic_dust.png",
	wield_image = "brewing_magic_dust.png"
})

minetest.register_craft({
	output = 'brewing:magic_dust 6',
	recipe = {
		{'brewing:magic_crystal'}
	}
})

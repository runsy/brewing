local modpath, S = ...

-- Tools Registration

-- Magic Pickaxe
minetest.register_tool("brewing:magic_pickaxe", {
	description = S("Magic Pickaxe"),
	inventory_image = "magic_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.8, [2]=0.9, [3]=0.4}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = '"brewing:magic_pickaxe" 1',
	recipe = {
		{'brewing:magic_crystal', 'brewing:magic_crystal', 'brewing:magic_crystal'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''}
	}
})

-- Magic Axe
minetest.register_tool("brewing:magic_axe", {
	description = S("Magic Axe"),
	inventory_image = "magic_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = '"brewing:magic_axe" 1',
	recipe = {
		{'brewing:magic_crystal', 'brewing:magic_crystal', ''},
		{'brewing:magic_crystal', 'default:stick', ''},
		{'', 'default:stick', ''}
	}
})

-- Magic Shovel
minetest.register_tool("brewing:magic_shovel", {
	description = S("Magic Shovel"),
	inventory_image = "magic_shovel.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = '"brewing:magic_shovel" 1',
	recipe = {
		{'', 'brewing:magic_crystal', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''}
	}
})

-- Magic Hoe
farming.register_hoe("brewing:magic_hoe", {
	description = S("Magic Hoe"),
	inventory_image = "magic_hoe.png",
	max_uses = 500,
	material = "brewing:magic_crystal_piece"
})

minetest.register_craft({
	output = '"brewing:magic_hoe" 1',
	recipe = {
		{'brewing:magic_crystal', 'brewing:magic_crystal', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''}
	}
})

-- Magic Sword
minetest.register_tool("brewing:magic_sword", {
	description = S("Magic Sword"),
	inventory_image = "magic_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.8, [2]=0.8, [3]=0.25}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = '"brewing:magic_sword" 1',
	recipe = {
		{'', 'brewing:magic_crystal', ''},
		{'', 'brewing:magic_crystal', ''},
		{'', 'default:stick', ''}
	}
})
local S = ...

local mg_name = minetest.get_mapgen_setting("mg_name")

-- Orange Mycena

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"coniferous_forest"},
			decoration = "brewing:orange_mycena",
			height = 1,
		})
end

minetest.register_node("brewing:orange_mycena", {
	description = S("Orange Mycena"),
	tiles = {"brewing_orange_mycena.png"},
	inventory_image = "brewing_orange_mycena.png",
	wield_image = "brewing_orange_mycena.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(3),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

-- Cortinarius Violaceus

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"coniferous_forest"},
			decoration = "brewing:cortinarius_violaceus",
			height = 1,
		})
end

minetest.register_node("brewing:cortinarius_violaceus", {
	description = S("Cortinarius Violaceus"),
	tiles = {"brewing_cortinarius_violaceus.png"},
	inventory_image = "brewing_cortinarius_violaceus.png",
	wield_image = "brewing_cortinarius_violaceus.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(-5),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

-- Gliophorus viridis

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_rainforest_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"rainforest"},
			decoration = "brewing:gliophorus_viridis",
			height = 1,
		})
end

minetest.register_node("brewing:gliophorus_viridis", {
	description = S("Gliophorus Viridis"),
	tiles = {"brewing_gliophorus_viridis.png"},
	inventory_image = "brewing_gliophorus_viridis.png",
	wield_image = "brewing_gliophorus_viridis.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(-3),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

--Pluteus Chrysophaeus

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"coniferous_forest"},
			decoration = "brewing:pluteus_chrysophaeus",
			height = 1,
		})
end

minetest.register_node("brewing:pluteus_chrysophaeus", {
	description = S("Pluteus Chrysophaeus"),
	tiles = {"brewing_pluteus_chrysophaeus.png"},
	inventory_image = "brewing_pluteus_chrysophaeus.png",
	wield_image = "brewing_pluteus_chrysophaeus.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(4),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

--Leaiana Mycena

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_rainforest_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"rainforest"},
			decoration = "brewing:leaiana_mycena",
			height = 1,
		})
end

minetest.register_node("brewing:leaiana_mycena", {
	description = S("Leaiana Mycena"),
	tiles = {"brewing_leaiana_mycena.png"},
	inventory_image = "brewing_leaiana_mycena.png",
	wield_image = "brewing_leaiana_mycena.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(4),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

-- Green Hygrocybe

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_rainforest_litter",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"rainforest"},
			decoration = "brewing:green_hygrocybe",
			height = 1,
		})
end

minetest.register_node("brewing:green_hygrocybe", {
	description = S("Green Hygrocybe"),
	tiles = {"brewing_green_hygrocybe.png"},
	inventory_image = "brewing_green_hygrocybe.png",
	wield_image = "brewing_green_hygrocybe.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(3),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

minetest.register_abm({
	label = "Brewing Mushroom spread",
	nodenames = {"brewing:orange_mycena", "brewing:cortinarius_violaceus", "brewing:gliophorus_viridis", "brewing:pluteus_chrysophaeus", "brewing:leaiana_mycena", "brewing:green_hygrocybe"},
	interval = 11,
	chance = 150,
	action = function(...)
		flowers.mushroom_spread(...)
	end,
})

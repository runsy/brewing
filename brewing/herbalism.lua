local modpath, S, mg_name = ...

local brewing_flowers = {}

brewing_flowers.datas = {
	{
		"fire_flower",
		S("Fire Flower"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{flammable = 1}
	},
	{
		"gerbera_daisy",
		S("Gerbera Daisy"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{color_orange = 1, flammable = 1}
	},
	{
		"yellow_bell",
		S("Yellow Bell"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{color_yellow = 1, flammable = 1}
	},
	{
		"saffron_crocus",
		S("Saffron Crocus"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{flammable = 1}
	},
	{
		"lucky_club",
		S("Lucky Club"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{color_green = 1, flammable = 1}
	},
	{
		"creosote_bush",
		S("Creosote Bush"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
	{
		"mint",
		S("Mint"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
		{
		"star_anise_plant",
		S("Star Anise Plant"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
		{
		"calla",
		S("Calla"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
		{
		"lavender",
		S("Lavender"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
	{
		"azalea",
		S("Azalea"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{flammable = 1}
	},
}

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("brewing:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"brewing_" .. name .. ".png"},
		inventory_image = "brewing_" .. name .. ".png",
		wield_image = "brewing_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

for _,item in pairs(brewing_flowers.datas) do
	add_simple_flower(unpack(item))
end

--Fire Flower

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_fire_flower == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:desert_sand",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"sandstone_desert", "desert"},
			decoration = "brewing:fire_flower",
			height = 1,
		})
end

--Gerbera Daisy

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_gerbera_daisy == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"grassland", "deciduous_forest"},
			decoration = "brewing:gerbera_daisy",
			height = 1,
		})
end

--Yellow Bell

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_yellow_bell == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"grassland", "coniferous_forest"},
			decoration = "brewing:yellow_bell",
			height = 1,
		})
end

-- Saffron Crocus

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_saffron_crocus == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"grassland"},
			decoration = "brewing:saffron_crocus",
			height = 1,
		})
end

-- Lucky Club

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_lucky_club == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.00001,
			biomes = {"grassland", "deciduous_forest"},
			decoration = "brewing:lucky_club",
			height = 1,
		})
end

-- Mint

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_mint == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.0005,
			biomes = {"grassland", "deciduous_forest"},
			decoration = "brewing:mint",
			y_min = 1,
			y_max = 3,
			height = 1,
		})
end

-- Creosote Bush

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_creosote_bush == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:sand",
			sidelen = 16,
			fill_ratio = 0.001,
			biomes = {"sandstone_desert_ocean", "desert_ocean"},
			decoration = "brewing:creosote_bush",
			y_min = 1,
			y_max = 2,
			height = 1,
		})
end

-- Artic Carrot

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_orange_mycena == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:silver_sand",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"cold_desert"},
			decoration = "brewing:artic_carrot",
			height = 1,
		})
end

minetest.register_node("brewing:artic_carrot", {
	description = S("Artic Carrot"),
	tiles = {"brewing_artic_carrot.png"},
	inventory_image = "brewing_artic_carrot_inv.png",
	wield_image = "brewing_artic_carrot_inv.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1, flora = 1, color_white = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(2),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

-- Mandragora

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_mandragora == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_dry_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"savanna"},
			decoration = "brewing:mandragora",
			height = 1,
		})
end

minetest.register_node("brewing:mandragora", {
	description = S("Mandragora"),
	tiles = {"brewing_mandragora.png"},
	inventory_image = "brewing_mandragora_inv.png",
	wield_image = "brewing_mandragora_inv.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	stack_max = 99,
	groups = {snappy = 3, attached_node = 1, flammable = 1, flora = 1, color_white = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

-- Anise Star Plant

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_star_anise_plant == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_dry_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"savanna"},
			decoration = "brewing:star_anise_plant",
			height = 1,
		})
end

-- Star Anise

minetest.register_craftitem("brewing:star_anise", {
	description = S("Star Anise"),
	inventory_image = "brewing_star_anise.png",
})

minetest.register_craft( {
	output = "brewing:star_anise 3",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"", "brewing:star_anise_plant", ""}
	}
})


-- Lavender

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_lavender == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.001,
			biomes = {"deciduous_forest"},
			decoration = "brewing:lavender",
			y_min = 1,
			y_max = 2,
			height = 1,
		})
end

-- Calla

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_calla== true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.001,
			biomes = {"deciduous_forest"},
			decoration = "brewing:calla",
			y_min = 1,
			y_max = 2,
			height = 1,
		})
end

-- Azalea

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_azalea== true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_grass",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"deciduous_forest"},
			decoration = "brewing:azalea",
			height = 1,
		})
end

-- Orange Mycena

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_orange_mycena == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0001,
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

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_cortinarius_violaceus == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0001,
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

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_gliophorus_viridis == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_coniferous_litter",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"coniferous_forest"},
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

minetest.register_abm({
	label = "Brewing Mushroom spread",
	nodenames = {"brewing:orange_mycena", "brewing:cortinarius_violaceus", "brewing:gliophorus_viridis"},
	interval = 11,
	chance = 150,
	action = function(...)
		flowers.mushroom_spread(...)
	end,
})

-- Gerbera Oil

minetest.register_craftitem("brewing:gerbera_oil", {
	description = S("Gerbera Oil"),
	inventory_image = "brewing_gerbera_oil.png",
})

minetest.register_craft( {
	output = "brewing:gerbera_oil",
	recipe = {
		{"", "", ""},
		{"", "brewing:gerbera_daisy", ""},
		{"", "brewing:vial", ""}
	}
})

-- Mint Juice

minetest.register_craftitem("brewing:mint_juice", {
	description = S("Mint Juice"),
	inventory_image = "brewing_mint_juice.png",
})

minetest.register_craft( {
	output = "brewing:mint_juice",
	recipe = {
		{"", "", ""},
		{"", "brewing:mint_leaves", ""},
		{"", "brewing:vial", ""}
	}
})

--Mint Leaves

minetest.register_craftitem("brewing:mint_leaves", {
	description = S("Mint Leaves"),
	inventory_image = "brewing_mint_leaves.png",
})

minetest.register_craft( {
	output = "brewing:mint_leaves 5",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"", "brewing:mint", ""}
	}
})

-- Fire Essence

minetest.register_craftitem("brewing:fire_essence", {
	description = S("Fire Essence"),
	inventory_image = "brewing_fire_essence.png",
})

minetest.register_craft( {
	output = "brewing:fire_essence",
	recipe = {
		{"", "", ""},
		{"", "brewing:fire_flower", ""},
		{"", "brewing:jar", ""}
	}
})

-- Saffron

minetest.register_craftitem("brewing:saffron", {
	description = S("Saffron Bag"),
	inventory_image = "brewing_saffron.png",
})

minetest.register_craft( {
	output = "brewing:saffron",
	recipe = {
		{"", "", ""},
		{"", "brewing:saffron_crocus", ""},
		{"", "default:paper", ""}
	}
})

-- Cortinarius Poison

minetest.register_craftitem("brewing:cortinarius_poison", {
	description = S("Cortinarius Poison"),
	inventory_image = "brewing_cortinarius_poison.png",
})

minetest.register_craft( {
	output = "brewing:cortinarius_poison",
	recipe = {
		{"", "", ""},
		{"", "brewing:cortinarius_violaceus", ""},
		{"", "brewing:jar", ""}
	}
})
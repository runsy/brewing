local modpath, S, mg_name = ...

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_magic_rose == true then
	--Spread the Magic Roses on map
	minetest.register_decoration({
		deco_type = "simple",
		place_on = "default:dirt_with_grass",
		sidelen = 16,
		fill_ratio = 0.0001,
		biomes = {"deciduous_forest"},
		decoration = "brewing:magic_rose_4",
		height = 1,
	})
end

--Magic Rose
farming.register_plant("brewing:magic_rose", {
	description = S("Magic Rose Seed"),
	paramtype2 = "meshoptions",
	inventory_image = "brewing_magic_rose_seed.png",
	steps = 4,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4},
	place_param2 = 1,
})

minetest.register_craftitem("brewing:magic_rose_petals", {
	description = S("Magic Rose Petals"),
	inventory_image = "brewing_rose_petals.png",
	wield_image = "brewing_rose_petals.png"
})

minetest.register_craft({
	type = "shapeless",
	output = "brewing:magic_rose_petals",
	recipe = {"brewing:magic_rose"}
})

minetest.register_craftitem("brewing:magic_rosewater", {
	description = S("Magic Rosewater"),
	inventory_image = "brewing_rosewater.png",
	wield_image = "brewing_rosewater.png"
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_rosewater",
	recipe = {
		{"default:steel_ingot", "brewing:magic_crystal_piece", "default:steel_ingot"},
		{"brewing:magic_crystal_piece", "brewing:magic_rose_petals", "brewing:magic_crystal_piece"},
		{"default:steel_ingot", "bucket:bucket_river_water", "default:steel_ingot"},
	}
})

--Rose Vase

minetest.register_node("brewing:magic_rose_vase", {
	description = S("Magic Rose on a vase"),
	drawtype = "plantlike",
	tiles = {"brewing_rose_vase.png"},
	walkable = false,
	groups = {cracky = 2, attached_node = 1},
	drop = "brewing:magic_rose_vase",
	--paramtype = "light",
	sunlight_propagates = false,
	--light_source = LIGHT_MAX - 1,
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "brewing_rose_vase.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 },
	},
	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "brewing:magic_rose_vase", param2 = 1})
	end,
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_rose_vase",
	recipe = {
		{"", "", ""},
		{"", "brewing:magic_rose", ""},
		{"", "vessels:glass_bottle", ""},
	}
})

--Blue Rose

minetest.register_craftitem("brewing:magic_blue_rose", {
	description = S("Magic Blue Rose"),
	inventory_image = "brewing_magic_blue_rose.png",
	wield_image = "brewing_magic_blue_rose.png"
})

minetest.register_craftitem("brewing:magic_blue_rose_petals", {
	description = S("Magic Blue Rose Petals"),
	inventory_image = "brewing_magic_blue_rose_petals.png",
	wield_image = "brewing_magic_blue_rose_petals.png"
})

minetest.register_craft({
	type = "shapeless",
	output = "brewing:magic_blue_rose",
	recipe = {"brewing:magic_rose", "dye:blue"}
})

minetest.register_craft({
	type = "shapeless",
	output = "brewing:magic_blue_rose_petals",
	recipe = {"brewing:magic_blue_rose"}
})

--Magic Blue Dust

minetest.register_craftitem("brewing:magic_blue_dust", {
	description = S("Magic Blue Dust"),
	inventory_image = "brewing_magic_blue_dust.png",
})

minetest.register_craft({
	type = "cooking",
	output = "brewing:magic_blue_dust",
	recipe = "brewing:magic_blue_rose_petals",
	cooktime = 2,
})

--Sugarcane

farming.register_plant("brewing:sugarcane", {
	description = S("Sugarcane Sprout"),
	paramtype2 = "meshoptions",
	inventory_image = "brewing_sugarcane_seed.png",
	steps = 4,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4},
	place_param2 = 1,
})

if mg_name ~= "v6" and mg_name ~= "singlenode" and brewing.settings.generate_sugarcane == true then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:dirt_with_rainforest_litter",
			sidelen = 16,
			fill_ratio = 0.0001,
			biomes = {"rainforest"},
			decoration = "brewing:sugarcane_4",
			y_min = 10,
			y_max = 35,
			height = 1,
		})
end

-- Sugar

if farming.mod ~= "redo" then
	minetest.register_craftitem("brewing:sugar", {
		description = S("Sugar"),
		inventory_image = "brewing_sugar.png",
		groups = {flammable = 3},
	})

	minetest.register_craft({
		type = "cooking",
		cooktime = 3,
		output = "brewing:sugar 2",
		recipe = "default:papyrus",
	})
end

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "brewing:sugar 5",
	recipe = "brewing:sugarcane",
})

minetest.register_alias("brewing:sugar", "farming:sugar")
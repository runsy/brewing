local modname = "meteor"

local modpath = minetest.get_modpath(modname)

local mg_name = minetest.get_mapgen_setting("mg_name")

local S = minetest.get_translator(minetest.get_current_modname())

--  Meteor
minetest.register_node("meteorite:lunar_meteor", {
	description = S("Lunar Meteor"),
	tiles = {"meteorite_lunar_meteor.png"},
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
			deco_type = "simple",
			place_on = "default:desert_sand",
			sidelen = 16,
			fill_ratio = 0.00001,
			biomes = {"desert"},
			decoration = "meteorite:lunar_meteor",
			height = 1,
		})
end

-- Meteor Piece

minetest.register_craftitem("meteorite:lunar_meteor_piece", {
	description = S("Lunar Meteor Piece"),
	inventory_image = "meteorite_meteor_piece.png",
})

minetest.register_craft({
	output = '"meteorite:lunar_meteor_piece" 6',
	recipe = {
		{'meteorite:lunar_meteor'}
	}
})

--Meteor Spawner--

minetest.register_abm({
	nodenames = {"meteorite:lunar_meteor_hot"},
	interval = 120.0,
	chance = 1,
	action = function(pos)
		minetest.add_node(pos, {name="meteorite:lunar_meteor"})
	end,
})

minetest.register_node("meteorite:lunar_meteor_hot", {
	description = S("Lunar Meteor"),
	tiles = {"meteorite_lunar_meteor_hot.png"},
	groups = {cracky=3, hot=3, falling_node=1, stone=1},
	light_source = minetest.LIGHT_MAX,
})

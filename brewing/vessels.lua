local modpath, S = ...

-- Vial

minetest.register_craftitem("brewing:vial", {
	description = S("Vial (empty)"),
	inventory_image = "brewing_vial.png",
})

minetest.register_craft( {
	output = "brewing:vial 10",
	recipe = {
		{"", "cork:cork", ""},
		{"", "default:glass", ""},
		{"", "default:glass", ""}
	}
})

-- Jar

minetest.register_craftitem("brewing:jar", {
	description = S("Crystal Jar (empty)"),
	inventory_image = "brewing_jar.png",
})

minetest.register_craft( {
	output = "brewing:jar 10",
	recipe = {
		{"", "cork:cork", ""},
		{"default:glass", "", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})
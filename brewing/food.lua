local modpath, S = ...

--Magic Donut

minetest.register_craftitem("brewing:magic_donut", {
	description = S("Magic Donut"),
	inventory_image = "brewing_magic_donut.png",
	on_use = function (itemstack, user, pointed_thing)	   	
		if minetest.get_modpath("mana") ~= nil then
			mana.add_up_to(user, brewing.settings.mana_magic_donut)
		end
		return minetest.do_item_eat(brewing.settings.donut_eat_hp, nil, itemstack, user, pointed_thing)
	end,
	groups = {flammable = 2, food = 3},
})

minetest.register_craftitem("brewing:magic_donut_dough", {
	description = S("Magic Donut Dough"),
	inventory_image = "brewing_magic_donut_dough.png",	
	on_use = minetest.item_eat(2),
	groups = {flammable = 2, food = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "brewing:magic_donut",
	recipe = "brewing:magic_donut_dough",
	cooktime = 3,
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_donut_dough",
	recipe = {
		{"", "", ""},
		{"farming:flour", "brewing:sugar", "brewing:magic_dust"},
		{"", "bucket:bucket_water", ""},
	}
})

--Lemonade

minetest.register_craftitem("brewing:lemonade", {
	description = S("Lemonade"),
	inventory_image = "brewing_lemonade.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:lemonade",
	recipe = {
		{"", "lemontree:lemon", ""},
		{"", "brewing:sugar", ""},
		{"", "vessels:drinking_glass", ""},
	}
})

--Lemon Pie

minetest.register_craftitem("brewing:lemon_pie", {
	description = S("Lemon Pie"),
	inventory_image = "brewing_lemon_pie.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2, food = 3},
})

minetest.register_craftitem("brewing:lemon_pie_dough", {
	description = S("Lemon Pie Dough"),
	inventory_image = "brewing_lemon_pie_dough.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "cooking",
	output = "brewing:lemon_pie",
	recipe = "brewing:lemon_pie_dough",
	cooktime = 3,
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:lemon_pie_dough",
	recipe = {
		{"", "brewing:sugar", ""},
		{"", "farming:flour", ""},
		{"", "brewing:lemonade", ""},
	}
})

--Fay Cake

minetest.register_craftitem("brewing:fay_cake", {
	description = S("Fay Cake"),
	inventory_image = "brewing_fay_cake.png",
	on_use = function (itemstack, user, pointed_thing)
		if minetest.get_modpath("mana") ~= nil then
			mana.add_up_to(user, brewing.settings.mana_fay_cake)
		end
		return minetest.do_item_eat(7, nil, itemstack, user, pointed_thing)
	end,
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:fay_cake",
	recipe = {
		{"", "", ""},
		{"brewing:lemon", "brewing:artic_carrot", "brewing:sugar"},
		{"", "farming:flour", ""},
	}
})

--Nymph Salad

minetest.register_craftitem("brewing:nymph_salad", {
	description = S("Nymph Salad"),
	inventory_image = "brewing_nymph_salad.png",
	on_use = function (itemstack, user, pointed_thing)
		if minetest.get_modpath("mana") ~= nil then
			mana.add_up_to(user, brewing.settings.mana_nymph_salad)
		end
		return minetest.do_item_eat(8, nil, itemstack, user, pointed_thing)
	end,	
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:nymph_salad",
	recipe = {
		{"", "", ""},
		{"flowers:mushroom_brown", "brewing:lemon", "brewing:mint"},
		{"", "brewing:clay_bowl", ""},
	}
})

--Siren Soup

minetest.register_craftitem("brewing:siren_soup", {
	description = S("Siren Soup"),
	inventory_image = "brewing_siren_soup.png",
	on_use = function(itemstack, user, pointed_thing)
		if minetest.get_modpath("mana") ~= nil then
			mana.add_up_to(user, brewing.settings.mana_siren_soup)
		end
		return minetest.do_item_eat(5, nil, itemstack, user, pointed_thing)
	end,
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:siren_soup",
	recipe = {
		{"", "brewing:mint", ""},
		{"brewing:anemon", "brewing:lemon", "brewing:turtle_shell"},
		{"", "brewing:clay_bowl", ""},
	}
})

-- Clay Bowl and Unbaked Clay Bowl
-- Food and Crops support

if (minetest.get_modpath("crops") ~= nil) and (minetest.get_modpath("food")) ~= nil then
	minetest.register_craftitem("brewing:unbaked_clay_bowl", {
		description = S("Unbaked Clay Bowl"),
		inventory_image = "brewing_unbaked_clay_bowl.png",
	})

	minetest.register_craft({
		type = "shaped",
		output = "brewing:unbaked_clay_bowl",
		recipe = {
			{ "", "", "" },
			{ "default:clay_lump", "", "default:clay_lump" },
			{ "", "default:clay_lump", "" }
		}
	})

	minetest.register_craftitem("brewing:clay_bowl", {
		description = S("Clay Bowl"),
		inventory_image = "brewing_clay_bowl.png",
		groups = {food_bowl=1 }
	})

	minetest.register_craft({
		type = "cooking",
		output = "crops:clay_bowl",
		recipe = "crops:brewing_clay_bowl"
	})
end

minetest.register_alias("brewing:unbaked_clay_bowl", "crops:unbaked_clay_bowl")
minetest.register_alias("brewing:clay_bowl", "crops:clay_bowl")
minetest.register_alias("brewing:clay_bowl", "food:bowl")

--Clementine Jam

minetest.register_craftitem("brewing:clementine_jam", {
	description = S("Clementine Jam"),
	inventory_image = "brewing_clementine_jam.png",
	on_use = minetest.item_eat(4, "brewing:jar")
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_jam",
	recipe = {
		{"", "clementinetree:clementine", ""},
		{"", "brewing:sugar", ""},
		{"", "brewing:jar", "default:paper"},
	}
})

--Clementine Cotton Candy

minetest.register_craftitem("brewing:clementine_cotton_candy", {
	description = S("Clementine Cotton Candy"),
	inventory_image = "brewing_clementine_cotton_candy.png",
	on_use = minetest.item_eat(6, "default:stick"),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_cotton_candy",
	recipe = {
		{"clementinetree:clementine", "clementinetree:clementine", "clementinetree:clementine"},
		{"clementinetree:clementine", "brewing:sugar", "clementinetree:clementine"},
		{"", "default:stick", ""},
	}
})

--Clementine Chupachups

minetest.register_craftitem("brewing:clementine_chupachups", {
	description = S("Clementine Chupachups"),
	inventory_image = "brewing_clementine_chupachups.png",
	on_use = minetest.item_eat(3, "default:stick"),
	groups = {flammable = 2, food = 3},
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:clementine_chupachups 4",
	recipe = {
		{"", "clementinetree:clementine", ""},
		{"clementinetree:clementine", "brewing:sugar", "clementinetree:clementine"},
		{"", "default:stick", ""},
	}
})
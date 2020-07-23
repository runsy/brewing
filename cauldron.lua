local S = ...

local function uppercase(str)
    return (str:gsub("^%l", string.upper))
end

-- Cauldron Form

local formspec =
	"size[8,9;]"..
	"image_button[1,0;1,1;default_book_written.png;btn_recipe_book;]"..
	"tooltip[btn_recipe_book;"..S("Recipe Book").."]"..
	"label[0,1;"..S("Recipe").."]"..
	"list[context;ing1;1,1;1,1;]"..
	"list[context;ing2;2,1;1,1;]"..
	"list[context;ing3;3,1;1,1;]"..
	"image[3,2;1,1;brewing_arrow_ing_gray.png]"..
	"image[0,4;1,1;"..brewing.settings.ignitor_image.."]"..
	"list[context;ignitor;1,4;1,1;]"..
	"image[2,4;1,1;brewing_arrow_gray.png]"..
	"image[3,4;1,1;brewing_bucket_water_gray.png]"..
	"list[context;water;4,4;1,1;]"..
	"image[4,3;1,1;brewing_arrow_gray.png^[transformR90]]"..
	"image[4,2;1,1;brewing_cauldron_form.png]"..
	"image[5,0;1,1;brewing_vessels_glass_bottle_gray.png]"..
	"list[current_name;flask;5,1;1,1;]"..
	"image[5,2;1,1;brewing_arrow_gray.png]"..
	"label[6,1;".. brewing.settings.filled_flasks .."x]"..
	"list[current_name;dst;6,2;1,1;]"..
	"list[current_player;main;0,5;8,4;]"

--Recipe Book Form

local function create_recipe_book_form()
	local recipe_book_formspec =
		"size[8,8;]"..
		"real_coordinates[true]"..
		"button_exit[3.5,6.6;1,1;btn_exit;"..S("Close").."]"
	--Create the cells
	local cells = ""
	local potion_name = ""
	local potion_names = {}
	local potion_idxs = ""
	local potion_idx = 0
	local ing1_idxs = ""
	local ing2_idxs = ""
	local ing3_idxs = ""
	for index, potion_craft in ipairs(brewing.craft_list) do
		if potion_craft["effect"] == "jumping" then
			potion_name = "potions_jump.png"
		else
			potion_name = "potions_"..potion_craft["effect"]..".png"
		end
		local potion_exists
		for idx, value in ipairs(potion_names) do
			if value == potion_name then
				potion_exists = idx
			else
				potion_exists = nil
			end
		end
		if potion_exists then
			potion_idx = potion_exists
		else
			local next_idx = #potion_names+1
			potion_names[next_idx]= potion_name
			potion_idx = next_idx
		end
		local ing_idxs = {}
		for i = 1, 3, 1 do
			local ingredient_image
			if potion_craft["recipe"][i] == "" then
				ingredient_image = "brewing_blank_ingredient.png"
			else
				ingredient_image = minetest.registered_items[potion_craft["recipe"][i]].inventory_image
				if not ingredient_image then
					ingredient_image = "brewing_blank_ingredient.png"
				end
			end
			ing_idxs[i] = tostring(index).."="..ingredient_image
		end
		if index > 1 then
			cells = cells ..","
		end
		local effect_type
		if potion_craft["type"] == "add" then
			effect_type = "+"
		else
			effect_type = "-"
		end
		cells = cells .. potion_idx .. ","..S(uppercase(potion_craft["effect"])) .. ",".. S("lvl").. " ".. effect_type .. potion_craft["level"]..','..index..','..index..','..index
		if index > 1 then
			ing1_idxs = ing1_idxs .. ','
			ing2_idxs = ing2_idxs .. ','
			ing3_idxs = ing3_idxs .. ','
		end
		ing1_idxs = ing1_idxs .. ing_idxs[1]
		ing2_idxs = ing2_idxs .. ing_idxs[2]
		ing3_idxs = ing3_idxs .. ing_idxs[3]
	end
	for idx, value in ipairs(potion_names) do
		if idx > 1 then
			potion_idxs = potion_idxs..","
		end
		potion_idxs = potion_idxs .. tostring(idx).."="..value
	end
	--minetest.chat_send_all(potion_idxs)
	recipe_book_formspec =
		recipe_book_formspec ..
		"tablecolumns[image,"..potion_idxs..";text;text;image,"..ing1_idxs..";image,"..ing2_idxs..";image,"..ing3_idxs.."]"..
		"table[0.375,0.375;7.2,6;table_potions;"..cells..";0]"
    return recipe_book_formspec
end

--
-- Node callback functions
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	return inv:is_empty("water") and inv:is_empty("dst") and inv:is_empty("flask")
end

local function is_valid_water(liquid_to_check)
	local isvalid = false
	for key, value in pairs(brewing.settings.liquid) do
		if value == liquid_to_check then
			isvalid = true
			break
		end
	end
	return isvalid
end

--when an item is put into the inventory
local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	if listname == "water" then
		local water_name= stack:get_name()
		--check if is a valid water liquid
		if is_valid_water(water_name) == true then
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "ignitor" then
		local iswater= stack:get_name()
		if iswater == brewing.settings.ignitor_name then
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "flask" then
		local iswater= stack:get_name()
		if iswater == brewing.settings.flask_name then
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "dst" then
		return 0
	else
		return stack:get_count()
	end
end

--when an item is moved inside the inventory
local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function decrease_stacks(pos, ing_listname, ing_stack, howmuch)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local count = ing_stack:get_count()
	if count > 0 then
		count = count - howmuch
		if count < 0 then
			count = 0
		end
		ing_stack:set_count(count)
	end
	inv:set_stack(ing_listname, 1, ing_stack)
end

local function try_to_make_potion(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local ing1, ing2, ing3, ignitor, water, flask, dst
	local ing1_name, ing2_name, ing3_name, ignitor_name, water_name, flask_name
	local flask_count
	local brewed
	local update = true
	while update do
		update = false
		ing1= inv:get_stack("ing1", 1)
		ing1_name = ing1:get_name()
		ing2=	inv:get_stack("ing2", 1)
		ing2_name = ing2:get_name()
		ing3=	inv:get_stack("ing3", 1)
		ing3_name = ing3:get_name()
		ignitor= inv:get_stack("ignitor", 1)
		ignitor_name = ignitor:get_name()
		water=	inv:get_stack("water", 1)
		water_name = water:get_name()
		flask=	inv:get_stack("flask", 1)
		flask_name = flask:get_name()
		flask_count = flask:get_count()
		dst=	inv:get_stack("dst", 1)

		--The list: {ingredient_list_name, ingredient_stack, ingredient_name, how_much_decrements_when_crafted}
		local ing_list = {{"ing1", ing1, ing1_name, 1}, {"ing2", ing2, ing2_name, 1}, {"ing3", ing3, ing3_name, 1}, {"ignitor", ignitor, ignitor_name, 1}, {"flask", flask, flask_name, brewing.settings.filled_flasks}}

		local is_valid_water= is_valid_water(water_name)

		--minetest.chat_send_player("singleplayer", brewing.settings.ignitor_name)

		if ignitor_name== brewing.settings.ignitor_name and is_valid_water and flask_name== brewing.settings.flask_name and flask_count >= brewing.settings.filled_flasks then
			--brewed, afterbrewed = minetest.get_craft_result({method = "normal", width =3, items = {ingplus1, ingplus2, ingplus3, ingminus1, ingminus2, ingminus3, ignitor, water, flask}})
			brewed = brewing.get_craft_result({ing1_name, ing2_name, ing3_name})
			if brewed ~= nil then
				if inv:room_for_item("dst", brewed) then
					brewed:set_count(brewing.settings.filled_flasks) --How much flask will be filled
					inv:add_item("dst", brewed) --Make the potion/s!!!
					--Decrease stacks of the ingredients
					local ing_stack
					local ing_list_name
					for key, ing in pairs(ing_list) do
						ing_list_name= ing[1]
						ing_stack = ing[2]
						local howmuch = ing[4]
						decrease_stacks(pos, ing_list_name, ing_stack, howmuch)
					end
					--replace the water bucket-->
					inv:set_stack("water", 1, ItemStack("bucket:bucket_empty 1"))
					brewing.make_sound("player", player, "brewing_magic_realization")
					--Message to player
					--minetest.chat_send_player("singleplayer", S("Potion created!)")
				end
			end
		end
		local infotext = ""
		end
	--
	-- Set meta values
	--
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

end

--Register Cauldron Node

minetest.register_node("brewing:magic_cauldron", {
	description = S("Magic Cauldron"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.375, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox1
			{-0.5, -0.3125, -0.5, 0.5, 0.5, -0.375}, -- NodeBox2
			{-0.5, -0.3125, 0.375, 0.5, 0.5, 0.5}, -- NodeBox3
			{-0.5, -0.3125, -0.375, -0.375, 0.5, 0.375}, -- NodeBox4
			{0.375, -0.3125, -0.375, 0.5, 0.5, 0.375}, -- NodeBox5
			{0.375, -0.5, -0.5, 0.5, -0.375, -0.375}, -- NodeBox6
			{0.375, -0.5, 0.375, 0.5, -0.375, 0.5}, -- NodeBox7
			{-0.5, -0.5, -0.5, -0.375, -0.375, -0.375}, -- NodeBox8
			{-0.5, -0.5, 0.375, -0.375, -0.375, 0.5}, -- NodeBox9
			{-0.375, 0.3125, -0.375, 0.375, 0.375, 0.375}, -- NodeBox10
		},
	},
	tiles = {
		"brewing_cauldron_top.png", "brewing_cauldron_side.png",
		"brewing_cauldron_side.png", "brewing_cauldron_side.png",
		"brewing_cauldron_side.png", "brewing_cauldron_side.png"
	},
	use_texture_alpha = true,
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	can_dig = can_dig,
	sounds = default.node_sound_stone_defaults(),
	drop = "brewing:magic_cauldron",

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		local inv = meta:get_inventory()
		inv:set_size('ing1', 1)
		inv:set_size('ing2', 1)
		inv:set_size('ing3', 1)
		inv:set_size('ignitor', 1)
		inv:set_size('water', 1)
		inv:set_size('flask', 1)
		inv:set_size('dst', 1)
	end,

	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "ing1", drops)
		default.get_inventory_drops(pos, "ing2", drops)
		default.get_inventory_drops(pos, "ing3", drops)
		default.get_inventory_drops(pos, "ignitor", drops)
		default.get_inventory_drops(pos, "water", drops)
		default.get_inventory_drops(pos, "flask", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "brewing:magic_cauldron"
		minetest.remove_node(pos)
		return drops
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		try_to_make_potion(pos, player)
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		try_to_make_potion(pos, player)
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,

	on_receive_fields = function(pos, formname, fields, sender)
		local player_name = sender:get_player_name()
		if fields.btn_recipe_book then
			minetest.show_formspec(player_name, "brewing:recipe_book", create_recipe_book_form())
		end
	end,
})



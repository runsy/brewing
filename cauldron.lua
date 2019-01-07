local modpath, S = ...

-- Cauldron Form
local formspec =
	"size[8,9;]"..
	"image[0,0;1,1;brewing_plus_gray.png]"..
	"list[context;ingplus1;1,0;1,1;]"..
	"list[context;ingplus2;2,0;1,1;]"..
	"list[context;ingplus3;3,0;1,1;]"..
	"image[0,1;1,1;brewing_minus_gray.png]"..
	"list[context;ingminus1;1,1;1,1;]"..
	"list[context;ingminus2;2,1;1,1;]"..
	"list[context;ingminus3;3,1;1,1;]"..
	"image[3,2;1,1;brewing_arrow_ing_gray.png]"..
	"image[0,4;1,1;"..brewing.settings.ignitor["image"].."]"..
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

--
-- Node callback functions
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("water") and inv:is_empty("dst") and inv:is_empty("flask")
end

--when an item is put into the inventory
local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	if listname == "water" then
		local water_name= stack:get_name()
		--check if is a valid water liquid
		if brewing.isvalidwater(water_name) == true then
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "ignitor" then
		local iswater= stack:get_name()
		if iswater== brewing.settings.ignitor["name"] then
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "flask" then
		local iswater= stack:get_name()
		if iswater== brewing.settings.flask_name then
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

local function try_to_make_potion(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local ingplus1, ingplus2, ingplus3, ingminus1, ingminus2, ingminus3, ignitor, water, flask, dst
	local ingplus1_name, ingplus2_name, ingplus3_name, ingminus1_name, ingminus2_name, ingminus3_name, ignitor_name, water_name, flask_name
	local flask_count
	local brewed
	local update = true
	while update do
		update = false
		ingplus1=	inv:get_stack("ingplus1", 1)
		ingplus1_name = ingplus1:get_name()
		ingplus2=	inv:get_stack("ingplus2", 1)
		ingplus2_name = ingplus2:get_name()
		ingplus3=	inv:get_stack("ingplus3", 1)
		ingplus3_name = ingplus3:get_name()
		ingminus1=	inv:get_stack("ingminus1", 1)
		ingminus1_name = ingminus1:get_name()
		ingminus2=	inv:get_stack("ingminus2", 1)
		ingminus2_name = ingminus2:get_name()
		ingminus3=	inv:get_stack("ingminus3", 1)
		ingminus3_name = ingminus3:get_name()
		ignitor= inv:get_stack("ignitor", 1)
		ignitor_name = ignitor:get_name()
		water=	inv:get_stack("water", 1)
		water_name = water:get_name()
		flask=	inv:get_stack("flask", 1)
		flask_name = flask:get_name()
		flask_count = flask:get_count()
		dst=	inv:get_stack("dst", 1)

		--The list: {ingredient_list_name, ingredient_stack, ingredient_name, how_much_decrements_when_crafted}
		local ing_list = {{"ingplus1", ingplus1, ingplus1_name, 1}, {"ingplus2", ingplus2, ingplus2_name, 1}, {"ingplus3", ingplus3, ingplus3_name, 1}, {"ingminus1", ingminus1, ingminus1_name, 1},{"ingminus2", ingminus2, ingminus2_name, 1},{"ingminus3", ingminus3, ingminus3_name, 1}, {"ignitor", ignitor, ignitor_name, 1}, {"flask", flask, flask_name, brewing.settings.filled_flasks}}

		local isvalidwater= brewing.isvalidwater(water_name)

		--minetest.chat_send_player("singleplayer", brewing.settings.ignitor_name)

		if ignitor_name== brewing.settings.ignitor["name"] and isvalidwater and flask_name== brewing.settings.flask_name and flask_count >= brewing.settings.filled_flasks then
			--brewed, afterbrewed = minetest.get_craft_result({method = "normal", width =3, items = {ingplus1, ingplus2, ingplus3, ingminus1, ingminus2, ingminus3, ignitor, water, flask}})
			brewed = brewing.get_craft_result{items = {{ingplus1_name, ingplus2_name, ingplus3_name}, {ingminus1_name, ingminus2_name, ingminus3_name}}}
			if brewed ~= nil then
				if inv:room_for_item("dst", brewed) then
					--How much flask will be filled
					brewed:set_count(brewing.settings.filled_flasks)
					--Make the potion/s!!!
					inv:add_item("dst", brewed)
					--Decrease stacks of the ingredients
					local ing_stack
					local ing_list_name
					for key, ing in pairs(ing_list) do
						ing_list_name= ing[1]
						ing_stack = ing[2]
						howmuch = ing[4]
						decrease_stacks(pos, ing_list_name, ing_stack, howmuch)
					end
					--replace the water bucket-->
					inv:set_stack("water", 1, ItemStack("bucket:bucket_empty 1"))
					brewing.magic_sound("to_player", user, "brewing_realization")
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

-- Register Cauldron Node

minetest.register_node("brewing:magic_cauldron", {
	description = S("Magic Cauldron"),
	tiles = {
		"brewing_cauldron_top.png", "brewing_cauldron_bottom.png",
		"brewing_cauldron_side.png", "brewing_cauldron_side.png",
		"brewing_cauldron_side.png", "brewing_cauldron_front.png"
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
		inv:set_size('ingplus1', 1)
		inv:set_size('ingplus2', 1)
		inv:set_size('ingplus3', 1)
		inv:set_size('ingminus1', 1)
		inv:set_size('ingminus2', 1)
		inv:set_size('ingminus3', 1)
		inv:set_size('ignitor', 1)
		inv:set_size('water', 1)
		inv:set_size('flask', 1)
		inv:set_size('dst', 1)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "ingplus1", drops)
		default.get_inventory_drops(pos, "ingplus2", drops)
		default.get_inventory_drops(pos, "ingplus3", drops)
		default.get_inventory_drops(pos, "ingminus1", drops)
		default.get_inventory_drops(pos, "ingminus2", drops)
		default.get_inventory_drops(pos, "ingminus3", drops)
		default.get_inventory_drops(pos, "ignitor", drops)
		default.get_inventory_drops(pos, "water", drops)
		default.get_inventory_drops(pos, "flask", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "brewing:magic_cauldron"
		minetest.remove_node(pos)
		return drops
	end,
	on_metadata_inventory_move = function(pos)
		try_to_make_potion(pos)
	end,
	on_metadata_inventory_put = function(pos)
		try_to_make_potion(pos)
	end,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})
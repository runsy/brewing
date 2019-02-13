-- Cork

local modname = "cork"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

cork = {	
	settings ={
		cork = "cork:cork",
		cork_tool = "cork:little_razor",
		cork_count = 16,		
	},
	get_cork = function(pos, node, player, itemstack, pointed_thing)
		local result = false
		local wielded_item = player:get_wielded_item()
		if wielded_item:get_name() == cork.settings.cork_tool then
			local inv = player:get_inventory()
			if inv:room_for_item("main", ItemStack(brewing.settings.cork)) then
				inv:add_item("main", ItemStack(cork.settings.cork.." "..tostring(cork.settings.cork_count))) --add cork to player's inventory
				minetest.set_node(pos, {name=node.name.."_nobark"}) -- replace the trunk
				cork.cut_sound("to_player", player, "cork_cut")
				result = true
			end
		end
		minetest.item_place_node(itemstack, player, pointed_thing, nil)
		return result
	end,
	cut_sound = function(dest, dest_name, soundfile)
		minetest.sound_play(soundfile, {dest = dest_name, gain = 0.4})
	end,
}

minetest.register_craftitem("cork:cork", {
	description = S("Cork"),
	inventory_image = "cork_cork.png",
})

-- Little Razor
minetest.register_tool("cork:little_razor", {
	description = S("Little Razor"),
	inventory_image = "cork_little_razor_inv.png",
	wield_image = "cork_little_razor.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = '"cork:little_razor" 1',
	recipe = {
		{'', '', ''},
		{'', 'default:steel_ingot', ''},
		{'default:stick', '', ''}
	}
})
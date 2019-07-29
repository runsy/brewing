--Define  the Fairy NPC

local modpath, S = ...

--Form Dialog

local formspec =
	"size[4,5;]"..
	"image[2,0;1,1;brewing_fairy_egg.png]"..
	"button_exit[0,1;3,1;btn_followme;"..S("Follow me").."]"..
	"button_exit[0,2;3,1;btn_standhere;"..S("Stand here").."]"..
	"button_exit[0,3;3,1;btn_ownthing;"..S("Do your own thing").."]"..
	"button_exit[3,1;1,1;btn_inv;"..S("Inv...").."]"..
	"button_exit[1,4;1,1;btn_close;"..S("Close").."]"

local formspec_inv =
	"size[8,8;]"..
	"image[3,0;1,1;brewing_fairy_egg.png]"..
	"label[4,0;"..S("Lily's Inventory").."]"..
	"list[detached:lily_inventory;main;0,1;8,2;]"..
	"list[current_player;main;0,4;8,4;]"

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (formname ~= "brewing:lily_actions") then
		return false
	end
	if brewing.entities.lily == nil then -- if lily dies after her formspec opened
		return true
	end
	brewing.magic_sound("to_player", player, "brewing_select")
	if fields.btn_followme then
		brewing.entities.lily.order = "follow"
	elseif fields.btn_standhere then
		brewing.entities.lily.order = "stand"
	elseif fields.btn_ownthing then
		brewing.entities.lily.order = ""
		brewing.entities.lily.state = "walk"
	elseif fields.btn_inv then
		local player_name = player:get_player_name()
		minetest.show_formspec(player_name, "brewing:lily_inventory", formspec_inv)
	end
	return true
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "brewing:lily_inventory" then
		return false
	end
	if brewing.entities.lily.crystalball_pos ~= nil then
		local inv = minetest.get_inventory({ type="detached", name="lily_inventory" })
		local meta = minetest.get_meta(brewing.entities.lily.crystalball_pos)
		local inv_crystallball = meta:get_inventory()
		local listdata = inv:get_list("main")
		inv_crystallball:set_list("main", listdata)
	end
	return true
end)

--create detached inventory
local function allow_put(pos, listname, index, stack, player)
	return stack:get_count()
end
local inv = minetest.create_detached_inventory("lily_inventory", {
	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		local stack = inv:get_stack(from_list, from_index)
		return allow_put(pos, to_list, to_index, stack, player)
	end,
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	allow_take = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
})

-- Size and width of Lily's Inventory
inv:set_size("main", 16)
inv:set_width("main", 8)

--Lily Identity
--from here to below

--A function to remove Lily from the world, drop her items, remove ownership, etc.
local function remove_lily(lily, pos)
	local lily_owner = lily.owner		
	-- Drop the items from Lily's inventory
	local inv = minetest.get_inventory({ type="detached", name="lily_inventory" })
	if (not inv:is_empty("main")) then
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if stack:get_count() > 0 then
				minetest.item_drop(stack, lily.object, pos)
			end
		end
	end
	-- Delete the metadata of the Crystal Ball
	if lily.crystalball_pos ~= nil then
		local meta = minetest.get_meta(lily.crystalball_pos)
		meta:set_string("owner", "")
		meta:set_string("infotext", "")
	end
	-- Delete Lily's Entity
	brewing.entities.lily.object:remove()
	brewing.entities.lily = nil
	-- Remove Lily's detached inventory
	inv:set_list("main", {})
	--Close formspec (Then no more dialog with Lily)
	minetest.close_formspec(lily_owner, formspec)
end

--In multiplayer mode, remove ownership when lily's owner abandon te game
--this makes lily available for the other players
minetest.register_on_leaveplayer(function(player)
	if not(brewing.entities.lily == nil) and not(minetest.is_singleplayer()) then
		local player_name = player:get_player_name()
		if player_name == brewing.entities.lily.owner then
			local pos = brewing.entities.lily.object:get_pos()
			remove_lily(brewing.entities.lily, pos)
		end
	end
end)

--lily is defined by 'name' & 'definition'

local name= "brewing:fairy_lily"

local definition = {
	id = nil,
	nametag = "Lily",
	type = "npc",
	hp_min = brewing.settings.lily_hp,
	hp_max = brewing.settings.lily_hp,
	walk_velocity = 1,
	run_velocity = 3,
	armor = 100,
	visual = "mesh",
	fly = true,
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	collisionbox = {-0.125, -0.25, -0.125, 0.125, 0.25, 0.125},
	--selectionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	mesh = "brewing_fairy.b3d",
	textures = {"brewing_fairy.png"},
	visual_size = {x = 0.25, y = 0.25},
	owner = "",
	crystalball_pos = {},
	drops = {
		{name = "brewing:lily_wings", chance = 3, min = 1, max = 1,},
	},
	animation = {
		stand_start = 0, stand_end = 80, stand_speed = 25,
		--walk_start = 168, walk_end = 188, walk_speed = 25,
		run_start = 168, run_end = 188,
		fly_start = 221, fly_end = 240,
	},
	on_die = function(self, pos)
		remove_lily(self, pos)
	end,
	after_activate = function(self, staticdata, dtime_s)
		if brewing.entities.lily == nil then
			brewing.entities.lily = self
		else
			self.object:remove()
			self = nil --a rare case that the mob is created thru a crystal ball when still is not naturally spawned
		end		
		if brewing.entities.lily.crystalball_pos ~=  nil then
			local inv = minetest.get_inventory({ type="detached", name="lily_inventory" })
			local meta = minetest.get_meta(brewing.entities.lily.crystalball_pos)
			local inv_crystallball = meta:get_inventory()
			local listdata = inv_crystallball:get_list("main")
			inv:set_list("main", listdata)
		end
	end,
	on_rightclick = function(self, clicker)
		if not(clicker:is_player()) then
			return false
		end
		local player_name = clicker:get_player_name()
		if (self.owner ~= player_name) then
			return
		end
		local wielded_item = clicker:get_wielded_item()
		if wielded_item:get_name() == "brewing:magic_donut" then
			if self.health < self.hp_max then
				self.health = self.health + brewing.settings.donut_eat_hp
				-- Decrease donut
				local inv = clicker:get_inventory()
				local count = wielded_item:get_count()
				count = count - 1
				if count >= 0 then
					wielded_item:set_count(count)
					local wielded_index = clicker:get_wield_index()
					local wielded_list_name = clicker:get_wield_list()
					inv:set_stack(wielded_list_name, wielded_index, wielded_item)
					brewing.magic_sound("to_player", clicker, "brewing_eat")
				end
			else
				brewing.magic_sound("to_player", clicker, "brewing_magic_failure")
			end
		else
			minetest.show_formspec(player_name, "brewing:lily_actions", formspec)
		end
	end,
}

mobs:register_mob(name, definition)

mobs:register_egg("brewing:fairy_lily", "Fairy Lily", "brewing_fairy_egg.png", 0, false)

--Lily's Wings

minetest.register_craftitem("brewing:lily_wings", {
	description = S("Lily's Wings"),
	inventory_image = "brewing_lily_wings.png",
	wield_image = "brewing_lily_wings.png"
})

--Magic Ring
--to call Lily
minetest.register_craftitem("brewing:magic_ring", {
	description = S("Magic Ring"),
	inventory_image = "magic_ring.png",
	wield_image = "magic_ring.png",
	on_use = function (itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		if (brewing.entities.lily ~= nil) and (brewing.entities.lily.owner == user_name) then
			local player_front_pos = brewing.posfrontplayer(user)
			if minetest.get_node(player_front_pos).name == "air" then
				brewing.entities.lily.object:set_pos(player_front_pos)
				brewing.magic_aura(user, user:get_pos(), "player", "default")
				brewing.magic_sound("to_player", user, "brewing_magic_sound")
			else
				brewing.magic_sound("to_player", user, "brewing_magic_failure")
			end
		end
	end,
})

minetest.register_craft({
	type = "shaped",
	output = "brewing:magic_ring",
	recipe = {
		{"", "", ""},
		{"", "brewing:magic_crystal", ""},
		{"", "default:steel_ingot", ""},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "brewing:magic_crystal",
	recipe = "brewing:magic_ring",
	cooktime = 3,
})

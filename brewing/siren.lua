local modpath, S = ...

local formspec_context = {}

mobs:register_mob("brewing:siren", {
	nametag = nil, 
	type = "monster",
	attack_type = "dogfight",
	damage = 8,
	reach = 1,
	hp_min = 25,
	hp_max = 30,
	armor = 200,
	jump = false,
	collisionbox = {-0.35, -0.8, -0.35, 0.35, 0.8, 0.35},
	drawtype = "front",
	visual = "mesh",
	mesh = 'brewing_siren.b3d',
	textures ={
		{"brewing_siren_blue_hair.png"},
		{"brewing_siren_blonde_hair.png"},
		{"brewing_siren_silver_hair.png"},
		{"brewing_siren_red_hair.png"},
	},
	sounds = {
		distance = 10,
		random = "brewing_siren_song",
		war_cry = "brewing_siren_war_cry"
	},
	follow = {"brewing:anemon"},
	visual_size = {x=1, y=1},
	fly = true,
	fly_in = "default:water_source",
	drops = {
		--Very rare
		{name = "brewing:pearl", chance = 20, min = 1, max = 1},
		--Rare
		{name = "brewing:anemon", chance = 5, min = 1, max = 1},
		{name = "brewing:turtle_shell", chance = 5, min = 1, max = 1},
	},
	fall_speed = -1,
	floats = 1,
	view_range = 5,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		walk_speed = 24,	run_speed = 30,
		stand_start = 0, stand_end = 80,
		stand_start = 191, stand_end = 231,				
		walk_start = 81, walk_end = 101,
		walk2_start =165, walk2_end = 190,
		walk3_start = 134, walk3_end = 164,
		walk4_start = 232, walk4_end = 252,
		run_start = 134, run_end = 164,
		punch_start = 102, punch_end = 112,
		punch2_start = 113, punch2_end = 133,
	},
	on_rightclick = function(self, clicker)
		if not(clicker:is_player()) then
			return false
		end
		if self["type"] == "animal" then
			mobs:feed_tame(self, clicker, 5, false, false)
		end
		local wielded_item_name = clicker:get_wielded_item():get_name()
		if (wielded_item_name == "mobs:lasso") or (wielded_item_name == "mobs:net") then		
			if self["type"] == "monster" then
				self["type"] = "animal"
				self["remove_ok"] = false						
			end
			if mobs:capture_mob(self, clicker, 10, 20, 30, true, nil) == nil then			
			end			
		end
	end,
	do_custom = function(self, dtime)
		--Do not stuck in the coastline				
		if self then			
				local pos = self.object:get_pos()
				local node = minetest.get_node_or_nil(pos)
			if node and
					minetest.registered_nodes[node.name] and
					not minetest.registered_nodes[node.name].groups.water then
				local pos = self.object:get_pos()				
				local yaw = self.object:get_yaw() or 0
				-- what is in front and one block below of mob?				
				-- what is mob standing on?
				pos.y = pos.y + self.collisionbox[2]
				-- where is front
				local dir_x = -math.sin(yaw) * (self.collisionbox[4] + 0.5)
				local dir_z = math.cos(yaw) * (self.collisionbox[4] + 0.5)
				local pos_front_below = {
					x = pos.x + dir_x + 0.5,
					y = pos.y - 0.5,
					z = pos.z + dir_z,
				}
				local node = minetest.get_node_or_nil(pos_front_below)
				if node and
						minetest.registered_nodes[node.name] and
						not minetest.registered_nodes[node.name].groups.water then
					local pi = math.pi
					self.object:set_yaw(yaw + 0.5*pi, 8)	
					yaw = self.object:get_yaw() or 0
					dir_x = -math.sin(yaw) * (self.collisionbox[4] + 0.5)
					dir_z = math.cos(yaw) * (self.collisionbox[4] + 0.5)
					pos_front_below = {
						x = pos.x + dir_x + 1,
						y = pos.y - 0.5,
						z = pos.z + dir_z,
					}
					node = minetest.get_node_or_nil(pos_front_below)
					if node and
							minetest.registered_nodes[node.name] and
							minetest.registered_nodes[node.name].groups.water then
						local pos_front = {
							x = pos.x + dir_x + 1,
							y = pos.y,
							z = pos.z + dir_z,
						}			
						self.object:move_to(pos_front, true)
					end
				end
			end
		end
		return true -- Load the default API
	end,
})

mobs:spawn_specific("brewing:siren",
	{"default:water_flowing", "default:water_source"},
	{"default:sand", "default:dirt", "group:seaplants"},
	-1, 18, 30, 60000, 1, -8, 31000)

mobs:register_egg("brewing:siren", "Siren", "brewing_siren_egg.png", 0)

-- Form to change the siren name when captured

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (formname ~= "brewing:rename_siren") then
		return false
	end
	if fields.quit then
		return true -- to remaining functions do not called
	end
	brewing.magic_sound("to_player", player, "brewing_select")
	if (fields.nametag) and (fields.nametag ~= "") then
		local context = formspec_context[player:get_player_name()]
		context.nametag = fields.nametag
	end
	return true
end)
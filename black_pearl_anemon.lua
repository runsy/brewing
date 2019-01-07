local modpath, S = ...

local formspec_context = {}

mobs:register_mob("brewing:bp_anemon", {
	nametag = "", 
	floats = 0,
	type = "monster",
	attack_type = "shoot",
	arrow = "brewing:bp_anemon_arrow",
	shoot_interval = 1,
	damage = 5,
	reach = 7,
	hp_min = 30,
	hp_max = 55,
	armor = 350,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.15, 0.5},
	visual = "sprite",
	drawtype = "front",
	textures ={
		{"brewing_black_pearl_anemon_1.png"},
		{"brewing_black_pearl_anemon_2.png"},
		{"brewing_black_pearl_anemon_3.png"},
	},
	sounds = {
	},
	visual_size = {x=1, y=1},	
	drops = {
		{name = "brewing:black_pearl", chance = 1, min = 1, max = 1},
	},
	fall_speed = -1,
	view_range = 10,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	walk_velocity = 0,
    run_velocity = 0,
    walk_chance = 0,                   
    jump = false,
})

mobs:spawn_specific("brewing:bp_anemon",
	{"default:water_flowing", "default:water_source"},
	{"default:sand", "default:dirt", "group:seaplants"},
	-1, 18, 30, 60000, 1, -18, 31000)

mobs:register_egg("brewing:bp_anemon", S("Black Pearl Anemon"), "brewing_bp_anemon_egg.png", 0)

mobs:register_arrow("brewing:bp_anemon_arrow", {
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},	
	textures = {"brewing_particle_water.png"},
	velocity = 3,
	tail = 1,
	tail_texture = "brewing_particle_water.png",
	tail_size = 0.2,
	glow = 5,
	expire = 0.1,
	hit_player = function(self, player)
		local user = self.object
		brewing.engine.effects.aqua(player, user, "entity")
	end,
	on_activate = function(self, staticdata, dtime_s)
		-- make fireball indestructable
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,
	})

minetest.register_craftitem("brewing:black_pearl", {
	description = S("Black Pearl"),
	inventory_image = "brewing_black_pearl.png",
	groups = {},
})


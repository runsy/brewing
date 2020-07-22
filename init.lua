local modname = minetest.get_current_modname()

local S = minetest.get_translator(modname)

local modpath = minetest.get_modpath(modname)

--global variables
brewing = {}
brewing.settings = {}
brewing.craft_list = {} --for potion crafts
brewing.effects = {} --for the player effects
brewing.players = {} --for the players

assert(loadfile(modpath.. "/settings.lua"))(S, modpath)
assert(loadfile(modpath.. "/api.lua"))(S, modname)
assert(loadfile(modpath.. "/effects.lua"))(S)
assert(loadfile(modpath.. "/potions.lua"))(S)
assert(loadfile(modpath.. "/potion_crafts.lua"))(S)
assert(loadfile(modpath.. "/cauldron.lua"))(S, modname)
assert(loadfile(modpath.. "/nodes.lua"))(S)
assert(loadfile(modpath.. "/player.lua"))(S)
assert(loadfile(modpath.. "/sound.lua"))()
assert(loadfile(modpath.. "/mushroom.lua"))(S)

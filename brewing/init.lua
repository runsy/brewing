local modname = "brewing"

local modpath = minetest.get_modpath(modname)

local S = minetest.get_translator(minetest.get_current_modname())

local mg_name = minetest.get_mapgen_setting("mg_name")
local mod_storage = minetest.get_mod_storage()

-- Some definitions
assert(loadfile(modpath .. "/api.lua"))(modpath, S) --Load the API firstly (brewing table)
assert(loadfile(modpath .. "/engine.lua"))(modpath, S) --Definition of the 'brewing.engine'
--check if mod is in the secure.trusted_mods list separated by comma
--local ismodtrusted = false
--local modtrusted
--for modtrusted in string.gmatch(minetest.setting_get("secure.trusted_mods"), '([^,]+)') do --separate the mod list
	--modtrusted = modtrusted:gsub("%s+", "") --trim the string
	--if modtrusted== "brewing" then
		--ismodtrusted= true
		--break
	--end
--end
assert(loadfile(modpath .. "/settings.lua"))(modpath, S) --Read the 'brewing.conf' file
assert(loadfile(modpath .. "/nodes.lua"))(modpath, S) --Definition of the nodes
if minetest.get_modpath("mobs") ~= nil then
	assert(loadfile(modpath .. "/lily.lua"))(modpath, S) --Definition of the Fairy NPC
	assert(loadfile(modpath .. "/siren.lua"))(modpath, S) --Definition of the Siren NPC
	assert(loadfile(modpath .. "/black_pearl_anemon.lua"))(modpath, S) --Definition of the Siren NPC
end
assert(loadfile(modpath .. "/tools.lua"))(modpath, S) --Definition of the tools
assert(loadfile(modpath .. "/weapons.lua"))(modpath, S) --Definition of the weapons
assert(loadfile(modpath .. "/wands.lua"))(modpath, S) --Definition of the wands
assert(loadfile(modpath .. "/aquatic.lua"))(modpath, S) --Definition of the nodes
assert(loadfile(modpath .. "/potions.lua"))(modpath, S) --Definition of the potions crafting
assert(loadfile(modpath .. "/cauldron.lua"))(modpath, S) --Definition of the cauldron
if minetest.get_modpath("3d_armor") ~= nil then --Armor (optional)
	assert(loadfile(modpath .. "/armor.lua"))(modpath, S)
end
assert(loadfile(modpath .. "/farming.lua"))(modpath, S, mg_name) --Definition of the farming stuff
assert(loadfile(modpath .. "/vessels.lua"))(modpath, S) --Definition of the vessels stuff
assert(loadfile(modpath .. "/herbalism.lua"))(modpath, S, mg_name) --Definition of the herbalism stuff
assert(loadfile(modpath .. "/food.lua"))(modpath, S) --Definition of the food stuff
assert(loadfile(modpath .. "/stairs.lua"))(modpath, S) --Definition of the stairs
assert(loadfile(modpath .. "/crystal_ball.lua"))(modpath, S) --Definition of the crystal ball that invokes Lily
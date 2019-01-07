local modpath, S = ...

local settings = Settings(modpath .. "/brewing.conf")
brewing.settings.bp_anemon_damage= tonumber(settings:get("bp_anemon_damage"))
brewing.settings.cork_count = tonumber(settings:get("cork_count"))
brewing.settings.donut_eat_hp = tonumber(settings:get("donut_eat_hp"))
brewing.settings.filled_flasks = tonumber(settings:get("filled_flasks"))
brewing.settings.freeze_hit_points = tonumber(settings:get("freeze_hit_points"))
brewing.settings.freeze_time = tonumber(settings:get("freeze_time"))
brewing.settings.generate_cortinarius_violaceus  = settings:get_bool("generate_cortinarius_violaceus", true)
brewing.settings.generate_creosote_bush = settings:get_bool("generate_creosote_bush", true)
brewing.settings.generate_fire_flower = settings:get_bool("generate_fire_flower", true)
brewing.settings.generate_gerbera_daisy = settings:get_bool("generate_gerbera_daisy", true)
brewing.settings.generate_lemmontree = settings:get_bool("generate_lemmontree", true)
brewing.settings.generate_lucky_club  = settings:get_bool("generate_lucky_club", true)
brewing.settings.generate_magic_rose = settings:get_bool("generate_magic_rose", true)
brewing.settings.generate_mint = settings:get_bool("generate_mint", true)
brewing.settings.generate_orange_mycena  = settings:get_bool("generate_orange_mycena", true)
brewing.settings.generate_pearl_oyster = settings:get_bool("generate_pearl_oyster", true)
brewing.settings.generate_saffron_crocus = settings:get_bool("generate_saffron_crocus", true)
brewing.settings.generate_sugarcane  = settings:get_bool("generate_sugarcane", true)
brewing.settings.generate_yellow_bell = settings:get_bool("generate_yellow_bell", true)
brewing.settings.generate_madragora = settings:get_bool("mandragora", true)
brewing.settings.ignitor["image"]= settings:get("ignitor_image")
brewing.settings.ignitor["name"]= settings:get("ignitor_name")
brewing.settings.lily_hp = settings:get("lily_hp", true)
brewing.settings.star_blue_amulet_speedup= tonumber(settings:get("star_blue_amulet_speedup"))
-- Mana Mod Settings
if minetest.get_modpath("mana") ~= nil then
	--Add
	brewing.settings.mana_magic_donut = tonumber(settings:get("mana_magic_donut"))
	brewing.settings.mana_fay_cake = tonumber(settings:get("mana_fay_cake"))
	brewing.settings.mana_nymph_salad = tonumber(settings:get("mana_nymph_salad"))
	brewing.settings.mana_siren_soup = tonumber(settings:get("mana_siren_soup"))
	--Subtract
	brewing.settings.mana_magic_wand = tonumber(settings:get("mana_magic_wand"))
	brewing.settings.mana_magic_blue_tear_wand = tonumber(settings:get("mana_magic_blue_tear_wand"))
end
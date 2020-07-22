local modpath, S = ...

-- Effects: antigrav, speed, ouhealth, health, air, ouair

brewing.register_potion_craft({
	effect= "jumping",
	type= "add",
	level= 1,
	recipe = {'flowers:tulip', '', ''}
})

--jumping_add1", recipe = { {'flowers:tulip','brewing:gerbera_oil','brewing:orange_mycena'}, {'','',''} } }
--"brewing:speed_add1", recipe = { {'flowers:dandelion_white','brewing:yellow_bell','flowers:geranium'}, {'','',''} } }
--"brewing:antigravity_add1", recipe = { {'brewing:mandragora','flowers:dandelion_white','brewing:star_anise'}, {'','',''} } }
--"brewing:air_add1", recipe = { {'flowers:rose','brewing:yellow_bell','brewing:gerbera_daisy'}, {'','',''} } }
--"brewing:ouair_add1", recipe = { {'flowers:dandelion_white','brewing:yellow_bell','flowers:tulip'}, {'','',''} } }
--"brewing:health_add1", recipe = { {'flowers:dandelion_white','brewing:saffron','brewing:star_anise'}, {'','',''} } }
--"brewing:ouhealth_add1"

local modpath, S = ...

--Air

brewing.register_potion_craft({
	effect= "ouair",
	type= "add",
	level= 2,
	recipe = {'brewing:cortinarius_violaceus', 'flowers:mushroom_red', 'brewing:gliophorus_viridis'}
})

--Jumping

brewing.register_potion_craft({
	effect= "jumping",
	type= "add",
	level= 1,
	recipe = {'flowers:mushroom_brown', 'flowers:mushroom_red', 'brewing:gliophorus_viridis'}
})

brewing.register_potion_craft({
	effect= "jumping",
	type= "add",
	level= 2,
	recipe = {'brewing:orange_mycena', 'brewing:cortinarius_violaceus', 'brewing:gliophorus_viridis'}
})

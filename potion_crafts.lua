local modpath, S = ...

brewing.register_potion_craft({
	effect= "jumping",
	type= "add",
	level= 2,
	recipe = {'brewing:orange_mycena', 'brewing:cortinarius_violaceus', 'brewing:gliophorus_viridis'}
})

brewing.register_potion_craft({
	effect= "health",
	type= "add",
	level= 2,
	recipe = {'brewing:pluteus_chrysophaeus', 'brewing:leaiana_mycena', 'brewing:green_hygrocybe'}
})

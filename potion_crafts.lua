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

--Health

brewing.register_potion_craft({
	effect= "health",
	type= "add",
	level= 1,
	recipe = {'flowers:mushroom_brown', 'flowers:mushroom_brown', 'flowers:mushroom_brown'}
})

brewing.register_potion_craft({
	effect= "health",
	type= "add",
	level= 2,
	recipe = {'brewing:pluteus_chrysophaeus', 'brewing:leaiana_mycena', 'brewing:green_hygrocybe'}
})

brewing.register_potion_craft({
	effect= "health",
	type= "sub",
	level= -3,
	recipe = {'flowers:mushroom_red', 'flowers:mushroom_red', 'flowers:mushroom_red'}
})

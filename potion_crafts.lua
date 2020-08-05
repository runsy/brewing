--Air

brewing.register_potion_craft({
	effect= "ouair",
	type= "add",
	level= 2,
	recipe = {'brewing:cortinarius_violaceus', 'flowers:mushroom_red', 'brewing:gliophorus_viridis'}
})

--Jump

brewing.register_potion_craft({
	effect= "jump",
	type= "add",
	level= 1,
	recipe = {'flowers:mushroom_brown', 'flowers:mushroom_red', 'brewing:gliophorus_viridis'}
})

brewing.register_potion_craft({
	effect= "jump",
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

--Speed

brewing.register_potion_craft({
	effect= "speed",
	type= "add",
	level= 2,
	recipe = {'brewing:pluteus_chrysophaeus', 'brewing:green_hygrocybe', 'brewing:green_hygrocybe'}
})

--Invisibility

brewing.register_potion_craft({
	effect= "invisibility",
	type= "add",
	level= 2,
	recipe = {'brewing:leaiana_mycena', 'brewing:green_hygrocybe', 'brewing:green_hygrocybe'}
})

--Invisibility

brewing.register_potion_craft({
	effect= "resist_fire",
	description= "Resist Fire",
	type= "add",
	level= 2,
	recipe = {'brewing:leaiana_mycena', 'brewing:cortinarius_violaceus', 'brewing:green_hygrocybe'}
})

# Brewing [brewing]

Create incredible potions for Minetest.

## API

### brewing.register_potion_craft

```
 brewing.register_potion_craft({
	effect= "jumping",
	type= "add",
	level= 1,
	recipe = {'flowers:tulip', '', ''}
})
```

- Effect: It is the effect on the player: "antigrav", "speed", "health", "ouhealth", "air", "ouair".

[ou= only one use]

- Type: "add" (positive) or "sub" (negative)

- Level: Intensity of the effect (1 to 3)

- Recipe: The 3 ingredients to craft the potion.

## Recipe Book

Click on the Recipe Book icon to check the potion crafting.

## Dependencies

- default, flowers

Click on the Recipe Book icon to check the potion crafting.

## Licenses

- Code: GPL v3.0
- Textures: CC BY-SA 4.0
- Sounds: They have different licenses, see the 'sounds/LICENSE.MD' file.

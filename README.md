# Brewing [brewing]

Create incredible potions for Minetest.

**This mod requires Player Physics mod as hard dependency.**


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

- Recipe: The 3 ingredients to craft the potion. The recipe is SHAPED (the order matters).

## Duration Time of the Effects

- For Jump & Speed effects= 60s (lvl1), 30s (lvl2) and 15s (lvl3).
- For Health & Air effects= 15s (lvl1), 3s (lvl2) and 60s (lvl3).
- Note: "One Use Health" and "One Use Air" obviously have no time.

## Recipe Book

Click on the Recipe Book icon to check the potion crafting.

## Dependencies

- default, flowers

Click on the Recipe Book icon to check the potion crafting.

## Licenses

- Code: GPL v3.0
- Textures: CC BY-SA 4.0
- Sounds: They have different licenses, see the 'sounds/LICENSE.MD' file.

local modpath, S = ...

--Magic Block

stairs.register_stair_and_slab(
	"magic_block",
	"brewing:magic_block",
	{cracky = 1, level = 2},
	{"brewing_magic_block.png"},
	"Stair Magic Block",
	"Slab Magic Block",
	default.node_sound_glass_defaults()
)

--Lemmontree


if minetest.get_modpath("tree_stairs") ~= nil then

	tree_stairs.register_stair(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"brewing_lemmontree_trunk.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front.png"},
		S("Lemmon Tree Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_slab(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk.png",},
		S("Lemmon Tree Slab"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_inner(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"ts_lemmontree_front_right.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front_right.png^[transformFX"},
		S("Lemmon Tree Inner Stair"),
		default.node_sound_wood_defaults(),
		false
	)

	tree_stairs.register_stair_outer(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{cracky = 3},
		{"brewing_lemmontree_trunk_top.png", "brewing_lemmontree_trunk_top.png",
		"ts_lemmontree_front.png", "brewing_lemmontree_trunk.png",
		"brewing_lemmontree_trunk.png", "ts_lemmontree_front.png"},
		S("Lemmon Tree Outer Stair"),
		default.node_sound_wood_defaults(),
		false
	)

else

	stairs.register_stair_and_slab(
		"brewing_lemmontree",
		"brewing:lemmontree",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"brewing_lemmontree_wood.png"},
		"Lemmon Tree Stair",
		"Lemmon Tree Slab",
		default.node_sound_wood_defaults()
	)

end
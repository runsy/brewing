local modpath, S = ...

--Magic Block

stairs.register_stair_and_slab(
	"magic_block",
	"brewing:magic_block",
	{cracky = 1, level = 2},
	{"brewing_magic_block.png"},
	S("Stair Magic Block"),
	S("Slab Magic Block"),
	default.node_sound_glass_defaults()
)
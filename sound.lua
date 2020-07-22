function brewing.make_sound(dest_type, dest, soundfile, max_hear_distance)
	if dest_type == "object" then
		minetest.sound_play(soundfile, {object = dest, gain = 0.5, max_hear_distance = max_hear_distance or 10,})
	 elseif dest_type == "player" then
		local player_name = dest:get_player_name()
		minetest.sound_play(soundfile, {to_player = player_name, gain = 0.5, max_hear_distance = max_hear_distance or 10,})
	 elseif dest_type == "pos" then
		minetest.sound_play(soundfile, {pos = dest, gain = 0.5, max_hear_distance = max_hear_distance or 10,})
	end
end

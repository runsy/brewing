minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if reason.type == "node_damage" then
		local player_name = player:get_player_name()
		local player_pos = player:get_pos()
		local node = minetest.get_node_or_nil(player_pos)
		if node.name == "fire:permanent_flame" or node.name == "default:lava_source"
			or node.name == "default:lava_flowing" then
				if brewing.players[player_name] and brewing.players[player_name]["resist_fire"] then
					return 0 --no damage
				end
		end
	end
	return hp_change
end, true)

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	brewing.players[player_name] = {}
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	brewing.players[player_name] = nil
end)

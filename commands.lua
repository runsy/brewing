minetest.register_chatcommand("effect", {
	params = "none",
	description = "get effect info",
	func = function(name, param)
		minetest.chat_send_player(name, "effects:")
		local potions_e = brewing.players[name]
		if potions_e~=nil then
			for potion_name, val in pairs(potions_e) do
				minetest.chat_send_player(name, potion_name .. "=" .. val)
			end
		end
	end,
})

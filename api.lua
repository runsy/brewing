local S, modname = ...

-- Function to register the potions
brewing.register_potion = function(sname, name, fname, time, def)
	local tps = {"add", "sub"}
	for t=1, #tps do
		for i=1, #def.types do
			local sdata = def.types[i]
			local tps_sign
			if tps[t] == "add" then
				tps_sign= "+"
			else
				tps_sign= "-"
			end
			local item_def = {
				description = S("@1 Potion", name) .. " ("..S("lvl")..":".." "..tps_sign..sdata.type..")",
				inventory_image = "potions_bottle.png^potions_"..(def.texture or sname)..".png^potions_"..tps[t]..sdata.type..".png",
				drawtype = "plantlike",
				paramtype = "light",
				walkable = false,
				groups = {dig_immediate=3,attached_node=1},
				--sounds = default.node_sound_glass_defaults(),
			}
			item_def.tiles = {item_def.inventory_image}
			local flags = {
				inv = false,
				type = tps[t],
			}
			if t == 2 then
				flags.inv = true
			end
			for name, val in pairs(brewing.effects[def.effect](sname, name, fname, time, sdata, flags)) do
				item_def[name] = val
			end
			for name, val in pairs(sdata.set) do
				item_def[name] = val
			end
			for name, val in pairs(sdata.effects) do
				item_def.potions[name] = val
			end
			minetest.register_node(fname.."_"..tps[t]..sdata.type, item_def)
			--potions.register_liquid(i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use)
			if minetest.get_modpath("throwing")~=nil then
				brewing.register_arrow(fname.."_"..tps[t]..sdata.type, i..tps[t]..sname, name.." ("..tps[t].." "..i..")", item_def.on_use,
						item_def.description, item_def.inventory_image)
			end
		end
	end
end

-- Function to register the potion crafts

brewing.register_potion_craft = function(def)
	brewing.craft_list[#brewing.craft_list+1] = {["effect"] = def.effect, ["type"] = def.type, ["level"] = def.level, ["recipe"] = def.recipe}
end

brewing.get_craft_result = function(ingredients)
	--recipes are 2x3
	local output
	local match
	--To get the output of the first potion: minetest.chat_send_player("singleplayer", brewing.craftlist[1][1])
	--To get the first ingredient of the first potion: minetest.chat_send_player("singleplayer", brewing.craftlist[1][2][1][1])
	--for key, potion_craft in pairs(brewing.craftlist) do
	for index, potion_craft in ipairs(brewing.craft_list) do
		--To get the output of the potion: minetest.chat_send_player("singleplayer", potion_craft[1])
		--To get the first ingredient of the 1st row of the potion: minetest.chat_send_player("singleplayer", potion_craft[2][1][1])
		--To get the first ingredient of the 2nd row of the potion: minetest.chat_send_player("singleplayer", potion_craft[2][2][1])
		--To get the second ingredient of the 2nd row of the potion: minetest.chat_send_player("singleplayer", potion_craft[2][2][2])
		--check recipe concordance
		--firstly in the 2 rows
		for i= 1, 3, 1 do
			match = false
			for j = 1, 3, 1 do
				--minetest.chat_send_player("singleplayer", "item="..potion_craft["recipe"][i])
				--minetest.chat_send_player("singleplayer", "item2=".. ingredients[j])
				if (potion_craft["recipe"][i] == ingredients[j]) or (potion_craft["recipe"][i] == '') then
					match = true
					break
				end
			end
			if not match then --if an ingredient does not match
				break
			end
		end
		if match then --if coincidence with a potion_craft
			output = modname ..":" .. potion_craft["effect"] .. "_".. potion_craft["type"] .. potion_craft["level"]
			break
		end
	end
	local item
	if match == true then
		item = ItemStack(output)
		--minetest.chat_send_player("singleplayer", "match")
	else
		item = nil
		--minetest.chat_send_player("singleplayer", "unmatched")
	end
	return item
end

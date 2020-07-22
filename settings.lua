local S, modpath = ...

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	inputstr = inputstr:gsub("%s+", "")
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

local settings = Settings(modpath .. "/brewing.conf")

brewing.settings.filled_flasks = tonumber(settings:get("filled_flasks"))
brewing.settings.ignitor_image= settings:get("ignitor_image")
brewing.settings.ignitor_name= settings:get("ignitor_name")
brewing.settings.flask_name= settings:get("flask_name")
brewing.settings.liquid = split(settings:get("liquid"), ',')


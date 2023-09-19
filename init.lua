local navbar = {}

local function hud_add(player)
	local name = player:get_player_name()
	navbar[name] = player:hud_add({
		hud_elem_type = "compass",
		position = { x = 0.5, y = 0 },
		size = { x = -25, y = 14 },
		scale = { x = 1, y = 1 },
		text = "navbar_navbar.png",
		alignment = { x = 0, y = 1 },
		offset = { x = 0, y = 0 },
		direction = 2,
		name = "navbar",
	})
end

minetest.register_on_joinplayer(function(player)
	if player:get_meta():get("navbar") ~= nil then
		player:get_meta():set_string("navbar", "visible")
	end
	hud_add(player)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player:hud_remove(navbar[name])
end)

minetest.register_chatcommand("navbar", {
	privs = {},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local setting = player:get_meta():get("navbar")
		if setting == "visible" then
			setting = "hidden"
			player:get_meta():set_string("navbar", setting)
			player:hud_remove(navbar[name])
		else
			setting = "visible"
			player:get_meta():set_string("navbar", setting)
			hud_add(player)
		end
		return true, "Navigation bar is now " .. setting .. "."
	end,
})

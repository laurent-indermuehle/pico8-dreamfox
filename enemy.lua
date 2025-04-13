function new_enemy(x, y)
	local sprite=2

	local enemy = {
		x = x,
		y = y,
		draw=function(_ENV)
			spr(sprite, x, y)
		end,
	}

	return enemy
end

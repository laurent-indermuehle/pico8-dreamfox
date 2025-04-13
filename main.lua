function _init()
	log("game initialized")

	--config
	w=128
	h=128
	enemies_count=5

	enemies={}
	for _=1, enemies_count do
		enemy = new_enemy(
			rnd(127),
			rnd(127)
		)

		add(enemies, enemy)
	end
end

function _update60()
	move(player)
end

function _draw()
	cls()
	player:draw()
	for enemy in all(enemies) do
		enemy:draw()
	end
end

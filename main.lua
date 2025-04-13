function _init()
	log("game initialized")

	--config
	enemies_count=3

	enemies={}
	for i=1,enemies_count do
		enemy = new_enemy(
			rnd(127),
			rnd(127)
		)

		add(enemies, enemy)
	end
end

function _update60()
	player:update()
end

function _draw()
	cls()
	player:draw()
	for enemy in all(enemies) do
		enemy:draw()
	end
end

function _init()
	log("game initialized")

	--config
	w = 128
	h = 128
	enemies_count = 5
	enemy_min_before_asleep = 300
	enemy_max_before_asleep = 6000

	enemies = {}
	for _ = 1, enemies_count do
		enemy = new_enemy()

		add(enemies, enemy)
	end
end

function _update60()
	move(player)

	for enemy in all(enemies) do
		enemy.next_asleep -= 1
		if enemy.next_asleep <= 0 then
			sleep(enemy)
		end
	end
end

function _draw()
	cls()
	player:draw()
	for enemy in all(enemies) do
		enemy:draw()
	end
end

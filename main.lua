function _init()
	log("game initialized")

	--config
	w = 128
	h = 128
	enemies_count = 5
	enemy_min_before_asleep = 100
	enemy_max_before_asleep = 2000
	drop_food_min_interv = 180
	foods={}

	enemies = {}
	for _ = 1, enemies_count do
		enemy = new_enemy()

		add(enemies, enemy)
	end
end

function _update60()

	player:update()

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

	for food in all(foods) do
		--      spr,      x,       y,    width,  height,  flip x,  flip y
		spr(food[1], food[2], food[3], food[4], food[5], food[6], food[7])
	end
end

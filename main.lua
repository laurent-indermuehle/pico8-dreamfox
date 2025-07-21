function _init()
	log("game initialized")

	-- config
	w = 128
	h = 128
	enemies_count = 16
	enemy_min_before_asleep = 100
	enemy_max_before_asleep = 1000
	drop_food_min_interv = 60
	foods = {}
	day = {
		name = "day",
		duration = 1000,
		color_ground = 3
	}
	night = {
		name = "night",
		duration = 800,
		color_ground = 1
	}


	-- data containers
	current_state = day
	time_spent_current_state = 0
	enemies = {}
	for _ = 1, enemies_count do
		enemy = new_enemy()

		add(enemies, enemy)
	end
end

function _update60()

	time_spent_current_state += 1
	timeline = flr(128 * (time_spent_current_state / current_state.duration))

	if time_spent_current_state > current_state.duration then
		time_spent_current_state = 0
		timeline = 0

		if current_state.name == "day" then
			current_state = night
		else
			current_state = day
		end
	end

	player:update()

	for enemy in all(enemies) do
		enemy:update()
	end
end

function _draw()

	-- Set transparency
	palt(0, false)
	palt(2, true)
	cls(current_state.color_ground)

	for food in all(foods) do
		--      spr,      x,       y,    width,  height,  flip x,  flip y
		spr(food[1], food[2], food[3], food[4], food[5], food[6], food[7])
	end

	for enemy in all(enemies) do
		enemy:draw()
	end

	player:draw()

	if current_state.name == "day" then
		rectfill(0, 5, 128 , 0, 1)
		rectfill(0, 5, timeline, 0, 2)
		print("Wake up! ", 4)
	else
		rectfill(0, 5, 128 , 0, 3)
		rectfill(0, 5, timeline, 0, 2)
		print("Sleep! ", 4)
	end

end

function _init()
	log("game initialized")

	-- config
	timeline_height = 6
	w = 128
	h = 128
	enemies_count = 16
	enemy_min_before_asleep = 100
	enemy_max_before_asleep = 1000
	action_min_interv = 1
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
	score = 0
	particules = {}
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
		particules = {}

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

	for part in all(particules) do
		spr(part.sprite, part.x, part.y, 1, 1)
		part.x += part.dir_x
		part.y += part.dir_y

		part.duration += 1
		if part.duration > part.max_duration then
			del(particules, part)
		end
	end

	for enemy in all(enemies) do
		enemy:draw()
	end

	player:draw()

	if current_state.name == "day" then
		rectfill(0, timeline_height, timeline, 0, 1)
		print("Wake up! ", 1, 1, 4)
	else
		rectfill(0, timeline_height, timeline, 0, 3)
		print("Sleep! ", 1, 1, 4)
	end

	print(score, 120, 1, 4)

end

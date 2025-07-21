function new_enemy()


  local enemy = {
    size = 8,
    x = rnd({8,120}),
    y = rnd({13,120}),
    sprite = 16,
    animations = {
      walk = {
        sprites = { 16, 17, 18, 19 },
        tick = 0,
        frame = 1,
        step = 12,
      },
      wake_up = {
        sprites = { 21, 22 },
        tick = 0,
        frame = 1,
        step = 4,
      },
    },
    flip_x = false,
    move_count = 0,
    speed = rnd(7),
    direction = flr(rnd(4)),
    dir_change_timer = 0,
    -- Change direction every 15-45 frames
    dir_change_delay = flr(rnd(30)) + 15,
    next_asleep = next_time_asleep(),
    wake_up = 0,
    colli_word = true,
    draw = function(_ENV)
      spr(sprite, x, y, 1, 1, flip_x)
    end,

    update = function(self)
      self.next_asleep -= 1
      if self.next_asleep <= 0 then
        sleep(self)
      else
        self.dir_change_timer += 1

        -- Check if it's time to change direction
        if self.dir_change_timer >= self.dir_change_delay then
          self.speed = rnd(7)
          self.direction = flr(rnd(4))
          self.dir_change_timer = 0
          self.dir_change_delay = flr(rnd(30)) + 15
        end

        -- Apply the current direction's movement
        if self.direction == 0 then
          move_left(self)
        elseif self.direction == 1 then
          move_right(self)
        elseif self.direction == 2 then
          move_up(self)
        elseif self.direction == 3 then
          move_down(self)
        end

        if self.wake_up > 0 then
          self.wake_up -= 1
          animate(self.animations.wake_up)
          self.sprite = self.animations.wake_up.sprites[self.animations.wake_up.frame]
          return  -- skip walking animation
        end

        if self.speed > 0 then
          animate(self.animations.walk)
          self.sprite = self.animations.walk.sprites[self.animations.walk.frame]
        end
      end
    end,

  }

  return enemy
end

function sleep(enemy)
  enemy.sprite = 20

  if check_collision(enemy) then
    enemy.next_asleep = next_time_asleep()
    enemy.wake_up = 60
    sfx(0)
  end
end

function next_time_asleep()
  local mx = enemy_max_before_asleep - enemy_min_before_asleep
  return enemy_min_before_asleep + rnd(mx)
end

function check_collision(enemy)
  -- Enemy's sprite boundaries (assuming 8x8 sprites)
  local e_left = enemy.x
  local e_right = enemy.x + 7
  local e_top = enemy.y
  local e_bottom = enemy.y + 7

  -- Player's four corners
  local corners = {
    {player.x, player.y},         -- Top-left
    {player.x + 7, player.y},     -- Top-right
    {player.x, player.y + 7},     -- Bottom-left
    {player.x + 7, player.y + 7}  -- Bottom-right
  }

  -- Check if any player corner is inside the enemy sprite
  for i=1,4 do
    local corner_x = corners[i][1]
    local corner_y = corners[i][2]

    if corner_x >= e_left and corner_x <= e_right and
       corner_y >= e_top and corner_y <= e_bottom then
      return true
    end
  end

  return false
end

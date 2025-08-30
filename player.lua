player={
  x = 30,
  y = 30,
  last_dir_x = 1,
  last_dir_y = 0,
  sprite = 32,
  size = 8,
  animations = {
    walk = {
      sprites = { 32, 33, 34, 35 },
      tick = 0,
      frame = 1,
      step = 8,
    },
  },
  flip_x = false,
  speed = 0.5,
  colli = true,
  colli_word = true,
  last_action = 0,
  move_count = 0,

  update=function(self)
    self.last_action += 1

    local dx, dy = get_input_direction()
    self.x += dx * self.speed
    self.y += dy * self.speed
    
    if dx > 0 then
      self.flip_x = false
    elseif dx < 0 then
      self.flip_x = true
    end

    if dx != 0 or dy != 0 then
      animate(self.animations.walk)
      -- update last known direction if we're moving
      self.last_dir_x = dx
      self.last_dir_y = dy
    end

    self.sprite = self.animations.walk.sprites[self.animations.walk.frame]

    if self.last_action < action_min_interv then
      return
    end

    -- log("Food ready")

    -- button X
    if (btn(5)) then
      log("X pressed")
      -- day
      if current_state.name == "day" then
        self:drop_food()
      else
        self:drop_food()
        -- sfx(1)
      end
      self.last_action = 0
    end
  end,

  draw=function(self)
    local sprite_cells = flr(self.size / 8)
    spr(self.sprite, self.x, self.y, sprite_cells, sprite_cells, self.flip_x)
  end,

  drop_food=function(self)

    food={
      sprite = 4,
      x = self.x,
      y = self.y,
      duration = 0,
      max_duration = 30,
      dir_x = self.last_dir_x,
      dir_y = self.last_dir_y
    }

    add(particules, food)
  end,
}

function get_input_direction()
  local left = btn(0)
  local right = btn(1)
  local up = btn(2)
  local down = btn(3)

  -- cancel out opposing directions
  if left and right then left, right = false, false end
  if up and down then up, down = false, false end

  -- calculate raw direction
  local dx, dy = 0, 0
  if right then dx = 1 end
  if left then dx = -1 end
  if up then dy = -1 end
  if down then dy = 1 end

  -- fix diagonal speed issue by scaling diagonal movement
  if dx != 0 and dy != 0 then
    -- diagonal movement: scale by ~0.707 (approx 181/256)
    dx = dx * 181 / 256
    dy = dy * 181 / 256
  end

  return dx, dy
end
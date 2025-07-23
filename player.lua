player={
  x = 30,
  y = 30,
  last_dir = "upright",
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
  speed = 10,
  colli = true,
  colli_word = true,
  last_action = 0,
  move_count = 0,

  update=function(self)
    self.last_action += 1

    if btn(0) then
      animate(self.animations.walk)
      move(self, -1, 0)
      self.last_dir = "left"
    end

    if btn(1) then
      animate(self.animations.walk)
      move(self, 1, 0)
      self.last_dir = "right"
    end

    if btn(2) then
      animate(self.animations.walk)
      if btn(0) then
        move(self, -1, -1)
        self.last_dir = "upleft"
      elseif btn(1) then
        move(self, 1, -1)
        self.last_dir = "upright"
      else
        move(self, 0, -1)
        self.last_dir = "up"
      end
    end

    if btn(3) then
      animate(self.animations.walk)
      if btn(0) then
        move(self, -1, 1)
        self.last_dir = "downleft"
      elseif btn(1) then
        move(self, 1, 1)
        self.last_dir = "downright"
      else
        move(self, 0, 1)
        self.last_dir = "down"
      end
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
      direction = self.last_dir
    }

    add(particules, food)
  end,
}

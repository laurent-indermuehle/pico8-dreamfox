player={
  x = 0,
  y = 0,
  sprite = 0,
  animations = {
    walk = {
      sprites = { 0, 1 },
      tick = 0,
      frame = 0,
      step = 4,
    },
  },
  flip_x = false,
  speed = 10,
  colli = true,
  colli_word = true,
  last_drop_food = 0,
  move_count = 0,

  update=function(self)
    self.last_drop_food += 1

    if (btn(0)) then
      animate(self.animations.walk)
      move_left(self)
    end

    if (btn(1)) then
      animate(self.animations.walk)
      move_right(self)
    end

    if (btn(2)) then
      animate(self.animations.walk)
      move_up(self)
    end

    if (btn(3)) then
      animate(self.animations.walk)
      move_down(self)
    end

    self.sprite = self.animations.walk.sprites[self.animations.walk.frame]

    if self.last_drop_food < drop_food_min_interv then
      return
    end

    -- log("Food ready")

    -- button X
    if (btn(5)) then
      log("X pressed")
      self:drop_food()
      self.last_drop_food = 0
    end
  end,

  draw=function(self)
    spr(self.sprite, self.x, self.y, 1, 1, self.flip_x)
  end,

  drop_food=function(self)
    food={
      4,          -- sprite number
      self.x,     -- x position
      self.y,     -- y position
      1,          -- width
      1,          -- height
      rnd({true, false}),  -- flip x
      rnd({true, false})   -- flip y
    }

    add(foods, food)
  end,
}

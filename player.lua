player={
  x = 0,
  y = 0,
  sprie = 0,
  sprite_1 = 0,
  sprite_2 = 1,
  sprite_threshold = 10,
  flip_x = false,
  speed = 10,
  colli = true,
  colli_word = true,
  last_drop_food = 0,
  move_count = 0,

  update=function(self)
    self.last_drop_food += 1

    if (btn(0)) then
      self.move_count += 1
      move_left(self)
    end

    if (btn(1)) then
      self.move_count += 1
      move_right(self)
    end

    if (btn(2)) then
      self.move_count += 1
      move_up(self)
    end

    if (btn(3)) then
      self.move_count += 1
      move_down(self)
    end

    if self.move_count > self.sprite_threshold then
      self.move_count = 0
      if self.sprite == self.sprite_1 then
        self.sprite = self.sprite_2
      else
        self.sprite = self.sprite_1
      end
    end

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

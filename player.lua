player={
  x=0,
  y=0,
  sprit=0,
  flipx=false,
  flipy=false,
  colli=true,
  colliword=true,
  last_drop_food=0,

  update=function(self)
    self.last_drop_food+=1

    move(self)

    if self.last_drop_food < drop_food_min_interv then
      return
    end

    log("Food ready")

    -- button X
    if (btn(5)) then
      log("X pressed")
      self:drop_food()
      self.last_drop_food = 0
    end
  end,

  draw=function(self)
    spr(self.sprit, self.x, self.y)
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

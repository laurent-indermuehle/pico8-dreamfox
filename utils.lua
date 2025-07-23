function log(text)
	printh(text, "dreamfox/log", false)
end

function move(o, x, y, speed)
  local last_x = o.x
  local last_y = o.y
  if x > 0 then
    o.x += (0.1 * o.speed) + x
  elseif x < 0 then
    o.x -= (0.1 * o.speed) - x
  end
  if y > 0 then
    o.y += (0.1 * o.speed) + y
  elseif y < 0 then
    o.y -= (0.1 * o.speed) - y
  end
  o.flip_x = (x < 0)
  if collision(o) then
    o.x = last_x
    o.y = last_y
  end
end

function move_left(o, speed)
  local last_x = o.x
  o.x -= 0.1 * o.speed
  o.flip_x = true
  if collision(o) then
    o.x = last_x
  end
end

function move_right(o, speed)
	local last_x = o.x
  o.x += 0.1 * o.speed
  o.flip_x = false
  if collision(o) then
    o.x = last_x
  end
end

function move_up(o, speed)
	local last_y = o.y
  o.y -= 0.1 * o.speed
  if collision(o) then
    o.y = last_y
  end
end

function move_down(o, speed)
  local last_y = o.y
  o.y += 0.1 * o.speed
  if collision(o) then
    o.y = last_y
  end
end

function collision(o)

	local colli = false
	local colli_world = false

  if (o.colli) then
	  local x1=o.x/8
 	  local y1=o.y/8
    local x2=(o.x+7)/8
    local y2=(o.y+7)/8

    local a=fget(mget(x1,y1),0)
    local b=fget(mget(x1,y2),0)
    local c=fget(mget(x2,y2),0)
    local d=fget(mget(x2,y1),0)

  		colli = a or b or c or d
  end

  -- collision with world
  if (o.colli_word) then
    colli_word=(
      o.x<0 or
      o.x+o.size-1>w or
      o.y<=timeline_height+1 or
      o.y+o.size-1>h
    )
  end

  return colli or colli_word
end

-- https://mboffin.itch.io/pico8-simple-animation
function animate(o)
  o.tick = (o.tick + 1) % o.step
  if (o.tick == 0) then
    o.frame = o.frame % #o.sprites + 1
  end
end

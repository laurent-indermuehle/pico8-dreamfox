function log(text)
	printh(text, "office/log", false)
end

function move(o)

	local lastx = o.x
	local lasty = o.y

  -- up
  if (btn(2)) then
    o.y-=1
    o.flipy = false
    o.sprit = 1
    if collision(o) then
      o.y = lasty
    end
  end

  -- down
  if (btn(3)) then
    o.y+=1
    o.flipy = true
    o.sprit = 1
    if collision(o) then
      o.y = lasty
    end
  end

  -- left
  if (btn(0)) then
    o.x-=1
    o.flipx = true
    o.flipy = false
    o.sprit = 0
    if collision(o) then
      o.x = lastx
    end
  end

  -- right
  if (btn(1)) then
    o.x+=1
    o.flipx = false
    o.flipy = false
    o.sprit = 0
    if collision(o) then
      o.x = lastx
    end
  end
end


function collision(o)

	local colli = false
	local colliworld = false

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
  if (o.colliword) then
    colliword=(
      o.x<0 or
      o.x+8>w or
      o.y<0 or
      o.y+8>h
    )
  end
  
  return colli or colliword
end
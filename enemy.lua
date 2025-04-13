function new_enemy()


  local enemy = {
    x = rnd(127),
    y = rnd(127),
    sprite = 2,
    next_asleep = next_time_asleep(),
    draw = function(_ENV)
      spr(sprite, x, y)
    end,
  }

  return enemy
end

function sleep(enemy)
  enemy.sprite = 3
  
  if check_collision(enemy) then
    enemy.sprite = 2  -- Wake up
    enemy.next_asleep = next_time_asleep()
  end
end

function next_time_asleep()
  return enemy_min_before_asleep + rnd(enemy_max_before_asleep)
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

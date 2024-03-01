local wall = {}
local enemy = {}
local player = {}

local SPEED = 3
local JUMP = 7
local GRAVITY = 0.2
local FASTFALL = 10
local SLOWFALL = 5
local SMALLBOUNCE = 9
local BIGBOUNCE = 9

function player.load(w, e)
  player.x, player.y = 32, 288
  player.draw_x, player.draw_y = 32, 288
  player.hspeed = 0
  player.vspeed = 0
  player.color = { .5, 1, .5 }
  player.jump = 0
  player.fall = FASTFALL
  player.inAir = false
  
  -- player needs access to wall and enemy functions
  wall, enemy = w, e
end

function player.update()
  if player.y > 384 then
    love.timer.sleep(.5)
    return false
  end
  
  if player.x > 512 then
    love.timer.sleep(.5)
    setCurrentLevel(getCurrentLevel() + 1)
    return true
  end
  
  -- Check for keyboard input
  if kb.left() then
    player.hspeed = -SPEED
  elseif kb.right() then
    player.hspeed = SPEED 
  else
    player.hspeed = 0
  end
  
  -- check if jump key pressed or released, gravity
  player.inAir = wall.checkCollisionFloor(player.x,player.y+1)
  
  if player.inAir then
    if kb.jumpPressed() then
      player.vspeed = -JUMP
    end
  else  
    player.fall = SLOWFALL
    if not kb.jumpHeld() then 
      if player.vspeed < -GRAVITY then
        player.vspeed = player.vspeed + 0.5
      end
      player.fall = FASTFALL
      player.vspeed = player.vspeed + (GRAVITY / 2)
    end
    player.vspeed = player.vspeed + GRAVITY
    if player.vspeed > player.fall then
      player.vspeed = player.fall
    end
  end
  
  if enemy.spring.checkCollision(player.x,player.y) then
    if kb.jumpHeld() then
      player.vspeed = -BIGBOUNCE
    else
      player.vspeed = -SMALLBOUNCE
    end
  end
  
  if enemy.spike.checkCollision(player.x,player.y) then
    love.timer.sleep(.5)
    return false
  end
  
  -- update position, check for collision
  local new_x = player.x + player.hspeed
  local new_y = player.y + player.vspeed
  local old_x = player.x 
  local old_y = player.y
  
  local collide_x = wall.checkCollisionWalls(new_x,player.y)
  local collide_y = wall.checkCollisionFloor(player.x,new_y) or
    wall.checkCollisionCeil(player.x,new_y)
  
  if not collide_x then
    player.x = new_x
  else
    player.x = round(player.x/16) * 16
  end
  if not collide_y then
    player.y = new_y
  else
    player.vspeed = 0
    player.vaccel = 0
    player.y = round(player.y/16) * 16 
  end
  
  player.draw_x = round(player.x)
  player.draw_y = round(player.y)
  
  return true
end

function player.draw()
  if player.x and player.y then
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill",player.draw_x,player.draw_y,32,32)
    love.graphics.setColor(1,1,1)
  end
end

function player.die()
  player.x, player.y = 32, 288 
  player.hspeed = 0
  player.vspeed = 0
  
end

return player
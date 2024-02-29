local wall = {}
local enemy = {}
local player = {}

local SPEED = 2
local JUMP = 6
local GRAVITY = 0.2
local MAXFALL = 8

player.x, player.y = 100, 100
player.draw_x, player.draw_y = 100, 100
player.hspeed = 0
player.vspeed = 0
player.color = { .5, 1, .5 }
player.vaccel = 0

function player.load(w, e)
  -- player needs access to wall and enemy functions
  wall, enemy = w, e
end

function player.update()
  -- Check for keyboard input
  if love.keyboard.isDown("left") then
    player.hspeed = -SPEED
  elseif love.keyboard.isDown("right") then
    player.hspeed = SPEED 
  else
    player.hspeed = 0
  end
  
  if wall.checkCollisionFloor(player.x,player.y+1) then
    if love.keyboard.isDown("up") then
      player.vspeed = -JUMP
    end
  else
    player.vspeed = player.vspeed + GRAVITY
    if player.vspeed > MAXFALL then
      player.vspeed = MAXFALL
    end
  end

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
end

function player.draw()
  if player.x and player.y then
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill",player.draw_x,player.draw_y,32,32)
    love.graphics.setColor(1,1,1)
  end
end

return player
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
  player.x, player.y, player.width, player.height = 32, 288, 32, 32
  player.draw_x, player.draw_y = 32, 288
  player.hspeed = 0
  player.vspeed = 0
  player.color = { .5, 1, .5 }
  player.jump = 0
  player.fall = FASTFALL
  player.inAir = false
  player.sprite = love.graphics.newImage("assets/spr_lilly.png")
  player.frames = {}
  player.jumpRelease = false
  player.currentFrame = 1
  player.spinFrame = 1
  player.vertState = 0 -- -1 = jump, 0 = ground, 1 = fall
  player.horState = 1 -- -1 = left, 1 = right
  player.tick = 0
  
  table.insert(player.frames, love.graphics.newQuad(0, 0, 32, 32, 96, 32))
  table.insert(player.frames, love.graphics.newQuad(32, 0, 32, 32, 96, 32))
  table.insert(player.frames, love.graphics.newQuad(0, 0, 32, 32, 96, 32))
  table.insert(player.frames, love.graphics.newQuad(64, 0, 32, 32, 96, 32))
  
  -- player needs access to wall and enemy functions
  wall, enemy = w, e
end

function player.update()
  player.tick = player.tick + 1
  
  if player.y > 480 then
    love.timer.sleep(.5)
    return false
  end
  
  if player.x > 640 then
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
  player.inAir = wall.checkCollisionFloor(player.x,player.y+1,
    player.width,player.height)
  
  if player.inAir then
    if kb.jumpPressed() then
      player.vspeed = -JUMP
      player.jumpRelease = false
    end
  else  
    player.fall = SLOWFALL
    if (not kb.jumpHeld()) or 
      (player.jumpRelease and player.vspeed < 0) then
      player.jumpRelease = true
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
  
  if enemy.spring.checkCollision(player.x,player.y,
    player.width,player.height) then
    if kb.jumpHeld() then
      player.vspeed = -BIGBOUNCE
    else
      player.vspeed = -SMALLBOUNCE
    end
  end
  
  if enemy.spike.checkCollision(player.x,player.y,
    player.width,player.height) then
    love.timer.sleep(.5)
    return false
  end
  
  -- update position, check for collision
  local new_x = player.x + player.hspeed
  local new_y = player.y + player.vspeed
  local old_x = player.x 
  local old_y = player.y
  
  local collide_x = wall.checkCollisionWalls(new_x,player.y,
    player.width,player.height)
  local collide_y_floor = wall.checkCollisionFloor(player.x,new_y,
    player.width,player.height)
  local collide_y_ceil = wall.checkCollisionCeil(player.x,new_y,
    player.width,player.height)
  
  if not collide_x then
    player.x = new_x
  else
    player.x = round(player.x/4) * 4
  end
  
  if not (collide_y_floor or collide_y_ceil) then
    player.y = new_y
  else
    player.y = round(player.y/16) * 16
    if collide_y_floor then
      player.vspeed = 0
      player.vaccel = 0
    end
  end
  
  player.setAnimationState()
  
  player.draw_x = round(player.x)
  player.draw_y = round(player.y)
  
  return true
end

function player.setAnimationState()  
  if player.vspeed < 0 then 
    player.vertState = -1
    player.currentFrame = 2
  elseif player.vspeed > 0 then 
    player.vertState = 0 
    player.currentFrame = 2
  elseif player.vertState ~= 1 then
    player.tick = 1 -- reset animation
    player.vertState = 1
    player.currentFrame = 1 
  end
  
  if player.hspeed < 0 then 
    player.horState = -1
  elseif player.hspeed > 0 then
    player.horState = 1
  elseif player.vspeed == 0 then
    player.currentFrame = 1
  end
  
  if player.vspeed < -1 or player.spinFrame > 1 then
    if player.tick % 5 == 0 then
      player.spinFrame = player.spinFrame + 1
      if player.spinFrame > 4 then
        player.spinFrame = 1
      end
    end
  elseif player.vspeed == 0 and player.hspeed ~= 0 then
    if player.tick % 8 == 0 then
      player.currentFrame = player.currentFrame + 1
      if player.currentFrame > 4 then
        player.currentFrame = 1
      end
    end
  end
end

function player.draw()
  love.graphics.draw(player.sprite,player.frames[player.currentFrame],
    player.draw_x+16,player.draw_y+16,math.rad(player.horState*(player.spinFrame-1)*90),
    player.horState,1,16,16)
end

function player.die()
  player.x, player.y = 32, 288 
  player.hspeed = 0
  player.vspeed = 0
end

return player
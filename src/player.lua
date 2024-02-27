local player = {}
player.update = {}

player.x, player.y = 100, 100
player.draw_x, player.draw_y = 100, 100
player.hspeed = 0
player.vspeed = 0
player.color = { .5, 1, .5 }
player.control = true

function player.update()
  local SPEED = 2
  
  player.x = player.x + (player.hspeed)
  player.y = player.y + (player.vspeed)
  
  player.draw_x = math.floor(player.x+0.5)
  player.draw_y = math.floor(player.y+0.5)

  if love.keyboard.isDown("left") then
    player.hspeed = -SPEED
  elseif love.keyboard.isDown("right") then
    player.hspeed = SPEED 
  else
    player.hspeed = 0
  end

  if love.keyboard.isDown("up") then 
    player.vspeed = -SPEED
  elseif love.keyboard.isDown("down") then
    player.vspeed = SPEED
  else
    player.vspeed = 0
  end
  
  
end

function player.draw()
  if player.x and player.y then
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill",player.draw_x,player.draw_y,32,32)
    love.graphics.setColor(1,1,1)
  end
end

return player
kb = {}

local jumpHeld = false
local jumpPressed = false

function kb.left()
  return love.keyboard.isDown("left")
end

function kb.right()
  return love.keyboard.isDown("right")
end

function kb.jumpPressed()
  return jumpPressed
end

function kb.jumpHeld()
  return jumpHeld
end

function kb.update()
  if love.keyboard.isDown("up") then
    if jumpHeld == false then
      jumpPressed = true
    else
      jumpPressed = false
    end
  end
  
  jumpHeld = love.keyboard.isDown("up")
end

function kb.draw()
  if jumpHeld then 
    love.graphics.printf("Jump held!", 100, 100, 100, "left")
  end
end
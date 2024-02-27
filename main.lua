local level = require("src.level")

local tickPeriod = 1/60
local accumulator = 0.0

function love.load()
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle("2D Platformer")
  love.window.setVSync( 1 )
  
  level.load()
end

function love.update(dt)
  local delta = dt
  if delta > tickPeriod then delta = tickPeriod end
  accumulator = accumulator + delta
  if accumulator >= tickPeriod then
    level.update(delta)
    accumulator = accumulator - tickPeriod
  end 
end

function love.draw()
  level.draw()
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end

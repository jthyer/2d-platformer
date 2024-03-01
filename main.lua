local level = require("src.level")
local tickPeriod = 1/60
local accumulator = 0.0
local currentLevel = 1
local scene = "level"

require("src.util")
require("src.keyboard")

function love.load()
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle("2D Platformer")
  love.window.setVSync( 1 )
  
  level.load(currentLevel)
end

function love.update(dt)
  if scene == "level" then
    local delta = dt
    --if delta > tickPeriod then delta = tickPeriod end
    accumulator = accumulator + delta
    if accumulator >= tickPeriod then
      kb.update()
      level.update(delta)
      accumulator = accumulator - tickPeriod
    end
  end
end

function love.draw()
  if scene == "level" then
    level.draw()
    kb.draw()
  else
    love.graphics.printf("YOU WIN!",0,356/2,512/2,"center",0,2,2)
  end
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end

function getCurrentLevel()
  return currentLevel
end

function setCurrentLevel(i)
  currentLevel = i
  if currentLevel <= 3 then
    level.load(currentLevel)
  else
    scene = "win"
  end
end

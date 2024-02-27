local level = {}

local LEVELDATA = require("src.levelData")
local wall = require("src.wall")
local enemy = require("src.enemy")
local player = require("src.player")

function level.load()  
  wall.load(LEVELDATA.tileData)
  enemy.load(LEVELDATA.enemyData)
end

function level.update()
  player.update()
  --enemy.update()
end

function level.draw()
  love.graphics.printf("level",100,20,500,"left")
  
  wall.draw()
  player.draw()
  enemy.draw()
end

return level
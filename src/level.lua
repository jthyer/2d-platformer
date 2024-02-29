local level = {}

level.LEVELDATA = require("src.levelData")
level.wall = require("src.wall")
level.enemy = require("src.enemy")
level.player = require("src.player")

function level.load()  
  level.wall.load(level.LEVELDATA.tileData)
  level.enemy.load(level.LEVELDATA.enemyData)
  level.player.load(level.wall, level.enemy)
end

function level.update()
  level.player.update()
end

function level.draw()
  love.graphics.printf("level",100,20,500,"left")
  
  level.wall.draw()
  level.player.draw()
  level.enemy.draw()
end

return level
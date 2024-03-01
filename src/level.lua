local level = {}

level.LEVELDATA = require("src.levelData")
level.wall = require("src.wall")
level.enemy = require("src.enemy")
level.player = require("src.player")

function level.load(l)  
  level.wall.load(level.LEVELDATA.tileData[l])
  level.enemy.load(level.LEVELDATA.enemyData[l])
  level.player.load(level.wall, level.enemy)
end

function level.update()
  if not level.player.update()
  then level.load(getCurrentLevel()) end
end

function level.draw()  
  level.wall.draw()
  level.player.draw()
  level.enemy.draw()
end

return level
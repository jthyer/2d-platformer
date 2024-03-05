local level = {}

level.LEVELDATA = require("src.levelData") 
level.bg = require("src.bg")
level.wall = require("src.wall")
level.enemy = require("src.enemy")
level.player = require("src.player")

function level.load(l)  
  level.bg.load(level.LEVELDATA[l].tileData)
  level.wall.load(level.LEVELDATA[l].wallData)
  level.enemy.load(level.LEVELDATA[l].enemyData)
  level.player.load(level.wall, level.enemy)
end

function level.update()
  if not level.player.update()
  then level.load(getCurrentLevel()) end
end

function level.draw()  
  level.bg.draw()  
  --level.wall.draw()
  level.player.draw()
  level.enemy.draw()
end

return level
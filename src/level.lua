local level = {}

level.LEVELDATA = require("src.levelData")
level.wall = require("src.wall")
level.enemy = require("src.enemy")
level.player = require("src.player")

function level.load(l)  
  level.wall.load(level.LEVELDATA[l].tileData)
  level.enemy.load(level.LEVELDATA[l].enemyData)
  level.player.load(level.wall, level.enemy)
end

function level.update()
  if not level.player.update()
  then level.load(getCurrentLevel()) end
end

function level.draw()  
  love.graphics.setColor(.9,.8,1)
  love.graphics.rectangle("fill",0,0,640,480)
  love.graphics.setColor(1,1,1)
  
  level.wall.draw()
  level.player.draw()
  level.enemy.draw()
end

return level
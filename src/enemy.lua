local enemy = {}
local enemyTable = {}
local enemyDeathFlag = {}

enemy.spring = {}
enemy.spike = {}

local COLORTABLE = {}
COLORTABLE.spring = { .5, .5, 1 }
COLORTABLE.spike = { 1, .2, .2 }

function enemy.load(ENEMYDATA)
  enemyTable = {}
  for i,v in ipairs(ENEMYDATA) do
    table.insert(enemyTable,enemy.createEnemy(v[1],v[2],v[3]))
  end
end

function enemy.createEnemy(id, x, y)
  local e = {}
    e.id = id
    e.x, e.y = x,y
    e.color = COLORTABLE[e.id]
  return e
end

function enemy.spring.checkCollision(x,y)
  local collision = false
  local enemyDeathFlag = {}
  
  for i,v in ipairs(enemyTable) do  
    if(v.id == "spring" and checkCollision(x,y,v.x,v.y)) then
      collision = true
      table.insert(enemyDeathFlag,i)
    end
  end
  
  for i2, v2 in ipairs(enemyDeathFlag) do
    table.remove(enemyTable, v2)
  end
  
  return collision
end

function enemy.spike.checkCollision(x,y)
  local collision = false

  for i,v in ipairs(enemyTable) do  
    if(v.id == "spike" and checkCollision(x,y,v.x,v.y)) then
      collision = true
    end
  end
  
  return collision
end


function enemy.update()
  
end

function enemy.draw()
  for i,v in ipairs(enemyTable) do
    love.graphics.setColor(v.color)
    love.graphics.rectangle("fill",v.x,v.y,32,32)
    love.graphics.setColor(1,1,1)
  end
end

return enemy
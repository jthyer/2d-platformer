local wall = {}
local wallTable = {}

function wall.load(TILEDATA)
  wallTable = {}
  for i,v in ipairs(TILEDATA) do
    for j,v2 in ipairs(v) do
      if v2 == 1 then
        local wall = {}
        wall.x = (j-1)*32
        wall.y = (i-1)*32
        table.insert(wallTable,wall)
      end
    end
  end
end

function wall.checkCollisionWalls(x,y)
  local collision = false
  for i,v in ipairs(wallTable) do  
    if(checkCollision(x,y,v.x,v.y)) then
      collision = true
    end
  end
  
  return collision
end

function wall.checkCollisionFloor(x,y)
  local collision = false
  for i,v in ipairs(wallTable) do  
    if(y <= v.y and checkCollision(x,y,v.x,v.y)) then
      collision = true
    end
  end
  
  return collision
end

function wall.checkCollisionCeil(x,y)
  local collision = false
  for i,v in ipairs(wallTable) do  
    if(y >= v.y and checkCollision(x,y,v.x,v.y)) then
      collision = true
    end
  end
  
  return collision
end

function wall.draw()
  for i,v in ipairs(wallTable) do
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",v.x,v.y,32,32)
  end
end

return wall
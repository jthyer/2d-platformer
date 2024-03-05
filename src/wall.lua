local wall = {}
local wallTable = {}

function wall.load(TILEDATA)
  wallTable = {}
  for i,v in ipairs(TILEDATA) do
    for j,v2 in ipairs(v) do
      if v2 == 1 then
        local wall = {}
        wall.x = (j-1)*16
        wall.y = (i-1)*16
        table.insert(wallTable,wall)
      end
    end
  end
end

function wall.checkCollisionWalls(x,y,w,h)
  local collision = false
  for i,v in ipairs(wallTable) do  
    if(checkCollision(x,y,w,h,v.x,v.y,16,16)) then
      collision = true
    end
  end
  
  return collision
end

function wall.checkCollisionFloor(x,y,w,h)
  local collision = false
  for i,v in ipairs(wallTable) do  
    if(y <= v.y and checkCollision(x,y,w,h,v.x,v.y,16,16)) then
      collision = true
    end
  end
  
  return collision
end

function wall.checkCollisionCeil(x,y,w,h)
  local collision = false

  for i,v in ipairs(wallTable) do  
    if(y > v.y and checkCollision(x,y,w,h,v.x,v.y,16,16)) then
      collision = true
    end
  end
  
  return collision
end

function wall.draw()
  for i,v in ipairs(wallTable) do
    love.graphics.setColor(.8,.4,.4)
    love.graphics.rectangle("fill",v.x,v.y,16,16)
    love.graphics.setColor(1,1,1)
  end
end

return wall
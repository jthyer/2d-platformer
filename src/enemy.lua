local enemy = {}
local enemyTable = {}

function enemy.load(ENEMYDATA)
  for i,v in ipairs(ENEMYDATA) do
    table.insert(enemyTable,enemy.createEnemy(v[1],v[2],v[3]))
  end
end

function enemy.createEnemy(id, x, y)
  local e = {}
    e.id = id
    e.x, e.y = x,y
    e.color = { 1, .5, .5 }
  return e
end

function enemy.update()
  -- for i,v in ipairs(enemyTable) do
    -- No enemy behavior yet.
  -- end
end

function enemy.draw()
  for i,v in ipairs(enemyTable) do
    love.graphics.setColor(v.color)
    love.graphics.rectangle("fill",v.x,v.y,32,32)
    love.graphics.setColor(1,1,1)
  end
end

return enemy
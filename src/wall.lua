local wall = {}
local wallTable = {}

function wall.load(TILEDATA)
  wallTable = {}
  for i,v in ipairs(TILEDATA) do
    for j,v2 in ipairs(v) do
      if v2 == 1 or v2 == 2 or v2 == 3 or v2 == 4 or v2 == 18 or v2 == 19 then
        local wall = {}
        wall.x = (j-1)*32
        wall.y = (i-1)*32
        table.insert(wallTable,wall)
      end
    end
  end
end

function wall.draw()
  for i,v in ipairs(wallTable) do
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",v.x,v.y,32,32)
  end
end

return wall
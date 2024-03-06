local bg = {}
local quads = {}
local canvas = love.graphics.newCanvas(640,480)
local fog_x = 0

local bg_tileset = love.graphics.newImage("assets/bg_tiles.png")
local bg_fog = love.graphics.newImage("assets/bg_fog.png")

function bg.load(TILEDATA)
  local image_width = bg_tileset:getWidth()
  local image_height = bg_tileset:getHeight()
  
  local rows = image_width / 16
  local cols = image_height / 16
  
  for i = 0, cols-1 do
    for j = 0, rows-1 do
      table.insert(quads,love.graphics.newQuad(
          j * 16, i * 16, 16, 16, image_width,image_height))
    end
  end 
  
  love.graphics.setCanvas(canvas)
  bg.drawCanvas(TILEDATA)
  love.graphics.setCanvas()
end

function bg.update()
  fog_x = fog_x - 4
  
  if fog_x < -512 then
    fog_x = 0
  end
end

function bg.drawCanvas(tileData)
 -- love.graphics.setColor(.7,.7,.8)
  --love.graphics.rectangle("fill",0,0,640,480)
 -- love.graphics.setColor(1,1,1)
  
  for i,v in ipairs(tileData) do
    for j,v2 in ipairs(v) do
      if v2 ~= -1 then
        love.graphics.draw(bg_tileset, quads[v2+1], (j-1) * 16,(i-1) * 16)
      end
    end
  end 
end

function bg.draw()
  love.graphics.setColor(.5,.5,.8)
  love.graphics.rectangle("fill",0,0,640,480)
  love.graphics.setColor(1,1,1,0.2)
  love.graphics.draw(bg_fog,fog_x,0)
  love.graphics.draw(bg_fog,fog_x+512,0) 
  love.graphics.draw(bg_fog,fog_x+1024,0)
  love.graphics.setColor(1,1,1,1)
  
  love.graphics.draw(canvas,0,0,0,1,1)
end

return bg
local spike = {}
local spikeTable = {}

spike.image = love.graphics.newImage("assets/bg_spikes.png")
spike.dir = {}

for i = 1, 4 do
  table.insert(spike.dir, love.graphics.newQuad((i-1)*16, 0, 16, 16, 64, 16))
end

function spike.load(SPIKEDATA)
  spikeTable = SPIKEDATA
end

function spike.draw()
  for i,v in ipairs(spikeTable) do
    love.graphics.draw(spike.image,spike.dir[v.id],v.x,v.y)
  end
end
  
return spike
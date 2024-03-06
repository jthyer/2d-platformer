local json = require("lib.json")
local levelData = {}
local NUMLEVELS = 1

for level = 1,NUMLEVELS do
  table.insert(levelData,{})
  levelData[level].wallData = {}
  levelData[level].enemyData = {}
  levelData[level].tileData = {}
  levelData[level].spikeData = {}
  
  local raw = love.filesystem.read("levels/level"..tostring(level)..".json")
  local jsonData = json.decode(raw)
    
  for i = 1, 30 do
    local rowWall = {}
    local rowTile = {}
    for i2 = 1, 40 do
      local wallCoord = jsonData["layers"][1]["data"][i2+((i-1)*40)]+1
      local tileCoord = jsonData["layers"][3]["data"][i2+((i-1)*40)]
      local spikeCoord = jsonData["layers"][4]["data"][i2+((i-1)*40)]+1
      table.insert(rowWall,wallCoord)
      table.insert(rowTile,tileCoord)
      if spikeCoord > 0 then
        local spikeUnit = {}
        spikeUnit.id = spikeCoord
        spikeUnit.x = (i2-1)*16
        spikeUnit.y = (i-1)*16
        table.insert(levelData[level].spikeData,spikeUnit)
      end
    end
    table.insert(levelData[level].wallData,rowWall)
    table.insert(levelData[level].tileData,rowTile)
  end
  
  for key,v in pairs(jsonData["layers"][2]["entities"]) do
    local enemy = {}
      enemy.id = v["name"]
      enemy.x = v["x"]
      enemy.y = v["y"]
    table.insert(levelData[level].enemyData,enemy)
  end

end

return levelData
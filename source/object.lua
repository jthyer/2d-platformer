local object = {}

local objectTable = {}
local objectDeathFlag = {}
local itrID

local new = {}
new.jellyfish = require("source.class.player")--require("source.class.jellyfish")
  new.jellyfishStill = new.jellyfish
  new.jellyfishMove = new.jellyfish
new.wall = require("source.class.wall")
new.player = require("source.class.player")

local p = {} -- parent functions to pass to child closures as needed

function p.checkObjects(f)
  -- perform a passed function on all objects 
  -- immediately return true if any f(obj) returns true
  for i,obj in ipairs(objectTable) do
    if f(obj) then
      return true
    end
  end
  return false
end

function p.updateFrame(image) 
  if image.spriteCount == 1 then
    return
  end
  
  image.timer = image.timer + 1
  if image.timer == image.sprite.frameSpeed then 
    image.index = image.index + 1
    image.timer = 0
    if image.index > image.sprite.frameCount then
      image.index = 1
    end
  end
end

function p.changeSprite(image,str)
  if image.sprite.index == str then 
    return
  end  
  
  image.sprite = global.getAsset("sprite",str)
  image.index = 1
  image.timer = 0
end

local function getID()
  local returnID = itrID
  itrID = itrID + 1
  
  return returnID
end

local function newObject(c,x,y)
  local obj = {}
  obj = new[c](c,x,y,p)
  return obj
end

function object.load(OBJECTDATA)
  itrID = 0
  objectTable = {}
  for i,obj in ipairs(OBJECTDATA) do
    table.insert(objectTable,newObject(obj.class,obj.x,obj.y))
  end
end

function object.update()
  for i,obj in ipairs(objectTable) do
    if obj.update ~= nil then
      obj.update()
    end
  end 
end

function object.draw()
  for i,obj in ipairs(objectTable) do
    if obj.drawInfo ~= nil then
      local x, y, sprite, imageIndex, dir, o = obj.drawInfo()
      love.graphics.draw(sprite.image,sprite.frame[imageIndex],x+o,y+o,0,dir,1,o,o)
    end
  end
end

return object
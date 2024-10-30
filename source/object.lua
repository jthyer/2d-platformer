local object = {}

local objectTable = {}
local objectDeathFlag = {}
local itrID

local new = require("source.class._define")

local p = {} -- parent functions to pass to child closures as needed

local function destroyObject(o)
  table.remove(objectTable,o)
end

local function newObject(c,x,y)
  local obj = {}
  obj = new[c](c,x,y,p)
  return obj
end

function p.checkObjects(f)
  -- perform a passed function on all objects 
  -- immediately return true if any f(obj) returns true
  for i,obj in ipairs(objectTable) do
    if f(obj) then
      return i
    end
  end
  return nil
end

function p.checkCollision(check_x,check_y,checkWidth,checkHeight,
  solidOnly,enemyOnly,floorOnly,ceilOnly,destroy,flag)
  local returnValue  

  local function f(obj) 
    local collision = false
    if (solidOnly and obj.solid) or (enemyOnly and obj.enemy) or
      (destroy and obj.bounce) or (flag and obj.win) then
      local x, y, w, h = obj.hitbox().x, obj.hitbox().y,
        obj.hitbox().width, obj.hitbox().height
      if (floorOnly == nil or check_y <= y) and
        (ceilOnly == nil or check_y > y) and
        util.checkOverlap(check_x,check_y,checkWidth,checkHeight,x,y,w,h) then
        collision = true
      end
    end
      
    return collision 
  end 
  
  returnValue = p.checkObjects(f)
  if returnValue then
    if destroy then
      destroyObject(returnValue)
    end
    returnValue = true
  else
    returnValue = false
  end
  
  return returnValue
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
    else
      love.graphics.setColor(.35,.25,.25)
      local x, y, width, height = obj.hitbox().x, obj.hitbox().y, obj.hitbox().width, obj.hitbox().height
      love.graphics.rectangle("fill",x,y,width,height)
      love.graphics.setColor(1,1,1)
    end
  end
end

return object
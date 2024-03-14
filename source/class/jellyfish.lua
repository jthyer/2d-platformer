local HSPEED = 1
local ORIGIN_OFFSET = 16

local function jellyfish(c,start_x,start_y)  
  local public = {}
  
  local class, x, y = c, start_x, start_y
  
  local image = { sprite = global.getAsset("sprite",class), index = 1, timer = 0, dir = 1 }
  
  function public.update() 
    if class == "jellyfishMove" then
      x = x + HSPEED
    end
  end
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, ORIGIN_OFFSET end
  
  return public
end

return jellyfish
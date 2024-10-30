local function flag(c,start_x,start_y)  
  local public = {}
  
  local class, x, y = c, start_x, start_y
  local hitbox = { 
    x = x,
    y = y,
    width = 32,
    height = 32,
  }
  
  local image = { sprite = global.getAsset("sprite",class), index = 1, timer = 0, dir = 1 }
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, 0 end
  
  function public.hitbox() return hitbox end
  public.win = true
  
  return public
end

return flag
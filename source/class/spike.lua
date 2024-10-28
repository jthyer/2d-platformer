local function spike(c,start_x,start_y)  
  local public = {}
  
  local class, x, y = c, start_x, start_y
  local hitbox = { 
    x = x,
    y = y,
    width = 16,
    height = 16,
  }
  
  local image = { sprite = global.getAsset("sprite",class), index = 1, timer = 0, dir = 1 }
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, 0 end  
  
  function public.hitbox() return hitbox end
  
  public.enemy = true

  return public
end

return spike

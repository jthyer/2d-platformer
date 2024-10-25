local function wall(c,start_x,start_y)  
  local public = {}
  
  local class, x, y = c, start_x, start_y
  local hitbox = { 
    x = x,
    y = y,
    width = 16,
    height = 16,
  }
  
  function public.hitbox() return hitbox end
  public.solid = true
  
  return public
end

return wall
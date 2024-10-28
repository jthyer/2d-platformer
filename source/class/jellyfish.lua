local HSPEED = 2
local ORIGIN_OFFSET = 16

local function jellyfish(c,start_x,start_y,p)  
  local public = {}
  
  local class, x, y, hspeed = c, start_x, start_y, HSPEED
  local image = { sprite = global.getAsset("sprite",class), index = 1, timer = 0, dir = 1 }
  
  local hitbox = {}
  hitbox = {x=x+8,y=y+8,width=16,height=16}
  
  local function updateHitbox()
    hitbox.x = x+8
    hitbox.y = y+8
  end
  
  function public.update() 
    if class == "jellyfishMove" then
      if (x < 0) or (x+(ORIGIN_OFFSET*2) > global.WINDOW_WIDTH) or
        (p.checkCollision(hitbox.x,hitbox.y,
        hitbox.width,hitbox.height,true)) then
        hspeed = hspeed * -1
      end
      x = x + hspeed
      updateHitbox()
    end
  end
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, ORIGIN_OFFSET end
  
  public.enemy = true
  public.bounce = true
  function public.hitbox() return hitbox end
 
  return public
end

return jellyfish
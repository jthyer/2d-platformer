local SPEED = 3
local JUMP = 7
local GRAVITY = 0.2
local FASTFALL = 10
local SLOWFALL = 5
local ORIGIN_OFFSET = 16

local function player(c,start_x,start_y,p)  
  local public = {}
  
  local image = { sprite = global.getAsset("sprite","lillyWalk"), index = 1, timer = 0, dir = 1 }

  local class, x, y = c, start_x, start_y
  local hspeed, vspeed = 0, 0
  local jumpRelease = false
  local maxFallSpeed = FASTFALL
  
  local hitbox = {}
  hitbox = {x=x+8,y=y+16,width=16,height=16}
  
  local function checkCollisionWalls(check_x,check_y,checkWidth,checkHeight,
    floorOnly,ceilOnly)
    local function f(obj) 
      local collision = false
      if obj.solid then
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
    return p.checkObjects(f)
  end
    
  local function horMovement()
    if kb.left() then
      hspeed = -SPEED
    elseif kb.right() then
      hspeed = SPEED    
    else
      hspeed = 0
    end

    local collide_x = checkCollisionWalls(hitbox.x+hspeed,hitbox.y,
      hitbox.width,hitbox.height)
    if not collide_x then
      x = x + hspeed
    else
      x = util.round(x/4) * 4
    end  
  end
  
  local function vertMovement()
    local grounded = checkCollisionWalls(hitbox.x,hitbox.y+1,
      hitbox.width,hitbox.height,true)
  
    if grounded then
      if kb.jumpPressed() then
        vspeed = -JUMP
        jumpRelease = false
      end
    else  
      maxFallSpeed = SLOWFALL
      if (not kb.jumpHeld()) or
        (jumpRelease and vspeed < 0) then
        jumpRelease = true
        if vspeed < -GRAVITY then
          vspeed = vspeed + 0.5
        end
        maxFallSpeed = FASTFALL
        vspeed = vspeed + (GRAVITY / 2)
      end
      vspeed = vspeed + GRAVITY
      if vspeed > maxFallSpeed then
        vspeed = maxFallSpeed
      end
    end  

    local new_y = y + vspeed
    local collide_y_floor = checkCollisionWalls(hitbox.x,hitbox.y+vspeed,
      hitbox.width,hitbox.height,true)
    local collide_y_ceil = checkCollisionWalls(hitbox.x,hitbox.y+vspeed,
      hitbox.width,hitbox.height,nil,true)
    
    if not (collide_y_floor or collide_y_ceil) then
      y = y + vspeed
    else
      y = util.round(y/16) * 16
      if collide_y_floor then
        vspeed = 0
        vaccel = 0
      end
    end   
  end
  
  local function updateHitbox()
    hitbox.x = x+8
    hitbox.y = y+16
  end
  
  local function updateSprite()
    local vertState, horState
    local spr 
    
    if hspeed < 0 then 
      image.dir = -1
    elseif hspeed > 0 then 
      image.dir = 1
    end
    
    if vspeed < 0 then 
      spr = "lillyJump"
    elseif vspeed > 0 then 
      spr = "lillyFall"
    elseif hspeed ~= 0 then
      spr = "lillyWalk"
    else
      spr = "lilly"
    end
    
    p.changeSprite(image,spr)
  end
  
  function public.update() 
    horMovement()
    vertMovement()
    updateHitbox()
    updateSprite()
    p.updateFrame(image)
  end
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, ORIGIN_OFFSET end

  return public
end

return player
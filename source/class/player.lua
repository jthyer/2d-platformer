local SPEED = 3
local JUMP = 6
local GRAVITY = 0.2
local FASTFALL = 10
local SLOWFALL = 5
local ORIGIN_OFFSET = 16
local TIME_TO_RELEASE = 4

local function player(c,start_x,start_y,p)  
  local public = {}
  
  local image = { sprite = global.getAsset("sprite","lillyWalk"), index = 1, timer = 0, dir = 1 }

  local class, x, y = c, start_x, start_y
  local hspeed, vspeed = 0, 0
  local jumpRelease = false
  local jumpTimer = 0 
    -- if you JUST jumped, but also let go of the button, don't decelerate immediately
  local maxFallSpeed = FASTFALL
  local grounded = true
  
  local hitbox = {}
  hitbox = {x=x+8,y=y+16,width=16,height=16}
  
  local function horMovement()
    if kb.left() then
      hspeed = -SPEED
    elseif kb.right() then
      hspeed = SPEED    
    else
      hspeed = 0
    end

    local collide_x = p.checkCollision(hitbox.x+hspeed,hitbox.y,
      hitbox.width,hitbox.height,true)
    if not collide_x then
      x = x + hspeed
    else
      x = util.round(x/4) * 4
    end  
    
    if x < -4 then 
      x = -4
    end
    
    if x + 28 > global.WINDOW_WIDTH then 
      x = global.WINDOW_WIDTH - 28
    end
  end
  
  local function vertMovement()
    grounded = p.checkCollision(hitbox.x,hitbox.y+1,
      hitbox.width,hitbox.height,true,nil,true)
  
    if grounded then
      if kb.jumpPressed() then
        vspeed = -JUMP
        jumpRelease = false
        jumpTimer = TIME_TO_RELEASE
      end
    else  
      maxFallSpeed = SLOWFALL
      if (not kb.jumpHeld()) or
        (jumpRelease and vspeed < 0) then
        jumpRelease = true
        if jumpTimer > 0 then 
          jumpTimer = jumpTimer - 1
        else
          if vspeed < -GRAVITY then
            vspeed = vspeed + 0.5
          end
          maxFallSpeed = FASTFALL
          vspeed = vspeed + (GRAVITY / 2)
        end
      end
      vspeed = vspeed + GRAVITY
      if vspeed > maxFallSpeed then
        vspeed = maxFallSpeed
      end
    end  

    local new_y = y + vspeed
    local collide_y_floor = p.checkCollision(hitbox.x,hitbox.y+vspeed,
      hitbox.width,hitbox.height,true,nil,true)
    local collide_y_ceil = p.checkCollision(hitbox.x,hitbox.y+vspeed,
      hitbox.width,hitbox.height,true,nil,nil,true)
    
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
    
    if not grounded then 
      if kb.jumpHeld() and not jumpRelease and vspeed > -5 then
        spr = "lillyJump"
      else
        spr = "lillyFall"
      end
    elseif hspeed ~= 0 then
      spr = "lillyWalk"
    else
      spr = "lilly"
    end
    
    p.changeSprite(image,spr)
  end
  
  local function enemyCollision()
    if(vspeed > 0 and
      p.checkCollision(hitbox.x-8,hitbox.y,
      hitbox.width+16,hitbox.height,nil,nil,true,nil,true)) then
      vspeed = -JUMP-1
      y = y + vspeed
      jumpTimer = TIME_TO_RELEASE
      if kb.jumpHeld() then
        jumpRelease = false
      end
    elseif(y > global.WINDOW_HEIGHT or p.checkCollision(hitbox.x,hitbox.y,
      hitbox.width,hitbox.height,nil,true)) then
      global.sceneRestart()
    end
  end
  
  local function flagCollision()
    if p.checkCollision(hitbox.x,hitbox.y,
      hitbox.width,hitbox.height,nil,nil,nil,nil,nil,true) then
      global.sceneNext()
    end
  end
  
  function public.update() 
    horMovement()
    vertMovement()
    updateHitbox()
    updateSprite()
    enemyCollision()
    flagCollision()
    p.updateFrame(image)
  end
  
  function public.drawInfo() return x, y, 
    image.sprite, image.index, image.dir, ORIGIN_OFFSET end

  return public
end

return player
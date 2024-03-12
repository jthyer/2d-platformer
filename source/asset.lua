local asset = {}

asset.tileset = {}

asset.tileset.labyrinth = love.graphics.newImage("image/tile_labyrinth.png")
asset.tileset.wall = love.graphics.newImage("image/tile_wall.png")

asset.sprite = {}

asset.sprite.lillyR =     { index = "lillyR",     image = love.graphics.newImage("image/spr_lillyR.png"),     frameCount = 1, frameSpeed = 0 }
asset.sprite.lillyWalkR = { index = "lillyWalkR", image = love.graphics.newImage("image/spr_lillyWalkR.png"), frameCount = 4, frameSpeed = 6 }
asset.sprite.lillyJumpR = { index = "lillyJumpR", image = love.graphics.newImage("image/spr_lillyJumpR.png"), frameCount = 4, frameSpeed = 6 }
asset.sprite.lillyFallR = { index = "lillyFallR", image = love.graphics.newImage("image/spr_lillyFallR.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.lillyL =     { index = "lillyL",     image = love.graphics.newImage("image/spr_lillyL.png"),     frameCount = 1, frameSpeed = 0 }
asset.sprite.lillyWalkL = { index = "lillyWalkL", image = love.graphics.newImage("image/spr_lillyWalkL.png"), frameCount = 4, frameSpeed = 6 }
asset.sprite.lillyJumpL = { index = "lillyJumpL", image = love.graphics.newImage("image/spr_lillyJumpL.png"), frameCount = 4, frameSpeed = 6 }
asset.sprite.lillyFallL = { index = "lillyFallL", image = love.graphics.newImage("image/spr_lillyFallL.png"), frameCount = 1, frameSpeed = 0 }

asset.sprite.jellyfishBoss = { image = love.graphics.newImage("image/spr_jellyfishBoss.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishMove = { image = love.graphics.newImage("image/spr_jellyfishMove.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishShoot = { image = love.graphics.newImage("image/spr_jellyfishShoot.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishStill = { image = love.graphics.newImage("image/spr_jellyfishStill.png"), frameCount = 1, frameSpeed = 0 }

for i,sprite in pairs(asset.sprite) do
  sprite.frameWidth = sprite.image:getWidth() / sprite.frameCount
  sprite.frameHeight = sprite.image:getHeight()

  sprite.frame = {}

  for i = 1,sprite.frameCount do
    sprite.frame[i] = love.graphics.newQuad(sprite.frameWidth*(i-1), 0, 
      sprite.frameWidth, sprite.frameHeight, sprite.image:getWidth(), sprite.image:getHeight()) 
  end
end

asset.music = {}

asset.sound = {}

return asset
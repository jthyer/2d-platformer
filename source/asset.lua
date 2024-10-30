local asset = {}

asset.tileset = {}

asset.tileset.labyrinth = love.graphics.newImage("image/tile_labyrinth.png")
asset.tileset.wall = love.graphics.newImage("image/tile_wall.png")

asset.sprite = {}

asset.sprite.lilly =     { index = "lilly",     image = love.graphics.newImage("image/spr_lilly.png"),     frameCount = 1, frameSpeed = 0 }
asset.sprite.lillyWalk = { index = "lillyWalk", image = love.graphics.newImage("image/spr_lillyWalk.png"), frameCount = 4, frameSpeed = 6 }
asset.sprite.lillyJump = { index = "lillyJump", image = love.graphics.newImage("image/spr_lillyJump.png"), frameCount = 4, frameSpeed = 3 }
asset.sprite.lillyFall = { index = "lillyFall", image = love.graphics.newImage("image/spr_lillyFall.png"), frameCount = 1, frameSpeed = 0 }

asset.sprite.jellyfishBoss = { image = love.graphics.newImage("image/spr_jellyfishBoss.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishMove = { image = love.graphics.newImage("image/spr_jellyfishMove.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishShoot = { image = love.graphics.newImage("image/spr_jellyfishShoot.png"), frameCount = 1, frameSpeed = 0 }
asset.sprite.jellyfishStill = { image = love.graphics.newImage("image/spr_jellyfishStill.png"), frameCount = 1, frameSpeed = 0 }

asset.sprite.flag = { image = love.graphics.newImage("image/spr_flag.png"), frameCount = 1, frameSpeed = 0 }

asset.sprite.spike = { image = love.graphics.newImage("image/tile_wall.png"), frameCount = 1, frameSpeed = 0 }

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
global = {}
global.WINDOW_WIDTH = 640
global.WINDOW_HEIGHT = 480
global.TILE_DIMENSION = 16

kb = require("source.kb")
util = require("source.util")

local asset = require("source.asset")
local scene = require("source.scene")
local text = require("source.text")

local tickPeriod = 1/60
local accumulator = 0.0

local sceneNumber = 1
local winTimer = 120

function love.load()
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle("Regrab City")
  love.window.setVSync( 1 )  
  
  font = love.graphics.newFont("image/BetterComicSans.ttf",32,"mono")

  scene.load(sceneNumber)
end

function love.update(dt)
  local delta = dt
  accumulator = accumulator + delta
  if accumulator >= tickPeriod then
    kb.update()
    scene.update()
    accumulator = accumulator - tickPeriod
    if sceneNumber == 4 then
      winTimer = winTimer - 1
      if winTimer <= 0 then
        love.event.quit()
      end
    end
  end  
end

function love.draw()
  scene.draw()
  kb.draw()
  if (sceneNumber <= 3) then
    text.drawSceneNum(sceneNumber)
  else
    text.drawWinScreen()
  end
end

function global.sceneRestart()
  scene.load(sceneNumber)
end

function global.sceneNext()
  sceneNumber = sceneNumber + 1
  scene.load(sceneNumber)
end

function global.getAsset(assetType,index)
  return asset[assetType][index]
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end
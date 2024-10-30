local text = {}

function text.drawSceneNum(s)
  love.graphics.setColor(0,0,0)
  love.graphics.printf("Level "..s.. " of 3",font,455,416,300,"left")
  love.graphics.setColor(1,1,1)
end

function text.drawWinScreen()
  love.graphics.setColor(0,0,0)
  love.graphics.printf("You won!",font,0,(global.WINDOW_HEIGHT/2)-38,
    global.WINDOW_WIDTH,"center")    
  love.graphics.setColor(1,1,1)
end

return text
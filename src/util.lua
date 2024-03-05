function checkCollision(x, y, w, h, x2, y2, w2, h2)
  local collision = false
  
  local a_left = x 
  local a_right = x + w
  local a_top = y
  local a_bottom = y + h
  
  local b_left = x2
  local b_right = x2 + w2
  local b_top = y2
  local b_bottom = y2 + h2
    
  if a_right > b_left and a_left < b_right and 
    a_bottom > b_top and a_top < b_bottom then
    collision = true
  end    
  
  return collision
end

function round(n) 
  return math.floor(n+0.5) 
end
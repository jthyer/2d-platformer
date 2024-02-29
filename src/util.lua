function checkCollision(x, y, x2, y2)
  local collision = false
  
  local a_left = x 
  local a_right = x + 32
  local a_top = y
  local a_bottom = y + 32
  
  local b_left = x2
  local b_right = x2 + 32
  local b_top = y2
  local b_bottom = y2 + 32
    
  if a_right > b_left and a_left < b_right and 
    a_bottom > b_top and a_top < b_bottom then
    collision = true
  end    
  
  return collision
end

function round(n) 
  return math.floor(n+0.5) 
end
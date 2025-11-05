init = function()
  
  screen.setFont("EnchantedSword")

  
  currState = new GameState()
  currState.init()
end

update = function()
  
  currState.update()
end

draw = function()
  
  currState.draw()
end
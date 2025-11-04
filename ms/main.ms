init = function()
  
  screen.setFont("PixAntiqua")

  
  currState = new GameState()
  currState.init()
end

update = function()
  
  currState.update()
end

draw = function()
  
  currState.draw()
end
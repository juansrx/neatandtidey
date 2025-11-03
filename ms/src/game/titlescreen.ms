TitleScreen = class
  
  constructor = function(gameState)
    this.gameState = gameState
  end

  init = function()
  end

  update = function()
    
    if mouse.release then
      this.gameState.changeTo("level1")
      this.gameState.init()
    end
    
  end

  draw = function()
    screen.drawMap( "titlescreen", 0, 0, 200, 200)
  end
  
end
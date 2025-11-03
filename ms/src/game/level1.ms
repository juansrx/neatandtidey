Level1 = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
  end

  init = function()
    
    this.playerShip = new Ship()
    this.playerShip.init()
    this.isActive = true
    
  end

  update = function()
    
    if this.isActive then
      
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
    end
    
  end

  draw = function()
    
    if this.isActive then
      screen.drawMap( "level1", 0, 0, 200, 200 )
      this.playerShip.draw()
    end
  end
  
end
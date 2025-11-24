Level24 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
  end
  
  init = function()
    
    this.playerShip = new Ship(0, 80)
    this.playerShip.init()
    
    this.isActive = true
  end

  update = function()
    
    if this.isActive then
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level24") then
        this.playerShip.drownTimeout(0, 80, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("final")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level24", 0, 0, 200, 200 )
      
      this.playerShip.draw()
    end
  end
  
end
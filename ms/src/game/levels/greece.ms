Greece = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
  end
  
  init = function()
    
    this.playerShip = new Ship(90, 0)
    this.playerShip.init()
    
    this.isActive = true
    
  end

  update = function()
    
    if this.isActive then
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "greece") then
        this.playerShip.drownTimeout(90, 0, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level5")
      end
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "greece", 0, 0, 200, 200 )
      screen.drawText("Welcome to Greece!", 0, 70, 10, "yellow")
      this.playerShip.draw()
    end
  end
  
end
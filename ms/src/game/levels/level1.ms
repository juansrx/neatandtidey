Level1 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
  end
  
  init = function()
    
    this.playerShip = new Ship(0, 0)
    this.playerShip.init()
    
    this.isActive = true
  end

  update = function()
    
    if this.isActive then
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level1") then
        this.playerShip.drownTimeout(0, 0, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level2")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level1", 0, 0, 200, 200 )
      screen.drawText("1. Click on the position you want to reach", 0, 70, 10, "yellow")
      screen.drawText("2. Evade anything that isn't water", 0, 50, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
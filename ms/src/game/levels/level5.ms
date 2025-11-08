Level5 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.cyclopList = [
      new Cyclop(75, 25, -1, 2000, new BarrelFactory(75, 25, -0.5, 0))
    ]
  end
  
  init = function()
    
    this.playerShip = new Ship(0, 90)
    this.playerShip.init()
    
    for cyclop in this.cyclopList
      cyclop.init()
    end
    
    this.isActive = true
    
  end
  
  updateCyclops = function()
    
    for cyclop in this.cyclopList
      
      cyclop.update()
    end
    
  end

  update = function()
    
    if this.isActive then
      
      this.updateCyclops()
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if spriteCollision("barrel1", "ship1") then
        this.playerShip.drownTimeout(0, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level5") then
        this.playerShip.drownTimeout(0, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level6")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level5", 0, 0, 200, 200 )
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      screen.drawText("Cyclops?.  Are those even real?", 0, 70, 10, "yellow")
      this.playerShip.draw()
    end
  end
  
end
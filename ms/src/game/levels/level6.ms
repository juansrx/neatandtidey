Level6 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.cyclopList = [
      new Cyclop(75, 50, -1, 3000, new BarrelFactory(75, 50, -0.5, 0))
      new Cyclop(-75, -75, 1, 3000, new BarrelFactory(-75, -75, 0.5, 0))
    ]
    
  end
  
  init = function()
    
    this.playerShip = new Ship(-50, 90)
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
        this.playerShip.drownTimeout(-50, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level6") then
        this.playerShip.drownTimeout(-50, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level7")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level6", 0, 0, 200, 200 )
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      /*screen.drawText("Cyclops?.  Are those even real?", 0, 70, 10, "yellow")*/
      this.playerShip.draw()
    end
  end
  
end
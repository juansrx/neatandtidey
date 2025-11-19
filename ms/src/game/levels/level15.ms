Level15 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.cyclopList = [
      new Cyclop(-50, -75, 1, 2000, new BarrelFactory(-50, -75, 0, 1))
      new Cyclop(0, -75, 1, 2000, new BarrelFactory(0, -75, 0, 1))
      new Cyclop(50, -75, 1, 2000, new BarrelFactory(50, -75, 0, 1))
    ]
    
  end
  
  init = function()
    
    this.playerShip = new Ship(90, 80)
    this.light = new Light(this.playerShip, 50, 50)
    this.playerShip.init()
    this.light.init()
    
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
      
      this.light.update()
      
      this.updateCyclops()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if spriteCollision("barrel1", "ship1") then
        this.playerShip.drownTimeout(90, 80, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level15") then
        this.playerShip.drownTimeout(90, 80, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level16")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level15", 0, 0, 200, 200 )
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end

      this.light.draw()
      
      
      this.playerShip.draw()
    end
  end
  
end
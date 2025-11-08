Level8 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.cyclopList = [
      new Cyclop(75, 50, -1, 2000, new BarrelFactory(75, 50, -1, -1))
      new Cyclop(-75, 50, 1, 2000, new BarrelFactory(-75, 50, 1, -1))
      new Cyclop(75, -50, -1, 2000, new BarrelFactory(75, -50, -1, 1))
      new Cyclop(-75, -50, 1, 2000, new BarrelFactory(-75, -50, 1, 1))
    ]
    
    this.currentList = []
    
    for i = 0 to 4
      
      this.currentList.push(new Current(-25 + (i * 12), 25, 1))
      this.currentList.push(new Current(-25 + (i * 12), -25, 1))
    end
    
  end
  
  init = function()
    
    this.playerShip = new Ship(0, 90)
    this.playerShip.init()
    
    for cyclop in this.cyclopList
      cyclop.init()
    end
    
    for current in this.currentList
      current.init()
    end
    
    this.isActive = true
    
  end
  
  updateCyclops = function()
    
    for cyclop in this.cyclopList
      
      cyclop.update()
    end
    
  end
  
  testPlayerInCurrent = function()
    
    for current in this.currentList
      
      if this.testActorCollision(this.playerShip, current) then
        
        current.pushActor(this.playerShip)
        break
      end
    end
    
  end
  
  update = function()
    
    if this.isActive then
      
      this.updateCyclops()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      this.testPlayerInCurrent()
      
      if spriteCollision("barrel1", "ship1") then
        this.playerShip.drownTimeout(0, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level8") then
        this.playerShip.drownTimeout(0, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level9")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level8", 0, 0, 200, 200 )
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      for current in this.currentList
        current.draw()
      end
      
      this.playerShip.draw()
    end
  end
  
end
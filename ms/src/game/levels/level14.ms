Level14 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.currentList = []
    
    for i = 0 to 1
      
      for j = 0 to 1
        
        this.currentList.push(new Current(-50 + (i * 12), 12 + (j * 12), 2))
      end
      
    end
    
    for i = 0 to 1
      
      for j = 0 to 1
        
        this.currentList.push(new Current(48 + (i * 12), -80 + (j * 12), 2))
      end
      
    end
    
    this.risingRockList = [
      new RisingRock(0, 80, 0, [2000, 1000, 3000])
      new RisingRock(12, 80, 0, [2000, 1000, 3000])
      new RisingRock(0, 68, 0, [2000, 1000, 3000])
      new RisingRock(12, 68, 0, [2000, 1000, 3000])
      
      new RisingRock(-36, 80, 0, [1000, 2000, 3000])
      new RisingRock(-48, 80, 0, [1000, 2000, 3000])
      new RisingRock(-36, 68, 0, [1000, 2000, 3000])
      new RisingRock(-48, 68, 0, [1000, 2000, 3000])
      
      new RisingRock(0, -80, 0, [2000, 1000, 3000])
      new RisingRock(12, -80, 0, [2000, 1000, 3000])
      new RisingRock(0, -68, 0, [2000, 1000, 3000])
      new RisingRock(12, -68, 0, [2000, 1000, 3000])
      
    ]
    
    for j = 0 to 4
        
      this.risingRockList.push(new RisingRock(-72 + (j * 12), -25, 1, [2000, 2000, 2000]))
    end
    
  end
  
  init = function()
    
    this.playerShip = new Ship(75, 75)
    this.playerShip.init()
    this.light = new Light(this.playerShip, 50, 50)
    this.light.init()
    
    for current in this.currentList
      current.init()
    end
    
    for risingRock in this.risingRockList
      risingRock.init()
    end
    
    this.isActive = true
    
  end
  
  testPlayerInCurrent = function()
    
    for current in this.currentList
      
      if this.testActorCollision(this.playerShip, current) then
        
        current.pushActor(this.playerShip)
        break
      end
    end
    
  end
  
  
  updateRisingRocks = function()
    
    for risingRock in this.risingRockList
      
      risingRock.update()
    end
    
  end
  
  testPlayerInRisingRock = function()
    
    for risingRock in this.risingRockList
      
      if risingRock.state == risingRock.states.RISEN and this.testActorCollision(this.playerShip, risingRock) then
        
        this.playerShip.drownTimeout(75, 75, 3000)
        break
      end
    end
    
  end
  
  update = function()
    
    if this.isActive then
      
      this.light.update()
      
      this.updateRisingRocks()
      this.testPlayerInRisingRock()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      this.testPlayerInCurrent()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level14") then
        this.playerShip.drownTimeout(75, 75, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level15")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level14", 0, 0, 200, 200 )
      
      for risingRock in this.risingRockList
        risingRock.draw()
      end
      
      for current in this.currentList
        current.draw()
      end
      
      //this.light.draw()
      
      this.playerShip.draw()
    end
  end
  
end
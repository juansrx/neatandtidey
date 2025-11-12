Level10 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.risingRockList = [
      new RisingRock(0, 0, 0, [2000, 1000, 3000])
      new RisingRock(12, 0, 0, [2000, 1000, 3000])
      new RisingRock(0, 12, 0, [2000, 1000, 3000])
      new RisingRock(12, 12, 0, [2000, 1000, 3000])
      
      new RisingRock(0, -36, 0, [2000, 1000, 3000])
      new RisingRock(12, -36, 0, [2000, 1000, 3000])
      new RisingRock(0, -48, 0, [2000, 1000, 3000])
      new RisingRock(12, -48, 0, [2000, 1000, 3000])
    ]
    
    for j = 0 to 4
        
      this.risingRockList.push(new RisingRock(-72 + (j * 12), -25, 1, [2000, 2000, 2000]))
    end
    
  end
  
  init = function()
    
    this.playerShip = new Ship(-92, -37)
    this.playerShip.init()
    
    for risingRock in this.risingRockList
      risingRock.init()
    end
    
    this.isActive = true
    
  end
  
  
  updateRisingRocks = function()
    
    for risingRock in this.risingRockList
      
      risingRock.update()
    end
    
  end
  
  testPlayerInRisingRock = function()
    
    for risingRock in this.risingRockList
      
      if risingRock.state == risingRock.states.RISEN and this.testActorCollision(this.playerShip, risingRock) then
        
        this.playerShip.drownTimeout(-92, -37, 3000)
        break
      end
    end
    
  end
  
  update = function()
    
    if this.isActive then
      
      this.updateRisingRocks()
      this.testPlayerInRisingRock()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level10") then
        this.playerShip.drownTimeout(-92, -37, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level11")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level10", 0, 0, 200, 200 )
      
      
      for risingRock in this.risingRockList
        risingRock.draw()
      end
      
      screen.drawText("Some waves require the", 0, 85, 10, "yellow")
      screen.drawText("right time to be passed", 0, 75, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
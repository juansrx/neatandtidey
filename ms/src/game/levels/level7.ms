Level7 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.cyclopList = [
      new Cyclop(75, 50, -1, 3000)
      new Cyclop(75, 38, -1, 3000)
    ]
    
    this.currentList = [
      new Current(-25, -25, 1)
      new Current(-37, -25, 1)
      new Current(-49, -25, 1)
      new Current(-61, -25, 1)
      
      new Current(-25, -37, 1)
      new Current(-37, -37, 1)
      new Current(-49, -37, 1)
      new Current(-61, -37, 1)
      
      new Current(-25, -49, 1)
      new Current(-37, -49, 1)
      new Current(-49, -49, 1)
      new Current(-61, -49, 1)
      
      new Current(-25, -61, 1)
      new Current(-37, -61, 1)
      new Current(-49, -61, 1)
      new Current(-61, -61, 1)
    ]
  end
  
  init = function()
    
    this.playerShip = new Ship(-70, 90)
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
        this.playerShip.drownTimeout(-70, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level7") then
        this.playerShip.drownTimeout(-70, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level8")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level7", 0, 0, 200, 200 )
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      for current in this.currentList
        current.draw()
      end
      
      screen.drawText("Watch out for the current!", 0, 70, 10, "yellow")
      this.playerShip.draw()
    end
  end
  
end
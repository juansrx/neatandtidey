Level19 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.currentList = [
    ]
    
    for i = 0 to 8
      this.currentList.push(new Current(-70 + (i * 12), 80, 2))
    end
    
    this.cyclopList = [
      new Cyclop(25, -95, 1, 4000, new BarrelFactory(25, -95, 0, 2))
    ]
    
    this.dolphinList = [
      new Dolphin(-80, 40, 1, 0, 0, [3000, 3000, 3000])
      new Dolphin(-8, 26, -1, 0, 1, [3000, 3000, 3000])
      
      new Dolphin(-8, 0, -1, 0, 1, [3000, 3000, 3000])
      new Dolphin(-80, -14, 1, 0, 0, [3000, 3000, 3000])
      
      new Dolphin(-80, -40, 1, 0, 0, [3000, 3000, 3000])
      new Dolphin(-8, -54, -1, 0, 1, [3000, 3000, 3000])
    ]
    
    for i = 0 to 12
      this.dolphinList.push(new Dolphin(66, 66 - (i * 12), 0, 0, i % 2, [3000, 3000, 3000]))
    end
    
  end
  
  init = function()
    
    this.playerShip = new Ship(75, 90)
    this.playerShip.init()
    
    
    for current in this.currentList
      current.init()
    end
    
    for cyclop in this.cyclopList
      cyclop.init()
    end
    
    for dolphin in this.dolphinList
      dolphin.init()
    end
    
    this.isActive = true
    
  end
  
  updateDolphins = function()
    
    for dolphin in this.dolphinList
      
      if this.testMapCollision(dolphin.position, dolphin.w, dolphin.h, "level19") then
        dolphin.speed *= -1
      end
      
      dolphin.update()
    end
    
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
  
  testPlayerCollisionWithDolphin = function()
    
    for dolphin in this.dolphinList
      
      if dolphin.state == dolphin.states.RISEN and this.testActorCollision(this.playerShip, dolphin) then
        
        this.playerShip.drownTimeout(75, 90, 3000)
        break
      end
    end
    
  end

  
  update = function()
    
    if this.isActive then
      
      
      this.updateCyclops()
      this.updateDolphins()
      this.testPlayerCollisionWithDolphin()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      this.testPlayerInCurrent()
      
      if spriteCollision("barrel1", "ship1") then
        this.playerShip.drownTimeout(75, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level19") then
        this.playerShip.drownTimeout(75, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level20")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level19", 0, 0, 200, 200 )

      
      for current in this.currentList
        current.draw()
      end
      
      for dolphin in this.dolphinList
        dolphin.draw()
      end
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      
      screen.drawText("We're almost there!. I can feel it", 0, 85, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
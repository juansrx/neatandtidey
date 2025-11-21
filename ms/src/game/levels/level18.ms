Level18 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.currentList = [
      new Current(0, 80, 2)
    
      new Current(0, 54, 2)
      new Current(0, 42, 0)
      new Current(0, 28, 2)
      
      new Current(0, 0, 2)
      new Current(0, -14, 1)
      new Current(0, -28, 2)
      
      new Current(0, -56, 2)
      new Current(0, -70, 2)
    ]
    
    this.cyclopList = [
      new Cyclop(-80, 12, 1, 10000, new BarrelFactory(-80, 12, 2, 0))
    ]
    
    this.dolphinList = [
      new Dolphin(0, 80, 0, 0.5, 0, [1000, 1000, 3000])
      new Dolphin(40, 66, 0, -0.5, 0, [2000, 2000, 3000])
      
      new Dolphin(30, 30, 0, 0, 1, [1000, 2000, 3000])
      
      new Dolphin(50, 0, 0, 0, 0, [2000, 1000, 3000])
      
      new Dolphin(75, -40, 0, 0, 0, [1000, 1000, 4000])
      
      new Dolphin(-50, -85, 0, 0, 1, [1000, 1000, 2000])
    ]
    
  end
  
  init = function()
    
    this.playerShip = new Ship(-50, 90)
    this.light = new Light(this.dolphinList[0], 200, 75)
    this.playerShip.init()
    this.light.init()
    
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
      
      if this.testMapCollision(dolphin.position, dolphin.w, dolphin.h, "level18") then
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
        
        this.playerShip.drownTimeout(-50, 90, 3000)
        break
      end
    end
    
  end

  
  update = function()
    
    if this.isActive then
      
      this.light.update()
      
      this.updateCyclops()
      this.updateDolphins()
      this.testPlayerCollisionWithDolphin()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      this.testPlayerInCurrent()
      
      if spriteCollision("barrel1", "ship1") then
        this.playerShip.drownTimeout(-50, 90, 3000)
      end
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level18") then
        this.playerShip.drownTimeout(-50, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level19")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level18", 0, 0, 200, 200 )

      
      for current in this.currentList
        current.draw()
      end
      
      for dolphin in this.dolphinList
        dolphin.draw()
      end
      
      for cyclop in this.cyclopList
        cyclop.draw()
      end
      
      this.light.draw()
      
      screen.drawText("Don't ask...", 0, 85, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
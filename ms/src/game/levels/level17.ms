Level17 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.dolphinList = [
      new Dolphin(0, 52, 0, 0, 0, [2000, 1000, 3000])
      new Dolphin(-12, 52, 0, 0, 1, [2000, 1000, 3000])
      
      new Dolphin(30, 30, 0, 0.5, 1, [1000, 2000, 3000])
      
      new Dolphin(50, 0, 1, 0, 0, [2000, 1000, 3000])
      
      new Dolphin(75, -20, -1, 0, 0, [1000, 1000, 4000])
      
      new Dolphin(-50, -75, -0.5, 0.5, 1, [1000, 1000, 2000])
    ]
    
  end
  
  init = function()
    
    this.playerShip = new Ship(20, 80)
    this.light = new Light(this.playerShip, 50, 50)
    this.playerShip.init()
    this.light.init()
    
    for dolphin in this.dolphinList
      dolphin.init()
    end
    
    this.isActive = true
    
  end
  
  
  updateDolphins = function()
    
    for dolphin in this.dolphinList
      
      if this.testMapCollision(dolphin.position, dolphin.w, dolphin.h, "level17") then
        dolphin.speed *= -1
      end
      
      dolphin.update()
    end
    
  end
  
  testPlayerCollisionWithDolphin = function()
    
    for dolphin in this.dolphinList
      
      if dolphin.state == dolphin.states.RISEN and this.testActorCollision(this.playerShip, dolphin) then
        
        this.playerShip.drownTimeout(20, 80, 3000)
        break
      end
    end
    
  end

  
  update = function()
    
    if this.isActive then
      
      this.light.update()
      
      this.updateDolphins()
      this.testPlayerCollisionWithDolphin()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level17") then
        this.playerShip.drownTimeout(20, 80, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level18")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level17", 0, 0, 200, 200 )
      
      for dolphin in this.dolphinList
        dolphin.draw()
      end
      
      this.light.draw()
      
      screen.drawText("There is something", 0, 85, 10, "yellow")
      screen.drawText("in the water...", 0, 75, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
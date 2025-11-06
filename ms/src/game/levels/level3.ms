Level3 = class extends BaseLevel
  
  constructor = function(gameState)
    
    super(gameState)
    this.barrelList = [
      new Barrel(75, 25, -0.5, 0)
      new Barrel(50, -25, -0.5, 0)
      new Barrel(75, -50, -0.5, 0)
    ]
  end
  
  init = function()
    
    this.playerShip = new Ship(-20, 90)
    this.playerShip.init()
    
    for barrel in this.barrelList
      barrel.init()
    end
    
    this.isActive = true
    
  end
  
  updateBarrels = function()
    
    for barrel in this.barrelList
      
      if abs(barrel.position.x) >= screen.width / 2 then
        barrel.speed.x = -barrel.speed.x
      end
      
      barrel.update()
    end
    
  end
  
  testPlayerBarrelCollisions = function()
    
    if spriteCollision("barrel1", "ship1") then
      this.playerShip.drownTimeout(-20, 90, 3000)
    end
    
  end

  update = function()
    
    if this.isActive then
      
      this.updateBarrels()
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      this.testPlayerBarrelCollisions()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level3") then
        this.playerShip.drownTimeout(-20, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level4")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level3", 0, 0, 200, 200 )
      
      for barrel in this.barrelList
        barrel.draw()
      end
      
      screen.drawText("Those barrels look dangerous", 0, 70, 10, "yellow")
      screen.drawText("Why would anyone litter like that?", 0, 60, 10, "yellow")
      
      this.playerShip.draw()
      
    end
  end
  
end
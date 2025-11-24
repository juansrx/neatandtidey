Level20 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.playerShip = new Ship(0, 80)
    this.dragonList = [
      new Dragon([[35, -38], [-35, -38]], 0.5, 4000, new FireballFactory(0, 0, 1, this.playerShip))
    ]
  end
  
  init = function()
    
    
    this.playerShip.init()
    
    for dragon in this.dragonList
      dragon.init()
    end
    
    this.isActive = true
  end
  
  updateDragons = function()
    
    for dragon in this.dragonList
      dragon.update()
    end
  end

  update = function()
    
    if this.isActive then
      
      this.updateDragons()
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level20") then
        this.playerShip.drownTimeout(0, 80, 3000)
      end
      
      if spriteCollision("dragon1", "ship1") then
        this.playerShip.drownTimeout(0, 80, 3000)
      end
      
      if spriteCollision("fireball1", "ship1") then
        this.playerShip.drownTimeout(0, 80, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level21")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level20", 0, 0, 200, 200 )
      screen.drawText("Hic Sunt Dracones", 0, 70, 10, "red")
      
      for dragon in this.dragonList
        dragon.draw()
      end
      
      this.playerShip.draw()
    end
  end
  
end
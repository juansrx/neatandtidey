Level23 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.playerShip = new Ship(0, 80)
    this.dragonList = [
      new Dragon([[-48, -60]], 1, 5000, new FireballFactory(0, 0, 2, this.playerShip))
      new Dragon([[48, -60]], 1, 5000, new FireballFactory(0, 0, 2, this.playerShip))
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
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level23") then
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
        this.gameState.changeTo("level24")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level23", 0, 0, 200, 200 )
      
      for dragon in this.dragonList
        dragon.draw()
      end
      
      this.playerShip.draw()
    end
  end
  
end
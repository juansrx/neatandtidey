Level11 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
    this.currentList = []
    
    for i = 0 to 12
      
      local dir = i % 2
      
      for j = 0 to 14
        
        this.currentList.push(new Current(-84 + (j * 12), 72 - (i * 12), dir))
      end
    end
    
    
  end
  
  init = function()
    
    this.playerShip = new Ship(-80, 90)
    this.playerShip.init()
    
    for current in this.currentList
      current.init()
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
  
  
  update = function()
    
    if this.isActive then
      
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      this.testPlayerInCurrent()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level11") then
        this.playerShip.drownTimeout(-80, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level12")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level11", 0, 0, 200, 200 )
      
      
      for current in this.currentList
        current.draw()
      end
      
      
      this.playerShip.draw()
    end
  end
  
end
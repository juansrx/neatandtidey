Level4 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
  end
  
  init = function()
    
    this.playerShip = new Ship(-20, 90)
    this.playerShip.init()
    
    this.isActive = true
    
  end

  update = function()
    
    if this.isActive then
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level4") then
        this.playerShip.drownTimeout(-20, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level5")
      end
      
      if this.playerShip.position.x <= (-screen.width / 2) then
        this.isActive = false
        this.gameState.changeTo("greece")
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level4", 0, 0, 200, 200 )
      
      this.playerShip.draw()
    end
  end
  
end
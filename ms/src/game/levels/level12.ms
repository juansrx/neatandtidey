Level12 = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
    
  end
  
  init = function()
    
    this.playerShip = new Ship(50, 90)
    this.light = new Light(this.playerShip, 50, 50)
    this.playerShip.init()
    this.light.init()
    
    this.isActive = true
    
  end

  
  update = function()
    
    if this.isActive then
      
      this.light.update()
      
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level12") then
        this.playerShip.drownTimeout(50, 90, 3000)
      end
      
      if this.playerShip.position.y <= (-screen.height / 2) + this.playerShip.h then
        this.isActive = false
        this.gameState.changeTo("level13")
      end
      
      
      this.keepActorInBounds(this.playerShip)
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level12", 0, 0, 200, 200 )

      this.light.draw()
      screen.drawText("Oh, now we have the low light gimmick", 0, 85, 10, "yellow")
      
      this.playerShip.draw()
    end
  end
  
end
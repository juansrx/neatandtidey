Level1 = class extends BaseLevel
  
  init = function()
    
    this.playerShip = new Ship(0, 0)
    this.playerShip.init()
    
    this.isActive = true
    
  end

  update = function()
    
    if this.isActive then
    
      if mouse.release then
        this.playerShip.moveTowards(mouse.x, mouse.y)
      end
      
      this.playerShip.update()
      
      if this.testMapCollision(this.playerShip.position, this.playerShip.w, this.playerShip.h, "level1", "rock1") then
        this.playerShip.drown()
        this.playerShip.setPositionTimeout(0, 0, 40)
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "level1", 0, 0, 200, 200 )
      screen.drawText("1. Click on the position you want to reach", 0, 70, 7, "yellow")
      screen.drawText("2. Evade anything that isn't water", 0, 50, 7, "yellow")
      screen.drawTextOutline("1. Click on the position you want to reach", 0, 70, 7, "red")
      screen.drawTextOutline("2. Evade anything that isn't water", 0, 50, 7, "red")
      
      this.playerShip.draw()
    end
  end
  
end
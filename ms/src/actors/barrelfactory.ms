BarrelFactory = class
  
  constructor = function(pX, pY, vX, vY)
  
    this.barrelList = []
    this.position = new Vector2(pX, pY)
    this.barrelSpeed = new Vector2(vX, vY)
  end
  
  createBarrel = function()
    
    local barrel = new Barrel(this.position.x, this.position.y, this.barrelSpeed.x, this.barrelSpeed.y)
    barrel.init()
    this.barrelList.push(barrel)
  end
  
  updateBarrelList = function()
    
    for barrel in this.barrelList
      
        barrel.update()
        if abs(barrel.position.x) > screen.width / 2 or abs(barrel.position.y) > screen.height / 2  then
        
          barrel.state = barrel.states.NOT_ACTIVE
        end
        
    end
    
    this.barrelList = this.barrelList.filter(function(barrel) return barrel.state != barrel.states.NOT_ACTIVE end)
    
  end
  
  drawBarrelList = function()
    
    for barrel in this.barrelList
        
      barrel.draw()
    end
    
  end
  
end
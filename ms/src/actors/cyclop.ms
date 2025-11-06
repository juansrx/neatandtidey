Cyclop = class
  
  constructor = function(pX, pY, dir, throwMs)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
    
    this.directions = object
      RIGHT = 1
      LEFT = -1
    end
  
    this.state = this.states.NOT_ACTIVE
    this.position = new Vector2(pX, pY)
    this.w = this.h = 12
    this.throwMs = throwMs
    this.direction = dir
    
    this.barrelList = []
  end
  
  throwBarrel = function()
    
    local barrel = new Barrel(this.position.x, this.position.y, 0.5 * this.direction, 0)
    barrel.init()
    this.barrelList.push(barrel)
    
  end
  
  init = function()
    
    this.throwTimer = 0
    this.state = this.states.ACTIVE
  end
  
  update = function()
    
    if this.state == this.states.ACTIVE then
      
      if system.time() >= this.throwMs + this.throwTimer then
        
        this.throwBarrel()
        this.throwTimer = system.time()
      end
  
      for barrel in this.barrelList
      
        barrel.update()
        if barrel.position.x <= -screen.width / 2 then
        
          barrel.state = barrel.states.NOT_ACTIVE
        end
      end
    
      this.barrelList = this.barrelList.filter(function(barrel) return barrel.state != barrel.states.NOT_ACTIVE end)
    end
    
  end
  
  draw = function()
    
    if this.state == this.states.ACTIVE then
      
      local spriteMap = object
        "1" = "cyclop2"
        "-1" = "cyclop1"
      end
      
      screen.drawSprite(spriteMap[this.direction], this.position.x, this.position.y, this.w, this.h)
      
      for barrel in this.barrelList
        
        barrel.draw()
      end
    end
    
  end
  
end
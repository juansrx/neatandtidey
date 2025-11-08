Cyclop = class
  
  constructor = function(pX, pY, dir, throwMs, barrelFactory)
  
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
    
    this.barrelFactory = barrelFactory
  end
  
  init = function()
    
    this.throwTimer = 0
    this.state = this.states.ACTIVE
  end
  
  update = function()
    
    if this.state == this.states.ACTIVE then
      
      if system.time() >= this.throwMs + this.throwTimer then
        
        this.barrelFactory.createBarrel()
        this.throwTimer = system.time()
      end
  
      this.barrelFactory.updateBarrelList()
    end
    
  end
  
  draw = function()
    
    if this.state == this.states.ACTIVE then
      
      local spriteMap = object
        "1" = "cyclop2"
        "-1" = "cyclop1"
      end
      
      screen.drawSprite(spriteMap[this.direction], this.position.x, this.position.y, this.w, this.h)
      
      this.barrelFactory.drawBarrelList()
    end
    
  end
  
end
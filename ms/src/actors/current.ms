Current = class
  
  constructor = function(pX, pY, dir)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
    
    this.directions = object
      RIGHT = 0
      LEFT = 1
    end
    
    this.state = this.states.NOT_ACTIVE
    this.position = new Vector2(pX, pY)
    this.w = this.h = 12
    this.direction = dir
    
  end
  
  init = function()
    
    this.state = this.states.ACTIVE
  end
  
  update = function()
    
  end
  
  pushActor = function(actor)
    
    if this.state == this.states.ACTIVE then
      
      local forceMap = object
        "0" = [0.5, 0]
        "1" = [-0.5, 0]
      end
      
      //actor.position.y = this.position.y
      actor.position += forceMap[this.direction]
      
    end
    
  end
  
  draw = function() 
    
    if this.state == this.states.ACTIVE then
      
      local spriteMap = object
        "0" = "current2"
        "1" = "current1"
      end
      
      screen.drawSprite(spriteMap[this.direction], this.position.x, this.position.y, this.w, this.h)
      
    end
  end
  
end
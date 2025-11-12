Current = class
  
  constructor = function(pX, pY, dir)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
    
    this.directions = object
      RIGHT = 0
      LEFT = 1
      UP = 2
      DOWN = 3
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
        "2" = [0, 0.5]
        "3" = [0, -0.5]
      end
      
      //actor.position.y = this.position.y
      actor.position += forceMap[this.direction]
      
    end
    
  end
  
  draw = function() 
    
    if this.state == this.states.ACTIVE then
      
      local spriteMap = object
        "0" = [-1, 1]
        "1" = [1, 1]
        "2" = [-1, 1]
        "3" = [1, 1]
      end
      
      
      screen.setDrawScale(spriteMap[this.direction][0], spriteMap[this.direction][1])
      screen.drawSprite("current1", this.position.x, this.position.y, this.w, this.h)
      screen.setDrawScale(1, 1)
      
    end
  end
  
end
Barrel = class
  
  constructor = function(pX, pY, vX, vY)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
  
    this.state = this.states.NOT_ACTIVE
    this.position = new Vector2(pX, pY)
    this.speed = new Vector2(vX, vY)
    this.w = this.h = 8
    
  end
  
  init = function()
    
    this.state = this.states.ACTIVE
  end
  
  
  update = function()
    
    if this.state == this.states.ACTIVE then
      this.position += this.speed
    end
  end
  
  draw = function()
    
    if this.state == this.states.ACTIVE then
      screen.drawSprite( "barrel1", this.position.x, this.position.y, this.w, this.h)
    end
  end
  
end
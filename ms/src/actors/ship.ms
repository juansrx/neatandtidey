Ship = class
  
  constructor = function(pX, pY)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
      MOVING = 2
      DROWNING = 3
      DROWNED = 4
    end
  
    this.state = this.states.NOT_ACTIVE
    this.position = new Vector2(pX, pY)
    this.w = this.h = 12
    
    this.positionTimeout = []
  end

  init = function()
    this.state = this.states.ACTIVE
  end

  update = function()
    
    if this.state == this.states.MOVING then
      
      local dVector = this.finalPosition - this.position
      if dVector.magnitude() <= 1 then
        this.speed = new Vector2(0, 0)
        this.state = this.states.ACTIVE
      else
        this.position += this.speed
      end  
        
    end
    
    if this.state == this.states.DROWNING then
      
      if system.time() - this.positionTimeout[3] >= this.positionTimeout[2] then

        this.speed = new Vector2(0, 0)
        this.position = new Vector2(this.positionTimeout[0], this.positionTimeout[1])
        this.state = this.states.ACTIVE
        this.positionTimeout = []
      end
    end
    
  end
  
  setPositionTimeout = function(x, y, ms)
  
    this.positionTimeout = [x, y, ms, system.time()]
  end
  
  moveTowards = function(pX, pY)
    
    if (this.state != this.states.ACTIVE) then
      return
    end
    
    this.finalPosition = new Vector2(pX, pY)
    this.speed = this.finalPosition - this.position
    this.speed.normalise()
    this.state = this.states.MOVING
    
  end
  
  drown = function()
    
      if this.state != this.states.DROWNING then
        this.state = this.states.DROWNING
      end
      
  end

  draw = function()
    
    if this.state == this.states.ACTIVE or this.states.MOVING then
      screen.drawSprite( "ship1", this.position.x, this.position.y, this.w, this.h)
    end
    
    if this.state == this.states.DROWNING then
      screen.drawSprite( "ship2", this.position.x, this.position.y, this.w, this.h)
    end
    
    
  end
  
end
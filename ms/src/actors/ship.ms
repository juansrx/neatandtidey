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
    this.w = this.h = 10
    
    this.positionTimeout = []
  end

  init = function()
    this.state = this.states.ACTIVE
  end

  update = function()
    
    if this.state == this.states.MOVING then
      
      // The speed re calculation is needed
      // to keep the ship "in course"
      this.speed = this.finalPosition - this.position
      this.speed.normalise()
      local dVector = this.finalPosition - this.position
      if dVector.magnitude() <= 1 then
        this.stop()
      else
        this.position += this.speed
      end  
        
    end
    
    if this.state == this.states.DROWNING then
      
      if system.time() >= this.positionTimeout[2] then

        this.stop()
        this.position = new Vector2(this.positionTimeout[0], this.positionTimeout[1])
        this.positionTimeout = []
      end
    end
    
  end
  
  moveTowards = function(pX, pY)
    
    if (this.state != this.states.ACTIVE) then
      return
    end
    
    this.finalPosition = new Vector2(pX, pY)
    this.state = this.states.MOVING
    
  end
  
  stop = function()
    
    this.speed = new Vector2(0, 0)
    this.state = this.states.ACTIVE
  end
  
  drownTimeout = function(pX, pY, ms)
    
      if this.state != this.states.DROWNING then
        this.state = this.states.DROWNING
        this.positionTimeout = [pX, pY, system.time() + ms]
      end
      
  end

  draw = function()
    
    if this.state == this.states.ACTIVE or this.states.MOVING then
      screen.drawSprite( "ship1", this.position.x, this.position.y, this.w, this.h)
      
      screen.drawLine(this.position.x, this.position.y, mouse.x, mouse.y, "white")
    end
    
    if this.state == this.states.DROWNING then
      screen.drawSprite( "ship2", this.position.x, this.position.y, this.w, this.h)
    end
    
  end
  
end
Dragon = class
  
  constructor = function(path, spd, throwMs, fireballFactory)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
    
    this.directions = object
      RIGHT = 0
      LEFT = 1
    end
    
    this.state = this.states.NOT_ACTIVE
    this.w = 12
    this.h = this.w * 4
    
    this.path = path
    this.speed = new Vector2(0, 0)
    this.spd = spd
    
    this.throwMs = throwMs
    this.fireballFactory = fireballFactory
    
  end
  
  setToNextPoint = function()
    
    this.position = new Vector2(this.path[this.currPos][0], this.path[this.currPos][1])
    this.finalPosition = new Vector2(
      this.path[(this.currPos + 1) % this.path.length][0], 
      this.path[(this.currPos + 1) % this.path.length][1]
    )
    
    this.speed = this.finalPosition - this.position
    this.speed.setMagnitude(this.spd)
    
    if this.speed.x >= 0 then
      
      this.direction = this.directions.RIGHT
    else
      
      this.direction = this.directions.LEFT
    end
    
  end
  
  init = function()
    
    this.throwTimer = system.time()
    this.currPos = 0
    this.setToNextPoint()
    this.fireballFactory.position = this.position * 1
    
    this.state = this.states.ACTIVE
  end
  
  update = function()
    
    if this.state == this.states.ACTIVE then
      
      local dVector = this.finalPosition - this.position
      if dVector.magnitude() <= 1 then
        
        this.currPos = (this.currPos + 1) % this.path.length
        this.setToNextPoint()
        
      else
        
        this.position += this.speed
      end
      
      if system.time() >= this.throwMs + this.throwTimer then
        
        this.fireballFactory.position = this.position * 1
        this.fireballFactory.createFireball()
        this.throwTimer = system.time()
        audio.playSound("fireball1", 0.5, 1)
      end
  
      this.fireballFactory.updateFireballList()
        
    end
    
  end
  
  draw = function()
    
      if this.state == this.states.ACTIVE then
        
        local spriteMap = object
          "0" = [-1, 1]
          "1" = [1, 1]
        end
      
        screen.setDrawScale(spriteMap[this.direction][0], spriteMap[this.direction][1])
        screen.drawSprite("dragon1", this.position.x, this.position.y, this.w, this.h)
        screen.setDrawScale(1, 1)
        
        this.fireballFactory.drawFireballList()
      end
  end
  
end
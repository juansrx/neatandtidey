RisingRock = class
  
  constructor = function(pX, pY, dir, timersByState)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
      RISING = 2
      RISEN = 3
    end
    
    this.directions = object
      RIGHT = 0
      LEFT = 1
    end
    
    this.state = this.states.NOT_ACTIVE
    this.position = new Vector2(pX, pY)
    this.w = this.h = 12
    this.direction = dir
    
    // fromState -> startTime, durationOfState, toState
    this.timersByState = object
      "1" = [0, timersByState[0], this.states.RISING]
      "2" = [0, timersByState[1], this.states.RISEN]
      "3" = [0, timersByState[2], this.states.ACTIVE]
    end
    
    this.spritesByState = object
      "1" = [0, 11]
      "2" = [12, 25]
      "3" = [26, 28]
    end
    
  end
  
  init = function()
    
    this.state = this.states.ACTIVE
    this.timersByState[this.state][0] = system.time()
    this.currentSprite = this.spritesByState[this.state][0]
  end
  
  update = function()
    
    local currTime = system.time()
    local currTimer = this.timersByState[this.state]
    
    if currTime - currTimer[0] >= currTimer[1] then
      
      this.timersByState[this.state][0] = 0
      this.state = this.timersByState[this.state][2]
      this.timersByState[this.state][0] = currTime
      this.currentSprite = this.spritesByState[this.state][0]
    else
      
      this.currentSprite = this.currentSprite + 1
      
      if this.currentSprite > this.spritesByState[this.state][1] then
        this.currentSprite = this.spritesByState[this.state][0]
      end
      
    end
    
  end
  
  draw = function()
    
      if this.state != this.states.NOT_ACTIVE then
        
        local spriteMap = object
          "0" = [-1, 1]
          "1" = [1, 1]
        end
      
      
        screen.setDrawScale(spriteMap[this.direction][0], spriteMap[this.direction][1])
        screen.drawSprite("risingrock1." + this.currentSprite, this.position.x, this.position.y, this.w, this.h)
        screen.setDrawScale(1, 1)
      end
  end
  
end
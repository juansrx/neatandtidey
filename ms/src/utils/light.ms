Light = class
  
  constructor = function(actor, w, h)
  
    this.states = object
      NOT_ACTIVE = 0
      ACTIVE = 1
    end
  
    this.state = this.states.NOT_ACTIVE
    this.w = w
    this.h = h
    
    this.actor = actor
    
  end

  init = function()
    this.state = this.states.ACTIVE
  end

  update = function()
    
  end
  

  draw = function()
    
    if this.state == this.states.ACTIVE then
      
      // From the border left of the screen to the actor
      // position - light width / 2 + 100
      local tPos = this.actor.position.x - (this.w / 2) + (screen.width / 2)
      screen.fillRect(-screen.width / 2, 0, tPos * 2, screen.height, "rgb(0, 0, 0)")
      
      // From the border right of the screen to 100 - the actor
      // position - light width / 2
      tPos = (screen.width / 2) - this.actor.position.x - (this.w / 2)
      screen.fillRect(screen.width / 2, 0, tPos * 2, screen.height, "rgb(0, 0, 0)")
      
      // From the bottom of the screen to the actor
      // position - light height / 2 + 100
      tPos = this.actor.position.y - this.h / 2 + (screen.height / 2)
      screen.fillRect(0, -screen.height / 2, screen.width, tPos * 2, "rgb(0, 0, 0)")
      
      // From the top of the screen to the actor
      // 100 - position - light height / 2
      tPos = (screen.height / 2) - this.actor.position.y - this.h / 2
      screen.fillRect(0, screen.height / 2, screen.width, tPos * 2, "rgb(0, 0, 0)")
    end
    
  end
  
end
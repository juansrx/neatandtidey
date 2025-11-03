Ship = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
    
    this.position = new Vector2(0, 50)
    
  end

  init = function()
    this.moving = false
    this.isActive = true
  end

  update = function()
    
    if this.moving then
      
      local dVector = this.finalPosition - this.position
      if dVector.magnitude() <= 1 then
        this.moving = false
      else
        this.position += this.speed
      end  
        
    end
    
  end
  
  moveTowards = function(pX, pY)
    
    this.finalPosition = new Vector2(pX, pY)
    this.speed = this.finalPosition - this.position
    this.speed.normalise()
    this.moving = true
    
  end

  draw = function()
    
    if this.isActive then
      screen.drawSprite( "ship1", this.position.x, this.position.y, 12, 12)
    end
  end
  
end
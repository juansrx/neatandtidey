FireballFactory = class
  
  constructor = function(pX, pY, spd, targetActor)
  
    this.fireballList = []
    this.position = new Vector2(pX, pY)
    this.targetActor = targetActor
    this.spd = spd
  end
  
  createFireball = function()
    
    local fireballSpeed = this.targetActor.position - this.position
    fireballSpeed.setMagnitude(this.spd)
    
    local fireball = new Fireball(this.position.x, this.position.y, fireballSpeed.x, fireballSpeed.y)
    fireball.init()
    this.fireballList.push(fireball)
  end
  
  updateFireballList = function()
    
    for fireball in this.fireballList
      
        fireball.update()
        if abs(fireball.position.x) > screen.width / 2 or abs(fireball.position.y) > screen.height / 2  then
        
          fireball.state = fireball.states.NOT_ACTIVE
        end
        
    end
    
    this.fireballList = this.fireballList.filter(function(barrel) return fireball.state != fireball.states.NOT_ACTIVE end)
    
  end
  
  drawFireballList = function()
    
    for fireball in this.fireballList
        
      fireball.draw()
    end
    
  end
  
end
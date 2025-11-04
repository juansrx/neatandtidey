StaticObstacle = class
  
  constructor = function(pX, pY, sprite)
    this.isActive = false
    this.position = new Vector2(pX, pY)
    this.sprite = sprite
  end
  
  init = function()
    this.isActive = true
  end
  
  update = function()
  end
  
  draw = function()
    
    if this.isActive then
      screen.drawSprite(this.sprite, this.position.x, this.position.y, 12, 12)
    end
  end
end
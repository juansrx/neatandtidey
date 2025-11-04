BaseLevel = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
    
    this.timers = object
    end
  end
  
  testMapCollision = function(positionVector, w, h, mapName, spriteName)
      return 
        mapHit(positionVector.x - w / 2, positionVector.y - h / 2, mapName) == spriteName or 
        mapHit(positionVector.x - w / 2, positionVector.y + h / 2, mapName) == spriteName or
        mapHit(positionVector.x + w / 2, positionVector.y - h / 2, mapName) == spriteName or
        mapHit(positionVector.x + w / 2, positionVector.y + h / 2, mapName) == spriteName
  end
  
end
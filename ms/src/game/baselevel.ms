BaseLevel = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
    
    this.mapHazards = ["rock1", "rock2", "island1", "island2"]
    
    this.mapHazards.contains("rock1")
    
    this.timers = object
    end
  end
  
  testMapCollision = function(positionVector, w, h, mapName, spriteName)
    
      return this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y + h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y + h / 2, mapName))
  end
  
end
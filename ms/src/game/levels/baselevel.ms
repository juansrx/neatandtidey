BaseLevel = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
    
    this.mapHazards = ["rock1", "rock2", "rock3", "island1", "island2", "green1", "green2", "sunkenship1"]
    
    this.timers = object
    end
  end
  
  testMapCollision = function(positionVector, w, h, mapName, spriteName)
    
      return this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y + h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y + h / 2, mapName))
  end
  
  keepActorInBounds = function (actor)
    
    
    if actor.position.x > screen.width / 2 then
      actor.position.x = screen.width / 2
      actor.stop()
    end
    
    if actor.position.x < -screen.width / 2 then
      actor.position.x = -screen.width / 2
      actor.stop()
    end
    
    if actor.position.y > screen.height / 2 then
      actor.position.y = screen.height / 2
      actor.stop()
    end
    
    if actor.position.y < -screen.height / 2 then
      actor.position.y = -screen.height / 2
      actor.stop()
    end
    
  end
  
end
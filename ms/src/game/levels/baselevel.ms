BaseLevel = class
  
  constructor = function(gameState)
    this.isActive = false
    this.gameState = gameState
    
    this.mapHazards = ["rock1", "rock2", "rock3", "rock4", "island1", "island2", "green1", "green2", "sunkenship1"]
    
    this.timers = object
    end
  end
  
  testMapCollision = function(positionVector, w, h, mapName, spriteName)
    
      return this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x - w / 2, positionVector.y + h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y - h / 2, mapName)) or
            this.mapHazards.contains(mapHit(positionVector.x + w / 2, positionVector.y + h / 2, mapName))
  end
  
  testActorCollision = function (actor1, actor2)
    
    return collision(actor1.position.x, actor1.position.y, actor1.w, actor1.h, actor2.position.x, actor2.position.y, actor2.w, actor2.h)
    
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
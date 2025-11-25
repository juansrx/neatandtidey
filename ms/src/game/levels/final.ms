Final = class extends BaseLevel
  
  constructor = function(gameState)
    super(gameState)
  end
  
  init = function()
    
    this.playerShip = new Ship(0, 80)
    this.playerShip.init()
    
    local me = this
    
    local assetManager = asset_manager.loadJSON(
      "credits", 
      function (obj)
        
        me.credits = obj.frames
        me.isActive = true
        me.inCredits = false
      end
    )
    
    while not assetManager
    end
    
  end
  
  
  rollCredits = function()
    
    this.currCredit = 0
    this.timers['credits'] = system.time()
    this.inCredits = true
  end

  update = function()
    
    if this.isActive then
    
      this.playerShip.moveTowards(0, -5)
      this.playerShip.update()
      
      if this.playerShip.position.y <= 0 and not this.inCredits then
        
        this.rollCredits()
      end
      
      if this.inCredits then
        
        this.updateCredits()
      end
      
    end
    
    
  end

  updateCredits = function()
    
    if this.currCredit < this.credits.length then
      
      if system.time() - this.timers['credits'] >= this.credits[this.currCredit].duration then
        
        this.currCredit+=1
        this.timers['credits'] = system.time()
      end
      
    end
    
  end

  draw = function()
    
    if this.isActive then
      
      screen.drawMap( "final", 0, 0, 200, 200 )
      
      this.playerShip.draw()
      
      if this.inCredits then 
        
        local i = 0
        for t in this.credits[this.currCredit].text
          
          screen.drawText(t, 0, 80 - i, 10, "red")
          i += 10
        end
        
      end
    
    end
    
  end
  
end
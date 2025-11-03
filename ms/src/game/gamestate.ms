GameState = class
  
  constructor = function()
    this.currState = new TitleScreen(this)
    
    this.stateMap = object
        level1 = new Level1(this)
    end
  end
  
  changeTo = function (name)

      this.currState = this.stateMap[name]
      this.currState.init()
  end

  init = function()
    this.currState.init()
  end

  update = function()
    this.currState.update()
  end

  draw = function()
    screen.clear()
    this.currState.draw()
  end
  
end
GameState = class
  
  constructor = function()
    this.currState = new TitleScreen(this)
    
    this.stateMap = object
        level1 = Level1
        level2 = Level2
        level3 = Level3
        level4 = Level4
        level5 = Level5
        level6 = Level6
        level7 = Level7
        level8 = Level8
        level9 = Level9
        level10 = Level10
        level11 = Level11
        greece = Greece
    end
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
  
  changeTo = function (name)

      delete this.currState
      this.currState = new this.stateMap[name](this)
      this.currState.init()
  end
  
end
GameState = class
  
  constructor = function()
    this.currState = new TitleScreen(this)
    
    this.songList = [
      "01anightofdizzyspells",
      "04allofus",
      "05comeandfindme",
      "10arpanauts",
      "14jumpshot",
      "17behindthewaterfallliesthebeg"
    ]
    
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
        level12 = Level12
        level13 = Level13
        level14 = Level14
        level15 = Level15
        level16 = Level16
        level17 = Level17
        level18 = Level18
        level19 = Level19
        level20 = Level20
        level21 = Level21
        level22 = Level22
        level23 = Level23
        level24 = Level24
        final = Final
        greece = Greece
    end
  end
  
  startPlaylist = function ()
    
    this.currMusic = audio.playMusic(this.songList[0], 0.5)
  end
  
  updatePlaylist = function ()
    
    if this.currMusic.getPosition() == this.currMusic.getDuration() then
      
      this.currMusic.stop()
      this.currMusic = audio.playMusic(this.songList[random.nextInt(this.songList.length)])
    end
  end

  init = function()
    
    this.startPlaylist()
    this.currState.init()
  end

  update = function()
    
    this.currState.update()
    this.updatePlaylist()
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
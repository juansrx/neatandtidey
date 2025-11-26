/*
 * mysoundmanager
 *
 * Custom sound manager
 */

if not audio.playSound0.type then
  audio.playSound0 = audio.playSound
end

if not audio.soundMap then
  
  audio.soundMap = object
  end
end

audio.playSound = function(n, v, t, p, r)
  
  if not audio.soundMap[n] or system.time() >= (audio.soundMap[n][0].getDuration() * 1000) + audio.soundMap[n][1] then
     
    audio.soundMap[n] = [
      audio.playSound0(n, v, t, p, r),
      system.time()
    ]
  
  end
    
  return audio.soundMap[n][0]
end

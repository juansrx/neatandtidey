/**
 * Collisions Library
 * 
 * Taken from https://microstudio.dev/i/microstudio/collisions/#
 * Made by microstudio
 */

hit = function( x, y, obj_x, obj_y, obj_w, obj_h)
  return abs( x-obj_x ) <= obj_w/2
     and abs( y-obj_y ) <= obj_h/2
end

collision = function(x1,y1,w1,h1,x2,y2,w2,h2)
  return abs(x1-x2) < (w1+w2)/2
     and abs(y1-y2) < (h1+h2)/2
end



// map collisions

if not screen.drawMap0.type then
  screen.drawMap0 = screen.drawMap
end

screen.drawMap = function(map,x,y,w,h)
  local m = map
  if m.type == "string" then m = maps[m] end

  m.screen_position = object
    x = x
    y = y
    w = w
    h = h
  end
  
  screen.drawMap0(map,x,y,w,h)
end

mapHit = function( x, y, map )
  if map.type == "string" then map = maps[map] end
  
  if not map then return 0 end
  if not map.screen_position then return 0 end
  
  local pos = map.screen_position
  
  local mx = pos.x-pos.w/2
  local my = pos.y-pos.h/2
  
  local dx = floor((x-mx)/pos.w*map.width)
  local dy = floor((y-my)/pos.h*map.height)
  
  if dx >= 0 and dx < map.width and dy >= 0 and dy < map.height then
    return map.get(dx,dy)
  else
    return 0
  end
end

// sprite collisions
screen.sprite_position_map = object
    time = 0
    map = object end
  end

if not screen.drawSprite0.type then
  screen.drawSprite0 = screen.drawSprite
end

screen.drawSprite = function(sprite,x,y,w,h)
  screen.drawSprite0(sprite,x,y,w,h)
  
  if sprite.type == "string" then
    local map = screen.sprite_position_map
    if system.time() > map.time then
      map.time = system.time()+8
      map.map = object end
    end
      
    local pos = map.map[sprite]
    if not pos then
      pos = map.map[sprite] = []
    end
    pos.push(object
      x = x
      y = y
      w = w
      h = h
    end)
  end
end

spriteHit = function( x, y, name )
  local map = screen.sprite_position_map
  local list = map.map[name]
  if list then
    for s in list
      if abs( s.x - x ) < s.w/2 and abs( s.y - y ) < s.h/2 then
        return s
      end
    end
  end
  
  return 0
end

spriteCollision = function( sprite1, sprite2 )
  local map = screen.sprite_position_map
  local list1 = map.map[sprite1]
  local list2 = map.map[sprite2]
  if list1 and list2 then
    for s1 in list1
      for s2 in list2
        if s1 != s2 and abs(s1.x-s2.x) < (s1.w+s2.w)/2 and abs(s1.y-s2.y) < (s1.h+s2.h)/2 then
          return [s1,s2]
        end
      end
    end
  end
  
  return 0
end

spriteCollisionList = function( sprite1, sprite2 )
  local map = screen.sprite_position_map
  local list1 = map.map[sprite1]
  local list2 = map.map[sprite2]
  local result = []
  if list1 and list2 then
    for s1 in list1
      for s2 in list2
        if s1 != s2 and abs(s1.x-s2.x) < (s1.w+s2.w)/2 and abs(s1.y-s2.y) < (s1.h+s2.h)/2 then
          result.push([s1,s2])
        end
      end
    end
  end
  
  return result
end


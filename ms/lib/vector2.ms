/**
* 
* Vector2 Library V1.0
* by PaulSt 
* 10.07.2023
* 
* 23.09.2023: .scale() accepts Vector2 and scales element wise
*
* free to use, credits are appreciated
*
*/

// ---- CONSTANTS ----

TO_RAD = PI/180
TO_DEG = 180/PI 
TAU = 2*PI

// ---- MODIFY CORE TYPES ----

Number.toDeg = function()
  return this*180/PI
end

Number.toRad = function()
  return this*PI/180
end


// ---- Vector2 class ----

Vector2 = class
  // class fields
  
  // class methods
  // read from object
  fromPosition = function(obj)
    local x = obj.x or obj.position.x
    local y = obj.y or obj.position.y
    return new Vector2(x, y)
  end
  
  fromVelocity = function(obj)
    local x = obj.vx or obj.velocity.x
    local y = obj.vy or obj.velocity.y
    return new Vector2(x, y)
  end
  
  // ==== CONSTRUCTOR ====
  constructor = function(x_=0, y_=0)
    set(x_, y_)
  end
  
  // ---- SET X AND Y ----
  
  // set vector
  // accepted inputs: (x,y), [x,y] and "object x:number y:number end" (including Vector2)
  set = function(x_=0, y_=0)
    if x_.type=="object" and x_.x.type=="number" and x_.y.type=="number" then
      x = x_.x
      y = x_.y
    elsif x_.type == "list" and x_.length >= 2 then
      x = x_[0]
      y = x_[1]
    else
      x = x_
      y = y_ 
    end
    return(this)
  end
  
  // set vector with polar coordinates
  setPolar = function(angle_, distance_)  
    if not(angle_.type=="number" and distance_.type=="number") then 
      set(0,0)
      // some error message
    end
    
    local x_ = distance_*cos(angle_)
    local y_ = distance_*sin(angle_)
    set(x_, y_)
    
    return this
  end
  
  setX = function(x_)
    if x_.type == "number" then x = x_ end
    return this
  end
  
  setY = function(y_)
    if y_.type == "number" then y = y_ end
    return this
  end
  
  // rounds coordinates to n decimals
  roundDec = function(dec = 10)
    local factor = 10^dec
    x = round(x * factor ) / factor
    y = round(y * factor ) / factor
    return this
  end
  
  clone = function()
    return new Vector2(this)
  end
  
  // ---- GET BASIC INFORMATION ----
  
  // returns array of coordinates
  toList = function()
    return [x, y]      
  end
  
  // returns magnitude squared
  magnitude2 = function()
    return (x^2 + y^2)
  end
  
  // returns magnitude/length of vector
  magnitude = function()
    return magnitude2()^(1/2)
  end
  
  // returns angle 
  angle = function()
    return atan2(y,x)
  end
  
  // returns angle from vector to input 
  angleTo = function(x_, y_)
    local a = new Vector2(x_, y_)
    local angle = atan2(a.y-y,a.x-x)
    return (angle + TAU) % (TAU)  // convert to range 0..2*PI
  end
  
  // returns true if coordinates are equal
  equals = function(x_, y_)
    local a = new Vector2(x_, y_)
    return ( x == a.x and y == a.y )
  end
  
  
  
  // ---- MANIPULATE MAGNITUDE ----
  
  // scale vector
  scale = function(scale_)
    if scale_.type == "number" then
      set(x*scale_, y*scale_)
    // scale element wise
    elsif scale_.type == "object" or scale.type == "list" then
      local s = new Vector2(scale_)
      set(x*s.x, y*s.y)
    
    else
      // add error message here
    end
    return this
  end
  
  // normalise vector (set magnitude to 1)
  normalise = function()
    scale(1/magnitude())
    return this
  end
  
  // set magnitude (length)
  setMagnitude = function(magn_)
    if magn_.type!="number" then return end
    scale(magn_/magnitude())
    return this
  end
  
  
  // ---- MANIPULATE ANGLE ----
  
  // set angle
  setAngle = function(angle_)
    if angle_.type!="number" then return end
    setPolar(angle_, magnitude())
  end
  
  // copy angle
  pointTo = function(x_, y_)
    local a = new Vector2(x_, y_)
    setAngle(a.angle())
  end
  
  // rotate vector around center, rotates around origin if no center defined
  rotate = function(angle_, center_)
   
    if angle_.type!="number" then 
      return // some error message
    end
    
    local c = new Vector2(center_)
    local centerIsGiven = c.x!=0 and c.y!=0
    
    if centerIsGiven then translate(-c) end
    setPolar(angle() + angle_, magnitude())
    if centerIsGiven then translate(c) end
    
    return this
  end
  
  // ---- MOVE ----
  
  // translate vector (move)
  translate = function(x_, y_)
    local a = new Vector2(x_, y_)
    set(x+a.x, y+a.y)
    return(this)
  end
  
  // translate vector with polar coordinates
  translatePolar = function(angle_, distance_)  
    
    if angle_.type!="number" or distance_.type!="number" then 
      return // some error message
    end
    
    local dx = distance_*cos(angle_)
    local dy = distance_*sin(angle_)
    set(x+dx, y+dy)
    
    return(this)
  end
  
   // same as translate
  add = function(x_, y_)
    translate(x_, y_)
  end
  
  // translate in opposite direction
  subtract = function(x_, y_)
    local a = new Vector2(x_, y_)
    set(x-a.x, y-a.y)
    return(this)
  end
  
  
  // ---- VECTOR MATH ---
  
  // determinante
  det = function(a_, b_)
    local a = new Vector2(a_)
    
    if b_ == 0 then
      return(x * a.y - y * a.x)
    else 
      b = new Vector2(b_)
      return(a.x * b.y - a.y * b.x)
    end 
  end
  
  // dot product
  dot = function(a_,b_)
    local a = new Vector2(a_)
    if b_ == 0 then
      return x*a.x+y*a.y
    else
      local b = new Vector2(b_)
      return(a.x*b.x+a.y*b.y)
    end
  end
  
  // cross product
  cross = function(a, b)
   return abs(det(a,b))
  end
  
  // vector projection of vector on input
  project = function(x_, y_)
    local a = new Vector2(x_, y_)
    return(a*(this*a)/(a*a))
  end
 
  // vector reflection of vector at plane with normal n
  reflect = function(xn_, yn_)
    local n = new Vector2(xn_, yn_)
    n.normalise()
    // w = v - 2 * (v · n) * n
    return this - n * 2 * (this * n)
    
  end
  
  // ---- VISUALISE ----
    
  // Show voctor as colored cross on screen
  // for debugging
  // 
  locate = function(color = "#ff0000", drawText = false, printout = false)
    screen.fillRect(x, y, 5, 1, color)
    screen.fillRect(x, y, 1, 5, color)
    if drawText then 
      local text = "["+ round(x*10)/10 +","+ round(y*10)/10 +"]"
      screen.drawText(text, x, y-3, 5, "rgba(127,127,127,0.8)") 
    end

    if printout then print("x = " + x + " y = " + y) end
    
    //screen.drawLine(0, 0, x, y, color)
    return(this)
  end
  
  // draw sprite at vector position
  drawSprite = function(sprite, width, height)
    screen.drawSprite(sprite, x, y, width, height)
    return(this)
  end
  
  
  // ---- OPERATORS ----
  
  // vector addition
  "+" = function(a, b_)
    local b = new Vector2(b_) 
    return new Vector2(a.x+b.x, a.y+b.y)

  end
  
  // subtraction or inverse b
  "-" = function(a, b_)
    local b = new Vector2(b_) 

    if a == 0 then
      return(new Vector2(-b.x, -b.y))
    else
      return(new Vector2(a.x-b.x, a.y-b.y))
    end

  end
  
  // scaling vector a with factor b or calculate dot product a*b
  // a has to be the vector and b the scalar. the other way round does not work
  "*" = function(a, b_)
    if b_.type == "number" then
      return(new Vector2(a.x*b_, a.y*b_))
    else
    
      local b = new Vector2(b_)
      return(a.x*b.x+a.y*b.y)
    end
  end
  
  // scaling vector a with factor 1/b
  "/" = function(a, b)
    if b.type == "number" then
      return(new Vector2(a.x/b, a.y/b))
    else
      // return error here
    end
  end
  
  // translate
  "+=" = function(a, b_)
    local b = new Vector2(b_)
    a.set(a.x+b.x, a.y+b.y)
  end
  
  // translate
  "-=" = function(a,b_)
    local b = new Vector2(b_)
    a.set(a.x-b.x, a.y-b.y)
  end
  
  // scale
  "*=" = function(a, b)
    if b.type == "number" then
      a.set(x*b, x*b)
    else
      // return error here?
    end
  end
  
  // scale
  "/=" = function(a, b)
    if b.type == "number" and b != 0 then
      a.set(a.x/b, a.y/b)
    else
      // return error here?
    end
  end
  
  

 
  
  
end

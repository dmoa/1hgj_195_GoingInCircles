Bullet = {}

Bullet.new = function()
  local self = {}

  self.x = -100
  self.y = love.math.random(0, 750)

  self.image1 = love.graphics.newImage("bullet1.png")
  self.image2 = love.graphics.newImage("bullet2.png")
  self.image3 = love.graphics.newImage("bullet3.png")

  self.currentImage = self.image1

  self.cycle = love.math.random(0, 0.6)

  self.xv = love.math.random(90, 150)
  self.right = 1

  self.draw = function()
    love.graphics.draw(self.currentImage, self.x, self.y, 0, 4, 4)
  end

  self.update = function(dt)
    self.x = self.x + self.xv * dt * self.right
    self.cycle = self.cycle + dt
    if self.cycle > 0.6 then
      self.cycle = 0
    end

    if self.cycle > 0.4 then
      self.currentImage = self.image3
      else if self.cycle > 0.2 then
        self.currentImage = self.image2
      else
        self.currentImage = self.image1
      end
    end

    if self.x + self.currentImage:getWidth() * 4 > WW then
      self.right = -1
    end

    if self.x < 0 then
      self.right = 1
    end

    for i = 1, numO do
      if playing and orbits[i].holder and
      self.x < orbits[i].x + orbits[i].size and
      self.x + self.currentImage:getWidth() * 4 > orbits[i].x - orbits[i].size and
      self.y + self.currentImage:getHeight() * 4 > orbits[i].y - orbits[i].size and
      self.y < orbits[i].y + orbits[i].size then
        gameOver()
      end
    end

  end

  return self
end

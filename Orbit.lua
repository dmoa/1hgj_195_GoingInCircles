Orbit = {}

alpha = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"}

Orbit.new = function(number)
  local self = {}

  if number < numO / 2 then
    self.hotkey = number
  else
    self.hotkey = alpha[number - 9]
  end

  if number == 1 then
    self.holder = true
  else
    self.holder = false
  end

  self.size = love.math.random(32, 40)

  self.x = love.math.random(50, 1150)
  self.y = love.math.random(50, 750)

  self.xv = love.math.random(0, 100)
  self.yv = love.math.random(0, 100)

  self.font = love.graphics.newFont(self.size)
  self.text = love.graphics.newText(self.font, self.hotkey)

  self.draw = function()
    love.graphics.circle("line", self.x, self.y, self.size)
    if not self.holder then
      love.graphics.draw(self.text, self.x - self.text:getWidth() / 2, self.y - self.text:getHeight() / 2)
    end
  end

  self.update = function(dt)
    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt

    if self.x - self.size < 0 or self.x + self.size > WW then
      self.xv = self.xv * - 1
    end
    if self.y - self.size < 0 or self.y + self.size > WH then
      self.yv = self.yv * - 1
    end

    if self.holder then
      player.x = self.x - player.image:getWidth() / 2
      player.y = self.y - player.image:getHeight() / 2
    end

    if love.keyboard.isDown(self.hotkey) and not self.holder then
      for i = 1, numO do
        orbits[i].holder = false
      end
      self.holder = true
    end
  end

  return self
end

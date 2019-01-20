Player = {}

Player.new = function()
  local self = {}

  self.x = orbits[1].x

  self.y = orbits[1].y

  self.image = love.graphics.newImage("player.png")

  self.draw = function()
    love.graphics.draw(self.image, self.x, self.y)
  end

  return self
end

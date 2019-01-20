require("Player")
require("Orbit")
require("Bullet")

function love.load()

  love.graphics.setDefaultFilter("nearest")

  WW = love.graphics.getWidth()
  WH = love.graphics.getHeight()

  numO = 20

  playing = false

  font = love.graphics.newFont(30)
  text = love.graphics.newText(font, "press space to start")

  timer = 60
  score = love.graphics.newText(font, timer)

end

function love.draw()
  love.graphics.print("escape to quit", 0, 0)
  love.graphics.print("press the character to jump into that orb", 0, 30)
  if playing then
    for i = 1, numO do
      orbits[i].draw()
    end
    player.draw()
    for k, v in ipairs(bullets) do
      bullets[k].draw()
    end
  else
    love.graphics.draw(text, WW / 2 - text:getWidth() / 2, WH / 2 - text:getHeight() / 2)
  end
  love.graphics.draw(score, WW / 2 - score:getWidth() / 2, 50)
end

oof = 0
function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  if playing then
    oof = oof + dt
    if oof > 4 then
      table.insert(bullets, Bullet.new())
      oof = 0
    end
    for i = 1, numO do
      orbits[i].update(dt)
    end
    for k, v in ipairs(bullets) do
      if playing then
        bullets[k].update(dt)
      end
    end
    timer = timer - dt
    score = love.graphics.newText(font, math.ceil(timer))
  end
  if love.keyboard.isDown("space") and not playing then
    start()
    playing = true
  end
  if timer < 0 then
    text = love.graphics.newText(font, "YOU WIN, CONGRATULATIONS")
    score = love.graphics.newText(font, 0)
    gameOver()
  end
end

function start()
  orbits = {}
  for i = 1, numO do
    orbits[i] = Orbit.new(i)
  end
  player = Player.new()
  bullets = {}
  for i = 1, 7 do
    bullets[i] = Bullet.new()
  end
  timer = 60
  playing = true
end

function gameOver()
  playing = false
  orbits = {}
  bullets = {}
  player = 1
end

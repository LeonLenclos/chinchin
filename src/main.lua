require 'Glass'
require 'constants'

utils = require 'utils'

SSM = require "lib.StackingSceneMgr".newManager()

function love.load()
    -- Graphics settings
    love.graphics.setDefaultFilter('nearest')
    love.graphics.setBackgroundColor(0,0,0)
    canvas = love.graphics.newCanvas(WIN_WIDTH, WIN_HEIGHT)

    -- Scenes manager settings
    SSM.setPath("scenes/")
    SSM.add("menu")

    -- Global game variables
    zMove = 0
    score = 0
end

function love.mousepressed(x, y, button)
    -- Update zMove according to mouse scroll
    zMove = button=='wu' and 1 or button=='wd' and -1 or 0
end


function love.update(dt)
    SSM.update(dt)
    zMove = 0
end

function love.draw()
    -- First draw on the canvas.
    love.graphics.setCanvas(canvas)
    canvas:clear(WHITE.r, WHITE.g, WHITE.b)
    SSM.draw()
    
    -- Then draw the canvas (scaled, and centered) on the window
    love.graphics.setCanvas()
    local winW, winH = love.window.getWidth(), love.window.getHeight()
    local scaleFactor = utils.constrain(math.floor(utils.min(winW/WIN_WIDTH, winH/WIN_HEIGHT)),1,10)
    love.graphics.draw(canvas,
        winW/2-WIN_WIDTH*scaleFactor/2,
        winH/2-WIN_HEIGHT*scaleFactor/2,
        0, scaleFactor)
end


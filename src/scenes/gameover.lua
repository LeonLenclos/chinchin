local scene = {}

frame = require 'frame'

local code, sprites, sounds

function scene.modify(flags)
    code = flags.code or code
end

function scene.load()
    -- Load sprites
    sprites = {}
    sprites.brokenglass = love.graphics.newImage('assets/brokenglass.png')
    sprites.gameover = love.graphics.newImage('assets/gameover.png')

    -- Load and play sounds
    sounds = {}
    sounds.music = love.audio.newSource('sounds/music-end.mp3', 'static')
    sounds.music:play()

    code = 1
end

function scene.update(dt)
    if utils.anyIsDown(CONTROLS.play) then
        SSM.purge('gameover')
        SSM.add('game')
    end
end

function scene.draw()
    -- Draw typo
    love.graphics.draw(sprites.gameover,
        math.floor(168/2-sprites.gameover:getWidth()/2),
        math.floor(WIN_HEIGHT/2-sprites.gameover:getHeight()/2+math.sin(love.timer.getTime())*5))
    
    -- Draw frame
    frame.draw(168,8,224,224, TEXT_GAMEOVER[code]..score)
    love.graphics.draw(sprites.brokenglass,268,95)

    -- Debug
    if DEBUG then scene.debugdraw() end
end

function scene.debugdraw()
    love.graphics.print('[GAME OVER SCENE]'
        .. '\n' .. 'score: ' .. score
        .. '\n' .. 'code: ' .. code
    )
end

return scene

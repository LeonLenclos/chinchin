local scene = {}

frame = require 'frame'

local sprites, sounds


function scene.load()
    -- Load sprite
    sprites = {}
    sprites.chinchin = love.graphics.newImage('assets/chinchin.png')
    sprites.chin = love.graphics.newImage('assets/chin.png')
    
    -- Load and play sounds
    sounds = {}
    sounds.music = love.audio.newSource('sounds/music-start.mp3', 'static')
    sounds.music:setVolume(0.7)
    sounds.music:setLooping(true)
    sounds.music:play()
end

function scene.update(dt)
    if utils.anyIsDown(CONTROLS.play) then
        sounds.music:pause()
        SSM.purge('menu')
        SSM.add('game')
    end
end

function scene.draw()
    -- Draw typo
    love.graphics.draw(sprites.chinchin,
        math.floor(168/2-sprites.chinchin:getWidth()/2),
        math.floor(WIN_HEIGHT/2-sprites.chinchin:getHeight()/2+math.sin(love.timer.getTime()*math.pi)*4))
    
    -- Draw frame
    frame.draw(168,8,224,224, TEXT_TITLESCREEN)
    love.graphics.draw(sprites.chin,320,165)
    
    -- Debug
    if DEBUG then scene.debugdraw() end
end

function scene.debugdraw()
    love.graphics.print('[MENU SCENE]')
end

return scene

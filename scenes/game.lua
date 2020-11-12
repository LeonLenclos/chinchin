local scene = {}

require 'Glass'
require 'constants'
frame = require 'frame'
utils = require 'utils'

local player,
    targets,
    cracks,
    spawnCountDown,
    chiningCountDown,
    crackingCountDown,
    sprites,
    sounds

function scene.load()

    -- load sprites
    sprites={}
    sprites.bg = love.graphics.newImage('assets/bg.png')
    sprites.player = {}
    for i=0,MAX_CRACKS do
        sprites.player[i]={}
        for j=1,PLAYER_SPRITES_NUMBER do
            table.insert(sprites.player[i], love.graphics.newImage('assets/player/'..i..'/'..j..'.png'))
        end
    end

    sprites.targets = {}
    for i=1,TARGETS_SPRITES_NUMBER do
        table.insert(sprites.targets, love.graphics.newImage('assets/targets/'..i..'.png'))
    end

    sprites.party = {}
    for i=1,PARTY_SPRITES_NUMBER do
        table.insert(sprites.party, love.graphics.newImage('assets/party/'..i..'.png'))
    end

    sprites.chin = {}
    for i=1,2 do
        table.insert(sprites.chin, love.graphics.newImage('assets/chin/'..i..'.png'))
    end
    sprites.crack = {}
    for i=1,2 do
        table.insert(sprites.crack, love.graphics.newImage('assets/crack/'..i..'.png'))
    end

    -- load sounds
    sounds={}
    sounds.cracks = {}
    for i=1,3 do
        table.insert(sounds.cracks, love.audio.newSource('sounds/crack'..i..'.mp3', 'static'))
    end

    sounds.chins = {}
    for i=1,3 do
        table.insert(sounds.chins, love.audio.newSource('sounds/chin'..i..'.mp3', 'static'))
    end

    sounds.music = love.audio.newSource('sounds/music.mp3', 'static')
    sounds.music:setVolume(0.6)
    sounds.music:setLooping(true)
    sounds.music:play()

    sounds.party = love.audio.newSource('sounds/party.mp3', 'static')
    sounds.party:setVolume(0.4)
    sounds.party:setLooping(true)
    sounds.party:play()


    -- init game
    player = PlayerGlass()
    targets = {}
    cracks = 0
    spawnCountDown = FIRST_SPAWN_INTERVAL
    chiningCountDown = 0
    crackingCountDown = 0

    score = 0
end


function scene.update(dt)
    -- Control player movement
    local playerMove = {
        x= utils.anyIsDown(CONTROLS.right) and 1
            or utils.anyIsDown(CONTROLS.left) and -1
            or 0,
        y= utils.anyIsDown(CONTROLS.down) and 1
            or utils.anyIsDown(CONTROLS.up) and -1
            or 0,
        z= zMove
    }

    -- Update player
    player:update(dt, playerMove)

    -- Remove hitted targets and update score
    for i=#targets,1,-1 do
        if targets[i]:hit(player) then            
            table.remove(targets, i)
            if player.currentSpeed > DANGEROUS_SPEED then
                cracks = cracks + 1
                sounds.cracks[math.random(#sounds.cracks)]:play()
                crackingCountDown = TCHINING_SPRITE_DURATION
            else
                sounds.chins[math.random(#sounds.chins)]:play()
                chiningCountDown = TCHINING_SPRITE_DURATION
            end
            score = score + 10
        end
    end

    chiningCountDown = chiningCountDown - dt
    crackingCountDown = crackingCountDown - dt

    -- Update targets
    for i=#targets,1,-1 do
        targets[i]:update(dt)
    end

    -- Add targets and gameover if too many
    spawnCountDown = spawnCountDown - dt
    if #targets == 0 and spawnCountDown > FIRST_SPAWN_INTERVAL then
        spawnCountDown = FIRST_SPAWN_INTERVAL
    end

    if spawnCountDown < 0 then
        if #targets >= MAX_TARGETS then
            scene.gameover(GAMEOVER_TOOMANY)
        end
        table.insert(targets, TargetGlass(targets))
        spawnCountDown = utils.constrain(utils.mapvalue(score, 0, MAX_SCORE_LEVEL, MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL), MAX_SPAWN_INTERVAL, MIN_SPAWN_INTERVAL)
    end

    -- cracks
    if cracks > MAX_CRACKS then
        scene.gameover(GAMEOVER_BROKEN)
    end
end



function scene.draw()
    -- bg
    -- love.graphics.draw(sprites.bg)

    -- party 1
    local function drawPartyLayer(i)
        local sprite = sprites.party[i]
        local noise = love.math.noise(love.timer.getTime()/50, i)*200-200
        love.graphics.draw(sprites.party[i], noise, HEIGHT)
    end


    for i=1,2 do drawPartyLayer(i) end

    -- targets
    for i,target in ipairs(targets) do
        if #targets > MAX_TARGETS-1 then
            local index = love.timer.getTime()%TCHINING_SPRITE_DURATION>TCHINING_SPRITE_DURATION/2 and 1 or 2
            local sprite = sprites.crack[(index+i)%2+1]
            love.graphics.draw(sprite,
                math.floor(target.x-sprite:getWidth()/2),
                math.floor(target.y-sprite:getHeight()/2))
        end
        love.graphics.draw(sprites.targets[1],
            math.floor(target.x-sprites.targets[1]:getWidth()/2),
            math.floor(target.y-TARGETS_SPRITES_CENTER.y))
    end

    -- chin
    if chiningCountDown > 0 or crackingCountDown > 0 then
        local countDown = chiningCountDown > 0 and chiningCountDown or crackingCountDown
        local spriteCollection = chiningCountDown > 0 and sprites.chin or sprites.crack
        local index = countDown > TCHINING_SPRITE_DURATION/2 and 1 or 2
        local sprite
        sprite = spriteCollection[index]
        love.graphics.draw(sprite, player.x-sprite:getWidth()/2, player.y-sprite:getHeight()/2)
    end

    -- party 2
    for i=3,#sprites.party do drawPartyLayer(i) end

    -- player
    local spriteIndex = math.floor(utils.mapvalue(player.z, 0, 1, 1, PLAYER_SPRITES_NUMBER))
    local x = math.floor((player.x-sprites.player[cracks][spriteIndex]:getWidth()/2)/2)*2+1
    local y = math.floor((player.y-PLAYER_SPRITES_CENTER.y)/2)*2
    love.graphics.draw(sprites.player[cracks][spriteIndex], x, y)


    -- score
    local frameW,frameH = 100, 24
    frame.draw(WIN_WIDTH-frameW-10,WIN_HEIGHT-frameH-10, frameW,frameH, 'SCORE: '..score, 3)

    if DEBUG then scene.debugdraw() end
end


function scene.debugdraw()
    love.graphics.print( '[GAME SCENE]'
        .. '\n' .. 'score: ' .. score
        .. '\n' .. 'cracks: ' .. cracks
        .. '\n' .. 'player.currentSpeed: ' .. utils.round(player.currentSpeed, 2)
        .. '\n' .. 'spawnCountDown: ' .. utils.round(spawnCountDown, 2)
        )
    player:debug()
    for i, target in ipairs(targets) do
        target:debug()    
    end
end

function scene.gameover(code)
    sounds.party:pause()
    sounds.music:pause()

    SSM.purge('game')
    SSM.add('gameover')
    SSM.modify('gameover', {code=code})
end

return scene

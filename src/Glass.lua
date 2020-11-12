require 'constants'

Object = require 'lib.classic'
utils = require 'utils'


-- Glass

Glass = Object:extend()

function Glass:new(x, y, z)
    self.x = x
    self.y = y
    self.z = z
    self.w = GLASS_WIDTH
    self.h = GLASS_HEIGHT
end

function Glass:hit(glass)
    -- Colision detection
    if self.z == glass.z
        and glass.x > self.x - self.w/2
        and glass.x < self.x + self.w/2
        and glass.y > self.y - self.h/2
        and glass.y < self.y + self.h/2
        then return true
    else return false
    end
end


function Glass:debug()

    -- draw box
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self.h)

    -- draw pos
    local size = 10 - 9 * self.z
    love.graphics.line(self.x-size, self.y, self.x+size, self.y)
    love.graphics.line(self.x, self.y-size, self.x, self.y+size)

    -- draw infos
    local infos = ''
    for i, k in ipairs({'x','y','z'}) do
        infos = infos .. k ..': ' .. utils.round(self[k],2) .. '\n'
    end
    love.graphics.print(infos, self.x+self.w/2+2, self.y)

end


-- TargetGlass

TargetGlass = Glass:extend()

function TargetGlass:new(targets)
    self.noisePos = love.math.random(1,100)

    -- Find a free innateX (avoid targets overlapping)
    repeat
        self.innateX = math.random(GLASS_WIDTH, WIDTH-GLASS_WIDTH)
        self.innateY = math.random(GLASS_HEIGHT, HEIGHT-GLASS_HEIGHT)
    until utils.reduce(targets, function(acc, target) return acc and not target:hit{x=self.innateX,y=self.innateY,z=1} end, true)

    -- Create
    TargetGlass.super.new(self, self.innateX, self.innateY, 1)
end

function TargetGlass:update(dt)
    -- Move the glass randomly around innate pos
    local xnoise = love.math.noise(love.timer.getTime()/2,1+self.noisePos)
    local ynoise = love.math.noise(love.timer.getTime()/2,2+self.noisePos)
    self.x = self.innateX + xnoise*TARGET_NOISE_AMP
    self.y = self.innateY + ynoise*TARGET_NOISE_AMP
end


-------------------------------------------------
-- PlayerGlass
-------------------------------------------------

PlayerGlass = Glass:extend()

function PlayerGlass:new()
    -- Speed calculation variables
    self.currentSpeed = 0
    self.speedHistoric = {}

    -- Create
    PlayerGlass.super.new(self, WIDTH/2, HEIGHT/2, 0)
end




function PlayerGlass:update(dt, move)

    -- Move the player's glass on x and y axis
    local slowdown = 1-self.z
    local xy_speed = utils.constrain(XY_SPEED * slowdown, XY_MIN_SPEED, XY_SPEED)
    self.x = utils.constrain(self.x + xy_speed * move.x * dt, self.w/2, WIDTH-self.w/2)
    self.y = utils.constrain(self.y + xy_speed * move.y * dt, self.h/2, HEIGHT-self.h/2)
    
    -- Move the player's glass on z axis
    local automaticRecoil = 0
    if move.x~=0 or move.y~=0 then automaticRecoil = .4 * dt end
    self.z = utils.constrain(self.z + Z_SPEED * move.z * dt - automaticRecoil, 0, 1)

    -- Speed calculation
    table.insert(self.speedHistoric, {dt=dt, moveZ=Z_SPEED*move.z*dt})
    while utils.reduce(self.speedHistoric, function(acc,v) return acc+v.dt end)>SPEED_HISTORIC_INTERVAL do
        table.remove(self.speedHistoric, 1)
    end
    self.currentSpeed = utils.reduce(self.speedHistoric, function(acc,v) return acc+v.moveZ end)/SPEED_HISTORIC_INTERVAL

end


frame = {}

require 'constants'

function frame.draw(x,y,w,h,text,padding)
    padding = padding or 10
    
    -- Outline
    love.graphics.setColor(WHITE.r, WHITE.g, WHITE.b)
    love.graphics.rectangle('fill', x,y,w,h)
    love.graphics.setColor(BLACK.r, BLACK.g, BLACK.b)
    love.graphics.rectangle('line', x,y,w,h)

    -- Frame background
    love.graphics.rectangle('fill', x+2,y+2,w-4,h-4)

    -- Text
    love.graphics.setColor(WHITE.r, WHITE.g, WHITE.b)
    love.graphics.printf(text, x+padding+2, y+padding+2, w-padding-padding-4)
    
    -- Clear Pencil
    love.graphics.setColor(255,255,255)
end

return frame
local utils = {}

-- General specific

function utils.mapvalue(val, min, max, mapmin, mapmax)
    return ((val-min)/(max-min))*(mapmax-mapmin)+mapmin
end

function utils.constrain(val, min, max)
    return val<min and min or val>max and max or val
end

function utils.round(val, decimal)
  if (decimal) then
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
  else
    return math.floor(val+0.5)
  end
end

function utils.reduce(list, fun, acc)
    acc = acc==nil and 0 or acc
    for k, v in ipairs(list) do
        acc = fun(acc, v)
    end 
    return acc 
end

function utils.min(a, b)
  return a > b and b or a
end

-- Love specific

function utils.anyIsDown(controlsList)
  return utils.reduce(controlsList, function(a, v) return a or love.keyboard.isDown(v) end, false)
end

return utils
local utils = {}

require('constants')

function utils.manhattan_distance(e1, e2)
    return math.abs(e1.x - e2.x) + math.abs(e1.y - e2.y)
end

function utils.checkCollision(a, b)
    --With locals it's common usage to use underscores instead of camelCasing
    local a_left = a.x
    local a_right = a.x + a.w
    local a_top = a.y
    local a_bottom = a.y + a.h

    local b_left = b.x
    local b_right = b.x + b.w
    local b_top = b.y 
    local b_bottom = b.y + b.h

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end

function utils.checkPaddleCollisionToWindowBorders(a, border)
    local a_top = a.y
    local a_bottom = a.y + a.h

    if border == 'top' then
        return a_top <= 0
    elseif border == 'bottom' then
        return a_bottom >= WINDOW_HEIGHT
    end
end

function utils.checkBallCollisionToWindowTopBottomBorders(a)
    local a_top = a.y
    local a_bottom = a.y + a.h

    return a_top <= 0
        or a_bottom >= WINDOW_HEIGHT
end

function utils.checkBallCollisionToWindowSideBorders(a)
    local a_left = a.x
    local a_right = a.x + a.w

    return a_left <= 0
        or a_right >= WINDOW_WIDTH
end

return utils
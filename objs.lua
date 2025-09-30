Object = require('classic')
require "constants"

Paddle = Object:extend()
Ball = Object:extend()

---@class (exact) Paddle
---@field x number
---@field y number
---@field w number
---@field h number
function Paddle:new (x, y, w, h)
    self.init_x = x
    self.init_y = y
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.mv_dist = 150
end

function Paddle:add_mv_keys(keys)
    self.up_key, self.down_key, self.left_key, self.right_key = unpack(keys)
end

function Paddle:draw_to_screen()
    -- print(self.y)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Paddle:move(direction, dt)
    if direction == 'up' then
        self.y = self.y - self.mv_dist * dt
    elseif direction == 'down' then
        self.y = self.y + self.mv_dist * dt
    end
end

function Paddle:reset()
    self.x = self.init_x
    self.y = self.init_y
end


function Ball:new(x, y, r)
    self.init_x = x
    self.init_y = y
    self.x = x
    self.y = y
    self.speed = 150
    -- initial direction (e.g., right and slightly up)
    self.dx = self.speed
    self.dy = 1.2 * self.speed
    self.img = love.graphics.newImage('assets/pong.png')
    self.w = 40
    self.h = 40

end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.x = self.init_x
    self.y = self.init_y
    self.dx = self.speed
    self.dy = -1.2 * self.speed
end

function Ball:draw_to_screen()
    -- print(self.y)
    love.graphics.draw(self.img, self.x, self.y)
end
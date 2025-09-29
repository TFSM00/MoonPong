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


function Ball:new(x, y, r)
    self.x = x
    self.y = y
    self.r = r
    self.speed = 150
    -- initial direction (e.g., right and slightly up)
    self.dx = self.speed
    self.dy = -self.speed
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw_to_screen()
    -- print(self.y)
    love.graphics.circle("fill", self.x, self.y, self.r)
end
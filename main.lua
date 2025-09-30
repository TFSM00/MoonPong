function love.load()
    require("objs")
    require("constants")
    math.randomseed(1, 2)
    utils = require('utils')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {resizable = false})
    love.window.setTitle("Moon Pong")
    left_paddle = Paddle(30, WINDOW_HEIGHT/2-50, 20, 150)
    right_paddle = Paddle(WINDOW_WIDTH-30-20, WINDOW_HEIGHT/2-50, 20, 150)
    ball = Ball(WINDOW_WIDTH/2+10, WINDOW_HEIGHT/2+10, 10)
    left_paddle:add_mv_keys({'w', 's', 'a', 'd'})
    right_paddle:add_mv_keys({'up', 'down', 'left', 'right'})
    score_left = 0
    score_right = 0
    backdrop = love.graphics.newImage('assets/moon_backdrop.png')
    font = love.graphics.newFont(36, "mono")
    love.graphics.setFont(font)
    
end

function love.update(dt)
    if love.keyboard.isDown(left_paddle.up_key) then
        if not utils.checkPaddleCollisionToWindowBorders(left_paddle, 'top') then
            left_paddle:move('up', dt)
        end
    elseif love.keyboard.isDown(left_paddle.down_key) then
        if not utils.checkPaddleCollisionToWindowBorders(left_paddle, 'bottom') then
            left_paddle:move('down', dt)
        end
    end
    if love.keyboard.isDown(right_paddle.up_key) then
        if not utils.checkPaddleCollisionToWindowBorders(right_paddle, 'top') then
            right_paddle:move('up', dt)
        end
    elseif love.keyboard.isDown(right_paddle.down_key) then
        if not utils.checkPaddleCollisionToWindowBorders(right_paddle, 'bottom') then
            right_paddle:move('down', dt)
        end
    end
    -- Top/bottom walls
    if ball.y < 0 then
        ball.y = 0
        ball.dy = -ball.dy
    elseif ball.y + ball.h > WINDOW_HEIGHT then
        ball.y = WINDOW_HEIGHT - ball.h
        ball.dy = -ball.dy
    end

    -- Left/right walls (optional for Pong, maybe scoring instead)
    if ball.x < 0 then
        ball.x = ball.w
        ball.dx = -ball.dx
        score_right = score_right + 1
        ball:reset()
        left_paddle:reset()
        right_paddle:reset()
    elseif ball.x + ball.w > WINDOW_WIDTH then
        ball.x = WINDOW_WIDTH - ball.w
        ball.dx = -ball.dx
        score_left = score_left + 1
        ball:reset()
        left_paddle:reset()
        right_paddle:reset()
    end

    -- Paddles
    if utils.checkCollision(left_paddle, ball) then
        ball.x = (left_paddle.x + left_paddle.w)
        ball.dx = -ball.dx
    elseif utils.checkCollision(right_paddle, ball) then
        ball.x = right_paddle.x - ball.w
        ball.dx = -ball.dx
    end
    ball:move(dt)

end

function love.draw()
    love.graphics.draw(backdrop, 0, 0)
    left_paddle:draw_to_screen()
    right_paddle:draw_to_screen()
    ball:draw_to_screen()

    love.graphics.print(score_left, font, WINDOW_WIDTH/2 - 200, 50)
    love.graphics.print(score_right, font, WINDOW_WIDTH/2 + 200, 50)
end




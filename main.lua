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
    if ball.y - ball.r < 0 then
        ball.y = ball.r
        ball.dy = -ball.dy
    elseif ball.y + ball.r > WINDOW_HEIGHT then
        ball.y = WINDOW_HEIGHT - ball.r
        ball.dy = -ball.dy
    end

    -- Left/right walls (optional for Pong, maybe scoring instead)
    if ball.x - ball.r < 0 then
        ball.x = ball.r
        ball.dx = -ball.dx
    elseif ball.x + ball.r > WINDOW_WIDTH then
        ball.x = WINDOW_WIDTH - ball.r
        ball.dx = -ball.dx
    end

    -- Paddles
    if utils.checkCollision(left_paddle, ball) then
        ball.x = left_paddle.x + left_paddle.w + ball.r
        ball.dx = -ball.dx
    elseif utils.checkCollision(right_paddle, ball) then
        ball.x = right_paddle.x - ball.r
        ball.dx = -ball.dx
    end
    ball:move(dt)

end

function love.draw()
    left_paddle:draw_to_screen()
    right_paddle:draw_to_screen()
    ball:draw_to_screen()
end




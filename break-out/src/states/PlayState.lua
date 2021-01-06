PlayState = Class{ __includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(1)

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    self.ball.x = VIRTUAL_WIDTH / 2 - self.ball.width / 2
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.paused = false
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()

        return
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:isColliding(self.paddle) then
        self.ball.dy = -self.ball.dy
        print('hit')
        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
--[[
    GD50
    Breakout Remake

    -- PowerUp Class --

    Author: Samuel Ayala

    Represents a power-up in the world space that is contained within bricks;
    each power-up is to have a different behavior in the gameplay. On spawn,
    the power-up will start descending down towards the Paddle. In order for the
    power-up to affect the game it must be caught be the Paddle. We'll add 
    collision detection with the Paddle.
]]

PowerUp = Class{}

BallPowerUpIndex = 7
KeyPowerUpIndex = 10

function PowerUp:init(x, y, key)
    self.width = 16
    self.height = 16
    self.x = x
    self.y = y
    self.dy = 0
    self.key = key
    -- used to determine if the power up is to be active in the gameplay.
    self.inPlay = false
end

function PowerUp:render()
    if self.inPlay then
        local powerUpIndex = BallPowerUpIndex -- default to ball power up
        if self.key then
            powerUpIndex = KeyPowerUpIndex
        end
        love.graphics.draw(gTextures['main'], gFrames['powerups'][powerUpIndex], self.x, self.y)
    end
end

function PowerUp:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function PowerUp:update(dt)
    self.y = self.y + self.dy * dt
end
--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    local medal = nil
    local y_position = 100
    if self.score > 0 then
        medal = love.graphics.newImage(getMedal(self.score))
    end
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 50, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    if medal then
        love.graphics.printf('But you won this medal!', 0, y_position, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(medal,VIRTUAL_WIDTH/2-medal:getWidth()/8,y_position+25,0,0.25,0.25)
        y_position = y_position + 110
    else
        love.graphics.printf('Try to score at least 1 :)', 0, y_position, VIRTUAL_WIDTH, 'center')
        y_position = y_position + 50
    end

    love.graphics.printf('Score: ' .. tostring(self.score), 0, y_position, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, y_position+30, VIRTUAL_WIDTH, 'center')
end

function getMedal(score)
    if score < 2 then
        return 'bronze.png'
    elseif score < 3 then
        return 'silver.png'
    else
        return 'gold.png'
    end
    return 1
end
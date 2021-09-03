PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.pauseText = '- paused -'
    self.soundInterval = 0.5
    self.soundTimer = 0
    self.soundFlag = false -- used to alternate between pause sound beeps. 
    --Set to false to play 2nd beep, 1st one is played on PlayState when pressing 'p'
end

function PauseState:enter(params)
    self.params = params
end

function PauseState:update(dt)
    self.soundTimer = self.soundTimer + dt
    if self.soundTimer > self.soundInterval then
        if self.soundFlag then
            sounds['pause1']:play()
            self.pauseText = '- paused -'
            self.soundFlag = false
        else
            sounds['pause2']:play()
            self.pauseText = ''
            self.soundFlag = true
        end
        self.soundTimer = 0
    end
    if love.keyboard.wasPressed('p') then
        gStateMachine:unpause('play')
    end
end

function PauseState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(self.pauseText,0,120, VIRTUAL_WIDTH, 'center')
end
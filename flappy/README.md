### lagiacrus44

## Randomized Fifty-Bird Assignment

### 3 attributes added to Paddle class:
1. Randomize gap size. Added inside PipePair init function.
```Lua
function PipePair:init(y)
    local GAP_HEIGHT = math.random(70,110)
```
2. Randomize spawn interval. Modified PlayState.lua to use:
```Lua
self.spawnInterval = math.random(2,3)
```
3. Add medals. Modified ScoreState.lua:
```Lua
function ScoreState:render() -- updated
function getMedal(score) -- new function to get the medal file to show, depending on score.
```
4. Pause. Added PauseState - triggered by Pressing 'P' during PlayState. We go back to PlayState by pressing 'P' again. Modified StateMachine.lua to prevent self.current:exit() before switching, save state instead. Game music will pause on this new state and text shown will be intermittent with 2 custom bleeps sounds from Bfxr.
```Lua
-- StateMachine.lua:

function StateMachine:pause(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	--self.current:exit()
	sounds['music']:pause()
	self.saved = self.current
	self.current = self.states[stateName]()
	self.current:enter(enterParams)
end

function StateMachine:unpause(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	sounds['music']:play()
	self.current:exit()
	self.current = self.saved
	self.saved = self.empty -- discard previously saved state, after resumption
	self.current:enter(enterParams)
end
``` 

#### Thanks!
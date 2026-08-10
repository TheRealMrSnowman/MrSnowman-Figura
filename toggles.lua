function pings.toggleGwuh(state)
    Gwuh:setVisible(state)
    if state then
        animations.model.extend:play()
        animations.model.extend:restart()
        return
    end
    PlayerReset()
end
function pings.togglePuppyEyes(state)
    AwwEyes:setVisible(state)
    if not state then
        PlayerReset()
    end
end
function pings.toggleChestBone(state)
    Boob:setVisible(state)
    if not state then
        PlayerReset()
    end
end
function pings.toggleCreeper(state)
    if state then
        animations.model.creeper:play()
        animations.model.creeper:restart()
        return
    end
    animations.model.creeper:stop()
    PlayerReset()
end
function pings.toggleSnowflakes(state)
    if state then
        SnowState = true
    end
    if not state then
        SnowState = false
    end
end
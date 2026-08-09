function pings.toggleGwuh(state)
    gw_eyes:setVisible(state)
    if state then
        animations.model.extend:play()
        animations.model.extend:restart()
        return
    end
    PlayerReset()
end
function pings.togglePuppyEyes(state)
    cute_eyes:setVisible(state)
    if not state then
        PlayerReset()
    end
end
function pings.toggleChestBone(state)
    boob:setVisible(state)
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
        snowtoggle = true
    end
    if not state then
        snowtoggle = false
    end
end
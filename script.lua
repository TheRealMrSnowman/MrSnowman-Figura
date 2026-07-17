vanilla_model.PLAYER:setVisible(false)
-- vanilla_model.HELMET:setVisible(false)
-- vanilla_model.ELYTRA:setVisible(false)
-- Shrthnd
gw_eyes = models.model.root.Head.custom_head.gwuh_eyes
cute_eyes = models.model.root.Head.custom_head.cute_eyes
boob = models.model.root.Body.custom_body.chest.chest_bone
stickMallows = models.mallow_stick.Item.mallows
-- c_phys_staff = models.mod_integration.create_mod.physics_staff
function rndName()
    local potentialNames = {
        "TheRealMrSnowman",
        "𝚃𝚑𝚎𝚁𝚎𝚊𝚕𝙼𝚛𝚂𝚗𝚘𝚠𝚖𝚊𝚗",
        "TheNotFakeMrSnowman",
        "Mr Snowman",
        "TheMrSnowman",
        "MrSnowman(real)(no fake)",
        "TheUhhhh... IDK",
        "Snowman",
        "Congealed Water Creature",
        "MimpterShnowman",
        "TheSnowiestMan",
        "TheRealMrSnowman?",
        "MrTheRealSnowman",
        "RealMrTheSnowman",
        "SnowmanTheRealMr",
        "Snowdman"
    }
    local pickName = math.random(1, #potentialNames)
    local newName = potentialNames[pickName]
    return newName
end
snowtoggle = false
function is_even(n)
    return n % 2 == 0
end
function soundHandler(soundName, soundPos, soundVol, soundPitch, loop)
    sounds:playSound(soundName, soundPos, soundVol, soundPitch, loop)
end

function events.tick()
    if snowtoggle then
        local ambientSnow = particles["snowflake"]
        local playerPos = player:getPos()
        function posOffset()
            local offset = math.random(-2,2)
            return offset
        end
        local snowflakePos = playerPos:add(vec(posOffset(), math.random(1,3) ,posOffset()))
        ambientSnow:setScale(0.3)
        ambientSnow:setPos(snowflakePos)
        ambientSnow:setGravity(0)
        ambientSnow:spawn()
    end
    animations.model.healthBar:pause()
    animations.model.healthBar:setTime(player:getHealth()/player:getMaxHealth())
    nameplate.ENTITY:setPos(0,(player:getHealth()/player:getMaxHealth()*2-2),0)
end
function createParticleAt(particleName, modelPart, xOffest, yOffest, zOffest, scale, gravity)
    local particleSpawner = particles[particleName]
        local firePos = modelPart:partToWorldMatrix():apply():add(vec(xOffest, yOffest, zOffest))
        particleSpawner:setScale(scale)
        particleSpawner:setPos(firePos)
        particleSpawner:setGravity(gravity)
        particleSpawner:spawn()
end
pys_stff_tggle = 0
function events.item_render(item)
    if item.id == "minecraft:netherite_sword" then
        local paticleChance = math.random(1,20)
        if paticleChance == 1 then
            createParticleAt("flame", stickMallows.top.top, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0)
            createParticleAt("flame", stickMallows.middle.middle, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0)
            createParticleAt("flame", stickMallows.bottom.bottom, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0)
        end
        return models.mallow_stick.Item
    elseif item.id == "simulated:creative_physics_staff" then
        function pings.wand_toggle(mod)
            if mod == 1 then
                    pys_stff_tggle = pys_stff_tggle+mod
                elseif mod == 3 and not is_even(pys_stff_tggle) then
                    pys_stff_tggle = pys_stff_tggle+mod
                else
            end
        end
        if is_even(pys_stff_tggle) then
            animations.physics_staff.active:stop()
            animations.physics_staff.Idle:play()

        elseif not is_even(pys_stff_tggle) then
            animations.physics_staff.Idle:stop()
            animations.physics_staff.active:play()
        end
        local paticleChance = math.random(1,10)
        if paticleChance == 1 then
            createParticleAt("snowflake", models.physics_staff.Item.orb.inner_cube, 0, 0 ,0, 0.1, 0)
        end
        return models.physics_staff.Item
    elseif item.id == "minecraft:crossbow" then
    --     function pings.fire_gun(mod)
    --         if is_even(mod) then
    --             animations.deagle.fire:play()
    --         else
    --             -- print("Error firing gun")
    --         end
    --     end
        -- models.deagle.Item:setScale(0.15, 0.15, 0.15)
        -- models.deagle.Item:setPos(models.model.root.RightArm.RightItemPivot:partToWorldMatrix():apply())
        -- rightClick = keybinds:newKeybind("rightclick","key.mouse.right")
        -- rightClick:onPress(function()pings.fire_gun(1)end)
        -- models.deagle.Item.mag.shell:setParentType("Arrow"):setPos(vec(0, -6, 20))
        return models.deagle.Item
    end
end
nameplate.ALL:setText(rndName())

-- local zoomKey = keybinds:newKeybind("Zoom", "key.keyboard.c", false)
-- function pings.bindZoomIn()
--     gw_eyes:setVisible(true)
--     sounds:stopSound("sounds.smack")
--     soundHandler("sounds.stretch-creak", player:getPos(), 1, 1, false)
--     animations.model.extend:restart()
--     animations.model.extend:play()
-- end
-- function pings.bindZoomOut()
--     gw_eyes:setVisible(false)
--     sounds:stopSound("sounds.stretch-creak")
--     soundHandler("sounds.smack", player:getPos(), 1, math.random(0.9,1.1), false)
-- end
-- zoomKey:setOnPress(function()
--     pings.bindZoomIn()
-- end)
-- zoomKey:setOnRelease(function()
--     pings.bindZoomOut()
-- end)
-- Stup 4 cmmn func
function NameSwap(newName)
    nameplate.ALL:setText(newName)
end
function PlayerReset()
    gw_eyes:setVisible(false)
    cute_eyes:setVisible(false)
    boob:setVisible(false)
end
function newToggle(wheelPage, offTitle, onTitle, offItem, onItem, pingName)
    local toggleaction = wheelPage
        :title(offTitle)
        :toggleTitle(onTitle)
        :item(offItem)
        :toggleItem(onItem)
        :setOnToggle(pingName)
end
function newTrigger(wheelPage, triggerTitle, icon, pingName)
    local toggleaction = wheelPage
        :title(triggerTitle)
        :item(icon)
        :onLeftClick(pingName)
end
PlayerReset()
-- Init act whel
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
-- States
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
function pings.cycleName()
    nameplate.ALL:setText(rndName())
end
-- Toggles
newToggle(mainPage:newAction(), "Enable GWUHH Mode", "Disable GWUHH Mode", "ender_pearl", "ender_eye", pings.toggleGwuh)
newToggle(mainPage:newAction(), "Enable Awww Mode", "Disable Awww Mode", "bone", "bone_meal", pings.togglePuppyEyes)
newToggle(mainPage:newAction(), "Enable \"Chest Bone\"", "Disable \"Chest Bone\"", "chest", "ender_chest", pings.toggleChestBone)
newToggle(mainPage:newAction(), "Enable Creeper", "Disable Creeper", "creeper_head", "barrier", pings.toggleCreeper)
newToggle(mainPage:newAction(), "Enable Snowflake", "Disable Snowflake", "snowball", "powder_snow_bucket", pings.toggleSnowflakes)
newTrigger(mainPage:newAction(), "Cycle Name", "name_tag", pings.cycleName)

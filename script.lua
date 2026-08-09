require("toggles")
require("tools")

vanilla_model.PLAYER:setVisible(false)
vanilla_model.HELMET:setVisible(false)
vanilla_model.CHESTPLATE:setVisible(false)
vanilla_model.LEGGINGS:setVisible(false)
vanilla_model.BOOTS:setVisible(false)
-- vanilla_model.ELYTRA:setVisible(false)
-- Shrthnd
gw_eyes = models.model.root.Head.custom_head.gwuh_eyes
cute_eyes = models.model.root.Head.custom_head.cute_eyes
realFace = models.model.root.Head.custom_head.real
boob = models.model.root.Body.custom_body.chest.chest_bone
stickMallows = models.mallow_stick.Item.mallows
-- c_phys_staff = models.mod_integration.create_mod.physics_staff
function rndName()
    local potentialNames = {
        "TheRealMrSnowman",
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
        "Man",
        "Snowdman"
    }
    local pickName = math.random(1, #potentialNames)
    local newName = potentialNames[pickName]
    return newName
end

-- Defaults
snowtoggle = false
pys_stff_tggle = 0

function PlayerReset()
    gw_eyes:setVisible(false)
    cute_eyes:setVisible(false)
    boob:setVisible(false)
    animations.model.skull_anim:play()
end
PlayerReset()
models.model.root.Skull:setLight(8)

function events.tick()
    if snowtoggle then
        local particleCount = 10
        for i = 1, particleCount, 1 do
            createParticleAt("snowflake", models.model.root.Head, math.random(-1,0)+math.random(),0.7+math.random(),math.random(-1,0)+math.random(),0.25,0.15,false)
        end
    end
    animations.model.healthBar:pause()
    animations.model.healthBar:setTime(player:getHealth()/player:getMaxHealth())
    nameplate.ENTITY:setPos(0,(player:getHealth()/player:getMaxHealth()*2-2),0)
end

function events.item_render(item)
    if item.id == "minecraft:netherite_sword" then
        local paticleChance = math.random(1,20)
        if paticleChance == 1 then
            createParticleAt("flame", stickMallows.top.top, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
            createParticleAt("flame", stickMallows.middle.middle, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
            createParticleAt("flame", stickMallows.bottom.bottom, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
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
        return models.deagle.Item
    end
end
nameplate.ALL:setText(rndName())

local partyKey = keybinds:newKeybind("Party", "key.keyboard.delete", false)
function pings.party()
    soundHandler("sounds.party", player:getPos(), 1, 1, false)
    local particleCount = 500
    for i = 1, particleCount, 1 do
        createParticleAt("cloud", models.model.root.Head, math.random(-1,0)+math.random(),math.random()+1,math.random(-1,0)+math.random(),0.25,0.25,true)
    end
end
partyKey:setOnPress(function()
    pings.party()
end)

function NameSwap(newName)
    nameplate.ALL:setText(newName)
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

-- Init act whel
function pings.cycleName()
    nameplate.ALL:setText(rndName())
end
-- Toggles
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
newToggle(mainPage:newAction(), "Enable GWUHH Mode", "Disable GWUHH Mode", "ender_pearl", "ender_eye", pings.toggleGwuh)
newToggle(mainPage:newAction(), "Enable Awww Mode", "Disable Awww Mode", "bone", "bone_meal", pings.togglePuppyEyes)
newToggle(mainPage:newAction(), "Enable \"Chest Bone\"", "Disable \"Chest Bone\"", "chest", "ender_chest", pings.toggleChestBone)
newToggle(mainPage:newAction(), "Enable Creeper", "Disable Creeper", "creeper_head", "barrier", pings.toggleCreeper)
newToggle(mainPage:newAction(), "Enable Snowflake", "Disable Snowflake", "snowball", "powder_snow_bucket", pings.toggleSnowflakes)
newTrigger(mainPage:newAction(), "Cycle Name", "name_tag", pings.cycleName)

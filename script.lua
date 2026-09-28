require("toggles")
require("tools")

models.model.root:setPrimaryTexture("SKIN")
vanilla_model.PLAYER:setVisible(false)
vanilla_model.HELMET:setVisible(false)
vanilla_model.CHESTPLATE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
vanilla_model.LEGGINGS:setVisible(false)
vanilla_model.BOOTS:setVisible(false)
-- Shrthnd
Gwuh = models.model.root.Head.custom_head.gwuh_eyes
AwwEyes = models.model.root.Head.custom_head.cute_eyes
Boob = models.model.root.Body.custom_body.chest.chest_bone
StickMallows = models.items.mallow_stick.Item.mallows
-- c_phys_staff = models.mod_integration.create_mod.physics_staff
function RndName()
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
nameplate.ALL:setText(RndName())

-- Defaults
SnowState = false
AeroWandState = 0
HealthHeight = false
HungerWidth = false

function PlayerReset()
    Gwuh:setVisible(false)
    AwwEyes:setVisible(false)
    Boob:setVisible(false)
    animations.model.headAnim:play()
end
PlayerReset()

function events.tick()
    if SnowState then
        local particleCount = 50
        for i = 1, particleCount, 1 do
            local a = math.random()*2*math.pi
            local r = math.random()*2
            local x = math.sin(a)*r
            local z = math.cos(a)*r
            CreateParticleAt("snowflake", models.model.root.Head, x,1.5+math.random(),z,0.25,0.15,false)
        end
    end
    if HealthHeight then
        animations.model.healthBar:pause()
        animations.model.healthBar:setTime(player:getHealth()/player:getMaxHealth())
        nameplate.ENTITY:setPos(0,(player:getHealth()/player:getMaxHealth()*2-2),0)
    end
    if HungerWidth then
        animations.model.hungerBar:pause()
        animations.model.hungerBar:setTime(player:getFood()/20)
    end
end

function events.item_render(item)
    if item.id == "minecraft:netherite_sword" then
        local paticleChance = math.random(1,20)
        if paticleChance == 1 then
            CreateParticleAt("flame", StickMallows.top.top, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
            CreateParticleAt("flame", StickMallows.middle.middle, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
            CreateParticleAt("flame", StickMallows.bottom.bottom, math.random(-0.1,0.1), math.random(-0.1,0.1)+0.1 ,math.random(-0.1,0.1), 0.3, 0, false)
        end
        return models.mallow_stick.Item
    elseif item.id == "simulated:creative_physics_staff" then
        function pings.wand_toggle(mod)
            if mod == 1 then
                    AeroWandState = AeroWandState+mod
                elseif mod == 3 and not IsEven(AeroWandState) then
                    AeroWandState = AeroWandState+mod
                else
            end
        end
        if IsEven(AeroWandState) then
            animations.physics_staff.active:stop()
            animations.physics_staff.Idle:play()

        elseif not IsEven(AeroWandState) then
            animations.physics_staff.Idle:stop()
            animations.physics_staff.active:play()
        end
        local paticleChance = math.random(1,10)
        if paticleChance == 1 then
            CreateParticleAt("snowflake", models.items.physics_staff.Item.orb.inner_cube, 0, 0 ,0, 0.1, 0)
        end
        return models.items.physics_staff.Item
    end
end

local partyKey = keybinds:newKeybind("Party", "key.keyboard.delete", false)
function pings.party()
    SoundHandler("sounds.party", player:getPos(), 1, 1, false)
    local particleCount = 1500
    for i = 1, particleCount, 1 do
        -- local a = math.random()*2*math.pi
        local u1 = math.random()
        local u2 = math.random()
        local r = 2
        local r2 = r*math.sqrt(u1)
        local t = u2*2*math.pi
        local x = r2*math.cos(t)
        local z = r2*math.sin(t)
        -- local d = math.random()*r
        -- local x = math.sin(a)*d
        local y = 2+math.random()
        -- local z = math.cos(a)*d
        CreateParticleAt("cloud", models.model.root.Head,x,y,z,0.25,0.25,true)
    end
end
partyKey:setOnPress(function()
    pings.party()
end)

function NameSwap(newName)
    nameplate.ALL:setText(newName)
end

-- Init act whel
function pings.cycleName()
    nameplate.ALL:setText(RndName())
end
-- Toggles
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
NewToggle(mainPage:newAction(), "Enable GWUHH Mode", "Disable GWUHH Mode", "ender_pearl", "ender_eye", pings.toggleGwuh)
NewToggle(mainPage:newAction(), "Enable Awww Mode", "Disable Awww Mode", "bone", "bone_meal", pings.togglePuppyEyes)
NewToggle(mainPage:newAction(), "Enable \"Chest Bone\"", "Disable \"Chest Bone\"", "chest", "ender_chest", pings.toggleChestBone)
NewToggle(mainPage:newAction(), "Enable Creeper", "Disable Creeper", "creeper_head", "barrier", pings.toggleCreeper)
NewToggle(mainPage:newAction(), "Enable Snowflake", "Disable Snowflake", "snowball", "powder_snow_bucket", pings.toggleSnowflakes)
NewToggle(mainPage:newAction(), "Enable HealthHeight", "Disable HealthHeight", "nether_star", "heart_of_the_sea", pings.toggleHealthHeight)
NewToggle(mainPage:newAction(), "Enable HungerWidth", "Disable HungerWidth", "nether_star", "heart_of_the_sea", pings.toggleHungerWidth)
NewToggle(mainPage:newAction(), "Enable Invis", "Disable Invis", "nether_star", "heart_of_the_sea", pings.toggleInvis)
NewTrigger(mainPage:newAction(), "Cycle Name", "name_tag", pings.cycleName)

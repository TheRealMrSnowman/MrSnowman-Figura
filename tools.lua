function CreateParticleAt(particleName, modelPart, xOffest, yOffest, zOffest, scale, gravity, randomColour)
    local particleSpawner = particles[particleName]
    local pos = modelPart:partToWorldMatrix():apply():add(vec(xOffest, yOffest, zOffest))
    particleSpawner:setScale(scale)
    particleSpawner:setPos(pos)
    particleSpawner:setGravity(gravity)
    if randomColour then
        particleSpawner:setColor(math.random(), math.random(), math.random())
    end
    particleSpawner:spawn()
end
function SoundHandler(soundName, soundPos, soundVol, soundPitch, loop)
    sounds:playSound(soundName, soundPos, soundVol, soundPitch, loop)
end
function IsEven(n)
    return n % 2 == 0
end
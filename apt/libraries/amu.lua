-- Advanced Moving Utils (for robots)
-- requires geolyzer and navigation upgrades..

local component = require("component")
local nu = require("navigationutils")
local ru = nu.robotutils

local geolyzer = component.geolyzer
local robot = require("robot")

local advancedmovingutils = {}
advancedmovingutils.navigationutils = nu
advancedmovingutils.robotutils = ru

-- facing
-- 2.0 -> North -> -Z
-- 3.0 -> South -> +Z
-- 4.0 -> West -> -X
-- 5.0 -> East -> +X

local function analyzeData(datatab, size)
    for i=1,size do
        if datatab[i] > 0.0 then
            return true
        end
    end
    return false
end

local function nextmove (coordstab)
    local x,y,z, step, tx, ty, tz = table.unpack(coordstab)
    if (x == 0 and y == 0 and z == 0) then
        return nil
    end

    if not (x == 0 or tx == true) then
        if x > 0 then
            local movestep = step
            if movestep > x then
                movestep = x
            end
            local datatab = geolyzer.scan(1,0,0,movestep,1,1)
            if analyzeData(datatab,movestep) then
                local newtab = {x,y,z,step,true,ty,tz}
                nextmove(newtab)
                return nil
            end
            nu.east()
            ru.forward(movestep)
            local newtab = {x-movestep,y,z,20,false,false,false}
            nextmove(newtab)
            return nil
        else
            local movestep = -step
            if movestep < x then
                movestep = x
            end
            local datatab = geolyzer.scan(movestep,0,0,-movestep,1,1)
            if analyzeData(datatab, -movestep) then
                local newtab = {x,y,z,step,true,ty,tz}
                nextmove(newtab)
                return nil
            end
            nu.west()
            ru.forward(-movestep)
            local newtab = {x-movestep,y,z,20,false,false,false}
            nextmove(newtab)
            return nil
        end
    end

    if not (z == 0 or tz == true) then
        if z > 0 then
            local movestep = step
            if movestep > z then
                movestep = z
            end
            local datatab = geolyzer.scan(0,1,0,1,movestep,1)
            if analyzeData(datatab, movestep) then
                local newtab = {x,y,z,step,tx,ty,true}
                nextmove(newtab)
                return nil
            end
            nu.south()
            ru.forward(movestep)
            local newtab = {x,y,z-movestep,20,false,false,false}
            nextmove(newtab)
            return nil
        else
            local movestep = -step
            if movestep < z then
                movestep = z
            end
            local datatab = geolyzer.scan(0,movestep,0,1,-movestep,1)
            if analyzeData(datatab, -movestep) then
                local newtab = {x,y,z,step,tx,ty,true}
                nextmove(newtab)
                return nil
            end
            nu.north()
            ru.forward(-movestep)
            local newtab = {x,y,z-movestep,20,false,false,false}
            nextmove(newtab)
            return nil
        end
    end

    if not (y == 0 or ty == true) then
        if y > 0 then
            local movestep = step
            if movestep > y then
                movestep = y
            end
            local datatab = geolyzer.scan(0,0,1,1,1,movestep)
            if analyzeData(datatab, movestep) then
                local newtab = {x,y,z,step,tx,true,tz}
                nextmove(newtab)
                return nil
            end
            ru.up(movestep)
            local newtab = {x,y-movestep,z,20,false,false,false}
            nextmove(newtab)
            return nil
        else
            local movestep = -step
            if movestep < y then
                movestep = y
            end
            local datatab = geolyzer.scan(0,0,movestep,1,1,-movestep)
            if analyzeData(datatab, -movestep) then
                local newtab = {x,y,z,step,tx,true,tz}
                nextmove(newtab)
                return nil
            end
            ru.down(-movestep)
            local newtab = {x,y-movestep,z,20,false,false,false}
            nextmove(newtab)
            return nil
        end
    end

    if step > 1 then
        local newtab = {x,y,z,math.floor(step/2),false,false,false}
        nextmove(newtab)
        return nil
    end
    print(string.format("No moves available to go to %d %d %d", x,y,z))
    return nil

end



local function goToRelativeCoords(coordstab)
    x,y,z = table.unpack(coordstab)
    local newtab = {x,y,z,20,false,false,false}
    nextmove(newtab)
end


advancedmovingutils.goToRelativeCoords = goToRelativeCoords
return advancedmovingutils 
local component = require("component")
local ru = require("robotutils")
local nav = component.navigation

local navigationutils = {}
-- in order to avoid loading multiple times!
navigationutils.robotutils = ru

local function analyzewaypoint(waypointdata)

    local rstr = string.match(waypointdata.label, ".+|%-?%d+|%d+|%-?%d+")
    if rstr == nil then return nil end
    local data = {}
    
    local iter = string.gmatch(waypointdata.label, "[^|]+")
    data.label = iter()
    data.abs = {iter(), iter(), iter()}
    data.rel = {waypointdata.position[1], waypointdata.position[2], waypointdata.position[3]}
    data.pos = {data.abs[1]-data.rel[1],data.abs[2]-data.rel[2],data.abs[3]-data.rel[3]}
    data.rs = waypointdata.redstone

    return data
end

-- facing
-- 2.0 -> North -> -Z
-- 3.0 -> South -> +Z
-- 4.0 -> West -> -X
-- 5.0 -> East -> +X

local function north()
    local current = nav.getFacing()
    if current == 5.0 then
        ru.left()
    elseif current == 4.0 then
        ru.right()
    elseif current == 3.0 then
        ru.around()
    end
end

local function south()
    local current = nav.getFacing()
    if current == 2.0 then
        ru.around()
    elseif current == 4.0 then
        ru.left()
    elseif current == 5.0 then
        ru.right()
    end
end

local function west()
    local current = nav.getFacing()
    if current == 5.0 then
        ru.around()
    elseif current == 3.0 then
        ru.right()
    elseif current == 2.0 then
        ru.left()
    end
end

local function east()
    local current = nav.getFacing()
    if current == 2.0 then
        ru.right()
    elseif current == 3.0 then
        ru.left()
    elseif current == 4.0 then
        ru.around()
    end
end

local function analyzeAllInRadius(rad)
    local wp = nav.findWaypoints(rad)
    local datas = {}
    for i=1,#wp do 
        local lans  = analyzewaypoint(wp[i])
        if lans ~= nil then
            table.insert(datas, lans)
        end
    end
    return datas
end

local function getDistance(relcords)
    return math.sqrt(math.pow(relcords[1],2) + math.pow(relcords[2],2) + math.pow(relcords[3],2))
end

local function findClosestWaypoint(range)
    local dat = analyzeAllInRadius(range)
    if #dat == 0 then
        return nil
    end
    local result = dat[1]
    for i=2,#dat do
        if getDistance(result.rel) > getDistance(dat[i].rel) then
            result = dat[i]
        end
    end
    return result
end

local function findClosestWaypointWithRedstone(range, redstone)
    local dat = analyzeAllInRadius(range)
    if #dat == 0 then
        return nil
    end
    local result = dat[1]
    for i=2,#dat do
        if dat[i].rs == redstone then
            if result.rs ~= redstone then
                result = dat[i]
            end
            if getDistance(result.rel) > getDistance(dat[i].rel) then
                result = dat[i]
            end
        end
    end
    if result.rs ~= redstone then
        return nil
    end
    return result
end

local function findMyCoordsFromWaypoints(range)
    local wp = nav.findWaypoints(range)
    local datas = {}
    for i=1,#wp do 
        local lans  = analyzewaypoint(wp[i])
        if lans ~= nil then
            table.insert(datas, lans)
        end
    end
    return datas
end

local function checkSurroundingWaypoints(range, x,y,z)
    local dat = findMyCoordsFromWaypoints(range)
    for i=1,#dat do 
        if not (dat[i].pos[1] == x and dat[i].pos[2] == y and dat[i].pos[3] == z) then
            print(dat[i].label.." Has Wrong Coordinates!")
        end
    end
end

navigationutils.analyzeAllInRadius = analyzeAllInRadius
navigationutils.analyzewaypoint = analyzewaypoint
navigationutils.findMyCoordsFromWaypoints = findMyCoordsFromWaypoints
navigationutils.east = east
navigationutils.west = west
navigationutils.north = north
navigationutils.south = south
navigationutils.checkSurroundingWaypoints = checkSurroundingWaypoints
navigationutils.findClosestWaypoint = findClosestWaypoint
navigationutils.findClosestWaypointWithRedstone = findClosestWaypointWithRedstone
return navigationutils
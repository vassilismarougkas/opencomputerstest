local component = require("component")
local term = require("term")
local sides = require("sides")
local robot = require("robot")

local navigation = component.navigation
local modem = component.modem

local waypoint = nil
-- Facing
-- 2 north [+3]
-- 3 south [-3]
-- 4 west [+1]
-- 5 east [-1]
-- 25 + waypoint.position[2]

local function getWaypoint(name)
    local navs = navigation.findWaypoints(64)
    for key, amount in pairs(navs) do
        if (amount.label == name) then
            return amount
        end
    end
    return nil
end

local function goHeight()
    for i=1,(6 + waypoint.position[2]) do
        robot.up()
    end
end

local function goHorizontial()

    if waypoint.position[1] == 0 then
        return nil
    elseif waypoint.position[1] > 0 then
        while (navigation.getFacing() ~= 5) do
            robot.turnLeft()
        end
        for i = 1,waypoint.position[1] do 
            robot.forward()
        end
        return nil
    elseif waypoint.position[1] < 0 then
        while (navigation.getFacing() ~= 4) do
            robot.turnLeft()
        end
        for i = 1,math.abs(waypoint.position[1]) do 
            robot.forward()
        end
        return nil
    end
end

local function goVertical()
    if waypoint.position[3] == 0 then
        return nil
    elseif waypoint.position[3] > 0 then
        while (navigation.getFacing() ~= 3) do
            robot.turnLeft()
        end
        for i = 1,waypoint.position[3] do 
            robot.forward()
        end
        return nil
    elseif waypoint.position[3] < 0 then
        while (navigation.getFacing() ~= 2) do
            robot.turnLeft()
        end
        for i = 1,math.abs(waypoint.position[3]) do 
            robot.forward()
        end
        return nil
    end
end

function goDoor()
    local signals = require("signals")
    modem.broadcast(signals.eytixis_robothatch_port, signals.eytixis_robothatch_open)
    os.sleep(0.5)
    robot.up()
    robot.up()
    modem.broadcast(signals.eytixis_robothatch_port, signals.eytixis_robothatch_close)
    for i=1,17 do
        robot.up()
    end
end

waypoint = getWaypoint("NIUG13")
goHeight()
goHorizontial()
goVertical()
goDoor()
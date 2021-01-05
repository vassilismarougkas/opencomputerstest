local component = require("component")
local term = require("term")
local sides = require("sides")
local robot = require("robot")

local navigation = component.navigation

local waypoint = nil

local arguments = {...}

local function getWaypoint(name, range)
    local navs = navigation.findWaypoints(range)
    if (navs.n == 0) then
        return nil
    end
    for key,amount in pairs(navs) do
        if (amount.label == name) then
            return amount
        end
    end
    return nil
end

local function goHeight(height)
    if (-waypoint.position[2] > height) then
        for i = 1,(-waypoint.position[2]-height) do
            robot.down()
        end
    elseif (-waypoint.position[2] < height) then
        for i = 1,(height+waypoint.position[2]) do
            robot.up()
        end
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

if (#arguments == 0) then
    print("Usage: <program> <waypoint>")
    return nil
end

waypoint = getWaypoint(arguments[1], 32)
local height = 25
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 64)
    height = 40
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 128)
    height = 60
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 256)
    height = 80
end
if (waypoint == nil) then
    print("Could not find the waypoint!")
    return nil
end

goHeight(height)
waypoint = getWaypoint(arguments[1], 32)
local height = 25
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 64)
    height = 40
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 128)
    height = 60
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 256)
    height = 80
end
if (waypoint == nil) then
    print("Could not find the waypoint!")
    return nil
end
goHorizontial()
waypoint = getWaypoint(arguments[1], 32)
local height = 25
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 64)
    height = 40
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 128)
    height = 60
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 256)
    height = 80
end
if (waypoint == nil) then
    print("Could not find the waypoint!")
    return nil
end
goVertical()
waypoint = getWaypoint(arguments[1], 32)
local height = 25
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 64)
    height = 40
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 128)
    height = 60
end
if (waypoint == nil) then
    waypoint = getWaypoint(arguments[1], 256)
    height = 80
end
if (waypoint == nil) then
    print("Could not find the waypoint!")
    return nil
end
goHeight(0)
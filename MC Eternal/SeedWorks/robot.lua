local component = require("component")
local term = require("term")
local serialization = require("serialization")
local signals = require("signals")
local event = require("event")
local robot = require("robot")

local tunnel = component.tunnel
local inv = component.inventory_controller

local function receiveData()
    tunnel.send(signals.seeds_server_send_data)
    local rec = {event.pull("modem_message")}
    local tab = serialization.unserialize(rec[6])
    return tab
end

local function askEnd()
    tunnel.send("STOP")
end

local function replaceCenter()
    for i=1,3 do robot.forward() end
    robot.swingDown()
    robot.useDown()
    robot.useDown()
    for i=1,3 do robot.back() end
end

local function placeCenter()
    for i=1,3 do robot.forward() end
    robot.useDown()
    inv.equip()
    robot.useDown()
    inv.equip()
    for i=1,3 do robot.back() end
end

local function emptyInv()
    robot.back()
    for i=1,16 do
        robot.select(i)
        robot.dropDown()
    end
    robot.select(1)
    robot.forward()
end

local function doneCenter()
    for i=1,3 do robot.forward() end
    robot.select(14)
    robot.useDown()
    robot.select(15)
    robot.swingDown()
    for i=1,3 do robot.back() end
    robot.turnRight()
    robot.forward()
    robot.dropDown()
    os.sleep(5)
    robot.suckDown()
    robot.turnRight()
    robot.forward()
    robot.dropDown()
    robot.turnRight()
    robot.forward()
    for i=1,16 do
        robot.select(i)
        robot.dropDown()
    end
    robot.turnRight()
    robot.forward()
end

local function fixHand()
    robot.back()
    robot.back()
    robot.suckDown()
    inv.equip()
    robot.dropDown()
    robot.forward()
    robot.forward()
end

local function clearSurroundings()
    robot.forward()
    robot.forward()
    robot.swingDown()
    robot.forward()
    robot.turnRight()
    robot.forward()
    robot.swingDown()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.swingDown()
    robot.turnLeft()
    for i=1,4 do robot.forward() end
    robot.turnAround()
end

local function replaceSurroundings()
    robot.forward()
    robot.forward()
    robot.swingDown()
    robot.useDown()
    robot.forward()
    robot.turnRight()
    robot.forward()
    robot.swingDown()
    robot.useDown()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.swingDown()
    robot.useDown()
    robot.turnLeft()
    for i=1,4 do robot.forward() end
    robot.turnAround()
end

local function placeSurroundings()
    robot.forward()
    robot.forward()
    robot.useDown()
    robot.forward()
    robot.turnRight()
    robot.forward()
    robot.useDown()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.useDown()
    robot.turnLeft()
    for i=1,4 do robot.forward() end
    robot.turnAround()
end

fixHand()
while robot.suckDown() do 
    placeCenter()
    placeSurroundings()
    local phase = false
    local cont = true
    while cont do
        local tab = receiveData()
        if phase then
            if (tab.strength + tab.gain + tab.growth) == 30 then
                doneCenter()
                clearSurroundings()
                emptyInv()
                cont = false
            elseif tab.center then
                replaceSurroundings()
                phase = not phase
            else 
                os.sleep(1)
            end
        else 
            if tab.around then
                replaceCenter()
                phase = not phase
                emptyInv()
                fixHand()
            else
                os.sleep(1)
            end
        end
    end
end
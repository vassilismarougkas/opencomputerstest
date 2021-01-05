local component = require("component")
local robot = require("robot")
local event = require("event")
local sides = require("sides")
local term = require("term")

local inv = component.inventory_controller
local redstone = component.redstone
local done = false

local waittime1 = 80
local waittime2 = 50

function main()
    term.clear()
    term.setCursor(1,1)
    term.write("Starting Seed Work!")

end

function nextSeed()
    robot.select(15)
    if robot.suckDown()~=false then
        return true
    end
    return false
end

function loop()
    while nextSeed() do
        done = false
        make()
    end
end
function plantF1()
    robot.back()
    robot.select(16)
    robot.suckDown(robot.space())
    robot.forward()
    robot.forward()
    inv.equip()
    robot.useDown()
    robot.useDown()
    robot.forward()
    robot.useDown()
    inv.equip()
    robot.select(15)
    inv.equip()
    robot.useDown()
    robot.select(16)
    inv.equip()
    robot.forward()
    robot.useDown()
    robot.useDown()
    robot.back()
    robot.turnRight()
    robot.forward()
    robot.useDown()
    robot.useDown()
    robot.turnAround()
    robot.forward()
    robot.forward()
    robot.useDown()
    robot.useDown()
    robot.back()
    robot.turnRight()
    robot.back()
    robot.back()
end

function wait1()
    os.sleep(1)
    redstone.setOutput(sides.top, 15)
    event.pull(waittime1, "redstone_changed")
    redstone.setOutput(sides.top, 0)
end

function wait2()
    os.sleep(1)
    event.pull(waittime2, "redstone_changed")
end

function plantF2()
    inv.equip()
    robot.forward()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(15)
    robot.swingDown()
    robot.select(16)
    inv.equip()
    robot.useDown()
    robot.useDown()
    inv.equip()
    robot.back()
    robot.back()
    
    robot.back()
    robot.back()
    robot.select(15)
    robot.dropDown()
    robot.forward()
    robot.forward()
    robot.select(16)
end

function clearSector()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(14)
    robot.swingDown()
    robot.turnRight()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(14)
    robot.swingDown()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(14)
    robot.swingDown()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(14)
    robot.swingDown()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
    robot.select(1)
    robot.useDown()
    robot.select(15)
    robot.swingDown()
    robot.back()
    robot.back()
end

function analyze()
    robot.turnLeft()
    robot.forward()
    robot.select(14)
    robot.dropDown()
    os.sleep(5)
    robot.suckDown()
    robot.turnLeft()
    robot.forward()
    robot.dropDown()
    robot.turnLeft()
    robot.forward()
    robot.turnLeft()
    robot.forward()
end

function check()
    if (inv.getStackInInternalSlot(15) == nil or inv.getStackInInternalSlot(14).size == 5) then
        done = true
        analyze()
    else 
        robot.back()
        robot.back()
        robot.select(1)
        robot.dropDown()
        robot.select(2)
        robot.dropDown()
        robot.select(3)
        robot.dropDown()
        robot.select(14)
        robot.dropDown()
        robot.forward()
        robot.forward()
    end
end

function make()
    while (not done) do
        plantF1()
        wait1()
        plantF2()
        wait2()
        clearSector()
        check()
    end
end

main()
loop()
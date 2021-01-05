local component = require("component")
local robot = require("robot")
local sides = require("sides")

local redstone = component.redstone
local loader = component.chunkloader

loader.setActive(true)

for i = 1,15 do 
    robot.up()
end

for i = 1,11 do
    for j = 1,16 do
        robot.forward()
    end

    robot.placeDown()
    redstone.setOutput(sides.down, 15)
end
robot.forward()
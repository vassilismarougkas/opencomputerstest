local component = require("component")
local term = require("term")
local sides = require("sides")
local robot = require("robot")

local navigation = component.navigation
local modem = component.modem

robot.select(1)
repeat
    while robot.down() do end
    while robot.up() do
        robot.placeDown()
    end
    robot.select(robot.select()+1)
until not robot.forward()
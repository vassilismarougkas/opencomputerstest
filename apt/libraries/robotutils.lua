local robot = require("robot")
local computer = require("computer")

local robotutils = {}

local function up(moves)
    local mv = moves or 1
    for i=1,mv do
        local tim = 0
        while not robot.up() do
            computer.beep()
            os.sleep(1)
            tim = tim+1
            if (tim >= 10) then
                robot.swingUp()
            end
        end
    end
end

local function down(moves)
    local mv = moves or 1
    for i=1,mv do 
        local tim = 0
        while not robot.down() do
            computer.beep()
            os.sleep(1)
            tim = tim+1
            if (tim >= 10) then
                robot.swingDown()
            end
        end
    end
end

local function forward(moves)
    local mv = moves or 1
    for i=1,mv do 
        local tim = 0
        while not robot.forward() do
            computer.beep()
            os.sleep(1)
            tim = tim+1
            if (tim >= 10) then
                robot.swing()
            end
        end
    end
end

local function back(moves)
    local mv = moves or 1
    for i=1,mv do robot.back() end
end

local function left()
    robot.turnLeft()
end

local function right()
    robot.turnRight()
end

local function around()
    robot.turnAround()
end

robotutils.forward = forward
robotutils.front = forward
robotutils.back = back
robotutils.up = up
robotutils.down = down
robotutils.left = left
robotutils.around = around
robotutils.right = right

return robotutils


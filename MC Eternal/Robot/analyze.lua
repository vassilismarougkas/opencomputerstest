local robot = require("robot")
local component = require("component")
local inv = component.inventory_controller

select(1)
while robot.suckDown() ~= false do
    while robot.suckDown() ~= false do end

    robot.forward()
    robot.forward()
    for i=1,5 do
        for j = 1,4 do
            robot.forward()
            if (i>1) then
                robot.select(j + (i-2)*4)
                robot.suckDown()
            end
            if (i < 5) then
                robot.select(j + (i-1)*4)
                robot.dropDown()
            end
        end
        for i=1,4 do
            robot.back()
        end
        os.sleep(4)
    end

    for i=1,16 do
        robot.select(i)
        robot.dropDown()
    end

    robot.back()
    robot.back()
end
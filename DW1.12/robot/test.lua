local robot = require("robot")
local computer = require("computer")
local component = require("component")
local magnet = component.tractor_beam

function drive() 
	while robot.forward() do
		while magnet.suck() do
		end
	end
end

function drop()
	for i=1,12 do 
		robot.select(i)
		robot.dropDown()
	end
	robot.select(1)
end

function full()
	return (computer.maxEnergy() - computer.energy() < 500)
end

function checkStop(s)
	robot.select(s)
	local bool = robot.compare()
	robot.select(1)
	return bool
end

function loop()
	drive()
	if checkStop(16) then
		drop()
		while (not full()) do os.sleep(0.1) end
	end
	if checkStop(13) then
		while robot.down() do end
	end
	if checkStop(14) then
		while robot.up() do end
	end
	k1,k2 = robot.detect()
	if k1 == true and k2 == "passable" then
		robot.swing()
	end
	if robot.detect() then
		if checkStop(15) then
			robot.turnLeft()
		else
			robot.turnRight()
		end
	end
end

while true do
	loop()
end
local term = require("term")
local component = require("component")
local event = require("event")
local gpu = component.gpu
local tr = require("transceiver")
tr.open(27001)
gpu.setResolution(159,49)
w,h = gpu.getResolution()
Aratio = w/h
c ={x=((w+1)/2),y=((h+1)/2)}
term.clear()


function loop()
	
	read()
	sphere()
	--print(st/mx)
end

function sphere()
	
	--gpu.setBackground(0xFFFFFF)
	
	for y = 1,h do
		if 1-(y/49) <= (st/mx) then
			gpu.setBackground(0x00FF00)
		else
			gpu.setBackground(0x3c3c3c)
		end
		for x = 1,w do	
			if (((x-c.x)/(w/(1277/788)/2))^2 + ((y-c.y)/(h/2))^2) <= 0.95 then
				gpu.set(x,y," ")
			end
			
		end
	end

end

function read()
	--_,_,_,_,_,st,mx,rt,md = event.pull("modem_message")
	_, d = tr.receive()
	st = d[1]
	mx = d[2]
end

function border()
	gpu.setBackground(0x0092ff)
	for y=1,h do
		for x=1,w do
			if (((x-c.x)/(w/(1277/788)/2))^2 + ((y-c.y)/(h/2))^2) <= 1.1 then
				gpu.set(x,y," ")
			end
		end
	end
end



border()
while true do
	loop()
end
for i = 1, 200 do modem.broadcast(25565, "data1") end

local modem = component.proxy(component.list("modem")())
local rs = component.proxy(component.list("redstone")())


modem.open(25000)

while true do
	_, _, _, port, _, message = computer.pullSignal("modem_message")
	if (port == 25000) then
		if (message == "light on") then
			rs.setOutput(1, 15)
		elseif (message == "light off") then
			rs.setOutput(1, 0)
		end
	end
end


while true do
	st = core.getEnergyStored()
	mx = core.getMaxEnergyStored()
	rt = core.getTransferPerTick()
	md = "null"
	if (core.canExtract()) then
		md = "extract"
	elseif (core.canReceive()) then
		md = "receive"
	end
	modem.broadcast(port, st, mx, rt, md)
	os.sleep(delay)
end

while true do
	_, _, _, _, port, st, mx, rt, md = event.pull("modem_message")
	term.clear()
	term.setCursor(1,1)
	print("Stored Power: "..st.."rf")
	print("Max Power: "..mx.."rf")
	print("Stored %: ".. tostring(100*st/mx) .."%")
	print("Pylon Mode: "..md)
	os.sleep(0.5)
end

function totime(sec)
	result = {}
	result.seconds = math.fmod(sec, 60)
	result.minutes = fmod(math.floor(sec/60), 60)
	result.hours = math.floor(sec/3600)
	return result
end

function display()
	term.clear()
	term.setCursor(math.floor((x/2)-(#message/2)),1)
	gpu.setForeground(0x00ffff)
	term.write(message)
	
	
	term.setCursor(1,2)
	gpu.setForeground(0x00ffff)
	term.write("Power Stored: ")
	gpu.setForeground(ffff00)
	term.write(math.floor(st).."RF")
	
	term.setCursor(1,3)
	gpu.setForeground(0x00ffff)
	term.write("Transfer Rate: ")
	gpu.setForeground(ffff00)
	term.write(math.floor(rt).."RF/t")
	
	term.setCursor(1,4)
	gpu.setForeground(0x00ffff)
	term.write("Maximum Power Storage: ")
	gpu.setForeground(ffff00)
	term.write(math.floor(mx).."RF")
	
	if displaySphere then
		shpere()
	end
end

function sphere()
	
	

	if (math.floor(100*st/mx) >= 80) then
		scolor = 0x00ff00
	elseif (math.floor(100*st/mx) <=20) then
		scolor = 0xff0000
	else
		scolor = 0xffff40
	end

end
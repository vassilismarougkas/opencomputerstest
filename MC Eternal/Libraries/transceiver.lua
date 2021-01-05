-- TRANSCEIVER API

-- note: use only 1 modem or 1 tunnel for the API's best performance
-- Not to be used as a junction between tunnels and network cards. Use TunnelLinker instead.

local event = require("event")
local component = require("component")
local transceiver = {}
local ports = {}
local device

function transceiver.reset()
	for k,v in pairs(component.list()) do
		if v == "tunnel" or v == "modem" then
			device = component.proxy(k)
		end
	end
	transceiver.type = device.type
end

function isOpenPort(pr)
	for k,v in pairs(ports) do
		if (v == pr) then
			return true
		end
	end
	return false
end


function transceiver.receive()
	if (device.type == "modem") then
		local m = {event.pull("modem_message")}
		table.remove(m,1)--event
		table.remove(m,1)--receiver
		table.remove(m,1)--sender
		local port = m[1]
		table.remove(m,1)--port
		table.remove(m,1)--range

		if (device.type == "tunnel") then
			port = m[1]
			table.remove(m,1)
		end
		return port, m
	end
	if (device.type == "tunnel") then
		local m = nil
		local port = nil
		repeat
			m = {event.pull("modem_message")}
			table.remove(m,1)--event
			table.remove(m,1)--receiver
			table.remove(m,1)--sender
			table.remove(m,1)--port
			table.remove(m,1)--range
			port = m[1]
			table.remove(m,1)--tport
		until(isOpenPort(port))
		return port, m
	end
end

function transceiver.send(port, ...)
	transceiver.sendT(port, {...})
end

function transceiver.sendT(port,data)
	if (device.type == "tunnel") then
		table.insert(data, port, 1)
		device.send(table.unpack(data))
	elseif (device.type == "modem") then
		device.broadcast(port, table.unpack(data))
	end
end

function transceiver.open(port)
	if (device.type == "tunnel") then
		table.insert(ports, #ports+1, port)
	elseif (device.type == "modem") then
		device.open(port)
	end
end

function transceiver.close(port)
	if (device.type == "tunnel") then
		for k, v in pairs(ports) do
			if (v == port) then
				table.remove(ports, k)
			end
		end
	elseif (device.type == "modem") then
		device.close(port)
	end
end

function transceiver.isOpen(p)
	if (device.type == "tunnel") then
		return isOpenPort(p)
	elseif (device.type == "modem") then
		return device.isOpen(p)
	end
end



transceiver.reset()
return transceiver
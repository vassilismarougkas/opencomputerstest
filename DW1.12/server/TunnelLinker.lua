-- Best to use with transceiver api.

-- Since tunnels don't use ports, the tunnel restricts the connection to 7 data messages per packet. Use serialised tables for more.

local ports = {27001}

local component = require("component")
local event = require("event")
local tunnels = {}
local re = nil
local port = nil
local data = nil

function loop()
	--_, re, se, port, range, m1, m2, m3, m4, m5, m6, m7, m8 = event.pull("modem_message")
	data = {event.pull("modem_message")}
	port = data[4]
	re = data[2]
	for i = 1,5 do
		table.remove(data, 1)
	end
	
	broadcast()
end

function initialize()
	tunnels = {}
	for k,v in pairs(component.list("tunnel")) do
		tunnels[k] = component.proxy(k)
	end
	modem = component.modem
	for k,v in pairs(ports) do
		modem.open(v)
	end
end

function broadcast()
	if not modem == nil then
		if (re == modem.address) then
			for addr,comp in pairs(tunnels) do
				comp.send(port, table.unpack(data))
			end
		else 
			for addr,comp in pairs(tunnels) do
				if not (re == addr) then
					comp.send(table.unpack(data))
				end
			end
			port = data[1]
			table.remove(data, 1)
			modem.broadcast(port, table.unpack(data))
		end
	else
		if #tunnels > 1 then
			for addr,comp in pairs(tunnels) do
				if not (re == addr) then
					comp.send(table.unpack(data))
				end
			end
		end
	end
end

initialize()
while true do
	loop()
end
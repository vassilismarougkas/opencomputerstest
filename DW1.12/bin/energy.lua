address = "bfb2a7bf-0c81-4c93-ab77-f90f00f0d8b7"
title = "Villjos Draconic Energy Core"
transmit_data = false
resolution = { x=45 , y=12 }
port = 27001
delay = 0.2

local component = require("component")
local term = require("term")
local colors = require("colors")
local formatter = require("formatter")
if transmit_data then tr = require("transceiver") end
local core = component.proxy(address)
local gpu = component.gpu

gpu.setResolution(resolution.x,resolution.y)
term.clear()

function loop()
    readCore()
    if transmit_data then
        broadcast()
    end
	display()
	os.sleep(delay)
end

function readCore()
	st = core.getEnergyStored()
	mx = core.getMaxEnergyStored()
	rt = core.getTransferPerTick()
	md = "null"
	if (core.canExtract()) then
		md = "extract"
	elseif (core.canReceive()) then
		md = "receive"
	end
end

function broadcast()
	tr.send(port, st, mx, rt, md)
end

function display()
	
	w,h = gpu.getResolution()
	term.clear()
	term.setCursor(math.floor((w/2)-(#title/2)),1)
	gpu.setForeground(0x00ffff)
	term.write(title)

	term.setCursor(1,2)
	gpu.setForeground(0x00ffff)
	term.write("Power Stored: ")
	gpu.setForeground(0xffff00)
	term.write(formatter.formatNumber(st,1).."RF")

	term.setCursor(1,3)
	gpu.setForeground(0x00ffff)
	term.write("Transfer Rate: ")
	gpu.setForeground(0xffff00)
	term.write(formatter.formatNumber(rt,0).."RF/t")

	term.setCursor(1,4)
	gpu.setForeground(0x00ffff)
	term.write("Maximum Power Storage: ")
	gpu.setForeground(0xffff00)
	term.write(formatter.formatNumber(mx,0).."RF")
	
	term.setCursor(1,5)
	gpu.setForeground(0x00ffff)
	term.write("Charge: ")
	gpu.setForeground(0xffff00)
	term.write(tostring(math.floor((st/mx)*10000)/100).."%")
	
end

while true do
	loop()
end
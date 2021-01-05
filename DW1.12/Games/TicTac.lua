-- Tic Tac --
local term = require("term")
local component = require("component")
local tunnel = component.tunnel
local event = require("event")

local connected = false
local data = {}
local host

local gamecount = 0
local name
local localscore, opponentscore = 0,0
local gamegrid = {[1]={[1]=0,[2]=0,[3]=0},[2]={[1]=0,[2]=0,[3]=0},[3]={[1]=0,[2]=0,[3]=0}}

--1.  modem_message
--2.  Receiver (local)
--3.  Sender
--4.  Port
--5.  Range
--6.  m1
--7.  m2
--8.  m3
--9.  m4
--10. m5
--11. m6
--12. m7
--13. m8

-- Game Grid: G(X(Y))=Value
-- 80x25

local function resetGrid()
	gamegrid = {[1]={[1]=0,[2]=0,[3]=0},[2]={[1]=0,[2]=0,[3]=0},[3]={[1]=0,[2]=0,[3]=0}}
end

local function getG(x,y)
	return gamegrid[x[y]]
end

function getEnergy()
	local current, total, perc
	current = computer.getEnergy()
	total = computer.maxEnergy()
	perc = math.floor(current*100/total)
	return perc, current, total
end

function connectInterface()
	
	term.clear()
	term.write("Locating Opponent....")
	
	connect()
	
	term.clear()
	term.write("Found Opponent")
	
	interface()
	
end

function connect()
	
	while (not connected) do
		data = {event.pull(4, "modem_message")}
		if (#data == 0) then
			tunnel.send("host")
		else
			if (data[0] == "host") then
				tunnel.send("join")
				connected = true
				host = true
			elseif (data[0] == "join") then
				connected = true
				host = false
			end
		end
	end

end

function interface()

	term.clear()
	term.setCursor(1,1)
	term.write("Enter your name:")
	name = io.read()

end

function game()

	

end

function loop()
	while (not GameHasEnded) do
	
	end
end

function render()

	term.clear()

end
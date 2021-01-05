local term = require("term")
local component = require("component")
local event  = require("event")
local transceiver = require("transceiver")

transceiver.open(27001)

function main()
	while true do
	  port, data = transceiver.receive()
	  st, mx, rt, md = table.unpack(data)
	  term.clear()
	  term.setCursor(1,1)
	  print("Stored Power: "..st.."rf")
	  print("Max Power: "..mx.."rf")
	  print("Stored %: ".. tostring(100*st/mx) .."%")
	  print("Rate: "..rt.."rf/t")
	  print("Pylon Mode: "..md)
	  if (rt >0) then
		sec = math.floor((mx-st)/(rt*20))
		result = totime(sec)
		print("until full: "..result.hours.." hours, "..result.minutes.." minutes, "..result.seconds.." seconds")
	  end
	  if (rt<0) then
		sec = math.floor((0-mx)/(rt*20))
		result = totime(sec)
		print("until empty: "..result.hours.." hours, "..result.minutes.." mins, "..result.seconds.." seconds")
	  end

	  

	  os.sleep(0.1)
	end
end

function div(n1, n2)
  return math.floor(n1/n2)
end

function mod(n1, n2)
  return math.fmod(n1,n2)
end

function totime(sec)
  result = {}
  result.seconds = math.fmod(sec, 60)
  result.minutes = math.fmod(math.floor(sec/60), 60)
  result.hours = math.floor(sec/3600)
  return result
end

main()

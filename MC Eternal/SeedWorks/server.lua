local component = require("component")
local term = require("term")
local serialization = require("serialization")
local signals = require("signals")
local event = require("event")

local rb = component.proxy("051b0aa5-2be9-45c8-adf5-6e82533587c7")
local rt = component.proxy("ed5c49bb-5aef-42c1-aad5-dbbb804975a0")
local tunnel = component.tunnel

local lastperc = 0
local enabled = true

local function termClear()
    term.clear()
    term.setCursor(1,1)
end

-- gain = rb.getInput()[3]
-- str = rb.getInput()[4]
-- growth = rb.getInput()[1]

-- cdone = rb.getInput()[3]
-- adone = rb.getInput()[4]

local function gatherData()
    local result = {}
    local br = rb.getInput()
    local tr = rt.getInput()
    result.growth = br[1]
    result.gain = br[3]
    result.strength = br[4]
    result.center = (tr[3] == 15)
    result.around = (tr[4] == 15)
    return result
end

local function sendData(data)
    tunnel.send(serialization.serialize(data))
end

local function await()
    local tab = {event.pull("modem_message")}
    return tab
end

local function resetScreen(data)
    termClear()
    local perc = data.growth + data.gain + data.strength
    perc = (perc*100) / 30
    perc = math.floor(perc)
    if (perc == 0) then
        perc = lastperc
    else
        lastperc = perc
    end
    term.write("Status: "..tostring(perc).."%")
end

local function loop()
    while await()[6] == signals.seeds_server_send_data do
        local tabl = gatherData()
        sendData(tabl)
        resetScreen(tabl)
    end
end

loop()
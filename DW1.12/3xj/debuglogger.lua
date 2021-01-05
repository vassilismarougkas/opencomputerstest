local component = require("component")
local term = require("term")
local filesystem = require("filesystem")
local shell = require("shell")

local debug = component.debug

local mainposition = {712,73,2195}
local lradius = 100
local includeVerticalDistance = false
local interval = 1 -- in seconds

local inside = {}

local function checkTimeLib()
    if not filesystem.exists("//lib/timelib.lua") then
        shell.execute("pastebin get Tsg2tkA8 //lib/timelib.lua")
    end
end

checkTimeLib()
local tl = require("timelib")

local function termClear()
    term.clear()
    term.setCursor(1,1)
end

local function register(name)
    table.insert(inside, name)
end

local function unRegister(name)
    for k,v in pairs (inside) do
        if v == name then
            table.remove(inside, k)
        end
    end
end

local function isRegistered(name)
    for k,v in pairs(inside) do 
        if (v == name) then
            return true
        end
    end
    return false
end

local function getDistance(p1, p2)
    if includeVerticalDistance then
        local distance = math.sqrt(math.pow(p1[1]-p2[1],2) + math.pow(p1[2]-p2[2],2) + math.pow(p1[3]-p2[3],2))
        return distance
    else
        local distance = math.sqrt(math.pow(p1[1]-p2[1],2) + math.pow(p1[3]-p2[3],2))
        return distance
    end
end

local function log(player)
    filesystem.makeDirectory(tl.getDate("//home/data/%h"))
    local f = io.open(tl.getDate("//home/data/%h/%d.txt"), "a")
    f:write(tl.getDate("%T").." -> "..player.." Entered")
    f:write("\n")
    f:close()
end

local function unLog(player)
    filesystem.makeDirectory(tl.getDate("//home/data/%h"))
    local f = io.open(tl.getDate("//home/data/%h/%d.txt"), "a")
    f:write(tl.getDate("%T").." -> "..player.." Left")
    f:write("\n")
    f:close()
end

local function findClosePlayers(x,y,radius)
    local players = debug.getPlayers()
    for i = 1, #players do
        local player = players[i]
        local position = {debug.getPlayer(player).getPosition()}
        if getDistance(mainposition, position) <= lradius then
            if not isRegistered(player) then
                register(player)
                log(player)
            end
        else 
            if (isRegistered(player)) then
                unRegister(player)
                unLog(player)
            end
        end
    end
end



termClear()
while true do
    findClosePlayers()
    os.sleep(interval)
end
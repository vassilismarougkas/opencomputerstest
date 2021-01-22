local list = require "apt.list"
local tArgs = {...}
local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local shell = require("shell")
local filesystem = require("filesystem")

local special = false

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

local function getList()
    local x = 0
    local str = nil
    repeat 
        str = "list"..x
        x = x + 1
    until filesystem.exists("/temp/"..str..".lua")
    download("/temp/"..str..".lua", "/apt/list.lua")
    return require("/temp/"..str)
end

local function printUsage()
    local st = [[
        Usage:
        apt [-f folder] package1, package2, ...
    ]]
    print(st)
end

if #tArgs == 0 then
    printUsage()
    return nil
else 
    if #tArgs > 2 then
        if tArgs[1] == "-f" then
            special = true
        end
    end
    local startpoint = 1
    if special then startpoint = 3 end

    local list = getList()
    for i = startpoint, #tArgs do
        if special then
            download(tArgs[2]..list[tArgs[i]]["name"], list[tArgs[i]]["location"])
        else
            download(list[tArgs[i]]["save"]..list[tArgs[i]]["name"], list[tArgs[i]]["location"])
        end
    end
end
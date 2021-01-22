local tArgs = {...}
local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local shell = require("shell")
local filesystem = require("filesystem")

local special = false

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

local function getList()
    shell.setWorkingDirectory("/")
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
end

local list = getList()

if #tArgs > 2 then
    if tArgs[1] == "-f" then
        special = true
    end
end

local startpoint = 1
if special then startpoint = 3 end

local function downloadApt(package)
    print("Downloading "..package)
    local tab = list[package]
    if special then
        download(tArgs[2]..tab["name"], tab["location"])
        if #tab["dependencies"] > 0 then
            for j = 1, #tab["dependencies"] do
                downloadApt(tab["dependencies"][j])
            end
        end
    else
        download(tab["save"]..tab["name"], tab["location"])
        if #tab["dependencies"] > 0 then
            for j = 1, #tab["dependencies"] do
                downloadApt(tab["dependencies"][j])
            end
        end
    end
end


for i = startpoint, #tArgs do
    downloadApt(tArgs[i])
end
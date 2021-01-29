local tArgs = {...}
local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local shell = require("shell")
local filesystem = require("filesystem")
local term = require("term")

local special = false

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

local function getList()
    shell.setWorkingDirectory("/")
    return require("/data/apt/list")
end

local function getInstalled()
    if not filesystem.exists("/data/apt/installed.txt") then
        return {}
    end
    local f = io.open("/data/apt/installed.txt", "r")
    local serialization = require("serialization")
    local data = serialization.unserialize(f:read())
    f:close()
    return data
end

local function saveInstalled(installed)
    local f = io.open("/data/apt/installed.txt", "w")
    local serialization = require("serialization")
    f:write(serialization.serialize(installed))
    f:close()
    return true
end

local function printUsage()
    local st = [[
        Apt Usage:
        apt help
        apt list
        apt update
        apt upgrade
        apt install <package names ...>
    ]]
    print(st)
end

local function update()
    shell.setWorkingDirectory("/")
    --if filesystem.exists("/data/apt/list.lua") then
    --    filesystem.remove("/data/apt/list.lua")
    --end
    download("/data/apt/list.lua", "/apt/list.lua")
end

local function printList()
    local list = getList()
    term.clear()
    term.setCursor(1,1)
    print("Available Programs: ")
    for key, tab in pairs(list) do 
        local bool = tab["hide"] or false
        if bool then
            print(key)
        end
    end
end

if #tArgs == 0 then
    printUsage()
    return nil
end

if #tArgs == 1 then
    if tArgs[1] == "help" then
        printUsage()
        return nil
    end
    if tArgs[1] == "list" then
        printList()
        return nil
    end
    if tArgs[1] == "update" then
        update()
        return nil
    end
    printUsage()
    return nil
end

local list = getList()
local installed_list = getInstalled()

local function downloadApt(package, tab)
    local version = tab["version"] or 1.0
    local dependencies = tab["dependencies"]

    if not installed_list["package"] == nil then
        local installed_version = installed_list["package"]
        if (installed_version >= version) then
            return false
        end
    end
    print("Downloading "..package)

    download(tab["save"]..tab["name"], tab["location"])

    installed_list[package] = version

    if dependencies ~= nil then
        for key, amount in pairs(dependencies) do
            downloadApt(amount, list[amount])
        end
    end
    
    return true
end

if tArgs[1] == "install" then
    for i = 2, #tArgs do
        downloadApt(tArgs[i], list[tArgs[i]])
    end

    saveInstalled(installed_list)
    return nil
end

printUsage()
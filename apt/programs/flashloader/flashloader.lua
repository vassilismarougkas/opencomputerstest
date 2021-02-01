local filesystem = require("filesystem")
local tArgs = {...}
local shell = require("shell")

local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

if not filesystem.exists("/data/flash") then
    filesystem.makeDirectory("/data/flash")
end

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

local function printUsage()
    local st = [[
    Flashloader Usage:
        flashloader flash <name> [label]
        flashloader update
        flashloader download <name>
    ]]
    print(st)
end

local function update()
    list = filesystem.list("/data/flash")
    repeat
        local file = list()
        if not file == nil then
            download("/data/flash/"..file, "/apt/programs/flashloader/flashes/"..file)
        end
    until file == nil
    list = nil

end

if (#tArgs == 0) then
    printUsage()
    return nil
end

if (#tArgs == 1) then
    if tArgs[1] == "update" then
        update()
    else
        printUsage()
    end
end

if (#tArgs == 2) then
    if (tArgs[1] == "download") then
        download("/data/flash/"..tArgs[2], "/apt/programs/flashloader/flashes/"..tArgs[2])
        return nil
    end
    if (tArgs[1] == "flash") then
        if not filesystem.exists("flash -q /data/flash/"..tArgs[2]) then
            download("/data/flash/"..tArgs[2], "/apt/programs/flashloader/flashes/"..tArgs[2])
        end
        shell.execute("flash -q /data/flash/"..tArgs[2].." "..tArgs[2])
        return nil
    end
    printUsage()
end

if (#tArgs == 3) then
    if (tArgs[1] == "flash") then
        if not filesystem.exists("flash -q /data/flash/"..tArgs[2]) then
            download("/data/flash/"..tArgs[2], "/apt/programs/flashloader/flashes/")
        end
        shell.execute("flash -q /data/flash/"..tArgs[2].." "..tArgs[3])
        return nil
    end
    printUsage()
end
printUsage()
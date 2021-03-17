local tArgs = {...}
local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local shell = require("shell")
local filesystem = require("filesystem")
local term = require("term")
local cutils = require("cutils")

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

if not filesystem.exists("/temp/packman") then
    filesystem.makeDirectory("/temp/packman")
end

local function printUsage()
    local usageString = [[
packman usage:
    packman -fdwx <pack name> [export folder/drive name]
    -f -> export on folder
    -d -> export on Drive
    -w -> wipe export folder or drive
    -x -> extract

Note: there is no list function. You need to go to the github page in order to find
      the packs
]]
    print(usageString)
end


local drive = false
local wipe = false
local extract = false
local export = nil
local package = nil

local function setSettings()
    local stri = tArgs[1]
    for i=2,#stri do
        if string.sub(stri,i,i) == "d" then
            drive = true
        elseif string.sub(stri,i,i) == "w" then
            wipe = true
        elseif string.sub(stri,i,i) == "f" then
            drive = false
        elseif string.sub(stri,i,i) == "x" then
            extract = true
        end
    end
end

local function downloadPackageOld()
    if package == nil then
        printUsage()
        return nil
    end
    if not extract then
        if export == nil then
            export = shell.getWorkingDirectory()
        end
        if wipe then
            shell.execute("rm -r "..export.."*")
        end
        if extract then
            local tempdownload = "/temp/packman/"..package..".tar"
            download(tempdownload, "/packman/packs/"..package..".tar")
            shell.execute("tar -xf "..tempdownload.." export")
        end
        if drive then
            local drivec = cutils.findComponent(export)
            export = "/mnt/"..drivec.fsnode.name.."/"
            if wipe then
                shell.execute("rm -r "..export.."*")
            end
            if extract then
                local tempdownload = "/temp/packman/"..package..".tar"
                download(tempdownload, "/packman/packs/"..package..".tar")
                shell.execute("tar -xf "..tempdownload.." export")
            end
        end
    end
end

local function downloadPackage()
    if package == nil then
        printUsage()
        return nil
    end
    if drive then
        local drivec = cutils.findComponent(export)
        export = "/mnt/"..drivec.fsnode.name.."/"
    end
    local dpath = export.."/"
    if extract then
        dpath = "/temp/packman/"
    end
    if wipe then
        shell.execute("rm -r "..export.."*")
    end
    download(dpath..package..".tar", "/packman/packs/"..package..".tar")
    if extract then
        shell.execute("tar -xf "..dpath..package..".tar".." "..export)
    end
end

if #tArgs == 0 then
    printUsage()
    return nil
end

if #tArgs == 1 then
    package = tArgs[1]
    export = shell.getWorkingDirectory()
    downloadPackage()
end


if #tArgs == 2 then
    if string.sub(tArgs[1],1,1) == "-" then
        setSettings()
        package = tArgs[2]
        downloadPackage()
    else 
        printUsage()
        return nil
    end
end

if #tArgs == 3 then
    if string.sub(tArgs[1],1,1) == "-" then
        setSettings()
        package = tArgs[2]
        export = tArgs[3] or nil
        downloadPackage()
    else 
        printUsage()
        return nil
    end
end
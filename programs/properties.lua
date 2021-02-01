local tArgs = {...}
local filesystem = require("filesystem")
local shell = require("shell")

local function printUsage()
    local usage = [[
    Usage: properties <filename>
    ]]
    print (usage)
end

if #tArgs ~= 1 then
    printUsage()
    return nil
end

local filename = shell.getWorkingDirectory().."/"..tArgs[1]
if not filesystem.exists(filename) then
    print("File doesn't exist!")
    return nil
end

local properties = [[
File Properties:
    Name: %s
    Location: %s
    Type: %s
    Last Modified: %s
    Size: %s bytes
]]
local type = "file"
if (filesystem.isDirectory(filename)) then
    type = "folder"
end
print(string.format(properties,filesystem.name(filename),
    filesystem.canonical(filename), type,
    os.date("%c",filesystem.lastModified(filename)/1002.7), filesystem.size(filename)
))
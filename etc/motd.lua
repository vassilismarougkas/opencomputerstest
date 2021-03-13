local filesystem = require("filesystem")
filesystem.remove("/temp")
filesystem.makeDirectory("/temp")
local shell = require("shell")
shell.setWorkingDirectory("/")

if (filesystem.exists("/autorun.lua")) then
    require("/autorun")
end
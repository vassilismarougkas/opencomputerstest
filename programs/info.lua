local shell = require("shell")
local currentDirectory = shell.getWorkingDirectory()
shell.setWorkingDirectory("/")

local version = require("/data/version")
local drive = require("component").filesystem

print("System Info")
print("Version: "..version.getVersion())
print("Storage: "..drive.spaceUsed.."/"..drive.spaceTotal.."  ("..(math.floor(1000*drive.spaceUsed/drive.spaceTotal)/10).."%)")

shell.setWorkingDirectory(currentDirectory)

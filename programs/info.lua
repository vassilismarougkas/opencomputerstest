local shell = require("shell")
local computer = require("computer")
local currentDirectory = shell.getWorkingDirectory()
shell.setWorkingDirectory("/")

local version = require("/data/version")
local drive = require("component").proxy(computer.getBootAddress())

print("System Info")
print("Version: "..version.getVersion())
print("Storage: "..drive.spaceUsed().."/"..drive.spaceTotal().."  ("..(math.floor(1000*drive.spaceUsed()/drive.spaceTotal())/10).."%)")

local usedMemory = computer.totalMemory() - computer.freeMemory()
print("Memory: "..usedMemory.."/"..computer.totalMemory().."  ("..(math.floor(1000*usedMemory/computer.totalMemory())/10).."%)")

shell.setWorkingDirectory(currentDirectory)

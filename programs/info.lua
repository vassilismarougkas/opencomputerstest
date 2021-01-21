local shell = require("shell")
local currentDirectory = shell.getWorkingDirectory()
shell.setWorkingDirectory("/")

local version = require("/data/version")

print("System Info")
print("Version: "..version.getVersion())


shell.setWorkingDirectory(currentDirectory)

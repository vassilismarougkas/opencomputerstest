local term = require("term")
local shell = require("shell")
local computer = require("computer")
local filesystem = require("filesystem")

local mainpath = "https://raw.githubusercontent.com/vassilismarougkas/opencomputerstest/master"

local function termClear()
    term.clear()
    term.setCursor(1,1)
end

local function download(dpath, gpath)
    shell.execute("wget -q -f "..mainpath..gpath.." "..dpath)
end

shell.setWorkingDirectory("/")
termClear()
local isValid = true
if not filesystem.exists("/data") then
    isValid = false
    filesystem.makeDirectory("/data")
else 
    if not filesystem.exists("/data/version.lua") then
        isValid = false
    end
end
local version = 0
local currentversion = nil
if (isValid) then
    currentversion = require("/data/version")
    version = currentversion.getVersion()
end

if not filesystem.exists("/temp") then
    filesystem.makeDirectory("/temp")
end
download("/temp/version.lua", "/version.lua")
local newversion = require("/temp/version")

if newversion.getVersion() <= version then
    print("You already have the latest version. No need to update.")
    print("Rebooting...")
    os.sleep(1)
    computer.shutdown(true)
end

if version > 0 then
    print("Removing old Files")
    for path, link in pairs (currentversion.getFiles()) do
        filesystem.remove(path)
    end
end

print("Downloading new Files")
for path, link in pairs(newversion.getFiles()) do
    download(path, link)
end

print("Rebooting...")
os.sleep(1)
computer.shutdown(true)
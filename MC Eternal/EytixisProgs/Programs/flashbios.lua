local shell = require("shell")
local term = require("term")
local component = require("component")

local filesystem = require("filesystem")
if not filesystem.exists("//eytixis/files") then
    shell.execute("mkdir //eytixis/files")
end

if not (filesystem.exists("//eytixis/files/bios.lua")) then
    print("Downloading Bios file from Pastebin!")
    shell.execute("pastebin get rf4bGMtU //eytixis/files/bios.lua")
end

shell.execute("flash -q //eytixis/files/bios.lua 'Bios'")
print("Bios Flashed!")
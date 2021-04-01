local shell = require("shell")
local computer = require("computer")
local currentDirectory = shell.getWorkingDirectory()
shell.setWorkingDirectory("/")

local version = require("/data/version")
local drive = require("component").proxy(computer.getBootAddress())

print("System Info")
print("Version: "..version.getVersion())

local drive_used = drive.spaceUsed()
local drive_total = drive.spaceTotal()
local drive_used_percentage = 100*drive_used/drive_total
print(string.format( "Storage: %d/%d (%.2f%%)", drive_used, drive_total, drive_used_percentage))

local ram_free = computer.freeMemory()
local ram_total = computer.totalMemory()
local ram_used = ram_total - ram_free
local ram_used_percentage = 100*ram_used/ram_total
print(string.format( "Memory: %d/%d (%.2f%%)", ram_used, ram_total, ram_used_percentage))

local stored_energy = computer.energy()
local full_energy = computer.maxEnergy()
local energy_percentage = 100*stored_energy/full_energy
print(string.format( "Energy: %d/%d (%.2f%%)", stored_energy, full_energy, energy_percentage))

shell.setWorkingDirectory(currentDirectory)
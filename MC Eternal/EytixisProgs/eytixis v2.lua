local shell = require("shell")
local term = require("term")
local component = require("component")
local filesystem = require("filesystem")

shell.execute("pastebin run S5msqP8t")

term.clear()
term.setCursor(1,1)

for folder in pairs (FileListTable) do
    if not filesystem.exists("//"..folder) then
        shell.execute("mkdir //"..folder)
    end
    for filename, code in pairs(FileListTable[folder]) do
        print("Installing "..filename.." in folder /"..folder)
        shell.execute("rm //"..folder.."/"..filename)
        shell.execute("pastebin get "..code.." //"..folder.."/"..filename)
    end
end

if (filesystem.exists("//lib/robot.lua")) then
    for folder in pairs (FileListTableRobot) do
        if not filesystem.exists("//"..folder) then
            shell.execute("mkdir //"..folder)
        end
        for filename, code in pairs(FileListTableRobot[folder]) do
            print("Installing "..filename.." in folder /"..folder)
            shell.execute("rm //"..folder.."/"..filename)
            shell.execute("pastebin get "..code.." //"..folder.."/"..filename)
        end
    end
end

print("Installation Complete!")
print("A system reboot is recommended")
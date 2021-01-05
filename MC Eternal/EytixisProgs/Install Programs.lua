local shell = require("shell")
local term = require("term")
local component = require("component")
local filesystem = require("filesystem")

local args = {...}

if (component.internet == nil) then
    print("No Internet Card Found!")
    print("Please install one and try again!")
else
    if (#args == 0) then
        term.clear()
        term.setCursor(1,1)
        print("Downloading Eytixis Install Program from Pastebin!")
        shell.execute("pastebin get tAaPygpU //bin/eytixis.lua")
        print("Downloading Transfer Program from Pastebin!")
        shell.execute("pastebin get wzpHEiyT //bin/transfer.lua")
        print("Downloading flashbios program from Pastebin!")
        shell.execute("pastebin get 63877xDV //bin/flashbios.lua")
        print("Downloading Remote File Transfer Protocol Library from Pastebin!")
        shell.execute("pastebin get AaSLzhwh //lib/rftp.lua")
        print("Downloading Formatter Library from Pastebin!")
        shell.execute("pastebin get PHeLPhwf //lib/formatter.lua")
        print("Downloading Transceiver Library from Pastebin!")
        shell.execute("pastebin get BNAAS1fe //lib/transceiver.lua")
        print("Downloading Signals from Pastebin!")
        shell.execute("pastebin get 0YhXPFFp //lib/signals.lua")
        print("Downloading Bios file from Pastebin!")
        if not filesystem.exists("//eytixis/files") then
            shell.execute("mkdir //eytixis/files")
        end
        shell.execute("pastebin get rf4bGMtU //eytixis/files/bios.lua")
        print("Installation Complete!")
        print("A system reboot is recommended!")
    elseif (#args == 1) then
        if (args[1] == "update") then
            print("Downloading Eytixis Install Program from Pastebin!")
            shell.execute("rm //bin/eytixis.lua")
            shell.execute("pastebin get tAaPygpU //bin/eytixis.lua")
            shell.execute("eytixis deleteall")
            shell.execute("eytixis")
        end
        if (args[1] == "deleteall") then
            shell.execute("rm //bin/transfer.lua")
            shell.execute("rm //bin/flashbios.lua")
            shell.execute("rm //lib/rftp.lua")
            shell.execute("rm //lib/formatter.lua")
            shell.execute("rm //lib/transceiver.lua")
            shell.execute("rm //lib/signals.lua")
            shell.execute("rm //eytixis/files/bios.lua")
        end
    end
end